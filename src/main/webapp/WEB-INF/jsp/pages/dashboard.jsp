<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  /* ────────────────────────────────────────────────
   Modern Color Palette (2025/2026 inspired)
   Primary   : #2c5282 → #3182ce (deep blue → vibrant blue)
   Success   : #38a169 → #48bb78 (fresh green)
   Warning   : #dd6b20 → #ed8936 (warm orange)
   Danger    : #c53030 → #f56565 (soft red)
   Accent 1  : #6b46c1 (purple)
   Accent 2  : #ed64a6 (pink-magenta)
   Neutral   : #1a202c (dark bg), #f7fafc (light bg)
   ──────────────────────────────────────────────── */

.gcsez-dashboard {
    background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
    min-height: calc(100vh - 70px);
    margin-top: 70px;
    margin-left: 260px;
    padding: 28px;
    font-family: 'Rubik', sans-serif;
    color: #2d3748;
}

.gcsez-breadcrumb-title {
    color: #1a202c;
    font-size: 1.75rem;
    font-weight: 700;
    background: linear-gradient(90deg, #3182ce, #667eea);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin: 0;
}

.gcsez-breadcrumb-nav a {
    color: #4a5568;
    transition: color 0.2s ease;
}

.gcsez-breadcrumb-nav a:hover {
    color: #3182ce;
}

/* ── Stat Cards ── */
.gcsez-stat-card {
    border: none;
    border-radius: 16px;
    background: white;
    padding: 24px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    position: relative;
    overflow: hidden;
}

.gcsez-stat-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 20px 40px rgba(0,0,0,0.12);
}

.gcsez-stat-card::after {
    content: "";
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--card-color), transparent);
}

