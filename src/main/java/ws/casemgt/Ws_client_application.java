package ws.casemgt;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class Ws_client_application {

	public String get_list_of_services(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/main_services");
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
	

	public String select_stp_elis_app_levels_list(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_stp_elis_app_levels_list");
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

	public String get_list_of_temporal_service(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/temporal_service");
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

	public String get_list_of_services_all(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/main_services_all");
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

	public String get_list_of_sub_services_new(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/sub_services_new");
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

	public String select_business_processes_sub_list_backend(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/sub_services_new_backend");
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

	public String get_list_of_sub_services_new_all(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/sub_services_new_all");
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

	

	public String get_list_of_request_purpose(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_list_of_request_purpose");
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

	public String get_details_of_job_after_payment(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/details_of_job_after_payment");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_online_select_bill_for_registration(String web_service_url, String web_service_api_key,
			String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_bill_for_registration");
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

	public String online_select_bill_for_application_general_all_backend(String web_service_url,
			String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_bill_for_application_general_all_backend");
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

	

	public String online_calculate_bill_only(String web_service_url,
			String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_calculate_bill_only");
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


	public String online_select_bill_for_regional_transitional_application(String web_service_url,
			String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_bill_for_regional_transitional_application");
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

	public String online_select_bill_for_tamp_duty_light_document(String web_service_url, String web_service_api_key,
			String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_bill_for_tamp_duty_light_document");
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

	public String load_application_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_details_by_job_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_details_by_job_number_within_unit(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_details_by_job_number_within_unit");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_details_by_job_number_all(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_details_by_job_number_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_consolidated_internal_search_report_geom(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_consolidated_internal_search_report_geom");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_consolidated_internal_search_report_attribute(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_consolidated_internal_search_report_attribute");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_load_details_for_payment(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_load_details_for_payment");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_verification_code_create(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_verification_code_create");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String check_request_purpose_validation(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/check_request_purpose_validation");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_generate_smd_title_plan_numbers(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_generate_smd_title_plan_numbers");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_verification_code_details(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_verification_code_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_load_previous_bill_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_load_previous_bill_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_address_register_add_new(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_address_register_add_new");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_get_parties_by_case(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_get_parties_by_case");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_address_register_by_id_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_address_register_by_id_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_registration(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_registration");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_on_case_sub(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_on_case_sub");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_not_on_case_sub(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_not_on_case_sub");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_not_on_case_exist(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_not_on_case_exist");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_not_on_case_exist_cj(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_not_on_case_exist_cj");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_load_details_for_batching(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_load_details_for_batching");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	
	public String select_lc_mother_file_update_final_register(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_lc_mother_file_update_final_register");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_resubmission_slip(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/process_resubmission_slip");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_process_batch_list_unit(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_unit");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}
	

	public String select_process_batch_list_unit_crb(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_unit_crb");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_process_batch_list_for_certificate_signing(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_for_certificate_signing");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_certificate_signing_applications_at_unit_by_inbox_type(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_certificate_signing_applications_at_unit_by_inbox_type");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_app_request_at_unit_by_inbox_type(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_app_request_at_unit_by_inbox_type");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_incoming_app_for_unit_using_adv_filter(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_incoming_app_for_unit_using_adv_filter");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_sub_process_application_type_for_adv_filter(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_sub_process_application_type_for_adv_filter");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_responded_queried_applications_at_unit(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_responded_queried_applications_at_unit");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_frrv_coordinator(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_frrv_coordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_frrv(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_frrv");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_tpp_coordinator(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_tpp_coordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_tpp(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_tpp");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_file_list(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_file_list");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	

	public String process_file_movement_list(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_file_movement_list");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_request_list(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_request_list");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_request_list_to_user(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_request_list_to_user");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	

	public String process_request_list_to_archive(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_request_list_to_archive");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_check_wkt_polygon_by_job_number(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_check_wkt_polygon_by_job_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
		
	}

	public String select_review_baby_steps_check_for_completion(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_review_baby_steps_check_for_completion");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
		
	}

	

	public String select_load_step_approved_comment(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_load_step_approved_comment");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
		
	}

	public String select_check_application_details_for_request(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_check_application_details_for_request");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_process_batch_list_cabinet(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_cabinet");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_process_batch_list_issue_collected(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_issue_collected");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	
	public String select_process_batch_list_issue_for_payment_collected(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_issue_for_payment_collected");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_process_batch_list_new(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_process_batch_list_new");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String update_job_step_status_bulk(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/update_job_step_status_bulk");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String update_job_step_status_bulk_frrv_cst(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/update_job_step_status_bulk_frrv_cst");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_frrv(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_batch_list_frrv");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	
	public String process_send_job_number_to_ffrv(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_send_job_number_to_ffrv");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}
	

	public String select_frrv_details_on_job_number(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/select_frrv_details_on_job_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_tpp(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_batch_list_tpp");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_tpp_supervisor(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/process_batch_list_tpp_supervisor");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_tpp_supervisor_to_cordinator(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/process_batch_list_tpp_supervisor_to_cordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_frrv_supervisor(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/process_batch_list_frrv_supervisor");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_frrv_supervisor_to_cordinator(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/process_batch_list_frrv_supervisor_to_cordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_cst_coordinator(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_cst_coordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_frrv_cst_coordinator(String web_service_url,
			String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_frrv_cst_coordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_at_unit_by_inbox_type_cst(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_cst");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}


	public String load_applications_at_unit_by_inbox_type_frrv_cst(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_applications_at_unit_by_inbox_type_frrv_cst");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_cst(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_batch_list_cst");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}


	public String process_batch_list_frrv_cst(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/process_batch_list_frrv_cst");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_cst_supervisor(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/process_batch_list_cst_supervisor");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_frrv_cst_supervisor(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/process_batch_list_frrv_cst_supervisor");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_cst_supervisor_to_cordinator(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/process_batch_list_cst_supervisor_to_cordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String process_batch_list_frrv_cst_supervisor_to_cordinator(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/process_batch_list_frrv_cst_supervisor_to_cordinator");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_list_of_gender(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_gender");
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

	public String get_list_of_locality(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_locality");
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

	public String get_locality_by_region(String web_service_url, String web_service_api_key, String region_id)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			// WebResource webResource =
			// client.resource(web_service_url +
			// "case_management_service/get_locality");
			// ClientResponse response =
			// webResource.accept("application/json").header("x-api-key",
			// web_service_api_key).get(ClientResponse.class);

			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_locality_by_region");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, region_id);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_lc_list_of_units(String web_service_url, String web_service_api_key, String office)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_lc_list_of_units");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, office);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_lc_list_of_units_manage(String web_service_url, String web_service_api_key, String office)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_lc_list_of_units_manage");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, office);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_global_values(String web_service_url, String web_service_api_key, String json_data) {
		// ResultSet result= null;
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/get_global_values_by_region");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_data);
			// ClientResponse response =
			// webResource.accept("application/json").header("x-api-key",
			// web_service_api_key).get(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_lc_office_regions_districts(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_lc_office_regions_districts");
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

	public String select_lc_office_regions_districts_all(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_lc_office_regions_districts_all");
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

	public String select_revenue_items_for_lvd_stamping_list(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_revenue_items_for_lvd_stamping_list");
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

	public String get_list_of_typeofuse(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_typeofuse");
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

	public String get_list_of_natureofinstrument(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_natureofinstrument");
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

	public String get_list_of_typeofinterest(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_typeofinterest");
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

	public String get_list_of_district(String web_service_url, String web_service_api_key, String region_id) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_district");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, region_id);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_list_of_region(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_region");
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

	public String get_list_of_designation(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_designation");
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

	public String get_list_of_sub_services(String web_service_url, String web_service_api_key,
			String business_process_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "case_management_service/sub_services");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public String get_flat_fees_for_a_service(String web_service_url, String web_service_api_key,
			String business_process_id,
			String business_process_sub_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(
						web_service_url + "case_management_service/get_flat_fees_for_a_service");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public String get_check_list_for_a_service(String web_service_url, String web_service_api_key,
			String business_process_id,
			String business_process_sub_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(
						web_service_url + "case_management_service/get_check_list_for_a_service");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public String get_check_list_for_a_service_new(String web_service_url, String web_service_api_key,
			String business_process_id,
			String business_process_sub_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "case_management_service/get_check_list_for_a_service_new");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public String load_application_milestone_for_tracking(String web_service_url, String web_service_api_key,
			String business_process_id,
			String business_process_sub_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "case_management_service/load_application_milestone_for_tracking");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				jsonArr.put(obj);
				String input = obj.toString();
				// System.out.println(input);
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public String online_select_regional_number_bill_single(String web_service_url, String web_service_api_key,
			String json_request)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "case_management_service/online_select_regional_number_bill_single");

				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								json_request);
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

	public String get_lrd_form_for_application(String web_service_url, String web_service_api_key,
			String business_process_id,
			String business_process_sub_id)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "case_management_service/select_lrd_form_for_application");
				JSONObject obj = new JSONObject();
				obj.put("business_process_id", business_process_id);
				obj.put("business_process_sub_id", business_process_sub_id);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
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

	public static final String DOWNLOAD_FILE_LOCATION = "C:\\tmp\\";

	public String get_bill_pdf(String web_service_url, String web_service_api_key, String input)

	{
		String output = null;
		String qualifiedDownloadFilePath = null;
		try {

			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {

				Client client = Client.create();
				WebResource webResource = client.resource(
						web_service_url + "case_management_service/reginonal_number_bill");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
				if (response_ws.getStatus() != 200) {
					throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
				}
				// output = response_ws.getEntity(String.class);

				// read response string
				inputStream = response_ws.getEntityInputStream();
				qualifiedDownloadFilePath = DOWNLOAD_FILE_LOCATION + "lcbill.pdf";
				outputStream = new FileOutputStream(qualifiedDownloadFilePath);
				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);
				}

				output = qualifiedDownloadFilePath;

				// read response string
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// release resources, if any
				outputStream.close();
				// response_ws.close();
				// client.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;
	}

	public String get_a_service_bill(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/pdf");
			ClientResponse response = webResource.accept("application/pdf").get(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	// ----------------------------------------------------------------------------------------------

	public String select_on_lc_inspection_reports(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_on_lc_inspection_reports");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String insert_update_on_lc_inspection_reports(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/insert_update_on_lc_inspection_reports");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String srs_assessment_complete(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "lc_assessment_complete");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String update_stamp_duty_records(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/update_stamp_duty_records");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String update_stamp_duty_records_embossment(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/update_stamp_duty_records_embossment");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_load_application_for_publication_management(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_load_application_ready_for_publication");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
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

	public String select_load_application_awaiting_publication_date(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_load_application_awaiting_publication_date");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
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

	public String select_address_register_add_new_general(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_address_register_add_new_general");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}
	

	public String select_delete_party(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_delete_party");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_get_party_by_party_id(String web_service_url, String web_service_api_key, String client_id) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_get_party_by_party_id");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, client_id);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_address_register_edit_general(String web_service_url, String web_service_api_key,
			String input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_address_register_edit_general");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_load_details_of_licenced_surveyor(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_load_details_of_licenced_surveyor");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_file_location(String web_service_url, String web_service_api_key,
			String batch_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/load_application_file_location"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, batch_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_applications_by_batchlist(String web_service_url, String web_service_api_key,
			String batch_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/load_applications_by_batchlist"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, batch_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_milestone_for_tracking_by_job(String web_service_url, String web_service_api_key,
			String job_number)

	{
		System.out.println(job_number);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_milestone_for_tracking_by_job"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
			// System.out.println(output);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_details_for_enquiries(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_details_for_enquiries"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_details_for_enquiries_stamping(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_details_for_enquiries_stamping"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String add_application_to_publication_list(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/add_application_to_publication_list"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_application_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_application_details_by_job_number"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_application_details_by_job_number_or_certificate_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_application_details_by_job_number_or_certificate_number"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_archived_application_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_archived_application_details_by_job_number"); //
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,
			// job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String load_application_cabinet_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_cabinet_details_by_job_number"); // ClientResponse
			// //
			webResource.accept("text/plain").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	/*
	 * public String load_application_details_for_enquiries(String
	 * web_service_url,String job_number)
	 * 
	 * { String output = "Data Not Received"; try { Client client =
	 * Client.create(); WebResource webResource =
	 * client.resource(web_service_url +
	 * "case_management_service/load_application_details_for_enquiries"); //
	 * ClientResponse response = //
	 * webResource.accept("text/plain").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,job_number);
	 * ClientResponse response =
	 * webResource.accept("application/json").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,
	 * job_number); if (response.getStatus() != 200) { throw new
	 * RuntimeException("Failed : HTTP error code : " + response.getStatus()); }
	 * output = response.getEntity(String.class); } catch (Exception e) {
	 * 
	 * e.printStackTrace();
	 * 
	 * } return output;
	 * 
	 * }
	 * 
	 * public String load_application_cabinet_details_by_job_number(String
	 * job_number) { String output = "Data Not Received"; try { Client client =
	 * Client.create(); WebResource webResource =
	 * client.resource(web_service_url +
	 * "case_management_service/load_application_cabinet_details_by_job_number")
	 * ; // ClientResponse response = //
	 * webResource.accept("text/plain").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,job_number);
	 * ClientResponse response =
	 * webResource.accept("application/json").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,
	 * job_number); if (response.getStatus() != 200) { throw new
	 * RuntimeException("Failed : HTTP error code : " + response.getStatus()); }
	 * output = response.getEntity(String.class); } catch (Exception e) {
	 * 
	 * e.printStackTrace();
	 * 
	 * } return output; }
	 * 
	 * public String load_application_details_for_enquiries(String
	 * web_service_url,String job_number)
	 * 
	 * { String output = "Data Not Received"; try { Client client =
	 * Client.create(); WebResource webResource =
	 * client.resource(web_service_url +
	 * "case_management_service/load_application_details_for_enquiries"); //
	 * ClientResponse response = //
	 * webResource.accept("text/plain").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,job_number);
	 * ClientResponse response =
	 * webResource.accept("application/json").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,
	 * job_number); if (response.getStatus() != 200) { throw new
	 * RuntimeException("Failed : HTTP error code : " + response.getStatus()); }
	 * output = response.getEntity(String.class); } catch (Exception e) {
	 * 
	 * e.printStackTrace();
	 * 
	 * } return output;
	 * 
	 * }
	 * 
	 * public String load_application_cabinet_details_by_job_number(String
	 * job_number) { String output = "Data Not Received"; try { Client client =
	 * Client.create(); WebResource webResource =
	 * client.resource(web_service_url +
	 * "case_management_service/load_application_cabinet_details_by_job_number")
	 * ; // ClientResponse response = //
	 * webResource.accept("text/plain").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,job_number);
	 * ClientResponse response =
	 * webResource.accept("application/json").header("api-key",ws_url_config.
	 * get_service_api_key()).post(ClientResponse.class,
	 * job_number); if (response.getStatus() != 200) { throw new
	 * RuntimeException("Failed : HTTP error code : " + response.getStatus()); }
	 * output = response.getEntity(String.class); } catch (Exception e) {
	 * 
	 * e.printStackTrace();
	 * 
	 * } return output; }
	 */
	public String load_application_collection_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_application_collection_details_by_job_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String load_save_collection_details_by_job_number(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/load_save_collection_details_by_job_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String select_archive_application_request(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_archive_application_request");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	// -----------------------------------------------------------------------------------------------------------------------------

	// public static void main(String[] args) {
	// try {

	// Client client = Client.create();

	// WebResource webResource =
	// client.resource("http://localhost:8080/RESTfulExample/rest/json/metallica/get");

	// ClientResponse response = webResource.accept("application/json")
	// .get(ClientResponse.class);

	// // ClientResponse response =
	// // webResource.accept("application/json").header("x-api-key",
	// // web_service_api_key).get(ClientResponse.class);

	// if (response.getStatus() != 200) {
	// throw new RuntimeException("Failed : HTTP error code : " +
	// response.getStatus());
	// }

	// String output = response.getEntity(String.class);

	// // System.out.println("Output from Server .... \n");
	// // System.out.println(output);

	// } catch (Exception e) {

	// e.printStackTrace();

	// }

	// }

	public String assign_inspection_case_to_officer(String web_service_url, String web_service_api_key,
			String jsondata) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/assign_inspection_case_to_officer");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, jsondata);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String online_select_update_assessesd_rent(String web_service_url, String web_service_api_key,
			String jsondata) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_update_assessesd_rent");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, jsondata);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String update_user_profile(String web_service_url, String web_service_api_key, String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/update_user_profile");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_link_account_to_jobs(String web_service_url, String web_service_api_key, String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/online_link_account_to_jobs");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_link_transaction_to_jobs(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/online_link_transaction_to_jobs");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String lc_comment_on_job(String web_service_url, String web_service_api_key, String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/lc_comment_on_job");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_process_acknowledgement_regional_number_bulk(String web_service_url,
			String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_process_acknowledgement_regional_number_bulk");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_update_application_ground_rent(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_update_application_ground_rent");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String lc_case_letters_add_update(String web_service_url, String web_service_api_key, String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/lc_case_letters_add_update");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_copy_mother_file_transaction_to_child(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_copy_mother_file_transaction_to_child");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String lc_certificate_search_relation_details_add_update(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/lc_certificate_search_relation_details_add_update");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String lc_payment_verification_for_bill_gcr(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/lc_payment_verification_for_bill_gcr");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_transaction_approvals_create(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_transaction_approvals_create");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String online_select_transaction_approvals_final_approval(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/online_select_transaction_approvals_final_approval");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_transaction_approvals_by_user(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_transaction_approvals_by_user");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_transaction_approvals_certificate_create(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_transaction_approvals_certificate_create");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_transaction_approvals_certificate_by_user(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_transaction_approvals_certificate_by_user");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_lc_transaction_approvals_certificate_update_by_user(String web_service_url,
			String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_lc_transaction_approvals_certificate_update_by_user");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String pvlmd_number_generation_deed_number_ls_number(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/pvlmd_number_generation_deed_number_ls_number");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_compliance_application_notice_count_per_division(String web_service_url,
			String web_service_api_key, String region_id)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_compliance_application_notice_count_per_division");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, region_id);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}


	public String select_compliance_application_notice_by_division(String web_service_url,
			String web_service_api_key, String region_id)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_compliance_application_notice_by_division");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, region_id);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_compliance_application_notice(String web_service_url,
			String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_compliance_application_notice");
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


	public String corporate_processing_units_staff(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/corporate_processing_units_staff");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}


	public String corporate_processing_units_application_with_staff(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/corporate_processing_units_application_with_staff");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_load_application_details(String web_service_url, String web_service_api_key,
			String job_number) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/select_load_application_details");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, job_number);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}




	public String pdf_byte_upload_to_service(String web_service_url,
			String web_service_api_key, String json_data)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "document_upload/recieve_binary_pdf");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key)
					.header("Content-Type", "application/json")
					.post(ClientResponse.class, json_data);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String select_licensed_surveyors_for_reporting(String web_service_url, String web_service_api_key)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "case_management_service/select_licensed_surveyors_for_reporting");
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
