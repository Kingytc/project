package com.sai.laps.helper.report;

import java.awt.Color;

import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;

/**
 * 
 *@author : S.SATHYA MOORTHY
 *@date   :Mar 14, 2009 :11:31:55 AM
 *@purpose:
 *@description :
 *@todo :
 */
public class ReportConstants{

	public ReportConstants() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
    public static Font REPORT_FONT_UNDERLINE=FontFactory.getFont("Helvetica",12,Font.UNDERLINE,new Color(0,0,0));
    public static Color REPORT_COLOR_GRAY = new Color(234, 234, 234);
    public static Color REPORT_COLOR_WHITE = new Color(255, 255, 255);
    public static Font REPORT_FONT_WHITE=FontFactory.getFont(FontFactory.HELVETICA,9, Font.NORMAL, new Color(255, 255, 255));
    public static Font REPORT_FONT_NORMAL=FontFactory.getFont(FontFactory.HELVETICA,9, Font.NORMAL, new Color(0,0,0));
	public static Font REPORT_FONT_BOLD =FontFactory.getFont(FontFactory.HELVETICA,9, Font.BOLD, new Color(0,0,0));
	public static Font REPORT_FONT_BOLD_WHITE_12 = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, new Color(0,0,0));
	public static Font REPORT_FONT_BOLD_UNDERLINE_12 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Font.UNDERLINE, new Color(0,0,0));
	public static Font REPORT_FONT_COLOR_RED=FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.RED);
	public static Font REPORT_FONT_COLOR_GREEN_9 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, new Color(70, 145, 70));
	public static Font REPORT_FONT_COLOR_YELLOW_9 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.YELLOW);
	public static Font REPORT_FONT_COLOR_BLUE_9 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.BLUE);
	public static Font REPORT_FONT_COLOR_GRAY_9 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.GRAY);
	public static Font REPORT_FONT_COLOR_WHITE_9 = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, Font.BOLD, Color.WHITE);
	
	public static Color REPORT_COLOR_RED=Color.RED;
	public static Color REPORT_COLOR_GREEN=new Color(70, 145, 70);
	public static Color REPORT_COLOR_YELLOW=Color.YELLOW;
	public static Color REPORT_COLOR_BLUE=Color.BLUE;

	
	/*	 public static Color REPORT_COLOR_BASIC_BLUE = Color.BLUE;
    public static Color REPORT_COLOR_BASIC_BLACK = Color.BLACK;
   public static Color REPORT_COLOR_BASIC_WHITE = Color.WHITE;
   public static Color REPORT_COLOR_BLUE_A1 = new Color(37, 131, 222);
   public static Color REPORT_COLOR_RED_A2 = new Color(253, 31, 6);
   public static Color REPORT_COLOR_GREEN_A3 = new Color(70, 145, 70);
   public static Color REPORT_COLOR_BROWN_A4 = new Color(128, 0, 0);
   public static Color REPORT_COLOR_PURPLE_A5 = new Color(128, 128, 192);
   public static Color REPORT_BACKGROUND_COLOR_BASIC_BLACK = Color.BLACK;
   public static Color REPORT_BACKGROUND_COLOR_BASIC_BLUE = Color.BLUE;
   public static Color REPORT_BACKGROUND_COLOR_BASIC_WHITE = Color.WHITE;
   public static Color REPORT_BACKGROUND_COLOR_BLUE_A1 = new Color(37, 131, 222);
   public static Color REPORT_BACKGROUND_COLOR_RED_A2 = new Color(253, 31, 6);
   public static Color REPORT_BACKGROUND_COLOR_GREEN_A3 = new Color(70, 145, 70);
   public static Color REPORT_BACKGROUND_COLOR_BROWN_A4 = new Color(128, 0, 0);
   public static Color REPORT_BACKGROUND_COLOR_PURPLE_A5 = new Color(128, 128, 192);
   public static Font REPORT_FONT_BASIC_BLACK_8 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_9 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_10 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_11 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_12 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLUE_8 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_10 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_11 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_12 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, Color.BLUE);
   public static Font REPORT_FONT_BASIC_WHITE_8 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_9 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_10 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_11 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_12 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, Color.WHITE);
   public static Font REPORT_FONT_A18 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A19 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A110 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A111 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A112 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A28 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A29 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A210 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A211 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A212 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A38 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A39 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A310 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A311 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A312 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A48 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A49 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A410 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A411 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A412 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A58 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A59 = FontFactory.getFont("Helvetica", 9, Font.NORMAL, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A510 = FontFactory.getFont("Helvetica", 8, Font.NORMAL, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A511 = FontFactory.getFont("Helvetica", 11, Font.NORMAL, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A512 = FontFactory.getFont("Helvetica", 12, Font.NORMAL, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_BASIC_BLACK_8_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_9_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_10_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_11_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLACK_12_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, Color.BLACK);
   public static Font REPORT_FONT_BASIC_BLUE_8_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_9_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_10_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_11_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, Color.BLUE);
   public static Font REPORT_FONT_BASIC_BLUE_12_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, Color.BLUE);
   public static Font REPORT_FONT_BASIC_WHITE_8_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_9_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_10_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_11_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, Color.WHITE);
   public static Font REPORT_FONT_BASIC_WHITE_12_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, Color.WHITE);
   public static Font REPORT_FONT_A18_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A19_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A110_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A111_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A112_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A28_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A29_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A210_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A211_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A212_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A38_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A39_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A310_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A311_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A312_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A48_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A49_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A410_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A411_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A412_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A58_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A59_BOLD = FontFactory.getFont("Helvetica", 9, Font.BOLD, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A510_BOLD = FontFactory.getFont("Helvetica", 8, Font.BOLD, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A511_BOLD = FontFactory.getFont("Helvetica", 11, Font.BOLD, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A512_BOLD = FontFactory.getFont("Helvetica", 12, Font.BOLD, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A18_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A19_ITALIC = FontFactory.getFont("Helvetica", 9, Font.ITALIC, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A110_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A111_ITALIC = FontFactory.getFont("Helvetica", 11, Font.ITALIC, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A112_ITALIC = FontFactory.getFont("Helvetica", 12, Font.ITALIC, REPORT_COLOR_BLUE_A1);
   public static Font REPORT_FONT_A28_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A29_ITALIC = FontFactory.getFont("Helvetica", 9, Font.ITALIC, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A210_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A211_ITALIC = FontFactory.getFont("Helvetica", 11, Font.ITALIC, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A212_ITALIC = FontFactory.getFont("Helvetica", 12, Font.ITALIC, REPORT_COLOR_RED_A2);
   public static Font REPORT_FONT_A38_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A39_ITALIC = FontFactory.getFont("Helvetica", 9, Font.ITALIC, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A310_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A311_ITALIC = FontFactory.getFont("Helvetica", 11, Font.ITALIC, REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A312_ITALIC = FontFactory.getFont("Helvetica", 12, Font.ITALIC,  REPORT_COLOR_GREEN_A3);
   public static Font REPORT_FONT_A48_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A49_ITALIC = FontFactory.getFont("Helvetica", 9, Font.ITALIC, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A410_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A411_ITALIC = FontFactory.getFont("Helvetica", 11, Font.ITALIC, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A412_ITALIC = FontFactory.getFont("Helvetica", 12, Font.ITALIC, REPORT_COLOR_BROWN_A4);
   public static Font REPORT_FONT_A58_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A59_ITALIC = FontFactory.getFont("Helvetica", 9, Font.ITALIC, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A510_ITALIC = FontFactory.getFont("Helvetica", 8, Font.ITALIC, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A511_ITALIC = FontFactory.getFont("Helvetica", 11, Font.ITALIC, REPORT_COLOR_PURPLE_A5);
   public static Font REPORT_FONT_A512_ITALIC = FontFactory.getFont("Helvetica", 12, Font.ITALIC, REPORT_COLOR_PURPLE_A5);
   public static int ORIENTATION_LANDSCAPE = 1;
   public static int ORIENTATION_PORTRAIT = 0;
   */
	
	
	
	
}