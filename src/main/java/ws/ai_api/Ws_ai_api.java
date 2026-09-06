package ws.ai_api;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import org.codehaus.jettison.json.JSONObject;
public class Ws_ai_api {

		public String select_ai_response(String web_service_url, String web_service_api_key, String json_request) {
		String output = null;
		try {
			try {
				Client client = Client.create();
				WebResource webResource = client.resource(web_service_url + "ai_agent_api/query");

				ClientResponse response_ws = webResource.type("application/json")
						.header("x-api-key", web_service_api_key).post(ClientResponse.class, json_request);
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
public String select_llm_response(
        String web_service_url,
        String web_service_api_key,
        String json_request) {

    String output = null;

    try {

        try {

            Client client = Client.create();

            WebResource webResource =
                    client.resource(
                            "http://localhost:11434/api/generate"
                    );

            System.out.println(
                    "Calling Ollama: "
                    + "http://localhost:11434/api/generate"
            );

            System.out.println(
                    "Ollama Request: "
                    + json_request
            );

            ClientResponse response_ws =
                    webResource
                            .type("application/json")
                            .post(
                                    ClientResponse.class,
                                    json_request
                            );

            System.out.println(
                    "Ollama Response Status: "
                    + response_ws.getStatus()
            );


            if (response_ws.getStatus() != 200) {

                String error =
                        response_ws.getEntity(
                                String.class
                        );

                System.out.println(
                        "Ollama Error Response: "
                        + error
                );

                throw new RuntimeException(
                        "Failed : HTTP error code : "
                        + response_ws.getStatus()
                        + " - "
                        + error
                );
            }


            String ollama_response =
                    response_ws.getEntity(
                            String.class
                    );


            System.out.println(
                    "Ollama Raw Response: "
                    + ollama_response
            );


            // JSONObject response_json =
            //         new JSONObject(
            //                 ollama_response
            //         );

  output =ollama_response;
                    
            // output =
            //         response_json.optString(
            //                 "response",
            //                 ""
            //         );


            response_ws.close();

            client.destroy();


        } catch (Exception e) {

            e.printStackTrace();
        }


    } catch (Exception e) {

        e.printStackTrace();
    }


    return output;
}

	public String prepare_llm_prompt(String json_request) {

    StringBuilder prompt = new StringBuilder();

    try {

        JSONObject obj_d =
                new JSONObject(json_request);


        /*
         * Extract application information
         */
        String user_question =
                obj_d.optString(
                        "user_question",
                        ""
                );

        String case_number =
                obj_d.optString(
                        "case_number",
                        ""
                );

        String job_number =
                obj_d.optString(
                        "job_number",
                        ""
                );

        String business_process_sub_name =
                obj_d.optString(
                        "business_process_sub_name",
                        ""
                );

 String applicationdetails =
                obj_d.optString(
                        "applicationdetails",
                        ""
                );

				

        /*
         * AI SYSTEM CONTEXT
         */
        prompt.append(
                "You are an AI assistant for a Land Administration System.\n\n"
        );


        /*
         * CASE INFORMATION
         */
        prompt.append(
                "=== CASE INFORMATION ===\n"
        );

        prompt.append(
                "Case Number: "
        ).append(
                case_number
        ).append(
                "\n"
        );

        prompt.append(
                "Job Number: "
        ).append(
                job_number
        ).append(
                "\n"
        );

        prompt.append(
                "Business Process: "
        ).append(
                business_process_sub_name
        ).append(
                "\n\n"
        );

		  prompt.append(
                "Application Details: "
        ).append(
                applicationdetails
        ).append(
                "\n\n"
        );


        /*
         * USER QUESTION
         */
        prompt.append(
                "=== USER QUESTION ===\n"
        );
System.out.println(
				"User Question: "
				+ user_question
		);
        prompt.append(
                user_question
        );

        prompt.append(
                "\n\n"
        );


        /*
         * AI INSTRUCTIONS
         */
        prompt.append(
                "=== INSTRUCTIONS ===\n"
        );

        prompt.append(
                "Answer the user's question clearly and accurately.\n"
        );

        prompt.append(
                "Use the case information when it is relevant.\n"
        );

        prompt.append(
                "Do not invent information that is not available.\n"
        );

        prompt.append(
                "If the available information is insufficient, "
                + "clearly state that.\n"
        );


    } catch (Exception e) {

        System.out.println(
                "Prompt Preparation Error: "
                + e.getMessage()
        );

        e.printStackTrace();
    }


    return prompt.toString();
}



}
