<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.gcsez-dashboard {
    background: #f8fafc;
    min-height: calc(100vh - 70px);
    margin-top: 70px;
    margin-left: 260px;
    padding: 24px;
    font-family: 'Rubik', sans-serif;
}

.gcsez-breadcrumb {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 24px;
}

.gcsez-breadcrumb-title {
    color: #111827;
    font-size: 1.5rem;
    font-weight: 600;
    margin: 0;
}

.gcsez-breadcrumb-nav {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.875rem;
    color: #6b7280;
}

.gcsez-breadcrumb-nav a {
    color: #6b7280;
    text-decoration: none;
}

.gcsez-breadcrumb-nav a:hover {
    color: #326573;
}

.gcsez-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 32px;
}

.gcsez-stat-card {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 24px;
    display: flex;
    align-items: center;
    gap: 16px;
    transition: all 0.2s ease;
}

.gcsez-stat-card:hover {
    border-color: #326573;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.gcsez-stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    color: white;
}

.gcsez-stat-icon.lease { background: #326573; }
.gcsez-stat-icon.rent { background: #57a394; }
.gcsez-stat-icon.ecommerce { background: #c5bb85; }
.gcsez-stat-icon.appointment { background: #b48478; }

.gcsez-stat-content {
    flex: 1;
}

.gcsez-stat-number {
    font-size: 1.75rem;
    font-weight: 600;
    color: #111827;
    margin: 0;
    line-height: 1.2;
}

.gcsez-stat-title {
    font-size: 0.875rem;
    color: #6b7280;
    margin: 4px 0 0 0;
}

.gcsez-section {
    background: #ffffff;
    border: 1px solid #e5e7eb;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 24px;
}

.gcsez-section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
}

.gcsez-section-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #111827;
    margin: 0;
}

.gcsez-section-actions {
    display: flex;
    align-items: center;
    gap: 12px;
}

.gcsez-btn {
    background: #326573;
    color: white;
    border: none;
    border-radius: 8px;
    padding: 8px 16px;
    font-size: 0.875rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    gap: 6px;
}

.gcsez-btn:hover {
    background: #2a5561;
    transform: translateY(-1px);
}

.gcsez-btn-outline {
    background: transparent;
    border: 1px solid #d1d5db;
    color: #374151;
}

.gcsez-btn-outline:hover {
    background: #f9fafb;
    border-color: #9ca3af;
}

.gcsez-search {
    position: relative;
    width: 200px;
}

.gcsez-search-input {
    width: 100%;
    padding: 8px 12px 8px 36px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 0.875rem;
    background: #f9fafb;
}

.gcsez-search-icon {
    position: absolute;
    left: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: #6b7280;
}

.gcsez-table {
    width: 100%;
    border-collapse: collapse;
}

.gcsez-table th {
    background: #f9fafb;
    padding: 12px 16px;
    text-align: left;
    font-size: 0.875rem;
    font-weight: 600;
    color: #374151;
    border-bottom: 1px solid #e5e7eb;
}

.gcsez-table td {
    padding: 12px 16px;
    border-bottom: 1px solid #f3f4f6;
    font-size: 0.875rem;
    color: #6b7280;
}

.gcsez-table tr:hover {
    background: #f9fafb;
}

.gcsez-badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 0.75rem;
    font-weight: 500;
}

.gcsez-badge.success { background: #d1fae5; color: #065f46; }
.gcsez-badge.warning { background: #fef3c7; color: #92400e; }
.gcsez-badge.info { background: #dbeafe; color: #1e40af; }
.gcsez-badge.danger { background: #fee2e2; color: #991b1b; }
.gcsez-badge.primary { background: #e0e7ff; color: #3730a3; }

.gcsez-btn-group {
    display: flex;
    gap: 4px;
}

.gcsez-btn-sm {
    padding: 6px 10px;
    font-size: 0.75rem;
}

.gcsez-chart-container {
    height: 300px;
    position: relative;
}

.gcsez-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}

.gcsez-quick-actions {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
}

.gcsez-appointment-item {
    padding: 16px 0;
    border-bottom: 1px solid #f3f4f6;
}

.gcsez-appointment-item:last-child {
    border-bottom: none;
}

.gcsez-appointment-item.completed {
    opacity: 0.7;
}

.gcsez-stats-overview {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-top: 16px;
}

.gcsez-stat-mini {
    text-align: center;
    padding: 12px;
    background: #f9fafb;
    border-radius: 8px;
}

.gcsez-stat-mini-value {
    font-size: 1.125rem;
    font-weight: 600;
    color: #111827;
    margin: 0;
}

.gcsez-stat-mini-label {
    font-size: 0.75rem;
    color: #6b7280;
    margin: 4px 0 0 0;
}

.gcsez-product-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #f3f4f6;
}

.gcsez-product-item:last-child {
    border-bottom: none;
}

.gcsez-product-info {
    display: flex;
    align-items: center;
    gap: 8px;
}

.gcsez-product-icon {
    width: 20px;
    text-align: center;
}

.gcsez-product-stats {
    display: flex;
    align-items: center;
    gap: 8px;
}

.gcsez-pagination {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    margin-top: 20px;
}

.gcsez-page-item {
    padding: 8px 12px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 0.875rem;
    color: #374151;
    text-decoration: none;
    transition: all 0.2s ease;
}

.gcsez-page-item:hover {
    background: #f3f4f6;
}

.gcsez-page-item.active {
    background: #326573;
    color: white;
    border-color: #326573;
}

.gcsez-page-item.disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

/* Mobile responsiveness */
@media (max-width: 768px) {
    .gcsez-dashboard {
        margin-left: 0;
        padding: 16px;
    }
    
    .gcsez-breadcrumb {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }
    
    .gcsez-stats-grid {
        grid-template-columns: 1fr;
    }
    
    .gcsez-section-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }
    
    .gcsez-section-actions {
        width: 100%;
        justify-content: space-between;
    }
    
    .gcsez-search {
        width: 100%;
    }
    
    .gcsez-quick-actions {
        grid-template-columns: 1fr;
    }
    
    .gcsez-stats-overview {
        grid-template-columns: 1fr;
    }
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