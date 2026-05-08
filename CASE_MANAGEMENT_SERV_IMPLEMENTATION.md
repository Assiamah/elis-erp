# Case_Management_Serv Implementation Guide

## Overview

All Regional PVLMD Transaction operations are now consolidated into a single servlet: **Case_Management_Serv**

This servlet handles three functional areas:
1. **Transaction CRUD** (Data Capture)
2. **Quality Control** (QC Workflow)
3. **Advanced Search** (Search & Reporting)

---

## Request Type Routing Structure

Add these request types to your existing `Case_Management_Serv.java` doPost method:

```java
String requestType = request.getParameter("request_type");

if (requestType == null) {
    response.getWriter().write("{\"success\":false,\"message\":\"Missing request_type parameter\"}");
    return;
}

switch (requestType) {
    // === TRANSACTION CRUD OPERATIONS ===
    case "get_regional_transactions_list":
        handleGetRegionalTransactionsList(request, response);
        break;
    case "get_regional_transaction_by_id":
        handleGetRegionalTransactionById(request, response);
        break;
    case "create_regional_transaction":
        handleCreateRegionalTransaction(request, response);
        break;
    case "update_regional_transaction":
        handleUpdateRegionalTransaction(request, response);
        break;
    case "delete_regional_transaction":
        handleDeleteRegionalTransaction(request, response);
        break;
    case "export_regional_transactions_excel":
        handleExportRegionalTransactionsExcel(request, response);
        break;
    case "export_regional_transactions_pdf":
        handleExportRegionalTransactionsPDF(request, response);
        break;
    
    // === QUALITY CONTROL OPERATIONS ===
    case "get_qc_pending_transactions":
        handleGetQCPendingTransactions(request, response);
        break;
    case "get_qc_statistics":
        handleGetQCStatistics(request, response);
        break;
    case "mark_transaction_under_review":
        handleMarkTransactionUnderReview(request, response);
        break;
    case "approve_transaction_qc":
        handleApproveTransactionQC(request, response);
        break;
    case "decline_transaction_qc":
        handleDeclineTransactionQC(request, response);
        break;
    case "batch_approve_qc":
        handleBatchApproveQC(request, response);
        break;
    case "export_qc_data":
        handleExportQCData(request, response);
        break;
    
    // === SEARCH OPERATIONS ===
    case "search_regional_transactions":
        handleSearchRegionalTransactions(request, response);
        break;
    case "get_search_statistics":
        handleGetSearchStatistics(request, response);
        break;
    case "export_search_results":
        handleExportSearchResults(request, response);
        break;
    
    default:
        response.getWriter().write("{\"success\":false,\"message\":\"Invalid request_type: " + requestType + "\"}");
        break;
}
```

---

## Implementation Methods

### 1. Get Regional Transactions List

```java
private void handleGetRegionalTransactionsList(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Get DataTables parameters
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        
        // Get search parameters
        String searchReference = request.getParameter("search_reference");
        String searchFile = request.getParameter("search_file");
        String searchJacket = request.getParameter("search_jacket");
        String searchStatus = request.getParameter("search_status");
        
        // Set defaults
        int startIndex = start != null ? Integer.parseInt(start) : 0;
        int pageSize = length != null ? Integer.parseInt(length) : 25;
        
        // Build query
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT t_id, reference_number, jacket_name, file_number, ");
        sql.append("instrument_type, instrument_date, party1_plaintiff, ");
        sql.append("party2_defendant, status, created_date ");
        sql.append("FROM csau_geospatial.regional_pvlmd_transactions_all ");
        sql.append("WHERE (deleted = false OR deleted IS NULL) ");
        
        List<Object> params = new ArrayList<>();
        
        if (searchReference != null && !searchReference.isEmpty()) {
            sql.append("AND reference_number ILIKE ? ");
            params.add("%" + searchReference + "%");
        }
        if (searchFile != null && !searchFile.isEmpty()) {
            sql.append("AND file_number ILIKE ? ");
            params.add("%" + searchFile + "%");
        }
        if (searchJacket != null && !searchJacket.isEmpty()) {
            sql.append("AND jacket_name ILIKE ? ");
            params.add("%" + searchJacket + "%");
        }
        if (searchStatus != null && !searchStatus.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(searchStatus);
        }
        
        sql.append("ORDER BY t_id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(startIndex);
        
        // Get total count
        String countSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE (deleted = false OR deleted IS NULL)";
        int totalCount = jdbcTemplate.queryForObject(countSql, Integer.class);
        
        // Execute query
        List<Map<String, Object>> results = jdbcTemplate.queryForList(sql.toString(), params.toArray());
        
        // Build response
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("draw", draw != null ? draw : "1");
        jsonResponse.put("recordsTotal", totalCount);
        jsonResponse.put("recordsFiltered", results.size());
        jsonResponse.put("data", new JSONArray(results));
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error getting regional transactions list", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error loading transactions\"}");
    }
}
```

