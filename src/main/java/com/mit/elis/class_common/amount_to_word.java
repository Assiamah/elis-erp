package com.mit.elis.class_common;

public class amount_to_word {
    /*
     * public String h1;
     * public String A1, P1, P2, W, P ;
     * public String w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11;
     * public String C1;
     * public String D1;
     * public String ee;
     * public String T;
     * public String F1 ;
     * public String G1;
     * public String MA;
     * public String J1;
     * public String K1 ;
     * public String BA ;
     * public final String Cnvtt(String M) {
     * // TODO: On Error Resume Next Warning!!!: The statement is not translatable
     * String N1;
     * String N2;
     * String N3;
     * String N4;
     * String N5;
     * String N6;
     * String N7;
     * String N8;
     * String N9;
     * String N10;
     * String N11;
     * String N12;
     * String N13;
     * String N14;
     * String N15;
     * String N16;
     * String N17;
     * String N18;
     * String N19;
     * String N20;
     * String N30;
     * String N40;
     * String N50;
     * String N60;
     * String N70;
     * String N80;
     * String N90;
     * String NH;
     * String NT;
     * String NM;
     * String NB;
     * N1 = "One";
     * N2 = "Two";
     * N3 = "Three";
     * N4 = "Four";
     * N5 = "Five";
     * N6 = "Six";
     * N7 = "Seven";
     * N8 = "Eight";
     * N9 = "Nine";
     * N10 = "Ten";
     * N11 = "Eleven";
     * N12 = "Twelve";
     * N13 = "Thirteen";
     * N14 = "Fourteen";
     * N15 = "Fifteen";
     * N16 = "Sixteen";
     * N17 = "Seventeen";
     * N18 = "Eighteen";
     * N19 = "Ninteen";
     * N20 = "Twenty";
     * N30 = "Thirty";
     * N40 = "Forty";
     * N50 = "Fifty";
     * N60 = "Sixty";
     * N70 = "Seventy";
     * N80 = "Eighty";
     * N90 = "Ninty";
     * NH = "Hundred";
     * NT = "Thousand";
     * NM = "Million";
     * NB = "Billion";
     * String no;
     * // A1, P1, P2, W, P %%%%%%%%% Public used instead
     * int L;
     * int No1;
     * int No2;
     * int No3;
     * int No4;
     * int No5;
     * int No6;
     * int No7;
     * no = M.trim();
     * // FormatNumber(txt_Test.Text, 2, , , TriState.False)
     * no = FormatNumber(no, 2, ,, TriState.False);
     * L = no.trim().length();
     * int hl;
     * int H;
     * int hh;
     * int hhh;
     * int hr;
     * // Dim h1 As String %%%%%%% Public used instead %%%%%%%%%
     * // Halalas value From 01 to 99.
     * // ----------------------------
     * if (((no != "0.00")
     * && (L != 0))) {
     * h1 = no.Substring((no.Length - 2));
     * }
     * 
     * if ((L != 0)) {
     * H = Integer.parseInt(h1);
     * }
     * 
     * if ((L != 0)) {
     * hh = Integer.parseInt(h1.Substring((h1.Length - 1)));
     * }
     * 
     * hr = Integer.parseInt(Int(hh.ToString().Trim()));
     * hr = 0;
     * if ((L != 0)) {
     * hhh = Integer.parseInt(h1.substring(0, 1));
     * }
     * 
     * hl = Integer.parseInt(Int(hhh.ToString().Trim()));
     * hl = 0;
     * if ((h1 != "00")) {
     * if ((H < 20)) {
     * if (((hl == 0)
     * && (hr == 1))) {
     * P1 = N1;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 2))) {
     * P1 = N2;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 3))) {
     * P1 = N3;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 4))) {
     * P1 = N4;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 5))) {
     * P1 = N5;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 6))) {
     * P1 = N6;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 7))) {
     * P1 = N7;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 8))) {
     * P1 = N8;
     * }
     * 
     * if (((hl == 0)
     * && (hr == 9))) {
     * P1 = N9;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 0))) {
     * P1 = N10;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 1))) {
     * P1 = N11;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 2))) {
     * P1 = N12;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 3))) {
     * P1 = N13;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 4))) {
     * P1 = N14;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 5))) {
     * P1 = N15;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 6))) {
     * P1 = N16;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 7))) {
     * P1 = N17;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 8))) {
     * P1 = N18;
     * }
     * 
     * if (((hl == 1)
     * && (hr == 9))) {
     * P1 = N19;
     * }
     * else {
     * if ((hr == 1)) {
     * P1 = N1;
     * }
     * 
     * if ((hr == 2)) {
     * P1 = N2;
     * }
     * 
     * if ((hr == 3)) {
     * P1 = N3;
     * }
     * 
     * if ((hr == 4)) {
     * P1 = N4;
     * }
     * 
     * if ((hr == 5)) {
     * P1 = N5;
     * }
     * 
     * if ((hr == 6)) {
     * P1 = N6;
     * }
     * 
     * if ((hr == 7)) {
     * P1 = N7;
     * }
     * 
     * if ((hr == 8)) {
     * P1 = N8;
     * }
     * 
     * if ((hr == 9)) {
     * P1 = N9;
     * }
     * 
     * if (((hl == 2)
     * && (hr == 0))) {
     * P1 = N20;
     * }
     * 
     * if (((hl == 2)
     * && (hr != 0))) {
     * P2 = N20;
     * }
     * 
     * if ((hl == 3)) {
     * P2 = N30;
     * }
     * 
     * if ((hl == 4)) {
     * P2 = N40;
     * }
     * 
     * if ((hl == 5)) {
     * P2 = N50;
     * }
     * 
     * if ((hl == 6)) {
     * P2 = N60;
     * }
     * 
     * if ((hl == 7)) {
     * P2 = N70;
     * }
     * 
     * if ((hl == 8)) {
     * P2 = N80;
     * }
     * 
     * if ((hl == 9)) {
     * P2 = N90;
     * }
     * 
     * if (((P1 != "")
     * && (P2 != ""))) {
     * P = (P2 + (" " + P1));
     * }
     * 
     * if (((P1 != "")
     * && (P2 == ""))) {
     * P = P1;
     * }
     * 
     * if (((P1 == "")
     * && (P2 != ""))) {
     * P = P2;
     * }
     * 
     * int a;
     * int aa;
     * int B;
     * int bb;
     * // Dim w9, w10, w11 As String ' w1, w3, w4, w5, w6, w7, w8, w9, w10, w11
     * %%%%%% Public used instead
     * // Starting value From 00 to 99.
     * // ----------------------------
     * if (((no != "0.00")
     * && (L == 4))) {
     * A1 = no.substring((L - 2), 1);
     * }
     * 
     * A1 = ("0" + A1);
     * if (((no != "0.00")
     * && (L >= 5))) {
     * A1 = no.substring((L - 3), 2);
     * }
     * 
     * if ((L != 0)) {
     * No1 = Integer.parseInt(Int(A1));
     * }
     * 
     * if ((L != 0)) {
     * aa = Integer.parseInt(Str(A1).Substring((Str(A1).Length - 1)));
     * }
     * 
     * a = Integer.parseInt(Int(aa.ToString().Trim()));
     * }
     * 
     * }
     * else {
     * a = 0;
     * }
     * 
     * if ((L > 1)) {
     * bb = Integer.parseInt(Str(A1).Substring(0, 2));
     * }
     * else {
     * B = 0;
     * }
     * 
     * if ((L != 0)) {
     * if ((double.Parse(Int(A1).ToString().Trim()) < 10)) {
     * bb = 0;
     * }
     * else {
     * B = Integer.parseInt(Int(bb.ToString().Trim()));
     * }
     * 
     * }
     * 
     * if ((No1 != 0)) {
     * if ((No1 < 20)) {
     * if (((B == 0)
     * && (a == 1))) {
     * w1 = N1;
     * }
     * 
     * if (((B == 0)
     * && (a == 2))) {
     * w1 = N2;
     * }
     * 
     * if (((B == 0)
     * && (a == 3))) {
     * w1 = N3;
     * }
     * 
     * if (((B == 0)
     * && (a == 4))) {
     * w1 = N4;
     * }
     * 
     * if (((B == 0)
     * && (a == 5))) {
     * w1 = N5;
     * }
     * 
     * if (((B == 0)
     * && (a == 6))) {
     * w1 = N6;
     * }
     * 
     * if (((B == 0)
     * && (a == 7))) {
     * w1 = N7;
     * }
     * 
     * if (((B == 0)
     * && (a == 8))) {
     * w1 = N8;
     * }
     * 
     * if (((B == 0)
     * && (a == 9))) {
     * w1 = N9;
     * }
     * 
     * if (((B == 1)
     * && (a == 0))) {
     * w1 = N10;
     * }
     * 
     * if (((B == 1)
     * && (a == 1))) {
     * w1 = N11;
     * }
     * 
     * if (((B == 1)
     * && (a == 2))) {
     * w1 = N12;
     * }
     * 
     * if (((B == 1)
     * && (a == 3))) {
     * w1 = N13;
     * }
     * 
     * if (((B == 1)
     * && (a == 4))) {
     * w1 = N14;
     * }
     * 
     * if (((B == 1)
     * && (a == 5))) {
     * w1 = N15;
     * }
     * 
     * if (((B == 1)
     * && (a == 6))) {
     * w1 = N16;
     * }
     * 
     * if (((B == 1)
     * && (a == 7))) {
     * w1 = N17;
     * }
     * 
     * if (((B == 1)
     * && (a == 8))) {
     * w1 = N18;
     * }
     * 
     * if (((B == 1)
     * && (a == 9))) {
     * w1 = N19;
     * }
     * else {
     * if ((a == 1)) {
     * w1 = N1;
     * }
     * 
     * if ((a == 2)) {
     * w1 = N2;
     * }
     * 
     * if ((a == 3)) {
     * w1 = N3;
     * }
     * 
     * if ((a == 4)) {
     * w1 = N4;
     * }
     * 
     * if ((a == 5)) {
     * w1 = N5;
     * }
     * 
     * if ((a == 6)) {
     * w1 = N6;
     * }
     * 
     * if ((a == 7)) {
     * w1 = N7;
     * }
     * 
     * if ((a == 8)) {
     * w1 = N8;
     * }
     * 
     * if ((a == 9)) {
     * w1 = N9;
     * }
     * 
     * if (((B == 2)
     * && (a == 0))) {
     * w1 = N20;
     * }
     * 
     * if (((B == 2)
     * && (a != 0))) {
     * w2 = N20;
     * }
     * 
     * if ((B == 3)) {
     * w2 = N30;
     * }
     * 
     * if ((B == 4)) {
     * w2 = N40;
     * }
     * 
     * if ((B == 5)) {
     * w2 = N50;
     * }
     * 
     * if ((B == 6)) {
     * w2 = N60;
     * }
     * 
     * if ((B == 7)) {
     * w2 = N70;
     * }
     * 
     * if ((B == 8)) {
     * w2 = N80;
     * }
     * 
     * if ((B == 9)) {
     * w2 = N90;
     * }
     * 
     * if (((w1 != "")
     * && (w2 != ""))) {
     * W = (w2 + (" " + w1));
     * }
     * 
     * if (((w1 != "")
     * && (w2 == ""))) {
     * W = (w1 + " ");
     * }
     * 
     * if (((w1 == "")
     * && (w2 != ""))) {
     * W = (w2 + " ");
     * }
     * 
     * // Hundred value From 100 to 999.
     * // ------------------------------
     * String C2;
     * // C1 %%%%%%% Public used instead
     * if ((L == 6)) {
     * C1 = no.substring(0, 1);
     * }
     * else if ((L > 6)) {
     * C1 = no.substring((L - 4), 1);
     * C2 = no.substring((L - 5), 1);
     * }
     * 
     * if ((L > 5)) {
     * No2 = Integer.parseInt(Int(C1));
     * }
     * 
     * if ((No2 != 0)) {
     * if ((No2 == 1)) {
     * w3 = N1;
     * }
     * 
     * if ((No2 == 2)) {
     * w3 = N2;
     * }
     * 
     * if ((No2 == 3)) {
     * w3 = N3;
     * }
     * 
     * if ((No2 == 4)) {
     * w3 = N4;
     * }
     * 
     * if ((No2 == 5)) {
     * w3 = N5;
     * }
     * 
     * if ((No2 == 6)) {
     * w3 = N6;
     * }
     * 
     * if ((No2 == 7)) {
     * w3 = N7;
     * }
     * 
     * if ((No2 == 8)) {
     * w3 = N8;
     * }
     * 
     * if ((No2 == 9)) {
     * w3 = N9;
     * }
     * 
     * if (((w3 != "")
     * && (W != ""))) {
     * W = (w3 + (" "
     * + (NH + (" " + ("and" + (" " + W.trim()))))));
     * }
     * 
     * if (((w3 != "")
     * && (W == ""))) {
     * W = (w3 + (" " + NH));
     * }
     * 
     * // Thousend value From 1000 to 99999.
     * // ----------------------------------
     * // Dim D1 As String ' %%%%% Public used instead
     * int TL;
     * int d;
     * int E;
     * // ''''''''''''''''
     * int de1;
     * String DD;
     * // %%%%% Public used instead
     * // '''''''''''''''
     * if ((L == 7)) {
     * D1 = no.substring(0, 1);
     * }
     * else if ((L == 8)) {
     * D1 = no.substring(0, 2);
     * }
     * else if ((L > 8)) {
     * D1 = no.substring((L - 6), 2);
     * }
     * 
     * de1 = Integer.parseInt(D1);
     * TL = D1.Length;
     * if ((TL != 0)) {
     * No3 = Int(de1);
     * }
     * 
     * if ((TL != 0)) {
     * DD = Str(de1).Substring((Str(de1).Length - 1));
     * }
     * 
     * d = Integer.parseInt(Int(DD.trim()));
     * }
     * else {
     * d = 0;
     * }
     * 
     * if ((TL > 1)) {
     * ee = Str(de1).Substring(0, 2);
     * }
     * else {
     * E = 0;
     * }
     * 
     * if ((TL != 0)) {
     * if ((double.Parse(Int(de1).ToString().Trim()) < 10)) {
     * ee = 0.ToString();
     * }
     * else {
     * E = Integer.parseInt(Int(ee.trim()));
     * }
     * 
     * }
     * 
     * if ((No3 != 0)) {
     * if ((No3 < 20)) {
     * if (((E == 0)
     * && (d == 1))) {
     * w4 = N1;
     * }
     * 
     * if (((E == 0)
     * && (d == 2))) {
     * w4 = N2;
     * }
     * 
     * if (((E == 0)
     * && (d == 3))) {
     * w4 = N3;
     * }
     * 
     * if (((E == 0)
     * && (d == 4))) {
     * w4 = N4;
     * }
     * 
     * if (((E == 0)
     * && (d == 5))) {
     * w4 = N5;
     * }
     * 
     * if (((E == 0)
     * && (d == 6))) {
     * w4 = N6;
     * }
     * 
     * if (((E == 0)
     * && (d == 7))) {
     * w4 = N7;
     * }
     * 
     * if (((E == 0)
     * && (d == 8))) {
     * w4 = N8;
     * }
     * 
     * if (((E == 0)
     * && (d == 9))) {
     * w4 = N9;
     * }
     * 
     * if (((E == 1)
     * && (d == 0))) {
     * w4 = N10;
     * }
     * 
     * if (((E == 1)
     * && (d == 1))) {
     * w4 = N11.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 2))) {
     * w4 = N12.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 3))) {
     * w4 = N13.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 4))) {
     * w4 = N14.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 5))) {
     * w4 = N15.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 6))) {
     * w4 = N16.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 7))) {
     * w4 = N17.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 8))) {
     * w4 = N18.Trim();
     * }
     * 
     * if (((E == 1)
     * && (d == 9))) {
     * w4 = N19.Trim();
     * }
     * else {
     * if ((d == 1)) {
     * w4 = N1;
     * }
     * 
     * if ((d == 2)) {
     * w4 = N2;
     * }
     * 
     * if ((d == 3)) {
     * w4 = N3;
     * }
     * 
     * if ((d == 4)) {
     * w4 = N4;
     * }
     * 
     * if ((d == 5)) {
     * w4 = N5;
     * }
     * 
     * if ((d == 6)) {
     * w4 = N6;
     * }
     * 
     * if ((d == 7)) {
     * w4 = N7;
     * }
     * 
     * if ((d == 8)) {
     * w4 = N8;
     * }
     * 
     * if ((d == 9)) {
     * w4 = N9;
     * }
     * 
     * if (((E == 2)
     * && (d == 0))) {
     * w4 = N20;
     * }
     * 
     * if (((E == 2)
     * && (d != 0))) {
     * w5 = N20;
     * }
     * 
     * if ((E == 3)) {
     * w5 = N30;
     * }
     * 
     * if ((E == 4)) {
     * w5 = N40;
     * }
     * 
     * if ((E == 5)) {
     * w5 = N50;
     * }
     * 
     * if ((E == 6)) {
     * w5 = N60;
     * }
     * 
     * if ((E == 7)) {
     * w5 = N70;
     * }
     * 
     * if ((E == 8)) {
     * w5 = N80;
     * }
     * 
     * if ((E == 9)) {
     * w5 = N90;
     * }
     * 
     * // Dim T As String '%%%%% Public used instead
     * if (((w4 != "")
     * && (w5 != ""))) {
     * T = (w5 + (" "
     * + (w4 + (" " + NT))));
     * }
     * 
     * if (((w4 != "")
     * && ((w5 == "")
     * && (No3 < 11)))) {
     * T = (w4 + (" " + NT));
     * }
     * 
     * // + " " 'delete space
     * if (((w4 != "")
     * && ((w5 == "")
     * && (No3 >= 11)))) {
     * T = (w4 + (" " + NT));
     * }
     * 
     * // + " " 'delete space
     * if (((w4 == "")
     * && (w5 != ""))) {
     * T = (w5 + (" "
     * + (NT + " ")));
     * }
     * 
     * if ((W != "")) {
     * W = (T + (", " + W.Trim()));
     * }
     * else {
     * W = (T + W);
     * }
     * 
     * }
     * 
     * // Thousand Hundred value From 1,00,000 to 9,99,999.
     * // -------------------------------------------------
     * // Dim F1 As String '%%%%% Public used instead
     * // Dim F As Integer
     * if ((L == 9)) {
     * F1 = no.Substring(0, 1);
     * }
     * else if ((L > 9)) {
     * F1 = no.Substring((L - 7), 1);
     * }
     * 
     * if ((L > 8)) {
     * No4 = Integer.parseInt(Int(F1));
     * }
     * 
     * if ((No4 != 0)) {
     * if ((No4 == 1)) {
     * w6 = N1;
     * }
     * 
     * if ((No4 == 2)) {
     * w6 = N2;
     * }
     * 
     * if ((No4 == 3)) {
     * w6 = N3;
     * }
     * 
     * if ((No4 == 4)) {
     * w6 = N4;
     * }
     * 
     * if ((No4 == 5)) {
     * w6 = N5;
     * }
     * 
     * if ((No4 == 6)) {
     * w6 = N6;
     * }
     * 
     * if ((No4 == 7)) {
     * w6 = N7;
     * }
     * 
     * if ((No4 == 8)) {
     * w6 = N8;
     * }
     * 
     * if ((No4 == 9)) {
     * w6 = N9;
     * }
     * 
     * if (((w6 != "")
     * && ((W != "")
     * && (No3 != 0)))) {
     * W = (w6 + (" "
     * + (NH + (" " + ("and" + (" " + W.Trim()))))));
     * }
     * 
     * if (((w6 != "")
     * && ((W != "")
     * && (No3 == 0)))) {
     * W = (w6 + (" "
     * + (NH + (" "
     * + (NT + (" " + W.Trim()))))));
     * }
     * 
     * if (((w6 != "")
     * && ((W == "")
     * && (No3 == 0)))) {
     * W = (w6 + (" "
     * + (NH + (" "
     * + (NT + " ")))));
     * }
     * 
     * // Million value From 1,0,00,000 to 99,9,99,999.
     * // ---------------------------------------------
     * // Dim G1 As String '%%%%% Public used instead
     * int TM;
     * int GA;
     * int HA;
     * // '********************************************************
     * // Dim gh1 As Integer
     * string gg;
     * string gh1;
     * // '********************************************************
     * if ((L == 10)) {
     * G1 = no.Substring(0, 1);
     * }
     * else if ((L == 11)) {
     * G1 = no.Substring(0, 2);
     * }
     * else if ((L > 11)) {
     * G1 = no.Substring((L - 9), 2);
     * }
     * 
     * gh1 = G1;
     * TM = G1.Length;
     * if ((TM != 0)) {
     * No5 = Integer.parseInt(Int(gh1));
     * }
     * 
     * if ((TM != 0)) {
     * gg = Str(gh1).Substring((Str(gh1).Length - 1));
     * }
     * 
     * GA = Integer.parseInt(Int(gg.Trim()));
     * }
     * else {
     * GA = 0;
     * }
     * 
     * if ((TM > 1)) {
     * hh = Integer.parseInt(Str(gh1).Substring(0, 2));
     * }
     * else {
     * HA = 0;
     * }
     * 
     * if ((TM != 0)) {
     * if ((double.Parse(Int(gh1).ToString().Trim()) < 10)) {
     * hh = 0;
     * }
     * else {
     * HA = Integer.parseInt(Int(hh.ToString().Trim()));
     * }
     * 
     * }
     * 
     * if ((No5 != 0)) {
     * if ((No5 < 20)) {
     * if (((HA == 0)
     * && (GA == 1))) {
     * w7 = N1;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 2))) {
     * w7 = N2;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 3))) {
     * w7 = N3;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 4))) {
     * w7 = N4;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 5))) {
     * w7 = N5;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 6))) {
     * w7 = N6;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 7))) {
     * w7 = N7;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 8))) {
     * w7 = N8;
     * }
     * 
     * if (((HA == 0)
     * && (GA == 9))) {
     * w7 = N9;
     * }
     * 
     * if (((HA == 1)
     * && (GA == 0))) {
     * w7 = N10;
     * }
     * 
     * if (((HA == 1)
     * && (GA == 1))) {
     * w7 = N11.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 2))) {
     * w7 = N12.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 3))) {
     * w7 = N13.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 4))) {
     * w7 = N14.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 5))) {
     * w7 = N15.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 6))) {
     * w7 = N16.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 7))) {
     * w7 = N17.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 8))) {
     * w7 = N18.Trim();
     * }
     * 
     * if (((HA == 1)
     * && (GA == 9))) {
     * w7 = N19.Trim();
     * }
     * else {
     * if ((GA == 1)) {
     * w7 = N1;
     * }
     * 
     * if ((GA == 2)) {
     * w7 = N2;
     * }
     * 
     * if ((GA == 3)) {
     * w7 = N3;
     * }
     * 
     * if ((GA == 4)) {
     * w7 = N4;
     * }
     * 
     * if ((GA == 5)) {
     * w7 = N5;
     * }
     * 
     * if ((GA == 6)) {
     * w7 = N6;
     * }
     * 
     * if ((GA == 7)) {
     * w7 = N7;
     * }
     * 
     * if ((GA == 8)) {
     * w7 = N8;
     * }
     * 
     * if ((GA == 9)) {
     * w7 = N9;
     * }
     * 
     * if (((HA == 2)
     * && (GA == 0))) {
     * w7 = N20;
     * }
     * 
     * if (((HA == 2)
     * && (GA != 0))) {
     * w8 = N20;
     * }
     * 
     * if ((HA == 3)) {
     * w8 = N30;
     * }
     * 
     * if ((HA == 4)) {
     * w8 = N40;
     * }
     * 
     * if ((HA == 5)) {
     * w8 = N50;
     * }
     * 
     * if ((HA == 6)) {
     * w8 = N60;
     * }
     * 
     * if ((HA == 7)) {
     * w8 = N70;
     * }
     * 
     * if ((HA == 8)) {
     * w8 = N80;
     * }
     * 
     * if ((HA == 9)) {
     * w8 = N90;
     * }
     * 
     * // Dim MA As String '%%%%%% Public used instead
     * if (((w7 != "")
     * && (w8 != ""))) {
     * MA = (w8 + (" "
     * + (w7 + (" "
     * + (NM + " ")))));
     * }
     * 
     * if (((w7 != "")
     * && ((w8 == "")
     * && (No5 < 11)))) {
     * MA = (w7 + (" "
     * + (NM + " ")));
     * }
     * 
     * if (((w7 != "")
     * && ((w8 == "")
     * && (No5 >= 11)))) {
     * MA = (w7 + (" "
     * + (NM + " ")));
     * }
     * 
     * if (((w7 == "")
     * && (w8 != ""))) {
     * MA = (w8 + (" "
     * + (NM + " ")));
     * }
     * 
     * if ((W != "")) {
     * W = (MA.Trim() + (", " + W.Trim()));
     * }
     * else {
     * W = (MA + (" " + W.Trim()));
     * }
     * 
     * }
     * 
     * // Million Hundred value From 1,00,0,00,000 to 9,99,9,99,999.
     * // ----------------------------------------------------------
     * // Dim J1 As String '%%%%%% Public usedinstead
     * // Dim J As Integer
     * if ((L == 12)) {
     * J1 = no.Substring(0, 1);
     * }
     * else if ((L > 12)) {
     * J1 = no.Substring((L - 10), 1);
     * }
     * 
     * if ((L > 11)) {
     * No6 = Integer.parseInt(Int(J1));
     * }
     * 
     * if ((No6 != 0)) {
     * if ((No6 == 1)) {
     * w9 = N1;
     * }
     * 
     * if ((No6 == 2)) {
     * w9 = N2;
     * }
     * 
     * if ((No6 == 3)) {
     * w9 = N3;
     * }
     * 
     * if ((No6 == 4)) {
     * w9 = N4;
     * }
     * 
     * if ((No6 == 5)) {
     * w9 = N5;
     * }
     * 
     * if ((No6 == 6)) {
     * w9 = N6;
     * }
     * 
     * if ((No6 == 7)) {
     * w9 = N7;
     * }
     * 
     * if ((No6 == 8)) {
     * w9 = N8;
     * }
     * 
     * if ((No6 == 9)) {
     * w9 = N9;
     * }
     * 
     * if (((w9 != "")
     * && ((W != "")
     * && (No5 != 0)))) {
     * W = (w9 + (" "
     * + (NH + (" " + ("and" + (" " + W.Trim()))))));
     * }
     * 
     * if (((w9 != "")
     * && ((W != "")
     * && (No5 == 0)))) {
     * W = (w9 + (" "
     * + (NH + (" "
     * + (NM + (" " + W.Trim()))))));
     * }
     * 
     * if (((w9 != "")
     * && ((W == "")
     * && (No5 == 0)))) {
     * W = (w9 + (" "
     * + (NH + (" "
     * + (NM + " ")))));
     * }
     * 
     * // Billion value From 1,0,00,0,00,000 to 99,9,99,9,99,999.
     * // -------------------------------------------------------
     * // Dim K1 As String '%%%%%%% Public used instead
     * int TB;
     * int KA;
     * int la;
     * // '************************************************************
     * int KL1;
     * int ll;
     * int kk;
     * // '************************************************************
     * if ((L == 13)) {
     * K1 = no.Substring(0, 1);
     * }
     * else if ((L == 14)) {
     * K1 = no.Substring(0, 2);
     * }
     * else if ((L > 14)) {
     * K1 = no.Substring((L - 12), 2);
     * }
     * 
     * KL1 = Integer.parseInt(K1);
     * TB = K1.Length;
     * if ((TB != 0)) {
     * No7 = Int(KL1);
     * }
     * 
     * if ((TB != 0)) {
     * kk = Integer.parseInt(Str(KL1).Substring((Str(KL1).Length - 1)));
     * }
     * 
     * KA = Integer.parseInt(Int(kk.ToString().Trim()));
     * }
     * else {
     * KA = 0;
     * }
     * 
     * if ((TB > 1)) {
     * ll = Integer.parseInt(Str(KL1).Substring(0, 2));
     * }
     * else {
     * la = 0;
     * }
     * 
     * if ((TB != 0)) {
     * if ((double.Parse(Int(KL1).ToString().Trim()) < 10)) {
     * ll = 0;
     * }
     * else {
     * la = Integer.parseInt(Int(ll.ToString().Trim()));
     * }
     * 
     * }
     * 
     * if ((No7 != 0)) {
     * if ((No7 < 20)) {
     * if (((la == 0)
     * && (KA == 1))) {
     * w10 = N1;
     * }
     * 
     * if (((la == 0)
     * && (KA == 2))) {
     * w10 = N2;
     * }
     * 
     * if (((la == 0)
     * && (KA == 3))) {
     * w10 = N3;
     * }
     * 
     * if (((la == 0)
     * && (KA == 4))) {
     * w10 = N4;
     * }
     * 
     * if (((la == 0)
     * && (KA == 5))) {
     * w10 = N5;
     * }
     * 
     * if (((la == 0)
     * && (KA == 6))) {
     * w10 = N6;
     * }
     * 
     * if (((la == 0)
     * && (KA == 7))) {
     * w10 = N7;
     * }
     * 
     * if (((la == 0)
     * && (KA == 8))) {
     * w10 = N8;
     * }
     * 
     * if (((la == 0)
     * && (KA == 9))) {
     * w10 = N9;
     * }
     * 
     * if (((la == 1)
     * && (KA == 0))) {
     * w10 = N10;
     * }
     * 
     * if (((la == 1)
     * && (KA == 1))) {
     * w10 = N11.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 2))) {
     * w10 = N12.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 3))) {
     * w10 = N13.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 4))) {
     * w10 = N14.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 5))) {
     * w10 = N15.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 6))) {
     * w10 = N16.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 7))) {
     * w10 = N17.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 8))) {
     * w10 = N18.Trim();
     * }
     * 
     * if (((la == 1)
     * && (KA == 9))) {
     * w10 = N19.Trim();
     * }
     * else {
     * if ((KA == 1)) {
     * w10 = N1;
     * }
     * 
     * if ((KA == 2)) {
     * w10 = N2;
     * }
     * 
     * if ((KA == 3)) {
     * w10 = N3;
     * }
     * 
     * if ((KA == 4)) {
     * w10 = N4;
     * }
     * 
     * if ((KA == 5)) {
     * w10 = N5;
     * }
     * 
     * if ((KA == 6)) {
     * w10 = N6;
     * }
     * 
     * if ((KA == 7)) {
     * w10 = N7;
     * }
     * 
     * if ((KA == 8)) {
     * w10 = N8;
     * }
     * 
     * if ((KA == 9)) {
     * w10 = N9;
     * }
     * 
     * if (((la == 2)
     * && (KA == 0))) {
     * w10 = N20;
     * }
     * 
     * if (((la == 2)
     * && (KA != 0))) {
     * w11 = N20;
     * }
     * 
     * if ((la == 3)) {
     * w11 = N30;
     * }
     * 
     * if ((la == 4)) {
     * w11 = N40;
     * }
     * 
     * if ((la == 5)) {
     * w11 = N50;
     * }
     * 
     * if ((la == 6)) {
     * w11 = N60;
     * }
     * 
     * if ((la == 7)) {
     * w11 = N70;
     * }
     * 
     * if ((la == 8)) {
     * w11 = N80;
     * }
     * 
     * if ((la == 9)) {
     * w11 = N90;
     * }
     * 
     * // Dim BA As String '%%%%%%% Public used instead
     * if (((w10 != "")
     * && (w11 != ""))) {
     * BA = (w11 + (" "
     * + (w10 + (" "
     * + (NB + " ")))));
     * }
     * 
     * if (((w10 != "")
     * && ((w11 == "")
     * && (No7 < 11)))) {
     * BA = (w10 + (" "
     * + (NB + " ")));
     * }
     * 
     * if (((w10 != "")
     * && ((w11 == "")
     * && (No7 >= 11)))) {
     * BA = (w10 + (" "
     * + (NB + " ")));
     * }
     * 
     * if (((w10 == "")
     * && (w11 != ""))) {
     * BA = (w11 + (" "
     * + (NB + " ")));
     * }
     * 
     * if ((W != "")) {
     * W = (BA.Trim() + (", " + W.Trim()));
     * }
     * else {
     * W = (BA + (" " + W.Trim()));
     * }
     * 
     * }
     * 
     * // Final Return Value.
     * // -------------------
     * if ((P != "")) {
     * P = (P.Trim() + " Ghana Pesewas ");
     * }
     * 
     * if ((W != "")) {
     * W = (W.Trim() + " Ghana Cedis ");
     * }
     * 
     * if (((W != "")
     * && (P != ""))) {
     * W = (W.Trim() + (", "
     * + (P.Trim() + " Only")));
     * }
     * 
     * if (((W != "")
     * && (P == ""))) {
     * W = (W.Trim() + " Only");
     * }
     * 
     * Cnvtt = W.Trim();
     * h1 = null;
     * A1 = null;
     * P1 = null;
     * P2 = null;
     * W = null;
     * P = null;
     * w1 = null;
     * w2 = null;
     * w3 = null;
     * w4 = null;
     * w5 = null;
     * w6 = null;
     * w7 = null;
     * w8 = null;
     * w9 = null;
     * w10 = null;
     * w11 = null;
     * C1 = null;
     * D1 = null;
     * ee = null;
     * T = null;
     * F1 = null;
     * G1 = null;
     * MA = null;
     * J1 = null;
     * K1 = null;
     * BA = null;
     * return Cnvtt;
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     * 
     * }
     */
}
