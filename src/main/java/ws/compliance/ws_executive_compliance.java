package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_executive_compliance {


	// public String compliance_executive_dashboard10(String report_web_service_url, String web_service_api_key, String json_request) {
	// 	////System.out.println(json_request);
	// 	String output = "Data Not Received";
	// 	try {
	// 		Client client = Client.create();
	// 		WebResource webResource = client
	// 				.resource(report_web_service_url + "compliance_executive/compliance_executive_dashboard10");
	// 		ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
	// 				.post(ClientResponse.class, json_request);
	// 		if (response.getStatus() != 200) {
	// 			throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
	// 		}
	// 		output = response.getEntity(String.class);
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	}

	// 	return output;

	// }
	


	// public String compliance_executive_dashboard11(String report_web_service_url, String web_service_api_key, String json_request) {
	// 	////System.out.println(json_request);
	// 	String output = "Data Not Received";
	// 	try {
	// 		Client client = Client.create();
	// 		WebResource webResource = client
	// 				.resource(report_web_service_url + "compliance_executive/compliance_executive_dashboard11");
	// 		ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
	// 				.post(ClientResponse.class, json_request);
	// 		if (response.getStatus() != 200) {
	// 			throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
	// 		}
	// 		output = response.getEntity(String.class);
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	}

	// 	return output;

	// }



	// public String compliance_executive_dashboard12(String report_web_service_url, String web_service_api_key, String json_request) {
	// 	////System.out.println(json_request);
	// 	String output = "Data Not Received";
	// 	try {
	// 		Client client = Client.create();
	// 		WebResource webResource = client
	// 				.resource(report_web_service_url + "compliance_executive/compliance_executive_dashboard12");
	// 		ClientResponse response = webResource.accept("application/json").header("x-api-key", web_service_api_key)
	// 				.post(ClientResponse.class, json_request);
	// 		if (response.getStatus() != 200) {
	// 			throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
	// 		}
	// 		output = response.getEntity(String.class);
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	}

	// 	return output;

	// }



	public String executive_dashboard_report_all_count(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_report_all_count");
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



		public String executive_dashboard_report_charts(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_report_charts");
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


		public String executive_dashboard_get_division_totals(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_get_division_totals");
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




		public String executive_dashboard_get_regional_received(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_get_regional_received");
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



	public String executive_dashboard_get_regional_completed_stats(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_get_regional_completed_stats");
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




	public String executive_dashboard_apps_recieved(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_recieved");
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



	public String executive_dashboard_apps_by_subservices_recieved(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_subservices_recieved");
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



		public String executive_dashboard_applications_recieved(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_applications_recieved");
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



	public String executive_dashboard_apps_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_pending");
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


	
		public String executive_dashboard_apps_by_subservices_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_subservices_pending");
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


		
		public String executive_dashboard_applications_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_applications_pending");
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



				//Completed


	public String executive_dashboard_apps_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_completed");
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


	
		public String executive_dashboard_apps_by_subservices_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_subservices_completed");
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


		
		public String executive_dashboard_applications_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_applications_completed");
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





	//RECEIVED COMPLETED

	public String executive_dashboard_apps_recieved_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_recieved_completed");
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


	
		public String executive_dashboard_apps_by_subservices_received_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_subservices_received_completed");
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


		
		public String executive_dashboard_applications_received_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_applications_received_completed");
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





	// QUERIED

	public String executive_dashboard_apps_queried(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_queried");
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


	
		public String executive_dashboard_apps_by_subservices_queried(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_subservices_queried");
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


		
		public String executive_dashboard_applications_queried(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_applications_queried");
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




		
		public String executive_dashboard_report_received_vs_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_report_received_vs_pending");
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




		
		public String executive_dashboard_apps_by_regions(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_regions");
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




	public String executive_dashboard_regional_apps_division(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_regional_apps_division");
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



	public String executive_dashboard_apps_past_due(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_past_due");
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




	public String executive_dashboard_apps_past_due_regions(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_past_due_regions");
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




	public String executive_dashboard_apps_pastdue_units(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_pastdue_units");
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



	public String executive_dashboard_apps_pastdue_within_unit(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_pastdue_within_unit");
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




	public String executive_dashboard_apps_pastdue_with_officer(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_pastdue_with_officer");
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





		public String executive_dashboard_apps_by_regions_to_divisions(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_apps_by_regions_to_divisions");
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




	public String executive_dashboard_divisions_services(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_divisions_services");
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


	public String executive_dashboard_divisions_sub_services(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_divisions_sub_services");
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



		public String executive_dashboard_divisions_sub_services_applications(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_divisions_sub_services_applications");
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


	public String executive_dashboard_get_apps_by_subservices_for_barchart(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "compliance_executive/executive_dashboard_get_apps_by_subservices_for_barchart");
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


