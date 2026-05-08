# Regional PVLMD Transaction API Services Documentation

This document outlines all the API service endpoints needed for the Regional PVLMD Transaction Management System. All endpoints follow the same pattern as existing ELIS ERP servlets.

## Service Architecture Pattern

All services should be implemented as Java Servlets following this pattern:
- **URL**: Servlet name (e.g., `Case_Management_Serv`)
- **Method**: POST
- **Parameter**: `request_type` determines the action
- **Response**: JSON format

---

## 1. Case_Management_Serv

**Purpose**: Main transaction CRUD operations

### 1.1 Get Regional Transactions List

**Request:**
```javascript
{
    request_type: 'get_regional_transactions_list',
    search_reference: '',      // optional
    search_file: '',           // optional
    search_jacket: '',         // optional
    search_status: ''          // optional: pending, approved, rejected
}
```

**Response:**
```json
{
    "draw": 1,
    "recordsTotal": 100,
    "recordsFiltered": 50,
    "data": [
        {
            "t_id": 1,
            "reference_number": "REF-2024-001",
            "jacket_name": "Jacket A",
            "file_number": "FILE-001",
            "instrument_type": "Lease",
            "instrument_date": "2024-01-15",
            "party1_plaintiff": "John Doe",
            "party2_defendant": "Jane Smith",
            "status": "approved",
            "created_date": "2024-01-10 10:30:00"
        }
    ]
}
```

**SQL Query:**
```sql
SELECT 
    t_id, reference_number, jacket_name, file_number, 
    instrument_type, instrument_date, party1_plaintiff, 
    party2_defendant, status, created_date
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE deleted = false OR deleted IS NULL
AND (:search_reference = '' OR reference_number ILIKE '%' || :search_reference || '%')
AND (:search_file = '' OR file_number ILIKE '%' || :search_file || '%')
AND (:search_jacket = '' OR jacket_name ILIKE '%' || :search_jacket || '%')
AND (:search_status = '' OR status = :search_status)
ORDER BY t_id DESC
LIMIT :limit OFFSET :offset;
```

---

### 1.2 Get Regional Transaction By ID

**Request:**
```javascript
{
    request_type: 'get_regional_transaction_by_id',
    t_id: 123
}
```

**Response:**
```json
{
    "success": true,
    "data": {
        "t_id": 123,
        "jacket_name": "Jacket A",
        "region": "Greater Accra",
        "reference_number": "REF-2024-001",
        "file_number": "FILE-001",
        "property_number": "PROP-001",
        "submission_date": "2024-01-10",
        "mutation_number": "MUT-001",
        "deed_number": "DEED-001",
        "serial_number": "SER-001",
        "sheet_number": "SHEET-001",
        "plan_number": "PLAN-001",
        "plot_number": "PLOT-001",
        "lvb_number": "LVB-001",
        "instrument_date": "2024-01-15",
        "instrument_type": "Lease",
        "doc_number": "DOC-001",
        "party1_plaintiff": "John Doe",
        "party1_plaintiff_tel_no": "0244123456",
        "party1_plaintiff_email": "john@example.com",
        "party1_plantiff_add": "123 Main St, Accra",
        "party2_defendant": "Jane Smith",
        "party2_defendant_tel_no": "0201234567",
        "party2_defendant_email": "jane@example.com",
        "party2_defendant_add": "456 Oak Ave, Kumasi",
        "consideration": "50000.00",
        "consideration_currency": "GHS",
        "premium": "5000.00",
        "premium_currency": "GHS",
        "rent": "1000.00",
        "compensation_status": "Paid",
        "term": "99 years",
        "commencement_date": "2024-02-01",
        "purpose": "Residential",
        "entered_date": "2024-01-10",
        "consent_date": "2024-01-20",
        "suit_number": "",
        "judgement_in_favour_of": "",
        "floor_level": "",
        "apartment_number": "",
        "unit_description": "",
        "hqfile_id": "",
        "gid_unique_across": "",
        "remarks": "Test transaction",
        "status": "approved",
        "approved_under_qc": true,
        "created_by": "Admin User",
        "created_by_id": "admin001",
        "created_date": "2024-01-10 10:30:00"
    }
}
```

**SQL Query:**
```sql
SELECT * FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE t_id = :t_id
AND (deleted = false OR deleted IS NULL);
```

