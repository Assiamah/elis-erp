<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
 /* ==============================
   ROOT VARIABLES (OTP THEME)
================================ */
:root {
    --primary: #10b981;
    --primary-dark: #059669;
    --secondary: #14b8a6;
    --accent: #84cc16;
    --danger: #ef4444;
    --warning: #f59e0b;
    --info: #0ea5e9;
    --bg: #f8fafc;
    --card-bg: #ffffff;
    --text-dark: #1f2937;
    --text-muted: #6b7280;
    --border: #e5e7eb;
}

/* ==============================
   GLOBAL
================================ */
body {
    font-family: 'Rubik', sans-serif;
    background: var(--bg);
    color: var(--text-dark);
}

.gcsez-dashboard {
    padding: 24px;
}

/* ==============================
   BREADCRUMB
================================ */
.gcsez-breadcrumb {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
}

.gcsez-breadcrumb-title {
    font-size: 1.6rem;
    font-weight: 600;
}

.gcsez-breadcrumb-nav a {
    color: var(--primary);
    text-decoration: none;
    font-weight: 500;
}

.gcsez-breadcrumb-nav span {
    margin: 0 6px;
    color: var(--text-muted);
}

/* ==============================
   STATS CARDS
================================ */
.gcsez-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 32px;
}

.gcsez-stat-card {
    padding: 22px;
    border-radius: 16px;
    color: #fff;
    display: flex;
    align-items: center;
    gap: 18px;
    box-shadow: 0 12px 30px rgba(16, 185, 129, 0.35);
    transition: all 0.3s ease;
}

.gcsez-stat-card:hover {
    transform: translateY(-6px);
}

