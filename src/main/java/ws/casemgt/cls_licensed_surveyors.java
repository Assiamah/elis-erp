package ws.casemgt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class cls_licensed_surveyors {

	public String online_smd_licensed_surveyors_list_by_number(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "maps_service/select_lc_spatial_objects_search_by_other_details");
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

	public String online_smd_licensed_surveyors_list(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_licensed_surveyors_list");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_calculate_ls_capacity(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_calculate_ls_capacity");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_capacity_determinants_all(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_capacity_determinants_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_copy_determinant_factors(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_copy_determinant_factors");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_copy_ls_details(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_copy_ls_details");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_cr_category_sub_classification_by_mc_code(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_cr_category_sub_classification_by_mc_code");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_ls_surveyor_capacity_all(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_ls_surveyor_capacity_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_ls_surveyor_capacity_by_ls_number(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_ls_surveyor_capacity_by_ls_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_ls_surveyor_capacity_determinants_by_ls_number(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_ls_surveyor_capacity_determinants_by_ls_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_ls_surveyor_list_all(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_ls_surveyor_list_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_survey_request_all(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_survey_request_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_survey_request_all_by_client(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_survey_request_all_by_client");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String select_survey_request_all_by_ls(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/select_survey_request_all_by_ls");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String survey_request_genere_regional_number(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/survey_request_genere_regional_number");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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

	public String survey_request_insert_update_all(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "licensed_surveyors_service/survey_request_insert_update_all");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,"");
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
