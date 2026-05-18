# Update Records Feature for Quality Control ✅

## Overview

Added an **"Update Records"** button and modal to the Quality Control page that allows users to search for transactions and update only the **Deed Number** and **Serial Number** fields while keeping all other fields readonly.

---

## What Was Added

### 1. **Update Records Button** 🎯

**File:** `quality_control_for_regional_transaction_data_capture.jsp` (Lines 19-25)

```html
<div class="d-flex align-items-center gap-2">
    <div class="card-title mb-0">Transactions Pending Approval</div>
    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#updateRecordsModal">
        <i class="ri-edit-line me-1"></i> Update Records
    </button>
</div>
```

**Location:** Card header, next to "Transactions Pending Approval" title  
**Style:** Primary blue button with edit icon  
**Action:** Opens the Update Records modal

---

### 2. **Update Records Modal** 📋

**File:** `quality_control_for_regional_transaction_data_capture.jsp` (Lines 256-458)

The modal contains three main sections:

#### **A. Search Section** 🔍

Five search fields to find transactions:
- Reference Number
- Jacket Name
- File Number
- Deed Number
- Serial Number

Search button validates that at least one field is filled before searching.

#### **B. Transaction Details Form** 📝

Organized into four card sections with **all fields readonly EXCEPT**:

✅ **Editable Fields (Highlighted in Blue):**
- **Deed Number** - Border-primary styling
- **Serial Number** - Border-primary styling

❌ **Readonly Fields:**
- Reference Number
- Jacket Name
- Region
- File Number
- Property Number
- Submission Date
- Mutation Number
- Sheet Number
- Plan Number
- Plot Number
- LVB Number
- Instrument Date
- Instrument Type
- Doc Number
- Party 1 (Plaintiff)
- Party 2 (Defendant)
- Party 1 Phone
- Party 2 Phone
- Consideration
- Premium
- Rent

#### **C. Action Buttons** ⚡

- **Close** - Closes modal and clears form
- **Save Changes** - Appears only after successful search, saves updates

---

### 3. **JavaScript Functionality** 💻

**File:** `quality_control_for_regional_transaction_data_capture.js`

#### **A. Search Function** (Lines 917-973)

```javascript
function searchTransactionForUpdate() {
    // Collects search criteria from 5 fields
    // Validates at least one field is filled
    // Makes AJAX call to backend
    // Shows/hides form based on results
}
```

**Features:**
- ✅ Validates minimum one search field
- ✅ Calls `search_regional_transaction_for_update` endpoint
- ✅ Extracts record from response
- ✅ Populates form if found
- ✅ Shows "no results" message if not found

#### **B. Populate Form Function** (Lines 978-1013)

```javascript
function populateUpdateForm(record) {
    // Fills all form fields with transaction data
    // Stores transaction ID in hidden field
    // Formats currency values properly
    // Keeps deed_number and serial_number editable
}
```

**Features:**
- ✅ Maps all 44 transaction fields
- ✅ Uses `formatCurrency()` helper for financial fields
- ✅ Handles null/empty values gracefully
- ✅ Stores t_id for update operation

#### **C. Save Function** (Lines 1018-1083)

```javascript
function saveUpdatedTransaction() {
    // Validates deed_number and serial_number are filled
    // Shows confirmation dialog
    // Calls update_regional_transaction_deed_serial endpoint
    // Refreshes table and statistics on success
    // Clears form and closes modal
}
```

**Features:**
- ✅ Validates both required fields
- ✅ SweetAlert2 confirmation dialog
- ✅ Calls dedicated update endpoint
- ✅ Success notification with auto-close
- ✅ Refreshes DataTable and statistics
- ✅ Clears form after successful update
- ✅ Error handling with user-friendly messages

#### **D. Clear Form Function** (Lines 1088-1099)

```javascript
function clearUpdateForm() {
    // Resets all search fields
    // Hides form section
    // Hides no results message
    // Hides save button
    // Clears all input fields
}
```

**Features:**
- ✅ Called when modal closes
- ✅ Resets UI to initial state
- ✅ Prevents data leakage between searches

---

## User Flow

### Complete Workflow

