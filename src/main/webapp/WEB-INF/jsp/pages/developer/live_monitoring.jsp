<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    html[data-live-monitoring-page="true"] #loader { display: none !important; }
    .elis-live-page { min-height: calc(100vh - 90px); padding: 24px; color: #15231f; background: #f5f8f7; }
    .elis-live-shell { max-width: 1480px; margin: 0 auto; }
    .elis-live-head { display: flex; align-items: flex-start; justify-content: space-between; gap: 20px; margin-bottom: 18px; }
    .elis-live-kicker { display: inline-flex; align-items: center; gap: 7px; color: #087c67; font-size: .68rem; font-weight: 800; text-transform: uppercase; letter-spacing: .08em; }
    .elis-live-kicker i { width: 7px; height: 7px; border-radius: 50%; background: currentColor; box-shadow: 0 0 0 5px rgba(8, 124, 103, .09); }
    .elis-live-head h1 { margin: 7px 0 5px; font-size: clamp(1.45rem, 2.4vw, 2.15rem); font-weight: 800; color: #13231f; letter-spacing: 0; }
    .elis-live-head p { max-width: 720px; margin: 0; color: #667973; font-size: .78rem; line-height: 1.55; }
    .elis-live-controls { display: flex; align-items: center; gap: 9px; flex-wrap: wrap; justify-content: flex-end; }
    .elis-live-state, .elis-live-controls button { min-height: 38px; display: inline-flex; align-items: center; gap: 8px; padding: 0 12px; border: 1px solid #dce7e3; border-radius: 10px; background: #fff; color: #647771; font-size: .68rem; font-weight: 800; white-space: nowrap; }
    .elis-live-state i { width: 8px; height: 8px; border-radius: 50%; background: currentColor; }
    .elis-live-state.is-loading i { animation: elisLivePulse 1s ease-in-out infinite; }
    .elis-live-state.is-healthy { border-color: rgba(13,139,95,.18); color: #0d8b5f; background: rgba(13,139,95,.07); }
    .elis-live-state.is-warning { border-color: rgba(193,128,23,.22); color: #b47312; background: rgba(193,128,23,.08); }
    .elis-live-state.is-critical, .elis-live-state.is-disconnected { border-color: rgba(196,81,69,.22); color: #bd4a3f; background: rgba(196,81,69,.08); }
    .elis-live-state.is-paused { color: #647771; }
    .elis-live-controls button { color: #15231f; cursor: pointer; }
    .elis-live-alert[hidden] { display: none; }
    .elis-live-alert { display: grid; grid-template-columns: 38px minmax(0, 1fr); gap: 12px; align-items: center; margin-bottom: 14px; padding: 13px 15px; border: 1px solid rgba(193,128,23,.22); border-radius: 12px; background: rgba(193,128,23,.07); }
    .elis-live-alert.is-critical { border-color: rgba(196,81,69,.22); background: rgba(196,81,69,.07); }
    .elis-live-alert span { width: 38px; height: 38px; display: grid; place-items: center; border-radius: 10px; color: #b47312; background: rgba(193,128,23,.13); font-weight: 900; }
    .elis-live-alert.is-critical span { color: #bd4a3f; background: rgba(196,81,69,.13); }
    .elis-live-alert strong, .elis-live-alert p { display: block; margin: 0; }
    .elis-live-alert strong { font-size: .78rem; }
    .elis-live-alert p { margin-top: 3px; color: #667973; font-size: .68rem; }
    .elis-live-metrics { display: grid; grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 11px; margin-bottom: 12px; }
    .elis-live-card { min-width: 0; padding: 16px; border: 1px solid #dce7e3; border-radius: 12px; background: #fff; box-shadow: 0 10px 28px rgba(20, 48, 40, .04); }
    .elis-live-card[data-live-drilldown] { cursor: pointer; transition: border-color .2s ease, box-shadow .2s ease, transform .2s ease; }
    .elis-live-card[data-live-drilldown]:hover, .elis-live-card[data-live-drilldown]:focus { border-color: rgba(8,124,103,.30); box-shadow: 0 14px 32px rgba(8,124,103,.10); transform: translateY(-1px); outline: 0; }
    .elis-live-card[data-live-drilldown="errors"]:hover, .elis-live-card[data-live-drilldown="errors"]:focus { border-color: rgba(189,74,63,.35); box-shadow: 0 14px 32px rgba(189,74,63,.10); }
    .elis-live-card header { display: flex; justify-content: space-between; gap: 8px; align-items: center; color: #667973; font-size: .65rem; font-weight: 800; }
    .elis-live-card header i { width: 8px; height: 8px; border-radius: 50%; background: #9aa9a4; }
    .elis-live-card.is-healthy header i { background: #0d8b5f; }
    .elis-live-card.is-warning header i { background: #b47312; }
    .elis-live-card.is-critical header i { background: #bd4a3f; }
    .elis-live-card strong { display: block; margin-top: 12px; color: #13231f; font-size: 1.45rem; line-height: 1.05; font-weight: 850; }
    .elis-live-card strong small { margin-left: 2px; color: #7a8a85; font-size: .63rem; font-weight: 800; }
    .elis-live-card p { margin: 9px 0 0; color: #667973; font-size: .63rem; line-height: 1.45; }
    .elis-live-card b { color: #13231f; }
    .elis-live-card-action { display: inline-flex; align-items: center; gap: 5px; margin-top: 10px; color: #087c67; font-size: .58rem; font-weight: 850; }
    .elis-live-card[data-live-drilldown="errors"] .elis-live-card-action { color: #bd4a3f; }
    .elis-live-meter { height: 5px; overflow: hidden; margin-top: 12px; border-radius: 999px; background: #e4ece9; }
    .elis-live-meter i { width: 0; height: 100%; display: block; border-radius: inherit; background: #0d8b5f; transition: width .35s ease; }
    .elis-live-card.is-warning .elis-live-meter i { background: #b47312; }
    .elis-live-card.is-critical .elis-live-meter i { background: #bd4a3f; }
    .elis-live-spark { height: 28px; display: flex; align-items: flex-end; gap: 2px; margin-top: 9px; }
    .elis-live-spark i { flex: 1; min-width: 2px; border-radius: 2px 2px 0 0; background: rgba(8, 124, 103, .45); transition: height .25s ease; }
    .elis-live-grid { display: grid; grid-template-columns: 1.22fr .78fr; gap: 12px; }
    .elis-live-panel { overflow: hidden; border: 1px solid #dce7e3; border-radius: 12px; background: #fff; box-shadow: 0 10px 28px rgba(20, 48, 40, .04); }
    .elis-live-panel > header { display: flex; justify-content: space-between; gap: 14px; align-items: flex-start; padding: 15px 17px; border-bottom: 1px solid #e3ece8; }
    .elis-live-panel h2 { margin: 3px 0 0; color: #13231f; font-size: .92rem; font-weight: 850; }
    .elis-live-panel header > span { color: #7a8a85; font-size: .62rem; white-space: nowrap; }
    .elis-live-signals { display: grid; grid-template-columns: repeat(6, minmax(0, 1fr)); gap: 8px; padding: 12px; border-bottom: 1px solid #e3ece8; }
    .elis-live-signals article { padding: 12px; border: 1px solid #e3ece8; border-radius: 10px; }
    .elis-live-signals span, .elis-live-signals strong, .elis-live-signals small { display: block; }
    .elis-live-signals span { color: #667973; font-size: .57rem; font-weight: 800; }
    .elis-live-signals strong { margin-top: 5px; color: #13231f; font-size: .86rem; }
    .elis-live-signals strong [data-live-value] { display: inline; }
    .elis-live-signals small { margin-top: 3px; color: #7a8a85; font-size: .53rem; line-height: 1.35; }
    .elis-live-list article { display: grid; grid-template-columns: 8px minmax(0, 1fr) auto auto; gap: 12px; align-items: center; padding: 12px 16px; border-bottom: 1px solid #e3ece8; }
    .elis-live-list article:last-child { border-bottom: 0; }
    .elis-live-list article > i { width: 8px; height: 8px; border-radius: 50%; background: #0d8b5f; }
    .elis-live-list article.is-warning > i { background: #b47312; }
    .elis-live-list article.is-critical > i { background: #bd4a3f; }
    .elis-live-list strong, .elis-live-list small { display: block; min-width: 0; }
    .elis-live-list strong { overflow: hidden; color: #13231f; font-size: .69rem; white-space: nowrap; text-overflow: ellipsis; }
    .elis-live-list small { overflow: hidden; margin-top: 2px; color: #667973; font-size: .58rem; white-space: nowrap; text-overflow: ellipsis; }
    .elis-live-list span { color: #667973; font-size: .58rem; white-space: nowrap; }
    .elis-live-list b { min-width: 68px; color: #13231f; font-size: .62rem; text-align: right; }
    .elis-live-empty { display: grid; justify-items: center; gap: 5px; padding: 28px; text-align: center; }
    .elis-live-empty span { width: 34px; height: 34px; display: grid; place-items: center; border-radius: 10px; color: #0d8b5f; background: rgba(13,139,95,.09); font-weight: 900; }
    .elis-live-empty strong { color: #13231f; font-size: .72rem; }
    .elis-live-empty small { color: #667973; font-size: .62rem; }
    .elis-live-endpoints article, .elis-live-activity article { display: grid; grid-template-columns: minmax(0, 1fr) auto; gap: 8px; padding: 12px 16px; border-bottom: 1px solid #e3ece8; }
    .elis-live-endpoints article:last-child, .elis-live-activity article:last-child { border-bottom: 0; }
    .elis-live-endpoints strong, .elis-live-activity strong { display: block; overflow: hidden; color: #13231f; font-size: .68rem; white-space: nowrap; text-overflow: ellipsis; }
    .elis-live-endpoints small, .elis-live-activity small { display: block; margin-top: 3px; color: #667973; font-size: .57rem; }
    .elis-live-endpoints b { color: #087c67; font-size: .7rem; white-space: nowrap; }
    .elis-live-drawer-backdrop[hidden] { display: none; }
    .elis-live-drawer-backdrop { position: fixed; inset: 0; z-index: 9998; background: rgba(10, 25, 22, .34); backdrop-filter: blur(2px); }
    .elis-live-drawer { position: fixed; top: 0; right: 0; z-index: 9999; width: min(560px, calc(100vw - 22px)); height: 100vh; display: flex; flex-direction: column; background: #f8fbfa; border-left: 1px solid #dce7e3; box-shadow: -28px 0 60px rgba(10,25,22,.22); transform: translateX(104%); transition: transform .26s ease; }
    .elis-live-drawer.is-open { transform: translateX(0); }
    .elis-live-drawer-head { display: flex; justify-content: space-between; gap: 18px; align-items: flex-start; padding: 20px; background: #fff; border-bottom: 1px solid #e3ece8; }
    .elis-live-drawer-head h2 { margin: 5px 0 4px; color: #13231f; font-size: 1.15rem; font-weight: 900; }
    .elis-live-drawer-head p { margin: 0; color: #667973; font-size: .68rem; line-height: 1.45; }
    .elis-live-drawer-close { width: 36px; height: 36px; display: grid; place-items: center; border: 1px solid #dce7e3; border-radius: 10px; background: #fff; color: #13231f; cursor: pointer; }
    .elis-live-drawer-body { overflow: auto; padding: 14px; }
    .elis-live-drawer-summary { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 9px; margin-bottom: 12px; }
    .elis-live-drawer-summary article { min-width: 0; padding: 12px; border: 1px solid #dce7e3; border-radius: 11px; background: #fff; }
    .elis-live-drawer-summary span, .elis-live-drawer-summary strong, .elis-live-drawer-summary small { display: block; }
    .elis-live-drawer-summary span { color: #667973; font-size: .56rem; font-weight: 850; text-transform: uppercase; letter-spacing: .04em; }
    .elis-live-drawer-summary strong { margin-top: 5px; color: #13231f; font-size: 1.05rem; font-weight: 900; }
    .elis-live-drawer-summary small { margin-top: 3px; color: #7a8a85; font-size: .56rem; }
    .elis-live-drawer-chart { height: 128px; display: flex; align-items: end; gap: 4px; padding: 12px; margin-bottom: 12px; border: 1px solid #dce7e3; border-radius: 12px; background: linear-gradient(180deg, #fff, #f3f8f6); }
    .elis-live-drawer-chart i { flex: 1; min-width: 5px; border-radius: 5px 5px 0 0; background: linear-gradient(180deg, #10a783, #087c67); box-shadow: inset 0 -1px 0 rgba(255,255,255,.35); }
    .elis-live-drawer-chart i.is-warning { background: linear-gradient(180deg, #d7982f, #b47312); }
    .elis-live-drawer-chart i.is-critical { background: linear-gradient(180deg, #d86b60, #bd4a3f); }
    .elis-live-drawer-list { overflow: hidden; border: 1px solid #dce7e3; border-radius: 12px; background: #fff; }
    .elis-live-drawer-list article { display: grid; grid-template-columns: 10px minmax(0, 1fr) auto; gap: 10px; align-items: center; padding: 12px 14px; border-bottom: 1px solid #e9f0ed; }
    .elis-live-drawer-list article:last-child { border-bottom: 0; }
    .elis-live-drawer-list article > i { width: 9px; height: 9px; border-radius: 999px; background: #087c67; box-shadow: 0 0 0 4px rgba(8,124,103,.08); }
    .elis-live-drawer-list article.is-critical > i { background: #bd4a3f; box-shadow: 0 0 0 4px rgba(189,74,63,.08); }
    .elis-live-drawer-list article.is-warning > i { background: #b47312; box-shadow: 0 0 0 4px rgba(180,115,18,.08); }
    .elis-live-drawer-list strong, .elis-live-drawer-list small { display: block; min-width: 0; }
    .elis-live-drawer-list strong { overflow: hidden; color: #13231f; font-size: .68rem; white-space: nowrap; text-overflow: ellipsis; }
    .elis-live-drawer-list small { overflow: hidden; margin-top: 3px; color: #667973; font-size: .57rem; white-space: nowrap; text-overflow: ellipsis; }
    .elis-live-drawer-list b { color: #087c67; font-size: .6rem; white-space: nowrap; }
    .elis-live-foot { display: flex; justify-content: space-between; gap: 15px; margin-top: 12px; color: #7a8a85; font-size: .58rem; }
    @keyframes elisLivePulse { 50% { opacity: .35; transform: scale(.75); } }
    @media (max-width: 1200px) { .elis-live-metrics { grid-template-columns: repeat(3, minmax(0, 1fr)); } .elis-live-grid { grid-template-columns: 1fr; } .elis-live-signals { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
    @media (max-width: 760px) { .elis-live-page { padding: 16px; } .elis-live-head { flex-direction: column; } .elis-live-controls { justify-content: flex-start; } .elis-live-metrics { grid-template-columns: repeat(2, minmax(0, 1fr)); } .elis-live-list article { grid-template-columns: 8px minmax(0, 1fr) auto; } .elis-live-list article > span { grid-column: 2; } .elis-live-foot { flex-direction: column; } }
    @media (max-width: 460px) { .elis-live-metrics, .elis-live-signals, .elis-live-drawer-summary { grid-template-columns: 1fr; } }
</style>

<main class="app-content elis-live-page" data-live-monitor data-monitor-url="${pageContext.request.contextPath}/LiveMonitoring">
    <div class="elis-live-shell">
        <header class="elis-live-head">
            <div>
                <span class="elis-live-kicker"><i></i>10-second telemetry</span>
                <h1>Live System Monitoring</h1>
                <p>Advanced read-only monitoring for ELIS database pressure, API response time, current database activity, and backend health signals.</p>
            </div>
            <div class="elis-live-controls">
                <span class="elis-live-state is-loading" data-live-state><i></i><b>Connecting</b></span>
                <button type="button" data-live-toggle aria-label="Pause live monitoring">
                    <i class="ri-pause-fill"></i><span>Pause</span>
                </button>
            </div>
        </header>

        <section class="elis-live-alert" data-live-alert hidden>
            <span>!</span>
            <div>
                <strong data-live-alert-title>Monitoring needs attention</strong>
                <p data-live-alert-copy>Waiting for a current sample.</p>
            </div>
        </section>

        <section class="elis-live-metrics">
            <article class="elis-live-card" data-live-card="connections" data-live-drilldown="connections" role="button" tabindex="0" aria-label="View connection pressure details">
                <header><span>Connection pressure</span><i></i></header>
                <strong><span data-live-value="connection_usage_pct">--</span><small>%</small></strong>
                <div class="elis-live-meter"><i data-live-meter="connection_usage_pct"></i></div>
                <p><b data-live-value="active_connections">--</b> active of <b data-live-value="max_connections">--</b> allowed</p>
                <span class="elis-live-card-action">View details <i class="ri-arrow-right-line"></i></span>
            </article>
            <article class="elis-live-card" data-live-card="cache" data-live-drilldown="cache" role="button" tabindex="0" aria-label="View database cache details">
                <header><span>Database cache</span><i></i></header>
                <strong><span data-live-value="cache_hit_pct">--</span><small>%</small></strong>
                <div class="elis-live-meter"><i data-live-meter="cache_hit_pct"></i></div>
                <p><b data-live-value="database_size">--</b> current database size</p>
                <span class="elis-live-card-action">View details <i class="ri-arrow-right-line"></i></span>
            </article>
            <article class="elis-live-card" data-live-card="api" data-live-drilldown="api" role="button" tabindex="0" aria-label="View API response time details">
                <header><span>API response time</span><i></i></header>
                <strong data-live-value="api_response_time_display">--</strong>
                <div class="elis-live-spark" data-live-spark aria-label="Recent API response time trend"></div>
                <p>P95 <b data-live-value="p95_response_display">--</b> / latest <b data-live-value="latest_response_display">--</b></p>
                <span class="elis-live-card-action">View response details <i class="ri-arrow-right-line"></i></span>
            </article>
            <article class="elis-live-card" data-live-card="errors" data-live-drilldown="errors" role="button" tabindex="0" aria-label="View failed API requests">
                <header><span>API failures</span><i></i></header>
                <strong><span data-live-value="failed_15m">--</span><small>failed</small></strong>
                <div class="elis-live-meter"><i data-live-meter="failure_rate_pct"></i></div>
                <p><b data-live-value="failure_rate_pct">--</b>% failure rate / 15 min</p>
                <span class="elis-live-card-action">View failed requests <i class="ri-arrow-right-line"></i></span>
            </article>
            <article class="elis-live-card" data-live-card="locks" data-live-drilldown="locks" role="button" tabindex="0" aria-label="View lock pressure details">
                <header><span>Lock pressure</span><i></i></header>
                <strong data-live-value="blocked_connections">--</strong>
                <div class="elis-live-meter"><i data-live-meter="lock_pressure_pct"></i></div>
                <p><b data-live-value="slow_queries">--</b> slow queries over 2 seconds</p>
                <span class="elis-live-card-action">View details <i class="ri-arrow-right-line"></i></span>
            </article>
        </section>

        <section class="elis-live-grid">
            <div class="elis-live-panel">
                <header>
                    <div><span class="elis-live-kicker"><i></i>Database workload</span><h2>Sessions Requiring Attention</h2></div>
                    <span data-live-sampled>Not sampled yet</span>
                </header>
                <div class="elis-live-signals">
                    <article><span>Total sessions</span><strong data-live-value="total_connections">--</strong><small>Client backends</small></article>
                    <article><span>Active</span><strong data-live-value="active_connections">--</strong><small>Running work now</small></article>
                    <article><span>Idle</span><strong data-live-value="idle_connections">--</strong><small>Available clients</small></article>
                    <article><span>Idle in tx</span><strong data-live-value="idle_in_transaction">--</strong><small>Lock risk</small></article>
                    <article><span>Rollback rate</span><strong><span data-live-value="rollback_pct">--</span>%</strong><small>Failed transactions</small></article>
                    <article><span>Deadlocks</span><strong data-live-value="deadlocks">--</strong><small>Since stats reset</small></article>
                </div>
                <div class="elis-live-list" data-live-sessions>
                    <div class="elis-live-empty"><span>OK</span><strong>No blocked or long-running sessions</strong><small>The database workload is currently clear.</small></div>
                </div>
            </div>

            <div class="elis-live-panel">
                <header>
                    <div><span class="elis-live-kicker"><i></i>API workload</span><h2>Top Endpoints</h2></div>
                    <span data-live-source>Waiting</span>
                </header>
                <div class="elis-live-endpoints" data-live-endpoints>
                    <div class="elis-live-empty"><span>i</span><strong>No API activity sampled yet</strong><small>The service will report endpoints after the first sample.</small></div>
                </div>
            </div>
        </section>

        <section class="elis-live-grid" style="margin-top:12px;">
            <div class="elis-live-panel">
                <header>
                    <div><span class="elis-live-kicker"><i></i>Recent activity</span><h2>Latest API Events</h2></div>
                </header>
                <div class="elis-live-activity" data-live-activity>
                    <div class="elis-live-empty"><span>i</span><strong>No recent events loaded</strong><small>Activity appears here when API logs are available.</small></div>
                </div>
            </div>
            <div class="elis-live-panel">
                <header>
                    <div><span class="elis-live-kicker"><i></i>Runtime</span><h2>Service Health</h2></div>
                </header>
                <div class="elis-live-signals" style="grid-template-columns:repeat(2,minmax(0,1fr));">
                    <article><span>PostgreSQL uptime</span><strong data-live-value="database_uptime">--</strong><small>Current cluster session</small></article>
                    <article><span>Temp bytes</span><strong data-live-value="temp_bytes_pretty">--</strong><small>Sort/hash spill pressure</small></article>
                    <article><span>Log source</span><strong data-live-value="api_log_source">--</strong><small>Detected API log table</small></article>
                    <article><span>Stats reset</span><strong data-live-value="stats_reset_display">--</strong><small>Database counters</small></article>
                </div>
            </div>
        </section>

        <footer class="elis-live-foot">
            <span>Monitoring pauses while this browser tab is hidden.</span>
            <span>Read-only dashboard. SQL text, API keys and request payloads are not rendered.</span>
        </footer>
    </div>
</main>

<div class="elis-live-drawer-backdrop" data-live-drawer-backdrop hidden></div>
<aside class="elis-live-drawer" data-live-drawer aria-hidden="true" aria-label="Monitoring details">
    <header class="elis-live-drawer-head">
        <div>
            <span class="elis-live-kicker"><i></i><span data-live-drawer-kicker>Telemetry details</span></span>
            <h2 data-live-drawer-title>Monitoring Details</h2>
            <p data-live-drawer-subtitle>Click a stat card to inspect current signals and recent refresh history.</p>
        </div>
        <button type="button" class="elis-live-drawer-close" data-live-drawer-close aria-label="Close monitoring details">
            <i class="ri-close-line"></i>
        </button>
    </header>
    <div class="elis-live-drawer-body">
        <div class="elis-live-drawer-summary" data-live-drawer-summary></div>
        <div class="elis-live-drawer-chart" data-live-drawer-chart aria-label="Recent refresh chart"></div>
        <div class="elis-live-drawer-list" data-live-drawer-list></div>
    </div>
</aside>

<script>
    (function() {
        var root = document.querySelector("[data-live-monitor]");
        if (!root) return;

        var loaderSuppressionRunning = false;
        function suppressGlobalLoader() {
            if (loaderSuppressionRunning) return;
            loaderSuppressionRunning = true;
            document.documentElement.setAttribute("data-live-monitoring-page", "true");
            if (document.documentElement.getAttribute("loader") !== "disable") {
                document.documentElement.setAttribute("loader", "disable");
            }
            var globalLoader = document.getElementById("loader");
            if (globalLoader) globalLoader.style.display = "none";
            loaderSuppressionRunning = false;
        }

        suppressGlobalLoader();
        document.addEventListener("DOMContentLoaded", suppressGlobalLoader);
        window.addEventListener("load", suppressGlobalLoader);
        if (window.MutationObserver) {
            new MutationObserver(suppressGlobalLoader).observe(document.documentElement, {
                attributes: true,
                attributeFilter: ["loader"]
            });
        }

        var state = root.querySelector("[data-live-state]");
        var stateLabel = state ? state.querySelector("b") : null;
        var toggle = root.querySelector("[data-live-toggle]");
        var toggleLabel = toggle ? toggle.querySelector("span") : null;
        var toggleIcon = toggle ? toggle.querySelector("i") : null;
        var alertBox = root.querySelector("[data-live-alert]");
        var alertTitle = root.querySelector("[data-live-alert-title]");
        var alertCopy = root.querySelector("[data-live-alert-copy]");
        var sessionList = root.querySelector("[data-live-sessions]");
        var endpointList = root.querySelector("[data-live-endpoints]");
        var activityList = root.querySelector("[data-live-activity]");
        var sampledLabel = root.querySelector("[data-live-sampled]");
        var sourceLabel = root.querySelector("[data-live-source]");
        var spark = root.querySelector("[data-live-spark]");
        var drawer = document.querySelector("[data-live-drawer]");
        var drawerBackdrop = document.querySelector("[data-live-drawer-backdrop]");
        var drawerClose = document.querySelector("[data-live-drawer-close]");
        var drawerKicker = document.querySelector("[data-live-drawer-kicker]");
        var drawerTitle = document.querySelector("[data-live-drawer-title]");
        var drawerSubtitle = document.querySelector("[data-live-drawer-subtitle]");
        var drawerSummary = document.querySelector("[data-live-drawer-summary]");
        var drawerChart = document.querySelector("[data-live-drawer-chart]");
        var drawerList = document.querySelector("[data-live-drawer-list]");
        var histories = { connections: [], cache: [], api: [], errors: [], locks: [] };
        var latestData = null;
        var activeDrawer = null;
        var currentFailedActivity = [];
        var paused = false;
        var loading = false;
        var timer = null;

        function number(value, fallback) {
            var parsed = Number(value);
            return Number.isFinite(parsed) ? parsed : (fallback || 0);
        }

        function hasNumber(value) {
            return value !== null && value !== undefined && value !== "" && Number.isFinite(Number(value));
        }

        function format(value, decimals) {
            return number(value).toLocaleString(undefined, {
                minimumFractionDigits: decimals || 0,
                maximumFractionDigits: decimals || 0
            });
        }

        function formatMs(value) {
            if (!hasNumber(value)) return "-- ms";
            var numeric = number(value);
            if (numeric >= 1000) return (numeric / 1000).toFixed(numeric >= 10000 ? 1 : 2) + " sec";
            return format(numeric, numeric < 100 ? 1 : 0) + " ms";
        }

        function formatDuration(milliseconds) {
            var value = number(milliseconds);
            if (value < 1000) return Math.round(value) + " ms";
            if (value < 60000) return (value / 1000).toFixed(1) + " sec";
            return Math.floor(value / 60000) + " min " + Math.round((value % 60000) / 1000) + " sec";
        }

        function addHistory(name, value) {
            histories[name].push(number(value));
            if (histories[name].length > 24) histories[name].shift();
        }

        function setState(status, label) {
            if (!state) return;
            state.className = "elis-live-state is-" + status;
            if (stateLabel) stateLabel.textContent = label;
        }

        function setCardStatus(name, status) {
            var card = root.querySelector('[data-live-card="' + name + '"]');
            if (!card) return;
            card.classList.remove("is-healthy", "is-warning", "is-critical");
            card.classList.add("is-" + status);
        }

        function setMeter(name, percentage) {
            var meter = root.querySelector('[data-live-meter="' + name + '"]');
            if (meter) meter.style.width = Math.max(0, Math.min(number(percentage), 100)) + "%";
        }

        function setValues(values) {
            Object.keys(values).forEach(function(key) {
                var value = values[key];
                root.querySelectorAll('[data-live-value="' + key + '"]').forEach(function(element) {
                    if (typeof value === "number") {
                        var decimals = ["connection_usage_pct", "cache_hit_pct", "rollback_pct", "failure_rate_pct", "avg_response_ms", "latest_response_ms", "p95_response_ms"].indexOf(key) >= 0 ? 1 : 0;
                        element.textContent = format(value, decimals);
                    } else {
                        element.textContent = value == null || value === "" ? "--" : value;
                    }
                });
            });
        }

        function renderSpark() {
            if (!spark) return;
            var responseHistory = histories.api.length ? histories.api : [0];
            var ceiling = Math.max.apply(null, responseHistory.concat([1]));
            spark.replaceChildren.apply(spark, responseHistory.map(function(item) {
                var bar = document.createElement("i");
                bar.style.height = Math.max(8, Math.round(item / ceiling * 100)) + "%";
                bar.title = formatMs(item);
                return bar;
            }));
        }

        function renderSessions(sessions) {
            if (!sessionList) return;
            sessionList.replaceChildren();
            if (!Array.isArray(sessions) || sessions.length === 0) {
                sessionList.innerHTML = '<div class="elis-live-empty"><span>OK</span><strong>No blocked or long-running sessions</strong><small>The database workload is currently clear.</small></div>';
                return;
            }
            sessions.forEach(function(item) {
                var row = document.createElement("article");
                var status = item.wait_type === "Lock" ? "critical" : item.state === "idle in transaction" ? "warning" : "active";
                row.className = "is-" + status;
                var pulse = document.createElement("i");
                var identity = document.createElement("div");
                var name = document.createElement("strong");
                name.textContent = item.application_name || "Database client";
                var detail = document.createElement("small");
                detail.textContent = (item.client_address || "local") + " - " + String(item.state || "unknown").replace(/_/g, " ");
                identity.append(name, detail);
                var wait = document.createElement("span");
                wait.textContent = item.wait_event || (item.wait_type ? item.wait_type + " wait" : "Running");
                var duration = document.createElement("b");
                duration.textContent = formatDuration(item.duration_ms);
                row.append(pulse, identity, wait, duration);
                sessionList.append(row);
            });
        }

        function renderEndpoints(endpoints) {
            if (!endpointList) return;
            endpointList.replaceChildren();
            if (!Array.isArray(endpoints) || endpoints.length === 0) {
                endpointList.innerHTML = '<div class="elis-live-empty"><span>i</span><strong>No API endpoint volume yet</strong><small>The API log source has no current rows for this window.</small></div>';
                return;
            }
            endpoints.forEach(function(item) {
                var row = document.createElement("article");
                var left = document.createElement("div");
                var title = document.createElement("strong");
                title.textContent = item.endpoint || "Unknown endpoint";
                var meta = document.createElement("small");
                meta.textContent = format(item.success_count || 0) + " success - " + format(item.failed_count || 0) + " failed - avg " + formatMs(item.avg_response_ms);
                var total = document.createElement("b");
                total.textContent = format(item.request_count || 0);
                left.append(title, meta);
                row.append(left, total);
                endpointList.append(row);
            });
        }

        function renderActivity(activity) {
            if (!activityList) return;
            activityList.replaceChildren();
            if (!Array.isArray(activity) || activity.length === 0) {
                activityList.innerHTML = '<div class="elis-live-empty"><span>i</span><strong>No recent events loaded</strong><small>Activity appears here when API logs are available.</small></div>';
                return;
            }
            activity.forEach(function(item) {
                var row = document.createElement("article");
                var left = document.createElement("div");
                var title = document.createElement("strong");
                title.textContent = item.endpoint || "Unknown endpoint";
                var meta = document.createElement("small");
                meta.textContent = (item.status || "Unknown") + " - " + (item.ip_address || "unknown IP") + " - " + formatMs(item.response_ms);
                var when = document.createElement("small");
                when.textContent = item.logged_at_display || "";
                left.append(title, meta);
                row.append(left, when);
                activityList.append(row);
            });
        }

        function renderFailures(failures) {
            currentFailedActivity = Array.isArray(failures) ? failures : [];
        }

        function metric(label, value, hint) {
            var article = document.createElement("article");
            var labelEl = document.createElement("span");
            var valueEl = document.createElement("strong");
            var hintEl = document.createElement("small");
            labelEl.textContent = label;
            valueEl.textContent = value == null || value === "" ? "--" : String(value);
            hintEl.textContent = hint || "";
            article.append(labelEl, valueEl, hintEl);
            return article;
        }

        function drawerRow(title, meta, value, status) {
            var article = document.createElement("article");
            if (status) article.className = "is-" + status;
            var pulse = document.createElement("i");
            var left = document.createElement("div");
            var titleEl = document.createElement("strong");
            var metaEl = document.createElement("small");
            var valueEl = document.createElement("b");
            titleEl.textContent = title || "Unknown";
            metaEl.textContent = meta || "";
            valueEl.textContent = value || "";
            left.append(titleEl, metaEl);
            article.append(pulse, left, valueEl);
            return article;
        }

        function renderDrawerChart(name, warningAt, criticalAt) {
            if (!drawerChart) return;
            var points = histories[name] && histories[name].length ? histories[name] : [0];
            var ceiling = Math.max.apply(null, points.concat([1]));
            drawerChart.replaceChildren.apply(drawerChart, points.map(function(value) {
                var bar = document.createElement("i");
                bar.style.height = Math.max(6, Math.round(number(value) / ceiling * 100)) + "%";
                if (criticalAt != null && number(value) >= criticalAt) bar.className = "is-critical";
                else if (warningAt != null && number(value) >= warningAt) bar.className = "is-warning";
                bar.title = name === "api" ? formatMs(value) : format(value, 1);
                return bar;
            }));
        }

        function emptyDrawerList(title, copy) {
            if (!drawerList) return;
            drawerList.innerHTML = '<div class="elis-live-empty"><span>i</span><strong>' + title + '</strong><small>' + copy + '</small></div>';
        }

        function openDrawer(name) {
            if (!drawer || !latestData) return;
            activeDrawer = name;
            var database = latestData.database || {};
            var api = latestData.api || {};
            var endpoints = Array.isArray(latestData.endpoints) ? latestData.endpoints : [];
            var sessions = Array.isArray(latestData.sessions) ? latestData.sessions : [];
            var kicker = "Telemetry details";
            var title = "Monitoring details";
            var subtitle = "Updated every 10 seconds while the tab is active.";
            var summary = [];
            var rows = [];
            var warningAt = null;
            var criticalAt = null;

            if (name === "connections") {
                kicker = "Database";
                title = "Connection Pressure";
                subtitle = "Client backend usage, idle sessions, and currently active PostgreSQL work.";
                warningAt = 70;
                criticalAt = 90;
                summary = [
                    metric("Usage", format(database.connection_usage_pct, 1) + "%", "of max connections"),
                    metric("Active", format(database.active_connections), "running now"),
                    metric("Idle", format(database.idle_connections), "available clients"),
                    metric("Max", format(database.max_connections), "configured limit")
                ];
                rows = sessions.map(function(item) {
                    var status = item.wait_type === "Lock" ? "critical" : item.state === "idle in transaction" ? "warning" : "active";
                    return drawerRow(item.application_name || "Database client", (item.client_address || "local") + " - " + String(item.state || "unknown").replace(/_/g, " "), formatDuration(item.duration_ms), status);
                });
            } else if (name === "cache") {
                kicker = "Database";
                title = "Database Cache & Storage";
                subtitle = "Cache hit rate, transaction health, temporary spill pressure, and database size.";
                summary = [
                    metric("Cache hit", format(database.cache_hit_pct, 1) + "%", "higher is better"),
                    metric("Database size", database.database_size || "--", "current DB size"),
                    metric("Rollback", format(database.rollback_pct, 1) + "%", "failed transactions"),
                    metric("Temp bytes", database.temp_bytes_pretty || "--", "sort/hash spill")
                ];
                rows = [
                    drawerRow("Committed transactions", "Since stats reset", format(database.transactions_committed), "active"),
                    drawerRow("Rolled back transactions", "Since stats reset", format(database.transactions_rolled_back), number(database.transactions_rolled_back) > 0 ? "warning" : "active"),
                    drawerRow("Deadlocks", "Since stats reset", format(database.deadlocks), number(database.deadlocks) > 0 ? "critical" : "active"),
                    drawerRow("Stats reset", database.stats_reset_display || "--", database.database_uptime || "--", "active")
                ];
            } else if (name === "api") {
                kicker = "API";
                title = "API Response Time";
                subtitle = api.response_time_source && api.response_time_source !== "not detected" ? "Response timing is read from " + api.response_time_source + " on every refresh." : "The API log source was found, but no response-time column was detected yet.";
                warningAt = 1000;
                criticalAt = 2000;
                summary = [
                    metric("Average", formatMs(api.avg_response_ms), "15-minute window"),
                    metric("P95", formatMs(api.p95_response_ms), "slower 5% threshold"),
                    metric("Latest", formatMs(api.latest_response_ms), "most recent sample"),
                    metric("Slow responses", format(api.slow_response_count), ">= 2 seconds")
                ];
                rows = endpoints.map(function(item) {
                    var ms = number(item.avg_response_ms);
                    return drawerRow(item.endpoint || "Unknown endpoint", format(item.request_count || 0) + " requests - " + format(item.failed_count || 0) + " failed", formatMs(item.avg_response_ms), ms >= 2000 ? "critical" : ms >= 1000 ? "warning" : "active");
                });
            } else if (name === "errors") {
                kicker = "Failed APIs";
                title = "Failed API Requests";
                subtitle = "Latest failed API rows from the current 15-minute monitoring window.";
                warningAt = 1;
                criticalAt = 10;
                summary = [
                    metric("Failed", format(api.failed_15m), "last 15 minutes"),
                    metric("Failure rate", format(api.failure_rate_pct, 1) + "%", "failed / total"),
                    metric("Success", format(api.success_15m), "last 15 minutes"),
                    metric("Total requests", format(api.requests_15m), "last 15 minutes")
                ];
                rows = currentFailedActivity.map(function(item) {
                    return drawerRow(item.endpoint || "Unknown endpoint", (item.status || "Failed") + " - " + (item.ip_address || "unknown IP") + " - " + formatMs(item.response_ms), item.logged_at_display || "", "critical");
                });
            } else if (name === "locks") {
                kicker = "Database";
                title = "Lock Pressure";
                subtitle = "Blocked connections, slow active queries, and idle transactions that can hold locks.";
                warningAt = 1;
                criticalAt = 3;
                summary = [
                    metric("Blocked", format(database.blocked_connections), "waiting on locks"),
                    metric("Slow queries", format(database.slow_queries), "over 2 seconds"),
                    metric("Idle in tx", format(database.idle_in_transaction), "lock risk"),
                    metric("Longest query", formatDuration(database.longest_query_ms), "active duration")
                ];
                rows = sessions.map(function(item) {
                    var status = item.wait_type === "Lock" ? "critical" : item.state === "idle in transaction" ? "warning" : "active";
                    return drawerRow(item.application_name || "Database client", (item.wait_event || item.wait_type || item.state || "Running") + " - " + (item.client_address || "local"), formatDuration(item.duration_ms), status);
                });
            }

            if (drawerKicker) drawerKicker.textContent = kicker;
            if (drawerTitle) drawerTitle.textContent = title;
            if (drawerSubtitle) drawerSubtitle.textContent = subtitle;
            if (drawerSummary) drawerSummary.replaceChildren.apply(drawerSummary, summary);
            renderDrawerChart(name, warningAt, criticalAt);
            if (drawerList) {
                drawerList.replaceChildren();
                if (rows.length) rows.forEach(function(item) { drawerList.append(item); });
                else emptyDrawerList(name === "errors" ? "No failed API rows returned" : "No detailed rows right now", name === "api" && (!api.response_time_source || api.response_time_source === "not detected") ? "Add a response time column to the API log table for live timing rows." : "The current monitoring sample has no rows for this card.");
            }
            if (drawerBackdrop) drawerBackdrop.hidden = false;
            drawer.classList.add("is-open");
            drawer.setAttribute("aria-hidden", "false");
        }

        function closeDrawer() {
            if (drawerBackdrop) drawerBackdrop.hidden = true;
            if (drawer) {
                drawer.classList.remove("is-open");
                drawer.setAttribute("aria-hidden", "true");
            }
            activeDrawer = null;
        }

        function render(payload) {
            var data = payload && payload.data ? payload.data : {};
            var database = data.database || {};
            var api = data.api || {};
            if (!hasNumber(api.avg_response_ms) && hasNumber(api.monitor_response_ms)) {
                api.avg_response_ms = api.monitor_response_ms;
                api.latest_response_ms = api.monitor_response_ms;
                api.p95_response_ms = api.monitor_response_ms;
                api.slow_response_count = number(api.monitor_response_ms) >= 2000 ? 1 : 0;
                api.response_time_source = "monitoring request";
            }
            api.api_response_time_display = formatMs(api.avg_response_ms);
            api.latest_response_display = formatMs(api.latest_response_ms);
            api.p95_response_display = formatMs(api.p95_response_ms);
            latestData = data;
            setValues(Object.assign({}, database, api));
            setMeter("connection_usage_pct", database.connection_usage_pct);
            setMeter("cache_hit_pct", database.cache_hit_pct);
            setMeter("failure_rate_pct", api.failure_rate_pct);
            setMeter("lock_pressure_pct", Math.min(number(database.blocked_connections) * 25 + number(database.slow_queries) * 10, 100));
            addHistory("connections", database.connection_usage_pct);
            addHistory("cache", database.cache_hit_pct);
            addHistory("api", hasNumber(api.avg_response_ms) ? api.avg_response_ms : 0);
            addHistory("errors", api.failed_15m);
            addHistory("locks", number(database.blocked_connections) + number(database.slow_queries) + number(database.idle_in_transaction));
            renderSpark();
            renderSessions(data.sessions);
            renderEndpoints(data.endpoints);
            renderActivity(data.activity);
            renderFailures(data.failed_activity || (Array.isArray(data.activity) ? data.activity.filter(function(item) {
                return String(item.status || "").toLowerCase() === "failed";
            }) : []));

            if (sampledLabel) sampledLabel.textContent = "Updated " + new Date(data.sampled_at || Date.now()).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", second: "2-digit" });
            if (sourceLabel) sourceLabel.textContent = api.api_log_source && api.api_log_source !== "not detected" ? api.api_log_source : "No log table";

            var connectionStatus = number(database.connection_usage_pct) >= 90 ? "critical" : number(database.connection_usage_pct) >= 70 ? "warning" : "healthy";
            var cacheStatus = number(database.cache_hit_pct) < 90 ? "critical" : number(database.cache_hit_pct) < 95 ? "warning" : "healthy";
            var apiStatus = number(api.avg_response_ms) >= 2000 || number(api.p95_response_ms) >= 3000 ? "critical" : number(api.avg_response_ms) >= 1000 || number(api.p95_response_ms) >= 1500 ? "warning" : "healthy";
            var errorStatus = number(api.failed_15m) >= 10 || number(api.failure_rate_pct) >= 10 ? "critical" : number(api.failed_15m) > 0 ? "warning" : "healthy";
            var lockStatus = number(database.blocked_connections) > 0 ? "critical" : number(database.slow_queries) > 0 || number(database.idle_in_transaction) > 2 ? "warning" : "healthy";
            setCardStatus("connections", connectionStatus);
            setCardStatus("cache", cacheStatus);
            setCardStatus("api", apiStatus);
            setCardStatus("errors", errorStatus);
            setCardStatus("locks", lockStatus);

            var critical = data.status === "critical" || errorStatus === "critical" || lockStatus === "critical" || apiStatus === "critical";
            var warning = data.status === "warning" || errorStatus === "warning" || lockStatus === "warning" || cacheStatus === "warning" || apiStatus === "warning";
            setState(critical ? "critical" : warning ? "warning" : "healthy", critical ? "Critical" : warning ? "Attention" : "Live and healthy");
            if (alertBox) {
                alertBox.hidden = !critical && !warning;
                alertBox.className = "elis-live-alert " + (critical ? "is-critical" : "is-warning");
            }
            if (alertTitle) alertTitle.textContent = critical ? "Immediate review recommended" : "Performance needs attention";
            if (alertCopy) {
                var conditions = [];
                if (number(database.blocked_connections) > 0) conditions.push(database.blocked_connections + " blocked connection(s)");
                if (number(database.slow_queries) > 0) conditions.push(database.slow_queries + " slow query(s)");
                if (number(database.idle_in_transaction) > 0) conditions.push(database.idle_in_transaction + " idle transaction(s)");
                if (number(api.failed_15m) > 0) conditions.push(api.failed_15m + " failed API request(s)");
                if (number(api.avg_response_ms) >= 1000) conditions.push(formatMs(api.avg_response_ms) + " avg API response");
                alertCopy.textContent = conditions.length ? conditions.join(" - ") : "One or more operating thresholds have been crossed.";
            }
            if (activeDrawer) openDrawer(activeDrawer);
        }

        function schedule() {
            window.clearTimeout(timer);
            if (!paused && !document.hidden) timer = window.setTimeout(load, 10000);
        }

        async function load() {
            if (paused || document.hidden || loading) return;
            loading = true;
            var startedAt = window.performance && performance.now ? performance.now() : Date.now();
            try {
                var formData = new URLSearchParams();
                formData.set("request_type", "snapshot");
                var response = await fetch(root.dataset.monitorUrl, {
                    method: "POST",
                    headers: { "Accept": "application/json", "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
                    body: formData.toString(),
                    credentials: "same-origin",
                    cache: "no-store"
                });
                var payload = await response.json();
                var finishedAt = window.performance && performance.now ? performance.now() : Date.now();
                if (payload && payload.data) {
                    payload.data.api = payload.data.api || {};
                    payload.data.api.monitor_response_ms = Math.max(0, Math.round(finishedAt - startedAt));
                }
                if (!response.ok || payload.success !== true) throw new Error(payload.message || "Monitoring unavailable");
                render(payload);
            } catch (error) {
                setState("disconnected", "Disconnected");
                if (alertBox) {
                    alertBox.hidden = false;
                    alertBox.className = "elis-live-alert is-critical";
                }
                if (alertTitle) alertTitle.textContent = "Live monitoring is unavailable";
                if (alertCopy) alertCopy.textContent = "The dashboard could not reach the ELIS monitoring service.";
            } finally {
                loading = false;
                schedule();
            }
        }

        function setPaused(shouldPause) {
            paused = shouldPause;
            window.clearTimeout(timer);
            if (toggleLabel) toggleLabel.textContent = paused ? "Resume" : "Pause";
            if (toggleIcon) toggleIcon.className = paused ? "ri-play-fill" : "ri-pause-fill";
            if (paused) setState("paused", "Paused");
            else load();
        }

        root.querySelectorAll("[data-live-drilldown]").forEach(function(card) {
            card.addEventListener("click", function() { openDrawer(card.dataset.liveDrilldown); });
            card.addEventListener("keydown", function(event) {
                if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    openDrawer(card.dataset.liveDrilldown);
                }
            });
        });
        if (drawerClose) drawerClose.addEventListener("click", closeDrawer);
        if (drawerBackdrop) drawerBackdrop.addEventListener("click", closeDrawer);
        document.addEventListener("keydown", function(event) {
            if (event.key === "Escape") closeDrawer();
        });
        if (toggle) toggle.addEventListener("click", function() { setPaused(!paused); });
        document.addEventListener("visibilitychange", function() {
            if (document.hidden) window.clearTimeout(timer);
            else if (!paused) load();
        });
        load();
    })();
</script>