---

### 2. Get Regional Transaction By ID

```java
private void handleGetRegionalTransactionById(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        
        if (transactionId == null || transactionId.isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Missing t_id parameter\"}");
            return;
        }
        
        String sql = "SELECT * FROM csau_geospatial.regional_pvlmd_transactions_all WHERE t_id = ? AND (deleted = false OR deleted IS NULL)";
        
        Map<String, Object> result = jdbcTemplate.queryForMap(sql, Long.parseLong(transactionId));
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("data", new JSONObject(result));
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error getting transaction by ID", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error fetching transaction details\"}");
    }
}
```

---

### 3. Create Regional Transaction

```java
private void handleCreateRegionalTransaction(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Get current user from session
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        // Extract all form fields
        String jacketName = request.getParameter("jacket_name");
        String region = request.getParameter("region");
        String referenceNumber = request.getParameter("reference_number");
        // ... extract all other parameters
        
        // Validate required fields
        if (jacketName == null || jacketName.isEmpty() ||
            region == null || region.isEmpty() ||
            referenceNumber == null || referenceNumber.isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Required fields missing\"}");
            return;
        }
        
        String sql = "INSERT INTO csau_geospatial.regional_pvlmd_transactions_all (" +
            "jacket_name, region, reference_number, file_number, property_number, " +
            "submission_date, mutation_number, deed_number, serial_number, sheet_number, " +
            "plan_number, plot_number, lvb_number, instrument_date, instrument_type, " +
            "doc_number, party1_plaintiff, party1_plaintiff_tel_no, party1_plaintiff_email, " +
            "party2_defendant, party2_defendant_tel_no, party2_defendant_email, " +
            "consideration, consideration_currency, premium, premium_currency, rent, " +
            "compensation_status, term, commencement_date, purpose, entered_date, " +
            "consent_date, suit_number, judgement_in_favour_of, floor_level, " +
            "apartment_number, unit_description, hqfile_id, gid_unique_across, remarks, " +
            "status, approved_under_qc, entered_by, entered_by_id, " +
            "created_by, created_by_id, created_date, deleted" +
            ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";
        
        jdbcTemplate.update(sql,
            jacketName, region, referenceNumber,
            request.getParameter("file_number"),
            request.getParameter("property_number"),
            // ... all other parameters in order
            "pending",  // status
            false,      // approved_under_qc
            userName, userId,  // entered_by
            userName, userId,  // created_by
            false       // deleted
        );
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", "Transaction created successfully");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error creating transaction", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error creating transaction\"}");
    }
}
```

---

### 4. Update Regional Transaction

