# Regional PVLMD Transaction Management System

## Overview
This system provides a complete workflow for managing regional PVLMD transactions with three main components:
1. **Data Capture** - For initial transaction entry
2. **Quality Control** - For reviewing and approving captured data
3. **Transaction Search** - For searching approved transactions

## Files Created

### 1. JSP Templates

#### a. `regional_transaction_data_capture.jsp`
**Location:** `/src/main/webapp/WEB-INF/jsp/pages/pvlmd_maps_templates/regional_transaction_data_capture.jsp`

**Purpose:** Main data capture interface for entering new PVLMD transactions

**Features:**
- Modern Bootstrap 5 design with responsive layout
- Advanced search functionality with multiple filter criteria
- DataTables integration for displaying transaction lists
- Comprehensive modal form for adding/editing transactions
- Form sections organized by category:
  - Basic Information (Jacket Name, Region, Reference Number, etc.)
  - Document Details (Mutation Number, Deed Number, Plan Number, etc.)
  - Parties Information (Party 1 & Party 2 details with contact info)
  - Financial Details (Consideration, Premium, Rent, Currency selection)
  - Additional Details (Term, Dates, Remarks, etc.)
- Export functionality (Excel, PDF)
- Real-time validation
- Action buttons for View, Edit, Delete operations

#### b. `quality_control_for_regional_transaction_data_capture.jsp`
**Location:** `/src/main/webapp/WEB-INF/jsp/pages/pvlmd_maps_templates/quality_control_for_regional_transaction_data_capture.jsp`

**Purpose:** Quality control interface for reviewing, approving, or rejecting transactions

**Features:**
- Statistics dashboard showing pending, under review, approved, and rejected counts
- Filter options for finding transactions requiring QC
- Comprehensive review modal with:
  - Transaction details display
  - Quality control checklist (9 checkpoints)
  - Review notes section
  - Approval/Decline functionality
- Batch approval capability for processing multiple transactions
- Quick approve option for trusted entries
- Status tracking (Pending → Under Review → Approved/Rejected)
- Export functionality for QC reports

#### c. `regional_transaction_search.jsp`
**Location:** `/src/main/webapp/WEB-INF/jsp/pages/pvlmd_maps_templates/regional_transaction_search.jsp`

**Purpose:** Advanced search interface for finding and viewing approved transactions

**Features:**
- Advanced search form with 14+ filter criteria
- Statistics cards showing various metrics
- Multi-select capability for batch operations
- Comprehensive result table with sortable columns
- Detailed view modal showing all transaction information
- Compare transactions feature (compare 2-3 transactions side-by-side)
- Multiple export formats (Excel, PDF, CSV)
- Print functionality
- Pagination with custom controls
- Checkbox selection for bulk actions

### 2. JavaScript Files

#### a. `regional_transaction_data_capture.js`
**Location:** `/src/main/webapp/js-pages/regional_transaction_data_capture.js`

**Key Functions:**
- `initializeDataTable()` - Sets up the main transaction table
- `openAddModal()` / `openEditModal()` - Modal management
- `saveTransaction()` - Handles create/update operations
- `validateForm()` - Client-side validation
- `viewTransaction()` - Display transaction details
- `deleteTransaction()` - Soft delete with confirmation
- `exportToExcel()` / `exportToPDF()` - Export functionality
- Event binding for all interactive elements

**API Endpoints Expected:**
- `POST /api/regional/transactions/list` - Get transaction list
- `GET /api/regional/transactions/get/{id}` - Get single transaction
- `POST /api/regional/transactions/create` - Create new transaction
- `POST /api/regional/transactions/update` - Update existing transaction
- `POST /api/regional/transactions/delete/{id}` - Delete transaction
- `GET /api/regional/transactions/export/excel` - Export to Excel
- `GET /api/regional/transactions/export/pdf` - Export to PDF

#### b. `quality_control_for_regional_transaction_data_capture.js`
**Location:** `/src/main/webapp/js-pages/quality_control_for_regional_transaction_data_capture.js`

**Key Functions:**
- `loadStatistics()` - Load QC statistics dashboard
- `openReviewModal()` - Open detailed review interface
- `markTransactionUnderReview()` - Change status to under review
- `approveTransaction()` - Approve with validation
- `declineTransaction()` - Reject with required reason
- `confirmBatchApproval()` - Process multiple approvals
- `quickApproveTransaction()` - Fast-track approval
- Checklist validation (minimum 5 items must be checked)

**API Endpoints Expected:**
- `POST /api/regional/transactions/qc/list` - Get QC pending transactions
- `GET /api/regional/transactions/qc/statistics` - Get QC statistics
- `POST /api/regional/transactions/qc/mark-under-review` - Mark as under review
- `POST /api/regional/transactions/qc/approve` - Approve transaction
- `POST /api/regional/transactions/qc/decline` - Decline transaction
- `POST /api/regional/transactions/qc/batch-approve` - Batch approve
- `GET /api/regional/transactions/qc/export` - Export QC data

#### c. `regional_transaction_search.js`
**Location:** `/src/main/webapp/js-pages/regional_transaction_search.js`

