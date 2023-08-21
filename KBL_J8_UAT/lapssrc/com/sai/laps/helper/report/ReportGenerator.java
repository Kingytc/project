package com.sai.laps.helper.report;
import java.awt.Color;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.Table;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.html.simpleparser.StyleSheet;
import com.lowagie.text.pdf.PdfPageEvent;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.document.output.RtfDataCache;
import com.sai.fw.context.ApplicationContext;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.helper.SAILogger;

/**
 * @author :S.SATHYA MOORTHY
 * @PURPOSE:FOR GENERATING REPORTS FROM LAPS ENGINE.(RTF,PDF,DOC)
 * @USAGE: IN BEAN.
 * @JAR FILE NEEDED:iText-2.0.7.jar
 * @POWERED BY :LAPS CACHE MODULE
 **/
public class ReportGenerator implements PdfPageEvent
{	
	
	public ReportGenerator() {
		super();
		// TODO Auto-generated constructor stub
		
	}
	
	


	static Logger log=Logger.getLogger(ReportGenerator.class);	

	/**
	 * 
	 *@author: S.SATHYA MOORTHY
	 *@date   :Mar 24, 2009 :11:30:22 AM
	 *@purpose:FOR INITILIZING THE REPORT GENERATOR ON STARTUP.
	 *@description :
	 *@todo :
	 */
	public static void initReportGenerator(){
		 getInstance();
		 
	}
	
	
	
	/**PDF REFERENCE DECLARATIONS **/
	public static Document document =null;
	public static ByteArrayOutputStream pdfbs=null;
	public static ByteArrayOutputStream rtfbs=null;
	public static PdfWriter pdfwriter=null;
	public static RtfWriter2 rtfwriter=null;
	/** END OF REFERENCE DECALARTIONS **/

	
    
    //----------------------------------------------------------------------------------------------------------
    /**PDF HEADER CONSTANTS **/
    public static String LAPS_PDF_HEADER_APPN0="";
    public static String LAPS_PDF_HEADER_CUSTOMERNAME="";
    /** END OF PDF HEADER CONSTANTS **/
    
   
    
    
    /**
	* @author:S.SATHYA MOORTHY
	* @PURPOSE:creating Document Instance
	* @return :This Method creates and returns the document Object
	**/
	public static Document getInstance()
	{	
		try
		{
			document = new Document(PageSize.A4, 20, 20, 20, 20);
			pdfbs = new ByteArrayOutputStream();
			rtfbs = new ByteArrayOutputStream();
			pdfwriter = PdfWriter.getInstance(document,pdfbs);
			rtfwriter = RtfWriter2.getInstance(document,rtfbs);//this rtf writer included for rtf file generation.
     		rtfwriter.getDocumentSettings().setDataCacheStyle(RtfDataCache.CACHE_DISK);//TEMPORARY STORAGE OF DOCUMENT IN DISK (S.SATHYA MOORTHY).
			addPageNumber(document);
			ReportGenerator event = new ReportGenerator();
			pdfwriter.setPageEvent(event);			
			document.addCreator("LAPS [LENDING AUTOMATION PROCESSING SYSTEM]");			
			document.addSubject("SYSARC INFOMATIX PRIVATE LTD");
			document.addCreationDate();
			document.open();						
		}
		catch(Exception e)
		{
			log.error("Exception Occurs while PDF(document) and RTF(document)creating Instance"+e.toString());
		}
		return document;	
	}
	
	
	
	
	
	
	/**
	 * @author:S.SATHYA MOORTHY
	 * @PURPOSE: CUSTOMIZABLE PDF (PAGE SIZE AND CO-ORDINATES)
	 * @USAGE :BEAN
	 * @SINCE :07/05/2008
	 * @param pagesize
	 * @param x1
	 * @param y1
	 * @param x2
	 * @param y2
	 * @return
	 */
	public static Document getCustomizeInstance(Rectangle pagesize,int x1,int y1,int x2,int y2)
	{
		try
		{
			document=new Document(pagesize, x1, y1, x2, y2);
			pdfbs = new ByteArrayOutputStream();
			rtfbs=new ByteArrayOutputStream();
			pdfwriter=PdfWriter.getInstance(document,pdfbs);
			rtfwriter = RtfWriter2.getInstance(document,rtfbs);//this rtf writer included for rtf file generation.
			rtfwriter.getDocumentSettings().setDataCacheStyle(RtfDataCache.CACHE_DISK);//TEMPORARY STORAGE OF DOCUMENT IN DISK (S.SATHYA MOORTHY).
			addPageNumber(document);
			ReportGenerator event = new ReportGenerator();
			pdfwriter.setPageEvent(event);			
			document.addCreator("LAPS [LENDING AUTOMATION PROCESSING SYSTEM]");
			document.addSubject("SYSARC INFOMATIX PRIVATE LTD");
			document.addCreationDate();
			document.open();
						
		}
		catch(Exception e)
		{
			log.error("Exception Occurs while PDF(document) and RTF(document)creating Instance"+e.toString());
		}
		return document;	
	}
	
