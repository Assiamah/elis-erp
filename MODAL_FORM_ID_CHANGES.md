# Regional Transaction Form - ID Changes Summary

## Overview
All form field IDs in the modal have been prefixed with `reg_txn_` to avoid conflicts with other forms on the page.

---

## JSP File Changes (regional_transaction_data_capture.jsp)

### Basic Information Section
| Old ID | New ID |
|--------|---------|
| `region` | `reg_txn_region` |
| `reference_number` | `reg_txn_reference_number` |
| `file_number` | `reg_txn_file_number` |
| `property_number` | `reg_txn_property_number` |
| `jacket_name` | `reg_txn_jacket_name` |
| `submission_date` | `reg_txn_submission_date` |

### Document Details Section
| Old ID | New ID |
|--------|---------|
| `mutation_number` | `reg_txn_mutation_number` |
| `deed_number` | `reg_txn_deed_number` |
| `serial_number` | `reg_txn_serial_number` |
| `sheet_number` | `reg_txn_sheet_number` |
| `plan_number` | `reg_txn_plan_number` |
| `plot_number` | `reg_txn_plot_number` |
| `lvb_number` | `reg_txn_lvb_number` |
| `instrument_date` | `reg_txn_instrument_date` |
| `instrument_type` | `reg_txn_instrument_type` |
| `doc_number` | `reg_txn_doc_number` |

### Party 1 Information
| Old ID | New ID |
|--------|---------|
| `party1_plaintiff` | `reg_txn_party1_plaintiff` |
| `party1_plaintiff_tel_no` | `reg_txn_party1_plaintiff_tel_no` |
| `party1_plaintiff_email` | `reg_txn_party1_plaintiff_email` |
| `party1_plantiff_add` | `reg_txn_party1_plantiff_add` |

### Party 2 Information
| Old ID | New ID |
|--------|---------|
| `party2_defendant` | `reg_txn_party2_defendant` |
| `party2_defendant_tel_no` | `reg_txn_party2_defendant_tel_no` |
| `party2_defendant_email` | `reg_txn_party2_defendant_email` |
| `party2_defendant_add` | `reg_txn_party2_defendant_add` |

### Financial Details
| Old ID | New ID |
|--------|---------|
| `consideration` | `reg_txn_consideration` |
| `consideration_currency` | `reg_txn_consideration_currency` |
| `premium` | `reg_txn_premium` |
| `premium_currency` | `reg_txn_premium_currency` |
| `rent` | `reg_txn_rent` |
| `compensation_status` | `reg_txn_compensation_status` |

### Additional Details
| Old ID | New ID |
|--------|---------|
| `term` | `reg_txn_term` |
| `commencement_date` | `reg_txn_commencement_date` |
| `purpose` | `reg_txn_purpose` |
| `entered_date` | `reg_txn_entered_date` |
| `consent_date` | `reg_txn_consent_date` |
| `suit_number` | `reg_txn_suit_number` |
| `judgement_in_favour_of` | `reg_txn_judgement_in_favour_of` |
| `floor_level` | `reg_txn_floor_level` |
| `apartment_number` | `reg_txn_apartment_number` |
| `remarks` | `reg_txn_remarks` |

---

## JavaScript File Changes (regional_transaction_data_capture.js)

You need to update ALL jQuery selectors in these functions:

### 1. populateFormWithData() function (around line 270-328)

Change all `$('#field_id')` to `$('#reg_txn_field_id')`:

```javascript
// BEFORE:
$('#region').val(data.region);
$('#reference_number').val(data.reference_number);
$('#file_number').val(data.file_number);
// ... etc

// AFTER:
$('#reg_txn_region').val(data.region);
$('#reg_txn_reference_number').val(data.reference_number);
$('#reg_txn_file_number').val(data.file_number);
// ... etc
```

### 2. collectFormData() function (around line 400-450)

Change all `$('#field_id').val()` to `$('#reg_txn_field_id').val()`:

```javascript
// BEFORE:
region: $('#region').val(),
reference_number: $('#reference_number').val(),
file_number: $('#file_number').val(),
// ... etc

// AFTER:
region: $('#reg_txn_region').val(),
reference_number: $('#reg_txn_reference_number').val(),
file_number: $('#reg_txn_file_number').val(),
// ... etc
```

### 3. validateForm() function (if exists)

Update any validation selectors:

```javascript
// BEFORE:
if (!$('#reference_number').val()) { ... }

// AFTER:
if (!$('#reg_txn_reference_number').val()) { ... }
```

### 4. clearForm() or resetForm() function (if exists)

Update all field clear operations:

```javascript
// BEFORE:
$('#region').val('');
$('#reference_number').val('');

// AFTER:
$('#reg_txn_region').val('');
$('#reg_txn_reference_number').val('');
```

