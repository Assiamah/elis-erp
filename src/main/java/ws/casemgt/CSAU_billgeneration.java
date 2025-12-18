package ws.casemgt;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.mit.elis.class_common.AmountInWords;
import com.mit.elis.class_common.Ws_url_config;
/*import com.case_management.cls_general_query;
import com.case_management.cls_generate_system_numbers;
import com.class_connection.databaseconn;*/
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Image;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.Barcode128;
import com.itextpdf.text.pdf.BarcodeQRCode;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class CSAU_billgeneration {
	/*
	 * cls_generate_system_numbers generate_csau_numbers = new
	 * cls_generate_system_numbers(); cls_general_query general_query = new
	 * cls_general_query(); databaseconn dbcon = new databaseconn();
	 */

	public String web_compname;
	public String web_comp_address;
	public String web_city;
	public String web_fax_number;
	public String web_telephone;
	public String web_email;
	public String web_branch_of_csau;
	public String web_rlo;
	public String web_regional_accountant;
	public String web_head_of_csau;
	public String web_chairman_regional_land_commission;
	public String web_office_region;

	private static Font TIME_ROMAN = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
	private static Font TIME_ROMAN_SMALL = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
	Ws_url_config ws_url_config = new Ws_url_config();

	// String pdf_dest = ws_url_config.get_softfile_location();
	// String software_file_location,

	// public byte[] IMG = cls_url_config.getSoftfile_location() + "NewLogo.jpg";
	// static final

	Font font = new Font(FontFamily.TIMES_ROMAN);
	Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
	Font font12pt = new Font(FontFamily.TIMES_ROMAN, 12);
	Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

	/**
	 * @param args
	 */
	public static Document createPDF(String file) {

		Document document = null;

		try {
			document = new Document();
			PdfWriter.getInstance(document, new FileOutputStream(file));
			document.open();

			addMetaData(document);

			addTitlePage(document);

			createTable(document);

			document.close();

		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return document;

	}

	private static void addMetaData(Document document) {
		document.addTitle("Generate PDF report");
		document.addSubject("Generate PDF report");
		document.addAuthor("Java Honk");
		document.addCreator("Java Honk");
	}

	private static void addTitlePage(Document document) throws DocumentException {

		Paragraph preface = new Paragraph();
		creteEmptyLine(preface, 1);
		preface.add(new Paragraph("PDF Report", TIME_ROMAN));

		creteEmptyLine(preface, 1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
		preface.add(new Paragraph("Report created on " + simpleDateFormat.format(new Date()), TIME_ROMAN_SMALL));
		document.add(preface);

	}

	private static void creteEmptyLine(Paragraph paragraph, int number) {
		for (int i = 0; i < number; i++) {
			paragraph.add(new Paragraph(" "));
		}
	}

	private static void createTable(Document document) throws DocumentException {
		Paragraph paragraph = new Paragraph();
		creteEmptyLine(paragraph, 2);
		document.add(paragraph);
		PdfPTable table = new PdfPTable(3);

		PdfPCell c1 = new PdfPCell(new Phrase("First Name"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

		c1 = new PdfPCell(new Phrase("Last Name"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);

		c1 = new PdfPCell(new Phrase("Test"));
		c1.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(c1);
		table.setHeaderRows(1);

		for (int i = 0; i < 5; i++) {
			table.setWidthPercentage(100);
			table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
			table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell("Java");
			table.addCell("Honk");
			table.addCell("Success");
		}

		document.add(table);
	}

	public byte[] createregionalnumberbill(String filename) throws DocumentException, IOException {
ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {

			
			// OutputStream file = new FileOutputStream(new
			// File("D://timer_new_new.pdf"));
			// Document document = new Document();
			Document document = new Document(PageSize.A5, 50, 50, 50, 50);

			// Read more:
			// http://mrbool.com/how-to-create-and-export-pdf-files-in-java/27343#ixzz596YBPXaJ
			// Pdf writer = PdfWriter.getInstance(file, new
			// FileOutput("C:\\Test.pdf"));

			PdfWriter.getInstance(document, out);

			// PdfWriter.getInstance(doc, new FileOutputStream(filename));

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(3);

			PdfPCell cell = new PdfPCell(new Paragraph("Java4s.com"));

			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell("Name");
			table.addCell("Address");
			table.addCell("Country");
			table.addCell("Java4s");
			table.addCell("NC");
			table.addCell("United States");
			table.setSpacingBefore(30.0f); // Space Before table starts, like
											// margin-top in CSS
			table.setSpacingAfter(30.0f); // Space After table starts, like
											// margin-Bottom in CSS

			// Inserting List in PDF
			List list = new List(true, 30);
			list.add(new ListItem("Java4s"));
			list.add(new ListItem("Php4s"));
			list.add(new ListItem("Some Thing..."));

			// Text formating in PDF
			Chunk chunk = new Chunk("Welecome To Java4s Programming Blog...");
			chunk.setUnderline(+1f, -2f);// 1st co-ordinate is for line
											// width,2nd is space between
			Chunk chunk1 = new Chunk("Php4s.com");
			chunk1.setUnderline(+4f, -8f);
			chunk1.setBackground(new BaseColor(17, 46, 193));

			// Now Insert Every Thing Into PDF Document
			document.open();// PDF document opened........
			document.add(Chunk.NEWLINE); // Something like in HTML :-)
			document.add(new Paragraph("Dear Java4s.com"));
			document.add(new Paragraph("Document Generated On - "));
			document.add(table);
			document.add(list); // In the new page we are going to add list
			document.close();

			//out.close();

			System.out.println("Pdf created successfully..");

			/*
			 * response.setContentType("application/pdf");
			 * response.setHeader("Cache-Control", "no-cache");
			 * response.setHeader("Cache-Control", "max-age=0");
			 * response.setHeader("Content-disposition", "attachment; " +
			 * "filename=new.pdf");
			 */

		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return out.toByteArray();
	}

	// private static final String FILE_PATH = "C:\\tmp\\testry.pdf";

	/*
	 * public byte[] send_sms(){ String WebResponseString = "";
	 * 
	 * System.Net.ServicePointManager.Expect100Continue = false; String url =
	 * "http://txtconnect.co/api/send/"; System.Net.WebClient client = new
	 * System.Net.WebClient();
	 * System.Collections.Specialized.NameValueCollection postData = new
	 * System.Collections.Specialized.NameValueCollection();
	 * postData.Add("token", "619f72f9599e9f4a5fdbf73d4a16067d65e770a2");
	 * postData.Add("from", CRSSenderName); postData.Add("to", str_recipient);
	 * postData.Add("msg", str_Message); byte[] responseBytes =
	 * client.UploadValues(url, postData); string response =
	 * System.Text.Encoding.ASCII.GetString(responseBytes); //
	 * response.Write(response) //MessageBox.Show(response, "Send SMS",
	 * MessageBoxButtons.OK, MessageBoxIcon.Information);
	 * 
	 * }
	 * 
	 */

	 public String Helliosms() {
		try {
			// Construct data
			String url = "http://txtconnect.co/api/send/";
			String token = "token=" + "619f72f9599e9f4a5fdbf73d4a16067d65e770a2";
			String from = "&from=" + "Landscom";
			String to = "&to=" + "233242012137";
			String msg = "&msg=" + " This is your message Eddy's Pizza";

			// Send data
			HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
			String data = token + from + to + msg;
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Length", Integer.toString(data.length()));
			conn.getOutputStream().write(data.getBytes("UTF-8"));
			final BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			final StringBuffer stringBuffer = new StringBuffer();
			String line;
			while ((line = rd.readLine()) != null) {
				stringBuffer.append(line);
			}
			rd.close();

			return stringBuffer.toString();
		} catch (Exception e) {
			System.out.println("Error SMS " + e);
			return "Error " + e;
		}
	}

	public byte[] create_service_bill_online(String software_file_location, String bill_number, String output_file,
			String ws_bill_details_db)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_job_number = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_bill_date = "";
		String bd_bill_amount = "0";
		String bd_business_process_sub_id = "0";
		String bd_business_process_sub_name = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			String bill_details = (String) jsonobj.getString("data");

			JSONArray jArr = new JSONArray(bill_details);
			for (int i = 0; i < jArr.length(); i++) {
				JSONObject obj = new JSONObject(bill_details);

				bd_customer_name = (String) obj.getString("customer_name");
				bd_job_number = (String) obj.getString("job_number");
				bd_business_process_id = (String) obj.getString("business_process_id");
				bd_business_process_name = (String) obj.getString("business_process_name");
				bd_bill_date = (String) obj.getString("bill_date");
				bd_bill_amount = (String) obj.getString("bill_amount");
				bd_business_process_sub_id = (String) obj.getString("business_process_sub_id");
				bd_business_process_sub_name = (String) obj.getString("business_process_sub_name");

			}

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_2 = new Paragraph("SURVEY AND MAPPING DIVISION", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			Paragraph p_3 = new Paragraph("SERVICE BILL", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p5 = new Paragraph("Bill No: " + bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p5.setAlignment(Element.ALIGN_LEFT);
			document.add(p5);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p7 = new Paragraph("Client's No: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p7.setAlignment(Element.ALIGN_LEFT);
			document.add(p7);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Job Number: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Land Size: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(3);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 35, 160, 100 });

			PdfPCell cell = new PdfPCell(new Paragraph("Details of Fees"));

			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell("S/N");
			table.addCell("Description");
			table.addCell("Amount (GHS)");

			Integer NumberCount = 1;

			table.addCell(NumberCount.toString());
			table.addCell(bd_business_process_name);
			table.addCell(bd_bill_amount);

			table.addCell("");
			table.addCell("Total Amount");
			table.addCell(bd_bill_amount);

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			table.setSpacingAfter(5.0f); // Space After table starts, like
											// margin-Bottom in CSS

			document.add(table);

			Paragraph p12 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency(bd_bill_amount),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + "Assiamah John",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			codeQrImage_sign.scaleAbsolute(100, 100);
			// codeQrImage_sign.setAbsolutePosition(310,380);
			document.add(codeQrImage_sign);

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			Barcode128 code128 = new Barcode128();
			code128.setCode("123456789");
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 420);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(310, 380);
			document.add(codeQrImage);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_bill_online_new(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_licensed_surveyor_name = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";
		String bd_surveyors_client = "";
		String bd_locality = "";
		String page_title = "SERVICE BILL";
		String created_for = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("client_name");
			bd_licensed_surveyor_name = (String) jsonobj_bbd.getString("licensed_surveyor_name");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_land_size = (String) jsonobj_bbd.getString("land_size");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");
			created_for = (String) jsonobj_bbd.getString("created_for_id");
			// bd_surveyors_client = (String)
			// jsonobj_bbd.getString("surveyors_client");
			// bd_locality = (String) jsonobj_bbd.getString("locality");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			if (bd_business_process_sub_name.equals("STAMP DUTY PAYMENT")) {
				page_title = "GRA STAMP DUTY BILL";
			}
			Paragraph p_3 = new Paragraph(page_title, new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode((String)jsonobj.getString("unique"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("unique"), 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Bill Number: " + (String) jsonobj.getString("unique"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			// convert to acres amount entered in hectors
			double bd_size_acres = Double.parseDouble(bd_land_size) * 0.404685642;
			BigDecimal instance = new BigDecimal(Double.toString(bd_size_acres));
			instance = instance.setScale(2, RoundingMode.HALF_UP);

			if (bd_business_process_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_licensed_surveyor_name,
						new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);
				Paragraph p7 = new Paragraph("Surveyor's Client Name: " + (String) jsonobj_bbd.getString("surveyors_client"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p7.setAlignment(Element.ALIGN_LEFT);
				document.add(p7);
				Paragraph p12 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p12.setAlignment(Element.ALIGN_LEFT);
				document.add(p12);

				Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else if (bd_business_process_name.equals("APPLICATION FOR PLAN APPROVAL")) {

				Paragraph p6 = new Paragraph("Client Name: " + bd_licensed_surveyor_name,
						new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s) / " + instance + " Hectare(s)  ",
						new Font(FontFamily.TIMES_ROMAN, 10));
				p10.setAlignment(Element.ALIGN_LEFT);
				document.add(p10);

				Paragraph p11 = new Paragraph(
						"Surveyor's Client Name: " + (String) jsonobj_bbd.getString("client_name"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p11.setAlignment(Element.ALIGN_LEFT);
				document.add(p11);

				Paragraph p12 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p12.setAlignment(Element.ALIGN_LEFT);
				document.add(p12);

			
			} else if (bd_business_process_name.equals("APPLICATION FOR REGISTRATION")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
						new Font(FontFamily.TIMES_ROMAN, 10));
				p10.setAlignment(Element.ALIGN_LEFT);
				document.add(p10);
			} else if (bd_business_process_name.equals("APPLICATION FOR SEARCH")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
						new Font(FontFamily.TIMES_ROMAN, 10));
				p10.setAlignment(Element.ALIGN_LEFT);
				document.add(p10);
			} else if (bd_business_process_name.equals("APPLICATION FOR STAMPING")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else if (bd_business_process_sub_name.equals("STAMP DUTY PAYMENT")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Description: " + created_for, new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else if (bd_business_process_name.equals("PVLMD EXTRA SERVICES")
					|| bd_business_process_name.equals("LVD ADMINISTRATIVE CHARGES")
					|| bd_business_process_name.equals("SMD EXTRA SERVICES")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Description: " + (String) jsonobj_bbd.getString("manual_bill_desc"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			}

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * // Inserting Table in PDF PdfPTable table = new PdfPTable(4);
			 * table.setWidthPercentage(100); // Left aLign
			 * table.setTotalWidth((float) 300.0); ;
			 * table.setHorizontalAlignment(0); table.setSpacingAfter(10);
			 * table.setTotalWidth(new float[] { 35, 80, 80, 100 });
			 * 
			 * PdfPCell cell = new PdfPCell(new Phrase("Details of Fees",
			 * font12pt));
			 * 
			 * cell.setColspan(5);
			 * cell.setHorizontalAlignment(Element.ALIGN_CENTER); //
			 * cell.setPadding(10.0f); cell.setBackgroundColor(new
			 * BaseColor(140, 221, 8));
			 * 
			 * table.addCell(cell);
			 * 
			 * table.addCell("S/N"); table.addCell("Bill Item Number");
			 * table.addCell("Description"); table.addCell("Amount (GHS)");
			 */
			// table.addCell("Division");

			/*
			 * Integer NumberCount = 1;
			 * 
			 * String bill_details = (String) jsonobj.getString("bills");
			 * 
			 * JSONArray jArr = new JSONArray(bill_details); for (int i = 0; i <
			 * jArr.length(); i++) { // JSONObject obj = new
			 * JSONObject(bill_details);
			 * 
			 * JSONObject obj = jArr.getJSONObject(i);
			 * System.out.println(obj.toString());
			 * 
			 * ;
			 * 
			 * table.addCell(new PdfPCell(new Phrase(NumberCount.toString(),
			 * font10pt))); table.addCell(new PdfPCell(new Phrase((String)
			 * obj.getString("bill_number"), font10pt))); table.addCell(new
			 * PdfPCell(new Phrase((String) obj.getString("customer_id"),
			 * font10pt))); table.addCell(new PdfPCell(new Phrase((String)
			 * obj.getString("bill_amount"), font10pt))); // table.addCell(new
			 * PdfPCell(new Phrase((String) // obj.getString("division"),
			 * font10pt)));
			 * 
			 * NumberCount++; }
			 * 
			 * // table.addCell(new PdfPCell(new Phrase("1", font10pt))); //
			 * table.addCell(new PdfPCell(new //
			 * Phrase((String)jsonobj.getString("unique"),font10pt)));
			 * 
			 * table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase(" ", font10pt))); if
			 * (bd_business_process_name == "APPLICATION FOR REGIONAL NUMBER") {
			 * // table.addCell(new PdfPCell(new Phrase("Regional Number Fee",
			 * // font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR PLAN APPROVAL") {
			 * // table.addCell(new PdfPCell(new Phrase("Plan Approval Fee", //
			 * font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR REGISTRATION") { //
			 * table.addCell(new PdfPCell(new Phrase("Consolidated //
			 * Regsitration Fee", font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR PART TRANSFER") {
			 * // table.addCell(new PdfPCell(new Phrase("Consolidated Transfer
			 * // Fee", font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else { // table.addCell(new
			 * PdfPCell(new Phrase("Service Fee", // font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Total Amount",
			 * font10pt))); }
			 * 
			 * String sc = String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount"));
			 * 
			 * table.addCell(new PdfPCell(new Phrase(sc, font10pt))); //
			 * table.addCell("Consolidated Regsitration Fee");
			 * 
			 * // table.addCell((String) jsonobj.getString("total_amount")); //
			 * table.addCell("LC");
			 * 
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 * // margin-top in CSS // table.setSpacingAfter(5.0f); // Space
			 * After table starts, like // margin-Bottom in CSS
			 */

			/*
			 * double total_amount = ((Double)
			 * jsonobj.getDouble("service_charge") + (Double)
			 * jsonobj.getDouble("total_amount"));
			 * 
			 * table.addCell(new PdfPCell(new Phrase("1", font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase(bd_business_process_sub_name, font10pt))); String sc =
			 * String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount")); table.addCell(new
			 * PdfPCell(new Phrase(sc, font10pt)));
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 * 
			 * table.addCell(new PdfPCell(new Phrase("2", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Service Charge",
			 * font10pt))); String ssc = String.format("%.2f", (Double)
			 * jsonobj.getDouble("service_charge")); table.addCell(new
			 * PdfPCell(new Phrase(ssc, font10pt)));
			 * table.setSpacingBefore(5.0f);
			 * 
			 * table.addCell(new PdfPCell(new Phrase("3", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Total Amount",
			 * font10pt))); String ssc1 = String.format("%.2f", total_amount);
			 * table.addCell(new PdfPCell(new Phrase(ssc1, font10pt)));
			 * table.setSpacingBefore(5.0f);
			 * 
			 * document.add(table);
			 * 
			 * Paragraph p12 = new Paragraph( "Amount In Words: " +
			 * AmountInWords.convertToCurrency((String)
			 * jsonobj.getString("total_amount")), new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p12.setAlignment(Element.ALIGN_LEFT); document.add(p12);
			 */

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(4);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 25, 80, 80, 100 });

			PdfPCell cell = new PdfPCell(new Phrase("Details of Fees", font12pt));
			cell.setColspan(4);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));
			table.addCell(cell);
			// table.AddHeaderCell(new Cell(2, 1).Add(new Paragraph("Date")));
			// table.AddHeaderCell(new Cell(1,3).Add(new Paragraph("Amount")));

			// table.add

			// PdfPCell headerCell = new PdfPHeaderCell();

			// headerCell.setPhrase(new Paragraph("CAC COMPLAINT TICKETT", new
			// Font(FontFamily.TIMES_ROMAN, 10)));
			// headerCell.setColspan(4);
			// headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// headerCell.setPadding(10.0f);
			// headerCell.setBackgroundColor(new BaseColor(140, 221, 8));

			// table.addCell(headerCell);

			// table.addHeaderCell(cell);

			// PdfPCell c1 = new PdfPCell(new Phrase("Details of Fees"));
			// c1.setColspan(4);
			// table.addCell(c1);

			// table.addHeaderCell(new Cell(1, 5).add(new
			// Paragraph("2019")).setBackgroundColor(DeviceRgb.BLUE).setBold())
			// .setTextAlignment(TextAlignment.CENTER);

			table.addCell("S/N");
			table.addCell("Bill Item Number");
			table.addCell("Description");
			table.addCell("Amount (GHS)");
			// table.addCell("Division");

			Integer NumberCount = 1;

			String bill_details = (String) jsonobj.getString("bills");

			JSONArray jArr = new JSONArray(bill_details);
			for (int i = 0; i < jArr.length(); i++) { // JSONObject obj = new
				// JSONObject(bill_details);

				JSONObject obj = jArr.getJSONObject(i);
				System.out.println(obj.toString());

				table.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_number"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("customer_id"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_amount"), font10pt)));
				// table.addCell(new PdfPCell(new Phrase((String)
				// obj.getString("division"), font10pt)));

				NumberCount++;
			}

			double total_amount = ((Double) jsonobj.getDouble("SC") + (Double) jsonobj.getDouble("LCA"));

			/*
			 * table.addCell(new PdfPCell(new Phrase("1", font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase(bd_business_process_sub_name, font10pt))); String sc =
			 * String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount")); table.addCell(new
			 * PdfPCell(new Phrase(sc, font10pt)));
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 */
			table.addCell(new PdfPCell(new Phrase("2", font10pt)));
			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(new Phrase("Service Charge", font10pt)));
			String ssc = String.format("%.2f", (Double) jsonobj.getDouble("SC"));
			table.addCell(new PdfPCell(new Phrase(ssc, font10pt)));
			table.setSpacingBefore(5.0f);

			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(
					new Phrase("Total Amount (" + (String) jsonobj_bbd.getString("no_of_copy") + ")", font10pt)));
			String ssc1 = String.format("%.2f", total_amount);
			table.addCell(new PdfPCell(new Phrase(ssc1, font10pt)));
			table.setSpacingBefore(5.0f);

			document.add(table);

			Paragraph p12 = new Paragraph(
					"Amount In Words: " + AmountInWords.convertToCurrency(String.valueOf(total_amount)),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}


	public byte[] create_service_bill_for_regional_transitional(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_licensed_surveyor_name = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";
		String bd_surveyors_client = "";
		String bd_locality = "";
		String page_title = "REGIONAL TRANSITIONAL BILL";
		String created_for = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("client_name");
			bd_licensed_surveyor_name = (String) jsonobj_bbd.getString("licensed_surveyor_name");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_land_size = (String) jsonobj_bbd.getString("land_size");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");
			created_for = (String) jsonobj_bbd.getString("created_for_id");
			// bd_surveyors_client = (String)
			// jsonobj_bbd.getString("surveyors_client");
			// bd_locality = (String) jsonobj_bbd.getString("locality");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			if (bd_business_process_sub_name.equals("STAMP DUTY PAYMENT")) {
				page_title = "GRA STAMP DUTY BILL";
			}
			Paragraph p_3 = new Paragraph(page_title, new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode((String)jsonobj.getString("unique"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("unique"), 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Bill Number: " + (String) jsonobj.getString("unique"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			// convert to acres amount entered in hectors
			double bd_size_acres = Double.parseDouble(bd_land_size) * 0.404685642;
			BigDecimal instance = new BigDecimal(Double.toString(bd_size_acres));
			instance = instance.setScale(2, RoundingMode.HALF_UP);

			if (bd_business_process_name.equals("APPLICATION FOR REGIONAL NUMBER")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_licensed_surveyor_name,
						new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);
				// Paragraph p7 = new Paragraph("Surveyor's Client Name: " + (String) jsonobj_bbd.getString("surveyors_client"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p7.setAlignment(Element.ALIGN_LEFT);
				// document.add(p7);
				// Paragraph p12 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p12.setAlignment(Element.ALIGN_LEFT);
				// document.add(p12);

				// Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p13.setAlignment(Element.ALIGN_LEFT);
				// document.add(p13);
			} else if (bd_business_process_name.equals("APPLICATION FOR PLAN APPROVAL")) {

				Paragraph p6 = new Paragraph("Client Name: " + bd_licensed_surveyor_name,
						new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				// Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s) / " + instance + " Hectare(s)  ",
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p10.setAlignment(Element.ALIGN_LEFT);
				// document.add(p10);

				// Paragraph p11 = new Paragraph(
				// 		"Surveyor's Client Name: " + (String) jsonobj_bbd.getString("client_name"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p11.setAlignment(Element.ALIGN_LEFT);
				// document.add(p11);

				// Paragraph p12 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p12.setAlignment(Element.ALIGN_LEFT);
				// document.add(p12);
			} else if (bd_business_process_name.equals("APPLICATION FOR REGISTRATION")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				// Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p10.setAlignment(Element.ALIGN_LEFT);
				// document.add(p10);
			} else if (bd_business_process_name.equals("APPLICATION FOR SEARCH")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				// Paragraph p10 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p10.setAlignment(Element.ALIGN_LEFT);
				// document.add(p10);
			} else if (bd_business_process_name.equals("APPLICATION FOR STAMPING")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				// Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p13.setAlignment(Element.ALIGN_LEFT);
				// document.add(p13);
			} else if (bd_business_process_sub_name.equals("STAMP DUTY PAYMENT")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Description: " + created_for, new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else if (bd_business_process_name.equals("PVLMD EXTRA SERVICES")
					|| bd_business_process_name.equals("LVD ADMINISTRATIVE CHARGES")
					|| bd_business_process_name.equals("SMD EXTRA SERVICES")) {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				Paragraph p13 = new Paragraph("Description: " + (String) jsonobj_bbd.getString("manual_bill_desc"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else {
				Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
				p6.setAlignment(Element.ALIGN_LEFT);
				document.add(p6);

				// Paragraph p13 = new Paragraph("Quantity: " + (String) jsonobj_bbd.getString("no_of_copy"),
				// 		new Font(FontFamily.TIMES_ROMAN, 10));
				// p13.setAlignment(Element.ALIGN_LEFT);
				// document.add(p13);
			}

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * // Inserting Table in PDF PdfPTable table = new PdfPTable(4);
			 * table.setWidthPercentage(100); // Left aLign
			 * table.setTotalWidth((float) 300.0); ;
			 * table.setHorizontalAlignment(0); table.setSpacingAfter(10);
			 * table.setTotalWidth(new float[] { 35, 80, 80, 100 });
			 * 
			 * PdfPCell cell = new PdfPCell(new Phrase("Details of Fees",
			 * font12pt));
			 * 
			 * cell.setColspan(5);
			 * cell.setHorizontalAlignment(Element.ALIGN_CENTER); //
			 * cell.setPadding(10.0f); cell.setBackgroundColor(new
			 * BaseColor(140, 221, 8));
			 * 
			 * table.addCell(cell);
			 * 
			 * table.addCell("S/N"); table.addCell("Bill Item Number");
			 * table.addCell("Description"); table.addCell("Amount (GHS)");
			 */
			// table.addCell("Division");

			/*
			 * Integer NumberCount = 1;
			 * 
			 * String bill_details = (String) jsonobj.getString("bills");
			 * 
			 * JSONArray jArr = new JSONArray(bill_details); for (int i = 0; i <
			 * jArr.length(); i++) { // JSONObject obj = new
			 * JSONObject(bill_details);
			 * 
			 * JSONObject obj = jArr.getJSONObject(i);
			 * System.out.println(obj.toString());
			 * 
			 * ;
			 * 
			 * table.addCell(new PdfPCell(new Phrase(NumberCount.toString(),
			 * font10pt))); table.addCell(new PdfPCell(new Phrase((String)
			 * obj.getString("bill_number"), font10pt))); table.addCell(new
			 * PdfPCell(new Phrase((String) obj.getString("customer_id"),
			 * font10pt))); table.addCell(new PdfPCell(new Phrase((String)
			 * obj.getString("bill_amount"), font10pt))); // table.addCell(new
			 * PdfPCell(new Phrase((String) // obj.getString("division"),
			 * font10pt)));
			 * 
			 * NumberCount++; }
			 * 
			 * // table.addCell(new PdfPCell(new Phrase("1", font10pt))); //
			 * table.addCell(new PdfPCell(new //
			 * Phrase((String)jsonobj.getString("unique"),font10pt)));
			 * 
			 * table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase(" ", font10pt))); if
			 * (bd_business_process_name == "APPLICATION FOR REGIONAL NUMBER") {
			 * // table.addCell(new PdfPCell(new Phrase("Regional Number Fee",
			 * // font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR PLAN APPROVAL") {
			 * // table.addCell(new PdfPCell(new Phrase("Plan Approval Fee", //
			 * font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR REGISTRATION") { //
			 * table.addCell(new PdfPCell(new Phrase("Consolidated //
			 * Regsitration Fee", font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else if
			 * (bd_business_process_name == "APPLICATION FOR PART TRANSFER") {
			 * // table.addCell(new PdfPCell(new Phrase("Consolidated Transfer
			 * // Fee", font10pt))); table.addCell(new PdfPCell(new
			 * Phrase("Total Amount", font10pt))); } else { // table.addCell(new
			 * PdfPCell(new Phrase("Service Fee", // font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Total Amount",
			 * font10pt))); }
			 * 
			 * String sc = String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount"));
			 * 
			 * table.addCell(new PdfPCell(new Phrase(sc, font10pt))); //
			 * table.addCell("Consolidated Regsitration Fee");
			 * 
			 * // table.addCell((String) jsonobj.getString("total_amount")); //
			 * table.addCell("LC");
			 * 
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 * // margin-top in CSS // table.setSpacingAfter(5.0f); // Space
			 * After table starts, like // margin-Bottom in CSS
			 */

			/*
			 * double total_amount = ((Double)
			 * jsonobj.getDouble("service_charge") + (Double)
			 * jsonobj.getDouble("total_amount"));
			 * 
			 * table.addCell(new PdfPCell(new Phrase("1", font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase(bd_business_process_sub_name, font10pt))); String sc =
			 * String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount")); table.addCell(new
			 * PdfPCell(new Phrase(sc, font10pt)));
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 * 
			 * table.addCell(new PdfPCell(new Phrase("2", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Service Charge",
			 * font10pt))); String ssc = String.format("%.2f", (Double)
			 * jsonobj.getDouble("service_charge")); table.addCell(new
			 * PdfPCell(new Phrase(ssc, font10pt)));
			 * table.setSpacingBefore(5.0f);
			 * 
			 * table.addCell(new PdfPCell(new Phrase("3", font10pt)));
			 * table.addCell(new PdfPCell(new Phrase("Total Amount",
			 * font10pt))); String ssc1 = String.format("%.2f", total_amount);
			 * table.addCell(new PdfPCell(new Phrase(ssc1, font10pt)));
			 * table.setSpacingBefore(5.0f);
			 * 
			 * document.add(table);
			 * 
			 * Paragraph p12 = new Paragraph( "Amount In Words: " +
			 * AmountInWords.convertToCurrency((String)
			 * jsonobj.getString("total_amount")), new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p12.setAlignment(Element.ALIGN_LEFT); document.add(p12);
			 */

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(4);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 25, 80, 80, 100 });

			PdfPCell cell = new PdfPCell(new Phrase("Details of Fees", font12pt));
			cell.setColspan(4);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));
			table.addCell(cell);
			// table.AddHeaderCell(new Cell(2, 1).Add(new Paragraph("Date")));
			// table.AddHeaderCell(new Cell(1,3).Add(new Paragraph("Amount")));

			// table.add

			// PdfPCell headerCell = new PdfPHeaderCell();

			// headerCell.setPhrase(new Paragraph("CAC COMPLAINT TICKETT", new
			// Font(FontFamily.TIMES_ROMAN, 10)));
			// headerCell.setColspan(4);
			// headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// headerCell.setPadding(10.0f);
			// headerCell.setBackgroundColor(new BaseColor(140, 221, 8));

			// table.addCell(headerCell);

			// table.addHeaderCell(cell);

			// PdfPCell c1 = new PdfPCell(new Phrase("Details of Fees"));
			// c1.setColspan(4);
			// table.addCell(c1);

			// table.addHeaderCell(new Cell(1, 5).add(new
			// Paragraph("2019")).setBackgroundColor(DeviceRgb.BLUE).setBold())
			// .setTextAlignment(TextAlignment.CENTER);

			table.addCell("S/N");
			table.addCell("Bill Item Number");
			table.addCell("Description");
			table.addCell("Amount (GHS)");
			// table.addCell("Division");

			Integer NumberCount = 1;

			String bill_details = (String) jsonobj.getString("bills");

			JSONArray jArr = new JSONArray(bill_details);
			for (int i = 0; i < jArr.length(); i++) { // JSONObject obj = new
				// JSONObject(bill_details);

				JSONObject obj = jArr.getJSONObject(i);
				System.out.println(obj.toString());

				table.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_number"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("customer_id"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_amount"), font10pt)));
				// table.addCell(new PdfPCell(new Phrase((String)
				// obj.getString("division"), font10pt)));

				NumberCount++;
			}

			double total_amount = ((Double) jsonobj.getDouble("SC") + (Double) jsonobj.getDouble("LCA"));

			/*
			 * table.addCell(new PdfPCell(new Phrase("1", font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase(bd_business_process_sub_name, font10pt))); String sc =
			 * String.format("%.2f", (Double)
			 * jsonobj.getDouble("total_amount")); table.addCell(new
			 * PdfPCell(new Phrase(sc, font10pt)));
			 * table.setSpacingBefore(5.0f); // Space Before table starts, like
			 */
			table.addCell(new PdfPCell(new Phrase("2", font10pt)));
			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(new Phrase("Service Charge", font10pt)));
			String ssc = String.format("%.2f", (Double) jsonobj.getDouble("SC"));
			table.addCell(new PdfPCell(new Phrase(ssc, font10pt)));
			table.setSpacingBefore(5.0f);

			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
			table.addCell(new PdfPCell(
					new Phrase("Total Amount (" + (String) jsonobj_bbd.getString("no_of_copy") + ")", font10pt)));
			String ssc1 = String.format("%.2f", total_amount);
			table.addCell(new PdfPCell(new Phrase(ssc1, font10pt)));
			table.setSpacingBefore(5.0f);

			document.add(table);

			Paragraph p12 = new Paragraph(
					"Amount In Words: " + AmountInWords.convertToCurrency(String.valueOf(total_amount)),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_bill_stamp_duty(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_bill_number = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("client_name");
			bd_bill_number = (String) jsonobj_bbd.getString("bill_number");
			/*
			 * bd_business_process_id = (String)
			 * jsonobj_bbd.getString("business_process_id");
			 * bd_business_process_name = (String)
			 * jsonobj_bbd.getString("business_process_name");
			 * 
			 * bd_business_process_sub_id = (String)
			 * jsonobj_bbd.getString("business_process_sub_id");
			 * bd_business_process_sub_name = (String)
			 * jsonobj_bbd.getString("business_process_sub_name");
			 */

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("STAMP DUTY PAYMENT (GRA)", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode((String)jsonobj.getString("unique"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_bill_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p8 = new Paragraph("Service Type: " + "Stamp Duty Payment", new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Bill Number: " + bd_bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p10 = new Paragraph("Assessed Amount: " + (String) jsonobj_bbd.getString("assessed_amount"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Amount Paid: " + (String) jsonobj_bbd.getString("payment_amount"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p18 = new Paragraph(
					"GRA Receipt Number: " + (String) jsonobj_bbd.getString("payment_slip_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p18.setAlignment(Element.ALIGN_LEFT);
			document.add(p18);

			Paragraph p19 = new Paragraph("Payment Mode: " + (String) jsonobj_bbd.getString("payment_mode"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p19.setAlignment(Element.ALIGN_LEFT);
			document.add(p19);

			Paragraph p120 = new Paragraph("Remarks: " + (String) jsonobj_bbd.getString("payment_remarks"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p120.setAlignment(Element.ALIGN_LEFT);
			document.add(p120);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p12 = new Paragraph(
					"Amount In Words: "
							+ AmountInWords.convertToCurrency((String) jsonobj_bbd.getString("payment_amount")),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Ghana Revenue Authority", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public InputStream generate_egcr_get_pdf(String egcr_url, String egcr_apikey, String json_request) {
		// String output = "Data Not Received";
		InputStream bytes = null;

		try {
			Client client = Client.create();
			WebResource webResource = client.resource(egcr_url + json_request + "/receiptfile");
			// ClientResponse response =
			// webResource.accept("text/plain").header("api-key",ws_url_config.get_service_api_key()).post(ClientResponse.class,job_number);

			System.out.println("Requested egcr: " + json_request);
			ClientResponse response = webResource.accept("application/json").type("application/json")
					.header("X-Api-Key", egcr_apikey).get(ClientResponse.class);

			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			}
			bytes = response.getEntityInputStream();

			// byte[] bytes = query(statement);
		} catch (Exception e) {

			e.printStackTrace();

		}
		return bytes;
	}

	public byte[] capture_manual_bill_payment(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_bill_number = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("client_name");
			bd_bill_number = (String) jsonobj_bbd.getString("bill_number");
			/*
			 * bd_business_process_id = (String)
			 * jsonobj_bbd.getString("business_process_id");
			 * bd_business_process_name = (String)
			 * jsonobj_bbd.getString("business_process_name");
			 * 
			 * bd_business_process_sub_id = (String)
			 * jsonobj_bbd.getString("business_process_sub_id");
			 * bd_business_process_sub_name = (String)
			 * jsonobj_bbd.getString("business_process_sub_name");
			 */

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("BILL PAYMENT", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode((String)jsonobj.getString("unique"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_bill_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			/*
			 * Paragraph p8 = new Paragraph("Service Type: " + "Bill Payment",
			 * new Font(FontFamily.TIMES_ROMAN, 10));
			 * p8.setAlignment(Element.ALIGN_LEFT); document.add(p8);
			 */

			Paragraph p9 = new Paragraph("Bill Number: " + bd_bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p10 = new Paragraph("Bill Amount: " + (String) jsonobj_bbd.getString("assessed_amount"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Amount Paid: " + (String) jsonobj_bbd.getString("payment_amount"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p18 = new Paragraph("Receipt Number: " + (String) jsonobj_bbd.getString("payment_slip_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p18.setAlignment(Element.ALIGN_LEFT);
			document.add(p18);

			Paragraph p19 = new Paragraph("Payment Mode: " + (String) jsonobj_bbd.getString("payment_mode"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p19.setAlignment(Element.ALIGN_LEFT);
			document.add(p19);

			Paragraph p120 = new Paragraph("Remarks: " + (String) jsonobj_bbd.getString("payment_remarks"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p120.setAlignment(Element.ALIGN_LEFT);
			document.add(p120);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p12 = new Paragraph(
					"Amount In Words: "
							+ AmountInWords.convertToCurrency((String) jsonobj_bbd.getString("payment_amount")),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_acknowledgement_slip_online_new(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("ar_name");
			// bd_job_number= (String)jsonobj_bbd.getString("job_number");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_land_size = (String) jsonobj_bbd.getString("land_size");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");

			bd_type_of_interest = (String) jsonobj_bbd.getString("type_of_interest");
			bd_application_type = (String) jsonobj_bbd.getString("application_type");
			bd_locality_of_parcel = (String) jsonobj_bbd.getString("locality_of_parcel");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			/*
			 * BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String)
			 * jsonobj.getString("job_number"), 1000, 1000, null); Image
			 * codeQrImage = barcodeQRCode.getImage();
			 * codeQrImage.scaleAbsolute(100, 100);
			 * codeQrImage.setAbsolutePosition(310, 380);
			 * document.add(codeQrImage);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("job_number"), 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Case Number: " + (String) jsonobj.getString("case_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Job Number: " + (String) jsonobj.getString("job_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Locality of Parcel: " + bd_locality_of_parcel,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p12 = new Paragraph("Type of Interest: " + bd_type_of_interest,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			// convert to acres amount entered in hectors
			double bd_size_acres = Double.parseDouble(bd_land_size) * 0.404686;
			System.out.println("value in hect is : " + bd_size_acres);
			BigDecimal instance = new BigDecimal(Double.toString(bd_size_acres));
			instance = instance.setScale(2, RoundingMode.HALF_UP);

			Paragraph p13 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p13.setAlignment(Element.ALIGN_LEFT);
			document.add(p13);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_acknowledgement_slip_re_submission(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";

		String bd_case_number = "";
		String bd_publication_type = "";
		String bd_job_number = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("client_name");
			// bd_job_number= (String)jsonobj_bbd.getString("job_number");
			// bd_business_process_id = (String)
			// jsonobj_bbd.getString("business_process_id");
			// bd_business_process_name = (String)
			// jsonobj_bbd.getString("business_process_name");
			// bd_land_size = (String) jsonobj_bbd.getString("land_size");
			// bd_business_process_sub_id = (String)
			// jsonobj_bbd.getString("business_process_sub_id");
			// bd_business_process_sub_name = (String)
			// jsonobj_bbd.getString("business_process_sub_name");

			// bd_type_of_interest = (String) jsonobj_bbd.getString("type_of_interest");
			// bd_application_type = (String) jsonobj_bbd.getString("application_type");
			// bd_locality_of_parcel = (String) jsonobj_bbd.getString("locality_of_parcel");
			bd_case_number = (String) jsonobj_bbd.getString("case_number");
			bd_publication_type = (String) jsonobj_bbd.getString("publication_type");
			bd_job_number = (String) jsonobj_bbd.getString("case_number");

			// JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("RE-SUBMISSION of HARD COPY (ACKNOWLEDGEMENT SLIP)",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			// Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
			// new Font(FontFamily.TIMES_ROMAN, 10));
			// p8.setAlignment(Element.ALIGN_LEFT);
			// document.add(p8);

			Paragraph p9 = new Paragraph("Case Number: " + bd_case_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Job Number: " + bd_job_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Reason: " + bd_publication_type,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			// Paragraph p11 = new Paragraph("Locality of Parcel: " + bd_locality_of_parcel,
			// new Font(FontFamily.TIMES_ROMAN, 10));
			// p11.setAlignment(Element.ALIGN_LEFT);
			// document.add(p11);

			// Paragraph p12 = new Paragraph("Type of Interest: " + bd_type_of_interest,
			// new Font(FontFamily.TIMES_ROMAN, 10));
			// p12.setAlignment(Element.ALIGN_LEFT);
			// document.add(p12);

			// convert to acres amount entered in hectors
			// double bd_size_acres = Double.parseDouble(bd_land_size) * 0.404686;
			// System.out.println("value in hect is : " + bd_size_acres);
			// BigDecimal instance = new BigDecimal(Double.toString(bd_size_acres));
			// instance = instance.setScale(2, RoundingMode.HALF_UP);

			// Paragraph p13 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
			// new Font(FontFamily.TIMES_ROMAN, 10));
			// p13.setAlignment(Element.ALIGN_LEFT);
			// document.add(p13);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_acknowledgement_slip_online_new_on_case(String software_file_location,
			String basic_bill_details, String ws_bill_details_db,
			String ws_login_user) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";
		// String bd_licensed_surveyor_name = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("ar_name");
			// bd_job_number= (String)jsonobj_bbd.getString("job_number");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_land_size = (String) jsonobj_bbd.getString("land_size");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");
			bd_locality_of_parcel = (String) jsonobj_bbd.getString("locality_of_parcel");

			// bd_licensed_surveyor_name = (String)
			// jsonobj_bbd.getString("licensed_surveyor_name");

			// bd_type_of_interest=
			// (String)jsonobj_bbd.getString("type_of_interest");
			// bd_application_type=
			// (String)jsonobj_bbd.getString("application_type");
			// bd_locality_of_parcel=
			// (String)jsonobj_bbd.getString("locality_of_parcel");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("job_number"), 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Case Number: " + (String) jsonobj.getString("case_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Job Number: " + (String) jsonobj.getString("job_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			System.out.println(bd_business_process_name);
			if (bd_business_process_name.equals("APPLICATION FOR REGIONAL NUMBER")) {

				// bd_locality_of_parcel = (String)
				// jsonobj_bbd.getString("locality_of_parcel");

				Paragraph p10s = new Paragraph(
						"Surveyor's Name: " + (String) jsonobj_bbd.getString("licensed_surveyor_name"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p10s.setAlignment(Element.ALIGN_LEFT);
				document.add(p10s);

				Paragraph p11 = new Paragraph("Regional Number: " + (String) jsonobj.getString("regional_number"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p11.setAlignment(Element.ALIGN_LEFT);
				document.add(p11);

				Paragraph p13 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality_of_parcel"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);

			} else if (bd_business_process_name.equals("APPLICATION FOR PLAN APPROVAL")) {
				Paragraph p11 = new Paragraph(
						"Surveyor's Name: " + (String) jsonobj_bbd.getString("licensed_surveyor_name"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p11.setAlignment(Element.ALIGN_LEFT);
				document.add(p11);

				Paragraph p13 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);

				Paragraph p19 = new Paragraph("Locality: " + (String) jsonobj_bbd.getString("locality_of_parcel"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p19);

					Paragraph p14 = new Paragraph("Regional Number: " + (String) jsonobj_bbd.getString("regional_number"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p14.setAlignment(Element.ALIGN_LEFT);
				document.add(p14);	

				Paragraph p16 = new Paragraph("District: " + (String) jsonobj_bbd.getString("district"),
						new Font(FontFamily.TIMES_ROMAN, 10));
			    p16.setAlignment(Element.ALIGN_LEFT);
			    document.add(p16);

				Paragraph p15 = new Paragraph("Region: " + (String) jsonobj_bbd.getString("region"),
						new Font(FontFamily.TIMES_ROMAN, 10));
				p15.setAlignment(Element.ALIGN_LEFT);
				document.add(p15);
				

			} else if (bd_business_process_name.equals("APPLICATION FOR REGISTRATION")) {
				Paragraph p13 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
						new Font(FontFamily.TIMES_ROMAN, 10));
				p13.setAlignment(Element.ALIGN_LEFT);
				document.add(p13);
			} else if (bd_business_process_name.equals("APPLICATION FOR PART TRANSFER")) {

			} else {

			}

			// Paragraph p11 = new Paragraph("Locality of Parcel: " +
			// bd_locality_of_parcel, new Font(FontFamily.TIMES_ROMAN, 10));
			// p11.setAlignment(Element.ALIGN_LEFT);
			// document.add(p11);

			// Paragraph p12 = new Paragraph("Type of Interest: " +
			// bd_type_of_interest, new Font(FontFamily.TIMES_ROMAN, 10));
			// p12.setAlignment(Element.ALIGN_LEFT);
			// document.add(p12);

			// Paragraph p13 = new Paragraph("Land Size: " + bd_land_size, new
			// Font(FontFamily.TIMES_ROMAN, 10));
			// p13.setAlignment(Element.ALIGN_LEFT);
			// document.add(p13);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_stamp_duty_bill(String software_file_location, String basic_bill_details, String ws_login_user,
			String output_file)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";

		String bd_job_number = "";
		String bd_case_number = "";
		String bd_stamp_duty_amount = "";
		String bd_assessed_value_amount = "";
		String bd_assessed_comment = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("ar_name");
			bd_job_number = (String) jsonobj_bbd.getString("job_number");
			bd_case_number = (String) jsonobj_bbd.getString("case_number");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_stamp_duty_amount = (String) jsonobj_bbd.getString("stamp_duty_amount");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");
			bd_assessed_comment = (String) jsonobj_bbd.getString("assessed_comment");

			bd_assessed_value_amount = (String) jsonobj_bbd.getString("assessed_value_amount");

			// bd_type_of_interest=
			// (String)jsonobj_bbd.getString("type_of_interest");
			// bd_application_type=
			// (String)jsonobj_bbd.getString("application_type");
			// bd_locality_of_parcel=
			// (String)jsonobj_bbd.getString("locality_of_parcel");

			// JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("Stamp Duty Bill", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			// (String) jsonobj.getString("regional_number")

			Paragraph p9 = new Paragraph("Case Number: " + bd_case_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Job Number: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p1 = new Paragraph("Stamp Duty Amount: " + bd_stamp_duty_amount,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p1.setAlignment(Element.ALIGN_LEFT);
			document.add(p1);

			p1 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency(bd_stamp_duty_amount),
					new Font(FontFamily.TIMES_ROMAN, 10));
			document.add(p1);

			Paragraph p2 = new Paragraph("Assessed Value: " + bd_assessed_value_amount,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p2.setAlignment(Element.ALIGN_LEFT);
			document.add(p2);

			Paragraph p3 = new Paragraph("Comments: " + bd_assessed_comment, new Font(FontFamily.TIMES_ROMAN, 10));
			p3.setAlignment(Element.ALIGN_LEFT);
			document.add(p3);

			/*
			 * p3 = new Paragraph("Assessor's Name: " + ws_login_user, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p3.setAlignment(Element.ALIGN_LEFT); document.add(p3);
			 */

			// System.out.println(bd_business_process_name);

			// Paragraph p11 = new Paragraph("Locality of Parcel: " +
			// bd_locality_of_parcel, new Font(FontFamily.TIMES_ROMAN, 10));
			// p11.setAlignment(Element.ALIGN_LEFT);
			// document.add(p11);

			// Paragraph p12 = new Paragraph("Type of Interest: " +
			// bd_type_of_interest, new Font(FontFamily.TIMES_ROMAN, 10));
			// p12.setAlignment(Element.ALIGN_LEFT);
			// document.add(p12);

			// Paragraph p13 = new Paragraph("Land Size: " + bd_land_size, new
			// Font(FontFamily.TIMES_ROMAN, 10));
			// p13.setAlignment(Element.ALIGN_LEFT);
			// document.add(p13);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Assessor's Name: " + ws_login_user, new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

public byte[] create_lc_rent_demand_notice(String softwareFileLocation, String basicBillDetails,
        String wsLoginUser, String outputFile)
        throws IOException, SQLException, JSONException {
    Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 14f, Font.BOLD);
    Font subtitleFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.BOLDITALIC);
    Font bodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL);
    Font boldBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.BOLD);
    Font italicBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.ITALIC); // Added for italic text
    Font boldItalicBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.BOLDITALIC); // Added for bold-italic text
    Font tableHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.BOLD);
    Font tableCellFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL);
    Font boldTableCellFont = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.BOLD);
    Font footerFont = new Font(Font.FontFamily.TIMES_ROMAN, 9f, Font.ITALIC);

    String bdCustomerName = "";
    String bdBusinessProcessId = "";
    String bdBusinessProcessName = "";
    String bdLandSize = "";
    String bdBusinessProcessSubId = "";
    String bdBusinessProcessSubName = "";
    String bdTypeOfInterest = "";
    String bdApplicationType = "";
    String bdLocalityOfParcel = "";
    String bdJobNumber = "";
    String bdCaseNumber = "";
    String bdStampDutyAmount = "";
    String bdRentPassingPerApp = "";

    ByteArrayOutputStream out = new ByteArrayOutputStream();
    try {
        JSONObject jsonObjBbd = new JSONObject(basicBillDetails);
        bdJobNumber = jsonObjBbd.getString("job_number");
        bdCaseNumber = jsonObjBbd.getString("case_number");
        bdRentPassingPerApp = jsonObjBbd.getString("rent_passing_per_app");
        // Assuming bdCustomerName is available in JSON; update if needed
        // bdCustomerName = jsonObjBbd.getString("customer_name"); // Uncomment and adjust key if available

        Document document = new Document(PageSize.A5, 36, 36, 50, 50);
        PdfWriter writer = PdfWriter.getInstance(document, out);
        document.open();
        PdfContentByte cb = writer.getDirectContent();

        // Add logo
        Image image = Image.getInstance(softwareFileLocation + "NewLogo.jpg");
        image.scaleToFit(100.0F, 80.0F);
        image.setAbsolutePosition(40, 500);
        document.add(image);

        // Add address block
        BaseFont bfAddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        PdfContentByte cbAddress = writer.getDirectContent();
        cbAddress.beginText();
        cbAddress.setFontAndSize(bfAddress, 8);
        cbAddress.setTextMatrix(300, 570);
        cbAddress.showText(web_comp_address);
        cbAddress.setTextMatrix(300, 560);
        cbAddress.showText(web_city);
        cbAddress.setTextMatrix(300, 550);
        cbAddress.showText("Tel: " + web_telephone);
        cbAddress.setTextMatrix(300, 540);
        cbAddress.showText("Fax: " + web_fax_number);
        cbAddress.setTextMatrix(300, 530);
        cbAddress.showText("Email: " + web_email);
        cbAddress.setTextMatrix(300, 520);
        cbAddress.showText("Web: www.lc.gov.gh");
        cbAddress.endText();

        // Horizontal line separator
        PdfContentByte canvas = writer.getDirectContent();
        canvas.setLineWidth(1f);
        canvas.setGrayStroke(0.5f);
        canvas.moveTo(36, 490);
        canvas.lineTo(560, 490);
        canvas.stroke();

        document.add(new Paragraph(" ", bodyFont));

        // Title
        Paragraph p1 = new Paragraph("LANDS COMMISSION", titleFont);
        p1.setAlignment(Element.ALIGN_CENTER);
        p1.setSpacingAfter(10f);
        document.add(p1);

        // Subtitle
        Paragraph p3 = new Paragraph("RENT TThjS DEMAND NOTICE", subtitleFont);
        p3.setAlignment(Element.ALIGN_CENTER);
        p3.setSpacingAfter(20f);
        document.add(p3);

        // QR Code
        BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bdJobNumber, 80, 80, null);
        Image codeQrImage = barcodeQRCode.getImage();
        codeQrImage.scaleAbsolute(80, 80);
        codeQrImage.setAbsolutePosition(450, 500);
        document.add(codeQrImage);

        // Date
        Date now = new Date();
        Paragraph p4 = new Paragraph("Date: " + new SimpleDateFormat("MMMM dd, yyyy").format(now), bodyFont);
        p4.setAlignment(Element.ALIGN_RIGHT);
        p4.setSpacingAfter(15f);
        document.add(p4);

        // Introduction paragraph with bold customer name and italicized notice
        Paragraph p5 = new Paragraph();
        p5.add(new Chunk("Dear ", bodyFont));
        p5.add(new Chunk(bdCustomerName, boldBodyFont));
        p5.add(new Chunk(",\n\n", bodyFont));
        p5.add(new Chunk("TAKE NOTICE", boldItalicBodyFont));
        p5.add(new Chunk(" that ground rent on the under mentioned premises which has been leased to you by the Lands Commission is ", bodyFont));
        p5.add(new Chunk("due for Payment", boldItalicBodyFont));
        p5.add(new Chunk(".", bodyFont));
        p5.setAlignment(Element.ALIGN_JUSTIFIED);
        p5.setSpacingAfter(10f);
        document.add(p5);

        // Details intro
        Paragraph p6 = new Paragraph("The details are provided below:", bodyFont);
        p6.setAlignment(Element.ALIGN_LEFT);
        p6.setSpacingAfter(15f);
        document.add(p6);

        // Additional details with bold job number and case number
        Paragraph pDetails = new Paragraph();
        pDetails.add(new Chunk("Job Number: ", bodyFont));
        pDetails.add(new Chunk(bdJobNumber, boldBodyFont));
        pDetails.add(new Chunk("   Case Number: ", bodyFont));
        pDetails.add(new Chunk(bdCaseNumber, boldBodyFont));
        pDetails.setAlignment(Element.ALIGN_LEFT);
        pDetails.setSpacingAfter(10f);
        document.add(pDetails);

        // Table for rent assessment
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(20f);
        table.setWidths(new float[] { 40, 20, 20, 20 });

        // Table header
        PdfPCell headerCell = new PdfPCell(new Phrase("RENT ASSESSMENT", tableHeaderFont));
        headerCell.setColspan(4);
        headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        headerCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        headerCell.setPadding(8f);
        headerCell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(headerCell);

        // Column headers
        addTableHeaderCell(table, "Rent Period", tableHeaderFont);
        addTableHeaderCell(table, "Rate", tableHeaderFont);
        addTableHeaderCell(table, "Interest Rate", tableHeaderFont);
        addTableHeaderCell(table, "Amount (GHS)", tableHeaderFont);

        // Data rows with bold rent period and amount
        addTableCell(table, jsonObjBbd.getString("rent_period_for_demand_note"), boldTableCellFont);
        addTableCell(table, bdRentPassingPerApp, tableCellFont);
        addTableCell(table, "N/A", tableCellFont);
        addTableCell(table, bdRentPassingPerApp, boldTableCellFont);

        document.add(table);

        // Demand paragraph with bold and italicized key phrases
        Paragraph p7 = new Paragraph();
        p7.add(new Chunk("Payment of the amount due", boldBodyFont));
        p7.add(new Chunk(" is hereby ", bodyFont));
        p7.add(new Chunk("demanded", boldItalicBodyFont));
        p7.add(new Chunk(". Rent that goes into arrears attracts a ", bodyFont));
        p7.add(new Chunk("compound interest", italicBodyFont));
        p7.add(new Chunk(". Failure to settle the amount may compel the Commission to institute ", bodyFont));
        p7.add(new Chunk("legal action", boldItalicBodyFont));
        p7.add(new Chunk(" to recover the said amount or take steps to ", bodyFont));
        p7.add(new Chunk("re-enter and cancel the lease", boldItalicBodyFont));
        p7.add(new Chunk(".", bodyFont));
        p7.setAlignment(Element.ALIGN_JUSTIFIED);
        p7.setSpacingAfter(15f);
        document.add(p7);

        // Notification paragraph with italicized address change
        Paragraph p8 = new Paragraph();
        p8.add(new Chunk("You are also required to notify the Commission with details of any changes in your ", bodyFont));
        p8.add(new Chunk("address (Postal or E-mail)", italicBodyFont));
        p8.add(new Chunk(".", bodyFont));
        p8.setAlignment(Element.ALIGN_JUSTIFIED);
        p8.setSpacingAfter(15f);
        document.add(p8);

        // Payment instructions with bold and italicized key phrases
        Paragraph p9 = new Paragraph();
        p9.add(new Chunk("ALL MONIES", boldBodyFont));
        p9.add(new Chunk(" SHOULD BE PAID EITHER IN ", bodyFont));
        p9.add(new Chunk("CASH OR BANKER'S DRAFT", boldItalicBodyFont));
        p9.add(new Chunk(".", bodyFont));
        p9.setAlignment(Element.ALIGN_LEFT);
        p9.setSpacingAfter(10f);
        document.add(p9);

        // Contact instructions
        Paragraph p10 = new Paragraph("Please contact the number below for any clarification:", bodyFont);
        p10.setAlignment(Element.ALIGN_LEFT);
        p10.setSpacingAfter(5f);
        document.add(p10);

        // Hotline with bold and italicized number
        Paragraph p11 = new Paragraph();
        p11.add(new Chunk("Hotlines: ", bodyFont));
        p11.add(new Chunk("0506430172", boldItalicBodyFont));
        p11.setAlignment(Element.ALIGN_LEFT);
        p11.setSpacingAfter(20f);
        document.add(p11);

        // Signature
        Paragraph p15 = new Paragraph("For: Regional Lands Officer", bodyFont);
        p15.setAlignment(Element.ALIGN_LEFT);
        p15.setSpacingAfter(10f);
        document.add(p15);

        // Footer note with italicized text
        Paragraph p16 = new Paragraph();
        p16.add(new Chunk("Please ignore this notice if you are not the legitimate lessee of the plot and/or if you have already settled your ground rent.", footerFont));
        p16.setAlignment(Element.ALIGN_LEFT);
        document.add(p16);

        document.close();
        return out.toByteArray();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return out.toByteArray();
}

// Helper methods for table cells
private void addTableHeaderCell(PdfPTable table, String text, Font font) {
    PdfPCell cell = new PdfPCell(new Phrase(text, font));
    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
    cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
    cell.setPadding(6f);
    cell.setBackgroundColor(new BaseColor(220, 220, 220));
    table.addCell(cell);
}

private void addTableCell(PdfPTable table, String text, Font font) {
    PdfPCell cell = new PdfPCell(new Phrase(text, font));
    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
    cell.setVerticalAlignment(Element.ALIGN_LEFT);
    cell.setPadding(6f);
    table.addCell(cell);
}

private void addTableCellborderless(PdfPTable table, String text, Font font) {
    PdfPCell cell = new PdfPCell(new Phrase(text, font));
	 cell.setBorder(Rectangle.NO_BORDER); // Make borderless
    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
    cell.setVerticalAlignment(Element.ALIGN_LEFT);
    cell.setPadding(6f);
    table.addCell(cell);
}




public byte[] create_lc_rent_demand_notice_for_rent_mgt_unit(String softwareFileLocation, String basicBillDetails, String estate_name,
        String wsLoginUser,  String wsLoginUser_id)
        throws IOException, SQLException, JSONException {
    Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 18f, Font.BOLD);
    Font subtitleFont = new Font(Font.FontFamily.TIMES_ROMAN, 14f, Font.BOLD);
    Font bodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.NORMAL);
    Font boldBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.BOLD);
    Font italicBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.ITALIC);
    Font boldItalicBodyFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.BOLDITALIC);
    Font tableHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.BOLD);
    Font tableCellFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.NORMAL);
    Font boldTableCellFont = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.BOLD);
	 Font boldTableCellFont10 = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.BOLD);
	  Font TableCellFont10 = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL);

    String bdCustomerName = "";
    String bdBusinessProcessId = "";
    String bdBusinessProcessName = "";
    String bdLandSize = "";
    String bdBusinessProcessSubId = "";
    String bdBusinessProcessSubName = "";
    String bdTypeOfInterest = "";
    String bdApplicationType = "";
    String bdLocalityOfParcel = "";
    String bdJobNumber = "";
    String bdCaseNumber = "";
    String bdStampDutyAmount = "";
    String bdRentPassingPerApp = "";
    String bdAccountNumber = "";
    String bdOwnersName = "";
    String bdAddress = "";
    String bdMobile = "";
    String bdMobile1 = "";
    String bdEmail = "";
    String bdFileNumber = "";
    String bdBlock = "";
    String bdPlotNumber = "";
    String bdPlotSize = "";
    String bdCovenantedUser = "";
    String rentPassing = "";
    String currentRentPeriodCovered = "";
    String currentRentAmount = "";
    String rentCurrentPeriodNewStart = "";
    String rentCurrentPeriodNewEnd = "";
    String rentArrearsNewPeriod = "";
    String arrearsAmount = "";
    String amountDue = "";

    ByteArrayOutputStream out = new ByteArrayOutputStream();
    try {
        JSONObject jsonObjBbd = new JSONObject(basicBillDetails);
        bdAccountNumber = jsonObjBbd.getString("account_number");
        bdOwnersName = jsonObjBbd.getString("owners_name");
        bdAddress = jsonObjBbd.getString("address");
        bdMobile = jsonObjBbd.getString("mobile");
        bdMobile1 = jsonObjBbd.getString("mobile_1");
        bdEmail = jsonObjBbd.getString("email");
        bdFileNumber = jsonObjBbd.getString("file_number");
        bdBlock = jsonObjBbd.getString("block");
        bdPlotNumber = jsonObjBbd.getString("plot_number");
        bdPlotSize = jsonObjBbd.getString("plot_size");
        bdCovenantedUser = jsonObjBbd.getString("covenanted_user");
        rentPassing = jsonObjBbd.getString("rent_passing");
        currentRentPeriodCovered = jsonObjBbd.getString("current_rent_period_covered");
        currentRentAmount = jsonObjBbd.getString("current_rent_amount");
        rentCurrentPeriodNewStart = jsonObjBbd.getString("rent_current_period_new_start");
        rentCurrentPeriodNewEnd = jsonObjBbd.getString("rent_current_period_new_end");
        rentArrearsNewPeriod = jsonObjBbd.getString("rent_arrears_new_period");
        arrearsAmount = jsonObjBbd.getString("arears_amount");
        amountDue = jsonObjBbd.getString("amount_due");

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        PdfWriter writer = PdfWriter.getInstance(document, out);
        document.open();
        PdfContentByte cb = writer.getDirectContent();
  // Date
        Date now = new Date();

        // Add logo
        Image image = Image.getInstance(softwareFileLocation + "NewLogo.jpg");
        image.scaleToFit(120.0F, 100.0F);
        image.setAbsolutePosition(240, 720);
        document.add(image);

        // Add address block
        BaseFont bfAddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        PdfContentByte cbAddress = writer.getDirectContent();
        cbAddress.beginText();
        cbAddress.setFontAndSize(bfAddress, 10);
        cbAddress.setTextMatrix(450, 800);
        cbAddress.showText(web_comp_address);
        cbAddress.setTextMatrix(450, 790);
        cbAddress.showText(web_city);
        cbAddress.setTextMatrix(450, 780);
        cbAddress.showText("Tel: " + web_telephone);
        cbAddress.setTextMatrix(450, 770);
        cbAddress.showText("Fax: " + web_fax_number);
        cbAddress.setTextMatrix(450, 760);
        cbAddress.showText("Email: " + web_email);
        cbAddress.setTextMatrix(450, 750);
        cbAddress.showText("Web: www.lc.gov.gh");
      

		cbAddress.setTextMatrix(50, 720);
        cbAddress.showText("My Ref No: " + bdFileNumber);

        cbAddress.setTextMatrix(50, 710);
        cbAddress.showText("Your Ref No:");

		BaseFont boldFont = BaseFont.createFont(BaseFont.HELVETICA_BOLD, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);

// Regular text first
//cbAddress.setFontAndSize(regularFont, 12);
cbAddress.setTextMatrix(50, 700);
cbAddress.showText("Account No: ");

// Then bold text
cbAddress.setFontAndSize(boldFont, 10);
cbAddress.showText(bdAccountNumber);

 cbAddress.setFontAndSize(bfAddress, 10);
	    cbAddress.setTextMatrix(450, 700);
        cbAddress.showText( "Date: " + new SimpleDateFormat("MMMM dd, yyyy").format(now));
        cbAddress.endText();


        // Horizontal line separator
        PdfContentByte canvas = writer.getDirectContent();
        canvas.setLineWidth(1f);
        canvas.setGrayStroke(0.5f);
        canvas.moveTo(50, 689);
        canvas.lineTo(560, 689);
        canvas.stroke();

        // Add space
        document.add(new Phrase(Chunk.NEWLINE));
        document.add(new Phrase(Chunk.NEWLINE));
        document.add(new Phrase(Chunk.NEWLINE));
        document.add(new Phrase(Chunk.NEWLINE));
        document.add(new Phrase(Chunk.NEWLINE));

        // Title
        Paragraph reportTitleOriginal = new Paragraph("LANDS COMMISSION", titleFont);
        reportTitleOriginal.setAlignment(Element.ALIGN_CENTER);
        reportTitleOriginal.setSpacingAfter(10f);
        document.add(reportTitleOriginal);

      
        // Paragraph p4 = new Paragraph();
        // p4.add(new Chunk("Date: ", bodyFont));
        // p4.add(new Chunk(new SimpleDateFormat("MMMM dd, yyyy").format(now), italicBodyFont));
        // p4.setAlignment(Element.ALIGN_RIGHT);
        // p4.setSpacingAfter(15f);
        // document.add(p4);

        // Subtitle
        Paragraph p3 = new Paragraph("RENT DEMAND NOTICE", subtitleFont);
        p3.setAlignment(Element.ALIGN_CENTER);
       // p3.setSpacingAfter(20f);
        document.add(p3);

        // QR Code
        BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bdFileNumber, 1000, 1000, null);
        Image codeQrImage = barcodeQRCode.getImage();
        codeQrImage.scaleAbsolute(100, 100);
        codeQrImage.setAbsolutePosition(35, 720);
        document.add(codeQrImage);

       // document.add(new Phrase(Chunk.NEWLINE));

        // // Owner and address with bold and italic
        // Paragraph p11_2 = new Paragraph();
        // p11_2.add(new Chunk("TO: ", bodyFont));
        // p11_2.add(new Chunk(bdOwnersName, boldBodyFont));
        // p11_2.setAlignment(Element.ALIGN_LEFT);
        // p11_2.setSpacingAfter(0f);
        // document.add(p11_2);

        // Paragraph p11_3 = new Paragraph();
        // p11_3.add(new Chunk("ADDRESS: ", bodyFont));
        // p11_3.add(new Chunk(bdAddress, boldBodyFont));
        // p11_3.setAlignment(Element.ALIGN_LEFT);
        // p11_3.setSpacingAfter(0f);
        // document.add(p11_3);

        // // Plot and location details with bold and italic
        // Paragraph p11_1 = new Paragraph();
        // p11_1.add(new Chunk("PLOT NO/LOC: ", bodyFont));
        // p11_1.add(new Chunk(bdPlotNumber, boldBodyFont));
        // p11_1.add(new Chunk(" / ", bodyFont));
        // p11_1.add(new Chunk(bdLocalityOfParcel, boldBodyFont));
        // p11_1.setAlignment(Element.ALIGN_LEFT);
        // p11_1.setSpacingAfter(0f);
        // document.add(p11_1);

        // Paragraph p11_1_a = new Paragraph();
        // p11_1_a.add(new Chunk("BLK NO./STRT: ", bodyFont));
        // p11_1_a.add(new Chunk(bdAccountNumber + "/" + bdBlock, boldBodyFont));
        // p11_1_a.add(new Chunk(" / ", bodyFont));
        // p11_1_a.add(new Chunk(bdLocalityOfParcel, boldBodyFont));
        // p11_1_a.setAlignment(Element.ALIGN_LEFT);
        // p11_1_a.setSpacingAfter(5f);
        // document.add(p11_1_a);


		// Table for rent assessment
  // --- Property Details Section (No Table) ---

Paragraph toParagraph = new Paragraph();
toParagraph.add(new Chunk("TO: ", TableCellFont10));
toParagraph.add(new Chunk(bdOwnersName + "\n", boldTableCellFont10));
toParagraph.setAlignment(Element.ALIGN_LEFT);
toParagraph.setSpacingAfter(2f);
document.add(toParagraph);

Paragraph addressParagraph = new Paragraph();
addressParagraph.add(new Chunk("ADDRESS: ", TableCellFont10));
addressParagraph.add(new Chunk(bdAddress + "\n", boldTableCellFont10));
addressParagraph.setAlignment(Element.ALIGN_LEFT);
addressParagraph.setSpacingAfter(2f);
document.add(addressParagraph);



// Property Address and Account Number on the same line
Paragraph propertyAndAccount = new Paragraph();
propertyAndAccount.add(new Chunk("PLOT NO/LOC: ", TableCellFont10));
propertyAndAccount.add(new Chunk(bdPlotNumber + ", "+ estate_name + "  / " + bdLocalityOfParcel + "    ", boldTableCellFont10));

// propertyAndAccount.add(new Chunk("ACCOUNT NUMBER: ", TableCellFont10));
// propertyAndAccount.add(new Chunk(bdAccountNumber, boldTableCellFont10));

propertyAndAccount.setAlignment(Element.ALIGN_LEFT);
propertyAndAccount.setSpacingAfter(8f);
document.add(propertyAndAccount);


        // Demand notice with bold and italic
        double amountDueValue = Double.parseDouble(amountDue);
        DecimalFormat df = new DecimalFormat("#,###.00");
        String formattedAmountDue = df.format(amountDueValue);


		 double amountDueValue_1 = Double.parseDouble(amountDue);
        DecimalFormat df_1 = new DecimalFormat("####.00");
        String formattedAmountDue_1= df_1.format(amountDueValue_1);

			System.out.println("amountDue");
		System.out.println(amountDue);

			System.out.println("formattedAmountDue");
		System.out.println(formattedAmountDue);


        Paragraph p5 = new Paragraph();
        p5.add(new Chunk("TAKE NOTICE", boldItalicBodyFont));
        p5.add(new Chunk(" that ground-rent on the above-mentioned premises for the period ", bodyFont));
        p5.add(new Chunk(rentArrearsNewPeriod, boldBodyFont));
        p5.add(new Chunk(" amounting to ", bodyFont));

      // p5.add(new Chunk(AmountInWords.convertToCurrency(String.valueOf(amountDue)), boldBodyFont));
	     p5.add(new Chunk(AmountInWords.convertToCurrency(String.valueOf(formattedAmountDue_1)), boldBodyFont));
		//p5.add(new Chunk(formattedAmountDue, boldBodyFont));
        p5.add(new Chunk(" (GHC ", bodyFont));
        p5.add(new Chunk(formattedAmountDue +" )", boldBodyFont));
        p5.add(new Chunk(" has become ", bodyFont));
        p5.add(new Chunk("due and payable", boldItalicBodyFont));
        p5.add(new Chunk(" by you. ", bodyFont));
        p5.add(new Chunk("Payment is hereby demanded.", boldBodyFont));
        p5.setAlignment(Element.ALIGN_JUSTIFIED);
        p5.setSpacingAfter(5f);
        document.add(p5);

        // // Details intro
        // Paragraph p6 = new Paragraph("The details are provided below:", bodyFont);
        // p6.setAlignment(Element.ALIGN_LEFT);
        // p6.setSpacingAfter(15f);
        // document.add(p6);

        // Table for rent assessment
        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
       // table.setSpacingAfter(20f);
        table.setWidths(new float[] { 80,120, 50 });

        // Table headers
        addTableHeaderCell(table, " ", tableHeaderFont);
        addTableHeaderCell(table, "Period", tableHeaderFont);
		addTableHeaderCell(table, "Amount (GHS)", tableHeaderFont);


        // Current rent

        addTableCell(table, "Current Rent: ", boldTableCellFont);
		 addTableCell(table, currentRentPeriodCovered, boldTableCellFont);
      //  addTableCell(table, formattedCurrentRentAmount, boldTableCellFont);


 // Current rent
        double currentRentAmountValue = Double.parseDouble(currentRentAmount);
        String formattedCurrentRentAmount = df.format(currentRentAmountValue);
       // addTableCell(table, "Current Rent: " + currentRentPeriodCovered, boldTableCellFont);
        addTableCell(table, formattedCurrentRentAmount, boldTableCellFont);




        // Arrears
       
        addTableCell(table, "Arrears for the period: " , boldTableCellFont);
		 addTableCell(table,  rentArrearsNewPeriod, boldTableCellFont);
       

		 double arrearsAmountValue = Double.parseDouble(arrearsAmount);
        String formattedArrearsAmount = df.format(arrearsAmountValue);
       // addTableCell(table, "Arrears for the period: " + rentArrearsNewPeriod, boldTableCellFont);
        addTableCell(table, formattedArrearsAmount, boldTableCellFont);

        // Total
		  addTableCell(table, " ", boldTableCellFont);
        addTableCell(table, "Total", boldTableCellFont);
        addTableCell(table, formattedAmountDue, boldTableCellFont);

        document.add(table);

        // // Signature block
        // Paragraph p10 = new Paragraph("SGN: ", bodyFont);
        // p10.setAlignment(Element.ALIGN_LEFT);
        // p10.setSpacingAfter(0f);
        // document.add(p10);

        // Paragraph p10_a = new Paragraph("NAME: ", bodyFont);
        // p10_a.setAlignment(Element.ALIGN_LEFT);
        // p10_a.setSpacingAfter(0f);
        // document.add(p10_a);

        // Paragraph p10_b = new Paragraph("FOR: ", bodyFont);
        // p10_b.add(new Chunk("REGIONAL LANDS OFFICER", boldBodyFont));
        // p10_b.setAlignment(Element.ALIGN_LEFT);
        // p10_b.setSpacingAfter(0f);
        // document.add(p10_b);

        // Paragraph p10_c = new Paragraph();
        // p10_c.add(new Chunk("CONTACT: ", bodyFont));
        // p10_c.add(new Chunk("( " + web_telephone + " )", italicBodyFont));
        // p10_c.setAlignment(Element.ALIGN_LEFT);
        // p10_c.setSpacingAfter(5f);
        // document.add(p10_c);

        // // Note section
        // Paragraph p10_d = new Paragraph("NOTE:", boldBodyFont);
        // p10_d.setAlignment(Element.ALIGN_CENTER);
        // p10_d.setSpacingAfter(0f);
        // document.add(p10_d);

		// --- Signature block: Name and Signature on the same line ---
// --- Signature & Contact Block (Unified Table) ---
// --- Signature & Contact Block (2 Rows) ---
PdfPTable signTable = new PdfPTable(1);
signTable.setWidthPercentage(100);
signTable.setSpacingBefore(10f);
signTable.setSpacingAfter(10f);
//signTable.setWidths(new float[]{2, 1}); // wider name column
signTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);


PdfPCell signCell;

if (wsLoginUser_id != null && !wsLoginUser_id.equals("null")) {
    File file1 = new File(softwareFileLocation + wsLoginUser_id + ".jpg");
    if (file1.exists() && !file1.isDirectory()) {

        // ✅ Load and scale the image
        Image image_sig = Image.getInstance(softwareFileLocation + wsLoginUser_id + ".jpg");
        image_sig.scaleToFit(60.0F, 60.0F);
        image_sig.setAlignment(Element.ALIGN_LEFT);

        // ✅ Create a PdfPCell containing the image
        signCell = new PdfPCell(image_sig);
        signCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        signCell.setVerticalAlignment(Element.ALIGN_LEFT);

    } else {
        // ✅ Create a PdfPCell with text if image not found
        Paragraph y_tna = new Paragraph("Certificate Not Approved",
                new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD));
        signCell = new PdfPCell(y_tna);
        signCell.setHorizontalAlignment(Element.ALIGN_LEFT);
        signCell.setVerticalAlignment(Element.ALIGN_LEFT);
    }

} else {
    // ✅ Handle null user id
    Paragraph y_tna = new Paragraph("Certificate Not Approved",
            new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD));
    signCell = new PdfPCell(y_tna);
    signCell.setHorizontalAlignment(Element.ALIGN_LEFT);
    signCell.setVerticalAlignment(Element.ALIGN_LEFT);
}

// ✅ Add border, padding, etc.
signCell.setBorder(Rectangle.NO_BORDER);
signCell.setPaddingTop(5f);
signCell.setPaddingBottom(5f);


signTable.addCell(signCell);

// Row 1: Name and Signature
PdfPCell nameCell = new PdfPCell(new Phrase("NAME: " + wsLoginUser, bodyFont));
nameCell.setBorder(Rectangle.NO_BORDER);
nameCell.setPaddingTop(5f);
nameCell.setPaddingBottom(5f);
signTable.addCell(nameCell);


// Row 2: FOR and CONTACT
PdfPCell forCell = new PdfPCell();
Phrase forPhrase = new Phrase();
forPhrase.add(new Chunk("FOR: ", bodyFont));
forPhrase.add(new Chunk("REGIONAL LANDS OFFICER", boldBodyFont));
forCell.addElement(forPhrase);
forCell.setBorder(Rectangle.NO_BORDER);
forCell.setPaddingTop(3f);
forCell.setPaddingBottom(5f);

PdfPCell contactCell = new PdfPCell();
Phrase contactPhrase = new Phrase();
contactPhrase.add(new Chunk("CONTACT: ", bodyFont));
contactPhrase.add(new Chunk("( " + web_telephone + " )", italicBodyFont));
contactCell.addElement(contactPhrase);
contactCell.setBorder(Rectangle.NO_BORDER);
contactCell.setPaddingTop(3f);
contactCell.setPaddingBottom(5f);

signTable.addCell(forCell);
signTable.addCell(contactCell);

document.add(signTable);

  // // Note section
        Paragraph p10_d = new Paragraph("NOTE:", boldBodyFont);
        p10_d.setAlignment(Element.ALIGN_CENTER);
        p10_d.setSpacingAfter(0f);
        document.add(p10_d);

        // Notes with bold and italic
        Paragraph p16 = new Paragraph();
        p16.add(new Chunk("(a) ", bodyFont));
        p16.add(new Chunk("Ground rent is not the same as Property rate.", italicBodyFont));
        p16.add(new Chunk(" Ground rent is paid to the Lands Commission for the land, while Property rate is paid to the local assembly for the building.\n", bodyFont));
       
		p16.add(new Chunk("(b) Rent that goes into arrears attracts a 10% ", bodyFont));
        p16.add(new Chunk("compound interest", boldItalicBodyFont));
        p16.add(new Chunk(" and failure to settle the above-stated amount ", bodyFont));
        //p16.add(new Chunk("(insert date i.e. 1 month after the date of the notice)", italicBodyFont));
        p16.add(new Chunk(" may compel the Lands Commission to institute a ", bodyFont));
        p16.add(new Chunk("civil action", boldItalicBodyFont));
        p16.add(new Chunk(" against you to recover the amount and its accumulative interest.\n", bodyFont));
       


		p16.add(new Chunk("(c) ", bodyFont));
        p16.add(new Chunk("Non-payment of rent", boldItalicBodyFont));
        p16.add(new Chunk(" could be grounds for re-entry of the land by the Lands Commission.\n", bodyFont));
        p16.add(new Chunk("(d) Please log in to ", bodyFont));
        p16.add(new Chunk("onlineservices.lc.gov.gh", italicBodyFont));
        p16.add(new Chunk(" to create an account, generate a bill, and make payment on the ", bodyFont));
        p16.add(new Chunk("GHANA.GOV payment platform", boldItalicBodyFont));
        p16.add(new Chunk(" OR pay via short code ", bodyFont));
        p16.add(new Chunk("*222#", italicBodyFont));
        p16.add(new Chunk(".\n", bodyFont));
        p16.add(new Chunk("(e) You may call or visit the Office during working hours ", bodyFont));
        p16.add(new Chunk("(8:00am-5:00pm)", italicBodyFont));
        p16.add(new Chunk(" with the following details: ", bodyFont));
        p16.add(new Chunk("TIN, VALID ID, EMAIL ADDRESS & PHONE NO.", boldBodyFont));
        p16.add(new Chunk(" for a bill for payment.\n", bodyFont));
        p16.add(new Chunk("(f) Please, inform us of any changes in your ", bodyFont));
        p16.add(new Chunk("contact address (phone no, postal or email)", italicBodyFont));
        p16.add(new Chunk(".\n", bodyFont));
        p16.add(new Chunk("(g) Please ignore this notice if you are not the legitimate lessee of the plot or if you have already settled your ground rent.", bodyFont));
        p16.setAlignment(Element.ALIGN_JUSTIFIED);
        document.add(p16);

        document.close();
        return out.toByteArray();
    } catch (FileNotFoundException e) {
        e.printStackTrace();
    } catch (DocumentException e) {
        e.printStackTrace();
    } finally {
        // Release resources, if any
    }
    return out.toByteArray();
}

// // Helper methods for table cells
// private void addTableHeaderCell(PdfPTable table, String text, Font font) {
//     PdfPCell cell = new PdfPCell(new Phrase(text, font));
//     cell.setHorizontalAlignment(Element.ALIGN_CENTER);
//     cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
//     cell.setPadding(6f);
//     cell.setBackgroundColor(new BaseColor(220, 220, 220));
//     table.addCell(cell);
// }

// private void addTableCell(PdfPTable table, String text, Font font) {
//     PdfPCell cell = new PdfPCell(new Phrase(text, font));
//     cell.setHorizontalAlignment(Element.ALIGN_CENTER);
//     cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
//     cell.setPadding(6f);
//     table.addCell(cell);
// }

	public byte[] create_lc_rent_demand_notice_for_rent_mgt_unit_u(String software_file_location, String basic_bill_details,
			String ws_login_user)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";

		String bd_job_number = "";
		String bd_case_number = "";
		String bd_stamp_duty_amount = "";

		String bd_rent_passing_per_app = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			// bd_customer_name = (String) jsonobj_bbd.getString("ar_name");
			String bd_account_number = (String) jsonobj_bbd.getString("account_number");
			String bd_owners_name = (String) jsonobj_bbd.getString("owners_name");
			String bd_address = (String) jsonobj_bbd.getString("address");
			String bd_mobile = (String) jsonobj_bbd.getString("mobile");

			String bd_mobile_1 = (String) jsonobj_bbd.getString("mobile_1");
			String bd_email = (String) jsonobj_bbd.getString("email");
			String bd_file_number = (String) jsonobj_bbd.getString("file_number");


			String bd_block = (String) jsonobj_bbd.getString("block");
			String bd_plot_number = (String) jsonobj_bbd.getString("plot_number");
			String bd_plot_size = (String) jsonobj_bbd.getString("plot_size");
			String bd_covenanted_user = (String) jsonobj_bbd.getString("covenanted_user");

			String rent_passing = (String) jsonobj_bbd.getString("rent_passing");
			String current_rent_period_covered = (String) jsonobj_bbd.getString("current_rent_period_covered");
			String current_rent_amount = (String) jsonobj_bbd.getString("current_rent_amount");
			String rent_current_period_new_start = (String) jsonobj_bbd.getString("rent_current_period_new_start");
			String rent_current_period_new_end = (String) jsonobj_bbd.getString("rent_current_period_new_end");
			String rent_arrears_new_period = (String) jsonobj_bbd.getString("rent_arrears_new_period");

			String arears_amount = (String) jsonobj_bbd.getString("arears_amount");

			String amount_due = (String) jsonobj_bbd.getString("amount_due");

	
			//SELECT rl_id, account_number, parcel_id, token, region_id, owners_name, address, mobile, mobile_1, email, file_number, ledger, folio, glpin, estate, location, block, plot_number, plot_size, covenanted_user, current_use, original_use, nature_of_devt, parcel_address, ls_number, nature_of_instrument, comm_date, term, expiry_date, after, consent_date, location_rate, rent_category, classification_of_arrears, rent_review_clause, rent_passing, adjoining_plots, amount_due, arears_amount, rent_outstanding, last_review_date, last_payment_date, remarks, is_demand_note_printed, is_demand_note_printed_date, is_demand_note_printed_by_id, is_demand_note_printed_by_name, is_demand_note_distributed, is_demand_note_distributed_date, is_demand_note_distributed_by_id, is_demand_note_distributed_by_name, created_by_id, created_by_name, created_at, updated_id, updated_by_name, updated_at, rent_review_period, last_payment_period, period_in_arrears, estate_id, current_rent_period_covered, current_rent_amount, rent_current_period_new_start, rent_current_period_new_end, rent_arrears_new_period
			//FROM rent.rent_main_ledger;
			
			Document document = new Document(PageSize.A4, 50, 50, 50, 50);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(240, 720);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			cbaddress.setTextMatrix(450, 800);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(450, 790);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(450, 780);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(450, 770);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(450, 760);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(450, 750);
			cbaddress.showText("Web: www.lc.gov.gh");


			cbaddress.setTextMatrix(50, 710);
			cbaddress.showText(("My Ref No: " + bd_file_number));
			cbaddress.setTextMatrix(50, 700);
			cbaddress.showText("Your Ref No:" + "");

		
			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(50, 689);
			canvas.lineTo(560, 689);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			//document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
			new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
	reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
	document.add(reportTitle_Original);


			// Paragraph reportTitle_JOB = new Paragraph("My Ref No: " + bd_plot_number, new Font(FontFamily.TIMES_ROMAN, 10));
			// reportTitle_JOB.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_JOB);

			// Paragraph reportTitle_JOB_1 = new Paragraph("Your Ref No: ", new Font(FontFamily.TIMES_ROMAN, 10));
			// reportTitle_JOB_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_JOB_1);


	// Assuming amount_due is a double or a number
	double amount_due_value = Double.parseDouble(amount_due);

	// Format the amount to 2 decimal places
	String formatted_amount_due = String.format("%.2f", amount_due_value);
	
			 DecimalFormat df = new DecimalFormat("#,###.00");
        String formatted = df.format(amount_due_value);



			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 12));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);


			Paragraph p_3 = new Paragraph("RENT DEMAND NOTICE", new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);


		//	document.add(new Phrase(Chunk.NEWLINE));

		
			
			
			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_file_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 720);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p11_2 = new Paragraph("TO: "+ bd_owners_name, new Font(FontFamily.TIMES_ROMAN, 12));
			p11_2.setAlignment(Element.ALIGN_LEFT);
			document.add(p11_2);


	Paragraph p11_3 = new Paragraph("ADDRESS: "+ bd_address, new Font(FontFamily.TIMES_ROMAN, 12));
			p11_3.setAlignment(Element.ALIGN_LEFT);
			document.add(p11_3);


			// 	Paragraph p11_1 = new Paragraph("PLOT NO/LOC: "+ bd_plot_number + "/" + bd_locality_of_parcel, new Font(FontFamily.TIMES_ROMAN, 12));
			// p11_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(p11_1);


			Paragraph p11_1 = new Paragraph("PLOT NO/LOC: "+ bd_plot_number + "/" + bd_locality_of_parcel, new Font(FontFamily.TIMES_ROMAN, 12));
			p11_1.setAlignment(Element.ALIGN_LEFT);
			document.add(p11_1);

			
			Paragraph p11_1_a = new Paragraph("BLK NO./STRT: "+ bd_account_number + "/" + bd_block + "/" + bd_locality_of_parcel, new Font(FontFamily.TIMES_ROMAN, 12));
			p11_1_a.setAlignment(Element.ALIGN_LEFT);
			document.add(p11_1_a);

			///document.add(new Phrase(Chunk.NEWLINE));
	
			Paragraph p5 = new Paragraph(
					"TAKE NOTICE that ground-rent on the above-mentioned premises for the period  period " + //
					rent_arrears_new_period +" amounting to "+AmountInWords.convertToCurrency(formatted_amount_due)+ " (GHC "+formatted+" ) has become due and payable by you. Payment is hereby demanded. "
							,
					new Font(FontFamily.TIMES_ROMAN, 12));
			p5.setAlignment(Element.ALIGN_LEFT);
			document.add(p5);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p6 = new Paragraph("The details are provided below",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);
			// System.out.println(bd_business_process_name);

			// document.add(new Phrase(Chunk.NEWLINE));

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(2);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 200, 50 });

			// PdfPCell cell = new PdfPCell(new Phrase("RENT ASSESSMENT", font10pt));
			// cell.setColspan(5);
			// cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setBackgroundColor(new BaseColor(140, 221, 8));

			// table.addCell(cell);

			table.addCell(new PdfPCell(new Phrase("Period", font12pt)));
			//table.addCell(new PdfPCell(new Phrase("Description", font12pt)));
			//table.addCell(new PdfPCell(new Phrase("Interest Rate", font10pt)));
			table.addCell(new PdfPCell(new Phrase("Amount (GHS)", font12pt)));

			//table.addCell(new PdfPCell(new Phrase(rent_passing, font10pt)));
			//table.addCell(new PdfPCell(new Phrase(bd_rent_passing_per_app, font10pt)));
			
			
			
			//table.addCell(new PdfPCell(new Phrase("Current Period", font12pt)));
			table.addCell(new PdfPCell(new Phrase("Current Rent: "+current_rent_period_covered, font12pt)));
			
			double current_rent_amount_value = Double.parseDouble(current_rent_amount);

					// Format the amount to 2 decimal places
					//String formatted_current_rent_amount = String.format("%.2f", current_rent_amount_value);
					String formatted_current_rent_amount = df.format(current_rent_amount_value);

					
			table.addCell(new PdfPCell(new Phrase(formatted_current_rent_amount, font12pt)));
			
			
			
			
			
			//table.addCell(new PdfPCell(new Phrase(, font12pt)));
			table.addCell(new PdfPCell(new Phrase("Arrears for the period: " + rent_arrears_new_period, font12pt)));
			
			double arears_amount_value = Double.parseDouble(arears_amount);

					// Format the amount to 2 decimal places
					//String formatted_arears_amount = String.format("%.2f", arears_amount_value);
					String formatted_arears_amount =df.format(arears_amount_value);

					
			table.addCell(new PdfPCell(new Phrase(formatted_arears_amount, font12pt)));






			//table.addCell(new PdfPCell(new Phrase("", font12pt)));
			table.addCell(new PdfPCell(new Phrase("Total", font12pt)));

		