	/**
	 * @author-S.SATHYA MOORTHY
	 * @PURPOSE: FOR CREATING THE IMAGE IN THE PDF.
	 * @ARG: image name,scale value
	 * @RETURN:IMAGE OBJECT.
	 * @source directory:img
	 */	
	public static  Image createPDFImage(int align,float scale)
	{
		Image image =null;
		try
		{			
			image = Image.getInstance (ApplicationContext.getHomeLogoRealPath());
			log.info("PDF IMAGE URI"+image.getUrl());
			if(image!=null)	{	
				image.setAlignment(align);		 //alignment of the image left=0 center=1 right=2;
	            image.scalePercent (scale);//increasing the width and height of the laps pdf
	            image.setRotationDegrees (0.0f);//image rotation. default 0 degree.
	           
			}
			else
			log.info("PDF LOGO NOT FOUND IN THE SYSTEM PATH ! ");
		}
		catch(Exception e)
		{
			log.error(e.toString());
		}
		return image;
	}
	
	

	
	
	
	
	

	
	/**
	 * @author S.SATHYA MOORTHY.
	 * @PURPOSE:For adding the content of pdf stream to hashmap.(BYTE TYPE CASTING)
	 * @arg:hashmap
	 **/
	public static void drawPDF(HashMap hshValues)
	{		
		try
		{
			if(document.isOpen())document.close();
			byte bytearray[]=pdfbs.toByteArray();
			ByteArrayOutputStream bs=new ByteArrayOutputStream();
			bs.write(bytearray);
			hshValues.put("PDF_OBJECT",bytearray);//this made for pdf generation
			bs.flush();
			bs.close();
			pdfbs.flush();
			pdfbs.close();
			rtfbs.flush();
			rtfbs.close();
			document=null;
			pdfbs=null;
			bs=null;
			rtfbs=null;

			
		}
		catch(Exception e)
		{
			log.error("$"+e.toString());
		}	
	}	

	
	
	
	/**
	 * @author S.SATHYA MOORTHY.
	 * @PURPOSE:For adding the content of rtf stream to hashmap.(BYTE TYPE CASTING)
	 * @arg:hashmap
	 **/
	public static void drawRTF(HashMap hshValues)
	{		
		try
		{
			if(document.isOpen())document.close();
			byte rtfbytearray[]=rtfbs.toByteArray();
			ByteArrayOutputStream rbs=new ByteArrayOutputStream();
			rbs.write(rtfbytearray);
			hshValues.put("RTF_OBJECT",rtfbytearray);//this made for rtf format 
			rbs.flush();
			rbs.close();
			pdfbs.flush();
			pdfbs.close();
			rtfbs.flush();
			rtfbs.close();
			document=null;
			pdfbs=null;
			rbs=null;
			rtfbs=null;

		}
		catch(Exception e)
		{
			log.error("$"+e.toString());
		}	
	}	
	

	
	
	
	
	/**
	 * @author S.SATHYA MOORTHY.
	 * @PURPOSE:For adding the content of rtf stream to hashmap.(BYTE TYPE CASTING)(AGAIN CONTENT CHANGED TO MS-DOC)
	 * @arg:hashmap
	 **/
	public static void drawDOC(HashMap hshValues)
	{		
		try
		{
			if(document.isOpen())document.close();
			byte rtfbytearray[]=rtfbs.toByteArray();
			ByteArrayOutputStream rbs=new ByteArrayOutputStream();
			rbs.write(rtfbytearray);
			hshValues.put("DOC_OBJECT",rtfbytearray);//this made for DOC format 
			rbs.flush();
			rbs.close();
			pdfbs.flush();
			pdfbs.close();
			rtfbs.flush();
			rtfbs.close();
			document=null;
			pdfbs=null;
			rbs=null;
			rtfbs=null;
					
		}
		catch(Exception e)
		{
			log.error("$"+e.toString());
		}	
	}	
	
	
	
	
	
	
	/**
	 *@author :S.SATHYA MOORTHY 
	 * @PURPOSE:FOR ADDING PAGE NUMBER
	 * @ARG:DOCUMENT OBJECT
	 */
	public static void  addPageNumber(Document hfdocument)
	{
		try
		{				
			HeaderFooter footer = new HeaderFooter(new Phrase("- "),new Phrase(" -"));
			footer.disableBorderSide(0);
			footer.setBorderWidthBottom(0.0f);
			footer.setBorderWidthTop(0.0f);
			footer.setAlignment(1);
			hfdocument.setFooter(footer);
			footer=null;
			/*
			hfdocument.open();
			hfdocument.add(createPDFImage(1,100.0f));
			HeaderFooter header = new HeaderFooter(new Phrase("Application Number:"+PDFGenerator.LAPS_PDF_HEADER_APPN0+"\t\t\tApplicant Name"+PDFGenerator.LAPS_PDF_HEADER_CUSTOMERNAME),false);
			header.setAlignment(1);
			header.setBorderWidthBottom(0.2f);
			header.setBorderWidthLeft(0.2f);
			header.setBorderWidthRight(0.2f);
			header.setBorderWidthTop(0.2f);
			header.setBackgroundColor(new Color(237,240,253));
			hfdocument.setHeader(header);
			*/
			
		}
		catch(Exception e)
		{
			log.error("$ Exception Occured While adding PAGE NUMBER"+e.toString());			
		}		 
	}	


	
	
	
	/**
	 *@author :	Muralidharan R
	 *@PURPOSE:For Creating new Page in the Pdf 
	 *@ARG:DOCUMENT OBJECT,Application Number,Company Name,Document Heading
	 */
	
