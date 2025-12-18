package ws.csaumgt;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_csau_monitoring {

    // public String monitoring_csau(String web_service_url, String web_service_api_key) {
	// 	String output = "Data Not Received";

	// 	try {
	// 		Client client = Client.create();
	// 		WebResource webResource = client
	// 				.resource(web_service_url + "csau_monitoring/load_apps");
	// 		ClientResponse response = webResource.accept("application/json")
	// 				.header("x-api-key", web_service_api_key).post(ClientResponse.class);
	// 		if (response.getStatus() != 200) {
	// 			throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
	// 		}
	// 		output = response.getEntity(String.class);
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	}

	// 	return output;
	// }


	public String monitoring_csau(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/load_apps1");
			ClientResponse response = webResource.type("application/json").header("x-api-key", web_service_api_key)
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



	




	 public String monitoring_csau1(String web_service_url, String web_service_api_key) {
		String output = "Data Not Received";

		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_dash");
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

	
	public String select_count_received_today_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_received_today_by_csau_front_officers");
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



	public String select_count_received_month_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_received_month_by_csau_front_officers");
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



	public String select_count_received_year_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_received_year_by_csau_front_officers");
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



	public String select_applications_received_year_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_received_year_by_csau_front_officers");
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



	public String select_applications_received_month_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_received_month_by_csau_front_officers");
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



	public String select_6months_bills_created_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_6months_bills_created_by_csau_front_officers");
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



		public String select_bills_created_by_csau_front_officers_and_paid(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_bills_created_by_csau_front_officers_and_paid");
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




	public String select_bills_created_by_csau_front_officers_and_acknowledged(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_bills_created_by_csau_front_officers_and_acknowledged");
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


		public String get_bills_created_by_csau_front_officers_last6months(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_bills_created_by_csau_front_officers_last6months");
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



	public String get_bills_created_by_csau_front_officers_last6months_and_paid(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_bills_created_by_csau_front_officers_last6months_and_paid");
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




	public String get_bills_created_by_csau_front_officers_last6months_and_acknow(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_bills_created_by_csau_front_officers_last6months_and_acknow");
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




	public String get_applications_signedout_year(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_applications_signedout_year");
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




	public String get_applications_signedout_today(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_applications_signedout_today");
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




	public String get_applications_signedout_month(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_applications_signedout_month");
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


	public String select_count_received_week_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_received_week_by_csau_front_officers");
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



	public String select_applications_received_week_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_received_week_by_csau_front_officers");
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


		public String select_applications_received_today_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_received_today_by_csau_front_officers");
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







	public String get_applications_signedout_week(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_applications_signedout_week");
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


	public String select_count_signedout_today_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_signedout_today_by_csau_front_officers");
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




	public String select_count_signedout_week_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_signedout_week_by_csau_front_officers");
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



	public String select_count_signedout_month_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_signedout_month_by_csau_front_officers");
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



	public String select_count_signedout_year_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_count_signedout_year_by_csau_front_officers");
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




	public String select_applications_signedout_year_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_signedout_year_by_csau_front_officers");
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


	public String select_applications_signedout_today_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_signedout_today_by_csau_front_officers");
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


	public String select_applications_signedout_week_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_signedout_week_by_csau_front_officers");
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



	public String select_applications_signedout_month_by_csau_front_officers(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_applications_signedout_month_by_csau_front_officers");
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



	public String select_bills_today_by_csau_front_officers_and_paid(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_bills_today_by_csau_front_officers_and_paid");
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



	public String get_bills_created_by_csau_front_officers_today_and_paid(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_bills_created_by_csau_front_officers_today_and_paid");
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


	public String select_bills_today_by_csau_front_officers_and_acknowledged(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/select_bills_today_by_csau_front_officers_and_acknowledged");
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



	public String get_bills_created_by_csau_front_officers_today_and_acknowledged(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/get_bills_created_by_csau_front_officers_today_and_acknowledged");
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



	public String csau_report_count_received_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_count_received_by_csau_front_officers_by_date");
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





	public String csau_report_apps_received_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_apps_received_by_csau_front_officers_by_date");
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





	public String csau_report_count_signedout_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_count_signedout_by_csau_front_officers_by_date");
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





	public String csau_report_apps_signedout_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_apps_signedout_by_csau_front_officers_by_date");
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




	public String csau_report_count_bills_created_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_count_bills_created_by_csau_front_officers_by_date");
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


	public String csau_report_all_bills_created_by_csau_front_officers_by_date(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "csau_monitoring/csau_report_all_bills_created_by_csau_front_officers_by_date");
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




	

	



	public String compliance_executive_dashboard10(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard10");
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



	public String compliance_executive_dashboard11(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard11");
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



	public String compliance_executive_dashboard12(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard12");
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



	public String compliance_executive_dashboard13(String web_service_url, String web_service_api_key, String json_request) {
		//System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_executive/compliance_executive_dashboard13");
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
