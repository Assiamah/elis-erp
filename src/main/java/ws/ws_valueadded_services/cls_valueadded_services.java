package ws.ws_valueadded_services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;

// import jakarta.naming.NamingException;
// import jakarta.ws.rs.Consumes;
// import jakarta.ws.rs.POST;
// import jakarta.ws.rs.Path;
// import jakarta.ws.rs.Produces;
// import jakarta.ws.rs.core.MediaType;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.mit.elis.class_common.Ws_url_config;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;


public class cls_valueadded_services {

	@Autowired
	private Ws_url_config cls_url_config;

	static Ws_url_config ws_url_config = new Ws_url_config();

	public String get_all_current_published_application(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/get_all_current_published_application");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_location_by_glpin(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_location_by_glpin");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_stamp_duty_payment(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_stamp_duty_payment");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_lc_bill_status(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_lc_bill_status");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_search_report(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_search_report");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_location_by_coordinate(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_location_by_coordinate");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_approved_plan(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_approved_plan");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String verify_land_register(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_land_register");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

	

	public String verify_certificate(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/verify_certificate");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

	
	public String check_existing_linked_rent_account(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/check_existing_linked_rent_account");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

	public String get_published_application_details(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/get_published_application_details");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	
	public String select_review_digital_workflow(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/select_review_digital_workflow");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	public String select_general_request_workflow(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/select_general_request_workflow");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}



	
	public String select_review_baby_steps_digital_workflow(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/select_review_baby_steps_digital_workflow");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

		public String select_set_request_as_completed(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/select_set_request_as_completed");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

		public String process_sent_jobs_for_records_verification(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/process_sent_jobs_for_records_verification");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}

		public String select_user_for_two_factor_verification(String web_service_url, String web_service_api_key,
			String user_name, String password) {
		String output = "Data Not Received";
		try {

				JSONObject obj = new JSONObject();
				obj.put("username", user_name);
				obj.put("password", password);
				// jsonArr.put(obj);
				String input = obj.toString();
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/select_user_for_two_factor_verification");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


		public String get_all_baby_steps_for_job(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/get_all_baby_steps_for_job");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}


	
		public String get_process_milestone_update_baby_steps_for_job(String web_service_url, String web_service_api_key,
			String data_input) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "value_added_service/get_process_milestone_update_baby_steps_for_job");
			ClientResponse response_ws = webResource.type("application/json").header("x-api-key", web_service_api_key).post(ClientResponse.class, data_input);
			if (response_ws.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response_ws.getStatus());
			}
			output = response_ws.getEntity(String.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return output;

	}
	

	


}