---

### 1.3 Create Regional Transaction

**Request:**
```javascript
{
    request_type: 'create_regional_transaction',
    jacket_name: 'Jacket A',
    region: 'Greater Accra',
    reference_number: 'REF-2024-001',
    file_number: 'FILE-001',
    // ... all other fields from the form
    entered_by: 'Current User Name',
    entered_by_id: 'user001'
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction created successfully",
    "t_id": 123
}
```

**Implementation Notes:**
- Validate required fields: jacket_name, region, reference_number, instrument_type
- Set default status to 'pending'
- Set approved_under_qc to false
- Set created_date to NOW()
- Set deleted to false
- Get current user from session for entered_by, entered_by_id, created_by, created_by_id

**SQL Query:**
```sql
INSERT INTO csau_geospatial.regional_pvlmd_transactions_all (
    jacket_name, region, reference_number, file_number, property_number,
    submission_date, mutation_number, deed_number, serial_number, sheet_number,
    plan_number, plot_number, lvb_number, instrument_date, instrument_type,
    doc_number, party1_plaintiff, party1_plaintiff_tel_no, party1_plaintiff_email,
    party2_defendant, party2_defendant_tel_no, party2_defendant_email,
    consideration, consideration_currency, premium, premium_currency, rent,
    compensation_status, term, commencement_date, purpose, entered_date,
    consent_date, suit_number, judgement_in_favour_of, floor_level,
    apartment_number, unit_description, hqfile_id, gid_unique_across, remarks,
    status, approved_under_qc, entered_by, entered_by_id,
    created_by, created_by_id, created_date, deleted
) VALUES (
    :jacket_name, :region, :reference_number, :file_number, :property_number,
    :submission_date, :mutation_number, :deed_number, :serial_number, :sheet_number,
    :plan_number, :plot_number, :lvb_number, :instrument_date, :instrument_type,
    :doc_number, :party1_plaintiff, :party1_plaintiff_tel_no, :party1_plaintiff_email,
    :party2_defendant, :party2_defendant_tel_no, :party2_defendant_email,
    :consideration, :consideration_currency, :premium, :premium_currency, :rent,
    :compensation_status, :term, :commencement_date, :purpose, :entered_date,
    :consent_date, :suit_number, :judgement_in_favour_of, :floor_level,
    :apartment_number, :unit_description, :hqfile_id, :gid_unique_across, :remarks,
    'pending', false, :entered_by, :entered_by_id,
    :created_by, :created_by_id, NOW(), false
) RETURNING t_id;
```

---

### 1.4 Update Regional Transaction

**Request:**
```javascript
{
    request_type: 'update_regional_transaction',
    t_id: 123,
    jacket_name: 'Jacket A Updated',
    // ... all other fields
    modified_by: 'Current User Name',
    modified_by_id: 'user001'
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction updated successfully"
}
```

**Implementation Notes:**
- Check if transaction exists and is not deleted
- Update modified_date to NOW()
- Get current user from session for modified_by, modified_by_id

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    jacket_name = :jacket_name,
    region = :region,
    reference_number = :reference_number,
    -- ... update all other fields
    modified_by = :modified_by,
    modified_by_id = :modified_by_id,
    modified_date = NOW()
WHERE t_id = :t_id
AND (deleted = false OR deleted IS NULL);
```

---

### 1.5 Delete Regional Transaction

**Request:**
```javascript
{
    request_type: 'delete_regional_transaction',
    t_id: 123
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction deleted successfully"
}
```

**Implementation Notes:**
- Soft delete by setting deleted = true
- Optionally store delete_requested_by, delete_note

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    deleted = true,
    deleted_requested_by_id = :user_id,
    deleted_requested_by = :user_name,
    modified_date = NOW()
WHERE t_id = :t_id;
```

---

### 1.6 Export Regional Transactions (Excel)

**Request:**
```
GET Case_Management_Serv?request_type=export_regional_transactions_excel&search_reference=&search_file=&search_jacket=&search_status=
```

**Implementation Notes:**
- Use Apache POI library to generate Excel file
- Apply same filters as list endpoint
- Set response content type: `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`
- Set header: `Content-Disposition: attachment; filename="regional_transactions.xlsx"`

---

### 1.7 Export Regional Transactions (PDF)

