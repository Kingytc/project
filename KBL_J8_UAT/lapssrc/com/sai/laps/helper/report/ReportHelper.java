/**
 *@author: S.SATHYA MOORTHY
 *@date   :Apr 24, 2009 :5:12:26 PM
 *@purpose:
 *@description :
 *@todo :
  */
package com.sai.laps.helper.report;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.Constants;
import com.sai.laps.helper.SAILogger;

/**
 *@author: S.SATHYA MOORTHY
 *@date   :Apr 24, 2009 :5:12:26 PM
 *@purpose:
 *@description :
 *@todo :
 */
public class ReportHelper {

	/**
	 * 
	 */
	public ReportHelper() {
		super();
		// TODO Auto-generated constructor stub
	}
	


	static Logger log=Logger.getLogger(ReportHelper.class);	

	
	/**
	 *@author: S.SATHYA MOORTHY
	 *@date   :Apr 24, 2009 :5:09:22 PM
	 *@param booolean
	 *@param rs
	 *@param strColumnName
	 *@return
	 *@throws Exception
	 *@purpose:
	 *@description :
	 *@todo :
	 */
	public static String getResultSetData(boolean booolean,ResultSet rs,String strColumnName)throws Exception{
		try{
		return booolean?FwHelper.correctNull(rs.getString(strColumnName)):"";
		}catch(Exception e){throw new Exception(e);}
	}
	

	/**
	 *@author S.SATHYA MOORTHY 
	 * @SINCE :15/04/2008
	 * @PURPOSE :CREATING THE FONT 
	 * @param FONTSTYLE
	 * @param FONTSIZE
	 * @param FONTTYPE
	 * @param color
	 */
	public Font organizeInstanceFont(String FONTSTYLE,float FONTSIZE,int FONTTYPE,Color color)
	{
		Font font=FontFactory.getFont(FONTSTYLE,FONTSIZE,FONTTYPE,color);
		return font;
	}
	
	
	
	/**
	 *@author S.SATHYA MOORTHY 
	 * @SINCE :15/04/2008
	 * @PURPOSE :CREATING THE FONT 
	 * @param FONTSTYLE
	 * @param FONTSIZE
	 * @param FONTTYPE
	 * @param color
	 */
	public static Font organizeAutoFont(String FONTSTYLE,float FONTSIZE,int FONTTYPE,Color color)
	{
		Font font=FontFactory.getFont(FONTSTYLE,FONTSIZE,FONTTYPE,color);
		return font;
	}
	
	
	/**
	 * @author S.SATHYA MOORTHY.
	 * @PURPOSE:For Creating Table in the Pdf
	 * @inputParam:integer no of columns,Array of Column Definition.
	 * @return:Table instance
	 **/
	public static  Table createTable(int noOfColumns,String[] strColumnDefinition)
	{
		Table table=null;
		
		try
		{
			table=new Table(noOfColumns);
			table.setWidth(100.0f);
			table.setPadding(2.0f);
			table.setBorderWidth(0.2f);
			table.setBorderColor(new Color(175,175,175));
			Cell cell=null;
			for(int i=0;i<strColumnDefinition.length;i++)
			{
				cell=new Cell(new Paragraph(new Paragraph(FwHelper.correctNull(strColumnDefinition[i]),
				FontFactory.getFont(FontFactory.HELVETICA,8, Font.NORMAL, new Color(0,0,0)))));
				cell.setWidth(100.0f);
				cell.setBorderColor(new Color(175,175,175));
			    table.addCell(cell);
			}
		}
		catch(Exception e)
		{
			log.error("$"+e.toString());
		}
		return table;
	}
	
	

	
	/**
	 * @author S.SATHYA MOORTHY.
	 * @PURPOSE:For Creating Table in the Pdf (customizing table).
	 * @inputParam:integer no of columns,Array of Column Definition,font type,resultset.
	 * @return:Table instance
	 **/
	public static  Table createTable(int noOfColumns,String[] strColumnDefinition,
			Font font,int tablealignment,
			Color tableborderColor,float cellpadding,
			ResultSet rs,int cellcolSpan,int CellhorizontalAlign
			
	)
	{
		Table table=null;
		try
		{
			//setting table properties
			table=new Table(noOfColumns);
			table.setAlignment(tablealignment);
			table.setBorderColor(tableborderColor);
			table.setPadding(cellpadding);
			rs.beforeFirst();
			//setting cell properties
			Cell cell=null;
			for(int i=0;i<strColumnDefinition.length;i++)
			{
				cell=new Cell(new Paragraph(new Paragraph(FwHelper.correctNull(strColumnDefinition[i]),font)));
				cell.setColspan(cellcolSpan);
				cell.setHorizontalAlignment(CellhorizontalAlign);
				table.addCell(cell);
				if(rs.next())
				{
				cell=new Cell(new Paragraph(new Paragraph(FwHelper.correctNull(rs.getString(i)),font)));
				cell.setColspan(cellcolSpan);
				cell.setHorizontalAlignment(CellhorizontalAlign);
				table.addCell(cell);
				}
				else
				{
					cell=new Cell(new Paragraph(new Paragraph("",font)));
					cell.setColspan(cellcolSpan);
					cell.setHorizontalAlignment(CellhorizontalAlign);
					table.addCell(cell);
				}
			    
			}
			
		}
		catch(Exception e)
		{
			log.error(e.toString());
		}
		return table;
	}
	