	public static void  addHeader(Document hfdocument,String strApplicationNo,String strApplicantName,String strDocumentHeading)
	{
		try
		{			
			hfdocument.add(createPDFImage(1,50.0f));
			hfdocument.add(new Paragraph(""));
			Table table1=null;
			Cell cell1=null;
			if(!FwHelper.correctNull(strDocumentHeading).equals("")){	
				table1=new Table(1);
    			table1.setPadding(2.0f);
    			table1.setWidth(100.0f);
    			table1.setBorder(0);			
    			cell1=new Cell(new Paragraph(strDocumentHeading+" ",ReportConstants.REPORT_FONT_BOLD_UNDERLINE_12));
    			cell1.setHorizontalAlignment(1);	
    			cell1.setBorder(0);
    			table1.addCell(cell1);
    			cell1=null;			
    			hfdocument.add(table1);
    			table1=null;
    			hfdocument.add(new Paragraph(""));
			}
			table1=new Table(4);
			table1.setPadding(2.0f);
			table1.setWidth(100.0f);
			table1.setBorderWidth(0.0f);
			table1.setBorderColor(new Color(200,200,200));
			table1.setBackgroundColor(new Color(200,200,200));
			cell1=new Cell(new Paragraph("Application Number "+"",FontFactory.getFont(FontFactory.HELVETICA,9, Font.BOLD, new Color(0,0,0))));
			cell1.setHorizontalAlignment(1);
			cell1.setBorderColorRight(new Color(234,234,23));
			table1.addCell(cell1);
			Cell cell2=new Cell(new Paragraph(strApplicationNo,FontFactory.getFont(FontFactory.HELVETICA,9, Font.NORMAL, new Color(0,0,0))));
			table1.addCell(cell2);
			Cell cell3=new Cell(new Paragraph("Applicant Name "+"",FontFactory.getFont(FontFactory.HELVETICA,9, Font.BOLD, new Color(0,0,0))));
			cell3.setHorizontalAlignment(1);
			table1.addCell(cell3);
			Cell cell4=new Cell(new Paragraph(strApplicantName,FontFactory.getFont(FontFactory.HELVETICA,9, Font.NORMAL, new Color(0,0,0))));
			cell4.setVerticalAlignment(1);
			table1.addCell(cell4);
			hfdocument.add(table1);
			cell1=null; cell2=null;cell3=null;cell4=null;
			table1=null;
			hfdocument.add(new Paragraph(""));
			hfdocument.add(new Paragraph(""));
			hfdocument.add(new Paragraph(""));
					
			}
		catch(Exception e)
		{
			log.error("$ Exception Occured While adding HeaderFooter"+e.toString());			
		}		 
	}
	

	
	
	
	/**
	 *@author :S.SATHYA MOORTHY 
	 * @PURPOSE:For Restricting the Toolbars in the generated PDF's 
	 * @ARG:documentobject.
	 * @since:28/01/2008
	 */
	public static void  disablePDFToolbars(Document pdfdocument)
	{
		/*
		pdfwriter.setViewerPreferences(
				pdfwriter.HideMenubar|
				pdfwriter.HideToolbar);
				*/
	}
	
	
	
	
	/**
	 *@author :S.SATHYA MOORTHY 
	 * @PURPOSE:For Restricting Printing Option in the generated Pdfss 
	 * @ARG:documentobject.
	 * @since:28/01/2008
	 */
	public static void noPrint(boolean boolArg)
	{/*
		if(boolArg)
		{
		pdfwriter.setViewerPreferences(pdfwriter.ALLOW_PRINTING);
		}
		*/
	}
	
	
	
	
	/**
	 *@author :S.SATHYA MOORTHY 
	 * @PURPOSE:For Adding Javascript into the generated Pdf 
	 * @ARG:String javascriptcode
	 * @since:28/01/2008
	 */
	
