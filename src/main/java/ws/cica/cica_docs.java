package ws.cica;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.codehaus.jettison.json.JSONException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
// import jakarta.swing.border.Border;

import java.io.File;
import java.util.ArrayList;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; 
import ws.casemgt.cls_casemgt;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;

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
import com.lowagie.text.Cell;
import com.mit.elis.class_common.AmountInWords;
import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_casemgt_reports;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class cica_docs {

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

    // public String IMG = cls_url_config.getSoftfile_location() + "NewLogo.jpg";
    // static final

    Font font = new Font(FontFamily.TIMES_ROMAN);
    Font font14pt = new Font(FontFamily.TIMES_ROMAN, 14);
    Font font12pt = new Font(FontFamily.TIMES_ROMAN, 12);
    Font font10pt = new Font(FontFamily.TIMES_ROMAN, 10);

    /**
     * @param args
     */

    public byte[] create_batch_list(String software_file_location, String ticke_no, String client_name, String purpose,
            String request_by, String output_file, String timeStamp,
            String web_comp_address,  String web_city,  String web_telephone,  String web_fax_number,  String web_email)
            throws IOException, SQLException, JSONException {

        // Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
        // Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

        // String bd_suit_number = "";
        // String bd_nature = "";
        // String bd_court_process = "";

        // // ByteArrayOutputStream out = new ByteArrayOutputStream();
        // // // file.;

         ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {

            // web_comp_address = "P.O. Box CT 5008";
            // web_city = "Cantonments-Accra, Ghana";
            // web_telephone = "0302 429760";
            // web_fax_number = "0302 761840";
            // web_email = "info@lc.gov.gh";

         
            Document document = new Document(PageSize.A5, 50, 50, 50, 50);

            PdfWriter writer = PdfWriter.getInstance(document, out);

            document.open();// PDF document opened........
            // PdfContentByte cb = writer.getDirectContent();

            // Inserting Logo
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
            // document.add(new Phrase(Chunk.NEWLINE));
            // document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
            p_1.setAlignment(Element.ALIGN_CENTER);
            document.add(p_1);

            Paragraph p_2 = new Paragraph("COMPLAINTS & ADVISORY CENTER (CAC)", new Font(FontFamily.TIMES_ROMAN, 10));
            p_2.setAlignment(Element.ALIGN_CENTER);
            document.add(p_2);

            Paragraph p_5 = new Paragraph("ACKNOWLEDGEMENT SLIP", new Font(FontFamily.TIMES_ROMAN, 10));
            p_5.setAlignment(Element.ALIGN_CENTER);
            document.add(p_5);

            document.add(new Phrase(Chunk.NEWLINE));
            document.add(new Phrase(Chunk.NEWLINE));

            Date now = new Date();
            Paragraph p4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
            p4.setAlignment(Element.ALIGN_RIGHT);
            document.add(p4);

            // Inserting Table in PDF
            float[] columnWidths = { 3, 10, 10, 10 };
            PdfPTable table = new PdfPTable(columnWidths);

            table.setTotalWidth(1000);
            table.setWidthPercentage(100);

            PdfPCell cell = new PdfPCell(new Paragraph("CAC COMPLAINT TICKET", new Font(FontFamily.TIMES_ROMAN, 10)));
            
            cell.setColspan(4);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(10.0f);
            cell.setBackgroundColor(new BaseColor(140, 221, 8));

            table.addCell(cell);

            // table.addHeaderCell(new Cell(1, 4).add(new Paragraph("CAC COMPLAINT TICKETT")).setBackgroundColor(DeviceRgb.BLUE).setBold())
            // .setTextAlignment(TextAlignment.CENTER);
            
            table.addCell(new Paragraph("NO.", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("TICKET NUMBER", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("NAME", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("PURPOSE", new Font(FontFamily.TIMES_ROMAN, 9)));

            Integer num = 0;
            num = (+num + 1);

            table.addCell(new Paragraph(Integer.toString(num), new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph(ticke_no, new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph(client_name, new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph(purpose, new Font(FontFamily.TIMES_ROMAN, 9)));
            table.setSpacingBefore(30.0f); // Space Before table starts, like
                                           // margin-top in CSS
            table.setSpacingAfter(30.0f); // Space After table starts, like
                                          // margin-Bottom in CSS

            document.add(table);

            Paragraph p15 = new Paragraph("CAC Officer: " + request_by, new Font(FontFamily.TIMES_ROMAN, 10));
            p15.setAlignment(Element.ALIGN_LEFT);
            document.add(p15);

            Paragraph p16 = new Paragraph("For: Regional Lands Officer",
                    new Font(FontFamily.TIMES_ROMAN, 10));
            p16.setAlignment(Element.ALIGN_LEFT);
            document.add(p16);

            // document.close();

            // //file.close();

            // System.out.println("Pdf created successfully..");

            // results = timeStamp;
            // System.out.println(results);
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
 
    public byte[]  create_print_request(String software_file_location, String ticket_no, String subject,
            String description, String requested_by, String duc_request, String request_to, String reference_id, String output_file, String timeStamp,
            String web_comp_address,  String web_city,  String web_telephone,  String web_fax_number,  String web_email)
            throws IOException, SQLException, JSONException {
        // Font bold = new Font(Font.FontFamily.HELVETICA, 8f, Font.BOLD);
        // Font normal = new Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL);

        // String bd_suit_number = "";
        // String bd_nature = "";
        // String bd_court_process = "";

        // // ByteArrayOutputStream out = new ByteArrayOutputStream();
        // // // file.;

          ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {

            // web_comp_address = "P.O. Box CT 5008";
            // web_city = "Cantonments-Accra, Ghana";
            // web_telephone = "0302 429760";
            // web_fax_number = "0302 761840";
            // web_email = "info@lc.gov.gh";

          
            Document document = new Document(PageSize.A5, 50, 50, 50, 50);

            PdfWriter writer = PdfWriter.getInstance(document, out);

            document.open();// PDF document opened........
            // PdfContentByte cb = writer.getDirectContent();

            // Inserting Logo
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
            // document.add(new Phrase(Chunk.NEWLINE));
            // document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_1 = new Paragraph("LANDS COMMISSION", new Font(FontFamily.TIMES_ROMAN, 14));
            p_1.setAlignment(Element.ALIGN_CENTER);
            document.add(p_1);

            Paragraph p_8 = new Paragraph("COMPLAINTS & ADVISORY CENTER (CAC)", new Font(FontFamily.TIMES_ROMAN, 10));
            p_8.setAlignment(Element.ALIGN_CENTER);
            document.add(p_8);

            Paragraph p_2 = new Paragraph("REQUEST FOR INFORMATION", new Font(FontFamily.TIMES_ROMAN, 10));
            p_2.setAlignment(Element.ALIGN_CENTER);
            document.add(p_2);

            document.add(new Phrase(Chunk.NEWLINE));
            document.add(new Phrase(Chunk.NEWLINE));

            Date now = new Date();
            Paragraph p_4 = new Paragraph("Date: " + now.toGMTString(), new Font(FontFamily.TIMES_ROMAN, 10));
            p_4.setAlignment(Element.ALIGN_RIGHT);
            document.add(p_4);

            document.add(new Phrase(Chunk.NEWLINE));

            // Paragraph p_9 = new Paragraph("Ticket Number: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            // p_9.setAlignment(Element.ALIGN_LEFT);
            // document.add(p_9);
            // Paragraph p_10 = new Paragraph(ticket_no, new Font(FontFamily.TIMES_ROMAN, 11));
            // p_10.setAlignment(Element.ALIGN_LEFT);
            // document.add(p_10);

            float[] columnWidths = {4, 10 };
            PdfPTable table = new PdfPTable(columnWidths);

            table.setTotalWidth(1000);
            table.setWidthPercentage(100);
            
            PdfPCell cellOne = new PdfPCell((new Paragraph("Ticket No.: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD))));
			PdfPCell cellTwo = new PdfPCell(new Paragraph(ticket_no, new Font(FontFamily.TIMES_ROMAN, 11)));

            PdfPCell cellthree = new PdfPCell((new Paragraph("To: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD))));
			PdfPCell cellfour = new PdfPCell(new Paragraph(request_to, new Font(FontFamily.TIMES_ROMAN, 11)));

            PdfPCell cellfive = new PdfPCell((new Paragraph("Subject: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD))));
			PdfPCell cellsix = new PdfPCell(new Paragraph(subject, new Font(FontFamily.TIMES_ROMAN, 11)));

            PdfPCell cellseven = new PdfPCell((new Paragraph("Reference No.: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD))));
			PdfPCell celleight = new PdfPCell(new Paragraph(reference_id, new Font(FontFamily.TIMES_ROMAN, 11)));

            cellOne.setBorder(Rectangle.NO_BORDER);
			cellTwo.setBorder(Rectangle.NO_BORDER);
            cellthree.setBorder(Rectangle.NO_BORDER);
			cellfour.setBorder(Rectangle.NO_BORDER);
            cellfive.setBorder(Rectangle.NO_BORDER);
			cellsix.setBorder(Rectangle.NO_BORDER);
            cellseven.setBorder(Rectangle.NO_BORDER);
			celleight.setBorder(Rectangle.NO_BORDER);

            table.addCell(cellOne);
			table.addCell(cellTwo);
            table.addCell(cellthree);
			table.addCell(cellfour);
            table.addCell(cellfive);
			table.addCell(cellsix);
            table.addCell(cellseven);
			table.addCell(celleight);

            document.add(table);

            document.add(new Phrase(Chunk.NEWLINE));

            // Paragraph p_5 = new Paragraph("Subject: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            // p_5.setAlignment(Element.ALIGN_LEFT);
            // document.add(p_5);
            // Paragraph p_12 = new Paragraph(subject, new Font(FontFamily.TIMES_ROMAN, 11));
            // p_12.setAlignment(Element.ALIGN_LEFT);
            // document.add(p_12);

            // document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_13 = new Paragraph("Description: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            p_13.setAlignment(Element.ALIGN_LEFT);
            document.add(p_13);
            Paragraph p_14 = new Paragraph(description, new Font(FontFamily.TIMES_ROMAN, 11));
            p_14.setAlignment(Element.ALIGN_LEFT);
            document.add(p_14);

            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_6 = new Paragraph("Request: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            p_6.setAlignment(Element.ALIGN_LEFT);
            document.add(p_6);
            Paragraph p_11 = new Paragraph(duc_request, new Font(FontFamily.TIMES_ROMAN, 11));
            p_11.setAlignment(Element.ALIGN_LEFT);
            document.add(p_11);

            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_7 = new Paragraph("Requested By: DCU", new Font(FontFamily.TIMES_ROMAN, 11));
            p_7.setAlignment(Element.ALIGN_LEFT);
            document.add(p_7);
            Paragraph p_3 = new Paragraph(requested_by, new Font(FontFamily.TIMES_ROMAN, 11));
            p_3.setAlignment(Element.ALIGN_LEFT);
            document.add(p_3);

            // document.add(new Phrase(Chunk.NEWLINE));

            // Paragraph p8 = new Paragraph("Deadline: " + deadline, new
            // Font(FontFamily.TIMES_ROMAN, 11, Font.ITALIC));
            // p_2.setAlignment(Element.ALIGN_LEFT);
            // document.add(p8);

            // document.close();

            // //file.close();

            // System.out.println("Pdf created successfully..");

            // results = timeStamp;
            // System.out.println(results);
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
}
