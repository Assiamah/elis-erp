package com.mit.elis.servlets.developer;

import com.mit.elis.class_common.Ws_url_config;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LiveMonitoringServlet {

    @Autowired
    private Ws_url_config cls_url_config;

    @RequestMapping("/LiveMonitoring")
    @PostMapping
    public String doPost(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return "{\"success\":false,\"message\":\"Session expired\"}";
        }

        String requestType = request.getParameter("request_type");
        if (!"snapshot".equals(requestType)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return "{\"success\":false,\"message\":\"Unsupported monitoring request\"}";
        }

        try {
            JSONObject payload = new JSONObject();
            payload.put("requested_by", session.getAttribute("userid") == null ? "" : session.getAttribute("userid"));
            payload.put("regional_code", session.getAttribute("regional_code") == null ? "" : session.getAttribute("regional_code"));

            Client client = Client.create();
            WebResource webResource = client.resource(cls_url_config.getWeb_service_url_ser() + "elis_service/live_monitoring_snapshot");
            ClientResponse serviceResponse = webResource.type("application/json")
                    .accept("application/json")
                    .header("x-api-key", cls_url_config.getWeb_service_url_ser_api_key())
                    .post(ClientResponse.class, payload.toString());

            String output = serviceResponse.getEntity(String.class);
            if (serviceResponse.getStatus() != 200) {
                response.setStatus(serviceResponse.getStatus());
                return "{\"success\":false,\"message\":\"Monitoring service unavailable\"}";
            }

            return output;
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return "{\"success\":false,\"message\":\"Unable to load live monitoring snapshot\"}";
        }
    }
}
