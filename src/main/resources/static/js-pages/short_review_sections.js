(function () {
    'use strict';
    document.addEventListener('DOMContentLoaded', function () {
        var context = document.getElementById('short-review-context');
        if (!context) return;
        document.addEventListener('click', function (event) {
            var button = event.target.closest('.short-review-load');
            if (!button || button.disabled) return;
            var panel = document.getElementById(button.dataset.panel);
            var status = panel.querySelector('.short-review-status');
            var target = panel.querySelector('.short-review-results') || panel.querySelector('tbody');
            var buttons = panel.querySelectorAll('.short-review-load');
            buttons.forEach(function (item) { item.disabled = true; });
            status.textContent = 'Loading…';
            status.classList.remove('text-danger');
            target.setAttribute('aria-busy', 'true');
            $.ajax({
                url: 'short_review_section',
                type: 'POST',
                dataType: 'html',
                timeout: 30000,
                data: {context: context.value, section: button.dataset.section}
            }).done(function (html) {
                target.innerHTML = html;
                status.textContent = 'Loaded';
                buttons.forEach(function (item) { item.textContent = 'Refresh'; });
                target.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (item) {
                    bootstrap.Tooltip.getOrCreateInstance(item);
                });
                if (button.dataset.section === 'parties') {
                    panel.parentElement.querySelector('.accordion-button .badge').textContent =
                        target.querySelectorAll('tr').length && !target.querySelector('[colspan]') ? target.querySelectorAll('tr').length : 0;
                }
            }).fail(function (xhr) {
                status.classList.add('text-danger');
                status.textContent = xhr.status === 401 ? 'Session expired. Sign in again.' :
                    xhr.status === 410 ? 'Please reload this application page.' : 'Unable to load. Click Load or Refresh to retry.';
            }).always(function () {
                buttons.forEach(function (item) { item.disabled = false; });
                target.setAttribute('aria-busy', 'false');
            });
        });
        var mapButton = document.getElementById('short-review-load-map');
        var map;
        mapButton.addEventListener('click', function () {
            var status = document.getElementById('short-review-map-status');
            try {
                map = initializeShortReviewMap();
                mapButton.disabled = true;
                mapButton.textContent = 'Map loaded';
                status.textContent = '';
            } catch (error) {
                status.textContent = 'Unable to display the parcel map. Check the parcel geometry and retry.';
            }
        });
        document.getElementById('collapseMap').addEventListener('shown.bs.collapse', function () {
            if (map) map.updateSize();
        });
    });
}());
