package ws.lvd_compensation_maps;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class Ws_category_and_rate {

	public String select_cr_category_classification_all(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "category_and_rate_service/select_cr_category_classification_all");
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

	


	public String select_cr_category_sub_classification_by_mc_code(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "category_and_rate_service/select_cr_category_sub_classification_by_mc_code");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}



	public String select_cr_sub_category_model_by_sub_category_code(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "category_and_rate_service/select_cr_sub_category_model_by_sub_category_code");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}



	public String select_rent_application_progress_details(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_rent_application_progress_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_rt_rates_table_current_per_estate(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_rt_rates_table_current_per_estate");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_rt_govt_estates_get_wkt(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_rt_govt_estates_get_wkt");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_rent_leasee_details_by_rl_id(String web_service_url, String web_service_api_key,
	String estate_code)

{
String output = "Data Not Received";
try {
	Client client = Client.create();
	WebResource webResource = client.resource(
			web_service_url + "rent_mgt_service/select_rent_leasee_details_by_rl_id");
	// ClientResponse response =
	// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
	ClientResponse response = webResource.accept("application/json")
			.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
	if (response.getStatus() != 200) {
		throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
	}
	output = response.getEntity(String.class);
} catch (Exception e) {

	e.printStackTrace();

}
return output;

}

public String select_rent_leasee_details_by_account_number(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_rent_leasee_details_by_account_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_prepare_rent_demand_notice_single(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_prepare_rent_demand_notice_single");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_prepare_rent_demand_notice_bulk(String web_service_url, String web_service_api_key,
			String estate_code)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "rent_mgt_service/select_prepare_rent_demand_notice_bulk");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, estate_code);
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