```java
private void handleUpdateRegionalTransaction(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        
        if (transactionId == null || transactionId.isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Missing t_id parameter\"}");
            return;
        }
        
        // Get current user
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        // Build dynamic update query
        StringBuilder sql = new StringBuilder("UPDATE csau_geospatial.regional_pvlmd_transactions_all SET ");
        List<Object> params = new ArrayList<>();
        
        // Add all fields that need updating
        String[] fields = {"jacket_name", "region", "reference_number", "file_number", 
                          "property_number", "instrument_type", "remarks"};
        // ... add all fields
        
        boolean first = true;
        for (String field : fields) {
            String value = request.getParameter(field);
            if (value != null) {
                if (!first) sql.append(", ");
                sql.append(field).append(" = ?");
                params.add(value);
                first = false;
            }
        }
        
        sql.append(", modified_by = ?, modified_by_id = ?, modified_date = NOW()");
        params.add(userName);
        params.add(userId);
        
        sql.append(" WHERE t_id = ? AND (deleted = false OR deleted IS NULL)");
        params.add(Long.parseLong(transactionId));
        
        int rowsAffected = jdbcTemplate.update(sql.toString(), params.toArray());
        
        if (rowsAffected > 0) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Transaction updated successfully");
            response.getWriter().write(jsonResponse.toString());
        } else {
            response.getWriter().write("{\"success\":false,\"message\":\"Transaction not found or no changes made\"}");
        }
        
    } catch (Exception e) {
        log.error("Error updating transaction", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error updating transaction\"}");
    }
}
```

---

### 5. Delete Regional Transaction

```java
private void handleDeleteRegionalTransaction(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        
        if (transactionId == null || transactionId.isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Missing t_id parameter\"}");
            return;
        }
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                    "SET deleted = true, deleted_requested_by_id = ?, " +
                    "deleted_requested_by = ?, modified_date = NOW() " +
                    "WHERE t_id = ?";
        
        jdbcTemplate.update(sql, userId, userName, Long.parseLong(transactionId));
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", "Transaction deleted successfully");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error deleting transaction", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error deleting transaction\"}");
    }
}
```

---

### 6. Get QC Pending Transactions

```java
private void handleGetQCPendingTransactions(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        
        String searchReference = request.getParameter("search_reference");
        String searchStatus = request.getParameter("search_status");
        String dateFrom = request.getParameter("date_from");
        String dateTo = request.getParameter("date_to");
        
        int startIndex = start != null ? Integer.parseInt(start) : 0;
        int pageSize = length != null ? Integer.parseInt(length) : 25;
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT t_id, reference_number, jacket_name, instrument_type, ");
        sql.append("party1_plaintiff, party2_defendant, entered_by, ");
        sql.append("created_date, status, approved_under_qc ");
        sql.append("FROM csau_geospatial.regional_pvlmd_transactions_all ");
        sql.append("WHERE (deleted = false OR deleted IS NULL) ");
        sql.append("AND approved_under_qc = false ");
        sql.append("AND status IN ('pending', 'under_review') ");
        
        List<Object> params = new ArrayList<>();
        
        if (searchReference != null && !searchReference.isEmpty()) {
            sql.append("AND reference_number ILIKE ? ");
            params.add("%" + searchReference + "%");
        }
        if (searchStatus != null && !searchStatus.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(searchStatus);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql.append("AND created_date >= ?::timestamp ");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql.append("AND created_date <= ?::timestamp + interval '1 day' ");
            params.add(dateTo);
        }
        
        sql.append("ORDER BY t_id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(startIndex);
        
        List<Map<String, Object>> results = jdbcTemplate.queryForList(sql.toString(), params.toArray());
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("draw", draw != null ? draw : "1");
        jsonResponse.put("recordsTotal", results.size());
        jsonResponse.put("recordsFiltered", results.size());
        jsonResponse.put("data", new JSONArray(results));
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error getting QC pending transactions", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error loading QC transactions\"}");
    }
}
```

---

### 7. Get QC Statistics

```java
private void handleGetQCStatistics(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Pending count
        String pendingSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all " +
                           "WHERE status = 'pending' AND approved_under_qc = false " +
                           "AND (deleted = false OR deleted IS NULL)";
        int pending = jdbcTemplate.queryForObject(pendingSql, Integer.class);
        
        // Under review count
        String underReviewSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all " +
                               "WHERE status = 'under_review' AND approved_under_qc = false " +
                               "AND (deleted = false OR deleted IS NULL)";
        int underReview = jdbcTemplate.queryForObject(underReviewSql, Integer.class);
        
        // Approved today
        String approvedTodaySql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all " +
                                 "WHERE approved_under_qc = true AND DATE(checked_by_date) = CURRENT_DATE " +
                                 "AND (deleted = false OR deleted IS NULL)";
        int approvedToday = jdbcTemplate.queryForObject(approvedTodaySql, Integer.class);
        
        // Rejected today
        String rejectedTodaySql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all " +
                                 "WHERE status = 'rejected' AND DATE(modified_date) = CURRENT_DATE " +
                                 "AND (deleted = false OR deleted IS NULL)";
        int rejectedToday = jdbcTemplate.queryForObject(rejectedTodaySql, Integer.class);
        
        JSONObject data = new JSONObject();
        data.put("pending", pending);
        data.put("under_review", underReview);
        data.put("approved_today", approvedToday);
        data.put("rejected_today", rejectedToday);
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("data", data);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error getting QC statistics", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error loading statistics\"}");
    }
}
```

