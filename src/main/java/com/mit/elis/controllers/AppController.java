package com.mit.elis.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Enumeration;
import java.util.regex.Pattern;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

// import com.sun.org.apache.xerces.internal.impl.dv.util.HexBin;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.mit.elis.class_common.Ws_url_config;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import ch.qos.logback.core.boolex.Matcher;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_general_query;
import ws.casemgt.ws_professional_portal;
import ws.csaumgt.ws_baby_steps;
import ws.rentmgt.Ws_rent_mgt;
import ws.users.Ws_users;

@Controller
public class AppController {
	@Autowired
	private Ws_url_config cls_url_config;
	// Ws_users cls_users = new Ws_users();

	cls_general_query general_q_cl = new cls_general_query();
	Ws_client_application user_web_service = new Ws_client_application();
	Ws_users cls_users = new Ws_users();
	cls_casemgt casemagt_cl = new cls_casemgt();
	cls_casemgt casemgt_cl = new cls_casemgt();
	ws_baby_steps baby_step_cl = new ws_baby_steps();
	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	Pattern macpt = null;

	private String getMac(String ip) {

		// Find OS and set command according to OS
		String OS = System.getProperty("os.name").toLowerCase();
		System.out.println(OS);
		//System.out.println(ip);

		String[] cmd;
		if (OS.contains("win")) {
			// Windows
			macpt = Pattern
					.compile("[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+");
			String[] a = { "arp", "-a", ip };
			cmd = a;
		} else {
			// Mac OS X, Linux
			macpt = Pattern
					.compile("[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+");
			String[] a = { "arp", ip };
			cmd = a;
		}

		try {
			// Run command
			Process p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			// read output with BufferedReader
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					p.getInputStream()));
			String line = reader.readLine();
			// Loop trough lines
			while (line != null) {
				java.util.regex.Matcher m = macpt.matcher(line);
				// when Matcher finds a Line then return it as result
				if (m.find()) {
					System.out.println("Found");
					System.out.println("MAC: " + m.group(0));
					return m.group(0);
				}

				line = reader.readLine();
			}

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// Return empty string if no MAC is found
		return "";
	}

	public String getMacAddress() throws Exception {
		String macAddress = null;
		String command = "ifconfig";
	
		String osName = System.getProperty("os.name");
		System.out.println("Operating System is " + osName);
	
		if (osName.startsWith("Windows")) {
			command = "ipconfig /all";
		} else if (osName.startsWith("Linux") || osName.startsWith("Mac") || osName.startsWith("HP-UX")
				|| osName.startsWith("NeXTStep") || osName.startsWith("Solaris") || osName.startsWith("SunOS")
				|| osName.startsWith("FreeBSD") || osName.startsWith("NetBSD")) {
			command = "ifconfig -a";
		} else if (osName.startsWith("OpenBSD")) {
			command = "netstat -in";
		} else if (osName.startsWith("IRIX") || osName.startsWith("AIX") || osName.startsWith("Tru64")) {
			command = "netstat -ia";
		} else if (osName.startsWith("Caldera") || osName.startsWith("UnixWare") || osName.startsWith("OpenUNIX")) {
			command = "ndstat";
		} else {// Note: Unsupported system.
			throw new Exception("The current operating system '" + osName + "' is not supported.");
		}
	
		@SuppressWarnings("deprecation")
		Process pid = Runtime.getRuntime().exec(command);
		BufferedReader in = new BufferedReader(new InputStreamReader(pid.getInputStream()));
		Pattern p = Pattern.compile("([\\w]{1,2}(-|:)){5}[\\w]{1,2}");
		while (true) {
			String line = in.readLine();
			System.out.println("line " + line);
			if (line == null)
				break;
	
			java.util.regex.Matcher m = p.matcher(line);
			if (m.find()) {
				macAddress = m.group();
				break;
			}
		}
		in.close();
		return macAddress;
	}

	public String ipAddr()
	{

		try {
			Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
			while (networkInterfaces.hasMoreElements()) {
			   NetworkInterface networkInterface = networkInterfaces.nextElement();
			   if (!networkInterface.isUp()) {
				  continue;
			   }
			   if (networkInterface.isLoopback()) {
				  continue;
			   }
			   Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
			   while (addresses.hasMoreElements()) {
				  InetAddress address = addresses.nextElement();
				  if (address.isLinkLocalAddress()) {
					 continue;
				  }
				  if (address.isSiteLocalAddress()) {
						System.out.println("IP address: " + address.getHostAddress());
						return address.getHostAddress();
				  }
			   }
			}
		 } catch (SocketException ex) {
			ex.printStackTrace();
		 }
		return null;
	}

	// @RequestMapping
	// @PostMapping("/")
	// public String home(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
	// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
	// }