	public static void  addJavaScript(String strJavaScriptCodes)
	{
		/*
		pdfwriter.addJavaScript(strJavaScriptCodes);
		*/
		
	
	}
	
	
	
	
	/**
	 * PDF EVENTS FOR ADDING HEADERS AND PAGE WISE MANIPULATION
	 * 
	 */
	public void onOpenDocument(PdfWriter ewriter, Document edocument){} 
	public void onCloseDocument(PdfWriter ewriter, Document edocument){} 
	public void onEndPage(PdfWriter ewriter, Document edocument){}
	public void onParagraph(PdfWriter ewriter, Document edocument, float paragraphPosition){} 
	public void onParagraphEnd(PdfWriter ewriter,Document edocument,float paragraphPosition){} 
	public void onChapter(PdfWriter ewriter,Document edocument,float paragraphPosition, Paragraph title){} 
	public void onChapterEnd(PdfWriter ewriter,Document edocument,float paragraphPosition){} 
	public void onSection(PdfWriter ewriter,Document edocument,float paragraphPosition, int depth, Paragraph title){} 
	public void onSectionEnd(PdfWriter ewriter,Document edocument,float paragraphPosition){}
	public void onGenericTag(PdfWriter ewriter, Document edocument, Rectangle rect, String text){} 
	public void onStartPage(PdfWriter ewriter, Document edocument)
	{
		
		
		
	/*try{edocument.add(createPDFImage(1,100.0f));}catch(Exception e){} 
		try
		{
		
		document.add(createPDFImage(1,100.0f));
		document.add(new Paragraph(""));
		Table table1=new Table(4);
		table1.setPadding(2.0f);
		table1.setWidth(100.0f);
		table1.setBorderWidth(0.0f);
		table1.setBorderColor(new Color(255,255,255));
		table1.setBackgroundColor(new Color(237,240,253));
		
		
		if(!PDFGenerator.LAPS_PDF_HEADER_APPN0.equals("")|| !PDFGenerator.LAPS_PDF_HEADER_CUSTOMERNAME.equals(""))
		{
			/*
		Cell cell1=new Cell(new Paragraph("Application Number :"+"",FontFactory.getFont(FontFactory.HELVETICA,8, Font.NORMAL, new Color(0,0,0))));
		table1.addCell(cell1);
		cell1.setHorizontalAlignment(1);
		Cell cell2=new Cell(new Paragraph(PDFGenerator.LAPS_PDF_HEADER_APPN0,FontFactory.getFont(FontFactory.HELVETICA,8, Font.NORMAL, new Color(0,0,0))));
		table1.addCell(cell2);
		Cell cell3=new Cell(new Paragraph("Applicant Name :"+"",FontFactory.getFont(FontFactory.HELVETICA,8, Font.NORMAL, new Color(0,0,0))));
		table1.addCell(cell3);
		Cell cell4=new Cell(new Paragraph(PDFGenerator.LAPS_PDF_HEADER_CUSTOMERNAME,FontFactory.getFont(FontFactory.HELVETICA,8, Font.NORMAL, new Color(0,0,0))));
		cell4.setVerticalAlignment(1);
		table1.addCell(cell4);
		table1.complete();
		document.add(table1);
		
			
			
		}
		
		
		document.add(new Paragraph(""));
		document.add(new Paragraph(""));
		document.add(new Paragraph(""));
		document.add(new Paragraph(""));
		
		
		
		}catch(Exception e){
			
			Logger.log("$Exception Occured when Handling the Page Events of PDFGenerator:"+e.toString());
			
		}*/
			
	}

		
	public static Document getParsingHTML(String str, Document doc)
	{
		try
		{
			StringReader stringReader = new 
			  StringReader(str.toString());
	        HTMLWorker worker = new HTMLWorker(doc);
	        worker.parse(stringReader);
	        
//			byte[] byte1 = str.getBytes();
//			InputStream arr = new ByteArrayInputStream(byte1);
//			
//			StyleSheet styles = new StyleSheet();
//			
//			ArrayList arrlist = HTMLWorker.parseToList(new InputStreamReader(arr), styles);
//			
//			
//			for (int k = 0; k <arrlist.size(); ++k)
//				document.add((Element)arrlist.get(k));
			
			
		}
		catch(Exception e)
		{
			log.error("$ Exception Occured While converting getParsingHTML"+e.toString());			
		}	
		return document;
	}
	
	
	
	
	
	
	
	
}//end of PDFGenerator