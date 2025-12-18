package ws.users;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class Ws_users {

	public String checkUser(String web_service_url, String web_service_api_key, String user_name, String password)

	{
		String output = null;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();

				//System.out.println(web_service_url + "user_management_service/load_user_for_login");
				//System.out.println(web_service_api_key);
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/load_user_for_login");
				JSONObject obj = new JSONObject();
				obj.put("user_name", user_name);
				obj.put("password", password);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				System.out.println(input);
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
	
	public String select_user_by_userid(String web_service_url, String web_service_api_key, String user_name)

	{
		String output = null;
		try {
			try {
				JSONArray jsonArr = new JSONArray();

				Client client = Client.create();

				System.out.println(web_service_url + "user_management_service/select_user_by_userid");
				System.out.println(web_service_api_key);
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/select_user_by_userid");
				JSONObject obj = new JSONObject();
				obj.put("user_name", user_name);
				//obj.put("password", password);
				jsonArr.put(obj);
				String input = jsonArr.toString();
				System.out.println(input);
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

	public String add_new_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/add_new_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String update_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/update_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String delete_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/delete_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String corp_add_new_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url
								+ "corporate_portal_sub_users_service/select_corporate_portal_sub_users_add");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String corp_add_new(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url
								+ "corporate_portal_sub_users_service/select_corporate_portal_users_add");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String corp_update_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "corporate_portal_users_service/select_corporate_portal_users_add");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String select_corporate_portal_sub_users_all_by_org(String web_service_url, String web_service_api_key,
			String job_number)

	{
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_portal_sub_users_service/select_corporate_portal_sub_users_all_by_org"); //
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

	public String update_user_profile(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/update_user_profile");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String select_update_user_profile_per_user(String web_service_url, String web_service_api_key,
			String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "user_management_service/select_update_user_profile_per_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	
	public String select_update_user_milestone_per_user(String web_service_url, String web_service_api_key,
			String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url
						+ "user_management_service/select_update_user_milestone_per_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String user_profile_for_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(
						web_service_url + "user_management_service/user_profile_for_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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
	

	public String select_lc_milestone_per_user(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(
						web_service_url + "user_management_service/select_lc_milestone_per_user");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String get_list_of_users(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_users");
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

	public String get_list_of_users_per_region(String web_service_url, String web_service_api_key, String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_users_per_region");
			ClientResponse response = webResource.type("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	public String get_list_of_users_division(String web_service_url, String web_service_api_key, String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_users_division");
			ClientResponse response = webResource.type("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			// ClientResponse response =
			// webResource.accept("application/json").header("x-api-key",
			// web_service_api_key).get(ClientResponse.class);
			if (response.getStatus() != 201) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);

		} catch (Exception e) {

			e.printStackTrace();

		}
		return output;

	}

	public String get_all_menu(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_menu");
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

	public String get_all_dashboard_menu(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_dashboard_menu");
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

	public String get_all_dashboard_menu(String web_service_url, String web_service_api_key, String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "user_management_service/get_all_dashboard_menu_by_user");
			ClientResponse response = webResource.type("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	
	public String select_all_assigned_milestone(String web_service_url, String web_service_api_key, String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "user_management_service/select_all_assigned_milestone");
			ClientResponse response = webResource.type("application/json")
					.header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
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

	public String get_list_of_users_new(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_users");
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

	public String get_all_users_short(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_users_short");
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

	public String get_all_regions(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/get_all_regions");
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

	public String select_user_for_two_factor_verification(String web_service_url, String web_service_api_key,
			String user_name, String password) {
		String output = null;
		try {
			try {
				// JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/select_user_for_two_factor_verification");
				JSONObject obj = new JSONObject();
				obj.put("username", user_name);
				obj.put("password", password);
				// jsonArr.put(obj);
				String input = obj.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
				// ClientResponse response_ws =
				// webResource.type("application/json").header("api-key",
				// Ws_url_config.get_egcr_apikey()).post(ClientResponse.class,
				// json_request);.post(ClientResponse.class, input);
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

	

	public String select_self_change_user_password(String web_service_url, String web_service_api_key,
			String user_name, String password) {
		String output = null;
		try {
			try {
				// JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/select_self_change_user_password");
				JSONObject obj = new JSONObject();
				obj.put("username", user_name);
				obj.put("password", password);
				// jsonArr.put(obj);
				String input = obj.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
				// ClientResponse response_ws =
				// webResource.type("application/json").header("api-key",
				// Ws_url_config.get_egcr_apikey()).post(ClientResponse.class,
				// json_request);.post(ClientResponse.class, input);
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

	public String send_code_for_password_reset(String web_service_url, String web_service_api_key,
			String user_name) {
		String output = null;
		try {
			try {
				// JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/send_code_for_password_reset");
				JSONObject obj = new JSONObject();
				obj.put("username", user_name);
				//obj.put("password", password);
				// jsonArr.put(obj);
				String input = obj.toString();
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
				// ClientResponse response_ws =
				// webResource.type("application/json").header("api-key",
				// Ws_url_config.get_egcr_apikey()).post(ClientResponse.class,
				// json_request);.post(ClientResponse.class, input);
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

	public String office_verify_verification_token(String web_service_url, String web_service_api_key,
			String request_json) {
		String output = null;
		try {
			try {
				// JSONArray jsonArr = new JSONArray();

				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/office_verify_verification_token");

				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, request_json);
				// ClientResponse response_ws =
				// webResource.type("application/json").header("api-key",
				// Ws_url_config.get_egcr_apikey()).post(ClientResponse.class,
				// json_request);.post(ClientResponse.class, input);
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

	public String usp_users_access_logs(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				// WebResource webResource =
				// client.resource(ws_url_config.get_user_account_web_service_url_ser() +
				// "user_management_service/usp_users_access_logs");
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/usp_users_access_logs");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

	public String select_corporate_portal_sub_users_all(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "user_management_service/select_corporate_portal_sub_users_all");
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

	public String select_corporate_portal_users_all(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "corporate_portal_users_service/select_corporate_portal_users_all");
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


		public String select_user_account_all_by_unit_per_region(String web_service_url, String web_service_api_key, String data_input)

	{
		String output = null;
		// boolean st =false;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client
						.resource(web_service_url + "user_management_service/select_user_account_all_by_unit_per_region");
				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class,
								data_input);
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

}