---

## Quick Find & Replace List for JavaScript

Run these find & replace operations in `regional_transaction_data_capture.js`:

1. `$('#region')` → `$('#reg_txn_region')`
2. `$('#reference_number')` → `$('#reg_txn_reference_number')`
3. `$('#file_number')` → `$('#reg_txn_file_number')`
4. `$('#property_number')` → `$('#reg_txn_property_number')`
5. `$('#jacket_name')` → `$('#reg_txn_jacket_name')`
6. `$('#submission_date')` → `$('#reg_txn_submission_date')`
7. `$('#mutation_number')` → `$('#reg_txn_mutation_number')`
8. `$('#deed_number')` → `$('#reg_txn_deed_number')`
9. `$('#serial_number')` → `$('#reg_txn_serial_number')`
10. `$('#sheet_number')` → `$('#reg_txn_sheet_number')`
11. `$('#plan_number')` → `$('#reg_txn_plan_number')`
12. `$('#plot_number')` → `$('#reg_txn_plot_number')`
13. `$('#lvb_number')` → `$('#reg_txn_lvb_number')`
14. `$('#instrument_date')` → `$('#reg_txn_instrument_date')`
15. `$('#instrument_type')` → `$('#reg_txn_instrument_type')`
16. `$('#doc_number')` → `$('#reg_txn_doc_number')`
17. `$('#party1_plaintiff')` → `$('#reg_txn_party1_plaintiff')`
18. `$('#party1_plaintiff_tel_no')` → `$('#reg_txn_party1_plaintiff_tel_no')`
19. `$('#party1_plaintiff_email')` → `$('#reg_txn_party1_plaintiff_email')`
20. `$('#party1_plantiff_add')` → `$('#reg_txn_party1_plantiff_add')`
21. `$('#party2_defendant')` → `$('#reg_txn_party2_defendant')`
22. `$('#party2_defendant_tel_no')` → `$('#reg_txn_party2_defendant_tel_no')`
23. `$('#party2_defendant_email')` → `$('#reg_txn_party2_defendant_email')`
24. `$('#party2_defendant_add')` → `$('#reg_txn_party2_defendant_add')`
25. `$('#consideration')` → `$('#reg_txn_consideration')`
26. `$('#consideration_currency')` → `$('#reg_txn_consideration_currency')`
27. `$('#premium')` → `$('#reg_txn_premium')`
28. `$('#premium_currency')` → `$('#reg_txn_premium_currency')`
29. `$('#rent')` → `$('#reg_txn_rent')`
30. `$('#compensation_status')` → `$('#reg_txn_compensation_status')`
31. `$('#term')` → `$('#reg_txn_term')`
32. `$('#commencement_date')` → `$('#reg_txn_commencement_date')`
33. `$('#purpose')` → `$('#reg_txn_purpose')`
34. `$('#entered_date')` → `$('#reg_txn_entered_date')`
35. `$('#consent_date')` → `$('#reg_txn_consent_date')`
36. `$('#suit_number')` → `$('#reg_txn_suit_number')`
37. `$('#judgement_in_favour_of')` → `$('#reg_txn_judgement_in_favour_of')`
38. `$('#floor_level')` → `$('#reg_txn_floor_level')`
39. `$('#apartment_number')` → `$('#reg_txn_apartment_number')`
40. `$('#remarks')` → `$('#reg_txn_remarks')`

---

## Important Notes

1. **DO NOT change**: The `name` attributes in the HTML - they stay the same (e.g., `name="region"` not `name="reg_txn_region"`)

2. **DO NOT change**: The hidden field `id="transaction_id"` if it exists - this is used internally

3. **Test thoroughly**: After making changes, test:
   - Opening the modal
   - Filling out the form
   - Saving a new transaction
   - Editing an existing transaction
   - Form validation

4. **Browser Console**: Check for any jQuery errors like "Cannot read property 'val' of null" - this means a selector wasn't updated

---

## Verification Checklist

After updating the JavaScript file:

- [ ] All 40+ field IDs updated in `populateFormWithData()`
- [ ] All 40+ field IDs updated in `collectFormData()`
- [ ] All validation selectors updated
- [ ] No remaining `$('#region')`, `$('#reference_number')`, etc. without prefix
- [ ] Modal opens without errors
- [ ] Form fields populate correctly when editing
- [ ] Form data submits correctly
- [ ] No console errors

---

## Files Modified

✅ `/src/main/webapp/WEB-INF/jsp/pages/pvlmd_maps_templates/regional_transaction_data_capture.jsp` - All IDs updated  
⏳ `/src/main/webapp/js-pages/regional_transaction_data_capture.js` - Needs manual update using the list above
