const CACHE_VERSION = 'wms-cache-v2';
const STATIC_CACHE = `${CACHE_VERSION}-static`;
const PAGE_CACHE = `${CACHE_VERSION}-pages`;
const NETWORK_TIMEOUT_MS = 3000;
const SCOPE_PATH = new URL(self.registration.scope).pathname;

const STATIC_FILE_EXTENSIONS = [
  '.css', '.js', '.mjs', '.png', '.jpg', '.jpeg', '.gif', '.svg', '.webp',
  '.woff', '.woff2', '.ttf', '.eot', '.ico', '.map', '.json', '.wasm'
];

self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

self.addEventListener('install', (event) => {
  event.waitUntil(self.skipWaiting());
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => !key.startsWith(CACHE_VERSION))
          .map((key) => caches.delete(key))
      )
    ).then(() => self.clients.claim())
  );
});

function isStaticAsset(requestUrl) {
  const path = requestUrl.pathname.toLowerCase();
  return STATIC_FILE_EXTENSIONS.some((ext) => path.endsWith(ext));
}

function canCache(response) {
  return response && (response.ok || response.type === 'opaque');
}

async function putInCache(cacheName, request, response) {
  if (!canCache(response)) return;

  const cache = await caches.open(cacheName);
  await cache.put(request, response.clone());
}

async function fetchAndCache(cacheName, request) {
  const response = await fetch(request);
  await putInCache(cacheName, request, response);
  return response;
}

function timeout(ms) {
  return new Promise((resolve) => {
    setTimeout(() => resolve(null), ms);
  });
}

async function cachedPageFallback(request) {
  return caches.match(request)
    .then((cached) => cached || caches.match(new URL(request.url).pathname))
    .then((cached) => cached || caches.match(SCOPE_PATH));
}

async function networkFirstWithTimeout(request) {
  const networkPromise = fetchAndCache(PAGE_CACHE, request).catch(() => null);
  const response = await Promise.race([networkPromise, timeout(NETWORK_TIMEOUT_MS)]);

  if (response) return response;

  const cached = await cachedPageFallback(request);
  if (cached) return cached;

  const networkResponse = await networkPromise;
  return networkResponse || new Response(
    '<!doctype html><title>Offline</title><h1>Offline</h1><p>This page is not cached yet.</p>',
    {
      status: 503,
      headers: { 'Content-Type': 'text/html; charset=utf-8' }
    }
  );
}

async function cacheFirstAndRefresh(event) {
  const { request } = event;
  const cached = await caches.match(request);
  const refresh = fetchAndCache(STATIC_CACHE, request).catch(() => null);

  if (cached) {
    event.waitUntil(refresh);
    return cached;
  }

  return refresh || fetch(request);
}

self.addEventListener('sync', (event) => {
  if (event.tag === 'heartbeat-sync') {
    event.waitUntil(sendHeartbeat());
  }
});

async function sendHeartbeat() {
  const clients = await self.clients.matchAll();
  for (const client of clients) {
    client.postMessage({
      type: 'HEARTBEAT_SYNC',
      timestamp: Date.now()
    });
  }
}

self.addEventListener('fetch', (event) => {
  const { request } = event;
  const requestUrl = new URL(request.url);

  if (request.method !== 'GET') return;

  if (request.mode === 'navigate') {
    event.respondWith(networkFirstWithTimeout(request));
    return;
  }

  if (isStaticAsset(requestUrl)) {
    event.respondWith(cacheFirstAndRefresh(event));
  }
});