---

### 8. Mark Transaction Under Review

```java
private void handleMarkTransactionUnderReview(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        String reviewNote = request.getParameter("review_note");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                    "SET status = 'under_review', review_note = ?, " +
                    "reviewed_by = ?, reviewed_by_id = ?, modified_date = NOW() " +
                    "WHERE t_id = ? AND (deleted = false OR deleted IS NULL)";
        
        jdbcTemplate.update(sql, reviewNote, userName, userId, Long.parseLong(transactionId));
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", "Transaction marked as under review");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error marking transaction under review", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error updating status\"}");
    }
}
```

---

### 9. Approve Transaction QC

```java
private void handleApproveTransactionQC(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        String approveNote = request.getParameter("approve_note");
        String reviewNote = request.getParameter("review_note");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                    "SET status = 'approved', approved_under_qc = true, " +
                    "approve_note = ?, review_note = ?, " +
                    "checked_by = ?, checked_by_id = ?, " +
                    "checked_by_date = NOW(), modified_date = NOW() " +
                    "WHERE t_id = ? AND (deleted = false OR deleted IS NULL)";
        
        jdbcTemplate.update(sql, approveNote, reviewNote, userName, userId, Long.parseLong(transactionId));
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", "Transaction approved successfully");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error approving transaction", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error approving transaction\"}");
    }
}
```

---

### 10. Decline Transaction QC

```java
private void handleDeclineTransactionQC(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionId = request.getParameter("t_id");
        String declineNote = request.getParameter("decline_note");
        String reviewNote = request.getParameter("review_note");
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                    "SET status = 'rejected', decline_note = ?, review_note = ?, " +
                    "declined_by = ?, declined_by_id = ?, modified_date = NOW() " +
                    "WHERE t_id = ? AND (deleted = false OR deleted IS NULL)";
        
        jdbcTemplate.update(sql, declineNote, reviewNote, userName, userId, Long.parseLong(transactionId));
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", "Transaction declined");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error declining transaction", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error declining transaction\"}");
    }
}
```

---

### 11. Batch Approve QC

```java
private void handleBatchApproveQC(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String transactionIdsJson = request.getParameter("transaction_ids");
        String batchNote = request.getParameter("batch_note");
        
        // Parse JSON array
        JSONArray transactionIdsArray = new JSONArray(transactionIdsJson);
        
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("user_name");
        String userId = (String) session.getAttribute("user_id");
        
        String sql = "UPDATE csau_geospatial.regional_pvlmd_transactions_all " +
                    "SET status = 'approved', approved_under_qc = true, " +
                    "approve_note = ?, checked_by = ?, checked_by_id = ?, " +
                    "checked_by_date = NOW(), modified_date = NOW() " +
                    "WHERE t_id IN (?) AND (deleted = false OR deleted IS NULL)";
        
        // Convert JSONArray to comma-separated string for IN clause
        StringBuilder ids = new StringBuilder();
        for (int i = 0; i < transactionIdsArray.length(); i++) {
            if (i > 0) ids.append(",");
            ids.append(transactionIdsArray.getLong(i));
        }
        
        int rowsAffected = jdbcTemplate.update(sql, batchNote, userName, userId, ids.toString());
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("message", rowsAffected + " transactions approved successfully");
        jsonResponse.put("count", rowsAffected);
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error in batch approval", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error during batch approval\"}");
    }
}
```

---

### 12. Search Regional Transactions