**Request:**
```
GET Case_Management_Serv?request_type=export_regional_transactions_pdf&search_reference=&search_file=&search_jacket=&search_status=
```

**Implementation Notes:**
- Use iText library (already in project) to generate PDF
- Apply same filters as list endpoint
- Set response content type: `application/pdf`
- Set header: `Content-Disposition: attachment; filename="regional_transactions.pdf"`

---

## 2. Case_Management_Serv

**Purpose**: Quality Control workflow operations

### 2.1 Get QC Pending Transactions

**Request:**
```javascript
{
    request_type: 'get_qc_pending_transactions',
    search_reference: '',      // optional
    search_status: '',         // optional: pending, under_review
    date_from: '',             // optional: YYYY-MM-DD
    date_to: ''                // optional: YYYY-MM-DD
}
```

**Response:**
```json
{
    "draw": 1,
    "recordsTotal": 50,
    "recordsFiltered": 30,
    "data": [
        {
            "t_id": 123,
            "reference_number": "REF-2024-001",
            "jacket_name": "Jacket A",
            "instrument_type": "Lease",
            "party1_plaintiff": "John Doe",
            "party2_defendant": "Jane Smith",
            "entered_by": "Data Entry User",
            "created_date": "2024-01-10 10:30:00",
            "status": "pending",
            "approved_under_qc": false
        }
    ]
}
```

**SQL Query:**
```sql
SELECT 
    t_id, reference_number, jacket_name, instrument_type,
    party1_plaintiff, party2_defendant, entered_by,
    created_date, status, approved_under_qc
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE (deleted = false OR deleted IS NULL)
AND approved_under_qc = false
AND status IN ('pending', 'under_review')
AND (:search_reference = '' OR reference_number ILIKE '%' || :search_reference || '%')
AND (:search_status = '' OR status = :search_status)
AND (:date_from = '' OR created_date >= :date_from::timestamp)
AND (:date_to = '' OR created_date <= :date_to::timestamp + interval '1 day')
ORDER BY t_id DESC
LIMIT :limit OFFSET :offset;
```

---

### 2.2 Get QC Statistics

**Request:**
```javascript
{
    request_type: 'get_qc_statistics',
    search_reference: '',
    search_status: '',
    date_from: '',
    date_to: ''
}
```

**Response:**
```json
{
    "success": true,
    "data": {
        "pending": 25,
        "under_review": 10,
        "approved_today": 5,
        "rejected_today": 2
    }
}
```

**SQL Queries:**
```sql
-- Pending count
SELECT COUNT(*) as pending
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'pending'
AND approved_under_qc = false
AND (deleted = false OR deleted IS NULL);

-- Under review count
SELECT COUNT(*) as under_review
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'under_review'
AND approved_under_qc = false
AND (deleted = false OR deleted IS NULL);

-- Approved today
SELECT COUNT(*) as approved_today
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE approved_under_qc = true
AND DATE(checked_by_date) = CURRENT_DATE
AND (deleted = false OR deleted IS NULL);

-- Rejected today
SELECT COUNT(*) as rejected_today
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'rejected'
AND DATE(modified_date) = CURRENT_DATE
AND (deleted = false OR deleted IS NULL);
```

---

### 2.3 Mark Transaction Under Review

**Request:**
```javascript
{
    request_type: 'mark_transaction_under_review',
    t_id: 123,
    review_note: 'Starting review process'
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction marked as under review"
}
```

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    status = 'under_review',
    review_note = :review_note,
    reviewed_by = :user_name,
    reviewed_by_id = :user_id,
    modified_date = NOW()
WHERE t_id = :t_id
AND (deleted = false OR deleted IS NULL);
```

---

### 2.4 Approve Transaction QC

**Request:**
```javascript
{
    request_type: 'approve_transaction_qc',
    t_id: 123,
    approve_note: 'All details verified and correct',
    review_note: 'Comprehensive review completed'
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction approved successfully"
}
```

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    status = 'approved',
    approved_under_qc = true,
    approve_note = :approve_note,
    review_note = :review_note,
    checked_by = :user_name,
    checked_by_id = :user_id,
    checked_by_date = NOW(),
    modified_date = NOW()
WHERE t_id = :t_id
AND (deleted = false OR deleted IS NULL);
```

---

### 2.5 Decline Transaction QC

