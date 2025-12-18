package com.mit.elis.class_common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class cls_sms {

	// public String Helliosms() {
	// try {
	// // Construct data
	// String url = "http://txtconnect.co/api/send/";
	// String token = "token=" + "619f72f9599e9f4a5fdbf73d4a16067d65e770a2";
	// String from = "&from=" + "Landscom";
	// String to = "&to=" + "233242012137";
	// String msg = "&msg=" + " This is your message Eddy's Pizza";

	// // Send data
	// HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
	// String data = token + from + to + msg;
	// conn.setDoOutput(true);
	// conn.setRequestMethod("POST");
	// conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
	// conn.getOutputStream().write(data.getBytes("UTF-8"));
	// final BufferedReader rd = new BufferedReader(new
	// InputStreamReader(conn.getInputStream()));
	// final StringBuffer stringBuffer = new StringBuffer();
	// String line;
	// while ((line = rd.readLine()) != null) {
	// stringBuffer.append(line);
	// }
	// rd.close();

	// return stringBuffer.toString();
	// } catch (Exception e) {
	// System.out.println("Error SMS " + e);
	// return "Error " + e;
	// }
	// }

	// public String send_register_message(String case_number, String msg1, String
	// reciplent) {
	// try {
	// // Construct data
	// String url = "https://www.txtconnect.co/v2/app/api/send/sms.json";
	// String token = "token=" + "619f72f9599e9f4a5fdbf73d4a16067d65e770a2";
	// String from = "&sender=" + "Landscom";
	// String to = "&recipients=" + reciplent;
	// String msg = "&message=" + msg1;

	// // Send data
	// HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
	// String data = token + from + to + msg;
	// // System.out.println(data);
	// conn.setDoOutput(true);
	// conn.setRequestMethod("POST");
	// conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
	// conn.getOutputStream().write(data.getBytes("UTF-8"));
	// final BufferedReader rd = new BufferedReader(new
	// InputStreamReader(conn.getInputStream()));
	// final StringBuffer stringBuffer = new StringBuffer();
	// String line;
	// while ((line = rd.readLine()) != null) {
	// stringBuffer.append(line);
	// }
	// rd.close();

	// return stringBuffer.toString();
	// } catch (Exception e) {
	// System.out.println("Error SMS " + e);
	// return "Error " + e;
	// }
	// }

}
