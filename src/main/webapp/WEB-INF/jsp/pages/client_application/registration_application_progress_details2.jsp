 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix ="c" %>
<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="ws.users.Ws_users" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>

<%@ page import="org.codehaus.jettison.json.JSONArray" %>
<%@ page import="org.codehaus.jettison.json.JSONException" %>
<%@ page import="org.codehaus.jettison.json.JSONObject" %>


  <jsp:include page="../includes/_header.jsp"></jsp:include>
  

  <% 


	  
%>

  
  


    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.jsp">Data Capture</a>
        </li>
        <li class="breadcrumb-item active">Maps</li>
      </ol>
           
           
      
      
      
       <div class="row">
     <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
         
          
          
          
					          
					      
							   <!-- wizard start wizard end -->
							   <section class="signup-step-container">
					        <div class="container">
					            <div class="row d-flex justify-content-center">
					                <div class="col-md-8">
					                    <div class="wizard">
					                        <div class="wizard-inner">
					                            <div class="connecting-line"></div>
					                            <ul class="nav nav-tabs" role="tablist">
					                                <li role="presentation" class="active">
					                                    <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" aria-expanded="true"><span class="round-tab">1 </span> <i>Step 1</i></a>
					                                </li>
					                                <li role="presentation" class="disabled">
					                                    <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" aria-expanded="false"><span class="round-tab">2</span> <i>Step 2</i></a>
					                                </li>
					                                <li role="presentation" class="disabled">
					                                    <a href="#step3" data-toggle="tab" aria-controls="step3" role="tab"><span class="round-tab">3</span> <i>Step 3</i></a>
					                                </li>
					                                <li role="presentation" class="disabled">
					                                    <a href="#step4" data-toggle="tab" aria-controls="step4" role="tab"><span class="round-tab">4</span> <i>Step 4</i></a>
					                                </li>
					                            </ul>
					                        </div>
					        
					                        <form role="form" action="index.html" class="login-box">
					                            <div class="tab-content" id="main_form">
					                                <div class="tab-pane active" role="tabpanel" id="step1">
					                                    <h4 class="text-center">Step 1</h4>
					                                    <div class="row">
					                                        <div class="col-md-6">
					                                            <div class="form-group">
					                                                <label>First and Last Name *</label> 
					                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                            </div>
					                                        </div>
					                                        <div class="col-md-6">
					                                            <div class="form-group">
					                                                <label>Phone Number  *</label> 
					                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                            </div>
					                                        </div>
					                                        <div class="col-md-6">
					                                            <div class="form-group">
					                                                <label>Email Address *</label> 
					                                                <input class="form-control" type="email" name="name" placeholder=""> 
					                                            </div>
					                                        </div>
					                                        
					                                        <div class="col-md-6">
					                                            <div class="form-group">
					                                                <label>Password *</label> 
					                                                <input class="form-control" type="password" name="name" placeholder=""> 
					                                            </div>
					                                        </div>
					                                        
					                                        
					                                    </div>
					                                    <ul class="list-inline pull-right">
					                                        <li><button type="button" class="default-btn next-step">Continue to next step</button></li>
					                                    </ul>
					                                </div>
					                                <div class="tab-pane" role="tabpanel" id="step2">
					                                    <h4 class="text-center">Step 2</h4>
					                                    <div class="row">
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Address 1 *</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>City / Town *</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Country *</label> 
					                                            <select name="country" class="form-control" id="country">
					                                                <option value="NG" selected="selected">Nigeria</option>
					                                                <option value="NU">Niue</option>
					                                                <option value="NF">Norfolk Island</option>
					                                                <option value="KP">North Korea</option>
					                                                <option value="MP">Northern Mariana Islands</option>
					                                                <option value="NO">Norway</option>
					                                            </select>
					                                        </div>
					                                    </div>
					                                    
					                                    
					                                    
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Registration No.</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                   </div>
					                                    
					                                    
					                                    <ul class="list-inline pull-right">
					                                        <li><button type="button" class="default-btn prev-step">Back</button></li>
					                                        <li><button type="button" class="default-btn next-step skip-btn">Skip</button></li>
					                                        <li><button type="button" class="default-btn next-step">Continue</button></li>
					                                    </ul>
					                                </div>
					                                <div class="tab-pane" role="tabpanel" id="step3">
					                                    <h4 class="text-center">Step 3</h4>
					                                     <div class="row">
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Account Name *</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Demo</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Inout</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Information</label> 
					                                            <div class="custom-file">
					                                              <input type="file" class="custom-file-input" id="customFile">
					                                              <label class="custom-file-label" for="customFile">Select file</label>
					                                            </div>
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Number *</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                    <div class="col-md-6">
					                                        <div class="form-group">
					                                            <label>Input Number</label> 
					                                            <input class="form-control" type="text" name="name" placeholder=""> 
					                                        </div>
					                                    </div>
					                                       </div>
					                                    <ul class="list-inline pull-right">
					                                        <li><button type="button" class="default-btn prev-step">Back</button></li>
					                                        <li><button type="button" class="default-btn next-step skip-btn">Skip</button></li>
					                                        <li><button type="button" class="default-btn next-step">Continue</button></li>
					                                    </ul>
					                                </div>
					                                <div class="tab-pane" role="tabpanel" id="step4">
					                                    <h4 class="text-center">Step 4</h4>
					                                    <div class="all-info-container">
					                                        <div class="list-content">
					                                            <a href="#listone" data-toggle="collapse" aria-expanded="false" aria-controls="listone">Collapse 1 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listone">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>First and Last Name *</label> 
					                                                                <input class="form-control" type="text"  name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Phone Number *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                        <div class="list-content">
					                                            <a href="#listtwo" data-toggle="collapse" aria-expanded="false" aria-controls="listtwo">Collapse 2 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listtwo">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Address 1 *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>City / Town *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Country *</label> 
					                                                                <select name="country2" class="form-control" id="country2" disabled="disabled">
					                                                                    <option value="NG" selected="selected">Nigeria</option>
					                                                                    <option value="NU">Niue</option>
					                                                                    <option value="NF">Norfolk Island</option>
					                                                                    <option value="KP">North Korea</option>
					                                                                    <option value="MP">Northern Mariana Islands</option>
					                                                                    <option value="NO">Norway</option>
					                                                                </select>
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Legal Form</label> 
					                                                                <select name="legalform2" class="form-control" id="legalform2" disabled="disabled">
					                                                                    <option value="" selected="selected">-Select an Answer-</option>
					                                                                    <option value="AG">Limited liability company</option>
					                                                                    <option value="GmbH">Public Company</option>
					                                                                    <option value="GbR">No minimum capital, unlimited liability of partners, non-busines</option>
					                                                                </select> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Business Registration No.</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Registered</label> 
					                                                                <select name="vat2" class="form-control" id="vat2" disabled="disabled">
					                                                                    <option value="" selected="selected">-Select an Answer-</option>
					                                                                    <option value="yes">Yes</option>
					                                                                    <option value="no">No</option>
					                                                                </select> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Seller</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                        <div class="col-md-12">
					                                                            <div class="form-group">
					                                                                <label>Company Name *</label> 
					                                                                <input class="form-control" type="password" name="name" placeholder="" disabled="disabled"> 
					                                                            </div>
					                                                        </div>
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                        <div class="list-content">
					                                            <a href="#listthree" data-toggle="collapse" aria-expanded="false" aria-controls="listthree">Collapse 3 <i class="fa fa-chevron-down"></i></a>
					                                            <div class="collapse" id="listthree">
					                                                <div class="list-box">
					                                                    <div class="row">
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Name *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                        
					                                                        <div class="col-md-6">
					                                                            <div class="form-group">
					                                                                <label>Number *</label> 
					                                                                <input class="form-control" type="text" name="name" placeholder=""> 
					                                                            </div>
					                                                        </div>
					                                                        
					                                                    </div>
					                                                </div>
					                                            </div>
					                                        </div>
					                                    </div>
					                                    
					                                    <ul class="list-inline pull-right">
					                                        <li><button type="button" class="default-btn prev-step">Back</button></li>
					                                        <li><button type="button" class="default-btn next-step">Finish</button></li>
					                                    </ul>
					                                </div>
					                                <div class="clearfix"></div>
					                            </div>
					                            
					                        </form>
					                    </div>
					                </div>
					            </div>
					        </div>
					    </section>
    
          
          
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
      
        
      
       <div class="row">
     <div class="col-lg-6">
          <!-- Example Bar Chart Card-->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fa fa-bar-chart"></i>Map sample</div>
            <div class="card-body">
            
         
          
          
          
					          
					      
							   <!-- wizard start wizard end -->
							 <!-- External toolbar sample -->
        <div class="row d-flex align-items-center p-3 my-3 text-white-50">
            <div class="col-12 col-lg-6 col-sm-12">
              <label>Theme:</label>
              <select id="theme_selector" class="custom-select col-lg-6 col-sm-12">
                    <option value="default">default</option>
                    <option value="arrows">arrows</option>
                    <option value="circles">circles</option>
                    <option value="dots">dots</option>
              </select>
            </div>
            <div class="col-12 col-lg-6 col-sm-12">
              <label>External Buttons:</label>
              <div class="btn-group col-lg-6 col-sm-12" role="group">
                  <button class="btn btn-secondary" id="prev-btn" type="button">Go Previous</button>
                  <button class="btn btn-secondary" id="next-btn" type="button">Go Next</button>
                  <button class="btn btn-danger" id="reset-btn" type="button">Reset Wizard</button>
              </div>
            </div>
        </div>

        <!-- SmartWizard html -->
        <div id="smartwizard">
            <ul>
                <li><a href="#step-1">Step 1<br /><small>This is step description</small></a></li>
                <li><a href="#step-2">Step 2<br /><small>This is step description</small></a></li>
                <li><a href="#step-3">Step 3<br /><small>This is step description</small></a></li>
                <li><a href="#step-4">Step 4<br /><small>This is step description</small></a></li>
            </ul>

            <div>
                <div id="step-1" class="">
                    <h3 class="border-bottom border-gray pb-2">Step 1 Content</h3>
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                </div>
                <div id="step-2" class="">
                    <h3 class="border-bottom border-gray pb-2">Step 2 Content</h3>
                    <div>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. </div>
                </div>
                <div id="step-3" class="">
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                </div>
                <div id="step-4" class="">
                    <h3 class="border-bottom border-gray pb-2">Step 4 Content</h3>
                    <div class="card">
                        <div class="card-header">My Details</div>
                        <div class="card-block p-0">
                          <table class="table">
                              <tbody>
                                  <tr> <th>Name:</th> <td>Tim Smith</td> </tr>
                                  <tr> <th>Email:</th> <td>example@example.com</td> </tr>
                              </tbody>
                          </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
							
          
            
          
            </div>
            <div class="card-footer small text-muted">Registration Process Movement</div>
          </div>
          
         
        
    
   
        
      </div>
     </div>
      
      
   
      
    </div>
  

 
    
  <jsp:include page="../includes/_footer.jsp"></jsp:include>
  
