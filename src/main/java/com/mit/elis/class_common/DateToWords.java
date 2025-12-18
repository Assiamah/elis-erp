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

public class DateToWords {

	/*
	 * private static final String[] specialNamesMonthDay = {
	 * "",
	 * " First",
	 * " Second",
	 * " Third",
	 * " Fourth",
	 * " Fifth",
	 * " Sixth",
	 * " Seventh",
	 * " Eighth",
	 * " Nineth",
	 * " Tenth",
	 * " Eleventh",
	 * " Twelveth",
	 * " Thirteenth",
	 * " Fourteenth",
	 * " Fifteenth",
	 * " Xixteenth",
	 * " Seventeenth",
	 * " Sighteenth",
	 * " nineteenth",
	 * " twenth",
	 * " twenty-first",
	 * " twenty second",
	 * " twenty third",
	 * " twenty fourth",
	 * " twenty fifth",
	 * " twenty sixth",
	 * " twenty seventh",
	 * " twenty eighth",
	 * " twenty nineth",
	 * " thirty",
	 * " thirty first"
	 * 
	 * };
	 * private static final String[] specialNames = {
	 * "",
	 * " thousand"
	 * 
	 * };
	 * 
	 * private static final String[] tensNames = {
	 * "",
	 * " ten",
	 * " twenty",
	 * " thirty",
	 * " forty",
	 * " fifty",
	 * " sixty",
	 * " seventy",
	 * " eighty",
	 * " ninety"
	 * };
	 * 
	 * private static final String[] numNames = {
	 * "",
	 * " one",
	 * " two",
	 * " three",
	 * " four",
	 * " five",
	 * " six",
	 * " seven",
	 * " eight",
	 * " nine",
	 * " ten",
	 * " eleven",
	 * " twelve",
	 * " thirteen",
	 * " fourteen",
	 * " fifteen",
	 * " sixteen",
	 * " seventeen",
	 * " eighteen",
	 * " nineteen"
	 * };
	 * 
	 * public DateToWords() {
	 * System.out.println("Pleaser date in dd-mm-yyyy format");
	 * Scanner in = new Scanner(System.in);
	 * String date = in.next();
	 * 
	 * if (validateDate(date)) {
	 * 
	 * SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy");
	 * ParsePosition parsePosition = new ParsePosition(0);
	 * Calendar cal = Calendar.getInstance();
	 * cal.setTime(dateFormatter.parse(date, new ParsePosition(0)));
	 * DateFormat format2 = new SimpleDateFormat("MMMMM ");
	 * 
	 * int day = cal.get(Calendar.DATE);
	 * String strDateToWords = getMonthDay(day);
	 * strDateToWords += " of " + format2.format(cal.getTime());
	 * 
	 * int year = cal.get(Calendar.YEAR);
	 * strDateToWords += " " + convert(year);
	 * 
	 * System.out.println(strDateToWords.toLowerCase());
	 * } else {
	 * System.out.println("Wrongt! Please enter date in dd-mm-yyyy format");
	 * }
	 * }
	 * 
	 * public String getMonthDay(int day) {
	 * return specialNamesMonthDay[day];
	 * }
	 * 
	 * private String convertLessThanOneThousand(int number) {
	 * String current;
	 * 
	 * if (number % 100 < 20) {
	 * current = numNames[number % 100];
	 * number /= 100;
	 * } else {
	 * current = numNames[number % 10];
	 * number /= 10;
	 * 
	 * current = tensNames[number % 10] + current;
	 * number /= 10;
	 * }
	 * if (number == 0) {
	 * return current;
	 * }
	 * return numNames[number] + " hundred" + current;
	 * }
	 * 
	 * public String convert(int number) {
	 * 
	 * if (number == 0) {
	 * return "zero";
	 * }
	 * 
	 * String prefix = "";
	 * 
	 * String current = "";
	 * int place = 0;
	 * 
	 * if (number >= 1 && number < 2000) {
	 * do {
	 * int n = number % 100;
	 * if (n != 0) {
	 * String s = convertLessThanOneThousand(n);
	 * current = s + current;
	 * }
	 * place++;
	 * number /= 100;
	 * } while (number > 0);
	 * } else {
	 * do {
	 * int n = number % 1000;
	 * if (n != 0) {
	 * String s = convertLessThanOneThousand(n);
	 * current = s + specialNames[place] + current;
	 * }
	 * place++;
	 * number /= 1000;
	 * } while (number > 0);
	 * }
	 * 
	 * return (prefix + current).trim();
	 * }
	 * 
	 * public boolean validateDate(String date) {
	 * SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	 * try {
	 * sdf.setLenient(false);
	 * sdf.parse(date);
	 * return true;
	 * } catch (ParseException ex) {
	 * return false;
	 * }
	 * }
	 * 
	 * public static void main(String[] args) {
	 * new DateToWords();
	 * 
	 * }
	 */
}
