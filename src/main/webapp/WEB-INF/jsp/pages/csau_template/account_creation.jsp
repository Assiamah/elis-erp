<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="org.codehaus.jettison.json.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
  <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
  <jsp:include page="../includes/_header.jsp"></jsp:include>
       

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Account Creation Template - ${fullname}</h1>
<!--             <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Test Generate Report</a>
 -->          </div>
    
          <hr>
          
          
        
        

       <div class="row">
     
     
     
     <div class="col-lg-8">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
           
           <%-- <div class="card-header">
				<h4 class='float-left'>
				<i class="fas fa-stamp"></i>Front Desk Templates - ${fullname}</h4>
				<form action="${pageContext.request.contextPath}/client_application" >
				
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form>
		</div> --%>
            <div class="card-body">


	    <div class="card">

		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsemaincase" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Create New Applicant Account
		            </a>
		        </h5>
		        <div id="collapsemaincase" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">

				      
                        <form method="post"   class="user" id="signUpForm" >
                            <!-- <div class="modal-body"> -->
                                                 <!-- <div class="form-group">
                                                    <label>Account Type</label>    
                                                    <select class="custom-select mb-1" id="account" name="account">
                                                       <option>Individual</option>
                                                      
                
                                                    </select>
                                                 </div>    -->
                                                 
                                                 <!-- 
                                                 <div class="form-group row">
                                  
                                                      <div class="col">
                                                      
                                                      </div>
                                                      
                                                       <div class="col">
                                                      
                                                      </div>
                                  
                                                    </div> -->
                
                                                 <div class="form-group">
                                                    <!-- <label>Name</label>
                                                    <input class="form-control form-control-lg" type="text" id="cl_name" name="cl_name" placeholder="" required="">
                                                    <small id="nameError" class="form-text text-danger "></small> -->
                                                    
                                                    
                                                    <div class="row">
                                                      <div class="col">
                                                       <label>First Name <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" placeholder="First name" id="cl_first_name" required>
                                                      </div>
                                                      <div class="col">
                                                     <label>Last Name <span class="text-danger">*</span></label>
                                                        <input type="text" class="form-control" placeholder="Last name" id="cl_last_name" required>
                                                     
                                                     
                                                      </div>
                                                      
                                                      
                                                    </div>
                                                 </div>
                                                
                                                
                                                
                                                
                                                <div class="form-group row">
                                  
                                                      <div class="col">
                                                      <label>Other Names</label>
                                                        <input type="text" class="form-control" placeholder="Other name"  id="cl_other_names" >
                                                      </div>
                                                      
                                                      <div class="col">
                                                         <label>Gender <span class="text-danger">*</span></label>    
                                                    <select class="form-control selectpicker " id="cl_gender" name="cl_gender" required>
                                                       <option value="">Select Gender</option>
                                                       <option value="Male">Male</option>
                                                       <option value="Female">Female</option> 
                                                       <option value="Couple">Couple</option>
                                                       <option value="Multiple">Multiple</option>
                                                       <option value="Company">Company</option>
                                                    </select>
                                                    <small id="genderError" class="form-text text-danger "></small>
                                                      </div>
                                  
                                                    </div>
                                                
                                              
                                              
                                            
                                                    
                                                 <div class="form-group">
                                                    <label>TIN</label>
                                                    <input class="form-control" type="text" id="cl_tin" name="tin" placeholder="tax identification number">
                                                    <!--<small id="tinError" class="form-text text-danger "></small>-->
                                                 </div>
                                                
                                                 <div class="form-group row">
                                  
                                                      <div class="col">
                                                          <label>ID Type <span class="text-danger">*</span></label>    
                                                    <select class="custom-select mb-1" id="cl_id_type" name="idType" required>
                                                       <option></option>
                                                       <option>National ID</option>
                                                       <option>Ghana Card</option>
                                                       <option>Passport</option>
                                                       <option>Drivers License</option>
                                                       <option>Voters ID</option>
                                                       <option>NHIS</option>
                                                    </select>
                                                    <small id="idTypeError" class="form-text text-danger "></small>
                                                      </div>
                                                      
                                                       <div class="col">
                                                       <label>ID Number <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" id="cl_id_number" name="idNum" placeholder="" required>
                                                    <small id="idNumError" class="form-text text-danger "></small>
                                                      </div>
                                  
                                                    </div>
                                                
                                                
                                                <div class="form-group row">
                                  
                                                      <div class="col">
                                                              <label>Email <span class="text-danger">*</span></label>
                                                            <input class="form-control" type="text" id="cl_email" name="cl_email" placeholder="" required>
                                                            <small id="emailError" class="form-text text-danger "></small>
                                                      </div>
                                                      
                                                       <div class="col">
                                                      <label>Country <span class="text-danger">*</span></label>    
                                                    <select class="custom-select mb-1" id="cl_country" name="cl_country" required>
                                                       <option>Ghana</option>
                                                       <option>Afghanistan</option>
                                                       <option>Albania</option>
                                                       <option>Algeria</option>
                                                       <option>Andorra</option>
                                                       <option>Angola</option>
                                                       <option>Antigua and Barbuda</option>
                                                       <option>Argentina</option>
                                                       <option>Armenia</option>
                                                       <option>Australia</option>
                                                       <option>Austria</option>
                                                       <option>Azerbaijan</option>
                                                       <option>The Bahamas</option>
                                                       <option>Bahrain</option>
                                                       <option>Bangladesh</option>
                                                       <option>Barbados</option>
                                                       <option>Belarus</option>
                                                       <option>Belgium</option>
                                                       <option>Belize</option>
                                                       <option>Benin</option>
                                                       <option>Bhutan</option>
                                                       <option>Bolivia</option>
                                                       <option>Bosnia and Herzegovina</option>
                                                       <option>Botswana</option>
                                                       <option>Brazil</option>
                                                       <option>Brunei</option>
                                                       <option>Bulgaria</option>
                                                       <option>Burkina Faso</option>
                                                       <option>Burundi</option>
                                                       <option>Cambodia</option>
                                                       <option>Cameroon</option>
                                                       <option>Canada</option>
                                                       <option>Cape Verde</option>
                                                       <option>Central African Republic</option>
                                                       <option>Chad</option>
                                                       <option>Chile</option>
                                                       <option>China</option>
                                                       <option>Colombia</option>
                                                       <option>Comoros</option>
                                                       <option>Congo, Republic of the</option>
                                                       <option>Congo, Democratic Republic of the</option>
                                                       <option>Costa Rica</option>
                                                       <option>Cote d'Ivoire</option>
                                                       <option>Croatia</option>
                                                       <option>Cuba</option>
                                                       <option>Cyprus</option>
                                                       <option>Czech Republic</option>
                                                       <option>Denmark</option>
                                                       <option>Djibouti</option>
                                                       <option>Dominica</option>
                                                       <option>Dominican Republic</option>
                                                       <option>East Timor (Timor-Leste)</option>
                                                       <option>Ecuador</option>
                                                       <option>Egypt</option>
                                                       <option>El Salvador</option>
                                                       <option>Equatorial Guinea</option>
                                                       <option>Eritrea</option>
                                                       <option>Estonia</option>
                                                       <option>Ethiopia</option>
                                                       <option>Fiji</option>
                                                       <option>Finland</option>
                                                       <option>France</option>
                                                       <option>Gabon</option>
                                                       <option>The Gambia</option>
                                                       <option>Georgia</option>
                                                       <option>Germany</option>
                                                       <option>Ghana</option>
                                                       <option>Greece</option>
                                                       <option>Grenada</option>
                                                       <option>Guatemala</option>
                                                       <option>Guinea</option>
                                                       <option>Guinea-Bissau</option>
                                                       <option>Guyana</option>
                                                       <option>Haiti</option>
                                                       <option>Honduras</option>
                                                       <option>Hungary</option>
                                                       <option>Iceland</option>
                                                       <option>India</option>
                                                       <option>Indonesia</option>
                                                       <option>Iran</option>
                                                       <option>Iraq</option>
                                                       <option>Ireland</option>
                                                       <option>Israel</option>
                                                       <option>Italy</option>
                                                       <option>Jamaica</option>
                                                       <option>Japan</option>
                                                       <option>Jordan</option>
                                                       <option>Kazakhstan</option>
                                                       <option>Kenya</option>
                                                       <option>Kiribati</option>
                                                       <option>Korea, North</option>
                                                       <option>Korea, South</option>
                                                       <option>Kosovo</option>
                                                       <option>Kuwait</option>
                                                       <option>Kyrgyzstan</option>
                                                       <option>Laos</option>
                                                       <option>Latvia</option>
                                                       <option>Lebanon</option>
                                                       <option>Lesotho</option>
                                                       <option>Liberia</option>
                                                       <option>Libya</option>
                                                       <option>Liechtenstein</option>
                                                       <option>Lithuania</option>
                                                       <option>Luxembourg</option>
                                                       <option>Macedonia</option>
                                                       <option>Madagascar</option>
                                                       <option>Malawi</option>
                                                       <option>Malaysia</option>
                                                       <option>Maldives</option>
                                                       <option>Mali</option>
                                                       <option>Malta</option>
                                                       <option>Marshall Islands</option>
                                                       <option>Mauritania</option>
                                                       <option>Mauritius</option>
                                                       <option>Mexico</option>
                                                       <option>Micronesia, Federated States of</option>
                                                       <option>Moldova</option>
                                                       <option>Monaco</option>
                                                       <option>Mongolia</option>
                                                       <option>Montenegro</option>
                                                       <option>Morocco</option>
                                                       <option>Mozambique</option>
                                                       <option>Myanmar (Burma)</option>
                                                       <option>Namibia</option>
                                                       <option>Nauru</option>
                                                       <option>Nepal</option>
                                                       <option>Netherlands</option>
                                                       <option>New Zealand</option>
                                                       <option>Nicaragua</option>
                                                       <option>Niger</option>
                                                       <option>Nigeria</option>
                                                       <option>Norway</option>
                                                       <option>Oman</option>
                                                       <option>Pakistan</option>
                                                       <option>Palau</option>
                                                       <option>Panama</option>
                                                       <option>Papua New Guinea</option>
                                                       <option>Paraguay</option>
                                                       <option>Peru</option>
                                                       <option>Philippines</option>
                                                       <option>Poland</option>
                                                       <option>Portugal</option>
                                                       <option>Qatar</option>
                                                       <option>Romania</option>
                                                       <option>Russia</option>
                                                       <option>Rwanda</option>
                                                       <option>Saint Kitts and Nevis</option>
                                                       <option>Saint Lucia</option>
                                                       <option>Saint Vincent and the Grenadines</option>
                                                       <option>Samoa</option>
                                                       <option>San Marino</option>
                                                       <option>Sao Tome and Principe</option>
                                                       <option>Saudi Arabia</option>
                                                       <option>Senegal</option>
                                                       <option>Serbia</option>
                                                       <option>Seychelles</option>
                                                       <option>Sierra Leone</option>
                                                       <option>Singapore</option>
                                                       <option>Slovakia</option>
                                                       <option>Slovenia</option>
                                                       <option>Solomon Islands</option>
                                                       <option>Somalia</option>
                                                       <option>South Africa</option>
                                                       <option>South Sudan</option>
                                                       <option>Spain</option>
                                                       <option>Sri Lanka</option>
                                                       <option>Sudan</option>
                                                       <option>Suriname</option>
                                                       <option>Swaziland</option>
                                                       <option>Sweden</option>
                                                       <option>Switzerland</option>
                                                       <option>Syria</option>
                                                       <option>Taiwan</option>
                                                       <option>Tajikistan</option>
                                                       <option>Tanzania</option>
                                                       <option>Thailand</option>
                                                       <option>Togo</option>
                                                       <option>Tonga</option>
                                                       <option>Trinidad and Tobago</option>
                                                       <option>Tunisia</option>
                                                       <option>Turkey</option>
                                                       <option>Turkmenistan</option>
                                                       <option>Tuvalu</option>
                                                       <option>Uganda</option>
                                                       <option>Ukraine</option>
                                                       <option>United Arab Emirates</option>
                                                       <option>United Kingdom</option>
                                                       <option>United States of America</option>
                                                       <option>Uruguay</option>
                                                       <option>Uzbekistan</option>
                                                       <option>Vanuatu</option>
                                                       <option>Vatican City (Holy See)</option>
                                                       <option>Venezuela</option>
                                                       <option>Vietnam</option>
                                                       <option>Yemen</option>
                                                       <option>Zambia</option>
                                                       <option>Zimbabwe</option>
                
                                                    </select>
                                                    <small id="countryError" class="form-text text-danger "></small>
                                                      </div>
                                  
                                                    </div>
                                                    
                                                    
                                                
                                                 
                                                 <div class="form-group row">
                                  
                                                      <div class="col">
                                                       <label>Address <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" id="cl_address" name="cl_address" required>
                                                      </div>
                                                      
                                                       <div class="col">
                                                      <label>Phone <span class="text-danger">*</span></label>
                                                    <input class="form-control" type="text" id="cl_phone" name="cl_phone" placeholder="Eg. 233200000000" required>
                                                    <small id="phoneError" class="form-text text-danger "></small>
                                                      </div>
                                  
                                                    </div>
                
                                                 <div class="form-group row">
                                  
                                                      <div class="col">
                                                       <label>Contact Person</label>
                                                            <input class="form-control" type="text" id="cl_contact_person" name="contactPerson" placeholder="">
                                                      </div>
                                                      
                                                       <div class="col">
                                                       <label>Contact Person's Phone</label>
                                                    <input class="form-control" type="text" id="cl_contact_person_phone"  placeholder="Eg. 233200000000">
                                                    <small id="contactPersonPhoneError" class="form-text text-danger "></small>
                                                      </div>
                                  
                                                    </div>
                                                 
                                                
                                                 
                                              
                        
                
                            <!-- </div> -->
                               <!-- <div class="modal-footer"> -->
                                            <button type="submit" id="btn_save_client_details"
                                            class="btn btn-primary btn-user btn-block">Save Account Details</button>
                                            <button type="reset" class="btn btn-google btn-user btn-block"
                                                data-dismiss="modal">Reset</button>
                                        <!-- </div> -->
                                        
                            </form>
					        
		                
		            </div>
		        </div>
		    </div>
      
          
            </div>
          
          </div>
          
         
        
    
   
        
      </div>
      
      
      
      
    <!--   Here is the right Table -->
        <div class="col-lg-4">
          <!-- Example Pie Chart Card-->
          
          
          
          	    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapselistofservices" aria-expanded="false" aria-controls="collapseFive">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fa fa-users"></i>Instructions
		            </a>
		        </h5>
		        <div id="collapselistofservices" class="collapse show" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		                
		               
		               
		               
		               
		               
		               
		       <!--   <form action="http://localhost:8080/lccorporate/Login" method="post">
				
				
				  <input type="hidden" id="username" name="username"  value="jecd@gmail.com">
				    <input type="hidden" id="password" name="password"  value="win">
				<button type="submit"  class="btn btn-primary btn-icon-split float-right" >
				<span class="icon text-white-50"> <i class="fas fa-angle-double-left"></i></span><span class="text">Back</span>
				</button>
				</form> -->
		               

		            </div>
		        </div>
		    </div>
		  
		  
		  
		  
		  
	
		  
		  
		    <br>
          
          
          
          <div id="accordion" role="tablist" aria-multiselectable="true">
		   
		   
		   
		 
		    <div class="card">
		        <h5 class="card-header" role="tab" id="headingThree">
		            <a class="collapsed d-block" data-toggle="collapse" data-parent="#accordion" href="#collapsedocs" aria-expanded="false" aria-controls="collapseThree">
		                <i class="fa fa-chevron-down pull-right"></i> <i class="fas fa-file-alt"></i>Reports
		            </a>
		        </h5>
		        <div id="collapsedocs" class="collapse" role="tabpanel" aria-labelledby="headingThree">
		            <div class="card-body">
		               
		               
		        
		            </div>
		        </div>
		    </div>
		    <br>
		    
		    
		    
		    
		    
		      
		    
	

		    
		</div>

      </div>
      
     </div>
      
       

           
        

        </div>
        <!-- /.container-fluid -->

    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
  
  
  
  