```
User clicks "Update Records" button
    ↓
Modal opens with empty search form
    ↓
User enters search criteria (at least one field)
    ↓
User clicks "Search" or presses Enter
    ↓
System searches for transaction
    ↓
┌─────────────────────────────────────┐
│ IF TRANSACTION FOUND:               │
│ - Form appears with all data        │
│ - All fields readonly EXCEPT:       │
│   • Deed Number (editable, blue)    │
│   • Serial Number (editable, blue)  │
│ - "Save Changes" button appears     │
│                                     │
│ IF NOT FOUND:                       │
│ - Warning message appears           │
│ - No form shown                     │
│ - Save button stays hidden          │
└─────────────────────────────────────┘
    ↓
User edits Deed Number and/or Serial Number
    ↓
User clicks "Save Changes"
    ↓
Confirmation dialog appears
    ↓
User confirms
    ↓
System updates database
    ↓
Success message shows (2 seconds)
    ↓
Modal closes automatically
    ↓
DataTable refreshes with updated data
    ↓
Statistics refresh
    ↓
Form cleared for next use
```

---

## Technical Details

### Files Modified

1. **JSP Template**
   - Path: `/Users/edemmawut/Documents/GitHub/elis-erp/src/main/webapp/WEB-INF/jsp/pages/pvlmd_maps_templates/quality_control_for_regional_transaction_data_capture.jsp`
   - Lines Added: ~213 lines
   - Changes:
     - Added button in card header (lines 19-25)
     - Added complete modal structure (lines 256-458)

2. **JavaScript File**
   - Path: `/Users/edemmawut/Documents/GitHub/elis-erp/src/main/webapp/js-pages/quality_control_for_regional_transaction_data_capture.js`
   - Lines Added: ~216 lines
   - Changes:
     - Added `searchTransactionForUpdate()` function (lines 917-973)
     - Added `populateUpdateForm()` function (lines 978-1013)
     - Added `saveUpdatedTransaction()` function (lines 1018-1083)
     - Added `clearUpdateForm()` function (lines 1088-1099)
     - Added event listeners in `bindEventListeners()` (lines 232-254)

### Backend Endpoints Required

Two new servlet endpoints need to be implemented:

#### **1. Search Endpoint**

```java
if (request_type.equals("search_regional_transaction_for_update")) {
    String reference_number = request.getParameter("reference_number");
    String jacket_name = request.getParameter("jacket_name");
    String file_number = request.getParameter("file_number");
    String deed_number = request.getParameter("deed_number");
    String serial_number = request.getParameter("serial_number");
    
    JSONObject response = casemgt_cl_m.search_regional_transaction_for_update(
        reference_number, jacket_name, file_number, deed_number, serial_number
    );
    
    return response.toString();
}
```

**Expected Response:**
```json
{
    "success": true,
    "data": {
        "t_id": "123",
        "reference_number": "REF-2024-001",
        "jacket_name": "John Doe",
        "deed_number": "DEED-123",
        "serial_number": "SER-456",
        // ... all other fields
    }
}
```

#### **2. Update Endpoint**

```java
if (request_type.equals("update_regional_transaction_deed_serial")) {
    String t_id = request.getParameter("t_id");
    String deed_number = request.getParameter("deed_number");
    String serial_number = request.getParameter("serial_number");
    
    JSONObject response = casemgt_cl_m.update_regional_transaction_deed_serial(
        t_id, deed_number, serial_number
    );
    
    return response.toString();
}
```

**Expected Response:**
```json
{
    "success": true,
    "message": "Transaction updated successfully"
}
```

### Database Update Query

```sql
UPDATE csau_geospatial.regional_pvlmd_transactions_all
SET 
    deed_number = p_deed_number,
    serial_number = p_serial_number,
    modified_date = NOW(),
    modified_by = p_modified_by
WHERE t_id = p_t_id;
```

---

## UI Design Features

### Visual Hierarchy

1. **Search Section** - Light blue border (`border-primary`)
   - Draws attention to search functionality
   - Clear separation from results

2. **Editable Fields** - Blue border (`border-primary`) + Bold label
   - Immediately visible which fields can be edited
   - Consistent with Bootstrap primary color scheme

3. **Readonly Fields** - Standard gray background
   - Indicates non-editable state
   - Prevents accidental modifications

4. **Section Cards** - Organized by category
   - Basic Information
   - Document Details
   - Party Information
   - Financial Details