**Key Functions:**
- `performSearch()` - Execute advanced search
- `loadStatistics()` - Update search statistics
- `viewTransactionDetails()` - Show comprehensive details
- `compareTransactions()` - Side-by-side comparison
- `updateSelectedTransactions()` - Track selected items
- `exportResults()` - Export in various formats
- `printTransaction()` - Print individual transaction
- Multi-select checkbox management

**API Endpoints Expected:**
- `POST /api/regional/transactions/search` - Advanced search
- `POST /api/regional/transactions/search/statistics` - Search statistics
- `GET /api/regional/transactions/get/{id}` - Get transaction details
- `GET /api/regional/transactions/export?format={excel|pdf|csv}` - Export results

## Database Schema Integration

All three pages work with the `csau_geospatial.regional_pvlmd_transactions_all` table structure you provided. Key fields utilized:

### Primary Fields
- `t_id` - Primary key
- `reference_number` - Unique transaction reference
- `jacket_name` - Transaction jacket identifier
- `region` - Regional classification
- `status` - Workflow status (pending, approved, rejected, under_review)
- `approved_under_qc` - Boolean flag for QC approval

### Document Fields
- `file_number`, `property_number`, `mutation_number`, `deed_number`
- `plan_number`, `plot_number`, `sheet_number`, `serial_number`
- `instrument_type`, `instrument_date`, `consent_date`

### Party Information
- `party1_plaintiff`, `party1_plaintiff_tel_no`, `party1_plaintiff_email`, `party1_plantiff_add`
- `party2_defendant`, `party2_defendant_tel_no`, `party2_defendant_email`, `party2_defendant_add`

### Financial Fields
- `consideration`, `consideration_currency`
- `premium`, `premium_currency`
- `rent`, `compensation_status`

### Audit Fields
- `created_by`, `created_by_id`, `created_date`
- `modified_by`, `modified_by_id`, `modified_date`
- `entered_by`, `checked_by`, `reviewed_by`, `declined_by`
- `approve_note`, `review_note`, `decline_note`

## Design Features

### Bootstrap 5 Components Used
- Cards with headers and bodies
- Modals (XL and XXL sizes)
- Forms with floating labels
- Buttons with icons (Remix Icon library)
- Tables with responsive design
- Badges for status indicators
- Alerts for notifications
- Grid system (col-xl, col-lg, col-md)
- Dropdown menus
- Checkboxes and selects

### UI/UX Enhancements
- Responsive design for all screen sizes
- Color-coded status badges
- Icon-based action buttons
- Toast notifications using SweetAlert2
- Loading spinners for async operations
- Confirmation dialogs for destructive actions
- Collapsible filter sections
- Statistics dashboards
- Export options in multiple formats

### JavaScript Features
- IIFE pattern for encapsulation
- AJAX for all server communication
- DataTables for advanced table features
- Form validation before submission
- Dynamic content loading
- Event delegation for dynamic elements
- Promise-based async operations
- Error handling with user feedback

## Implementation Notes

### Backend Requirements
You'll need to create REST API endpoints to support the frontend functionality. The expected endpoints are documented in each JavaScript file.

### Security Considerations
- Implement CSRF protection
- Add authentication checks on all endpoints
- Validate all input server-side
- Use parameterized queries to prevent SQL injection
- Implement role-based access control

### Performance Optimizations
- Server-side pagination implemented
- Lazy loading of transaction details
- Cached statistics where appropriate
- Debounced search inputs (can be added)
- Indexed database queries on frequently searched fields

### Future Enhancements
- Save/favorite search criteria
- Email notifications for status changes
- Bulk edit functionality
- Advanced reporting dashboard
- Transaction history timeline
- Attachment upload support
- Digital signature integration
- Workflow automation rules

## Testing Checklist

### Data Capture Page
- [ ] Create new transaction with all fields
- [ ] Edit existing transaction
- [ ] Delete transaction with confirmation
- [ ] Search by various criteria
- [ ] Export to Excel/PDF
- [ ] Form validation works correctly
- [ ] Required fields enforced

### Quality Control Page
- [ ] View pending transactions
- [ ] Open review modal
- [ ] Complete checklist items
- [ ] Approve transaction
- [ ] Decline transaction with reason
- [ ] Mark as under review
- [ ] Batch approve multiple transactions
- [ ] Statistics update correctly

### Search Page
- [ ] Advanced search with multiple filters
- [ ] View transaction details
- [ ] Compare 2-3 transactions
- [ ] Select multiple records
- [ ] Export in different formats
- [ ] Print transaction details
- [ ] Reset search criteria
- [ ] Statistics display correctly

## Browser Compatibility
- Chrome/Edge (latest 2 versions)
- Firefox (latest 2 versions)
- Safari (latest 2 versions)
- Mobile browsers (responsive design)

## Dependencies
The system uses existing project dependencies:
- Bootstrap 5 (already included in project)
- jQuery (already included in project)
- DataTables (already included in project)
- SweetAlert2 (already included in project)
- Remix Icons (already included in project)

No additional dependencies are required.
