package ws.setup;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class Ws_sex {

	// static String base_url = "http://localhost:8080/web_service_ehms/rest/";
	// static String base_url =
	// "http://localhost:7273/WebServiceRestful_Server/rest/";
	// http://41.66.204.149:7273/WebServiceRestful_Server/rest/case_management_service/main_services

	public static String sex_add(String web_service_url, String web_service_api_key, String data_input) {
		String output = null;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url + "ws_sex/select_sex_add");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	public static String sex_update(String web_service_url, String web_service_api_key, String data_input) {
		String output = null;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url + "ws_sex/select_sex_update");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	public static String sex_delete(String web_service_url, String web_service_api_key, String data_input) {
		String output = null;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url + "ws_sex/select_sex_delete");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	public static String sex_get_list(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			System.out.println(web_service_url);
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "ws_sex/select_sexs_list");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.get(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

}