/* OTP matched gradients */
.gcsez-stat-card:nth-child(1) {
    background: linear-gradient(135deg, #10b981, #059669);
}
.gcsez-stat-card:nth-child(2) {
    background: linear-gradient(135deg, #22c55e, #15803d);
}
.gcsez-stat-card:nth-child(3) {
    background: linear-gradient(135deg, #14b8a6, #0f766e);
}
.gcsez-stat-card:nth-child(4) {
    background: linear-gradient(135deg, #84cc16, #3f6212);
}

.gcsez-stat-icon {
    width: 56px;
    height: 56px;
    background: rgba(255,255,255,0.2);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
}

.gcsez-stat-number {
    font-size: 1.8rem;
    font-weight: 800;
}

.gcsez-stat-title {
    font-size: 0.85rem;
    opacity: 0.9;
}

/* ==============================
   SECTIONS
================================ */
.gcsez-section {
    background: var(--card-bg);
    border-radius: 18px;
    padding: 22px;
    margin-bottom: 28px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.05);
}

.gcsez-section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
}

.gcsez-section-title {
    font-size: 1.2rem;
    font-weight: 600;
}

/* ==============================
   BUTTONS
================================ */
.gcsez-btn {
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: #fff;
    border: none;
    padding: 10px 18px;
    border-radius: 10px;
    font-weight: 500;
    cursor: pointer;
}

.gcsez-btn-outline {
    background: #fff;
    border: 1px solid var(--border);
    color: var(--text-dark);
    padding: 8px 14px;
    border-radius: 10px;
    cursor: pointer;
}

.gcsez-btn-sm {
    padding: 6px 10px;
}

/* ==============================
   TABLES
================================ */
.gcsez-table {
    width: 100%;
    border-collapse: collapse;
}

.gcsez-table thead {
    background: #f1f5f9;
}

.gcsez-table th {
    text-align: left;
    font-size: 0.8rem;
    padding: 12px;
    color: var(--text-muted);
}

.gcsez-table td {
    padding: 12px;
    border-bottom: 1px solid var(--border);
    font-size: 0.9rem;
}

/* ==============================
   BADGES
================================ */
.gcsez-badge {
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 0.75rem;
    font-weight: 600;
}

.gcsez-badge.success { background: #dcfce7; color: #166534; }
.gcsez-badge.warning { background: #fef3c7; color: #92400e; }
.gcsez-badge.danger  { background: #fee2e2; color: #991b1b; }
.gcsez-badge.info    { background: #e0f2fe; color: #075985; }
.gcsez-badge.primary { background: #d1fae5; color: #065f46; }

/* ==============================
   SEARCH
================================ */
.gcsez-search {
    position: relative;
}

.gcsez-search-input {
    padding: 8px 12px 8px 34px;
    border-radius: 10px;
    border: 1px solid var(--border);
}

.gcsez-search-icon {
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-muted);
}

/* ==============================
   MINI STATS
================================ */
.gcsez-stats-overview {
    display: flex;
    justify-content: space-between;
    margin-top: 16px;
}

.gcsez-stat-mini-value {
    font-weight: 700;
    color: var(--primary);
}

.gcsez-stat-mini-label {
    font-size: 0.75rem;
    color: var(--text-muted);
}

</style>

<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<main style="margin-left: 260px; transition: margin-left 0.3s;">

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg sticky-top" style="background: rgba(15,23,42,0.85); backdrop-filter: blur(10px);">
    <div class="container-fluid px-4">
      <button class="btn btn-outline-secondary d-lg-none me-3" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas">
        <i class="bi bi-list fs-4"></i>
      </button>
      
      <form class="d-flex flex-grow-1 mx-4" role="search">
        <input class="form-control bg-dark border-0 text-white" 
               type="search" placeholder="Search..." aria-label="Search"
               style="max-width: 420px;">
      </form>

      <div class="d-flex align-items-center gap-3">
        <button class="btn btn-outline-secondary rounded-circle p-2">
          <i class="bi bi-bell"></i>
        </button>
        <button class="btn btn-outline-secondary rounded-circle p-2">
          <i class="bi bi-chat-dots"></i>
        </button>
      </div>
    </div>
  </nav>

  <!-- Content -->
  <div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="mb-0">Dashboard Overview</h2>
      <div>
        <button class="btn btn-outline-light me-2">Last 30 days</button>
        <button class="btn btn-primary">Download Report</button>
      </div>
    </div>

    <!-- Stats Row -->
    <div class="row g-4 mb-5">
      <div class="col-xl-3 col-md-6">
        <div class="card stat-card bg-deep-purple">
          <div class="card-body">
            <h6 class="text-secondary mb-1">Total Revenue</h6>
            <h3 class="mb-0">$128,430</h3>
            <small class="text-success">+18.2% from last month</small>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card stat-card bg-deep-emerald">
          <div class="card-body">
            <h6 class="text-secondary mb-1">New Customers</h6>
            <h3 class="mb-0">3,842</h3>
            <small class="text-success">+12.4% from last month</small>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card stat-card bg-deep-rose">
          <div class="card-body">
            <h6 class="text-secondary mb-1">Active Projects</h6>
            <h3 class="mb-0">47</h3>
            <small class="text-warning">3 due this week</small>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card stat-card bg-deep-teal">
          <div class="card-body">
            <h6 class="text-secondary mb-1">Conversion Rate</h6>
            <h3 class="mb-0">4.8%</h3>
            <small class="text-success">+0.6% from last month</small>
          </div>
        </div>
      </div>
    </div>

    <!-- Charts & Tables Row -->
    <div class="row g-4">
      <div class="col-xl-8">
        <div class="card h-100">
          <div class="card-header">
            <h5 class="mb-0">Revenue Trend</h5>
          </div>
          <div class="card-body">
            <!-- You can paste Chart.js / ApexCharts code here -->
            <div class="bg-dark rounded-3" style="height: 320px; display:flex; align-items:center; justify-content:center;">
              <p class="text-secondary mb-0">[ Revenue line chart goes here ]</p>
            </div>
          </div>
        </div>
      </div>

      <div class="col-xl-4">
        <div class="card h-100">
          <div class="card-header">
            <h5 class="mb-0">Top Products</h5>
          </div>
          <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
              <span>Pro Plan</span>
              <span class="fw-bold">$24,890</span>
            </div>
            <div class="progress mb-4"><div class="progress-bar" style="width: 78%"></div></div>

            <div class="d-flex justify-content-between mb-3">
              <span>Enterprise</span>
              <span class="fw-bold">$19,120</span>
            </div>
            <div class="progress mb-4"><div class="progress-bar" style="width: 62%"></div></div>

            <div class="d-flex justify-content-between mb-3">
              <span>Team Plan</span>
              <span class="fw-bold">$11,450</span>
            </div>
            <div class="progress mb-4"><div class="progress-bar" style="width: 41%"></div></div>
          </div>
        </div>
      </div>
    </div>

  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Initialize charts with GCSEZ color scheme
document.addEventListener('DOMContentLoaded', function() {
    const gcsezColors = {
        primary: '#326573',
        secondary: '#57a394',
        accent: '#c5bb85',
        warning: '#b48478'
    };

    // Lease Status Chart
    const leaseStatusCtx = document.getElementById('gcsezLeaseStatusChart').getContext('2d');
    new Chart(leaseStatusCtx, {
        type: 'doughnut',
        data: {
            labels: ['Approved', 'Pending', 'Under Review', 'Rejected'],
            datasets: [{
                data: [15, 12, 8, 7],
                backgroundColor: [
                    gcsezColors.primary,
                    gcsezColors.secondary,
                    gcsezColors.accent,
                    gcsezColors.warning
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
    
    // Rent Collection Chart
    const rentCollectionCtx = document.getElementById('gcsezRentCollectionChart').getContext('2d');
    new Chart(rentCollectionCtx, {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
            datasets: [{
                label: 'Rent Collected (GHS)',
                data: [12500, 13200, 14100, 14800, 15600, 16400, 17200, 17400, 17900, 18540],
                backgroundColor: gcsezColors.secondary,
                borderColor: gcsezColors.primary,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return 'GHS ' + value;
                        }
                    }
                }
            }
        }
    });
    
    // Sales Chart
    const salesCtx = document.getElementById('gcsezSalesChart').getContext('2d');
    new Chart(salesCtx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Daily Sales (GHS)',
                data: [8450, 12500, 9800, 11200, 15600, 12800, 14800],
                backgroundColor: gcsezColors.accent + '20',
                borderColor: gcsezColors.accent,
                borderWidth: 2,
                tension: 0.3,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return 'GHS ' + value;
                        }
                    }
                }
            }
        }
    });
});
</script>