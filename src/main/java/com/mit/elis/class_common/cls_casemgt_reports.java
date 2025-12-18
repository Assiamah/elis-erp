package com.mit.elis.class_common;

import java.awt.Dimension;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mit.elis.plan_generations.GeometryUtils;
import com.mit.elis.plan_generations.Renderer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.awt.geom.AffineTransform;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.html.simpleparser.HTMLWorker;
import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.itextpdf.text.pdf.Barcode128;
import com.itextpdf.text.pdf.BarcodeQRCode;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfDocument;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;
import com.vividsolutions.jts.geom.GeometryCollection;


import ws.casemgt.HeaderFooterPageEvent;
import ws.casemgt.cls_case_documents;
import ws.casemgt.cls_case_management;
import java.util.*;
//import java.util.List;

public class cls_casemgt_reports {

	@Autowired
	private static Ws_url_config cls_url_config;


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

	cls_case_management cls_case_management = new cls_case_management();
	cls_case_documents cls_case_documents = new cls_case_documents();

	public static String convertToTitleCaseIteratingChars(String text) {
		if (text == null || text.isEmpty()) {
			return text;
		}

		StringBuilder converted = new StringBuilder();

		boolean convertNext = true;
		for (char ch : text.toCharArray()) {
			if (Character.isSpaceChar(ch)) {
				convertNext = true;
			} else if (convertNext) {
				ch = Character.toTitleCase(ch);
				convertNext = false;
			} else {
				ch = Character.toLowerCase(ch);
			}
			converted.append(ch);
		}

		return converted.toString();
	}

	private static final String[] specialNamesMonthDay = { "", " First", " Second", " Third", " Fourth", " Fifth",
			" Sixth", " Seventh", " Eighth", " Nineth", " Tenth", " Eleventh", " Twelveth", " Thirteenth",
			" Fourteenth", " Fifteenth", " Xixteenth", " Seventeenth", " Sighteenth", " nineteenth", " twenth",
			" twenty-first", " twenty second", " twenty third", " twenty fourth", " twenty fifth", " twenty sixth",
			" twenty seventh", " twenty eighth", " twenty nineth", " thirty", " thirty first"

	};

	private static final String[] getMonth = { "", " January", " February", " March", " April", " May", " June",
			" July", " August", " September", " October", " November", " December"

	};

	private static final String[] specialNamesMonthDay_short = { "", " 1st", " 2nd", " 3rd", " 4th", " 5th", " 6th",
			" 7th", " 8th", " 9th", " 10th", " 11th", " 12th", " 13th", " 14th", " 15th", " 16th", " 17th", " 18th",
			" 19th", " 20th", " 21st", " 22nd", " 23rd", " 24th", " 25th", " 26th", " 27th", " 28th", " 29th", " 30th",
			" 31st"

	};


