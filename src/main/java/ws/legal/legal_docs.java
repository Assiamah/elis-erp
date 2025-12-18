package ws.legal;

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

import com.mit.elis.class_common.AmountInWords;
import com.mit.elis.class_common.Ws_url_config;
import com.mit.elis.class_common.cls_casemgt_reports;
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

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class legal_docs {

    public byte[] web_compname;
    public byte[] web_comp_address;
    public byte[] web_city;
    public byte[] web_fax_number;
    public byte[] web_telephone;
    public byte[] web_email;
    public byte[] web_branch_of_csau;
    public byte[] web_rlo;
    public byte[] web_regional_accountant;
    public byte[] web_head_of_csau;
    public byte[] web_chairman_regional_land_commission;
    public byte[] web_office_region;

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

    public byte[] create_batch_list(String software_file_location, String basic_batch_details,
            String ws_login_user, String output_file, String timeStamp,
            String web_comp_address, String web_city, String web_telephone, String web_fax_number, String web_email)
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

            Paragraph p_2 = new Paragraph("LEGAL UNIT - BATCHLIST", new Font(FontFamily.TIMES_ROMAN, 10));
            p_2.setAlignment(Element.ALIGN_CENTER);
            document.add(p_2);

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

            PdfPCell cell = new PdfPCell(
                    new Paragraph("RECEIVING WRITS FROM SECRETARIAT", new Font(FontFamily.TIMES_ROMAN, 10)));

            cell.setColspan(4);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(10.0f);
            cell.setBackgroundColor(new BaseColor(140, 221, 8));

            table.addCell(cell);

            table.addCell(new Paragraph("NO.", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("SUIT NUMBER", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("NATURE OF CASE", new Font(FontFamily.TIMES_ROMAN, 9)));
            table.addCell(new Paragraph("COURT PROCESS", new Font(FontFamily.TIMES_ROMAN, 9)));

            JSONObject jsonobj = new JSONObject(basic_batch_details);
            String list = (String) jsonobj.getString("list");
            Integer num = 0;

            JSONArray jArr = new JSONArray(list);
            for (int i = 0; i < jArr.length(); i++) {

                String S_list = jArr.getString(i);
                JSONObject obj = new JSONObject(S_list);

                String suit_number = (String) obj.getString("suit_number");
                String nature = (String) obj.getString("nature");
                String court_process = (String) obj.getString("court_process");
                num = (+num + 1);

                table.addCell(new Paragraph(Integer.toString(num), new Font(FontFamily.TIMES_ROMAN, 9)));
                table.addCell(new Paragraph(suit_number, new Font(FontFamily.TIMES_ROMAN, 9)));
                table.addCell(new Paragraph(nature, new Font(FontFamily.TIMES_ROMAN, 9)));
                table.addCell(new Paragraph(court_process, new Font(FontFamily.TIMES_ROMAN, 9)));

            }

            table.setSpacingBefore(30.0f); // Space Before table starts, like
                                           // margin-top in CSS
            table.setSpacingAfter(30.0f); // Space After table starts, like
                                          // margin-Bottom in CSS

            document.add(table);

            Paragraph p15 = new Paragraph("Received By: " + ws_login_user, new Font(FontFamily.TIMES_ROMAN, 10));
            p15.setAlignment(Element.ALIGN_LEFT);
            document.add(p15);

            Paragraph p16 = new Paragraph("Signature:.......................................",
                    new Font(FontFamily.TIMES_ROMAN, 10));
            p16.setAlignment(Element.ALIGN_LEFT);
            document.add(p16);

            document.add(new Phrase(Chunk.NEWLINE));
            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p17 = new Paragraph("Fowarded By:.................................... ",
                    new Font(FontFamily.TIMES_ROMAN, 10));
            p17.setAlignment(Element.ALIGN_LEFT);
            document.add(p17);

            Paragraph p18 = new Paragraph("Signature:.......................................",
                    new Font(FontFamily.TIMES_ROMAN, 10));
            p18.setAlignment(Element.ALIGN_LEFT);
            document.add(p18);

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

    public String load_scanned_documents(String suit_number, String legal_document_location)
            throws IOException, SQLException, JSONException {
        String output = null;

        try {
            JSONArray arr_r = new JSONArray();
            String folderpath = legal_document_location + suit_number;

            File subdir = new File(folderpath.toString());
            String[] children = subdir.list();

            if (children == null) {
                System.out.println("Either dir does not exist or is not a directory");
            } else {
                for (int j = 0; j < children.length; j++) {
                    String filename_doc = children[j];
                    String path = folderpath.toString() + "/" + filename_doc;

                    String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

                    JSONObject obj_r = new JSONObject();

                    obj_r.put("document_name", filename_doc);
                    obj_r.put("document_type", path);
                    obj_r.put("document_extention", extension);
                    obj_r.put("document_file", path);

                    arr_r.put(obj_r);
                }

                System.out.println(arr_r.toString());
                output = arr_r.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return output;
    }

    public String load_requested_documents(String suit_number, String load_requested_documents)
            throws IOException, SQLException, JSONException {
        String output = null;

        try {
            JSONArray arr_r = new JSONArray();
            String folderpath = load_requested_documents + suit_number;

            File subdir = new File(folderpath.toString());
            String[] children = subdir.list();

            if (children == null) {
                System.out.println("Either dir does not exist or is not a directory");
            } else {
                for (int j = 0; j < children.length; j++) {
                    String filename_doc = children[j];
                    String path = folderpath.toString() + "/" + filename_doc;

                    String extension = filename_doc.substring(filename_doc.lastIndexOf("."));

                    JSONObject obj_r = new JSONObject();

                    obj_r.put("document_name", filename_doc);
                    obj_r.put("document_type", path);
                    obj_r.put("document_extention", extension);
                    obj_r.put("document_file", path);

                    arr_r.put(obj_r);
                }

                System.out.println(arr_r.toString());
                output = arr_r.toString();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return output;
    }

    public byte[] create_print_request(String software_file_location, String suit_number, String deadline,
            String subject, String description, String requested_by, String output_file, String timeStamp,
            String web_comp_address, String web_city, String web_telephone, String web_fax_number, String web_email)
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

            // Paragraph p9 = new Paragraph("Suit Number: ", new
            // Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            // p_2.setAlignment(Element.ALIGN_LEFT);
            // document.add(p9);
            // Paragraph p10 = new Paragraph(suit_number, new Font(FontFamily.TIMES_ROMAN,
            // 11));
            // p_2.setAlignment(Element.ALIGN_LEFT);
            // document.add(p10);

            float[] columnWidths = { 3, 10 };
            PdfPTable table = new PdfPTable(columnWidths);

            table.setTotalWidth(1000);
            table.setWidthPercentage(100);

            PdfPCell cellOne = new PdfPCell(
                    (new Paragraph("Suit Number: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD))));
            PdfPCell cellTwo = new PdfPCell(new Paragraph(suit_number, new Font(FontFamily.TIMES_ROMAN, 11)));
            // table.addCell(new Paragraph("Ticket Number: ", new
            // Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD)));
            // table.addCell(new Paragraph(ticket_no, new Font(FontFamily.TIMES_ROMAN,
            // 11)));

            cellOne.setBorder(Rectangle.NO_BORDER);
            cellTwo.setBorder(Rectangle.NO_BORDER);

            table.addCell(cellOne);
            table.addCell(cellTwo);

            document.add(table);

            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_5 = new Paragraph("Subject: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            p_5.setAlignment(Element.ALIGN_LEFT);
            document.add(p_5);
            Paragraph p_12 = new Paragraph(subject, new Font(FontFamily.TIMES_ROMAN, 11));
            p_12.setAlignment(Element.ALIGN_LEFT);
            document.add(p_12);

            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_6 = new Paragraph("Description: ", new Font(FontFamily.TIMES_ROMAN, 11, Font.BOLD));
            p_6.setAlignment(Element.ALIGN_LEFT);
            document.add(p_6);
            Paragraph p_11 = new Paragraph(description, new Font(FontFamily.TIMES_ROMAN, 11));
            p_11.setAlignment(Element.ALIGN_LEFT);
            document.add(p_11);

            document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_7 = new Paragraph("Requested By: " + requested_by,
                    new Font(FontFamily.TIMES_ROMAN, 11));
            p_7.setAlignment(Element.ALIGN_LEFT);
            document.add(p_7);

            // document.add(new Phrase(Chunk.NEWLINE));

            Paragraph p_8 = new Paragraph("Deadline: " + deadline, new Font(FontFamily.TIMES_ROMAN, 11));
            p_8.setAlignment(Element.ALIGN_LEFT);
            document.add(p_8);

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
