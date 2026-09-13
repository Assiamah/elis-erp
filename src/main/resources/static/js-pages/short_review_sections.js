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
        // Fetch before Bootstrap opens the step modal so existing show/shown handlers
        // see populated fields. Keep the modal nodes, maps and direct event handlers.
        var readyButtons = new WeakSet();
        document.addEventListener('click', function (event) {
            var button = event.target.closest('.step-quick-actions [data-bs-toggle="modal"]');
            if (!button || button.disabled) return;
            if (readyButtons.has(button)) {
                readyButtons.delete(button);
                return;
            }
            var id = (button.getAttribute('data-bs-target') || '').replace(/^#/, '');
            var modal = document.getElementById(id);
            if (!modal || !modal.hasAttribute('data-short-review-modal')) return;
            event.preventDefault();
            event.stopImmediatePropagation();
            var label = button.innerHTML;
            var status = button.parentElement.querySelector('.short-review-modal-status');
            if (!status) {
                status = document.createElement('span');
                status.className = 'short-review-modal-status small d-block mt-2';
                status.setAttribute('role', 'status');
                button.parentElement.appendChild(status);
            }
            button.disabled = true;
            button.textContent = 'Loading…';
            status.textContent = '';
            status.classList.remove('text-danger');
            modal.setAttribute('aria-busy', 'true');
            $.ajax({
                url: 'short_review_modal', type: 'POST', dataType: 'html', timeout: 30000,
                data: {context: context.value, modal: id}
            }).done(function (html) {
                try {
                    var parsed = new DOMParser().parseFromString(html, 'text/html');
                    var fresh = parsed.getElementById(id);
                    if (!fresh || !fresh.hasAttribute('data-short-review-modal')) {
                        throw new Error('Missing workflow modal');
                    }
                    // Check all bindings before changing any live controls.
                    var bindings = Array.from(modal.querySelectorAll('[data-short-hydrate]')).filter(function (node) {
                        return !node.parentElement.closest('[data-short-content="true"]');
                    }).map(function (node) {
                        var replacement = fresh.querySelector('[data-short-hydrate="' + node.dataset.shortHydrate + '"]');
                        if (!replacement) throw new Error('Incomplete workflow modal');
                        return [node, replacement];
                    });
                    bindings.forEach(function (pair) {
                        var node = pair[0], replacement = pair[1];
                        if (node.dataset.shortContent === 'true') {
                            var editor = typeof Quill !== 'undefined' && typeof Quill.find === 'function' ? Quill.find(node) : null;
                            if (editor && editor.clipboard) {
                                editor.clipboard.dangerouslyPasteHTML(replacement.innerHTML, 'silent');
                            } else {
                                node.innerHTML = replacement.innerHTML;
                            }
                        }
                        (node.dataset.shortAttributes || '').split(',').filter(Boolean).forEach(function (name) {
                            if (replacement.hasAttribute(name)) node.setAttribute(name, replacement.getAttribute(name));
                            else node.removeAttribute(name);
                        });
                        if (node.dataset.shortControl === 'true') {
                            node.value = replacement.value;
                            if (node.type === 'checkbox' || node.type === 'radio') node.checked = replacement.checked;
                        }
                    });
                    button.disabled = false;
                    button.innerHTML = label;
                    readyButtons.add(button);
                    button.click();
                } catch (error) {
                    status.classList.add('text-danger');
                    status.textContent = 'Unable to populate these details. Click Details to retry.';
                }
            }).fail(function (xhr) {
                status.classList.add('text-danger');
                status.textContent = xhr.status === 401 ? 'Session expired. Sign in again.' :
                    xhr.status === 410 ? 'Please reload this application page.' :
                    'Unable to load these details. Click Details to retry.';
            }).always(function () {
                button.disabled = false;
                button.innerHTML = label;
                modal.setAttribute('aria-busy', 'false');
            });
        }, true);
        var mapButton = document.getElementById('short-review-load-map');
        var map;
        if (mapButton) mapButton.addEventListener('click', function () {
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
        var mapPanel = document.getElementById('collapseMap');
        if (mapPanel) mapPanel.addEventListener('shown.bs.collapse', function () {
            if (map) map.updateSize();
        });
    });
}());
