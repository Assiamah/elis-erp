package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_compliance {

	public String report_dashboard_all_get(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_service/report_dashboard_all");
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
					.resource(web_service_url + "compliance_service/report_dashboard_all");
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
					web_service_url + "compliance_service/report_dashboard_created_today");
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
					+ "compliance_service/report_dashboard_created_day_by_division");
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
					+ "compliance_service/report_dashboard_created_day_by_service_type");
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
					web_service_url + "compliance_service/report_dashboard_created_month");
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
					+ "compliance_service/report_dashboard_created_month_by_division");
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
					+ "compliance_service/report_dashboard_created_month_by_service_type");
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
					web_service_url + "compliance_service/report_dashboard_completed_today");
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
					+ "compliance_service/report_dashboard_completed_day_by_division");
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
					+ "compliance_service/report_dashboard_completed_day_by_service_type");
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
					web_service_url + "compliance_service/report_dashboard_completed_month");
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
					+ "compliance_service/report_dashboard_completed_month_by_division");
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
					+ "compliance_service/report_dashboard_completed_month_by_service_type");
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
					+ "compliance_service/report_dashboard_created_year_by_division");
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
					+ "compliance_service/report_dashboard_created_year_by_service_type");
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
					+ "compliance_service/report_dashboard_completed_year_by_division");
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
					+ "compliance_service/report_dashboard_completed_year_by_service_type");
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
					+ "compliance_service/report_dashboard_created_completed_year_by_division");
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
					+ "compliance_service/report_dashboard_created_completed_year_by_service_type");
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
					web_service_url + "compliance_service/report_dashboard_unit_within_division");
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
					web_service_url + "compliance_service/report_dashboard_unit_within_each_unit");
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
					web_service_url + "compliance_service/report_dashboard_unit_for_each_staff");
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
					web_service_url + "compliance_service/report_dashboard_unit_within_division");
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
					web_service_url + "compliance_service/report_dashboard_unit_within_each_unit");
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
					web_service_url + "compliance_service/report_dashboard_unit_for_each_staff");
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

	public String select_reminder_apps_from_complaince_notice_by_unit(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(
					web_service_url + "compliance_service/select_reminder_apps_from_complaince_notice_by_unit");
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

	public String select_warning_apps_from_complaince_notice_by_unit(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			WebResource webResource = client.resource(
					web_service_url + "compliance_service/select_warning_apps_from_complaince_notice_by_unit");
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
					+ "compliance_service/report_dashboard_compliance_create_notice");
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

	public String send_compliance_focal_person_message(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/send_compliance_focal_person_message");
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

	public String select_update_compliance_notice_to_active(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/select_update_compliance_notice_to_active");
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

	public String select_compliance_application_notice_by_unit(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/select_compliance_application_notice_by_unit");
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

	public String select_compliance_application_notice_count_per_region(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/select_compliance_application_notice_count_per_region");
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

	public String update_compliance_application_notice(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/update_compliance_application_notice");
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

	public String select_responses_on_compliance_application_notice(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();

			// TODO: send data to appropriate endpoint
			WebResource webResource = client.resource(web_service_url
					+ "compliance_service/select_responses_on_compliance_application_notice");
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

	public String compliance_executive_dashboard(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard");
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


	public String compliance_executive_dashboard10(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard10");
			ClientResponse response = webResource.type("application/json")
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



	public String compliance_executive_dashboard11(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard11");
			ClientResponse response = webResource.type("application/json")
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


	public String compliance_executive_dashboard12(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard12");
			ClientResponse response = webResource.type("application/json")
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




	public String compliance_executive_dashboard13(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard13");
			ClientResponse response = webResource.type("application/json")
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



	public String compliance_executive_dashboard1(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard1");
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

	public String corporate_applications_report_dashboard_created_year_by_divisio(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_created_year_by_divisio");
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



	public String corporate_applications_report_dashboard_created_year_by_service(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_created_year_by_service");
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



	public String corporate_applications_report_dashboard_completed_year_by_divis(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_year_by_divis");
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





	public String corporate_applications_report_dashboard_completed_year_by_servi(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_year_by_servi");
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




	public String corporate_applications_report_dashboard_created_completed_year(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_created_completed_year");
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

	public String corporate_applications_report_dashboard_created_completed(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_created_completed");
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

	public String corporate_applications_report_dashboard_unit_within_division(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_unit_within_division");
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

	public String corporate_applications_report_dashboard_unit_within_each_unit(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_unit_within_each_unit");
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


	public String corporate_applications_report_dashboard_unit_for_each_staff(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_unit_for_each_staff");
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

	public String corporate_applications_report_dashboard_apps_past_due_officer(String web_service_url, String web_service_api_key,
	String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_apps_past_due_officer");
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

		public String corporate_applications_report_dashboard_apps_past_due_appss(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "corporate_apps_dashboard/corporate_applications_report_dashboard_apps_past_due_appss");
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





		public String corporate_processing_units_staff(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/corporate_processing_units_staff");
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



		public String corporate_applications_report_dashboard_by_subservice(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/corporate_applications_report_dashboard_by_subservice");
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




		public String corporate_processing_units_application_with_stamping_staff(String web_service_url, String web_service_api_key,
			String json_request) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(web_service_url
					+ "case_management_service/corporate_processing_units_application_with_stamping_staff");
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