	/**
	 * 
	 *@author: S.SATHYA MOORTHY
	 *@date   :Apr 24, 2009 :5:21:10 PM
	 *@param rs
	 *@param strColumnName
	 *@return
	 *@throws Exception
	 *@purpose:
	 *@description :
	 *@todo :
	 */
	public static Cell createCell(boolean booolean,ResultSet rs,String strColumnName) throws Exception{
		Cell cell1;
		try{
			
			cell1=new Cell(new Paragraph(booolean?FwHelper.correctNull(rs.getString(strColumnName)):"",ReportConstants.REPORT_FONT_NORMAL));
			cell1.setHorizontalAlignment(0);
			cell1.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
		}
		catch(Exception e){throw new Exception(e);}
	   return cell1;
	
	  }
	
	/**
	 * 
	 *@author: S.SATHYA MOORTHY
	 *@date   :Apr 24, 2009 :6:46:10 PM
	 *@param NumberofCols
	 *@purpose:
	 *@description :
	 *@todo :
	 */
	public static Table getTableInstance(int NumberofCols)throws Exception{
		Table table=null;
		try{
			
			table=new Table(NumberofCols);
			table.setPadding(3.0f);
			table.setTop(152.0f);
			table.setBorder(0);
			table.setAutoFillEmptyCells(true);
			table.setWidth(100.0f);
			table.setCellsFitPage(true);
			
		}
		catch(Exception e){
			throw e;
		}
		return table;
	}

	
	
public static Table appendCell(Table table,ResultSet rs)throws Exception{
		try{
			if(rs.next()){
				
								
				
				
			}
			
		}
		catch(Exception e){
			
		}
		return table;
		
	}
	
	
/**
 *@author: S.SATHYA MOORTHY
 *@date   :May 2, 2009 :2:24:18 PM
 *@param exception
 *@param response
 *@param strHidBeanId
 *@param strHidBeanGetMethod
 *@throws BadElementException
 *@throws Exception
 *@purpose:FOR GENERATING PDF FOR EXCEPTION
 *@description :
 *@todo :
 */
public static void showPDFException(Exception exception,HttpServletResponse response,String strHidBeanId,String strHidBeanGetMethod) throws BadElementException,Exception  {
	
	Document document=ReportGenerator.getInstance();
	Table table=new Table(2);
	table.setPadding(2.0f);
	table.setBorderWidth(0.0f);
	table.setAutoFillEmptyCells(true);
	table.setWidth(100.0f);
	table.setTop(152.0f);
	table.setCellsFitPage(true);
	Cell cell=new Cell(new Paragraph("RUNTIME EXCEPTION OCCURRED IN LAPS WHILE GENERATING THE PDF DOCUMENT",ReportConstants.REPORT_FONT_COLOR_RED));
	cell.setHorizontalAlignment(0);
	cell.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
	cell.setColspan(2);
	table.addCell(cell);
	cell=null;
	cell=new Cell(new Paragraph("EXCEPTION DETAILS :",ReportConstants.REPORT_FONT_COLOR_RED));
	cell.setHorizontalAlignment(0);
	cell.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
	cell.setColspan(2);
	table.addCell(cell);
	cell=null;
	cell=new Cell(new Paragraph("BUSINESS ID="+FwHelper.correctNull(strHidBeanId)+
			"   BUSINESS GET METHOD="+FwHelper.correctNull(strHidBeanGetMethod),ReportConstants.REPORT_FONT_BOLD));
	cell.setHorizontalAlignment(0);
	cell.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
	cell.setColspan(2);
	table.addCell(cell);
	cell=null;
	
	cell=new Cell(new Paragraph("EXCEPTION TYPE : ",ReportConstants.REPORT_FONT_BOLD));
	cell.setHorizontalAlignment(0);
	cell.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
	table.addCell(cell);
	cell=null;
	
	cell=new Cell(new Paragraph(FwHelper.correctNull(exception.getMessage()),ReportConstants.REPORT_FONT_BOLD));
	cell.setHorizontalAlignment(0);
	cell.setBackgroundColor(ReportConstants.REPORT_COLOR_WHITE);
	table.addCell(cell);
	cell=null;
	document.add(table);
	table=null;
	HashMap hashmap=new HashMap();
	ReportGenerator.drawPDF(hashmap);
	Object byteobject = hashmap.get("PDF_OBJECT");
	if (!(byteobject instanceof byte[]))
		throw new Exception("CANNOT GENERATE PDF !BYTE ARRAY IS NEEDED !FOUND ANOTHER DATA TYPE TYPE=:"+ byteobject.getClass());
	byte[] bytearray = (byte[]) byteobject;
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	baos.write(bytearray);
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control","must-revalidate, post-check=0, pre-check=0");
	response.setHeader("Pragma", "public");
	response.setContentType(Constants.CONTENT_TYPE_PDF);
	response.setContentLength(baos.size());
	ServletOutputStream sout = response.getOutputStream();// GETTING THE OUTPUTSTREAM
	baos.writeTo(sout);
	baos.close();
	sout.flush();
	sout.close();
	hashmap=null;
	document=null;
	
	
}
		
	

}