.gcsez-stat-card:nth-child(1) { --card-color: #667eea; }  /* indigo */
.gcsez-stat-card:nth-child(2) { --card-color: #48bb78; }  /* green  */
.gcsez-stat-card:nth-child(3) { --card-color: #ed8936; }  /* orange */
.gcsez-stat-card:nth-child(4) { --card-color: #ed64a6; }  /* pink   */

.gcsez-stat-icon {
    width: 64px;
    height: 64px;
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.75rem;
    color: white;
    box-shadow: 0 6px 14px rgba(0,0,0,0.15);
    background: var(--card-color);
    transition: transform 0.3s ease;
}

.gcsez-stat-card:hover .gcsez-stat-icon {
    transform: scale(1.1) rotate(5deg);
}

.gcsez-stat-number {
    font-size: 2.25rem;
    font-weight: 800;
    color: #1a202c;
    background: linear-gradient(90deg, #2d3748, #4a5568);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ── Sections ── */
.gcsez-section {
    background: rgba(255,255,255,0.75);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 28px;
    border: 1px solid rgba(255,255,255,0.3);
    box-shadow: 0 12px 32px rgba(0,0,0,0.08);
    margin-bottom: 32px;
}

.gcsez-section::before {
    content: "";
    position: absolute;
    inset: 0;
    border-radius: 20px;
    background: linear-gradient(135deg, rgba(49,130,206,0.08), rgba(102,126,234,0.05));
    z-index: -1;
}

.gcsez-section-title {
    font-size: 1.5rem;
    font-weight: 700;
    background: linear-gradient(90deg, #3182ce, #667eea);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ── Table Enhancements ── */
.gcsez-table th {
    background: linear-gradient(90deg, #edf2f7, #e2e8f0);
    color: #2d3748;
    font-weight: 600;
}

.gcsez-table tr:hover {
    background: rgba(49,130,206,0.08);
}

/* ── Badges ── */
.gcsez-badge.success  { background: #d4f4e2; color: #2f855a; }
.gcsez-badge.warning  { background: #fefcbf; color: #b7791f; }
.gcsez-badge.danger   { background: #fed7d7; color: #c53030; }
.gcsez-badge.info     { background: #bee3f8; color: #2b6cb0; }
.gcsez-badge.primary  { background: #e9d8fd; color: #6b46c1; }

/* ── Buttons ── */
.gcsez-btn {
    background: linear-gradient(135deg, #3182ce, #667eea);
    border: none;
    color: white;
    padding: 10px 20px;
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.gcsez-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(49,130,206,0.3);
}

.gcsez-btn-outline {
    border: 2px solid #cbd5e0;
    color: #4a5568;
}

.gcsez-btn-outline:hover {
    background: #edf2f7;
    border-color: #a0aec0;
}

/* ── Quick Actions ── */
.gcsez-quick-actions button {
    background: white;
    border: 1px solid #e2e8f0;
    color: #4a5568;
    border-radius: 12px;
    padding: 14px 20px;
    transition: all 0.25s ease;
}

.gcsez-quick-actions button:hover {
    background: linear-gradient(135deg, #667eea22, #ed64a622);
    border-color: #667eea;
    color: #2d3748;
    transform: translateY(-2px);
}

/* Mobile adjustments remain similar */
@media (max-width: 768px) {
    .gcsez-dashboard {
        margin-left: 0;
        padding: 20px;
    }
    .gcsez-stats-grid {
        grid-template-columns: 1fr;
    }
}
/* Avatar + transparent background utilities */
.avatar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 1.25rem;
    width: 3rem;
    height: 3rem;
}

.avatar-lg {
    width: 4rem;
    height: 4rem;
    font-size: 1.75rem;
}

.avatar-rounded {
    border-radius: 0.75rem; /* or 50% for circle */
}

.bg-primary-transparent {
    background-color: rgba(49, 130, 206, 0.12) !important;
    color: #3182ce;
}

.bg-success-transparent {
    background-color: rgba(56, 161, 105, 0.12) !important;
    color: #38a169;
}

.bg-info-transparent {
    background-color: rgba(43, 108, 176, 0.12) !important;
    color: #2b6cb0;
}

.bg-warning-transparent {
    background-color: rgba(221, 107, 32, 0.12) !important;
    color: #dd6b20;
}

.svg-primary { color: #3182ce; }
.svg-success { color: #38a169; }
.svg-info    { color: #2b6cb0; }
.svg-warning { color: #dd6b20; }

/* Card variations for visual separation */
.dashboard-main-card.primary   { border-left: 4px solid #3182ce; }
.dashboard-main-card.success   { border-left: 4px solid #38a169; }
.dashboard-main-card.info      { border-left: 4px solid #2b6cb0; }
.dashboard-main-card.warning   { border-left: 4px solid #dd6b20; }

/* Optional: subtle hover effect */
.custom-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 24px rgba(0,0,0,0.08);
    transition: all 0.25s ease;
}
</style>

<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<main class="gcsez-dashboard">
    <div class="gcsez-breadcrumb">
        <h1 class="gcsez-breadcrumb-title">Dashboard</h1>
        <nav class="gcsez-breadcrumb-nav">
            <a href="javascript:void(0)">Home</a>
            <span>/</span>
            <span>Dashboard</span>
        </nav>
    </div>

    <!-- Statistics Overview -->
    <div class="gcsez-stats-grid">
        <div class="gcsez-stat-card">
            <div class="gcsez-stat-icon lease">
                <i class="fas fa-file-contract"></i>
            </div>
            <div class="gcsez-stat-content">
                <div class="gcsez-stat-number">42</div>
                <div class="gcsez-stat-title">Lease Applications</div>
            </div>
        </div>
        <div class="gcsez-stat-card">
            <div class="gcsez-stat-icon rent">
                <i class="fas fa-money-bill-wave"></i>
            </div>
            <div class="gcsez-stat-content">
                <div class="gcsez-stat-number">GHS 18,540</div>
                <div class="gcsez-stat-title">Ground Rent Collected</div>
            </div>
        </div>
        <div class="gcsez-stat-card">
            <div class="gcsez-stat-icon ecommerce">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <div class="gcsez-stat-content">
                <div class="gcsez-stat-number">GHS 12,847</div>
                <div class="gcsez-stat-title">E-Commerce Sales</div>
            </div>
        </div>
        <div class="gcsez-stat-card">
            <div class="gcsez-stat-icon appointment">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="gcsez-stat-content">
                <div class="gcsez-stat-number">24</div>
                <div class="gcsez-stat-title">Today's Appointments</div>
            </div>
        </div>
    </div>

    <!-- Lease Management Section -->
    <div class="gcsez-section">
        <div class="gcsez-section-header">
            <h2 class="gcsez-section-title">Lease & Application Management</h2>
            <div class="gcsez-section-actions">
                <button class="gcsez-btn">
                    <i class="fas fa-plus-circle"></i> New Application
                </button>
            </div>
        </div>
        
        <div class="gcsez-grid">
            <div>
                <div class="gcsez-table-container">
                    <table class="gcsez-table">
                        <thead>
                            <tr>
                                <th>Applicant</th>
                                <th>Property</th>
                                <th>Submitted</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Robert Johnson</td>
                                <td>Luxury Villa A12</td>
                                <td>Oct 28, 2025</td>
                                <td><span class="gcsez-badge success">Approved</span></td>
                                <td>
                                    <div class="gcsez-btn-group">
                                        <button class="gcsez-btn-outline gcsez-btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Sarah Williams</td>
                                <td>Modern Apartment B34</td>
                                <td>Oct 29, 2025</td>
                                <td><span class="gcsez-badge warning">Pending</span></td>
                                <td>
                                    <div class="gcsez-btn-group">
                                        <button class="gcsez-btn-outline gcsez-btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Michael Brown</td>
                                <td>Commercial Space C56</td>
                                <td>Oct 30, 2025</td>
                                <td><span class="gcsez-badge info">Under Review</span></td>
                                <td>
                                    <div class="gcsez-btn-group">
                                        <button class="gcsez-btn-outline gcsez-btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Jennifer Lee</td>
                                <td>Townhouse D78</td>
                                <td>Oct 31, 2025</td>
                                <td><span class="gcsez-badge danger">Rejected</span></td>
                                <td>
                                    <div class="gcsez-btn-group">
                                        <button class="gcsez-btn-outline gcsez-btn-sm">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="gcsez-pagination">
                    <a href="#" class="gcsez-page-item disabled">Prev</a>
                    <a href="#" class="gcsez-page-item active">1</a>
                    <a href="#" class="gcsez-page-item">2</a>
                    <a href="#" class="gcsez-page-item">3</a>
                    <a href="#" class="gcsez-page-item">Next</a>
                </div>
            </div>
            
            <div class="gcsez-grid" style="gap: 20px;">
                <div class="gcsez-section">
                    <h3 class="gcsez-section-title">Lease Application Status</h3>
                    <div class="gcsez-chart-container">
                        <canvas id="gcsezLeaseStatusChart"></canvas>
                    </div>
                </div>
                
                <div class="gcsez-section">
                    <h3 class="gcsez-section-title">Quick Actions</h3>
                    <div class="gcsez-quick-actions">
                        <button class="gcsez-btn-outline">
                            <i class="fas fa-file-contract"></i> New Lease
                        </button>
                        <button class="gcsez-btn-outline">
                            <i class="fas fa-chart-bar"></i> Generate Report
                        </button>
                        <button class="gcsez-btn-outline">
                            <i class="fas fa-bell"></i> Send Reminders
                        </button>
                        <button class="gcsez-btn-outline">
                            <i class="fas fa-download"></i> Export Data
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Ground Rent Management Section -->
    <div class="gcsez-section">
        <div class="gcsez-section-header">
            <h2 class="gcsez-section-title">Ground Rent Management</h2>
            <div class="gcsez-section-actions">
                <div class="gcsez-search">
                    <i class="fas fa-search gcsez-search-icon"></i>
                    <input type="text" class="gcsez-search-input" placeholder="Search payments...">
                </div>
                <button class="gcsez-btn">
                    <i class="fas fa-plus-circle"></i> Record Payment
                </button>
            </div>
        </div>
        
        <div class="gcsez-grid">
            <div>
                <table class="gcsez-table">
                    <thead>
                        <tr>
                            <th>Property</th>
                            <th>Tenant</th>
                            <th>Due Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Luxury Villa A12</td>
                            <td>Robert Johnson</td>
                            <td>Nov 5, 2025</td>
                            <td>GHS 1,200</td>
                            <td><span class="gcsez-badge success">Paid</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-receipt"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Modern Apartment B34</td>
                            <td>Sarah Williams</td>
                            <td>Nov 10, 2025</td>
                            <td>GHS 850</td>
                            <td><span class="gcsez-badge warning">Pending</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-receipt"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Commercial Space C56</td>
                            <td>Michael Brown</td>
                            <td>Oct 28, 2025</td>
                            <td>GHS 2,500</td>
                            <td><span class="gcsez-badge danger">Overdue</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-receipt"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Townhouse D78</td>
                            <td>Jennifer Lee</td>
                            <td>Nov 15, 2025</td>
                            <td>GHS 950</td>
                            <td><span class="gcsez-badge info">Upcoming</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-receipt"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="gcsez-section">
                <h3 class="gcsez-section-title">Rent Collection Overview</h3>
                <div class="gcsez-chart-container">
                    <canvas id="gcsezRentCollectionChart"></canvas>
                </div>
                <div class="gcsez-stats-overview">
                    <div class="gcsez-stat-mini">
                        <div class="gcsez-stat-mini-value">GHS 18,540</div>
                        <div class="gcsez-stat-mini-label">Collected</div>
                    </div>
                    <div class="gcsez-stat-mini">
                        <div class="gcsez-stat-mini-value">GHS 5,250</div>
                        <div class="gcsez-stat-mini-label">Pending</div>
                    </div>
                    <div class="gcsez-stat-mini">
                        <div class="gcsez-stat-mini-value">GHS 2,500</div>
                        <div class="gcsez-stat-mini-label">Overdue</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- E-Commerce Section -->
    <div class="gcsez-section">
        <div class="gcsez-section-header">
            <h2 class="gcsez-section-title">Building Materials E-Commerce</h2>
            <div class="gcsez-section-actions">
                <div class="gcsez-search">
                    <i class="fas fa-search gcsez-search-icon"></i>
                    <input type="text" class="gcsez-search-input" placeholder="Search orders...">
                </div>
                <button class="gcsez-btn">
                    <i class="fas fa-plus-circle"></i> New Order
                </button>
            </div>
        </div>
        
        <div class="gcsez-grid">
            <div>
                <table class="gcsez-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Products</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#ORD-7842</td>
                            <td>Construction Co.</td>
                            <td>Cement, Tiles, Pipes</td>
                            <td>GHS 2,450</td>
                            <td><span class="gcsez-badge success">Delivered</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7841</td>
                            <td>John's Renovation</td>
                            <td>Paint, Brushes, Tools</td>
                            <td>GHS 850</td>
                            <td><span class="gcsez-badge warning">Processing</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7840</td>
                            <td>City Builders</td>
                            <td>Steel Beams, Nails, Wood</td>
                            <td>GHS 5,420</td>
                            <td><span class="gcsez-badge info">Shipped</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-7839</td>
                            <td>Home Solutions</td>
                            <td>Doors, Windows, Hardware</td>
                            <td>GHS 3,870</td>
                            <td><span class="gcsez-badge primary">Pending</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="gcsez-grid" style="gap: 20px;">
                <div class="gcsez-section">
                    <h3 class="gcsez-section-title">Sales Overview</h3>
                    <div class="gcsez-chart-container">
                        <canvas id="gcsezSalesChart"></canvas>
                    </div>
                    <div class="gcsez-stats-overview">
                        <div class="gcsez-stat-mini">
                            <div class="gcsez-stat-mini-value">GHS 12,847</div>
                            <div class="gcsez-stat-mini-label">Today's Sales</div>
                        </div>
                        <div class="gcsez-stat-mini">
                            <div class="gcsez-stat-mini-value">GHS 84,321</div>
                            <div class="gcsez-stat-mini-label">Monthly Sales</div>
                        </div>
                        <div class="gcsez-stat-mini">
                            <div class="gcsez-stat-mini-value">247</div>
                            <div class="gcsez-stat-mini-label">Orders</div>
                        </div>
                    </div>
                </div>
                
                <div class="gcsez-section">
                    <h3 class="gcsez-section-title">Top Selling Products</h3>
                    <div class="gcsez-product-list">
                        <div class="gcsez-product-item">
                            <div class="gcsez-product-info">
                                <div class="gcsez-product-icon text-primary">
                                    <i class="fas fa-fill-drip"></i>
                                </div>
                                Premium Paint
                            </div>
                            <div class="gcsez-product-stats">
                                <span class="text-muted">142 units</span>
                                <span class="gcsez-badge success">+12%</span>
                            </div>
                        </div>
                        <div class="gcsez-product-item">
                            <div class="gcsez-product-info">
                                <div class="gcsez-product-icon text-warning">
                                    <i class="fas fa-th-large"></i>
                                </div>
                                Ceramic Tiles
                            </div>
                            <div class="gcsez-product-stats">
                                <span class="text-muted">98 units</span>
                                <span class="gcsez-badge warning">+8%</span>
                            </div>
                        </div>
                        <div class="gcsez-product-item">
                            <div class="gcsez-product-info">
                                <div class="gcsez-product-icon text-success">
                                    <i class="fas fa-tools"></i>
                                </div>
                                Tool Kit
                            </div>
                            <div class="gcsez-product-stats">
                                <span class="text-muted">76 units</span>
                                <span class="gcsez-badge success">+15%</span>
                            </div>
                        </div>
                        <div class="gcsez-product-item">
                            <div class="gcsez-product-info">
                                <div class="gcsez-product-icon text-danger">
                                    <i class="fas fa-bolt"></i>
                                </div>
                                Power Tools
                            </div>
                            <div class="gcsez-product-stats">
                                <span class="text-muted">63 units</span>
                                <span class="gcsez-badge danger">+5%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Appointments Section -->
    <div class="gcsez-section">
        <div class="gcsez-section-header">
            <h2 class="gcsez-section-title">Appointment Management</h2>
            <div class="gcsez-section-actions">
                <div class="gcsez-search">
                    <i class="fas fa-search gcsez-search-icon"></i>
                    <input type="text" class="gcsez-search-input" placeholder="Search appointments...">
                </div>
                <button class="gcsez-btn">
                    <i class="fas fa-plus-circle"></i> New Appointment
                </button>
            </div>
        </div>
        
        <div class="gcsez-grid">
            <div>
                <table class="gcsez-table">
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Client</th>
                            <th>Property</th>
                            <th>Agent</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>10:00 AM</td>
                            <td>Robert Johnson</td>
                            <td>Luxury Villa A12</td>
                            <td>John Smith</td>
                            <td>Viewing</td>
                            <td><span class="gcsez-badge success">Confirmed</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>11:30 AM</td>
                            <td>Sarah Williams</td>
                            <td>Modern Apartment B34</td>
                            <td>Emma Johnson</td>
                            <td>Consultation</td>
                            <td><span class="gcsez-badge warning">Pending</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>2:15 PM</td>
                            <td>Michael Brown</td>
                            <td>Commercial Space C56</td>
                            <td>Michael Brown</td>
                            <td>Viewing</td>
                            <td><span class="gcsez-badge success">Confirmed</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>3:45 PM</td>
                            <td>Jennifer Lee</td>
                            <td>Townhouse D78</td>
                            <td>John Smith</td>
                            <td>Consultation</td>
                            <td><span class="gcsez-badge danger">Cancelled</span></td>
                            <td>
                                <div class="gcsez-btn-group">
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="gcsez-btn-outline gcsez-btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <div class="gcsez-section">
                <h3 class="gcsez-section-title">Today's Schedule</h3>
                <div class="gcsez-appointment-list">
                    <div class="gcsez-appointment-item">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">10:00 AM - Property Viewing</h6>
                            <span class="gcsez-badge success">Confirmed</span>
                        </div>
                        <p class="mb-1">Robert Johnson - Luxury Villa A12</p>
                        <small class="text-muted">Agent: John Smith</small>
                    </div>
                    <div class="gcsez-appointment-item">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">11:30 AM - Consultation</h6>
                            <span class="gcsez-badge warning">Pending</span>
                        </div>
                        <p class="mb-1">Sarah Williams - Modern Apartment B34</p>
                        <small class="text-muted">Agent: Emma Johnson</small>
                    </div>
                    <div class="gcsez-appointment-item completed">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">9:00 AM - Property Viewing</h6>
                            <span class="gcsez-badge info">Completed</span>
                        </div>
                        <p class="mb-1">James Anderson - Family Home F12</p>
                        <small class="text-muted">Agent: Michael Brown</small>
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