	public byte[] create_land_certificate_LEASEHOLD(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
	
		
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("         " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("         " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("         " + folio_number);

			// cbaddress.setTextMatrix(400, 780);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("LAND CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("THIS IS TO CERTIFY THAT ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			// Chunk st2 = new Chunk(" of Accra in the Greater Accra Region",
			// small);
			// st2.setTextRise(7);
			// p_2.add(st2);

			Chunk st2 = new Chunk(" of Accra in the Greater Accra Region", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(" of the Republic of Ghana is registered as tenant or lessee ", small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(commencement_date);
			// DateTimeFormatter formatter1 =
			// DateTimeFormatter.ofPattern("dd/MM/yyyy");
			// LocalDate formatter2 = LocalDate.toLocalDate("dd/MM/yyyy");
			// String formatted_date_of_registration =
			// localDateTime.format(formatter1);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Chunk st4 = new Chunk(
					" for a term of " + term + " years from the " + specialNamesMonthDay[day_c] + " day of "
							+ convertToTitleCaseIteratingChars(month_c.toString()) + ", " + year_c + " subject to the",
					small);
			st4.setTextRise(7);
			p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being", small);
			st7.setTextRise(7);
			p_2.add(st7);

			Chunk st8 = new Chunk(" GLPIN No. " + glpin + ", SECTION " + registration_section_number + " BLOCK "
					+ registration_block_number + ", situate at " + locality, small);
			st8.setTextRise(7);
			p_2.add(st8);

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated on Registry Map",
					small);
			st10.setTextRise(7);
			p_2.add(st10);

			Chunk st11 = new Chunk(
					" No. " + registry_mapref + " in the Lands Commission, Cantonment Accra, and being the piece or",
					small);
			st11.setTextRise(7);
			p_2.add(st11);

			Chunk st12 = new Chunk(" parcel of land shown and edged with pink color on Survey Plan No. " + plan_no,
					small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" annexed to this Certificate except and reserved all minerals, oils, precious",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" stones and timber whatsoever upon or under the said piece or parcel of land.",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			//// document.add(new Phrase(Chunk.NEWLINE));

			// String approval_status = (String)
			// obj_proprietors.getString("approval_status");
			// System.out.println("approval_status");
			// System.out.println(certificete_approval_status);

			if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {

				File file1 = new File(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {

					Paragraph y_tna = new Paragraph("Certificate Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}

			// Paragraph p_4 = new Paragraph(".......................................",
			// new Font(FontFamily.TIMES_ROMAN, 12));
			// p_4.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			/*
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 */

			// PdfPCell CellFourHdr_memorials = new PdfPCell(new
			// Paragraph("Remarks",font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			/*
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 */

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null") {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);

					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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



	public byte[] create_land_certificate_LEASEHOLD_old(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
	
		
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("LAND CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("THIS IS TO CERTIFY THAT ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			// Chunk st2 = new Chunk(" of Accra in the Greater Accra Region",
			// small);
			// st2.setTextRise(7);
			// p_2.add(st2);

			Chunk st2 = new Chunk(" of Accra in the Greater Accra Region", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(" of the Republic of Ghana is registered as tenant or lessee ", small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(commencement_date);
			// DateTimeFormatter formatter1 =
			// DateTimeFormatter.ofPattern("dd/MM/yyyy");
			// LocalDate formatter2 = LocalDate.toLocalDate("dd/MM/yyyy");
			// String formatted_date_of_registration =
			// localDateTime.format(formatter1);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Chunk st4 = new Chunk(
					" for a term of " + term + " years from the " + specialNamesMonthDay[day_c] + " day of "
							+ convertToTitleCaseIteratingChars(month_c.toString()) + ", " + year_c + " subject to the",
					small);
			st4.setTextRise(7);
			p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being", small);
			st7.setTextRise(7);
			p_2.add(st7);

			Chunk st8 = new Chunk(" GLPIN No. " + glpin + ", SECTION " + registration_section_number + " BLOCK "
					+ registration_block_number + ", situate at " + locality, small);
			st8.setTextRise(7);
			p_2.add(st8);

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated on Registry Map",
					small);
			st10.setTextRise(7);
			p_2.add(st10);

			Chunk st11 = new Chunk(
					" No. " + registry_mapref + " in the Lands Commission, Cantonment Accra, and being the piece or",
					small);
			st11.setTextRise(7);
			p_2.add(st11);

			Chunk st12 = new Chunk(" parcel of land shown and edged with pink color on Survey Plan No. " + plan_no,
					small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" annexed to this Certificate except and reserved all minerals, oils, precious",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" stones and timber whatsoever upon or under the said piece or parcel of land.",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			//// document.add(new Phrase(Chunk.NEWLINE));

			// String approval_status = (String)
			// obj_proprietors.getString("approval_status");
			// System.out.println("approval_status");
			// System.out.println(certificete_approval_status);

			if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {

				File file1 = new File(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {

					Paragraph y_tna = new Paragraph("Certificate Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}

			// Paragraph p_4 = new Paragraph(".......................................",
			// new Font(FontFamily.TIMES_ROMAN, 12));
			// p_4.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			/*
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 */

			// PdfPCell CellFourHdr_memorials = new PdfPCell(new
			// Paragraph("Remarks",font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			/*
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 */

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null") {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);

					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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



	public byte[] create_land_certificate_LEASEHOLD_provisional(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("PROVISIONAL CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(20f);

			Chunk st = new Chunk("THIS IS TO CERTIFY THAT ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			// Chunk st2 = new Chunk(" of Accra in the Greater Accra Region",
			// small);
			// st2.setTextRise(7);
			// p_2.add(st2);

			Chunk st2 = new Chunk(" of Accra in the Greater Accra Region", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(" of the Republic of Ghana is registered as tenant or lessee ", small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(commencement_date);
			// DateTimeFormatter formatter1 =
			// DateTimeFormatter.ofPattern("dd/MM/yyyy");
			// LocalDate formatter2 = LocalDate.toLocalDate("dd/MM/yyyy");
			// String formatted_date_of_registration =
			// localDateTime.format(formatter1);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Chunk st4 = new Chunk(
					" for a term of " + term + " years from the " + specialNamesMonthDay[day_c] + " day of "
							+ convertToTitleCaseIteratingChars(month_c.toString()) + ", " + year_c + " subject to the",
					small);
			st4.setTextRise(7);
			p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being", small);
			st7.setTextRise(7);
			p_2.add(st7);

			Chunk st8 = new Chunk(" GLPIN No. " + glpin + ", SECTION " + registration_section_number + " BLOCK "
					+ registration_block_number + ", situate at " + locality, small);
			st8.setTextRise(7);
			p_2.add(st8);

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated on Registry Map",
					small);
			st10.setTextRise(7);
			p_2.add(st10);

			Chunk st11 = new Chunk(
					" No. " + registry_mapref + " in the Lands Commission, Cantonment Accra, and being the piece or",
					small);
			st11.setTextRise(7);
			p_2.add(st11);

			Chunk st12 = new Chunk(" parcel of land shown and edged with pink color on Survey Plan No. " + plan_no,
					small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" annexed to this Certificate except and reserved all minerals, oils, precious",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" stones and timber whatsoever upon or under the said piece or parcel of land.",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";

			cert_text2 += "This Certificate does not affect or prejudice the enforcement of any right adverse to or in derogation of the title thereto as its specified in the Register.\n"
					+ "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(30);
			document.add(p_3);

			//// document.add(new Phrase(Chunk.NEWLINE));

			// String approval_status = (String)
			// obj_proprietors.getString("approval_status");
			// System.out.println(approval_status);

			if (certificete_approval_status.equals("1")) {

				File file1 = new File(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(cls_url_config.getSoftfile_location() + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {

					Paragraph y_tna = new Paragraph("Certificate Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}

			// Paragraph p_4 = new Paragraph(".......................................",
			// new Font(FontFamily.TIMES_ROMAN, 12));
			// p_4.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			/*
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 */

			// PdfPCell CellFourHdr_memorials = new PdfPCell(new
			// Paragraph("Remarks",font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			/*
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 */

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null") {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);

					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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

	public byte[] create_land_register(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_register_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		System.out.println(request_json.toString());
		System.out.println(case_records);


		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_valuation_section = (String) case_obj.getString("lrd_valuation_section");
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String json_lrd_encumbrances_section = (String) case_obj.getString("lrd_encumbrances_section");
		String json_lrd_certificate_section = (String) case_obj.getString("lrd_certificate_section");
		String json_lrd_proprietorship_section = (String) case_obj.getString("lrd_proprietorship_section");
		String json_lrd_reservation_section = (String) case_obj.getString("lrd_reservation_section");

		System.out.println("json_lrd_encumbrances_section");
		System.out.println(json_lrd_encumbrances_section);

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String description_of_land = (String) job_detail_obj.get("smd_region").toString();

		DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);
			Font font10pt_bold = new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD);

			Document document = new Document(PageSize.A4.rotate(), 50, 50, 50, 50);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode(new_case_number);
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(60,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(120, 120);
			codeQrImage.setAbsolutePosition(35, 465);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(367, 490);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(690, 480);
			document.add(image1);

			// Font font = new Font(FontFamily.TIMES_ROMAN);
			// Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			// Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph y_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			Paragraph p_1 = new Paragraph("LAND REGISTER", new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			// Inserting Table in PDF
			PdfPTable myTable_admin = new PdfPTable(2);
			myTable_admin.setWidthPercentage(100);
			// Left aLign
			myTable_admin.setTotalWidth((float) 300.0);
			;
			myTable_admin.setHorizontalAlignment(0);
			myTable_admin.setSpacingAfter(10);
			myTable_admin.setTotalWidth(new float[] { 50, 100 });

			myTable_admin.addCell(new PdfPCell(new Phrase("Administrative District", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(district, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Nature of Interest", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(type_of_interest, font10pt)));
			// myTable_admin.addCell("bd_bill_amount");

			LocalDateTime localDateTime9 = LocalDateTime.parse(commencement_date);
			String vr_commencement_date = localDateTime9.format(formatter1);
	
			myTable_admin.addCell(new PdfPCell(new Phrase("Commencement Date", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(vr_commencement_date, font10pt)));

			if(!type_of_interest.contains("FREE")){

				myTable_admin.addCell(new PdfPCell(new Phrase("Term", font10pt_bold)));
				myTable_admin.addCell(new PdfPCell(new Phrase(term + " Year(s)", font10pt)));
	
				myTable_admin.addCell(new PdfPCell(new Phrase("Option for Renewal", font10pt_bold)));
				myTable_admin.addCell(new PdfPCell(new Phrase(renewal_term, font10pt)));
			}


			LocalDateTime localDateTime1 = LocalDateTime.parse(date_of_registration);
			String vr_date_of_registration = localDateTime1.format(formatter1);

			myTable_admin.addCell(new PdfPCell(new Phrase("Date of registration", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(vr_date_of_registration, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Volume", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(volume_number, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Folio", font10pt_bold)));
			myTable_admin.addCell(new PdfPCell(new Phrase(folio_number, font10pt)));

		
			

			// myTable_admin.addCell("bd_bill_amount");

			// PdfPCell cell_admin = new PdfPCell(new Paragraph("Description of Land", font10pt_bold));
			// cell_admin.setColspan(2);
			// // cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// // cell.setPadding(10.0f);
			// // cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			// myTable_admin.addCell(cell_admin);

			// PdfPCell cell_land_desc = new PdfPCell(new Paragraph("All that piece or parcel of land in extent " + extent
			// 		+ " more or less being GLPIN " + glpin + ", " + parcel_description + " situated at " + locality
			// 		+ " in the Greater Accra Region of the Republic of Ghana as delineated on Registry Map No. "
			// 		+ registry_mapref
			// 		+ " in the Lands Commission, Cantonment-Accra, Accra and being the piece or parcel of land shown and edged with pink colour on Plan No. "
			// 		+ plan_no + " annexed to the Land Certificate. ", font10pt));
			// cell_land_desc.setColspan(2);

			PdfPCell cell_admin = new PdfPCell(new Paragraph("Description of Land", font10pt_bold));
			cell_admin.setColspan(2);
			myTable_admin.addCell(cell_admin);

			description_of_land=description_of_land.replace("<ol><li>", "");
			description_of_land=description_of_land.replace("</li></ol>", "");


			PdfPCell cell_land_desc = new PdfPCell(new Paragraph(description_of_land, font10pt));
			cell_land_desc.setColspan(2);

			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_admin.addCell(cell_land_desc);

			myTable_admin.setSpacingBefore(5.0f); // Space Before table starts,
													// like margin-top in CSS
			myTable_admin.setSpacingAfter(5.0f); // Space After table starts,
													// like margin-Bottom in CSS

			document.add(myTable_admin);

			// Inserting Table in PDF
			PdfPTable myTable_valuation = new PdfPTable(3);
			myTable_valuation.setWidthPercentage(100);
			// Left aLign
			myTable_valuation.setTotalWidth((float) 300.0);
			;
			myTable_valuation.setHorizontalAlignment(0);
			myTable_valuation.setSpacingAfter(10);
			myTable_valuation.setTotalWidth(new float[] { 40, 90, 100 });

			PdfPCell cell_valuation = new PdfPCell(new Paragraph(
					"Valuation (Note: The date at the beginning of the last entry is the date on which the parcel was valued.) ",
					font10pt_bold));
			cell_valuation.setColspan(3);
			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_valuation.addCell(cell_valuation);

			myTable_valuation.addCell(new PdfPCell(new Phrase("Date ", font10pt_bold)));
			myTable_valuation.addCell(new PdfPCell(new Phrase("Amount", font10pt_bold)));
			myTable_valuation.addCell(new PdfPCell(new Phrase("Remarks", font10pt_bold)));

			// String json_data_land_certificate = "";

			// myTable_valuation.addCell(new PdfPCell(new Phrase(vr_date_of_registration, font10pt)));
			// myTable_valuation.addCell(new PdfPCell(new Phrase(stamp_duty_payable, font10pt)));
			// myTable_valuation.addCell(new PdfPCell(
			// 		new Phrase("The date herein is the date of the application for first registration.", font10pt)));

			if (json_lrd_valuation_section != "null" && json_lrd_valuation_section != null) {
				JSONArray jArr_valuation = new JSONArray(json_lrd_valuation_section);
				for (int i = 0; i < jArr_valuation.length(); i++) {
					JSONObject obj_valuation = jArr_valuation.getJSONObject(i);
					// Toast.makeText(getApplicationContext(),obj.toString(),Toast.LENGTH_SHORT).show();

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_valuation.getString("vs_date_of_valuation"));
					String vs_date_of_valuation = localDateTime2.format(formatter1);

					myTable_valuation.addCell(new PdfPCell(new Phrase(vs_date_of_valuation, font10pt)));
					myTable_valuation
							.addCell(new PdfPCell(new Phrase((String) obj_valuation.getString("vs_amount"), font10pt)));
					myTable_valuation.addCell(
							new PdfPCell(new Phrase((String) obj_valuation.getString("vs_remarks"), font10pt)));
				}
			}

			myTable_valuation.setSpacingBefore(5.0f);
			myTable_valuation.setSpacingAfter(5.0f);
			document.add(myTable_valuation);

			// Inserting Table in PDF
			PdfPTable myTable_reservation = new PdfPTable(2);
			myTable_reservation.setWidthPercentage(100);
			// Left aLign
			myTable_reservation.setTotalWidth((float) 300.0);
			;
			myTable_reservation.setHorizontalAlignment(0);
			myTable_reservation.setSpacingAfter(10);
			myTable_reservation.setTotalWidth(new float[] { 50, 160 });

			PdfPCell cell_head = new PdfPCell(new Paragraph("Reservations. etc.", font10pt_bold));
			cell_head.setColspan(2);
			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_reservation.addCell(cell_head);

			LocalDateTime localDateTime3 = LocalDateTime.parse(date_of_registration);
			String vs_date_of_registration = localDateTime3.format(formatter1);

			
		
			if (json_lrd_reservation_section != "null" && json_lrd_reservation_section != null) {
				JSONArray jArr_valuation = new JSONArray(json_lrd_reservation_section);
				for (int i = 0; i < jArr_valuation.length(); i++) {
					JSONObject obj_valuation = jArr_valuation.getJSONObject(i);
					// Toast.makeText(getApplicationContext(),obj.toString(),Toast.LENGTH_SHORT).show();

					myTable_reservation.addCell(new PdfPCell(new Phrase(vs_date_of_registration, font10pt)));
			
							myTable_reservation.addCell(
							new PdfPCell(new Phrase((String) obj_valuation.getString("reservation_description"), font10pt)));
				}
			}

		
			// myTable_reservation.addCell(new PdfPCell(new Phrase(vs_date_of_registration, font10pt)));
			// myTable_reservation
			// 		.addCell(new PdfPCell(new Phrase(
			// 				"Subject to the reservations, exceptions, restrictions, restrictivecovenants and conditions contained or referred to in a lease (a true copy of which is annexed to the Land Certificate) made between "
			// 						+ grantors_name + " of the one part and " + ar_name + " of the other part. ",
			// 				font10pt)));



			myTable_reservation.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_reservation.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_reservation);

			// Inserting Table in PDF
			PdfPTable myTable_land_certificate = new PdfPTable(4);
			myTable_land_certificate.setWidthPercentage(100);
			// Left aLign
			myTable_land_certificate.setTotalWidth((float) 300.0);
			;
			myTable_land_certificate.setHorizontalAlignment(0);
			myTable_land_certificate.setSpacingAfter(10);
			myTable_land_certificate.setTotalWidth(new float[] { 50, 50, 50, 50 });

			PdfPCell cell_land_certificate = new PdfPCell(
					new Paragraph("Land Certificate/Provisional Certificate", font10pt_bold));

			cell_land_certificate.setColspan(4);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));

			myTable_land_certificate.addCell(cell_land_certificate);

			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Date of Issue", font10pt_bold)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("To Whom Issued", font10pt_bold)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Serial No.", font10pt_bold)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Official Notes", font10pt_bold)));

			// String json_data_land_certificate = "";
			if (json_lrd_certificate_section != "null" && json_lrd_certificate_section != null ) {
				JSONArray jArr_land_certificate = new JSONArray(json_lrd_certificate_section);
				for (int i = 0; i < jArr_land_certificate.length(); i++) {
					JSONObject obj_land_certificate = jArr_land_certificate.getJSONObject(i);

					LocalDateTime localDateTime4 = LocalDateTime
							.parse((String) obj_land_certificate.getString("cs_date_of_registration"));
					String cs_date_of_registration = localDateTime4.format(formatter1);

					myTable_land_certificate.addCell(new PdfPCell(new Phrase(cs_date_of_registration, font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							new Phrase((String) obj_land_certificate.getString("cs_to_whom_issued"), font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							new Phrase((String) obj_land_certificate.getString("cs_serial_number"), font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							new Phrase((String) obj_land_certificate.getString("cs_official_notes"), font10pt)));
				}
			}

			myTable_land_certificate.setSpacingBefore(5.0f); // Space Before
																// myTable_land_certificate
																// starts, like
																// margin-top in
																// CSS
			myTable_land_certificate.setSpacingAfter(5.0f); // Space After table
															// starts, like
															// margin-Bottom in
															// CSS
			document.add(myTable_land_certificate);


			document.newPage();


			// Inserting Table in PDF
			PdfPTable myTable_proprietors = new PdfPTable(10);
			myTable_proprietors.setWidthPercentage(100);
			// Left aLign
			myTable_proprietors.setTotalWidth((float) 300.0);
			;
			myTable_proprietors.setHorizontalAlignment(0);
			myTable_proprietors.setSpacingAfter(10);
			myTable_proprietors.setTotalWidth(new float[] { 50, 50, 90, 50, 50,  50, 90, 50, 50, 50 });

			PdfPCell cell_proprietors = new PdfPCell(new Paragraph("Proprietorship", font10pt_bold));
			cell_proprietors.setColspan(10);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			myTable_proprietors.addCell(cell_proprietors);

			PdfPCell CellOneHdr_proprietors = new PdfPCell(new Paragraph("Entry No", font10pt_bold));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellOneHdr_proprietors);

			PdfPCell CellTwoHdr_proprietors = new PdfPCell(new Paragraph("Registered No.", font10pt_bold));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTwoHdr_proprietors);

			PdfPCell CellTreeHdr_proprietors = new PdfPCell(
					new Paragraph("Proprietors (names addresses and descriptions)", font10pt_bold));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTreeHdr_proprietors);

			PdfPCell cell_interest = new PdfPCell(new Paragraph("Instruments Relevant to the Title", font10pt_bold));
			cell_interest.setColspan(5);
			myTable_proprietors.addCell(cell_interest);

			PdfPCell CellNineHdr_proprietors = new PdfPCell(new Paragraph("Remark", font10pt_bold));
			// CellNineHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellNineHdr_proprietors);

			PdfPCell CellTenHdr_proprietors = new PdfPCell(new Paragraph("Signature of Registrar", font10pt_bold));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTenHdr_proprietors);

			PdfPCell EmptyCell_proprietors = new PdfPCell(new Paragraph("", font10pt_bold));
			// EmptyCell_proprietors.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);
			EmptyCell_proprietors.setColspan(3);
			myTable_proprietors.addCell(EmptyCell_proprietors);
			// myTable_proprietors.addCell(EmptyCell_proprietors);
			// myTable_proprietors.addCell(EmptyCell_proprietors);

			PdfPCell CellFourHdr_proprietors = new PdfPCell(new Paragraph("Date of Instrument", font10pt_bold));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellFourHdr_proprietors);

			PdfPCell CellFiveHdr_proprietors = new PdfPCell(new Paragraph("Nature of Instrument ", font10pt_bold));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellFiveHdr_proprietors);

			// PdfPCell CellElevenHdr_proprietors = new PdfPCell(new Paragraph("Term ", font10pt_bold));
			// // CellOneHdr_proprietors.setRowspan(2);
			// myTable_proprietors.addCell(CellElevenHdr_proprietors);

			PdfPCell CellSixHdr_proprietors = new PdfPCell(new Paragraph("Date of Registration", font10pt_bold));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellSixHdr_proprietors);

			PdfPCell CellSevenHdr_proprietors = new PdfPCell(new Paragraph("Parties", font10pt_bold));
			/// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellSevenHdr_proprietors);

			PdfPCell CellEightHdr_proprietors = new PdfPCell(new Paragraph("Price Paid", font10pt_bold));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellEightHdr_proprietors);

			PdfPCell lastcell_proprietors = new PdfPCell(new Paragraph("", font10pt_bold));
			// lastcell_proprietors.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);
			lastcell_proprietors.setColspan(2);
			myTable_proprietors.addCell(EmptyCell_proprietors);
			Integer NumberCount = 1;

			// String json_data_land_certificate = "";
			if (json_lrd_proprietorship_section != "null" && json_lrd_proprietorship_section != null ) {
				JSONArray jArr_proprietors = new JSONArray(json_lrd_proprietorship_section);
				for (int i = 0; i < jArr_proprietors.length(); i++) {
					JSONObject obj_proprietors = jArr_proprietors.getJSONObject(i);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
					myTable_proprietors.addCell(new PdfPCell(
							new Phrase((String) obj_proprietors.getString("ps_registration_number"), font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_proprietor"), font10pt)));

					LocalDateTime localDateTime5 = LocalDateTime
							.parse((String) obj_proprietors.getString("ps_date_of_instrument"));
					String ps_date_of_instrument = localDateTime5.format(formatter1);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(ps_date_of_instrument, font10pt)));
					myTable_proprietors.addCell(new PdfPCell(
							new Phrase((String) obj_proprietors.getString("ps_nature_of_instrument"), font10pt)));

					// 		LocalDateTime localDateTime4 = LocalDateTime
					// 		.parse((String) obj_proprietors.getString("commencement_date"));
					// String ps_commencement_date = localDateTime4.format(formatter1);

					//myTable_proprietors.addCell(new PdfPCell(new Phrase((String) obj_proprietors.getString("term"), font10pt)));
					//myTable_proprietors.addCell(new PdfPCell(new Phrase((String) obj_proprietors.getString("term") + " Years from " + ps_commencement_date, font10pt)));

					LocalDateTime localDateTime6 = LocalDateTime
							.parse((String) obj_proprietors.getString("ps_date_of_registration"));
					String ps_date_of_registration = localDateTime6.format(formatter1);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(ps_date_of_registration, font10pt)));
					myTable_proprietors
							.addCell(new PdfPCell(new Phrase(
									(String) obj_proprietors.getString("ps_transferor") + " (1) "
											+ (String) obj_proprietors.getString("ps_transferee") + " (2) ",
									font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_price_paid"), font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_remarks"), font10pt)));

					// Image image_sig = Image.getInstance(software_file_location + "signature.jpg");
					// // imgPDF2.ScaleToFit(100.0F, 70.0F)
					// image_sig.scaleToFit(100.0F, 100.0F);
					// myTable_proprietors.addCell(image_sig);



					String app_approval_status = (String) obj_proprietors.getString("approval_status");
					//System.out.println("app_approval_status");
					///System.out.println(app_approval_status);
					//System.out.println("approval_by_id");
					//System.out.println((String) obj_proprietors.getString("approval_by_id"));
					//System.out.println(software_file_location + (String) obj_proprietors.getString("approval_by_id") + ".jpg");
					
					//if ( app_approval_status != null && app_approval_status != "null" && app_approval_status.equals("1") ) {
					if ( !app_approval_status.equals("0") && !app_approval_status.equals("null") && app_approval_status.equals("1") ) {

						File file1 = new File(software_file_location + (String) obj_proprietors.getString("approval_by_id") + ".jpg");
						if (file1.exists() && !file1.isDirectory()) {
							Image image_sig = Image.getInstance(software_file_location + (String) obj_proprietors.getString("approval_by_id") + ".jpg");
							image_sig.scaleToFit(100.0F, 100.0F);
							image_sig.setAlignment(Element.ALIGN_CENTER);
		
							myTable_proprietors.addCell(image_sig);;
		
						} else {
		
							Paragraph y_tna = new Paragraph("Approved",
									new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
							y_tna.setAlignment(Element.ALIGN_CENTER);
							myTable_proprietors.addCell(y_tna);
						}
		
					} else {
		
						Paragraph y_tna = new Paragraph("Transaction Not Approved",
								new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
						y_tna.setAlignment(Element.ALIGN_CENTER);
						myTable_proprietors.addCell(y_tna);
					}


					NumberCount += 1;
				}
			}

			myTable_proprietors.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_proprietors.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_proprietors);

					// Inserting Table in PDF
					PdfPTable myTable_encumbrances = new PdfPTable(9);
					myTable_encumbrances.setWidthPercentage(100); // Left
		
					myTable_encumbrances.setTotalWidth((float) 300.0);
					;
					myTable_encumbrances.setHorizontalAlignment(0);
					myTable_encumbrances.setSpacingAfter(10);
					myTable_encumbrances.setTotalWidth(new float[] { 25, 40, 40, 50, 140, 20, 20, 50, 50 });
		

			PdfPCell EmptyCell_encumbrances = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_encumbrances.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			PdfPCell cell_encumbrances = new PdfPCell(
					new Paragraph("Leases, Charges, Encumbrances, etc. Affecting Land", font10pt));
			cell_encumbrances.setColspan(9); //
			cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER); // cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140,221,
			// 8));
			myTable_encumbrances.addCell(cell_encumbrances);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt)); //
			CellTwoHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt)); //
			CellTreeHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_encumbrances.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellTenHdr_memorials);

			PdfPCell cell_folio_reference = new PdfPCell(new Paragraph("Folio Reference No", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			cell_folio_reference.setColspan(2);
			myTable_encumbrances.addCell(cell_folio_reference);

			PdfPCell CellFourHdr_memorials = new PdfPCell(new Paragraph("Remarks", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Signature of Registrar", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellFiveHdr_memorials);

			myTable_encumbrances.addCell(EmptyCell_encumbrances);
			myTable_encumbrances.addCell(EmptyCell_encumbrances);
			myTable_encumbrances.addCell(EmptyCell_encumbrances);
			myTable_encumbrances.addCell(EmptyCell_encumbrances);
			myTable_encumbrances.addCell(EmptyCell_encumbrances);

			PdfPCell CellSixHdr_memorials = new PdfPCell(new Paragraph("Back", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_encumbrances.addCell(CellSixHdr_memorials);

			PdfPCell CellSevenHdr_memorials = new PdfPCell(new Paragraph("Forward", font10pt));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_encumbrances.addCell(CellSevenHdr_memorials);

			myTable_encumbrances.addCell(EmptyCell_encumbrances);
			myTable_encumbrances.addCell(EmptyCell_encumbrances);

			// System.out.println(json_lrd_encumbrances_section);

			System.out.println("json_lrd_encumbrances_section");
		System.out.println(json_lrd_encumbrances_section);
			Integer NumberCount_memo = 1; //
			String json_data_land_certificate = "";
			if (json_lrd_encumbrances_section != "null" && json_lrd_encumbrances_section != null) {
				JSONArray jArr_memorials = new JSONArray(json_lrd_encumbrances_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);

					System.out.println("obj_memorials");
		System.out.println(obj_memorials);
					myTable_encumbrances.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					// myTable_encumbrances.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("es_entry_number"), font10pt)));

					LocalDateTime localDateTime7 = LocalDateTime
							.parse((String) obj_memorials.getString("es_date_of_instrument"));
					String m_date_of_instrument = localDateTime7.format(formatter1);

					myTable_encumbrances.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime8 = LocalDateTime
							.parse((String) obj_memorials.getString("es_date_of_registration"));
					String m_date_of_registration = localDateTime8.format(formatter1);

					myTable_encumbrances.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_encumbrances.addCell(new PdfPCell(
							new Phrase((String) obj_memorials.getString("es_registered_number"), font10pt)));
							myTable_encumbrances.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("es_memorials"), font10pt)));

							myTable_encumbrances
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("es_back"), font10pt)));
							myTable_encumbrances.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("es_forward"), font10pt)));
							myTable_encumbrances.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("es_remarks"), font10pt)));


								//String app_approval_status = (String) obj_memorials.get("approval_status").toString();
								String app_approval_status = (String) obj_memorials.getString("approval_status");
					//if ( app_approval_status != null && app_approval_status != "null" && app_approval_status.equals("1") ) {
						if (app_approval_status != null && 
    !app_approval_status.equals("0") && 
    !app_approval_status.equals("null") && 
    app_approval_status.equals("1")) {

						File file1 = new File(software_file_location + (String) obj_memorials.getString("approval_by_id") + ".jpg");
						if (file1.exists() && !file1.isDirectory()) {
							Image image_sig = Image.getInstance(software_file_location + (String) obj_memorials.getString("approval_by_id") + ".jpg");
							image_sig.scaleToFit(100.0F, 100.0F);
							image_sig.setAlignment(Element.ALIGN_CENTER);
		
							myTable_encumbrances.addCell(image_sig);;
		
						} else {
		
							Paragraph y_tna = new Paragraph("Approved",
									new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
							y_tna.setAlignment(Element.ALIGN_CENTER);
							myTable_encumbrances.addCell(y_tna);
						}
		
					} else {
		
						Paragraph y_tna = new Paragraph("Transaction Not Approved",
								new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
						y_tna.setAlignment(Element.ALIGN_CENTER);
						myTable_encumbrances.addCell(y_tna);
					}
					NumberCount_memo += 1;
				}
			}

			myTable_encumbrances.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
														myTable_encumbrances.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS
			document.add(myTable_encumbrances);


			Paragraph p_2 = new Paragraph("Printed By", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			document.close();
			//file.close();
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

	public byte[] create_land_register_A3(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_register_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_valuation_section = (String) case_obj.getString("lrd_valuation_section");
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String json_lrd_encumbrances_section = (String) case_obj.getString("lrd_encumbrances_section");
		String json_lrd_certificate_section = (String) case_obj.getString("lrd_certificate_section");
		String json_lrd_proprietorship_section = (String) case_obj.getString("lrd_proprietorship_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			Document document = new Document(PageSize.A3.rotate(), 50, 50, 50, 50);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode(new_case_number);
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(60,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(60, 740);
			document.add(codeQrImage);

			Paragraph p_1 = new Paragraph("LAND REGISTER", new Font(FontFamily.TIMES_ROMAN, 18));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);
			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(120.0F,
			 * 100.0F); image.setAbsolutePosition(170, 485);
			 * document.add(image);
			 */
			/*
			 * BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA,
			 * BaseFont.CP1252, BaseFont.NOT_EMBEDDED); PdfContentByte cbaddress
			 * = writer.getDirectContent(); cbaddress.beginText();
			 * cbaddress.setFontAndSize(bfaddress, 7);
			 * 
			 * cbaddress.setTextMatrix(310, 560);
			 * cbaddress.showText(cls_general_query.comp_address);
			 * cbaddress.setTextMatrix(310, 550);
			 * cbaddress.showText(cls_general_query.city);
			 * cbaddress.setTextMatrix(310, 540); cbaddress.showText(("Tel: " +
			 * cls_general_query.telephone)); cbaddress.setTextMatrix(310, 530);
			 * cbaddress.showText(("Fax: " + cls_general_query.fax_number));
			 * cbaddress.setTextMatrix(310, 520); cbaddress.showText(("Email: "
			 * + cls_general_query.email)); cbaddress.setTextMatrix(310, 510);
			 * cbaddress.showText("Web: www.lc.gov.gh");
			 * 
			 * 
			 * cbaddress.endText();
			 */

			/*
			 * PdfContentByte canvas = writer.getDirectContent();
			 * canvas.moveTo(20, 480); canvas.lineTo(400, 480);
			 * canvas.closePathStroke();
			 */

			document.add(new Phrase(Chunk.NEWLINE));

			// Inserting Table in PDF
			PdfPTable myTable_admin = new PdfPTable(2);
			myTable_admin.setWidthPercentage(70);
			// Left aLign
			myTable_admin.setTotalWidth((float) 300.0);
			;
			myTable_admin.setHorizontalAlignment(0);
			myTable_admin.setSpacingAfter(10);
			myTable_admin.setTotalWidth(new float[] { 50, 100 });

			myTable_admin.addCell(new PdfPCell(new Phrase("Administrative District", font10pt)));
			myTable_admin.addCell(new PdfPCell(new Phrase(district, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Nature of Interest", font10pt)));
			myTable_admin.addCell(new PdfPCell(new Phrase(type_of_interest, font10pt)));
			// myTable_admin.addCell("bd_bill_amount");

			LocalDateTime localDateTime1 = LocalDateTime.parse(date_of_registration);
			String vr_date_of_registration = localDateTime1.format(formatter1);

			myTable_admin.addCell(new PdfPCell(new Phrase("Date of registration", font10pt)));
			myTable_admin.addCell(new PdfPCell(new Phrase(vr_date_of_registration, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Volume", font10pt)));
			myTable_admin.addCell(new PdfPCell(new Phrase(volume_number, font10pt)));

			myTable_admin.addCell(new PdfPCell(new Phrase("Folio", font10pt)));
			myTable_admin.addCell(new PdfPCell(new Phrase(folio_number, font10pt)));

			// myTable_admin.addCell("bd_bill_amount");

			PdfPCell cell_admin = new PdfPCell(new Paragraph("Description of Land", font10pt));
			cell_admin.setColspan(2);
			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_admin.addCell(cell_admin);

			PdfPCell cell_land_desc = new PdfPCell(new Paragraph("All that piece or parcel of land in extent " + extent
					+ " more or less being GLPIN " + glpin + ", " + parcel_description + " situate at " + locality
					+ " in the Greater Accra Region of the Republic of Ghana as delineated on Registry Map No. "
					+ registry_mapref
					+ " in the Lands Commission, Cantonment-Accra, Accra and being the piece or parcel of land shown and edged with pink colour on Plan No. "
					+ plan_no + " annexed to the Land Certificate. ", font10pt));
			cell_land_desc.setColspan(2);

			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_admin.addCell(cell_land_desc);

			myTable_admin.setSpacingBefore(5.0f); // Space Before table starts,
													// like margin-top in CSS
			myTable_admin.setSpacingAfter(5.0f); // Space After table starts,
													// like margin-Bottom in CSS

			document.add(myTable_admin);

			// Inserting Table in PDF
			PdfPTable myTable_valuation = new PdfPTable(3);
			myTable_valuation.setWidthPercentage(70);
			// Left aLign
			myTable_valuation.setTotalWidth((float) 300.0);
			;
			myTable_valuation.setHorizontalAlignment(0);
			myTable_valuation.setSpacingAfter(10);
			myTable_valuation.setTotalWidth(new float[] { 40, 90, 100 });

			PdfPCell cell_valuation = new PdfPCell(new Paragraph(
					"Valuation (Note: The date at the beginning of the last entry is the date on which the parcel was valued.) ",
					font10pt));
			cell_valuation.setColspan(3);
			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_valuation.addCell(cell_valuation);

			myTable_valuation.addCell(new PdfPCell(new Phrase("Date ", font10pt)));
			myTable_valuation.addCell(new PdfPCell(new Phrase("Amount", font10pt)));
			myTable_valuation.addCell(new PdfPCell(new Phrase("Remarks", font10pt)));

			// String json_data_land_certificate = "";

			// myTable_valuation.addCell(new PdfPCell(new Phrase(vr_date_of_registration, font10pt)));
			// myTable_valuation.addCell(new PdfPCell(new Phrase(stamp_duty_payable, font10pt)));
			// myTable_valuation.addCell(new PdfPCell(
			// 		new Phrase("The date herein is the date of the application for first registration.", font10pt)));

			if (json_lrd_valuation_section != "null") {
				JSONArray jArr_valuation = new JSONArray(json_lrd_valuation_section);
				for (int i = 0; i < jArr_valuation.length(); i++) {
					JSONObject obj_valuation = jArr_valuation.getJSONObject(i);
					// Toast.makeText(getApplicationContext(),obj.toString(),Toast.LENGTH_SHORT).show();

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_valuation.getString("vs_date_of_valuation"));
					String vs_date_of_valuation = localDateTime2.format(formatter1);

					myTable_valuation.addCell(new PdfPCell(new Phrase(vs_date_of_valuation, font10pt)));
					myTable_valuation
							.addCell(new PdfPCell(new Phrase((String) obj_valuation.getString("vs_amount"), font10pt)));
					myTable_valuation.addCell(
							new PdfPCell(new Phrase((String) obj_valuation.getString("vs_remarks"), font10pt)));
				}
			}

			myTable_valuation.setSpacingBefore(5.0f);
			myTable_valuation.setSpacingAfter(5.0f);
			document.add(myTable_valuation);

			// Inserting Table in PDF
			PdfPTable myTable_reservation = new PdfPTable(2);
			myTable_reservation.setWidthPercentage(70);
			// Left aLign
			myTable_reservation.setTotalWidth((float) 300.0);
			;
			myTable_reservation.setHorizontalAlignment(0);
			myTable_reservation.setSpacingAfter(10);
			myTable_reservation.setTotalWidth(new float[] { 50, 160 });

			PdfPCell cell_head = new PdfPCell(new Paragraph("Reservations. etc.", font10pt));
			cell_head.setColspan(2);
			// cell_admin.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_admin.setBackgroundColor(new BaseColor(140, 221, 8));
			myTable_reservation.addCell(cell_head);

			LocalDateTime localDateTime3 = LocalDateTime.parse(date_of_registration);
			String vs_date_of_registration = localDateTime3.format(formatter1);

			myTable_reservation.addCell(new PdfPCell(new Phrase(vs_date_of_registration, font10pt)));
			myTable_reservation
					.addCell(new PdfPCell(new Phrase(
							"Subject to the reservations, exceptions, restrictions, restrictivecovenants and conditions contained or referred to in a lease (a true copy of which is annexed to the Land Certificate) made between "
									+ grantors_name + " of the one part and " + ar_name + " of the other part. ",
							font10pt)));

			myTable_reservation.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_reservation.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_reservation);

			// Inserting Table in PDF
			PdfPTable myTable_land_certificate = new PdfPTable(4);
			myTable_land_certificate.setWidthPercentage(70);
			// Left aLign
			myTable_land_certificate.setTotalWidth((float) 300.0);
			;
			myTable_land_certificate.setHorizontalAlignment(0);
			myTable_land_certificate.setSpacingAfter(10);
			myTable_land_certificate.setTotalWidth(new float[] { 50, 50, 50, 50 });

			PdfPCell cell_land_certificate = new PdfPCell(
					new Paragraph("Land Certificate/Provisional Certificate", font10pt));

			cell_land_certificate.setColspan(4);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));

			myTable_land_certificate.addCell(cell_land_certificate);

			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Date of Issue", font10pt)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("To Whom Issued", font10pt)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Serial No.", font10pt)));
			myTable_land_certificate.addCell(new PdfPCell(new Phrase("Official Notes", font10pt)));

			// String json_data_land_certificate = "";
			if (json_lrd_certificate_section != "null") {
				JSONArray jArr_land_certificate = new JSONArray(json_lrd_certificate_section);
				for (int i = 0; i < jArr_land_certificate.length(); i++) {
					JSONObject obj_land_certificate = jArr_land_certificate.getJSONObject(i);

					LocalDateTime localDateTime4 = LocalDateTime
							.parse((String) obj_land_certificate.getString("cs_date_of_registration"));
					String cs_date_of_registration = localDateTime4.format(formatter1);

					myTable_land_certificate.addCell(new PdfPCell(new Phrase(cs_date_of_registration, font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							//new Phrase((String) obj_land_certificate.getString("cs_to_whom_issued"), font10pt)));
							new Phrase((String) obj_land_certificate.getString("cs_to_whom_issued"), font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							new Phrase((String) obj_land_certificate.getString("cs_serial_number"), font10pt)));
					myTable_land_certificate.addCell(new PdfPCell(
							new Phrase((String) obj_land_certificate.getString("cs_official_notes"), font10pt)));
				}
			}

			myTable_land_certificate.setSpacingBefore(5.0f); // Space Before
																// myTable_land_certificate
																// starts, like
																// margin-top in
																// CSS
			myTable_land_certificate.setSpacingAfter(5.0f); // Space After table
															// starts, like
															// margin-Bottom in
															// CSS
			document.add(myTable_land_certificate);

			// Inserting Table in PDF
			PdfPTable myTable_proprietors = new PdfPTable(10);
			myTable_proprietors.setWidthPercentage(100);
			// Left aLign
			myTable_proprietors.setTotalWidth((float) 300.0);
			;
			myTable_proprietors.setHorizontalAlignment(0);
			myTable_proprietors.setSpacingAfter(10);
			myTable_proprietors.setTotalWidth(new float[] { 50, 50, 90, 50, 50, 50, 90, 50, 50, 50 });

			PdfPCell cell_proprietors = new PdfPCell(new Paragraph("Proprietorship", font10pt));
			cell_proprietors.setColspan(10);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			myTable_proprietors.addCell(cell_proprietors);

			PdfPCell CellOneHdr_proprietors = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellOneHdr_proprietors);

			PdfPCell CellTwoHdr_proprietors = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTwoHdr_proprietors);

			PdfPCell CellTreeHdr_proprietors = new PdfPCell(
					new Paragraph("Proprietors (names addresses and descriptions)", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTreeHdr_proprietors);

			PdfPCell cell_interest = new PdfPCell(new Paragraph("Instruments Relevant to the Title", font10pt));
			cell_interest.setColspan(5);
			myTable_proprietors.addCell(cell_interest);

			PdfPCell CellNineHdr_proprietors = new PdfPCell(new Paragraph("Remark", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellNineHdr_proprietors);

			PdfPCell CellTenHdr_proprietors = new PdfPCell(new Paragraph("Signature of Registrar", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_proprietors.addCell(CellTenHdr_proprietors);

			PdfPCell EmptyCell_proprietors = new PdfPCell(new Paragraph("", font10pt));
			// EmptyCell_proprietors.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);
			EmptyCell_proprietors.setColspan(3);
			myTable_proprietors.addCell(EmptyCell_proprietors);
			// myTable_proprietors.addCell(EmptyCell_proprietors);
			// myTable_proprietors.addCell(EmptyCell_proprietors);

			PdfPCell CellFourHdr_proprietors = new PdfPCell(new Paragraph("Date of Instrument", font10pt));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellFourHdr_proprietors);

			PdfPCell CellFiveHdr_proprietors = new PdfPCell(new Paragraph("Nature of Instrument ", font10pt));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellFiveHdr_proprietors);

			PdfPCell CellSixHdr_proprietors = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellSixHdr_proprietors);

			PdfPCell CellSevenHdr_proprietors = new PdfPCell(new Paragraph("Parties", font10pt));
			/// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellSevenHdr_proprietors);

			PdfPCell CellEightHdr_proprietors = new PdfPCell(new Paragraph("Price Paid", font10pt));
			// CellOneHdr_proprietors.setRowspan(2);
			myTable_proprietors.addCell(CellEightHdr_proprietors);

			PdfPCell lastcell_proprietors = new PdfPCell(new Paragraph("", font10pt));
			// lastcell_proprietors.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);
			lastcell_proprietors.setColspan(2);
			myTable_proprietors.addCell(EmptyCell_proprietors);
			Integer NumberCount = 1;

			// String json_data_land_certificate = "";
			if (json_lrd_proprietorship_section != "null") {
				JSONArray jArr_proprietors = new JSONArray(json_lrd_proprietorship_section);
				for (int i = 0; i < jArr_proprietors.length(); i++) {
					JSONObject obj_proprietors = jArr_proprietors.getJSONObject(i);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
					myTable_proprietors.addCell(new PdfPCell(
							new Phrase((String) obj_proprietors.getString("ps_registration_number"), font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_proprietor"), font10pt)));

					LocalDateTime localDateTime5 = LocalDateTime
							.parse((String) obj_proprietors.getString("ps_date_of_instrument"));
					String ps_date_of_instrument = localDateTime5.format(formatter1);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(ps_date_of_instrument, font10pt)));
					myTable_proprietors.addCell(new PdfPCell(
							new Phrase((String) obj_proprietors.getString("ps_nature_of_instrument"), font10pt)));

					LocalDateTime localDateTime6 = LocalDateTime
							.parse((String) obj_proprietors.getString("ps_date_of_registration"));
					String ps_date_of_registration = localDateTime6.format(formatter1);

					myTable_proprietors.addCell(new PdfPCell(new Phrase(ps_date_of_registration, font10pt)));
					myTable_proprietors
							.addCell(new PdfPCell(new Phrase(
									(String) obj_proprietors.getString("ps_transferor") + " (1) "
											+ (String) obj_proprietors.getString("ps_transferee") + " (2) ",
									font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_price_paid"), font10pt)));
					myTable_proprietors.addCell(
							new PdfPCell(new Phrase((String) obj_proprietors.getString("ps_remarks"), font10pt)));

					Image image = Image.getInstance(software_file_location + "signature.jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image.scaleToFit(100.0F, 100.0F);
					// image.setAbsolutePosition(240, 710);
					// img3.setAutoScale(true);
					// document.add(image);

					// AddImage here
					myTable_proprietors.addCell(image);
					NumberCount += 1;
				}
			}

			myTable_proprietors.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_proprietors.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_proprietors);

			/*
			 * //Inserting Table in PDF PdfPTable myTable_memorials = new
			 * PdfPTable(9); myTable_memorials.setWidthPercentage(100); //Left
			 * aLign myTable_memorials.setTotalWidth((float) 300.0);;
			 * myTable_memorials.setHorizontalAlignment(0);
			 * myTable_memorials.setSpacingAfter(10);
			 * myTable_memorials.setTotalWidth(new float[]{ 25, 40,
			 * 40,50,140,20,20,50,50 });
			 * 
			 * PdfPCell EmptyCell_memorials = new PdfPCell(new
			 * Paragraph("",font10pt)); EmptyCell_memorials.setBorderWidth(0);
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * 
			 * 
			 * PdfPCell cell_memorials = new PdfPCell(new
			 * Paragraph("Leases, Charges, Encumbrances, etc. Affecting Land"
			 * ,font10pt)); cell_memorials.setColspan(9); //
			 * cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER
			 * ); // cell.setPadding(10.0f);
			 * //cell_land_certificate.setBackgroundColor(new BaseColor(140,
			 * 221, 8)); myTable_memorials.addCell(cell_memorials);
			 * 
			 * 
			 * PdfPCell CellOneHdr_memorials = new PdfPCell(new
			 * Paragraph("Entry No",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellOneHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellTwoHdr_memorials = new PdfPCell(new
			 * Paragraph("Date of Instrument.",font10pt)); //
			 * CellTwoHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellTwoHdr_memorials);
			 * 
			 * 
			 * 
			 * PdfPCell CellTreeHdr_memorials = new PdfPCell(new
			 * Paragraph("Date of Registration",font10pt)); //
			 * CellTreeHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellTreeHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellNineHdr_memorials = new PdfPCell(new
			 * Paragraph("Registered No.",font10pt));
			 * //cell_interest.setColspan(5);
			 * myTable_memorials.addCell(CellNineHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellTenHdr_memorials = new PdfPCell(new
			 * Paragraph("Memorials",font10pt));
			 * //CellNineHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellTenHdr_memorials);
			 * 
			 * 
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 * 
			 * 
			 * 
			 * PdfPCell CellFourHdr_memorials = new PdfPCell(new
			 * Paragraph("Remarks",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellFourHdr_memorials);
			 * 
			 * PdfPCell CellFiveHdr_memorials = new PdfPCell(new
			 * Paragraph("Signature of Registrar",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellFiveHdr_memorials);
			 * 
			 * 
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * 
			 * Integer NumberCount_memo = 1; //String json_data_land_certificate
			 * = ""; if(json_lrd_memorials_section != "null" ){ JSONArray
			 * jArr_memorials = new JSONArray(json_lrd_memorials_section); for
			 * (int i=0; i < jArr_memorials.length(); i++) { JSONObject
			 * obj_memorials = jArr_memorials.getJSONObject(i);
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase(NumberCount_memo.toString(),font10pt)));
			 * 
			 * LocalDateTime localDateTime7 =
			 * LocalDateTime.parse((String)obj_memorials.getString(
			 * "m_date_of_instrument")); String m_date_of_instrument =
			 * localDateTime7.format(formatter1);
			 * 
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase(m_date_of_instrument,font10pt)));
			 * 
			 * LocalDateTime localDateTime8 =
			 * LocalDateTime.parse((String)obj_memorials.getString(
			 * "m_date_of_registration")); String m_date_of_registration =
			 * localDateTime8.format(formatter1);
			 * 
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase(m_date_of_registration,font10pt)));
			 * 
			 * 
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase((String)obj_memorials.getString("m_registered_no"),
			 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase((String)obj_memorials.getString("m_memorials"),font10pt)))
			 * ;
			 * 
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase((String)obj_memorials.getString("m_back"),font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new Phrase("",font10pt)));
			 * NumberCount_memo += 1; } }
			 * 
			 * 
			 * 
			 * 
			 * 
			 * myTable_memorials.setSpacingBefore(5.0f); // Space Before table
			 * starts, like margin-top in CSS
			 * myTable_memorials.setSpacingAfter(5.0f); // Space After table
			 * starts, like margin-Bottom in CSS
			 * 
			 * 
			 * document.add(myTable_memorials);
			 */

			Paragraph p_2 = new Paragraph("Printed By", new Font(FontFamily.TIMES_ROMAN, 10));
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_2);

			document.close();
			//file.close();
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

	public byte[] create_smd_temp_barcode(String job_number)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		// request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		System.out.println(request_json.toString());

		// String case_records =
		// cls_case_management.select_log_who_generated_smd_temp_barcode(web_service_url,web_service_api_key,request_json.toString());

		// JSONObject case_obj;
		// case_obj = new JSONObject(case_records);

		/*
		 * String parcel_details = case_obj.get("parcel_details").toString();
		 * String transaction_details =
		 * case_obj.get("transaction_details").toString(); String job_detail =
		 * case_obj.get("job_detail").toString(); String
		 * json_lrd_memorials_section = (String)
		 * case_obj.getString("lrd_memorials_section");
		 */
		/*
		 * JSONObject parcel_details_obj; parcel_details_obj = new
		 * JSONObject(parcel_details); String glpin = (String)
		 * parcel_details_obj.get("glpin").toString(); String
		 * licensed_surveyor_number = (String)
		 * parcel_details_obj.get("licensed_no").toString(); String
		 * regional_number = (String)
		 * parcel_details_obj.get("regional_number").toString(); String locality
		 * = (String) parcel_details_obj.get("locality").toString(); String
		 * district = (String) parcel_details_obj.get("district").toString();
		 * String region = (String) parcel_details_obj.get("region").toString();
		 * String size_of_land = (String)
		 * parcel_details_obj.get("land_size").toString(); String extent =
		 * (String) parcel_details_obj.get("extent").toString(); String
		 * registry_mapref = (String)
		 * parcel_details_obj.get("registry_mapref").toString(); String plan_no
		 * = (String) parcel_details_obj.get("plan_no").toString(); String cc_no
		 * = (String) parcel_details_obj.get("cc_no").toString(); String
		 * ltr_plan_no = (String)
		 * parcel_details_obj.get("ltr_plan_no").toString(); String
		 * locality_class = (String)
		 * parcel_details_obj.get("locality_class").toString(); String
		 * registration_district_number = (String)
		 * parcel_details_obj.get("registration_district_number") .toString();
		 * String registration_section_number = (String)
		 * parcel_details_obj.get("registration_section_number").toString();
		 * String registration_block_number = (String)
		 * parcel_details_obj.get("registration_block_number").toString();
		 * 
		 * JSONObject transaction_details_obj; transaction_details_obj = new
		 * JSONObject(transaction_details); String ar_name = (String)
		 * transaction_details_obj.get("ar_name").toString(); String
		 * new_case_number = (String)
		 * transaction_details_obj.get("case_number").toString(); String
		 * date_of_document = (String)
		 * transaction_details_obj.get("date_of_document").toString(); String
		 * nature_of_instrument = (String)
		 * transaction_details_obj.get("nature_of_instrument").toString();
		 * String certificate_number = (String)
		 * transaction_details_obj.get("certificate_number").toString();
		 * 
		 * String type_of_interest = (String)
		 * transaction_details_obj.get("type_of_interest").toString(); String
		 * type_of_use = (String)
		 * transaction_details_obj.get("type_of_use").toString(); String
		 * volume_number = (String)
		 * transaction_details_obj.get("volume_number").toString(); String
		 * folio_number = (String)
		 * transaction_details_obj.get("folio_number").toString(); String term =
		 * (String) transaction_details_obj.get("term").toString(); String
		 * commencement_date = (String)
		 * transaction_details_obj.get("commencement_date").toString();
		 * 
		 * String renewal_term = (String)
		 * transaction_details_obj.get("renewal_term").toString(); String
		 * consideration_fee = (String)
		 * transaction_details_obj.get("consideration_fee").toString(); String
		 * stamp_duty_payable = (String)
		 * transaction_details_obj.get("stamp_duty_payable").toString(); String
		 * assessed_value = (String)
		 * transaction_details_obj.get("assessed_value").toString(); String
		 * parcel_description = (String)
		 * transaction_details_obj.get("parcel_description").toString(); String
		 * plot_number = (String)
		 * transaction_details_obj.get("plot_number").toString(); // String
		 * parcel_description = (String) //
		 * transaction_details_obj.get("plot_number").toString(); String
		 * publicity_date = (String)
		 * transaction_details_obj.get("publicity_date").toString();
		 * 
		 * String family_of_grantor = (String)
		 * transaction_details_obj.get("family_of_grantor").toString();
		 * 
		 * String rent_review_period = (String)
		 * transaction_details_obj.get("rent_review_period").toString(); String
		 * annual_rent = (String)
		 * transaction_details_obj.get("annual_rent").toString();
		 * 
		 * String rent_period_covered = (String)
		 * transaction_details_obj.get("rent_period_covered").toString(); String
		 * rent_review_date = (String)
		 * transaction_details_obj.get("rent_review_date").toString(); String
		 * date_of_first_payment = (String)
		 * transaction_details_obj.get("date_of_first_payment").toString();
		 * String outstanding_rent = (String)
		 * transaction_details_obj.get("outstanding_rent").toString(); String
		 * remark_or_comment = (String)
		 * transaction_details_obj.get("remark_or_comment").toString(); String
		 * date_of_registration = (String)
		 * transaction_details_obj.get("date_of_registration").toString();
		 * String case_status = (String)
		 * transaction_details_obj.get("case_status").toString(); String
		 * grantors_name = (String)
		 * transaction_details_obj.getString("grantors_name");
		 * 
		 * String stool_family_name = (String)
		 * transaction_details_obj.get("stool_family_name").toString(); //
		 * String is_part_of_gelis_area", //
		 * transaction_details_obj.get("is_part_of_gelis_area").toString();
		 * String stamp_duty_description = (String)
		 * transaction_details_obj.get("stamp_duty_description").toString();
		 * String certificate_type = (String)
		 * transaction_details_obj.get("certificate_type").toString(); String
		 * case_file_number = (String)
		 * transaction_details_obj.get("case_file_number").toString(); // String
		 * phone_number", // job_detail_obj.get("phone_number").toString();
		 * String case_process_stage = (String)
		 * transaction_details_obj.get("case_process_stage").toString();
		 * 
		 * JSONObject job_detail_obj; job_detail_obj = new
		 * JSONObject(job_detail); // String job_number = (String) job_number);
		 * String application_stage = (String)
		 * job_detail_obj.get("application_stage").toString();
		 * 
		 * System.out.println(job_detail_obj.get("application_stage").toString()
		 * ); String business_process_id = (String)
		 * job_detail_obj.get("business_process_id").toString(); String
		 * business_process_name = (String)
		 * job_detail_obj.get("business_process_name").toString(); String
		 * business_process_sub_id = (String)
		 * job_detail_obj.get("business_process_sub_id").toString(); String
		 * business_process_sub_name = (String)
		 * job_detail_obj.get("business_process_sub_name").toString();
		 * 
		 * String embossed = (String) job_detail_obj.get("embossed").toString();
		 * // String remark_or_comment = (String) //
		 * job_detail_obj.get("remark_or_comment").toString();
		 */
		ByteArrayOutputStream out = new ByteArrayOutputStream();

		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Barcode128 code128 = new Barcode128();
			code128.setCode(job_number);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(30, 750);
			code128Image.scalePercent(100);
			document.add(code128Image);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(490, 720);
			document.add(codeQrImage);

			/*
			 * BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(job_number,
			 * 1000, 1000, null); Image codeQrImage1 =
			 * barcodeQRCode1.getImage(); codeQrImage1.scaleAbsolute(80, 80);
			 * codeQrImage1.setAbsolutePosition(30, 720);
			 * document.add(codeQrImage1);
			 */

			document.close();
			//file.close();
		return out.toByteArray();

		} catch (Exception e) {
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

	public byte[] create_lc_lease_document(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		System.out.println(case_records);
		System.out.println(request_json.toString());
		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();
System.out.println(publicity_date);
		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();
		System.out.println(family_of_grantor);
		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("LEASE DOCUMENTS", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("THIS LEASE is made the 3rd day of September in the Year Two Thousand and Twenty-Four (2024) BETWEEN THE PRESIDENT OF THE REPUBLIC OF GHANA (hereinafter called \"the Lessor\" which expression shall where the context so admits or requires include his successors in office and his duly authorised officers and servants) acting by ALEX NII KWEITE QUAYNOR,  CHAIRMAN OF THE LANDS COMMISSION,  of the Republic of Ghana of the one part AND MICHAEL YAW ODONKOR of P. O. BOX 1234, ACCRA in the Greater Accra Region of the Republic of Ghana (hereinafter called \"the Lessee\" which expression shall where the context so admits or requires include their successors and assigns) of the other part: -", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk("	1. WHEREAS\n" + //
								"        a. The subject land forms part of the State Land measuring approximately 1335.96 acres acquired by the Government by virtue of Executive Instrument (E.I. 38) of 1976 as Site for Animal Research Institute at Katamanso/Frafraha of the Greater Accra Region of the Republic of Ghana.\n" + //
								"\n" + //
								"        b. The “Lessor” has been issued a Land Certificate number GA74186 dated 14th Day of August 2023 in respect of its freehold interest under the acquisition, which was registered at the Land Title Registry in Folio 1435 of Volume 019 of the Land Register.\n" + //
								"\n" + //
								"        c. Pursuant to an application for regularization by the Lessee, the Lessor has agreed to lease to the Lessee the land known as Plot No. 2 Block A situate at Katamanso/Frafraha subject to the terms and conditions herein contained.\n" + //
								"\n" + //
								"    2. NOW THEREFORE THIS LEASE WITNESSES as follows: -\n" + //
								"In consideration of the sum of Twenty-Eight Thousand, Eight Hundred and Sixty Cedis (GH¢28,860.00) and One Hundred and Twenty Thousand, Two Hundred Cedis (GH¢28,860.00)  paid by the Lessee to the Lessor as premium and compensation respectively (the receipt whereof the Lessor hereby acknowledges) and in further consideration of the payment of the ground rent hereinafter stated and the observance and performance of the covenants and conditions herein contained the Lessor HEREBY LEASES to the Lessee ALL THAT piece of land known as Plot No. 2 Block A containing an approximate area of 0.208 of an acre or 0.084 hectare situate at Katamanso/Frafraha in the Kpone-Katamanso Municipality in the Greater Accra Region of the Republic of Ghana TO HAVE and TO HOLD same unto the use of the Lessee for a term of Fifty (50) years with effect from the 1st day of January 2024 to the 3rd day of December, 2074 yielding and paying therefor unto the Lessor the Ground rent of Two Hundred and Forty Ghana Cedis (GH¢240.00) per annum payable yearly in advance on or before the 1st day of January in every year the payment for the period from 1st January 2019 to 31st December 2024 having been made on or before the execution of this lease PROVIDED that the rent hereby reserved shall be subject to revision by the Lessor every Fifth (5th) year of the term hereby granted or upon assignment or sublease of the whole site or a portion of it.\n" + //
								"\n" + //
								"    3. THE LESSEE HEREBY COVENANTS WITH THE LESSOR as follows.\n" + //
								"\n" + //
								"    a) To pay the ground rent at the times and in the manner aforesaid without any deduction whatsoever.\n" + //
								"\n" + //
								"    b) To pay interest on any rent arrears at the prevailing Bank of Ghana lending interest rate.\n" + //
								"\n" + //
								"    c) To bear pay and discharge all existing and future rates charges taxes duties assessments impositions and outgoing whatsoever imposed on the demised premises or upon any building or buildings thereon or imposed upon or payable by the occupier in respect thereof but in the event of the Lessor at any time hereafter by virtue of any statute judgment or otherwise being or becoming liable or responsible for the payment of all or any part of such rates taxes charges duties assessments impositions and outgoings as aforesaid or a contribution or other payment in lieu thereof then and in every such case the Lessee will pay to the Lessor on demand all moneys paid by the Lessor as rent in arrears.\n" + //
								"\n" + //
								"    d) Not to use or permit the use of the demised premises or any building or buildings thereon otherwise than for RESIDENTIAL Purposes Only.\n" + //
								"\n" + //
								"    e) To keep the demised premises together with all buildings thereon and all additions thereto and the walls fences vaults road drains compound and appurtenances thereof clean and in a good and substantial state of repair and condition.\n" + //
								"\n" + //
								"    f) To connect if so required by the Lessor the building or buildings erected upon the demised premises with the nearest water and electricity supply main and with the sewer where such exist or may eventually be installed.\n" + //
								"\n" + //
								"    g) Not to do or permit to be done upon the demised premises any act or thing which shall be or may become a nuisance damage annoyance or inconvenience to the Lessor or to the occupiers of any of the adjoining or neighbouring buildings or to the neighbourhood.\n" + //
								"\n" + //
								"    h) Not without the previous consent in writing of the Lessor to charge or mortgage at law or in equity assign underlet or part with possession of the demised premises or any part thereof or any building or buildings thereon or any interest therein.\n" + //
								"\n" + //
								"    i) To permit the Lessor and its officers at any time to enter upon the demised premises for the purposes of constructing laying down altering cleansing emptying or maintaining any sewers water-courses cesspools gutters drains water pipes or electric wires which the Lessor may consider necessary either for accommodation of any adjoining property or for any other purpose whatever doing as little damage as may be to the demised premises and restoring the surface of the soil and everything erected thereon without any unreasonable delay but without paying compensation for any damage or inconvenience to the Lessee. \n" + //
								"\n" + //
								"    j) To permit the Lessor and its agents at any reasonable time to enter upon the demised premises and any building or buildings thereon and examine the state of repair and condition thereof and to repair and make good within a reasonable time all defects for which the Lessee is responsible hereunder and of which notice in writing shall have been given by the Lessor to the Lessee.\n" + //
								"\n" + //
								"    k) To keep the building or buildings upon the demised premises insured against fire with a reputable Insurance Company in the Joint names of the parties hereto in the full value thereof and whenever required to produce to the Lessor the policy of Insurance and the receipt for the current year's premium and to cause all moneys received by virtue of such insurance to be forthwith laid out in rebuilding and reinstating the premises and to make up any deficiency out of the Lessee's own moneys and in case the Lessee shall make default in keeping such building or buildings so insured aforesaid the Lessor may do all things necessary to effect and maintain such insurance and all moneys expended by the Lessor for that purpose shall be repayable by the Lessee on demand and be recovered as rent in arrears.\n" + //
								"\n" + //
								"    l) The lease is entitled to automatic renewal subject to the original covenants contained in the lease herein and any new terms to be agreed upon by the parties or their successors, agents or assignees, taking into consideration any improvement of the land by the lessee as provided for in section 50 of the Land Act, 2020 (Act 1036).\n" + //
								"\n" + //
								"5. THE LESSOR HEREBY COVENANTS WITH THE LESSEE as follows:\n" + //
								"    a) That the Lessee paying the rent hereby reserved in the manner herein specified and observing and or performing the covenants and conditions herein contained shall peaceably and quietly hold and enjoy the demised land without any unlawful interference or disturbances whatsoever from or by the Lessor or any person or persons lawfully claiming from, under or in trust for it during the term hereby granted and any renewed term.\n" + //
								"    b) To observe and perform all the implied covenants under a lease for valuable consideration imposed upon the Lessor by the relevant provisions of the Land Act, 2020 (Act 1036).\n" + //
								"\n" + //
								"6. PROVIDED ALWAYS AND IT IS EXPRESSLY AGREED THAT:\n" + //
								"                    a) The ground rent of One Thousand One Hundred and Ten Ghana Cedis (GH¢1,100.00) hereby reserved and payable from the date as specified in commencement of this lease shall cease to be payable and a fully economic rent shall be payable if the Lessee shall assign sub-demise or part with possession of the said demised premises or any part thereof.\n" + //
								"\n" + //
								"                    b) If the yearly rent hereby reserved or any part thereof shall be in arrears for three (3) calendar months whether legally demanded or not or if the Lessee shall enter into liquidation whether compulsory or voluntary (not being merely a voluntary liquidation for the purpose of amalgamation or reconstruction) or if any assign not being a Corporation shall become bankrupt or shall file any petition under the insolvency Laws of Ghana or elsewhere or compound with his creditors or suffer any execution to be levied on his effects or if any of the covenants on the part of the Lessee shall not be duly performed and observed then and in any of the cases it shall be lawful for the Lessor to re-enter upon the said demised premises or any part thereof in the name of the whole and thereupon this demise shall absolutely determine but without prejudice to the rights of the Lessor in respect of any antecedent breach of any of the Lessee's covenants herein contained.\n" + //
								"\n" + //
								"                    c) If any part of the land or premises hereby demised falling within the road reservation line is required by Lessor for road widening or other purposes the Lessor shall have the right upon giving reasonable prior notice in writing to re-enter upon such land which shall thenceforward cease to form part of the land hereby demised without paying compensation but subject to the appropriate reconsideration of the rent to be thenceforward payable in respect of the remaining land hereby demised and subject to the Lessor carrying out such accommodational works as it considers necessary without cost to the occupiers.\n" + //
								"\n" + //
								"                    d) Nothing in this Lease contained shall be deemed either to convey or to dispense with the necessity of applying for and obtaining every such permit and authority as may be required by the Lessee in connection with any works or activities of whatsoever nature proposed to be carried out on the land hereby demised.\n" + //
								"", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					"SCHEDULE\n" + //
												"ALL THAT piece of land known as Plot 2 Block A and containing an approximate area of 0.208 of an acre or 0.084 hectare situate at Mataheko in the Accra Metropolis in the Greater Accra Region of the Republic of Ghana bounded on the North-West from pillar numbered SGGA B7295/19/6 to SGGA B7295/19/1 by Unnumbered Plot measuring a distance of 110.6 feet more or less on the North-East from pillar numbered SGGA B7295/19/1 to SGGA B7295/19/2 by Unnumbered Plot measuring a distance 79.8 feet more or less on the South-East from pillar numbered SGGA B7295/19/2 to SGGA B7295/19/3 by Road measuring a distance of 105.6 feet more or less on the South-West from pillar numbered SGGA B7295/19/3 to SGGA B7295/19/6 by Road measuring a distance of 91.3 feet more or less on which piece or parcel of land is more particularly delineated on Plan No. GA 007/22/AC 17482 attached hereto and thereon shew edged Pink. \n" + //
												"IN WITNESS WHEREOF the party hereto of the first part has hereunto set his hand and affixed the Seal of the Lands Commission of Ghana and the party hereto of the second part has hereunto set his hand the day and year first above written: -",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date);
			 * 
			 * 
			 * Month month_c = localDateTime.getMonth(); int day_c =
			 * localDateTime.getDayOfMonth(); int year_c =
			 * localDateTime.getYear();
			 */

			// Chunk st4 = new Chunk(" residue of a lease for a term of "+ term
			// + " years from the "+ day_c + " day of " + month_c + ", "+ year_c
			// + " subject to the", small);
			// st4.setTextRise(7);
			// p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being ", small);
			st7.setTextRise(7);
			p_2.add(st7);

			Chunk st8 = new Chunk("GLPIN No. " + glpin + ", " + registration_section_number + " "
					+ registration_block_number + ", situate at " + locality, small);
			st8.setTextRise(7);
			p_2.add(st8);

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated", small);
			st10.setTextRise(7);
			p_2.add(st10);

			/*
			 * Chunk st11 = new Chunk(" No. "+ registry_mapref +
			 * " in the Lands Commission, Cantonment Accra, and being the piece or"
			 * , small); st11.setTextRise(7); p_2.add(st11);
			 */

			Chunk st12 = new Chunk("SIGNED SEALED with the Seal of the\t\t}\n" + //
								"Lands Commission and DELIVERED by\t\t}  ……………………………..\n" + //
								"the said ALEX NII KWEITE QUAYNOR\t\t} ALEX NII KWEITE QUAYNOR for and on behalf of the PRESIDENT\t\t}\n" + //
								"OF THE REPUBLIC OF GHANA in the\t\t}\n" + //
								"presence of:-\n" + //
								"\n" + //
								"NAME: ………………………………………….\n" + //
								"ADDRESS…………………………………\n" + //
								"SIGNATURE: ................................................" + plan_no, small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" Signed and Delivered by the said within-named\t}\n" + //
								"LESSEE JAMES ELIJAH DONKOH\t\t}   ………………………………\n" + //
								"in the presence of-\t\t\t\t\t}    JAMES ELIJAH DONKOH\n" + //
								"\n" + //
								"\n" + //
								"NAME: …………………………………………….\n" + //
								"ADDRESS: ……………………………………….\n" + //
								"SIGNATURE: ……………………………………..\n" + //
								"TELEPHONE NO.: ……………………………….\n" + //
								"",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" OATH OF PROOF\n" + //
								"\n" + //
								"I, \t\t\t of Lands Commission, Accra make Oath and say that on the \t\tof \t\t\t 2024, I was present and saw ALEX NII KWEITE QUAYNOR duly execute the Instrument now produced to me and marked \"A” and that the said ALEX NII KWEITE QUAYNOR can read and write: -\n" + //
								"\n" + //
								"Sworn in Accra this \tday of \t\t2024}\n" + //
								"Deponent\n" + //
								"\n" + //
								"\n" + //
								"\n" + //
								"REGISTRAR OF LANDS:\n" + //
								"\n" + //
								"\n" + //
								"\n" + //
								"\n" + //
								"CERTIFICATE OF-PROOF\n" + //
								"On the\tday of\t\t\t2024\t\t at\t\t\t o'clock in the \t\tnoon this Instrument was proved before me by the Oath of the within-named to have been duly executed by the within-named ALEX NII KWEITE QUAYNOR.\n" + //
								"\n" + //
								"\n" + //
								"REGISTRAR OF LANDS\n" + //
								"\n" + //
								"\n" + //
								"\n" + //
								"This is the Instrument Marked “A” referred to In e Oath of \t\t\t\t\t Sworn Before me, this\t\t day of\t\t\t\t\t2024\n" + //
								"\n" + //
								"\n" + //
								"REGISTRAR OF LANDS\n" + //
								"",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			Chunk st16 = new Chunk(" L.S. No ................................................................ .\n" + //
								"Regn. No .. .. .......... ........ ...... ....... ............ ........... .... .\n" + //
								"Dated ....................................................... 20......... •\n" + //
								"----------------------------------------------------------------------------\n" + //
								"PRESIDENT OF THE REPUBLIC OF GHANA\n" + //
								"\n" + //
								"AND\n" + //
								"!\n" + //
								"JAMES ELIJAH DONKOH \n" + //
								"------------------------------------------------------------------------------\n" + //
								"RESIDENTIAL LEASE\n" + //
								"In respect of Plot No. 2 Block A\n" + //
								"Katamanso/Frafraha - Accra\n" + //
								"------------------------------------ ---------------------------------------------\n" + //
								"Term:\t\t\tFifty (50) years\n" + //
								"\n" + //
								"Commences:\t1st January, 2024\n" + //
								"\n" + //
								"Expires:\t\t31st December, 2073\n" + //
								"\n" + //
								"Rent:\t\t\tGh¢:240.00\n" + //
								"\n" + //
								"Job No: \t\tLS10022452023\n" + //
								"\n" + //
								"Plan No.: \t\t576/2024",
					small);
					st16.setTextRise(7);
			p_2.add(st16);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.close();
			//file.close();
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

	public byte[] create_concurrence_certificate(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException, ParseException {
			JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("CONCURRENCE CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("I ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(web_chairman_regional_land_commission, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(" CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS ", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					"  acting for and on behalf of the Lands commission hereby certify that I concur to the disposal of right and interest in the land evidenced by the within-written document subject to the conditions set out in the schedule hereunder:-\n"
							+ "SCHEDULE ABOVE REFERRED TO\n"
							+ "\n"
							+ "The rent payable under the lease shall be paid to the Administrator of Stool Lands or his duly authorized agent.\n"
							+ "The rent mentioned in the within-written document shall be subject to revision every fifth (5 th ) year of the term.\n"
							+ "That no development shall be undertaken on the land until the lessee has obtained building and development permits from the\n"
							+ "Statutory Planning	Committee of the Metropolitan/Municipal/District Assembly.\n"
							+ "	Dated this	        day of 	     20\n"
							+ "",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date);
			 * 
			 * 
			 * Month month_c = localDateTime.getMonth(); int day_c =
			 * localDateTime.getDayOfMonth(); int year_c =
			 * localDateTime.getYear();
			 */

			// Chunk st4 = new Chunk(" residue of a lease for a term of "+ term
			// + " years from the "+ day_c + " day of " + month_c + ", "+ year_c
			// + " subject to the", small);
			// st4.setTextRise(7);
			// p_2.add(st4);

			Chunk st5 = new Chunk(" SCHEDULE ABOVE REFERRED TO:", small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(
					" (1)	The rent payable under the lease shall be paid to the Administrator of Stool Lands or her duly authorized agent:",
					small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(
					" (2)	The rent reserved under the Lease herein shall be One Hundred and Twenty Ghana Cedis (GHS 120.00) per annum subject to revision every fifth (5th) year of the term. ",
					small);
			st7.setTextRise(7);
			p_2.add(st7);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS COMMISSION ";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			// document.add(p_3);

			Paragraph p_3_1 = new Paragraph("File No. 32000/117/2019", new Font(FontFamily.TIMES_ROMAN, 12));
			p_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3_1.setLeading(32);
			document.add(p_3_1);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.close();
			//file.close();
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

	public byte[] create_consent_certificate(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException, ParseException {
	
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("CONSENT CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("I ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(web_chairman_regional_land_commission, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(" CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS ", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					" acting for and on behalf of the regional Lands Commission hereby consent to a sublease by sic insurance company limited with its registered office at No. 28/29 Ring Road East Osu � Accra and of P.O BOX LG822, Legon � Accra of all its rights and interest in ALL THAT PIECE OR PARCEL of land known as Unit No. 39,  Block 8, Section 160 ",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date);
			 * 
			 * 
			 * Month month_c = localDateTime.getMonth(); int day_c =
			 * localDateTime.getDayOfMonth(); int year_c =
			 * localDateTime.getYear();
			 */

			// Chunk st4 = new Chunk(" residue of a lease for a term of "+ term
			// + " years from the "+ day_c + " day of " + month_c + ", "+ year_c
			// + " subject to the", small);
			// st4.setTextRise(7);
			// p_2.add(st4);

			Chunk st5 = new Chunk(
					" containing an approximate area of 0.325 of an acre being a portion of an Unnumbered Plot situate at Greenhill, Legon � Accra, in the Greater Accra Region of the Republic of Ghana demised by a Lease dated the 10th day of January 1995 and made between the Government of the Republic of Ghana of the one part and the Sublessor herein of the other part of a term of Ninety � nine (99) years with effect from the 21st day of November, 1986 and it is being subleased to the Sublessee herein for the term of Fifty (50) ",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(
					"years with effect from the 1st day of September,1998 SUBJECT nevertheless to the payment of the revised ground rent reserved in the head lease and observance and performance of the Covenants contained in the said Lease reserved and on the part of the Lessee to be observed and performed PROVIDED ALWAYS THAT this Consent is restricted to the particular Sublease hereby authorized and save as aforesaid the covenant in the said Lease contained against mortgaging assigning under � letting or parting with possession shall remain in full force and effect.   ",
					small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(
					" Dated and sealed with Seal of the Greater Accra Regional Lands Commission this 26th day of March, 2020",
					small);
			st7.setTextRise(7);
			p_2.add(st7);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS COMMISSION ";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			// document.add(p_3);

			Paragraph p_3_1 = new Paragraph("File No. 32000/117/2019", new Font(FontFamily.TIMES_ROMAN, 12));
			p_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3_1.setLeading(32);
			document.add(p_3_1);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();
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

	public byte[] create_concurrence_certificate1(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("LEASE DOCUMENTS", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("THIS IS TO CERTIFY THAT ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(" of Accra in the Greater Accra Region", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					" of the Republic of Ghana is registered as proprietor of an estate of freehold subject to the",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date);
			 * 
			 * 
			 * Month month_c = localDateTime.getMonth(); int day_c =
			 * localDateTime.getDayOfMonth(); int year_c =
			 * localDateTime.getYear();
			 */

			// Chunk st4 = new Chunk(" residue of a lease for a term of "+ term
			// + " years from the "+ day_c + " day of " + month_c + ", "+ year_c
			// + " subject to the", small);
			// st4.setTextRise(7);
			// p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being ", small);
			st7.setTextRise(7);
			p_2.add(st7);

			Chunk st8 = new Chunk("GLPIN No. " + glpin + ", " + registration_section_number + " "
					+ registration_block_number + ", situate at " + locality, small);
			st8.setTextRise(7);
			p_2.add(st8);

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated", small);
			st10.setTextRise(7);
			p_2.add(st10);

			/*
			 * Chunk st11 = new Chunk(" No. "+ registry_mapref +
			 * " in the Lands Commission, Cantonment Accra, and being the piece or"
			 * , small); st11.setTextRise(7); p_2.add(st11);
			 */

			Chunk st12 = new Chunk(" and edged with pink color on Survey Plan No. " + plan_no, small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" annexed to this Certificate except and reserved all minerals, oils, precious",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" stones and timber whatsoever upon or under the said piece or parcel of land.",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.close();
			//file.close();
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

	public byte[] create_primeval_report(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String output_file)
			throws IOException, SQLException, JSONException {

		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		String case_records = cls_case_management
				.select_ds_farm_inspection_format_all(web_service_url,
						web_service_api_key);
		// String crop_details =
		// cls_case_management.select_ds_crop_details_all_by_item_code(case_number);

		JSONObject obj = new JSONObject(case_records);
		String main_details = (String) obj.getString("data");

		/*
		 * String term = (String)obj_main.getString("term"); String
		 * commencement_date = (String)obj_main.getString("commencement_date");
		 * String renewal_term = (String)obj_main.getString("renewal_term");
		 * String consideration_fee =
		 * (String)obj_main.getString("consideration_fee"); String
		 * stamp_duty_payable =
		 * (String)obj_main.getString("stamp_duty_payable"); String
		 * assessed_value = (String)obj_main.getString("assessed_value"); String
		 * parcel_description =
		 * (String)obj_main.getString("parcel_description"); String plot_number
		 * = (String)obj_main.getString("plot_number"); String publicity_date =
		 * (String)obj_main.getString("publicity_date"); String plan_no =
		 * (String)obj_main.getString("plan_no"); String date_of_registration =
		 * (String)obj_main.getString("date_of_registration"); String
		 * grantors_name = (String)obj_main.getString("grantors_name");
		 */

		/*
		 * fit_id, name_of_farmer, farmer_phone_no, farmer_postal_addres,
		 * farmer_email, farmer_sex, farmer_age, id_type, id_number,
		 * name_of_contact_person, phone_of_contact_person, farmer_photo,
		 * signature_photo, item_code, date_of_inspection, batch_no, district,
		 * town_site_location, road_route, road_route_side, chainage_km,
		 * template_type, names_of_adjoining_farmers_lhs,
		 * names_of_adjoining_farmers_rhs, dimention_length, dimention_breadth,
		 * dimention_area, gps_coordinates, type_of_farming,
		 * classification_of_crop, animal_farm_keeping, specify_type_of_animal,
		 * structure_description, charcoal_burning, palm_wine_tapping,
		 * other_specify, comments, name_of_enumerator, falls_within,
		 * land_owners_name, crop_farmed_area_15, created_by, created_by_id,
		 * created_date, modified_by, modified_by_id, modified_date,
		 * year_created
		 */

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 30, 50);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 * 
			 * BarcodeQRCode barcodeQRCode = new BarcodeQRCode(item_code, 1000,
			 * 1000, null); Image codeQrImage = barcodeQRCode.getImage();
			 * codeQrImage.scaleAbsolute(100, 100);
			 * codeQrImage.setAbsolutePosition(40,720);
			 * document.add(codeQrImage);
			 * 
			 * 
			 * /* Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(120.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			/*
			 * farmer_postal_addres, farmer_email, , , id_type, id_number, ,
			 * phone_of_contact_person, item_code, , district,
			 * town_site_location, , classification_of_crop
			 * 
			 */

			// String IMG_farmer = "";

			// JSONObject obj_main = new JSONObject(main_details);
			// String new_case_number =
			// (String)obj_main.getString("case_number");

			JSONArray jArr = new JSONArray(main_details);
			for (int i = 0; i < jArr.length(); i++) {
				JSONObject obj_main = jArr.getJSONObject(i);
				// Toast.makeText(getApplicationContext(),obj.toString(),Toast.LENGTH_SHORT).show();

				// String ar_name = (String)obj_main.getString("ar_name");

				document.add(new Phrase(Chunk.NEWLINE));

				Paragraph p_1 = new Paragraph(
						"REVIEW OF DETAILED DESIGN STUDY OF THE CONSTRUCTION OF A NEW BRIDGE ACROSS THE VOLTA RIVER ON THE EASTERN CORRIDOR",
						new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_1.setAlignment(Element.ALIGN_CENTER);
				document.add(p_1);

				Paragraph p_1_E = new Paragraph("VALUATION SHEET", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_1_E.setAlignment(Element.ALIGN_CENTER);
				document.add(p_1_E);

				// document.add(new Phrase(Chunk.NEWLINE));

				String fit_id = (String) obj_main.getString("fit_id");
				String name_of_farmer = (String) obj_main.getString("name_of_farmer");
				String farmer_phone_no = (String) obj_main.getString("farmer_phone_no");
				String farmer_postal_addres = (String) obj_main.getString("farmer_postal_addres");
				String farmer_email = (String) obj_main.getString("farmer_email");
				String farmer_sex = (String) obj_main.getString("farmer_sex");
				String farmer_age = (String) obj_main.getString("farmer_age");
				String id_type = (String) obj_main.getString("id_type");
				String id_number = (String) obj_main.getString("id_number");
				String name_of_contact_person = (String) obj_main.getString("name_of_contact_person");
				String phone_of_contact_person = (String) obj_main.getString("phone_of_contact_person");
				String item_code = (String) obj_main.getString("item_code");
				String date_of_inspection = (String) obj_main.getString("date_of_inspection");
				String district = (String) obj_main.getString("district");
				String town_site_location = (String) obj_main.getString("town_site_location");
				String type_of_farming = (String) obj_main.getString("type_of_farming");
				String classification_of_crop = (String) obj_main.getString("classification_of_crop");
				String other_specify = (String) obj_main.getString("other_specify");
				String dimention_area = (String) obj_main.getString("dimention_area");
				String code = (String) obj_main.getString("code");

				String IMG_farmer = "C:\\gelisdocs\\" + code + ".jpg";
				// String Path = code +".jpg";
				// String IMG_farmer = "C:\\gelisdocs\\D001.jpg";
				// String IMG_farmer = "C:\\gelisdocs\\"+Path;

				System.out.println("path");
				System.out.println(IMG_farmer);
				Image image1 = Image.getInstance(IMG_farmer);
				// imgPDF2.ScaleToFit(100.0F, 70.0F)
				image1.scaleToFit(250.0F, 250.0F);
				image1.setAbsolutePosition(320, 540);
				document.add(image1);

				BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
				PdfContentByte cbaddress = writer.getDirectContent();
				cbaddress.beginText();
				cbaddress.setFontAndSize(bfaddress, 12);

				cbaddress.setTextMatrix(70, 700);
				cbaddress.showText(name_of_farmer.toUpperCase());

				cbaddress.setTextMatrix(70, 680);
				cbaddress.showText("Sex:  " + farmer_sex);

				cbaddress.setTextMatrix(190, 680);
				cbaddress.showText("Age:  " + farmer_age);

				cbaddress.setTextMatrix(70, 660);
				cbaddress.showText("Vulnerability:   " + "No");

				cbaddress.setTextMatrix(190, 660);
				cbaddress.showText("Phone #: " + farmer_phone_no);

				cbaddress.setTextMatrix(70, 500);
				cbaddress.showText("Farm Code: " + code);

				cbaddress.setTextMatrix(200, 500);
				cbaddress.showText("Contact Person: " + name_of_contact_person.toUpperCase());

				cbaddress.setTextMatrix(430, 500);
				cbaddress.showText("Farm Size: " + dimention_area);

				cbaddress.setTextMatrix(70, 480);
				cbaddress.showText("Location: " + town_site_location);

				cbaddress.setTextMatrix(280, 480);
				cbaddress.showText("Other Activities:  " + other_specify);

				/*
				 * cbaddress.setTextMatrix(400, 520);
				 * cbaddress.showText("Farm Size:     " + "0.45");
				 */

				cbaddress.setTextMatrix(70, 460);
				cbaddress.showText("Date of Inspection :     " + date_of_inspection);

				cbaddress.setTextMatrix(280, 460);
				cbaddress.showText("Method of Farming:     " + type_of_farming);

				/*
				 * cbaddress.setTextMatrix(400, 540);
				 * cbaddress.showText("Farm Size:     " + "0.45");
				 */

				cbaddress.endText();

				// PdfPage pdfPage = document.addNewPage();

				PdfContentByte canvas = writer.getDirectContent();
				canvas.moveTo(20, 420);
				canvas.lineTo(580, 420);

				canvas.moveTo(20, 520);
				canvas.lineTo(580, 520);
				canvas.closePathStroke();

				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));

				// Get the current date and time
				LocalDateTime currentTime = LocalDateTime.now();
				System.out.println("Current DateTime: " + currentTime);

				LocalDate date1 = currentTime.toLocalDate();
				System.out.println("Date : " + date1);

				Month month = currentTime.getMonth();
				int day = currentTime.getDayOfMonth();
				int year = currentTime.getYear();

				// System.out.println("Month : " + month);
				// System.out.println("Day : " + day);
				// System.out.println("Seconds : " + seconds);

				/*
				 * String cert_text2 =""; cert_text2 +=
				 * "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the"
				 * ; cert_text2 += " Lands Commission this "+ day + " day of " +
				 * month + ", "+ year + ".";
				 * 
				 * 
				 * Paragraph p_3 = new Paragraph(cert_text2, new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_3.setAlignment(Element.ALIGN_JUSTIFIED);
				 * p_3.setLeading(32); document.add(p_3);
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE));
				 * 
				 * Paragraph p_4 = new
				 * Paragraph(".......................................", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
				 * 
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE));
				 * 
				 * Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ",
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
				 */
				// document.newPage();

				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));

				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));
				document.add(new Phrase(Chunk.NEWLINE));

				/*
				 * Paragraph p_6 = new Paragraph("MEMORIALS", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_6.setAlignment(Element.ALIGN_CENTER); document.add(p_6);
				 */

				// String new_case_number =
				// (String)obj_main_data.getString("item_code");
				// Inserting Table in PDF
				PdfPTable myTable_memorials = new PdfPTable(6);
				myTable_memorials.setWidthPercentage(100);
				// Left aLign
				myTable_memorials.setTotalWidth((float) 300.0);
				;
				myTable_memorials.setHorizontalAlignment(0);
				myTable_memorials.setSpacingAfter(10);
				myTable_memorials.setTotalWidth(new float[] { 100, 100, 100, 100, 100, 100 });

				PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
				EmptyCell_memorials.setBorderWidth(0);
				// CellOneHdr_proprietors.setRowspan(2);

				PdfPCell cell_memorials = new PdfPCell(new Paragraph("Details of Crops", font10pt));
				cell_memorials.setColspan(6);
				// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
				// cell.setPadding(10.0f);
				// cell_land_certificate.setBackgroundColor(new BaseColor(140,
				// 221, 8));
				myTable_memorials.addCell(cell_memorials);

				PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Category", font10pt));
				// CellOneHdr_proprietors.setRowspan(1);
				myTable_memorials.addCell(CellOneHdr_memorials);

				PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Typr of Crop", font10pt));
				// CellTwoHdr_proprietors.setRowspan(1);
				myTable_memorials.addCell(CellTwoHdr_memorials);

				PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Crop Stage", font10pt));
				// CellTreeHdr_proprietors.setRowspan(1);
				myTable_memorials.addCell(CellTreeHdr_memorials);

				PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Crop Area", font10pt));
				// cell_interest.setColspan(5);
				myTable_memorials.addCell(CellNineHdr_memorials);

				PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Cropr Rate", font10pt));
				// CellNineHdr_proprietors.setRowspan(1);
				myTable_memorials.addCell(CellTenHdr_memorials);

				PdfPCell cell_folio_reference = new PdfPCell(new Paragraph("Crop value GHS", font10pt));
				// CellTenHdr_proprietors.setRowspan(1);
				// cell_folio_reference.setColspan(2);
				myTable_memorials.addCell(cell_folio_reference);

				/*
				 * Integer NumberCount_memo = 1; //String
				 * json_data_land_certificate = "";
				 * if(json_lrd_memorials_section != "null" ){ JSONArray
				 * jArr_memorials = new JSONArray(json_lrd_memorials_section);
				 * for (int i=0; i < jArr_memorials.length(); i++) { JSONObject
				 * obj_memorials = jArr_memorials.getJSONObject(i);
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase(NumberCount_memo.toString(),font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_date_of_instrument"
				 * ),font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString(
				 * "m_date_of_registration"),font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_registered_no"),
				 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_memorials"),
				 * font10pt)));
				 * 
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_back"),font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_forward"),font10pt)
				 * )); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("m_remarks"),font10pt)
				 * )); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("",font10pt))); NumberCount_memo += 1; } }
				 */

				String crop_details = cls_case_management
						.select_ds_crop_details_all_by_item_code(web_service_url,
								web_service_api_key, item_code);

				JSONObject obj_crop_details = new JSONObject(crop_details);
				String crop_details_data = (String) obj_crop_details.getString("data");
				// JSONObject obj_main_data = new JSONObject(crop_details_data);

				System.out.println("New Data");
				System.out.println(crop_details_data);
				if (crop_details_data != "null") {
					JSONArray jArr_memorials = new JSONArray(crop_details_data);
					for (int J = 0; J < jArr_memorials.length(); J++) {
						JSONObject obj_memorials = jArr_memorials.getJSONObject(J);

						myTable_memorials.addCell(
								new PdfPCell(new Phrase((String) obj_memorials.getString("crop_category"), font10pt)));
						myTable_memorials.addCell(
								new PdfPCell(new Phrase((String) obj_memorials.getString("type_of_crop"), font10pt)));
						myTable_memorials.addCell(
								new PdfPCell(new Phrase((String) obj_memorials.getString("stage_of_crop"), font10pt)));
						myTable_memorials.addCell(new PdfPCell(new Phrase(
								(String) obj_memorials.getString("crop_area_coverage_pecentage"), font10pt)));
						myTable_memorials.addCell(
								new PdfPCell(new Phrase((String) obj_memorials.getString("estimated_area"), font10pt)));
						myTable_memorials.addCell(
								new PdfPCell(new Phrase((String) obj_memorials.getString("estimated_area"), font10pt)));
						// NumberCount_memo += 1;
					}
				}

				/*
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("FOOD CROP",font10pt))); myTable_memorials.addCell(new
				 * PdfPCell(new Phrase("YAM",font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("MATURED",font10pt))); myTable_memorials.addCell(new
				 * PdfPCell(new Phrase("0.0200 ",font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("400.00",font10pt))); myTable_memorials.addCell(new
				 * PdfPCell(new Phrase("334.00",font10pt)));
				 */

				/*
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("",font10pt))); myTable_memorials.addCell(new
				 * PdfPCell(new Phrase("",font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("",font10pt))); myTable_memorials.addCell(new
				 * PdfPCell(new Phrase(" ",font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("GRAND TOTAL",font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase("450.00",font10pt)));
				 */

				myTable_memorials.setSpacingBefore(5.0f); // Space Before table
															// starts, like
															// margin-top in CSS
				myTable_memorials.setSpacingAfter(5.0f); // Space After table
															// starts, like
															// margin-Bottom in
															// CSS

				document.add(myTable_memorials);

				Paragraph p_4 = new Paragraph("Date of Payment : ..............................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				p_4.setAlignment(Element.ALIGN_LEFT);
				document.add(p_4);

				// document.add(new Phrase(Chunk.NEWLINE));

				Paragraph p_5 = new Paragraph("Mode Of Payment: Cash......     Cheque.......",
						new Font(FontFamily.TIMES_ROMAN, 12));
				p_5.setAlignment(Element.ALIGN_LEFT);
				document.add(p_5);

				Paragraph p_50 = new Paragraph("Cheque No..........", new Font(FontFamily.TIMES_ROMAN, 12));
				p_50.setAlignment(Element.ALIGN_LEFT);
				document.add(p_50);

				Paragraph p7 = new Paragraph("Witness Name: ", new Font(FontFamily.TIMES_ROMAN, 12));
				p7.setAlignment(Element.ALIGN_RIGHT);
				document.add(p7);

				Paragraph p_8 = new Paragraph("...............................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				p_8.setAlignment(Element.ALIGN_LEFT);
				document.add(p_8);

				Paragraph p_12 = new Paragraph("........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				p_12.setAlignment(Element.ALIGN_RIGHT);
				document.add(p_12);

				Paragraph p_9 = new Paragraph("SIGNATURE/THUMBPRINT", new Font(FontFamily.TIMES_ROMAN, 12));
				p_9.setAlignment(Element.ALIGN_LEFT);
				document.add(p_9);

				Paragraph p_13 = new Paragraph("SIGNATURE/THUMBPRINT", new Font(FontFamily.TIMES_ROMAN, 12));
				p_13.setAlignment(Element.ALIGN_RIGHT);
				document.add(p_13);

				Paragraph p_10 = new Paragraph("ASSIAMAH KORANKYE JOHN", new Font(FontFamily.TIMES_ROMAN, 12));
				p_10.setAlignment(Element.ALIGN_LEFT);
				document.add(p_10);

				Paragraph p_11 = new Paragraph("CERTIFIED VALUER :HELEN ARTHUR (MRS) MGhIS",
						new Font(FontFamily.TIMES_ROMAN, 12));
				p_11.setAlignment(Element.ALIGN_LEFT);
				document.add(p_11);

				document.newPage();

			}

			document.close();
			//file.close();
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

	public byte[] create_lvd_comparable_report(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String output_file)
			throws IOException, SQLException, JSONException {


		String case_records = cls_case_management
				.select_ds_farm_inspection_format_all(web_service_url,
						web_service_api_key);
		// String crop_details =
		// cls_case_management.select_ds_crop_details_all_by_item_code(case_number);

		JSONObject obj = new JSONObject(case_records);
		String main_details = (String) obj.getString("data");

		/*
		 * String term = (String)obj_main.getString("term"); String
		 * commencement_date = (String)obj_main.getString("commencement_date");
		 * String renewal_term = (String)obj_main.getString("renewal_term");
		 * String consideration_fee =
		 * (String)obj_main.getString("consideration_fee"); String
		 * stamp_duty_payable =
		 * (String)obj_main.getString("stamp_duty_payable"); String
		 * assessed_value = (String)obj_main.getString("assessed_value"); String
		 * parcel_description =
		 * (String)obj_main.getString("parcel_description"); String plot_number
		 * = (String)obj_main.getString("plot_number"); String publicity_date =
		 * (String)obj_main.getString("publicity_date"); String plan_no =
		 * (String)obj_main.getString("plan_no"); String date_of_registration =
		 * (String)obj_main.getString("date_of_registration"); String
		 * grantors_name = (String)obj_main.getString("grantors_name");
		 */

		/*
		 * fit_id, name_of_farmer, farmer_phone_no, farmer_postal_addres,
		 * farmer_email, farmer_sex, farmer_age, id_type, id_number,
		 * name_of_contact_person, phone_of_contact_person, farmer_photo,
		 * signature_photo, item_code, date_of_inspection, batch_no, district,
		 * town_site_location, road_route, road_route_side, chainage_km,
		 * template_type, names_of_adjoining_farmers_lhs,
		 * names_of_adjoining_farmers_rhs, dimention_length, dimention_breadth,
		 * dimention_area, gps_coordinates, type_of_farming,
		 * classification_of_crop, animal_farm_keeping, specify_type_of_animal,
		 * structure_description, charcoal_burning, palm_wine_tapping,
		 * other_specify, comments, name_of_enumerator, falls_within,
		 * land_owners_name, crop_farmed_area_15, created_by, created_by_id,
		 * created_date, modified_by, modified_by_id, modified_date,
		 * year_created
		 */

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 30, 50);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 * 
			 * BarcodeQRCode barcodeQRCode = new BarcodeQRCode(item_code, 1000,
			 * 1000, null); Image codeQrImage = barcodeQRCode.getImage();
			 * codeQrImage.scaleAbsolute(100, 100);
			 * codeQrImage.setAbsolutePosition(40,720);
			 * document.add(codeQrImage);
			 * 
			 * 
			 * /* Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(120.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			/*
			 * farmer_postal_addres, farmer_email, , , id_type, id_number, ,
			 * phone_of_contact_person, item_code, , district,
			 * town_site_location, , classification_of_crop
			 * 
			 */

			// String IMG_farmer = "";

			// JSONObject obj_main = new JSONObject(main_details);
			// String new_case_number =
			// (String)obj_main.getString("case_number");

			JSONArray jArr = new JSONArray(main_details);
			for (int i = 0; i < jArr.length(); i++) {
				JSONObject obj_main = jArr.getJSONObject(i);
				// Toast.makeText(getApplicationContext(),obj.toString(),Toast.LENGTH_SHORT).show();

				// String ar_name = (String)obj_main.getString("ar_name");

				document.add(new Phrase(Chunk.NEWLINE));

				Paragraph p_1 = new Paragraph(
						"REVIEW OF DETAILED DESIGN STUDY OF THE CONSTRUCTION OF A NEW BRIDGE ACROSS THE VOLTA RIVER ON THE EASTERN CORRIDOR",
						new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_1.setAlignment(Element.ALIGN_CENTER);
				document.add(p_1);

				Paragraph p_1_E = new Paragraph("VALUATION SHEET", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_1_E.setAlignment(Element.ALIGN_CENTER);
				document.add(p_1_E);

				// document.add(new Phrase(Chunk.NEWLINE));

				String fit_id = (String) obj_main.getString("fit_id");
				String name_of_farmer = (String) obj_main.getString("name_of_farmer");
				String farmer_phone_no = (String) obj_main.getString("farmer_phone_no");
				String farmer_postal_addres = (String) obj_main.getString("farmer_postal_addres");
				String farmer_email = (String) obj_main.getString("farmer_email");
				String farmer_sex = (String) obj_main.getString("farmer_sex");
				String farmer_age = (String) obj_main.getString("farmer_age");
				String id_type = (String) obj_main.getString("id_type");
				String id_number = (String) obj_main.getString("id_number");
				String name_of_contact_person = (String) obj_main.getString("name_of_contact_person");
				String phone_of_contact_person = (String) obj_main.getString("phone_of_contact_person");
				String item_code = (String) obj_main.getString("item_code");
				String date_of_inspection = (String) obj_main.getString("date_of_inspection");
				String district = (String) obj_main.getString("district");
				String town_site_location = (String) obj_main.getString("town_site_location");
				String type_of_farming = (String) obj_main.getString("type_of_farming");
				String classification_of_crop = (String) obj_main.getString("classification_of_crop");
				String other_specify = (String) obj_main.getString("other_specify");
				String dimention_area = (String) obj_main.getString("dimention_area");
				String code = (String) obj_main.getString("code");

				String IMG_farmer = "C:\\gelisdocs\\" + code + ".jpg";
				// String Path = code +".jpg";
				// String IMG_farmer = "C:\\gelisdocs\\D001.jpg";
				// String IMG_farmer = "C:\\gelisdocs\\"+Path;

				System.out.println("path");
				System.out.println(IMG_farmer);
				Image image1 = Image.getInstance(IMG_farmer);
				// imgPDF2.ScaleToFit(100.0F, 70.0F)
				image1.scaleToFit(250.0F, 250.0F);
				image1.setAbsolutePosition(320, 540);
				document.add(image1);

				BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
				PdfContentByte cbaddress = writer.getDirectContent();
				cbaddress.beginText();
				cbaddress.setFontAndSize(bfaddress, 12);

				cbaddress.setTextMatrix(70, 700);
				cbaddress.showText(name_of_farmer.toUpperCase());

				cbaddress.setTextMatrix(70, 680);
				cbaddress.showText("Sex:  " + farmer_sex);

				cbaddress.setTextMatrix(190, 680);
				cbaddress.showText("Age:  " + farmer_age);

				cbaddress.setTextMatrix(70, 660);
				cbaddress.showText("Vulnerability:   " + "No");

				cbaddress.setTextMatrix(190, 660);
				cbaddress.showText("Phone #: " + farmer_phone_no);

				/*
				 * cbaddress.setTextMatrix(70, 500);
				 * cbaddress.showText("Farm Code: " + code);
				 * 
				 * cbaddress.setTextMatrix(200, 500);
				 * cbaddress.showText("Contact Person: " +
				 * name_of_contact_person.toUpperCase());
				 * 
				 * cbaddress.setTextMatrix(430, 500);
				 * cbaddress.showText("Farm Size: " + dimention_area);
				 * 
				 * 
				 * 
				 * 
				 * cbaddress.setTextMatrix(70, 480);
				 * cbaddress.showText("Location: " + town_site_location);
				 * 
				 * cbaddress.setTextMatrix(280, 480);
				 * cbaddress.showText("Other Activities:  " + other_specify);
				 * 
				 * cbaddress.setTextMatrix(400, 520);
				 * cbaddress.showText("Farm Size:     " + "0.45");
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 * cbaddress.setTextMatrix(70, 460);
				 * cbaddress.showText("Date of Inspection :     " +
				 * date_of_inspection);
				 * 
				 * cbaddress.setTextMatrix(280, 460);
				 * cbaddress.showText("Method of Farming:     " +
				 * type_of_farming);
				 */

				/*
				 * cbaddress.setTextMatrix(400, 540);
				 * cbaddress.showText("Farm Size:     " + "0.45");
				 */

				cbaddress.endText();

				// PdfPage pdfPage = document.addNewPage();

				PdfContentByte canvas = writer.getDirectContent();
				// canvas.moveTo(20, 420);
				// canvas.lineTo(580, 420);

				canvas.moveTo(20, 520);
				canvas.lineTo(580, 520);
				canvas.closePathStroke();

				/*
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE));
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 * // Get the current date and time LocalDateTime currentTime =
				 * LocalDateTime.now(); System.out.println("Current DateTime: "
				 * + currentTime);
				 * 
				 * LocalDate date1 = currentTime.toLocalDate();
				 * System.out.println("Date : " + date1);
				 * 
				 * Month month = currentTime.getMonth(); int day =
				 * currentTime.getDayOfMonth(); int year =
				 * currentTime.getYear();
				 */

				// System.out.println("Month : " + month);
				// System.out.println("Day : " + day);
				// System.out.println("Seconds : " + seconds);

				/*
				 * String cert_text2 =""; cert_text2 +=
				 * "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the"
				 * ; cert_text2 += " Lands Commission this "+ day + " day of " +
				 * month + ", "+ year + ".";
				 * 
				 * 
				 * Paragraph p_3 = new Paragraph(cert_text2, new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_3.setAlignment(Element.ALIGN_JUSTIFIED);
				 * p_3.setLeading(32); document.add(p_3);
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE));
				 * 
				 * Paragraph p_4 = new
				 * Paragraph(".......................................", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
				 * 
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE));
				 * 
				 * Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ",
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
				 */
				// document.newPage();

				/*
				 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE));
				 * 
				 * 
				 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE)); document.add(new
				 * Phrase(Chunk.NEWLINE));
				 * 
				 * 
				 * PdfPTable myTable_memorials = new PdfPTable(6);
				 * myTable_memorials.setWidthPercentage(100); //Left aLign
				 * myTable_memorials.setTotalWidth((float) 300.0);;
				 * myTable_memorials.setHorizontalAlignment(0);
				 * myTable_memorials.setSpacingAfter(10);
				 * myTable_memorials.setTotalWidth(new float[]{ 100, 100,
				 * 100,100,100,100 });
				 * 
				 * PdfPCell EmptyCell_memorials = new PdfPCell(new
				 * Paragraph("",font10pt));
				 * EmptyCell_memorials.setBorderWidth(0);
				 * //CellOneHdr_proprietors.setRowspan(2);
				 * 
				 * 
				 * PdfPCell cell_memorials = new PdfPCell(new
				 * Paragraph("Details of Crops",font10pt));
				 * cell_memorials.setColspan(6); //
				 * cell_land_certificate.setHorizontalAlignment(Element.
				 * ALIGN_CENTER); // cell.setPadding(10.0f);
				 * //cell_land_certificate.setBackgroundColor(new BaseColor(140,
				 * 221, 8)); myTable_memorials.addCell(cell_memorials);
				 * 
				 * 
				 * PdfPCell CellOneHdr_memorials = new PdfPCell(new
				 * Paragraph("Category",font10pt));
				 * //CellOneHdr_proprietors.setRowspan(1);
				 * myTable_memorials.addCell(CellOneHdr_memorials);
				 * 
				 * 
				 * PdfPCell CellTwoHdr_memorials = new PdfPCell(new
				 * Paragraph("Typr of Crop",font10pt)); //
				 * CellTwoHdr_proprietors.setRowspan(1);
				 * myTable_memorials.addCell(CellTwoHdr_memorials);
				 * 
				 * 
				 * 
				 * PdfPCell CellTreeHdr_memorials = new PdfPCell(new
				 * Paragraph("Crop Stage",font10pt)); //
				 * CellTreeHdr_proprietors.setRowspan(1);
				 * myTable_memorials.addCell(CellTreeHdr_memorials);
				 * 
				 * 
				 * PdfPCell CellNineHdr_memorials = new PdfPCell(new
				 * Paragraph("Crop Area",font10pt));
				 * //cell_interest.setColspan(5);
				 * myTable_memorials.addCell(CellNineHdr_memorials);
				 * 
				 * 
				 * PdfPCell CellTenHdr_memorials = new PdfPCell(new
				 * Paragraph("Cropr Rate",font10pt));
				 * //CellNineHdr_proprietors.setRowspan(1);
				 * myTable_memorials.addCell(CellTenHdr_memorials);
				 * 
				 * 
				 * PdfPCell cell_folio_reference = new PdfPCell(new
				 * Paragraph("Crop value GHS",font10pt));
				 * //CellTenHdr_proprietors.setRowspan(1);
				 * //cell_folio_reference.setColspan(2);
				 * myTable_memorials.addCell(cell_folio_reference);
				 * 
				 * 
				 * 
				 * 
				 * 
				 * String crop_details =
				 * cls_case_management.select_ds_crop_details_all_by_item_code(
				 * item_code);
				 * 
				 * JSONObject obj_crop_details = new JSONObject(crop_details);
				 * String crop_details_data =
				 * (String)obj_crop_details.getString("data"); // JSONObject
				 * obj_main_data = new JSONObject(crop_details_data);
				 * 
				 * System.out.println("New Data");
				 * System.out.println(crop_details_data); if(crop_details_data
				 * != "null" ){ JSONArray jArr_memorials = new
				 * JSONArray(crop_details_data); for (int J=0; J <
				 * jArr_memorials.length(); J++) { JSONObject obj_memorials =
				 * jArr_memorials.getJSONObject(J);
				 * 
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("crop_category"),
				 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("type_of_crop"),
				 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("stage_of_crop"),
				 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString(
				 * "crop_area_coverage_pecentage"),font10pt)));
				 * myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("estimated_area"),
				 * font10pt))); myTable_memorials.addCell(new PdfPCell(new
				 * Phrase((String)obj_memorials.getString("estimated_area"),
				 * font10pt))); // NumberCount_memo += 1; } }
				 * 
				 * 
				 * myTable_memorials.setSpacingBefore(5.0f); // Space Before
				 * table starts, like margin-top in CSS
				 * myTable_memorials.setSpacingAfter(5.0f); // Space After table
				 * starts, like margin-Bottom in CSS
				 * 
				 * 
				 * document.add(myTable_memorials);
				 * 
				 * 
				 * Paragraph p_4 = new
				 * Paragraph("Date of Payment : .............................................."
				 * , new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_4.setAlignment(Element.ALIGN_LEFT); document.add(p_4);
				 * 
				 * 
				 * // document.add(new Phrase(Chunk.NEWLINE));
				 * 
				 * Paragraph p_5 = new
				 * Paragraph("Mode Of Payment: Cash......     Cheque.......",
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_5.setAlignment(Element.ALIGN_LEFT); document.add(p_5);
				 * 
				 * 
				 * 
				 * Paragraph p_50 = new Paragraph("Cheque No..........", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_50.setAlignment(Element.ALIGN_LEFT); document.add(p_50);
				 * 
				 * 
				 * Paragraph p7 = new Paragraph("Witness Name: ", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p7.setAlignment(Element.ALIGN_RIGHT); document.add(p7);
				 * 
				 * Paragraph p_8 = new
				 * Paragraph("...............................................",
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_8.setAlignment(Element.ALIGN_LEFT); document.add(p_8);
				 * 
				 * Paragraph p_12 = new Paragraph(
				 * "........................................................",
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * p_12.setAlignment(Element.ALIGN_RIGHT); document.add(p_12);
				 * 
				 * 
				 * Paragraph p_9 = new Paragraph("SIGNATURE/THUMBPRINT", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_9.setAlignment(Element.ALIGN_LEFT); document.add(p_9);
				 * 
				 * 
				 * Paragraph p_13 = new Paragraph("SIGNATURE/THUMBPRINT", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_13.setAlignment(Element.ALIGN_RIGHT); document.add(p_13);
				 * 
				 * Paragraph p_10 = new Paragraph("ASSIAMAH KORANKYE JOHN", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_10.setAlignment(Element.ALIGN_LEFT); document.add(p_10);
				 * 
				 * 
				 * Paragraph p_11 = new
				 * Paragraph("CERTIFIED VALUER :HELEN ARTHUR (MRS) MGhIS", new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_11.setAlignment(Element.ALIGN_LEFT); document.add(p_11);
				 */

				document.newPage();

			}

			document.close();
			//file.close();
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

	public byte[] create_file_list(String web_service_url, String web_service_api_key, String software_file_location,
			String list_of_applications, String batch_number,
			String batching_officer,
			String receiving_officer, String output_file)
			throws IOException, SQLException, JSONException, ParseException {

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(batch_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			/*
			 * Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image1.scaleToFit(70.0F,
			 * 70.0F); image1.setAbsolutePosition(50, 670);
			 * document.add(image1);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN,
			 * BaseFont.CP1252, BaseFont.NOT_EMBEDDED); PdfContentByte cbaddress
			 * = writer.getDirectContent(); cbaddress.beginText();
			 * cbaddress.setFontAndSize(bfaddress, 11);
			 * 
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 * 
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * 
			 * 
			 * 
			 * cbaddress.endText();
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("BATCH LIST", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			// document.newPage();

			Paragraph p_6 = new Paragraph("BATCH NUMBER : " + batch_number, new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			// System.out.println(formatter.format(date));

			Paragraph p_7 = new Paragraph("BATCH DATE : " + formatter.format(date),
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_7.setAlignment(Element.ALIGN_CENTER);
			document.add(p_7);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(5);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 70, 100, 100, 100 });

			// PdfPCell EmptyCell_memorials = new PdfPCell(new
			// Paragraph("",font10pt));
			// EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("S/N", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Job Number", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Applicant Name", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellFoureHdr_memorials = new PdfPCell(new Paragraph("Locality", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFoureHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Service Type", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			// PdfPCell CellNineHdr_memorials1 = new PdfPCell(new
			// Paragraph("Status",font10pt));
			// cell_interest.setColspan(5);
			// myTable_memorials.addCell(CellNineHdr_memorials1);

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (list_of_applications != "null") {
				JSONArray jArr_memorials = new JSONArray(list_of_applications);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("job_number"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("ar_name"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("locality"), font10pt)));

					myTable_memorials.addCell(new PdfPCell(
							new Phrase((String) obj_memorials.getString("business_process_sub_name"), font10pt)));

					// Receivingofficer=(String)obj_memorials.getString("job_recieved_by");
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase("",font10pt)));
					NumberCount_memo += 1;
				}
			}

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p_41 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_41.setAlignment(Element.ALIGN_CENTER); document.add(p_41);
			 * 
			 * Paragraph p_4_11 = new Paragraph(batching_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_11.setAlignment(Element.ALIGN_CENTER); document.add(p_4_11);
			 * 
			 * Paragraph p_51 = new Paragraph("BATCHING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_51.setAlignment(Element.ALIGN_CENTER); document.add(p_51);
			 * /////////////////////////
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * Paragraph p_4_1 = new Paragraph(receiving_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_1.setAlignment(Element.ALIGN_CENTER); document.add(p_4_1);
			 * 
			 * Paragraph p_5 = new Paragraph("RECEIVING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			// Inserting Table in PDF
			PdfPTable myTable_signature = new PdfPTable(2);
			myTable_signature.setWidthPercentage(100);

			PdfPCell cellOne = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellTwo = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellThree = new PdfPCell(new PdfPCell(new Phrase("BATCHING OFFICER", font10pt)));
			PdfPCell cellFour = new PdfPCell(new PdfPCell(new Phrase("RECEIVING OFFICER", font10pt)));
			PdfPCell cellFive = new PdfPCell(new PdfPCell(new Phrase((String) batching_officer, font10pt)));
			PdfPCell cellSix = new PdfPCell(new PdfPCell(new Phrase((String) receiving_officer, font10pt)));

			cellOne.setBorder(Rectangle.NO_BORDER);
			cellTwo.setBorder(Rectangle.NO_BORDER);
			cellThree.setBorder(Rectangle.NO_BORDER);
			cellFour.setBorder(Rectangle.NO_BORDER);
			cellFive.setBorder(Rectangle.NO_BORDER);
			cellSix.setBorder(Rectangle.NO_BORDER);

			cellTwo.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellFour.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellSix.setHorizontalAlignment(Element.ALIGN_RIGHT);

			// Left aLign
			myTable_signature.setTotalWidth((float) 300.0);
			myTable_signature.setHorizontalAlignment(0);
			myTable_signature.setSpacingAfter(10);
			myTable_signature.setTotalWidth(new float[] { 100, 100 });

			myTable_signature.addCell(cellOne);
			myTable_signature.addCell(cellTwo);

			// roles
			myTable_signature.addCell(cellThree);
			myTable_signature.addCell(cellFour);

			// roles
			myTable_signature.addCell(cellFive);
			myTable_signature.addCell(cellSix);

			myTable_signature.setSpacingBefore(5.0f);
			myTable_signature.setSpacingAfter(5.0f);

			document.add(myTable_signature);

			document.close();
			//file.close();
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


	public byte[] create_request_list(String web_service_url, String web_service_api_key, String software_file_location,
			String list_of_applications, String batch_number,
			String batching_officer,
			String receiving_officer, String output_file)
			throws IOException, SQLException, JSONException, ParseException {

		// JSONObject obj = new JSONObject(case_records);
		// String main_details = (String)obj.getString("main_details");
		// String json_lrd_memorials_section =
		// (String)obj.getString("lrd_memorials_section");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(batch_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			/*
			 * Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image1.scaleToFit(70.0F,
			 * 70.0F); image1.setAbsolutePosition(50, 670);
			 * document.add(image1);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN,
			 * BaseFont.CP1252, BaseFont.NOT_EMBEDDED); PdfContentByte cbaddress
			 * = writer.getDirectContent(); cbaddress.beginText();
			 * cbaddress.setFontAndSize(bfaddress, 11);
			 * 
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 * 
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * 
			 * 
			 * 
			 * cbaddress.endText();
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("REQUEST LIST", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			// document.newPage();

			Paragraph p_6 = new Paragraph("REQUEST NUMBER : " + batch_number, new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			// System.out.println(formatter.format(date));

			Paragraph p_7 = new Paragraph("REQUEST DATE : " + formatter.format(date),
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_7.setAlignment(Element.ALIGN_CENTER);
			document.add(p_7);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 70, 100, 100, 100, 100 });

			// PdfPCell EmptyCell_memorials = new PdfPCell(new
			// Paragraph("",font10pt));
			// EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("S/N", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Job Number", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Applicant Name", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellFoureHdr_memorials = new PdfPCell(new Paragraph("Locality", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFoureHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Service Type", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellEightHdr_memorials = new PdfPCell(new Paragraph("Purpose", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellEightHdr_memorials);

			// PdfPCell CellNineHdr_memorials1 = new PdfPCell(new
			// Paragraph("Status",font10pt));
			// cell_interest.setColspan(5);
			// myTable_memorials.addCell(CellNineHdr_memorials1);

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (list_of_applications != "null") {
				JSONArray jArr_memorials = new JSONArray(list_of_applications);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("job_number"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("ar_name"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.optString("locality"), font10pt)));

					myTable_memorials.addCell(new PdfPCell(
							new Phrase((String) obj_memorials.getString("business_process_sub_name"), font10pt)));

							myTable_memorials.addCell(new PdfPCell(
							new Phrase((String) obj_memorials.getString("job_purpose"), font10pt)));

					// Receivingofficer=(String)obj_memorials.getString("job_recieved_by");
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase("",font10pt)));
					NumberCount_memo += 1;
				}
			}

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p_41 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_41.setAlignment(Element.ALIGN_CENTER); document.add(p_41);
			 * 
			 * Paragraph p_4_11 = new Paragraph(batching_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_11.setAlignment(Element.ALIGN_CENTER); document.add(p_4_11);
			 * 
			 * Paragraph p_51 = new Paragraph("BATCHING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_51.setAlignment(Element.ALIGN_CENTER); document.add(p_51);
			 * /////////////////////////
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * Paragraph p_4_1 = new Paragraph(receiving_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_1.setAlignment(Element.ALIGN_CENTER); document.add(p_4_1);
			 * 
			 * Paragraph p_5 = new Paragraph("RECEIVING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			// Inserting Table in PDF
			PdfPTable myTable_signature = new PdfPTable(2);
			myTable_signature.setWidthPercentage(100);

			PdfPCell cellOne = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellTwo = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellThree = new PdfPCell(new PdfPCell(new Phrase("BATCHING OFFICER", font10pt)));
			PdfPCell cellFour = new PdfPCell(new PdfPCell(new Phrase("RECEIVING OFFICER", font10pt)));
			PdfPCell cellFive = new PdfPCell(new PdfPCell(new Phrase((String) batching_officer, font10pt)));
			PdfPCell cellSix = new PdfPCell(new PdfPCell(new Phrase((String) receiving_officer, font10pt)));

			cellOne.setBorder(Rectangle.NO_BORDER);
			cellTwo.setBorder(Rectangle.NO_BORDER);
			cellThree.setBorder(Rectangle.NO_BORDER);
			cellFour.setBorder(Rectangle.NO_BORDER);
			cellFive.setBorder(Rectangle.NO_BORDER);
			cellSix.setBorder(Rectangle.NO_BORDER);

			cellTwo.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellFour.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellSix.setHorizontalAlignment(Element.ALIGN_RIGHT);

			// Left aLign
			myTable_signature.setTotalWidth((float) 300.0);
			myTable_signature.setHorizontalAlignment(0);
			myTable_signature.setSpacingAfter(10);
			myTable_signature.setTotalWidth(new float[] { 100, 100 });

			myTable_signature.addCell(cellOne);
			myTable_signature.addCell(cellTwo);

			// roles
			myTable_signature.addCell(cellThree);
			myTable_signature.addCell(cellFour);

			// roles
			myTable_signature.addCell(cellFive);
			myTable_signature.addCell(cellSix);

			myTable_signature.setSpacingBefore(5.0f);
			myTable_signature.setSpacingAfter(5.0f);

			document.add(myTable_signature);

			document.close();
			//file.close();
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

	public byte[] create_batch_list_bulk_collection_slip(String web_service_url, String web_service_api_key,
			String software_file_location,
			String list_of_applications, String batch_number,
			String batching_officer, String output_file)
			throws IOException, SQLException, JSONException, ParseException {

		// JSONObject obj = new JSONObject(case_records);
		// String main_details = (String)obj.getString("main_details");
		// String json_lrd_memorials_section =
		// (String)obj.getString("lrd_memorials_section");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(batch_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			/*
			 * Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image1.scaleToFit(70.0F,
			 * 70.0F); image1.setAbsolutePosition(50, 670);
			 * document.add(image1);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN,
			 * BaseFont.CP1252, BaseFont.NOT_EMBEDDED); PdfContentByte cbaddress
			 * = writer.getDirectContent(); cbaddress.beginText();
			 * cbaddress.setFontAndSize(bfaddress, 11);
			 * 
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 * 
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * 
			 * 
			 * 
			 * cbaddress.endText();
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("BULK COLLECTION SLIP", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			// document.newPage();

			Paragraph p_6 = new Paragraph("BATCH NUMBER : " + batch_number, new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			// System.out.println(formatter.format(date));

			Paragraph p_7 = new Paragraph("COLLECTION DATE : " + formatter.format(date),
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_7.setAlignment(Element.ALIGN_CENTER);
			document.add(p_7);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(3);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 70, 100 });
			// myTable_memorials.setTotalWidth(new float[] { 25, 70, 100, 100, 100 });

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("S/N", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Job Number", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Applicant Name", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			// PdfPCell CellFoureHdr_memorials = new PdfPCell(new Paragraph("Purpose",
			// font10pt));
			// // CellTreeHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFoureHdr_memorials);

			// PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Service Type",
			// font10pt));
			// // cell_interest.setColspan(5);
			// myTable_memorials.addCell(CellNineHdr_memorials);

			// PdfPCell CellNineHdr_memorials1 = new PdfPCell(new
			// Paragraph("Status",font10pt));
			// cell_interest.setColspan(5);
			// myTable_memorials.addCell(CellNineHdr_memorials1);

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (list_of_applications != "null") {
				JSONArray jArr_memorials = new JSONArray(list_of_applications);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("job_number"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("ar_name"), font10pt)));
					// myTable_memorials.addCell(
					// new PdfPCell(new Phrase((String) obj_memorials.getString("job_purpose"),
					// font10pt)));

					// myTable_memorials.addCell(new PdfPCell(
					// new Phrase((String) obj_memorials.getString("business_process_sub_name"),
					// font10pt)));

					// Receivingofficer=(String)obj_memorials.getString("job_recieved_by");
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase("",font10pt)));
					NumberCount_memo += 1;
				}
			}

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportoddicer = new Paragraph(batching_officer, new Font(FontFamily.TIMES_ROMAN, 12));
			reportoddicer.setAlignment(Element.ALIGN_LEFT);
			document.add(reportoddicer);

			// Paragraph p_8 = new Paragraph(batching_officer, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			// p_8.setAlignment(Element.ALIGN_RIGHT);
			// document.add(p_8);

			Paragraph reportTitle4 = new Paragraph("FOR: REGIONAL LANDS OFFICER",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle4.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle4);
			Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle5.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle5);
			document.add(new Phrase(Chunk.NEWLINE));

			document.close();
			//file.close();
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

	public byte[] create_batch_list(String web_service_url, String web_service_api_key, String software_file_location,
			String list_of_applications, String batch_number,
			String batching_officer,
			String receiving_officer, String output_file)
			throws IOException, SQLException, JSONException, ParseException {

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(batch_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			/*
			 * Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			 * //imgPDF2.ScaleToFit(100.0F, 70.0F) image1.scaleToFit(70.0F,
			 * 70.0F); image1.setAbsolutePosition(50, 670);
			 * document.add(image1);
			 */

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN,
			 * BaseFont.CP1252, BaseFont.NOT_EMBEDDED); PdfContentByte cbaddress
			 * = writer.getDirectContent(); cbaddress.beginText();
			 * cbaddress.setFontAndSize(bfaddress, 11);
			 * 
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 * 
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * 
			 * 
			 * 
			 * cbaddress.endText();
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("BATCH LIST", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			// document.newPage();

			Paragraph p_6 = new Paragraph("BATCH NUMBER : " + batch_number, new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			// System.out.println(formatter.format(date));

			Paragraph p_7 = new Paragraph("BATCH DATE : " + formatter.format(date),
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_7.setAlignment(Element.ALIGN_CENTER);
			document.add(p_7);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(5);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 70, 100, 100, 100 });

			// PdfPCell EmptyCell_memorials = new PdfPCell(new
			// Paragraph("",font10pt));
			// EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("S/N", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Job Number", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Applicant Name", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellFoureHdr_memorials = new PdfPCell(new Paragraph("Purpose", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFoureHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Service Type", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			// PdfPCell CellNineHdr_memorials1 = new PdfPCell(new
			// Paragraph("Status",font10pt));
			// cell_interest.setColspan(5);
			// myTable_memorials.addCell(CellNineHdr_memorials1);

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (list_of_applications != "null") {
				JSONArray jArr_memorials = new JSONArray(list_of_applications);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("job_number"), font10pt)));
					myTable_memorials
							.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("ar_name"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("job_purpose"), font10pt)));

					myTable_memorials.addCell(new PdfPCell(
							new Phrase((String) obj_memorials.getString("business_process_sub_name"), font10pt)));

					// Receivingofficer=(String)obj_memorials.getString("job_recieved_by");
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase("",font10pt)));
					NumberCount_memo += 1;
				}
			}

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p_41 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_41.setAlignment(Element.ALIGN_CENTER); document.add(p_41);
			 * 
			 * Paragraph p_4_11 = new Paragraph(batching_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_11.setAlignment(Element.ALIGN_CENTER); document.add(p_4_11);
			 * 
			 * Paragraph p_51 = new Paragraph("BATCHING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_51.setAlignment(Element.ALIGN_CENTER); document.add(p_51);
			 * /////////////////////////
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * Paragraph p_4_1 = new Paragraph(receiving_officer, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4_1.setAlignment(Element.ALIGN_CENTER); document.add(p_4_1);
			 * 
			 * Paragraph p_5 = new Paragraph("RECEIVING OFFICER ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			// Inserting Table in PDF
			PdfPTable myTable_signature = new PdfPTable(2);
			myTable_signature.setWidthPercentage(100);

			PdfPCell cellOne = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellTwo = new PdfPCell(new Paragraph("...........................................", font10pt));
			PdfPCell cellThree = new PdfPCell(new PdfPCell(new Phrase("BATCHING OFFICER", font10pt)));
			PdfPCell cellFour = new PdfPCell(new PdfPCell(new Phrase("RECEIVING OFFICER", font10pt)));
			PdfPCell cellFive = new PdfPCell(new PdfPCell(new Phrase((String) batching_officer, font10pt)));
			PdfPCell cellSix = new PdfPCell(new PdfPCell(new Phrase((String) receiving_officer, font10pt)));

			cellOne.setBorder(Rectangle.NO_BORDER);
			cellTwo.setBorder(Rectangle.NO_BORDER);
			cellThree.setBorder(Rectangle.NO_BORDER);
			cellFour.setBorder(Rectangle.NO_BORDER);
			cellFive.setBorder(Rectangle.NO_BORDER);
			cellSix.setBorder(Rectangle.NO_BORDER);

			cellTwo.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellFour.setHorizontalAlignment(Element.ALIGN_RIGHT);
			cellSix.setHorizontalAlignment(Element.ALIGN_RIGHT);

			// Left aLign
			myTable_signature.setTotalWidth((float) 300.0);
			myTable_signature.setHorizontalAlignment(0);
			myTable_signature.setSpacingAfter(10);
			myTable_signature.setTotalWidth(new float[] { 100, 100 });

			myTable_signature.addCell(cellOne);
			myTable_signature.addCell(cellTwo);

			// roles
			myTable_signature.addCell(cellThree);
			myTable_signature.addCell(cellFour);

			// roles
			myTable_signature.addCell(cellFive);
			myTable_signature.addCell(cellSix);

			myTable_signature.setSpacingBefore(5.0f);
			myTable_signature.setSpacingAfter(5.0f);

			document.add(myTable_signature);

			document.close();
			//file.close();
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

	public byte[] create_publication_list(String web_service_url, String web_service_api_key,
			String software_file_location, String list_of_applications,
			String to_email_address, String batching_officer,
			String output_file) throws IOException, SQLException, JSONException, ParseException {

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.COURIER, 9, Font.NORMAL);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");

			String notice = "LAND TITLE REGISTRATION REGULATION LAW, 1986 PNDCL. 152) \n"
					+ "NOTICE OF APPLICATION FOR REGISTRATION OF TITLE TO LAND \n"
					+ "Take Notice that the under mentioned persons have applied to be registered as proprietors of the under "
					+ "mentioned lands and that I intend to register them as proprietors of the said lands if no objections are "
					+ "lodged against the registration in accordance with regulation with 54 of the Land Title Registration Regulations, "
					+ "1986 at the Land Registration Division - Lands Commission, Cantonment-Accra (Survey and Mapping Division (SMD) "
					+ "Premises) before the expiration of fourteen (14) days from the date of this notice.";

			Paragraph p_8 = new Paragraph(notice, new Font(FontFamily.TIMES_ROMAN, 10));
			p_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p_8);
			document.add(new Phrase(Chunk.NEWLINE));

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd MMMM YYYY");
			SimpleDateFormat date_formatter = new SimpleDateFormat("dd MMMM YYYY");

			if (list_of_applications != "null") {

				JSONObject jsonObject = new JSONObject(list_of_applications.trim());
				Integer NewCounter = 1;
				int[] ordinal = { 1 };
				jsonObject.keys().forEachRemaining(key -> {
					Object value = null;

					try {
						value = jsonObject.get((String) key);
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					Paragraph p_4 = new Paragraph("LOCALITY: " + ((String) key).toUpperCase(),
							new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
					try {
						document.add(p_4);
						// document.add(new Phrase(Chunk.NEWLINE));
						// document.add(new Phrase(Chunk.NEWLINE));
					} catch (DocumentException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					// System.out.println("Key: " + key);
					String json_string = value.toString();

					try {
						JSONArray jArr_list = new JSONArray(json_string);

						for (int i = 0; i < jArr_list.length(); i++) {
							JSONObject obj_memorials = jArr_list.getJSONObject(i);
							Paragraph p_41 = new Paragraph(NewCounter.toString() + ". ",
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_41.setIndentationLeft(25);

							Paragraph p_01 = new Paragraph(
								ordinal[0] + ".   " + "   a. GLPIN:  " + obj_memorials.getString("glpin").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_01.setIndentationLeft(50);

							Paragraph p_5 = new Paragraph(
								   "b. Lessee's Name:  "
											+ obj_memorials.getString("ar_name").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_5.setIndentationLeft(25);
							Paragraph p_6 = new Paragraph(
									"c. Grantor:  " + obj_memorials.getString("grantor").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_6.setIndentationLeft(50);
							// Paragraph p_7 = new Paragraph(
							// 		"c. Description of Land:  " + obj_memorials.getString("description").toUpperCase(),
							// 		new Font(FontFamily.TIMES_ROMAN, 12));
							// p_7.setIndentationLeft(50);
							Paragraph p_12 = new Paragraph(
									"d. Extent:  " + obj_memorials.getString("extent").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_12.setIndentationLeft(50);
							Paragraph p_9 = new Paragraph(
									"e. Type of Interest:  " + obj_memorials.getString("interest").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_9.setIndentationLeft(50);
							Paragraph p_10 = new Paragraph(
									"f. Registry Map Ref:  " + obj_memorials.getString("registry_map").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_10.setIndentationLeft(50);
							Paragraph p_11 = new Paragraph(
									"g. Lodgement Number:  " + obj_memorials.getString("client_number").toUpperCase(),
									new Font(FontFamily.TIMES_ROMAN, 12));
							p_11.setIndentationLeft(50);
							ordinal[0]++;
							try {
								document.add(p_01);
								document.add(p_5);
								document.add(p_6);
								//document.add(p_7);
								document.add(p_12);
								document.add(p_9);
								document.add(p_10);
								document.add(p_11);
								document.add(new Phrase(Chunk.NEWLINE));
								// document.add(new Phrase(Chunk.NEWLINE));
								// document.add(p_12);
							} catch (DocumentException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							} finally {

							}

						}
						document.add(new Phrase(Chunk.NEWLINE));
						document.add(new Phrase(Chunk.NEWLINE));
						// document.add(new Phrase(Chunk.NEWLINE));

					} catch (JSONException | DocumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				});

			}

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add((new Chunk("NOTES ", new Font(FontFamily.TIMES_ROMAN, 12))).setUnderline(0.1f, -2f));

			String end_notice = "The Acknowledgement Slip/�Yellow Card� issued by the Land Registration Division (upon lodgement of an application for registration) is not the Land Certificate but only an acknowledgement card, which cannot be substituted for a land certificate (Section 58 of the Land Title Registration Law,  1986 (PNDCL 152)";
			String end_notice_2 = "Plots of land for registration are to be dealt with in accordance with the Land Title Registration Law, 1986 (PNDCL. 152) which is administered as a function of the Land Registration Division of the Lands Commission.\n"
					+ "a) \t\tAll transactions on public/state lands must first be handled by the Public and Vested Lands Management Division (PVLMD) of the Lands Commission which is legally mandated (Section 23 of Lands Commission Act, 2008 (Act 767) to manage public lands and all lands vested in the President.  All stool land transactions are also constitutionally required to be certified by the Regional Lands Commission of the Region where the lands are situated before submission to the Land Registration Division";
			String end_notice_3 = "The rights of a registered proprietor under Section 43 of the PNDCL.152 are indefeasible and are superior to any conferred under any other form of registration";
			String end_notice_4 = "Registration under the Law is compulsory for all land owners and penalties are payable by persons who fail to register their interest";
			String end_notice_5 = "Final judgments of Courts of competent jurisdiction are also to be registered";
			String end_notice_6 = "Application for first registration of land should be submitted by the owner/representative of the land at the the Client Service Access Unit (CSAU) of the Lands Commission, Cantonments - Accra, P. O. Box CT 5008, Cantonments � Accra";
			String end_notice_7 = "No pillar erected at the corner points on a registered parcel of land should be moved or disturbed.  It is an offence to remove or disturb any such pillar whether it is erected on your own land or not.  It is also a criminal offence punishable by a fine or imprisonment or both to enter upon any land without lawful authority and willfully destroy fences and/or buildings erected thereon";
			String end_notice_8 = "Further information in relation to compulsory land registration may be obtained from the CSAU";
			String end_notice_9 = "Any person(s) who seeks to object to an application as listed above is/are required to provide the basis and justification for the objection and should submit copies of all supporting documents such as Court judgments, wills, Letters of Administration and Court proceedings to the objection letter to the CSAU";
			String end_notice_10 = "If item 9 is not complied with the objection will not be accepted";
			// Paragraph p_8 = new Paragraph(notice);
			/*
			 * Chunk st2 = new Chunk(notice, small); st2.setTextRise(7);
			 * p_8.add(st2);
			 */
			Font list_font = FontFactory.getFont(FontFactory.HELVETICA, 10);
			List list1 = new List(List.ORDERED);
			list1.add(new ListItem(end_notice, list_font));
			list1.add(new ListItem(end_notice_2, list_font));
			list1.add(new ListItem(end_notice_3, list_font));
			list1.add(new ListItem(end_notice_4, list_font));
			list1.add(new ListItem(end_notice_5, list_font));
			list1.add(new ListItem(end_notice_6, list_font));
			list1.add(new ListItem(end_notice_7, list_font));
			list1.add(new ListItem(end_notice_8, list_font));
			list1.add(new ListItem(end_notice_9, list_font));
			list1.add(new ListItem(end_notice_10, list_font));
			list1.setAlignindent(true);
			document.add(list1);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_0 = new Paragraph("Dated " + date_formatter.format(date), new Font(FontFamily.TIMES_ROMAN, 12));

			Paragraph p_1 = new Paragraph("YAA AGYEMAN BOADI (MRS.)", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			Paragraph p_2 = new Paragraph("DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			Paragraph p_3 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_0.setAlignment(Element.ALIGN_CENTER);
			p_1.setAlignment(Element.ALIGN_CENTER);
			p_3.setAlignment(Element.ALIGN_CENTER);
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_0);
			document.add(p_1);
			document.add(p_2);
			document.add(p_3);
			// Inserting Table in PDF

			document.close();
			//file.close();
		return out.toByteArray();
		
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

	public byte[] create_special_publication_list(String web_service_url, String web_service_api_key,
			String software_file_location, String list_of_applications,
			String to_email_address, String batching_officer,
			String output_file) throws IOException, SQLException, JSONException, ParseException {

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.COURIER, 9, Font.NORMAL);

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy HH:mm:ss");

			// String notice = "LAND TITLE REGISTRATION REGULATION LAW, 1986 PNDCL. 152) \n"
			// + "NOTICE OF APPLICATION FOR REGISTRATION OF TITLE TO LAND \n"
			// + "Take Notice that the under mentioned persons have applied to be registered
			// as proprietors of the under "
			// + "mentioned lands and that I intend to register them as proprietors of the
			// said lands if no objections are "
			// + "lodged against the registration in accordance with regulation with 54 of
			// the Land Title Registration Regulations, "
			// + "1986 at the Land Registration Division - Lands Commission,
			// Cantonment-Accra (Survey and Mapping Division (SMD) "
			// + "Premises) before the expiration of fourteen (14) days from the date of
			// this notice.";

			// Paragraph p_8 = new Paragraph(notice, new Font(FontFamily.TIMES_ROMAN, 10));

			// p_8.setAlignment(Element.ALIGN_LEFT);
			// document.add(p_8);
			// document.add(new Phrase(Chunk.NEWLINE));

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd MMMM YYYY");
			SimpleDateFormat date_formatter = new SimpleDateFormat("dd MMMM YYYY");

			if (list_of_applications != "null") {

				try {
					HTMLWorker htmlWorker = new HTMLWorker(document);
					htmlWorker.parse(new StringReader(list_of_applications));

				} catch (Exception e) {

				}

			}

			// ----------------------------------------------------------

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add((new Chunk("NOTES ", new Font(FontFamily.TIMES_ROMAN, 12))).setUnderline(0.1f, -2f));

			String end_notice = "The Acknowledgement Slip/�Yellow Card� issued by the Land Registration Division (upon lodgement of an application for registration) is not the Land Certificate but only an acknowledgement card, which cannot be substituted for a land certificate (Section 58 of the Land Title Registration Law,  1986 (PNDCL 152)";
			String end_notice_2 = "Plots of land for registration are to be dealt with in accordance with the Land Title Registration Law, 1986 (PNDCL. 152) which is administered as a function of the Land Registration Division of the Lands Commission.\n"
					+ "a) \t\tAll transactions on public/state lands must first be handled by the Public and Vested Lands Management Division (PVLMD) of the Lands Commission which is legally mandated (Section 23 of Lands Commission Act, 2008 (Act 767) to manage public lands and all lands vested in the President.  All stool land transactions are also constitutionally required to be certified by the Regional Lands Commission of the Region where the lands are situated before submission to the Land Registration Division";
			String end_notice_3 = "The rights of a registered proprietor under Section 43 of the PNDCL.152 are indefeasible and are superior to any conferred under any other form of registration";
			String end_notice_4 = "Registration under the Law is compulsory for all land owners and penalties are payable by persons who fail to register their interest";
			String end_notice_5 = "Final judgments of Courts of competent jurisdiction are also to be registered";
			String end_notice_6 = "Application for first registration of land should be submitted by the owner/representative of the land at the the Client Service Access Unit (CSAU) of the Lands Commission, Cantonments - Accra, P. O. Box CT 5008, Cantonments � Accra";
			String end_notice_7 = "No pillar erected at the corner points on a registered parcel of land should be moved or disturbed.  It is an offence to remove or disturb any such pillar whether it is erected on your own land or not.  It is also a criminal offence punishable by a fine or imprisonment or both to enter upon any land without lawful authority and willfully destroy fences and/or buildings erected thereon";
			String end_notice_8 = "Further information in relation to compulsory land registration may be obtained from the CSAU";
			String end_notice_9 = "Any person(s) who seeks to object to an application as listed above is/are required to provide the basis and justification for the objection and should submit copies of all supporting documents such as Court judgments, wills, Letters of Administration and Court proceedings to the objection letter to the CSAU";
			String end_notice_10 = "If item 9 is not complied with the objection will not be accepted";
			// Paragraph p_8 = new Paragraph(notice);
			/*
			 * Chunk st2 = new Chunk(notice, small); st2.setTextRise(7);
			 * p_8.add(st2);
			 */
			Font list_font = FontFactory.getFont(FontFactory.HELVETICA, 10);
			List list1 = new List(List.ORDERED);
			list1.add(new ListItem(end_notice, list_font));
			list1.add(new ListItem(end_notice_2, list_font));
			list1.add(new ListItem(end_notice_3, list_font));
			list1.add(new ListItem(end_notice_4, list_font));
			list1.add(new ListItem(end_notice_5, list_font));
			list1.add(new ListItem(end_notice_6, list_font));
			list1.add(new ListItem(end_notice_7, list_font));
			list1.add(new ListItem(end_notice_8, list_font));
			list1.add(new ListItem(end_notice_9, list_font));
			list1.add(new ListItem(end_notice_10, list_font));
			list1.setAlignindent(true);
			document.add(list1);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_0 = new Paragraph("Dated " + date_formatter.format(date), new Font(FontFamily.TIMES_ROMAN, 12));

			Paragraph p_1 = new Paragraph("YAA AGYEMAN BOADI (MRS.)", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			Paragraph p_2 = new Paragraph("DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			Paragraph p_3 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_0.setAlignment(Element.ALIGN_CENTER);
			p_1.setAlignment(Element.ALIGN_CENTER);
			p_3.setAlignment(Element.ALIGN_CENTER);
			p_2.setAlignment(Element.ALIGN_CENTER);
			document.add(p_0);
			document.add(p_1);
			document.add(p_2);
			document.add(p_3);
			// Inserting Table in PDF

			document.close();
			//file.close();
		return out.toByteArray();
		
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

	public byte[] create_search_report_pvlmd(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature, String fullname,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
			JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph reportTitle_JOB = new Paragraph("Job Number: " +
			 * job_number, new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle_JOB.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_JOB); document.add(new
			 * Phrase(Chunk.NEWLINE)); document.add(new Phrase(Chunk.NEWLINE));
			 */
			/*
			 * Paragraph reportTitle = new Paragraph("LANDS COMMISSION", new
			 * Font(FontFamily.TIMES_ROMAN, 14));
			 * reportTitle.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle);
			 */

			DateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
			Date date = new Date();
			// DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// System.out.println(dateFormat.format(date)); // 2016/11/16
			// 12:08:43

			Paragraph reportTitle3 = new Paragraph(dateFormat.format(date), new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle3.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle3);

			Paragraph reportTitle_O = new Paragraph("PUBLIC AND VESTED LAND MANAGEMENT DIVISION - SEARCH",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_O.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_O);
			Paragraph reportTitle_1 = new Paragraph(
					"A Search is requested against the land delineated on the plan attached.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_1);
			/*
			 * Paragraph reportTitle_2 = new
			 * Paragraph("(b) Comprised in the following instrument", new
			 * Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2);
			 */
			Paragraph reportTitle_Line1 = new Paragraph(
					"_____________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line1.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line1);
			Paragraph reportTitle_3 = new Paragraph(
					"PURPOSE                                                                       "
							+ "RECORDED TRANSACTION(S)",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_3);
			Paragraph reportTitle_Line2 = new Paragraph(
					"_______________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line2);
			Paragraph reportTitle_Name = new Paragraph("NAME AND ADDRESS OF ENQUIRER : ",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Name.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_Name);

			Paragraph reportTitle_Name1 = new Paragraph(ar_name.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			reportTitle_Name1.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Name1);

			Paragraph reportTitle_address = new Paragraph(client_address.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			reportTitle_address.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_address);
			Paragraph reportTitle_Line3 = new Paragraph(
					"_________________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line3.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line3);
			Paragraph reportTitle_note0 = new Paragraph("NOTE:-", new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note0.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note0);
			Paragraph reportTitle_note1 = new Paragraph(
					"(a) This form of search can be made against any piece of land situate in Ghana which is identified by r"
							+ "eference to an instrument registered in the Land Registry or a plan attached in duplicate.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note1.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(reportTitle_note1);
			Paragraph reportTitle_note2 = new Paragraph(
					"(b) The instrument referred to above must have been executed and stamped subsequent to 1st October, 1"
							+ "946. Where more than one Deed affecting the land are known to have been since this date, only the ear"
							+ "liest in date should be mentioned.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note2.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(reportTitle_note2);
			Paragraph reportTitle_note3 = new Paragraph(
					"(c) The Executive Secretary can accept no responsibility of any loss, which may be occasioned by reli"
							+ "ance on the report given below:",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note3.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(reportTitle_note3);
			Paragraph reportTitle_note4 = new Paragraph(
					"(d) The report may be collected from the CSAU within the Premises of the Land Valuation Division of the Lands Commission near Cantonment Post Office (Ghana Post and Ghana Vodafone).",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note4.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(reportTitle_note4);
			Paragraph reportTitle_Line4 = new Paragraph(
					"___________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line4.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line4);
			Paragraph reportTitle_note5 = new Paragraph(
					"The search applied for against the land edged red on the plan attached has been made with the followi"
							+ "ng result:- ",
					new Font(FontFamily.TIMES_ROMAN, 1));
			reportTitle_note5.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note5);
			// Paragraph reportTitle_note6 = new Paragraph(remark_or_comment1,
			// new Font(FontFamily.TIMES_ROMAN, 14));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			// reportTitle_note6.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_note6);
			/*
			 * Paragraph reportTitle_Line5 = new Paragraph(
			 * "*******************************************************************************************************",
			 * new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_Line5.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Line5);
			 */
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date1);
			// String formatted_date_of_registration = formatter.format(date1);

			// System.out.println("Today : " + today);

			if (signature.equals("Yes")) {
				Paragraph reportsignpad = new Paragraph("...........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportsignpad.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportsignpad);

				Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				reportoddicer.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportoddicer);

				Paragraph reportTitle4 = new Paragraph("FOR: REGIONAL LANDS OFFICER",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportTitle5);
				document.add(new Phrase(Chunk.NEWLINE));

			}

			Paragraph reportTitle_JOB1 = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_JOB1.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_JOB1);
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			/*
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * String cert_text2 = ""; cert_text2 += " Yours faithfully";
			 * 
			 * Paragraph p_3 = new Paragraph(cert_text2, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_3.setAlignment(Element.ALIGN_JUSTIFIED); p_3.setLeading(32);
			 * document.add(p_3);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * // document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_5 = new Paragraph("JOSEPH A. ARTHUR", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();
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

	public byte[] create_search_report_lc_consolidated_search(String web_service_url, String web_service_api_key,String doc_web_service_url, String doc_web_service_api_key,
			String software_file_location, String case_number,
			String job_number,
			String output_file, String sign_path, String case_docs_location, String public_docs_location)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");
		String transaction_approval_details = case_obj.get("transaction_approval_details").toString();

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();
		String vr_case_number = (String) parcel_details_obj.get("case_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String created_date = (String) job_detail_obj.get("created_date").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();
		String type_of_transaction = "";
		String approval_status = "0";
		String officers_grade = "";
		String report_approved_by = "0";
		String report_approved_by_id = "0";

		// String job_number = (String) obj_main.getString("job_number");
		if (transaction_approval_details.equals("null") || transaction_approval_details == null) {

		} else {
			JSONObject transaction_approval_details_obj;
			transaction_approval_details_obj = new JSONObject(transaction_approval_details);
			type_of_transaction = (String) transaction_approval_details_obj.get("type_of_transaction")
					.toString();
			approval_status = (String) transaction_approval_details_obj.get("approval_status").toString();
			officers_grade = (String) transaction_approval_details_obj.get("officers_grade").toString();
			report_approved_by = (String) transaction_approval_details_obj.get("created_by").toString();
			report_approved_by_id = (String) transaction_approval_details_obj.get("created_by_id").toString();

		}

		ByteArrayOutputStream out_pdf = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 100, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out_pdf);

			// document.addHeader("Header", "Header Text");

			HeaderFooterPageEvent event = new HeaderFooterPageEvent();
			event.extraValue = job_number + " (" + locality + ")";
			writer.setPageEvent(event);

			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph reportTitle = new Paragraph("LANDS COMMISSION", new
			 * Font(FontFamily.TIMES_ROMAN, 14));
			 * reportTitle.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle);
			 */

			DateFormat dateFormat = new SimpleDateFormat("MMMM dd yyyy");
			// DateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
			Date date = new Date();
			// DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// System.out.println(dateFormat.format(date)); // 2016/11/16
			// 12:08:43

			// LocalDateTime localDateTime = LocalDateTime.parse(date);

			// int month_c_d = date.getMonth();
			// int day_c_d = date.;
			// int year_c_d = date.getYear();

			// Date date = new Date();
			LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			int year_c_d = localDate.getYear();
			int month_c_d = localDate.getMonthValue();
			int day_c_d = localDate.getDayOfMonth();

			// int currentYear = year_c_d + 1900;

			Paragraph reportTitle3 = new Paragraph(
					specialNamesMonthDay_short[day_c_d] + " " + getMonth[month_c_d] + ", " + year_c_d,
					new Font(FontFamily.TIMES_ROMAN, 12));
			// Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			// new Font(FontFamily.TIMES_ROMAN, 12));
			//

			/*
			 * 
			 */
			reportTitle3.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle3);

			Paragraph reportTitle_title = new Paragraph("OFFICIAL CERTIFICATE OF RESULT OF SEARCH",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));

			reportTitle_title.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_title);

			Paragraph reportTitle_JOB = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));

			reportTitle_JOB.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_JOB);

			document.add(new Phrase(Chunk.NEWLINE));
			/*
			 * Paragraph reportTitle_1 = new Paragraph(
			 * "A Search is requested against the land delineated on the plan attached."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(created_date);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Paragraph reportTitle_note = new Paragraph(
					"To: " + ar_name.toUpperCase() + ", " + client_address.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_note.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note);

			Paragraph reportTitle_note6 = new Paragraph(
					"Pursuant to your application dated " + specialNamesMonthDay_short[day_c] + " day of "
							+ convertToTitleCaseIteratingChars(month_c.toString()) + ", " + year_c + " made by "
							+ ar_name.toUpperCase() + ", " + client_address.toUpperCase()
							+ ", a search has been made against the land delineated on the plan(s) attached with the following result(s):",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_note6.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(reportTitle_note6);

			document.add(new Phrase(Chunk.NEWLINE));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			// reportTitle_note6.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_note6);
			/*
			 * Paragraph reportTitle_Line5 = new Paragraph(
			 * "*******************************************************************************************************",
			 * new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_Line5.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Line5);
			 * 
			 * 
			 */

			document.add(new Phrase(Chunk.NEWLINE));

			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("dd-MMMM-yyyy hh:mm:ss aa");
			SimpleDateFormat dateTimeInGMT1 = new SimpleDateFormat("hh:mm:ss aa");
			// Setting the time zone
			dateTimeInGMT.setTimeZone(TimeZone.getTimeZone("GMT"));
			System.out.println(dateTimeInGMT.format(new Date()));

			System.out.println(dateTimeInGMT1.format(new Date()));
			System.out.println(day_c_d);

			Paragraph reportTitle_7 = new Paragraph(
					"The Seal of this Registry was affixed to this Certificate at the hour of "
							+ dateTimeInGMT1.format(new Date()) + " on the " + specialNamesMonthDay_short[day_c_d]
							+ " day of " + getMonth[month_c_d] + ", " + year_c_d,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_7.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_7);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date1);
			// String formatted_date_of_registration = formatter.format(date1);

			// System.out.println("Today : " + today);

			if (type_of_transaction.equals("approval_of_consolidated_search_signature")) {
				if (approval_status.equals("1")) {

					Image imagesign = Image.getInstance(sign_path + report_approved_by_id +
							".jpg");
					imagesign.scaleToFit(100.0F, 100.0F);
					imagesign.setAlignment(Element.ALIGN_RIGHT);
					document.add(imagesign);

					Paragraph reportsignpad = new Paragraph(
							"...........................................................",
							new Font(FontFamily.TIMES_ROMAN, 12));
					reportsignpad.setAlignment(Element.ALIGN_RIGHT);
					document.add(reportsignpad);

					Paragraph reportoddicer = new Paragraph(report_approved_by, new Font(FontFamily.TIMES_ROMAN, 12));
					reportoddicer.setAlignment(Element.ALIGN_RIGHT);
					document.add(reportoddicer);

					Paragraph p_8 = new Paragraph(officers_grade, new Font(FontFamily.TIMES_ROMAN, 12));
					p_8.setAlignment(Element.ALIGN_RIGHT);
					document.add(p_8);

					Paragraph reportTitle4 = new Paragraph("FOR: REGIONAL LANDS OFFICER",
							new Font(FontFamily.TIMES_ROMAN, 12));
					reportTitle4.setAlignment(Element.ALIGN_RIGHT);
					document.add(reportTitle4);
					Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
					reportTitle5.setAlignment(Element.ALIGN_RIGHT);
					document.add(reportTitle5);
					document.add(new Phrase(Chunk.NEWLINE));
				}
			}

			// if (signature.equals("Yes")) {

			// }

			Paragraph reportTitle_JOB1 = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_JOB1.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_JOB1);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			/*
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * String cert_text2 = ""; cert_text2 += " Yours faithfully";
			 * 
			 * Paragraph p_3 = new Paragraph(cert_text2, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_3.setAlignment(Element.ALIGN_JUSTIFIED); p_3.setLeading(32);
			 * document.add(p_3);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * // document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_5 = new Paragraph("JOSEPH A. ARTHUR", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();

			// // // Add Code to merge the the pdf
			// // // output_file

			// String path_to_site_plan = case_docs_location + vr_case_number
			// + File.separator + "site_plan_for_final_report.pdf";

			// String path_to_final_site_plan = case_docs_location + vr_case_number +
			// File.separator
			// + "final_merge_sr.pdf";

			// String path_to_final_site_plan_new = public_docs_location + vr_case_number +
			// File.separator
			// + "completed_search_report.pdf";


			
			
			// File files_pdf_jackets = new File(public_docs_location + vr_case_number);
			// if (!files_pdf_jackets.exists()) {
			// 	if (files_pdf_jackets.mkdirs()) {
			// 	// System.out.println("Multiple directories are created!");
			// 	} else {
			// 	System.out.println("Failed to create multiple directories!");
			// 	}
			// }

   // 1. Prepare output stream to collect the combined PDF
       // 3. Prepare the final combined PDF
	   ByteArrayOutputStream combinedPdfOutputStream = new ByteArrayOutputStream();
	   Document resultDoc_hp = new Document();
	   PdfCopy copy_hp = new PdfCopy(resultDoc_hp, combinedPdfOutputStream);
	   resultDoc_hp.open();

			
            // 4. Add content from out_pdf
            PdfReader outPdfReader = new PdfReader(out_pdf.toByteArray());
            for (int i = 1; i <= outPdfReader.getNumberOfPages(); i++) {
                copy_hp.addPage(copy_hp.getImportedPage(outPdfReader, i));
            }
            outPdfReader.close();


			    JSONObject obj_pdf = new JSONObject();
			    obj_pdf.put("doc_reference_number", vr_case_number);
			    obj_pdf.put("document_type", "case_docs");
				System.out.println(obj_pdf.toString());
				String web_response = cls_case_documents.select_case_documents_by_case_number(doc_web_service_url, doc_web_service_api_key, obj_pdf.toString());
				System.out.println(web_response);

				JSONObject web_response_case = new JSONObject(web_response); 
				String docs_data = web_response_case.get("data").toString(); 


        // Create ObjectMapper instance
        ObjectMapper objectMapper = new ObjectMapper();

        // Parse JSON String into a JsonNode array
        JsonNode rootNode = objectMapper.readTree(docs_data);

        // Loop through each object in the array
        for (JsonNode node : rootNode) {
            String doc_uuid =node.get("doc_uuid").asText();
			String document_name =node.get("document_name").asText();

			//System.out.println("dfd_id: " + node.get("dfd_id").asInt());
          //  System.out.println("doc_uuid: " + node.get("doc_uuid").asText());
           // System.out.println("doc_reference_number: " + node.get("doc_reference_number").asText());
           // System.out.println("document_name: " + node.get("document_name").asText());
           // System.out.println("doc_description: " + node.get("doc_description").asText());
           // System.out.println("----------------------------");
		
		   if (document_name.contains("hashed_plan_")) {
			

			JSONObject obj_pdf_b = new JSONObject();
			obj_pdf_b.put("doc_uuid", doc_uuid);
					//obj.put("doc_uuid", "44bd40f4-7733-11ef-a814-000c2930f1ec");
		
				// Read the InputStream from the external service
					InputStream pdf_blob = cls_case_documents.open_doc_by_unique_id_new_vlob(
						doc_web_service_url, doc_web_service_api_key,
						obj_pdf_b.toString()
					);

					 // 4. Read PDF from InputStream
					 PdfReader reader = new PdfReader(pdf_blob);

					 // 5. Copy all pages to the final document
					 int totalPages = reader.getNumberOfPages();
					 for (int i = 1; i <= totalPages; i++) {
						 copy_hp.addPage(copy_hp.getImportedPage(reader, i));
					 }
		 
			}

        }


			// String folderpath = case_docs_location + vr_case_number;
			// File subdir = new File(folderpath.toString());
			// String[] children = subdir.list();
			// if (children == null) {
			// // System.out.println("Either dir does not exist or is not a
			// // directory");
			// } else {
			// for (int j = 0; j < children.length; j++) {
			// String filename_doc = children[j];
			// String path = folderpath.toString() + File.separator + filename_doc;
			// String extension = filename_doc.substring(filename_doc.lastIndexOf("."));
			// 	if (filename_doc.contains("hashed_plan_")) {
			// 	PdfReader reader2 = new PdfReader(path);
			// 	// Copying Second Document
			// 		for (int i = 1; i <= reader2.getNumberOfPages(); i++) {
			// 		copy_hp.addPage(copy_hp.getImportedPage(reader2, i));
			// 		}
			// 	}

			// }

			// }

			resultDoc_hp.close();

			// String doc1 = output_file;
			// String doc2 = path_to_site_plan;
			// String resultDocFile = path_to_final_site_plan;
			// PdfReader reader1 = new PdfReader(doc1);
			// Document resultDoc = new Document();
			// PdfCopy copy = new PdfCopy(resultDoc, new FileOutputStream(resultDocFile));
			// resultDoc.open();

			// // Copying First Document
			// for (int i = 1; i <= reader1.getNumberOfPages(); i++) {
			// copy.addPage(copy.getImportedPage(reader1, i));
			// }
			// PdfReader reader2 = new PdfReader(doc2);
			// // Copying Second Document
			// for (int i = 1; i <= reader2.getNumberOfPages(); i++) {
			// copy.addPage(copy.getImportedPage(reader2, i));
			// }
			// resultDoc.close();

			// Create PdfReader instance.
			// //PdfReader s_pdfReader = new PdfReader(path_to_final_site_plan);
			// 1. Create PdfReader from your combined PDF
	PdfReader s_pdfReader = new PdfReader(combinedPdfOutputStream.toByteArray());

	// 2. Create an output stream to capture the modified PDF
	ByteArrayOutputStream stampedOutputStream = new ByteArrayOutputStream();
	
	// 3. Create PdfStamper instance (this applies the changes)
	PdfStamper pdfStamper = new PdfStamper(s_pdfReader, stampedOutputStream);
	
	// 4. Create BaseFont instance
	BaseFont baseFont = BaseFont.createFont(
		BaseFont.TIMES_ROMAN,
		BaseFont.CP1252, 
		BaseFont.NOT_EMBEDDED
	);
	
	// 5. Get number of pages
	int pages = s_pdfReader.getNumberOfPages();
	
	// 6. Iterate through pages
	for (int i = 1; i <= pages; i++) {
		// Example: Add only from page 2 onwards
		if (i == 1) {
			continue; // skip page 1
		}
	
		PdfContentByte pageContentByte = pdfStamper.getOverContent(i);
	
		// Write text
		pageContentByte.beginText();
		pageContentByte.setFontAndSize(baseFont, 10);
		pageContentByte.setTextMatrix(50, 745);
		pageContentByte.showText(job_number + " Date " + currentTime);
		pageContentByte.endText();
	
		// Add signature image
		PdfContentByte over = pdfStamper.getOverContent(i);
		Image imagesign = Image.getInstance(sign_path + report_approved_by_id + ".jpg");
		imagesign.scaleToFit(80.0F, 80.0F);
		imagesign.setAbsolutePosition(50, 760);
		over.addImage(imagesign);
	
		// Add QR code
		BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(job_number, 1000, 1000, null);
		Image codeQrImage1 = barcodeQRCode1.getImage();
		codeQrImage1.scaleAbsolute(80, 80);
		codeQrImage1.setAbsolutePosition(500, 750);
		over.addImage(codeQrImage1);
	}
	
		// 7. CLOSE the stamper to save changes!
		pdfStamper.close();
		s_pdfReader.close();
				return stampedOutputStream.toByteArray();
				//return "ok";
			
		
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {

			// release resources, if any
			// outputStream.close();
			// response_ws.close();
			// client.close();

		}
	return out_pdf.toByteArray();
	}

	public byte[] create_search_report_pvlmd_old(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String fullname,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(450, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */
			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 690);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 18);
			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			// cbaddress.setTextMatrix(230, 750);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
					new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Original);

			Paragraph reportTitle_JOB = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_JOB.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_JOB);
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			/*
			 * Paragraph reportTitle = new Paragraph("LANDS COMMISSION", new
			 * Font(FontFamily.TIMES_ROMAN, 14));
			 * reportTitle.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle);
			 */
			Paragraph reportTitle_O = new Paragraph("PUBLIC AND VESTED LAND MANAGEMENT DIVISION - SEARCH",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_O.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_O);
			Paragraph reportTitle_1 = new Paragraph(
					"A Search is requested against the land delineated on the plan attached.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_1);
			/*
			 * Paragraph reportTitle_2 = new
			 * Paragraph("(b) Comprised in the following instrument", new
			 * Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2);
			 */
			Paragraph reportTitle_Line1 = new Paragraph(
					"_____________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line1.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line1);
			Paragraph reportTitle_3 = new Paragraph(
					"PURPOSE                                                                       "
							+ "RECORDED TRANSACTION(S)",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_3);
			Paragraph reportTitle_Line2 = new Paragraph(
					"_______________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line2);
			Paragraph reportTitle_Name = new Paragraph("NAME AND ADDRESS OF ENQUIRER : ",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Name.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_Name);

			Paragraph reportTitle_Name1 = new Paragraph(ar_name, new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			reportTitle_Name1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_Name1);

			Paragraph reportTitle_address = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 14));
			reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_address);
			Paragraph reportTitle_Line3 = new Paragraph(
					"_________________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line3.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line3);
			Paragraph reportTitle_note0 = new Paragraph("NOTE:-", new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note0.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note0);
			Paragraph reportTitle_note1 = new Paragraph(
					"(a) This form of search can be made against any piece of land situate in Ghana which is identified by r"
							+ "eference to an instrument registered in the Land Registry or a plan attached in duplicate.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note1);
			Paragraph reportTitle_note2 = new Paragraph(
					"(b) The instrument referred to above must have been executed and stamped subsequent to 1st October, 1"
							+ "946. Where more than one Deed affecting the land are known to have been since this date, only the ear"
							+ "liest in date should be mentioned.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note2.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note2);
			Paragraph reportTitle_note3 = new Paragraph(
					"(c) The Executive Secretary can accept no responsibility of any loss, which may be occasioned by reli"
							+ "ance on the report given below:",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note3.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note3);
			Paragraph reportTitle_note4 = new Paragraph(
					"(d) The report may be collected from the CSAU within the Premises of the Land Valuation Division of the Lands Commission near Cantonment Post Office (Ghana Post and Ghana Vodafone).",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note4.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note4);
			Paragraph reportTitle_Line4 = new Paragraph(
					"___________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line4.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line4);
			Paragraph reportTitle_note5 = new Paragraph(
					"The search applied for against the land edged red on the plan attached has been made with the followi"
							+ "ng result:- ",
					new Font(FontFamily.TIMES_ROMAN, 1));
			reportTitle_note5.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note5);
			Paragraph reportTitle_note6 = new Paragraph(remark_or_comment1, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_note6.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note6);
			Paragraph reportTitle_Line5 = new Paragraph(
					"*******************************************************************************************************",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line5.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line5);
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date1);
			// String formatted_date_of_registration = formatter.format(date1);

			// System.out.println("Today : " + today);

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// System.out.println(dateFormat.format(date)); // 2016/11/16
			// 12:08:43

			Paragraph reportTitle3 = new Paragraph(dateFormat.format(date), new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle3.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle3);

			Paragraph reportsignpad = new Paragraph("...........................................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportsignpad.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportsignpad);

			Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
			reportoddicer.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportoddicer);

			Paragraph reportTitle4 = new Paragraph("FOR: EXECUTIVE SECRETRY", new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle4.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle4);
			Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle5.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle5);
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			/*
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * String cert_text2 = ""; cert_text2 += " Yours faithfully";
			 * 
			 * Paragraph p_3 = new Paragraph(cert_text2, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_3.setAlignment(Element.ALIGN_JUSTIFIED); p_3.setLeading(32);
			 * document.add(p_3);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * // document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_5 = new Paragraph("JOSEPH A. ARTHUR", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();
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

	public byte[] create_search_report_smd(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature, String fullname,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * document.add(new Phrase(Chunk.NEWLINE)); document.add(new
			 * Phrase(Chunk.NEWLINE)); document.add(new Phrase(Chunk.NEWLINE));
			 * document.add(new Phrase(Chunk.NEWLINE));
			 */
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			/*
			 * Paragraph reportTitle_Original = new
			 * Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN,
			 * 18, Font.BOLD));
			 * reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Original);
			 */
			Paragraph reportTitle_JOB = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_JOB.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_JOB);

			Paragraph reportTitle_CASE = new Paragraph("Case Number: " + case_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_CASE.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_CASE);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			/*
			 * Paragraph reportTitle = new Paragraph("LANDS COMMISSION", new
			 * Font(FontFamily.TIMES_ROMAN, 14));
			 * reportTitle.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle);
			 */

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// System.out.println(dateFormat.format(date)); // 2016/11/16
			// 12:08:43

			Paragraph reportTitle_DATE = new Paragraph(dateFormat.format(date), new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_DATE.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_DATE);

			Paragraph reportTitle_O = new Paragraph("SURVEY AND MAPPING DIVISION - SEARCH REPORT",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_O.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_O);

			/*
			 * Paragraph reportTitle_1 = new Paragraph(
			 * "A Search is requested against the land delineated on the plan attached."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_1);
			 */
			/*
			 * Paragraph reportTitle_2 = new
			 * Paragraph("(b) Comprised in the following instrument", new
			 * Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2);
			 */
			Paragraph reportTitle_Line1 = new Paragraph(
					"_____________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line1.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line1);

			/*
			 * Paragraph reportTitle_3 = new Paragraph(
			 * "PURPOSE                                                                       "
			 * + "RECORDED TRANSACTION(S)", new Font(FontFamily.TIMES_ROMAN,
			 * 12)); reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_3); Paragraph reportTitle_Line2 = new
			 * Paragraph(
			 * "_______________________________________________________________________________________________________",
			 * new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_Line2.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Line2);
			 */
			Paragraph reportTitle_Name = new Paragraph("NAME AND ADDRESS OF ENQUIRER : ",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_Name.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_Name);

			Paragraph reportTitle_Name1 = new Paragraph(ar_name, new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			reportTitle_Name1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_Name1);

			Paragraph reportTitle_address = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 14));
			reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_address);
			Paragraph reportTitle_Line3 = new Paragraph(
					"_________________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line3.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line3);
			Paragraph reportTitle_note0 = new Paragraph("NOTE:-", new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note0.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note0);
			Paragraph reportTitle_note1 = new Paragraph(
					"(a) This search report from Survey and Mapping Division (SMD) does not in any way confer or confirm ownership or title to the land on the attcahed site plan shown edged pink. It may only indicate a stage in the land title registration process.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note1);
			Paragraph reportTitle_note2 = new Paragraph(
					"(b) The Director of SMD or his/her representative will not accept responsibility for any loss which may be occasioned by relience on the report given below.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note2.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note2);
			Paragraph reportTitle_note3 = new Paragraph(
					"(c) Any further enquiries are to be directed to the Director of SMD.",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_note3.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note3);
			/*
			 * Paragraph reportTitle_note4 = new Paragraph(
			 * "(d) The report may be collected from the CSAU within the Premises of the Land Valuation Division of the Lands Commission near Cantonment Post Office (Ghana Post and Ghana Vodafone)."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_note4.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_note4);
			 */
			Paragraph reportTitle_Line4 = new Paragraph(
					"___________________________________________________________________________________________________",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line4.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line4);
			Paragraph reportTitle_note5 = new Paragraph(
					"The search applied for against the land edged pink on the plan attached has been made with the followi"
							+ "ng results:- ",
					new Font(FontFamily.TIMES_ROMAN, 1));
			reportTitle_note5.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note5);

			/*
			 * Paragraph reportTitle_note6 = new Paragraph(remark_or_comment1,
			 * new Font(FontFamily.TIMES_ROMAN, 10));
			 * reportTitle_note6.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_note6);
			 */

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			Paragraph reportTitle_Line5 = new Paragraph(
					"*******************************************************************************************************",
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_Line5.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Line5);
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date1);
			// String formatted_date_of_registration = formatter.format(date1);

			// System.out.println("Today : " + today);

			// DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = new Date();
			// System.out.println(dateFormat.format(date)); // 2016/11/16
			// 12:08:43

			/*
			 * Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle3);
			 */
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			if (signature.equals("Yes")) {
				Paragraph reportsignpad = new Paragraph("...........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportsignpad.setAlignment(Element.ALIGN_LEFT);
				document.add(reportsignpad);

				Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				reportoddicer.setAlignment(Element.ALIGN_LEFT);
				document.add(reportoddicer);

				Paragraph reportTitle4 = new Paragraph("FOR: DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_LEFT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("SURVEY AND MAPPING DIVISION",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_LEFT);
				document.add(reportTitle5);
			}

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			/*
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * String cert_text2 = ""; cert_text2 += " Yours faithfully";
			 * 
			 * Paragraph p_3 = new Paragraph(cert_text2, new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_3.setAlignment(Element.ALIGN_JUSTIFIED); p_3.setLeading(32);
			 * document.add(p_3);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE)); // document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_4 = new
			 * Paragraph(".......................................", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_4.setAlignment(Element.ALIGN_CENTER); document.add(p_4);
			 * 
			 * // document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph p_5 = new Paragraph("JOSEPH A. ARTHUR", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();
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

	public byte[] create_search_report_lrd(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature, String fullname,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(60, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(440, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(440, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(440, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(440, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(440, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(440, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(440, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 670);
			canvas.lineTo(700, 670);
			canvas.closePathStroke();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
					new Font(FontFamily.TIMES_ROMAN, 22, Font.BOLD));
			reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Original);

			Paragraph reportTitle_OriginaL2 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_OriginaL2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_OriginaL2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_JOB = new Paragraph("My Ref No: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB);

			Paragraph reportTitle_JOB_1 = new Paragraph("Your Ref No: ", new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB_1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB_1);

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// ystem.out.println(dateFormat.format(date));

			/*
			 * Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle3);
			 */

			Paragraph reportTitle_Date = new Paragraph("Date: " + dateFormat.format(date),
					new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
			reportTitle_Date.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_Date);

			Paragraph reportTitle_JOB_2 = new Paragraph(ar_name.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
			reportTitle_JOB_2.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB_2);

			Paragraph reportTitle_address = new Paragraph(client_address.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 10, Font.BOLD));
			reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_address);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_salutation = new Paragraph("Dear Sir/Madam: ", new Font(FontFamily.TIMES_ROMAN, 11));
			reportTitle_salutation.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_salutation);

			document.add(new Phrase(Chunk.NEWLINE));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			/*
			 * Paragraph reportTitle_O = new
			 * Paragraph("RE: OFFICIAL SEARCH ON LAND SITUATE AT " + locality +
			 * " IN EXTENT " + size_of_land + " FOR " + ar_name, new
			 * Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			 * reportTitle_O.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_O);
			 * 
			 * Paragraph reportTitle_Line1 = new Paragraph(
			 * "_____________________________________________________________________________________________",
			 * new Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_Line1.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Line1);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_1 = new Paragraph("", new
			 * Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_1);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_2 = new Paragraph(remark_or_comment1, new
			 * Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_3 = new
			 * Paragraph("Copy of the site plan attached for ease of reference."
			 * , new Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_3); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_4 = new Paragraph(
			 * "Please note that for details of the registered Certificate, you may purchase a Certificate Search Form from the Client Service Access Unit of the Lands Commission to enable you obtain further information."
			 * , new Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_4.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_4);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_5 = new Paragraph("Yours Faithfully,", new
			 * Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_5.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_5);
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportsignpad = new Paragraph("...........................................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportsignpad.setAlignment(Element.ALIGN_LEFT);
			document.add(reportsignpad);

			if (signature.equals("Yes")) {

				Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				reportoddicer.setAlignment(Element.ALIGN_LEFT);
				document.add(reportoddicer);

				Paragraph reportTitle4 = new Paragraph("FOR: DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_LEFT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_LEFT);
			}

			document.close();
			//file.close();
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

	public byte[] create_search_report_police(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature, String fullname,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(450, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */
			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 690);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 18);
			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			// cbaddress.setTextMatrix(230, 750);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
					new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Original);

			Paragraph reportTitle_OriginaL2 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_OriginaL2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_OriginaL2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_JOB = new Paragraph("My Ref No: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB);

			Paragraph reportTitle_JOB_1 = new Paragraph("Your Ref No: ", new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB_1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB_1);

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// ystem.out.println(dateFormat.format(date));

			/*
			 * Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle3);
			 */

			Paragraph reportTitle_Date = new Paragraph("Date: " + dateFormat.format(date),
					new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_Date.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_Date);

			Paragraph reportTitle_address = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_address);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_salutation = new Paragraph("Dear Sir/Madam: ", new Font(FontFamily.TIMES_ROMAN, 11));
			reportTitle_salutation.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_salutation);

			document.add(new Phrase(Chunk.NEWLINE));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			/*
			 * Paragraph reportTitle_O = new Paragraph("RE: REQUEST FOR SEARCH",
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle_O.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_O);
			 * 
			 * Paragraph reportTitle_Line1 = new Paragraph(
			 * "_____________________________________________________________________________________________________",
			 * new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_Line1.setAlignment(Element.ALIGN_CENTER);
			 * document.add(reportTitle_Line1);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * 
			 * Paragraph reportTitle_2 = new Paragraph(remark_or_comment1, new
			 * Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_3 = new
			 * Paragraph("Copy of the site plan attached for ease of reference."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_3); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_4 = new Paragraph(
			 * "Please note that for details of the registered Certificate, you may purchase a Certificate Search Form from the Client Service Access Uint of the Land Commission to enable you obtain further information."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_4.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_4);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_5 = new Paragraph("Yours Faithfully,", new
			 * Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_5.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_5);
			 */

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			if (signature.equals("Yes")) {

				Paragraph reportsignpad = new Paragraph("...........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportsignpad.setAlignment(Element.ALIGN_LEFT);
				document.add(reportsignpad);

				Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				reportoddicer.setAlignment(Element.ALIGN_LEFT);
				document.add(reportoddicer);

				Paragraph reportTitle4 = new Paragraph("FOR: DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_LEFT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_LEFT);

			}

			document.close();
			//file.close();
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

	public byte[] create_search_report_lrd_2(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature, String fullname,
			String designation, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");
		//String certificate_approved_by_name = (String) case_obj.getString("certificate_approved_by_name");


		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		
		
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();
        String created_date = (String) job_detail_obj.get("created_date").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 50, 50, 10, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			
			HeaderFooterPageEvent event = new HeaderFooterPageEvent();
			event.extraValue = job_number;
			writer.setPageEvent(event);
			
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(450, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */
			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 690);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

		//	document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 18);
			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			// cbaddress.setTextMatrix(230, 750);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
					new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Original);

			Paragraph reportTitle_OriginaL2 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_OriginaL2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_OriginaL2);

			document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph reportTitle_JOB = new Paragraph("My Ref No: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			// reportTitle_JOB.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_JOB);

			// Paragraph reportTitle_JOB_1 = new Paragraph("Your Ref No: ", new Font(FontFamily.TIMES_ROMAN, 10));
			// reportTitle_JOB_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_JOB_1);
			document.add(new Phrase(Chunk.NEWLINE));
			//document.add(new Phrase(Chunk.NEWLINE));

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// ystem.out.println(dateFormat.format(date));

			/*
			 * Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle3);
			 */

			Paragraph reportTitle_Date = new Paragraph("Date: " + dateFormat.format(date),
					new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_Date.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_Date);

			/*
			 * Paragraph reportTitle_address = new Paragraph(client_address, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_address);
			 */
			Paragraph reportTitle_title = new Paragraph("OFFICIAL CERTIFICATE OF THE RESULT OF SEARCH",
						new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			reportTitle_title.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_title);

			//document.add(new Phrase(Chunk.NEWLINE));


			
			Paragraph reportTitle_JOB = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));

			reportTitle_JOB.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_JOB);

			document.add(new Phrase(Chunk.NEWLINE));
			/*
			 * Paragraph reportTitle_1 = new Paragraph(
			 * "A Search is requested against the land delineated on the plan attached."
			 * , new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(created_date);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Paragraph reportTitle_note = new Paragraph(
					"To: " + ar_name.toUpperCase() + ", " + client_address.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_note.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note);


			Paragraph reportTitle_note1 = new Paragraph(
					"Pursuant to your application dated "  + specialNamesMonthDay_short[day_c] + " day of "
							+ convertToTitleCaseIteratingChars(month_c.toString()) + ", " + year_c + " made by "
							+ ar_name.toUpperCase() + ", " + client_address.toUpperCase() 
							+ ", a search has been made against the Land Certificate Number " + certificate_number
							+ " with the following result:",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_note1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note1);

			document.add(new Phrase(Chunk.NEWLINE));

			//HTMLWorker htmlWorker = new HTMLWorker(document);
			//htmlWorker.parse(new StringReader(remark_or_comment1));

			// Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			// Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			//document.add(new Phrase(Chunk.NEWLINE));


            // Create a StyleSheet and set line spacing
            StyleSheet styles = new StyleSheet();
            styles.loadTagStyle("body", "leading", "5"); // Set line spacing (leading) to 20


			//HTMLWorker htmlWorker = new HTMLWorker(document);
			//htmlWorker.parse(new StringReader(remark_or_comment_bob));

  			// Define your CSS for Times New Roman and justified text
 			 String css = "body { font-family: Times New Roman; text-align: justify; }";

  			// Use XMLWorkerHelper to parse HTML and apply CSS
  			//XMLWorkerHelper.getInstance().parseXHtml(writer, document, new StringReader(htmlContent), new StringReader(css));

			Font timesNewRoman = FontFactory.getFont(FontFactory.TIMES_ROMAN, 11, Font.NORMAL);

			//String htmlContent = "<html><body><p>THIS IS TO CERTIFY THAT Sam of Accra in the Greater Accra Region of the Republic of Ghana is registered as tenant or lessee for the unexpired residue of a lease for a term of 99 years from the  twenty seventh day of September, 2023 subject to the reservation, restrictions, encumbrances, liens and interests as are notified by memorial underwritten or endorsed hereon, of and in ALL THAT piece or Parcel of land in extent 0.230 more or less being GLPIN No. GA329393-1148882, SECTION 024 BLOCK 123, situate at AJANGORTEY in the Greater Accra Region of the Republic of Ghana aforesaid which said piece or parcel of land is more particularly delineated on Registry Map No. 79ui in the Lands Commission, Cantonment Accra, and being the piece or parcel of land shown and edged with pink color on Survey Plan No. 7899 annexed to this Certificate except and reserved all minerals, oils, precious stones and timber whatsoever upon or under the said piece or parcel of land..</p></body></html>";
			
			
			//remark_or_comment_bob
			//remark_or_comment_bob

// Replace a value in the string
remark_or_comment1= remark_or_comment1.replace("<ol><li>", "<html><body><p>");
remark_or_comment1= remark_or_comment1.replace("</li></ol>", "</p></body></html>");

// Output the result
//System.out.println(updatedString);  // Output: "This is the new comment."
            // // Parse the HTML content
             java.util.List<Element> elements = HTMLWorker.parseToList(new StringReader(remark_or_comment1), styles);


			  // Process the parsed elements
			  for (Element element : elements) {
				if (element instanceof Paragraph) {
					// Create a new Paragraph from the original one and set the font and alignment
					Paragraph originalParagraph = (Paragraph) element;
					Paragraph newParagraph = new Paragraph(originalParagraph.getContent(), timesNewRoman);
					newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
					newParagraph.setLeading(15f); 
					newParagraph.setSpacingAfter(10f);  // Add spacing after each paragraph
					document.add(newParagraph);
					System.out.println("Par 1");
				} else if (element instanceof Phrase) {
					// Create a new Paragraph from the Phrase and apply formatting
					Phrase originalPhrase = (Phrase) element;
					Paragraph newParagraph = new Paragraph(originalPhrase.getContent(), timesNewRoman);
					newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
					newParagraph.setLeading(30f); 
					newParagraph.setSpacingAfter(20f);  // Add spacing after each paragraph
					document.add(newParagraph);
					System.out.println("Par 2");
				} else if (element instanceof Chunk) {
					// Create a new Chunk and apply font
					Chunk originalChunk = (Chunk) element;
					Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);
   System.out.println("Chunk ");

// // Convert the Chunk to a Paragraph to control line spacing
// Chunk originalChunk = (Chunk) element;
// Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);

// // Create a new Paragraph with the Chunk and set line spacing
// Paragraph paragraph = new Paragraph(newChunk);
// paragraph.setLeading(15f); // Set the line spacing, adjust the value as needed

// // Add the Paragraph (with line spacing) to the document
// document.add(paragraph);
					document.add(newChunk);
				} else {
					// For other types of elements, just add them without changes
					document.add(element);
				}
			}



			 LocalDateTime myDateObj = LocalDateTime.now();
             //System.out.println("Before formatting: " + myDateObj);
              DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");

             String formattedDate = myDateObj.format(myFormatObj);
              //System.out.println("After formatting: " + formattedDate);


		//	document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph reportTitle_7 = new Paragraph(
			// 		"The seal of this Registry was affixed to this Certificate at the hour of " + formattedDate,
			// 		new Font(FontFamily.TIMES_ROMAN, 14));
			// reportTitle_7.setAlignment(Element.ALIGN_LEFT);
			// document.add(reportTitle_7);

			LocalDateTime currentTime = LocalDateTime.now();
			SimpleDateFormat dateTimeInGMT = new SimpleDateFormat("dd-MMMM-yyyy hh:mm:ss aa");
			SimpleDateFormat dateTimeInGMT1 = new SimpleDateFormat("hh:mm:ss aa");
			// Setting the time zone
			dateTimeInGMT.setTimeZone(TimeZone.getTimeZone("GMT"));
			// Month month_c = currentTime.getMonth();
			// int day_c = currentTime.getDayOfMonth();
			// int year_c = currentTime.getYear();

			int year_c_d = currentTime.getYear();
			int month_c_d = currentTime.getMonthValue();
			int day_c_d = currentTime.getDayOfMonth();

			

			Paragraph reportTitle_7 = new Paragraph(
					"The Seal of this Registry was affixed to this Certificate at the hour of "
							+ dateTimeInGMT1.format(new Date()) + " on the " + specialNamesMonthDay_short[day_c_d]
							+ " day of " + getMonth[month_c_d] + ", " + year_c_d,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_7.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_7);


			document.add(new Phrase(Chunk.NEWLINE));

			
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			if (signature.equals("Yes")) {


				if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {
					//if ( !certificete_approval_status.equals("0") && !certificete_approval_status.equals("null") && certificete_approval_status.equals("1") ) {
	
					File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
					if (file1.exists() && !file1.isDirectory()) {
						Image image_sig = Image
								.getInstance(software_file_location + certificate_approved_by + ".jpg");
						// imgPDF2.ScaleToFit(100.0F, 70.0F)
						image_sig.scaleToFit(100.0F, 100.0F);
						image_sig.setAlignment(Element.ALIGN_RIGHT);
	
						document.add(image_sig);
	
					} else {
						Paragraph y_tna = new Paragraph("Approved",
								new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
						y_tna.setAlignment(Element.ALIGN_RIGHT);
						document.add(y_tna);
					}
	
				} else {
	
					Paragraph y_tna = new Paragraph("Report Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_RIGHT);
					document.add(y_tna);
				}
				Paragraph reportsignpad = new Paragraph("...........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportsignpad.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportsignpad);

				//Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				//Paragraph reportoddicer = new Paragraph(certificate_approved_by_name, new Font(FontFamily.TIMES_ROMAN, 12));
				//
				// reportoddicer.setAlignment(Element.ALIGN_RIGHT);
				// document.add(reportoddicer);

				/*
				 * Paragraph reportoddicer_design = new Paragraph(designation,
				 * new Font(FontFamily.TIMES_ROMAN, 12));
				 * reportoddicer_design.setAlignment(Element.ALIGN_LEFT);
				 * document.add(reportoddicer_design);
				 */

				Paragraph reportTitle4 = new Paragraph("FOR: CHIEF REGSTRAR OF LANDS", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_RIGHT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("LAND REGISTRATION DIVISION",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_RIGHT);

				document.add(new Phrase(Chunk.NEWLINE));
			}


			Paragraph reportTitle_JOB1 = new Paragraph("Job Number: " + job_number,
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_JOB1.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_JOB1);

	document.add(new Phrase(Chunk.NEWLINE));

				Paragraph reportTitle_8 = new Paragraph(
					"CAVEAT: Applicant is hereby notified that this result of this search only confirms that this particular parcel of land has been duly registered.",
					new Font(FontFamily.TIMES_ROMAN, 11));
			reportTitle_8.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_8);

		

			/*
			 * Paragraph reportTitle_8 = new Paragraph(
			 * "CAVEAT: Applicant is hereby notified that the result of the search only confirms that the particular parcel of land has been duly registered. However that autority or otherwise of the Land Certificate can only be confirmed of the Original Land Cerfiacte is submitted for examination by the Director or his representative. Applicants therefore are advised to produce or submit the Original Land Certificate befire concluding any transaction involving thier Land Certifaicate."
			 * , new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle_8.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_8);
			 */

			document.close();
			//file.close();
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

	public byte[] create_search_report_lrd_2_old(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String signature,
			String fullname, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		// System.out.println("Result");
		// System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment1 = (String) job_detail_obj.get("remark_or_comment").toString();
		// String remark_or_comment =
		// (String)job_detail_obj.get("remark_or_comment").toString();

		// String job_number = (String) obj_main.getString("job_number");

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(450, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */
			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 690);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_BOLD, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 18);
			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			// cbaddress.setTextMatrix(230, 750);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new
			// Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			// Paragraph y_1 = new Paragraph("NOTICE OF SITE INSPECTION", new
			// Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// y_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph reportTitle_Original = new Paragraph("LANDS COMMISSION",
					new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			reportTitle_Original.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_Original);

			Paragraph reportTitle_OriginaL2 = new Paragraph("LAND REGISTRATION DIVISION",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_OriginaL2.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_OriginaL2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_JOB = new Paragraph("My Ref No: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB);

			Paragraph reportTitle_JOB_1 = new Paragraph("Your Ref No: ", new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_JOB_1.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_JOB_1);

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			// ystem.out.println(dateFormat.format(date));

			/*
			 * Paragraph reportTitle3 = new Paragraph(dateFormat.format(date),
			 * new Font(FontFamily.TIMES_ROMAN, 12));
			 * reportTitle3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle3);
			 */

			Paragraph reportTitle_Date = new Paragraph("Date: " + dateFormat.format(date),
					new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_Date.setAlignment(Element.ALIGN_RIGHT);
			document.add(reportTitle_Date);

			Paragraph reportTitle_address = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_address.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_address);

			Paragraph reportTitle_title = new Paragraph("OFFICIAL CERTIFICATE OF THE RESULT OF SEARCH",
					new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_title.setAlignment(Element.ALIGN_CENTER);
			document.add(reportTitle_title);

			Paragraph reportTitle_note = new Paragraph(
					"It is hereby certify that the official search applied for has been made with the following result: Since "
							+ dateFormat.format(date),
					new Font(FontFamily.TIMES_ROMAN, 10));
			reportTitle_note.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note);

			document.add(new Phrase(Chunk.NEWLINE));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment1));

			/*
			 * Paragraph reportTitle_salutation = new
			 * Paragraph("Description of Land: " + "", new
			 * Font(FontFamily.TIMES_ROMAN, 11));
			 * reportTitle_salutation.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_salutation);
			 * 
			 * Paragraph reportTitle_1 = new Paragraph("Proprietor:  " +
			 * ar_name, new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_1.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_1);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_2 = new Paragraph("Date of Registration:  "
			 * + date_of_registration, new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_2.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_2); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_3 = new Paragraph("Nature of Instrument:  "
			 * + nature_of_instrument, new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_3.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_3); document.add(new
			 * Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_4 = new Paragraph("Certificate Number:  " +
			 * certificate_number, new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_4.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_4);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_5 = new Paragraph("Encumbrance:  " +
			 * "NILL", new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_5.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_5);
			 * 
			 * document.add(new Phrase(Chunk.NEWLINE));
			 * 
			 * Paragraph reportTitle_6 = new Paragraph("Registered Number:  " +
			 * certificate_number, new Font(FontFamily.TIMES_ROMAN, 9));
			 * reportTitle_6.setAlignment(Element.ALIGN_LEFT);
			 * document.add(reportTitle_6);
			 */
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph reportTitle_7 = new Paragraph(
					"The Seal of this Registry was affixed to Land Certificate on " + date,
					new Font(FontFamily.TIMES_ROMAN, 9));
			reportTitle_7.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_7);

			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			if (signature.equals("Yes")) {
				Paragraph reportsignpad = new Paragraph("...........................................................",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportsignpad.setAlignment(Element.ALIGN_LEFT);
				document.add(reportsignpad);

				Paragraph reportoddicer = new Paragraph(fullname, new Font(FontFamily.TIMES_ROMAN, 12));
				reportoddicer.setAlignment(Element.ALIGN_LEFT);
				document.add(reportoddicer);

				Paragraph reportTitle4 = new Paragraph("FOR: DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle4.setAlignment(Element.ALIGN_LEFT);
				document.add(reportTitle4);
				Paragraph reportTitle5 = new Paragraph("LAND REGISTRATION DIVISION",
						new Font(FontFamily.TIMES_ROMAN, 12));
				reportTitle5.setAlignment(Element.ALIGN_LEFT);

				document.add(new Phrase(Chunk.NEWLINE));
			}

			Paragraph reportTitle_8 = new Paragraph(
					"CAVEAT: Applicant is hereby notified that the result of the search only confirms that the particular parcel of land has been duly registered. However that autority or otherwise of the Land Certificate can only be confirmed of the Original Land Cerfiacte is submitted for examination by the Director or his representative. Applicants therefore are advised to produce or submit the Original Land Certificate befire concluding any transaction involving thier Land Certifaicate.",
					new Font(FontFamily.TIMES_ROMAN, 12));
			reportTitle_8.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_8);

			document.close();
			//file.close();
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

	public byte[] create_inspection_letter(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String ir_business_process_sub_name,
			String login_user, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		System.out.println(request_json.toString());
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_8 = new Paragraph("CASE NUMBER: " + new_case_number,
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p_8);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_1 = new Paragraph(ar_name, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_1);

			Paragraph y_2 = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_2.setAlignment(Element.ALIGN_LEFT);
			document.add(y_2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_3 = new Paragraph("Dear Sir/Madam,", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_3.setAlignment(Element.ALIGN_LEFT);
			document.add(y_3);

			Paragraph y_4 = new Paragraph("NOTICE OF SITE INSPECTION", new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			y_4.setAlignment(Element.ALIGN_CENTER);
			document.add(y_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("Reference the " + ir_business_process_sub_name + " of land situate at ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(locality, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(
					" The office wishes to bring to your notice a pending site inspection that needs to be conducted on your site in order to facilitate your "
							+ ir_business_process_sub_name + ".",
					small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					" Kindly visit our Office to see the undersigned officer for further directives upon receipt of this letter during working hours.",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			Chunk st6 = new Chunk(
					" Please adhere to this directive to enable the Office continue with your application.", small);
			st6.setTextRise(7);
			p_2.add(st6);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += " Yours faithfully";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p_5);

			document.close();
			//file.close();
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

	public byte[] create_general_letters_templates(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String leter_details,
			String login_user, String designation, String letter_cc, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			cbaddress.setTextMatrix(50, 720);
			cbaddress.showText("My Ref No: " +
					job_number);

			cbaddress.setTextMatrix(50, 700);
			cbaddress.showText("Your Ref No: " +
					"");

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));

			leter_details = "<p style='font-family: Times, serif !important;'>" + leter_details + "</p>";
			System.out.println("html: " + leter_details);
			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(leter_details));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_6 = new Paragraph("FOR: DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_LEFT);
			document.add(p_6);

			Paragraph p_5 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p_5);

			Paragraph p_8 = new Paragraph(designation, new Font(FontFamily.TIMES_ROMAN, 12));
			p_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p_8);

			// System.out.println("CC: " + letter_cc);
			if (!letter_cc.equals("none") || letter_cc.length() > 4) {
				document.add(new Phrase(Chunk.NEWLINE));
				Paragraph p_9 = new Paragraph("CC: " + letter_cc, new Font(FontFamily.TIMES_ROMAN, 12));
				p_9.setAlignment(Element.ALIGN_LEFT);
				document.add(p_9);

				/*
				 * Paragraph p_10 = new Paragraph(letter_cc, new
				 * Font(FontFamily.TIMES_ROMAN, 12));
				 * p_10.setAlignment(Element.ALIGN_LEFT); document.add(p_8);
				 */
			}

			document.close();
			//file.close();
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

	public byte[] create_planning_comments_letter(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number,
			String ir_business_process_sub_name, String login_user, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);
		// String client_address = (String) obj.getString("client_address");

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_8 = new Paragraph("CASE NUMBER: " + new_case_number,
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p_8);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_1 = new Paragraph("THE MUNICIPAL DIRECTOR", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_1);

			Paragraph y_2 = new Paragraph("PHYSICAL PLANNING DEPARTMENT",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_2.setAlignment(Element.ALIGN_LEFT);
			document.add(y_2);

			Paragraph y_2_1 = new Paragraph("AYAWASO EAST MUNICIPAL", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_2_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_2_1);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_3 = new Paragraph("Dear Sir/Madam,", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_3.setAlignment(Element.ALIGN_LEFT);
			document.add(y_3);

			Paragraph y_4 = new Paragraph("REQUEST FOR PLANNING COMMENTS ",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			y_4.setAlignment(Element.ALIGN_CENTER);
			document.add(y_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("The above subject matter refers", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(
					"The publict and Vested Lands Management Division (PVLMD) is considering the subject matter.",
					small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(
					" I am directed to request for your comments on the zonning of the subject and its conformity to the approved planning scheme for the area. "
							+ ir_business_process_sub_name + ".",
					small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(" counting on your co-operation.", small);
			st3.setTextRise(7);
			p_2.add(st3);

			Chunk st6 = new Chunk(" Thank you.", small);
			st6.setTextRise(7);
			p_2.add(st6);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += " Yours faithfully";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p_5);

			Paragraph p_5_1 = new Paragraph("FOR: REGIONAL LANDS OFFICER", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5_1.setAlignment(Element.ALIGN_LEFT);
			document.add(p_5_1);

			document.close();
			//file.close();
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

	public byte[] create_offer_letter(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String ir_business_process_sub_name,
			String login_user, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_offer_letter(web_service_url,
						web_service_api_key,
						request_json.toString());

System.out.println("request_json");
System.out.println(request_json.toString());

System.out.println("case_records");
System.out.println(case_records);
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));
			// Paragraph p_8 = new Paragraph("CASE NUMBER: " + new_case_number,
			// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_8.setAlignment(Element.ALIGN_LEFT);
			// document.add(p_8);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			
			Paragraph reportTitle_note = new Paragraph(
					"To: " + ar_name.toUpperCase() + ", " + client_address.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_note.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note);

			Paragraph y_1 = new Paragraph(client_address.toUpperCase(), new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_1);

			

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_2 = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_2.setAlignment(Element.ALIGN_LEFT);
			document.add(y_2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_3 = new Paragraph("Dear Sir/Madam,", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_3.setAlignment(Element.ALIGN_LEFT);
			document.add(y_3);
			
			Paragraph y_41 = new Paragraph(
					"WITHOUT PREJUDICE",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.UNDERLINE));
			y_41.setAlignment(Element.ALIGN_LEFT);
			document.add(y_41);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4 = new Paragraph(
					"RE: APPLICATION FOR REGULARISATION - LAND SITUATE AT FRAFRAHA - SITE FOR ANIMAL RESEARCH INSTITUTE, 1976 (E.I. 38)",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.UNDERLINE));
			y_4.setAlignment(Element.ALIGN_CENTER);
			document.add(y_4);

			 document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph y_4_21 = new Paragraph(
				"Application No. "+ job_number+ " applying for a lease is hereby referred.",
				new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL));
				y_4_21.setAlignment(Element.ALIGN_LEFT);
		document.add(y_4_21);

		document.add(new Phrase(Chunk.NEWLINE));


		Paragraph y_4_2_1 = new Paragraph(
				"I am pleased to inform you that your application for a lease within the Animal Research Local Development Plan, New Legon, has been approved by the Lands Commission at its Meeting held on __________ September, 2021.",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_2_1.setAlignment(Element.ALIGN_JUSTIFIED);
		document.add(y_4_2_1);

		document.add(new Phrase(Chunk.NEWLINE));

		Paragraph y_4_2_2 = new Paragraph(
				"The Commission has directed that Plot No. __________ situated with the above referred planning scheme, Accra, covering an approximate area of _____ acre, and shown edged pink on the attached site plan, be allocated to you under the following terms and conditions:",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_2_2.setAlignment(Element.ALIGN_JUSTIFIED);
		document.add(y_4_2_2);

		document.add(new Phrase(Chunk.NEWLINE));

		Paragraph y_4_2_3 = new Paragraph(
			"1. Lease Term: The lease term shall be for a period of _____ years, commencing from the date of execution of the lease agreement. \n" + //
			"2. Rent: The annual ground rent payable for the leased property shall be _____, payable quarterly in advance. \n" + //
			"3. Use of Land: The leased property shall be used solely for ____________the purposes; \n" + //
			"4. Compliance: The lessee shall comply with all applicable laws and regulations in relation to the use of the leased property. \n" + //
			"5. The lease will contain further terms and conditions, which are usually embodied in Government leases.",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_2_3.setAlignment(Element.ALIGN_JUSTIFIED);
		document.add(y_4_2_3);

		document.add(new Phrase(Chunk.NEWLINE));

		Paragraph y_4_2_4 = new Paragraph(
			"Payment of the following fees is mandatory upon acceptance of this offer.",
			new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_4_2_4.setAlignment(Element.ALIGN_LEFT);
			document.add(y_4_2_4);

	//document.add(new Phrase(Chunk.NEWLINE));


		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);
		// Left aLign
		table.setTotalWidth((float) 300.0);
		;
		table.setHorizontalAlignment(0);
		table.setSpacingAfter(10);
		table.setTotalWidth(new float[] { 20, 120, 100 });

		// PdfPCell cell = new PdfPCell(new Phrase("Details of Fees", font10pt));
		// cell.setColspan(4);
		// cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		// // cell.setPadding(10.0f);
		// cell.setBackgroundColor(new BaseColor(140, 221, 8));
		// table.addCell(cell);
		

		table.addCell(new PdfPCell(new Phrase("S/N", font10pt)));
		//table.addCell("Bill Item Number");
		table.addCell(new PdfPCell(new Phrase("Description", font10pt)));
		table.addCell(new PdfPCell(new Phrase("Amount (GHS)", font10pt)));
		// table.addCell("Division");

		Integer NumberCount = 1;

		String bill_details = (String) case_obj.getString("bills");

		JSONArray jArr = new JSONArray(bill_details);
		for (int i = 0; i < jArr.length(); i++) { // JSONObject obj = new
			// JSONObject(bill_details);

			JSONObject obj = jArr.getJSONObject(i);
			System.out.println(obj.toString());

			table.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font10pt)));
		//	table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_number"), font10pt)));
			table.addCell(new PdfPCell(new Phrase((String) obj.getString("customer_id"), font10pt)));
			table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_amount"), font10pt)));
			// table.addCell(new PdfPCell(new Phrase((String)
			// obj.getString("division"), font10pt)));

			NumberCount++;
		}

		double total_amount = ((Double) case_obj.getDouble("total_bill") );

	
		// table.addCell(new PdfPCell(new Phrase("2", font10pt)));
		// table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
		// table.addCell(new PdfPCell(new Phrase("Service Charge", font10pt)));
		
		// String ssc = String.format("%.2f", (Double) case_obj.getDouble("total_bill"));
		
		// table.addCell(new PdfPCell(new Phrase(ssc, font10pt)));
		// table.setSpacingBefore(5.0f);

		table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
		//table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
		table.addCell(new PdfPCell(
				new Phrase("Total Amount", font10pt)));
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

			Paragraph y_4_3_1 = new Paragraph(
					"Please ensure that all payments are promptly made to Bank Account Number ………………………. at OmniBSic Bank no later than (Date) in order to finalize the lease agreement in your favor. Ground rent payments thereafter should be made directly to the Lands Commission until the lease term expires.",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_1);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4_3_2 = new Paragraph(
					"You are required to indicate your acceptance of this offer within by [                ] 14 days from the date of this letter. ",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_2.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4_3_3 = new Paragraph(
					"If this offer is not accepted and the required payments are not made by the due date, it will be deemed as a rejection of the offer. The Commission will then proceed to take appropriate legal actions to reclaim ownership of the plot referenced above in accordance with the laws of Ghana.",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_3.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_3);


			// Paragraph y_4_1 = new Paragraph("Term: " + term,
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL));
			// y_4_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_4_1);


			// Paragraph y_4_12 = new Paragraph("Commencement: "+ commencement_date,
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL));
			// 		y_4_12.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_4_12);


			document.add(new Phrase(Chunk.NEWLINE));
			
			
			



			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("Please communicate your written acceptance to the Lands Commission by registered post or courier service not later than three (3) months from the date herein. ",
					small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(locality, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk("All payments, payable in three separate instalments, must be made to the Bank of Ghana into the “PDB ACCOUNT” (ACCOUNT NUMBER ……………………….) within three (3) months from the date of this letter, before a lease will be engrossed in your favour Subsequent payment of the ground rent will be made to the Lands Commission till the expiration of the lease term.",
					small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					"All recipients of the offer letters should note that securing an offer letter does not guarantee an acquisition of lease document. The lease will contain terms and conditions, which are usually embodied in Government leases.",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			Chunk st6 = new Chunk("If We do not hear from you by the specified date nor receive your remittance for the fees and charges, it shall be assumed that you are not interested in regularising your occupation on the said site and this offer shall lapse and the Commission reserves the right to invoke the powers under Section 236 of the Land Act, 2020 (Act 103) to initiate legal action to repossess the property without any further reference to you.", small);
			st6.setTextRise(7);
			p_2.add(st6);

			// Chunk st6_ = new Chunk(" ii.	Lease Preparation:       One Thousand Cedis (GHS 1,00.00)", small);
			// st6_.setTextRise(7);
			// p_2.add(st6_);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			//document.add(p_2);

			// Paragraph y_5 = new Paragraph(
			// 		"4.	The Premium may be paid by Banker�s Draft in favour of �LANDS COMMISSION�. The Administrative fees and charges may also be paid by Cash.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_5.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_5);

			// Paragraph y_6 = new Paragraph(
			// 		"5.	The lease shall embody such terms and conditions as are usually included in lease of State Lands of this nature and such other covenants the Government may choose to include.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_6.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_6);

			// Paragraph y_7 = new Paragraph(
			// 		"6.	The site is yet to be surveyed and demarcated. The plan attached is indicative only for the purpose initiating the allocation process. The final cadastral plan will be incorporated into the formal lease to be engrossed for you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_7.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_7);

			// Paragraph y_8 = new Paragraph(
			// 		"In order that you do not trespass unto other adjoining properties, an authorized Surveyor of the Lands Commission shall be detailed to demarcate and show to you the boundaries of the land allocated to you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_8.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_8);

			// Paragraph y_9 = new Paragraph(
			// 		"ALLOCATION OF GOVERNMENT LAND IN THE ADENTAN BUSINESS DISTRICT � ADENTA (RESIDENTIAL)",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_9.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_9);

			// Paragraph y_10 = new Paragraph(
			// 		"7.	These terms and conditions are subject to the necessary written agreement being entered into between the Government and yourself, and on that understanding, your unqualified acceptance of this offer by REGISTERED POST or COURIER SERVICE or HAND DELIVERY not later than two months from the date hereof and also receive your remittance for all the fees and charges stated above by the same date. ",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_10.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_10);

			// Paragraph y_11 = new Paragraph(
			// 		"8.	If we do not hear from you by the said date nor receive your remittance for the fees and charges, it shall be assumed that you are not interested in the land and this offer shall laps and recommended for re-allocation to another suitable applicant without any further reference to you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_11.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_11);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += " Yours faithfully, ";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_12 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_12.setAlignment(Element.ALIGN_LEFT);
			document.add(p_12);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_13 = new Paragraph("TIMOTHY ANYIDOHO", new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			p_13.setAlignment(Element.ALIGN_LEFT);
			document.add(p_13);

			// Paragraph p_13 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			// p_13.setAlignment(Element.ALIGN_LEFT);
			// document.add(p_13);

			

			Paragraph p_14 = new Paragraph("Ag. REGIONAL LANDS OFFICER", new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			p_14.setAlignment(Element.ALIGN_LEFT);
			document.add(p_14);

			document.close();
			//file.close();
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





	public byte[] create_offer_letter_external(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String ir_business_process_sub_name,
			String login_user, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_offer_letter(web_service_url,
						web_service_api_key,
						request_json.toString());

System.out.println("request_json");
System.out.println(request_json.toString());

System.out.println("case_records");
System.out.println(case_records);
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String json_offer_letter_fees = (String) case_obj.getString("offer_letter_fees");
		String client_address = (String) case_obj.getString("client_address");


		String date_of_payment = (String) case_obj.getString("date_of_payment");
		String ground_rent = (String) case_obj.getString("ground_rent");

		

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			// BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			// Image codeQrImage = barcodeQRCode.getImage();
			// codeQrImage.scaleAbsolute(80, 80);
			// codeQrImage.setAbsolutePosition(50, 730);
			// // codeQrImage.setAbsolutePosition(420, 690);
			// document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			// Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// // imgPDF2.ScaleToFit(100.0F, 70.0F)
			// image1.scaleToFit(100.0F, 100.0F);
			// image1.setAbsolutePosition(240, 730);
			// // image1.setAbsolutePosition(50, 670);
			// document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);
			Font font12pt = new Font(FontFamily.TIMES_ROMAN, 12);
			Font font12pt_bold = new Font(FontFamily.TIMES_ROMAN, 12);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			// cbaddress.setTextMatrix(400, 780);
			// cbaddress.showText(web_comp_address);
			// cbaddress.setTextMatrix(400, 770);
			// cbaddress.showText(web_city);
			// cbaddress.setTextMatrix(400, 760);
			// cbaddress.showText(("Tel: " + web_telephone));
			// cbaddress.setTextMatrix(400, 750);
			// cbaddress.showText(("Fax: " + web_fax_number));
			// cbaddress.setTextMatrix(400, 740);
			// cbaddress.showText(("Email: " + web_email));
			// cbaddress.setTextMatrix(400, 730);
			// cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			// PdfContentByte canvas = writer.getDirectContent();
			// canvas.moveTo(20, 690);
			// canvas.lineTo(700, 690);
			// canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			 document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// // document.add(new Phrase(Chunk.NEWLINE));
			// Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			// p_1.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));
			// Paragraph p_8 = new Paragraph("CASE NUMBER: " + new_case_number,
			// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// p_8.setAlignment(Element.ALIGN_LEFT);
			// document.add(p_8);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			
			Paragraph reportTitle_note = new Paragraph(
					"To: " + ar_name.toUpperCase(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			reportTitle_note.setAlignment(Element.ALIGN_LEFT);
			document.add(reportTitle_note);

			Paragraph y_1 = new Paragraph(client_address.toUpperCase(), new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_1);

			

			document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph y_2 = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			// y_2.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_3 = new Paragraph("Dear Sir/Madam,", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_3.setAlignment(Element.ALIGN_LEFT);
			document.add(y_3);
			
			Paragraph y_41 = new Paragraph(
					"WITHOUT PREJUDICE",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.UNDERLINE));
			y_41.setAlignment(Element.ALIGN_CENTER);
			document.add(y_41);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4 = new Paragraph(
					"REGULARIZATION OF OCCUPATION OF PARCEL OF LAND SITUATED AT FRAFRAHA - SITE FOR ANIMAL RESEARCH INSTITUTE, 1976 (E.I. 38)",
					new Font(FontFamily.TIMES_ROMAN, 14, Font.UNDERLINE));
			y_4.setAlignment(Element.ALIGN_CENTER);
			document.add(y_4);

			 document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph y_4_21 = new Paragraph(
				"Application No. "+ job_number+ " applying for a regularization is hereby referred.",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_21.setAlignment(Element.ALIGN_LEFT);
		document.add(y_4_21);

		document.add(new Phrase(Chunk.NEWLINE));


		Paragraph y_4_2_1 = new Paragraph(
				"I am pleased to inform you that your application for regularization of occupation within the Site for Animal Research-Revised Local Plan, Frafraha has been approved by the Lands Commission.",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_2_1.setAlignment(Element.ALIGN_JUSTIFIED);
		document.add(y_4_2_1);

		document.add(new Phrase(Chunk.NEWLINE));

		Paragraph y_4_2_2 = new Paragraph(
				"The Commission has further directed that Plot No. "+ plot_number +" situated within the above referred planning scheme covering an approximate area of "+size_of_land+" acre(s) and shown edged pink on the attached site plan be allocated to you under the following terms and conditions:",
				new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
				y_4_2_2.setAlignment(Element.ALIGN_JUSTIFIED);
		document.add(y_4_2_2);

		document.add(new Phrase(Chunk.NEWLINE));
		///String vr_ground_rent = String.format("%,.2f", ground_rent);

		// Paragraph y_4_2_3 = new Paragraph(
		// 	//"1. Lease Term: The lease term shall be for a period of "+term+" years, commencing from 1st January, 2024. \n" + //
		// "1. Lease Term: The lease term shall be for a period of "+"50"+" years, commencing from 1st January, 2024. \n" + //
		// 	"2. Rent: The annual ground rent payable for the leased property shall be GHS "+ ground_rent +", payable in advance. \n" + //
		// 	"3. Use of Land: The leased property shall be used for "+type_of_use+" purposes only; \n" + //
		// 	"4. Compliance: The lessee shall comply with all applicable laws and regulations in relation to the use of the leased property. \n" + //
		// 	"5. The lease will contain further terms and conditions, which are usually embodied in Government leases.",
		// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
		// 		y_4_2_3.setAlignment(Element.ALIGN_JUSTIFIED);
		// document.add(y_4_2_3);

		Paragraph y_4_2_3 = new Paragraph();
		y_4_2_3.setFont(new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
		y_4_2_3.setAlignment(Element.ALIGN_JUSTIFIED);

		// Adding the first part (bold text before the semicolon)
		Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
		Font normalFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

		// 1. Lease Term:
		y_4_2_3.add(new Chunk("1. Lease Term:", boldFont));
		y_4_2_3.add(new Chunk(" The lease term shall be for a period of 50 years, commencing from 1"));

		// Adding superscript 'st'
		Chunk superscriptChunk = new Chunk("st");
		superscriptChunk.setTextRise(5); // Adjust the vertical position for superscript
		superscriptChunk.setFont(new Font(Font.FontFamily.TIMES_ROMAN, 8, Font.NORMAL));
		y_4_2_3.add(superscriptChunk);

		// Adding the remaining text for 1st Lease Term
		y_4_2_3.add(new Chunk(" January, 2024.\n", normalFont));

		// 2. Rent:
		y_4_2_3.add(new Chunk("2. Rent:", boldFont));
		y_4_2_3.add(new Chunk(" The annual ground rent payable for the leased property shall be GHS "
				+ ground_rent + ", payable in advance.\n", normalFont));

		// 3. Use of Land:
		y_4_2_3.add(new Chunk("3. Use of Land:", boldFont));
		y_4_2_3.add(new Chunk(" The leased property shall be used for "
				+ type_of_use + " purposes only.\n", normalFont));

		// 4. Compliance:
		y_4_2_3.add(new Chunk("4. Compliance:", boldFont));
		y_4_2_3.add(new Chunk(" The lessee shall comply with all applicable laws and regulations in relation to the use of the leased property.\n", normalFont));

		// 5. Further terms:
		//y_4_2_3.add(new Chunk("5. Further terms:", boldFont));
		y_4_2_3.add(new Chunk("5. The lease will contain further terms and conditions, which are usually embodied in Government leases.", normalFont));

		// Adding the paragraph to the document
		document.add(y_4_2_3);

	//	document.add(new Phrase(Chunk.NEWLINE));

		double total_amount = ((Double) case_obj.getDouble("total_bill") );
String ssc1 = String.format("%,.2f", total_amount);

		Paragraph y_4_2_4 = new Paragraph(
			"6. The regularization offer is further subject to the payment of an amount of GHS "+ ssc1 +".",
			new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
			y_4_2_4.setAlignment(Element.ALIGN_LEFT);
			document.add(y_4_2_4);

	    // document.add(new Phrase(Chunk.NEWLINE));

		//document.add(new Phrase(Chunk.NEWLINE));

		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);
		// Left aLign
		table.setTotalWidth((float) 300.0);
		;
		table.setHorizontalAlignment(0);
		table.setSpacingAfter(10);
		table.setTotalWidth(new float[] { 20, 120, 100 });

		// PdfPCell cell = new PdfPCell(new Phrase("Details of Fees", font10pt));
		// cell.setColspan(4);
		// cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		// // cell.setPadding(10.0f);
		// cell.setBackgroundColor(new BaseColor(140, 221, 8));
		// table.addCell(cell);
		

		table.addCell(new PdfPCell(new Phrase("S/N", font12pt)));
		//table.addCell("Bill Item Number");
		table.addCell(new PdfPCell(new Phrase("Description", font12pt)));
		table.addCell(new PdfPCell(new Phrase("Amount (GHS)", font12pt)));
		// table.addCell("Division");

		Integer NumberCount = 1;

		//String bill_details = (String) case_obj.getString("bills");

		JSONArray jArr = new JSONArray(json_offer_letter_fees);
		for (int i = 0; i < jArr.length(); i++) { // JSONObject obj = new
			// JSONObject(bill_details);

			JSONObject obj = jArr.getJSONObject(i);
			System.out.println(obj.toString());

			table.addCell(new PdfPCell(new Phrase(NumberCount.toString(), font12pt)));
		//	table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_number"), font10pt)));
			table.addCell(new PdfPCell(new Phrase((String) obj.getString("bill_description"), font12pt)));
			
			double bill_amount_value = Double.parseDouble((String) obj.getString("bill_amount"));
		    String formatted_arears_amount = String.format("%,.2f", bill_amount_value);
			PdfPCell cell = new PdfPCell(new Phrase(formatted_arears_amount, font12pt));
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT); // Align content to the right
            table.addCell(cell);
			//table.addCell(new PdfPCell(new Phrase(formatted_arears_amount, font10pt)));
			// table.addCell(new PdfPCell(new Phrase((String)
			// obj.getString("division"), font10pt)));

			NumberCount++;
		}

		//double arears_amount_value = Double.parseDouble(arears_amount);

					// Format the amount to 2 decimal places
					//String formatted_total_amount = String.format("%.2f", total_amount);

		

	
		// table.addCell(new PdfPCell(new Phrase("2", font10pt)));
		// table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
		// table.addCell(new PdfPCell(new Phrase("Service Charge", font10pt)));
		
		// String ssc = String.format("%.2f", (Double) case_obj.getDouble("total_bill"));
		
		// table.addCell(new PdfPCell(new Phrase(ssc, font10pt)));
		// table.setSpacingBefore(5.0f);

		table.addCell(new PdfPCell(new Phrase(" ", font12pt)));
		//table.addCell(new PdfPCell(new Phrase(" ", font10pt)));
		table.addCell(new PdfPCell(
				new Phrase("Total Amount", font12pt)));

		
		PdfPCell cell_1 = new PdfPCell(new Phrase(ssc1, font12pt_bold));
		cell_1.setHorizontalAlignment(Element.ALIGN_RIGHT); // Align content to the right
        table.addCell(cell_1);

		//table.addCell(new PdfPCell(new Phrase(ssc1, font12pt)));
		table.setSpacingBefore(5.0f);

		document.add(table);

		// Paragraph p12 = new Paragraph(
		// 		"Amount in words: " + AmountInWords.convertToCurrency(String.valueOf(total_amount)),
		// 		new Font(FontFamily.TIMES_ROMAN, 12));
		// p12.setAlignment(Element.ALIGN_LEFT);
		// document.add(p12);

		document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph y_4_3_1 = new Paragraph(
			// 		"Please ensure that all payments are promptly made to Bank Account Number ………………………. at OmniBSic Bank no later than (Date) in order to finalize the lease agreement in your favor. Ground rent payments thereafter should be made directly to the Lands Commission until the lease term expires.",
			// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
			// 		y_4_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			// document.add(y_4_3_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4_3_2 = new Paragraph(
					"Your acceptance of this offer by Registered Post, Courier Service or Hand Delivery is anticipated within 14 days from the date of this letter. Kindly note that securing an offer letter does not guarantee an acquisition of a lease.",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_2.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_2);

			document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph y_4_3_3 = new Paragraph(
			// 		"Kindly note that you will be required to contribute towards the payment of compensation as part of the regularization process unless you can substantiate that your grant and occupation of the land is at the instance of a pre-acquisition owner (compensation claimants) with the requisite documents.",
			// 		new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
			// 		y_4_3_3.setAlignment(Element.ALIGN_JUSTIFIED);
			// document.add(y_4_3_3);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4_3_4 = new Paragraph(
					"Please ensure that all payments are made to OmniBSIC Bank at the Land Admin Service Center, New Legon or any OmniBSIC Bank branch nationwide, not later than "+date_of_payment+" in order to finalize the issuance of a lease in your favour. Subsequent annual ground rent payments shall be made directly to the Lands Commission upon the execution of the lease.",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_4.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_4);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_4_3_5 = new Paragraph(
					"Failure to accept this offer and make payment by the specified dates would be deemed to be a rejection of the offer. The Lands Commission reserves the right to take appropriate legal action to repossess the plot referenced above in accordance with Section 236 of the Land Act, 2020 (Act 1036).",
					new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL));
					y_4_3_5.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(y_4_3_5);

			


			// Paragraph y_4_1 = new Paragraph("Term: " + term,
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL));
			// y_4_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_4_1);


			// Paragraph y_4_12 = new Paragraph("Commencement: "+ commencement_date,
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.NORMAL));
			// 		y_4_12.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_4_12);


			document.add(new Phrase(Chunk.NEWLINE));
			
			
			



			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("Please communicate your written acceptance to the Lands Commission by registered post or courier service not later than three (3) months from the date herein. ",
					small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(locality, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk("Please ensure that all payments are made to OmniBSIC Bank at the Land Admin Service Center, New Legon or any OmniBSIC Bank branches nationwide, not later than "+ date_of_payment+" in order to finalize the lease agreement in your favour. Subsequent Annual Ground rent payments shall be made directly to the Lands Commission upon the execution of the lease.",
					small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					"All recipients of the offer letters should note that securing an offer letter does not guarantee an acquisition of lease document. The lease will contain terms and conditions, which are usually embodied in Government leases.",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			Chunk st6 = new Chunk("If We do not hear from you by the specified date nor receive your remittance for the fees and charges, it shall be assumed that you are not interested in regularising your occupation on the said site and this offer shall lapse and the Commission reserves the right to invoke the powers under Section 236 of the Land Act, 2020 (Act 103) to initiate legal action to repossess the property without any further reference to you.", small);
			st6.setTextRise(7);
			p_2.add(st6);

			// Chunk st6_ = new Chunk(" ii.	Lease Preparation:       One Thousand Cedis (GHS 1,00.00)", small);
			// st6_.setTextRise(7);
			// p_2.add(st6_);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			//document.add(p_2);

			// Paragraph y_5 = new Paragraph(
			// 		"4.	The Premium may be paid by Banker�s Draft in favour of �LANDS COMMISSION�. The Administrative fees and charges may also be paid by Cash.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_5.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_5);

			// Paragraph y_6 = new Paragraph(
			// 		"5.	The lease shall embody such terms and conditions as are usually included in lease of State Lands of this nature and such other covenants the Government may choose to include.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_6.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_6);

			// Paragraph y_7 = new Paragraph(
			// 		"6.	The site is yet to be surveyed and demarcated. The plan attached is indicative only for the purpose initiating the allocation process. The final cadastral plan will be incorporated into the formal lease to be engrossed for you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_7.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_7);

			// Paragraph y_8 = new Paragraph(
			// 		"In order that you do not trespass unto other adjoining properties, an authorized Surveyor of the Lands Commission shall be detailed to demarcate and show to you the boundaries of the land allocated to you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_8.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_8);

			// Paragraph y_9 = new Paragraph(
			// 		"ALLOCATION OF GOVERNMENT LAND IN THE ADENTAN BUSINESS DISTRICT � ADENTA (RESIDENTIAL)",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_9.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_9);

			// Paragraph y_10 = new Paragraph(
			// 		"7.	These terms and conditions are subject to the necessary written agreement being entered into between the Government and yourself, and on that understanding, your unqualified acceptance of this offer by REGISTERED POST or COURIER SERVICE or HAND DELIVERY not later than two months from the date hereof and also receive your remittance for all the fees and charges stated above by the same date. ",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_10.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_10);

			// Paragraph y_11 = new Paragraph(
			// 		"8.	If we do not hear from you by the said date nor receive your remittance for the fees and charges, it shall be assumed that you are not interested in the land and this offer shall laps and recommended for re-allocation to another suitable applicant without any further reference to you.",
			// 		new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			// y_11.setAlignment(Element.ALIGN_LEFT);
			// document.add(y_11);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += " Yours faithfully, ";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_12 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_12.setAlignment(Element.ALIGN_LEFT);
			document.add(p_12);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_13 = new Paragraph("BENJAMIN ARTHUR", new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			p_13.setAlignment(Element.ALIGN_LEFT);
			document.add(p_13);

			// Paragraph p_13 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			// p_13.setAlignment(Element.ALIGN_LEFT);
			// document.add(p_13);

			

			Paragraph p_14 = new Paragraph("(EXECUTIVE SECRETARY)", new Font(FontFamily.TIMES_ROMAN, 12,Font.BOLD));
			p_14.setAlignment(Element.ALIGN_LEFT);
			document.add(p_14);

			document.close();
			//file.close();
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

	public byte[] create_query_letter(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String ir_business_process_sub_name,
			String login_user, String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(50, 730);
			// codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			/*
			 * Image image = Image.getInstance(software_file_location + "CoatofArm.jpg"); //
			 * imgPDF2.ScaleToFit(100.0F, 70.0F) image.scaleToFit(100.0F,
			 * 100.0F); image.setAbsolutePosition(240, 710);
			 * document.add(image);
			 */

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(100.0F, 100.0F);
			image1.setAbsolutePosition(240, 730);
			// image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 10);

			// cbaddress.setTextMatrix(50, 710);
			// cbaddress.showText("Case Number");
			// cbaddress.setTextMatrix(50, 690);
			// cbaddress.showText(new_case_number);

			/*
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			/*
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 * cbaddress.setTextMatrix(400, 780);
			 * cbaddress.showText("LANDS COMMISSION");
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText(web_comp_address);
			cbaddress.setTextMatrix(400, 770);
			cbaddress.showText(web_city);
			cbaddress.setTextMatrix(400, 760);
			cbaddress.showText(("Tel: " + web_telephone));
			cbaddress.setTextMatrix(400, 750);
			cbaddress.showText(("Fax: " + web_fax_number));
			cbaddress.setTextMatrix(400, 740);
			cbaddress.showText(("Email: " + web_email));
			cbaddress.setTextMatrix(400, 730);
			cbaddress.showText("Web: www.lc.gov.gh");

			cbaddress.setTextMatrix(400, 700);
			Date now = new Date();
			// cbaddress.showText("Date: " + now.toGMTString());

			cbaddress.endText();

			PdfContentByte canvas = writer.getDirectContent();
			canvas.moveTo(20, 690);
			canvas.lineTo(700, 690);
			canvas.closePathStroke();

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			// document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_7 = new Paragraph("Date: " + now.toGMTString(),
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_7.setAlignment(Element.ALIGN_RIGHT);
			document.add(p_7);

			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_8 = new Paragraph("CASE NUMBER: " + new_case_number,
					new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p_8);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_1 = new Paragraph(ar_name, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_LEFT);
			document.add(y_1);

			Paragraph y_2 = new Paragraph(client_address, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_2.setAlignment(Element.ALIGN_LEFT);
			document.add(y_2);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_3 = new Paragraph("Dear Sir/Madam,", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			y_3.setAlignment(Element.ALIGN_LEFT);
			document.add(y_3);

			Paragraph y_4 = new Paragraph("APPLICATION QUERY LETTER", new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
			y_4.setAlignment(Element.ALIGN_CENTER);
			document.add(y_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("Reference the " + business_process_name + " of land situate at ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(locality, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(
					" The office wishes to bring to your notice a pending site inspection that needs to be conducted on your site in order to facilitate your "
							+ business_process_name + ".",
					small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(
					" Kindly visit our Office to see the undersigned officer for further directives upon receipt of this letter during working hours.",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			Chunk st6 = new Chunk(
					" Please adhere to this directive to enable the Office continue with your registration process.",
					small);
			st6.setTextRise(7);
			p_2.add(st6);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += " Yours faithfully";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph(login_user, new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p_5);

			document.close();
			//file.close();
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

	public byte[] create_query_letter(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(70, 750);
			cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("LAND CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
			Paragraph p_2 = new Paragraph();
			p_2.setSpacingAfter(72f);

			Chunk st = new Chunk("THIS IS TO CERTIFY THAT ", small);
			st.setTextRise(7);
			p_2.add(st);

			Chunk st1 = new Chunk(ar_name, small_bold);
			st1.setTextRise(7);
			p_2.add(st1);

			Chunk st2 = new Chunk(" of Accra in the Greater Accra Region", small);
			st2.setTextRise(7);
			p_2.add(st2);

			Chunk st3 = new Chunk(" of the Republic of Ghana is registered as tenant or lessee for the unexpired",
					small);
			st3.setTextRise(7);
			p_2.add(st3);

			// Display a date in day, month, year format
			// DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			// Date date = formatter.parse(date_of_registration);
			// String formatted_date_of_registration = formatter.format(date);
			// System.out.println("Today : " + today);

			/*
			 * LocalDateTime localDateTime =
			 * LocalDateTime.parse(commencement_date); DateTimeFormatter
			 * formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy"); LocalDate
			 * formatter2 = LocalDate.toLocalDate("dd/MM/yyyy"); String
			 * formatted_date_of_registration =
			 * localDateTime.format(formatter1);
			 */

			LocalDateTime localDateTime = LocalDateTime.parse(commencement_date);
			// DateTimeFormatter formatter1 =
			// DateTimeFormatter.ofPattern("dd/MM/yyyy");
			// LocalDate formatter2 = LocalDate.toLocalDate("dd/MM/yyyy");
			// String formatted_date_of_registration =
			// localDateTime.format(formatter1);

			Month month_c = localDateTime.getMonth();
			int day_c = localDateTime.getDayOfMonth();
			int year_c = localDateTime.getYear();

			Chunk st4 = new Chunk(" residue of a lease for a term of " + term + " years from the "
					+ specialNamesMonthDay[day_c] + " day of " + convertToTitleCaseIteratingChars(month_c.toString())
					+ ", " + year_c + " subject to the", small);
			st4.setTextRise(7);
			p_2.add(st4);

			Chunk st5 = new Chunk(" reservations, restrictions, encumbrances, liens and interests as are notified",
					small);
			st5.setTextRise(7);
			p_2.add(st5);

			Chunk st6 = new Chunk(" by memorial underwritten or endorsed hereon, of and in ALL THAT piece or", small);
			st6.setTextRise(7);
			p_2.add(st6);

			Chunk st7 = new Chunk(" Parcel of land in extent " + extent + " more or less being ", small);
			st7.setTextRise(7);
			p_2.add(st7);

			/*
			 * Chunk st8 = new Chunk("GLPIN No. " + glpin + ", SECTION " +
			 * registration_section_number + " BLOCK " +
			 * registration_block_number + ", situate at " + locality, small);
			 * p_2.add(st8);
			 */

			Chunk st9 = new Chunk(" in the Greater Accra Region of the Republic of Ghana aforesaid which", small);
			st9.setTextRise(7);
			p_2.add(st9);

			Chunk st10 = new Chunk(" said piece or parcel of land is more particularly delineated on Registry Map",
					small);
			st10.setTextRise(7);
			p_2.add(st10);

			Chunk st11 = new Chunk(
					" No. " + registry_mapref + " in the Lands Commission, Cantonment Accra, and being the piece or",
					small);
			st11.setTextRise(7);
			p_2.add(st11);

			Chunk st12 = new Chunk(" parcel of land shown and edged with pink color on Survey Plan No. " + plan_no,
					small);
			st12.setTextRise(7);
			p_2.add(st12);

			Chunk st14 = new Chunk(" annexed to this Certificate except and reserved all minerals, oils, precious",
					small);
			st14.setTextRise(7);
			p_2.add(st14);

			Chunk st15 = new Chunk(" stones and timber whatsoever upon or under the said piece or parcel of land.",
					small);
			st15.setTextRise(7);
			p_2.add(st15);

			// Paragraph p_2 = new Paragraph(cert_text, new
			// Font(FontFamily.TIMES_ROMAN, 12));
			p_2.setAlignment(Element.ALIGN_JUSTIFIED);
			// p_2.line
			p_2.setLeading(32);
			document.add(p_2);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			/*
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 */

			// PdfPCell CellFourHdr_memorials = new PdfPCell(new
			// Paragraph("Remarks",font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			/*
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 */

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null") {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase(NumberCount_memo.toString(), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);

					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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

	public byte[] create_smd_barcode(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String wkt_polygon, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		System.out.println(request_json.toString());

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(490, 720);
			document.add(codeQrImage);

			BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(wkt_polygon, 1000, 1000, null);
			Image codeQrImage1 = barcodeQRCode1.getImage();
			codeQrImage1.scaleAbsolute(80, 80);
			codeQrImage1.setAbsolutePosition(30, 720);
			document.add(codeQrImage1);

			Barcode128 code128 = new Barcode128();
			code128.setCode(glpin);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 670);
			code128Image.scalePercent(100);
			document.add(code128Image);

			document.close();
			//file.close();
		return out.toByteArray();

	
		} catch (Exception e) {
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



	public byte[] create_smd_barcode_gated_wor_flow(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
	
		JSONObject request_json = new JSONObject();
		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());

		String case_records = cls_case_management
				.select_generate_2d_barcode(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String glpin = case_obj.get("glpin").toString();
		String wkt_polygon = case_obj.get("wkt_polygon").toString();
		

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(job_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(490, 720);
			document.add(codeQrImage);

			BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(wkt_polygon, 1000, 1000, null);
			Image codeQrImage1 = barcodeQRCode1.getImage();
			codeQrImage1.scaleAbsolute(80, 80);
			codeQrImage1.setAbsolutePosition(30, 720);
			document.add(codeQrImage1);

			Barcode128 code128 = new Barcode128();
			code128.setCode(glpin);
			code128.setCodeType(Barcode128.CODE128);
			Image code128Image = code128.createImageWithBarcode(cb, null, null);
			code128Image.scaleAbsolute(100, 100);
			code128Image.setAbsolutePosition(20, 670);
			code128Image.scalePercent(100);
			document.add(code128Image);

			document.close();
			//file.close();
		return out.toByteArray();

	
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {

		}
	return out.toByteArray();

	}

	public byte[] create_smd_barcode_gated_work_flow_address_code(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number, String output_file,String plan_approval_verification_url)
			throws IOException, SQLException, JSONException, ParseException {
	
		JSONObject request_json = new JSONObject();
		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json.toString());

		String case_records = cls_case_management
				.select_generate_2d_barcode(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String glpin = case_obj.get("glpin").toString();
		String wkt_polygon = case_obj.get("wkt_polygon").toString();
		

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			// BarcodeQRCode barcodeQRCode = new BarcodeQRCode(wkt_polygon, 1000, 1000, null);
			// Image codeQrImage = barcodeQRCode.getImage();
			// codeQrImage.scaleAbsolute(80, 80);
			// codeQrImage.setAbsolutePosition(490, 720);
			// document.add(codeQrImage);

			BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(plan_approval_verification_url+glpin, 1000, 1000, null);
			Image codeQrImage1 = barcodeQRCode1.getImage();
			codeQrImage1.scaleAbsolute(70, 70);
			codeQrImage1.setAbsolutePosition(55, 645);
			document.add(codeQrImage1);

			// Barcode128 code128 = new Barcode128();
			// code128.setCode(glpin);
			// code128.setCodeType(Barcode128.CODE128);
			// Image code128Image = code128.createImageWithBarcode(cb, null, null);
			// code128Image.scaleAbsolute(100, 100);
			// code128Image.setAbsolutePosition(20, 670);
			// code128Image.scalePercent(100);
			// document.add(code128Image);

			document.close();
			//file.close();
		return out.toByteArray();

	
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {

		}
	return out.toByteArray();

	}

	public byte[] create_title_plan(String web_service_url, String web_service_api_key, String software_file_location,
			String case_number, String job_number,
			String wkt_polygon, String output_file)
			throws IOException, SQLException, JSONException, ParseException, com.vividsolutions.jts.io.ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);
		System.out.println(request_json);
		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		/*
		 * String[] wkts = {
		 * "MULTIPOLYGON(((1204267.29591961 330962.775430757,1204269.37459434 330964.854105487,1204266.48472948 330968.707258644,1204276.57390682 330977.883847083,1204300.8082122 330952.027161425,1204287.57567307 330940.062106885,1204267.29591961 330962.775430757)))"
		 * ,
		 * "MULTIPOLYGON(((1209684 329954.53,1203010.13 330250.78,1203365.13 333146.34,1197477.63 334319.19,1199448.38 342953,1199453 343056.34,1198616.63 353236.47,1206762 353228.56,1206868.88 343868.84,1209786 343929.84,1209684 329954.53)))"
		 * };
		 */

		String[] wkts = {
				"MULTIPOLYGON(((1204267.29591961 330962.775430757,1204269.37459434 330964.854105487,1204266.48472948 330968.707258644,1204276.57390682 330977.883847083,1204300.8082122 330952.027161425,1204287.57567307 330940.062106885,1204267.29591961 330962.775430757)))",
				"MULTIPOLYGON(((1209684 329954.53,1203010.13 330250.78,1203365.13 333146.34,1197477.63 334319.19,1199448.38 342953,1199453 343056.34,1198616.63 353236.47,1206762 353228.56,1206868.88 343868.84,1209786 343929.84,1209684 329954.53)))" };

		/*
		 * String[] wkts = {
		 * "POLYGON((1307544.234 392443.128, 1307557.86 392444.355, 1307690.266 392329.812,1307692.794 392315.993, 1307611.113 392212.503, 1307460.678 392343.218, 1307544.234 392443.128))"
		 * };
		 */
		GeometryCollection geometries = null;
		geometries = GeometryUtils.readCollection(wkts);
		// try {
		//
		// } catch (com.vividsolutions.jts.io.ParseException ex) {
		// ex.printStackTrace();
		// // return;
		// }

		// dimension of target image that will be used for display of geometries
		// Dimension dim = new Dimension(300, 1000);
		Dimension dim = new Dimension(500, 500);

		// renders image and saved it to map.jpg
		new Renderer(dim, geometries).rasterizeToFile(new File("map.jpg"), "JPG");

		ByteArrayOutputStream out = new ByteArrayOutputStream();

		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			// BufferedImage buffer = new Renderer(dim, geometries).rasterize();

			// Image map_mage = ImageIO.write(buffer, "JPG", new
			// File("map.jpg"));

			// Image image = (Image) new Renderer(dim, geometries).rasterize();
			// Image map_mage = ImageIO.write(new Renderer(dim,
			// geometries).rasterize(), new File("map.jpg"), "JPG");
			// ImageIO.write(rasterize());

			// public static final String web_service_url, String web_service_api_key,String
			// software_file_location + "CoatofArm.jpg" =
			// "C:\\gelisdocs\\" + case_number
			// + ".jpg";

			// new Renderer(dim, geometries).rasterizeToFile(new File("C:\\gelisdocs\\" +
			// case_number + ".png"), "PNG");
			// Image map_mage = Image.getInstance("C:\\gelisdocs\\" + case_number + ".png");
			// map_mage.scaleAbsolute(450, 400);
			// map_mage.setAbsolutePosition(70, 300);
			// document.add(map_mage);

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 720);
			document.add(codeQrImage);

			BarcodeQRCode barcodeQRCode1 = new BarcodeQRCode(wkt_polygon, 1000, 1000, null);
			Image codeQrImage1 = barcodeQRCode1.getImage();
			codeQrImage1.scaleAbsolute(80, 80);
			codeQrImage1.setAbsolutePosition(30, 720);
			document.add(codeQrImage1);

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("TITLE PLANS", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			document.close();
			//file.close();
		return out.toByteArray();

		
		} catch (Exception e) {
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

	public String create_consent_certificate_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number) throws Exception {
		String output_cetfificate_template = "";
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		LocalDateTime currentTime = LocalDateTime.now();
		System.out.println("Current DateTime: " + currentTime);

		LocalDate date1 = currentTime.toLocalDate();
		System.out.println("Date : " + date1);

		Month month = currentTime.getMonth();
		int day = currentTime.getDayOfMonth();
		int year = currentTime.getYear();

		output_cetfificate_template += "I ";
		output_cetfificate_template += web_chairman_regional_land_commission;

		output_cetfificate_template += " CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS ";
		output_cetfificate_template += " acting for and on behalf of the regional Lands Commission hereby consent to a sublease by "
				+ grantors_name + " with its registered office at " + client_address
				+ " of all its rights and interest in ALL THAT PIECE OR PARCEL of land known as " + glpin + " ";
		output_cetfificate_template += " containing an approximate area of " + size_of_land
				+ " of an acre being a portion of an Unnumbered Plot situate at " + locality
				+ ", in the Greater Accra Region of the Republic of Ghana demised by a Lease dated the "
				+ commencement_date + " and made between the " + ar_name
				+ " of the one part and the Sublessor herein of the other part of a term of" + term
				+ " years with effect from the " + commencement_date
				+ " and it is being subleased to the Sublessee herein for the term of " + term + " ";
		output_cetfificate_template += " years with effect from the " + commencement_date
				+ " SUBJECT nevertheless to the payment of the revised ground rent reserved in the head lease and observance and performance of the Covenants contained in the said Lease reserved and on the part of the Lessee to be observed and performed PROVIDED ALWAYS THAT this Consent is restricted to the particular Sublease hereby authorized and save as aforesaid the covenant in the said Lease contained against mortgaging assigning under � letting or parting with possession shall remain in full force and effect.   ";
		output_cetfificate_template += " Dated and sealed with Seal of the Greater Accra Regional Lands Commission this "
				+ specialNamesMonthDay_short[day] + " day of " + convertToTitleCaseIteratingChars(month.toString())
				+ ", " + year + ".";

		return output_cetfificate_template;
	}

	public String create_deeds_certificate_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number) throws Exception {
		String output_cetfificate_template = "";
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String client_address = (String) case_obj.getString("client_address");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();
		String created_date = (String) transaction_details_obj.get("created_date").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		// System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		// LocalDateTime currentTime = LocalDateTime.now();
		// System.out.println("Current DateTime: " + currentTime);

		DateTimeFormatter formattern = DateTimeFormatter.ofPattern("HH:mm:ss a");

		LocalDateTime localDateTime = LocalDateTime.parse(created_date);
		// DateTimeFormatter formatter1 =
		// DateTimeFormatter.ofPattern("dd/MM/yyyy");
		// LocalDate formatter2 = LocalDate.toLocalDate("dd/MM/yyyy");
		// String formatted_date_of_registration =
		// localDateTime.format(formatter1);

		// Month month_c = localDateTime.getMonth();
		// int day_c = localDateTime.getDayOfMonth();
		// int year_c = localDateTime.getYear();

		// LocalDate date1 = currentTime.toLocalDate();
		// System.out.println("Date : " + date1);

		Month month = localDateTime.getMonth();
		int day = localDateTime.getDayOfMonth();
		int year = localDateTime.getYear();

		String dateTimeString = localDateTime.format(formattern);

		output_cetfificate_template += "This Instrument is registered under section 216 of the Land Act, 2020 (Act 1036) this "
				+ specialNamesMonthDay_short[day] + " day of " + convertToTitleCaseIteratingChars(month.toString())
				+ ", " + year + " at " + dateTimeString;

		return output_cetfificate_template;
	}

	public byte[] create_consent_certificate_typed(String web_service_url, String web_service_api_key,
			String software_file_location, String notes, String case_number,
			String job_number,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		System.out.println("Result");

		System.out.println(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		System.out.println(parcel_details);

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 40, 40, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 700);
			document.add(image1);

			Font font = new Font(FontFamily.HELVETICA);
			Font font14pt = new Font(FontFamily.HELVETICA, 14);
			Font font10pt = new Font(FontFamily.HELVETICA, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */
			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.HELVETICA, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("CONSENT CERTIFICATE", new Font(FontFamily.HELVETICA, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));

			// HTMLWorker htmlWorker = new HTMLWorker(document);
			// htmlWorker.parse(new StringReader(notes));

   // Create a StyleSheet and set line spacing
   StyleSheet styles = new StyleSheet();
   styles.loadTagStyle("body", "leading", "40"); // Set line spacing (leading) to 20


   //HTMLWorker htmlWorker = new HTMLWorker(document);
   //htmlWorker.parse(new StringReader(remark_or_comment_bob));

	 // Define your CSS for Times New Roman and justified text
	 String css = "body { font-family: Times New Roman; text-align: justify; }";

	 // Use XMLWorkerHelper to parse HTML and apply CSS
	 //XMLWorkerHelper.getInstance().parseXHtml(writer, document, new StringReader(htmlContent), new StringReader(css));

   Font timesNewRoman = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD);

// Replace a value in the string
notes= notes.replace("<ol><li>", "<html><body><p>");
notes= notes.replace("</li></ol>", "</p></body></html>");

// Output the result
//System.out.println(updatedString);  // Output: "This is the new comment."
            // // Parse the HTML content
             java.util.List<Element> elements = HTMLWorker.parseToList(new StringReader(notes), styles);


			  // Process the parsed elements
			  for (Element element : elements) {
				if (element instanceof Paragraph) {
					// Create a new Paragraph from the original one and set the font and alignment
					Paragraph originalParagraph = (Paragraph) element;
					Paragraph newParagraph = new Paragraph(originalParagraph.getContent(), timesNewRoman);
					newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
					newParagraph.setLeading(20f); 
					newParagraph.setSpacingAfter(10f);  // Add spacing after each paragraph
					document.add(newParagraph);
					System.out.println("Par 1");
				} else if (element instanceof Phrase) {
					// Create a new Paragraph from the Phrase and apply formatting
					Phrase originalPhrase = (Phrase) element;
					Paragraph newParagraph = new Paragraph(originalPhrase.getContent(), timesNewRoman);
					newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
					newParagraph.setLeading(30f); 
					newParagraph.setSpacingAfter(20f);  // Add spacing after each paragraph
					document.add(newParagraph);
					System.out.println("Par 2");
				} else if (element instanceof Chunk) {
					// Create a new Chunk and apply font
					Chunk originalChunk = (Chunk) element;
					Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);
   System.out.println("Chunk ");

// // Convert the Chunk to a Paragraph to control line spacing
// Chunk originalChunk = (Chunk) element;
// Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);

// // Create a new Paragraph with the Chunk and set line spacing
// Paragraph paragraph = new Paragraph(newChunk);
// paragraph.setLeading(15f); // Set the line spacing, adjust the value as needed

// // Add the Paragraph (with line spacing) to the document
// document.add(paragraph);
					document.add(newChunk);
				} else {
					// For other types of elements, just add them without changes
					document.add(element);
				}
			}



			document.add(new Phrase(Chunk.NEWLINE));

			// String cert_text2 = "";
			// cert_text2 += "Dated and Sealed with the Seal of the Greater Accra Regional ";
			// cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
			// 		+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			String cert_text2 = "";
			cert_text2 += "Dated and Sealed with the Seal of the Greater Accra Regional ";
			cert_text2 += " Lands Commission this " + "              "+ "           day of "
					+  "                               " + ", " + "20" + " ";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.HELVETICA, 12, java.awt.Font.BOLD));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
		    document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph(".................................................",
					new Font(FontFamily.HELVETICA, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			Paragraph p_5_1 = new Paragraph("CHAIRPERSON OF THE GREATER ACCRA REGIONAL LANDS COMMISSION ",
					new Font(FontFamily.HELVETICA, 12, Font.BOLD));
					p_5_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5_1);

		

			Paragraph p_3_1 = new Paragraph("File No: " + case_file_number, new Font(FontFamily.HELVETICA, 12, Font.BOLD));
			p_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3_1.setLeading(32);
			document.add(p_3_1);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.HELVETICA, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			// document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p_5 = new Paragraph("CHIEF REGISTRAR OF LANDS ", new
			 * Font(FontFamily.TIMES_ROMAN, 12));
			 * p_5.setAlignment(Element.ALIGN_CENTER); document.add(p_5);
			 */

			document.close();
			//file.close();
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

	public String create_concurrence_certificate_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number)
			throws IOException, SQLException, JSONException, ParseException {
		String output_cetfificate_template = "";
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		output_cetfificate_template += "I ";
		output_cetfificate_template += web_chairman_regional_land_commission;
		output_cetfificate_template += " CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS ";
		output_cetfificate_template += " COMMISSION in accordance with section 10 (3) of the Lands Commission Act, 2008 (Act 767) hereby record my concurrence to the transaction evidenced by the within � written document subject to the conditions set out in the Schedule hereunder: ";
		output_cetfificate_template += " SCHEDULE ABOVE REFERRED TO:";
		output_cetfificate_template += " (1)	The rent payable under the lease shall be paid to the Administrator of Stool Lands or her duly authorized agent:";
		output_cetfificate_template += " (2)	The rent reserved under the Lease herein shall be " + annual_rent
				+ " per annum subject to revision every fifth (5th) year of the term. ";

		/*
		 * output_cetfificate_template += "I "; output_cetfificate_template +=
		 * Ws_url_config.web_chairman_regional_land_commission;
		 * output_cetfificate_template +=
		 * " CHAIRMAN OF THE GREATER ACCRA REGIONAL LANDS ";
		 * output_cetfificate_template +=
		 * " acting for and on behalf of the regional Lands Commission hereby consent to a sublease by sic insurance company limited with its registered office at No. 28/29 Ring Road East Osu � Accra and of P.O BOX LG822, Legon � Accra of all its rights and interest in ALL THAT PIECE OR PARCEL of land known as Unit No. 39,  Block 8, Section 160 "
		 * ; output_cetfificate_template +=
		 * " containing an approximate area of 0.325 of an acre being a portion of an Unnumbered Plot situate at Greenhill, Legon � Accra, in the Greater Accra Region of the Republic of Ghana demised by a Lease dated the 10th day of January 1995 and made between the Government of the Republic of Ghana of the one part and the Sublessor herein of the other part of a term of Ninety � nine (99) years with effect from the 21st day of November, 1986 and it is being subleased to the Sublessee herein for the term of Fifty (50) "
		 * ; output_cetfificate_template +=
		 * " years with effect from the 1st day of September,1998 SUBJECT nevertheless to the payment of the revised ground rent reserved in the head lease and observance and performance of the Covenants contained in the said Lease reserved and on the part of the Lessee to be observed and performed PROVIDED ALWAYS THAT this Consent is restricted to the particular Sublease hereby authorized and save as aforesaid the covenant in the said Lease contained against mortgaging assigning under � letting or parting with possession shall remain in full force and effect.   "
		 * ; output_cetfificate_template +=
		 * " Dated and sealed with Seal of the Greater Accra Regional Lands Commission this 26th day of March, 2020"
		 * ;
		 */
		return output_cetfificate_template;

	}

	public byte[] create_concurrence_certificate_typed(String web_service_url, String web_service_api_key,
			String software_file_location, String transaction_number, String job_number,
			String type_of_certificate,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", transaction_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);
		System.out.println(request_json.toString());

		System.out.println(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");
		
		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();
		String date_of_issue = (String) transaction_details_obj.get("date_of_issue").toString();
		
		String deed_number = (String) transaction_details_obj.get("deed_number").toString();
		String file_number = (String) transaction_details_obj.get("file_number").toString();
		String ls_number = (String) transaction_details_obj.get("ls_number").toString();
		String ground_rent = (String) transaction_details_obj.get("ground_rent").toString();
		

		
		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(new_case_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780); cbaddress.showText("File Number: " + file_number);

			/*
			 * cbaddress.setTextMatrix(70, 780); cbaddress.showText("Cert. No: "
			 * + certificate_number);
			 * 
			 * cbaddress.setTextMatrix(70, 765); cbaddress.showText("Volume: " +
			 * volume_number);
			 * 
			 * cbaddress.setTextMatrix(70, 750); cbaddress.showText("Folio: " +
			 * folio_number);
			 */

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();


			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph y_1 = new Paragraph("CONCURRENCE CERTIFICATE", new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			
			// HTMLWorker htmlWorker = new HTMLWorker(document);
			// htmlWorker.parse(new StringReader(remark_or_comment_bob));

  			// Define your CSS for Times New Roman and justified text
 			 String css = "body { font-family: Times New Roman; text-align: justify; }";
			  String remark_or_comment_bob = (String)  job_detail_obj.get("remark_or_comment").toString();

  			// Use XMLWorkerHelper to parse HTML and apply CSS
  			//XMLWorkerHelper.getInstance().parseXHtml(writer, document, new StringReader(htmlContent), new StringReader(css));

			Font timesNewRoman = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12, Font.NORMAL);
			Font timesNewRoman_bold = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12, Font.BOLD);

			String htmlContent = "<html><body><p>THIS IS TO CERTIFY THAT Sam of Accra in the Greater Accra Region of the Republic of Ghana is registered as tenant or lessee for the unexpired residue of a lease for a term of 99 years from the  twenty seventh day of September, 2023 subject to the reservations, restrictions, encumbrances, liens and interests as are notified by memorial underwritten or endorsed hereon, of and in ALL THAT piece or Parcel of land in extent 0.230 more or less being GLPIN No. GA329393-1148882, SECTION 024 BLOCK 123, situate at AJANGORTEY in the Greater Accra Region of the Republic of Ghana aforesaid which said piece or parcel of land is more particularly delineated on Registry Map No. 79ui in the Lands Commission, Cantonment Accra, and being the piece or parcel of land shown and edged with pink color on Survey Plan No. 7899 annexed to this Certificate except and reserved all minerals, oils, precious stones and timber whatsoever upon or under the said piece or parcel of land..</p></body></html>";

// Replace a value in the string
remark_or_comment_bob= remark_or_comment_bob.replace("<ol><li>", "<html><body><p>");
remark_or_comment_bob= remark_or_comment_bob.replace("</li></ol>", "</p></body></html>");


  // Create a StyleSheet
  StyleSheet styles = new StyleSheet();
  styles.loadTagStyle("body", "font-family", "Times-Roman");
  styles.loadTagStyle("body", "font-size", "12pt");
  styles.loadTagStyle("p", "alignment", "justify");
  styles.loadTagStyle("b", "font-weight", "bold");

  // Parse the HTML content using HTMLWorker
  HTMLWorker htmlWorker = new HTMLWorker(document);
  htmlWorker.setStyleSheet(styles);

  // Parse and add content to the document
  java.util.List<Element> elements = htmlWorker.parseToList(new StringReader(remark_or_comment_bob), styles);
  //for (Element element : elements) {
	for (Element element : elements) {
		if (element instanceof Paragraph) {
			// Create a new Paragraph from the original one and set the font and alignment
			// Paragraph originalParagraph = (Paragraph) element;
			// Paragraph newParagraph = new Paragraph(originalParagraph.getContent(), timesNewRoman);
			
			// Paragraph paragraph = (Paragraph) element;
			
			// newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
			// newParagraph.setLeading(30f); 
			// newParagraph.setSpacingAfter(20f);  // Add spacing after each paragraph
			// document.add(newParagraph);

			// document.add(element);
			//System.out.println("Par 1");
			Paragraph paragraph = (Paragraph) element;
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED); // Ensure justification
			paragraph.setLeading(25f); 
			paragraph.setSpacingAfter(10f);  // Add spacing after each paragraph
			document.add(paragraph);

		} else if (element instanceof Phrase) {
			// Create a new Paragraph from the Phrase and apply formatting
			Phrase originalPhrase = (Phrase) element;
			Paragraph newParagraph = new Paragraph(originalPhrase.getContent(), timesNewRoman);
			newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
			newParagraph.setLeading(25f); 
			newParagraph.setSpacingAfter(10f);  // Add spacing after each paragraph
			document.add(newParagraph);
			System.out.println("Par 2");
		} else if (element instanceof Chunk) {
			// Create a new Chunk and apply font
			Chunk originalChunk = (Chunk) element;
			Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);

			document.add(newChunk);
		} else {
			// For other types of elements, just add them without changes
			document.add(element);
		}
	//document.add(element);
  }



      
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + date_of_issue);

			
			
			
			

			if ( date_of_issue != null && date_of_issue != "null" ) {

				// Parse the string to OffsetDateTime
				//OffsetDateTime offsetDateTime = OffsetDateTime.parse(date_of_issue);
				LocalDateTime dateTime =LocalDateTime.parse(date_of_issue);
				//DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				//LocalDateTime dateTime = offsetDateTime.toLocalDateTime();
				System.out.println("Date of Issue as LocalDateTime: " + dateTime);
				LocalDate date1 = dateTime.toLocalDate();
				System.out.println("Date : " + date1);

				Month month = dateTime.getMonth();
				int day = dateTime.getDayOfMonth();
				int year = dateTime.getYear();

				// System.out.println("Month : " + month);
				// System.out.println("Day : " + day);
				// System.out.println("Seconds : " + seconds);

				document.add(new Phrase(Chunk.NEWLINE));
				// document.add(new Phrase(Chunk.NEWLINE));

				String cert_text2 = "";
				cert_text2 += "CHAIRMAN OF THE REGIONAL LANDS COMMISSION ";
				cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
						+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

				Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_3.setAlignment(Element.ALIGN_JUSTIFIED);
				p_3.setLeading(20);
				document.add(p_3);

			} else {


			}





			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {

				File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(software_file_location + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {

					Paragraph y_tna = new Paragraph("Certificate Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					//document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				//document.add(y_tna);
			}


			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));


			Paragraph p_3_1 = new Paragraph("File No: " + case_file_number, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3_1.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3_1.setLeading(32);
			document.add(p_3_1);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("CHAIRMAN OF THE REGIONAL LANDS COMMISSION ",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			document.close();
			//file.close();
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

	public String create_land_certificate_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number)
			throws IOException, SQLException, JSONException, ParseException {

		String output_cetfificate_template = "";

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		output_cetfificate_template += "THIS IS TO CERTIFY THAT ";
		output_cetfificate_template += ar_name;
		output_cetfificate_template += " of Accra in the Greater Accra Region";
		output_cetfificate_template += " of the Republic of Ghana is registered as tenant or lessee for the unexpired";
		LocalDateTime localDateTime = LocalDateTime.parse(commencement_date);

		Month month_c = localDateTime.getMonth();
		int day_c = localDateTime.getDayOfMonth();
		int year_c = localDateTime.getYear();

		output_cetfificate_template += " residue of a lease for a term of " + term + " years from the "
				+ specialNamesMonthDay[day_c] + " day of " + convertToTitleCaseIteratingChars(month_c.toString()) + ", "
				+ year_c + " subject to the";

		output_cetfificate_template += " reservations, restrictions, encumbrances, liens and interests as are notified";
		output_cetfificate_template += " by memorial underwritten or endorsed hereon, of and in ALL THAT piece or";
		output_cetfificate_template += " Parcel of land in extent " + extent + " more or less being ";
		output_cetfificate_template += "GLPIN No. " + glpin + ", SECTION " + registration_section_number + " BLOCK "
				+ registration_block_number + ", situate at " + locality;
		output_cetfificate_template += " in the Greater Accra Region of the Republic of Ghana aforesaid which";
		output_cetfificate_template += " said piece or parcel of land is more particularly delineated on Registry Map";
		output_cetfificate_template += " No. " + registry_mapref
				+ " in the Lands Commission, Cantonment Accra, and being the piece or";
		output_cetfificate_template += " parcel of land shown and edged with pink color on Survey Plan No. " + plan_no;
		output_cetfificate_template += " annexed to this Certificate except and reserved all minerals, oils, precious";
		output_cetfificate_template += " stones and timber whatsoever upon or under the said piece or parcel of land.";

		return output_cetfificate_template;

	}

	public String create_land_register_description_of_land(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number)
			throws IOException, SQLException, JSONException {

		String output_cetfificate_template = "";
		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_register_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();

		String locality = (String) parcel_details_obj.get("locality").toString();

		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");
		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();

		// file.;
		try {

			output_cetfificate_template += "All that piece or parcel of land in extent " + extent;
			output_cetfificate_template += " more or less being GLPIN " + glpin + ", " + parcel_description
					+ " situate at " + locality;
			output_cetfificate_template += " in the Greater Accra Region of the Republic of Ghana as delineated on Registry Map No. ";
			output_cetfificate_template += registry_mapref;
			output_cetfificate_template += " in the Lands Commission, Cantonment-Accra, Accra and being the piece or parcel of land shown and edged with pink colour on Plan No. ";
			output_cetfificate_template += plan_no + " annexed to the Land Certificate. ";
			return output_cetfificate_template;
		} catch (Exception e) {
			e.printStackTrace();
		}

		finally {

		}
		return output_cetfificate_template;

	}

	public byte[] create_land_certificate_typed_old(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String type_of_certificate, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");
		String memo_entry_no = (String) case_obj.getString("memo_entry_no");
		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		
		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment_bob = (String)  job_detail_obj.get("remark_or_comment").toString();

		//String type_of_certicate_final = type_of_certificate == "Land Certificate" ? "LAND CERTIFICATE" : type_of_certificate;

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 50, 50, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			//codeQrImage.setAbsolutePosition(420, 690);
			//codeQrImage.setAbsolutePosition(420, 690);
			codeQrImage.setAbsolutePosition(50, 670);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			//document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			//image1.setAbsolutePosition(50, 670);
			image1.setAbsolutePosition(420, 690);
			//document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 770);
			cbaddress.showText("         		" + certificate_number);

			cbaddress.setTextMatrix(70, 755);
			cbaddress.showText("         		" + volume_number);

			cbaddress.setTextMatrix(70, 740);
			cbaddress.showText("          		" + folio_number);

			// cbaddress.setTextMatrix(400, 780);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
		 document.add(new Phrase(Chunk.NEWLINE));
			 document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			//document.add(p_1);

			Paragraph y_1 = new Paragraph(type_of_certificate.toUpperCase(), new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			//document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			document.add(new Phrase(Chunk.NEWLINE));

			HTMLWorker htmlWorker = new HTMLWorker(document);
			htmlWorker.parse(new StringReader(remark_or_comment_bob));

			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			Month month = currentTime.getMonth();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			String cert_text2 = "";
			cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
			cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
					+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

			Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12));
			p_3.setAlignment(Element.ALIGN_JUSTIFIED);
			p_3.setLeading(32);
			document.add(p_3);

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {
				//if ( !certificete_approval_status.equals("0") && !certificete_approval_status.equals("null") && certificete_approval_status.equals("1") ) {

				File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(software_file_location + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {
					Paragraph y_tna = new Paragraph("Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}



			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			//document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("FOR: CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			//document.add(p_5);

			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			// PdfPCell cell_memorials = new PdfPCell(new Paragraph("Leases,
			// Charges, Encumbrances, etc. Affecting Land",font10pt));
			// cell_memorials.setColspan(9);
			// cell_land_certificate.setHorizontalAlignment(Element.ALIGN_CENTER);
			// cell.setPadding(10.0f);
			// cell_land_certificate.setBackgroundColor(new BaseColor(140, 221,
			// 8));
			// myTable_memorials.addCell(cell_memorials);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument.", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			/*
			 * PdfPCell cell_folio_reference = new PdfPCell(new
			 * Paragraph("Folio Reference No",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * cell_folio_reference.setColspan(2);
			 * myTable_memorials.addCell(cell_folio_reference);
			 */

			// PdfPCell CellFourHdr_memorials = new PdfPCell(new
			// Paragraph("Remarks",font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			// myTable_memorials.addCell(CellFourHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			/*
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * 
			 * PdfPCell CellSixHdr_memorials = new PdfPCell(new
			 * Paragraph("Back",font10pt));
			 * //CellTenHdr_proprietors.setRowspan(1);
			 * myTable_memorials.addCell(CellSixHdr_memorials);
			 * 
			 * 
			 * PdfPCell CellSevenHdr_memorials = new PdfPCell(new
			 * Paragraph("Forward",font10pt));
			 * //CellOneHdr_proprietors.setRowspan(2);
			 * myTable_memorials.addCell(CellSevenHdr_memorials);
			 * 
			 * 
			 * 
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 * myTable_memorials.addCell(EmptyCell_memorials);
			 */

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null" && json_lrd_memorials_section != null) {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					
					myTable_memorials.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("m_entry_number"), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);

					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					LocalDateTime localDateTime2 = LocalDateTime
							.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));

					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no") + "/" + memo_entry_no, font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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

	public byte[] create_land_certificate_typed(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String type_of_certificate, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");
		String certificate_approved_date = case_obj.isNull("certificate_approved_date") ? "" : case_obj.optString("certificate_approved_date");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();
		String date_of_issue = (String) transaction_details_obj.get("date_of_issue").toString();
		
		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		String remark_or_comment_bob = (String)  job_detail_obj.get("remark_or_comment").toString();

		//String type_of_certicate_final = type_of_certificate == "Land Certificate" ? "LAND CERTIFICATE" : type_of_certificate;

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			//codeQrImage.setAbsolutePosition(420, 690);
			//codeQrImage.setAbsolutePosition(420, 690);
			codeQrImage.setAbsolutePosition(50, 670);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(90.0F, 90.0F);
			//image1.setAbsolutePosition(50, 670);
			image1.setAbsolutePosition(450, 680);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(60, 780);
			cbaddress.showText("Cert. No: " + certificate_number);

			cbaddress.setTextMatrix(60, 765);
			cbaddress.showText("Volume: " + volume_number);

			cbaddress.setTextMatrix(60, 750);
			cbaddress.showText("Folio: " + folio_number);

			// cbaddress.setTextMatrix(400, 780);
			// cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
			// Font.BOLD);
			Paragraph p_1 = new Paragraph("REPUBLIC OF GHANA", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			type_of_certificate = (type_of_certificate == null) ? "" : type_of_certificate;

			Paragraph y_1 = new Paragraph(type_of_certificate.toUpperCase(), new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);

			// document.add(new Phrase(Chunk.NEWLINE));

			Font small_bold = new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD);
			Font small = new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL);

			document.add(new Phrase(Chunk.NEWLINE));


            // Create a StyleSheet and set line spacing
           // StyleSheet styles = new StyleSheet();
          //  styles.loadTagStyle("body", "leading", "40"); // Set line spacing (leading) to 20


			// HTMLWorker htmlWorker = new HTMLWorker(document);
			// htmlWorker.parse(new StringReader(remark_or_comment_bob));

  			// Define your CSS for Times New Roman and justified text
 			 String css = "body { font-family: Times New Roman; text-align: justify; }";

  			// Use XMLWorkerHelper to parse HTML and apply CSS
  			//XMLWorkerHelper.getInstance().parseXHtml(writer, document, new StringReader(htmlContent), new StringReader(css));

			Font timesNewRoman = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12, Font.NORMAL);
			Font timesNewRoman_bold = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12, Font.BOLD);

			String htmlContent = "<html><body><p>THIS IS TO CERTIFY THAT Sam of Accra in the Greater Accra Region of the Republic of Ghana is registered as tenant or lessee for the unexpired residue of a lease for a term of 99 years from the  twenty seventh day of September, 2023 subject to the reservations, restrictions, encumbrances, liens and interests as are notified by memorial underwritten or endorsed hereon, of and in ALL THAT piece or Parcel of land in extent 0.230 more or less being GLPIN No. GA329393-1148882, SECTION 024 BLOCK 123, situate at AJANGORTEY in the Greater Accra Region of the Republic of Ghana aforesaid which said piece or parcel of land is more particularly delineated on Registry Map No. 79ui in the Lands Commission, Cantonment Accra, and being the piece or parcel of land shown and edged with pink color on Survey Plan No. 7899 annexed to this Certificate except and reserved all minerals, oils, precious stones and timber whatsoever upon or under the said piece or parcel of land..</p></body></html>";

// Replace a value in the string
remark_or_comment_bob= remark_or_comment_bob.replace("<ol><li>", "<html><body><p>");
remark_or_comment_bob= remark_or_comment_bob.replace("</li></ol>", "</p></body></html>");


  // Create a StyleSheet
  StyleSheet styles = new StyleSheet();
  styles.loadTagStyle("body", "font-family", "Times-Roman");
  styles.loadTagStyle("body", "font-size", "12pt");
  styles.loadTagStyle("p", "alignment", "justify");
  styles.loadTagStyle("b", "font-weight", "bold");

  // Parse the HTML content using HTMLWorker
  HTMLWorker htmlWorker = new HTMLWorker(document);
  htmlWorker.setStyleSheet(styles);

  // Parse and add content to the document
  java.util.List<Element> elements = htmlWorker.parseToList(new StringReader(remark_or_comment_bob), styles);
  //for (Element element : elements) {
	for (Element element : elements) {
		if (element instanceof Paragraph) {
			// Create a new Paragraph from the original one and set the font and alignment
			// Paragraph originalParagraph = (Paragraph) element;
			// Paragraph newParagraph = new Paragraph(originalParagraph.getContent(), timesNewRoman);
			
			// Paragraph paragraph = (Paragraph) element;
			
			// newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
			// newParagraph.setLeading(30f); 
			// newParagraph.setSpacingAfter(20f);  // Add spacing after each paragraph
			// document.add(newParagraph);

			// document.add(element);
			//System.out.println("Par 1");
			Paragraph paragraph = (Paragraph) element;
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED); // Ensure justification
			paragraph.setLeading(25f); 
			paragraph.setSpacingAfter(10f);  // Add spacing after each paragraph
			document.add(paragraph);

		} else if (element instanceof Phrase) {
			// Create a new Paragraph from the Phrase and apply formatting
			Phrase originalPhrase = (Phrase) element;
			Paragraph newParagraph = new Paragraph(originalPhrase.getContent(), timesNewRoman);
			newParagraph.setAlignment(Element.ALIGN_JUSTIFIED);  // Set text justification
			newParagraph.setLeading(25f); 
			newParagraph.setSpacingAfter(10f);  // Add spacing after each paragraph
			document.add(newParagraph);
			System.out.println("Par 2");
		} else if (element instanceof Chunk) {
			// Create a new Chunk and apply font
			Chunk originalChunk = (Chunk) element;
			Chunk newChunk = new Chunk(originalChunk.getContent(), timesNewRoman);

			document.add(newChunk);
		} else {
			// For other types of elements, just add them without changes
			document.add(element);
		}
	//document.add(element);
  }



      
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + date_of_issue);

			
			
			
			

			if ( date_of_issue != null && date_of_issue != "null" ) {

				// Parse the string to OffsetDateTime
				//OffsetDateTime offsetDateTime = OffsetDateTime.parse(date_of_issue);
				LocalDateTime dateTime =LocalDateTime.parse(date_of_issue);
				//DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				//LocalDateTime dateTime = offsetDateTime.toLocalDateTime();
				System.out.println("Date of Issue as LocalDateTime: " + dateTime);
				LocalDate date1 = dateTime.toLocalDate();
				System.out.println("Date : " + date1);

				Month month = dateTime.getMonth();
				int day = dateTime.getDayOfMonth();
				int year = dateTime.getYear();

				// System.out.println("Month : " + month);
				// System.out.println("Day : " + day);
				// System.out.println("Seconds : " + seconds);

				document.add(new Phrase(Chunk.NEWLINE));
				// document.add(new Phrase(Chunk.NEWLINE));

				String cert_text2 = "";
				cert_text2 += "IN WITNESS WHEREOF I have hereunto signed my name and affixed the seal of the";
				cert_text2 += " Lands Commission this " + specialNamesMonthDay_short[day] + " day of "
						+ convertToTitleCaseIteratingChars(month.toString()) + ", " + year + ".";

				Paragraph p_3 = new Paragraph(cert_text2, new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
				p_3.setAlignment(Element.ALIGN_JUSTIFIED);
				p_3.setLeading(20);
				document.add(p_3);

			} else {


			}





			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {

				File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(software_file_location + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {

					Paragraph y_tna = new Paragraph("Certificate Not Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					//document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				//document.add(y_tna);
			}



			Paragraph p_4 = new Paragraph(".......................................",
					new Font(FontFamily.TIMES_ROMAN, 12));
			p_4.setAlignment(Element.ALIGN_CENTER);
			document.add(p_4);

			// document.add(new Phrase(Chunk.NEWLINE));

			Paragraph p_5 = new Paragraph("FOR: CHIEF REGISTRAR OF LANDS ", new Font(FontFamily.TIMES_ROMAN, 12));
			p_5.setAlignment(Element.ALIGN_CENTER);
			document.add(p_5);

			


			document.newPage();

			Paragraph p_6 = new Paragraph("MEMORIALS", new Font(FontFamily.TIMES_ROMAN, 12, Font.BOLD));
			p_6.setAlignment(Element.ALIGN_CENTER);
			document.add(p_6);

			// Inserting Table in PDF
			PdfPTable myTable_memorials = new PdfPTable(6);
			myTable_memorials.setWidthPercentage(100);
			// Left aLign
			myTable_memorials.setTotalWidth((float) 300.0);
			;
			myTable_memorials.setHorizontalAlignment(0);
			myTable_memorials.setSpacingAfter(10);
			myTable_memorials.setTotalWidth(new float[] { 25, 50, 50, 50, 160, 30 });

			PdfPCell EmptyCell_memorials = new PdfPCell(new Paragraph("", font10pt));
			EmptyCell_memorials.setBorderWidth(0);
			// CellOneHdr_proprietors.setRowspan(2);

			PdfPCell CellOneHdr_memorials = new PdfPCell(new Paragraph("Entry No", font10pt));
			// CellOneHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellOneHdr_memorials);

			PdfPCell CellTwoHdr_memorials = new PdfPCell(new Paragraph("Date of Instrument", font10pt));
			// CellTwoHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTwoHdr_memorials);

			PdfPCell CellTreeHdr_memorials = new PdfPCell(new Paragraph("Date of Registration", font10pt));
			// CellTreeHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellTreeHdr_memorials);

			PdfPCell CellNineHdr_memorials = new PdfPCell(new Paragraph("Registered No.", font10pt));
			// cell_interest.setColspan(5);
			myTable_memorials.addCell(CellNineHdr_memorials);

			PdfPCell CellTenHdr_memorials = new PdfPCell(new Paragraph("Memorials", font10pt));
			// CellNineHdr_proprietors.setRowspan(1);
			// CellTenHdr_memorials.setColspan(2);
			myTable_memorials.addCell(CellTenHdr_memorials);

			PdfPCell CellFiveHdr_memorials = new PdfPCell(new Paragraph("Cancellation", font10pt));
			// CellTenHdr_proprietors.setRowspan(1);
			myTable_memorials.addCell(CellFiveHdr_memorials);

			

			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			Integer NumberCount_memo = 1;
			// String json_data_land_certificate = "";
			if (json_lrd_memorials_section != "null" && json_lrd_memorials_section != null) {
				JSONArray jArr_memorials = new JSONArray(json_lrd_memorials_section);
				for (int i = 0; i < jArr_memorials.length(); i++) {
					JSONObject obj_memorials = jArr_memorials.getJSONObject(i);
					myTable_memorials.addCell(new PdfPCell(new Phrase((String) obj_memorials.getString("m_entry_number"), font10pt)));
					// System.out.println("Seconds : " + seconds);

					LocalDateTime localDateTime1 = LocalDateTime.parse((String) obj_memorials.getString("m_date_of_instrument"));
					String m_date_of_instrument = localDateTime1.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_instrument, font10pt)));

					
					LocalDateTime localDateTime2 = LocalDateTime.parse((String) obj_memorials.getString("m_date_of_registration"));
					String m_date_of_registration = localDateTime2.format(formatter1);
					myTable_memorials.addCell(new PdfPCell(new Phrase(m_date_of_registration, font10pt)));


					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_registered_no"), font10pt)));
					myTable_memorials.addCell(
							new PdfPCell(new Phrase((String) obj_memorials.getString("m_memorials"), font10pt)));

					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_back"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_forward"),font10pt)));
					// myTable_memorials.addCell(new PdfPCell(new
					// Phrase((String)obj_memorials.getString("m_remarks"),font10pt)));
					myTable_memorials.addCell(new PdfPCell(new Phrase("", font10pt)));
					NumberCount_memo += 1;
				}
			}

			/*
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("1 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("3/7/26/1",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("Michael Yow Manu ",font10pt)));
			 * myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("28/10/1974 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Assignment of Lease for 99 years from 01/11/1974"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("23/07/1997 ",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new
			 * Phrase("Government of the Republic of Ghana (1) Michael Yaw Manu (2)"
			 * ,font10pt))); myTable_memorials.addCell(new PdfPCell(new
			 * Phrase("C39.00/Year",font10pt))); myTable_memorials.addCell(new
			 * PdfPCell(new Phrase("",font10pt)));
			 */

			myTable_memorials.setSpacingBefore(5.0f); // Space Before table
														// starts, like
														// margin-top in CSS
			myTable_memorials.setSpacingAfter(5.0f); // Space After table
														// starts, like
														// margin-Bottom in CSS

			document.add(myTable_memorials);

			document.close();
			//file.close();
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

	public byte[] create_deeds_certificate_typed(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number,String type_of_certificate, String output_file)
			throws IOException, SQLException, JSONException, ParseException {
		/*
		 * Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD); Font
		 * normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);
		 */

		/// cls_case_management.select_lrd_recodes_for_certificate_by_case_number(case_number);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		String case_records = cls_case_management
				.select_lrd_recodes_for_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String json_lrd_memorials_section = (String) case_obj.getString("lrd_memorials_section");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();
		String parcel_remarks = (String) parcel_details_obj.get("remarks").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();
		String deed_number = (String) transaction_details_obj.get("deed_number").toString();
		String file_number = (String) transaction_details_obj.get("file_number").toString();
		String ls_number = (String) transaction_details_obj.get("ls_number").toString();
		String ground_rent = (String) transaction_details_obj.get("ground_rent").toString();
		


		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();
		// String remark_or_comment = (String)
		// job_detail_obj.get("remark_or_comment").toString();

		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// file.;
		try {

			Document document = new Document(PageSize.A4, 60, 60, 25, 25);
			PdfWriter writer = PdfWriter.getInstance(document, out);
			document.open();// PDF document opened........
			PdfContentByte cb = writer.getDirectContent();

			/*
			 * Barcode128 code128 = new Barcode128();
			 * code128.setCode("123456789");
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100,100);
			 * code128Image.setAbsolutePosition(20,770);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */

			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(file_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(80, 80);
			codeQrImage.setAbsolutePosition(420, 690);
			document.add(codeQrImage);

			Image image = Image.getInstance(software_file_location + "CoatofArm.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image.scaleToFit(100.0F, 100.0F);
			image.setAbsolutePosition(240, 710);
			document.add(image);

			Image image1 = Image.getInstance(software_file_location + "NewLogo.jpg");
			// imgPDF2.ScaleToFit(100.0F, 70.0F)
			image1.scaleToFit(70.0F, 70.0F);
			image1.setAbsolutePosition(50, 670);
			document.add(image1);

			Font font = new Font(FontFamily.TIMES_ROMAN);
			Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
			Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

			document.add(new Phrase(Chunk.NEWLINE));

			BaseFont bfaddress = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
			PdfContentByte cbaddress = writer.getDirectContent();
			cbaddress.beginText();
			cbaddress.setFontAndSize(bfaddress, 11);

			cbaddress.setTextMatrix(70, 780);
			cbaddress.showText("LS No: " + certificate_number);

			cbaddress.setTextMatrix(70, 765);
			cbaddress.showText("Deed Number: " + parcel_remarks);

			// cbaddress.setTextMatrix(70, 750);
			// cbaddress.showText("Folio: " + folio_number);

			cbaddress.setTextMatrix(400, 780);
			cbaddress.showText("LANDS COMMISSION");

			cbaddress.endText();

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));

			// Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,

			// Font.BOLD);
			// Get the current date and time
			LocalDateTime currentTime = LocalDateTime.now();
			System.out.println("Current DateTime: " + currentTime);

			LocalDate date1 = currentTime.toLocalDate();
			System.out.println("Date : " + date1);

			int month = currentTime.getMonthValue();
			int day = currentTime.getDayOfMonth();
			int year = currentTime.getYear();

			// System.out.println("Month : " + month);
			// System.out.println("Day : " + day);
			// System.out.println("Seconds : " + seconds);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));
			Paragraph p_1 = new Paragraph("LANDS COMMSSION", new Font(FontFamily.TIMES_ROMAN, 18, Font.BOLD));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			document.add(new Phrase(Chunk.NEWLINE));

			// BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			// Image codeQrImage = barcodeQRCode.getImage();
			// codeQrImage.scaleAbsolute(100, 100);
			// codeQrImage.setAbsolutePosition(20, 480);
			// document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			Paragraph y_1 = new Paragraph("CERTIFICATE OF REGISTRATION OF INSTRUMENT",
					new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
			y_1.setAlignment(Element.ALIGN_CENTER);
			document.add(y_1);


			System.out.println("Registration DateTime: " + date_of_registration);

			SimpleDateFormat datetimeFormatter2 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date n_date_of_registration = datetimeFormatter2.parse(date_of_registration);

			Paragraph p4 = new Paragraph(
					"This instrument is registered under Section 216 of the Land Act, 2020 (Act1036) this" + "[Day] day of [Month], [year]" + (n_date_of_registration.toGMTString()).replace("00:00:00 GMT", ""), new Font(FontFamily.TIMES_ROMAN, 14));
			p4.setAlignment(Element.ALIGN_LEFT);
			document.add(p4);

			Paragraph p6_7 = new Paragraph("Grantor: " + grantors_name , new Font(FontFamily.TIMES_ROMAN, 14));
			p6_7.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_7);

			Paragraph p6_8 = new Paragraph("Grantee: " + ar_name, new Font(FontFamily.TIMES_ROMAN, 14));
			p6_8.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_8);

			Paragraph p6_9 = new Paragraph("Instrument Type: " + nature_of_instrument, new Font(FontFamily.TIMES_ROMAN, 14));
			p6_9.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_9);


			SimpleDateFormat datetimeFormatter1 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date date_of_instrument = datetimeFormatter1.parse(date_of_document);
			//date_of_instrument = date_of_instrument.toGMTString();

			Paragraph p6_2 = new Paragraph("Date of Instrument: " + (date_of_instrument.toGMTString()).replace("00:00:00 GMT", ""), new Font(FontFamily.TIMES_ROMAN, 14));
			p6_2.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_2);

			Date now = new Date();

			Paragraph p6_3 = new Paragraph("Deed Number " + deed_number, new Font(FontFamily.TIMES_ROMAN, 14));
			p6_3.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_3);

			Paragraph p6_4 = new Paragraph("Land Serial Number: " + ls_number, new Font(FontFamily.TIMES_ROMAN, 14));
			p6_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_4);

			Paragraph p6_5 = new Paragraph("Job Number: " + job_number, new Font(FontFamily.TIMES_ROMAN, 14));
			p6_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_5);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));


			SimpleDateFormat format = new SimpleDateFormat("dd-MM-YYYY");

			// String dateString = format.format( new Date() );
			// Date date = format.parse ( "2009-12-31" );

			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			document.close();
			//file.close();
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

	public String create_inspection_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number, String job_number)
			throws Exception {
		String output_cetfificate_template = "";

		output_cetfificate_template += "The above subject matter refers";
		output_cetfificate_template += "The publict and Vested Lands Management Division (PVLMD) is considering the subject matter. ";
		output_cetfificate_template += "I am directed to request for your comments on the zonning of the subject and its conformity to the approved planning scheme for the area.";
		output_cetfificate_template += " counting on your co-operation.";
		output_cetfificate_template += " Thank you.";

		return output_cetfificate_template;
	}

	public String create_certificate_search_template(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number) throws Exception {
		String output_cetfificate_template = "";

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);


		System.out.println(request_json.toString());
		
		String case_records = cls_case_management
				.select_records_for_certificate_search_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());
						System.out.println(case_records.toString());
		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("s_p_transaction_details").toString();
		String job_detail = case_obj.get("s_p_job_detail").toString();

		String grantor_name = case_obj.get("grantor_name").toString();
		String client_name = case_obj.get("client_name").toString();

		String lrd_encumbrances_section = case_obj.get("lrd_encumbrances_section").toString();


		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		//String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		
		
        String date_of_issue = (String) transaction_details_obj.get("date_of_issue").toString();
		String registered_number = (String) transaction_details_obj.get("registered_number").toString();
		

		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String description_of_land = (String) job_detail_obj.get("smd_region").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		LocalDateTime currentTime = LocalDateTime.now();
		System.out.println("Current DateTime: " + currentTime);

		LocalDate date1 = currentTime.toLocalDate();
		System.out.println("Date : " + date1);

		Month month = currentTime.getMonth();
		int day = currentTime.getDayOfMonth();
		int year = currentTime.getYear();

		// + specialNamesMonthDay_short[day] + " day of " +
		// convertToTitleCaseIteratingChars(month.toString())
		// + ", " + year + ".";

	//output_cetfificate_template += "<b>DATE OF ISSUANCE</b> : " + date_of_issue + "\r\n";
		
		if ( description_of_land != null && description_of_land != "null" ) {
			output_cetfificate_template += "<b>DESCRIPTION OF LAND</b> :" + description_of_land.toUpperCase() + "\r\n";
		}else{
			output_cetfificate_template += "<b>DESCRIPTION OF LAND</b> :"  + "\r\n";
		}
		
		if ( grantor_name != null && grantor_name != "null" ) {
			output_cetfificate_template += "<b>GRANTOR</b> : " + grantor_name.toUpperCase() + "\r\n";
		}else{
			output_cetfificate_template += "<b>GRANTOR</b> : "  + "\r\n";
		}
		

		if ( client_name != null && client_name != "null" ) {
			output_cetfificate_template += "<b>PROPRIETOR</b>:" + client_name.toUpperCase() + "\r\n";
	
		}else{
			output_cetfificate_template += "<b>PROPRIETOR</b>:" + "\r\n";
	
		}
		

		if ( date_of_registration != null && date_of_registration != "null" ) {
		
			output_cetfificate_template += "<b>DATE OF REGISTRATION</b> : " + date_of_registration + "\r\n";
	
		}else{

			output_cetfificate_template += "<b>DATE OF REGISTRATION</b> : "  + "\r\n";
	
		}
		

		if ( nature_of_instrument != null && nature_of_instrument != "null" ) {
			output_cetfificate_template += "<b>NATURE OF INTEREST</b> :" + nature_of_instrument.toUpperCase() + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>NATURE OF INTEREST</b> :"  + "\r\n";
		
		}
		



		if ( term != null && term != "null" ) {
			output_cetfificate_template += "<b>TERM</b> : " + term.toUpperCase() + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>TERM</b> : " + "\r\n";
		
		}
		
		if ( commencement_date != null && commencement_date != "null" ) {
			output_cetfificate_template += "<b>COMMENCEMENT DATE</b> :" + commencement_date.toUpperCase() + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>COMMENCEMENT DATE</b> :"  + "\r\n";

		}
		
		if ( certificate_number != null && certificate_number != "null" ) {
			output_cetfificate_template += "<b>LAND CERTIFICATE NUMBER</b> :" + certificate_number + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>LAND CERTIFICATE NUMBER</b> :" + "\r\n";
		
		}
		
		if ( certificate_type != null && certificate_type != "null" ) {
			output_cetfificate_template += "<b>CERTIFICATE TYPE</b> :" + certificate_type.toUpperCase() + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>CERTIFICATE TYPE</b> :" + "\r\n";
		
		}
		
		if ( lrd_encumbrances_section != null && lrd_encumbrances_section != "null" ) {
			output_cetfificate_template += "<b>ENCUMBRANCE</b>: " + lrd_encumbrances_section.toUpperCase() + "\r\n";
		
		}else{
			output_cetfificate_template += "<b>ENCUMBRANCE</b>: " + "\r\n";
		
		}
		
		if ( registered_number != null && registered_number != "null" ) {
			output_cetfificate_template += "<b>REGISTERED NUMBER</b>: " + registered_number + "\r\n";

		}else{
			output_cetfificate_template += "<b>REGISTERED NUMBER</b>: " + "\r\n";

		}
		
		
		return output_cetfificate_template;
	}

	public byte[] create_generate_memo_for_certificate(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String ws_login_user,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		System.out.println(request_json.toString());

		String case_records = cls_case_management
				.select_lrd_recodes_for_mortgage_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String lrd_memorials_section = (String) case_obj.getString("lrd_memo_section");
		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");
		String proprietor_name = (String) case_obj.getString("proprietor_name");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		String registered_number = (String) transaction_details_obj.get("registered_number").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		JSONObject lrd_memorials_section_obj;
		lrd_memorials_section_obj = new JSONObject(lrd_memorials_section);
		String m_memorials = (String) lrd_memorials_section_obj.get("m_memorials").toString();
		String m_registered_no = (String) lrd_memorials_section_obj.get("m_registered_no").toString();
		String m_date_of_instrument = (String) lrd_memorials_section_obj.get("m_date_of_instrument").toString();
		String m_date_of_registration = (String) lrd_memorials_section_obj.get("m_date_of_registration").toString();
		String m_back = (String) lrd_memorials_section_obj.get("m_back").toString();
		String m_forward = (String) lrd_memorials_section_obj.get("m_forward").toString();
		String m_remarks = (String) lrd_memorials_section_obj.get("m_remarks").toString();

		// Date new_date_of_document = new Date(date_of_document);
		// Date new_date_of_registration = new Date(date_of_registration);

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

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("LAND REGISTRATION DIVISION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			Paragraph p_3_1 = new Paragraph("MEMORANDUM OF REGISTRATION OF MORTGAGE", new Font(FontFamily.TIMES_ROMAN, 14));
			p_3_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3_1);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			
			SimpleDateFormat datetimeFormatter2 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date n_date_of_registration = datetimeFormatter2.parse(m_date_of_registration);

			Paragraph p4 = new Paragraph(
					"This instument has been duly registered according to law on: " + (n_date_of_registration.toGMTString()).replace("00:00:00 GMT", ""),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_LEFT);
			document.add(p4);

			Paragraph p6_7 = new Paragraph("Proprietor Name: " + proprietor_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_7.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_7);

			Paragraph p6_1 = new Paragraph("Registered No: " + m_registered_no, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_1.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_1);

			SimpleDateFormat datetimeFormatter1 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date date_of_instrument = datetimeFormatter1.parse(m_date_of_instrument);
			//date_of_instrument = date_of_instrument.toGMTString();

			Paragraph p6_2 = new Paragraph("Date of Instrument: " + (date_of_instrument.toGMTString()).replace("00:00:00 GMT", ""), new Font(FontFamily.TIMES_ROMAN, 10));
			p6_2.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_2);

			Date now = new Date();

			Paragraph p6_3 = new Paragraph("Date of Issue: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p6_3.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_3);

			Paragraph p6_4 = new Paragraph("Memorials: " + m_memorials, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_4);

			Paragraph p6_5 = new Paragraph("Job Number: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_5);

			// Paragraph p8_1 = new Paragraph("Fee Paid GHS: " + "0.00", new Font(FontFamily.TIMES_ROMAN, 10));
			// p8_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(p8_1);

			// Paragraph p9_1 = new Paragraph("Receipt No: " + "" + "Date:" + now.toGMTString(),
			// 		new Font(FontFamily.TIMES_ROMAN, 10));
			// p9_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(p9_1);

			// Paragraph p9_2 = new Paragraph("Register: Vol: " + volume_number + " Folio:" + folio_number,
			// 		new Font(FontFamily.TIMES_ROMAN, 10));
			// p9_2.setAlignment(Element.ALIGN_LEFT);
			// document.add(p9_2);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p6 = new Paragraph("Client Name: " + ar_name, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p6.setAlignment(Element.ALIGN_LEFT); document.add(p6);
			 */
			/*
			 * Paragraph p8 = new Paragraph("Service Type: " +
			 * business_process_sub_name, new Font(FontFamily.TIMES_ROMAN, 10));
			 * p8.setAlignment(Element.ALIGN_LEFT); document.add(p8);
			 */

			/*
			 * Paragraph p9 = new Paragraph("Case Number: " + case_number, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p9.setAlignment(Element.ALIGN_LEFT); document.add(p9);
			 */
			// Paragraph p10 = new Paragraph("Job Number: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			// p10.setAlignment(Element.ALIGN_LEFT);
			// document.add(p10);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph p14 = new Paragraph("FORM LR. 34 ", new Font(FontFamily.TIMES_ROMAN, 10));
			// p14.setAlignment(Element.ALIGN_LEFT);
			// document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(job_number,
			 * 1000, 1000, null); Image codeQrImage_sign =
			 * barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310, 380);
			 * document.add(codeQrImage_sign);
			 */

			 if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {
				//if ( !certificete_approval_status.equals("0") && !certificete_approval_status.equals("null") && certificete_approval_status.equals("1") ) {

				File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(software_file_location + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {
					Paragraph y_tna = new Paragraph("Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}

			 Paragraph p14 = new Paragraph(".....................................................", new Font(FontFamily.TIMES_ROMAN, 10));
			 p14.setAlignment(Element.ALIGN_CENTER);
			document.add(p14);

			Paragraph p15 = new Paragraph("FOR: CHIEF REGSTRAR OF LANDS", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_CENTER);
			document.add(p15);

			document.close();
			//file.close();
		return out.toByteArray();
		
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
	

	public byte[] create_generate_discharge_memo_for_certificate(String web_service_url, String web_service_api_key,
			String software_file_location, String case_number,
			String job_number, String ws_login_user,
			String output_file) throws IOException, SQLException, JSONException, ParseException {
		Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
		Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

		JSONObject request_json = new JSONObject();

		request_json.put("transaction_number", case_number);
		request_json.put("job_number", job_number);

		System.out.println(request_json.toString());

		String case_records = cls_case_management
				.select_lrd_recodes_for_mortgage_certificate_by_case_number(web_service_url,
						web_service_api_key,
						request_json.toString());

						System.out.println(case_records);

		JSONObject case_obj;
		case_obj = new JSONObject(case_records);

		String parcel_details = case_obj.get("parcel_details").toString();
		String transaction_details = case_obj.get("transaction_details").toString();
		String job_detail = case_obj.get("job_detail").toString();
		String lrd_memorials_section = (String) case_obj.getString("lrd_memo_section");
		String certificete_approval_status = case_obj.get("certificete_approval_status").toString();
		String certificate_approved_by = (String) case_obj.getString("certificate_approved_by");
		String proprietor_name = (String) case_obj.getString("proprietor_name");

		JSONObject parcel_details_obj;
		parcel_details_obj = new JSONObject(parcel_details);
		String glpin = (String) parcel_details_obj.get("glpin").toString();
		String licensed_surveyor_number = (String) parcel_details_obj.get("licensed_no").toString();
		String regional_number = (String) parcel_details_obj.get("regional_number").toString();
		String locality = (String) parcel_details_obj.get("locality").toString();
		String district = (String) parcel_details_obj.get("district").toString();
		String region = (String) parcel_details_obj.get("region").toString();
		String size_of_land = (String) parcel_details_obj.get("land_size").toString();
		String extent = (String) parcel_details_obj.get("extent").toString();
		String registry_mapref = (String) parcel_details_obj.get("registry_mapref").toString();
		String plan_no = (String) parcel_details_obj.get("plan_no").toString();
		String cc_no = (String) parcel_details_obj.get("cc_no").toString();
		String ltr_plan_no = (String) parcel_details_obj.get("ltr_plan_no").toString();
		String locality_class = (String) parcel_details_obj.get("locality_class").toString();
		String registration_district_number = (String) parcel_details_obj.get("registration_district_number")
				.toString();
		String registration_section_number = (String) parcel_details_obj.get("registration_section_number").toString();
		String registration_block_number = (String) parcel_details_obj.get("registration_block_number").toString();

		JSONObject transaction_details_obj;
		transaction_details_obj = new JSONObject(transaction_details);
		String ar_name = (String) transaction_details_obj.get("ar_name").toString();
		String new_case_number = (String) transaction_details_obj.get("case_number").toString();
		String date_of_document = (String) transaction_details_obj.get("date_of_document").toString();
		String nature_of_instrument = (String) transaction_details_obj.get("nature_of_instrument").toString();
		String certificate_number = (String) transaction_details_obj.get("certificate_number").toString();

		String type_of_interest = (String) transaction_details_obj.get("type_of_interest").toString();
		String type_of_use = (String) transaction_details_obj.get("type_of_use").toString();
		String volume_number = (String) transaction_details_obj.get("volume_number").toString();
		String folio_number = (String) transaction_details_obj.get("folio_number").toString();
		String term = (String) transaction_details_obj.get("term").toString();
		String commencement_date = (String) transaction_details_obj.get("commencement_date").toString();

		String renewal_term = (String) transaction_details_obj.get("renewal_term").toString();
		String consideration_fee = (String) transaction_details_obj.get("consideration_fee").toString();
		String stamp_duty_payable = (String) transaction_details_obj.get("stamp_duty_payable").toString();
		String assessed_value = (String) transaction_details_obj.get("assessed_value").toString();
		String parcel_description = (String) transaction_details_obj.get("parcel_description").toString();
		String plot_number = (String) transaction_details_obj.get("plot_number").toString();
		// String parcel_description = (String)
		// transaction_details_obj.get("plot_number").toString();
		String publicity_date = (String) transaction_details_obj.get("publicity_date").toString();

		String family_of_grantor = (String) transaction_details_obj.get("family_of_grantor").toString();

		String rent_review_period = (String) transaction_details_obj.get("rent_review_period").toString();
		String annual_rent = (String) transaction_details_obj.get("annual_rent").toString();

		String rent_period_covered = (String) transaction_details_obj.get("rent_period_covered").toString();
		String rent_review_date = (String) transaction_details_obj.get("rent_review_date").toString();
		String date_of_first_payment = (String) transaction_details_obj.get("date_of_first_payment").toString();
		String outstanding_rent = (String) transaction_details_obj.get("outstanding_rent").toString();
		String remark_or_comment = (String) transaction_details_obj.get("remark_or_comment").toString();
		String date_of_registration = (String) transaction_details_obj.get("date_of_registration").toString();
		String case_status = (String) transaction_details_obj.get("case_status").toString();
		String grantors_name = (String) transaction_details_obj.getString("grantors_name");

		String stool_family_name = (String) transaction_details_obj.get("stool_family_name").toString();
		// String is_part_of_gelis_area",
		// transaction_details_obj.get("is_part_of_gelis_area").toString();
		String stamp_duty_description = (String) transaction_details_obj.get("stamp_duty_description").toString();
		String certificate_type = (String) transaction_details_obj.get("certificate_type").toString();
		String case_file_number = (String) transaction_details_obj.get("case_file_number").toString();
		// String phone_number",
		// job_detail_obj.get("phone_number").toString();
		String case_process_stage = (String) transaction_details_obj.get("case_process_stage").toString();

		String registered_number = (String) transaction_details_obj.get("registered_number").toString();

		JSONObject job_detail_obj;
		job_detail_obj = new JSONObject(job_detail);
		// String job_number = (String) job_number);
		String application_stage = (String) job_detail_obj.get("application_stage").toString();

		System.out.println(job_detail_obj.get("application_stage").toString());
		String business_process_id = (String) job_detail_obj.get("business_process_id").toString();
		String business_process_name = (String) job_detail_obj.get("business_process_name").toString();
		String business_process_sub_id = (String) job_detail_obj.get("business_process_sub_id").toString();
		String business_process_sub_name = (String) job_detail_obj.get("business_process_sub_name").toString();

		String embossed = (String) job_detail_obj.get("embossed").toString();

		JSONObject lrd_memorials_section_obj;
		lrd_memorials_section_obj = new JSONObject(lrd_memorials_section);
		String m_memorials = (String) lrd_memorials_section_obj.get("m_memorials").toString();
		String m_registered_no = (String) lrd_memorials_section_obj.get("m_registered_no").toString();
		String m_date_of_instrument = (String) lrd_memorials_section_obj.get("m_date_of_instrument").toString();
		String m_date_of_registration = (String) lrd_memorials_section_obj.get("m_date_of_registration").toString();
		String m_back = (String) lrd_memorials_section_obj.get("m_back").toString();
		String m_forward = (String) lrd_memorials_section_obj.get("m_forward").toString();
		String m_remarks = (String) lrd_memorials_section_obj.get("m_remarks").toString();

		// Date new_date_of_document = new Date(date_of_document);
		// Date new_date_of_registration = new Date(date_of_registration);

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

			Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 16));
			p_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_1);

			Paragraph p_3 = new Paragraph("LAND REGISTRATION DIVISION", new Font(FontFamily.TIMES_ROMAN, 14));
			p_3.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3);

			Paragraph p_3_1 = new Paragraph("DISCHARGE OF MORTGAGE", new Font(FontFamily.TIMES_ROMAN, 14));
			p_3_1.setAlignment(Element.ALIGN_CENTER);
			document.add(p_3_1);

			/*
			 * Barcode128 code128 = new Barcode128(); code128.setCode((String)
			 * jsonobj.getString("job_number"));
			 * code128.setCodeType(Barcode128.CODE128); Image code128Image =
			 * code128.createImageWithBarcode(cb, null, null);
			 * code128Image.scaleAbsolute(100, 100);
			 * code128Image.setAbsolutePosition(20, 420);
			 * code128Image.scalePercent(100); document.add(code128Image);
			 */
			BarcodeQRCode barcodeQRCode = new BarcodeQRCode(certificate_number, 1000, 1000, null);
			Image codeQrImage = barcodeQRCode.getImage();
			codeQrImage.scaleAbsolute(100, 100);
			codeQrImage.setAbsolutePosition(20, 480);
			document.add(codeQrImage);

			// document.add(new Phrase(Chunk.NEWLINE));
			// document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			
			SimpleDateFormat datetimeFormatter2 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date n_date_of_registration = datetimeFormatter2.parse(m_date_of_registration);

			Paragraph p4 = new Paragraph(
					"This instument has been duly registered according to law on: " + (n_date_of_registration.toGMTString()).replace("00:00:00 GMT", ""),
					new Font(FontFamily.TIMES_ROMAN, 10));
			p4.setAlignment(Element.ALIGN_LEFT);
			document.add(p4);

			Paragraph p6_7 = new Paragraph("Proprietor Name: " + proprietor_name, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_7.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_7);

			Paragraph p6_1 = new Paragraph("Registered No: " + m_registered_no, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_1.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_1);

			SimpleDateFormat datetimeFormatter1 = new SimpleDateFormat(
                "yyyy-MM-dd");
			Date date_of_instrument = datetimeFormatter1.parse(m_date_of_instrument);
			//date_of_instrument = date_of_instrument.toGMTString();

			Paragraph p6_2 = new Paragraph("Date of Instrument: " + (date_of_instrument.toGMTString()).replace("00:00:00 GMT", ""), new Font(FontFamily.TIMES_ROMAN, 10));
			p6_2.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_2);

			
			Date now = new Date();
			Paragraph p6_3 = new Paragraph("Date of Issue: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
			p6_3.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_3);

			Paragraph p6_4 = new Paragraph("Memorials: " + m_memorials, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_4.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_4);

			Paragraph p6_5 = new Paragraph("Job Number: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			p6_5.setAlignment(Element.ALIGN_LEFT);
			document.add(p6_5);

			// Paragraph p8_1 = new Paragraph("Fee Paid GHS: " + "0.00", new Font(FontFamily.TIMES_ROMAN, 10));
			// p8_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(p8_1);

			// Paragraph p9_1 = new Paragraph("Receipt No: " + "" + "Date:" + now.toGMTString(),
			// 		new Font(FontFamily.TIMES_ROMAN, 10));
			// p9_1.setAlignment(Element.ALIGN_LEFT);
			// document.add(p9_1);

			// Paragraph p9_2 = new Paragraph("Register: Vol: " + volume_number + " Folio:" + folio_number,
			// 		new Font(FontFamily.TIMES_ROMAN, 10));
			// p9_2.setAlignment(Element.ALIGN_LEFT);
			// document.add(p9_2);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			/*
			 * Paragraph p6 = new Paragraph("Client Name: " + ar_name, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p6.setAlignment(Element.ALIGN_LEFT); document.add(p6);
			 */
			/*
			 * Paragraph p8 = new Paragraph("Service Type: " +
			 * business_process_sub_name, new Font(FontFamily.TIMES_ROMAN, 10));
			 * p8.setAlignment(Element.ALIGN_LEFT); document.add(p8);
			 */

			/*
			 * Paragraph p9 = new Paragraph("Case Number: " + case_number, new
			 * Font(FontFamily.TIMES_ROMAN, 10));
			 * p9.setAlignment(Element.ALIGN_LEFT); document.add(p9);
			 */
			// Paragraph p10 = new Paragraph("Job Number: " + job_number, new Font(FontFamily.TIMES_ROMAN, 10));
			// p10.setAlignment(Element.ALIGN_LEFT);
			// document.add(p10);

			document.add(new Phrase(Chunk.NEWLINE));
			document.add(new Phrase(Chunk.NEWLINE));

			// Paragraph p14 = new Paragraph("FORM LR. 34 ", new Font(FontFamily.TIMES_ROMAN, 10));
			// p14.setAlignment(Element.ALIGN_LEFT);
			// document.add(p14);

			/*
			 * BarcodeQRCode barcodeQRCode_sign = new BarcodeQRCode(job_number,
			 * 1000, 1000, null); Image codeQrImage_sign =
			 * barcodeQRCode_sign.getImage();
			 * codeQrImage_sign.scaleAbsolute(100, 100); //
			 * codeQrImage_sign.setAbsolutePosition(310, 380);
			 * document.add(codeQrImage_sign);
			 */

			 if ( certificete_approval_status != null && certificete_approval_status != "null" && certificete_approval_status.equals("1") ) {
				//if ( !certificete_approval_status.equals("0") && !certificete_approval_status.equals("null") && certificete_approval_status.equals("1") ) {

				File file1 = new File(software_file_location + certificate_approved_by + ".jpg");
				if (file1.exists() && !file1.isDirectory()) {
					Image image_sig = Image
							.getInstance(software_file_location + certificate_approved_by + ".jpg");
					// imgPDF2.ScaleToFit(100.0F, 70.0F)
					image_sig.scaleToFit(100.0F, 100.0F);
					image_sig.setAlignment(Element.ALIGN_CENTER);

					document.add(image_sig);

				} else {
					Paragraph y_tna = new Paragraph("Approved",
							new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
					y_tna.setAlignment(Element.ALIGN_CENTER);
					document.add(y_tna);
				}

			} else {

				Paragraph y_tna = new Paragraph("Certificate Not Approved",
						new Font(FontFamily.TIMES_ROMAN, 16, Font.BOLD));
				y_tna.setAlignment(Element.ALIGN_CENTER);
				document.add(y_tna);
			}

			 Paragraph p14 = new Paragraph(".....................................................", new Font(FontFamily.TIMES_ROMAN, 10));
			 p14.setAlignment(Element.ALIGN_CENTER);
			document.add(p14);

			Paragraph p15 = new Paragraph("FOR: CHIEF REGSTRAR OF LANDS", new Font(FontFamily.TIMES_ROMAN, 10));
			p15.setAlignment(Element.ALIGN_CENTER);
			document.add(p15);

			document.close();
			//file.close();
		return out.toByteArray();
		
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
