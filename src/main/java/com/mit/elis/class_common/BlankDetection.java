package com.mit.elis.class_common;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.PixelGrabber;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;

/**
 * This utility loads a given TIF and try to detect if it's
 * blank or not.
 * 
 * We create in-memory image and then calculate the standard
 * deviation of the color information. If a certain value is not
 * reached then we assume that the image is mainly uniform and
 * probably blank. The threshold value is an estimate. Depending
 * the source of the TIF this value can be higher. For example,
 * TIF from a FAX machine or a scanner can be dirty, with hair/dust presence,
 * but with no content.
 * 
 * jai_core.jar and jai_codec.jar are required.
 * http://java.sun.com/products/java-media/jai/index.jsp
 * 
 * @author http://www.rgagnon.com/howto.html
 */

public class BlankDetection {

    public static final int FAILURE = 2;
    public static final int BLANK = 0;
    public static final int NOTBLANK = 1;
    // value where we can consider that this is a blank image
    // can be much higher depending of the TIF source
    // (ex. scanner or fax)
    public static final int BLANK_THRESHOLD = 1000;

    /**
     * Converts an Image to a BufferedImage
     * 
     * @param im une Image
     * @return BufferedImage
     */
    public static BufferedImage imageToBufferedImage(Image im) {
        BufferedImage bi = new BufferedImage(im.getWidth(null), im.getHeight(null), BufferedImage.TYPE_INT_RGB);
        Graphics bg = bi.getGraphics();
        bg.drawImage(im, 0, 0, null);
        bg.dispose();
        return bi;
    }

    /**
     * Check if an Image is blank or not
     * Computes the standard deviation based on the color information
     * 
     * @param bi bufferedimage
     * @return true it's blank
     */
    public static boolean isBlank(BufferedImage bi) throws Exception {
        long count = 0;
        long total = 0;
        double totalVariance = 0;
        double stdDev = 0;
        int height = bi.getHeight();
        int width = bi.getWidth();

        int[] pixels = new int[width * height];
        PixelGrabber pg = new PixelGrabber(bi, 0, 0, width, height, pixels, 0, width);
        pg.grabPixels();
        for (int j = 0; j < height; j++) {
            for (int i = 0; i < width; i++) {
                count++;
                int pixel = pixels[j * width + i];
                int red = (pixel >> 16) & 0xff;
                int green = (pixel >> 8) & 0xff;
                int blue = (pixel) & 0xff;
                int pixelValue = new Color(red, green, blue, 0).getRGB();
                total += pixelValue;
                double avg = total / count;
                totalVariance += Math.pow(pixelValue - avg, 2);
                stdDev = Math.sqrt(totalVariance / count);
            }
        }
        return (stdDev < BLANK_THRESHOLD);
    }

    /**
     * Accept on the command line the path to a TIF file
     * 
     * Returns an errorlevel based on the analysis
     * 0 - blank
     * 1 - not blank
     * 2 - IO error
     * 
     * @param args path vers complet vers un PROPS
     */
    /*
     * public static void main(String[] args) {
     * try {
     * if (args.length==0) {
     * System.out.println("Missing parameter.");
     * System.exit(FAILURE);
     * }
     * String path = args[0];
     * FileInputStream in = new FileInputStream(path);
     * FileChannel channel = in.getChannel();
     * ByteBuffer buffer = ByteBuffer.allocate((int)channel.size());
     * channel.read(buffer);
     * Image image = load(buffer.array());
     * BufferedImage bufferedImage = imageToBufferedImage(image);
     * boolean isBlank = BlankDetection.isBlank(bufferedImage);
     * 
     * System.exit( isBlank ? BLANK : NOTBLANK );
     * }
     * catch (Exception e) {
     * e.printStackTrace();
     * System.exit(FAILURE);
     * }
     * }
     */
}
