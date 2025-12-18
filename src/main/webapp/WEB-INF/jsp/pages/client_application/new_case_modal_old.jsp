<%@ page import="ws.casemgt.Ws_client_application" %>
<%@ page import="org.codehaus.jettison.json.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>


<% 
String id =request.getParameter("cafeId");
System.out.println("working " + id);
%>

      

 <div class="modal-header" id="bg">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="myFunction()"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Create a new Case</h4>
      </div>
      <div class="modal-body" id="bg">
     
<div class="progress">
    <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
  </div>
  <form id="regiration_form" novalidate action=""  method="post">
  <fieldset>
    <h2>Step Service Selection</h2>
	     <div class="form-group">
          <label for="main_service">Main Service</label>
                  <select name="id" id="main_service"  onchange="this.form.submit();"class="form-control input-sm" data-style="btn-info"  data-live-search="true">
                  <option value="-1">Select Main Service</option>
                  <% 
                  try {
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_services();			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_id = (String) jsonObject.getString("business_process_id");
                          String business_process_name = (String) jsonObject.getString("business_process_name");
                          %>
                          <option value="<%=business_process_id%>"><%=business_process_name%></option>
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>
          </div>
           <div class="form-group">
          <label for="sub_service">Sub Service</label>
                  <select name="sub_service" class="form-control input-sm" data-style="btn-info" data-live-search="true">
                    <option value="-1">Select Sub Service</option>
                  <% 
                  try {
                	  String userName = request.getParameter("business_process_id");
                	  
                	  Ws_client_application user_web_service = new Ws_client_application();
              		
              		String jsonArrayContent =null;
              		jsonArrayContent =user_web_service.get_list_of_sub_services(userName);			
              		//response.setContentType("application/json");
              		//response.getWriter().print(jsonArrayContent);
              		JSONArray jArr;
            		
            			jArr = new JSONArray(jsonArrayContent);
            			for (int i=0; i < jArr.length(); i++) {
                          JSONObject jsonObject = jArr.getJSONObject(i);
                          
                          String business_process_id = (String) jsonObject.getString("business_process_id");
                          String business_process_name = (String) jsonObject.getString("business_process_name");
                          %>
                           <option value="<%=userName%>"><%=userName%></option>
                          <option value="<%=business_process_id%>"><%=business_process_name%></option>
                          <% 
                          
                          
            			}
                  }
                  catch (Exception e){
                	  e.printStackTrace();
                  }
                  
                  %>
                </select>
          </div>
    <input type="button" name="next" class="next btn btn-info" value="Next" />
  </fieldset>
  <fieldset>
    <h2>Step 1: BIO DATA</h2>
	    <div class="form-group">
	    	<label for="memfullname">FULL NAME</label>
	    	<input type="text" class="form-control input-sm" id="fullname" name="memfullname" value="<%= id %>">
	    	<!-- <input type="text" class="form-control input-sm" id="fullname" name="memfullname" placeholder="Enter Full Name"> -->
	    </div>
	    	<div class="row">
		    	<div class="col-md-6">	
			    	<div class="form-group">
			          <label for="memgender">GENDER</label>
			                  <select name="memgender" class="form-control input-sm">
			                    <option value="male">Male</option>
			                    <option value="female">Female</option>
			                </select>
			          </div>
			    </div>
			    <div class="col-md-6">
			          <div class="form-group">
				    	<label for="memdob">DATE OF BIRTH</label>
				    	<input type="text" class="form-control input-sm tcal" id="dob" name="memdob">
				    </div>
				</div>
			</div>
	    <div class="form-group">
	    	<label for="memhometown">HOME TOWN</label>
	    	<input type="text" class="form-control input-sm" id="hometown" name="memhometown">
	    </div>
	    <div class="form-group">
          <label for="memmaritalstatus">MARITAL STATUS</label>
                  <select name="memmaritalstatus" class="form-control input-sm" data-style="btn-info" multiple data-max-options="2" data-live-search="true">
                    <option value="single">SINGLE</option>
                    <option value="married">MARRIED</option>
                    <option value="divorced">DIVORCED</option>
                </select>
          </div>
          <div class="form-group">
                <label for="mempic">UPLOAD PROFILE PICTURE</label>
                <input type="file" class="form-control input-sm" name="file">
            </div>
    <input type="button" name="next" class="next btn btn-info" value="Next" />
  </fieldset>
  <fieldset>
    <h2> Step 2: NEXT OF KIN DETAILS</h2>
    <div class="form-group">
	    <label for="kinfullname">FULL NAME</label>
	    <input type="text" class="form-control" name="kinfullname" id="kinfullname" placeholder="Enter fullname">
    </div>
    <div class="form-group">
	    <label for="kinphonenum">PHONE NUMBER</label>
	    <input type="text" class="form-control" name="kinphonenum" id="kinphonenum" placeholder="Enter Phone number">
    </div>
    <input type="button" name="previous" class="previous btn btn-default" value="Previous" />
    <input type="button" name="next" class="next btn btn-info" value="Next" />
  </fieldset>
  <fieldset>
    <h2>Step 3: LISAG MEMEBERSHIP</h2>
    <div class="form-group">
	    <label for="memlicennum">LICENCE NUMBER</label>
	    <input type="text" class="form-control" id="memlicennum" name="memlicennum" placeholder="Mobile Number">
    </div>
    <div class="form-group">
	    <label for="meminduction">INDUCTION YEAR</label>
	    <input type="text" class="form-control" id="memlicennum" name="memlicennum" placeholder="Induction year">
    </div>
    <div class="row">
    	<div class="col-md-6">
    		<div class="form-group">
			    <label for="memphonenum1">PHONE NUMBER 1</label>
			    <input type="text" class="form-control" name="memphonenum1" id="memphonenum1" placeholder="Enter Phone number">
   			 </div>
    	</div>
    	<div class="col-md-6">
    		<div class="form-group">
			    <label for="memphonenum2">PHONE NUMBER 2</label>
			    <input type="text" class="form-control" name="memphonenum2" id="memphonenum2" placeholder="Enter Phone number">
    		</div>
    	</div>
    </div>
    	<div class="row">
	    	<div class="col-md-6">	
			    <div class="form-group">
				    <label for="mememail">EMAIL</label>
				    <input type="email" class="form-control" name="mememail" id="mememail" placeholder="Enter email of member">
			    </div>
			</div>
			<div class="col-md-6">
			    <div class="form-group">
				    <label for="memecity">CITY</label>
				    <input type="email" class="form-control" name="memecity" id="memecity" placeholder="Enter city of member">
			    </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
			    <div class="form-group">
				    <label for="membussaddress">BUSINESS ADDRESS</label>
				    <input type="email" class="form-control" name="membussaddress" id="membussaddress" placeholder="Enter business address of member">
			    </div>
			</div>
			<div class="col-md-6">
			    <div class="form-group">
				    <label for="memresaddress">RESIDENTIAL ADDRESS</label>
				    <input type="email" class="form-control" name="memresaddress" id="memresaddress" placeholder="Enter residential address of member">
			    </div>
			</div>
		</div>
    <div class="form-group">
          <label for="memstatus">STATUS</label>
                  <select name="memstatus" class="form-control input-sm">
                    <option value="active">ACTIVE</option>
                    <option value="inactive">INACTIVE</option>
                </select>
          </div>
    <input type="button" name="previous" class="previous btn btn-default" value="Previous" />
	<input type="button" name="next" class="next btn btn-info" value="Next" />
  </fieldset>
   <fieldset>
    <h2>Step 4: BANK DETAILS</h2>
    <div class="form-group">
	    <label for="membankname">BANK NAME</label>
	    <input type="text" class="form-control" id="membankname" name="membankname" placeholder="Enter name of bank">
    </div>
    <div class="form-group">
	    <label for="membankaccname">BANK ACCOUNT NAME</label>
	    <input type="text" class="form-control" id="membankaccname" name="membankaccname" placeholder="Enter bank account name">
    </div>
       
    		<div class="form-group">
			    <label for="membankaccnum">BANK ACCOUNT NUMBER</label>
			    <input type="text" class="form-control" name="membankaccnum" id="membankaccnum" placeholder="Enter bank account number">
   			 </div>
    	
    	
    		<div class="form-group">
			    <label for="membankbranch">BANK BRANCH</label>
			    <input type="text" class="form-control" name="membankbranch" id="membankbranch" placeholder="Enter bank branch">
    		</div>
    
    
    <input type="button" name="previous" class="previous btn btn-default" value="Previous" />
    <input type="submit" name="submit" class="submit btn btn-success" value="Submit" />
  </fieldset>
  </form>
</div>




  