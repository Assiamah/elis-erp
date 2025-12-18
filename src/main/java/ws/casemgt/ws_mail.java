package ws.casemgt;

import com.mit.elis.class_common.Ws_url_config;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_mail {

    static Ws_url_config ws_url_config = new Ws_url_config();

     public String send_otp_mail(String web_service_url, String web_service_api_key, String json_data) {
        String output = "Data Not Received";
        try {
            Client client = Client.create();
            WebResource webResource = client
                    .resource(web_service_url + "mail_service/send_otp_mail");
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
    
}
