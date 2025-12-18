package ws.casemgt;

import com.mit.elis.class_common.Ws_url_config;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_sms {

    static Ws_url_config ws_url_config = new Ws_url_config();

    public String send_single_sms(String web_service_url, String web_service_api_key, String json_data) {
        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "sms_service/send_single_sms");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, json_data);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;
    }

    public String check_sms_balance(String web_service_url, String web_service_api_key, String json_data) {
        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "sms_service/check_sms_balance");
            // ClientResponse response =
            // webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
            ClientResponse response = webResource.accept("application/json")
                    .header("x-api-key", web_service_api_key).post(ClientResponse.class, json_data);
            if (response.getStatus() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
            }
            output = response.getEntity(String.class);
        } catch (Exception e) {

            e.printStackTrace();

        }
        return output;
    }

    public String select_log_sms_alert(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = "Data Not Received";
		// boolean st =false;

		try {

			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "sms_service/select_log_sms_alert");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, data_input);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

    public String select_log_sms_alert_backoffice(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = "Data Not Received";
		// boolean st =false;

		try {

			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "sms_service/lc_outgoing_sms_log_backoffice");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, data_input);
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
