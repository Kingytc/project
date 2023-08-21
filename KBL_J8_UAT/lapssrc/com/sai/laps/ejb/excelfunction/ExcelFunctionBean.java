package com.sai.laps.ejb.excelfunction;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import java.util.ArrayList;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import jxl.CellType;
import jxl.Workbook;
import jxl.Sheet;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.record.StandardRecord;
import org.apache.poi.hssf.usermodel.DVConstraint;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ComparisonOperator;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PatternFormatting;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.util.LittleEndianOutput;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFConditionalFormattingRule;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFFontFormatting;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFSheetConditionalFormatting;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTSheetProtection;

import com.sai.laps.helper.EJBInvoker;
import java.sql.ResultSet;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Field;


import com.sai.laps.ejb.edustudent.edustudentBean;
import com.sai.laps.ejb.perrepappstatus.PerRepAppStatusBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.SetupParams;

@Stateless(name = "ExcelFunctionBean", mappedName = "ExcelFunctionHome")
@Remote (ExcelFunctionRemote.class)
public class ExcelFunctionBean extends BeanAdapter{
	
	private static final long serialVersionUID = 42L;
	static Logger log=Logger.getLogger(ExcelFunctionBean.class);
	
	/**
	 * Created By Zahoorunnisa.S for Online Status Report to Excel Sheet
	 ** 
	 */

	public ExcelFunctionBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HashMap doExportOnlineReport(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		HashMap hshBeanVal = new HashMap();
		String strQuery=null;
		String strStatus=null, strStatusdesc="";
		String strOpFields=null;
		String strloantypedesc="";
		String strloantype="";
		String strbufOrgcode="";
		String strFromDate="";
		String strToDate="";
		String[] strtabnames = new String[9];
		int intRowCount=0,intCellCount=0;
		ArrayList vecT = new ArrayList();
		
		try {
			
			PerRepAppStatusBean status =  new PerRepAppStatusBean();
			hshBeanVal = status.getOnlineReport(hshValues);
			strOpFields = Helper.correctNull((String)hshBeanVal.get("strOpFields"));
			strbufOrgcode = Helper.correctNull((String)hshBeanVal.get("strbufOrgcode"));
			strloantype = Helper.correctNull((String)hshBeanVal.get("loantype"));
			strFromDate = Helper.correctNull((String)hshBeanVal.get("strFromDate"));
			strToDate = Helper.correctNull((String)hshBeanVal.get("strToDate"));
			
			
			strStatus = Helper.correctNull((String)hshBeanVal.get("strStatus"));
			strloantypedesc = SetupParams.getSetupParams("OnlinePrdCodeDesc",Helper.correctNull((String)hshBeanVal.get("loantype")));
			strStatusdesc = SetupParams.getSetupParams("OnlineAppStatus",Helper.correctNull((String)hshBeanVal.get("strStatus")));
			
			vecT = (ArrayList)hshBeanVal.get("vecT");
			
			HSSFWorkbook wb = new HSSFWorkbook();
			
			 HSSFCellStyle cellStyle_Edit_Numeric = wb.createCellStyle();
	    	 cellStyle_Edit_Numeric.setBorderLeft(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Numeric.setBorderRight(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Numeric.setBorderBottom(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Numeric.setBorderTop(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Numeric.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
	    	 cellStyle_Edit_Numeric.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	    	 cellStyle_Edit_Numeric.setLocked(false);
	    	 
	    	 HSSFCellStyle borderstyle2 = wb.createCellStyle();
	    	 HSSFFont normalfont = wb.createFont();
	    	 normalfont.setFontName("Verdana");
	    	 borderstyle2.setBorderLeft(HSSFColor.AQUA.index);
	    	 borderstyle2.setBorderRight(HSSFColor.AQUA.index);
	    	 borderstyle2.setBorderBottom(HSSFColor.AQUA.index);
	    	 borderstyle2.setBorderTop(HSSFColor.AQUA.index);
	    	 borderstyle2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	    	 borderstyle2.setFont(normalfont);
	    	 
	    	 HSSFFont boldfont = wb.createFont();
	    	 boldfont.setFontName("Verdana");
	    	 HSSFCellStyle cell_calculate= wb.createCellStyle();
	    	 boldfont.setColor(HSSFColor.BLUE.index);
	    	 boldfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	 cell_calculate.setBorderLeft(HSSFColor.AQUA.index);
	    	 cell_calculate.setBorderRight(HSSFColor.AQUA.index);
	    	 cell_calculate.setBorderBottom(HSSFColor.AQUA.index);
	    	 cell_calculate.setBorderTop(HSSFColor.AQUA.index);
	    	 cell_calculate.setFont(boldfont);
	    	 
	    	 HSSFFont headfont = wb.createFont();
	    	 headfont.setFontName("Verdana");
	    	 HSSFCellStyle cell_heading= wb.createCellStyle();
	    	 headfont.setColor(HSSFColor.GREEN.index);
	    	 headfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	 cell_heading.setBorderLeft(HSSFColor.AQUA.index);
	    	 cell_heading.setBorderRight(HSSFColor.AQUA.index);
	    	 cell_heading.setBorderBottom(HSSFColor.AQUA.index);
	    	 cell_heading.setBorderTop(HSSFColor.AQUA.index);
	    	 cell_heading.setFont(headfont);
	    	 
	    	 HSSFFont boldfont1 = wb.createFont();
	    	 boldfont1.setFontName("Courier New");
	    	 boldfont1.setColor(HSSFFont.COLOR_NORMAL);
	    	 boldfont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    	 
	    	 HSSFCellStyle bldborcolstyle= wb.createCellStyle();
	    	 bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
	    	 bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
	    	 bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
	    	 bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
	    	 bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
	    	 bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
	    	 bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    	 bldborcolstyle.getWrapText();
	    	 bldborcolstyle.setFont(boldfont1);
	    	 
	    	 HSSFCellStyle cellStyle_Edit_Left = wb.createCellStyle();
	    	 cellStyle_Edit_Left.setBorderLeft(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Left.setBorderRight(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Left.setBorderBottom(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Left.setBorderTop(HSSFColor.AQUA.index);
	    	 cellStyle_Edit_Left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	    	 cellStyle_Edit_Left.getWrapText();
	    	 cellStyle_Edit_Left.setLocked(false);
	    	 
	    	 HSSFCellStyle cellStyle_Editor_Left = wb.createCellStyle();
	    	 cellStyle_Editor_Left.setBorderLeft(HSSFColor.AQUA.index);
	    	 cellStyle_Editor_Left.setBorderRight(HSSFColor.AQUA.index);
	    	 cellStyle_Editor_Left.setBorderBottom(HSSFColor.AQUA.index);
	    	 cellStyle_Editor_Left.setBorderTop(HSSFColor.AQUA.index);
	    	 cellStyle_Editor_Left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	    	 cellStyle_Editor_Left.setWrapText(true);
	    	 cellStyle_Editor_Left.setLocked(false);

	    	 HSSFCellStyle borderstyle = wb.createCellStyle();
	    	 borderstyle.setBorderLeft(HSSFColor.AQUA.index);
	    	 borderstyle.setBorderRight(HSSFColor.AQUA.index);
	    	 borderstyle.setBorderBottom(HSSFColor.AQUA.index);
	    	 borderstyle.setBorderTop(HSSFColor.AQUA.index);
	    	 borderstyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	    	 
	    	 HSSFSheet sheet = null;
	    	 HSSFRow row = null;
	    	 HSSFCell cell = null;
	    	
	    	 if(strloantypedesc.length() == 1){
	    	 sheet = wb.createSheet(strStatusdesc+" Application Status Report for "+strloantypedesc);
	    	 }else{
	    		String strLoanType = strloantypedesc.trim().replaceAll(",","");
	         	String strDesc = "";
	         	char c=0;
	         	for(int i=0;i<strLoanType.trim().length();i++)
	         	{
	         		c = strLoanType.charAt(i);
	         		strDesc = strDesc + SetupParams.getSetupParams("OnlinePrdCodeDesc", Character.toString(c)) + " & ";
	         	}
	         	strDesc = strDesc.substring(0,strDesc.length()-3);
	         	sheet = wb.createSheet(strStatusdesc+" Application Status Report for "+strDesc);
	    	 }
	    	 
	    	 
	    	 //sheet.protectSheet("laps");
	    	 
	    	 sheet.setColumnWidth(0,0);
	    	 
	    	 for(int col=1;col<11;col++)
		     {
	    		 if(col == 2 || col == 9 ){
	    			 sheet.setColumnWidth(col,9500);
	    		 }else if(col == 5){
	    			 sheet.setColumnWidth(col,6000);
	    		 }else if(col == 6 || col == 8){
	    			 sheet.setColumnWidth(col,12000);
	    		 }else{
	    			 sheet.setColumnWidth(col,5000);
	    		 }
		     }
			 
	    	row = sheet.createRow((short) intRowCount);
	    	 
			
			
			 intRowCount++;
	    	 intCellCount=1;
	    	 row = sheet.createRow((short) intRowCount);
	    	 
	    	 for(int k=1;k<11;k++) {
	    		
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_BLANK);
		    	cell.setCellValue(String.valueOf((String)vecT.get(k-1)));
		    	cell.setCellStyle(bldborcolstyle);
		    	intCellCount++;
	    	 }
			
	    	intRowCount++;
	    	if(strStatus.equalsIgnoreCase("P")){
				
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_complete^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strloantype+"^"+strFromDate+"^"+strToDate);
			}else if(strStatus.equalsIgnoreCase("I")){
				
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_incomplete^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strloantype+"^"+strFromDate+"^"+strToDate);	
			}else if(strStatus.equalsIgnoreCase("E")){
				
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_enquiry^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strloantype+"^"+strFromDate+"^"+strToDate);	
			}
			
			rs=DBUtils.executeInternetParserQuery(strQuery);
			while(rs.next()) {
				
				intCellCount=1;
				row = sheet.createRow((short)  intRowCount);
				
				cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("org_name")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("NAME")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_NUMERIC);
		    	cell.setCellValue(correctNull(rs.getString("prelim_ref_no")));
		    	cell.setCellStyle(borderstyle);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_NUMERIC);
		    	cell.setCellValue(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("prelim_loanamount")))));
		    	cell.setCellStyle(borderstyle);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("app_date")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("action_taken")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(Helper.correctNull(rs.getString("status_date")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		        
		    	String strcomments = Helper.CLOBToString(rs.getClob("prelim_comments")).replaceAll("<[^>]+>", "").replaceAll("<!--.*?-->","");
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(Helper.removeHTMLTags(Helper.CLOBToString(rs.getClob("prelim_comments"))).toString().replaceAll("&nbsp;", "").replaceAll("--", ""));
		    	cell.setCellStyle(cellStyle_Editor_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("appln_since_dt")));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(SetupParams.getSetupParams("OnlinePrdCodeDesc",correctNull(rs.getString("PRELIM_LOANTYPE"))));
		    	cell.setCellStyle(cellStyle_Edit_Left);
		    	intCellCount++;
				
		    	intRowCount++;
			}
			
			  File foldername = null;
			
	    	  String path=Helper.correctNull(ApplicationParams.getstrOnlineExcel());
	    	  foldername=new File(path);
	    	  
	    	  if(!foldername.exists()) {
	    		foldername.mkdirs();
	    	  }
	    	 
			  Calendar cal=Calendar.getInstance();
			  String strFileName=path+"LAPS"+"_"+ cal.get(Calendar.DAY_OF_MONTH)+"_"+ cal.get(Calendar.MINUTE)+"_"+ cal.get(Calendar.MILLISECOND)+".xls";	
			  FileOutputStream fout=new FileOutputStream(strFileName);
			  wb.write(fout);
			  String strmsg="";
			  strmsg="Online Status is Successfully exported to Excel!";
			  hshresult.put("msg",strmsg);
			  hshresult.put("FileDownload",strFileName);
			  fout.close();
			
		}catch(Exception e){
			
			throw new EJBException("Error closing the connection " + e.getMessage());	
			
		}
		finally {
			try {
				if(rs!=null){
					
					rs.close();
			  }
			}
			catch(Exception e) {
				
				throw new EJBException("close"+e.toString()); 
			}
		}
		
		return hshresult ;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:July 10, 2014-04:00:00 PM
	 * @category to Export Financials Excel
	 * @return
	 * @
	 */
	public HashMap doExcelExportFinancialFormat(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		String strCMANo=Helper.correctNull((String)hshRequestValues.get("strCMANo"));
		String strPage=Helper.correctNull((String)hshRequestValues.get("strPage"));
		String cmaformat=Helper.correctNull((String)hshRequestValues.get("cmaformat"));
		ArrayList arrTabname=new ArrayList();
		String strRow[]={"D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ"};
		try
		{
			log.info("======  Logger for Excel Export Started==================");
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFCellStyle cellStyle_Edit_Numeric = wb.createCellStyle();
			cellStyle_Edit_Numeric.setBorderLeft(HSSFColor.AQUA.index);
			cellStyle_Edit_Numeric.setBorderRight(HSSFColor.AQUA.index);
			cellStyle_Edit_Numeric.setBorderBottom(HSSFColor.AQUA.index);
			cellStyle_Edit_Numeric.setBorderTop(HSSFColor.AQUA.index);
			cellStyle_Edit_Numeric.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
			cellStyle_Edit_Numeric.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			cellStyle_Edit_Numeric.setLocked(false);
			
			HSSFCellStyle cellStyle1 = wb.createCellStyle();
			cellStyle1.setDataFormat(wb.createDataFormat().getFormat("dd/mm/yyyy"));
			cellStyle1.setBorderLeft(HSSFColor.AQUA.index);
			cellStyle1.setBorderRight(HSSFColor.AQUA.index);
			cellStyle1.setBorderBottom(HSSFColor.AQUA.index);
			cellStyle1.setBorderTop(HSSFColor.AQUA.index);
			cellStyle1.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			cellStyle1.setLocked(true);
			
			HSSFCellStyle borderstyle2 = wb.createCellStyle();
			HSSFFont normalfont = wb.createFont();
			normalfont.setFontName("Verdana");
			borderstyle2.setBorderLeft(HSSFColor.AQUA.index);
			borderstyle2.setBorderRight(HSSFColor.AQUA.index);
			borderstyle2.setBorderBottom(HSSFColor.AQUA.index);
			borderstyle2.setBorderTop(HSSFColor.AQUA.index);
			borderstyle2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			borderstyle2.setFont(normalfont);
			
			HSSFFont boldfont = wb.createFont();
			boldfont.setFontName("Verdana");
			HSSFCellStyle cell_calculate= wb.createCellStyle();
			boldfont.setColor(HSSFColor.BLUE.index);
			boldfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cell_calculate.setBorderLeft(HSSFColor.AQUA.index);
			cell_calculate.setBorderRight(HSSFColor.AQUA.index);
			cell_calculate.setBorderBottom(HSSFColor.AQUA.index);
			cell_calculate.setBorderTop(HSSFColor.AQUA.index);
			cell_calculate.setFont(boldfont);
			
			HSSFFont headfont = wb.createFont();
			headfont.setFontName("Verdana");
			HSSFCellStyle cell_heading= wb.createCellStyle();
			headfont.setColor(HSSFColor.GREEN.index);
			headfont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			cell_heading.setBorderLeft(HSSFColor.AQUA.index);
			cell_heading.setBorderRight(HSSFColor.AQUA.index);
			cell_heading.setBorderBottom(HSSFColor.AQUA.index);
			cell_heading.setBorderTop(HSSFColor.AQUA.index);
			cell_heading.setFont(headfont);
			
			HSSFFont boldfont1 = wb.createFont();
			boldfont1.setFontName("Courier New");
			boldfont1.setColor(HSSFFont.COLOR_NORMAL);
			boldfont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			
			HSSFCellStyle bldborcolstyle= wb.createCellStyle();
			bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
			bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
			bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
			bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			bldborcolstyle.setFont(boldfont1);
			
			HSSFCellStyle cellStyle_Edit_Left = wb.createCellStyle();
			cellStyle_Edit_Left.setBorderLeft(HSSFColor.AQUA.index);
			cellStyle_Edit_Left.setBorderRight(HSSFColor.AQUA.index);
			cellStyle_Edit_Left.setBorderBottom(HSSFColor.AQUA.index);
			cellStyle_Edit_Left.setBorderTop(HSSFColor.AQUA.index);
			cellStyle_Edit_Left.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			cellStyle_Edit_Left.setLocked(false);
			
			HSSFCellStyle borderstyle = wb.createCellStyle();
			borderstyle.setBorderLeft(HSSFColor.AQUA.index);
			borderstyle.setBorderRight(HSSFColor.AQUA.index);
			borderstyle.setBorderBottom(HSSFColor.AQUA.index);
			borderstyle.setBorderTop(HSSFColor.AQUA.index);
			borderstyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			//Dont add a new row or new column between 1 to 4
			HSSFSheet sheet = null;
			String sheetname="";
			HSSFRow row = null;
			HSSFCell cell = null;
			
			strQuery = SQLParser.getSqlQuery("com_finmaster_selectbytabname^"+strCMANo+"^"+strPage);
			rs= DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrTabname.add(Helper.correctNull((String)rs.getString("fin_tabname")));
			}
			if(rs != null)
			{
				rs.close();
			}
			int intRowCount=0,intCellCount=0;
			if(arrTabname!=null && arrTabname.size()>0)
			{
				for(int c=arrTabname.size()-1;c>=0;c--)
				{
					intRowCount=0;intCellCount=0;
					strTabName=Helper.correctNull((String)arrTabname.get(c));
					sheet = wb.createSheet(strTabName);
					if(c==arrTabname.size()-1)
						sheetname = sheet.getSheetName();;
					sheet.protectSheet("LaPs");
					String c1=sheet.getSheetName();
					log.info(c1);
					sheet.setColumnWidth(0, 0);//Making rowid column hidden
					sheet.setColumnWidth(2, 15000);
					for(int col=3;col<35;col++)
					{
						sheet.setColumnWidth(col,4000);
					}
					
					CellRangeAddressList DateList=new CellRangeAddressList(1,1,3,34);
					DVConstraint DateConstraint=DVConstraint.createDateConstraint(DVConstraint.OperatorType.NOT_EQUAL, "00/00/0000","00/00/0000","dd/mm/yyyy");
					HSSFDataValidation DateValidation=new HSSFDataValidation(DateList,DateConstraint);
					sheet.addValidationData(DateValidation);
					
					DateList=new CellRangeAddressList(2,2,3,34);
					DateConstraint=DVConstraint.createDateConstraint(DVConstraint.OperatorType.NOT_EQUAL, "00/00/0000","00/00/0000","dd/mm/yyyy");
					DateValidation=new HSSFDataValidation(DateList,DateConstraint);
					sheet.addValidationData(DateValidation);
					
					CellRangeAddressList addressListFinType=new CellRangeAddressList(3,3,3,34);
					DVConstraint dvConstraint=DVConstraint.createExplicitListConstraint(new String[]{"AUDITED","UNAUDITED","ESTIMATED","PROJECTION"});
					HSSFDataValidation dataValidation=new HSSFDataValidation(addressListFinType,dvConstraint);
					dataValidation.setSuppressDropDownArrow(false);
					sheet.addValidationData(dataValidation);
					
					String str1="-999999999999";
					String str2="999999999999";
					CellRangeAddressList addressNumericList=new CellRangeAddressList(5,61,3,34);
					DVConstraint dvNumericConstraint=DVConstraint.createNumericConstraint(DVConstraint.ValidationType.DECIMAL, DVConstraint.OperatorType.BETWEEN, str1,str2);
					HSSFDataValidation dataNumericValidation=new HSSFDataValidation(addressNumericList,dvNumericConstraint);
					sheet.addValidationData(dataNumericValidation);
					
					row = sheet.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("ROWID");
					cell.setCellStyle(bldborcolstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("S.NO");
					cell.setCellStyle(bldborcolstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("PARTICULARS");
					cell.setCellStyle(bldborcolstyle);
					intCellCount++;
					
					for(int k=1;k<33;k++)
					{
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue("YEAR "+k);
						cell.setCellStyle(bldborcolstyle);
						intCellCount ++;
					}
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" Starting period of financial :  (Format:mm/dd/yyyy)");
					cell.setCellStyle(cell_calculate);
					intCellCount++;
					
					HSSFCellStyle cellStyle = wb.createCellStyle();
					cellStyle.setDataFormat(wb.createDataFormat().getFormat("dd/mm/yyyy"));
					cellStyle.setBorderLeft(HSSFColor.AQUA.index);
					cellStyle.setBorderRight(HSSFColor.AQUA.index);
					cellStyle.setBorderBottom(HSSFColor.AQUA.index);
					cellStyle.setBorderTop(HSSFColor.AQUA.index);
					cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
					cellStyle.setLocked(false);
					
					for(int k=1;k<33;k++)
					{
						cell = row.createCell(intCellCount);
						if(c==arrTabname.size()-1)
						{
							cell.setCellValue(" ");
							cell.setCellStyle(cellStyle);
							
						}
						else
						{
							String strFormula= sheetname+"!"+strRow[k-1]+(intRowCount+1);
							cell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
							cell.setCellFormula(strFormula);
							cell.setCellStyle(cellStyle1);
							
						}
						intCellCount++;
					}
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" End period of financial :  (Format:mm/dd/yyyy)");
					cell.setCellStyle(cell_calculate);
					intCellCount++;
					
					cellStyle = wb.createCellStyle();
					cellStyle.setDataFormat(wb.createDataFormat().getFormat("dd/mm/yyyy"));
					cellStyle.setBorderLeft(HSSFColor.AQUA.index);
					cellStyle.setBorderRight(HSSFColor.AQUA.index);
					cellStyle.setBorderBottom(HSSFColor.AQUA.index);
					cellStyle.setBorderTop(HSSFColor.AQUA.index);
					cellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
					cellStyle.setLocked(false);
					
					for(int k=1;k<33;k++)
					{
						cell = row.createCell(intCellCount);
						if(c==arrTabname.size()-1)
						{
							cell.setCellValue(" ");
							cell.setCellStyle(cellStyle);
							
						}
						else
						{
							String strFormula= sheetname+"!"+strRow[k-1]+(intRowCount+1);
							cell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
							cell.setCellFormula(strFormula);
							cell.setCellStyle(cellStyle1);
						}
						
						intCellCount++;
					}
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(" ");
					cell.setCellStyle(borderstyle);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("FINANCIAL TYPE");
					cell.setCellStyle(cell_calculate);
					intCellCount++;
					
					for(int k=1;k<33;k++)
					{
						cell = row.createCell(intCellCount);
						cell.setCellValue(HSSFCell.CELL_TYPE_BLANK);
						cell.setCellStyle(cellStyle_Edit_Left);
						
						if(c==arrTabname.size()-1)
						{
							cell.setCellValue(" ");
							cell.setCellStyle(cellStyle);
						}
						else
						{
							String strFormula= sheetname+"!"+strRow[k-1]+(intRowCount+1);
							cell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
							cell.setCellFormula(strFormula);
							cell.setCellStyle(cell_calculate);
							
						}
						intCellCount++;
					}
					
					intRowCount++;
					intCellCount=1;
					row = sheet.createRow((short) intRowCount);
					for(int k=1;k<35;k++)
					{
						cell = row.createCell(intCellCount);
						cell.setCellValue(HSSFCell.CELL_TYPE_BLANK);
						cell.setCellValue(" ");
						cell.setCellStyle(borderstyle);
						intCellCount++;
					}
					
					intRowCount++;
					strQuery = SQLParser.getSqlQuery("finselect2^"+strCMANo+"^"+strTabName);
					rs= DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						intCellCount=0;
						row = sheet.createRow((short)  intRowCount);
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(correctNull(rs.getString("fin_rowid")));
						cell.setCellStyle(borderstyle);
						intCellCount++;
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(correctNull(rs.getString("fin_sno")));
						cell.setCellStyle(borderstyle);
						intCellCount++;
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(correctNull(rs.getString("fin_rowdesc")));
						cell.setCellStyle(borderstyle2);
						if(correctNull(rs.getString("fin_rowtype")).equalsIgnoreCase("C"))
						{
							cell.setCellStyle(cell_calculate);
						}
						else if(correctNull(rs.getString("fin_rowtype")).equalsIgnoreCase("H"))
						{
							cell.setCellStyle(cell_heading);
						}
						intCellCount++;
						
						for(int k=1;k<33;k++)
						{
							intCellCount=2;
							intCellCount=k+intCellCount;
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
							cell.setCellStyle(cellStyle_Edit_Numeric);
							if(correctNull(rs.getString("fin_rowtype")).equalsIgnoreCase("H"))
							{
								cell.setCellValue(" ");
								cell.setCellStyle(cell_heading);
							}
							if(correctNull(rs.getString("fin_rowtype")).equalsIgnoreCase("C"))
							{
								cell.setCellStyle(cell_calculate);
							}
						}
						intRowCount++;
					}
				}
			}
			File foldername = null;
			String path="C:/Financial Format/";
			foldername=new File(path);
			if(!foldername.exists())
			{
				foldername.mkdirs();
			}
			String strFileName=path+"/"+cmaformat+"_"+strCMANo+"_"+"COMPANYNAME"+".xls";
			FileOutputStream fOut = new FileOutputStream(strFileName);
			String strmsg="";
			strmsg="Financial Format is Successfully exported to Excel in C:!";
			hshresult.put("strmsg",strmsg);
			//hshresult.put("workbook",wb);
			hshresult.put("FileDownload",strFileName);
			hshresult.put("strFinancialDn","Y");
			hshresult.put("FileName",cmaformat+"_"+strCMANo+"_Companyname"+".xls" );
			wb.write(fOut);
			fOut.flush();
			fOut.close();
			