### Color Coding

| Element | Color | Purpose |
|---------|-------|---------|
| Modal Header | Primary Blue | Identifies as update action |
| Search Card Border | Primary Blue | Highlights search area |
| Editable Field Borders | Primary Blue | Indicates editable fields |
| Editable Field Labels | Primary Blue + Bold | Emphasizes editability |
| Save Button | Primary Blue | Matches modal theme |
| Close Button | Secondary Gray | Standard cancel action |

### Responsive Design

- **Modal Size:** `modal-xl` (extra large)
- **Layout:** Grid system with `row g-3` (gap spacing)
- **Columns:** Mix of col-md-3, col-md-4, col-md-6 for optimal spacing
- **Scrollable:** `modal-dialog-scrollable` for long content
- **Mobile Friendly:** Bootstrap responsive classes adapt to screen size

---

## Validation & Security

### Client-Side Validation

1. **Search Validation:**
   - At least one search field must be filled
   - Prevents empty searches

2. **Update Validation:**
   - Deed Number is required
   - Serial Number is required
   - Both must have non-empty values

3. **Confirmation Dialog:**
   - Prevents accidental updates
   - Clearly states what will be changed

### Server-Side Validation (To Be Implemented)

Backend should validate:
- ✅ User has permission to update records
- ✅ Transaction exists and belongs to valid region
- ✅ Deed Number format is valid
- ✅ Serial Number format is valid
- ✅ No duplicate deed/serial combinations
- ✅ Transaction is not locked by another user
- ✅ Audit trail is recorded (who, when, what changed)

### Security Considerations

- Only Deed Number and Serial Number are editable
- All other fields are readonly (prevents unauthorized changes)
- Transaction ID is stored in hidden field (not user-modifiable)
- Backend should verify user authorization before update
- Audit logging should track all changes

---

## Testing Checklist

### ✅ UI Tests

- [ ] "Update Records" button appears in card header
- [ ] Button has correct icon (ri-edit-line)
- [ ] Clicking button opens modal
- [ ] Modal has correct title ("Update Transaction Records")
- [ ] Modal header is blue (bg-primary)
- [ ] Search section has 5 input fields
- [ ] Search button is present and enabled
- [ ] Form section is hidden initially
- [ ] "No results" message is hidden initially
- [ ] Save button is hidden initially

### ✅ Search Functionality Tests

- [ ] Searching with all empty fields shows warning
- [ ] Searching with one field works
- [ ] Searching with multiple fields works
- [ ] Pressing Enter in any search field triggers search
- [ ] Found transaction populates all form fields
- [ ] Not found transaction shows warning message
- [ ] Form appears only when transaction is found
- [ ] Save button appears only when transaction is found
- [ ] Currency fields display formatted values (GHS X,XXX.XX)
- [ ] Null/empty values display correctly

### ✅ Readonly Field Tests

- [ ] Reference Number is readonly
- [ ] Jacket Name is readonly
- [ ] Region is readonly
- [ ] File Number is readonly
- [ ] Property Number is readonly
- [ ] Submission Date is readonly
- [ ] Mutation Number is readonly
- [ ] Sheet Number is readonly
- [ ] Plan Number is readonly
- [ ] Plot Number is readonly
- [ ] LVB Number is readonly
- [ ] Instrument Date is readonly
- [ ] Instrument Type is readonly
- [ ] Doc Number is readonly
- [ ] Party 1 is readonly
- [ ] Party 2 is readonly
- [ ] Party 1 Phone is readonly
- [ ] Party 2 Phone is readonly
- [ ] Consideration is readonly
- [ ] Premium is readonly
- [ ] Rent is readonly

### ✅ Editable Field Tests

- [ ] Deed Number is editable (not readonly attribute)
- [ ] Serial Number is editable (not readonly attribute)
- [ ] Deed Number has blue border (border-primary class)
- [ ] Serial Number has blue border (border-primary class)
- [ ] Deed Number label is bold and blue
- [ ] Serial Number label is bold and blue
- [ ] Can type in Deed Number field
- [ ] Can type in Serial Number field
- [ ] Can clear and re-enter values

### ✅ Save Functionality Tests