@GetMapping("/")
	public String gethome(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
          model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";
	///	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
	}

	

	@RequestMapping("/multiloginlandingpage")
	@PostMapping
	public String multiloginlandingpage(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		Gson googleJson = new Gson();
		try {

			// request.setAttribute("fullname", Ws_url_config.web_fullname);
			// request.setAttribute("userid", Ws_url_config.web_useid);
			// request.setAttribute("division", Ws_url_config.web_division);
			// request.setAttribute("user_level", Ws_url_config.user_level);

			// request.setAttribute("fullname", Ws_url_config.web_fullname);
			// request.setAttribute("userid", Ws_url_config.web_useid);
			// request.setAttribute("division", Ws_url_config.web_division);
			// request.setAttribute("user_level", Ws_url_config.user_level);

			// HttpSession session = request.getSession();

			ws_professional_portal casemgt_web_service = new ws_professional_portal();

			/*
			 * RequestDispatcher rd=request.getRequestDispatcher(
			 * "/client_application/case_movement_module.jsp"); return "layouts/app";
			 * rd.include(request,response);
			 */

			request.getRequestDispatcher("/multiloginlandingpage/multiloginlandingpage.jsp").forward(request, response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/forgot_password")
	@PostMapping
	public String forgot_password(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

				model.addAttribute("content", "../pages/forgot_password.jsp"); return "layouts/app";

	}

	@SuppressWarnings("unchecked")
    public boolean loginAuthenticated(HttpSession session) {
        try {

            Map<String, Object> passKeyData = (Map<String, Object>) session.getAttribute("passKey");

            if (passKeyData != null) {
                long expiryTime = (long) passKeyData.get("expiryTime");
                if (System.currentTimeMillis() > expiryTime) {
                    session.invalidate();
                    return false;
                } else {
                    String emailaddress = (String) passKeyData.get("value");
                    // Decrypt the passkey for verification\
                    return isValidPassKey(emailaddress);
                }
            }

            return false;
        } catch (Exception e) {
            return false;
        }
    }
    
    private boolean isValidPassKey(String passKey) {
        //Implement your passkey validation logic
       //return passKey != null && !passKey.isBlank();
		return passKey != null && !passKey.trim().isEmpty();
    }

	@RequestMapping("/Login")
	@PostMapping
	public String main_dashboard(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (!loginAuthenticated(session)) {
            request.setAttribute("login", "failed_session");
            model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";

        }

		// System.out.println(userName + password);
		String web_service_response = null;
		String web_service_response_all_users = null;
		String web_service_response_verify = null;
		String new_userid = null;

		String vr_region_code = null;

		// System.out.println(userName);
		// System.out.println(password);
		// System.out.println(cls_url_config.getWeb_service_url_ser());
		// System.out.println(cls_url_config.getWeb_service_url_ser_api_key());

		try {

			String vc_1 = request.getParameter("vc_1");
			String vc_2 = request.getParameter("vc_2");
			String vc_3 = request.getParameter("vc_3");
			String vc_4 = request.getParameter("vc_4");
			String vc_5 = request.getParameter("vc_5");
			String vc_6 = request.getParameter("vc_6");

			String modified_by = (String) session.getAttribute("fullname");
			String modified_by_id = (String) session.getAttribute("user_id_init");

			String user = (String) session.getAttribute("user");
			String pass = (String) session.getAttribute("pass");
			// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

			// String userid = (String) session.getAttribute("userid");

			String full_code = vc_1 + vc_2 + vc_3 + vc_4 + vc_5 + vc_6;

			JSONObject obj_v = new JSONObject();
			obj_v.put("full_code", full_code);
			obj_v.put("user_id", modified_by_id);

			String input = obj_v.toString();
			System.out.println("code verification request");

			System.out.println(input);

			web_service_response_verify = cls_users.office_verify_verification_token(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), input);
			JSONObject obj_verify = new JSONObject(web_service_response_verify);
			String arr_verify = obj_verify.get("status").toString();

			if (arr_verify.equals("Success")) {

				web_service_response = cls_users.checkUser(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), user, pass);
				// JSONObject obj = new JSONObject();
				System.out.println(web_service_response);

				JSONObject obj_test = new JSONObject(web_service_response);
				String arr_tester = obj_test.get("data").toString();

				/* JSONArray arr_tester = obj_test.getJSONArray("data"); */

				if (arr_tester != null) {
					// System.out.println("If success");
					// System.out.println(arr_tester);

					// creating a session
					// HttpSession session = request.getSession();
					// session.setAttribute("", name);

					// do this when user login success
					// System.out.println(web_service_response);
					JSONObject obj = new JSONObject(web_service_response);
					// String pageName = obj.get("data").toString();
					String regional_code = "";
					JSONArray arr = obj.getJSONArray("data");
					// System.out.println("arra : " + arr);
					for (int i = 0; i < arr.length(); i++) {

						String fullname = arr.getJSONObject(i).getString("fullname");
						String userid = arr.getJSONObject(i).getString("userid");
						String division = arr.getJSONObject(i).getString("division");
						String user_level = arr.getJSONObject(i).getString("user_level");
						String user_phone = arr.getJSONObject(i).getString("phone");

						regional_code = arr.getJSONObject(i).getString("regional_code");
						String regional_name = arr.getJSONObject(i).getString("regional_name");
						String distict_code = arr.getJSONObject(i).getString("distict_code");
						String district_name = arr.getJSONObject(i).getString("district_name");
						String region_name = arr.getJSONObject(i).getString("region");
						String unit_name = arr.getJSONObject(i).getString("unit_name");
						String unit_id = arr.getJSONObject(i).getString("unit_id");
						String designation = arr.getJSONObject(i).getString("designation");
						String view_all_offices = arr.getJSONObject(i).getString("view_all_offices");

						vr_region_code = arr.getJSONObject(i).getString("regional_code");

						new_userid = userid;
						// System.out.println("regional code : " + regional_code);
						// System.out.println("regional code : " + web_service_response);
						/*
						 * request.setAttribute("fullname", fullname);
						 * request.setAttribute("userid", userid);
						 * request.setAttribute("division", division);
						 * request.setAttribute("user_level", user_level);
						 */
						request.setAttribute("page_name", "login");

						session.setAttribute("designation", arr.getJSONObject(i).getString("userprofile"));
						session.setAttribute("emailaddress", arr.getJSONObject(i).getString("emailaddress"));
						session.setAttribute("staffnumber", arr.getJSONObject(i).getString("staffnumber"));
						session.setAttribute("username", arr.getJSONObject(i).getString("username"));
						session.setAttribute("userid", userid);
						session.setAttribute("fullname", fullname);
						session.setAttribute("division", division);
						session.setAttribute("user_level", user_level);
						session.setAttribute("user_phone", user_phone);
						session.setAttribute("view_all_offices", view_all_offices);
						session.setAttribute("unit_name", unit_name);
						session.setAttribute("unit_id", unit_id);
						session.setAttribute("regional_code", regional_code);
						session.setAttribute("regional_name", regional_name);
						session.setAttribute("region_name", region_name);
						session.setAttribute("distict_code", distict_code);
						session.setAttribute("district_name", district_name);

						session.setAttribute("designation", designation);
						/*
						 * System.out.println("unit_name :" + unit_name);
						 * System.out.println("unit_id : " + unit_id);
						 */
						// //HttpSession session = request.getSession();
						// session.setAttribute("unit_id", unit_id);

					}

					// Echo client's request information
					String request_url = request.getRequestURI();
					String protocol = request.getProtocol();
					String path_info = request.getPathInfo();
					String ip_address = request.getRemoteAddr();
					
					// String command = "/sbin/ifconfig";
					// String macAddress = "";
					// String sOsName = System.getProperty("os.name");
					// if (sOsName.startsWith("Windows")) {
					// 	command = "ipconfig";
					// } else {

					// 	if ((sOsName.startsWith("Linux")) || (sOsName.startsWith("Mac")) || (sOsName.startsWith("HP-UX"))) {
					// 		command = "/sbin/ifconfig";
					// 	} else {
					// 		System.out.println("The current operating system '" + sOsName + "' is not supported.");
					// 	}
					// }

					// Pattern p = Pattern.compile("([a-fA-F0-9]{1,2}(-|:)){5}[a-fA-F0-9]{1,2}");
					// try {
					// 	@SuppressWarnings("deprecation")
					// 	Process pa = Runtime.getRuntime().exec(command);
					// 	pa.waitFor();
					// 	BufferedReader reader = new BufferedReader(new InputStreamReader(pa.getInputStream()));

					// 	//System.out.println(reader.readLine());

					// 	//String line;
					// 	java.util.regex.Matcher m;
					// 	while ((macAddress = reader.readLine()) != null) {

					// 		m = p.matcher(macAddress);

					// 		if (!m.find())
					// 		continue;
					// 			macAddress = m.group();
					// 		break;
					// 	}
					// 	//System.out.println(line);
					// } catch (Exception e) {
					// 	e.printStackTrace();
					// }
					

					//String macAddress = getMac(macAddr()) == "" || getMac(ip_address) == null ? getMacAddress() : getMac(ip_address); 
					String macAddress = getMac(ipAddr());


					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
					LocalDateTime now = LocalDateTime.now();
					// System.out.println(dtf.format(now));

					JSONObject obj_usr_log = new JSONObject();
					obj_usr_log.put("user_id", new_userid);
					obj_usr_log.put("work_station", ip_address);
					obj_usr_log.put("ip_address", ipAddr());
					obj_usr_log.put("mac_address", macAddress);
					obj_usr_log.put("request_url", request_url);
					obj_usr_log.put("protocol", protocol);
					obj_usr_log.put("log_date", dtf.format(now));
					obj_usr_log.put("log_type", "IN");

					obj_usr_log.put("description", "User log in of the System");
					obj_usr_log.put("t_date", dtf.format(now));
					obj_usr_log.put("comp_id", "0");

					//// System.out.println("Login Logs ");
					// System.out.println(request.toString());
					System.out.println(obj_usr_log.toString());
					web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							obj_usr_log.toString());

					String web_service_response_menu = null;
					web_service_response_menu = cls_users.get_all_dashboard_menu(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							new_userid);
					JSONObject menu_obj = new JSONObject(web_service_response_menu);
					String all_menus = menu_obj.get("data").toString();

					Gson googleJson = new Gson();
					ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
					session.setAttribute("menus", javaArrayListFromGSON);
					session.setAttribute("menus_com", all_menus);

					

					// String web_service_response_milestone = null;
					// web_service_response_milestone = cls_users.select_all_assigned_milestone(
					// 		cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(),
					// 		new_userid);
					// JSONObject milestone_obj = new JSONObject(web_service_response_milestone);
					// String all_milestone = milestone_obj.get("data").toString();

					// ObjectMapper objectMapper = new ObjectMapper();
					// JsonNode jsonArray = objectMapper.readTree(all_milestone);

					// List<String> msIds = new ArrayList<>();
					// for (JsonNode node : jsonArray) {
					// 	msIds.add(node.get("ms_id").asText()); // Extract "ms_id" as a String
					// }

					// String milestone_result = String.join(",", msIds);
					// //System.out.println(milestone_result); // Output: 854,855

					// System.out.println("all_milestone: " + milestone_result);

					// // Gson googleJson = new Gson();
					// //ArrayList javaArrayListFromGSON = googleJson.fromJson(all_milestone, ArrayList.class);
					// //session.setAttribute("menus", javaArrayListFromGSON);
					// session.setAttribute("all_milestone", milestone_result);

					// session.setAttribute("user_level", user_level);

					/*
					 * String web_service_response_all_users =null;
					 * web_service_response_all_users
					 * =Ws_users.get_all_dashboard_menu(); JSONObject all_users_obj
					 * = new JSONObject(web_service_response_all_users); String
					 * all_users = all_users_obj.get("data").toString(); ArrayList
					 * javaArrayListFromGSON_users = googleJson.fromJson(all_users,
					 * ArrayList.class);
					 */
					// request.setAttribute("all_users",
					// javaArrayListFromGSON_users);

					String web_service_response_main_service = null;
					web_service_response_main_service = user_web_service
							.get_list_of_services(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject main_service_obj = new JSONObject(web_service_response_main_service);

					String all_main_service = main_service_obj.get("data").toString();

					
					String web_service_response_elis_app_levels_list = null;
					web_service_response_elis_app_levels_list = user_web_service
							.select_stp_elis_app_levels_list(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject elis_app_levels_list = new JSONObject(web_service_response_elis_app_levels_list);

					String all_elis_app_levels_list = elis_app_levels_list.get("data").toString();


					String web_service_response_temporal_service = null;
					web_service_response_temporal_service = user_web_service
							.get_list_of_temporal_service(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject temporal_service_obj = new JSONObject(web_service_response_temporal_service);

					String temporal_service = temporal_service_obj.get("data").toString();
					// ArrayList javaArrayListFromGSON_main_service =
					// googleJson.fromJson(all_main_service, ArrayList.class);
					// request.setAttribute("menus",
					// javaArrayListFromGSON_main_service);

					String web_service_response_sub_service = null;
					web_service_response_sub_service = user_web_service
							.select_business_processes_sub_list_backend(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject sub_service_obj = new JSONObject(web_service_response_sub_service);
					String all_sub_service = sub_service_obj.get("data").toString();

					String web_service_response_sub_service_all = null;
					web_service_response_sub_service_all = user_web_service
							.get_list_of_sub_services_new_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject sub_service_all_obj = new JSONObject(web_service_response_sub_service_all);
					String all_sub_service_all = sub_service_all_obj.get("data").toString();

					String web_service_response_request_purpose = null;
					web_service_response_request_purpose = user_web_service
							.get_list_of_request_purpose(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject request_purpose_obj = new JSONObject(web_service_response_request_purpose);
					String request_purpose = request_purpose_obj.get("data").toString();

					// ArrayList javaArrayListFromGSON_sub_service =
					// googleJson.fromJson(all_sub_service, ArrayList.class);
					// request.setAttribute("menus",
					// javaArrayListFromGSON_sub_service);

					String jsonArrayContent_surveyors = user_web_service
						.select_licensed_surveyors_for_reporting(cls_url_config.getWeb_service_url_ser(),
								cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject surveyors_list_obj = new JSONObject(jsonArrayContent_surveyors);
					String all_surveyors_list = surveyors_list_obj.get("data").toString();

					String web_service_response_office_data = null;

					JSONObject obj_rc = new JSONObject();

					obj_rc.put("region_code", vr_region_code);

					// obj.put("case_number", case_number);

					// String input_details = obj.toString();
					// System.out.println(obj_rc.toString());

					String jsonArrayContent_office_region = user_web_service
							.select_lc_office_regions_districts_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject office_region_obj = new JSONObject(jsonArrayContent_office_region);
					String all_list_office_region = office_region_obj.get("data").toString();

					String jsonArrayContent_division_list = casemgt_cl.divisions_get_list(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject division_list_obj = new JSONObject(jsonArrayContent_division_list);
					String all_list_division_list = division_list_obj.get("data").toString();

					String jsonArrayContent_region_list = casemgt_cl
							.get_region_list(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject region_list_obj = new JSONObject(jsonArrayContent_region_list);
					String all_list_region_list = region_list_obj.get("data").toString();

					session.setAttribute("office_region_list", all_list_office_region);
					// session.setAttribute("office_region_list_all", all_list_office_region);
					session.setAttribute("division_list", all_list_division_list);
					session.setAttribute("region_list", all_list_region_list);
					session.setAttribute("surveyors_report_list", all_surveyors_list);

					String jsonArrayContent_tags_for_batching_jobs_list = baby_step_cl
							.get_tags_for_batching_jobs_list(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), "-");

					JSONObject tags_for_batching_jobs_list_obj = new JSONObject(
							jsonArrayContent_tags_for_batching_jobs_list);
					String all_list_tags_for_batching_jobs_list = tags_for_batching_jobs_list_obj.get("data")
							.toString();
					session.setAttribute("tags_for_batching_jobs_list", all_list_tags_for_batching_jobs_list);

					web_service_response_office_data = general_q_cl
							.get_global_values(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_rc.toString());
					// web_service_response_office_data =
					// general_q_cl.get_global_values();
					JSONObject sou_obj = new JSONObject(web_service_response_office_data);

					String sms_setting = sou_obj.get("sms").toString();
					String organisation_details = sou_obj.get("orgset").toString();
					String all_users_for_batching = sou_obj.get("users").toString();

					session.setAttribute("web_list_of_users", all_users_for_batching);
					session.setAttribute("web_main_services", all_main_service);
					session.setAttribute("web_sub_services", all_sub_service);
					session.setAttribute("web_sub_services_all", all_sub_service_all);
					session.setAttribute("web_temporal_service", temporal_service);
					session.setAttribute("mac_address", macAddress);
					session.setAttribute("ip_address", ip_address);
					session.setAttribute("request_purpose_all", request_purpose);
					session.setAttribute("web_elis_app_levels", all_elis_app_levels_list);
					// System.out.println("OrgVa");
					// System.out.println(organisation_details);

					JSONArray arr_sou = new JSONArray(organisation_details);
					for (int i = 0; i < arr_sou.length(); i++) {
						String compname = arr_sou.getJSONObject(i).getString("compname");
						String comp_address = arr_sou.getJSONObject(i).getString("comp_address");
						String city = arr_sou.getJSONObject(i).getString("city");
						String fax_number = arr_sou.getJSONObject(i).getString("fax_number");
						String telephone = arr_sou.getJSONObject(i).getString("telephone");

						String email = arr_sou.getJSONObject(i).getString("email");
						String branch_of_csau = arr_sou.getJSONObject(i).getString("branch_of_csau");
						String rlo = arr_sou.getJSONObject(i).getString("rlo");
						String regional_accountant = arr_sou.getJSONObject(i).getString("regional_accountant");
						String head_of_csau = arr_sou.getJSONObject(i).getString("head_of_csau");
						String chairman_regional_land_commission = arr_sou.getJSONObject(i)
								.getString("chairman_regional_land_commission");
						String office_region = arr_sou.getJSONObject(i).getString("office_region");

						// System.out.println(fullname);
						request.setAttribute("compname", compname);
						request.setAttribute("web_comp_address", comp_address);
						request.setAttribute("web_city", city);
						request.setAttribute("web_fax_number", fax_number);
						request.setAttribute("web_telephone", telephone);
						request.setAttribute("web_email", email);
						request.setAttribute("web_branch_of_csau", branch_of_csau);
						request.setAttribute("web_rlo", rlo);
						request.setAttribute("web_regional_accountant", regional_accountant);
						request.setAttribute("web_head_of_csau", head_of_csau);
						request.setAttribute("web_chairman_regional_land_commission",
								chairman_regional_land_commission);
						request.setAttribute("web_office_region", office_region);

						session.setAttribute("web_compname", compname);
						session.setAttribute("web_comp_address", comp_address);
						session.setAttribute("web_city", city);
						session.setAttribute("web_fax_number", fax_number);
						session.setAttribute("web_telephone", telephone);
						session.setAttribute("web_email", email);
						session.setAttribute("web_branch_of_csau", branch_of_csau);
						session.setAttribute("web_rlo", rlo);
						session.setAttribute("web_regional_accountant", regional_accountant);
						session.setAttribute("web_head_of_csau", head_of_csau);
						session.setAttribute("web_chairman_regional_land_commission",
								chairman_regional_land_commission);
						session.setAttribute("web_office_region", office_region);

						/*
						 * Ws_url_config.web_compname = compname;
						 * Ws_url_config.web_comp_address = comp_address;
						 * Ws_url_config.web_city = city;
						 * Ws_url_config.web_fax_number = fax_number;
						 * Ws_url_config.web_telephone = telephone;
						 * Ws_url_config.web_email = email;
						 * Ws_url_config.web_branch_of_csau = branch_of_csau;
						 * Ws_url_config.web_rlo = rlo;
						 * Ws_url_config.web_regional_accountant =
						 * regional_accountant; Ws_url_config.web_head_of_csau =
						 * head_of_csau;
						 * Ws_url_config.web_chairman_regional_land_commission =
						 * chairman_regional_land_commission;
						 * Ws_url_config.web_office_region = office_region;
						 */
						// //HttpSession session = request.getSession();
						// session.setAttribute("uname", userid);

					}



					String web_service_response_est = null;

			web_service_response_est = rent_mgt_service.select_rt_govt_estatesg_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_est = new JSONObject(web_service_response_est);
			String estate_list = web_response_case_est.get("data").toString();
			//ArrayList estate_list_list = googleJson.fromJson(estate_list, ArrayList.class);

			session.setAttribute("estate_list", estate_list);

			String web_service_response_nt = null;

			web_service_response_nt = rent_mgt_service.select_rt_nature_of_instrument_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_nt = new JSONObject(web_service_response_nt);
			String nature_of_instrument_list = web_response_case_nt.get("data").toString();
			//ArrayList nature_of_instrument_list_list = googleJson.fromJson(nature_of_instrument_list, ArrayList.class);

			session.setAttribute("nature_of_instrument_list", nature_of_instrument_list);

			String web_service_response_na = null;

			web_service_response_na = rent_mgt_service.select_rt_nature_of_development_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_na = new JSONObject(web_service_response_na);
			String nature_of_development_list = web_response_case_na.get("data").toString();
			//ArrayList nature_of_development_list_list = googleJson.fromJson(nature_of_development_list,ArrayList.class);

			session.setAttribute("nature_of_development_list", nature_of_development_list);

			String web_service_response_us = null;

			web_service_response_us = rent_mgt_service.select_rt_user_category_list(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key());
			JSONObject web_response_case_us = new JSONObject(web_service_response_us);
			String user_category_list = web_response_case_us.get("data").toString();
			//ArrayList user_category_list_list = googleJson.fromJson(user_category_list, ArrayList.class);

			request.setAttribute("user_category_list", user_category_list);


					web_service_response_all_users = cls_users.get_all_users_short(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
					session.setAttribute("get_all_users_short", web_service_response_all_users);

					session.setAttribute("service_url", cls_url_config.getWeb_service_url_ser());
					session.setAttribute("api_key", cls_url_config.getWeb_service_url_ser_api_key());

					web_service_response = casemagt_cl.report_dashboard_all_by_user(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							new_userid);
					JSONObject dash_obj = new JSONObject(web_service_response);

					String apps_rec_month = dash_obj.get("apps_rec_month").toString();
					String apps_comp_month = dash_obj.get("apps_comp_month").toString();
					String apps_rec_year = dash_obj.get("apps_rec_year").toString();
					String apps_comp_year = dash_obj.get("apps_comp_year").toString();
					String apps_past_due_dates = dash_obj.get("apps_past_due_dates").toString();
					int completionRate = 0;

					Object crObj = dash_obj.get("completion_rate");

					if (crObj != null) {
						completionRate = Integer.parseInt(crObj.toString().replace("%", ""));
					}
					String apps_with_user = dash_obj.get("apps_with_user").toString();
					request.setAttribute("apps_with_user", apps_with_user);
					request.setAttribute("apps_rec_month", apps_rec_month);
					request.setAttribute("apps_comp_month", apps_comp_month);
					request.setAttribute("apps_rec_year", apps_rec_year);
					request.setAttribute("apps_comp_year", apps_comp_year);
					request.setAttribute("apps_past_due_dates", apps_past_due_dates);
					request.setAttribute("completion_rate", completionRate);

					//		model.addAttribute("content", "../pages/mainpage/main_dashboard.jsp"); return "layouts/app";
					

			//model.addAttribute("content", "../pages/mainpage/main_dashboard.jsp");
        	// 		return "layouts/app";

			return "redirect:/dashboard";
		

					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				} else {
					request.setAttribute("login", "failed");
					// System.out.println("If Not success");
				  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";

					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				}

			} else {
				request.setAttribute("login", "failedverificationcode");

			  model.addAttribute("content", "../auth/login.jsp");
        return "layouts/guest";

			}

			// System.out.println(pageName);

			// //HttpSession session = request.getSession();
			// session.setAttribute("username", userName);

			/*
			 * //setting session to expiry in 30 mins
			 * session.setMaxInactiveInterval(30*60); Cookie user_Name = new
			 * Cookie("user", userName); response.addCookie(user_Name);
			 */

			// }
			// else
			// {
			// out.println("Username or Password incorrect");
			// RequestDispatcher rs =
			// request.getRequestDispatcher("index.html");
			// rs.include(request, response);
			// }
			//
			// PrintWriter out = response.getWriter();
			// out.println(web_service_response);
			// } catch (JSONException e) {

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// ['success'] = true; // #15
		// ['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
		return "";
	}


	@PostMapping("/verify_google_authenticator")
		public String verify_google_authenticator(HttpSession session, Model model, HttpServletRequest request) throws JSONException {
			
			String otp = request.getParameter("otp");
			String secretKey = (String) session.getAttribute("secretKey");
			String web_service_response = null;
			String web_service_response_all_users = null;
			//String web_service_response_verify = null;
			String new_userid = null;
			String user = (String) session.getAttribute("user");
			String pass = (String) session.getAttribute("pass");

			String vr_region_code = null;

			if (secretKey == null || otp == null || otp.isEmpty()) {
				request.setAttribute("error", "Invalid request.");
						model.addAttribute("content", "../pages/configure_google_authenticator.jsp"); return "layouts/app";
			}

			JSONObject obj_v = new JSONObject();
			// obj_v.put("full_code", full_code);
			// obj_v.put("user_id", modified_by_id);

			GoogleAuthenticator gAuth = new GoogleAuthenticator();
			boolean isValid = gAuth.authorize(secretKey, Integer.parseInt(otp));

			if (isValid) {
				session.removeAttribute("secretKey"); // Clear the secret key after successful verification
				session.removeAttribute("qrCodeURL");
				session.setAttribute("googleAuthEnabled", true); // Mark Google Authenticator as enabled
				//		model.addAttribute("content", "../pages/dashboard.jsp"); return "layouts/app"; // Redirect to dashboard or desired page


				web_service_response = cls_users.checkUser(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), user, pass);
				// JSONObject obj = new JSONObject();
				System.out.println(web_service_response);

				JSONObject obj_test = new JSONObject(web_service_response);
				String arr_tester = obj_test.get("data").toString();

				/* JSONArray arr_tester = obj_test.getJSONArray("data"); */

				if (arr_tester != null) {
					// System.out.println("If success");
					// System.out.println(arr_tester);

					// creating a session
					// HttpSession session = request.getSession();
					// session.setAttribute("", name);

					// do this when user login success
					// System.out.println(web_service_response);
					JSONObject obj = new JSONObject(web_service_response);
					// String pageName = obj.get("data").toString();
					String regional_code = "";
					JSONArray arr = obj.getJSONArray("data");
					// System.out.println("arra : " + arr);
					for (int i = 0; i < arr.length(); i++) {

						String fullname = arr.getJSONObject(i).getString("fullname");
						String userid = arr.getJSONObject(i).getString("userid");
						String division = arr.getJSONObject(i).getString("division");
						String user_level = arr.getJSONObject(i).getString("user_level");
						String user_phone = arr.getJSONObject(i).getString("phone");

						regional_code = arr.getJSONObject(i).getString("regional_code");
						String regional_name = arr.getJSONObject(i).getString("regional_name");
						String distict_code = arr.getJSONObject(i).getString("distict_code");
						String district_name = arr.getJSONObject(i).getString("district_name");
						String region_name = arr.getJSONObject(i).getString("region");
						String unit_name = arr.getJSONObject(i).getString("unit_name");
						String unit_id = arr.getJSONObject(i).getString("unit_id");
						String designation = arr.getJSONObject(i).getString("designation");
						String view_all_offices = arr.getJSONObject(i).getString("view_all_offices");

						vr_region_code = arr.getJSONObject(i).getString("regional_code");

						new_userid = userid;
						// System.out.println("regional code : " + regional_code);
						// System.out.println("regional code : " + web_service_response);
						/*
						 * request.setAttribute("fullname", fullname);
						 * request.setAttribute("userid", userid);
						 * request.setAttribute("division", division);
						 * request.setAttribute("user_level", user_level);
						 */
						request.setAttribute("page_name", "login");

						session.setAttribute("designation", arr.getJSONObject(i).getString("userprofile"));
						session.setAttribute("emailaddress", arr.getJSONObject(i).getString("emailaddress"));
						session.setAttribute("staffnumber", arr.getJSONObject(i).getString("staffnumber"));
						session.setAttribute("username", arr.getJSONObject(i).getString("username"));
						session.setAttribute("userid", userid);
						session.setAttribute("fullname", fullname);
						session.setAttribute("division", division);
						session.setAttribute("user_level", user_level);
						session.setAttribute("user_phone", user_phone);
						session.setAttribute("view_all_offices", view_all_offices);
						session.setAttribute("unit_name", unit_name);
						session.setAttribute("unit_id", unit_id);
						session.setAttribute("regional_code", regional_code);
						session.setAttribute("regional_name", regional_name);
						session.setAttribute("region_name", region_name);
						session.setAttribute("distict_code", distict_code);
						session.setAttribute("district_name", district_name);

						session.setAttribute("designation", designation);
						/*
						 * System.out.println("unit_name :" + unit_name);
						 * System.out.println("unit_id : " + unit_id);
						 */
						// //HttpSession session = request.getSession();
						// session.setAttribute("unit_id", unit_id);

					}

					// Echo client's request information
					String request_url = request.getRequestURI();
					String protocol = request.getProtocol();
					String path_info = request.getPathInfo();
					String ip_address = request.getRemoteAddr();
					
					// String command = "/sbin/ifconfig";
					// String macAddress = "";
					// String sOsName = System.getProperty("os.name");
					// if (sOsName.startsWith("Windows")) {
					// 	command = "ipconfig";
					// } else {

					// 	if ((sOsName.startsWith("Linux")) || (sOsName.startsWith("Mac")) || (sOsName.startsWith("HP-UX"))) {
					// 		command = "/sbin/ifconfig";
					// 	} else {
					// 		System.out.println("The current operating system '" + sOsName + "' is not supported.");
					// 	}
					// }

					// Pattern p = Pattern.compile("([a-fA-F0-9]{1,2}(-|:)){5}[a-fA-F0-9]{1,2}");
					// try {
					// 	@SuppressWarnings("deprecation")
					// 	Process pa = Runtime.getRuntime().exec(command);
					// 	pa.waitFor();
					// 	BufferedReader reader = new BufferedReader(new InputStreamReader(pa.getInputStream()));

					// 	//System.out.println(reader.readLine());

					// 	//String line;
					// 	java.util.regex.Matcher m;
					// 	while ((macAddress = reader.readLine()) != null) {

					// 		m = p.matcher(macAddress);

					// 		if (!m.find())
					// 		continue;
					// 			macAddress = m.group();
					// 		break;
					// 	}
					// 	//System.out.println(line);
					// } catch (Exception e) {
					// 	e.printStackTrace();
					// }
					

					//String macAddress = getMac(macAddr()) == "" || getMac(ip_address) == null ? getMacAddress() : getMac(ip_address); 
					String macAddress = getMac(ipAddr());


					DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
					LocalDateTime now = LocalDateTime.now();
					// System.out.println(dtf.format(now));

					JSONObject obj_usr_log = new JSONObject();
					obj_usr_log.put("user_id", new_userid);
					obj_usr_log.put("work_station", ip_address);
					obj_usr_log.put("ip_address", ipAddr());
					obj_usr_log.put("mac_address", macAddress);
					obj_usr_log.put("request_url", request_url);
					obj_usr_log.put("protocol", protocol);
					obj_usr_log.put("log_date", dtf.format(now));
					obj_usr_log.put("log_type", "IN");

					obj_usr_log.put("description", "User log in of the System");
					obj_usr_log.put("t_date", dtf.format(now));
					obj_usr_log.put("comp_id", "0");

					//// System.out.println("Login Logs ");
					// System.out.println(request.toString());
					System.out.println(obj_usr_log.toString());
					web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							obj_usr_log.toString());

					String web_service_response_menu = null;
					web_service_response_menu = cls_users.get_all_dashboard_menu(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							new_userid);
					JSONObject menu_obj = new JSONObject(web_service_response_menu);
					String all_menus = menu_obj.get("data").toString();

					Gson googleJson = new Gson();
					ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
					session.setAttribute("menus", javaArrayListFromGSON);
					session.setAttribute("menus_com", all_menus);

					

					// String web_service_response_milestone = null;
					// web_service_response_milestone = cls_users.select_all_assigned_milestone(
					// 		cls_url_config.getWeb_service_url_ser(),
					// 		cls_url_config.getWeb_service_url_ser_api_key(),
					// 		new_userid);
					// JSONObject milestone_obj = new JSONObject(web_service_response_milestone);
					// String all_milestone = milestone_obj.get("data").toString();

					// ObjectMapper objectMapper = new ObjectMapper();
					// JsonNode jsonArray = objectMapper.readTree(all_milestone);

					// List<String> msIds = new ArrayList<>();
					// for (JsonNode node : jsonArray) {
					// 	msIds.add(node.get("ms_id").asText()); // Extract "ms_id" as a String
					// }

					// String milestone_result = String.join(",", msIds);
					// //System.out.println(milestone_result); // Output: 854,855

					// System.out.println("all_milestone: " + milestone_result);

					// // Gson googleJson = new Gson();
					// //ArrayList javaArrayListFromGSON = googleJson.fromJson(all_milestone, ArrayList.class);
					// //session.setAttribute("menus", javaArrayListFromGSON);
					// session.setAttribute("all_milestone", milestone_result);

					// session.setAttribute("user_level", user_level);

					/*
					 * String web_service_response_all_users =null;
					 * web_service_response_all_users
					 * =Ws_users.get_all_dashboard_menu(); JSONObject all_users_obj
					 * = new JSONObject(web_service_response_all_users); String
					 * all_users = all_users_obj.get("data").toString(); ArrayList
					 * javaArrayListFromGSON_users = googleJson.fromJson(all_users,
					 * ArrayList.class);
					 */
					// request.setAttribute("all_users",
					// javaArrayListFromGSON_users);

					String web_service_response_main_service = null;
					web_service_response_main_service = user_web_service
							.get_list_of_services(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject main_service_obj = new JSONObject(web_service_response_main_service);

					String all_main_service = main_service_obj.get("data").toString();


					String web_service_response_temporal_service = null;
					web_service_response_temporal_service = user_web_service
							.get_list_of_temporal_service(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject temporal_service_obj = new JSONObject(web_service_response_temporal_service);

					String temporal_service = temporal_service_obj.get("data").toString();
					// ArrayList javaArrayListFromGSON_main_service =
					// googleJson.fromJson(all_main_service, ArrayList.class);
					// request.setAttribute("menus",
					// javaArrayListFromGSON_main_service);

					String web_service_response_sub_service = null;
					web_service_response_sub_service = user_web_service
							.select_business_processes_sub_list_backend(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject sub_service_obj = new JSONObject(web_service_response_sub_service);
					String all_sub_service = sub_service_obj.get("data").toString();

					String web_service_response_sub_service_all = null;
					web_service_response_sub_service_all = user_web_service
							.get_list_of_sub_services_new_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject sub_service_all_obj = new JSONObject(web_service_response_sub_service_all);
					String all_sub_service_all = sub_service_all_obj.get("data").toString();

					String web_service_response_request_purpose = null;
					web_service_response_request_purpose = user_web_service
							.get_list_of_request_purpose(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());
					JSONObject request_purpose_obj = new JSONObject(web_service_response_request_purpose);
					String request_purpose = request_purpose_obj.get("data").toString();

					// ArrayList javaArrayListFromGSON_sub_service =
					// googleJson.fromJson(all_sub_service, ArrayList.class);
					// request.setAttribute("menus",
					// javaArrayListFromGSON_sub_service);

					String web_service_response_office_data = null;

					JSONObject obj_rc = new JSONObject();

					obj_rc.put("region_code", vr_region_code);

					// obj.put("case_number", case_number);

					// String input_details = obj.toString();
					// System.out.println(obj_rc.toString());

					String jsonArrayContent_office_region = user_web_service
							.select_lc_office_regions_districts_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject office_region_obj = new JSONObject(jsonArrayContent_office_region);
					String all_list_office_region = office_region_obj.get("data").toString();

					String jsonArrayContent_division_list = casemgt_cl.divisions_get_list(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject division_list_obj = new JSONObject(jsonArrayContent_division_list);
					String all_list_division_list = division_list_obj.get("data").toString();

					String jsonArrayContent_region_list = casemgt_cl
							.get_region_list(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

					JSONObject region_list_obj = new JSONObject(jsonArrayContent_region_list);
					String all_list_region_list = region_list_obj.get("data").toString();

					session.setAttribute("office_region_list", all_list_office_region);
					// session.setAttribute("office_region_list_all", all_list_office_region);
					session.setAttribute("division_list", all_list_division_list);
					session.setAttribute("region_list", all_list_region_list);

					String jsonArrayContent_tags_for_batching_jobs_list = baby_step_cl
							.get_tags_for_batching_jobs_list(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), "-");

					JSONObject tags_for_batching_jobs_list_obj = new JSONObject(
							jsonArrayContent_tags_for_batching_jobs_list);
					String all_list_tags_for_batching_jobs_list = tags_for_batching_jobs_list_obj.get("data")
							.toString();
					session.setAttribute("tags_for_batching_jobs_list", all_list_tags_for_batching_jobs_list);

					web_service_response_office_data = general_q_cl
							.get_global_values(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key(), obj_rc.toString());
					// web_service_response_office_data =
					// general_q_cl.get_global_values();
					JSONObject sou_obj = new JSONObject(web_service_response_office_data);

					String sms_setting = sou_obj.get("sms").toString();
					String organisation_details = sou_obj.get("orgset").toString();
					String all_users_for_batching = sou_obj.get("users").toString();

					session.setAttribute("web_list_of_users", all_users_for_batching);
					session.setAttribute("web_main_services", all_main_service);
					session.setAttribute("web_sub_services", all_sub_service);
					session.setAttribute("web_sub_services_all", all_sub_service_all);
					session.setAttribute("web_temporal_service", temporal_service);
					session.setAttribute("mac_address", macAddress);
					session.setAttribute("ip_address", ip_address);
					session.setAttribute("request_purpose_all", request_purpose);
					// System.out.println("OrgVa");
					// System.out.println(organisation_details);

					JSONArray arr_sou = new JSONArray(organisation_details);
					for (int i = 0; i < arr_sou.length(); i++) {
						String compname = arr_sou.getJSONObject(i).getString("compname");
						String comp_address = arr_sou.getJSONObject(i).getString("comp_address");
						String city = arr_sou.getJSONObject(i).getString("city");
						String fax_number = arr_sou.getJSONObject(i).getString("fax_number");
						String telephone = arr_sou.getJSONObject(i).getString("telephone");

						String email = arr_sou.getJSONObject(i).getString("email");
						String branch_of_csau = arr_sou.getJSONObject(i).getString("branch_of_csau");
						String rlo = arr_sou.getJSONObject(i).getString("rlo");
						String regional_accountant = arr_sou.getJSONObject(i).getString("regional_accountant");
						String head_of_csau = arr_sou.getJSONObject(i).getString("head_of_csau");
						String chairman_regional_land_commission = arr_sou.getJSONObject(i)
								.getString("chairman_regional_land_commission");
						String office_region = arr_sou.getJSONObject(i).getString("office_region");

						// System.out.println(fullname);
						request.setAttribute("compname", compname);
						request.setAttribute("web_comp_address", comp_address);
						request.setAttribute("web_city", city);
						request.setAttribute("web_fax_number", fax_number);
						request.setAttribute("web_telephone", telephone);
						request.setAttribute("web_email", email);
						request.setAttribute("web_branch_of_csau", branch_of_csau);
						request.setAttribute("web_rlo", rlo);
						request.setAttribute("web_regional_accountant", regional_accountant);
						request.setAttribute("web_head_of_csau", head_of_csau);
						request.setAttribute("web_chairman_regional_land_commission",
								chairman_regional_land_commission);
						request.setAttribute("web_office_region", office_region);

						session.setAttribute("web_compname", compname);
						session.setAttribute("web_comp_address", comp_address);
						session.setAttribute("web_city", city);
						session.setAttribute("web_fax_number", fax_number);
						session.setAttribute("web_telephone", telephone);
						session.setAttribute("web_email", email);
						session.setAttribute("web_branch_of_csau", branch_of_csau);
						session.setAttribute("web_rlo", rlo);
						session.setAttribute("web_regional_accountant", regional_accountant);
						session.setAttribute("web_head_of_csau", head_of_csau);
						session.setAttribute("web_chairman_regional_land_commission",
								chairman_regional_land_commission);
						session.setAttribute("web_office_region", office_region);

						/*
						 * Ws_url_config.web_compname = compname;
						 * Ws_url_config.web_comp_address = comp_address;
						 * Ws_url_config.web_city = city;
						 * Ws_url_config.web_fax_number = fax_number;
						 * Ws_url_config.web_telephone = telephone;
						 * Ws_url_config.web_email = email;
						 * Ws_url_config.web_branch_of_csau = branch_of_csau;
						 * Ws_url_config.web_rlo = rlo;
						 * Ws_url_config.web_regional_accountant =
						 * regional_accountant; Ws_url_config.web_head_of_csau =
						 * head_of_csau;
						 * Ws_url_config.web_chairman_regional_land_commission =
						 * chairman_regional_land_commission;
						 * Ws_url_config.web_office_region = office_region;
						 */
						// //HttpSession session = request.getSession();
						// session.setAttribute("uname", userid);

					}

					web_service_response_all_users = cls_users.get_all_users_short(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key());
					session.setAttribute("get_all_users_short", web_service_response_all_users);

					session.setAttribute("service_url", cls_url_config.getWeb_service_url_ser());
					session.setAttribute("api_key", cls_url_config.getWeb_service_url_ser_api_key());

					web_service_response = casemagt_cl.report_dashboard_all_by_user(
							cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(),
							new_userid);
					JSONObject dash_obj = new JSONObject(web_service_response);

					String apps_rec_month = dash_obj.get("apps_rec_month").toString();
					String apps_comp_month = dash_obj.get("apps_comp_month").toString();
					String apps_rec_year = dash_obj.get("apps_rec_year").toString();
					String apps_comp_year = dash_obj.get("apps_comp_year").toString();
					String apps_past_due_dates = dash_obj.get("apps_past_due_dates").toString();
					String completion_rate = dash_obj.get("completion_rate").toString();
					String apps_with_user = dash_obj.get("apps_with_user").toString();
					request.setAttribute("apps_with_user", apps_with_user);
					request.setAttribute("apps_rec_month", apps_rec_month);
					request.setAttribute("apps_comp_month", apps_comp_month);
					request.setAttribute("apps_rec_year", apps_rec_year);
					request.setAttribute("apps_comp_year", apps_comp_year);
					request.setAttribute("apps_past_due_dates", apps_past_due_dates);
					request.setAttribute("completion_rate", completion_rate);

							model.addAttribute("content", "../pages/mainpage/main_dashboard.jsp"); return "layouts/app";
					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				} else {
					request.setAttribute("login", "failed");
					// System.out.println("If Not success");
					 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				}

			} else {
				request.setAttribute("error", "Invalid OTP. Please try again.");
						model.addAttribute("content", "../pages/configure_google_authenticator.jsp"); return "layouts/app";
			}
	}

	
	@RequestMapping("/change_password_rs")
	@PostMapping
	public String change_password_rs(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		// System.out.println(userName + password);
		String web_service_response = null;
		String web_service_response_all_users = null;
		String web_service_response_verify = null;
		String new_userid = null;

		String vr_region_code = null;

		// System.out.println(userName);
		// System.out.println(password);
		// System.out.println(cls_url_config.getWeb_service_url_ser());
		// System.out.println(cls_url_config.getWeb_service_url_ser_api_key());

		try {

			String vc_1 = request.getParameter("vc_1");
			String vc_2 = request.getParameter("vc_2");
			String vc_3 = request.getParameter("vc_3");
			String vc_4 = request.getParameter("vc_4");
			String vc_5 = request.getParameter("vc_5");
			String vc_6 = request.getParameter("vc_6");

			String modified_by = (String) session.getAttribute("fullname");
			String modified_by_id = (String) session.getAttribute("user_id_init");

			String user = (String) session.getAttribute("user");
			//String pass = (String) session.getAttribute("pass");
			// String fullname = (String) session.getAttribute("fullname"); String mac_address = (String) session.getAttribute("mac_address"); String ip_address =  (String) session.getAttribute("ip_address");

			// String userid = (String) session.getAttribute("userid");

			String full_code = vc_1 + vc_2 + vc_3 + vc_4 + vc_5 + vc_6;

			JSONObject obj_v = new JSONObject();
			obj_v.put("full_code", full_code);
			obj_v.put("user_id", modified_by_id);

			String input = obj_v.toString();
			System.out.println("code verification request");

			System.out.println(input);

			web_service_response_verify = cls_users.office_verify_verification_token(
					cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(), input);
			JSONObject obj_verify = new JSONObject(web_service_response_verify);
			String arr_verify = obj_verify.get("status").toString();

			if (arr_verify.equals("Success")) {

				web_service_response = cls_users.select_user_by_userid(cls_url_config.getWeb_service_url_ser(),
						cls_url_config.getWeb_service_url_ser_api_key(), user);
				// JSONObject obj = new JSONObject();
				System.out.println(web_service_response);

				JSONObject obj_test = new JSONObject(web_service_response);
				String arr_tester = obj_test.get("data").toString();

				/* JSONArray arr_tester = obj_test.getJSONArray("data"); */

				if (arr_tester != null) {
					// System.out.println("If success");
					// System.out.println(arr_tester);

					// creating a session
					// HttpSession session = request.getSession();
					// session.setAttribute("", name);

					// do this when user login success
					// System.out.println(web_service_response);
					JSONObject obj = new JSONObject(web_service_response);
					// String pageName = obj.get("data").toString();
				
					JSONArray arr = obj.getJSONArray("data");
					// System.out.println("arra : " + arr);
					for (int i = 0; i < arr.length(); i++) {
						
						session.setAttribute("username", arr.getJSONObject(i).getString("username"));

					}

							model.addAttribute("content", "../pages/change_password.jsp"); return "layouts/app";
					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				} else {
					request.setAttribute("login", "failed");
					// System.out.println("If Not success");
					model.addAttribute("content", "../pages/two_factor_authentication_for_password_reset.jsp"); return "layouts/app";
					// RequestDispatcher view =
					// request.getRequestDispatcher("main_dashboard.jsp"); return "layouts/app";

				}

			} else {
				request.setAttribute("login", "failedverificationcode");

				model.addAttribute("content", "../pages/two_factor_authentication_for_password_reset.jsp"); return "layouts/app";
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
		return "";
	}

	// Ws_users cls_users = new Ws_users();

	@RequestMapping("/usp_users_access_logs")
	@PostMapping
	public String usp_users_access_logs(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		try {
			// HttpSession session = request.getSession();

			String request_url = request.getRequestURI();
			String protocol = request.getProtocol();
			String path_info = request.getPathInfo();
			String ip_address = request.getRemoteAddr();

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String web_service_response = null;

			JSONObject obj_usr_log = new JSONObject();
			obj_usr_log.put("user_id", (String) session.getAttribute("userid"));
			obj_usr_log.put("work_station", ip_address);
			obj_usr_log.put("ip_address", ip_address);
			obj_usr_log.put("request_url", request_url);
			obj_usr_log.put("protocol", protocol);
			obj_usr_log.put("log_date", dtf.format(now));
			obj_usr_log.put("log_type", "OUT");

			obj_usr_log.put("description", "User log out of the System");
			obj_usr_log.put("t_date", dtf.format(now));
			obj_usr_log.put("comp_id", "0");

			// System.out.println(obj_usr_log.toString());
			web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					obj_usr_log.toString());

			session.removeAttribute("userId");
			session.removeAttribute("emailaddress");
			session.removeAttribute("staffnumber");
			session.removeAttribute("username");
			session.removeAttribute("userid");
			session.removeAttribute("fullname");
			session.removeAttribute("division");
			session.removeAttribute("user_level");
			session.removeAttribute("user_phone");
			session.removeAttribute("unit_name");
			session.removeAttribute("unit_id");
			session.removeAttribute("regional_code");
			session.removeAttribute("regional_name");
			session.removeAttribute("distict_code");
			session.removeAttribute("district_name");
			session.invalidate();

			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping("/usp_users_access_logs_1")
	@PostMapping
	public String usp_users_access_logs_1(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		try {
			// HttpSession session = request.getSession();
			String request_url = request.getRequestURI();
			String protocol = request.getProtocol();
			String path_info = request.getPathInfo();
			String ip_address = request.getRemoteAddr();

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String web_service_response = null;

			JSONObject obj_usr_log = new JSONObject();
			obj_usr_log.put("user_id", (String) session.getAttribute("userid"));
			obj_usr_log.put("work_station", ip_address);
			obj_usr_log.put("ip_address", ip_address);
			obj_usr_log.put("request_url", request_url);
			obj_usr_log.put("protocol", protocol);
			obj_usr_log.put("log_date", dtf.format(now));
			obj_usr_log.put("log_type", "OUT");

			obj_usr_log.put("description", "User log out of the System");
			obj_usr_log.put("t_date", dtf.format(now));
			obj_usr_log.put("comp_id", "0");

			// System.out.println(obj_usr_log.toString());
			web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					obj_usr_log.toString());

			session.removeAttribute("userId");
			session.removeAttribute("emailaddress");
			session.removeAttribute("staffnumber");
			session.removeAttribute("username");
			session.removeAttribute("userid");
			session.removeAttribute("fullname");
			session.removeAttribute("division");
			session.removeAttribute("user_level");
			session.removeAttribute("user_phone");
			session.removeAttribute("unit_name");
			session.removeAttribute("unit_id");
			session.removeAttribute("regional_code");
			session.removeAttribute("regional_name");
			session.removeAttribute("distict_code");
			session.removeAttribute("district_name");
			session.invalidate();

			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// $result['success'] = true; // #15
		// $result['msg'] = 'User authenticated!'; // #16
		// doGet(request, response);
		return "";
	}

	// Ws_users cls_users = new Ws_users();
	// cls_casemgt casemagt_cl = new cls_casemgt();

	@RequestMapping("/two_factor_authentication_1")
	@PostMapping
	public String two_factor_authentication(HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		// System.out.println(userName + password);
		String web_service_response = null;
		String new_userid = null;
		String vr_region_code = null;

		//// web_service_response =
		//// cls_users.select_user_for_two_factor_verification(userName, password);
		// JSONObject obj = new JSONObject();

		// Send SMS
		// If Login is successful send the verification code

		// code
		try {

					model.addAttribute("content", "../pages/user_management/two_factor_authentication.jsp"); 
					return "layouts/app";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				model.addAttribute("content", "../pages/user_management/two_factor_authentication.jsp"); 
				return "layouts/app";
	   
	}

	@RequestMapping("/Logout")
	@PostMapping
	public String Logout(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		try {
			// HttpSession session = request.getSession();
			String request_url = request.getRequestURI();
			String protocol = request.getProtocol();
			String path_info = request.getPathInfo();
			String ip_address = request.getRemoteAddr();

			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			LocalDateTime now = LocalDateTime.now();
			String web_service_response = null;

			JSONObject obj_usr_log = new JSONObject();
			obj_usr_log.put("user_id", (String) session.getAttribute("userid"));
			obj_usr_log.put("work_station", ip_address);
			obj_usr_log.put("ip_address", ip_address);
			obj_usr_log.put("request_url", request_url);
			obj_usr_log.put("protocol", protocol);
			obj_usr_log.put("log_date", dtf.format(now));
			obj_usr_log.put("log_type", "OUT");

			obj_usr_log.put("description", "User log out of the System");
			obj_usr_log.put("t_date", dtf.format(now));
			obj_usr_log.put("comp_id", "0");

			// System.out.println(obj_usr_log.toString());
			web_service_response = cls_users.usp_users_access_logs(cls_url_config.getWeb_service_url_ser(),
					cls_url_config.getWeb_service_url_ser_api_key(),
					obj_usr_log.toString());

			session.removeAttribute("userId");
			session.removeAttribute("emailaddress");
			session.removeAttribute("staffnumber");
			session.removeAttribute("username");
			session.removeAttribute("userid");
			session.removeAttribute("fullname");
			session.removeAttribute("division");
			session.removeAttribute("user_level");
			session.removeAttribute("user_phone");
			session.removeAttribute("unit_name");
			session.removeAttribute("unit_id");
			session.removeAttribute("regional_code");
			session.removeAttribute("regional_name");
			session.removeAttribute("distict_code");
			session.removeAttribute("district_name");
			session.invalidate();

			 model.addAttribute("content", "../auth/login.jsp");
			 return "layouts/guest";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 model.addAttribute("content", "../auth/login.jsp");
		 return "layouts/guest";

	}

}
