// Service Worker to handle background sync and offline capabilities
self.addEventListener('install', (event) => {
    event.waitUntil(self.skipWaiting());
});

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