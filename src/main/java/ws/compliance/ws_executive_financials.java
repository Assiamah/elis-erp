package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;


public class ws_executive_financials {


public String compliance_executive_financials(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}


   public String compliance_executive_financials1(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials1");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	} 
    

    public String compliance_executive_financials2(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials2");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}


    public String compliance_executive_financials3(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials3");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}


	public String compliance_executive_financials5(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials5");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}



	public String compliance_executive_financials4(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_financials/compliance_executive_financials4");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class);
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
