<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Receive Writ -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Receive writ</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form action="secretariat" method="post">
        <div class="modal-body" >
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Suit Number <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" name="suit_number" required>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Nature of Cases<span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="nature_of_case"  required>
                <option disabled selected>-- select --</option>
                 <c:forEach items="${type_of_cases}" var="typeslist"  varStatus="typeslist_loop">
                        <option value="${typeslist.id}" >${typeslist.description}</option>
                     </c:forEach>
              </select>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Region <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="court_region" id="court_region" required>
                <option disabled selected>-- select --</option>
                <option value="1">Greater Accra</option>
				<option value="2">Western</option>
				<option value="3">Volta</option>	
				<option value="4">Eastern</option>	
				<option value="5">Ashanti</option>	
				<option value="6">Central</option>	
				<option value="7">Northern</option>	
				<option value="8">Upper East</option>	
				<option value="9">Upper West</option>	
				<option value="10">Oti</option>	
				<option value="11">Bono East</option>	
				<option value="12">Ahafo</option>	
				<option value="13">Bono</option>	
				<option value="14">North East </option>	
				<option value="15">Savannah</option>
				<option value="16">Western North</option>	
              </select>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Court <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="court" id="court" required>
                <option disabled selected>-- select --</option>
              	<!-- 	 <c:forEach items="${courts}" var="courtslist"  varStatus="courtslist_loop">
                        <option value="${courtslist.id}" >${courtslist.court_name}</option>
                     </c:forEach>
                     -->
              </select>
            </div>
          </div>
          
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">City/Town :</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" name="court_city" id="court_city" readonly>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Date of  Document <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="date" class="form-control " name="date_document" required>
            </div>
          </div>
            <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Date Received <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="date" class="form-control"   name="date_received">
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Plaintiff's Name(s) <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <textarea type="text" class="form-control" name="plaintiff" required></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Defendant's Name(s) <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <textarea class="form-control" name="defendant" required></textarea>
            </div>
          </div>
          <input type="text" name="request_type" value="receive_writ" hidden>
          <input type="text" name="received_by" value="${sessionScope.userid}" hidden>
          <input type="text" name="received_at" value="${sessionScope.fullname}" hidden>
          
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_btn" class="btn btn-primary">Save</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  <!-- Receive Writ -->
  
 
  
  <!-- Edit Writ 
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Edit writ</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
        <form id="edit_writ" method="post">
        <div class="modal-body"  style="font-size: small;">
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Suit Number <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" name="edit_suit_number" id="edit_suit_number" required>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Nature of Cases<span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="nature_of_case"  required>
                <option disabled selected>-- select --</option>
                 <c:forEach items="${type_of_cases}" var="typeslist"  varStatus="typeslist_loop">
                        <option value="${typeslist.id}" >${typeslist.description}</option>
                     </c:forEach>
              </select>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Region <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="court_region" id="court_region" required>
                <option disabled selected>-- select --</option>
                <option value="1">Greater Accra</option>
				<option value="2">Western</option>
				<option value="3">Volta</option>	
				<option value="4">Eastern</option>	
				<option value="5">Ashanti</option>	
				<option value="6">Central</option>	
				<option value="7">Northern</option>	
				<option value="8">Upper East</option>	
				<option value="9">Upper West</option>	
				<option value="10">Oti</option>	
				<option value="11">Bono East</option>	
				<option value="12">Ahafo</option>	
				<option value="13">Bono</option>	
				<option value="14">North East </option>	
				<option value="15">Savannah</option>
				<option value="16">Western North</option>	
              </select>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Court <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <select class="form-control" aria-label="Default select example" name="court" id="court" required>
                <option disabled selected>-- select --</option>
              	!-- 	 <c:forEach items="${courts}" var="courtslist"  varStatus="courtslist_loop">
                        <option value="${courtslist.id}" >${courtslist.court_name}</option>
                     </c:forEach>
                     --
              </select>
            </div>
          </div>
          
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">City/Town :</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" name="court_city" id="court_city" readonly>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Date of  Document <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="date" class="form-control " name="date_document" required>
            </div>
          </div>
            <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Date Received <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <input type="date" class="form-control"   name="date_received">
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Plaintiff's Name(s) <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <textarea type="text" class="form-control" name="plaintiff" required></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="inputText" class="col-sm-4 col-form-label">Defendant's Name(s) <span class="text-danger">*</span>:</label>
            <div class="col-sm-8">
              <textarea type="text" class="form-control" name="defendant" required></textarea>
            </div>
          </div>
          <input type="text" name="request_type" value="receive_writ" hidden>
          <input type="text" name="received_by" value="${sessionScope.userid}" hidden>
          <input type="text" name="received_at" value="${sessionScope.fullname}" hidden>
          
        </div>
        <div class="modal-footer">
          <button type="submit" id="save_btn" class="btn btn-primary">Save</button>
        </div>
        </form>
      </div>
    </div>
  </div>
  !-- Edit Writ -->
  
  <!-- Case Summary Modal -->
  <div class="modal fade" id="summaryModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Case Summary</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
        </div>
      
        
        <div class="modal-body" >
			<div class="row mb-3">
         	 	<label for="" class="col-sm-12 col-form-label">Suit No:</label>
	              <div class="row mb-3 col-sm-12">
	               
	                <div class="col-sm-12">
	                 <input type="text" class="form-control" id="suit_number" name="suit_number">
	                </div>
	              </div>
			</div>
          	<div class="row mb-3">
         	 	<label for="" class="col-sm-1 col-form-label">Summary:</label>
	              <div class="row mb-3 col-sm-12">
	               
	                <div class="col-sm-12">
	                  <textarea class="form-control"  name="summary" id="summary" ></textarea>
	                </div>
	              </div>
			</div>
			<div class="row mb-3">
         	 	<label for="" class="col-sm-1 col-form-label">Reliefs:</label>
	              <div class="row mb-3 col-sm-12">
	               
	                <div class="col-sm-12">
	                  <textarea class="form-control"  name="reliefs" id="reliefs" ></textarea>
	                </div>
	              </div>
			</div>

        </div>
        <div class="modal-footer">
         
        </div>
 
      </div>
    </div>
  </div>
  
  <!-- Case Summary Modal  -->