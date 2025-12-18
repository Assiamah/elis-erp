package ws.csaumgt;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_csaupayment {

	public String generate_egcr(String web_service_url, String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "lc_official_receipt_service/generate_egcr_pdf_only");
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


	public String get_verify_receipt_and_update(String web_service_url, String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "lc_official_receipt_service/get_verify_receipt_and_update");
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

	
	public String lc_payment_verification_for_bill(String web_service_url, String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "payment_service/lc_payment_verification_for_bill");
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

	public String lc_payment_verification_for_name_change(String web_service_url, String web_service_api_key,
			String json_data) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "payment_service/lc_payment_verification_for_name_change");
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

	public String lc_payment_verification_for_bill_revised(String web_service_url, String web_service_api_key,
			String json_data) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "payment_service/lc_payment_verification_for_bill_revised");
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

	public String lc_payment_verification_for_bill_stamping(String web_service_url, String web_service_api_key,
			String json_data) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "payment_service/lc_payment_verification_for_bill_stamping");
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

	public String select_portal_users_by_email(String web_service_url, String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "payment_service/select_portal_users_by_email");
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

	public String generate_payment_payment_checkout(String web_payment_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_payment_service_url);
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);

			System.out.println(json_request);
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.type("application/json")
					.post(ClientResponse.class, json_request);

			// ClientResponse response =
			// webResource.accept("application/json").type("application/json").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// input);

			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String load_bill_for_payment_individual(String web_service_url, String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "payment_service/load_bill_for_payment_individual");
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

	public String load_bill_for_payment_individual_old_system(String web_service_url, String web_service_api_key,
			String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_bill_for_payment_individual_old_system");
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

	public String lc_payment_confirmation_for_bill_individual(String web_service_url, String web_service_api_key,
			String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "payment_service/lc_payment_confirmation_for_bill_individual");
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


	public String select_load_bill_by_ref_or_gog(String web_service_url, String web_service_api_key,
			String json_data) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "payment_service/select_load_bill_by_ref_or_gog");
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

	public String check_gog_for_payment_by_ref_or_gog(String web_service_url, String web_service_api_key,
			String json_data) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "non_key_service/check_gog_for_payment_by_ref_or_gog");
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


