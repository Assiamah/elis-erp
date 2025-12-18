package ws.cica;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_cica {

	public String save_client_details(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/save_clients_details");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String open_ticket(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/open_ticket");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_complaints(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_complaints");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String reply_ticket(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/reply_ticket");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String get_ticket_replies(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/get_ticket_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String get_client_replies(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/get_client_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String client_reply(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/client_reply");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String status_update(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/status_update");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_counts(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_counts");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_focal_person_counts(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_focal_person_counts");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_replies_counts(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_replies_counts");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_replies_counts(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_replies_counts_");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_replies(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String search_archived(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/search_archived");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String get_ticket_by_id(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/get_ticket_by_id");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public void sendMail(String web_service_url, String web_service_api_key, String json_request) {

		try {
			Client client = Client.create();

			WebResource webResource = client
					.resource("http://localhost:4001/api/email/cica/send_mail");
			ClientResponse response_ws = webResource.type("application/json").post(ClientResponse.class, json_request);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void sendText(String web_service_url, String web_service_api_key, String json_request) {
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource("http://10.4.1.47:8080/gelis_online_service_live/rest/email_service/send_smtp");
			ClientResponse response_ws = webResource.type("application/json").post(ClientResponse.class, json_request);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String load_enquiry_service(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_enquiry_service");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String get_tickets_by_id(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/get_tickets_by_id");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String forward_ticket(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/forward_ticket");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_unit_tickets(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_unit_tickets");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_reports(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_reports");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_tickets(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_tickets");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String update_ticket_details(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/update_ticket_details");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_ticket_details(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_ticket_details");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_ticket_one_replies(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_ticket_one_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String update_ticket_status(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/update_ticket_status");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_status_note(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_status_note");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String reply_to_ticket(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/reply_to_ticket");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_ticket_replies(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_ticket_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String forward_tickets(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/forward_tickets");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_focal_person_tickets(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_focal_person_tickets");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String forward_focal_tickets(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/forward_focal_tickets");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String archive_replies(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/archive_replies");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String send_single_sms(String web_service_url, String web_service_api_key, String data_input)

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

	public String save_reply_message(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/save_reply_message");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			output = response.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return output;
	}

	public String load_sms_messages(String web_service_url, String web_service_api_key, String json_request) {
		// TODO Auto-generated method stub
		String output = "Data Not Received";
		try {

			Client client = Client.create();

			WebResource webResource = client
					.resource(web_service_url + "cica_services/load_sms_messages");
			ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
					.post(ClientResponse.class, json_request);
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
