package ws.casemgt;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

public class HeaderFooterPageEvent extends PdfPageEventHelper {

    public static String extraValue = "";

    private PdfTemplate total;
    private Font font = new Font(Font.FontFamily.HELVETICA, 8);

    @Override
    public void onOpenDocument(PdfWriter writer, Document document) {
        total = writer.getDirectContent().createTemplate(30, 16);
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {

        PdfContentByte cb = writer.getDirectContent();

        // Left footer
        ColumnText.showTextAligned(
                cb,
                Element.ALIGN_LEFT,
                new Phrase(extraValue, font),
                36,
                30,
                0
        );

        // Right footer: Page X of
        String text = "Page " + writer.getPageNumber() + " of ";
        float textBase = 550;

        ColumnText.showTextAligned(
                cb,
                Element.ALIGN_RIGHT,
                new Phrase(text, font),
                textBase,
                30,
                0
        );

        // Add placeholder for total pages
        cb.addTemplate(total, textBase, 30);
    }

    @Override
    public void onCloseDocument(PdfWriter writer, Document document) {

        // Fill in total page count
        ColumnText.showTextAligned(
                total,
                Element.ALIGN_LEFT,
                new Phrase(String.valueOf(writer.getPageNumber() - 1), font),
                2,
                2,
                0
        );
    }
}