package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_compliance_regional {

	public String report_dashboard_all_get(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "regional_compliance_service/report_dashboard_all");
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

	public String report_dashboard_all_post(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "regional_compliance_service/report_dashboard_all");
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

	public String report_dashboard_created_today_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_created_today");
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

	public String report_dashboard_created_day_by_division_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_day_by_division");
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

	public String report_dashboard_created_day_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_day_by_service_type");
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

	public String report_dashboard_created_month_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_created_month");
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

	public String report_dashboard_created_month_by_division_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_month_by_division");
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

	public String report_dashboard_created_month_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_month_by_service_type");
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

	public String report_dashboard_completed_today_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_completed_today");
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

	public String report_dashboard_completed_day_by_division_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_day_by_division");
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

	public String report_dashboard_completed_day_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_day_by_service_type");
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

	public String report_dashboard_completed_month_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_completed_month");
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

	public String report_dashboard_completed_month_by_division_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_month_by_division");
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

	public String report_dashboard_completed_month_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_month_by_service_type");
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

	public String report_dashboard_created_year_by_service_type_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_year_by_division");
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

	public String report_dashboard_created_year_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_year_by_service_type");
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

	public String report_dashboard_completed_year_by_service_type_post(String web_service_url,
			String web_service_api_key, String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_year_by_division");
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

	public String report_dashboard_completed_year_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_completed_year_by_service_type");
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

	public String report_dashboard_received_completed_year_by_service_type_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_completed_year_by_division");
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

	public String report_dashboard_received_completed_year_application_for_each_service_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_created_completed_year_by_service_type");
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

	public String report_dashboard_units_with_apps_past_due_year_post(String web_service_url,
			String web_service_api_key, String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: change this endpoint to get units with past due
			// applications in a year
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_within_division");
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

	public String report_dashboard_officers_within_units_with_apps_past_due_year_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: change this endpoint to get officers within units with past
			// due applications in a year
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_within_each_unit");
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

	public String report_dashboard_applications_with_officers_that_are_apps_past_due_year_post(String web_service_url,
			String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: change this endpoint to get applications with officers that
			// are past due applications in a year
			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_for_each_staff");
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

	public String report_dashboard_units_with_apps_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_within_division");
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

	public String report_dashboard_officers_within_units_with_apps_post(String web_service_url,
			String web_service_api_key, String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_within_each_unit");
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

	public String report_dashboard_applications_with_officers_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(
					web_service_url + "regional_compliance_service/report_dashboard_unit_for_each_staff");
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

	public String send_compliance_message_post(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "regional_compliance_service/report_dashboard_compliance_create_notice");
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
