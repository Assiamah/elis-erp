package ws.corporate;


import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;


public class ws_corporate_apps {



    public String corporate_applications_report_dashboard_all(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_all");
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




    public String corporate_applications_division_apps(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_division_apps");
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




    public String corporate_applications_division_apps_by_service(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_division_apps_by_service");
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





    public String corporate_applications_report_dashboard_created_today(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_today");
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


    public String corporate_applications_report_dashboard_created_day_by_division(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_day_by_division");
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




    public String corporate_applications_report_dashboard_created_day_by_service(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_day_by_service");
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





    public String corporate_applications_report_dashboard_created_month(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_month");
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




    public String corporate_applications_report_dashboard_created_month_by_divisi(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_month_by_divisi");
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





    public String corporate_applications_report_dashboard_created_month_by_servic(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_month_by_servic");
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





    public String corporate_applications_report_dashboard_completed_today(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_today");
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




    public String corporate_applications_report_dashboard_completed_day_by_divisi(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_day_by_divisi");
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




    public String corporate_applications_report_dashboard_completed_day_by_servic(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_day_by_servic");
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




    public String corporate_applications_report_dashboard_completed_month(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_month");
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





    public String corporate_applications_report_dashboard_completed_month_by_divi(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_month_by_divi");
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





    public String corporate_applications_report_dashboard_completed_month_by_serv(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_month_by_serv");
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




    public String corporate_applications_report_dashboard_recieved_between_dates(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_recieved_between_dates");
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




    public String  corporate_applications_report_dashboard_created_by_date_range(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_created_by_date_range");
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




    public String  corporate_applications_division_apps_by_service_date_range(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_division_apps_by_service_date_range");
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




    public String  corporate_apps_report_dashboard_recieved_completed_by_dates(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_apps_report_dashboard_recieved_completed_by_dates");
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




    public String  corporate_apps_report_dashboard_created_comp_by_date_range(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_apps_report_dashboard_created_comp_by_date_range");
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






    public String  corporate_app_division_apps_by_service_date_range_rec_comp(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_app_division_apps_by_service_date_range_rec_comp");
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




    public String  corporate_applications_report_dashboard_completed_by_dates(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_by_dates");
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



    public String  corporate_applications_report_dashboard_completed_by_date(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_by_date");
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




    public String  corporate_applications_report_dashboard_completed_by_serv_dates(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_completed_by_serv_dates");
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



	public String  corporate_sub_applications_report_dashboard_created_today(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_sub_applications_report_dashboard_created_today");
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



	public String  corporate_sub_applications_report_dashboard_created_month(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_sub_applications_report_dashboard_created_month");
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




	public String  corporate_sub_applications_report_dashboard_completed_day(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_sub_applications_report_dashboard_completed_day");
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



	public String  corporate_sub_applications_report_dashboard_completed_month(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_sub_applications_report_dashboard_completed_month");
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








	public String corporate_applications_report_dashboard_past_due_apps(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_past_due_apps");
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




	public String corporate_applications_report_dashboard_apps_past_due_officer(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_applications_report_dashboard_apps_past_due_officer");
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





	public String corporate_dashboard_two_all(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_all");
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





	public String corporate_dashboard_two_apps_recieved(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_recieved");
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





	public String corporate_dashboard_two_apps_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_pending");
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




	public String corporate_dashboard_two_apps_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_completed");
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





	public String corporate_dashboard_two_apps_by_subservices_recieved(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_recieved");
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






	public String corporate_dashboard_two_apps_by_subservices_completed(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_completed");
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




	public String corporate_dashboard_two_apps_by_subservices_pending(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_pending");
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


	
	public String corporate_dashboard_two_apps_by_subservices_recieved_from_banks(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_recieved_from_banks");
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




	public String corporate_dashboard_two_apps_by_subservices_pending_from_banks(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_pending_from_banks");
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




	public String corporate_dashboard_two_apps_by_subservices_completed_from_bank(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_completed_from_bank");
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





	public String corporate_dashboard_two_applications_recieved_from_bank(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_applications_recieved_from_bank");
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



	public String corporate_dashboard_two_applications_pending_from_bank(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_applications_pending_from_bank");
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




	public String corporate_dashboard_two_applications_completed_from_bank(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_applications_completed_from_bank");
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




	public String corporate_dashboard_two_all_chart(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_all_chart");
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



	public String corporate_dashboard_two_applications_top_five_banks(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_applications_top_five_banks");
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




	public String corporate_dashboard_two_all_barchart(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_all_barchart");
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



	public String corporate_dashboard_two_apps_queried(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_queried");
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







	public String corporate_dashboard_two_apps_by_subservices_queried(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_queried");
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





	public String corporate_dashboard_two_apps_by_subservices_queried_from_banks(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_apps_by_subservices_queried_from_banks");
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







	public String corporate_dashboard_two_applications_queried_from_bank(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/corporate_dashboard_two_applications_queried_from_bank");
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



	public String report_on_the_corporate_applications(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/report_on_the_corporate_applications");
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




	public String report_on_the_corporate_applications_by_services(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/report_on_the_corporate_applications_by_services");
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
	





	public String report_on_the_corporate_applications_by_sub_services(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/report_on_the_corporate_applications_by_sub_services");
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
	





	public String report_on_the_corporate_applications_by_applications(String report_web_service_url, String web_service_api_key, String json_request) {
		////System.out.println(json_request);
		String output = "Data Not Received";
		try {
			Client client = Client.create();
			WebResource webResource = client
					.resource(report_web_service_url + "corporate_apps_dashboard/report_on_the_corporate_applications_by_applications");
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
