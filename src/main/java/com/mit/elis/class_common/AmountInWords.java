package com.mit.elis.class_common;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

public class AmountInWords {

	public static String convertToCurrency(String num) {

		// double doubleNumber = 24.04;
		// String doubleAsString = String.valueOf(doubleNumber);
		// int indexOfDecimal = doubleAsString.indexOf(".");
		// System.out.println("Double Number: " + doubleNumber);
		/// System.out.println("Integer Part: " + doubleAsString.substring(0,
		// indexOfDecimal));
		// System.out.println("Decimal Part: " +
		// doubleAsString.substring(indexOfDecimal));

		// BigDecimal bigDecimal = new BigDecimal(String.valueOf(doubleNumber));

		BigDecimal bd = new BigDecimal(num);

		// System.out.println("BigDecimal" + bd);

		// int indexOfDecimal = num.indexOf(".");

		// double doubleNumber1 = Double.parseDouble(num);

		// System.out.println("InT VAlue" + doubleNumber1);

		// System.out.println("InT VAlue" + Math.floor(doubleNumber1));
		// System.out.println("InT VAlue" + (doubleNumber1 -
		// Math.floor(doubleNumber1)));

		// System.out.println("Original" + num);

		// integral = Math.floor(x)
		// s fractional = x - Math.floor(x)

		long number = bd.longValue();
		long no = bd.longValue();
		// System.out.println("number" + bd);

		// System.out.println("no" + bd);

		int decimal = (int) (bd.remainder(BigDecimal.ONE).doubleValue() * 100);

		int digits_length = String.valueOf(no).length();

		String doubleAsString = num;
		int indexOfDecimal = doubleAsString.indexOf(".");

		int digits_value = Integer.valueOf(doubleAsString.substring(0, indexOfDecimal));

		// int digits_value = Integer.valueOf(no);

		// System.out.println("decimal" + decimal);

		/// System.out.println("digits_length" + digits_length);

		int i = 0;
		ArrayList<String> str = new ArrayList<>();
		HashMap<Integer, String> words = new HashMap<>();
		words.put(0, "");
		words.put(1, "One");
		words.put(2, "Two");
		words.put(3, "Three");
		words.put(4, "Four");
		words.put(5, "Five");
		words.put(6, "Six");
		words.put(7, "Seven");
		words.put(8, "Eight");
		words.put(9, "Nine");
		words.put(10, "Ten");
		words.put(11, "Eleven");
		words.put(12, "Twelve");
		words.put(13, "Thirteen");
		words.put(14, "Fourteen");
		words.put(15, "Fifteen");
		words.put(16, "Sixteen");
		words.put(17, "Seventeen");
		words.put(18, "Eighteen");
		words.put(19, "Nineteen");
		words.put(20, "Twenty");
		words.put(30, "Thirty");
		words.put(40, "Forty");
		words.put(50, "Fifty");
		words.put(60, "Sixty");
		words.put(70, "Seventy");
		words.put(80, "Eighty");
		words.put(90, "Ninety");
		String digits[] = { "", "Hundred", "Thousand", "Million", "Billion" };

		/*
		 * while (i < digits_length) { int divider = (i == 2) ? 10 : 100; number
		 * = no % divider; System.out.println("number" + number); no = no /
		 * divider; i += divider == 10 ? 1 : 2; if (number > 0) { int counter =
		 * str.size(); String plural = (counter > 0 && number > 9) ? "s" : "";
		 * // String plural = (counter > 0 && number > 9) ? "s" : "";
		 * System.out.println("counter" + counter); String tmp = (number < 21) ?
		 * words.get(Integer.valueOf((int) number)) + " " + digits[counter] +
		 * plural : words.get(Integer.valueOf((int) Math.floor(number / 10) *
		 * 10)) + " " + words.get(Integer.valueOf((int) (number % 10))) + " " +
		 * digits[counter] + plural;
		 * 
		 * str.add(tmp); System.out.println("tmp" + tmp); } else { str.add("");
		 * } }
		 */

		// Collections.reverse(str);
		// String Rupees = String.join(" ", str).trim();

		String Rupees = convertNumber(digits_value);
		// System.out.println("digits_value" + digits_value);

		String paise = (decimal) > 0 ? " And " + words.get(Integer.valueOf((int) (decimal - decimal % 10))) + " "
				+ words.get(Integer.valueOf((int) (decimal % 10))) : "";

		if (decimal > 0) {
			return Rupees + " Ghana Cedis " + paise + " Ghana Pesewas " + " Only";
		} else {

			return Rupees + " Ghana Cedis " + " Only";
		}

	}