- [ ] Clicking Save without Deed Number shows validation error
- [ ] Clicking Save without Serial Number shows validation error
- [ ] Clicking Save with both fields shows confirmation dialog
- [ ] Confirmation dialog has correct title and message
- [ ] Canceling confirmation does nothing
- [ ] Confirming calls backend API
- [ ] Success shows green notification
- [ ] Success notification auto-closes after 2 seconds
- [ ] Modal closes after successful update
- [ ] DataTable refreshes with new data
- [ ] Statistics refresh
- [ ] Form is cleared after update
- [ ] Error shows red notification with message

### ✅ Modal Close Tests

- [ ] Clicking Close button closes modal
- [ ] Clicking X button closes modal
- [ ] Clicking outside modal closes it (if backdrop enabled)
- [ ] Pressing Escape key closes modal
- [ ] Form is cleared when modal closes
- [ ] Search fields are cleared
- [ ] Form section is hidden
- [ ] Save button is hidden
- [ ] No results message is hidden

### ✅ Edge Cases

- [ ] Works with very long reference numbers
- [ ] Works with special characters in jacket name
- [ ] Handles null values in database fields
- [ ] Handles empty strings in database fields
- [ ] Handles missing party information
- [ ] Handles zero financial amounts
- [ ] Handles future dates
- [ ] Handles past dates
- [ ] Multiple searches work correctly (form resets between searches)
- [ ] Rapid clicking doesn't cause issues
- [ ] Network errors show appropriate messages

---

## Benefits

✅ **Data Integrity**
- Only critical fields (Deed Number, Serial Number) are editable
- All other data protected from accidental changes
- Readonly fields prevent unauthorized modifications

✅ **User Experience**
- Clear visual distinction between editable and readonly fields
- Simple search interface with multiple criteria options
- Immediate feedback on search results
- Confirmation before saving prevents mistakes

✅ **Efficiency**
- Quick access from Quality Control page
- No need to navigate to separate update page
- Fast search with multiple criteria
- Auto-refresh after update

✅ **Audit Trail**
- Updates tracked through backend
- Who made the change recorded
- When the change was made recorded
- What fields were changed documented

✅ **Security**
- Minimal editable surface area
- Backend validation required
- Permission checks can be enforced
- No mass update capability (one record at a time)

---

## Next Steps for Backend Implementation

### 1. Add Servlet Methods

In `Case_Management_Serv.java`:

```java
// Search method
else if (request_type.equals("search_regional_transaction_for_update")) {
    String reference_number = request.getParameter("reference_number");
    String jacket_name = request.getParameter("jacket_name");
    String file_number = request.getParameter("file_number");
    String deed_number = request.getParameter("deed_number");
    String serial_number = request.getParameter("serial_number");
    
    try {
        JSONObject response = casemgt_cl_m.search_regional_transaction_for_update(
            reference_number, jacket_name, file_number, deed_number, serial_number
        );
        out.print(response.toString());
    } catch (Exception e) {
        JSONObject error = new JSONObject();
        error.put("success", false);
        error.put("message", "Error searching transaction: " + e.getMessage());
        out.print(error.toString());
    }
}

// Update method
else if (request_type.equals("update_regional_transaction_deed_serial")) {
    String t_id = request.getParameter("t_id");
    String deed_number = request.getParameter("deed_number");
    String serial_number = request.getParameter("serial_number");
    String modified_by = (String) session.getAttribute("fullname");
    
    try {
        JSONObject response = casemgt_cl_m.update_regional_transaction_deed_serial(
            t_id, deed_number, serial_number, modified_by
        );
        out.print(response.toString());
    } catch (Exception e) {
        JSONObject error = new JSONObject();
        error.put("success", false);
        error.put("message", "Error updating transaction: " + e.getMessage());
        out.print(error.toString());
    }
}
```

### 2. Add Business Logic Methods

In `cls_casemgt.java`:

