package ws.lvd_compensation_maps;

import java.io.IOException;
import java.util.ArrayList;
import java.io.File;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import ws.casemgt.cls_casemgt;
import ws.maps.Ws_maps;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mit.elis.class_common.Ws_url_config;
import com.google.gson.Gson;

/**
 * Servlet implementation class regional_number
 */
// @WebServlet(urlPatterns = { "/lvd_comparable_maps" })
@Controller
public class category_and_rate_ws {
	@Autowired
	private Ws_url_config cls_url_config;

	cls_casemgt casemgt_cl = new cls_casemgt();

	@RequestMapping("/lvd_comparable_map_423323s")
	@GetMapping
	public String lvd_comparable_maps(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		try {
			Ws_maps cls_maps = new Ws_maps();
			String web_service_response_menu = null;
			web_service_response_menu = cls_maps
					.select_sp_parcels_lvd_location_list(cls_url_config.getWeb_service_url_ser(),
							cls_url_config.getWeb_service_url_ser_api_key(), "0");
			JSONObject menu_obj;
			menu_obj = new JSONObject(web_service_response_menu);
			String all_menus = menu_obj.get("data").toString();

			Gson googleJson = new Gson();
			ArrayList javaArrayListFromGSON = googleJson.fromJson(all_menus, ArrayList.class);
			request.setAttribute("localitylist", javaArrayListFromGSON);

			// request.setAttribute("page_name", "comparable");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.setAttribute("page_name", "case_comparable");
		return "/client_application/maps_lvd_comparables.jsp";

	}

	/**
	 * @see HttpServlet#doPost(HttpSession session,HttpServletRequest request,
	 *      HttpServletResponse
	 *      response)
	 */
	public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		// doGet(request, response);

		// String case_number = "LCGARGAPCN716613620190";
		// String job_number = "SMDGAPPA132305820190";

		if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
			// Session is expired
			request.setAttribute("login", "sessionout");
			System.out.println("If Not success");
			 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		}

		return "/client_application/maps_lvd_comparables.jsp";

	}

}