```java
private void handleSearchRegionalTransactions(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        
        // Get all search parameters
        String referenceNumber = request.getParameter("reference_number");
        String fileNumber = request.getParameter("file_number");
        String jacketName = request.getParameter("jacket_name");
        String planNumber = request.getParameter("plan_number");
        String party1 = request.getParameter("party1");
        String party2 = request.getParameter("party2");
        String instrumentType = request.getParameter("instrument_type");
        String region = request.getParameter("region");
        String dateFrom = request.getParameter("date_from");
        String dateTo = request.getParameter("date_to");
        String status = request.getParameter("status");
        String qcStatus = request.getParameter("qc_status");
        
        int startIndex = start != null ? Integer.parseInt(start) : 0;
        int pageSize = length != null ? Integer.parseInt(length) : 25;
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT t_id, reference_number, jacket_name, file_number, ");
        sql.append("instrument_type, instrument_date, party1_plaintiff, ");
        sql.append("party2_defendant, consideration, consideration_currency, ");
        sql.append("status, approved_under_qc, created_date ");
        sql.append("FROM csau_geospatial.regional_pvlmd_transactions_all ");
        sql.append("WHERE (deleted = false OR deleted IS NULL) ");
        
        List<Object> params = new ArrayList<>();
        
        if (referenceNumber != null && !referenceNumber.isEmpty()) {
            sql.append("AND reference_number ILIKE ? ");
            params.add("%" + referenceNumber + "%");
        }
        if (fileNumber != null && !fileNumber.isEmpty()) {
            sql.append("AND file_number ILIKE ? ");
            params.add("%" + fileNumber + "%");
        }
        if (jacketName != null && !jacketName.isEmpty()) {
            sql.append("AND jacket_name ILIKE ? ");
            params.add("%" + jacketName + "%");
        }
        if (planNumber != null && !planNumber.isEmpty()) {
            sql.append("AND plan_number ILIKE ? ");
            params.add("%" + planNumber + "%");
        }
        if (party1 != null && !party1.isEmpty()) {
            sql.append("AND party1_plaintiff ILIKE ? ");
            params.add("%" + party1 + "%");
        }
        if (party2 != null && !party2.isEmpty()) {
            sql.append("AND party2_defendant ILIKE ? ");
            params.add("%" + party2 + "%");
        }
        if (instrumentType != null && !instrumentType.isEmpty()) {
            sql.append("AND instrument_type = ? ");
            params.add(instrumentType);
        }
        if (region != null && !region.isEmpty()) {
            sql.append("AND region = ? ");
            params.add(region);
        }
        if (dateFrom != null && !dateFrom.isEmpty()) {
            sql.append("AND instrument_date >= ? ");
            params.add(dateFrom);
        }
        if (dateTo != null && !dateTo.isEmpty()) {
            sql.append("AND instrument_date <= ? ");
            params.add(dateTo);
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND status = ? ");
            params.add(status);
        }
        if (qcStatus != null && !qcStatus.isEmpty()) {
            sql.append("AND approved_under_qc = ? ");
            params.add(Boolean.parseBoolean(qcStatus));
        }
        
        sql.append("ORDER BY t_id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add(startIndex);
        
        List<Map<String, Object>> results = jdbcTemplate.queryForList(sql.toString(), params.toArray());
        
        // Get total count with same filters
        String countSql = sql.toString().replaceAll("SELECT.*?FROM", "SELECT COUNT(*) FROM")
                                          .replaceAll("ORDER BY.*$", "");
        int totalCount = jdbcTemplate.queryForObject(countSql, Integer.class, params.subList(0, params.size() - 2).toArray());
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("draw", draw != null ? draw : "1");
        jsonResponse.put("recordsTotal", totalCount);
        jsonResponse.put("recordsFiltered", results.size());
        jsonResponse.put("data", new JSONArray(results));
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error searching transactions", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error searching transactions\"}");
    }
}
```

---

### 13. Get Search Statistics