// Add the formatted amount to the cell
table.addCell(new PdfPCell(new Phrase(formatted, font12pt)));
			//table.addCell(new PdfPCell(new Phrase(amount_due, font12pt)));

			


			// table.addCell("Bill Item Number");

			Integer NumberCount = 1;

			/*
			 * String bill_details = (String)jsonobj.getString("bills");
			 * 
			 * JSONArray jArr = new JSONArray(bill_details); for (int i=0; i <
			 * jArr.length(); i++) { // JSONObject obj = new
			 * JSONObject(bill_details);
			 * 
			 * JSONObject obj = jArr.getJSONObject(i);
			 * System.out.println(obj.toString());
			 * 
			 * ;
			 * 
			 * table.addCell(new PdfPCell(new
			 * Phrase(NumberCount.toString(),font10pt))); table.addCell(new
			 * PdfPCell(new
			 * Phrase((String)obj.getString("bill_number"),font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase((String)obj.getString("customer_id"),font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase((String)obj.getString("bill_amount"),font10pt)));
			 * table.addCell(new PdfPCell(new
			 * Phrase((String)obj.getString("division"),font10pt)));
			 * 
			 * NumberCount++; }
			 */

			table.addCell(new PdfPCell(new Phrase("1", font10pt)));
		

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			// table.setSpacingAfter(5.0f); // Space After table starts, like
			// margin-Bottom in CSS

			document.add(table);

			// document.add(new Phrase(Chunk.NEWLINE));


			
			// Paragraph p7 = new Paragraph(
			// 		"You are required to pay an outstanding rent of "+ AmountInWords.convertToCurrency(formatted_amount_due) +" for the period "+rent_arrears_new_period+". Rent that goes into arrears attracts a compound interest. Failure to settle the amount may compel the Commission to institute legal action to recover the said amount or take steps to re-enter and thereby cancel the lease."
			// 									,
			// 		new Font(FontFamily.TIMES_ROMAN, 12));
			// p7.setAlignment(Element.ALIGN_LEFT);
			// document.add(p7);

			// document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph p8 = new Paragraph(
			// 		"You are also required to notify the Commission with details of any charges in your address (Postal or E-mail).",
			// 		new Font(FontFamily.TIMES_ROMAN, 12));
			// p8.setAlignment(Element.ALIGN_LEFT);
			// document.add(p8);

			//document.add(new Phrase(Chunk.NEWLINE));



			Paragraph p10 = new Paragraph("SGN: ",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);


			Paragraph p10_a = new Paragraph("NAME: ",
					new Font(FontFamily.TIMES_ROMAN, 12));
					p10_a.setAlignment(Element.ALIGN_LEFT);
			document.add(p10_a);



			Paragraph p10_b = new Paragraph("FOR: REGIONAL LANDS OFFICER",
					new Font(FontFamily.TIMES_ROMAN, 12));
					p10_b.setAlignment(Element.ALIGN_LEFT);
			document.add(p10_b);

			//document.add(new Phrase(Chunk.NEWLINE));


			Paragraph p10_c = new Paragraph("CONTACT: ( "+web_telephone +" )",
					new Font(FontFamily.TIMES_ROMAN, 12));
					p10_c.setAlignment(Element.ALIGN_LEFT);
			document.add(p10_c);


			Paragraph p10_d = new Paragraph("NOTE:",
					new Font(FontFamily.TIMES_ROMAN, 12));
					p10_d.setAlignment(Element.ALIGN_CENTER);
			document.add(p10_d);


			// Paragraph p9 = new Paragraph("ALL MONIES SHOULD BE PAID EITHER IN CASH AT THE ONSITE BANK OR ON GHANA.GOV PAYMENT PLATFORM OR ANY PARTICIPATING BANK.",
			// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p9.setAlignment(Element.ALIGN_LEFT);
			// document.add(p9);

			// Paragraph p10 = new Paragraph("Please contact the number below for any clarification",
			// 		new Font(FontFamily.TIMES_ROMAN, 12));
			// p10.setAlignment(Element.ALIGN_LEFT);
			// document.add(p10);

			// Paragraph p11 = new Paragraph("Hotlines: 0203147754", new Font(FontFamily.TIMES_ROMAN, 12));
			// p11.setAlignment(Element.ALIGN_LEFT);
			// document.add(p11);

			

		
			/*
			 * Paragraph p14 = new Paragraph("Assessd By: " + ws_login_user, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p14.setAlignment(Element.ALIGN_LEFT); document.add(p14);
			 */

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

		//	document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
			// p15.setAlignment(Element.ALIGN_LEFT);
			// document.add(p15);

			// document.add(new Phrase(Chunk.NEWLINE));


			Paragraph p16 = new Paragraph(
					"(a) Ground rent is not the same as Property rate. " + //
												"Ground rent is paid to the Lands Commission for the land, while Property " + //
												"rate is paid to the local assembly for the building.\n" + //
												"(b) Rent that goes into arrears attracts a compound interest and failure to settle the above-stated amount before (insert date" + //
												"i.e. 1 month after the date of the notice) may compel the Lands Commission to institute a civil action against you to recover" + //
												"the amount and its accumulative interest.\n" + //
												"(c) Non-payment of rent could be grounds for re-entry of the land by the Lands Commission.\n" + //
												"(d) Please log in to onlineservices.lc.gov.gh to create an account, generate a bill, and make payment on the GHANA.GOV " + //
												"payment platform OR pay via short code *122#\n" + //
												"(e) You may call or visit the Office during working hours (8:00am-5:00pm) with the following details; TIN, VALID ID," + //
												"EMAIL ADDRESS & PHONE NO.; for a bill for payment.\n" + //
												"(f) Please, inform us of any changes in your contact address (phone no, postal or email).\n" + //
												"(g) Please ignore this notice if you are not the legitimate lessee of the plot or if you have already settled your ground rent.",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p16.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(p16);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_bill_regional_number(String software_file_location, String output_file,
			String ws_bill_details_db)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String client_name = "";
		String bd_job_number = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_bill_date = "";
		String bd_bill_amount = "";
		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bill_number = "";
		String licensed_surveyor_number = "";
		String licensed_surveyor_name = "";
		String bill_description = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("data");

			// JSONArray jArr = new JSONArray(ws_bill_details_db);
			// for (int i=0; i < jArr.length(); i++) {
			// JSONObject obj = jArr.getJSONObject(i);

			client_name = (String) jsonobj.getString("client_name");
			bd_job_number = (String) jsonobj.getString("job_number");
			// bd_business_process_id=
			// (String)obj.getString("business_process_id");
			bill_number = (String) jsonobj.getString("bill_number");
			// bd_bill_date= (String)obj.getString("bill_date");
			bd_bill_amount = (String) jsonobj.getString("bill_amount");
			// bd_business_process_sub_id=
			// (String)obj.getString("business_process_sub_id");
			// bd_business_process_sub_name=
			// (String)obj.getString("business_process_sub_name");

			licensed_surveyor_number = (String) jsonobj.getString("licensed_surveyor_number");
			licensed_surveyor_name = (String) jsonobj.getString("licensed_surveyor_name");
			bill_description = (String) jsonobj.getString("bill_description");

			// }

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_2 = new Paragraph("SURVEY AND MAPPING DIVISION", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			Paragraph p_3 = new Paragraph("SERVICE BILL", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p5 = new Paragraph("Bill No: " + bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p5.setAlignment(Element.ALIGN_LEFT);
			document.add(p5);

			Paragraph p6 = new Paragraph("Surveyor's Name: " + licensed_surveyor_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p7 = new Paragraph("Surveyor's No: " + licensed_surveyor_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p7.setAlignment(Element.ALIGN_LEFT);
			document.add(p7);

			Paragraph p11 = new Paragraph("Surveyor's Client Name: " + client_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p8 = new Paragraph("Service Type: " + bill_description, new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Job Number: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(3);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 35, 160, 100 });

			PdfPCell cell = new PdfPCell(new Paragraph("Details of Fees"));

			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell(new Phrase("S/N", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Description", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Amount (GHS)", new Font(FontFamily.TIMES_ROMAN, 10)));

			Integer NumberCount = 1;

			table.addCell(new Phrase(NumberCount.toString(), new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bill_description, new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.addCell(new Phrase("", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Total Amount", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			table.setSpacingAfter(5.0f); // Space After table starts, like
											// margin-Bottom in CSS

			document.add(table);

			Paragraph p12 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency(bd_bill_amount),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + "Assiamah John",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			codeQrImage_sign.scaleAbsolute(100, 100);
			// codeQrImage_sign.setAbsolutePosition(310,380);
			document.add(codeQrImage_sign);

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			Barcode128 code128 = new Barcode128();
			code128.setCode(bill_number);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 420);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(310, 380);
			document.add(codeQrImage);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_bill_plan_approval(String software_file_location, String output_file,
			String ws_bill_details_db)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String client_name = "";
		String bd_job_number = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_bill_date = "";
		String bd_bill_amount = "";
		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bill_number = "";
		String licensed_surveyor_number = "";
		String licensed_surveyor_name = "";
		String bill_description = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			// JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("data");
			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("data");

			// JSONArray jArr = new JSONArray(ws_bill_details_db);
			// for (int i=0; i < jArr.length(); i++) {
			// JSONObject obj = jArr.getJSONObject(i);

			client_name = (String) jsonobj.getString("client_name");
			bd_job_number = (String) jsonobj.getString("job_number");
			// bd_business_process_id=
			// (String)obj.getString("business_process_id");
			bill_number = (String) jsonobj.getString("bill_number");
			// bd_bill_date= (String)obj.getString("bill_date");
			bd_bill_amount = (String) jsonobj.getString("bill_amount");
			// bd_business_process_sub_id=
			// (String)obj.getString("business_process_sub_id");
			// bd_business_process_sub_name=
			// (String)obj.getString("business_process_sub_name");

			licensed_surveyor_number = (String) jsonobj.getString("licensed_surveyor_number");
			licensed_surveyor_name = (String) jsonobj.getString("licensed_surveyor_name");
			bill_description = (String) jsonobj.getString("bill_description");

			// }

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_2 = new Paragraph("SURVEY AND MAPPING DIVISION", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			Paragraph p_3 = new Paragraph("SERVICE BILL", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p5 = new Paragraph("Bill No: " + bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p5.setAlignment(Element.ALIGN_LEFT);
			document.add(p5);

			Paragraph p6 = new Paragraph("Surveyor's Name: " + licensed_surveyor_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p7 = new Paragraph("Surveyor's No: " + licensed_surveyor_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p7.setAlignment(Element.ALIGN_LEFT);
			document.add(p7);

			Paragraph p11 = new Paragraph("Surveyor's Client Name: " + client_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p8 = new Paragraph("Service Type: " + bill_description, new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Job Number: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(3);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 35, 160, 100 });

			PdfPCell cell = new PdfPCell(new Paragraph("Details of Fees"));

			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell(new Phrase("S/N", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Description", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Amount (GHS)", new Font(FontFamily.TIMES_ROMAN, 10)));

			Integer NumberCount = 1;

			table.addCell(new Phrase(NumberCount.toString(), new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bill_description, new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.addCell(new Phrase("", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Total Amount", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			table.setSpacingAfter(5.0f); // Space After table starts, like
											// margin-Bottom in CSS

			document.add(table);

			Paragraph p12 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency(bd_bill_amount),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + "Assiamah John",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			codeQrImage_sign.scaleAbsolute(100, 100);
			// codeQrImage_sign.setAbsolutePosition(310,380);
			document.add(codeQrImage_sign);

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			Barcode128 code128 = new Barcode128();
			code128.setCode(bill_number);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 420);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bill_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(310, 380);
			document.add(codeQrImage);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_acknowledement_slip(String software_file_location, String generate_job_number,
			String generate_case_number,
			String generate_regional_number, String business_process_sub_name, String licensed_surveyor_number,
			String licensed_surveyor_name, String lessees_name, String locality, String district, String region,
			String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);

			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.landscommission.org");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_2 = new Paragraph("SURVEY AND MAPPING DIVISION", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			Paragraph p_3 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Surveyor's Name: " + licensed_surveyor_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p7 = new Paragraph("Surveyor's No: " + licensed_surveyor_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p7.setAlignment(Element.ALIGN_LEFT);
			document.add(p7);

			Paragraph p8 = new Paragraph("Service Type: " + business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p13 = new Paragraph("Case Number: " + generate_case_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p13.setAlignment(Element.ALIGN_LEFT);
			document.add(p13);

			Paragraph p16 = new Paragraph("Regional Number: " + generate_regional_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p16.setAlignment(Element.ALIGN_LEFT);
			document.add(p16);

			Paragraph p9 = new Paragraph("Job Number: " + generate_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Surveyor's Client: " + lessees_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Locality of Parcel: " + locality, new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p14 = new Paragraph("District: " + district, new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			Paragraph p15 = new Paragraph("Region: " + region, new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			Paragraph p12 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency("5643.76"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p20 = new Paragraph("Client Service Officer: " + "Assiamah John",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p20.setAlignment(Element.ALIGN_LEFT);
			document.add(p20);

			Paragraph p21 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p21.setAlignment(Element.ALIGN_LEFT);
			document.add(p21);

			BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode("https://memorynotfound.com", 1000, 1000, null);
			Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			codeQrImage_sign.scaleAbsolute(100, 100);
			// codeQrImage_sign.setAbsolutePosition(310,380);
			document.add(codeQrImage_sign);

			Barcode128 code128 = new Barcode128();
			code128.setCode("123456789");
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 420);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(generate_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(310, 380);
			document.add(codeQrImage);

			// Inserting Table in PDF

			// Now Insert Every Thing Into PDF Document

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_plan_approval_hard_copy_submission(String software_file_location, String output_file,
			String ws_bill_details_db)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String client_name = "";
		String bd_job_number = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_bill_date = "";
		String bd_bill_amount = "";
		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bill_number = "";
		String licensed_surveyor_number = "";
		String licensed_surveyor_name = "";
		String bill_description = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobject_data = new JSONObject(ws_bill_details_db);
			String ws_bill_number = jsonobject_data.getString("data");

			// JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("data");
			JSONObject jsonobj = new JSONObject(ws_bill_number);
			// String bill_details = (String)jsonobj.getString("data");

			// JSONArray jArr = new JSONArray(ws_bill_details_db);
			// for (int i=0; i < jArr.length(); i++) {
			// JSONObject obj = jArr.getJSONObject(i);

			client_name = (String) jsonobj.getString("ar_name");
			bd_job_number = (String) jsonobj.getString("job_number");
			// bd_business_process_id=
			// (String)obj.getString("business_process_id");
			// bill_number= (String)jsonobj.getString("bill_number");
			// bd_bill_date= (String)obj.getString("bill_date");
			// bd_bill_amount= (String)jsonobj.getString("bill_amount");
			// bd_business_process_sub_id=
			// (String)obj.getString("business_process_sub_id");
			// bd_business_process_sub_name=
			// (String)obj.getString("business_process_sub_name");

			licensed_surveyor_number = (String) jsonobj.getString("licensed_surveyor_number");
			licensed_surveyor_name = (String) jsonobj.getString("smd_licensed_surveyor_name");
			// bill_description= (String)jsonobj.getString("bill_description");

			// }

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_2 = new Paragraph("SURVEY AND MAPPING DIVISION", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			Paragraph p_3 = new Paragraph("PLAN APPROVAL HARD COPY SUBMISSION SLIP",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p5 = new Paragraph("Bill No: " + bill_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p5.setAlignment(Element.ALIGN_LEFT);
			document.add(p5);

			Paragraph p6 = new Paragraph("Surveyor's Name: " + licensed_surveyor_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p7 = new Paragraph("Surveyor's No: " + licensed_surveyor_number,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p7.setAlignment(Element.ALIGN_LEFT);
			document.add(p7);

			Paragraph p11 = new Paragraph("Surveyor's Client Name: " + client_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p8 = new Paragraph("Service Type: " + bill_description, new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Job Number: " + bd_job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(3);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 35, 160, 100 });

			PdfPCell cell = new PdfPCell(new Paragraph("Details of Fees"));

			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell(new Phrase("S/N", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Description", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Amount (GHS)", new Font(FontFamily.TIMES_ROMAN, 10)));

			Integer NumberCount = 1;

			table.addCell(new Phrase(NumberCount.toString(), new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bill_description, new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.addCell(new Phrase("", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase("Total Amount", new Font(FontFamily.TIMES_ROMAN, 10)));
			table.addCell(new Phrase(bd_bill_amount, new Font(FontFamily.TIMES_ROMAN, 10)));

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			table.setSpacingAfter(5.0f); // Space After table starts, like
											// margin-Bottom in CSS

			document.add(table);

			Paragraph p12 = new Paragraph("Amount In Words: " + AmountInWords.convertToCurrency(bd_bill_amount),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + "Assiamah John",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(bd_job_number, 1000, 1000, null);
			Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			codeQrImage_sign.scaleAbsolute(100, 100);
			// codeQrImage_sign.setAbsolutePosition(310,380);
			document.add(codeQrImage_sign);

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			Barcode128 code128 = new Barcode128();
			code128.setCode(bd_job_number);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 420);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(bd_job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(310, 380);
			document.add(codeQrImage);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

	public byte[] create_service_acknoeledgement_bulk_regional_number(String software_file_location,
			String basic_bill_details,
			String ws_bill_details_db, String ws_login_user, String output_file)
			throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		String bd_licensed_surveyor_name = "";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";
		String bd_regional_number_list = "";
		String bd_ref_number = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_regional_number_list = (String) jsonobj_bbd.getString("regional_number_list");
			bd_licensed_surveyor_name = (String) jsonobj_bbd.getString("licensed_surveyor_name");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_ref_number = (String) jsonobj_bbd.getString("ref_number");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode((String)jsonobj.getString("unique"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("reference_number"), 1000, 1000,
					null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Bill Number: " + (String) jsonobj.getString("reference_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p6 = new Paragraph("Surveyor's Name: " + bd_licensed_surveyor_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			document.add(new Phrase(Chunk.NEWLINE));

			// Inserting Table in PDF
			PdfPTable table = new PdfPTable(5);
			table.setWidthPercentage(100);
			// Left aLign
			table.setTotalWidth((float) 300.0);
			;
			table.setHorizontalAlignment(0);
			table.setSpacingAfter(10);
			table.setTotalWidth(new float[] { 35, 80, 80, 100, 100 });

			PdfPCell cell = new PdfPCell(new Phrase("Regional Number List", font12pt));

			cell.setColspan(5);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			cell.setBackgroundColor(new BaseColor(140, 221, 8));

			table.addCell(cell);

			table.addCell("S/N");
			table.addCell("Job Number");
			table.addCell("Regional Number");
			table.addCell("Client Name");
			table.addCell("Locality");
			// table.addCell("District");

			// table.addCell("Division");

			Integer NumberCount = 1;

			String bill_details = (String) jsonobj.getString("jobs");

			JSONArray jArr = new JSONArray(bill_details);
			for (int i = 0; i < jArr.length(); i++) {
				// JSONObject obj = new JSONObject(bill_details);

				JSONObject obj = jArr.getJSONObject(i);
				System.out.println(obj.toString());

				;

				table.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("job_number"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("regional_number"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("ar_name"), font10pt)));
				table.addCell(new PdfPCell(new Phrase((String) obj.getString("locality"), font10pt)));

				NumberCount++;
			}

			// table.addCell(new PdfPCell(new Phrase("1", font10pt)));
			// table.addCell(new PdfPCell(new
			// Phrase((String)jsonobj.getString("unique"),font10pt)));

			// table.addCell("Consolidated Regsitration Fee");

			// table.addCell((String) jsonobj.getString("total_amount"));
			// table.addCell("LC");

			table.setSpacingBefore(5.0f); // Space Before table starts, like
											// margin-top in CSS
			// table.setSpacingAfter(5.0f); // Space After table starts, like
			// margin-Bottom in CSS

			document.add(table);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}


	public byte[] regenerate_process_acknowledgment_slip(String software_file_location, String basic_bill_details,
			String ws_bill_details_db,
			String ws_login_user, String output_file) throws IOException, SQLException, JSONException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		String bd_customer_name = "";
		// String bd_job_number ="";
		String bd_business_process_id = "";
		String bd_business_process_name = "";
		String bd_land_size = "";

		String bd_business_process_sub_id = "";
		String bd_business_process_sub_name = "";

		String bd_type_of_interest = "";

		String bd_application_type = "";
		String bd_locality_of_parcel = "";

		String bd_created_date = "";

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			JSONObject jsonobj_bbd = new JSONObject(basic_bill_details);
			bd_customer_name = (String) jsonobj_bbd.getString("ar_name");
			// bd_job_number= (String)jsonobj_bbd.getString("job_number");
			bd_business_process_id = (String) jsonobj_bbd.getString("business_process_id");
			bd_business_process_name = (String) jsonobj_bbd.getString("business_process_name");
			bd_land_size = (String) jsonobj_bbd.getString("land_size");
			bd_business_process_sub_id = (String) jsonobj_bbd.getString("business_process_sub_id");
			bd_business_process_sub_name = (String) jsonobj_bbd.getString("business_process_sub_name");

			bd_type_of_interest = (String) jsonobj_bbd.getString("type_of_interest");
			bd_application_type = (String) jsonobj_bbd.getString("application_type");
			bd_locality_of_parcel = (String) jsonobj_bbd.getString("locality_of_parcel");
			bd_created_date = (String) jsonobj_bbd.getString("created_date");

			JSONObject jsonobj = new JSONObject(ws_bill_details_db);
			// String bill_details = (String)jsonobj.getString("bills");

			Document document = new Document(PageSize.A5, 25, 25, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(120.0F, 100.0F);
			image.setAbsolutePosition(170, 485);
			document.add(image);

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 7);

			cbaddress.setTextMatrix(310, 560);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(310, 550);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(310, 540);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(310, 530);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(310, 520);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(310, 510);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 480);
			canvas.lineTo(400, 480);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			/*
			 * BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String)
			 * jsonobj.getString("job_number"), 1000, 1000, null); Image
			 * codeQrImage = barcodeQRCode.getImage();
			 * codeQrImage.scaleAbsolute(100, 100);
			 * codeQrImage.setAbsolutePosition(310, 380);
			 * document.add(codeQrImage);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode((String) jsonobj.getString("job_number"), 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			//Date now = new Date();
			Paragraph p4 = new Paragraph("Date: " + bd_created_date, new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_RIGHT);
			document.add(p4);

			Paragraph p6 = new Paragraph("Client Name: " + bd_customer_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6.setAlignment(Element.ALIGN_LEFT);
			document.add(p6);

			Paragraph p8 = new Paragraph("Service Type: " + bd_business_process_sub_name,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p8.setAlignment(Element.ALIGN_LEFT);
			document.add(p8);

			Paragraph p9 = new Paragraph("Case Number: " + (String) jsonobj.getString("case_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p9.setAlignment(Element.ALIGN_LEFT);
			document.add(p9);

			Paragraph p10 = new Paragraph("Job Number: " + (String) jsonobj.getString("job_number"),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p10.setAlignment(Element.ALIGN_LEFT);
			document.add(p10);

			Paragraph p11 = new Paragraph("Locality of Parcel: " + bd_locality_of_parcel,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p11.setAlignment(Element.ALIGN_LEFT);
			document.add(p11);

			Paragraph p12 = new Paragraph("Type of Interest: " + bd_type_of_interest,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p12.setAlignment(Element.ALIGN_LEFT);
			document.add(p12);

			// convert to acres amount entered in hectors
			double bd_size_acres = Double.parseDouble(bd_land_size) * 0.404686;
			System.out.println("value in hect is : " + bd_size_acres);
			BigDecimal instance = new BigDecimal(Double.toString(bd_size_acres));
			instance = instance.setScale(2, RoundingMode.HALF_UP);

			Paragraph p13 = new Paragraph("Land Size: " + bd_land_size + " Acre(s)",
					new Font(FontFamily.TIMES_ROMAN, 10));
			p13.setAlignment(Element.ALIGN_LEFT);
			document.add(p13);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p14 = new Paragraph("Client Service Officer: " + ws_login_user,
					new Font(FontFamily.TIMES_ROMAN, 10));
			p14.setAlignment(Element.ALIGN_LEFT);
			document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new
			 * BarcodeQRCode((String)jsonobj.getString("unique"), 1000, 1000,
			 * null); Image codeQrImage_sign = barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310,380);
			 * document.add(codeQrImage_sign);
			 */

			Paragraph p15 = new Paragraph("For: Regional Lands Officer", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_LEFT);
			document.add(p15);

			document.close();
			//out.close();
		return out.toByteArray();
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out.toByteArray();

	}

}
