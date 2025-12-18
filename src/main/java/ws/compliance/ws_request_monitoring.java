package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_request_monitoring {



    public String select_staff_apps_with_unit_monitoring(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/select_staff_apps_with_unit_monitoring");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}




    public String select_all_staff_apps_with_unit_monitoring(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/select_all_staff_apps_with_unit_monitoring");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}




    public String all_staff_apps_with_unit_monitoring(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/all_staff_apps_with_unit_monitoring");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}




    public String select_staff_apps_with_unit_request_incoming_applications(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/select_staff_apps_with_unit_request_incoming_applications");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}




    public String select_staff_apps_with_officers_request_withinunit_applications(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/select_staff_apps_with_officers_request_withinunit_applications");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}





    public String select_staff_apps_with_officers_request_withinuni(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "request_monitoring/select_staff_apps_with_officers_request_withinuni");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
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