```java
private void handleGetSearchStatistics(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Total count
        String totalSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE (deleted = false OR deleted IS NULL)";
        int total = jdbcTemplate.queryForObject(totalSql, Integer.class);
        
        // Approved count
        String approvedSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE status = 'approved' AND (deleted = false OR deleted IS NULL)";
        int approved = jdbcTemplate.queryForObject(approvedSql, Integer.class);
        
        // Pending count
        String pendingSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE status = 'pending' AND (deleted = false OR deleted IS NULL)";
        int pending = jdbcTemplate.queryForObject(pendingSql, Integer.class);
        
        // Rejected count
        String rejectedSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE status = 'rejected' AND (deleted = false OR deleted IS NULL)";
        int rejected = jdbcTemplate.queryForObject(rejectedSql, Integer.class);
        
        // QC approved count
        String qcApprovedSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE approved_under_qc = true AND (deleted = false OR deleted IS NULL)";
        int qcApproved = jdbcTemplate.queryForObject(qcApprovedSql, Integer.class);
        
        // This month count
        String thisMonthSql = "SELECT COUNT(*) FROM csau_geospatial.regional_pvlmd_transactions_all WHERE DATE_TRUNC('month', created_date) = DATE_TRUNC('month', CURRENT_DATE) AND (deleted = false OR deleted IS NULL)";
        int thisMonth = jdbcTemplate.queryForObject(thisMonthSql, Integer.class);
        
        JSONObject data = new JSONObject();
        data.put("total", total);
        data.put("approved", approved);
        data.put("pending", pending);
        data.put("rejected", rejected);
        data.put("qc_approved", qcApproved);
        data.put("this_month", thisMonth);
        
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", true);
        jsonResponse.put("data", data);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
        
    } catch (Exception e) {
        log.error("Error getting search statistics", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write("{\"success\":false,\"message\":\"Error loading statistics\"}");
    }
}
```

---

## Export Methods (Excel/PDF)

For export functionality, you'll need to:

1. **Excel Export**: Use Apache POI library
2. **PDF Export**: Use iText library (already in your project)

These methods should:
- Query data with filters
- Generate file in memory
- Set appropriate response headers
- Write to response output stream

Example structure:

```java
private void handleExportRegionalTransactionsExcel(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        // Get search parameters
        String searchReference = request.getParameter("search_reference");
        // ... other parameters
        
        // Query data
        List<Map<String, Object>> data = queryTransactionsWithFilters(searchReference, ...);
        
        // Create Excel workbook using Apache POI
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Regional Transactions");
        
        // Create header row
        Row headerRow = sheet.createRow(0);
        String[] columns = {"ID", "Reference Number", "Jacket Name", /* ... */};
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
        }
        
        // Fill data rows
        int rowNum = 1;
        for (Map<String, Object> row : data) {
            Row excelRow = sheet.createRow(rowNum++);
            // Fill cells...
        }
        
        // Set response headers
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=regional_transactions.xlsx");
        
        // Write to response
        workbook.write(response.getOutputStream());
        workbook.close();
        
    } catch (Exception e) {
        log.error("Error exporting to Excel", e);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}
```

---

## Required Imports

Add these imports to your `Case_Management_Serv.java`:

```java
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
```

---

## Database Configuration

Make sure you have JdbcTemplate configured in your Spring Boot application:

```java
@Autowired
private JdbcTemplate jdbcTemplate;
```

Or initialize it manually:

```java
private JdbcTemplate getJdbcTemplate() {
    DataSource dataSource = // get your datasource
    return new JdbcTemplate(dataSource);
}
```

---

## Testing Checklist

After implementing each method:

- [ ] Test with valid data
- [ ] Test with missing parameters
- [ ] Test with invalid data types
- [ ] Test SQL injection prevention
- [ ] Verify JSON response format
- [ ] Check error handling
- [ ] Test with large datasets (pagination)
- [ ] Verify user session handling
- [ ] Test concurrent requests
- [ ] Check database indexes performance

---

## Notes

1. All methods follow the same pattern: extract parameters → validate → execute query → return JSON
2. Always use parameterized queries to prevent SQL injection
3. Get user information from session for audit trail
4. Log all errors for debugging
5. Return consistent JSON response format
6. Handle null/empty values gracefully
7. Use transactions for multi-step operations if needed

---

This consolidated approach keeps all regional transaction logic in one place while maintaining clean separation through the request_type routing!