			log.info("======  Logger for Excel Export Finished==================");
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	
	
	/**
	 * @author:Guhan Tamilvanan
	 * @date:July 13, 2016
	 * @category to Export Fair value calculation Excel
	 */
	public HashMap doFVCExportFormat(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		
		String strCBSaccno=Helper.correctNull((String)hshRequestValues.get("strCBSaccno"));
		String strcalc_date=Helper.correctNull((String)hshRequestValues.get("calc_date"));
		String strBorrName=Helper.correctNull((String)hshRequestValues.get("strBorrName"));
		String strBeforeVal=Helper.correctDouble((String)hshRequestValues.get("strBeforeVal"));
		String strAfterVal=Helper.correctDouble((String)hshRequestValues.get("strAfterVal"));
		String strFVProfitLoss=Helper.correctDouble((String)hshRequestValues.get("strFVProfitLoss"));
		ArrayList arrdate = new ArrayList();
		ArrayList arrPrin = new ArrayList();
		ArrayList arrInt = new ArrayList();
		ArrayList arrOS = new ArrayList();
		ArrayList arrcashflow = new ArrayList();
		int intRowCount=0,intCellCount=0;
		
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		try
		{
			HSSFWorkbook wb = new HSSFWorkbook();
			
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			borderstyleright.setBorderLeft(HSSFColor.AQUA.index);
			borderstyleright.setBorderRight(HSSFColor.AQUA.index);
			borderstyleright.setBorderBottom(HSSFColor.AQUA.index);
			borderstyleright.setBorderTop(HSSFColor.AQUA.index);
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			borderstyleleft.setBorderLeft(HSSFColor.AQUA.index);
			borderstyleleft.setBorderRight(HSSFColor.AQUA.index);
			borderstyleleft.setBorderBottom(HSSFColor.AQUA.index);
			borderstyleleft.setBorderTop(HSSFColor.AQUA.index);
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			
			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			borderstylecenter.setBorderLeft(HSSFColor.AQUA.index);
			borderstylecenter.setBorderRight(HSSFColor.AQUA.index);
			borderstylecenter.setBorderBottom(HSSFColor.AQUA.index);
			borderstylecenter.setBorderTop(HSSFColor.AQUA.index);
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			
			for(int i=1;i<=2;i++)
			{
				arrdate = new ArrayList();
				arrPrin = new ArrayList();
				arrInt = new ArrayList();
				arrOS = new ArrayList();
				arrcashflow = new ArrayList();
				if(i==1)
				{
					arrdate = (ArrayList)hshRequestValues.get("arrBeforeDate");
					arrPrin = (ArrayList)hshRequestValues.get("arrBeforePrin");
					arrInt = (ArrayList)hshRequestValues.get("arrBeforeInt");
					arrOS = (ArrayList)hshRequestValues.get("arrBeforeOS");
					arrcashflow = (ArrayList)hshRequestValues.get("arrBeforeCashFlow");
				}
				else
				{
					arrdate = (ArrayList)hshRequestValues.get("arrAfterDate");
					arrPrin = (ArrayList)hshRequestValues.get("arrAfterPrin");
					arrInt = (ArrayList)hshRequestValues.get("arrAfterInt");
					arrOS = (ArrayList)hshRequestValues.get("arrAfterOS");
					arrcashflow = (ArrayList)hshRequestValues.get("arrAfterCashFlow");
				}
				
				intRowCount=0;intCellCount=0;
				if(i == 1)
					sheet = wb.createSheet("Before");
				else
					sheet = wb.createSheet("After");
				sheet.protectSheet("laps");
				
				sheet.setColumnWidth(0, 4000);
				sheet.setColumnWidth(1, 6000);
				sheet.setColumnWidth(2, 6000);
				sheet.setColumnWidth(3, 6000);
				sheet.setColumnWidth(4, 6000);
				sheet.setColumnWidth(6, 4000);
				sheet.setColumnWidth(7, 6000);

				if(i == 1)
					strQuery = SQLParser.getSqlQuery("sel_vw_fvc_details^"+strCBSaccno+"^B");
				else
					strQuery = SQLParser.getSqlQuery("sel_vw_fvc_details^"+strCBSaccno+"^A");
				
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					row = sheet.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Customer Name");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(strBorrName);
					cell.setCellStyle(borderstyleleft);
					CellRangeAddress region = CellRangeAddress.valueOf("B1:C1"); 
					sheet.addMergedRegion(region);
					intCellCount++;
					
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("CBS Account No.");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(strCBSaccno);
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Loan Outstanding");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString("CLR_BAL_AMT")));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Calculation Date");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(strcalc_date);
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Before Value");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble(strBeforeVal))));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Interest Rate %");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString("ROI")));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Interest Demand date");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString("int_dmd_date")));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("After Value");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble(strAfterVal))));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Discount Rate %");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString("DISC_RATE")));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Due Date");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString("due_date")));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Profit/ Loss");
					cell.setCellStyle(borderstyleleft);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble(strFVProfitLoss))));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
				}
				
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((short) intRowCount);
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((short) intRowCount);
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Date");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Flow Amount");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Outstanding");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Interest");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Cash Flow");
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
				if(arrcashflow!=null && arrcashflow.size()>0)
				{
					for(int c=0;c<arrcashflow.size();c++)
					{
						intRowCount++;
						intCellCount=0;
						row = sheet.createRow((short) intRowCount);
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(Helper.correctNull((String)arrdate.get(c)));
						cell.setCellStyle(borderstyleleft);
						intCellCount++;
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)arrPrin.get(c)))));
						cell.setCellStyle(borderstyleright);
						intCellCount++;
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)arrOS.get(c)))));
						cell.setCellStyle(borderstyleright);
						intCellCount++;
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)arrInt.get(c)))));
						cell.setCellStyle(borderstyleright);
						intCellCount++;
						
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)arrcashflow.get(c)))));
						cell.setCellStyle(borderstyleright);
						intCellCount++;
					}
				}
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^FVC");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/"+strBorrName+"_"+strCBSaccno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xls");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
				log.info("Excel created and stored in the Server location :"+path+"/"+strBorrName+"_"+strCBSaccno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xls");
			}
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	
	/**
	 * @author:Guhan Tamilvanan
	 * @date:July 13, 2016
	 * @category to Export NPA provisioning output Excel
	 */
	public HashMap doExportNPAProvOutput(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String strExe_Sno=Helper.correctInt((String)hshRequestValues.get("hid_execsno"));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String[] strHeaders = {"S.No","Branch Code","Branch Name","Borrower Name","Customer ID","Finacle Account Number","Norm Status","Date of NPA","Balance Outstanding","Unrealised Interest","Other Charges","Net Balance","Provision","Secured Value","Unsecured Value","Whether Partly secured","CGC/ECGC/CGTMSE-Recd+Cover","Ab-initio","Date of AB-Initio","Whether Restructured","Date of Restructuring","Whether written off","Whether Fraud","Date of Fraud"};
		String[] strHeadersSize = {"2000","4000","10000","10000","3000","6000","4000","3000","5000","5000","5000","5000","5000","5000","5000","5000","6000","3000","4000","5000","5000","5000","4000","4000"};
		try
		{
			HSSFWorkbook wb = new HSSFWorkbook();
			
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			
			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			
			sheet = wb.createSheet("NPA PROVISIONING");
			
			row = sheet.createRow((int) intRowCount);
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			
			String strPreviousVal = "";
			int rows_count = 0;
			int rows_count_actual = 1;
			boolean boolSameCust = true;
			
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report^"+strExe_Sno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((int) intRowCount);
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(rs.getRow());
				cell.setCellStyle(borderstyleleft);
				intCellCount++;
				
				//strPreviousVal = "";
				boolSameCust = true;
				
				if(!strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					strPreviousVal = Helper.correctNull((String)rs.getString("CUST_ID"));
					rows_count = Integer.parseInt(Helper.correctInt((String)rs.getString("cus_count")));
					boolSameCust = false;
				}
				rows_count_actual = rows_count_actual + 1;
								
				for(int j=1;j<=24;j++)
				{
					if(boolSameCust && (j==13||j==14||j==15||j==17||j==18))
					{
						intCellCount++;	
						continue;
					}
					else
					{
						if(j == 1 || j == 2 || j == 3 || j == 4 || j == 5 || j == 6)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstyleleft);
							intCellCount++;
						}
						if(j == 8 || j == 9 || j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 16)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(j+1)))));
							cell.setCellStyle(borderstyleright);
							if(j==13 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("N"+rows_count_actual+":N"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==14 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("O"+rows_count_actual+":O"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							intCellCount++;
						}
						if(j == 7 || j == 15 || j == 17 || j == 18 || j == 19 || j == 20 || j == 21 || j == 22 || j ==23)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstylecenter);
							if(j==15 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("P"+rows_count_actual+":P"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==17 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("R"+rows_count_actual+":R"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==18 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("S"+rows_count_actual+":S"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
//							if(j==21 && !boolSameCust)
//							{
//								CellRangeAddress region = CellRangeAddress.valueOf("V"+rows_count_actual+":V"+(rows_count_actual+rows_count-1)); 
//								sheet.addMergedRegion(region);
//							}
//							if(j==22 && !boolSameCust)
//							{
//								CellRangeAddress region = CellRangeAddress.valueOf("W"+rows_count_actual+":W"+(rows_count_actual+rows_count-1)); 
//								sheet.addMergedRegion(region);
//							}
//							if(j==23 && !boolSameCust)
//							{
//								CellRangeAddress region = CellRangeAddress.valueOf("X"+rows_count_actual+":X"+(rows_count_actual+rows_count-1)); 
//								sheet.addMergedRegion(region);
//							}
							intCellCount++;						
						}						
					}
				}
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^NPA");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			log.info("Report Location==="+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/EXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xls");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/EXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xls");
				hshresult.put("FileName","EXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xls");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	public HashMap doExportNPAProvReport(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String strExe_Sno=Helper.correctInt((String)hshRequestValues.get("hid_execsno"));
		String strnpaorg=Helper.correctInt((String)hshRequestValues.get("npaorg")).substring(0, 6);
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String[] strHeaders = {"Branch Code","Branch Name","Region Code","Region Name","Borrower Name","Customer ID","Finacle Account Number","Norm Status","Date of NPA","Balance Outstanding","Unrealised Interest","Other Charges","Net Balance","Provision","Secured Value","Unsecured Value","Whether Partly secured","CGC/ECGC/CGTMSE-Recd+Cover","Ab-initio","Date of AB-Initio","Whether Restructured","Date of Restructuring","Whether written off","Whether Fraud","Date of Fraud","Security Type","Security ID","Owner of security","Consortium/ Multiple/Sole","If Consortium, Charge (Paripassu/ first)","Prime/ Collateral","Valuation Date","Security Value","Out of which assigned secured value","CBS Security Value"};
		String[] strHeadersSize = {"4000","10000","4000","10000","10000","3000","6000","4000","3000","5000","5000","5000","5000","5000","5000","5000","5000","6000","3000","4000","5000","5000","5000","4000","4000","4000","4000","5000","6000","7000","4000","4000","4000","7000","4000"};
		try
		{
			XSSFWorkbook wb = new XSSFWorkbook();
			
			XSSFCellStyle borderstyleright = wb.createCellStyle();
			
			
			XSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			
			XSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			
			XSSFSheet sheet = null;
			XSSFRow row = null;
			XSSFCell cell = null;
			
			sheet = wb.createSheet("NPA PROVISIONING");
			
			row = sheet.createRow((int) intRowCount);
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(XSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			String strPreviousVal = "",strPrevAccNo="";
			int rows_count = 0;
			int rows_count_actual = 1;
			int rows_count_acc = 0;
			boolean boolSameCust = true;
			boolean boolSameAcc = true;
			int i=0;
			double dblSubTotal=0,dblSubTotal1=0;
			
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report1^"+strExe_Sno+"^"+strnpaorg+"^"+strExe_Sno+"^"+strnpaorg);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				if(!strPreviousVal.equalsIgnoreCase("") && !strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc)+":G"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc)+":H"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc)+":I"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc)+":J"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc)+":K"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc)+":L"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc)+":M"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc)+":N"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc)+":R"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc)+":S"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc)+":T"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc)+":U"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc)+":V"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc)+":W"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc)+":X"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc)+":Y"+(rows_count_actual)); 
					sheet.addMergedRegion(region);

					region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc)+":AC"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc)+":AI"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					rows_count_acc=0;
					
					CellRangeAddress region4 = CellRangeAddress.valueOf("A"+(rows_count_actual-rows_count+1)+":A"+(rows_count_actual)); 
					sheet.addMergedRegion(region4);
					
					CellRangeAddress region5 = CellRangeAddress.valueOf("B"+(rows_count_actual-rows_count+1)+":B"+(rows_count_actual)); 
					sheet.addMergedRegion(region5);
					
					CellRangeAddress region6 = CellRangeAddress.valueOf("C"+(rows_count_actual-rows_count+1)+":C"+(rows_count_actual)); 
					sheet.addMergedRegion(region6);
					
					CellRangeAddress region7 = CellRangeAddress.valueOf("D"+(rows_count_actual-rows_count+1)+":D"+(rows_count_actual)); 
					sheet.addMergedRegion(region7);
					
					CellRangeAddress region8 = CellRangeAddress.valueOf("E"+(rows_count_actual-rows_count+1)+":E"+(rows_count_actual)); 
					sheet.addMergedRegion(region8);
					
					CellRangeAddress region9 = CellRangeAddress.valueOf("F"+(rows_count_actual-rows_count+1)+":F"+(rows_count_actual)); 
					sheet.addMergedRegion(region9);
					
					CellRangeAddress region1 = CellRangeAddress.valueOf("O"+(rows_count_actual-rows_count+1)+":O"+(rows_count_actual)); 
					sheet.addMergedRegion(region1);
					
					CellRangeAddress region2 = CellRangeAddress.valueOf("P"+(rows_count_actual-rows_count+1)+":P"+(rows_count_actual)); 
					sheet.addMergedRegion(region2);
					
					CellRangeAddress region3 = CellRangeAddress.valueOf("Q"+(rows_count_actual-rows_count+1)+":Q"+(rows_count_actual)); 
					sheet.addMergedRegion(region3);
					
					rows_count_actual = rows_count_actual + 1;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow(intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Sub Total");
					cell.setCellStyle(borderstyleright);
					
					region = CellRangeAddress.valueOf("A"+rows_count_actual+":AG"+rows_count_actual); 
					sheet.addMergedRegion(region);
					intCellCount=33;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal1));
					cell.setCellStyle(borderstyleright);
					
					
					dblSubTotal=0;dblSubTotal1=0;
					
				}
				
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow(intRowCount);
				
				if(!strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					strPreviousVal = Helper.correctNull((String)rs.getString("CUST_ID"));
					strPrevAccNo=Helper.correctNull((String)rs.getString("ACC_NO"));
					rows_count=1;
					boolSameCust = true;
					boolSameAcc=true;
					
					dblSubTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("assignedsec")));
					dblSubTotal1=Double.parseDouble(Helper.correctDouble(rs.getString("PrimeVal")));
					
				}
				else if(strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					if(strPrevAccNo.equalsIgnoreCase(Helper.correctNull((String)rs.getString("ACC_NO"))))
					{
						boolSameAcc=false;
						rows_count_acc+=1;
					}
					else
					{
						boolSameAcc=true;
						strPrevAccNo=Helper.correctNull((String)rs.getString("ACC_NO"));
					}
					rows_count+=1;
					boolSameCust = false;
					dblSubTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("assignedsec")));
					dblSubTotal1=Double.parseDouble(Helper.correctDouble(rs.getString("PrimeVal")));
				}
				rows_count_actual = rows_count_actual + 1;
								
				for(int j=1;j<=35;j++)
				{
					if(!boolSameCust  && boolSameAcc && (j==15||j==16||j==17||j==35||j==1||j==2||j==3||j==4||j==5||j==6))
					{
						intCellCount++;	
						continue;
					}
					else if(!boolSameAcc && (j==7||j==8||j==9||j==10||j==11||j==12||j==13||j==14||j==18||j==19||j==20||j==21||j==22||j==23||j==24||j==25||j==29||j==36))
					{
						intCellCount++;	
						continue;
					}
					else
					{
						
						if(!boolSameCust  && boolSameAcc && (j==7||j==8||j==9||j==10||j==11||j==12||j==13||j==14||j==18||j==19||j==20||j==21||j==22||j==23||j==24||j==25||j==29||j==36))
						{
							CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc-1)+":G"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc-1)+":H"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc-1)+":I"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc-1)+":J"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc-1)+":K"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc-1)+":L"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc-1)+":M"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc-1)+":N"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc-1)+":R"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc-1)+":S"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc-1)+":T"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc-1)+":U"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc-1)+":V"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc-1)+":W"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc-1)+":X"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc-1)+":Y"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);

							region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc-1)+":AC"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc-1)+":AI"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							rows_count_acc=0;
						}
						if(j == 1 || j == 2 || j == 3 || j == 4 || j == 5 || j == 6|| j == 7 || j == 8|| j == 26|| j == 27|| j == 28|| j == 29|| j == 30|| j == 31|| j == 32)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
							cell.setCellStyle(borderstyleleft);
							intCellCount++;
						}
						if(j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 15 || j == 16 || j == 18|| j == 33|| j == 34|| j == 35)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(j)))));
							cell.setCellStyle(borderstyleright);
							/*if(j==15 && boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("P"+rows_count_actual+":P"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==16 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("Q"+rows_count_actual+":Q"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==35 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("AJ"+rows_count_actual+":AJ"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}*/
							intCellCount++;
						}
						if(j == 9 || j == 17 || j == 19 || j == 20 || j == 21 || j == 22 || j == 23 || j == 24 || j ==25)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
							cell.setCellStyle(borderstylecenter);
							intCellCount++;						
						}						
					}						
				}
				
				
			}
			
			if(rs.previous())
			{
				{
					CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc)+":G"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc)+":H"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc)+":I"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc)+":J"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc)+":K"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc)+":L"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc)+":M"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc)+":N"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc)+":R"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc)+":S"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc)+":T"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc)+":U"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc)+":V"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc)+":W"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc)+":X"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc)+":Y"+(rows_count_actual)); 
					sheet.addMergedRegion(region);

					region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc)+":AC"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc)+":AI"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					rows_count_acc=0;
					
					CellRangeAddress region4 = CellRangeAddress.valueOf("A"+(rows_count_actual-rows_count+1)+":A"+(rows_count_actual)); 
					sheet.addMergedRegion(region4);
					
					CellRangeAddress region5 = CellRangeAddress.valueOf("B"+(rows_count_actual-rows_count+1)+":B"+(rows_count_actual)); 
					sheet.addMergedRegion(region5);
					
					CellRangeAddress region6 = CellRangeAddress.valueOf("C"+(rows_count_actual-rows_count+1)+":C"+(rows_count_actual)); 
					sheet.addMergedRegion(region6);
					
					CellRangeAddress region7 = CellRangeAddress.valueOf("D"+(rows_count_actual-rows_count+1)+":D"+(rows_count_actual)); 
					sheet.addMergedRegion(region7);
					
					CellRangeAddress region8 = CellRangeAddress.valueOf("E"+(rows_count_actual-rows_count+1)+":E"+(rows_count_actual)); 
					sheet.addMergedRegion(region8);
					
					CellRangeAddress region9 = CellRangeAddress.valueOf("F"+(rows_count_actual-rows_count+1)+":F"+(rows_count_actual)); 
					sheet.addMergedRegion(region9);
					
					CellRangeAddress region1 = CellRangeAddress.valueOf("O"+(rows_count_actual-rows_count+1)+":O"+(rows_count_actual)); 
					sheet.addMergedRegion(region1);
					
					CellRangeAddress region2 = CellRangeAddress.valueOf("P"+(rows_count_actual-rows_count+1)+":P"+(rows_count_actual)); 
					sheet.addMergedRegion(region2);
					
					CellRangeAddress region3 = CellRangeAddress.valueOf("Q"+(rows_count_actual-rows_count+1)+":Q"+(rows_count_actual)); 
					sheet.addMergedRegion(region3);
					
					
					rows_count_actual = rows_count_actual + 1;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow(intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Sub Total");
					cell.setCellStyle(borderstyleright);
					
					region = CellRangeAddress.valueOf("A"+rows_count_actual+":AG"+rows_count_actual); 
					sheet.addMergedRegion(region);
					intCellCount=33;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal1));
					cell.setCellStyle(borderstyleright);
					
				}
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^NPA");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			log.info("NPA Report Location ======"+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				hshresult.put("FileName","NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	
//=======================================added for NPA Report==============================================//
	
	public HashMap getNpaProvisioningReport(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord=new HashMap();
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strGen="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		ResultSet rs1 = null;
		String strExe_Sno=Helper.correctInt((String)hshValues.get("hid_execsno"));
		String strnpaorg=Helper.correctInt((String)hshValues.get("npaorg")).substring(0, 6);
		try
		{
			int i=0;
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report1^"+strExe_Sno+"^"+strnpaorg+"^"+strExe_Sno+"^"+strnpaorg);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				i++;
				arrCol = new ArrayList();
				//arrCol.add(String.valueOf(i));
				arrCol.add(correctNull(rs.getString("ORG_SCODE")));//0
				arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
				arrCol.add(correctNull(rs.getString("region_code")));//2
				arrCol.add(correctNull(rs.getString("region_name")));//3
				arrCol.add(correctNull(rs.getString("CUST_NAME")));//4
				arrCol.add(correctNull(rs.getString("CUST_ID")));//5
				arrCol.add(correctNull(rs.getString("ACC_NO")));//6
				arrCol.add(correctNull(rs.getString("NORM_STATUS")));//7
				arrCol.add(correctNull(rs.getString("NPA_DATE")));//8
				arrCol.add(correctNull(rs.getString("OS_LIMIT")));//9
				arrCol.add(correctNull(rs.getString("UNREAL_INT_VAL")));//10
				arrCol.add(correctNull(rs.getString("OTHR_CHARGES")));//11
				arrCol.add(correctNull(rs.getString("netbal")));//12
				arrCol.add(correctNull(rs.getString("PROV_VALUE")));//13
				arrCol.add(correctNull(rs.getString("sec_assign")));//14
				arrCol.add(correctNull(rs.getString("unsecured")));//15
				arrCol.add(correctNull(rs.getString("partial_sec")));//16
				arrCol.add(correctNull(rs.getString("COVERAGE_VAL_SANC")));//17
				arrCol.add(correctNull(rs.getString("abinitio")));//18
				arrCol.add(correctNull(rs.getString("abinitio_date")));//19
				arrCol.add(correctNull(rs.getString("restructure")));//20
				arrCol.add(correctNull(rs.getString("restr_appr_date")));//21
				arrCol.add(correctNull(rs.getString("writeoff")));//22
				arrCol.add(correctNull(rs.getString("fraud_acc")));//23
				arrCol.add(correctNull(rs.getString("fraud_date")));//24
				arrCol.add(correctNull(rs.getString("security_type")));//26
				arrCol.add(correctNull(rs.getString("APP_SEC_SECID")));//27
				arrCol.add(correctNull(rs.getString("security_ownername")));//28
				arrCol.add(correctNull(rs.getString("banking_arrangement")));//29
				arrCol.add(correctNull(rs.getString("CUS_SEC_AMOUNT_CHARGED")));//31
				arrCol.add(correctNull(rs.getString("Collateral_type")));//32
				arrCol.add(correctNull(rs.getString("valuation_date")));//33
				arrCol.add(correctNull(rs.getString("CUS_SEC_NETSECURITY")));//34
				arrCol.add(correctNull(rs.getString("assignedsec")));//35
				arrCol.add(correctNull(rs.getString("PrimeVal")));//36
				arrRow.add(arrCol);
				
			}
			log.info("**************arrRow*********************"+arrRow);
			
			hshValues.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getNpaProvisioningReport ======= "+e.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshValues;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:July 11, 2014-12:00:00 PM
	 * @category to Import Financials Excel
	 * @return
	 * @
	 */
	public HashMap getExcelValues(HashMap hshRequestValues)
	{
		String strExp="";
		String strmsg="";
		String strCMAflag=Helper.correctNull((String)hshRequestValues.get("CMAflag"));
		String strFreezeflag=Helper.correctNull((String)hshRequestValues.get("CMAflag"));
		ResultSet rs1=null;
		ResultSet rs=null;
		try
		{
            byte[] byteData=(byte[])hshRequestValues.get("stream");
         	if(!strCMAflag.equalsIgnoreCase("SUCCESS"))
         	{
         		throw new Exception(strCMAflag);
         	}
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
				Workbook workbook = Workbook.getWorkbook(inputStream);
				String sheetnames[]=workbook.getSheetNames();
				HashMap hshRecord= new HashMap();
				ArrayList arrVal = new ArrayList();
				ArrayList arrCol = null;
				ArrayList arrYearStart = new ArrayList();
				ArrayList arrYear = new ArrayList();
				ArrayList arrType = new ArrayList();
				Sheet sheet = workbook.getSheet(0);
				int columns = sheet.getColumns();
				int rows = sheet.getRows();
				String strDivId=Helper.correctNull((String)hshRequestValues.get("strDivId"));
				if(strDivId.equals(""))
					strDivId="0";
				for(int row = 1;row < rows;row++)
				{
					arrCol=new ArrayList();
					for(int col = 0;col < columns;col++) 
		        	{
						if(row==1 && col>=3)
						{
							if(!sheet.getCell(col, row).getContents().trim().equals(""))
							{
				            	if(sheet.getCell(col, row).getType()==CellType.DATE)
				            	{
				            		arrYearStart.add(doChangeFormat(Helper.correctNull((String)sheet.getCell(col, row).getContents())));
				            	}
				            	else
				            	{
				            		strExp="$Not a Valid Sheet.......Please Check Financial Date Values";
				            		throw new Exception(strExp);
				            	}
							}
						}
						else if(row==2 && col>=3)
						{
							if(!sheet.getCell(col, row).getContents().trim().equals(""))
							{
								if(sheet.getCell(col, row).getType()==CellType.DATE)
								{
									arrYear.add(doChangeFormat(Helper.correctNull((String)sheet.getCell(col, row).getContents())));
								}
								else
								{
									strExp="$Not a Valid Sheet.......Please Check Financial Date Values";
									throw new Exception(strExp);
								}
							}
						}
						else if(row==3 && col>=3)
			            {
			            	if(!sheet.getCell(col, row).getContents().trim().equals(""))
			            	{
				            	if(sheet.getCell(col, row).getType()==CellType.LABEL)
				            	{
				            		String strFintype=sheet.getCell(col, row).getContents().trim();
				            		if(strFintype.equalsIgnoreCase("audited") || strFintype.equalsIgnoreCase("unaudited") ||
				            				strFintype.equalsIgnoreCase("estimated") || strFintype.equalsIgnoreCase("projection"))
				            		{
				            			arrType.add(Helper.correctNull((String)sheet.getCell(col, row).getContents()));
				            		}
				            		else
				            		{
				            			strExp="$Not a Valid Sheet.......Please Check Financial Type Values";
					            		throw new Exception(strExp);
				            		}
				            	}
				            	else
				            	{
				            		strExp="$Not a Valid Sheet.......Please Check Financial Type Values";
				            		throw new Exception(strExp);
				            	}
			            	}
			            }
						else if(row>3)
			            {
							if(col<=4)
							{
								arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
							}
							else
			            	{
			            		if(sheet.getCell(col, row).getType()==CellType.NUMBER)
				            	{
				            		arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
				            	}
				            	else
				            	{
				            		arrCol.add("0.00");
				            	}
			            	}
			            }
		        	}
					arrVal.add(arrCol);
		        }
				/*For Financial same year*/
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				String strfintype="";
				String strquery="",strQuery="";
				String appno=Helper.correctNull((String)hshRequestValues.get("hidfinid"));
				String sno="";
				int count=0;
				if(arrYear!=null && arrType!=null && arrYear.size()>0 &&  arrType.size()>0)
				{
					//to check whether entry for particular Application in Year table
					strQuery = SQLParser.getSqlQuery("sel_count_year^"+appno+"^"+strDivId);
					rs=DBUtils.executeQuery(strQuery);
				    if(rs.next())
					{ 
				    	count=Integer.parseInt(rs.getString("cnt"));
					}	
				    if(count>0)
				    {
				    
//				    	hshQueryValues.put("size","1");
//				    	arrValues.add(appno);	
//				       	arrValues.add(strDivId);
//					    hshQuery.put("strQueryId","del_year_corp");
//					    hshQuery.put("arrValues",arrValues);
//				        hshQueryValues.put("1",hshQuery);
//					    EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				    	
					}
					for(int i=0;i<arrYear.size();i++)
					{
						int intUpdatesize=0;					
						hshQueryValues=new HashMap();
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						strfintype=Helper.correctNull((String)arrType.get(i));
						
						//to generate Sno Automatically
						strQuery = SQLParser.getSqlQuery("per_finayear_maxid^"+appno);
					    if(rs!=null)
					    	rs.close();
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
						}
						arrValues.add(appno);
						arrValues.add(Helper.correctNull((String)arrYear.get(i)));
					
						arrValues.add(strfintype);
						arrValues.add(strDivId);
						arrValues.add(Helper.correctNull((String)arrYearStart.get(i)));
						hshQuery.put("strQueryId","corp_year_insert");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				    	
					}
				}
				hshRecord.put("sheetno","1");
				hshRecord.put("appno",Helper.correctNull((String)hshRequestValues.get("hidfinid")));
				hshRecord.put("arrVal",arrVal);
				hshRecord.put("arrType",arrType);
				hshRecord.put("arrYear",arrYear);
				hshRecord.put("strFreezeflag",strFreezeflag);
				hshRecord.put("strDivId",Helper.correctNull((String)hshRequestValues.get("sel_divID")));
				log.info("insertFinancialValues @@@@@@@@@@ input @@@@@@@@@@"+arrVal);
				log.info("insertFinancialValues @@@@@@@@@@ input total hshrecord @@@@@@@@@@"+hshRecord);
				insertFinancialValues(hshRecord);
				log.info("insertFinancialValues @@@@@@@@@@ end");
				//insertFinancialDesc(hshRecord);
				log.info("insertFinancialDesc @@@@@@@@@@ end");
				for(int i=1;i<sheetnames.length;i++)
				{
					hshRecord=new HashMap();
					arrVal= new ArrayList();
					arrCol= new ArrayList();
					sheet = workbook.getSheet(i);
					columns = sheet.getColumns();
					rows = sheet.getRows();
					for(int row = 1;row < rows;row++)
					{
						arrCol=new ArrayList();
						for(int col = 0;col < columns;col++) 
			        	{
								if(row>3)
								{
									if(col<=4)
									{
										arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
									}
									else
					            	{
					            		if(sheet.getCell(col, row).getType()==CellType.NUMBER)
						            	{
						            		arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
						            	}
						            	else
						            	{
						            		arrCol.add("0.00");
						            	}
					            	}
								}
			        	}
						arrVal.add(arrCol);
					}
					hshRecord.put("sheetno",Integer.toString(i+1));
					hshRecord.put("appno",Helper.correctNull((String)hshRequestValues.get("hidfinid")));
					hshRecord.put("arrVal",arrVal);
					hshRecord.put("arrType",arrType);
					hshRecord.put("arrYear",arrYear);
					hshRecord.put("strDivId",Helper.correctNull((String)hshRequestValues.get("strDivId")));
					log.info("insertFinancialValues @@@@@@@@@@ input @@@@@@@@@@"+arrVal);
					log.info("insertFinancialValues @@@@@@@@@@ input total hshrecord @@@@@@@@@@"+hshRecord);
					insertFinancialValues(hshRecord);
					log.info("insertFinancialValues @@@@@@@@@@ end");
					//insertFinancialDesc(hshRecord);
					log.info("insertFinancialDesc @@@@@@@@@@ end");
					strmsg="Successfully Uploaded!!!!";
					hshRequestValues.put("msg",strmsg);
				}
            }
            else
            {
            	strExp="$Select the Valid Excel Sheet to Upload!!";
            	throw new Exception(strExp);
            }
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new EJBException(e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshRequestValues;
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:July 11, 2014-02:00:00 PM
	 * @category Financial Values Insertion/updation
	 * @return
	 * @
	 */
	private void insertFinancialValues(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrCol=null;
		int intValue=0;
		ArrayList arrYear  = (ArrayList)hshValues.get("arrYear");
		ArrayList arrType  = (ArrayList)hshValues.get("arrType");
		ArrayList arrVal  = (ArrayList)hshValues.get("arrVal");
		String strSheetno=Helper.correctNull((String)hshValues.get("sheetno"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strDivId=Helper.correctNull((String)hshValues.get("strDivId"));
		String strFreezeflag=Helper.correctNull((String)hshValues.get("strFreezeflag"));
		String strExp="",strCount1="";
		if(strDivId.equalsIgnoreCase(""))
		{
			strDivId="0";
		}
		try
		{
			HashMap hshQueryValues;
			HashMap hshQuery;
			ArrayList arrValues;
			String strfintype="";
			String strCount="";
			if(strSheetno.equalsIgnoreCase("1"))
			{
				strQuery = SQLParser.getSqlQuery("finselect1^"+strAppno+"^"+strDivId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCount=Helper.correctNull((String)rs.getString("cnt"));
				}
				strQuery = SQLParser.getSqlQuery("sel_com_finappdesc^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCount1=Helper.correctNull((String)rs.getString("cnt"));
				}
				if(!strCount.equalsIgnoreCase("0") || !strCount1.equalsIgnoreCase("0") )
				{
//					hshQueryValues=new HashMap();
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					hshQuery.put("strQueryId","delFinancial");
//					arrValues.add(strAppno);
//					hshQuery.put("arrValues",arrValues);
//					hshQueryValues.put("size","2");
//					hshQueryValues.put("1",hshQuery);
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					hshQuery.put("strQueryId","finappdescdel");
//					arrValues.add(strAppno);
//					hshQuery.put("arrValues",arrValues);
//					hshQueryValues.put("2",hshQuery);
//					
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			if(arrYear!=null && arrType!=null && arrYear.size()>0 &&  arrType.size()>0)
			{
				for(int i=0;i<arrYear.size();i++)
				{
					int intUpdatesize=0;					
					hshQueryValues=new HashMap();
					for(int k=4;k<arrVal.size();k++)
					{
						strfintype=Helper.correctNull((String)arrType.get(i));
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappvaluesins");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull((String)arrYear.get(i)));
						String yearselect=Helper.correctNull((String)arrYear.get(i));
						arrCol = (ArrayList)arrVal.get(k);
						arrValues.add(Helper.correctNull((String)arrCol.get(0)));
						if(strfintype.equalsIgnoreCase("audited"))
						{
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("unaudited"))
						{
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("estimated"))
						{
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("projection"))
						{
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
						}
						arrValues.add(strDivId);
						strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"+strAppno+"^"+strDivId+"^"+strfintype+"^"+yearselect);				
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrValues.add(Helper.correctNull(rs.getString("com_sno")));
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				if(arrYear!=null && arrYear.size()>0)
				{
					strExp="$Please check the Financial Date";
	        		throw new Exception(strExp);
				}
				else
				{
					strExp="$Please check the Financial Type";
	        		throw new Exception(strExp);
				}
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in insertFinancialValues " + exception.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:July 11, 2014-12:00:00 PM
	 * @category Financial Description Insertion/Updation
	 * @return
	 * @
	 */
	private void insertFinancialDesc(HashMap hshValues)
	{
		ResultSet rs=null;
		try
		{
			String strQuery="";
			ArrayList arrFinRowID=new ArrayList();
			ArrayList arrCol=new ArrayList();
			ArrayList arrVal  = (ArrayList)hshValues.get("arrVal");
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("com_finvalues_selectbydesc^"+strAppno);
	    	rs= DBUtils.executeQuery(strQuery);
	    	while(rs.next())
	    	{
	    		arrFinRowID.add(Helper.correctNull(rs.getString("fin_rowid")));
	    	}
	    	int intUpdatesize=0;					
			HashMap hshQueryValues=new HashMap();
			HashMap hshQuery=new HashMap();
			ArrayList arrValues=new ArrayList();
			int j=0;
			for(j=0;j<arrFinRowID.size();j++)
			{
		    	for(int i=3;i<arrVal.size();i++)
		    	{
		    		arrCol = (ArrayList)arrVal.get(i);
		    		if(Helper.correctNull((String)arrFinRowID.get(j)).equalsIgnoreCase(Helper.correctNull((String)arrCol.get(0))))
		    		{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappdescins");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull((String)arrCol.get(0)));
						arrValues.add(Helper.correctNull((String)arrCol.get(2)));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						break;
		    		}
		    	}
			 }
			 if(hshQueryValues!=null && hshQueryValues.size()>0)
	    	 {
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	    	 }
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in insertFinancialDesc " + exception.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
	}
	private String doChangeFormat(String strDate)
	{
		String date="";
		date=strDate.substring(0,2)+"/"+strDate.substring(3,5)+"/"+strDate.substring(6,10);
		return date;
	}
	public String getMaxInwardno(String strSolid)
	{
		String strQuery="";
		ResultSet rs = null;
		String strInwardno = "";
		String strFinancialYear="";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selfinancialyear");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
				strFinancialYear=strFinancialYear.substring(2,4);
			}
			if(rs !=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getmaxinwardno");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strInwardno = strSolid +strFinancialYear+ rs.getString(1) ;				
			}
			if(rs != null)rs.close();
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getMaxAckId "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return strInwardno;
	}
	public HashMap getFreezedExcelValues(HashMap hshRequestValues)
	{
		String strExp="";
		String strmsg="";
		String strCMAflag=Helper.correctNull((String)hshRequestValues.get("CMAflag"));
		String strFreezeflag=Helper.correctNull((String)hshRequestValues.get("CMAflag"));
		int colsize=0;
		ResultSet rs1=null;
		ResultSet rs=null;
		try
		{
            byte[] byteData=(byte[])hshRequestValues.get("stream");
         	if(!strCMAflag.equalsIgnoreCase("SUCCESS"))
         	{
         		throw new Exception(strCMAflag);
         	}
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
				Workbook workbook = Workbook.getWorkbook(inputStream);
				String sheetnames[]=workbook.getSheetNames();
				HashMap hshRecord= new HashMap();
				ArrayList arrVal = new ArrayList();
				ArrayList arrCol = null;
				ArrayList arrYear = new ArrayList();
				ArrayList arrType = new ArrayList();
				Sheet sheet = workbook.getSheet(0);
				int columns = sheet.getColumns();
				int rows = sheet.getRows();
				String strDivId=Helper.correctNull((String)hshRequestValues.get("strDivId"));
				if(strDivId.equals(""))
					strDivId="0";
				for(int row = 1;row < rows;row++)
				{
					arrCol=new ArrayList();
					colsize=3;
					for(int col = 0;col < columns;col++) 
		        	{
						if(row==1 && col>=3)
						{
							if(!sheet.getCell(col, row).getContents().trim().equals(""))
							{
								String strFintype=sheet.getCell(col, 2).getContents().trim();
			            		if(strFintype.equalsIgnoreCase("unaudited") ||
			            				strFintype.equalsIgnoreCase("estimated") || strFintype.equalsIgnoreCase("projection"))
			            		{
				            	if(sheet.getCell(col, row).getType()==CellType.DATE)
				            	{
				            		arrYear.add(doChangeFormat(Helper.correctNull((String)sheet.getCell(col, row).getContents())));
				            	}
				            	
			            		}
				            	else
				            	{
				            		if(!strFintype.equalsIgnoreCase("audited"))
				            		{
				            		strExp="$Not a Valid Sheet.......Please Check Financial Date Values";
				            		throw new Exception(strExp);
				            		}
				            	}
							}
						}
						else if(row==2 && col>=3)
			            {
			            	if(!sheet.getCell(col, row).getContents().trim().equals(""))
			            	{
				            	if(sheet.getCell(col, row).getType()==CellType.LABEL)
				            	{
				            		String strFintype=sheet.getCell(col, row).getContents().trim();
				            		if(strFintype.equalsIgnoreCase("unaudited") ||
				            				strFintype.equalsIgnoreCase("estimated") || strFintype.equalsIgnoreCase("projection"))
				            		{
				            			arrType.add(Helper.correctNull((String)sheet.getCell(col, row).getContents()));
				            		}
				            		else
				            		{
				            			if(!strFintype.equalsIgnoreCase("audited"))
				            			{
				            			strExp="$Not a Valid Sheet.......Please Check Financial Type Values";
					            		throw new Exception(strExp);
				            			}
				            		}
				            	}
				            	else
				            	{
				            		strExp="$Not a Valid Sheet.......Please Check Financial Type Values";
				            		throw new Exception(strExp);
				            	}
			            	}
			            }
						else if(row>2)
			            {
							if(col<=2)
							{
								arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
							}
							else
			            	{
								
								String strFintype=sheet.getCell(colsize, 2).getContents().trim();
			            		if(sheet.getCell(col, row).getType()==CellType.NUMBER)
				            	{
			            			if(strFintype.equalsIgnoreCase("") || strFintype.equalsIgnoreCase("unaudited") ||
				            				strFintype.equalsIgnoreCase("estimated") || strFintype.equalsIgnoreCase("projection"))
				            		{
				            		
				            		
				            		arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
				            		}
				            	}
			            		else
			            		{
			            			arrCol.add("0.00");	
			            		}
			            									
								
			            		
						if(colsize!=34)
			            		colsize=colsize+1;
			            	}
			            }
		        	}
					arrVal.add(arrCol);
		        }
				/*For Financial same year*/
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				String strfintype="";
				String strquery="",strQuery="";
				String appno=Helper.correctNull((String)hshRequestValues.get("hidfinid"));
				String sno="";
				int count=0;
				if(arrYear!=null && arrType!=null && arrYear.size()>0 &&  arrType.size()>0)
				{
					//to check whether entry for particular Application in Year table
					strQuery = SQLParser.getSqlQuery("sel_count_year^"+appno+"^"+strDivId);
					rs=DBUtils.executeQuery(strQuery);
				    if(rs.next())
					{ 
				    	count=Integer.parseInt(rs.getString("cnt"));
					}	
				    if(count>0)
				    {
				    
				    	hshQueryValues.put("size","1");
				    	arrValues.add(appno);	
				       	arrValues.add(strDivId);
					    hshQuery.put("strQueryId","del_year_corp_audit");
					    hshQuery.put("arrValues",arrValues);
				        hshQueryValues.put("1",hshQuery);
					    EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				    	
					}
					for(int i=0;i<arrYear.size();i++)
					{
						int intUpdatesize=0;					
						hshQueryValues=new HashMap();
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						strfintype=Helper.correctNull((String)arrType.get(i));
						
						//to generate Sno Automatically
						strQuery = SQLParser.getSqlQuery("per_finayear_maxid^"+appno);
					    if(rs!=null)
					    	rs.close();
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrValues.add(Helper.correctNull(rs.getString("snorelmax")));
						}
						arrValues.add(appno);
						arrValues.add(Helper.correctNull((String)arrYear.get(i)));
					
						arrValues.add(strfintype);
						arrValues.add(strDivId);
						hshQuery.put("strQueryId","corp_year_insert");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				    	
					}
				}
				hshRecord.put("sheetno","1");
				hshRecord.put("appno",Helper.correctNull((String)hshRequestValues.get("hidfinid")));
				hshRecord.put("arrVal",arrVal);
				hshRecord.put("arrType",arrType);
				hshRecord.put("arrYear",arrYear);
				hshRecord.put("strFreezeflag",strFreezeflag);
				hshRecord.put("strDivId",Helper.correctNull((String)hshRequestValues.get("sel_divID")));
				log.info("insertFinancialValues @@@@@@@@@@ input @@@@@@@@@@"+arrVal);
				log.info("insertFinancialValues @@@@@@@@@@ input total hshrecord @@@@@@@@@@"+hshRecord);
				insertFinancialFreezedValues(hshRecord);
				log.info("insertFinancialValues @@@@@@@@@@ end");
				//insertFinancialDesc(hshRecord);
				log.info("insertFinancialDesc @@@@@@@@@@ end");
				for(int i=1;i<sheetnames.length;i++)
				{
					hshRecord=new HashMap();
					arrVal= new ArrayList();
					arrCol= new ArrayList();
					sheet = workbook.getSheet(i);
					columns = sheet.getColumns();
					rows = sheet.getRows();
					for(int row = 1;row < rows;row++)
					{
						colsize=3;
						arrCol=new ArrayList();
						for(int col = 0;col < columns;col++) 
			        	{
							if(row>2)
				            {
								if(col<=2)
								{
									arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
								}
								else
				            	{
									
									String strFintype=sheet.getCell(colsize, 2).getContents().trim();
				            		if(sheet.getCell(col, row).getType()==CellType.NUMBER)
					            	{
				            			if(strFintype.equalsIgnoreCase("") || strFintype.equalsIgnoreCase("unaudited") ||
					            				strFintype.equalsIgnoreCase("estimated") || strFintype.equalsIgnoreCase("projection"))
					            		{
					            		
					            		
					            		arrCol.add(Helper.correctNull(sheet.getCell(col, row).getContents()));
					            		}
					            	}
				            		else
				            		{
				            			arrCol.add("0.00");	
				            		}
				            									
									
				            		
							if(colsize!=34)
				            		colsize=colsize+1;
				            	}
				            }
			        	}
						arrVal.add(arrCol);
			        
					}
					hshRecord.put("sheetno",Integer.toString(i+1));
					hshRecord.put("appno",Helper.correctNull((String)hshRequestValues.get("hidfinid")));
					hshRecord.put("arrVal",arrVal);
					hshRecord.put("arrType",arrType);
					hshRecord.put("arrYear",arrYear);
					hshRecord.put("strDivId",Helper.correctNull((String)hshRequestValues.get("strDivId")));
					log.info("insertFinancialValues @@@@@@@@@@ input @@@@@@@@@@"+arrVal);
					log.info("insertFinancialValues @@@@@@@@@@ input total hshrecord @@@@@@@@@@"+hshRecord);
					insertFinancialFreezedValues(hshRecord);
					log.info("insertFinancialValues @@@@@@@@@@ end");
					//insertFinancialDesc(hshRecord);
					log.info("insertFinancialDesc @@@@@@@@@@ end");
					strmsg="Successfully Uploaded!!!!";
					hshRequestValues.put("msg",strmsg);
				}
            }
            else
            {
            	strExp="$Select the Valid Excel Sheet to Upload!!";
            	throw new Exception(strExp);
            }
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new EJBException(e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshRequestValues;
	}
	public HashMap getExcelData(HashMap hshRequestValues)
	{
        boolean Availpan=false;
        boolean validpan=false;
		Connection con = null;
		HashMap hshQuery=null;
		PreparedStatement pstmt = null;
		Connection connectionORC = null;
		CallableStatement callableStmt2 = null;
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null;
		int intLen=0,count=1;
		long longAppno=0;
		String strQuery = "",strExp = "",strCustId = "",strBankId = "",strChargeID = "",strPan = "",strMandstaus = "",strAppNoval="",strPanvalid="";
		String strCBSID = "", strName="",strAppNo="",strOrgSCode="",strPanApp="",strInwardno="",strAppId="",strsancamt="",strAppIdval="",strExAppNo="";
		String strCOAPPCBSID= "",strCOGUARAppId= "",strDUMMYAPPID="0",strloanamount="",strprdcode="",strIntrest="",strInttype="";
		String struserid=Helper.correctNull((String)hshRequestValues.get("strUserId"));
		String strOrgShortCode=Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
		String strOrgCode=Helper.correctNull((String)hshRequestValues.get("strOrgCode"));
		String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("strOrgLevel"));
		String strSolid=correctNull((String)hshRequestValues.get("strSolid"));//Added by Mohan
		String strShortCode=Helper.correctNull((String)hshRequestValues.get("strOrgShortCode"));
		double dblMarketRate=0.0,dblBankRate=0.0,dblMCLRValue=0.0;
		int appterms=0;
		String strMCLRValueType="",strMCLRValueTableCode="",strDummy="";
		
		StringBuilder strExcelColumnName=new StringBuilder();
		
		ArrayList ArrExcelScreenno=new ArrayList();
		ArrayList ArrExcelScreenID=new ArrayList();
		ArrayList ArrExcelType=new ArrayList();
		ArrayList ArrExcelTableName=new ArrayList();
		ArrayList ArrExcelSheetno=new ArrayList();
		ArrayList ArrExcelColnum=new ArrayList();
		ArrayList ArrExcelRownum=new ArrayList();
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try
		{
			String strdate=Helper.getCurrentDateTime();//Added by Mohan 
		    byte[] byteData=(byte[])hshRequestValues.get("stream");
	        if(byteData!=null)
	        {
	        	con = ConnectionFactory.getConnection();
	        	ByteArrayInputStream byInputStream = new ByteArrayInputStream(byteData);
				Workbook workbook = Workbook.getWorkbook(byInputStream);
				java.text.NumberFormat nf=java.text.NumberFormat.getNumberInstance();
				nf.setMinimumIntegerDigits(7);
				nf.setGroupingUsed(false);
				hshRequestValues.put("struserid",struserid);
			  // Added for APPID generation before uploading demographics
				HashMap map=new HashMap();
				HashMap hshappno=new HashMap();
				HashMap hshlapId=new HashMap();
				HashMap hshlapsOldId=new HashMap();
				HashMap hshInwardNo=new HashMap();
				HashMap hshIntrest=new HashMap();
				HashMap hshcoapplapsId=new HashMap(); 
				HashMap hshcoappoldlapsId=new HashMap(); 
				HashMap hshInttype=new HashMap();
				HashMap hshPrdCode=new HashMap();
				HashMap hshCRPVal=new HashMap();
				HashMap hshBSPVal=new HashMap();
				HashMap hshBaseRate=new HashMap();
				
				ArrayList arrRow=new ArrayList();
				ArrayList arrCol=new ArrayList();
				ArrayList arrcbsid=new ArrayList();
				ArrayList arrApp=new ArrayList();
//				ArrayList ArrCBSValid=new ArrayList();
				ArrayList ArrAppid=new ArrayList();
				
				ArrayList arrTerms=new ArrayList();
				ArrayList arrTermsId=new ArrayList();
				ArrayList arrTermsType=new ArrayList(); 
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selgoldratevalue");
	 			rs = DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				dblMarketRate=Double.parseDouble(Helper.correctDouble(rs.getString("per_goldrate")));
	 				dblBankRate=Double.parseDouble(Helper.correctDouble(rs.getString("per_avg_rate")));
	 			}
	 			if(rs!=null)
					rs.close();
	 			strQuery=SQLParser.getSqlQuery("getyearlymclrvalue");
	 			rs = DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				strMCLRValueType=Helper.correctNull(rs.getString("MCLR_TYPE"))+'@'+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+'@'+Helper.correctNull(rs.getString("MCLR_TABLECODE"));
	 				strMCLRValueTableCode=Helper.correctNull(rs.getString("MCLR_TABLECODE"));
	 				dblMCLRValue=Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD")));
	 			}
	 			if(rs!=null)
	 				rs.close();
			 // EXCEL SHEET VALIDATION 
				strBankId=Helper.correctNull((String)workbook.getSheet(1).getCell(0,99).getContents());
				if(strBankId.equals("KBLGOLDDEP"))
				{
					//EXCEL MANDATORY VALIDATION
					//strMandstaus=Helper.correctNull((String)workbook.getSheet(0).getCell(5,8).getContents());
				//	if(strMandstaus.equals("READY TO UPLOAD"))
				//	{	
					
					
					strOrgShortCode = strOrgShortCode.trim();
					int scodeLength = strOrgShortCode.length();
					if (strOrgShortCode.equals("")) {
						strExp = strExp+ "There is no organisation attached with user";
						throw new Exception(strExp);
					} else {
						if(scodeLength==1){
							strOrgShortCode="000"+strOrgShortCode;
						}
						if(scodeLength==2){
							strOrgShortCode="00"+strOrgShortCode;
						}
						if(scodeLength==3){
							strOrgShortCode="0"+strOrgShortCode;
						}
					}
					intLen = strOrgShortCode.length();
					strQuery=SQLParser.getSqlQuery("getAppno^"+(intLen+1)+"^"+intLen+"^"+strOrgShortCode);
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						longAppno=(rs1.getLong(1));
					}
					
					
				HashMap hshRef=new HashMap();
				HashMap hshCBSID=new HashMap();
				HashMap hshJLPrdCode=new HashMap();
				HashMap hshJLLoanAmt=new HashMap();
				ArrayList arrRef=new ArrayList();
				
				for(int loop=2;loop<32;loop++)
				{
					if(!(Helper.correctNull((String) workbook.getSheet(1).getCell(21, loop).getContents())).equalsIgnoreCase(""))
					{
						arrRef.add(Helper.correctNull((String) workbook.getSheet(1).getCell(21, loop).getContents()));
						hshCBSID.put((Helper.correctNull((String) workbook.getSheet(1).getCell(21, loop).getContents())),(Helper.correctNull((String) workbook.getSheet(1).getCell(1, loop).getContents())) );
					}
				}
				
				for (int i=2;i<32;i++)
				{
					if(!(Helper.correctNull((String) workbook.getSheet(2).getCell(16, i).getContents())).equalsIgnoreCase(""))
					{
						hshJLPrdCode.put((Helper.correctNull((String) workbook.getSheet(2).getCell(16, i).getContents())), (Helper.correctNull((String) workbook.getSheet(2).getCell(17, i).getContents())));
						hshJLLoanAmt.put((Helper.correctNull((String) workbook.getSheet(2).getCell(16, i).getContents())), (Helper.correctNull((String) workbook.getSheet(2).getCell(4, i).getContents())));
					}
				}
				
				if(arrRef!=null && arrRef.size()>0)
				{
					for(int j=0;j<arrRef.size();j++)
					{
						if(rs!=null)
							rs.close();
						strPan=Helper.correctNull((String)arrRef.get(j));
						strCBSID=Helper.correctNull((String)hshCBSID.get(strPan));
						strQuery=SQLParser.getSqlQuery("Excel_Cbsidcheck^"+strCBSID);
			 			rs = DBUtils.executeQuery(strQuery);
			 			if(rs.next())
			 			{
			 				if(Helper.correctNull(rs.getString("perapp_profilestatus")).equalsIgnoreCase("Y"))
			 				{
			 					strAppId=Helper.correctNull(rs.getString("perapp_id"));
			 					strInwardno=getMaxInwardno(strSolid);
			 					ArrAppid.add(strAppId);
			 					hshlapId.put(strPan,strAppId);
			 					hshlapsOldId.put(strPan,Helper.correctNull(rs.getString("perapp_oldid")));
			 					hshInwardNo.put(strAppId,strInwardno);
			 					
			 					strloanamount = Helper.correctNull((String)hshJLLoanAmt.get(strPan));
					    	    strprdcode = Helper.correctNull((String)hshJLPrdCode.get(strPan));
					    	    strQuery=SQLParser.getSqlQuery("excelintrestratecal^"+strprdcode+"^"+strloanamount+"^"+strprdcode);
								if(rs1 != null)
								{
									rs1.close();
								}
					 			rs1 = DBUtils.executeQuery(strQuery);
					 			if(rs1.next())
					 			{
					 				strInttype=Helper.correctNull(rs1.getString("prdint_inttype"));
						 			if(strInttype.equalsIgnoreCase("floating"))
						 			{
						 				strInttype="Floating";
						 				strIntrest=String.valueOf(Double.parseDouble(Helper.correctDouble(rs1.getString("prd_creditrskpremium")))+Double.parseDouble(Helper.correctDouble(rs1.getString("prd_busstrategicpremium")))+dblMCLRValue);
						 				hshCRPVal.put(strPan,Helper.correctDouble(rs1.getString("prd_creditrskpremium")));
						 				hshBSPVal.put(strPan,Helper.correctDouble(rs1.getString("prd_busstrategicpremium")));
						 				hshBaseRate.put(strPan,Helper.correctDouble(rs1.getString("prd_interestid")));
						 			}
						 			else if(strInttype.equalsIgnoreCase("fixed"))
						 			{
						 				strInttype="Fixed";
						 				strIntrest=Helper.correctNull(rs1.getString("prd_interest"));
						 				hshBaseRate.put(strPan,Helper.correctDouble(rs1.getString("prd_interestid")));
						 			}
						 			else
						 			{
						 				strIntrest="0";
						 				strInttype="0";
						 				hshBaseRate.put(strPan,"0");
						 			}
						 			
						 			hshIntrest.put(strPan,strIntrest);
						 			hshInttype.put(strPan,strInttype);
						 			
						 			longAppno = (longAppno)+count;
						 			strAppNo = strOrgShortCode + nf.format(longAppno);
					 			}
					 			else
								{
									strAppNo="Not selected in Loan product sheet";
							    }
					 			
			 				}
			 				else
			 				{
			 					strInwardno="Customer Id Not Completed in Laps";
			 					strAppNo=strInwardno;
			 				}
			 			}
			 			else
			 			{
			 				strInwardno="Customer Id Not Available in Laps";
			 				strAppNo=strInwardno;
			 			}
			 			
			 			arrRow.add(strInwardno);
						arrCol.add(Helper.correctNull((String)hshCBSID.get(strPan)));
						map.put(strPan, strInwardno);
						arrApp.add(strAppNo);
						hshappno.put(strPan, strAppNo);
						hshPrdCode.put(strPan, strprdcode);
					}
				}
				
				hshRequestValues.put("arrval1",arrCol);
				hshRequestValues.put("arrval2",arrRow);
				hshRequestValues.put("arrval3",arrApp);
				
				
				//For converting CBSID to LAPS ID 
				
				for(int loop=2;loop<92;loop++)
				{
					strCOAPPCBSID= Helper.correctNull((String) workbook.getSheet(6).getCell(2, loop).getContents());
					if(!strCOAPPCBSID.equalsIgnoreCase(""))
					{
					strQuery=SQLParser.getSqlQuery("Excel_Cbsidcheck^"+strCOAPPCBSID);
					if(rs != null)
					{
						rs.close();
					}
		 			rs = DBUtils.executeQuery(strQuery);
		 			if(rs.next())
		 			{
		 				if(Helper.correctNull((String)rs.getString("perapp_profilestatus")).equalsIgnoreCase("Y"))
		 				{
		 					strCOGUARAppId=Helper.correctNull(rs.getString("perapp_id"));
		 					hshcoappoldlapsId.put(strCOAPPCBSID, Helper.correctNull(rs.getString("perapp_oldid")));
		 				}
		 			}
		 			else
	 				{
	 					strCOGUARAppId=strDUMMYAPPID;
	 				}
		 			hshcoapplapsId.put(strCOAPPCBSID, strCOGUARAppId);
				  }
			   } 
					
	           	
			  	    //Dynamic Excel upload added by Midhun Vijay
					hshQuery=new HashMap();
					String strTabname="";	
			        String strColname="";	
			        String strContent="";
			        String strTableColumnId="";
			        String strType="";
			        String strSplit[]=null;
			        String strQuery1="";
			        String strNULLchk="";
			        String strTableId="";
			        String strTablesheetno="";
			        String strexctype="";
				    String strSeqID="";
				        			        
			        int col;
			        int row;
			        int maxNoofSheets;
			        int result=0;
			        int rows_in_a_sheet = 1;
			        int intsheetno = 1;
			        
			        long t3=0;
			        
					rs = DBUtils.executeQuery(SQLParser.getSqlQuery("excel_tot_max"));
					if(rs.next())
					{
						maxNoofSheets = rs.getInt("maxscreenid");	
					}
					else
					{
						maxNoofSheets = 0;
					}
					 if(rs != null)
					 {
						rs.close();
					 }
				 		for(int i=1;i <= maxNoofSheets ;i++)
				 		{
				 			// Multi Entry  
				 			strQuery1=SQLParser.getSqlQuery("excel_screensno_ref^"+i);
				 			rs = DBUtils.executeQuery(strQuery1);

							
				 			if(rs.next())
				 			{
				 				rows_in_a_sheet = rs.getInt("EXC_ENTRY");					 				
				 			}
				 			else
				 			{
				 				rows_in_a_sheet = 0;
				 			}
				 			if(rs != null)
				 			{
				 				rs.close();
				 			}
				 		    	innerloop: 									
				 				for(int m=0;m < rows_in_a_sheet; m++ )
				 				{
				 					double dblEstGoldRate=0.0,dblEstBankRate=0.0,dblEstMarketRate=0.0,dblNetWeight=0.0;
				 					
				 					strExcelColumnName=new StringBuilder();
				 					ArrExcelScreenno=new ArrayList();
				 					ArrExcelScreenID=new ArrayList();
				 					ArrExcelType=new ArrayList();
				 					ArrExcelTableName=new ArrayList();
				 					ArrExcelSheetno=new ArrayList();
				 					ArrExcelColnum=new ArrayList();
				 					ArrExcelRownum=new ArrayList();
				 					
				 					boolean booltermsflag=true;
				 					if(rs1!=null)
				 						rs1.close();
				 					
										strQuery=SQLParser.getSqlQuery("excel_screen_ref^"+i);
					 					rs1 = DBUtils.executeQuery(strQuery);
					 				while(rs1.next())
				 					{	
					 					
					 					strExcelColumnName.append(Helper.correctNull(rs1.getString("EXC_COLNAME"))).append(",");
					 					
					 					ArrExcelScreenno.add(Helper.correctNull(rs1.getString("EXC_SCREEN_SNO")));
					 					ArrExcelScreenID.add(Helper.correctNull(rs1.getString("EXC_SCREEN_ID")));
					 					ArrExcelType.add(Helper.correctNull(rs1.getString("EXC_TYPE")));
					 					ArrExcelTableName.add(Helper.correctNull(rs1.getString("EXC_TABNAME")));
					 					ArrExcelSheetno.add(Helper.correctNull(rs1.getString("EXC_SHEET_NO")));
					 					ArrExcelColnum.add(Helper.correctNull(rs1.getString("EXC_COLNUM")));
					 					ArrExcelRownum.add(Helper.correctNull(rs1.getString("EXC_ROWNUM")));
					 					
					 					
				 					}
					 				if(strExcelColumnName.length()>1)
					 					strExcelColumnName.deleteCharAt(strExcelColumnName.length()-1);
					 				
					 					if(ArrExcelScreenno!=null && ArrExcelScreenno.size()>0)
					 					{
					 						for(int x=0;x<ArrExcelScreenno.size();x++)
					 						{
					 							strTableColumnId = Helper.correctNull((String)ArrExcelScreenno.get(x));
						 						strTableId=Helper.correctNull((String)ArrExcelScreenID.get(x));
						 						strexctype=Helper.correctNull((String)ArrExcelType.get(x));
						 						strTablesheetno=Helper.correctNull((String)ArrExcelSheetno.get(x));
						 						intsheetno = Integer.parseInt(strTablesheetno);
						 						Sheet sheet = workbook.getSheet(intsheetno);
						 						
						 						col=Integer.parseInt(Helper.correctInt((String)ArrExcelColnum.get(x)));
					 							
					 							if(m==0)
					 							{
					 								row=Integer.parseInt(Helper.correctInt((String)ArrExcelRownum.get(x)));
					 							}
					 							else
					 							{
					 								row=Integer.parseInt(Helper.correctInt((String)ArrExcelRownum.get(x)))+m;
					 							}	
						 							
						 						if(i==1 && (Helper.correctNull(sheet.getCell(1, row).getContents()).equalsIgnoreCase("")))
						 							continue innerloop;
						 						else if(i!=1 &&(Helper.correctNull(sheet.getCell(0, row).getContents()).equalsIgnoreCase("")))
						 							continue innerloop;
						 						
						 							
						 						if(strTableColumnId.equals("1"))
						 						{
						 							strTabname=Helper.correctNull((String)ArrExcelTableName.get(x));
						 									
						 							strType=Helper.correctNull((String)ArrExcelType.get(x));
						 							
						 							if(strType.equalsIgnoreCase("APPID"))
						 							{
						 							strInwardno=sheet.getCell(col, row).getContents();
						 							strInwardno=(String)map.get(strInwardno);
						 							if(strInwardno!=null){
						 							if(strInwardno.equals("Customer Id Not Completed in Laps")||
						 									strInwardno.equals("Customer Id Not Available in Laps")||
						 									strInwardno.equals("Not selected in Loan product sheet"))
							 							  	{
						 								    strInwardno="0";
						 								   continue innerloop;
							 							  	}
						 							}
						 							strContent= "'"+strInwardno+"'";
				 						 					 						 			
						 							}
						 							else if(strType.equalsIgnoreCase("APPNO"))
						 							{
						 								strAppNo=sheet.getCell(col, row).getContents();
						 							  	strAppNo=(String)hshappno.get(strAppNo);
						 							  	if(strAppNo!=null){
						 							  	if(strAppNo.equals("Customer Id Not Completed in Laps")||
						 							  	   strAppNo.equals("Customer Id Not Available in Laps")||
						 							  	   strAppNo.equals("Not selected in Loan product sheet"))
						 							  	   {
						 							  		strAppNo="0";
						 							  		continue innerloop;
						 							  	   }
						 							  	if(strTableId.equalsIgnoreCase("13")&&booltermsflag)
						 							  	{
						 							  		if(!strExAppNo.equalsIgnoreCase(strAppNo))
						 							  		{
							 							  		String strRefNo=sheet.getCell(col, row).getContents();
							 							  		String strPrdCode=(String)hshPrdCode.get(strRefNo);
							 							  		
							 							  		arrTerms=new ArrayList();
							 									arrTermsId=new ArrayList();
							 									arrTermsType=new ArrayList();  
							 									if(rs2!=null)
							 										rs2.close();
							 									strQuery=SQLParser.getSqlQuery("apptermscondsel1^"+strAppNo+"^S");
							 									rs2=DBUtils.executeQuery(strQuery);
							 									if(rs2.next())
							 									{
							 										appterms = rs2.getInt(1);
							 									}
							 									if(rs2!=null)
							 										rs2.close();
							 									rs2=DBUtils.executeLAPSQuery("apptermscond_prd_select^"+strPrdCode);
							 									while(rs2.next())
							 									{
							 										arrTermsId.add(correctNull(rs2.getString(1)));
							 										arrTerms.add(correctNull(rs2.getString(2)));
							 										arrTermsType.add(correctNull(rs2.getString(3)));
							 									}				 
							 									if(arrTermsId.size()> 0 && arrTermsId!=null)
							 									{
							 										int intSize=0;
							 										HashMap hshQueryValues = new HashMap();
							 										HashMap hshQuery1 = new HashMap();
							 										ArrayList arrValues = null;
							 										for(int j=0;j<arrTermsId.size();j++)
							 										{
							 											hshQueryValues.put("size",String.valueOf(++intSize));
							 											hshQuery1=new HashMap();
							 											hshQuery1.put("strQueryId","apptermscondins");
							 											arrValues=new ArrayList();
							 											arrValues.add(strAppNo);
							 											arrValues.add(correctNull(Integer.toString(j+appterms)));
							 											arrValues.add(correctNull((String)arrTerms.get(j)));
							 											arrValues.add("P");
							 											arrValues.add("N");
							 											arrValues.add("S");
							 											arrValues.add("");
							 											arrValues.add(correctNull((String)arrTermsType.get(j)));
							 											arrValues.add(correctNull((String)arrTermsId.get(i)));
							 											hshQuery1.put("arrValues",arrValues);
							 											hshQueryValues.put(String.valueOf(intSize),hshQuery1);
							 										}
							 										if(arrTermsId.size()>0)
							 										EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							 									}
							 									booltermsflag=false;
							 									strExAppNo=strAppNo;
						 							  		}
						 							  	 }
						 							  	}
						 								strContent=	"'"+strAppNo+"'";
						 							}
						 							else
					 								{
						 								break innerloop;
					 								}
						 							if(strContent.equalsIgnoreCase("'null'"))
						 							{ 
						 						    	break innerloop;
						 							}
						 						}
						 						else
						 						{
						 							strType=Helper.correctNull((String)ArrExcelType.get(x));
						 							if(strType.equalsIgnoreCase("APPID"))
						 							{
						 							strInwardno=sheet.getCell(col, row).getContents();
						 							strInwardno=(String)map.get(strInwardno);
						 							if(strInwardno!=null){
						 							if(strInwardno.equals("Customer Id Not Completed in Laps")||
						 									strInwardno.equals("Customer Id Not Available in Laps")||
						 									strInwardno.equals("Not selected in Loan product sheet"))
							 							  	{
						 								    strInwardno="0";
						 								   continue innerloop;
							 							  	}
						 							}
						 							else
						 							{
						 								strInwardno="0";	
						 								continue innerloop;
						 							}
								 						strContent=strContent.concat(","+"'"+strInwardno+"'");
								 						strNULLchk=strInwardno;
					 						 				
						 							}
						 							else if(strType.equalsIgnoreCase("BRATE"))
						 							{
						 								strContent=strContent.concat(","+"'"+dblBankRate+"'");
						 								strNULLchk=String.valueOf(dblBankRate);
						 							}
						 							else if(strType.equalsIgnoreCase("CHAR"))
						 							{
						 								strContent=strContent.concat(","+"'"+sheet.getCell(col, row).getContents().replaceAll("'"," ")+"'");
						 							}
						 							else if(strType.equalsIgnoreCase("COAPID"))
						 							{
						 								strCOGUARAppId=sheet.getCell(col, row).getContents();
							 							strCOGUARAppId=(String)hshcoapplapsId.get(strCOGUARAppId);
							 							if(strCOGUARAppId==null)
							 							{
							 								strCOGUARAppId="0";
							 								continue innerloop;
							 							}
							 							strContent=strContent.concat(","+"'"+strCOGUARAppId+"'");
							 							strNULLchk=strCOGUARAppId;
					 						 				
						 							}
						 							else if(strType.equalsIgnoreCase("COAPPOLDID"))
						 							{
						 								strCOGUARAppId=sheet.getCell(col, row).getContents();
						 								strCOGUARAppId=(String)hshcoappoldlapsId.get(strCOGUARAppId);
						 								if(strCOGUARAppId==null)
						 								{
						 									strCOGUARAppId="0";
						 									continue innerloop;
						 								}
						 								strContent=strContent.concat(","+"'"+strCOGUARAppId+"'");
						 								strNULLchk=strCOGUARAppId;
						 								
						 							}
						 							else if(strType.equalsIgnoreCase("DATE"))
						 							{
						 								strContent=strContent.concat(",to_date('"+sheet.getCell(col, row).getContents()+"','DD/MM/YYYY')");
						 								strNULLchk=sheet.getCell(col, row).getContents();
						 							}
						 							else if(strType.equalsIgnoreCase("DEMOID"))
						 							{
						 								strAppId=sheet.getCell(col, row).getContents();
						 								strAppId=(String)hshlapId.get(strAppId);
						 								if(strAppId==null)
						 								{
						 									strAppId="0";
						 									continue innerloop;
						 								}
						 								
						 								strContent=strContent.concat(","+"'"+strAppId+"'");
						 								strNULLchk=strAppId;
						 							}
						 							else if(strType.equalsIgnoreCase("DEMOOLDID"))
						 							{
						 								strAppId=sheet.getCell(col, row).getContents();
						 								strAppId=(String)hshlapsOldId.get(strAppId);
						 								if(strAppId==null)
						 								{
						 									strAppId="0";
						 									continue innerloop;
						 								}
						 								
						 								strContent=strContent.concat(","+"'"+strAppId+"'");
						 								strNULLchk=strAppId;
						 							}
						 							else if(strType.equalsIgnoreCase("EBRATE"))
						 							{
						 								strContent=strContent.concat(","+"'"+dblEstBankRate+"'");
						 								strNULLchk=String.valueOf(dblEstBankRate);
						 							}
						 							else if(strType.equalsIgnoreCase("EMRATE"))
						 							{
						 								strContent=strContent.concat(","+"'"+dblEstMarketRate+"'");
						 								strNULLchk=String.valueOf(dblEstMarketRate);
						 							}
						 							else if(strType.equalsIgnoreCase("ERATE"))
						 							{
						 								strContent=strContent.concat(","+"'"+dblEstGoldRate+"'");
						 								strNULLchk=String.valueOf(dblEstGoldRate);
						 							}
						 							else if(strType.equalsIgnoreCase("INTRT"))
						 							{
						 							strIntrest=sheet.getCell(col, row).getContents();
						 							strIntrest=(String)hshIntrest.get(strIntrest);
						 							if(strIntrest==null)
						 							{
						 								strIntrest="0.0";
						 							}
						 							strContent=strContent.concat(","+"'"+strIntrest+"'");
						 							strNULLchk=strIntrest;
						 							
				 						 			}
						 							else if(strType.equalsIgnoreCase("INTYPE"))
						 							{
						 							strInttype=sheet.getCell(col, row).getContents();
						 							strInttype=(String)hshInttype.get(strInttype);
						 							if(strInttype==null)
						 							{
						 								strInttype="Floating";
						 							}
						 							strContent=strContent.concat(","+"'"+strInttype+"'");
						 							strNULLchk=strInttype;
				 						 			}
						 							else if(strType.equalsIgnoreCase("MRATE"))
						 							{
						 								strContent=strContent.concat(","+"'"+dblMarketRate+"'");
						 								strNULLchk=String.valueOf(dblMarketRate);
						 							}
						 							else if(strType.equalsIgnoreCase("NWGT"))
						 							{
						 								String strTemp=sheet.getCell(col, row).getContents();
						 								dblNetWeight=Double.parseDouble(Helper.correctDouble(strTemp));
						 								strContent=strContent.concat(","+"'"+dblNetWeight+"'");
						 								strNULLchk=String.valueOf(dblNetWeight);
						 								
						 								dblEstBankRate=dblBankRate*dblNetWeight;
						 								dblEstMarketRate=dblMarketRate*dblNetWeight;
						 								
						 								dblEstGoldRate=Math.min(dblEstBankRate,dblEstMarketRate);
						 							}
						 							else if(strType.equalsIgnoreCase("ORGC"))
						 							{
						 								strContent=strContent.concat(","+"'"+strShortCode+"'");
						 								strNULLchk=strShortCode;
						 							}
						 							else if(strType.equalsIgnoreCase("ORGSYS"))
						 							{
						 								strContent=strContent.concat(","+"'"+strOrgCode+"'");
						 								strNULLchk=strOrgCode;
						 							}
						 							else if(strType.equalsIgnoreCase("SPLIT"))
						 							{				
						 								strSplit=(sheet.getCell(col, row).getContents()).split("-");
						 								strContent=strContent.concat(",'"+strSplit[0]+"'");
						 								strNULLchk=strSplit[0];
						 							}
						 							else if(strType.equalsIgnoreCase("SYSDATE"))
						 							{
						 								strContent=strContent.concat(",to_date('"+strdate+"','DD/MM/YYYY')");
						 								strNULLchk=strdate;
						 							}
						 							else if(strType.equalsIgnoreCase("USER"))
						 							{
						 								strContent=strContent.concat(","+"'"+struserid+"'");
						 								strNULLchk=struserid;
						 							}
						 							else if(strType.equalsIgnoreCase("CRP"))
						 							{
						 								strDummy=sheet.getCell(col, row).getContents();
						 								strDummy=Helper.correctNull((String)hshCRPVal.get(strInttype));
						 							
						 							strContent=strContent.concat(","+"'"+strDummy+"'");
						 							strNULLchk="";
				 						 			}
						 							else if(strType.equalsIgnoreCase("BSP"))
						 							{
						 								strDummy=sheet.getCell(col, row).getContents();
						 								strDummy=Helper.correctNull((String)hshBSPVal.get(strDummy));
						 								
						 								strContent=strContent.concat(","+"'"+strDummy+"'");
						 								strNULLchk="";
						 							}
						 							else if(strType.equalsIgnoreCase("MCLRTABCOD"))
						 							{
						 								strDummy=sheet.getCell(col, row).getContents();
						 								strDummy=Helper.correctNull((String)hshInttype.get(strDummy));
						 								if(strDummy.equalsIgnoreCase("Floating"))
						 									strDummy=strMCLRValueTableCode;
						 								else
						 									strDummy="";
						 								
						 								strContent=strContent.concat(","+"'"+strDummy+"'");
						 								strNULLchk=strDummy;
						 							}
						 							else if(strType.equalsIgnoreCase("MCLR"))
						 							{
						 								strDummy=sheet.getCell(col, row).getContents();
						 								strDummy=Helper.correctNull((String)hshInttype.get(strDummy));
						 								if(strDummy.equalsIgnoreCase("Floating"))
						 									strDummy=strMCLRValueType;
						 								else
						 									strDummy="";
						 								strContent=strContent.concat(","+"'"+strDummy+"'");
						 								strNULLchk=strDummy;
						 							}
						 							else if(strType.equalsIgnoreCase("BASE"))
						 							{
						 								strDummy=sheet.getCell(col, row).getContents();
						 								strDummy=Helper.correctNull((String)hshBaseRate.get(strDummy));
						 								
						 								strContent=strContent.concat(","+"'"+strDummy+"'");
						 								strNULLchk="";
						 							}
						 							
						 							
//													if (strNULLchk.equals(""))
//						 							{
//						 								break innerloop;
//						 							}
												}
					 						}
					 						
					 					}
					 					
					 					String formQuery="insert into "+strTabname +"("+ strExcelColumnName.toString() + ")" +"values" +"(" +strContent +")";
					 					System.out.println(formQuery);
					 					
					 					rs1.close();
					
					 					
					 					pstmt = con.prepareStatement(formQuery);
					 					pstmt.clearParameters();				 		 			
					 					long t1=System.currentTimeMillis();
					 					result=pstmt.executeUpdate(); //REplace with next line
					 					//pstmt.addBatch();
					 					long t2=System.currentTimeMillis();
					 					t3=(t2 - t1)+t3;
					 					log.info("SQL Query Generated : " +formQuery);
					 					log.info("SQL Execution Status : " + result + " (Time Taken : " + (t2 - t1) + " ms)");
					 					log.info("SQL Execution Status : " + result + " (Total Time Taken : " + (t3) + " ms)");
					 					
					 					if(pstmt != null)
					 					{
					 						pstmt.close();					
					 					}	
					 					
					 					
					 		    	
				 				}								  					
				 		
				 		}
				 	  		
				 		
				 		log.info("============Procedure started=================");
				 		if(!hshInwardNo.isEmpty()){
				 			
						 	   for(int loop=0;loop<ArrAppid.size();loop++)
						 		{
						 		strAppId=Helper.correctNull((String)ArrAppid.get(loop));
						 		strInwardno=(String)hshInwardNo.get(strAppId);
								callableStmt2 = con.prepareCall("call PROC_CUSTCBSID_UPDATE(?,?)");
								callableStmt2.setString(1,Helper.correctNull(strInwardno));
								callableStmt2.setString(2,Helper.correctNull(strAppId));
								callableStmt2.execute();
								callableStmt2.clearParameters();
								callableStmt2.close();
						 		  }
						 		}
				 		
				 		log.info("Procedure 1:  PROC_CUSTCBSID_UPDATE executed successfully");
				 		
				 	  if(arrRow != null && arrRow.size() > 0)
				 		{
				 			for(int loop=0;loop<arrRow.size();loop++)
					 		{
				 				strInwardno=Helper.correctNull((String)arrRow.get(loop));
				 				if(!strInwardno.equals("")||
				 				!strInwardno.equals("Customer Id Not Completed in Laps")||
				 				!strInwardno.equals("Customer Id Not Available in Laps")||
				 				!strInwardno.equals("Not selected in Loan product sheet")){
								callableStmt2 = con.prepareCall("call PROC_INWARD_UPDATE(?)");
								callableStmt2.setString(1,Helper.correctNull(strInwardno));
								callableStmt2.execute();
								callableStmt2.clearParameters();
								callableStmt2.close();
				 				}
					 		}
				 		}
				 	  
				 	 log.info("Procedure 2:  PROC_INWARD_UPDATE executed successfully");
				 	 
				        if(arrApp != null && arrApp.size() > 0)
				 		 {
				 			for(int loop=0;loop<arrApp.size();loop++)
					 		{
				 				strAppNo=Helper.correctNull((String)arrApp.get(loop));
				 				if(!strAppNo.equals("")||
				 				!strAppNo.equals("Customer Id Not Completed in Laps")||
						 		!strAppNo.equals("Customer Id Not Available in Laps")||
				 				!strAppNo.equals("Not selected in Loan product sheet")){
								callableStmt2 = con.prepareCall("call PROC_SANCAMT_UPDATE(?)");
								callableStmt2.setString(1,Helper.correctNull(strAppNo));
								callableStmt2.execute();
								callableStmt2.clearParameters();
								callableStmt2.close();
				 				}
					 		}
				 		}
				        
				        log.info("Procedure 3:  PROC_SANCAMT_UPDATE executed successfully  ===  01062016");
				 		
				    hshRequestValues.put("upload_status","Success");
	           	}
						  
			/*}
	       else
	        {
	        	strExp="$Invalid To Upload Staus.......Please Check the template";
	        	hshRequestValues.put("strExp",strExp);
	        }*/
	            		
		   else
		        {
		        	strExp="$Not a Valid Sheet.......Please Check the template";
		        	hshRequestValues.put("strExp",strExp);
		        }	
	     }
	}
	        
	 catch (Exception e) {
		 
		 e.printStackTrace();
		throw new EJBException(e.toString());
	 }
	 finally
	 {
		 try
			{
			 	if(rs != null)
				{
					rs.close();
				}
				if(rs1 != null)
				{
					rs1.close();
				}
				if(pstmt != null)
				{
					pstmt.close();
				}
				
				if(callableStmt2 != null)
				{
					callableStmt2.close();
				}
				if(con != null)
				{
					con.close();
				}
														
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing connection "+cf.getMessage());
			}
	 }
	 return hshRequestValues;
	}
	private void insertFinancialFreezedValues(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrCol=null;
		int intValue=0;
		ArrayList arrYear  = (ArrayList)hshValues.get("arrYear");
		ArrayList arrType  = (ArrayList)hshValues.get("arrType");
		ArrayList arrVal  = (ArrayList)hshValues.get("arrVal");
		String strSheetno=Helper.correctNull((String)hshValues.get("sheetno"));
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strDivId=Helper.correctNull((String)hshValues.get("strDivId"));
		String strFreezeflag=Helper.correctNull((String)hshValues.get("strFreezeflag"));
		String strExp="",strCount1="";
		String strsno="";
		int intUpdateSize=0;
		if(strDivId.equalsIgnoreCase(""))
		{
			strDivId="0";
		}
		try
		{
			HashMap hshQueryValues;
			HashMap hshQuery;
			ArrayList arrValues;
			String strfintype="";
			String strCount="";
			hshQueryValues=new HashMap();
			if(strSheetno.equalsIgnoreCase("1"))
			{
				strQuery = SQLParser.getSqlQuery("finselect1^"+strAppno+"^"+strDivId);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCount=Helper.correctNull((String)rs.getString("cnt"));
				}
				strQuery = SQLParser.getSqlQuery("sel_com_finappdesc^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strCount1=Helper.correctNull((String)rs.getString("cnt"));
				}
				if(!strCount.equalsIgnoreCase("0") || !strCount1.equalsIgnoreCase("0") )
				{
					if(rs!=null)
						rs.close();
					strQuery = SQLParser.getSqlQuery("corp_fin_year_freezevalue^"+strAppno+"^"+strDivId);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strsno=Helper.correctNull((String)rs.getString("com_sno"));
					
						hshQuery = new HashMap();		
						arrValues=new ArrayList();
						intUpdateSize++;
					  hshQuery.put("strQueryId","delFinancial_audit");
					arrValues.add(strAppno);
					arrValues.add(strsno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdateSize));
					hshQueryValues.put(Integer.toString(intUpdateSize),hshQuery);
				
					}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			if(arrYear!=null && arrType!=null && arrYear.size()>0 &&  arrType.size()>0)
			{
				for(int i=0;i<arrYear.size();i++)
				{
					int intUpdatesize=0;					
					hshQueryValues=new HashMap();
					for(int k=3;k<arrVal.size();k++)
					{
						strfintype=Helper.correctNull((String)arrType.get(i));
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","finappvaluesins");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull((String)arrYear.get(i)));
						String yearselect=Helper.correctNull((String)arrYear.get(i));
						arrCol = (ArrayList)arrVal.get(k);
						arrValues.add(Helper.correctNull((String)arrCol.get(0)));
						if(strfintype.equalsIgnoreCase("audited"))
						{
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("unaudited"))
						{
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("estimated"))
						{
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
							arrValues.add("0.00");
						}
						else if(strfintype.equalsIgnoreCase("projection"))
						{
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add("0.00");
							arrValues.add(Helper.correctDouble((String)arrCol.get(i+3)));
							arrValues.add("0.00");
						}
						arrValues.add(strDivId);
						strQuery = SQLParser.getSqlQuery("corp_app_sno_select^"+strAppno+"^"+strDivId+"^"+strfintype+"^"+yearselect);				
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrValues.add(Helper.correctNull(rs.getString("com_sno")));
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			else
			{
				if(arrYear!=null && arrYear.size()>0)
				{
					strExp="$Please check the Financial Date";
	        		throw new Exception(strExp);
				}
				else
				{
					strExp="$Please check the Financial Type";
	        		throw new Exception(strExp);
				}
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in insertFinancialValues " + exception.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
	}
	public HashMap getZIPFileData(HashMap hshRequestValues){
		
		ResultSet rs=null;
		String source="";
		try {
			
			String path="/Temp Folder";
			String strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^FVC");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull(rs.getString(1));
//				path=path.substring(0, path.length()-1);
			}
			
			log.info("=======File Path==========="+path);
			
			 try
		      {
		         source = path.substring(path.lastIndexOf("/") + 1, path.length());
		      }
		     catch (Exception e)
		     {
		        source = path;
		     }
			
			File directoryToZip = new File(path);
	
			List<File> fileList = new ArrayList<File>();
			
			getAllFiles(directoryToZip, fileList,source);
			writeZipFile(directoryToZip, fileList,source,path);
			hshRequestValues.put("FileDownload",path+"_ExcelFile.zip");
			hshRequestValues.put("FileName","FVC_FILES.zip");
			
			
		
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hshRequestValues;
		
	}

	private static void getAllFiles(File dir, List<File> fileList,String strSourcePath)  {
		try {
			File[] files = dir.listFiles();
			for (File file : files) {
				fileList.add(file);
				if (file.isDirectory()) {
					getAllFiles(file, fileList,strSourcePath);
				} 
			}
			log.info("=======getAllFiles===========");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void writeZipFile(File directoryToZip, List<File> fileList,String strSourcePath,String DestFile) {

		try {
			
			FileOutputStream fos = new FileOutputStream(DestFile+"_ExcelFile.zip");
			ZipOutputStream zos = new ZipOutputStream(fos);

			for (File file : fileList) {
				if (!file.isDirectory()) { // we only zip files, not directories
					addToZip(directoryToZip, file, zos,strSourcePath);
				}
			}
			log.info("=======writeZipFile===========");
			zos.close();
			fos.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private static void addToZip(File directoryToZip, File file, ZipOutputStream zos,String strSourcePath) throws FileNotFoundException,
			EJBException,IOException {

		FileInputStream fis = new FileInputStream(file);

		// we want the zipEntry's path to be a relative path that is relative
		// to the directory being zipped, so chop off the rest of the path
		String zipFilePath = file.getCanonicalPath().substring(directoryToZip.getCanonicalPath().length() + 1,
				file.getCanonicalPath().length());
		ZipEntry zipEntry = new ZipEntry(strSourcePath+ File.separator+zipFilePath);
		zos.putNextEntry(zipEntry);

		byte[] bytes = new byte[1024];
		int length;
		while ((length = fis.read(bytes)) >= 0) {
			zos.write(bytes, 0, length);
		}

		zos.closeEntry();
		fis.close();
	}
	public HashMap doExportProductSpread(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String[] strHeaders = {"Modification","Product Code","Interest ID","Category ID","Product Purpose","Product Description","Product Type","Product Range From","Product Range To","Product Term From","Product Term To",
				"Product Loan Type","Scheme Code","Bank Scheme","ROI Reference Types","Interest Type","Int Range From","Int Range To","ROI Type","Int Tenor From","Int Tenor To","Reference Type","Int Tenor/Score From",
				"Int Tenor/Score To","Credit Risk Premium","Business Strategic Premium","Rating Codes","Sector","Circular Reference Number"};
		String[] strHeadersSize = {"2000","3000","3000","3000","3000","6000","3000","3000","3000","3000","3000",
				"3000","3000","3000","5000","5000","3000","3000","5000","3000","3000","5000","3000",
				"3000","3000","3000","3000","5000","5000"};
		try
		{
			XSSFWorkbook wb = new XSSFWorkbook();
			
			XSSFCellStyle borderstyleright = wb.createCellStyle();
			
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			XSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			
			XSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			XSSFCellStyle cellStyle = wb.createCellStyle();
			cellStyle.setLocked(true);
			
			XSSFCellStyle cellStyle1 = wb.createCellStyle();
			cellStyle1.setLocked(false);
			
			XSSFSheet sheet = null;
			XSSFSheet sheet1=null;
			XSSFSheet sheet2=null;
			XSSFRow row = null;
			XSSFCell cell = null;
			
			XSSFSheetConditionalFormatting sheetCF=null;
			XSSFConditionalFormattingRule rule1=null;
			XSSFConditionalFormattingRule rule2=null;
			XSSFConditionalFormattingRule rule3=null;
			XSSFConditionalFormattingRule[] cfRules=null;
			CellRangeAddress[] regions=null;
			
			XSSFFontFormatting font1=null;
			XSSFFontFormatting font2=null;
			XSSFFontFormatting font3=null;
			
			sheet = wb.createSheet("Retail");
			
			row = sheet.createRow((short) intRowCount);
			
			for(int i=0;i<29;i++)
			{
				if(i!=2)
				sheet.setDefaultColumnStyle(i,cellStyle1);
			}
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
			}
			
			intCellCount=104;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("insert");
			intCellCount++;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("Modify");
			intCellCount++;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("Delete");
			intCellCount++;
			
			
			strQuery = SQLParser.getSqlQuery("sel_productspread_retail");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((short) intRowCount);
				
				cell = row.createCell(intCellCount);
				cell.setCellStyle(cellStyle1);
				intCellCount++;
				
				for(int j=1;j<strHeaders.length-1;j++)
				{
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
					if(j==24||j==25)
						cell.setCellStyle(cellStyle1);
					else
						cell.setCellStyle(cellStyle);
					intCellCount++;
				}
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(cellStyle1);
				intCellCount++;
				
				intCellCount=104;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("insert");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Modify");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Delete");
				intCellCount++;
				
				sheetCF = sheet.getSheetConditionalFormatting();
				rule1 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DA"+intRowCount);
				font1=rule1.createFontFormatting();
				font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
			  
				rule2 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DB"+intRowCount);
				font2=rule2.createFontFormatting();
				font2.setFontColorIndex(IndexedColors.BLUE.getIndex());
			 	 
			 	rule3 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DC"+intRowCount);
			 	font3=rule3.createFontFormatting();
				font3.setFontColorIndex(IndexedColors.RED.getIndex());
				
			 	cfRules = new XSSFConditionalFormattingRule[]{rule1,rule2,rule3};
			 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+intRowCount+":$AC"+intRowCount)};
			 	sheetCF.addConditionalFormatting(regions, cfRules);
				
			}
			
			for(int a=intRowCount+1;a<(intRowCount+500);a++)
			{
				row = sheet.createRow((short) a);
				
				intCellCount=104;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("insert");
				
				sheetCF = sheet.getSheetConditionalFormatting();
				rule1 = sheetCF.createConditionalFormattingRule("$A"+a+":$A"+a+"=$DA"+a);
				font1=rule1.createFontFormatting();
				font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
			  
				
			 	cfRules = new XSSFConditionalFormattingRule[]{rule1};
			 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+a+":$AC"+a)};
			 	sheetCF.addConditionalFormatting(regions, cfRules);
				
			}
			CellRangeAddressList addressNumericList=null;
			CellRangeAddressList addressListFinType=null;
			XSSFDataValidation dataValidation=null;
			XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper(sheet);
			
			String str1="-1";
			String str2="100";
			addressNumericList=new CellRangeAddressList(1, (intRowCount+500), 24, 25);
			
			XSSFDataValidationConstraint dvConstraint1 = (XSSFDataValidationConstraint)dvHelper.createNumericConstraint(DVConstraint.ValidationType.DECIMAL, DVConstraint.OperatorType.BETWEEN, str1,str2);
			XSSFDataValidation validation2= (XSSFDataValidation)dvHelper.createValidation(dvConstraint1,addressNumericList);
			validation2.setShowErrorBox(true);
			sheet.addValidationData(validation2);
			
			
			addressListFinType=new CellRangeAddressList(1,intRowCount,0,0);
			XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"MODIFY","DELETE"});
			XSSFDataValidation validation = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType);
			validation.setShowErrorBox(true);
			sheet.addValidationData(validation);
			
			CellRangeAddressList addressListFinType1=new CellRangeAddressList(intRowCount+1,(intRowCount+500),0,0);
			dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"INSERT"});
			XSSFDataValidation validation1 = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType1);
			validation.setShowErrorBox(true);
			sheet.addValidationData(validation1);
			
		 	sheet.protectSheet("syslaps");
			sheet.setAutoFilter(CellRangeAddress.valueOf("$A1:$AC1"));
			
			sheet.enableLocking();
			CTSheetProtection sheetProtection = sheet.getCTWorksheet().getSheetProtection();
			sheetProtection.setSelectLockedCells(false); 
			sheetProtection.setSelectUnlockedCells(false); 
			sheetProtection.setFormatColumns(false); 
			sheetProtection.setSort(false); 
			sheetProtection.setAutoFilter(false); 
			
			sheetProtection.setFormatCells(true); 
			sheetProtection.setFormatRows(true); 
			sheetProtection.setInsertColumns(true); 
			sheetProtection.setInsertRows(true); 
			sheetProtection.setInsertHyperlinks(true); 
			
			sheetProtection.setDeleteColumns(true); 
			sheetProtection.setDeleteRows(true); 
			sheetProtection.setPivotTables(false); 
			sheetProtection.setObjects(false); 
			sheetProtection.setScenarios(false);
			
			
			//Facility Details
			
			String[] strHeadersFac = {"Modification","Facility Code","Interest ID","Head ID","Sub Head ID","Facility Description","Facility Range From","Facility Range To","Facility Term From","Facility Term To",
					"Scheme Code","Bank Scheme","ROI Reference Types","Interest Type","Int Range From","Int Range To","ROI Type","Int Tenor From","Int Tenor To","Reference Type","Int Tenor/Score From",
					"Int Tenor/Score To","Credit Risk Premium","Business Strategic Premium","Rating Codes","Sector","Circular Reference Number"};
			String[] strHeadersFacSize = {"2000","3000","3000","3000","3000","6000","3000","3000","3000","3000",
					"3000","3000","5000","5000","3000","3000","5000","3000","3000","5000","3000",
					"3000","3000","3000","3000","5000","5000"};
			
			sheet1 = wb.createSheet("Agriculture");
			
			for(int i=0;i<27;i++)
			{
				if(i!=2)
				sheet1.setDefaultColumnStyle(i,cellStyle1);
			}
			
			
			intRowCount=0;intCellCount=0;
			
			row = sheet1.createRow((short) intRowCount);
			
			for(int i=0;i<strHeadersFac.length;i++)
			{
				sheet1.setColumnWidth(i, Integer.parseInt(strHeadersFacSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeadersFac[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
				
			}
			
			intCellCount=104;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("insert");
			intCellCount++;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("Modify");
			intCellCount++;
			
			cell = row.createCell(intCellCount);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue("Delete");
			intCellCount++;
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_facilityspread_agridetails");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intRowCount++;
				intCellCount=0;
				row = sheet1.createRow((short) intRowCount);
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellStyle(cellStyle1);
				intCellCount++;
				
				for(int j=1;j<strHeadersFac.length-1;j++)
				{
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
					if(j==22||j==23)
						cell.setCellStyle(cellStyle1);
					else
						cell.setCellStyle(cellStyle);
					intCellCount++;
				}
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("");
				cell.setCellStyle(cellStyle1);
				intCellCount++;
				
				intCellCount=104;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("insert");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Modify");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Delete");
				intCellCount++;
				
				sheetCF = sheet1.getSheetConditionalFormatting();
				rule1 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DA"+intRowCount);
				font1=rule1.createFontFormatting();
				font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
			  
				rule2 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DB"+intRowCount);
				font2=rule2.createFontFormatting();
				font2.setFontColorIndex(IndexedColors.BLUE.getIndex());
			 	 
			 	rule3 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DC"+intRowCount);
			 	font3=rule3.createFontFormatting();
				font3.setFontColorIndex(IndexedColors.RED.getIndex());
				
			 	cfRules = new XSSFConditionalFormattingRule[]{rule1,rule2,rule3};
			 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+intRowCount+":$AC"+intRowCount)};
			 	sheetCF.addConditionalFormatting(regions, cfRules);
				
				
			}
			
			for(int a=intRowCount+1;a<(intRowCount+500);a++)
			{
				row = sheet1.createRow((short) a);
				
				intCellCount=104;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("insert");
				intCellCount++;
				
				sheetCF = sheet1.getSheetConditionalFormatting();
				rule1 = sheetCF.createConditionalFormattingRule("$A"+a+":$A"+a+"=$DA"+a);
				font1=rule1.createFontFormatting();
				font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
			  
				
			 	cfRules = new XSSFConditionalFormattingRule[]{rule1};
			 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+a+":$AA"+a)};
			 	sheetCF.addConditionalFormatting(regions, cfRules);
				
			}
			
			str1="-1";
			str2="100";
			addressNumericList=new CellRangeAddressList(1, (intRowCount+500), 22, 23);
			
			validation2= (XSSFDataValidation)dvHelper.createValidation(dvConstraint1,addressNumericList);
			validation2.setShowErrorBox(true);
			sheet1.addValidationData(validation2);
			
			
			addressListFinType=new CellRangeAddressList(1,intRowCount,0,0);
			dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"MODIFY","DELETE"});
			validation = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType);
			validation.setShowErrorBox(true);
			sheet1.addValidationData(validation);
			
			addressListFinType1=new CellRangeAddressList(intRowCount+1,(intRowCount+500),0,0);
			dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"INSERT"});
			validation1 = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType1);
			validation.setShowErrorBox(true);
			sheet1.addValidationData(validation1);
			
		 	sheet1.protectSheet("syslaps");
			sheet1.setAutoFilter(CellRangeAddress.valueOf("$A1:$AA1"));
			
			sheet1.enableLocking();
			sheetProtection = sheet1.getCTWorksheet().getSheetProtection();
			sheetProtection.setSelectLockedCells(false); 
			sheetProtection.setSelectUnlockedCells(false); 
			sheetProtection.setFormatColumns(false); 
			sheetProtection.setSort(false); 
			sheetProtection.setAutoFilter(false); 
			
			sheetProtection.setFormatCells(true); 
			sheetProtection.setFormatRows(true); 
			sheetProtection.setInsertColumns(true); 
			sheetProtection.setInsertRows(true); 
			sheetProtection.setInsertHyperlinks(true); 
			
			sheetProtection.setDeleteColumns(true); 
			sheetProtection.setDeleteRows(true); 
			sheetProtection.setPivotTables(false); 
			sheetProtection.setObjects(false); 
			sheetProtection.setScenarios(false);
			
			
				sheet2 = wb.createSheet("Corporate");
				
				for(int i=0;i<27;i++)
				{
					if(i!=2)
					sheet2.setDefaultColumnStyle(i,cellStyle1);
				}
				
				
				intRowCount=0;intCellCount=0;
				
				row = sheet2.createRow((short) intRowCount);
				
				for(int i=0;i<strHeadersFac.length;i++)
				{
					sheet2.setColumnWidth(i, Integer.parseInt(strHeadersFacSize[i]));
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(strHeadersFac[i]);
					cell.setCellStyle(borderstylecenter);
					intCellCount++;
					
				}
				intCellCount=104;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("insert");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Modify");
				intCellCount++;
				
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue("Delete");
				intCellCount++;
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("sel_facilityspread_corpdetails");
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intRowCount++;
					intCellCount=0;
					row = sheet2.createRow((short) intRowCount);
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellStyle(cellStyle1);
					intCellCount++;
					
					for(int j=1;j<strHeadersFac.length-1;j++)
					{
						cell = row.createCell(intCellCount);
						cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
						if(j==22||j==23)
							cell.setCellStyle(cellStyle1);
						else
							cell.setCellStyle(cellStyle);
						intCellCount++;
					}
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("");
					cell.setCellStyle(cellStyle1);
					intCellCount++;
					
					intCellCount=104;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("insert");
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Modify");
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Delete");
					intCellCount++;
					
					sheetCF = sheet2.getSheetConditionalFormatting();
					rule1 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DA"+intRowCount);
					font1=rule1.createFontFormatting();
					font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
				  
					rule2 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DB"+intRowCount);
					font2=rule2.createFontFormatting();
					font2.setFontColorIndex(IndexedColors.BLUE.getIndex());
				 	 
				 	rule3 = sheetCF.createConditionalFormattingRule("$A"+intRowCount+":$A"+intRowCount+"=$DC"+intRowCount);
				 	font3=rule3.createFontFormatting();
					font3.setFontColorIndex(IndexedColors.RED.getIndex());
					
				 	cfRules = new XSSFConditionalFormattingRule[]{rule1,rule2,rule3};
				 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+intRowCount+":$AC"+intRowCount)};
				 	sheetCF.addConditionalFormatting(regions, cfRules);
					
					
				}
				
				for(int a=intRowCount+1;a<(intRowCount+500);a++)
				{
					row = sheet2.createRow((short) a);
					
					intCellCount=104;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("insert");
					intCellCount++;
					
					sheetCF = sheet2.getSheetConditionalFormatting();
					rule1 = sheetCF.createConditionalFormattingRule("$A"+a+":$A"+a+"=$DA"+a);
					font1=rule1.createFontFormatting();
					font1.setFontColorIndex(IndexedColors.GREEN.getIndex());
				  
					
				 	cfRules = new XSSFConditionalFormattingRule[]{rule1};
				 	regions = new CellRangeAddress[]{CellRangeAddress.valueOf("$A"+a+":$AA"+a)};
				 	sheetCF.addConditionalFormatting(regions, cfRules);
					
				}
				
				
				str1="-1";
				str2="100";
				addressNumericList=new CellRangeAddressList(1, (intRowCount+500), 22, 23);
				
				validation2= (XSSFDataValidation)dvHelper.createValidation(dvConstraint1,addressNumericList);
				validation2.setShowErrorBox(true);
				sheet2.addValidationData(validation2);
				
				
				addressListFinType=new CellRangeAddressList(1,intRowCount,0,0);
				dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"MODIFY","DELETE"});
				validation = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType);
				validation.setShowErrorBox(true);
				sheet2.addValidationData(validation);
				
				addressListFinType1=new CellRangeAddressList(intRowCount+1,(intRowCount+500),0,0);
				dvConstraint = (XSSFDataValidationConstraint)dvHelper.createExplicitListConstraint(new String[]{"INSERT"});
				validation1 = (XSSFDataValidation)dvHelper.createValidation(dvConstraint, addressListFinType1);
				validation.setShowErrorBox(true);
				sheet2.addValidationData(validation1);
				
			 	sheet2.protectSheet("syslaps");
				sheet2.setAutoFilter(CellRangeAddress.valueOf("$A1:$AA1"));
				
				sheet2.enableLocking();
				sheetProtection = sheet2.getCTWorksheet().getSheetProtection();
				sheetProtection.setSelectLockedCells(false); 
				sheetProtection.setSelectUnlockedCells(false); 
				sheetProtection.setFormatColumns(false); 
				sheetProtection.setSort(false); 
				sheetProtection.setAutoFilter(false); 
				
				sheetProtection.setFormatCells(true); 
				sheetProtection.setFormatRows(true); 
				sheetProtection.setInsertColumns(true); 
				sheetProtection.setInsertRows(true); 
				sheetProtection.setInsertHyperlinks(true); 
				
				sheetProtection.setDeleteColumns(true); 
				sheetProtection.setDeleteRows(true); 
				sheetProtection.setPivotTables(false); 
				sheetProtection.setObjects(false); 
				sheetProtection.setScenarios(false);				
			
			String path="/Temp Folder";
			File foldername = null;
			
			foldername=new File(path);
			if(!foldername.exists())
			{
				foldername.mkdirs();
			}
			FileOutputStream fOut = new FileOutputStream(path+"/ProductSpreadDetails_"+Helper.getCurrentDateandTime()+".xlsx");
			hshresult.put("FileDownload",path+"/ProductSpreadDetails_"+Helper.getCurrentDateandTime()+".xlsx");
			hshresult.put("FileName","ProductSpreadDetails_"+Helper.getCurrentDateandTime()+".xlsx");
			hshresult.put("strFinancialDn","N");
			wb.write(fOut);
			fOut.flush();
			fOut.close();
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}

	public HashMap updateProductSpread(HashMap hshRequestValues)
	{
		String strExp="";
		String strmsg="";
		ResultSet rs=null;
		String strExcelflag=Helper.correctNull((String)hshRequestValues.get("strExcelflag"));
		String strFileName=Helper.correctNull((String)hshRequestValues.get("strFileName"));
		try
		{
            byte[] byteData=(byte[])hshRequestValues.get("stream");
            if(!strExcelflag.equalsIgnoreCase("SUCCESS"))
         	{
         		throw new Exception(strExcelflag);
         	}
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
            	
            	 XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
            	 
            	 
				HashMap hshRecord= new HashMap();
				ArrayList arrRow = new ArrayList();
				ArrayList arrCol = null;
				XSSFSheet  sheet = workbook.getSheetAt(0);
				int columns =0;
				int rows =0;
				int intCount=0;
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				int intRow=0,intExecutionNo=0;
				
				rs=DBUtils.executeLAPSQuery("selmaxexecutionno");
				if(rs.next())
				{
					intExecutionNo=rs.getInt("sno");
				}
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("selmaxbackuptable_exeno");
				if(rs.next())
				{
					if(intExecutionNo<rs.getInt("sno"))
					{
						intExecutionNo=rs.getInt("sno");
					}
				}
				
				++intExecutionNo;
				
				XSSFWorkbook wb = new XSSFWorkbook();
				
				XSSFCellStyle borderstyleright = wb.createCellStyle();
				
				borderstyleright.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
				
				XSSFCellStyle borderstyleleft = wb.createCellStyle();
				
				borderstyleleft.setAlignment(XSSFCellStyle.ALIGN_LEFT);
				
				XSSFCellStyle borderstylecenter = wb.createCellStyle();
				
				borderstylecenter.setAlignment(XSSFCellStyle.ALIGN_CENTER);
				borderstylecenter.setLocked(true);
				
				XSSFSheet hssheet = null;
				XSSFRow hsrow = null;
				XSSFCell hscell = null;
				
				
				for(int i=0;i<3;i++)
				{
					sheet = workbook.getSheetAt(i);
					
					hssheet = wb.createSheet(sheet.getSheetName());
					hssheet.protectSheet("Kb!Pr0DUCTSp63D");
					int currentRowIndex=0;
					int rowCount=sheet.getLastRowNum(); 
					if(rowCount>0)
					{
						for(int a=0;a<rowCount;a++)
						{
							Row row = sheet.getRow(a);
							hssheet.createRow(a);
							
							int cellCount=27;
							if(i==0)
								cellCount=29;
							
							for(int b=0;b<cellCount;b++)
							{
								Cell cell = sheet.getRow(a).getCell(b);
								if(cell!=null)
									hssheet.getRow(a).createCell(b).setCellValue(cell.toString());
								else
									hssheet.getRow(a).createCell(b).setCellValue("");
							}
							
						}
						
						for(int a=1;a<rowCount;a++)
						{
							Row row = sheet.getRow(a);
							hssheet.createRow(a);
							
							int cellCount=27;
							if(i==0)
								cellCount=29;
							
							Cell cell = sheet.getRow(a).getCell(0);

							if(cell!=null && !(cell.toString()).equalsIgnoreCase(""))
							{
								hshRecord=new HashMap();
								arrCol= new ArrayList();
								hshRecord.put("strQueryId", "ins_prdfac_spreaddetails");
								++intCount;
								for(int b=0;b<cellCount;b++)
								{
									Cell cell1 = sheet.getRow(a).getCell(b);
									
									if((i==1 || i==2) &&(b==6||b==10))
									{
										arrCol.add("");
									}
									
									if(cell1!=null)
										arrCol.add(Helper.correctNull(cell1.toString()));
									else
										arrCol.add("");
								}
								
								if(i==0)
									arrCol.add("P");
								else if(i==1)
									arrCol.add("A");
								else
									arrCol.add("C");	
								arrCol.add(String.valueOf(a+1));
								arrCol.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
								arrCol.add(String.valueOf(intExecutionNo));
								arrCol.add(String.valueOf(++intRow));
								hshRecord.put("arrValues",arrCol);
								hshQueryValues.put(String.valueOf(intCount),hshRecord);
								hshQueryValues.put("size",String.valueOf(intCount));
							}
							
						}
					}
					
				}
				
				if(intCount>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				String path="/Temp Folder";
				rs = DBUtils.executeLAPSQuery("getstaticdata_soldid^32^SPREADEXCELLOC");
				if(rs.next())
				{
					path = Helper.correctNull((String)rs.getString("stat_data_desc1"));
				}
				log.info("Excel Location==="+path);
				if(!path.equalsIgnoreCase(""))
				{
					File foldername = null;
					
					foldername=new File(path);
					if(!foldername.exists())
					{
						foldername.mkdirs();
					}
					FileOutputStream fOut = new FileOutputStream(path+"/"+strFileName+"_"+Helper.getCurrentDateandTime()+"_"+intExecutionNo+"_"+Helper.correctNull((String)hshRequestValues.get("strUserId"))+".xls");
					wb.write(fOut);
					fOut.flush();
					fOut.close();
				}
				
				strmsg="Success";
				hshRequestValues.put("msg",strmsg);
            }
            else
            {
            	strExp="$Select the Valid Excel Sheet to Upload!!";
            	throw new Exception(strExp);
            }
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new EJBException(e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshRequestValues;
	}
	public HashMap doExportNPAProvOutput_OLD(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String txt_qenddate=Helper.correctInt((String)hshRequestValues.get("txt_qenddate"));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String[] strHeaders = {"S.No","Branch Code","Branch Name","Borrower Name","Customer ID","Finacle Account Number","Norm Status","Date of NPA","Balance Outstanding","Unrealised Interest","Other Charges","Net Balance","Provision","Secured Value","Unsecured Value","Whether Partly secured","CGC/ECGC/CGTMSE-Recd+Cover","Ab-initio","Date of AB-Initio","Whether written off","Whether Fraud","Date of Fraud"};
		String[] strHeadersSize = {"2000","4000","10000","10000","3000","6000","4000","3000","5000","5000","5000","5000","5000","5000","5000","5000","6000","3000","4000","5000","4000","4000"};
		try
		{
			HSSFWorkbook wb = new HSSFWorkbook();
			
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			
			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			
			sheet = wb.createSheet("NPA PROVISIONING OLD");
			
			row = sheet.createRow((int) intRowCount);
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			
			String strPreviousVal = "";
			int rows_count = 0;
			int rows_count_actual = 1;
			boolean boolSameCust = true;
			String MaxSlNo="";
			strQuery = SQLParser.getSqlQuery("get_Maax_Npa_Prov_Oldata^"+txt_qenddate);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				MaxSlNo = Helper.correctNull((String)rs.getString("MaxSlNo"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report_OLD^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+txt_qenddate);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((int) intRowCount);
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(rs.getRow());
				cell.setCellStyle(borderstyleleft);
				intCellCount++;
				
				//strPreviousVal = "";
				boolSameCust = true;
				
				if(!strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					strPreviousVal = Helper.correctNull((String)rs.getString("CUST_ID"));
					rows_count = Integer.parseInt(Helper.correctInt((String)rs.getString("cus_count")));
					boolSameCust = false;
				}
				rows_count_actual = rows_count_actual + 1;
								
				for(int j=1;j<=22;j++)
				{
					if(boolSameCust && (j==13||j==14||j==15||j==17||j==18))
					{
						intCellCount++;	
						continue;
					} 
					else
					{
						if(j == 1 || j == 2 || j == 3 || j == 4 || j == 5 || j == 6)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstyleleft);
							intCellCount++;
						}
						if(j == 8 || j == 9 || j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 16)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(j+1)))));
							cell.setCellStyle(borderstyleright);
							if(j==13 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("N"+rows_count_actual+":N"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==14 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("O"+rows_count_actual+":O"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							intCellCount++;
						}
						if(j == 7 || j == 15 || j == 17 || j == 18 || j == 19 || j == 20 || j == 21)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstylecenter);
							if(j==15 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("P"+rows_count_actual+":P"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==17 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("R"+rows_count_actual+":R"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==18 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("S"+rows_count_actual+":S"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							intCellCount++;						
						}						
					}
				}
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^NPA");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			log.info("Report Location==="+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/EXE_"+txt_qenddate.replace("/", "")+".xls");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/EXE_"+txt_qenddate.replace("/", "")+".xls");
				hshresult.put("FileName","EXE_"+txt_qenddate.replace("/", "")+".xls");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	
	public HashMap doExportNPAProvReport1(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		ResultSet rs5 = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String txtdate=Helper.correctInt((String)hshRequestValues.get("txtdate"));
		String date=Helper.correctInt((String)hshRequestValues.get("txtdate"));
		String strnpaorg=Helper.correctInt((String)hshRequestValues.get("npaorg")).substring(0, 6);
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		String strExe_Sno="";
		String[] strHeaders = {"Branch Code","Branch Name","Region Code","Region Name","Borrower Name","Customer ID","Finacle Account Number","Norm Status","Date of NPA","Balance Outstanding","Unrealised Interest","Other Charges","Net Balance","Provision","Secured Value","Unsecured Value","Whether Partly secured","CGC/ECGC/CGTMSE-Recd+Cover","Ab-initio","Date of AB-Initio","Whether Restructured","Date of Restructuring","Whether written off","Whether Fraud","Date of Fraud","Security Type","Security ID","Owner of security","Consortium/ Multiple/Sole","If Consortium, Charge (Paripassu/ first)","Prime/ Collateral","Valuation Date","Security Value","Out of which assigned secured value","CBS Security Value"};
		String[] strHeadersSize = {"4000","10000","4000","10000","10000","3000","6000","4000","3000","5000","5000","5000","5000","5000","5000","5000","5000","6000","3000","4000","5000","5000","5000","4000","4000","4000","4000","5000","6000","7000","4000","4000","4000","7000","4000"};
		try
		{
			XSSFWorkbook wb = new XSSFWorkbook();
			
			XSSFCellStyle borderstyleright = wb.createCellStyle();
			
			
			XSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			
			XSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			
			XSSFSheet sheet = null;
			XSSFRow row = null;
			XSSFCell cell = null;
			
			sheet = wb.createSheet("NPA PROVISIONING");
			
			row = sheet.createRow((int) intRowCount);
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(XSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			String strPreviousVal = "",strPrevAccNo="";
			int rows_count = 0;
			int rows_count_actual = 1;
			int rows_count_acc = 0;
			boolean boolSameCust = true;
			boolean boolSameAcc = true;
			int i=0;
			double dblSubTotal=0,dblSubTotal1=0;
			try {
			    
			    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy");
			    txtdate=sdf2.format(sdf.parse(txtdate));
			} catch (Exception e) {
			    e.printStackTrace();

			}
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report1old^"+txtdate+"^"+strnpaorg+"^"+txtdate+"^"+strnpaorg);
			rs = DBUtils.executeQuery(strQuery);
		     while(rs.next())
			{
				
				if(!strPreviousVal.equalsIgnoreCase("") && !strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc)+":G"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc)+":H"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc)+":I"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc)+":J"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc)+":K"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc)+":L"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc)+":M"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc)+":N"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc)+":R"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc)+":S"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc)+":T"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc)+":U"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc)+":V"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc)+":W"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc)+":X"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc)+":Y"+(rows_count_actual)); 
					sheet.addMergedRegion(region);

					region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc)+":AC"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc)+":AI"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					rows_count_acc=0;
					
					CellRangeAddress region4 = CellRangeAddress.valueOf("A"+(rows_count_actual-rows_count+1)+":A"+(rows_count_actual)); 
					sheet.addMergedRegion(region4);
					
					CellRangeAddress region5 = CellRangeAddress.valueOf("B"+(rows_count_actual-rows_count+1)+":B"+(rows_count_actual)); 
					sheet.addMergedRegion(region5);
					
					CellRangeAddress region6 = CellRangeAddress.valueOf("C"+(rows_count_actual-rows_count+1)+":C"+(rows_count_actual)); 
					sheet.addMergedRegion(region6);
					
					CellRangeAddress region7 = CellRangeAddress.valueOf("D"+(rows_count_actual-rows_count+1)+":D"+(rows_count_actual)); 
					sheet.addMergedRegion(region7);
					
					CellRangeAddress region8 = CellRangeAddress.valueOf("E"+(rows_count_actual-rows_count+1)+":E"+(rows_count_actual)); 
					sheet.addMergedRegion(region8);
					
					CellRangeAddress region9 = CellRangeAddress.valueOf("F"+(rows_count_actual-rows_count+1)+":F"+(rows_count_actual)); 
					sheet.addMergedRegion(region9);
					
					CellRangeAddress region1 = CellRangeAddress.valueOf("O"+(rows_count_actual-rows_count+1)+":O"+(rows_count_actual)); 
					sheet.addMergedRegion(region1);
					
					CellRangeAddress region2 = CellRangeAddress.valueOf("P"+(rows_count_actual-rows_count+1)+":P"+(rows_count_actual)); 
					sheet.addMergedRegion(region2);
					
					CellRangeAddress region3 = CellRangeAddress.valueOf("Q"+(rows_count_actual-rows_count+1)+":Q"+(rows_count_actual)); 
					sheet.addMergedRegion(region3);
					
					rows_count_actual = rows_count_actual + 1;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow(intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Sub Total");
					cell.setCellStyle(borderstyleright);
					
					region = CellRangeAddress.valueOf("A"+rows_count_actual+":AG"+rows_count_actual); 
					sheet.addMergedRegion(region);
					intCellCount=33;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal1));
					cell.setCellStyle(borderstyleright);
					
					
					dblSubTotal=0;dblSubTotal1=0;
					
				}
				
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow(intRowCount);
				
				if(!strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					strPreviousVal = Helper.correctNull((String)rs.getString("CUST_ID"));
					strPrevAccNo=Helper.correctNull((String)rs.getString("ACC_NO"));
					rows_count=1;
					boolSameCust = true;
					boolSameAcc=true;
					
					dblSubTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("assignedsec")));
					dblSubTotal1=Double.parseDouble(Helper.correctDouble(rs.getString("PrimeVal")));
					
				}
				else if(strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					if(strPrevAccNo.equalsIgnoreCase(Helper.correctNull((String)rs.getString("ACC_NO"))))
					{
						boolSameAcc=false;
						rows_count_acc+=1;
					}
					else
					{
						boolSameAcc=true;
						strPrevAccNo=Helper.correctNull((String)rs.getString("ACC_NO"));
					}
					rows_count+=1;
					boolSameCust = false;
					dblSubTotal+=Double.parseDouble(Helper.correctDouble(rs.getString("assignedsec")));
					dblSubTotal1=Double.parseDouble(Helper.correctDouble(rs.getString("PrimeVal")));
				}
				rows_count_actual = rows_count_actual + 1;
								
				for(int j=1;j<=35;j++)
				{
					if(!boolSameCust  && boolSameAcc && (j==15||j==16||j==17||j==35||j==1||j==2||j==3||j==4||j==5||j==6))
					{
						intCellCount++;	
						continue;
					}
					else if(!boolSameAcc && (j==7||j==8||j==9||j==10||j==11||j==12||j==13||j==14||j==18||j==19||j==20||j==21||j==22||j==23||j==24||j==25||j==29||j==36))
					{
						intCellCount++;	
						continue;
					}
					else
					{
						
						if(!boolSameCust  && boolSameAcc && (j==7||j==8||j==9||j==10||j==11||j==12||j==13||j==14||j==18||j==19||j==20||j==21||j==22||j==23||j==24||j==25||j==29||j==36))
						{
							CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc-1)+":G"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc-1)+":H"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc-1)+":I"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc-1)+":J"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc-1)+":K"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc-1)+":L"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc-1)+":M"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc-1)+":N"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc-1)+":R"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc-1)+":S"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc-1)+":T"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc-1)+":U"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc-1)+":V"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc-1)+":W"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc-1)+":X"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc-1)+":Y"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);

							region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc-1)+":AC"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							
							region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc-1)+":AI"+(rows_count_actual-1)); 
							sheet.addMergedRegion(region);
							rows_count_acc=0;
						}
						if(j == 1 || j == 2 || j == 3 || j == 4 || j == 5 || j == 6|| j == 7 || j == 8|| j == 26|| j == 27|| j == 28|| j == 29|| j == 30|| j == 31|| j == 32)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
							cell.setCellStyle(borderstyleleft);
							intCellCount++;
						}
						if(j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 15 || j == 16 || j == 18|| j == 33|| j == 34|| j == 35)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(j)))));
							cell.setCellStyle(borderstyleright);
							/*if(j==15 && boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("P"+rows_count_actual+":P"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==16 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("Q"+rows_count_actual+":Q"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==35 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("AJ"+rows_count_actual+":AJ"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}*/
							intCellCount++;
						}
						if(j == 9 || j == 17 || j == 19 || j == 20 || j == 21 || j == 22 || j == 23 || j == 24 || j ==25)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(XSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j)));
							cell.setCellStyle(borderstylecenter);
							intCellCount++;						
						}						
					}						
				}
				
				
			}
			
			if(rs.previous())
			{
				{
					CellRangeAddress region = CellRangeAddress.valueOf("G"+(rows_count_actual-rows_count_acc)+":G"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("H"+(rows_count_actual-rows_count_acc)+":H"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("I"+(rows_count_actual-rows_count_acc)+":I"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("J"+(rows_count_actual-rows_count_acc)+":J"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("K"+(rows_count_actual-rows_count_acc)+":K"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("L"+(rows_count_actual-rows_count_acc)+":L"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("M"+(rows_count_actual-rows_count_acc)+":M"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("N"+(rows_count_actual-rows_count_acc)+":N"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("R"+(rows_count_actual-rows_count_acc)+":R"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("S"+(rows_count_actual-rows_count_acc)+":S"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("T"+(rows_count_actual-rows_count_acc)+":T"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("U"+(rows_count_actual-rows_count_acc)+":U"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("V"+(rows_count_actual-rows_count_acc)+":V"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("W"+(rows_count_actual-rows_count_acc)+":W"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("X"+(rows_count_actual-rows_count_acc)+":X"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("Y"+(rows_count_actual-rows_count_acc)+":Y"+(rows_count_actual)); 
					sheet.addMergedRegion(region);

					region = CellRangeAddress.valueOf("AC"+(rows_count_actual-rows_count_acc)+":AC"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					
					region = CellRangeAddress.valueOf("AI"+(rows_count_actual-rows_count_acc)+":AI"+(rows_count_actual)); 
					sheet.addMergedRegion(region);
					rows_count_acc=0;
					
					CellRangeAddress region4 = CellRangeAddress.valueOf("A"+(rows_count_actual-rows_count+1)+":A"+(rows_count_actual)); 
					sheet.addMergedRegion(region4);
					
					CellRangeAddress region5 = CellRangeAddress.valueOf("B"+(rows_count_actual-rows_count+1)+":B"+(rows_count_actual)); 
					sheet.addMergedRegion(region5);
					
					CellRangeAddress region6 = CellRangeAddress.valueOf("C"+(rows_count_actual-rows_count+1)+":C"+(rows_count_actual)); 
					sheet.addMergedRegion(region6);
					
					CellRangeAddress region7 = CellRangeAddress.valueOf("D"+(rows_count_actual-rows_count+1)+":D"+(rows_count_actual)); 
					sheet.addMergedRegion(region7);
					
					CellRangeAddress region8 = CellRangeAddress.valueOf("E"+(rows_count_actual-rows_count+1)+":E"+(rows_count_actual)); 
					sheet.addMergedRegion(region8);
					
					CellRangeAddress region9 = CellRangeAddress.valueOf("F"+(rows_count_actual-rows_count+1)+":F"+(rows_count_actual)); 
					sheet.addMergedRegion(region9);
					
					CellRangeAddress region1 = CellRangeAddress.valueOf("O"+(rows_count_actual-rows_count+1)+":O"+(rows_count_actual)); 
					sheet.addMergedRegion(region1);
					
					CellRangeAddress region2 = CellRangeAddress.valueOf("P"+(rows_count_actual-rows_count+1)+":P"+(rows_count_actual)); 
					sheet.addMergedRegion(region2);
					
					CellRangeAddress region3 = CellRangeAddress.valueOf("Q"+(rows_count_actual-rows_count+1)+":Q"+(rows_count_actual)); 
					sheet.addMergedRegion(region3);
					
					
					rows_count_actual = rows_count_actual + 1;
					
					intRowCount++;
					intCellCount=0;
					row = sheet.createRow(intRowCount);
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue("Sub Total");
					cell.setCellStyle(borderstyleright);
					
					region = CellRangeAddress.valueOf("A"+rows_count_actual+":AG"+rows_count_actual); 
					sheet.addMergedRegion(region);
					intCellCount=33;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal));
					cell.setCellStyle(borderstyleright);
					intCellCount++;
					
					cell = row.createCell(intCellCount);
					cell.setCellType(XSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(nf.format(dblSubTotal1));
					cell.setCellStyle(borderstyleright);
					
				}
			}
			
			strQuery = SQLParser.getSqlQuery("selectmaxexeno^"+txtdate);
			rs5 = DBUtils.executeQuery(strQuery);
			if(rs5.next())
			{
				strExe_Sno = Helper.correctNull((String)rs5.getString("EXE_SNO"));
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^NPA");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			log.info("NPA Report Location ======"+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				hshresult.put("FileName","NPAEXE_"+strExe_Sno+"_"+Helper.getCurrentDateTime().replace("/", "")+".xlsx");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
				if(rs5 != null)
				{
					rs5.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	public HashMap doExportNPAProv_Accountwise(HashMap hshRequestValues)
	{
		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String txt_qenddate=Helper.correctInt((String)hshRequestValues.get("txt_qenddate"));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String[] strHeaders = {"S.No","Branch Code","Branch Name","Borrower Name","Customer ID","Finacle Account Number","Norm Status","Date of NPA","Balance Outstanding","Unrealised Interest","Other Charges","Net Balance","Provision","Secured Value","Unsecured Value","Whether Partly secured","CGC/ECGC/CGTMSE-Recd+Cover","Ab-initio","Date of AB-Initio","Whether written off","Whether Fraud","Date of Fraud"};
		String[] strHeadersSize = {"2000","4000","10000","10000","3000","6000","4000","3000","5000","5000","5000","5000","5000","5000","5000","5000","6000","3000","4000","5000","4000","4000"};
		try
		{
			HSSFWorkbook wb = new HSSFWorkbook();
			
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			
			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			
			sheet = wb.createSheet("NPA Reports – Account Wise Security Wise");
			
			row = sheet.createRow((int) intRowCount);
			
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			
			String strPreviousVal = "";
			int rows_count = 0;
			int rows_count_actual = 1;
			boolean boolSameCust = true;
			String MaxSlNo="";
			strQuery = SQLParser.getSqlQuery("get_Maax_Npa_Prov_Oldata^"+txt_qenddate);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				MaxSlNo = Helper.correctNull((String)rs.getString("MaxSlNo"));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_NPA_PROV_report_OLDS"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+MaxSlNo+"^"+txt_qenddate);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intRowCount++;
				intCellCount=0;
				row = sheet.createRow((int) intRowCount);
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(rs.getRow());
				cell.setCellStyle(borderstyleleft);
				intCellCount++;
				
				//strPreviousVal = "";
				boolSameCust = true;
				
				if(!strPreviousVal.equalsIgnoreCase(Helper.correctNull((String)rs.getString("CUST_ID"))))
				{
					strPreviousVal = Helper.correctNull((String)rs.getString("CUST_ID"));
					rows_count = Integer.parseInt(Helper.correctInt((String)rs.getString("cus_count")));
					boolSameCust = false;
				}
				rows_count_actual = rows_count_actual + 1;
								
				for(int j=1;j<=22;j++)
				{
					if(boolSameCust && (j==13||j==14||j==15||j==17||j==18))
					{
						intCellCount++;	
						continue;
					} 
					else
					{
						if(j == 1 || j == 2 || j == 3 || j == 4 || j == 5 || j == 6)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstyleleft);
							intCellCount++;
						}
						if(j == 8 || j == 9 || j == 10 || j == 11 || j == 12 || j == 13 || j == 14 || j == 16)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString(j+1)))));
							cell.setCellStyle(borderstyleright);
							if(j==13 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("N"+rows_count_actual+":N"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==14 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("O"+rows_count_actual+":O"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							intCellCount++;
						}
						if(j == 7 || j == 15 || j == 17 || j == 18 || j == 19 || j == 20 || j == 21)
						{
							cell = row.createCell(intCellCount);
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							cell.setCellValue(Helper.correctNull((String)rs.getString(j+1)));
							cell.setCellStyle(borderstylecenter);
							if(j==15 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("P"+rows_count_actual+":P"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==17 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("R"+rows_count_actual+":R"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							if(j==18 && !boolSameCust)
							{
								CellRangeAddress region = CellRangeAddress.valueOf("S"+rows_count_actual+":S"+(rows_count_actual+rows_count-1)); 
								sheet.addMergedRegion(region);
							}
							intCellCount++;						
						}						
					}
				}
			}
			
			String path="/Temp Folder";
			strQuery = SQLParser.getSqlQuery("selotherparam_ratexpos^NPA");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				path = Helper.correctNull((String)rs.getString(1));
			}
			log.info("Report Location==="+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/EXE_"+txt_qenddate.replace("/", "")+".xls");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/EXE_"+txt_qenddate.replace("/", "")+".xls");
				hshresult.put("FileName","EXE_"+txt_qenddate.replace("/", "")+".xls");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
	}
	
	public HashMap dodownloadxslforfbill(HashMap hshRequestValues) throws EJBException
	{

		ResultSet rs = null;
		HashMap hshresult = new HashMap();
		String strQuery="",strTabName="";
		int intRowCount=0,intCellCount=0;
		String txt_qenddate=Helper.correctInt((String)hshRequestValues.get("txt_qenddate"));
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		String[] strHeaders = {"S.No","Reference Type","Reference Spread Value","Table Code For Loans","Table Code For OverDraft","Effective From"};
			String[] strHeadersSize = {"2000","15000","10000","7000","7000","5000"};
		
		try
		{
//			String strFromDate="";
//			String strToDate="";
//			String date=Helper.correctNull((String)hshRequestValues.get("date"));
			
            XSSFWorkbook wb = new XSSFWorkbook();
			
			XSSFCellStyle borderstyleright = wb.createCellStyle();
			
			
			XSSFCellStyle borderstyleleft = wb.createCellStyle();
			
			borderstyleleft.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			
			XSSFCellStyle borderstylecenter = wb.createCellStyle();
			
			borderstylecenter.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			
			XSSFSheet sheet = null;
			XSSFRow row = null;
			XSSFCell cell = null;
			
			
//			HSSFWorkbook wb = new HSSFWorkbook();
//			
//			HSSFCellStyle borderstyleright = wb.createCellStyle();
//			
//			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
//			
//			HSSFCellStyle borderstyleleft = wb.createCellStyle();
//			
//			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
//			
//			HSSFCellStyle borderstylecenter = wb.createCellStyle();
//			
//			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
//			
//			HSSFSheet sheet = null;
//			HSSFRow row = null;
//			HSSFCell cell = null;
			
			sheet = wb.createSheet("ROI Excel Report");
			
			row = sheet.createRow((int) intRowCount);
		
			for(int i=0;i<strHeaders.length;i++)
			{
				sheet.setColumnWidth(i, Integer.parseInt(strHeadersSize[i]));
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeaders[i]);
				cell.setCellStyle(borderstylecenter);
				intCellCount++;
			}
			
			String strPreviousVal = "";
			int rows_count = 0;
			int rows_count_actual = 1;
			intRowCount++;
			int m=0;
			strQuery = SQLParser.getSqlQuery("getonlyfbilldataforxl");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				intCellCount=0;
				
				row = sheet.createRow((int)  intRowCount);
				
				
				cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(Integer.toString(rows_count_actual++));//1
		    	cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
				
				
				
				cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("DESCRIPTION")));//2
		    	//cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("MCLR_BASERATESPREAD")));//3
		    	cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("MCLR_TABLECODE")));//4
		    	cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("MCLR_TABLECODEOVERDRAFTS")));//5
		    	cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
		    	
		    	cell = row.createCell(intCellCount);
		    	cell.setCellValue(HSSFCell.CELL_TYPE_STRING);
		    	cell.setCellValue(correctNull(rs.getString("EFFDATE")));//6
		    	cell.setCellStyle(borderstylecenter);
		    	intCellCount++;
		    	
		    	intRowCount++;
			}
			
			String path="/Temp Folder";
			log.info("Report Location==="+path);
			if(!path.equalsIgnoreCase(""))
			{
				File foldername = null;
				
				foldername=new File(path);
				if(!foldername.exists())
				{
					foldername.mkdirs();
				}
				FileOutputStream fOut = new FileOutputStream(path+"/EXE_"+txt_qenddate.replace("/", "")+".xlsx");
				//hshresult.put("workbook",wb);
				hshresult.put("FileDownload",path+"/EXE_"+txt_qenddate.replace("/", "")+".xlsx");
				hshresult.put("FileName","EXE_"+txt_qenddate.replace("/", "")+".xlsx");
				hshresult.put("strFinancialDn","N");
				wb.write(fOut);
				fOut.flush();
				fOut.close();
			}
		}
		catch(Exception exception)
		{
			throw new EJBException("Error in Excel Export " + exception.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshresult;
		
	}
	public HashMap updateSpreadvalueforfbil(HashMap hshRequestValues)
	{
		String strExp="";
		String strmsg="";
		ResultSet rs=null;
		String strExcelflag=Helper.correctNull((String)hshRequestValues.get("strExcelflag"));
		String strFileName=Helper.correctNull((String)hshRequestValues.get("strFileName"));
		try
		{
            byte[] byteData=(byte[])hshRequestValues.get("stream");
            if(!strExcelflag.equalsIgnoreCase("SUCCESS"))
         	{
         		throw new Exception(strExcelflag);
         	}
            if(byteData!=null)
            {
            	ByteArrayInputStream inputStream = new ByteArrayInputStream(byteData);
            	
            	 XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
            	 
            	 
				HashMap hshRecord= new HashMap();
				ArrayList arrRow = new ArrayList();
				ArrayList arrCol = null;
				XSSFSheet  sheet = workbook.getSheetAt(0);
				int columns =0;
				int rows =0;
				int intCount=0;
				ArrayList arrValues=new ArrayList();
				HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				int intRow=0,intExecutionNo=0;
				
				/*rs=DBUtils.executeLAPSQuery("selmaxexecutionno");
				if(rs.next())
				{
					intExecutionNo=rs.getInt("sno");
				}
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("selmaxbackuptable_exeno");
				if(rs.next())
				{
					if(intExecutionNo<rs.getInt("sno"))
					{
						intExecutionNo=rs.getInt("sno");
					}
				}
				
				++intExecutionNo;*/
				
				XSSFWorkbook wb = new XSSFWorkbook();
				
				XSSFCellStyle borderstyleright = wb.createCellStyle();
				
				borderstyleright.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
				
				XSSFCellStyle borderstyleleft = wb.createCellStyle();
				
				borderstyleleft.setAlignment(XSSFCellStyle.ALIGN_LEFT);
				
				XSSFCellStyle borderstylecenter = wb.createCellStyle();
				
				borderstylecenter.setAlignment(XSSFCellStyle.ALIGN_CENTER);
				borderstylecenter.setLocked(true);
				
				XSSFSheet hssheet = null;
				XSSFRow hsrow = null;
				XSSFCell hscell = null;
				
				
				for(int i=0;i<3;i++)
				{
					sheet = workbook.getSheetAt(i);
					
					hssheet = wb.createSheet(sheet.getSheetName());
					hssheet.protectSheet("Kb!Pr0DUCTSp63D");
					int currentRowIndex=0;
					int rowCount=sheet.getLastRowNum(); 
					if(rowCount>0)
					{
						for(int a=0;a<rowCount;a++)
						{
							Row row = sheet.getRow(a);
							hssheet.createRow(a);
							
							int cellCount=27;
							if(i==0)
								cellCount=29;
							
							for(int b=0;b<cellCount;b++)
							{
								Cell cell = sheet.getRow(a).getCell(b);
								if(cell!=null)
									hssheet.getRow(a).createCell(b).setCellValue(cell.toString());
								else
									hssheet.getRow(a).createCell(b).setCellValue("");
							}
							
						}
						
						for(int a=1;a<rowCount;a++)
						{
							Row row = sheet.getRow(a);
							hssheet.createRow(a);
							
							int cellCount=27;
							if(i==0)
								cellCount=29;
							
							Cell cell = sheet.getRow(a).getCell(0);

							if(cell!=null && !(cell.toString()).equalsIgnoreCase(""))
							{
								hshRecord=new HashMap();
								arrCol= new ArrayList();
								hshRecord.put("strQueryId", "ins_prdfac_spreaddetails");
								++intCount;
								for(int b=0;b<cellCount;b++)
								{
									Cell cell1 = sheet.getRow(a).getCell(b);
									
									if((i==1 || i==2) &&(b==6||b==10))
									{
										arrCol.add("");
									}
									
									if(cell1!=null)
										arrCol.add(Helper.correctNull(cell1.toString()));
									else
										arrCol.add("");
								}
								
								if(i==0)
									arrCol.add("P");
								else if(i==1)
									arrCol.add("A");
								else
									arrCol.add("C");	
								arrCol.add(String.valueOf(a+1));
								arrCol.add(Helper.correctNull((String)hshRequestValues.get("strUserId")));
								arrCol.add(String.valueOf(intExecutionNo));
								arrCol.add(String.valueOf(++intRow));
								hshRecord.put("arrValues",arrCol);
								hshQueryValues.put(String.valueOf(intCount),hshRecord);
								hshQueryValues.put("size",String.valueOf(intCount));
							}
							
						}
					}
					
				}
				
				if(intCount>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
				
				String path="/Temp Folder";
				rs = DBUtils.executeLAPSQuery("getstaticdata_soldid^32^SPREADEXCELLOC");
				if(rs.next())
				{
					path = Helper.correctNull((String)rs.getString("stat_data_desc1"));
				}
				log.info("Excel Location==="+path);
				if(!path.equalsIgnoreCase(""))
				{
					File foldername = null;
					
					foldername=new File(path);
					if(!foldername.exists())
					{
						foldername.mkdirs();
					}
					FileOutputStream fOut = new FileOutputStream(path+"/"+strFileName+"_"+Helper.getCurrentDateandTime()+"_"+intExecutionNo+"_"+Helper.correctNull((String)hshRequestValues.get("strUserId"))+".xls");
					wb.write(fOut);
					fOut.flush();
					fOut.close();
				}
				
				strmsg="Success";
				hshRequestValues.put("msg",strmsg);
            }
            else
            {
            	strExp="$Select the Valid Excel Sheet to Upload!!";
            	throw new Exception(strExp);
            }
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw new EJBException(e.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			}
			catch(Exception exception2)
			{
				throw new EJBException("Error closing the connection " + exception2.getMessage());
			}
		}
		return hshRequestValues;
	}
	
}
