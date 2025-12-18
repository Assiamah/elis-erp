package ws.compliance;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class ws_focal_compliance {

    public String compliance_focal_report_dashboard_created_today(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_today");
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





	public String compliance_focal_report_dashboard_created_day_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_day_by_division");
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




    public String compliance_focal_report_dashboard_created_day_by_service_type(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_day_by_service_type");
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




	public String compliance_focal_report_dashboard_created_this_month(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_this_month");
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




	public String compliance_focal_report_dashboard_created_month_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_month_by_division");
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




	public String compliance_focal_report_dashboard_created_month_by_service_type(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_month_by_service_type");
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



	public String compliance_focal_report_dashboard_completed_today(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_today");
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




	public String compliance_focal_report_dashboard_completed_month(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_month");
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




	public String compliance_focal_report_dashboard_completed_today_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_today_by_division");
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





	public String compliance_focal_report_dashboard_completed_month_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_month_by_division");
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


	public String compliance_focal_report_dashboard_completed_today_by_service_ty(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_today_by_service_ty");
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




	public String compliance_focal_report_dashboard_completed_month_by_service_ty(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_month_by_service_ty");
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




	public String compliance_focal_report_dashboard_all(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_all");
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




	public String compliance_focal_report_dashboard_created_year_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_year_by_division");
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





	public String compliance_focal_report_dashboard_created_year_by_service_type(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_year_by_service_type");
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






	public String compliance_focal_report_dashboard_created_completed_year_by_div(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_completed_year_by_div");
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




	public String compliance_focal_report_dashboard_created_completed_year_by_ser(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_created_completed_year_by_ser");
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



	public String compliance_focal_report_dashboard_completed_year_by_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_year_by_division");
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



	public String compliance_focal_report_dashboard_completed_year_by_service_typ(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_report_dashboard_completed_year_by_service_typ");
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



    public String compliance_focal_apps_pastdue_units(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_pastdue_units");
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



    public String compliance_focal_apps_pastdue_within_unit(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_pastdue_within_unit");
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





    public String compliance_focal_apps_pastdue_with_officer(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_pastdue_with_officer");
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





    public String compliance_focal_apps_with_division(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_with_division");
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




    public String compliance_focal_apps_with_division_unit(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_with_division_unit");
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








    public String compliance_focal_apps_with_division_staff_apps(String web_service_url, String web_service_api_key, String json_request) {
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(web_service_url + "compliance_focal/compliance_focal_apps_with_division_staff_apps");
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



    




    
    

    

}


