package ws.ai_api;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class Ws_ai_api {

		public String select_ai_response(String web_service_url, String web_service_api_key, String json_request) {
		String output = null;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url + "ai_agent_api/query");

				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
				if (response_ws.getStatus() != 200) {
					throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
				}
				output = response_ws.getEntity(String.class);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

}
