// Create a loading overlay component
const loadingOverlay = {
    show: function(message = 'Processing...') {
        // Remove any existing overlay first
        this.hide();
        
        // Create overlay element
        const overlay = document.createElement('div');
        overlay.id = 'ajax-loading-overlay';
        overlay.className = 'ajax-loading-overlay';
        overlay.innerHTML = `
            <div class="loading-content">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <div class="loading-text mt-3">${message}</div>
            </div>
        `;
        
        document.body.appendChild(overlay);
        document.body.style.overflow = 'hidden';
    },
    
    hide: function() {
        const overlay = document.getElementById('ajax-loading-overlay');
        if (overlay) {
            overlay.remove();
            document.body.style.overflow = '';
        }
    }
};

// CSS for the loading overlay
const loadingCSS = `
    .ajax-loading-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.42);
        backdrop-filter: blur(3px) !important;
        -webkit-backdrop-filter: blur(3px) !important;
        z-index: 9999;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: opacity 0.3s ease;
    }
    
    .loading-content {
        text-align: center;
        background: var(--custom-white);
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        animation: fadeIn 0.3s ease;
    }
    
    .loading-text {
        font-weight: 500;
        color: #495057;
        font-size: 1rem;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .spinner-border {
        width: 3rem;
        height: 3rem;
        border-width: 0.25em;
    }
`;

// Add CSS to document
const styleSheet = document.createElement("style");
styleSheet.textContent = loadingCSS;
document.head.appendChild(styleSheet);

// Global AJAX interceptors
(function() {
    // Store original fetch
    const originalFetch = window.fetch;
    
    // Override fetch
    window.fetch = async function(...args) {
        let loadingMessage = 'Loading...';
        
        // Try to extract message from options
        if (args[1] && args[1].loadingMessage) {
            loadingMessage = args[1].loadingMessage;
        }
        
        loadingOverlay.show(loadingMessage);
        
        try {
            const response = await originalFetch.apply(this, args);
            return response;
        } finally {
            setTimeout(() => loadingOverlay.hide(), 300); // Small delay for smooth transition
        }
    };
    
    // jQuery AJAX interceptors (if jQuery is used)
    if (window.jQuery) {
        $(document).ajaxStart(function() {
            loadingOverlay.show('Processing request...');
        });
        
        $(document).ajaxStop(function() {
            setTimeout(() => loadingOverlay.hide(), 300);
        });
        
        $(document).ajaxError(function(event, jqxhr, settings, thrownError) {
            loadingOverlay.hide();
            console.error('AJAX Error:', thrownError);
        });
    }
})();

// Alternative: For specific AJAX calls with custom messages
function ajaxWithLoading(options) {
    const { 
        url, 
        method = 'GET', 
        data = null, 
        message = 'Processing...',
        success = () => {},
        error = () => {},
        complete = () => {}
    } = options;
    
    loadingOverlay.show(message);
    
    fetch(url, {
        method: method,
        headers: {
            'Content-Type': 'application/json',
        },
        body: data ? JSON.stringify(data) : null
    })
    .then(response => response.json())
    .then(data => {
        success(data);
    })
    .catch(err => {
        error(err);
    })
    .finally(() => {
        setTimeout(() => loadingOverlay.hide(), 300);
        complete();
    });
}

// Enhanced tooltip initialization
window.initializeTooltips = function() {
    // Check if tooltip plugin is available
    if (!$.fn.tooltip) {
        console.warn('Tooltip plugin not loaded');
        return;
    }
    
    // Destroy existing tooltips to prevent duplicates
    $('[data-bs-toggle="tooltip"]').tooltip('dispose');
    
    // Initialize with optimized settings
    $('[data-bs-toggle="tooltip"]').tooltip({
        trigger: 'hover',
        delay: {
            show: 200,    // Reduced from default 0 to 200ms for better UX
            hide: 0       // Hide immediately
        },
        animation: true,
        html: false,
        container: 'body',
        boundary: 'window',
        template: '<div class="tooltip custom-tooltip" role="tooltip">' +
                 '<div class="tooltip-arrow"></div>' +
                 '<div class="tooltip-inner"></div>' +
                 '</div>'
    });
}