**Request:**
```javascript
{
    request_type: 'decline_transaction_qc',
    t_id: 123,
    decline_note: 'Missing required documentation',
    review_note: 'Reviewed but incomplete'
}
```

**Response:**
```json
{
    "success": true,
    "message": "Transaction declined"
}
```

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    status = 'rejected',
    decline_note = :decline_note,
    review_note = :review_note,
    declined_by = :user_name,
    declined_by_id = :user_id,
    modified_date = NOW()
WHERE t_id = :t_id
AND (deleted = false OR deleted IS NULL);
```

---

### 2.6 Batch Approve QC

**Request:**
```javascript
{
    request_type: 'batch_approve_qc',
    transaction_ids: '[123, 124, 125]',  // JSON array string
    batch_note: 'Batch approval for January submissions'
}
```

**Response:**
```json
{
    "success": true,
    "message": "3 transactions approved successfully",
    "count": 3
}
```

**Implementation Notes:**
- Parse transaction_ids JSON array
- Loop through IDs and update each one
- Use transaction for atomicity

**SQL Query:**
```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET
    status = 'approved',
    approved_under_qc = true,
    approve_note = :batch_note,
    checked_by = :user_name,
    checked_by_id = :user_id,
    checked_by_date = NOW(),
    modified_date = NOW()
WHERE t_id IN (:transaction_ids)
AND (deleted = false OR deleted IS NULL);
```

---

### 2.7 Export QC Data

**Request:**
```
GET Case_Management_Serv?request_type=export_qc_data&search_reference=&search_status=&date_from=&date_to=
```

**Implementation Notes:**
- Generate Excel file with QC-specific columns
- Include approval/rejection notes
- Include reviewer information

---

## 3. RegionalTransactionSearchServ

**Purpose**: Advanced search and reporting

### 3.1 Search Regional Transactions

**Request:**
```javascript
{
    request_type: 'search_regional_transactions',
    reference_number: '',
    file_number: '',
    jacket_name: '',
    plan_number: '',
    party1: '',
    party2: '',
    instrument_type: '',
    region: '',
    date_from: '',
    date_to: '',
    status: '',
    qc_status: ''       // 'true' or 'false'
}
```

**Response:**
```json
{
    "draw": 1,
    "recordsTotal": 500,
    "recordsFiltered": 100,
    "data": [
        {
            "t_id": 123,
            "reference_number": "REF-2024-001",
            "jacket_name": "Jacket A",
            "file_number": "FILE-001",
            "instrument_type": "Lease",
            "instrument_date": "2024-01-15",
            "party1_plaintiff": "John Doe",
            "party2_defendant": "Jane Smith",
            "consideration": "50000.00",
            "consideration_currency": "GHS",
            "status": "approved",
            "approved_under_qc": true,
            "created_date": "2024-01-10 10:30:00"
        }
    ]
}
```

**SQL Query:**
```sql
SELECT 
    t_id, reference_number, jacket_name, file_number,
    instrument_type, instrument_date, party1_plaintiff,
    party2_defendant, consideration, consideration_currency,
    status, approved_under_qc, created_date
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE (deleted = false OR deleted IS NULL)
AND (:reference_number = '' OR reference_number ILIKE '%' || :reference_number || '%')
AND (:file_number = '' OR file_number ILIKE '%' || :file_number || '%')
AND (:jacket_name = '' OR jacket_name ILIKE '%' || :jacket_name || '%')
AND (:plan_number = '' OR plan_number ILIKE '%' || :plan_number || '%')
AND (:party1 = '' OR party1_plaintiff ILIKE '%' || :party1 || '%')
AND (:party2 = '' OR party2_defendant ILIKE '%' || :party2 || '%')
AND (:instrument_type = '' OR instrument_type = :instrument_type)
AND (:region = '' OR region = :region)
AND (:date_from = '' OR instrument_date >= :date_from)
AND (:date_to = '' OR instrument_date <= :date_to)
AND (:status = '' OR status = :status)
AND (:qc_status = '' OR approved_under_qc = (:qc_status)::boolean)
ORDER BY t_id DESC
LIMIT :limit OFFSET :offset;
```

---

### 3.2 Get Search Statistics

**Request:**
```javascript
{
    request_type: 'get_search_statistics',
    // Same parameters as search
}
```

**Response:**
```json
{
    "success": true,
    "data": {
        "total": 500,
        "approved": 450,
        "pending": 30,
        "rejected": 20,
        "qc_approved": 400,
        "this_month": 50
    }
}
```

**SQL Queries:**
```sql
-- Total count
SELECT COUNT(*) as total
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE (deleted = false OR deleted IS NULL)
-- Add same WHERE conditions as search query;