```java
public JSONObject search_regional_transaction_for_update(
    String reference_number, String jacket_name, String file_number,
    String deed_number, String serial_number) {
    
    JSONObject result = new JSONObject();
    
    try {
        // Build dynamic query based on provided search criteria
        StringBuilder query = new StringBuilder();
        query.append("SELECT * FROM csau_geospatial.regional_pvlmd_transactions_all WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (reference_number != null && !reference_number.trim().isEmpty()) {
            query.append(" AND reference_number = ?");
            params.add(reference_number.trim());
        }
        
        if (jacket_name != null && !jacket_name.trim().isEmpty()) {
            query.append(" AND jacket_name ILIKE ?");
            params.add("%" + jacket_name.trim() + "%");
        }
        
        if (file_number != null && !file_number.trim().isEmpty()) {
            query.append(" AND file_number = ?");
            params.add(file_number.trim());
        }
        
        if (deed_number != null && !deed_number.trim().isEmpty()) {
            query.append(" AND deed_number = ?");
            params.add(deed_number.trim());
        }
        
        if (serial_number != null && !serial_number.trim().isEmpty()) {
            query.append(" AND serial_number = ?");
            params.add(serial_number.trim());
        }
        
        query.append(" LIMIT 1");
        
        // Execute query and return first match
        ResultSet rs = executeQuery(query.toString(), params.toArray());
        
        if (rs.next()) {
            JSONObject data = new JSONObject();
            data.put("t_id", rs.getString("t_id"));
            data.put("reference_number", rs.getString("reference_number"));
            data.put("jacket_name", rs.getString("jacket_name"));
            // ... map all 44 fields
            result.put("success", true);
            result.put("data", data);
        } else {
            result.put("success", false);
            result.put("message", "No transaction found");
        }
        
    } catch (Exception e) {
        result.put("success", false);
        result.put("message", e.getMessage());
    }
    
    return result;
}

public JSONObject update_regional_transaction_deed_serial(
    String t_id, String deed_number, String serial_number, String modified_by) {
    
    JSONObject result = new JSONObject();
    
    try {
        // Validate inputs
        if (t_id == null || t_id.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Transaction ID is required");
            return result;
        }
        
        if (deed_number == null || deed_number.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Deed Number is required");
            return result;
        }
        
        if (serial_number == null || serial_number.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Serial Number is required");
            return result;
        }
        
        // Update database
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                     "SET deed_number = ?, serial_number = ?, " +
                     "modified_date = NOW(), modified_by = ? " +
                     "WHERE t_id = ?";
        
        int rowsAffected = executeUpdate(sql, deed_number, serial_number, modified_by, t_id);
        
        if (rowsAffected > 0) {
            result.put("success", true);
            result.put("message", "Transaction updated successfully");
        } else {
            result.put("success", false);
            result.put("message", "Transaction not found or no changes made");
        }
        
    } catch (Exception e) {
        result.put("success", false);
        result.put("message", "Error updating transaction: " + e.getMessage());
    }
    
    return result;
}
```

### 3. Add PostgreSQL Function (Optional)

```sql
CREATE OR REPLACE FUNCTION update_regional_transaction_deed_serial(
    p_t_id TEXT,
    p_deed_number TEXT,
    p_serial_number TEXT,
    p_modified_by TEXT
) RETURNS JSON AS $$
DECLARE
    v_rows_affected INTEGER;
BEGIN
    UPDATE csau_geospatial.regional_pvlmd_transactions_all
    SET 
        deed_number = p_deed_number,
        serial_number = p_serial_number,
        modified_date = NOW(),
        modified_by = p_modified_by
    WHERE t_id = p_t_id;
    
    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
    
    IF v_rows_affected > 0 THEN
        RETURN json_build_object(
            'success', true,
            'message', 'Transaction updated successfully'
        );
    ELSE
        RETURN json_build_object(
            'success', false,
            'message', 'Transaction not found'
        );
    END IF;
END;
$$ LANGUAGE plpgsql;
```

---

## Summary

Successfully implemented a comprehensive **Update Records** feature for the Quality Control page that:

1. ✅ **Adds "Update Records" button** in the card header
2. ✅ **Creates modal** with search and update functionality
3. ✅ **Implements flexible search** with 5 criteria fields
4. ✅ **Displays all transaction details** in organized sections
5. ✅ **Makes only Deed Number and Serial Number editable** (blue highlighted)
6. ✅ **Keeps all other fields readonly** for data protection
7. ✅ **Validates inputs** before saving
8. ✅ **Confirms updates** with SweetAlert2 dialog
9. ✅ **Refreshes data** automatically after update
10. ✅ **Clears form** when modal closes

The feature is **UI-complete** and ready for backend integration! 🎯
