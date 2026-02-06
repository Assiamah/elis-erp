class InactivityTimer {
    constructor(config = {}) {
        // Configuration
        this.config = {
            warningTime: 100,      // 1 minute warning
            logoutTime: 900,       // 15 minutes total until logout
            checkInterval: 1000,
            events: ['mousemove', 'keydown', 'click', 'scroll', 'touchstart', 'mousedown', 'input', 'wheel'],
            extendOnButtonClick: true,
            buttonExtensionMinutes: 15,
            debounceDelay: 500,    // Prevent rapid resets
            ignoreEvents: ['mouseleave', 'mouseenter'], // Events to ignore
            ...config
        };
        
        // State
        this.lastActivity = Date.now();
        this.logoutTimer = null;
        this.warningTimer = null;
        this.countdownInterval = null;
        this.isModalShowing = false;
        this.timeLeft = this.config.warningTime;
        this.modal = null;
        this.backdrop = null;
        this.isActive = true;
        this.debounceTimeout = null;
        
        // Initialize
        this.init();
    }
    
    init() {
        // Store modal elements
        this.modal = document.getElementById('inactivityModal');
        this.backdrop = document.getElementById('inactivityBackdrop');
        
        if (!this.modal) {
            console.warn('Modal element not found. Creating fallback.');
            this.createFallbackModal();
        }
        
        // IMPORTANT: Enable event listeners
        this.setupEventListeners();
        this.setupTimers();
        this.setupModalHandlers();
        this.setupVisibilityHandler();
        
        // Add CSS for progress bar gradient
        this.addProgressBarStyles();
        
        // Track initial activity
        this.updateLastActivity();
    }
    
    createFallbackModal() {
        // Create modal if it doesn't exist
        this.modal = document.createElement('div');
        this.modal.id = 'inactivityModal';
        this.modal.className = 'modal fade';
        this.modal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Session About to Expire</h5>
                    </div>
                    <div class="modal-body">
                        <p>Your session will expire in <span id="countdownTimer" class="fw-bold">05:00</span> due to inactivity.</p>
                        <div class="progress" style="height: 5px;">
                            <div id="progressFill" class="progress-bar" role="progressbar" style="width: 100%"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="stayActiveBtn">Stay Active</button>
                        <button type="button" class="btn btn-secondary" id="logoutNowBtn">Logout Now</button>
                    </div>
                </div>
            </div>
        `;
        document.body.appendChild(this.modal);
        
        // Create backdrop
        this.backdrop = document.createElement('div');
        this.backdrop.id = 'inactivityBackdrop';
        this.backdrop.className = 'modal-backdrop fade';
        document.body.appendChild(this.backdrop);
    }
    
    addProgressBarStyles() {
        if (!document.querySelector('#inactivity-timer-styles')) {
            const style = document.createElement('style');
            style.id = 'inactivity-timer-styles';
            style.textContent = `
                .progress-bar-gradient {
                    background: linear-gradient(90deg, #2ecc71 0%, #f1c40f 50%, #e74c3c 100%) !important;
                    transition: width 1s linear !important;
                }
                .countdown-critical {
                    animation: pulseCritical 0.5s infinite !important;
                }
                @keyframes pulseCritical {
                    0% { opacity: 1; }
                    50% { opacity: 0.6; }
                    100% { opacity: 1; }
                }
                #inactivityModal {
                    z-index: 1060;
                }
                #inactivityBackdrop {
                    z-index: 1050;
                }
            `;
            document.head.appendChild(style);
        }
    }
    
    // FIXED: Uncomment and enhance event listeners
    setupEventListeners() {
        // User activity resets timer (with debouncing)
        this.config.events.forEach(event => {
            document.addEventListener(event, (e) => {
                // Skip ignored events
                if (this.config.ignoreEvents.includes(event)) {
                    return;
                }
                
                // Handle specific events
                if (event === 'keydown') {
                    // Ignore modifier keys only
                    const modifierKeys = ['Shift', 'Control', 'Alt', 'Meta', 'CapsLock'];
                    if (modifierKeys.includes(e.key)) {
                        return;
                    }
                }
                
                this.handleUserActivity();
            }, { passive: true });
        });
        
        // Handle browser tab visibility
        document.addEventListener('visibilitychange', () => {
            if (!document.hidden) {
                this.handleUserActivity();
            }
        });
        
        // Handle window focus/blur
        window.addEventListener('focus', () => {
            this.handleUserActivity();
        });
        
        // Optional: Handle AJAX requests if your app uses them
        this.setupAjaxActivityTracking();
    }
    
    handleUserActivity() {
        // Debounce to prevent excessive calls
        if (this.debounceTimeout) {
            clearTimeout(this.debounceTimeout);
        }
        
        this.debounceTimeout = setTimeout(() => {
            this.resetTimer();
            this.isActive = true;
        }, this.config.debounceDelay);
    }
    
    setupAjaxActivityTracking() {
        // Track AJAX requests as activity
        const originalSend = XMLHttpRequest.prototype.send;
        XMLHttpRequest.prototype.send = function(...args) {
            window.sessionTimer?.handleUserActivity();
            return originalSend.apply(this, args);
        };
        
        // Track fetch requests as activity
        const originalFetch = window.fetch;
        window.fetch = function(...args) {
            window.sessionTimer?.handleUserActivity();
            return originalFetch.apply(this, args);
        };
    }
    
    setupModalHandlers() {
        // Stay Active Button
        const stayActiveBtn = document.getElementById('stayActiveBtn');
        if (stayActiveBtn) {
            stayActiveBtn.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.handleStayActiveClick();
            });
        }
        
        // Logout Now Button
        const logoutNowBtn = document.getElementById('logoutNowBtn');
        if (logoutNowBtn) {
            logoutNowBtn.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.forceLogout();
            });
        }
        
        // Close button (X) in modal header
        const closeBtn = this.modal?.querySelector('[data-bs-dismiss="modal"]');
        if (closeBtn) {
            closeBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.handleStayActiveClick();
            });
        }
    }
    
    handleStayActiveClick() {
        // Reset the timer
        this.resetTimer();
        
        // Optional: Extend session for longer period
        if (this.config.extendOnButtonClick) {
            this.extendSession(this.config.buttonExtensionMinutes);
        }
        
        // Show confirmation feedback
        this.showConfirmationFeedback();
    }
    
    showConfirmationFeedback() {
        const button = document.getElementById('stayActiveBtn');
        if (!button) return;
        
        const originalText = button.innerHTML;
        
        // Visual feedback
        button.innerHTML = '<span class="me-2">✓</span> Session Extended!';
        button.classList.remove('btn-primary');
        button.classList.add('btn-success');
        
        // Hide modal after delay
        setTimeout(() => {
            this.hideWarningModal();
            
            // Reset button after modal hides
            setTimeout(() => {
                button.innerHTML = originalText;
                button.classList.remove('btn-success');
                button.classList.add('btn-primary');
            }, 300);
        }, 500);
    }
    
    setupTimers() {
        // Clear existing timers
        this.clearTimers();
        
        const warningDelay = (this.config.logoutTime - this.config.warningTime) * 1000;
        const logoutDelay = this.config.logoutTime * 1000;
        
        // Set warning timer (when to show modal)
        this.warningTimer = setTimeout(() => {
            this.showWarningModal();
        }, warningDelay);
        
        // Set logout timer (when to force logout)
        this.logoutTimer = setTimeout(() => {
            this.forceLogout();
        }, logoutDelay);
    }
    
    updateLastActivity() {
        this.lastActivity = Date.now();
        this.isActive = true;
    }
    
    resetTimer() {
        // Update last activity timestamp
        this.updateLastActivity();
        
        // Hide modal if showing
        if (this.isModalShowing) {
            this.hideWarningModal();
        }
        
        // Reset all timers
        this.setupTimers();
        
        // Optional: Update UI to show user is active
        this.showActivityIndicator();
    }
    
    showActivityIndicator() {
        // Optional: Show a brief visual indicator that activity was detected
        const indicator = document.createElement('div');
        indicator.className = 'activity-indicator position-fixed bottom-0 end-0 m-3';
        indicator.style.cssText = 'z-index: 1000; transition: opacity 0.5s;';
        indicator.innerHTML = '<div class="alert alert-success alert-dismissible fade show" style="padding: 5px 10px; margin: 0;"><small>✓ Active</small></div>';
        
        document.body.appendChild(indicator);
        
        setTimeout(() => {
            indicator.style.opacity = '0';
            setTimeout(() => {
                if (indicator.parentNode) {
                    indicator.remove();
                }
            }, 500);
        }, 1000);
    }
    
    showWarningModal() {
        if (this.isModalShowing) return;
        
        // Check if user is actually inactive
        const timeSinceActivity = Date.now() - this.lastActivity;
        const inactiveThreshold = (this.config.logoutTime - this.config.warningTime) * 1000;
        
        if (timeSinceActivity < inactiveThreshold) {
            // User has been active recently, don't show modal
            this.resetTimer();
            return;
        }
        
        this.isModalShowing = true;
        this.timeLeft = this.config.warningTime;
        
        // Update the timer display immediately
        this.updateCountdownDisplay();
        
        // Show Bootstrap modal using vanilla JS
        this.showBootstrapModal();
        
        // Start countdown
        this.startVisualCountdown();
        
        // Optional: Play sound notification
        this.playNotificationSound();

        // Optional: Browser notification (if permitted)
        this.showBrowserNotification();
    }
    
    showBootstrapModal() {
        if (!this.modal) return;
        
        // Show modal
        this.modal.style.display = 'block';
        this.modal.classList.add('show');
        this.modal.setAttribute('aria-hidden', 'false');
        
        // Show backdrop if it exists
        if (this.backdrop) {
            this.backdrop.style.display = 'block';
            this.backdrop.classList.add('show');
        } else {
            // Create backdrop if it doesn't exist
            const backdrop = document.createElement('div');
            backdrop.className = 'modal-backdrop fade show';
            backdrop.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 1040;';
            document.body.appendChild(backdrop);
            this.backdrop = backdrop;
        }
        
        // Prevent body scroll
        document.body.style.overflow = 'hidden';
        
        // Set focus to Stay Active button after a short delay
        setTimeout(() => {
            const stayActiveBtn = document.getElementById('stayActiveBtn');
            if (stayActiveBtn) {
                stayActiveBtn.focus();
            }
        }, 100);
    }
    
    startVisualCountdown() {
        // Clear any existing interval
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
        }
        
        // Update immediately
        this.updateCountdownDisplay();
        
        // Update every second
        this.countdownInterval = setInterval(() => {
            this.updateCountdownDisplay();
        }, 1000);
    }
    
    updateCountdownDisplay() {
        if (!this.isModalShowing) return;
        
        // Update time left
        this.timeLeft--;
        
        // Update timer display
        const timerElement = document.getElementById('countdownTimer');
        if (timerElement) {
            const minutes = Math.floor(this.timeLeft / 60);
            const seconds = this.timeLeft % 60;
            timerElement.textContent = 
                `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
            
            // Update visual urgency
            this.updateVisualUrgency();
        }
        
        // Update progress bar
        const progressFill = document.getElementById('progressFill');
        if (progressFill) {
            const percentage = Math.max(0, (this.timeLeft / this.config.warningTime) * 100);
            progressFill.style.width = `${percentage}%`;
            
            // Add gradient class if not present
            if (!progressFill.classList.contains('progress-bar-gradient')) {
                progressFill.classList.add('progress-bar-gradient');
            }
        }
        
        // Check if time's up
        if (this.timeLeft <= 0) {
            clearInterval(this.countdownInterval);
            this.forceLogout();
        }
    }
    
    updateVisualUrgency() {
        const timerElement = document.getElementById('countdownTimer');
        if (!timerElement) return;
        
        // Remove all urgency classes
        timerElement.classList.remove('text-warning', 'text-danger', 'countdown-critical');
        
        // Add appropriate classes based on time left
        if (this.timeLeft <= 60) { // Last minute
            timerElement.classList.add('text-danger', 'countdown-critical');
        } else if (this.timeLeft <= 120) { // Last 2 minutes
            timerElement.classList.add('text-warning', 'countdown-critical');
        } else if (this.timeLeft <= 180) { // Last 3 minutes
            timerElement.classList.add('text-warning');
        }
    }
    
    hideWarningModal() {
        if (!this.isModalShowing) return;
        
        this.isModalShowing = false;
        
        // Hide Bootstrap modal
        this.hideBootstrapModal();
        
        // Clear countdown interval
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
            this.countdownInterval = null;
        }
        
        // Reset progress bar
        const progressFill = document.getElementById('progressFill');
        if (progressFill) {
            progressFill.style.width = '100%';
        }
    }
    
    hideBootstrapModal() {
        // Hide modal
        if (this.modal) {
            this.modal.style.display = 'none';
            this.modal.classList.remove('show');
            this.modal.setAttribute('aria-hidden', 'true');
        }
        
        // Hide backdrop
        if (this.backdrop) {
            this.backdrop.style.display = 'none';
            this.backdrop.classList.remove('show');
        }
        
        // Restore body scroll
        document.body.style.overflow = '';
    }
    
    resetTimer() {
        // Update last activity timestamp
        this.lastActivity = Date.now();
        
        // Hide modal if showing
        if (this.isModalShowing) {
            this.hideWarningModal();
        }
        
        // Reset all timers
        this.setupTimers();
    }
    
    extendSession(minutes) {
        // Add extra time to both timers
        const extraSeconds = minutes * 60;
        this.config.logoutTime += extraSeconds;
        this.config.warningTime += extraSeconds;
        
        // Show notification
        this.showExtendedNotification(minutes);
    }
    
    showExtendedNotification(minutes) {
        // Remove existing notification if any
        const existingNotification = document.querySelector('.session-extended-notification');
        if (existingNotification) {
            existingNotification.remove();
        }
        
        // Create toast notification
        const toast = document.createElement('div');
        toast.className = 'session-extended-notification position-fixed top-0 end-0 p-3';
        toast.style.zIndex = '1060';
        
        toast.innerHTML = `
            <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header bg-success text-white">
                    <strong class="me-auto">✓ Session Extended</strong>
                    <button type="button" class="btn-close btn-close-white" onclick="this.parentElement.parentElement.parentElement.remove()"></button>
                </div>
                <div class="toast-body">
                    Session extended by ${minutes} minutes.
                </div>
            </div>
        `;
        
        document.body.appendChild(toast);
        
        // Remove after delay
        setTimeout(() => {
            if (toast.parentNode) {
                toast.remove();
            }
        }, 3000);
    }
    
    async forceLogout() {
        // Only logout if truly inactive
        const timeSinceActivity = Date.now() - this.lastActivity;
        const logoutThreshold = this.config.logoutTime * 1000;
        
        if (timeSinceActivity < logoutThreshold) {
            // User has been active, reset instead
            this.resetTimer();
            return;
        }
        
        this.clearTimers();
        this.hideWarningModal();
        
        // Optional: Send logout request to server
        // await this.sendLogoutRequest();
        
        // Redirect to logout page
        window.location.href = '/Logout';
    }
    
    setupVisibilityHandler() {
        let hiddenTime = null;
        
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                hiddenTime = Date.now();
            } else {
                if (hiddenTime) {
                    const timeHidden = Date.now() - hiddenTime;
                    const secondsHidden = Math.floor(timeHidden / 1000);
                    
                    // If screen was off for too long, consider it inactivity
                    if (secondsHidden > 30) {
                        this.handleScreenOff(secondsHidden);
                    }
                }
            }
        });
    }
    
    handleScreenOff(secondsOff) {
        const warningSeconds = this.config.logoutTime - this.config.warningTime;
        
        if (secondsOff >= this.config.logoutTime) {
            // Screen was off longer than total logout time
            this.forceLogout();
        } else if (secondsOff >= warningSeconds) {
            // Screen was off past warning threshold
            this.showWarningModal();
            this.timeLeft = this.config.warningTime - (secondsOff - warningSeconds);
            
            // Ensure timeLeft is not negative
            this.timeLeft = Math.max(0, this.timeLeft);
        }
    }
    
    playNotificationSound() {
        // Simple beep sound using Web Audio API
        try {
            const audioContext = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioContext.createOscillator();
            const gainNode = audioContext.createGain();
            
            oscillator.connect(gainNode);
            gainNode.connect(audioContext.destination);
            
            oscillator.frequency.value = 800;
            oscillator.type = 'sine';
            gainNode.gain.value = 0.1;
            
            oscillator.start();
            setTimeout(() => oscillator.stop(), 200);
        } catch (e) {
            // Audio not supported
        }
    }

    showBrowserNotification() {
        // Request permission and show notification
        if ("Notification" in window && Notification.permission === "granted") {
            new Notification("Session Expiring Soon", {
                body: "Your session will expire in 5 minutes. Click to stay active.",
                icon: "/notification-icon.png",
                requireInteraction: true
            });
        } else if (Notification.permission !== "denied") {
            Notification.requestPermission().then(permission => {
                if (permission === "granted") {
                    this.showBrowserNotification();
                }
            });
        }
    }
    
    // async sendLogoutRequest() {
    //     try {
    //         const response = await fetch('/api/logout', {
    //             method: 'POST',
    //             headers: { 'Content-Type': 'application/json' },
    //             body: JSON.stringify({ 
    //                 reason: 'inactivity',
    //                 timestamp: new Date().toISOString()
    //             })
    //         });
            
    //         return await response.json();
    //     } catch (error) {
    //         throw error;
    //     }
    // }
    
    clearTimers() {
        if (this.warningTimer) {
            clearTimeout(this.warningTimer);
            this.warningTimer = null;
        }
        
        if (this.logoutTimer) {
            clearTimeout(this.logoutTimer);
            this.logoutTimer = null;
        }
        
        if (this.countdownInterval) {
            clearInterval(this.countdownInterval);
            this.countdownInterval = null;
        }
    }
    
    destroy() {
        this.clearTimers();
        
        // Remove event listeners
        this.config.events.forEach(event => {
            document.removeEventListener(event, this.handleUserActivity);
        });
        
        document.removeEventListener('visibilitychange', this.handleVisibilityChange);
        window.removeEventListener('focus', this.handleUserActivity);
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', () => {
    // Check authentication before starting timer
    const isAuthenticated = checkAuthentication();
    
    if (isAuthenticated) {
        window.sessionTimer = new InactivityTimer({
            warningTime: 100,    // 1 minute warning before logout
            logoutTime: 900,     // 15 minutes total inactivity until logout
            extendOnButtonClick: true,
            buttonExtensionMinutes: 15,
            debounceDelay: 500   // Prevent rapid resets from scroll/mousemove
        });
    }
});

function checkAuthentication() {
    // Replace with your actual authentication check
    // Example: return document.cookie.includes('sessionId=');
    return true;
}

// Optional: Add method to manually trigger activity (for forms, etc.)
window.triggerActivity = function() {
    if (window.sessionTimer) {
        window.sessionTimer.resetTimer();
    }
};