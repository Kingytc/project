package com.sai.laps.helper.report;
import java.awt.Color;

import org.apache.log4j.Logger;

import com.lowagie.text.Cell;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;

/***
 * Venkatesh D
 * For Adding differet Report Cells to the table
 *
 */
public class ReportManager
{
	 /***
	 * @purpose To add cell(Phrase) to a table
	 * @date Dec 24, 2009 11:49:55 AM
	 * @throws Exception
	 * ReportCellPhrase
	 */
	public Cell ReportCellPhrase(String strText, int Colspan,Font f,int HorizontalAlign)throws Exception {
		Cell cell = new Cell(new Phrase(strText,f));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	


	static Logger log=Logger.getLogger(ReportManager.class);	

	
	
	/**
	 * 
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @param HorizontalAlign
	 * @return
	 * @throws Exception
	 */
	
	public Cell ReportCellPhrase(int HorizontalAlign,String strText, int Colspan,int RowSpan)throws Exception 
	{
		Cell cell = new Cell(new Phrase(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	public Cell ReportCellPhrase(String strText, int Colspan,Font font)throws Exception {
		Cell cell = new Cell(new Phrase(strText,font));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0);
		cell.setHorizontalAlignment(1);
		return cell;
	}
	
	/**
	 * @purpose To Add cell(Paragraph) to the table 
	 * @since 4.2
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 * ReportCellNormal
	 */
	public Cell ReportCell(String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(0);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCell(int HorizontalAlign,String strText, int Colspan,int RowSpan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @param font
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCell(int HorizontalAlign,String strText, int Colspan, int RowSpan, Font font)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,font));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCell(int HorizontalAlign,String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param BorderWidth
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCell(int HorizontalAlign,String strText, int Colspan,float BorderWidth)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setColspan(Colspan);
		cell.setBorderWidth(BorderWidth);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellGray(String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setBackgroundColor(ReportConstants.REPORT_COLOR_GRAY);
		cell.setColspan(Colspan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(0);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellGray(int HorizontalAlign,String strText, int Colspan,int RowSpan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setBackgroundColor(ReportConstants.REPORT_COLOR_GRAY);
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @param colBgColor
	 * @return
	 * @throws Exception
	 */
		
	public Cell ReportCellPhraseColor(int HorizontalAlign,String strText, int Colspan,int RowSpan,Color colBgColor)throws Exception 
	{
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_NORMAL));
		cell.setBackgroundColor(colBgColor);
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.0f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @param fntTextFont
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellPhraseFont(int HorizontalAlign,String strText, int Colspan,int RowSpan,Font fntTextFont)throws Exception 
	{
		Cell cell = new Cell(new Paragraph(strText,fntTextFont));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.0f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellGrayBold(int HorizontalAlign,String strText,int Colspan,int RowSpan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setBackgroundColor(ReportConstants.REPORT_COLOR_GRAY);
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(0);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(int HorizontalAlign,String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}

	/**
	 * 
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(String strText, int Colspan,int RowSpan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(0);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param RowSpan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(int HorizontalAlign,String strText, int Colspan,int RowSpan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setRowspan(RowSpan);
		cell.setBorderWidth(0.1f);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}

	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param BorderWidth
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(int HorizontalAlign,String strText, int Colspan,float BorderWidth)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setBorderWidth(BorderWidth);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**	  
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param BorderWidth
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBold(int HorizontalAlign,String strText, int Colspan, int Rowspan,float BorderWidth)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setColspan(Colspan);
		cell.setRowspan(Rowspan);
		cell.setBorderWidth(BorderWidth);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBoldGray(int HorizontalAlign,String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD));
		cell.setBackgroundColor(ReportConstants.REPORT_COLOR_GRAY);
		cell.setColspan(Colspan);
		cell.setHorizontalAlignment(HorizontalAlign);
		cell.setBorderWidth(0.1f);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellBoldUlFontPhrase(int HorizontalAlign,String strText, int Colspan)throws Exception 
	{
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_BOLD_UNDERLINE_12));
		cell.setColspan(Colspan);
		cell.setHorizontalAlignment(HorizontalAlign);
		cell.setBorderWidth(0.1f);
		cell.setBorderWidth(0);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellFontColorWhite9(int HorizontalAlign,String strText, int Colspan)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_COLOR_WHITE_9));
		cell.setColspan(Colspan);
		cell.setHorizontalAlignment(HorizontalAlign);
		cell.setBorderWidth(0.1f);
		return cell;
	}
	
	/**
	 * 
	 * @param HorizontalAlign
	 * @param strText
	 * @param Colspan
	 * @param BorderWidth
	 * @return
	 * @throws Exception
	 */
	public Cell ReportCellFontColorWhite9(int HorizontalAlign,String strText, int Colspan,float BorderWidth)throws Exception {
		Cell cell = new Cell(new Paragraph(strText,ReportConstants.REPORT_FONT_COLOR_WHITE_9));
		cell.setColspan(Colspan);
		cell.setBorderWidth(BorderWidth);
		cell.setHorizontalAlignment(HorizontalAlign);
		return cell;
	}

}