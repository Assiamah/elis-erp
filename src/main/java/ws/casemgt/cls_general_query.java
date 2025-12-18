package ws.casemgt;

import java.sql.SQLException;

import org.codehaus.jettison.json.JSONException;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class cls_general_query {

	public static Integer licensed_surveyor_uid;
	public static String licensed_surveyor_name;
	public static String licensed_surveyor_mobile;
	public static String licensed_surveyor_telephone;
	public static String licensed_surveyor_email;
	public static String licensed_surveyor_status;
	public static Integer licensed_surveyor_inception_year;

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

	public String get_global_values(String web_service_url, String web_service_api_key) {
		// ResultSet result= null;
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "case_management_service/get_global_values");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.get(ClientResponse.class);
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

	public String save_bill_data_bulk(String web_service_url, String web_service_api_key, String user_to_create)
			throws JSONException, SQLException {

		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "maps_service/select_lc_spatial_objects_search_by_other_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, "");
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String save_bill_data_single(String web_service_url, String web_service_api_key)
			throws JSONException, SQLException {

		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "maps_service/select_lc_spatial_objects_search_by_other_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, "");
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String save_lc_job_number_processing_dashboard_data_single(String web_service_url,
			String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "maps_service/select_lc_spatial_objects_search_by_other_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, "");
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String save_lrd_registration_processing_data_single(String web_service_url, String web_service_api_key) {

		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "maps_service/select_lc_spatial_objects_search_by_other_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, "");
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;
	}

	public String save_lrd_registration_sub_process_data_single(String web_service_url, String web_service_api_key) {

		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "maps_service/select_lc_spatial_objects_search_by_other_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
			ClientResponse response = webResource.accept("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, "");
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