-- Approved count
SELECT COUNT(*) as approved
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'approved'
AND (deleted = false OR deleted IS NULL);

-- Pending count
SELECT COUNT(*) as pending
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'pending'
AND (deleted = false OR deleted IS NULL);

-- Rejected count
SELECT COUNT(*) as rejected
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE status = 'rejected'
AND (deleted = false OR deleted IS NULL);

-- QC approved count
SELECT COUNT(*) as qc_approved
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE approved_under_qc = true
AND (deleted = false OR deleted IS NULL);

-- This month count
SELECT COUNT(*) as this_month
FROM csau_geospatial.regional_pvlmd_transactions_all
WHERE DATE_TRUNC('month', created_date) = DATE_TRUNC('month', CURRENT_DATE)
AND (deleted = false OR deleted IS NULL);
```

---

### 3.3 Export Search Results

**Request:**
```
GET RegionalTransactionSearchServ?request_type=export_search_results&format=excel&reference_number=&file_number=&...
```

**Implementation Notes:**
- Support formats: excel, pdf, csv
- Apply same filters as search endpoint
- For Excel: Use Apache POI
- For PDF: Use iText
- For CSV: Generate plain text with comma separation

---

## Implementation Checklist

### For Each Servlet:

1. **Create Servlet Class**
   ```java
   @WebServlet("/Case_Management_Serv")
   public class Case_Management_Serv extends HttpServlet {
       // Implement doPost method
   }
   ```

2. **Handle Request Type Routing**
   ```java
   String requestType = request.getParameter("request_type");
   
   switch (requestType) {
       case "get_regional_transactions_list":
           handleGetList(request, response);
           break;
       case "get_regional_transaction_by_id":
           handleGetById(request, response);
           break;
       // ... other cases
   }
   ```

3. **Database Connection**
   - Use existing database connection pool
   - Use PreparedStatement to prevent SQL injection
   - Close connections in finally block

4. **Session Management**
   - Get current user from session
   - Validate user permissions
   - Log actions for audit trail

5. **Error Handling**
   - Try-catch blocks around database operations
   - Return meaningful error messages
   - Log errors for debugging

6. **JSON Response**
   - Use org.codehaus.jettison.json or Gson
   - Set content type: application/json
   - Handle null values properly

---

## Security Considerations

1. **Authentication**: Verify user is logged in
2. **Authorization**: Check user has appropriate role/permissions
3. **Input Validation**: Sanitize all input parameters
4. **SQL Injection**: Use parameterized queries only
5. **XSS Prevention**: Escape output in responses
6. **Audit Trail**: Log all create/update/delete operations

---

## Performance Optimization

1. **Database Indexes**: Add indexes on frequently searched columns
   ```sql
   CREATE INDEX idx_regional_ref_number ON csau_geospatial.regional_pvlmd_transactions_all(reference_number);
   CREATE INDEX idx_regional_status ON csau_geospatial.regional_pvlmd_transactions_all(status);
   CREATE INDEX idx_regional_created_date ON csau_geospatial.regional_pvlmd_transactions_all(created_date);
   CREATE INDEX idx_regional_qc ON csau_geospatial.regional_pvlmd_transactions_all(approved_under_qc);
   ```

2. **Pagination**: Always use LIMIT and OFFSET
3. **Connection Pooling**: Reuse database connections
4. **Caching**: Cache statistics for short periods (5-10 minutes)

---

## Testing

Test each endpoint with:
- Valid data
- Invalid/missing data
- SQL injection attempts
- Large datasets (pagination)
- Concurrent requests
- Different user roles

---

## Notes

- All date fields should be in ISO format: YYYY-MM-DD
- Timestamps should include time: YYYY-MM-DD HH:MM:SS
- Currency amounts should be stored as strings to preserve precision
- Boolean fields: use true/false (not 1/0)
- Empty strings preferred over NULL for text fields
- Always check for deleted flag in queries