	private static final String[] units = { "", " One", " Two", " Three", " Four", " Five", " Six", " Seven", " Eight",
			" Nine" };
	private static final String[] twoDigits = { " Ten", " Eleven", " Twelve", " Thirteen", " Fourteen", " Fifteen",
			" Sixteen", " Seventeen", " Eighteen", " Nineteen" };
	private static final String[] tenMultiples = { "", "", " Twenty", " Thirty", " Forty", " Fifty", " Sixty",
			" Seventy", " Eighty", " Ninety" };
	private static final String[] placeValues = { " ", " Thousand", " Million", " Billion", " Trillion" };

	private static String convertNumber(long number) {
		String word = "";
		int index = 0;
		do {
			// take 3 digits in each iteration
			int num = (int) (number % 1000);
			if (num != 0) {
				String str = ConversionForUptoThreeDigits(num);
				word = str + placeValues[index] + word;
			}
			index++;
			// next 3 digits
			number = number / 1000;
		} while (number > 0);
		return word;
	}

	private static String ConversionForUptoThreeDigits(int number) {
		String word = "";
		int num = number % 100;
		if (num < 10) {
			word = word + units[num];
		} else if (num < 20) {
			word = word + twoDigits[num % 10];
		} else {
			word = tenMultiples[num / 10] + units[num % 10];
		}

		word = (number / 100 > 0) ? units[number / 100] + " Hundred" + word : word;
		return word;
	}

	/*
	 * public static String[] units = { "", "One", "Two", "Three", "Four",
	 * "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve",
	 * "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen",
	 * "Nineteen" }; public static String[] tens = { "", "", "Twenty", "Thirty",
	 * "Fourty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
	 * 
	 * public static String convert(final int n) { if (n < 0) { return "Minus "
	 * + convert(-n); } if (n < 20) { return units[n]; } if (n < 100) { return
	 * tens[n / 10] + " " + units[n % 10]; } if (n < 1000) { return units[n /
	 * 100] + " Hundred " + ((n % 100 != 0) ? "And " : "") + convert(n % 100); }
	 * System.out.println("new n" + n);
	 * 
	 * if (n < 100000) { return convert(n / 1000) + " Thousand " + convert(n %
	 * 1000); } if (n < 10000000) { return convert(n / 100000) + " Million " +
	 * convert(n % 100000); } return convert(n / 10000000) + " Billion " +
	 * convert(n % 10000000); }
	 */
	/*
	 * public static String[] ones = { "", "one", "two", "three", "four",
	 * "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve",
	 * "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen",
	 * "nineteen" };
	 * 
	 * public static String[] tens = { "", // 0 "", // 1 "twenty", // 2
	 * "thirty", // 3 "forty", // 4 "fifty", // 5 "sixty", // 6 "seventy", // 7
	 * "eighty", // 8 "ninety" // 9 };
	 * 
	 * public static String getMoneyIntoWords(double money) { long dollars =
	 * (long) money; long cents = Math.round((money - dollars) * 100);
	 * 
	 * if (money == 0D) { return ""; } if (money < 0) { return
	 * INVALID_INPUT_GIVEN; } String dollarsPart = ""; if (dollars > 0) {
	 * dollarsPart = convert(dollars) + " dollar" + (dollars == 1 ? "" : "s"); }
	 * String centsPart = ""; if (cents > 0) { if (dollarParts.length() > 0) {
	 * centsPart = " and "; } centsPart += convert(cents) + " cent" + (cents ==
	 * 1 ? "" : "s"); } return dollarsPart + centsPart; }
	 */

}
