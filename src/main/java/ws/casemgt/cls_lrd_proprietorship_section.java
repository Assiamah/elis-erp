package ws.casemgt;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class cls_lrd_proprietorship_section {

	public String select_lrd_proprietorship_section_all_by_case_number(String web_service_url,
			String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "lrd_proprietorship_section/select_lrd_proprietorship_section_all_by_case_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,json_request);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_lrd_proprietorship_section_all_by_id(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "lrd_proprietorship_section/select_lrd_proprietorship_section_all_by_id");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,json_request);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_lrd_proprietorship_section_add_and_update(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "lrd_proprietorship_section/select_lrd_proprietorship_section_add_and_update");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,json_request);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_lrd_proprietorship_section_delete_by_id(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "lrd_proprietorship_section/select_lrd_proprietorship_section_delete_by_id");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,json_request);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
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
