/******************************************************************************
 * Package:			com.sai.laps.ejb.perrepappstatus
 * File:			PerRepAppStatusBean.java
 * Description:		Bean Implementation Class for Application Status  Report
 * @author			R.Saraswathi 
 ******************************************************************************/
package com.sai.laps.ejb.perrepappstatus;


import java.io.File;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.sql.SQLPermission;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import com.sai.laps.ejb.financial.FinancialBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "PerRepAppStatusBean", mappedName = "PerRepAppStatusHome")
@Remote (PerRepAppStatusRemote.class)

public class PerRepAppStatusBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tempOffset = "10";
	
	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";
        
		try
		{
			strMethod=correctNull((String)hshValues.get("hidMethod"));

			if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getRepDetails1"))
			{
				hshRecord =(HashMap)getRepDetails1(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList1"))
			{
				hshRecord =(HashMap)getParamList1(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getMonitoringReport"))
			{
				hshRecord =(HashMap)getMonitoringReport(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getMonitoringAnnexureD"))
			{
			   hshRecord =(HashMap)getMonitoringAnnexureD(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getMonitoringSanction"))
			{
			   hshRecord =(HashMap)getMonitoringSanction(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getStateCityReport"))
			{
			   hshRecord =(HashMap)getStateCityReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getMonitoringReportOthers"))
			{
				hshRecord =(HashMap)getMonitoringReportOthers(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getMMRReport"))
			{
				hshRecord =(HashMap)getMMRReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getTermLoanReviewReport"))
			{
				hshRecord =(HashMap)getTermLoanReviewReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getSanctionedloanReport"))
			{
				hshRecord =(HashMap)getSanctionedloanReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getAppRegisterReport"))
			{
				hshRecord =(HashMap)getAppRegisterReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOnlineReport"))
			{
				hshRecord =(HashMap)getOnlineReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getLsrrReport"))
			{
				hshRecord =(HashMap)getLsrrReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getAppOFRReport"))
			{
				hshRecord =(HashMap)getOFRReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getCorpRatingReport"))
			{
				hshRecord =(HashMap)getCorpRatingReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getPoolBasedRatingReport"))
			{
				hshRecord =(HashMap)getPoolBasedRatingReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getOnlineReportAnnexure1"))
			{
				hshRecord =(HashMap)getOnlineReportAnnexure1(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getSecValuatinReport"))
			{
				hshRecord =(HashMap)getSecValuatinReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getSecVerifPendingdata"))
			{
				hshRecord =(HashMap)getSecVerifPendingdata(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getemandateDetails"))
			{
				hshRecord =(HashMap)getemandateDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getemandateDetailsExcel"))
			{
				hshRecord =(HashMap)getemandateDetailsExcel(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getCGTMSEReport"))
			{
				hshRecord =(HashMap)getCgtmseRunReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getCGTMSEExcel"))
			{
				hshRecord =(HashMap)getCGTMSEExcelReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getAppSpreadData"))
			{
				hshRecord =(HashMap)getAppSpreadDataReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getSpreadSheetExcel"))
			{
				hshRecord =(HashMap)getSpreadSheetExcelReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getDataValuationReport"))
			{
				hshRecord =(HashMap)getDataValuationReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getXLDataValuationReport"))
			{
				hshRecord =(HashMap)getXLDataValuationReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getMsmeReport"))
			{
				hshRecord =(HashMap)getMsmeReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getsolvencyReport"))
			{
				hshRecord =(HashMap)getsolvencyReport(hshValues);   
			}

			else if (strMethod.equalsIgnoreCase("getCreditSaleReport"))
			{
				hshRecord =(HashMap)getCreditSaleReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getXLCreditSaleReport"))
			{
				hshRecord =(HashMap)getXLCreditSaleReport(hshValues);   
			}
			else if (strMethod.equalsIgnoreCase("getDCOEReport"))
			{
				hshRecord =(HashMap)getDCOEReport(hshValues);
			}
			
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getSpreadSheetExcelReport(HashMap hshValues) {


		String strEnchancement=null,strOD=null;
		String reportType1="";
		int intRowCount=0,intCellCount=0;
		ArrayList arrCol=new ArrayList();
		try
		{
			hshValues=getAppSpreadDataReport(hshValues);

			HSSFWorkbook wb = new HSSFWorkbook();
			wb.isWriteProtected();
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			arrCol=(ArrayList)hshValues.get("arrRow");

			HSSFFont boldfont2 = wb.createFont();
			boldfont2.setFontName("Verdana");
			boldfont2.setColor(HSSFFont.COLOR_NORMAL);
			boldfont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			borderstylecenter.setFont(boldfont2);

			HSSFCellStyle boldstyle= wb.createCellStyle();
			boldstyle.setBorderLeft(HSSFColor.AQUA.index);
			boldstyle.setBorderRight(HSSFColor.AQUA.index);
			boldstyle.setBorderBottom(HSSFColor.AQUA.index);
			boldstyle.setBorderTop(HSSFColor.AQUA.index);
			boldstyle.setFont(boldfont2);
			boldstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);


			HSSFCellStyle bldborcolstyle= wb.createCellStyle();
			bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
			bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
			bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
			bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);	    	
			bldborcolstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	    	
			bldborcolstyle.setWrapText(true);	    	
			bldborcolstyle.setFont(boldfont2);

			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			String reportType=Helper.correctNull((String)hshValues.get("reportType"));
			int intFcnt = Helper.parseInt((String)hshValues.get("intFundcnt"));
			int intNFcnt = Helper.parseInt((String)hshValues.get("intNonfundcnt"));
			int intPromocnt = Helper.parseInt((String)hshValues.get("intPromocnt"));

			
			sheet = wb.createSheet("Spreadsheet Report");
        	String str_newline=Helper.correctNull((String)hshValues.get("labels"));
			String strHeadersSize[]=str_newline.split(",");

			intCellCount=0; 
			intRowCount++;
			row = sheet.createRow((short) intRowCount);

			for(int i=0;i<strHeadersSize.length;i++)
			{
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeadersSize[i]);
				cell.setCellStyle(bldborcolstyle);
				sheet.autoSizeColumn(intCellCount);
				intCellCount++;


			}

			String strPreviousVal = "",temp="";
			int rows_count = 0;
			int rows_count_actual = 1;
			int sno=1;
			boolean boolSameCust = true;
			int size=0;

			if(arrCol!=null && arrCol.size()>0)
			{
				for(int i=0;i<arrCol.size();i++)
				{
					intCellCount=0; 
					intRowCount++;
					row = sheet.createRow((short) intRowCount);
					ArrayList arrayData=(ArrayList)arrCol.get(i);

					//int intFcnt=10,intNFcnt=10;
					{
						for(int k=0;k<arrayData.size();k++){
							{
								String tempVal= "";
								if(!(k==40))
									tempVal=Helper.correctNull((String)arrayData.get(k));

								if (tempVal.equals(" "))
								{
									tempVal=" ";
								}	
								if((k==28))
								{

									int intTemp=0;
									if(k==11)
										intTemp=intFcnt;
									else
										intTemp=intNFcnt;	

									String[] strArr=((String)arrayData.get(k)).split("@");

									for(int a=0;a<strArr.length;a++)
									{
										String[] strArr1=strArr[a].split("~");
										if(strArr1!=null && strArr1.length>1)
										{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(strArr1[0]);
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(strArr1[1]);
											intCellCount++;
										}else{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

										}

									}

									for(int a=strArr.length;a<intTemp;a++)
									{
										cell = row.createCell(intCellCount);
										cell.setCellType(HSSFCell.CELL_TYPE_STRING);
										cell.setCellValue(" ");
										intCellCount++;

										cell = row.createCell(intCellCount);
										cell.setCellType(HSSFCell.CELL_TYPE_STRING);
										cell.setCellValue(" ");
										intCellCount++;
									}
								}

								else if((k==40))
								{
									ArrayList arr1=(ArrayList)arrayData.get(40);
									ArrayList arr2=(ArrayList)arrayData.get(41);
									ArrayList arr3=(ArrayList)arrayData.get(42);


									if(arr1!=null && arr1.size()>0)
									{
										for(int a=0;a<arr1.size();a++)
										{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr1.get(a));
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr2.get(a));
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr3.get(a));
											intCellCount++;

										}

										if(intPromocnt>arr1.size())
										{
											for(int a=arr1.size();a<intPromocnt;a++)
											{

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

											}

										}
										k=k+2;
									}
									else
									{
										for(int a=0;a<intPromocnt;a++)
										{

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

										}
										k=k+2;
									}
								}


								else{
									cell = row.createCell(intCellCount);
									cell.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell.setCellValue(tempVal);
									intCellCount++;
								}
							}



							File foldername = null;


							String path=ApplicationParams.getStrdoclocation()+"/e-Mandate/";
							foldername=new File(path);
							if(!foldername.exists())
							{
								foldername.mkdirs();
							}
							String strFileName="REPORTS3";
							FileOutputStream fOut = new FileOutputStream(strFileName);
							hshValues.put("FileDownLoad",strFileName);
							hshValues.put("strFinancialDn","emandate");

							wb.write(fOut);

							fOut.flush();
							fOut.close();
						}
					}
				}
			}
		}

		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
		}
		finally
		{
			try
			{
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshValues;


	
	}

	private HashMap getAppSpreadDataReport(HashMap hshValues) {

		ResultSet rs = null, rs1 = null, rs2 = null;
		ArrayList arrRow = new ArrayList();
		HashMap hshRec = new HashMap();
		HashMap hshQuery = null;
		int intsize=0;
		ArrayList arrCol =null;
		String strQuery=null;
		String strOrg = null;
		String orglevel=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrg_Name ="";
		String strloantype="",appno="";
		String reportType="";
		String strExcelField=null;
		String strODExcelFIled=null;
		HashMap hshResults=new HashMap();
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		String strFinancialYear="",strFinancialYear1="",strFinancialYear2="";
		String strHeader="";
		int intFundcnt=0,intNonfundcnt=0,intTempcnt=0;
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strFromDate =(String)hshValues.get("txtFromDate");
			strToDate =(String)hshValues.get("txtToDate");
			strGen =(String)hshValues.get("strUserId");
			reportType=(String)hshValues.get("report");
			strOrg =correctNull((String)((String)hshValues.get("hidOrgCode")).replace("'",""));
			orglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=(String)hshValues.get("hidOrgName");
			strDepartment=correctNull((String)hshValues.get("seldepartment"));
			strDesignation=correctNull((String)hshValues.get("seldesignation"));
			//Front end serial no and display date
			String strFromDateEnd =(String)hshValues.get("txtFromDate");
			String strToDateEnd =(String)hshValues.get("txtToDate");
	        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy");
	        String newDateStr = simpleDateFormat.format(simpleDateFormat.parse(strFromDateEnd.substring(8)));
	        String newDateStr1 = simpleDateFormat.format(simpleDateFormat.parse(strToDateEnd.substring(8)));
	        int size=0;
			if(orglevel.equalsIgnoreCase("C"))//head office
			{
				strOrg=strOrg.substring(0,3)+"%";
			}
			else if (orglevel.equalsIgnoreCase("R") || orglevel.equalsIgnoreCase("CPC"))
			{
				strOrg=strOrg.substring(0,6)+"%";
			}
			else if (orglevel.equalsIgnoreCase("D"))
			{
				strOrg=strOrg.substring(0,9)+"%";
			}
			else if (orglevel.equalsIgnoreCase("A"))
			{
				strOrg=strOrg.substring(0,12)+"%";
			}
			else if (orglevel.equalsIgnoreCase("B"))
			{
				strOrg=strOrg;
			}
		
		 if (rs != null) {
				rs.close();
			}
        	strExcelField="MODULE TYPE,CODE NUMBER,INTEREST NUMBER,SUB NUMBER,AMOUNT FROM,AMOUNT TO,TENOR FROM," +
				"TENOR TO,ROI TYPE,REFERENCE TYPE,SCORE FROM,SCORE TO,RATING SCORE," +
				"SECTOR,CREDIT RISK VALUATION,BUSINESS STATICS VALUATION,EXECUTION NUMBER,EXECUTION DATE,EXECUTION FLAG," +
				"MODIFICATION,CREDIT SCORE AFTER,BUSINESS STATICS AFTER,PRODUCT PURPOSE,DESCRIPTION,PRODUCT TYPE,BANK SCHEME";
        	
				rs = DBUtils.executeLAPSQuery("sel_appspreadsheet_details^"+strFromDate+"^"+strToDate);
				while(rs.next()){
					arrCol=new ArrayList();
				
					arrCol.add(Helper.correctNull(rs.getString("PRD_MODULETYPE")));  //0
					arrCol.add(Helper.correctNull(rs.getString("PRD_CODE"))); //1
					arrCol.add(Helper.correctNull(rs.getString("PRD_INTSNO"))); //2
					arrCol.add(Helper.correctNull(rs.getString("PRD_INTSUBSNO"))); //3
					arrCol.add(Helper.correctNull(rs.getString("PRD_INTAMTFROM"))); //4
					arrCol.add(Helper.correctNull(rs.getString("PRD_INTAMTTO"))); //5
					arrCol.add(Helper.correctNull(rs.getString("PRD_TENORFROM"))); //6
					arrCol.add(Helper.correctNull(rs.getString("PRD_TENORTO"))); //7
					arrCol.add(Helper.correctNull(rs.getString("PRD_INTROITYPE"))); //8
					arrCol.add(Helper.correctNull(rs.getString("PRD_REFERENCETYPE"))); //9
					arrCol.add(Helper.correctNull(rs.getString("PRD_SCOREFROM"))); //10
					arrCol.add(Helper.correctNull(rs.getString("PRD_SCORETO")));//11
					arrCol.add(Helper.correctNull(rs.getString("PRD_RATINGSCORE")));//12
					arrCol.add(Helper.correctNull(rs.getString("PRD_SECTOR")));//13
					arrCol.add(Helper.correctNull(rs.getString("PRD_CREDITRSKVAL")));//14
					arrCol.add(Helper.correctNull(rs.getString("PRD_BUSSSTATVAL")));//15
					arrCol.add(Helper.correctNull(rs.getString("APP_EXECUTIONNO")));//16
					arrCol.add(Helper.correctNull(rs.getString("APP_EXEDATE")));//17
					arrCol.add(Helper.correctNull(rs.getString("APP_EXEFLAG")));//18
					arrCol.add(Helper.correctNull(rs.getString("APP_MODIFICATION")));//19
					arrCol.add(Helper.correctNull(rs.getString("PRD_CREDITRSKVAL_AFTER")));//20
					arrCol.add(Helper.correctNull(rs.getString("PRD_BUSSSTATVAL_AFTER")));//21
					arrCol.add(Helper.correctNull(rs.getString("PRODUCT_PURPOSE"))); //22
					arrCol.add(Helper.correctNull(rs.getString("PRODUCT_DESCRIPTION"))); //23
					arrCol.add(Helper.correctNull(rs.getString("PRODUCT_TYPE"))); //24
					arrCol.add(Helper.correctNull(rs.getString("BANK_SCHEME"))); //25	
					arrRow.add(arrCol);		
				}
				
	    	hshRec.put("labels",strExcelField);
			hshRec.put("arrRow", arrRow);
			hshRec.put("strFromDate",strFromDate);
			hshRec.put("strToDate",strToDate);
			hshRec.put("org_name",strOrg_Name);
			hshRec.put("reportType",reportType);
			hshRec.put("strHeader",strHeader);
			hshRec.put("intFundcnt",String.valueOf(intFundcnt));
			hshRec.put("intNonfundcnt",String.valueOf(intNonfundcnt));
		
			}

		
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRec;

	
	}
	

	private HashMap getMonitoringAnnexureD(HashMap hshValues) 
	{

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{
		
			String strLimitFrom = correctNull((String)hshValues.get("txtlimitfrom"));
			String strLimitTo = correctNull((String)hshValues.get("txtlimitto"));
		
			String selLevel = correctNull((String)hshValues.get("sellevel"));
			String strorg_name = correctNull((String)hshValues.get("org_name"));
			String straccstatus = correctNull((String)hshValues.get("accstatus"));
			
			StringBuffer strBillAppendQuery = new StringBuffer();
			StringBuffer strAppenQuery = new StringBuffer();
			
			String rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			
			// this coding for selecting multiple regional, branch, zone etc
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("branchcode like '").append("001%").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" branchcode like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append("or branchcode like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" branchcode like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("(");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" branchcode like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or branchcode like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" branchcode like '").append(rpselect1.substring(0,9)).append("%'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append(" branchcode = ").append(rpselect1);
			}
			
			strBillAppendQuery.append(strAppenQuery);
			if(!strLimitFrom.equals(""))
			{
				strAppenQuery.append(" and sanctionedamount between ").append(strLimitFrom).append(" and ").append(strLimitTo);
			}
	
			/*String annexured[][]={{"0","0.00","0","0.00","0","0.00"},
					{"0","0.00","0","0.00","0","0.00"},
					{"0","0.00","0","0.00","0","0.00"},
					{"0","0.00","0","0.00","0","0.00"},
					{"0","0.00","0","0.00","0","0.00"},
			};*/
			
			//hshRecord = getAnnexureDForBranch(hshValues,strAppenQuery.toString(),strBillAppendQuery.toString());
			String strQuery ="";
			hshRecord.put("E1LDCOUNT","0");
			hshRecord.put("E1LDOSAMT","0.00");
			hshRecord.put("E2LDCOUNT","0");
			hshRecord.put("E2LDOSAMT","0.00");
			hshRecord.put("SMALDCOUNT","0");
			hshRecord.put("SMALDOSAMT","0.00");
			
			hshRecord.put("E1NRCOUNT","0");
			hshRecord.put("E1NROSAMT","0.00");
			hshRecord.put("E2NRCOUNT","0");
			hshRecord.put("E2NROSAMT","0.00");
			hshRecord.put("SMANRCOUNT","0");
			hshRecord.put("SMANROSAMT","0.00");
			
			hshRecord.put("E1NICOUNT","0");
			hshRecord.put("E1NIOSAMT","0.00");
			hshRecord.put("E2NICOUNT","0");
			hshRecord.put("E2NIOSAMT","0.00");
			hshRecord.put("SMANICOUNT","0");
			hshRecord.put("SMANIOSAMT","0.00");
			
			hshRecord.put("E1DDCOUNT","0");
			hshRecord.put("E1DDOSAMT","0.00");
			hshRecord.put("E2DDCOUNT","0");
			hshRecord.put("E2DDOSAMT","0.00");
			hshRecord.put("SMADDCOUNT","0");
			hshRecord.put("SMADDOSAMT","0.00");
			
			hshRecord.put("E1ODCOUNT","0");
			hshRecord.put("E1ODOSAMT","0.00");
			hshRecord.put("E2ODCOUNT","0");
			hshRecord.put("E2ODOSAMT","0.00");
			hshRecord.put("SMAODCOUNT","0");
			hshRecord.put("SMAODOSAMT","0.00");
			
			strQuery=SQLParser.getSqlQuery("sel_AnnexureD^"+strAppenQuery+"^"+straccstatus);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				
				//loan Default
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("001"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("002")))
				{
					hshRecord.put("E1LDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E1LDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("001"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("003")))
				{
					hshRecord.put("E2LDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E2LDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("001"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("004")))
				{
					hshRecord.put("SMALDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("SMALDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				
				//Non-renewal
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("003"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("002")))
				{
					hshRecord.put("E1NRCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E1NROSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("003"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("003")))
				{
					hshRecord.put("E2NRCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E2NROSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("003"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("004")))
				{
					hshRecord.put("SMANRCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("SMANROSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				//Non-Inspection
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("004"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("002")))
				{
					hshRecord.put("E1NICOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E1NIOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("004"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("003")))
				{
					hshRecord.put("E2NICOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E2NIOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("004"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("004")))
				{
					hshRecord.put("SMANICOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("SMANIOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				//Doc-Defficiency
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("005"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("002")))
				{
					hshRecord.put("E1DDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E1DDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("005"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("003")))
				{
					hshRecord.put("E2DDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E2DDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("005"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("004")))
				{
					hshRecord.put("SMADDCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("SMADDOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				//Other-Default
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("006"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("002")))
				{
					hshRecord.put("E1ODCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E1ODOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("006"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("003")))
				{
					hshRecord.put("E2ODCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("E2ODOSAMT",correctNull(rs.getString("outstandingamt")));
				}
				
				if((correctNull(rs.getString("alertfor")).equalsIgnoreCase("006"))
						&& (correctNull(rs.getString("assetclassification")).equalsIgnoreCase("004")))
				{
					hshRecord.put("SMAODCOUNT",correctNull(rs.getString("cnt")));
					hshRecord.put("SMAODOSAMT",correctNull(rs.getString("outstandingamt")));
				}
			}
			hshRecord.put("org_name",strorg_name);
			if(selLevel.equalsIgnoreCase("R"))
			{
				selLevel="FGMO";
			}
			else if(selLevel.equalsIgnoreCase("D"))
			{
				selLevel="RO";
			}
			else if(selLevel.equalsIgnoreCase("A"))
			{
				selLevel="Branch";
			}
			else
			{
				selLevel="";
			}
			hshRecord.put("selLevel",selLevel);
			hshRecord.put("LimitFrom",strLimitFrom);
			hshRecord.put("LimitTo",strLimitTo);
			hshRecord.put("accstatus",straccstatus);
		}
		
		
		catch(Exception e)
		{
			throw new EJBException("Exception inside getMonitoringAnnexureD"+e.toString());
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
				throw new EJBException("Exception while closing the connection"+e.toString()); 
			}
		}
		
		return hshRecord;
	
	}

	/*private HashMap getAnnexureDForBranch(HashMap hshValues,String strAppenQuery,String strBillAppendQuery) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		String totalcount[][] = new String[5][7];
		String osamt[][] = new String[5][7];
		
		try
		{

				
		
			String strQuery ="";
			
			strQuery = SQLParser
					.getSqlQuery("selloandefaultforallscheme^>^>^<^"
							+ (strAppenQuery) + "^>^<^"
							+ (strAppenQuery.toString()) + "^>^>^<^"
							+ (strBillAppendQuery) + "^>^>^>^<^"
							+ (strAppenQuery) + "^>^<^" + (strAppenQuery)
							+ "^>^<^" + (strBillAppendQuery) + "^>^<^"
							+ (strBillAppendQuery));
			
			
				
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				totalcount[Integer.parseInt(Helper.correctInt(rs.getString("b")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("a")))] = correctNull(rs.getString("totalcount"));
				
				osamt[Integer.parseInt(Helper.correctInt(rs.getString("b")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("a")))] = correctNull(rs.getString("OSAMT"));
				
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser
					.getSqlQuery("selannexuredfordefiencydocument^" + (strBillAppendQuery)
							+ "^" + (strBillAppendQuery) + "^"
							+ (strBillAppendQuery) + "^" + (strBillAppendQuery)+"^>^"
							+ (strBillAppendQuery) + "^<^" + (strBillAppendQuery)
							+ "^>^" + (strBillAppendQuery) + "^>^"
							+ (strBillAppendQuery));
	
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				totalcount[Integer.parseInt(Helper.correctInt(rs.getString("b")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("a")))] = correctNull(rs.getString("totalcount"));
				
				osamt[Integer.parseInt(Helper.correctInt(rs.getString("a")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("b")))] = correctNull(rs.getString("OSAMT"));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser
			.getSqlQuery("selannexuredforotherdefault^"
					+ "> 30^" + "<=60^" + strBillAppendQuery + "^" + "> 30^" + "<=60^"
					+ strBillAppendQuery + "^" + "> 30^" + "<=60^" + strBillAppendQuery
					+ "^" + "> 30^" + "<=60^" + strBillAppendQuery);
	
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				totalcount[Integer.parseInt(Helper.correctInt(rs.getString("b")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("a")))] = correctNull(rs.getString("totalcount"));
				
				osamt[Integer.parseInt(Helper.correctInt(rs.getString("a")))]
				           [Integer.parseInt(Helper.correctInt(rs.getString("b")))] = correctNull(rs.getString("OSAMT"));
			}
			
			if(rs!=null)
				rs.close();
			
			
			hshRecord.put("totalcount",totalcount);
			hshRecord.put("osamt",osamt);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	
		
	}*/

	private HashMap getMonitoringReportOthers(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{
		
			tempOffset = correctNull((String)hshValues.get("rowsrange"));
			String parameterSelect = correctNull((String)hshValues.get("parameterselect"));
			String accountClassification = correctNull((String)hshValues.get("accountclasssel"));
			String strLimitFrom = correctNull((String)hshValues.get("txtlimitfrom"));
			String strLimitTo = correctNull((String)hshValues.get("txtlimitto"));
			String strOustandingFrom = correctNull((String)hshValues.get("txtoutstandingfrom"));
			String strOustandingTo = correctNull((String)hshValues.get("txtoutstandingto"));
			String strExcessFrom = correctNull((String)hshValues.get("txtexcessfrom"));
			String strExcessTo = correctNull((String)hshValues.get("txtexcessto"));
			String selLevel = correctNull((String)hshValues.get("sellevel"));
			String limit = correctNull((String)hshValues.get("limit"));
			String offset = correctNull((String)hshValues.get("offset"));
			String tempTableCheck = correctNull((String)hshValues.get("tempTableCheck"));
			String straccount_class= correctNull((String)hshValues.get("hidaccclass_text"));
			String straccstatus= correctNull((String)hshValues.get("accstatus"));
			
			String strparamtext= correctNull((String)hshValues.get("hidparameterselect_text"));
			String straccstatustext= correctNull((String)hshValues.get("hidaccountstatus_text"));
			
			String strschemecode=correctNull((String)hshValues.get("schemecode")); 
			
			StringBuffer strBillAppendQuery = new StringBuffer();
			StringBuffer strAppenQuery = new StringBuffer();
			StringBuffer strSchemeQuery =new StringBuffer();
			StringBuffer strLCSchemeAppenQuery=new StringBuffer();
			
			String rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			String strbillstype="";
			// this coding for selecting multiple regional, branch, zone etc
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and ORG_CODE like '").append("001%").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" ORG_CODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append("or ORG_CODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and ORG_CODE like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" ORG_CODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or ORG_CODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and ORG_CODE like '").append(rpselect1.substring(0,9)).append("%'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append(" and ORG_CODE in (").append(rpselect1).append(")");
			}
			else if(selLevel.equals("B"))
			{
				strAppenQuery.append(" and ORG_CODE in (").append(rpselect1).append(")");
			}
			
			
			strBillAppendQuery.append(strAppenQuery);
			
			
				if(!strLimitFrom.equals(""))
				{
					
					strAppenQuery.append(" and FUND_SANCAMT between ").append(strLimitFrom).append(" and ").append(strLimitTo);
					
					strBillAppendQuery.append(" and LIMIT_SANCTAMT between ").append(strLimitFrom).append(" and ").append(strLimitTo);
				}
			
			/*if(!strOustandingFrom.equals(""))
			{
				strAppenQuery.append(" and FUND_OSAMT between ").append(strOustandingFrom).append(" and ").append(strOustandingTo);
				
				strBillAppendQuery.append(" and BILLS_BILLAMT between ").append(strOustandingFrom).append(" and ").append(strOustandingTo);
			}
			if(!strExcessFrom.equals(""))
			{
				strAppenQuery.append(" and FUND_OVERDUEAMT between ").append(strExcessFrom).append(" and ").append(strExcessTo);
				strBillAppendQuery.append(" and BILLS_OVERDUEAMT between ").append(strExcessFrom).append(" and ").append(strExcessTo);
			}*/
			if(!strschemecode.equals(""))
			{
				if(strschemecode.equalsIgnoreCase("G"))
				{
				    strSchemeQuery.append("and fun.FUND_SCHEMECODE not in('DL002','DL003','DL004','DL011','DL012')");
				    strLCSchemeAppenQuery.append("and fun.FUND_SCHEMECODE in('DL002','DL003','DL004','DL011','DL012')");
				    strbillstype="'F','I'";
				}
				else if(strschemecode.equalsIgnoreCase("F"))
				{
					strSchemeQuery.append("and fun.FUND_SCHEMECODE in('DL021','DL022')");
					strLCSchemeAppenQuery.append("and fun.FUND_SCHEMECODE in('DL004','DL011','DL012')");
					strbillstype="'F'";
				}
			}
			
			if(parameterSelect.equals("001"))
			{
				hshRecord = getLoanDetailsReport(parameterSelect,accountClassification,strAppenQuery.toString(),strBillAppendQuery.toString(),limit,offset,tempTableCheck,straccstatus,strSchemeQuery.toString(),strLCSchemeAppenQuery.toString(),strbillstype);
			}
			else if(parameterSelect.equals("003"))
			{
			    hshRecord =  getNonRenewalAccount(parameterSelect,accountClassification,strBillAppendQuery.toString(),limit,offset,straccstatus);
			}
			else if(parameterSelect.equals("004"))
			{
				hshRecord =  getNonInspection(parameterSelect,accountClassification,strBillAppendQuery.toString(),limit,offset,straccstatus);
			}
			else if(parameterSelect.equals("005"))
			{
				hshRecord =  getDeficiencyDocument(parameterSelect,accountClassification,strBillAppendQuery.toString(),limit,offset,tempTableCheck,straccstatus);
			}
			else if(parameterSelect.equals("006"))
			{	
				hshRecord =  getOtherDefault(parameterSelect,accountClassification,strBillAppendQuery.toString(),limit,offset,tempTableCheck,straccstatus);
			}
			
			hshRecord.put("orgLevel",selLevel);
			hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
			hshRecord.put("account_class",straccount_class);
			hshRecord.put("parameter",strparamtext.toUpperCase());
			hshRecord.put("status",straccstatustext.toUpperCase());
			hshRecord.put("schemecode",strschemecode);
		}
		
		
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
	}

	private HashMap getOtherDefault(String parameterSelect, String accountClassification, String strAppenQuery,String limit, String offset,String tempTableCheck,String straccstatus) 
	{


		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			
			String strQuery ="",strdaysfrom="",strdaysto="";
			
			if(accountClassification.equalsIgnoreCase("003"))
			{
				strdaysfrom="30";
				strdaysto="60";
			}
			else if(accountClassification.equalsIgnoreCase("005"))
			{
				strdaysfrom="90";
				strdaysto="9999";
			}
			else if(accountClassification.equalsIgnoreCase("004"))
			{
				strdaysfrom="60";
				strdaysto="90";
			}
			else 
			{
				strdaysfrom="0";
				strdaysto="0";
			}
			
			/*if("1".equals(tempTableCheck))
			{
			
				strQuery=SQLParser.getSqlQuery("selotherdefaultsforstock^"+"> "+strdaysfrom+"^"+"<= "+strdaysto+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Other Defaults");
					
					arrRow.add(arrCol);
				}
			}*/
			
			 /*if(arrRow.size()< Double.parseDouble(tempOffset) && ("1".equals(tempTableCheck)))
			 {
					tempTableCheck ="2";
					limit = "0";
					offset = tempOffset;
			 }*/
			
			
			/* if("2".equals(tempTableCheck))
			 {
			
				strQuery=SQLParser.getSqlQuery("selotherdefaultsforbooks^"+"> "+strdaysfrom+"^"+"<= "+strdaysto+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
					arrCol.add("");
					arrCol.add("");
					arrCol.add("");
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Other Defaults");
					
					arrRow.add(arrCol);
				}
			 }*/	
			strQuery=SQLParser.getSqlQuery("selotherdefaultsforstockandbokkdebts^"+straccstatus+"^"+"> "+strdaysfrom+"^"+"<= "+strdaysto+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("ORG_NAME")));
				arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
				arrCol.add(correctNull(rs.getString("prd_desc")));
				arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
				arrCol.add("");
				arrCol.add("");
				arrCol.add("");
				if(accountClassification.equals("002"))
				{	
					arrCol.add("EAS - I");
				}
				else if(accountClassification.equals("003"))
				{
					arrCol.add("EAS - II");
				}
				else if(accountClassification.equals("004"))
				{
					arrCol.add("SMA");
				}
				else
				{
					arrCol.add("Standard");
				}
				//arrCol.add("Other Defaults");
				if(correctNull(rs.getString("MSU_SECU_CODE")).equalsIgnoreCase("107"))
				{
					arrCol.add("Non-Submission of Stock Statement");
				}
				else
				{
					arrCol.add("Non-Submission of BookDebt Statement");	
				}
				arrCol.add(correctNull(rs.getString("limit_cutaccno")));
				arrCol.add(correctNull(rs.getString("limit_accflag")));
				arrRow.add(arrCol);
			} 
			
			 limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			 offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
				
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			hshRecord.put("tempTableCheck",tempTableCheck);
			
			hshRecord.put("arrRow",arrRow);	
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	}
		
	
	
	

	private HashMap getDeficiencyDocument(String parameterSelect, String accountClassification, String strAppenQuery,String limit, String offset,String tempTableCheck,String straccstatus) 
	{


		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			
			String strQuery ="";
			
			 if(accountClassification.equals("003"))
			 {	 
				
				 if("1".equals(tempTableCheck))
				 {
					 strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforexpirydate^"+straccstatus+"^"+">^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
					
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrCol = new ArrayList();
						
						arrCol.add(correctNull(rs.getString("ORG_NAME")));
						arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
						arrCol.add(correctNull(rs.getString("prd_desc")));
						arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
						arrCol.add(correctNull(rs.getString("fund_osamt")));
						arrCol.add("");
						arrCol.add("");
						if(accountClassification.equals("002"))
						{	
							arrCol.add("EAS - I");
						}
						else if(accountClassification.equals("003"))
						{
							arrCol.add("EAS - II");
						}
						else if(accountClassification.equals("004"))
						{
							arrCol.add("SMA");
						}
						else
						{
							arrCol.add("Standard");
						}
						arrCol.add("Deficiency in Documentation");
						arrCol.add(correctNull(rs.getString("limit_cutaccno")));
						arrCol.add(correctNull(rs.getString("limit_accflag")));
						arrRow.add(arrCol);
					}
				}	
				 if(arrRow.size()< Double.parseDouble(tempOffset) && ("1".equals(tempTableCheck)))
				 {
						tempTableCheck ="2";
						limit = "0";
						offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
				 }
			
			 if("2".equals(tempTableCheck))
			 {
				strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforinsasset^"+straccstatus+"^"+"<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
					arrCol.add(correctNull(rs.getString("fund_osamt")));
					arrCol.add("");
					arrCol.add("");
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Deficiency in Documentation");
					arrCol.add(correctNull(rs.getString("limit_cutaccno")));
					arrCol.add(correctNull(rs.getString("limit_accflag")));
					arrRow.add(arrCol);
				}
			 }	
			 if(arrRow.size()<Double.parseDouble(tempOffset) && ("2".equals(tempTableCheck)))
			 {
					tempTableCheck ="3";
					limit = "0";
					offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			 }	
				
			 if("3".equals(tempTableCheck))
			 {
				    strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforvetteddetails^"+straccstatus+"^"+">^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
					
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrCol = new ArrayList();
						
						arrCol.add(correctNull(rs.getString("ORG_NAME")));
						arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
						arrCol.add(correctNull(rs.getString("prd_desc")));
						arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
						arrCol.add(correctNull(rs.getString("fund_osamt")));
						arrCol.add("");
						arrCol.add("");
						if(accountClassification.equals("002"))
						{	
							arrCol.add("EAS - I");
						}
						else if(accountClassification.equals("003"))
						{
							arrCol.add("EAS - II");
						}
						else if(accountClassification.equals("004"))
						{
							arrCol.add("SMA");
						}
						else
						{
							arrCol.add("Standard");
						}
						arrCol.add("Deficiency in Documentation");
						arrCol.add(correctNull(rs.getString("limit_cutaccno")));
						arrCol.add(correctNull(rs.getString("limit_accflag")));
						arrRow.add(arrCol);
					}
			 	}
			 if(arrRow.size()<Double.parseDouble(tempOffset) && ("3".equals(tempTableCheck)))
			 {
					tempTableCheck ="4";
					limit = "0";
					offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			 }	
				
			 if("4".equals(tempTableCheck))
			 {
				
					strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforDBCdetails^"+straccstatus+"^"+">^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
					
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrCol = new ArrayList();
						
						arrCol.add(correctNull(rs.getString("ORG_NAME")));
						arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
						arrCol.add(correctNull(rs.getString("prd_desc")));
						arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
						arrCol.add(correctNull(rs.getString("fund_osamt")));
						arrCol.add("");
						arrCol.add("");
						if(accountClassification.equals("002"))
						{	
							arrCol.add("EAS - I");
						}
						else if(accountClassification.equals("003"))
						{
							arrCol.add("EAS - II");
						}
						else if(accountClassification.equals("004"))
						{
							arrCol.add("SMA");
						}
						else
						{
							arrCol.add("Standard");
						}
						arrCol.add("Deficiency in Documentation");
						arrCol.add(correctNull(rs.getString("limit_cutaccno")));
						arrCol.add(correctNull(rs.getString("limit_accflag")));
						arrRow.add(arrCol);
					}
			 }
			 if(arrRow.size()<Double.parseDouble(tempOffset) && ("4".equals(tempTableCheck)))
			 {
					tempTableCheck ="5";
					limit = "0";
					offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			 }	
				
			 if("5".equals(tempTableCheck))
			 {
				
					strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforvalueddategreaterthanthree^"+straccstatus+"^"+">^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
					
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrCol = new ArrayList();
						
						arrCol.add(correctNull(rs.getString("ORG_NAME")));
						arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
						arrCol.add(correctNull(rs.getString("prd_desc")));
						arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
						arrCol.add(correctNull(rs.getString("fund_osamt")));
						arrCol.add("");
						arrCol.add("");
						if(accountClassification.equals("002"))
						{	
							arrCol.add("EAS - I");
						}
						else if(accountClassification.equals("003"))
						{
							arrCol.add("EAS - II");
						}
						else if(accountClassification.equals("004"))
						{
							arrCol.add("SMA");
						}
						else
						{
							arrCol.add("Standard");
						}
						arrCol.add("Deficiency in Documentation");
						arrCol.add(correctNull(rs.getString("limit_cutaccno")));
						arrCol.add(correctNull(rs.getString("limit_accflag")));
						arrRow.add(arrCol);
					}
			 	}	
			 }
			 else
			 {
				 
				 if("1".equals(tempTableCheck))
				 {
				 		strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforrocdetails^"+straccstatus+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
						
						rs=DBUtils.executeQuery(strQuery);
						
						while(rs.next())
						{
							arrCol = new ArrayList();
							
							arrCol.add(correctNull(rs.getString("ORG_NAME")));
							arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
							arrCol.add(correctNull(rs.getString("prd_desc")));
							arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
							arrCol.add(correctNull(rs.getString("fund_osamt")));
							arrCol.add("");
							arrCol.add("");
							if(accountClassification.equals("002"))
							{	
								arrCol.add("EAS - I");
							}
							else if(accountClassification.equals("003"))
							{
								arrCol.add("EAS - II");
							}
							else if(accountClassification.equals("004"))
							{
								arrCol.add("SMA");
							}
							else
							{
								arrCol.add("Standard");
							}
							arrCol.add("Deficiency in Documentation");
							arrCol.add(correctNull(rs.getString("limit_cutaccno")));
							arrCol.add(correctNull(rs.getString("limit_accflag")));
							arrRow.add(arrCol);
						}
				 	}	
					 if(arrRow.size()<Double.parseDouble(tempOffset) && ("1".equals(tempTableCheck)))
					 {
							tempTableCheck ="2";
							limit = "0";
							offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
					 }
				
					 if("2".equals(tempTableCheck))
					 {
						 strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforguarantordetails^"+straccstatus+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
							
							rs=DBUtils.executeQuery(strQuery);
							
							while(rs.next())
							{
								arrCol = new ArrayList();
								
								arrCol.add(correctNull(rs.getString("ORG_NAME")));
								arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
								arrCol.add(correctNull(rs.getString("prd_desc")));
								arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
								arrCol.add(correctNull(rs.getString("fund_osamt")));
								arrCol.add("");
								arrCol.add("");
								if(accountClassification.equals("002"))
								{	
									arrCol.add("EAS - I");
								}
								else if(accountClassification.equals("003"))
								{
									arrCol.add("EAS - II");
								}
								else if(accountClassification.equals("004"))
								{
									arrCol.add("SMA");
								}
								else
								{
									arrCol.add("Standard");
								}
								arrCol.add("Deficiency in Documentation");
								arrCol.add(correctNull(rs.getString("limit_cutaccno")));
								arrCol.add(correctNull(rs.getString("limit_accflag")));
								arrRow.add(arrCol);
							}
					 }
					 if(arrRow.size()<Double.parseDouble(tempOffset) && ("2".equals(tempTableCheck)))
					 {
							tempTableCheck ="3";
							limit = "0";
							offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
					 }
				
					 if("3".equals(tempTableCheck))
					 {
						
						 strQuery=SQLParser.getSqlQuery("selDocumentdeficiencyforequitymortgagedetails^"+straccstatus+"^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
							
							rs=DBUtils.executeQuery(strQuery);
							
							while(rs.next())
							{
								arrCol = new ArrayList();
								
								arrCol.add(correctNull(rs.getString("ORG_NAME")));
								arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
								arrCol.add(correctNull(rs.getString("prd_desc")));
								arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
								arrCol.add(correctNull(rs.getString("fund_osamt")));
								arrCol.add("");
								arrCol.add("");
								if(accountClassification.equals("002"))
								{	
									arrCol.add("EAS - I");
								}
								else if(accountClassification.equals("003"))
								{
									arrCol.add("EAS - II");
								}
								else if(accountClassification.equals("004"))
								{
									arrCol.add("SMA");
								}
								else
								{
									arrCol.add("Standard");
								}
								arrCol.add("Deficiency in Documentation");
								arrCol.add(correctNull(rs.getString("limit_cutaccno")));
								arrCol.add(correctNull(rs.getString("limit_accflag")));
								arrRow.add(arrCol);
							}
					 }		
					
			 }
				
				limit = "" + (Double.parseDouble(offset));
				offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
				
				hshRecord.put("limit",limit);
				hshRecord.put("offset",offset);
			hshRecord.put("tempTableCheck",tempTableCheck);
			hshRecord.put("arrRow",arrRow);	
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	
	
	}

	private HashMap getNonInspection(String parameterSelect, String accountClassification, String strAppenQuery,String limit, String offset,String straccstatus) 
	{

		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			
			String strQuery ="";
			
			
			strQuery=SQLParser.getSqlQuery("selNonInspectionmis^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("ORG_NAME")));
				arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
				arrCol.add(correctNull(rs.getString("prd_desc")));
				arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
				arrCol.add(correctNull(rs.getString("fund_osamt")));
				arrCol.add(correctNull(rs.getString("fund_overdueamt")));
				arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")));
				if(accountClassification.equals("002"))
				{	
					arrCol.add("EAS - I");
				}
				else if(accountClassification.equals("003"))
				{
					arrCol.add("EAS - II");
				}
				else if(accountClassification.equals("004"))
				{
					arrCol.add("SMA");
				}
				else
				{
					arrCol.add("Standard");
				}
				arrCol.add("Non - Inspection of Securities");
				arrCol.add(correctNull(rs.getString("limit_cutaccno")));
				arrCol.add(correctNull(rs.getString("limit_accflag")));
				arrRow.add(arrCol);
			}
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	
	}

	private HashMap getNonRenewalAccount(String parameterSelect, String accountClassification, String strAppenQuery,String limit, String offset,String straccstatus)
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			
			String strQuery ="";
			
			
			strQuery=SQLParser.getSqlQuery("selnonrenewalmis^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("ORG_NAME")));
				arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
				arrCol.add(correctNull(rs.getString("prd_desc")));
				arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
				arrCol.add(correctNull(rs.getString("fund_osamt")));
				arrCol.add(correctNull(rs.getString("fund_overdueamt")));
				arrCol.add(correctNull(rs.getString("limit_expirydate")));
				if(accountClassification.equals("002"))
				{	
					arrCol.add("EAS - I");
				}
				else if(accountClassification.equals("003"))
				{
					arrCol.add("EAS - II");
				}
				else if(accountClassification.equals("004"))
				{
					arrCol.add("SMA");
				}
				else
				{
					arrCol.add("Standard");
				}
				arrCol.add("Non Renewal of Limits");
				arrCol.add(correctNull(rs.getString("limit_cutaccno")));
				arrCol.add(correctNull(rs.getString("limit_accflag")));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow",arrRow);
			
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
		
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	}

	private HashMap getLoanDetailsReport(String parameterSelect, String accountClassification, String strAppenQuery, String strBillAppendQuery,String limit, String offset,String tempTableCheck,String straccstatus,String strSchemeQuery, String strLCAppenQuery,String strbillstype)
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		try
		{

			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			
			String strQuery ="";
			
			if("1".equals(tempTableCheck))
			{	
				strQuery=SQLParser.getSqlQuery("seloverdueseas^"+strSchemeQuery+"^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^>^<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
			
			
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("FUND_SANCAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OSAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")));
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Loan Default");
					arrCol.add(correctNull(rs.getString("fund_accno")));//
					arrCol.add(correctNull(rs.getString("FUND_OVERDUETYPE")));
					arrRow.add(arrCol);
				}
			}	
			
			if(arrRow.size()<Double.parseDouble(tempOffset) && ("1".equals(tempTableCheck)))
			{
				tempTableCheck ="2";
				limit = "0";
				offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			}
			
			if("2".equals(tempTableCheck))
			{	
				strQuery=SQLParser.getSqlQuery("seldormanteas^"+strSchemeQuery+"^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^<^"+(strAppenQuery.toString())+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("FUND_SANCAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OSAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")));
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Loan Default");
					arrCol.add(correctNull(rs.getString("fund_accno")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUETYPE")));
					arrRow.add(arrCol);
				}
			}	
			
			if(arrRow.size()<Double.parseDouble(tempOffset) && ("2".equals(tempTableCheck)))
			{
				tempTableCheck ="3";
				limit = "0";
				offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			}
			if(("3".equals(tempTableCheck)))
			{	
				strQuery=SQLParser.getSqlQuery("selbillseas^"+strbillstype+"^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^>^<^"+(strBillAppendQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("LIMIT_SANCTAMT")));
					arrCol.add(correctNull(rs.getString("BILLS_BILLAMT")));
					arrCol.add(correctNull(rs.getString("BILLS_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("BILLS_BILLDUEDATE")));
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Loan Default");
					arrCol.add(correctNull(rs.getString("bills_accno")));
					arrCol.add(correctNull(rs.getString("bills_accflag")));
					arrRow.add(arrCol);
				}
			}	
			if(arrRow.size()<Double.parseDouble(tempOffset) && ("3".equals(tempTableCheck)))
			{
				tempTableCheck ="4";
				limit = "0";
				offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			}
			if(("4".equals(tempTableCheck)))
			{	
				strQuery=SQLParser.getSqlQuery("selforExcessinWCeas^"+strSchemeQuery+"^"+parameterSelect+"^"+accountClassification+"^"+straccstatus+"^>^>^>^<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("FUND_SANCAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OSAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")));
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Loan Default");
					arrCol.add(correctNull(rs.getString("fund_accno")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUETYPE")));
					arrRow.add(arrCol);
				}
			}	
			if(arrRow.size()<Double.parseDouble(tempOffset) && ("4".equals(tempTableCheck)))
			{
				tempTableCheck ="5";
				limit = "0";
				offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
			}
			
			
			if(("5".equals(tempTableCheck)))
			{	
				strQuery=SQLParser.getSqlQuery("selforLCeas^"+strLCAppenQuery+"^"+accountClassification+"^"+straccstatus+"^>^<^"+(strAppenQuery)+" order by org_code, org_name)  where row_num > "+limit+" and row_num <= "+offset);
				
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrCol = new ArrayList();
					
					arrCol.add(correctNull(rs.getString("ORG_NAME")));
					arrCol.add(correctNull(rs.getString("PERSONAL_CUSTNAME")));
					arrCol.add(correctNull(rs.getString("prd_desc")));
					arrCol.add(correctNull(rs.getString("FUND_SANCAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OSAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUEAMT")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUESINCE")));
					if(accountClassification.equals("002"))
					{	
						arrCol.add("EAS - I");
					}
					else if(accountClassification.equals("003"))
					{
						arrCol.add("EAS - II");
					}
					else if(accountClassification.equals("004"))
					{
						arrCol.add("SMA");
					}
					else
					{
						arrCol.add("Standard");
					}
					arrCol.add("Loan Default");
					arrCol.add(correctNull(rs.getString("fund_accno")));
					arrCol.add(correctNull(rs.getString("FUND_OVERDUETYPE")));
					arrRow.add(arrCol);
				}
			}	
			
			
			
			limit = "" + (Double.parseDouble(offset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			hshRecord.put("tempTableCheck",tempTableCheck);
			
			
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
		
	}

	private HashMap getRepDetails(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strSaveDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strDatetype="";
		String strloantype="";
		StringBuffer strbufOrgcode=new StringBuffer();
			
		try
		{
			
			
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			
			strOrgCode =(String)hshValues.get("hidOrgCode");
			
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=(String)hshValues.get("txttoamt");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			strloantype=correctNull((String)hshValues.get("loantype"));
			if(strOpFields.equals("")&& strSelFields.equals(""))  
			{	
				strSelFields="Proposal Number,Applicant Name,Amount,Applied Date";
				strOpFields="app_no,perapp_fname,perapp_lname,loan_recmdamt as  loan_recmdamt,to_char(loan_receivedate,'DD/MM/YYYY') as app_date";
			}
			if(!((strOrglevel.equalsIgnoreCase("State")) || (strOrglevel.equalsIgnoreCase("City")) ||(strOrglevel.equalsIgnoreCase("S/C"))))
			{
			strOrgCode=strOrgCode.replaceAll("'","");
			}
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("org_code = '").append(strOrgCode).append("'");
			}
			else if(strOrglevel.equalsIgnoreCase("State"))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_STATE in (").append(strOrgCode).append(")");
						
				}
				else
				{
					strbufOrgcode.append("ORG_STATE =").append(strOrgCode);
				}
			}
			else if((strOrglevel.equalsIgnoreCase("City"))||(strOrglevel.equalsIgnoreCase("S/C")))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_CITY in (").append(strOrgCode).append(")");
				}
				else
				{
					strbufOrgcode.append("ORG_CITY =").append(strOrgCode);
				}
			}
			
			
			if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
			{
				strbufOrgcode.append(" and applications.app_approvedby = users.usr_id");
				strDatetype="app_processdate";
			}
			else
			{
				strbufOrgcode.append(" and applications.app_applnholder = users.usr_id");
				strDatetype="loan_receivedate";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			if(strStatus.equalsIgnoreCase("L")){
				strOpFields=strOpFields+",to_char(app_lodgeddate,'DD/MM/YYYY') as app_lodgeddate,app_renew_flag";
				strSelFields=strSelFields+",Lodged Date,Proposal Type";
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				if(!strOrglevel.equalsIgnoreCase("CPC"))
				strQuery =SQLParser.getSqlQuery("selappstatusdatewise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strloantype+"^"+strDatetype+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
				else
					strQuery =SQLParser.getSqlQuery("selappstatusdatewise_cpc^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strloantype+"^"+strDatetype+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
			}	
			
			else
			{
				strQuery = SQLParser.getSqlQuery("selappstatusamtwise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strloantype+"^"+txtfromamt+"^"+txttoamt);
			}

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("Proposal Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")); 
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =Helper.correctDouble(rs.getString("loan_recmdamt"));
					vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
					vecRecords.add("right");
				}
						
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("inward_date"));
					if(strTemp.equalsIgnoreCase(""))
					{
						strTemp =correctNull(rs.getString("app_date"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				if (vecT.contains("Application Status"))
				{
					strTemp =correctNull(rs.getString("app_status"));
					if (strTemp.equalsIgnoreCase("op"))
					{
						strTemp="Open/Pending";
					}
					else if (strTemp.equalsIgnoreCase("pa"))
					{
						strTemp ="Processed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("pr"))
					{
						strTemp ="Processed/Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ca"))
					{
						strTemp ="Closed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("cr"))
					{
						strTemp ="Closed/Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ol"))
					{
						strTemp ="Open/Lodged";
					}
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					String a = correctNull(rs.getString("cat_name"));
					strTemp = a;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if ((vecT.contains("Approved Date"))||(vecT.contains("Rejected Date"))||(vecT.contains("Date")))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Branch"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint"))
				{
					strTemp =correctNull(rs.getString("mail_toflowpoint"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Flowpoint Received Date"))
				{
					vecRecords.add(correctNull(rs.getString("mail_date")));
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint Action"))
				{
					strTemp =correctNull(rs.getString("wrk_flowname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Approved By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Rejected By"))
				{
					strTemp =correctNull(rs.getString("usr_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				
				if(vecT.contains("Pending with"))
				{
					/*String strappwith="";
					strQuery1 = SQLParser.getSqlQuery("selapplicationwith^"+Helper.correctNull((String)rs.getString("app_no")));
					if(rs1 != null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strappwith =correctNull(rs1.getString("createdby"));
					}
					if(strappwith.equalsIgnoreCase(""))
					{*/
					strTemp =correctNull(rs.getString("createdby"));
//					}
					
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if(vecT.contains("Lodged Date"))
				{
					strTemp =correctNull(rs.getString("app_lodgeddate"));
					if(strTemp.equalsIgnoreCase(""))
						strTemp=" ";
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if(vecT.contains("Proposal Type"))
				{
					strTemp =correctNull(rs.getString("app_renew_flag"));
					
					if (strTemp.equalsIgnoreCase("S"))
						strTemp = "Resturcture";
					else if (strTemp.equalsIgnoreCase("R"))
						strTemp = "Renew";
					else if (strTemp.equalsIgnoreCase("P"))
						strTemp = "Postsanction";
					else
						strTemp = "Fresh";
					
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				vecVal.add(vecRecords);
			}
			if(strStatus.equalsIgnoreCase("A"))
			{
				strStatus="Approved";
			}
			else if(strStatus.equalsIgnoreCase("R"))
			{
				strStatus="Rejected";
			}
			else if(strStatus.equalsIgnoreCase("L"))
			{
				strStatus="Lodged";
			}
			else
			{
				strStatus="Pending";
			}
			if(strloantype.equalsIgnoreCase("P"))
			{
				strloantype="Retail";
			}
			else if(strloantype.equalsIgnoreCase("A"))
			{
				strloantype="Agriculture";
			}
				
			hshRec.put("strStatus",strStatus);
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("Org_Name",strOrg_Name);
			hshRec.put("loantype",strloantype);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRec;
	}
	private HashMap getRepDetails1(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strOpFields = null;
		String strSelFields=null;
		String strStatus=null;
		String strTemp=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strDate=null;
		String strFromDate=null;
		ArrayList vecT = new ArrayList();
		String strSaveDate=null;
		String strGen=null;
			
		try
		{
			
			
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			
			strOrgCode =(String)hshValues.get("hidOrgCode");
			
		
			
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=(String)hshValues.get("txttoamt");
			
			if(strOpFields.equals("")&& strSelFields.equals(""))
				
			{	strSelFields="Application Number,Applicant Name,Amount,Applied Date,Application Status";
				strOpFields="app_no,perapp_fname,perapp_lname,loan_recmdamt as  loan_recmdamt,convert(varchar,app_createdate,103) as app_date,app_status";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQuery =SQLParser.getSqlQuery("selappstatusdatewise^"+strOpFields+"^"+strOrgCode+"^"+strStatus+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
			}	
			
			else
			{
				strQuery = SQLParser.getSqlQuery("selappstatusamtwise^"+strOpFields+"^"+strOrgCode+"^"+strStatus+"^"+txtfromamt+"^"+txttoamt);
			}
			
			
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname")); 
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =correctNull(rs.getString("loan_recmdamt"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
						
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("app_date"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				if (vecT.contains("Application Status"))
				{
					strTemp =correctNull(rs.getString("app_status"));
					if (strTemp.equalsIgnoreCase("op"))
					{
						strTemp="Open/Pending";
					}
					else if (strTemp.equalsIgnoreCase("pa"))
					{
						strTemp ="Processed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("pr"))
					{
						strTemp ="Processed/Rejected";
					}
					else if (strTemp.equalsIgnoreCase("ca"))
					{
						strTemp ="Closed/Approved";
					}
					else if (strTemp.equalsIgnoreCase("cr"))
					{
						strTemp ="Closed/Rejected";
					}
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Product Name"))
				{
					String a = correctNull(rs.getString("cat_name"));
					String b = correctNull(rs.getString("scatname"));
					String c = correctNull(rs.getString("prd_desc"));
					strTemp = a+"-"+b+"-"+c;
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Approval/Rejection Date"))
				{
					strTemp =correctNull(rs.getString("app_processdate"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint"))
				{
					strTemp =correctNull(rs.getString("mail_toflowpoint"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Flowpoint Received Date"))
				{
					vecRecords.add(correctNull(
												rs.getString("mail_date")));
					vecRecords.add("center");
				}
				if (vecT.contains("Current Flowpoint Action"))
				{
					strTemp =correctNull(rs.getString("wrk_flowname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
					
				}
					
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRec;
	}
	private HashMap showProfile(HashMap hshPar) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strPeriod=null;
		String strStatus =null;
		String strOrgLevel = null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;

		try
		{
					
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			strStatus = st.nextToken();
			strPeriod = st.nextToken();
			hidOpFields =st.nextToken();
	 		hidSelFields = st.nextToken();
			
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Organisation Names");
			vecLabel.add("Process Status");
			vecLabel.add("Peroid");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			
			rs=DBUtils.executeLAPSQuery("repbanknames^"+hidOrgCode);
			int flag=0;
			while(rs.next())
			{
				if(flag==0){
					hidOrgCode="";
					flag=1;
				}
				
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,((hidOrgCode.length())-1));
			vecValue.add(hidOrgCode);
			if (strStatus.equalsIgnoreCase("p"))
			{
				strStatus="Pending";
			}
			else  if (strStatus.equalsIgnoreCase("a"))
			{
				strStatus="Approved";
			}
			else if (strStatus.equalsIgnoreCase("r"))
			{
				strStatus="Rejected";
			}
			vecValue.add(strStatus);
			vecValue.add(strPeriod);
			vecValue.add(hidSelFields);
			
			hshRecord.put("vecLabel",vecLabel);
			hshRecord.put("vecValue",vecValue);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}

	private HashMap getParamList(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strTemp=null;
		String strParam = null;
		String strOrgCode= null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strPeriod=null;
		String strStatus =null;
		String strSaveDate =null;
		String strGen =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			strStatus =  st.nextToken();
			strPeriod =  st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtSaveDate",strSaveDate);
			hshRecord.put("strUserId",strGen);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
	private HashMap getParamList1(HashMap hshPar) 
	{
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		String strTemp=null;
		String strParam = null;
		String strOrgCode= null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strPeriod=null;
		String strStatus =null;
		String strSaveDate =null;
		String strGen =null;
		String txtfromamt=null;
		String txttoamt=null;
		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strSaveDate =(String)hshTemp.get("txtDate");
			txtfromamt =(String)hshTemp.get("txtfromamt");
			txttoamt =(String)hshTemp.get("txttoamt");
			strParam =(String)hshTemp.get("param");
			
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			strStatus =  st.nextToken();
			strPeriod =  st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate",strPeriod);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtSaveDate",strSaveDate);
			hshRecord.put("strUserId",strGen);
			hshRecord.put("txtSaveDate",strSaveDate);
			hshRecord.put("strUserId",strGen);
			hshRecord.put("txtfromamt",txtfromamt);
			hshRecord.put("txttoamt",txttoamt);
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails1(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}
	
	private HashMap getMonitoringSanction(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		ArrayList arrRecords=null;
		HashMap hshRec=null;
		ArrayList arrVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strSelFields=null;
		String strStatus=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strDate=null;
		String strFromDate=null;
		String strSaveDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String limit = "";
		String offset = "";
		StringBuffer strbufOrgcode=new StringBuffer();
		StringBuffer strbufDate=new StringBuffer();
		StringBuffer strbufAmtcode=new StringBuffer();
		
		try
		{
			
			
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			
			strOrgCode =(String)hshValues.get("hidOrgCode");
			
			strSelFields =(String)hshValues.get("hidSelFields");
			strDate =(String)hshValues.get("txtDate");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=correctNull((String)hshValues.get("txttoamt"));
			
			if(!strDate.equalsIgnoreCase("All"))
			{
			strFromDate = strDate.substring(0,strDate.indexOf("-"));
			strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
			}
			
			 limit = correctNull((String)hshValues.get("limit"));
			 offset = correctNull((String)hshValues.get("offset"));
			 
			 
			 if(!txtfromamt.equals(""))
				{
					strbufAmtcode.append(" and limit_sanctamt between ").append(txtfromamt).append(" and ").append(txttoamt);
				}
			 
			 if(!strDate.equalsIgnoreCase("All"))
				{
					if(!strFromDate.equalsIgnoreCase(""))
					{
						strbufAmtcode.append(" and (TO_DATE(to_char(LIMIT_ACCOPENDT,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('").append(strFromDate).append("','DD/MM/YYYY') and TO_DATE( '").append(strToDate)
						.append("','DD/MM/YYYY'))");
					}
				} 
			 
			
			 
			if(strOrglevel.equals("C"))
			{	
				strbufOrgcode.append("and ORG_CODE like '").append("001%").append("'");
			}
			else if(strOrglevel.equals("R"))
			{
				strOrgCode = strOrgCode.replaceAll("'","");
				if(strOrgCode.indexOf(",")!=-1)
				{
					String[] strArray = strOrgCode.split(",");
					strbufOrgcode.append(" and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strbufOrgcode.append(" ORG_CODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strbufOrgcode.append("or ORG_CODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strbufOrgcode.append(")");
				}
				else
				{
					strbufOrgcode.append(" and ORG_CODE like '").append(strOrgCode.substring(0,6)).append("%'");
				}
			}
			else if(strOrglevel.equals("D"))
			{
				strOrgCode = strOrgCode.replaceAll("'","");
				if(strOrgCode.indexOf(",")!=-1)
				{
					String[] strArray = strOrgCode.split(",");
					strbufOrgcode.append("and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strbufOrgcode.append(" ORG_CODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strbufOrgcode.append(" or ORG_CODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strbufOrgcode.append(")");
				}
				else
				{
					strbufOrgcode.append(" and ORG_CODE like '").append(strOrgCode.substring(0,9)).append("%'");
				}
			}
			else if(strOrglevel.equals("A"))
			{
				strbufOrgcode.append(" and ORG_CODE in (").append(strOrgCode).append(")");
			}
			else if(strOrglevel.equals("B"))
			{
				strbufOrgcode.append(" and ORG_CODE in (").append(strOrgCode).append(")");
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
				
			strQuery =SQLParser.getSqlQuery("selmonsanctionlimit^"+strbufAmtcode.toString()+"^"+strbufOrgcode.toString()+" order by org_name,personal_custname) order by org_name,personal_custname)  where row_num > "+limit+" and row_num <= "+offset+" order by org_name,personal_custname");

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			arrVal = new ArrayList();
			while (rs.next())
			{
				arrRecords = new ArrayList();
				
					arrRecords.add(correctNull(rs.getString("LIMIT_ACCOPENDT")));//0
					arrRecords.add(correctNull(rs.getString("limit_cutaccno")));//1
					arrRecords.add(correctNull(rs.getString("personal_custname")));//2
					arrRecords.add(correctNull(rs.getString("limit_sanctamt")));//3
					arrRecords.add(correctNull(rs.getString("org_name")));//4
					arrRecords.add(correctNull(rs.getString("stat_data_desc1")));//5
					arrVal.add(arrRecords);
			}
			hshRec.put("strStatus",strStatus);
			hshRec.put("arrRow",arrVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("Org_Name",strOrg_Name);
			hshRec.put("Orglevel",strOrglevel);
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRec.put("limit",limit);
			hshRec.put("offset",offset);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRec;
	}
	
	
	private HashMap getStateCityReport(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		
		HashMap hshRec=null;
		
		ArrayList arrRecords=null;
		ArrayList arrVal =null;
		
		StringBuffer strbufOrgcode=new StringBuffer();
		
		String strQuery=null;
		String strCityName = null;
		String strStatus=null;
		String strOption=null;
		String strOpFields = null;
		String strProdtype=null;
		String strDatetype="";
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		String txtfromamt=null;
		String txttoamt=null;
		String strloantype=null;
		
		try
		{
			strCityName =correctNull((String)hshValues.get("city_name"));
			strOption=correctNull((String)hshValues.get("hidOption"));
			strOpFields =correctNull((String)hshValues.get("hidOpFields"));
			strStatus =correctNull((String)hshValues.get("status"));
			strProdtype =correctNull((String)hshValues.get("prodtype"));
			strDate =(String)hshValues.get("txtDate");
			txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
			txttoamt=(String)hshValues.get("txttoamt");
			strloantype=correctNull((String)hshValues.get("loantype"));
			
			if(strOpFields.equals(""))  
			{	
				strOpFields="app_no,perapp_fname,perapp_lname,loan_recmdamt as  loan_recmdamt,to_char(loan_receivedate,'DD/MM/YYYY') as app_date";
			}
			if(strOption.equals("S"))
			{
				if(strCityName.indexOf(",")!=-1)
				{
					strbufOrgcode.append("and ");
					strbufOrgcode.append("ORG_STATE in (").append(strCityName).append(")");
						
				}
				else
				{
					strbufOrgcode.append(" and ORG_STATE = ").append(strCityName);
				}
			}
			else 
			{
			
				if(strCityName.indexOf(",")!=-1)
				{
					strbufOrgcode.append("and ");
					strbufOrgcode.append("ORG_CITY in (").append(strCityName).append(")");
				}
				else
				{
					strbufOrgcode.append(" and ORG_CITY = ").append(strCityName);
				}
			}
			
			
			if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
			{
				strbufOrgcode.append("and applications.app_approvedby = users.usr_id");
				strDatetype="app_processdate";
			}
			else
			{
				strbufOrgcode.append("and applications.app_applnholder = users.usr_id");
				strDatetype="app_createdate";
			}
			if(rs!=null)
			{
				rs.close();
			}
				
			//strQuery =SQLParser.getSqlQuery("sel_StateCitywiseReport^"+"^"+strOpFields+"^"+strbufOrgcode.toString());
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQuery =SQLParser.getSqlQuery("selappstatusdatewise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strloantype+"^"+strDatetype+"^"+strFromDate+"^"+strToDate+"^"+txtfromamt+"^"+txttoamt);
			}	
			
			else
			{
				strQuery = SQLParser.getSqlQuery("selappstatusamtwise^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStatus+"^"+strloantype+"^"+txtfromamt+"^"+txttoamt);
			}
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			arrVal = new ArrayList();
			while (rs.next())
			{
				arrRecords = new ArrayList();
				
					arrRecords.add(correctNull(rs.getString("app_no")));//0
					arrRecords.add(correctNull(rs.getString("org_name")));//1
					arrRecords.add(correctNull(rs.getString("perapp_fname")));//2
					arrRecords.add(correctNull(rs.getString("loan_recmdamt")));//3
					arrRecords.add(correctNull(rs.getString("app_date")));//4
					arrRecords.add(correctNull(rs.getString("cat_name")));//5
					arrRecords.add(correctNull(rs.getString("scatname")));//6
					arrVal.add(arrRecords);
			}
			hshRec.put("strStatus",strStatus);
			hshRec.put("arrRow",arrVal);
			hshRec.put("OrgOption",strOption);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getStateCityReport"+e.toString());
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
		return hshRec;
	}
	
	private HashMap getMonitoringReport(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		String strQuery ="";
		try
		{
		
			
			
			tempOffset = correctNull((String)hshValues.get("rowsrange"));
			//String parameterSelect = correctNull((String)hshValues.get("parameterselect"));
			String accountClassification = correctNull((String)hshValues.get("accountclasssel"));
			String strLimitFrom = correctNull((String)hshValues.get("txtlimitfrom"));
			String strLimitTo = correctNull((String)hshValues.get("txtlimitto"));
			//String strOustandingFrom = correctNull((String)hshValues.get("txtoutstandingfrom"));
			//String strOustandingTo = correctNull((String)hshValues.get("txtoutstandingto"));
			//String strExcessFrom = correctNull((String)hshValues.get("txtexcessfrom"));
			//String strExcessTo = correctNull((String)hshValues.get("txtexcessto"));
			String selLevel = correctNull((String)hshValues.get("sellevel"));
			String limit = correctNull((String)hshValues.get("limit"));
			String offset = correctNull((String)hshValues.get("offset"));
			String straccount_class= correctNull((String)hshValues.get("hidaccclass_text"));
			String straccstatus= correctNull((String)hshValues.get("accstatus"));
			String strOrgName= correctNull((String)hshValues.get("strOrgName"));
			
			//String strparamtext= correctNull((String)hshValues.get("hidparameterselect_text"));
			String straccstatustext= correctNull((String)hshValues.get("hidaccountstatus_text"));
			
			String strschemecode=correctNull((String)hshValues.get("schemecode")); 
			
			String strSector=correctNull((String)hshValues.get("sector"));
			
			String strSectorcode=correctNull((String)hshValues.get("sectorcode"));
			
			StringBuffer strBillAppendQuery = new StringBuffer();
			StringBuffer strAppenQuery = new StringBuffer();
			
			String rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			// this coding for selecting multiple regional, branch, zone etc
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and BRANCHCODE like '").append("001%").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" BRANCHCODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append("or BRANCHCODE like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and BRANCHCODE like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" BRANCHCODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or BRANCHCODE like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and BRANCHCODE like '").append(rpselect1.substring(0,9)).append("%'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append(" and BRANCHCODE in (").append(rpselect1).append(")");
			}
			else if(selLevel.equals("B"))
			{
				strAppenQuery.append(" and BRANCHCODE in (").append(rpselect1).append(")");
			}
			
			
			strBillAppendQuery.append(strAppenQuery);
			
			
				if(!strLimitFrom.equals(""))
				{
					strAppenQuery.append(" and SANCTIONEDAMOUNT between ").append(strLimitFrom).append(" and ").append(strLimitTo);
				}
			
			/*if(!strOustandingFrom.equals(""))
			{
				strAppenQuery.append(" and OUTSTANDING between ").append(strOustandingFrom).append(" and ").append(strOustandingTo);
			}
			if(!strExcessFrom.equals(""))
			{
				strAppenQuery.append(" and OVERDUEAMOUNT between ").append(strExcessFrom).append(" and ").append(strExcessTo);
			}*/
			if(!strSector.equals(""))
			{
				if(strSector.equals("Sector wise"))
				{
					strAppenQuery.append(" and SECTOR in('"+strSectorcode+"')");
				}else if(strSector.equals("Sub sector wise"))
				{
					strAppenQuery.append(" and SUBSECTOR in('"+strSectorcode+"')");
				}else if(strSector.equals("Purpose wise"))
				{
					strAppenQuery.append(" and PURPOSEOFADVANCE in('"+strSectorcode+"')");
				}
			}
			if(!strschemecode.equals(""))
			{
				if(strschemecode.equalsIgnoreCase("F"))
				{
					strAppenQuery.append("and SCHEMECODE in('DL021','DL022','DL004','DL011','DL012','FB001','FB002','FB003','FB004')");
				}
			}
			
			strQuery=SQLParser.getSqlQuery("sel_AnnexureReport"
					//+"^"+parameterSelect
					+"^"+accountClassification
					+"^"+straccstatus
					+"^"+(strAppenQuery)
					+" order by branchname,customername)ORDER BY branchname,customername)where row_num > "
					+limit
					+" and row_num <= "+offset
					+" order by branchname,customername,BRANCHCODE");

				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("branchname")));//ORG_NAME 0
				arrCol.add(correctNull(rs.getString("customername")));//PERSONAL_CUSTNAME 1
				arrCol.add(correctNull(rs.getString("facilitynature")));//prd_desc 2
				arrCol.add(correctNull(rs.getString("sanctionedamount")));//FUND_SANCAMT 3
				arrCol.add(correctNull(rs.getString("outstanding")));//FUND_OSAMT 4
				arrCol.add(correctNull(rs.getString("overdueamount")));//FUND_OVERDUEAMT 5
				arrCol.add(correctNull(rs.getString("overduesince")));//FUND_OVERDUESINCE 6
				arrCol.add(correctNull(rs.getString("accountnumber")));//fund_accno 7
				arrCol.add(correctNull(rs.getString("accounttype")));//FUND_OVERDUETYPE 8
				arrCol.add(correctNull(rs.getString("alertfor")));//fund_accno 9
				arrCol.add(correctNull(rs.getString("assetclassification")));//FUND_OVERDUETYPE 10
				arrRow.add(arrCol);
				}
			
				hshRecord.put("arrRow",arrRow);
				
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			
			
			hshRecord.put("sectorval",correctNull((String)hshValues.get("sectorval")));
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			
			hshRecord.put("orgLevel",selLevel);
			hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
			hshRecord.put("account_class",straccount_class);
			//hshRecord.put("parameter",strparamtext.toUpperCase());
			hshRecord.put("status",straccstatustext.toUpperCase());
			hshRecord.put("schemecode",strschemecode);
			hshRecord.put("str_orgname",strOrgName);
			
		}
		
		
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
	}
	
	
	private HashMap getMMRReport(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		String strQuery ="";
		String strFromDate="";
		String strToDate="";
		try
		{
		
			//tempOffset = correctNull((String)hshValues.get("rowsrange"));
			String strLimitFrom = correctNull((String)hshValues.get("txtlimitfrom"));
			String strLimitTo = correctNull((String)hshValues.get("txtlimitto"));
			
			String selLevel = correctNull((String)hshValues.get("sellevel"));
			
			String limit = correctNull((String)hshValues.get("limit"));
			String offset = correctNull((String)hshValues.get("offset"));
			
			StringBuffer strAppenQuery = new StringBuffer();
			
			String rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			
			String strStatus =correctNull((String)hshValues.get("varstatus"));
			
			strFromDate=correctNull((String)hshValues.get("fromdate"));
			strToDate=correctNull((String)hshValues.get("todate"));
			
			// this coding for selecting multiple regional, branch, zone etc
			
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				strAppenQuery.append(" and (TO_DATE(to_char(mmr_createdate " ).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and orgs.org_code like '").append("001%").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" orgs.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append("or orgs.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and orgs.org_code like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" orgs.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or orgs.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and orgs.org_code like '").append(rpselect1.substring(0,9)).append("%'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append(" and orgs.org_code in (").append(rpselect1).append(")");
			}
			
			
			/*
				if(!strLimitFrom.equals(""))
				{
					strAppenQuery.append(" and  between ").append(strLimitFrom).append(" and ").append(strLimitTo);
				}*/
			
			if(strStatus.equalsIgnoreCase("O"))
			{
			
			strQuery=SQLParser.getSqlQuery("sel_perparedmmrReport^"
					+(strAppenQuery)
					+" order by org.org_name,personal_custname ) order by orgname,personal_custname ) where row_num > "
					+ limit
					+" and row_num <= "+offset
					+" order by orgname,personal_custname");
			
			}
			else if(strStatus.equalsIgnoreCase("P"))
			{
			
			strQuery=SQLParser.getSqlQuery("sel_submittedmmrReport^"
					+(strAppenQuery)
					+" order by org.org_name,personal_custname ) order by orgname,personal_custname ) where row_num > "
					+ limit
					+" and row_num <= "+offset
					+" order by orgname,personal_custname");

			}
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("mmr_cbsid")));// 0
				arrCol.add(correctNull(rs.getString("personal_custname")));// 1
				arrCol.add(correctNull(rs.getString("username")));// 2
				arrCol.add(correctNull(rs.getString("reportdate")));// 3
				arrCol.add(correctNull(rs.getString("orgname")));// 4
				arrRow.add(arrCol);
				}
			
				hshRecord.put("arrRow",arrRow);
				
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			
			hshRecord.put("orgLevel",selLevel);
			hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
		}
		
		
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
	}
	
	
	private HashMap getTermLoanReviewReport(HashMap hshValues)
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		String strQuery ="";
		String strFromDate="";
		String strToDate="";
		String strStatusvalue="";
		try
		{
		
			String strLimitFrom = correctNull((String)hshValues.get("txtlimitfrom"));
			String strLimitTo = correctNull((String)hshValues.get("txtlimitto"));
			
			String selLevel = correctNull((String)hshValues.get("sellevel"));
			
			String limit = correctNull((String)hshValues.get("limit"));
			String offset = correctNull((String)hshValues.get("offset"));
			
			StringBuffer strAppenQuery = new StringBuffer();
			
			String rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			
			String strStatus =correctNull((String)hshValues.get("varstatus"));
			
			strFromDate=correctNull((String)hshValues.get("fromdate"));
			strToDate=correctNull((String)hshValues.get("todate"));
			
			// this coding for selecting multiple regional, branch, zone etc
			
			
			if(strStatus.equalsIgnoreCase("OP"))
			{
				strAppenQuery
				.append("a.tlr_createdby=usr.usr_id(+) ");
			}
			else if(strStatus.equalsIgnoreCase("PA"))
			{
				strAppenQuery
				.append("a.tlr_PROCESSEDBY=usr.usr_id ");
			}
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				if(strStatus.equalsIgnoreCase("OP"))
				{
					strAppenQuery
					.append(" and (TO_DATE(to_char(tlr_createdate " )
					.append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
					.append(strFromDate)
					.append("','DD/MM/YYYY') and TO_DATE('")
					.append(strToDate).append("','DD/MM/YYYY'))");
				}
				else if(strStatus.equalsIgnoreCase("PA"))
				{
					strAppenQuery
					.append(" and (TO_DATE(to_char(a.tlr_processdate " )
					.append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
					.append(strFromDate)
					.append("','DD/MM/YYYY') and TO_DATE('")
					.append(strToDate).append("','DD/MM/YYYY'))");
				}
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and a.tlr_orgcode=org.org_scode and  org.org_code like '").append("001%").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and a.tlr_orgcode=org.org_scode and (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append("or org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and a.tlr_orgcode=org.org_scode and  org.org_code like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and a.tlr_orgcode=org.org_scode and  (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and a.tlr_orgcode=org.org_scode and org.org_code like '").append(rpselect1.substring(0,9)).append("%'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append(" and a.tlr_orgcode=org.org_scode and  org.org_code in (").append(rpselect1).append(")");
			}
			
			if(strStatus.equalsIgnoreCase("OP"))
			{
				strStatusvalue="'"+strStatus+"'";
			}
			else
			{
				strStatusvalue="'PA','CA'";
			}
			strQuery=SQLParser.getSqlQuery("sel_ReviewTermLoanReport^"
					+strStatusvalue+"^"
					+(strAppenQuery)
					+" order by org.org_name,personal_custname ) order by orgname,personal_custname ) where row_num > "
					+ limit
					+" and row_num <= "+offset
					+" order by orgname,personal_custname");
			
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull((String)rs.getString("personal_custname")));// 0
				arrCol.add(correctNull((String)rs.getString("tlr_cbsid")));// 1
				arrCol.add(correctNull((String)rs.getString("reviewdue")));// 2
				                                            
				if(strStatus.equalsIgnoreCase("OP"))
				{
					arrCol.add(correctNull((String)rs.getString("reviewon")));// 3
				}
				else
				{
					arrCol.add(correctNull((String)rs.getString("review_processdate")));// 3
				}
				arrCol.add(correctNull((String)rs.getString("reviewedby")));// 4
				arrCol.add(correctNull((String)rs.getString("orgname")));//5
				arrRow.add(arrCol);
				}
			
				hshRecord.put("arrRow",arrRow);
				
			limit = "" + (Double.parseDouble(limit) + Double.parseDouble(tempOffset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			
			hshRecord.put("orgLevel",selLevel);
			hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
		}
		
		
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		
		return hshRecord;
	}
	
	private HashMap getSanctionedloanReport(HashMap hshValues)
	{
		ResultSet rs = null;
		ResultSet rs2 = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		ArrayList arrSisRow = new ArrayList();
		 ArrayList arrSisCol = new ArrayList();
		String strQuery ="";
		String strFromDate="";
		String strToDate="";
		//String strFromAmt="";
		//String strToAmt="";
		String selLevel="";
		String limit ="";
		String offset = "";
		String rpselect1  = "";
		String strLoantype = "";
		String strusrclass="";
		String ModuleType="";
		
		double dblnonfundbase=0.0;
		double dblfundbase=0.0;
		
		double dblProjectCost=0.0;
		double dblRecmdAmt=0.0;
		double dblMargin=0.0;
		
		try
		{
			StringBuffer strAppenQuery = new StringBuffer();
			
			selLevel = correctNull((String)hshValues.get("sellevel"));
			limit = correctNull((String)hshValues.get("limit"));
			offset = correctNull((String)hshValues.get("offset"));
			rpselect1 = correctNull((String)hshValues.get("rpselect1"));
			strLoantype =correctNull((String)hshValues.get("varloantype"));
			strFromDate=correctNull((String)hshValues.get("fromdate"));
			strToDate=correctNull((String)hshValues.get("todate"));
			//strFromAmt=correctNull((String)hshValues.get("fromamt"));
			//strToAmt=correctNull((String)hshValues.get("toamt"));
			strusrclass =correctNull((String)hshValues.get("sanctionlevel"));
			ModuleType= correctNull((String)hshValues.get("moduleType"));
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				strAppenQuery.append(" and (TO_DATE(to_char(app_processdate ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append(" and org.org_scode = app_processorgscode and  org.org_code = '").append("001000000000000").append("'");
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and org.org_scode = app_processorgscode and (");
					for(int i=0;i<strArray.length;i++)
					{
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and org.org_scode = app_processorgscode and  org.org_code = '").append(rpselect1).append("'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and org.org_scode = app_processorgscode and  (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append("and org.org_scode = app_processorgscode and org.org_code = '").append(rpselect1).append("'");
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and org.org_scode = app_processorgscode and org.org_code in (").append(rpselect1).append(")");
			}
			
			/*
			 * For Retail
			 * 
			 */
			
			if((strLoantype.equalsIgnoreCase("P"))||(strLoantype.equalsIgnoreCase("All") && ModuleType.equalsIgnoreCase("P")))
			{
				
					String Loantype="";
					
					if(strLoantype.equalsIgnoreCase("All"))
					{
						Loantype="P";
					}
					else
					{
						Loantype=strLoantype;
					}
					
					strQuery=SQLParser.getSqlQuery("sel_retailsanctionedloansreport^"
							+Loantype+"^"
							+strusrclass+"^"
							+(strAppenQuery)
							+" order by app_processdate ) order by app_processdate ) where row_num > "
							+ limit
							+" and row_num <= "+offset
							+" order by app_processdate");
					
						rs=DBUtils.executeQuery(strQuery);
						
						while(rs.next())
						{ 
							arrCol = new ArrayList();
							arrCol.add(correctNull((String)rs.getString("app_processdate")));// 0
							arrCol.add(correctNull((String)rs.getString("perapp_fname")));// 1
							arrCol.add(correctNull((String)rs.getString("createdbrn")));// 2
							
								strQuery=SQLParser.getSqlQuery("sel_totmeans^"
										+correctNull((String)rs.getString("app_no"))+"^"
										+"and (cr_apptype like 'a%' or cr_apptype is null)");
								rs2=DBUtils.executeQuery(strQuery);
								if(rs2.next())
								{
									arrCol.add(correctNull(rs2.getString("cr_total_means")));// 3
								}
								else
								{
									arrCol.add("");// 3
								}
							
							arrCol.add(Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt"))))));// 4
							arrCol.add("");//5
							arrCol.add(correctNull((String)rs.getString("loan_modintrate")));//6
							
							dblProjectCost=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_costloanprd")));
							dblRecmdAmt=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
							
							dblMargin=(100*(dblProjectCost-dblRecmdAmt))/dblProjectCost;
							
							arrCol.add(""+dblMargin);//7
							arrCol.add(arrSisRow);//8
							arrCol.add("");//9
							arrCol.add("");//10
							arrCol.add(correctNull((String)rs.getString("app_loantype")));//11
							arrCol.add("0");//12
							arrRow.add(arrCol);
						}
						hshRecord.put("arrRow",arrRow);
						
						hshRecord.put("orgLevel",selLevel);
						hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
						
						if(arrRow.size()<Double.parseDouble(tempOffset))
						{
							limit="0";
							offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
							ModuleType="A";
						}
						else
						{
							ModuleType="P";
						}
				}
			
			/*
			 * For Agriculture
			 * 
			 */
			
			if((strLoantype.equalsIgnoreCase("A")) || (strLoantype.equalsIgnoreCase("All") && ModuleType.equalsIgnoreCase("A")))
			{
				String Loantype="";
				
				if(strLoantype.equalsIgnoreCase("All"))
				{
					Loantype="A";
				}
				else
				{
					Loantype=strLoantype;
				}
				
				strQuery=SQLParser.getSqlQuery("sel_retailsanctionedloansreport^"
						+Loantype+"^"
						+strusrclass+"^"
						+(strAppenQuery)
						+" order by app_processdate ) order by app_processdate ) where row_num > "
						+ limit
						+" and row_num <= "+offset
						+" order by app_processdate");
				
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{ 
						arrCol = new ArrayList();
						arrCol.add(correctNull((String)rs.getString("app_processdate")));// 0
						arrCol.add(correctNull((String)rs.getString("perapp_fname")));// 1
						arrCol.add(correctNull((String)rs.getString("createdbrn")));// 2
						
							strQuery=SQLParser.getSqlQuery("sel_totmeans^"
									+correctNull((String)rs.getString("app_no"))
									+"^"+"and (cr_apptype like 'a%' or cr_apptype is null)");
							rs2=DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								arrCol.add(correctNull(rs2.getString("cr_total_means")));// 3
							}
							else
							{
								arrCol.add("");// 3
							}
						
						arrCol.add(Helper.converToLakhs(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt"))))));// 4
						arrCol.add("");//5
						arrCol.add(correctNull((String)rs.getString("loan_modintrate")));//6
						dblProjectCost=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_costloanprd")));
						dblRecmdAmt=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")));
						
						dblMargin=(100*(dblProjectCost-dblRecmdAmt))/dblProjectCost;
						
						arrCol.add(""+dblMargin);//7
						arrCol.add(arrSisRow);//8
						arrCol.add("");//9
						arrCol.add("");//10
						arrCol.add(correctNull((String)rs.getString("app_loantype")));//11
						arrCol.add("0");//12
						arrRow.add(arrCol);
					}
					hshRecord.put("arrRow",arrRow);
					
					hshRecord.put("orgLevel",selLevel);
					hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
					
					
					if(arrRow.size()<Double.parseDouble(tempOffset))
					{
						limit="0";
						offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
						ModuleType="T";
					}
					else
					{
						ModuleType="A";
					}
			}
			
			/*
			 * For Tertiary
			 * 
			 */
			
			if((strLoantype.equalsIgnoreCase("T"))|| (strLoantype.equalsIgnoreCase("All") && ModuleType.equalsIgnoreCase("T")))
			{
				strQuery=SQLParser.getSqlQuery("sel_tertiarysanctionedloansreport^"
						+strusrclass+"^"
						+(strAppenQuery)
						+" order by app_processdate ) order by app_processdate ) where row_num > "
						+ limit
						+" and row_num <= "+offset
						+" order by app_processdate");
				
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						dblnonfundbase=0.0;
						dblfundbase=0.0;
							
						arrCol = new ArrayList();
						arrCol.add(correctNull((String)rs.getString("app_processdate")));// 0
						arrCol.add(correctNull((String)rs.getString("perapp_fname")));// 1
						arrCol.add(correctNull((String)rs.getString("createdbrn")));// 2
						
						strQuery=SQLParser.getSqlQuery("sel_totmeans^"
								+correctNull((String)rs.getString("app_no"))+"^"
								+"and (CR_APPTYPE = '" 
								+correctNull((String)rs.getString("perapp_id")) 
								+"' or cr_apptype is null)");
						
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							arrCol.add(correctNull(rs2.getString("cr_total_means")));// 3
						}
						else
						{
							arrCol.add("");// 3
						}
						
						if(correctNull((String)rs.getString("facility_headid")).equalsIgnoreCase("4"))
						{
							dblnonfundbase=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						}
						else
						{
							dblfundbase=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						}
						arrCol.add(Helper.converToLakhs(Helper.formatDoubleValue(dblfundbase)));//4
						arrCol.add(Helper.converToLakhs(Helper.formatDoubleValue(dblnonfundbase)));//5
						arrCol.add(correctNull((String)rs.getString("interest")));//6
						arrCol.add(correctNull((String)rs.getString("facility_margin")));//7
						arrCol.add(arrSisRow);//8
						arrCol.add(correctNull((String)rs.getString("facility_existing")));//9
						arrCol.add(correctNull((String)rs.getString("facility_proposed")));//10
						arrCol.add(correctNull((String)rs.getString("app_loantype")));//11
						arrCol.add("0");//12
						arrRow.add(arrCol);
					}
					hshRecord.put("arrRow",arrRow);
					hshRecord.put("orgLevel",selLevel);
					hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
				
					
					if(arrRow.size()<Double.parseDouble(tempOffset))
					{
						limit="0";
						offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
						ModuleType="C";
					}
					else
					{
						ModuleType="T";
					}
			}
			
			/*
			 * For Corporate
			 * 
			 */
			
			if((strLoantype.equalsIgnoreCase("C")) || (strLoantype.equalsIgnoreCase("All") && ModuleType.equalsIgnoreCase("C")))
			{
				strQuery=SQLParser.getSqlQuery("sel_corporatesanctionedloansreport^"
						+strusrclass+"^"
						+(strAppenQuery)
						+" order by app_processdate ) order by app_processdate ) where row_num > "
						+ limit
						+" and row_num <= "+offset
						+" order by app_processdate");
				
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						 dblnonfundbase=0.0;
						 dblfundbase=0.0;
						 arrCol = new ArrayList();
						
						 arrCol.add(correctNull((String)rs.getString("app_processdate")));// 0
						 arrCol.add(correctNull((String)rs.getString("comapp_companyname")));// 1
						 arrCol.add(correctNull((String)rs.getString("createdbrn")));// 2
						 
							strQuery=SQLParser.getSqlQuery("sel_totmeans^"
									+correctNull((String)rs.getString("app_no"))+"^"
									+"and (CR_APPTYPE='0' or CR_APPTYPE is null)");
							
							rs2=DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								arrCol.add(correctNull(rs2.getString("cr_total_means")));// 3
							}
							else
							{
								arrCol.add("");// 3
							}
						 
						 if(correctNull((String)rs.getString("facility_headid")).equalsIgnoreCase("4"))
						 {
							dblnonfundbase=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						 }
						 else
						 {
							dblfundbase=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")));
						 }
						 arrCol.add(""+dblfundbase);//4
						 arrCol.add(""+dblnonfundbase);//5
						
						 arrCol.add(correctNull((String)rs.getString("interest")));//6
						 arrCol.add(correctNull((String)rs.getString("facility_margin")));//7
						 
						 
					   // arrSisCol = null;
						arrSisRow = new ArrayList();
						int count = 0;
						strQuery=SQLParser.getSqlQuery("sel_sisterconcerndetails^"+correctNull((String)rs.getString("app_no"))+"^"+correctNull((String)rs.getString("comapp_id")));
						rs2=DBUtils.executeQuery(strQuery);
						while (rs2.next())
						{
							arrSisCol = new ArrayList();
							arrSisCol.add(correctNull(rs2.getString("sis_nonfund")));//0
							arrSisCol.add(correctNull(rs2.getString("sis_fund")));//1
							arrSisCol.add(correctNull(rs2.getString("comapp_div_name")));//2
							arrSisCol.add(""+count);//3
							arrSisRow.add(arrSisCol);
						}
						arrCol.add(arrSisRow);//8
						arrCol.add(correctNull((String)rs.getString("facility_existing")));//9
						arrCol.add(correctNull((String)rs.getString("facility_proposed")));//10
						arrCol.add(correctNull((String)rs.getString("app_loantype")));//11
						arrCol.add(""+arrSisCol.size());//12
						arrRow.add(arrCol);
					}
					hshRecord.put("arrRow",arrRow);
								
				hshRecord.put("orgLevel",selLevel);
				hshRecord.put("orgname",Helper.correctNull((String)hshValues.get("org_name")));
				
				if(arrRow.size()<Double.parseDouble(tempOffset))
				{
					limit="0";
					offset =""+(Double.parseDouble(tempOffset)-arrRow.size());
				}
				
			} 
			
			limit = "" + (Double.parseDouble(offset));
			offset = "" + (Double.parseDouble(offset) + Double.parseDouble(tempOffset));
			
			hshRecord.put("limit",limit);
			hshRecord.put("offset",offset);
			hshRecord.put("ModuleType",ModuleType);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRecord;
	}
	
	
	private HashMap getAppRegisterReport(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
		String strQuery ="";
		String strDate="";
		String strFromDate="";
		String strToDate="";
		String selLevel="";
		String rpselect1  = "";
		String strprocessat="";
		String strOrgName="";
		String branchtype="";
		String strOrgLevel="";
		 
		
		try
		{
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strprocessat = correctNull((String)hshValues.get("processat"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
						
			strAppenQuery.append("  inward_applnprocessat = '").append(strprocessat).append("'");
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				strAppenQuery.append(" and (TO_DATE(to_char(inward_createdon ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append(" and org.org_scode = inward_orgscode and  org_code like '001%'");
				
			}
			else if(selLevel.equals("R"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append(" and org.org_scode = inward_orgscode and (");
					for(int i=0;i<strArray.length;i++)
					{
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or org.org_code like '").append(strArray[i].substring(0,6)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append(" and org.org_scode = inward_orgscode and  org.org_code like '").append(rpselect1.substring(0,6)).append("%'");
				}
			}
			else if(selLevel.equals("D"))
			{
				rpselect1 = rpselect1.replaceAll("'","");
				if(rpselect1.indexOf(",")!=-1)
				{
					String[] strArray = rpselect1.split(",");
					strAppenQuery.append("and org.org_scode = inward_orgscode and  (");
					for(int i=0;i<strArray.length;i++)
					{
					
						if(i==0)
						{	
							strAppenQuery.append(" org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
						else
						{
							strAppenQuery.append(" or org.org_code like '").append(strArray[i].substring(0,9)).append("%'");
						}
					}
					strAppenQuery.append(")");
				}
				else
				{
					strAppenQuery.append("and org.org_scode = inward_orgscode and org.org_code like '").append(rpselect1.substring(0,9)).append("%'");
				
				}
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and org.org_scode = inward_orgscode and org.org_code in (").append(rpselect1).append(")");
			}
			strQuery =SQLParser.getSqlQuery("sel_appreg_report^"+strAppenQuery.toString());

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			while (rs.next())
			{
				arrCol = new ArrayList();
				dbmultiples=1;
				arrCol.add(correctNull(rs.getString("inward_no")));//0
				arrCol.add(correctNull(rs.getString("inward_sector")));//1
				arrCol.add(correctNull(rs.getString("inward_custname")));//2
				strvaluesin = correctNull(rs.getString("inward_valuesin"));
				if(strvaluesin.equals("C"))
				{	
					dbmultiples=10000000;
				}
				else if(strvaluesin.equals("L"))
				{
					dbmultiples=100000;
				}
				arrCol.add(""+(Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt"))) * dbmultiples));//3
				arrCol.add(""+(Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt"))) * dbmultiples));//4
				arrCol.add(""+(Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt"))) * dbmultiples));//5
				arrCol.add(correctNull(rs.getString("INWARD_APPLIEDON")));//6
				arrCol.add(correctNull(rs.getString("inward_docreceivedon")));//7
				arrCol.add(correctNull(rs.getString("inward_brstatus")));//8
				arrCol.add(correctNull(rs.getString("org_name")));//9
				arrRow.add(arrCol);
			}
			if(strprocessat.equals("1"))
			{
				branchtype="Branch";
			}
			else
			{
				branchtype="Saral";
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("orglevel",strOrgLevel);
			hshRecord.put("processat",branchtype);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getAppRegisterReport"+e.toString());
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
		return hshRecord;
		
	}
	public HashMap getMsmeReport(HashMap hshValues) 
	{
		ResultSet rs = null;
 		ResultSet rs1=null,rs2=null;
 		ArrayList vecRecords=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strOrgCode ="",strGen="";
		String strCBSid="",strappNo="";
		try
		{
			strGen =(String)hshValues.get("strUserId");
		
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("hidOrgCode"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("hidOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("orglevel"));
			strOrgCode = correctNull((String)hshValues.get("hidOrgCode"));
			strCBSid= correctNull((String)hshValues.get("cbsid"));
			strappNo=	 correctNull((String)hshValues.get("appno"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
						
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				if(!strCBSid.equalsIgnoreCase("") && strappNo.equalsIgnoreCase("") && !strCBSid.equalsIgnoreCase("ALL") )
				{
					strAppenQuery.append(" and (TO_DATE(to_char(ma.MSME_APPROVEDDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append(" and ma.MSME_CBSID= '").append(strCBSid).append("'") ;
				}else if(strCBSid.equalsIgnoreCase("") && !strappNo.equalsIgnoreCase(""))
				{
					strAppenQuery.append(" and (TO_DATE(to_char(ma.MSME_APPROVEDDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append("and mp.MSME_APPNO= '").append(strappNo).append("'") ;
				}else if(!strCBSid.equalsIgnoreCase("") && !strappNo.equalsIgnoreCase("") && !strCBSid.equalsIgnoreCase("ALL") )
				{
					strAppenQuery.append(" and (TO_DATE(to_char(ma.MSME_APPROVEDDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append(" and ma.MSME_CBSID= '").append(strCBSid).append("'and mp.MSME_APPNO= '").append(strappNo).append("'");
				}
				else if(strCBSid.equalsIgnoreCase("ALL") && strappNo.equalsIgnoreCase(""))
				{
					strAppenQuery.append(" and (TO_DATE(to_char(ma.MSME_APPROVEDDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append(" and ma.MSME_CBSID like '%'") ;
				}else if( !strappNo.equalsIgnoreCase("") && strCBSid.equalsIgnoreCase("ALL") )
				{
					strAppenQuery.append(" and (TO_DATE(to_char(ma.MSME_APPROVEDDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append(" and ma.MSME_CBSID like '%").append("'and mp.MSME_APPNO= '").append(strappNo).append("'");
				}
				
			}
			
			if(strOrgLevel.equals("C"))
			{	
				strAppenQuery.append("and  org_code like '001%'");
				
			}
			else if(strOrgLevel.equalsIgnoreCase("R")||strOrgLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,6)).append("%'");
			}
			else if(strOrgLevel.equals("D"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,9)).append("%'");
			}
			else if(strOrgLevel.equals("A"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,12)).append("%'");
			}
			
			strQuery =SQLParser.getSqlQuery("sel_msmereport^"+strAppenQuery.toString());

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			MastApplicantBean MAB=new MastApplicantBean();
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("PERAPP_CBSID")));//0
				arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));//1
				arrCol.add(Helper.correctNull(rs.getString("msme_appno")));//2
				arrCol.add(Helper.correctNull(rs.getString("msme_facsno")));//3
				arrCol.add(Helper.correctNull(rs.getString("msme_equipmentvalold")));//4
				arrCol.add(Helper.correctNull(rs.getString("msme_plantvalold")));//5
				arrCol.add(Helper.correctNull(rs.getString("msme_salesturnoverold")));//6	
				arrCol.add(Helper.correctNull(rs.getString("msme_salestnasonold")));//7
				String strCatTypeDesc=MAB.getMasterDesc("MISMast", "12", Helper.correctNull(rs.getString("APP_AGRICULTURE_OLD")));
				
				arrCol.add(strCatTypeDesc);//8
				String strSectorDesc="";String strSector=Helper.correctNull(rs.getString("APP_SECTOR_OLD"));
				if(strSector.equalsIgnoreCase("01"))
				{
					strSectorDesc="Priority Sector";
				}
				else if(strSector.equalsIgnoreCase("02"))
				{
					strSectorDesc="Non Priority Sector";
				}
				arrCol.add(strSectorDesc);//9
				String strSubSectorDesc=MAB.getMasterDesc("MISMast","7",Helper.correctNull(rs.getString("APP_SUBSECTOR_OLD")));
				if(strSubSectorDesc.equalsIgnoreCase(""))
				{
					strSubSectorDesc=MAB.getMasterDesc("MISMast","8",Helper.correctNull(rs.getString("APP_SUBSECTOR_OLD")));
				}
				arrCol.add(strSubSectorDesc);//10
				String strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",Helper.correctNull(rs.getString("APP_SENSITIVESECTOR_OLD")));
				
				arrCol.add(strSensitiveSectorDesc);//11
				String strGovernmentDesc=MAB.getMasterDesc("MISMast", "23", Helper.correctNull(rs.getString("APP_GOVTANNOUNCESCHEME_OLD")));
				
				arrCol.add(strGovernmentDesc);//12
				String strStandupIndiaDesc="";
				if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA_OLD")).equalsIgnoreCase("Y"))
					strStandupIndiaDesc="Yes";
				else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA_OLD")).equalsIgnoreCase("N"))
					strStandupIndiaDesc="No";
				else
					strStandupIndiaDesc="";
				arrCol.add(strStandupIndiaDesc);//13
				
				arrCol.add(Helper.correctNull(rs.getString("msme_equipmentval")));//14
				arrCol.add(Helper.correctNull(rs.getString("msme_plantval")));//15
				arrCol.add(Helper.correctNull(rs.getString("msme_salesturnover")));//16
				arrCol.add(Helper.correctNull(rs.getString("msme_salestnason")));//17
                strCatTypeDesc=MAB.getMasterDesc("MISMast", "12", Helper.correctNull(rs.getString("APP_AGRICULTURE")));
				
				arrCol.add(strCatTypeDesc);//18
				strSectorDesc=""; strSector=Helper.correctNull(rs.getString("APP_SECTOR"));
				if(strSector.equalsIgnoreCase("01"))
				{
					strSectorDesc="Priority Sector";
				}
				else if(strSector.equalsIgnoreCase("02"))
				{
					strSectorDesc="Non Priority Sector";
				}
				arrCol.add(strSectorDesc);//19
				strSubSectorDesc=MAB.getMasterDesc("MISMast","7",Helper.correctNull(rs.getString("APP_SUBSECTOR")));
				if(strSubSectorDesc.equalsIgnoreCase(""))
				{
					strSubSectorDesc=MAB.getMasterDesc("MISMast","8",Helper.correctNull(rs.getString("APP_SUBSECTOR")));
				}
				arrCol.add(strSubSectorDesc);//20
                strSensitiveSectorDesc=MAB.getMasterDesc("MISMast","11",Helper.correctNull(rs.getString("APP_SENSITIVESECTOR")));
				
				arrCol.add(strSensitiveSectorDesc);//21
                strGovernmentDesc=MAB.getMasterDesc("MISMast", "23", Helper.correctNull(rs.getString("APP_GOVTANNOUNCESCHEME")));
				
				arrCol.add(strGovernmentDesc);//22
				strStandupIndiaDesc="";
				if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("Y"))
					strStandupIndiaDesc="Yes";
				else if(Helper.correctNull(rs.getString("APP_STANDUP_INDIA")).equalsIgnoreCase("N"))
					strStandupIndiaDesc="No";
				else
					strStandupIndiaDesc="";
				arrCol.add(strStandupIndiaDesc);//23
				String strOrg_dept="";
				if(rs1 != null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("getuser_det^"+ Helper.correctNull(rs.getString("MSME_CREATED_BY")));
				if(rs1.next()){
					arrCol.add(Helper.correctNull(rs.getString("MSME_CREATED_BY"))+"-"+Helper.correctNull(rs1.getString("user_name")));//24
					arrCol.add(Helper.correctNull(rs.getString("MSME_CREATED_ON")));//25
					arrCol.add(Helper.correctNull(rs1.getString("ORG_NAME")));//26
					if(("001").equalsIgnoreCase(Helper.correctNull(rs1.getString("USR_DEPARTMENT")))){
						if(rs2!=null)
						{
							rs2.close();
						}
						
						rs2=DBUtils.executeQuery(SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^20^"+Helper.correctNull(rs.getString("MSME_ORGDEPT"))));
						if(rs2.next())
						{
							strOrg_dept=Helper.correctNull((String)rs2.getString("cbs_static_data_desc"));
						}}
					arrCol.add(strOrg_dept);//27
				}else{
					arrCol.add("");//24
					arrCol.add("");//25
					arrCol.add("");//26
					arrCol.add("");//27
				}
				if(rs1 != null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("getuser_det^"+ Helper.correctNull(rs.getString("MSME_APPROVEDBY")));
				if(rs1.next()){
					arrCol.add(Helper.correctNull(rs.getString("MSME_APPROVEDBY"))+"-"+Helper.correctNull(rs1.getString("user_name")));//28
					arrCol.add(Helper.correctNull(rs.getString("MSME_APPROVEDDATE")));//29
					arrCol.add(Helper.correctNull(rs1.getString("ORG_NAME")));//30
					if(("001").equalsIgnoreCase(Helper.correctNull(rs.getString("MSME_ApprovedOrgdept")))){
						if(rs2!=null)
						{
							rs2.close();
						}
						
						rs2=DBUtils.executeQuery(SQLParser.getSqlQuery("sel_CBSStaticDataPassingCode^20^"+Helper.correctNull(rs.getString("MSME_ApprovedOrgdept"))));
						if(rs2.next())
						{
							strOrg_dept=Helper.correctNull((String)rs2.getString("cbs_static_data_desc"));
						}}
					arrCol.add(strOrg_dept);//31
				}else{
					arrCol.add("");//28
					arrCol.add("");//29
					arrCol.add("");//30
					arrCol.add("");//31
				}
				
				
				arrCol.add(Helper.correctNull(rs.getString("app_activitycode_old")));//32
				arrCol.add(Helper.correctNull(rs.getString("app_activitycode")));//33
				arrCol.add(Helper.correctNull(rs.getString("msme_proposalno")));//34
				arrRow.add(arrCol);
			}
          		
			hshValues.put("arrRow", arrRow);

			
		}
		catch(Exception ce)
		{
			System.out.println(ce.toString());
			throw new EJBException("Error in getMsmeLeadReport "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
}
	
	
	public HashMap getOnlineReport(HashMap hshValues) 
	{
 		ResultSet rs = null;
 		ResultSet rs1=null;
 		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strOpFields = "";
		String strSelFields= "";
		String strStatus=null;
		String strTemp=null;
		String txttoamt=null;
		String strFromDate=null;
		String strToDate=null;
		ArrayList vecT = new ArrayList();
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strDatetype="",strAppstatus="";
		String strMultiLoanType="";
		String strloantype="",strConstitution="",strConstitutionDesc="",strReferenceNo="";
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		double dblTL=0.0,dblWC=0.0,dblTOT=0.0;
		StringBuffer strbufOrgcode=new StringBuffer();
			
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strDate =(String)hshValues.get("txtDate");
			strGen =(String)hshValues.get("strUserId");
			strOrgCode =(String)hshValues.get("hidOrgCode");
			strStatus =(String)hshValues.get("hidStatus");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			strMultiLoanType=correctNull((String)hshValues.get("loantype"));
			
			strMultiLoanType = strMultiLoanType.replaceAll("@", ",");
			int i = strMultiLoanType.length()-1; 
			strloantype = strMultiLoanType.substring(0, i);
			
				
			if(strOpFields.equals(""))  {	
				
				strOpFields="COMAPP_REFNO,COMAPP_COMPANYNAME,COMAPP_CONSTITUTION,(select sdcm_description from STATE_DIST_CITY_MASTER where sdcm_code=COMAPP_CITY) as city,COMAPP_PHONENO,COMAPP_PURPOSEOFLOAN,COMAPP_CONTACTPERSON,COMAPP_DATEOFINCORP,COMAPP_PRESENTLOA,COMAPP_PROPOSEDLOA,COMAPP_NETWORTH,COMAPP_NETWORTHDATE,COMAPP_WRKCAPLNAMT,COMAPP_TERMLNAMT,org_name";
			}
			
			if(!((strOrglevel.equalsIgnoreCase("State")) || (strOrglevel.equalsIgnoreCase("City")) ||(strOrglevel.equalsIgnoreCase("S/C"))))
			{
			strOrgCode=strOrgCode.replaceAll("'","");
			}
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("comapp_org_scode like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("comapp_org_scode like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("comapp_org_scode like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("comapp_org_scode like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("comapp_org_scode = '").append(strOrgCode).append("'");
			}
			else if(strOrglevel.equalsIgnoreCase("State"))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_STATE in (").append(strOrgCode).append(")");
						
				}
				else
				{
					strbufOrgcode.append("ORG_STATE =").append(strOrgCode);
				}
			}
			else if((strOrglevel.equalsIgnoreCase("City"))||(strOrglevel.equalsIgnoreCase("S/C")))
			{
				if(strOrgCode.indexOf(",")!=-1)
				{
					strbufOrgcode.append("ORG_CITY in (").append(strOrgCode).append(")");
				}
				else
				{
					strbufOrgcode.append("ORG_CITY =").append(strOrgCode);
				}
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next()) {
				
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			
			strFromDate =(String)hshValues.get("txtFromDate");
			strToDate =(String)hshValues.get("txtToDate");
			
			if(rs != null){
				rs.close();}
			
			hshRec = new HashMap();
			vecVal = new ArrayList();
			
			if(strStatus.equalsIgnoreCase("Q")){
				
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_requested^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strFromDate+"^"+strToDate);
			}else if(strStatus.equalsIgnoreCase("D")){
				
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_detailed^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strFromDate+"^"+strToDate);	
			}
			else if(strStatus.equalsIgnoreCase("U")){
				strQuery=SQLParser.getSqlQuery("sel_online_status_report_uploadedtolaps^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strFromDate+"^"+strToDate);	
			}
			
			rs=DBUtils.executeInternetParserQuery(strQuery);
			while (rs.next()) {
				arrCol=new ArrayList();
				strReferenceNo=correctNull(rs.getString("COMAPP_REFNO"));
				arrCol.add(correctNull(rs.getString("COMAPP_REFNO")));//0
				arrCol.add(correctNull(rs.getString("COMAPP_COMPANYNAME")));//1
				strConstitution=correctNull(rs.getString("COMAPP_CONSTITUTION"));
				if(strConstitution.equalsIgnoreCase("1")||strConstitution.equalsIgnoreCase("01"))
					strConstitutionDesc="Individuals";
				else if(strConstitution.equalsIgnoreCase("11"))
					strConstitutionDesc="Proprietary Concerns";
				else if(strConstitution.equalsIgnoreCase("09")||strConstitution.equalsIgnoreCase("9"))
					strConstitutionDesc="Partnership firms";
				else if(strConstitution.equalsIgnoreCase("10"))
					strConstitutionDesc="Joint Families(HUF)";
				else if(strConstitution.equalsIgnoreCase("06")||strConstitution.equalsIgnoreCase("6"))
					strConstitutionDesc="Trusts";
				else if(strConstitution.equalsIgnoreCase("101"))
					strConstitutionDesc="Groups";
				else if(strConstitution.equalsIgnoreCase("102"))
					strConstitutionDesc="Limited Liability Partnership";
				else if(strConstitution.equalsIgnoreCase("103"))
					strConstitutionDesc="Joint Liability Groups(JLGs)";
				else if(strConstitution.equalsIgnoreCase("104"))
					strConstitutionDesc="Central Government Dept-Railways";
				else if(strConstitution.equalsIgnoreCase("105"))
					strConstitutionDesc="Central Government Dept-Telegraphs";
				else if(strConstitution.equalsIgnoreCase("106"))
					strConstitutionDesc="Cent";
				arrCol.add(strConstitutionDesc);//2
				arrCol.add(correctNull(rs.getString("city")));//3
				arrCol.add(correctNull(rs.getString("COMAPP_PHONENO")));//4
				arrCol.add(correctNull(rs.getString("COMAPP_PURPOSEOFLOAN")));//5
				arrCol.add(correctNull(rs.getString("COMAPP_CONTACTPERSON")));//6
				arrCol.add(correctNull(rs.getString("COMAPP_DATEOFINCORP")));//7
				arrCol.add(correctNull(rs.getString("COMAPP_PRESENTLOA")));//8
				arrCol.add(correctNull(rs.getString("COMAPP_PROPOSEDLOA")));//9
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("COMAPP_NETWORTH")))));//10
				arrCol.add(correctNull(rs.getString("COMAPP_NETWORTHDATE")));//11
				dblTL=Double.parseDouble(Helper.correctDouble(rs.getString("COMAPP_WRKCAPLNAMT")));
				dblWC=Double.parseDouble(Helper.correctDouble(rs.getString("COMAPP_TERMLNAMT")));
				dblTOT=dblTL+dblWC;
				arrCol.add(nf.format(dblTL));//12
				arrCol.add(nf.format(dblWC));//13
				arrCol.add(nf.format(dblTOT));//14
				
				if(strStatus.equalsIgnoreCase("U"))
				{
					if(rs1!=null)
					{rs1.close();}
					rs1=DBUtils.executeLAPSQuery("selappstatusbasedoninwardno^"+strReferenceNo);
					if (rs1.next()) {
						strAppstatus =correctNull(rs1.getString("app_status"));
					}
					if(strAppstatus.equalsIgnoreCase("op"))
						strAppstatus="Open/Pending";
					else if(strAppstatus.equalsIgnoreCase("pa"))
						strAppstatus="Processed/Approved";
					else if(strAppstatus.equalsIgnoreCase("pr"))
						strAppstatus="Processed/Rejected";
					else if(strAppstatus.equalsIgnoreCase("ca"))
						strAppstatus="Closed/Approved";
					else if(strAppstatus.equalsIgnoreCase("cr"))
						strAppstatus="Closed/Rejected";
					else
						strAppstatus="";
					arrCol.add(strAppstatus);//15
				}else{
					arrCol.add("");//15
				}
				arrCol.add(correctNull(rs.getString("org_name")));//16
				arrRow.add(arrCol);
			}
				
			hshRec.put("strStatus",strStatus);
			hshRec.put("arrRow",arrRow);
			hshRec.put("labels",strSelFields);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("strFromDate",strFromDate);
			hshRec.put("strToDate",strToDate);
			hshRec.put("Org_Name",strOrg_Name);
			hshRec.put("loantype",strloantype);
			hshRec.put("strOpFields",strOpFields);
			hshRec.put("strbufOrgcode",strbufOrgcode.toString());
			
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRec;
	}
	public HashMap getLsrrReport(HashMap hshValues) 
	{

 		ResultSet rs = null;
 		ResultSet rs1=null,rs2=null,rs3=null;
		ArrayList arrRow=null;
		HashMap hshRec=null;
		ArrayList arrCol =null;
		ArrayList Arrvalues =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strTemp=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strloantype="",appno="";
		String strPeriodicity="";
		HashMap hshResults=new HashMap();
		ArrayList arrBorroweExposure=null;
		ArrayList arrBorroweExposureCol=null;
		double strProposedExposure=0.00;
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		double strtotSancamt=0.00;
		StringBuffer strbufOrgcode=new StringBuffer();
		double sanctionamt=0.00;
		String strorgScode="";
		StringBuffer strQueryFirst=new StringBuffer();
		StringBuffer strQueryLast=new StringBuffer();
		StringBuffer strbufDesignation=new StringBuffer();
		String strcreWeight="";
		String strStaffId="";
		String strSessionOrgCode="";
		String residentType="";
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strFromDate =(String)hshValues.get("txtFromDate");
			strToDate =(String)hshValues.get("txtToDate");
			strGen =(String)hshValues.get("strUserId");
			strOrgCode =(String)hshValues.get("hidOrgCode");
			strSessionOrgCode =(String)hshValues.get("strOrgCode");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			strDepartment=correctNull((String)hshValues.get("seldepartment"));
			strDesignation=correctNull((String)hshValues.get("seldesignation"));
			strOrgCode=strOrgCode.replaceAll("'","");
			
			if(strOrglevel.equalsIgnoreCase("CPC"))
			{
				strOrgCode = strSessionOrgCode;
			}
			strQuery=SQLParser.getSqlQuery("repbankname^"+strOrgCode);
			rs2=DBUtils.executeQuery(strQuery);
			if(rs2.next())
			{
				strorgScode=correctNull((String)rs2.getString("org_scode"));
			}
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strQuery=SQLParser.getSqlQuery("sel_cbsdatapassingcode^"+strDepartment);
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
					strDepartment=correctNull((String)rs2.getString("cbs_static_data_code"));
				}
				strbufDesignation.append(",CASE app_loantype WHEN 'P' THEN (SELECT appsanc_appno FROM appraisalsanction WHERE appsanc_appno = app.app_no AND appraisal_sancauth = '").append(strDesignation).append("'").append(" and APPRAISAL_DEPARTMENT= '").append(strDepartment).append("'").append(")ELSE (SELECT com_appno FROM com_briefbackground  WHERE com_appno = app.app_no AND com_sancauthority = '").append(strDesignation).append("'").append(" and COM_SANCDEPT ='").append(strDepartment).append("'").append(")END as appsanc");
				strbufOrgcode.append("app_processorgscode=org_scode and org_scode= '").append(strorgScode).append("'");
				strQueryLast.append("where appsanc is not null");
			}
			else if(strOrglevel.equalsIgnoreCase("R")|| strOrglevel.equalsIgnoreCase("D")|| strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufDesignation.append(",CASE app_loantype WHEN 'P' THEN (SELECT appsanc_appno FROM appraisalsanction WHERE appsanc_appno = app.app_no AND appraisal_sancauth = '").append(strDesignation).append("'").append(")ELSE (SELECT com_appno FROM com_briefbackground  WHERE com_appno = app.app_no AND com_sancauthority = '").append(strDesignation).append("'").append(")END as appsanc");
				if(strOrglevel.equalsIgnoreCase("D"))
					strbufOrgcode.append("APP_ORGCODE=org_code and org_code like '").append(strOrgCode.substring(0, 9)).append("%%'");
				else
					strbufOrgcode.append("app_processorgscode=org_scode and org_scode= '").append(strorgScode).append("'");
				strQueryLast.append("where appsanc is not null");
			}
			else
			{
				strbufDesignation.append("  ");
				strbufOrgcode.append("app_processorgscode=org_scode and org_scode= '").append(strorgScode).append("'");
				strQueryLast.append("  ");
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			
			hshRec = new HashMap();
			Arrvalues=new ArrayList();
			arrRow = new ArrayList();
			
			strQuery=SQLParser.getSqlLSRRQuery("sel_Applicationdetails~"+strbufDesignation.toString()+"~"+strbufOrgcode.toString()+"~"+strFromDate+"~"+strToDate+"~"+strQueryLast.toString());
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				appno=correctNull(rs2.getString("app_no"));
				//appno="05000000009";
				hshValues.put("appno",appno);
				strloantype=correctNull(rs2.getString("APP_LOANTYPE"));
			if(strloantype.equalsIgnoreCase("P")){
				strQuery=SQLParser.getSqlQuery("sel_lsrr_reportretail^"+appno);
			
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				residentType=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));
				arrCol = new ArrayList();
				strStaffId=Helper.correctNull(rs.getString("indinfo_staff_id"));
				hshValues.put("appid",correctNull((String)rs.getString("demo_oldappid")));
				strAppid=correctNull((String)rs.getString("demo_oldappid"));
				strTemp =correctNull(rs.getString("sanctionrefno"));
				strTemp=strTemp+" - "+correctNull(rs.getString("app_processdate"));
				arrCol.add(strTemp);//0
				
				strTemp=correctNull(rs.getString("PERAPP_CBSID"))+"@"+correctNull(rs.getString("demo_type"))+"@";
				if(strStaffId.equalsIgnoreCase(""))
					strTemp =strTemp+correctNull(rs.getString("name"))+"@";
				else
					strTemp =strTemp+correctNull(rs.getString("name"))+"<b>&nbsp;["+strStaffId+"]&nbsp;</b>"+"@";	
				if(residentType.equals("N"))
				{
					strTemp =strTemp+Helper.replaceForJavaScriptString(correctNull(rs.getString("Address")))+"~";
				}
				else
				{
					strTemp =strTemp+Helper.replaceForJavaScriptString(correctNull(rs.getString("permaddress")))+"~";
				}
				
				strQuery1=SQLParser.getSqlQuery("sel_coappguradetails^"+appno);
				rs1=DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					residentType=correctNull(rs1.getString("INDINFO_RESIDENT_STATUS"));
					strTemp=strTemp+correctNull(rs1.getString("PERAPP_CBSID"))+"@"+correctNull(rs1.getString("demo_type"))+"@";
					strTemp=strTemp+correctNull((String)rs1.getString("name"))+"@";
					if(residentType.equals("N"))
					{
						strTemp=strTemp+Helper.replaceForJavaScriptString(correctNull((String)rs1.getString("Address")))+"~";
					}
					else
					{
						strTemp=strTemp+Helper.replaceForJavaScriptString(correctNull((String)rs1.getString("permAddress")))+"~";
					}
				}
				arrCol.add(strTemp);//1
				arrCol.add(Helper.addComma(Helper.correctDouble((String)rs.getString("PERAPP_NETWORTH"))));//2
				
				arrCol.add(correctNull((String)rs.getString("occupation")));//3
				
				arrCol.add(Helper.removeHTMLTags(Helper.CLOBToString(rs.getClob("loan_purposeofloan"))).toString().replaceAll("&nbsp;", "").replaceAll("--", "").replaceAll("\n", "")+"~");//4
				
				if(correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("OD"))
					strTemp ="OverDraft - "+Helper.correctNull(rs.getString("prd_bankscheme"));
				else if(correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("DL"))
					strTemp ="Demand Loan - "+Helper.correctNull(rs.getString("prd_bankscheme"));
				else if(correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("TL"))
					strTemp ="Term Loan - "+Helper.correctNull(rs.getString("prd_bankscheme"));
				else
					strTemp=" - "+Helper.correctNull(rs.getString("prd_bankscheme"));
				/*if(strTemp.equalsIgnoreCase("TL")){
					strTemp="Term Loan";
				}else if(strTemp.equalsIgnoreCase("DL"))
				{
					strTemp="Demand Loan";
				}else if(strTemp.equalsIgnoreCase("OD")){
					strTemp="Over Draft";
				}*/
				
				strTemp=strTemp+" - "+Helper.addComma(Helper.correctDouble(rs.getString("loan_recmdamt")));
				sanctionamt=sanctionamt+Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt")));
				//Gobi
				strtotSancamt=strtotSancamt+Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt")));
				strtotSancamt=Double.parseDouble(nf.format(strtotSancamt));
				
				arrCol.add(strTemp+"~");//5
				
				strQuery1=SQLParser.getSqlQuery("sel_Securitydetailsnew^"+appno+"^"+strAppid);
				rs1=DBUtils.executeQuery(strQuery1);
				StringBuffer strSecurityName=new StringBuffer();
				StringBuffer strMargin=new StringBuffer();
				StringBuffer strSecType=new StringBuffer();
				StringBuffer strSecValue=new StringBuffer();
				StringBuffer strSecValuation=new StringBuffer();
				while(rs1.next()){
					strSecurityName.append(correctNull(rs1.getString("SEC_NAME"))+"~");
					strMargin.append(Helper.correctDouble(rs1.getString("app_sec_margin"))+"~");
					if(Helper.correctNull(rs1.getString("app_sec_securitytype")).equalsIgnoreCase("1"))
						strSecType.append("Primary~");
					else
						strSecType.append("Collateral~");
					strSecValue.append(Helper.correctDouble(rs1.getString("app_sec_securityvalue"))+"~");
					strSecValuation.append(Helper.correctDouble(rs1.getString("cus_sec_valuation_date"))+"~");
				}
				
				arrCol.add(strSecurityName.toString());//6
				arrCol.add(strMargin.toString());//7
				
				//double baserate=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_baserate")));
				double modROIrate=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_modintrate")));
				double dblROIrate=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_intrate")));
				//double ROI=modROIrate-baserate;
				//dblROIrate=dblROIrate-baserate;
				arrCol.add(nf.format(dblROIrate)+"~");//8
				
				strTemp =correctNull(rs.getString("LOAN_REQTERMS"));
				strPeriodicity =correctNull(rs.getString("loan_repaymenttype"));
				if(strPeriodicity.equalsIgnoreCase("1"))
				{
					strPeriodicity="Equated Monthly Installment";
				}else if(strPeriodicity.equalsIgnoreCase("2"))
				{
					strPeriodicity="Non_EMI";
				}else if(strPeriodicity.equalsIgnoreCase("3"))
				{
					strPeriodicity="Graduated installments";
				}else if(strPeriodicity.equalsIgnoreCase("4"))
				{
					strPeriodicity="Step Up";
				}
				else if(strPeriodicity.equalsIgnoreCase("5"))
				{
					strPeriodicity="Step Down";
				}
				else if(strPeriodicity.equalsIgnoreCase("6"))
				{
					strPeriodicity="Taper Down";
				}
				else if(strPeriodicity.equalsIgnoreCase("7"))
				{
					strPeriodicity="Balloon";
				}
				else if(strPeriodicity.equalsIgnoreCase("9"))
				{
					strPeriodicity="Flip Method";
				}
				else if(strPeriodicity.equalsIgnoreCase("10"))
				{
					strPeriodicity="Equal Installments";
				}
				else if(strPeriodicity.equalsIgnoreCase("11"))
				{
					strPeriodicity="Slab";
				}
				else if(strPeriodicity.equalsIgnoreCase("12"))
				{
					strPeriodicity="OverDraft";
				}
				else if(strPeriodicity.equalsIgnoreCase("13"))
				{
					strPeriodicity="Equal Monthly Installments";
				}
				else if(strPeriodicity.equalsIgnoreCase("8"))
				{
					strPeriodicity="Bullet";
				}
				else{
					strPeriodicity="Not Applicable";
				}
				arrCol.add(strPeriodicity+"~");//9
				arrCol.add(strTemp+"~");//10
				
				strTemp =correctNull(rs.getString("app_sector"));
				if(strTemp.equalsIgnoreCase("01")){
					
					strTemp="Priority Sector";
				}else if(strTemp.equalsIgnoreCase("02"))
				{
					strTemp="Non - Priority Sector";
				}
				arrCol.add(strTemp);//11
				
				if(rs1!=null)
				{rs1.close();}
				strQuery1=SQLParser.getSqlQuery("sel_borrower_totalexposureamount^"+appno+"^"+strAppid);
				rs1=DBUtils.executeQuery(strQuery1);
				if (rs1.next()) {
					arrCol.add(Helper.addComma(Helper.correctDouble((String)rs1.getString("APP_TOTALEXPOSURE"))));
				}else{
					arrCol.add("0.00");//12
				}
				if(Helper.correctNull((String)rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("C")||Helper.correctNull((String)rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("D"))
				{
					if(!Helper.correctNull((String)rs.getString("LOAN_PERTAINS_BRANCH")).equalsIgnoreCase(""))
					{
						if(rs1!=null)
						{rs1.close();}
						strQuery1=SQLParser.getSqlQuery("selectorgname^"+Helper.correctNull((String)rs.getString("LOAN_PERTAINS_BRANCH")));
						rs1=DBUtils.executeQuery(strQuery1);
						if (rs1.next()) 
							arrCol.add(Helper.correctNull((String)rs1.getString("org_name")));//13
						else
							arrCol.add(Helper.correctNull((String)rs.getString("orgname")));//13
					}
					else
					{
						arrCol.add(Helper.correctNull((String)rs.getString("orgname")));//13
					}
				}
				else
				{
					arrCol.add(Helper.correctNull((String)rs.getString("orgname")));//13
				}
				arrCol.add(nf.format(modROIrate)+"~");//14
				arrCol.add(Helper.correctNull((String)rs.getString("constitution")));//15
				arrCol.add(" ");//16
				
				if(rs1!=null)
				{rs1.close();}
				strQuery1=SQLParser.getSqlQuery("sel_crerating^"+appno);
				rs1=DBUtils.executeQuery(strQuery1);
				if (rs1.next()) {
					
					strcreWeight=correctNull(rs1.getString("cre_weight"));
					if(strcreWeight.equalsIgnoreCase("KB1"))
					{
						strcreWeight+=" - Minimal Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB2"))
					{
						strcreWeight+=" - Lowest Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB3"))
					{
						strcreWeight+=" - Lower Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB4"))
					{
						strcreWeight+=" - Low Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB5"))
					{
						strcreWeight+=" - Moderate Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB6"))
					{
						strcreWeight+=" - Average Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB7"))
					{
						strcreWeight+=" - High Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB8"))
					{
						strcreWeight+=" - Very high Risk";
					}else if(strcreWeight.equalsIgnoreCase("KB9"))
					{
						strcreWeight+=" - Sub standard (highest)";
					}else if(strcreWeight.equalsIgnoreCase("KB10"))
					{
						strcreWeight+=" - Doubt full/ loss (critical)";
					}
					arrCol.add(strcreWeight);//17
				}else{
					arrCol.add("");//17
				}
				if(rs1!=null)
				{rs1.close();}
				strQuery1=SQLParser.getSqlQuery("getCollSecPercnt^"+appno);
				rs1=DBUtils.executeQuery(strQuery1);
				if (rs1.next()) {
					
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("app_totalseccoverage")))));//18
					
				}else{
					
					arrCol.add(" ");//18
				}
				arrCol.add("0.00");//19
				arrCol.add("0.00");//20
				arrCol.add(strSecType.toString());
				arrCol.add(strSecValue.toString());
				arrCol.add(strSecValuation.toString());
				arrRow.add(arrCol);
				
			}
		}else{
				strQuery=SQLParser.getSqlQuery("sel_lsrr_reportAgri^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					arrCol = new ArrayList();
					
					residentType=correctNull(rs.getString("INDINFO_RESIDENT_STATUS"));

					strStaffId=Helper.correctNull(rs.getString("indinfo_staff_id"));
 					hshValues.put("appid",correctNull((String)rs.getString("demo_comappid")));
 					strAppid=correctNull((String)rs.getString("demo_comappid"));
					
					strTemp =correctNull(rs.getString("sanctionrefno"));
					strTemp=strTemp+" - "+correctNull(rs.getString("app_processdate"));
					arrCol.add(strTemp);//0
					
					strTemp=correctNull(rs.getString("PERAPP_CBSID"))+"@"+"a@";
					if(strStaffId.equalsIgnoreCase(""))
					strTemp =strTemp+correctNull(rs.getString("name"))+"@";
					else
						strTemp =strTemp+correctNull(rs.getString("name"))+"<b>&nbsp;["+strStaffId+"]&nbsp;</b>"+"@";
					if(residentType.equals("N"))
					{
						strTemp =strTemp+Helper.replaceForJavaScriptString(correctNull(rs.getString("Address")))+"~";
					}
					else
					{
						strTemp =strTemp+Helper.replaceForJavaScriptString(correctNull(rs.getString("permaddress")))+"~";
					}
					
					String strType="";
					String strTypeArr[]	= null;
					String strCBSid="";
					String strGTemp="",strOTemp="",strCOTemp="",strCTemp="";
					strQuery1=SQLParser.getSqlQuery("compromotertagsel^"+appno);
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next()){
						strType			= correctNull(rs1.getString("com_compdttype"));
						if(!strType.equals(""))
						{
							strTypeArr			= strType.split("@");
						}
						
						boolean boolFlag=true;
						if(strTypeArr!=null)
						{
							for(int i=0;i<strTypeArr.length;i++)
							{
								String strTitle="";
								if(boolFlag==true){
								boolFlag=false;
								if(strTypeArr[i].equalsIgnoreCase("G"))
								{
									
									strQuery1=SQLParser.getSqlQuery("coapdetails^"+Helper.correctInt(rs1.getString("com_compdtappid")));
									rs3=DBUtils.executeQuery(strQuery1);
									if(rs3.next()){
										strCBSid=correctNull(rs3.getString("PERAPP_CBSID"));
										strTitle=correctNull(rs3.getString("perapp_title"));
									}
									strGTemp=strGTemp+strCBSid+"@"+strTypeArr[i]+"@";
									strGTemp=strGTemp+strTitle+"&nbsp;"+correctNull(rs1.getString("com_compdtfname"))+"@";
									strGTemp=strGTemp+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress1")))+", "+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress2")))+","+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtcity"))+","+correctNull(rs1.getString("com_compdtstate")))+","+correctNull(rs1.getString("com_compdtpin"))+"~";
								}
								else if(strTypeArr[i].equalsIgnoreCase("C"))
								{
									
									strQuery1=SQLParser.getSqlQuery("coapdetails^"+Helper.correctInt(rs1.getString("com_compdtappid")));
									rs3=DBUtils.executeQuery(strQuery1);
									if(rs3.next()){
										strCBSid=correctNull(rs3.getString("PERAPP_CBSID"));
										strTitle=correctNull(rs3.getString("perapp_title"));
									}
									strCTemp=strCTemp+strCBSid+"@"+strTypeArr[i]+"@";
									strCTemp=strCTemp+strTitle+"&nbsp;"+correctNull(rs1.getString("com_compdtfname"))+"@";
									strCTemp=strCTemp+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress1")))+", "+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress2")))+","+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtcity"))+","+correctNull(rs1.getString("com_compdtstate")))+","+correctNull(rs1.getString("com_compdtpin"))+"~";
								}
								else if(strTypeArr[i].equalsIgnoreCase("CO"))
								{
									
									strQuery1=SQLParser.getSqlQuery("coapdetails^"+Helper.correctInt(rs1.getString("com_compdtappid")));
									rs3=DBUtils.executeQuery(strQuery1);
									if(rs3.next()){
										strCBSid=correctNull(rs3.getString("PERAPP_CBSID"));
										strTitle=correctNull(rs3.getString("perapp_title"));
									}
									strCOTemp=strCOTemp+strCBSid+"@"+strTypeArr[i]+"@";
									strCOTemp=strCOTemp+strTitle+"&nbsp;"+correctNull(rs1.getString("com_compdtfname"))+"@";
									strCOTemp=strCOTemp+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress1")))+", "+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress2")))+","+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtcity"))+","+correctNull(rs1.getString("com_compdtstate")))+","+correctNull(rs1.getString("com_compdtpin"))+"~";
								}
								else
								{
									
									strQuery1=SQLParser.getSqlQuery("coapdetails^"+Helper.correctInt(rs1.getString("com_compdtappid")));
									rs3=DBUtils.executeQuery(strQuery1);
									if(rs3.next()){
										strCBSid=correctNull(rs3.getString("PERAPP_CBSID"));
										strTitle=correctNull(rs3.getString("perapp_title"));
									}
									strOTemp=strOTemp+strCBSid+"@"+strTypeArr[i]+"@";
									strOTemp=strOTemp+strTitle+"&nbsp;"+correctNull(rs1.getString("com_compdtfname"))+"@";
									strOTemp=strOTemp+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress1")))+", "+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtaddress2")))+","+Helper.replaceForJavaScriptString(correctNull(rs1.getString("com_compdtcity"))+","+correctNull(rs1.getString("com_compdtstate")))+","+correctNull(rs1.getString("com_compdtpin"))+"~";
								}
								}
							}
						}
					}
					arrCol.add(strTemp+strGTemp+strCTemp+strCOTemp+strOTemp);//1
					
					arrCol.add(Helper.addComma(Helper.correctDouble((String)rs.getString("PERAPP_NETWORTH"))));//2
					arrCol.add(correctNull((String)rs.getString("occupation")));//3
					
					if(rs1!=null){rs1.close();}
					StringBuffer strFacilityPurpose=new StringBuffer();
					StringBuffer strFacilityClassification=new StringBuffer();
					StringBuffer strFacilityPeriod=new StringBuffer();
					StringBuffer strFacilityPeriodicity=new StringBuffer();
					StringBuffer strFacilityROI=new StringBuffer();
					StringBuffer strFacilitySancROI=new StringBuffer();
					String strFacilityNature="",strFacilitySno="",strBankScheme="";
					double strBaserate=0.00,strROI=0.00;
					double dblSanROI=0.00;
					int intcountpri=0,intcountnonpri=0;
					strQuery1=SQLParser.getSqlQuery("sel_facdetails^"+appno);
					rs1=DBUtils.executeQuery(strQuery1);
					while(rs1.next()){
						
						strPeriodicity=correctNull(rs1.getString("facility_repaytype"));
						if(strPeriodicity.equalsIgnoreCase("E"))
						{
							strPeriodicity="EMI";
						}else if(strPeriodicity.equalsIgnoreCase("NE"))
						{
							strPeriodicity="Non-EMI";
						}else if(strPeriodicity.equalsIgnoreCase("OD"))
						{
							strPeriodicity="On Demand";
						}else if(strPeriodicity.equalsIgnoreCase("LC"))
						{
							strPeriodicity="As Per LC Terms";
						}else if(strPeriodicity.equalsIgnoreCase("CO"))
						{
							strPeriodicity="As Per Contract Terms";
						}else if(strPeriodicity.equalsIgnoreCase("BG"))
						{
							strPeriodicity="As Per BG Rules";
						}else if(strPeriodicity.equalsIgnoreCase("DD"))
						{
							strPeriodicity="On Due Date";
						}else if(strPeriodicity.equalsIgnoreCase("PC"))
						{
							strPeriodicity="From the proceeds of PSC / by realization of bill";
						}
						else if(strPeriodicity.equalsIgnoreCase("PS"))
						{
							strPeriodicity="By Realization of Export Bills";
						}
						else if(strPeriodicity.equalsIgnoreCase("PR"))
						{
							strPeriodicity="By Realization of Respective Bills";
						}
						else if(strPeriodicity.equalsIgnoreCase("TG"))
						{
							strPeriodicity="As per TCBG Rules";
						}
						else{
							strPeriodicity="Not Applicable";
						}
						double fac_sancamt=0.00;
						String fac_headfac="",strFacgroup="";
						strFacilityNature=correctNull(rs1.getString("com_facnature"));
						if(strFacilityNature.equalsIgnoreCase("1"))
							strFacilityNature="Working Capital";
						else if(strFacilityNature.equalsIgnoreCase("2"))
							strFacilityNature="Term Loan";
						else
							strFacilityNature="";
						strBankScheme=correctNull(rs1.getString("com_bankscheme"));
						strBaserate=Double.parseDouble(Helper.correctDouble(rs1.getString("facility_baserate")));
						strROI=Double.parseDouble(Helper.correctDouble(rs1.getString("BPLR")));
						dblSanROI=Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancinterest")));
						//strROI=strROI-strBaserate;
						//dblSanROI=dblSanROI-strBaserate;
						strFacilityPeriodicity.append(strPeriodicity+"~");
						strFacilityPeriod.append(correctNull(rs1.getString("facility_months"))+"~");
						strFacilityPurpose.append(Helper.replaceForJavaScriptString(Helper.CLOBToString(rs1.getClob("FACILITY_PURPOSE")))+"~");
						
						fac_sancamt=Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancamt")));
						fac_headfac=correctNull(rs1.getString("com_headfac"));
						if(fac_headfac.equalsIgnoreCase("1"))
						{
							fac_sancamt=fac_sancamt/50;
						}
						strFacgroup=correctNull(rs1.getString("facility_group"));
						if(!strFacgroup.equalsIgnoreCase("0"))
						{
							strFacilityClassification.append("("+strFacilityNature+" - "+strBankScheme+" - "+Helper.addComma(nf.format(fac_sancamt))+")~");
						}else{
							strFacilityClassification.append(strFacilityNature+" - "+strBankScheme+" - "+Helper.addComma(nf.format(fac_sancamt))+"~");
						}
						if(strFacgroup.equalsIgnoreCase("0"))
						{
							sanctionamt=sanctionamt+fac_sancamt;
						}
						if(!correctNull(rs1.getString("facility_intsubtype")).equalsIgnoreCase(""))
						{
							strFacilityROI.append(nf.format(strROI)+"~");
						}else{
							strFacilityROI.append(nf.format(strROI)+"~");
						}
						if(!correctNull(rs1.getString("facility_intsubtype")).equalsIgnoreCase(""))
						{
							strFacilitySancROI.append(nf.format(dblSanROI)+"~");
						}else{
							strFacilitySancROI.append(nf.format(dblSanROI)+"~");
						}
						strFacilitySno=correctNull(rs1.getString("facility_sno"));
						strTemp="";
						if(rs3!=null){rs3.close();}
						strQuery1=SQLParser.getSqlQuery("sel_misappclassification^"+appno+"^"+strFacilitySno);
						rs3=DBUtils.executeQuery(strQuery1);
						if(rs3.next()){
							strTemp =correctNull(rs3.getString("app_sector"));
							if(strTemp.equalsIgnoreCase("01")){
								intcountpri++;
								strTemp="Priority Sector";
							}else if(strTemp.equalsIgnoreCase("02"))
							{
								intcountnonpri++;
								strTemp="Non - Priority Sector";
							}
							strTemp=strTemp;
						}
						else{
							strTemp=strTemp;
						}
						
					}
					arrCol.add(strFacilityPurpose.toString());//4
					arrCol.add(strFacilityClassification.toString());//5
					
					strQuery1=SQLParser.getSqlQuery("sel_Securitydetailsnew^"+appno+"^"+strAppid);
					rs1=DBUtils.executeQuery(strQuery1);
					StringBuffer strSecurityName=new StringBuffer();
					StringBuffer strMargin=new StringBuffer();
					StringBuffer strSecType=new StringBuffer();
					StringBuffer strSecValue=new StringBuffer();
					StringBuffer strSecValuation=new StringBuffer();
					while(rs1.next()){
						strSecurityName.append(correctNull(rs1.getString("SEC_NAME"))+"~");
						strMargin.append(Helper.correctDouble(rs1.getString("app_sec_margin"))+"~");
						if(Helper.correctNull(rs1.getString("app_sec_securitytype")).equalsIgnoreCase("1"))
							strSecType.append("Primary~");
						else
							strSecType.append("Collateral~");
						strSecValue.append(Helper.correctDouble(rs1.getString("app_sec_securityvalue"))+"~");
						strSecValuation.append(Helper.correctDouble(rs1.getString("cus_sec_valuation_date"))+"~");
					}
					
					arrCol.add(strSecurityName.toString());//6
					arrCol.add(strMargin.toString());//7
					
					arrCol.add(strFacilityROI.toString());//8
					arrCol.add(strFacilityPeriodicity.toString());//9
					arrCol.add(strFacilityPeriod.toString());//10
					if(intcountpri>=intcountnonpri)
					{
						arrCol.add("Priority Sector");//11
					}
					else{
						arrCol.add("Non - Priority Sector");//11
					}
					
					if(rs1!=null)
					{rs1.close();}
					strQuery1=SQLParser.getSqlQuery("sel_borrower_totalexposureamount^"+appno+"^"+strAppid);
					rs1=DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						
						arrCol.add(Helper.addComma(Helper.correctDouble((String)rs1.getString("APP_TOTALEXPOSURE"))));//12
						
					}else{
						
						arrCol.add("0.00");//12
					}
					
					if(Helper.correctNull((String)rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("C"))
					{
						if(rs1!=null)
						{rs1.close();}
						strQuery1=SQLParser.getSqlQuery("sel_pertainingbr^"+appno);
						rs1=DBUtils.executeQuery(strQuery1);
						if (rs1.next()) 
							arrCol.add(Helper.correctNull((String)rs1.getString("org_name")));//13
						else
							arrCol.add(Helper.correctNull((String)rs.getString("orgname")));//13
					}
					else
					{
						arrCol.add(Helper.correctNull((String)rs.getString("orgname")));//13
					}
					arrCol.add(strFacilitySancROI.toString());//14
					arrCol.add(Helper.correctNull((String)rs.getString("constitution")));//15
					arrCol.add(" ");//16
					if(rs1!=null)
					{rs1.close();}
					strQuery1=SQLParser.getSqlQuery("sel_crerating^"+appno);
					rs1=DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						
						strcreWeight=correctNull(rs1.getString("cre_weight"));
						if(strcreWeight.equalsIgnoreCase("KB1"))
						{
							strcreWeight+=" - Minimal Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB2"))
						{
							strcreWeight+=" - Lowest Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB3"))
						{
							strcreWeight+=" - Lower Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB4"))
						{
							strcreWeight+=" - Low Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB5"))
						{
							strcreWeight+=" - Moderate Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB6"))
						{
							strcreWeight+=" - Average Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB7"))
						{
							strcreWeight+=" - High Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB8"))
						{
							strcreWeight+=" - Very high Risk";
						}else if(strcreWeight.equalsIgnoreCase("KB9"))
						{
							strcreWeight+=" - Sub standard (highest)";
						}else if(strcreWeight.equalsIgnoreCase("KB10"))
						{
							strcreWeight+=" - Doubt full/ loss (critical)";
						}
						arrCol.add(strcreWeight);//17
					}else{
						arrCol.add("");//17
					}
					if(rs1!=null)
					{rs1.close();}
					strQuery1=SQLParser.getSqlQuery("getCollSecPercnt^"+appno);
					rs1=DBUtils.executeQuery(strQuery1);
					if (rs1.next()) {
						
						arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("app_totalseccoverage")))));//18
						
					}else{
						
						arrCol.add(" ");//18
					}
					double dblCOP=0.00;
					if(rs1!=null)
					{rs1.close();}
					strQuery1=SQLParser.getSqlQuery("sel_costofproject^"+appno);
					rs1=DBUtils.executeQuery(strQuery1);
					while (rs1.next()) {
						
						dblCOP=dblCOP+Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_totalvalue")));
					}
					arrCol.add(Helper.addComma(nf.format(dblCOP)));//19
					
					HashMap hshRes = new HashMap();
					String strFinID="0",cma="0",formuladesc="",desc="",strFinValues="";
					double dblRatio=0.00;
					String yearselect = "",strRatio="";
					strQuery = SQLParser.getSqlQuery("sel_financeid^" + appno);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						strFinID = Helper.correctInt((String) rs1
								.getString("DEMO_FINSTANDARD"));
						if (!strFinID.equals("")) {
							strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+ strFinID);
							if(rs3!=null){rs3.close();}
							rs3 = DBUtils.executeQuery(strQuery);
							if (rs3.next()) {
								cma = Helper.correctNull((String) rs3.getString("FIN_CMANO"));
							}
						}
					}
					if (rs1 != null)
						rs1.close();
					if(!strFinID.equalsIgnoreCase("0")){
					strQuery = SQLParser.getSqlQuery("com_finappvalues_audit_unaudit_select^"+ strFinID + "^<=^<^<");
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						yearselect = correctNull((String) rs1.getString("audityear"));
						if(Double.parseDouble(Helper.correctDouble((String) rs1.getString("fin_audit")))>0)
						{
							desc="a";
						}
						else{
							desc="u";
						}
							
					} else {
						yearselect = "";
					}
					}
					if (rs1 != null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("sel_NWC_Ratios^"+ cma);
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next()) {
						formuladesc = correctNull((String) rs1.getString("fin_formula"));
					}
					FinancialBean financial=new FinancialBean();
					if (!yearselect.trim().equalsIgnoreCase("")) {
						
						HashMap hshFinYearVal = new HashMap();
						hshFinYearVal.put("appno", appno);
						hshFinYearVal.put("strFinID", strFinID);
						hshFinYearVal.put("comappid", Helper.correctNull((String) hshValues.get("comapp_id")));
						
						//hshFinYearVal = (HashMap) EJBInvoker.executeStateLess("financial", hshFinYearVal, "getFinValues");
						hshFinYearVal = financial.getFinValues(hshFinYearVal);
						
						HashMap hshformula = new HashMap();
						hshformula.put("appno", appno);
						hshformula.put("strFinID", strFinID);
						hshformula.put("formulaid", formuladesc);
						hshformula.put("curryear", yearselect);
						hshformula.put("prevyear", "");
						hshformula.put("currfinancialtype", desc);
						hshformula.put("prevfinancialtype", "a");
						hshformula.put("internalcalc", "N");
						hshformula.put("hshdata", new HashMap());
						hshformula.put("hshFinYearVal", hshFinYearVal);
						
						hshRes = (HashMap) EJBInvoker.executeStateLess("comformula", hshformula, "GetFinValue");
						
						if (rs1 != null)
							rs1.close();
						strQuery = SQLParser.getSqlQuery("comfinance_finappid^"+ strFinID);
						rs1 = DBUtils.executeQuery(strQuery);
						if (rs1.next()) {
							strFinValues = correctNull((String) rs1.getString("fin_valuesarein"));
						}
						dblRatio=Double.parseDouble(Helper.correctDouble((String) hshRes.get("strTotalValue")));
						if(strFinValues.equalsIgnoreCase("L"))
							dblRatio=dblRatio/1;
						else if(strFinValues.equalsIgnoreCase("C"))
							dblRatio=dblRatio * 100;
						else
							dblRatio=dblRatio/100000;
					} 
					arrCol.add(Helper.addComma(Helper.correctDouble(String.valueOf(dblRatio))));//20
					arrCol.add(strSecType.toString());//21
					arrCol.add(strSecValue.toString());//22
					arrCol.add(strSecValuation.toString());//23
					arrRow.add(arrCol);
				}
		}
	}
			hshRec.put("ArrValues",arrRow);
			arrRow=new ArrayList();
			
			if(rs2!=null)
			{
				rs2.close();
			}
			strQueryLast=new StringBuffer();
			if(strOrglevel.equalsIgnoreCase("C")||strOrglevel.equalsIgnoreCase("R")|| strOrglevel.equalsIgnoreCase("D")|| strOrglevel.equalsIgnoreCase("CPC"))
			{
				strQueryLast.append("and SOL_SANCTIONED_BY='").append(strDesignation).append("'");
			}
			else
			{
				strQueryLast.append(" ");
			}
			
			
			double dblsolSanctAmt=0.00;
			strQuery=SQLParser.getSqlQuery("selsolvencyreport^"+strorgScode+"^"+strFromDate+"^"+strToDate+"^"+strQueryLast.toString());
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs2.getString("ARS_SANCTIONREFNO"))+"-"+correctNull(rs2.getString("sanctdate")));//0
				arrCol.add(correctNull(rs2.getString("SOL_CBS_ID"))+"@a@"+correctNull(rs2.getString("name"))+"@"+correctNull(rs2.getString("address"))+"~");//1
				arrCol.add(Helper.addComma(correctNull(rs2.getString("perapp_networth"))));//2
				arrCol.add(correctNull(rs2.getString("occupation")));//3
				arrCol.add(correctNull(rs2.getString("sol_purpose")));//4
				dblsolSanctAmt=dblsolSanctAmt+Double.parseDouble(Helper.correctDouble(rs2.getString("sol_amount")));
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("sol_amount"))))));//5
				arrCol.add(" ");//6
				arrCol.add(" ");//7
				arrCol.add(" ");//8
				arrCol.add(" ");//9
				arrCol.add(" ");//10
				arrCol.add(" ");//11
				arrCol.add(" ");//12
				arrCol.add(Helper.correctNull(rs2.getString("org_name")));//13
				arrCol.add("");//14
				arrCol.add(Helper.correctNull(rs2.getString("constitution")));//15
				arrCol.add(" ");//16
				arrCol.add(" ");//17
				arrCol.add(" ");//18
				arrCol.add("0.00");//19
				arrCol.add("0.00");//20
				arrCol.add("");//21
				arrCol.add("");//22
				arrCol.add("");//23
				arrRow.add(arrCol);
			}
			hshRec.put("ArrRow",arrRow);	
			arrRow=new ArrayList();
			if(rs2!=null)
			{
				rs2.close();
			}
			double dblKPOWSanctAmt=0.00;
			if(rs2!=null)
			{
				rs2.close();
			}
			strQueryLast=new StringBuffer();
			if(strOrglevel.equalsIgnoreCase("C")||strOrglevel.equalsIgnoreCase("R")|| strOrglevel.equalsIgnoreCase("D")|| strOrglevel.equalsIgnoreCase("CPC"))
			{
				strQueryLast.append("and addkbow_Sanctioned='").append(strDesignation).append("'");
			}
			else
			{
				strQueryLast.append(" ");
			}
			strQuery=SQLParser.getSqlQuery("selkpowerreport^"+strorgScode+"^"+strFromDate+"^"+strToDate+"^"+strQueryLast.toString());
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs2.getString("ARS_SANCTIONREFNO"))+"-"+correctNull(rs2.getString("sanctdate")));//0
				arrCol.add(correctNull(rs2.getString("ADDKBOW_CBS_ID"))+"@a@"+correctNull(rs2.getString("name"))+"@"+correctNull(rs2.getString("address"))+"~");//1
				arrCol.add(Helper.addComma(correctNull(rs2.getString("perapp_networth"))));//2
				arrCol.add(correctNull(rs2.getString("occupation")));//3
				arrCol.add("");//4
				dblKPOWSanctAmt=dblKPOWSanctAmt+Double.parseDouble(Helper.correctDouble(rs2.getString("ADDKBOW_LIMITSANCTIONED")));
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("ADDKBOW_LIMITSANCTIONED"))))));//5
				arrCol.add(" ");//6
				arrCol.add(" ");//7
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("ADDKBOW_RATEOFINT")))));//8
				arrCol.add(" ");//9
				if(Helper.correctNull(rs2.getString("ADDKBOW_PERIODMONTH")).equalsIgnoreCase("2"))
				{
					arrCol.add(String.valueOf(Integer.parseInt(Helper.correctInt(rs2.getString("ADDKBOW_PERIODIN")))*12));
				}
				else 
				{
					arrCol.add(Helper.correctNull(rs2.getString("ADDKBOW_PERIODIN")));//10
				}
				arrCol.add(" ");//11
				arrCol.add(" ");//12
				arrCol.add(Helper.correctNull(rs2.getString("org_name")));//13
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("ADDKBOW_RATEOFINTTOTAL")))));//14
				arrCol.add(Helper.correctNull(rs2.getString("constitution")));//15
				arrCol.add(" ");//16
				arrCol.add(" ");//17
				arrCol.add(" ");//18
				arrCol.add("0.00");//19
				arrCol.add("0.00");//20
				arrCol.add("");//21
				arrCol.add("");//22
				arrCol.add("");//23
				arrRow.add(arrCol);
			}
	hshRec.put("ArrKpowerRow",arrRow);
	hshRec.put("strtotSancamt",strtotSancamt);
	hshRec.put("txtSaveDate",strSaveDate);
	hshRec.put("strFromDate",strFromDate);
	hshRec.put("strToDate",strToDate);
	hshRec.put("Org_Name",strOrg_Name);
	hshRec.put("loantype",strloantype);
	hshRec.put("strbufOrgcode",strbufOrgcode.toString());
	hshRec.put("sanctionamt",Helper.addComma(nf.format(sanctionamt)));
	hshRec.put("dblsolsanctamt",Helper.addComma(nf.format(dblsolSanctAmt)));
	hshRec.put("dblkpowersanctamt",Helper.addComma(nf.format(dblKPOWSanctAmt)));
	}
	catch(Exception e)
	{
		throw new EJBException("inside getLsrrReport"+e.toString());
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
return hshRec;
}

public HashMap getsolvencyReport(HashMap hshValues) 
{
 		ResultSet rs = null;
 		ResultSet rs1=null,rs2=null,rs3=null;
		
		HashMap hshRec=null;
		ArrayList arrCol =null;
		ArrayList Arrvalues =null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null;
		String strTemp=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrglevel=null;
		String strOrg_Name = "";
		String strloantype="",appno="";
		String strPeriodicity="";
		HashMap hshResults=new HashMap();
		ArrayList arrBorroweExposure=null;
		ArrayList arrBorroweExposureCol=null;
		double strProposedExposure=0.00;
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		double strtotSancamt=0.00;
		StringBuffer strbufOrgcode=new StringBuffer();
		double sanctionamt=0.00;
		String strorgScode="";
		StringBuffer strQueryFirst=new StringBuffer();
		StringBuffer strQueryLast=new StringBuffer();
		StringBuffer strbufDesignation=new StringBuffer();
		String strcreWeight="";
		String strStaffId="";
		String strSessionOrgCode="";
		String residentType="";
		String decodestr="";
		float sumofamount=0f;
		float actotal=0f;
		float cctotal=0f;
		String strUserId="";
		String orglevel="";
		
		try
		{
			ArrayList arrRow=new ArrayList();
			strSessionOrgCode =(String)hshValues.get("org_name");
			strSessionOrgCode = strSessionOrgCode.replaceAll("\'","");
			strDate = correctNull((String)hshValues.get("txtDate"));
			strGen =(String)hshValues.get("strUserId");
			strUserId=(String)hshValues.get("strUserId");
			orglevel=(String)hshValues.get("sample");
			if(orglevel.equalsIgnoreCase("C"))//head office
			{
				strSessionOrgCode=strSessionOrgCode.substring(0,3)+"%";
			}
			else if (orglevel.equalsIgnoreCase("R") || orglevel.equalsIgnoreCase("CPC"))
			{
				strSessionOrgCode=strSessionOrgCode.substring(0,6)+"%";
			}
			else if (orglevel.equalsIgnoreCase("D"))
			{
				strSessionOrgCode=strSessionOrgCode.substring(0,9)+"%";
			}
			else if (orglevel.equalsIgnoreCase("A"))
			{
				strSessionOrgCode=strSessionOrgCode.substring(0,12)+"%";
			}
			else if (orglevel.equalsIgnoreCase("B"))
			{
				strSessionOrgCode=strSessionOrgCode;
			}
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			strQuery=SQLParser.getSqlQuery("sel_banker_report^"+strSessionOrgCode+"^"+strFromDate+"^"+strToDate);
			
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs2.getString("BANKER_APPL_NO")));//0
				String decode=correctNull(rs2.getString("TYPE_OF_BENEFICIARY"));
				decodestr=SQLParser.getSqlQuery("decodeof_TYPE_OF_BENEFICIARY^"+decode);
				rs=DBUtils.executeQuery(decodestr);
				if(rs.next())
				{
					arrCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));//1	
				}
				arrCol.add(correctNull(rs2.getString("BANKER_CBS_ID")));//1
				arrCol.add(correctNull(rs2.getString("BANKER_APPLICANT_NAME")));//2
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_AMOUNT"))))));//3
				if(!correctNull(rs2.getString("BANKER_AMOUNT")).equalsIgnoreCase(""))
				{
				sumofamount=sumofamount+Float.parseFloat(correctNull(rs2.getString("BANKER_AMOUNT")));
				}
				arrCol.add(correctNull(rs2.getString("BANKER_BENF_NAME")));//4
				arrCol.add(correctNull(rs2.getString("TENDER_NOTIFICATION_DATE")));//5
				arrCol.add(correctNull(rs2.getString("BANKER_BRIEF_WORKORDER").replaceAll("[^a-zA-Z0-9\\s]", "")));//6
				arrCol.add(correctNull(rs2.getString("BANKER_DATE")));//7
				arrCol.add(correctNull(rs2.getString("BANKER_APPROVE_DATE")));//8
				arrCol.add(correctNull(rs2.getString("ARS_SANCTIONREFNO")));//9
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANKER_COMMISSION_EARNED"))))));//3
				if(!correctNull(rs2.getString("BANKER_COMMISSION_EARNED")).equalsIgnoreCase(""))
				{
				actotal=actotal+Float.parseFloat(correctNull(rs2.getString("BANKER_COMMISSION_EARNED")));
				}
				arrCol.add(Helper.addComma(nf.format(Double.parseDouble(Helper.correctDouble(rs2.getString("BANK_CHARGE_APPLICABLE"))))));//3
				if(!correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")).equalsIgnoreCase(""))
				{
				cctotal=cctotal+Float.parseFloat(correctNull(rs2.getString("BANK_CHARGE_APPLICABLE")));
				}
				arrCol.add(correctNull(rs2.getString("COM_BANK_SANSTATUS")));//12
				arrRow.add(arrCol);
			}
			if(rs2!=null)
			{
				rs2.close();
			}
			
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2))+" "+correctNull(rs.getString(3));
			}
			hshValues.put("arrRow",arrRow);
			hshValues.put("genby", strGen);
			hshValues.put("txtSaveDate",strSaveDate);
			hshValues.put("strFromDate",strFromDate);
			hshValues.put("strToDate",strToDate);
			hshValues.put("Org_Name",strOrg_Name);
			hshValues.put("loantype",strloantype);
			hshValues.put("sumofamount",Helper.addComma(nf.format(sumofamount)));
			hshValues.put("actotal",Helper.addComma(nf.format(actotal)));
			hshValues.put("cctotal",Helper.addComma(nf.format(cctotal)));
			hshValues.put("strUserIdforgen",strUserId);
			
	}
	catch(Exception e)
	{
		throw new EJBException("inside getSolvencyReport"+e.toString());
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
	private HashMap getOFRReport(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
 		ArrayList vecRecords=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strStatus ="",strGen="";
	
		
		try
		{
			strGen =(String)hshValues.get("strUserId");
			strStatus=correctNull((String)hshValues.get("hidprocessstatus"));
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
						
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				strAppenQuery.append(" and (TO_DATE(to_char(fin_createddate ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
				.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and  org_code like '001%'");
				
			}
			else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,7)).append("%'");
			}
			else if(selLevel.equals("D"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,10)).append("%'");
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,13)).append("%'");
			}
			strQuery =SQLParser.getSqlQuery("sel_onlyforratingstatusreport^"+strStatus+"^"+strAppenQuery.toString());

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("org_scode")));//0
				arrCol.add(correctNull(rs.getString("fin_cbsid")));//1
				arrCol.add(correctNull(rs.getString("fin_appname")));//2
				arrCol.add(correctNull(rs.getString("fin_ratappno")));//3
				arrCol.add(correctNull(rs.getString("status")));//4
				arrCol.add(correctNull(rs.getString("usr_id")));//5
				arrCol.add(correctNull(rs.getString("usr_fname")));//6
				arrCol.add(correctNull(rs.getString("usrdepartment")));//7
				arrCol.add(correctNull(rs.getString("received_date")));//8
				arrRow.add(arrCol);
			}
			if(strStatus.equalsIgnoreCase("P"))
				strStatus="Pending";
			else if(strStatus.equalsIgnoreCase("A"))
				strStatus="Approved";
			else if(strStatus.equalsIgnoreCase("R"))
				strStatus="Rejected";
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate", strDate);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRecord;
	}
	private HashMap getCorpRatingReport(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
 		ArrayList vecRecords=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strStatus ="",strGen="";
	
		
		try
		{
			strGen =(String)hshValues.get("strUserId");
			strStatus=correctNull((String)hshValues.get("hidprocessstatus"));
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
						
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				if(strStatus.equalsIgnoreCase("P"))
				{
					strAppenQuery.append(" and (TO_DATE(to_char(APP_CREATEDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append("and org_code =app_orgcode ");
				}else
				{
					strAppenQuery.append(" and (TO_DATE(to_char(APP_PROCESSDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append("and org_code =app_processorgscode ");
				}
			}
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and  org_code like '001%'");
				
			}
			else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,6)).append("%'");
			}
			else if(selLevel.equals("D"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,9)).append("%'");
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,12)).append("%'");
			}
			if(strStatus.equalsIgnoreCase("P"))
				strStatus="op";
			else if(strStatus.equalsIgnoreCase("A"))
				strStatus="pa";
			else if(strStatus.equalsIgnoreCase("R"))
				strStatus="pr";
			strQuery =SQLParser.getSqlQuery("selcorpratingreport^"+strStatus+"^"+strAppenQuery.toString());

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("org_scode")));//0
				arrCol.add(correctNull(rs.getString("perapp_cbsid")));//1
				arrCol.add(correctNull(rs.getString("perapp_fname")));//2
				arrCol.add(correctNull(rs.getString("app_no")));//3
				arrCol.add(correctNull(rs.getString("status")));//4
				arrCol.add(correctNull(rs.getString("usr_id")));//5
				arrCol.add(correctNull(rs.getString("usr_fname")));//6
				arrCol.add(correctNull(rs.getString("department")));//7
				arrCol.add(correctNull(rs.getString("CRE_ASONDATE")));//8
				arrRow.add(arrCol);
			}
			if(strStatus.equalsIgnoreCase("op"))
				strStatus="Pending";
			else if(strStatus.equalsIgnoreCase("pa"))
				strStatus="Approved";
			else if(strStatus.equalsIgnoreCase("pr"))
				strStatus="Rejected";
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate", strDate);
			hshRecord.put("genby", strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCorpRatingReport ==== "+e.toString());
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
		return hshRecord;
	}
	
	
	private HashMap getSecVerifPendingdata(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
 		ArrayList vecRecords=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="",hidOrgName="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strStatus ="",strGen="";
		StringBuffer strTemp=new StringBuffer();

		try
		{
			strGen =(String)hshValues.get("strUserId");
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("orglevel"));
			rpselect1 = correctNull((String)hshValues.get("hidOrgCode"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			hidOrgName =correctNull((String)hshValues.get("hidOrgName"));
			
			if(selLevel.equalsIgnoreCase("C"))
			{
				strTemp.append(" and org_code like (").append(rpselect1.substring(0, 4)).append("%%%%')");
			}
			else if(selLevel.equalsIgnoreCase("R")|| selLevel.equalsIgnoreCase("CPC"))
			{
				strTemp.append(" and org_code like (").append(rpselect1.substring(0, 7)).append("%')");
			}
			else if(selLevel.equalsIgnoreCase("D"))
			{
				strTemp.append(" and org_code like (").append(rpselect1.substring(0, 10)).append("%')");
			}
			else if(selLevel.equalsIgnoreCase("CPC"))
			{
				strTemp.append(" and org_code like (").append(rpselect1.substring(0, 10)).append("%')");
			}
			else
			{
				strTemp.append(" and org_code like (").append(rpselect1.substring(0, 13)).append("%')");
			}
			
			strQuery=SQLParser.getSqlQuery("sel_repSecVerifPending^"+strTemp);

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("PERAPP_ID")));//0
				arrCol.add(correctNull(rs.getString("ownername")));//1
				arrCol.add(correctNull(rs.getString("CUS_SEC_ID")));//2
				arrCol.add(correctNull(rs.getString("SEC_NAME")));//3
				arrCol.add(correctNull(rs.getString("SEC_CREATEDBY")));//4
				arrCol.add(correctNull(rs.getString("SEC_CREATEDDATE")));//5
				arrRow.add(arrCol);
			}
			
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate", strDate);
			hshRecord.put("genby", strGen);
			hshRecord.put("hidOrgName", hidOrgName);
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSecVerifPendingdata ==== "+e.toString());
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
		return hshRecord;
	}
	
	
	private HashMap getPoolBasedRatingReport(HashMap hshValues) 
	{
		
 		ResultSet rs = null;
 		ResultSet rs1=null;
 		ArrayList vecRecords=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecVal =null;
		String strQuery=null,strQuery1=null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		StringBuffer strbufOrgcode=new StringBuffer();
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strStatus ="",strGen="";
	
		
		try
		{
			strGen =(String)hshValues.get("strUserId");
			strStatus=correctNull((String)hshValues.get("hidprocessstatus"));
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and  org_code like '001%'");
				
			}
			else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,6)).append("%'");
			}
			else if(selLevel.equals("D"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,9)).append("%'");
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and org_code like ").append(rpselect1.substring(0,12)).append("%'");
			}
			
			if(!(strFromDate.equalsIgnoreCase("")) && (!(strToDate.equalsIgnoreCase(""))))
			{
				if(strStatus.equalsIgnoreCase("P"))
				{
					strAppenQuery.append(" and (TO_DATE(to_char(APP_CREATEDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append("and org_code =app_orgcode ");
				}else
				{
					strAppenQuery.append(" and (TO_DATE(to_char(APP_PROCESSDATE ,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))")
					.append("and org_code =app_processorgscode ");
				}
			}
			if(strStatus.equalsIgnoreCase("P"))
				strStatus="op";
			else if(strStatus.equalsIgnoreCase("A"))
				strStatus="pa";
			else if(strStatus.equalsIgnoreCase("R"))
				strStatus="pr";
			
			strQuery =SQLParser.getSqlQuery("selratingapplicationreport^"+strStatus+"^"+strAppenQuery.toString()+"^"+strStatus+"^"+strAppenQuery.toString()+"^<^<");

			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			String strvaluesin="";
			double dbmultiples;
			while (rs.next())
			{
				
						arrCol = new ArrayList();
						arrCol.add(correctNull(rs.getString("org_scode")));//0
						arrCol.add(correctNull(rs.getString("perapp_cbsid")));//1
						arrCol.add(correctNull(rs.getString("perapp_fname")));//2
						arrCol.add(correctNull(rs.getString("app_no")));//3
						arrCol.add(correctNull(rs.getString("status")));//4
						arrCol.add(correctNull(rs.getString("usr_id")));//5
						arrCol.add(correctNull(rs.getString("usr_fname")));//6
						arrCol.add(correctNull(rs.getString("department")));//7
						arrCol.add(correctNull(rs.getString("CRE_ASONDATE")));//8
						if(correctNull(rs.getString("app_loantype")).equalsIgnoreCase("P"))
						arrCol.add("Retail");//9
						else if(correctNull(rs.getString("app_loantype")).equalsIgnoreCase("A"))
							arrCol.add("Agriculture");//9
						else if(correctNull(rs.getString("app_loantype")).equalsIgnoreCase("C"))
							arrCol.add("Corporate");//9
						else
							arrCol.add(" ");
						arrRow.add(arrCol);
				
			}
			if(strStatus.equalsIgnoreCase("op"))
				strStatus="Pending";
			else if(strStatus.equalsIgnoreCase("pa"))
				strStatus="Approved";
			else if(strStatus.equalsIgnoreCase("pr"))
				strStatus="Rejected";
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("hidStatus",strStatus);
			hshRecord.put("txtDate", strDate);
			hshRecord.put("genby", strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPoolBasedRatingReport ======= "+e.toString());
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
		return hshRecord;
	}
	private HashMap getCreditSaleReport(HashMap hshValues) 
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

		
		try
		{
			strGen =(String)hshValues.get("strUserId");
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and  o.org_code like '001%'");
				
			}
			else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and o.org_code like ").append(rpselect1.substring(0,6)).append("%'");
			}
			else if(selLevel.equals("D"))
			{
				strAppenQuery.append("and o.org_code like ").append(rpselect1.substring(0,9)).append("%'");
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and o.org_code like ").append(rpselect1.substring(0,12)).append("%'");
			}
			
			int i=0;
			strQuery =SQLParser.getSqlQuery("sel_dcoereport^"+strFromDate+"^"+strToDate);
			
			if(rs != null)
				rs.close();
			String streligdigi="",strreason="";
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				i++;
				arrCol = new ArrayList();
				arrCol.add(String.valueOf(i));
				arrCol.add(correctNull(rs.getString("LOANDISBBRANCH")));//0
				arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
				arrCol.add(correctNull(rs.getString("REGIONALOFFICE")));//2
				arrCol.add(correctNull(rs.getString("CBSID")));//3
				arrCol.add(correctNull(rs.getString("CUSTOMOERNAME")));//4
				arrCol.add(correctNull(rs.getString("SANCTIONAMOUNT")));//5
				arrCol.add(correctNull(rs.getString("SANCTIONDATE")));//6
				arrCol.add(correctNull(rs.getString("SCHEME")));//7
				arrCol.add(correctNull(rs.getString("INWARDNO")));//8
				arrCol.add(correctNull(rs.getString("SANCTIONREFNO")));//9
				arrCol.add(correctNull(rs.getString("DIGIAPPNO")));//10
				arrCol.add(correctNull(rs.getString("ELIGDIGI")));//11
				arrCol.add(correctNull(rs.getString("BREIFDISCRIPTION")));//12
				streligdigi=correctNull(rs.getString("ELIGDIGI"));
				strreason=correctNull(rs.getString("REASON"));

				if(streligdigi.equalsIgnoreCase("Yes") && !strreason.equalsIgnoreCase("")){
						strQuery=SQLParser.getSqlQuery("selCreditSaleReason^245^"+strreason);
						rs1=DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{				
							arrCol.add(correctNull(rs1.getString("STAT_DATA_DESC1")));//13

						}
					}
					
				else if(streligdigi.equalsIgnoreCase("No") && !strreason.equalsIgnoreCase("")){
						strQuery=SQLParser.getSqlQuery("selCreditSaleReason^246^"+strreason);
						rs1=DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{				
							arrCol.add(correctNull(rs1.getString("STAT_DATA_DESC1")));//13
						}
					}
				else{
					arrCol.add("");//13

				}
				arrCol.add(correctNull(rs.getString("REASON")));//14
				arrCol.add(correctNull(rs.getString("percomments")));//15

				arrRow.add(arrCol);
				
			}
			
			strQuery =SQLParser.getSqlQuery("sel_dcoereport_digi^"+strFromDate+"^"+strToDate);
			
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{

				i++;
				arrCol = new ArrayList();
				arrCol.add(String.valueOf(i));
				arrCol.add(correctNull(rs.getString("LOANDISBBRANCH")));//0
				arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
				arrCol.add(correctNull(rs.getString("REGIONALOFFICE")));//2
				arrCol.add(correctNull(rs.getString("CBSID")));//3
				arrCol.add(correctNull(rs.getString("CUSTOMOERNAME")));//4
				arrCol.add(correctNull(rs.getString("SANCTIONAMOUNT")));//5
				arrCol.add(correctNull(rs.getString("SANCTIONDATE")));//6
				arrCol.add(correctNull(rs.getString("SCHEME")));//7
				arrCol.add(correctNull(rs.getString("INWARDNO")));//8
				arrCol.add(correctNull(rs.getString("SANCTIONREFNO")));//9
				arrCol.add("");//10
				arrCol.add("");//11
				arrCol.add("");//12
				arrCol.add("");//13
				arrCol.add("");//14
				arrCol.add("");//15
				
				
				arrRow.add(arrCol);
				
			
			}
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			
			hshValues.put("arrRow",arrRow);
			hshValues.put("branch_name",strOrgName);
			hshValues.put("strFromDate", strFromDate);
			hshValues.put("strToDate", strToDate);
			hshValues.put("genby", strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCreditSaleReport ======= "+e.toString());
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
	private HashMap getSecValuatinReport(HashMap hshValues) 
	{
		
		ResultSet rs = null;
		HashMap hshRecord=new HashMap();
		String strQuery=null,strQuery1=null;
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strGen="";
		StringBuffer strTemp=new StringBuffer();
		
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		
		try
		{
			strGen =(String)hshValues.get("strUserId");
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("orglevel"));
			rpselect1 = correctNull((String)hshValues.get("hidOrgCode"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			
			
			if(selLevel.equalsIgnoreCase("C"))
			{
				strTemp.append(" and substr(org_code,1,3) >= ").append(rpselect1.substring(0, 4)).append("' AND   substr(org_code,1,3) <= ").append(rpselect1.substring(0, 4)).append("'");
			}
			else if(selLevel.equalsIgnoreCase("R")|| selLevel.equalsIgnoreCase("CPC"))
			{
				strTemp.append(" and substr(org_code,1,6) >= ").append(rpselect1.substring(0, 7)).append("' AND   substr(org_code,1,6) <= ").append(rpselect1.substring(0, 7)).append("'");
			}
			else if(selLevel.equalsIgnoreCase("D"))
			{
				strTemp.append(" and substr(org_code,1,9) >= ").append(rpselect1.substring(0, 10)).append("' AND   substr(org_code,1,9) <= ").append(rpselect1.substring(0, 10)).append("'");
			}
			else if(selLevel.equalsIgnoreCase("CPC"))
			{
				strTemp.append(" and substr(org_code,1,9) >= ").append(rpselect1.substring(0, 10)).append("' AND   substr(org_code,1,9) <= ").append(rpselect1.substring(0,10)).append("'");
			}
			else
			{
				strTemp.append(" and substr(org_code,1,12) >= ").append(rpselect1.substring(0, 13)).append("' AND   substr(org_code,1,12) <= ").append(rpselect1.substring(0, 13)).append("'");
			}
			
			if(selLevel.equalsIgnoreCase("C") || selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("D")||selLevel.equalsIgnoreCase("CPC"))
			{
				strTemp.append("and cus_sec_type='"+correctNull((String)hshValues.get("sel_securitytype"))+"'");
			}
			else
			{
				strTemp.append("and cus_sec_type in ("+correctNull((String)hshValues.get("hidsectype"))+")");
			}
			strQuery=SQLParser.getSqlQuery("selexpiredsecurity^101^"+strTemp+"^101^"+strTemp);
			if(rs != null)
				rs.close();
			String strExistingID="";
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				
				String strNewsecID=Helper.correctNull(rs.getString("cus_sec_id"));
				if(strExistingID.equalsIgnoreCase(strNewsecID))
					continue;
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));
				arrCol.add(Helper.correctNull(rs.getString("name")));
				arrCol.add(Helper.correctNull(rs.getString("cus_sec_id")));
				arrCol.add(Helper.correctNull(rs.getString("sec_name")));
				arrCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")))));
				arrCol.add(Helper.correctNull(rs.getString("CUS_SEC_VALUER_NAME")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_SEC_VALUATION_DATE1")));
				arrCol.add(Helper.correctNull(rs.getString("org_name")));
				arrCol.add(Helper.correctNull(rs.getString("org_scode")));
				arrCol.add(Helper.correctNull(rs.getString("app_no")));
				arrRow.add(arrCol);
				
				strExistingID=strNewsecID;
			}
			
			hshRecord.put("arrRow",arrRow);
			
			arrRow=new ArrayList();
			strQuery=SQLParser.getSqlQuery("selgoingtoexpiresecurity^102^"+strTemp+"^102^"+strTemp);
			if(rs != null)
				rs.close();
			strExistingID="";
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strNewsecID=Helper.correctNull(rs.getString("cus_sec_id"));
				if(strExistingID.equalsIgnoreCase(strNewsecID))
					continue;
				
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));
				arrCol.add(Helper.correctNull(rs.getString("name")));
				arrCol.add(Helper.correctNull(rs.getString("cus_sec_id")));
				arrCol.add(Helper.correctNull(rs.getString("sec_name")));
				arrCol.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("CUS_SEC_SECURITY_DESCRIPTION"))));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")))));
				arrCol.add(Helper.correctNull(rs.getString("CUS_SEC_VALUER_NAME")));
				arrCol.add(Helper.correctNull(rs.getString("CUS_SEC_VALUATION_DATE1")));
				arrCol.add(Helper.correctNull(rs.getString("org_name")));
				arrCol.add(Helper.correctNull(rs.getString("org_scode")));
				arrCol.add(Helper.correctNull(rs.getString("app_no")));
				arrRow.add(arrCol);
				
				strExistingID=strNewsecID;
			}
			
			hshRecord.put("arrRow1",arrRow);
			
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			//hshRecord.put("arrRow",arrRow);
			hshRecord.put("branch_name",strOrgName);
			hshRecord.put("genby", strGen);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSecValuatinReport ======= "+e.toString());
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
		return hshRecord;
	}
	private HashMap getemandateDetails(HashMap hshValues) 
	{
 		ResultSet rs = null,rs1=null;
 		ArrayList vecRecords=null;
 		ArrayList vecT = new ArrayList();
 		ArrayList vecVal =null;
		HashMap hshRec=null;
		String strQuery=null,strQuery1=null;
		String strOrgCode = null, strOpFields = null,strSelFields=null,strStatus=null,strTemp=null,strToDate=null;
		String strDate=null,strFromDate=null,strSaveDate=null,strGen=null,strOrglevel=null,strOrg_Name = "",strDatetype="";
		StringBuffer strbufOrgcode=new StringBuffer();
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strGen =(String)hshValues.get("strUserId");
			strOrgCode =(String)hshValues.get("hidOrgCode");
			strSelFields =(String)hshValues.get("hidSelFields");
			strOpFields =(String)hshValues.get("hidOpFields");
			strStatus =(String)hshValues.get("hidStatus");
			strDate =(String)hshValues.get("txtDate");
			strOrglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
			//if(strOpFields.equals("")&& strSelFields.equals(""))  
			{	
				strSelFields="Proposal Number,Applicant Name,CBS Customer ID,CBS AccountNo,Address,Phone No.,E-Mail Id,Pending,Proposal";
				strOpFields="app_no,perapp_title,perapp_fname,perapp_lname,perapp_cbsid,cbs_accountno,CON_COMADDR1,CON_COMADDR2,CON_COMVILLAGE,CON_COMCITY,CON_COMDIST,CON_COMSTATE,CON_COMZIP,CON_COMCOUNTRY,CON_COMPHONE,CON_MOBILE,CON_COMPHONE,CON_EMAIL,org_name,PERAPP_KYCPEND_FLAG,PERAPP_FIPEND_FLAG,app_renew_flag";
			}
			if(!((strOrglevel.equalsIgnoreCase("State")) || (strOrglevel.equalsIgnoreCase("City")) ||(strOrglevel.equalsIgnoreCase("S/C"))))
			{
				strOrgCode=strOrgCode.replaceAll("'","");
			}
			if(strOrglevel.equalsIgnoreCase("C"))
			{
				strbufOrgcode.append("org_code like '001%'");
			}
			else if(strOrglevel.equalsIgnoreCase("R")||strOrglevel.equalsIgnoreCase("CPC"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("D"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("A"))
			{
				strbufOrgcode.append("org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			else if(strOrglevel.equalsIgnoreCase("B"))
			{
				strbufOrgcode.append("org_code = '").append(strOrgCode).append("'");
			}
		
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
			while (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			
			
			if(strStatus.equalsIgnoreCase("A"))
			{
				strQuery = SQLParser.getSqlQuery("sel_allkycfipending_report^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strOpFields+"^"+strbufOrgcode.toString());
			}
			else if(strStatus.equalsIgnoreCase("F"))
			{
				strQuery = SQLParser.getSqlQuery("sel_fipendingreport^"+strOpFields+"^"+strbufOrgcode.toString());
			}
			else if(strStatus.equalsIgnoreCase("K"))
			{
				strQuery = SQLParser.getSqlQuery("sel_kycpendingreport^"+strOpFields+"^"+strbufOrgcode.toString());
			}
			else if(strStatus.equalsIgnoreCase("M"))
			{
				strQuery = SQLParser.getSqlQuery("sel_emandatereport^"+strOpFields+"^"+strbufOrgcode.toString());
			}
			
			
			
			
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				vecRecords.add(Helper.correctNull(rs.getString("app_no"))); //0
				vecRecords.add(Helper.correctNull(rs.getString("perapp_title"))+"."+Helper.correctNull(rs.getString("perapp_fname"))+" "+Helper.correctNull(rs.getString("perapp_lname"))); //1
				vecRecords.add(Helper.correctNull(rs.getString("perapp_cbsid"))); //2
				vecRecords.add(Helper.correctNull(rs.getString("cbs_accountno"))); //3
				vecRecords.add(Helper.correctNull(rs.getString("CON_COMADDR1"))); //4
				vecRecords.add(Helper.correctNull(rs.getString("CON_MOBILE"))); //5
				vecRecords.add(Helper.correctNull(rs.getString("CON_EMAIL"))); //6
				vecRecords.add(Helper.correctNull(rs.getString("CON_COMADDR2"))); //7
				vecRecords.add(Helper.correctNull(rs.getString("CON_COMVILLAGE"))); //8
				String citycodeval=Helper.correctNull(rs.getString("CON_COMCITY"));
				String countrycodeval=Helper.correctNull(rs.getString("CON_COMCOUNTRY"));

				String city_code_val="",state_code_val="",statecode_val="",countryval="";
				if(!citycodeval.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("selcitycode^"+citycodeval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						city_code_val = Helper.correctNull((String)rs1.getString(1));
						state_code_val = Helper.correctNull((String)rs1.getString(2));
						if(!state_code_val.equalsIgnoreCase(""))
						{
							strQuery = SQLParser.getSqlQuery("selstatecode^"+state_code_val);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								statecode_val = Helper.correctNull((String)rs1.getString(1));
								
							}
						}
					}
				}
				if(!countrycodeval.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_countrynamebycode^"+countrycodeval);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						countryval=Helper.correctNull((String)rs1.getString(1));
					}
				}
				
				
				vecRecords.add(city_code_val); //9
				vecRecords.add(statecode_val); //10
				vecRecords.add(countryval); //11
				vecRecords.add(Helper.correctNull(rs.getString("CON_COMZIP"))); //12
				
				String PERAPP_KYCPEND_FLAG=Helper.correctNull(rs.getString("PERAPP_KYCPEND_FLAG"));
				String PERAPP_FIPEND_FLAG=Helper.correctNull(rs.getString("PERAPP_FIPEND_FLAG"));
				
				String strpendtemp="";
				boolean boolPenFlag=false;
				
				if(PERAPP_KYCPEND_FLAG.equals("Y"))
				{	
					strpendtemp="KYC";
					boolPenFlag=true;
				}
				
				if(PERAPP_FIPEND_FLAG.equals("Y"))
				{
					if(boolPenFlag==true)
					{
						strpendtemp="KYC, FI";
					}
					else
					{
						strpendtemp="FI";
					}
				}
				vecRecords.add(strpendtemp); //13
				String strproposaltype=Helper.correctNull(rs.getString("app_renew_flag"));
				if (strproposaltype.equalsIgnoreCase("S"))
					strproposaltype = "Resturcture";
				else if (strproposaltype.equalsIgnoreCase("R"))
					strproposaltype = "Renew";
				else if (strproposaltype.equalsIgnoreCase("P"))
					strproposaltype = "Postsanction";
				else
					strproposaltype = "Fresh";
				
				vecRecords.add(strproposaltype);
				vecVal.add(vecRecords);
			}
			hshRec.put("labels",strSelFields);
			hshRec.put("vecValues",vecVal);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
			hshRec.put("txtSaveDate",strSaveDate);
			hshRec.put("Org_Name",strOrg_Name);
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
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
		return hshRec;
	}
	private HashMap getemandateDetailsExcel(HashMap hshValues) 
	{
		int intRowCount=0,intCellCount=0;
		ArrayList vecVal=new ArrayList();
		try
		{
			hshValues=getemandateDetails(hshValues);

			HSSFWorkbook wb = new HSSFWorkbook();
			wb.isWriteProtected();
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			vecVal=(ArrayList)hshValues.get("vecValues");

			HSSFFont boldfont2 = wb.createFont();
			boldfont2.setFontName("Verdana");
			boldfont2.setColor(HSSFFont.COLOR_NORMAL);
			boldfont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			
	        HSSFCellStyle borderstylecenter = wb.createCellStyle();
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			borderstylecenter.setFont(boldfont2);
			
			HSSFCellStyle boldstyle= wb.createCellStyle();
			boldstyle.setBorderLeft(HSSFColor.AQUA.index);
			boldstyle.setBorderRight(HSSFColor.AQUA.index);
			boldstyle.setBorderBottom(HSSFColor.AQUA.index);
			boldstyle.setBorderTop(HSSFColor.AQUA.index);
			boldstyle.setFont(boldfont2);
			boldstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			
			
			HSSFCellStyle bldborcolstyle= wb.createCellStyle();
			bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
			bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
			bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
			bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);	    	
			bldborcolstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	    	
			bldborcolstyle.setWrapText(true);	    	
			bldborcolstyle.setFont(boldfont2);

			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			sheet = wb.createSheet("Pending Applications");
			String str_newline=Helper.correctNull((String)hshValues.get("labels"));
			//sheet.protectSheet("LAPS");
			String strHeadersSize[]=str_newline.split(",");

			intCellCount=0; 
			intRowCount++;
			row = sheet.createRow((short) intRowCount);
			
			for(int i=0;i<strHeadersSize.length;i++)
			{
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeadersSize[i]);
				cell.setCellStyle(bldborcolstyle);
				intCellCount++;
			}

			String strPreviousVal = "";
			int rows_count = 0;
			int rows_count_actual = 1;
			int sno=1;
			boolean boolSameCust = true;
			
			if(vecVal!=null)
			{
			if(vecVal.size()!=0)
			{
				for(int i=0;i<vecVal.size();i++)
				{
					intCellCount=0; 
					intRowCount++;
					row = sheet.createRow((short) intRowCount);
					ArrayList Vecdata=(ArrayList)vecVal.get(i);
					int ksize=strHeadersSize.length;
					for(int j=0;j<Vecdata.size();j++)
					{
						String tempVal="";
						if(j!=7 && j!=8 &&j!=9 && j!=10 && j!=11 && j!=12)
						{
							if(j==4)
							{
								tempVal = Helper.correctNull((String) Vecdata.get(j))+"\n"+Helper.correctNull((String)Vecdata.get(7))+"\n"+Helper.correctNull((String)Vecdata.get(8))+"\n"+Helper.correctNull((String)Vecdata.get(9))+"\n"+Helper.correctNull((String)Vecdata.get(10))+"\n"+Helper.correctNull((String)Vecdata.get(11))+"\n"+Helper.correctNull((String)Vecdata.get(12));
							}
							else
							{
								tempVal=Helper.correctNull((String)Vecdata.get(j));
							}
							cell = row.createCell(intCellCount);
						    cell.setCellType(HSSFCell.CELL_TYPE_STRING);
						    cell.setCellValue(tempVal);
						    intCellCount++;
						}
					}
						
						 
				}
				}
			}
		  File foldername = null;
		  
	  	  String path=ApplicationParams.getStrdoclocation()+"/e-Mandate/";
	  	  foldername=new File(path);
	  	  if(!foldername.exists())
	  	  {
	  		foldername.mkdirs();
	  	  }
	  	  String strFileName="REPORTS3";
		  FileOutputStream fOut = new FileOutputStream(strFileName);
		  hshValues.put("FileDownLoad",strFileName);
		  hshValues.put("strFinancialDn","emandate");

		  wb.write(fOut);
		  
		  fOut.flush();
		  fOut.close();
		}
		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
		}
		finally
		{
			try
			{
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshValues;
	}
	private HashMap getCgtmseRunReport(HashMap hshValues) 
	{
		ResultSet rs = null, rs1 = null, rs2 = null;
		ArrayList arrRow = new ArrayList();
		HashMap hshRec = new HashMap();
		HashMap hshQuery = null;
		int intsize=0;
		ArrayList arrCol =null;
		String strQuery=null;
		String strOrg = null;
		String orglevel=null;
		String strFromDate=null;
		String strToDate=null;
		String strSaveDate=null;
		String strDate=null;
		String strGen=null;
		String strOrg_Name ="";
		String strloantype="",appno="";
		String reportType="";
		String strExcelField=null;
		String strODExcelFIled=null;
		HashMap hshResults=new HashMap();
		double strExistingExposure=0.00,strTotalExposure=0.00;
		String strDepartment="",strAppid="",strDesignation="";
		String strFinancialYear="",strFinancialYear1="",strFinancialYear2="";
		String strHeader="";
		int intFundcnt=0,intNonfundcnt=0,intTempcnt=0;
;		ResultSet rsfinData=null;
		try
		{
			strSaveDate =(String)hshValues.get("txtSaveDate");
			strFromDate =(String)hshValues.get("txtFromDate");
			strToDate =(String)hshValues.get("txtToDate");
			strGen =(String)hshValues.get("strUserId");
			reportType=(String)hshValues.get("report");
			strOrg =correctNull((String)((String)hshValues.get("hidOrgCode")).replace("'",""));
			orglevel=correctNull((String)hshValues.get("orglevel"));
			strOrg_Name=(String)hshValues.get("hidOrgName");
			strDepartment=correctNull((String)hshValues.get("seldepartment"));
			strDesignation=correctNull((String)hshValues.get("seldesignation"));
			//Front end serial no and display date
			String strFromDateEnd =(String)hshValues.get("txtFromDate");
			String strToDateEnd =(String)hshValues.get("txtToDate");
	        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy");
	        String newDateStr = simpleDateFormat.format(simpleDateFormat.parse(strFromDateEnd.substring(8)));
	        String newDateStr1 = simpleDateFormat.format(simpleDateFormat.parse(strToDateEnd.substring(8)));
	        int size=0;
			if(orglevel.equalsIgnoreCase("C"))//head office
			{
				strOrg=strOrg.substring(0,3)+"%";
			}
			else if (orglevel.equalsIgnoreCase("R") || orglevel.equalsIgnoreCase("CPC"))
			{
				strOrg=strOrg.substring(0,6)+"%";
			}
			else if (orglevel.equalsIgnoreCase("D"))
			{
				strOrg=strOrg.substring(0,9)+"%";
			}
			else if (orglevel.equalsIgnoreCase("A"))
			{
				strOrg=strOrg.substring(0,12)+"%";
			}
			else if (orglevel.equalsIgnoreCase("B"))
			{
				strOrg=strOrg;
			}
		
		 if (rs != null) {
				rs.close();
			}
		 
			if(reportType.equalsIgnoreCase("enchancement")){
				
				rs = DBUtils.executeLAPSQuery("sel_enhancement_det^"+strFromDate+"^"+strToDate+"^"+strOrg+"^"+strFromDate+"^"+strToDate+"^"+strOrg);
				
				while(rs.next()){
					intTempcnt=0;
					String strExistingLimit="",strEnhancementLimit="";
					arrCol=new ArrayList();
					if (rs1!= null) {
						rs1.close();
					}
				rs1=DBUtils.executeLAPSQuery("selfinancialReportyear");
				if(rs1.next())
				{
					

					strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(2,4);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+strFinancialYear2;
					
					/*strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(2,4);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+"-"+strFinancialYear2;*/
				}
				
					if (rs1!= null) {
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_cgtmse_enhancedlimits^"+Helper.correctNull(rs.getString("cbs_accountno"))+"^"+strToDate+"^"+Helper.correctNull(rs.getString("cbs_accountno"))+"^"+strToDate);
					while(rs1.next())
					{
						intTempcnt++;
						strEnhancementLimit+=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancamt"))))+"~"+Helper.correctNull(rs1.getString("processdate"))+"@";
					}
					
					
					if (rs1!= null) {
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_cgtmse_existinglimit^"+Helper.correctNull(rs.getString("cbs_accountno"))+"^"+Helper.correctNull(rs.getString("cbs_accountno")));
					if(rs1.next())
					{
						strExistingLimit=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancamt"))));
					}
					
					if(Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("F"))
					{
						if(intTempcnt>intFundcnt)
							intFundcnt=intTempcnt;
					}
					else
					{
						if(intTempcnt>intNonfundcnt)
							intNonfundcnt=intTempcnt;
					}
						
				
					arrCol.add(String.valueOf(++size)+"/"+strFinancialYear);//0
					
					arrCol.add(Helper.correctNull(rs.getString("app_no"))); //1
					arrCol.add(Helper.correctNull(rs.getString("org_name")));//2
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));//3
					arrCol.add(Helper.correctNull(rs.getString("org_scode")));//4
					arrCol.add(Helper.correctNull(rs.getString("org_name")+"/"+(rs.getString("org_scode"))));//5
					arrCol.add(Helper.correctNull(rs.getString("region_name")));//6
					arrCol.add(Helper.correctNull(rs.getString("Application_date")));//7
					arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));//8
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGPAN_NO")));//9
					strHeader="CGTMSE Enhancement Register for the period of";
					if(intTempcnt>0 && Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("F"))
					{
						arrCol.add(strExistingLimit);//110
						arrCol.add(strEnhancementLimit);//1
						arrCol.add(String.valueOf(intTempcnt));//12
					}
					else
					{
						arrCol.add("");//13
						arrCol.add("");//14
						arrCol.add("");//15
					}
					if(intTempcnt>0 && Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("NF"))
					{
						arrCol.add(strExistingLimit);//13
						arrCol.add(strEnhancementLimit);//14
						arrCol.add(String.valueOf(intTempcnt));//15
					}
					else
					{
						arrCol.add("");//13
						arrCol.add("");//14
						arrCol.add("");//15
					}
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUARANTEE_FEE_AMOUNT")));//16
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_TAXABLE_AMOUNT")));//17
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_IGST_RATE")));//18
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_IGST_AMOUNT")));//19
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGST_RATE")));//20
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGST_AMOUNT")));//21
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_SGST_RATE")));//22
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_SGST_AMOUNT")));//23
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUA_STARTDATE")));//24
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUA_ENDDATE")));//25
					arrRow.add(arrCol);		
				}
				
				
				StringBuffer strTemp=new StringBuffer();
				
				strTemp.append("S.NO,App_No,Branch Name,Borrower Name,Branch Code,Branch Code/Branch Name,Name Of Region,Date of Application,A/c No,CGPAN,");
				
				if(intFundcnt>0)
				{
					strTemp.append("Fund Based Existing Amount,");
					
					for(int i=0;i<intFundcnt;i++)
					{
						strTemp.append("Fund Based Enhancement Amount "+(i+1)+",Fund Based Date of Enhancement "+(i+1)+",");
					}
					strTemp.append("Fund Based No. Of Enhancement,");
				}
				if(intNonfundcnt>0)
				{
					strTemp.append("Non Fund Based Existing Amount,");
					
					for(int i=0;i<intNonfundcnt;i++)
					{
						strTemp.append("Non Fund Based Enhancement Amount "+(i+1)+",Non Fund Based Date of Enhancement "+(i+1)+",");
					}
					strTemp.append("Non Fund Based No. Of Enhancement,");
				}
				strTemp.append("Guarantee Fee Amount,Taxable Amount,IGST Rate,IGST Amount,CGST Rate,CGST Amount,SGST Rate,SGST Amount,Guarantee Cover Starts on,Guarantee Cover Expires on");
				
				strExcelField=strTemp.toString();
				
				}
			else if(reportType.equalsIgnoreCase("register_rep"))
			{
				strExcelField="Appl Sl No,Branch Code,Branch Name/Branch Code,Name of the Region,State,Borrower Name,Date of Application," +
						"Type of credit facility,Type of activity,A/c No,Non Fund Based Working Capital Limit No,Guarantee Amount,Applicantion Ref No (Submitted Appl No),CGPAN,Guarantee Fee Amount,Taxable Amount,IGST Rate," +
						"IGST Amount,CGST Rate,CGST Amount,SGST Rate,SGST Amount,Guarantee Cover Starts on,Guarantee Cover Expires on,Udyog Aadhaar No (UAN),MIS Classification," +
						"Woman Operated/Owned";
				rs = DBUtils.executeLAPSQuery("sel_cgtmseregreport^"+strFromDate+"^"+strToDate+"^"+strOrg+"^"+strFromDate+"^"+strToDate+"^"+strOrg);
				while(rs.next())
				{
					arrCol=new ArrayList();
					if (rs1!= null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("selfinancialReportyear");
					if(rs1.next())
					{

						strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
						strFinancialYear1=strFinancialYear.substring(2,4);
						strFinancialYear2=strFinancialYear.substring(7,9);
						strFinancialYear=strFinancialYear1+strFinancialYear2;
					}
					arrCol.add(String.valueOf(++size)+"/"+strFinancialYear);//0
					//arrCol.add(Helper.correctNull(rs.getString("app_no")));  
					//arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));
					arrCol.add(Helper.correctNull(rs.getString("org_scode")));
					//arrCol.add(Helper.correctNull(rs.getString("org_name")));
					arrCol.add(Helper.correctNull(rs.getString("org_name")+"/"+(rs.getString("org_scode"))));
					arrCol.add(Helper.correctNull(rs.getString("region_name")));
					arrCol.add(Helper.correctNull(rs.getString("STATE_NAME")));
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));
					arrCol.add(Helper.correctNull(rs.getString("Application_date")));
					arrCol.add(Helper.correctNull(rs.getString("SCHEME_CODE")));
					arrCol.add(Helper.correctNull(rs.getString("Type_of_activity")));
					arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));
					arrCol.add(Helper.correctNull(rs.getString("NF_accountno")));
					arrCol.add(Helper.correctNull(rs.getString("Guarantee_amount")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_APPL_REFNO")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGPAN_NO")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUARANTEE_FEE_AMOUNT")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_TAXABLE_AMOUNT")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_IGST_RATE")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_IGST_AMOUNT")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGST_RATE")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGST_AMOUNT")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_SGST_RATE")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_SGST_AMOUNT")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUA_STARTDATE")));
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_GUA_ENDDATE")));
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_UDYOG_AADHAR")));
					arrCol.add(Helper.correctNull(rs.getString("app_agriculture")));
					arrCol.add(Helper.correctNull(rs.getString("owned_by_women")));
					arrRow.add(arrCol);
				}
				
			}
			else if(reportType.equalsIgnoreCase("guarant_rep"))
			{
				strExcelField="Sl No,App_No,CBSID,Name of the borrower,CBS Account No.,Sanc. Ref No," +
				"Sanction Date,Sanction Amount,CGPAN of the facility,CGTSME Permitted,Collateral Flag, MIS Classification";
				rs = DBUtils.executeLAPSQuery("sel_cgtmseguar_rep^"+strFromDate+"^"+strToDate+"^"+strOrg+"^"+strFromDate+"^"+strToDate+"^"+strOrg);
				while(rs.next()){
					arrCol=new ArrayList();
					if (rs1!= null) {
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("selfinancialReportyear^"+Helper.correctNull(rs.getString("processdate"))+"^"+Helper.correctNull(rs.getString("processdate")));
					if(rs1.next())
					{
						strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
						strFinancialYear1=strFinancialYear.substring(2,4);
						strFinancialYear2=strFinancialYear.substring(7,9);
						strFinancialYear=strFinancialYear1+"-"+strFinancialYear2;
					}
					arrCol.add(String.valueOf(++size)+"/"+strFinancialYear);//0
					arrCol.add(Helper.correctNull(rs.getString("app_no")));    //1
					arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));//2
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));//3
					arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));//4
					arrCol.add(Helper.correctNull(rs.getString("sanctionrefno")));//5
					arrCol.add(Helper.correctNull(rs.getString("processdate")));//6
					arrCol.add(Helper.correctNull(rs.getString("LOAN_RECMDAMT")));//6
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGPAN_NO")));//6
					arrCol.add(Helper.correctNull(rs.getString("CGTMSE_PERMITTED")));//6
					arrCol.add(Helper.correctNull(rs.getString("collateralflag")));//6
					arrCol.add(Helper.correctNull(rs.getString("app_agriculture")));//6
					arrRow.add(arrCol);		
				}
				
			}
			else if(reportType.equalsIgnoreCase("od")){
				strExcelField="Sl No,App_No,CBSID,Name of the borrower,OD A/c,Sanc. Ref No and date for new limit," +
						"Date of renewal in system,Earlier OD limit,CGPAN of the facility,New OD limit (reduced)";
				rs = DBUtils.executeLAPSQuery("sel_od_details^"+strFromDate+"^"+strToDate+"^"+strOrg+"^"+strFromDate+"^"+strToDate+"^"+strOrg);
				while(rs.next()){
					arrCol=new ArrayList();
					if (rs1!= null) {
						rs1.close();
					}
				rs1=DBUtils.executeLAPSQuery("selfinancialReportyear^"+Helper.correctNull(rs.getString("processdate"))+"^"+Helper.correctNull(rs.getString("processdate")));
				if(rs1.next())
				{
					strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
					strFinancialYear1=strFinancialYear.substring(2,4);
					strFinancialYear2=strFinancialYear.substring(7,9);
					strFinancialYear=strFinancialYear1+"-"+strFinancialYear2;
				}
					//arrCol.add(String.valueOf(++size)+"/"+newDateStr+"-"+newDateStr1);//0
					arrCol.add(String.valueOf(++size)+"/"+strFinancialYear);//0
					arrCol.add(Helper.correctNull(rs.getString("app_no")));    //1
					arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));//2
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));//3
					arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));//4
					arrCol.add(Helper.correctNull(rs.getString("sanctionrefno")+"/"+Helper.correctNull(rs.getString("Newlimit"))));//5
					//arrCol.add(Helper.correctNull(rs.getString("sanctionrefno")));//4
					//arrCol.add(Helper.correctNull(rs.getString("processdate")));//5
					arrCol.add(Helper.correctNull(rs.getString("createdate")));//6	
					arrCol.add(Helper.correctNull(rs.getString("oldlimit")));//7
					arrCol.add(Helper.correctNull(rs.getString("TXNDET_CGPAN_NO")));//8	
					arrCol.add(Helper.correctNull(rs.getString("Newlimit")));//9
					strHeader="CGTMSE Reduction for the period of";
					arrRow.add(arrCol);
				}
			}
			
			else if(reportType.equalsIgnoreCase("ca"))
			{
				int multCACount=0;
				String strcomapp_id="";
				rs = DBUtils.executeLAPSQuery("sel_ca_details^"+strFromDate+"^"+strToDate+"^"+strOrg+"^"+strFromDate+"^"+strToDate+"^"+strOrg);
				while(rs.next())
				{
					arrCol=new ArrayList();
					if (rs1!= null) 
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("selfinancialReportyear");
					if(rs1.next())
					{
						strFinancialYear=Helper.correctNull((String)rs1.getString("FinancialYear"));
						strFinancialYear1=strFinancialYear.substring(2,4);
						strFinancialYear2=strFinancialYear.substring(7,9);
						strFinancialYear=strFinancialYear1+"-"+strFinancialYear2;
					}
					//Latest Audited Financial Year Data
					String StrRowID1="",StrRowID2="",StrRowID3="",StrRowID4="",StrRowID5="",StrRowID6="",StrRowID7="",StrRowID8="",StrRowID9="",StrRowID10="" ;
					String StrRowID11="",StrRowID12="",StrRowID13="",StrRowID14="",StrRowID15="",StrRowID16="",StrRowID17="",StrRowID18="";
					String Strfinancialrequired="";
					strQuery = SQLParser.getSqlQuery("sel_facilityrequired^"+Helper.correctNull(rs.getString("app_no")));
					 rsfinData = DBUtils.executeQuery(strQuery);
					if(rsfinData.next())
					{
						Strfinancialrequired=correctNull(rsfinData.getString("app_facilityrequired"));
					}
					if(Helper.correctNull(rs.getString("app_loantype")).equalsIgnoreCase("p")||(Helper.correctNull(rs.getString("app_loantype")).equalsIgnoreCase("A") && Strfinancialrequired.equalsIgnoreCase("N")) )
					{
					rs1=DBUtils.executeLAPSQuery("sel_dailyreportaudited^"+Helper.correctNull(rs.getString("app_no")));
					if(rs1.next())
					{
						String strSno=Helper.correctNull((String)rs1.getString("COM_SNO"));
						rs2=DBUtils.executeLAPSQuery("sel_dailyreportcgtsmefindata^"+Helper.correctNull(rs.getString("app_no"))+"^"+strSno);
						while(rs2.next())
						{
							if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("1"))
							{	
								StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("2"))
							{	
								StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("3"))
							{	
								StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("4"))
							{	
								StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("5"))
							{	
								StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("6"))
							{	
								StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("7"))
							{	
								StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("8"))
							{	
								StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("9"))
							{	
								StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("10"))
							{	
								StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("11"))
							{	
								StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("12"))
							{	
								StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("13"))
							{	
								StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("14"))
							{	
								StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("15"))
							{	
								StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("16"))
							{	
								StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
							else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("17"))
							{	
								StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
							}
						}
					}
					else 
					{
						rs1=DBUtils.executeLAPSQuery("sel_dailyreportlatestyear^"+Helper.correctNull(rs.getString("app_no")));
						if(rs1.next())
						{
							String strSno=Helper.correctNull((String)rs1.getString("COM_SNO"));
							String strFinType=Helper.correctNull((String)rs1.getString("COM_FINTYPE"));

							rs2=DBUtils.executeLAPSQuery("sel_dailyreportcgtsmefindata^"+Helper.correctNull(rs.getString("app_no"))+"^"+strSno);
							while(rs2.next())
							{
								if(strFinType.equalsIgnoreCase("PROJECTION"))//ESTIMATED  UNAUDITED
								{
									if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("1"))
									{	
										StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("2"))
									{	
										StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("3"))
									{	
										StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("4"))
									{	
										StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("5"))
									{	
										StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("6"))
									{	
										StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("7"))
									{	
										StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("8"))
									{	
										StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("9"))
									{	
										StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("10"))
									{	
										StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("11"))
									{	
										StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("12"))
									{	
										StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("13"))
									{	
										StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("14"))
									{	
										StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("15"))
									{	
										StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("16"))
									{	
										StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("17"))
									{	
										StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
									}
								}
								else if(strFinType.equalsIgnoreCase("ESTIMATED"))//  UNAUDITED
								{
									if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("1"))
									{	
										StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("2"))
									{	
										StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("3"))
									{	
										StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("4"))
									{	
										StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("5"))
									{	
										StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("6"))
									{	
										StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("7"))
									{	
										StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("8"))
									{	
										StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("9"))
									{	
										StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("10"))
									{	
										StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("11"))
									{	
										StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("12"))
									{	
										StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("13"))
									{	
										StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("14"))
									{	
										StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("15"))
									{	
										StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("16"))
									{	
										StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("17"))
									{	
										StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
									}
								}
								else if(strFinType.equalsIgnoreCase("UNAUDITED")) 
								{
									if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("1"))
									{	
										StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("2"))
									{	
										StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("3"))
									{	
										StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("4"))
									{	
										StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("5"))
									{	
										StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("6"))
									{	
										StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("7"))
									{	
										StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("8"))
									{	
										StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("9"))
									{	
										StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("10"))
									{	
										StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("11"))
									{	
										StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("12"))
									{	
										StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("13"))
									{	
										StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("14"))
									{	
										StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("15"))
									{	
										StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("16"))
									{	
										StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
									else if(Helper.correctNull((String)rs2.getString("CGTMSE_ROWID")).equalsIgnoreCase("17"))
									{	
										StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
									}
								}
							}
						}
					}	
					}
					else
					{
						String StrFinancialId="";
						strQuery = SQLParser.getSqlQuery("comdemographics_sel^"+Helper.correctNull(rs.getString("app_no")));
						ResultSet rsfin = DBUtils.executeQuery(strQuery);
						if (rsfin.next())
						{
							StrFinancialId = (Helper.correctInt((String) rsfin.getString("demo_finstandard")));
						}
						rs1=DBUtils.executeLAPSQuery("sel_dailyreportaudited^"+StrFinancialId);
						if(rs1.next())
						{
							String strSno=Helper.correctNull((String)rs1.getString("COM_SNO"));
							rs2=DBUtils.executeLAPSQuery("sel_dailyreportcgtsmefindatacorp^"+Helper.correctNull(rs.getString("app_no"))+"^"+strSno);
							while(rs2.next())
							{
								String StrRowID=Helper.correctNull((String)rs2.getString("CGTMSE_ROWID"));
								if(StrRowID.equalsIgnoreCase("19")||StrRowID.equalsIgnoreCase("100")||StrRowID.equalsIgnoreCase("46")||StrRowID.equalsIgnoreCase("22")||StrRowID.equalsIgnoreCase("107")||
								StrRowID.equalsIgnoreCase("52")||StrRowID.equalsIgnoreCase("58")||StrRowID.equalsIgnoreCase("25")||StrRowID.equalsIgnoreCase("114")||StrRowID.equalsIgnoreCase("28")||
								StrRowID.equalsIgnoreCase("64")||StrRowID.equalsIgnoreCase("121")||StrRowID.equalsIgnoreCase("31")||StrRowID.equalsIgnoreCase("70")||StrRowID.equalsIgnoreCase("128")||
								StrRowID.equalsIgnoreCase("34")||StrRowID.equalsIgnoreCase("76")||StrRowID.equalsIgnoreCase("136")||StrRowID.equalsIgnoreCase("82")||StrRowID.equalsIgnoreCase("37")||
								StrRowID.equalsIgnoreCase("143")||StrRowID.equalsIgnoreCase("150")||StrRowID.equalsIgnoreCase("88")||StrRowID.equalsIgnoreCase("40")||StrRowID.equalsIgnoreCase("43")||
								StrRowID.equalsIgnoreCase("94")||StrRowID.equalsIgnoreCase("157"))
								{	
									StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("21")||StrRowID.equalsIgnoreCase("101")||StrRowID.equalsIgnoreCase("47")||StrRowID.equalsIgnoreCase("24")||
										StrRowID.equalsIgnoreCase("108")||StrRowID.equalsIgnoreCase("53")||StrRowID.equalsIgnoreCase("59")||StrRowID.equalsIgnoreCase("27")||
										StrRowID.equalsIgnoreCase("115")||StrRowID.equalsIgnoreCase("30")||StrRowID.equalsIgnoreCase("65")||StrRowID.equalsIgnoreCase("122")||
										StrRowID.equalsIgnoreCase("33")||StrRowID.equalsIgnoreCase("71")||StrRowID.equalsIgnoreCase("129")||StrRowID.equalsIgnoreCase("36")||
										StrRowID.equalsIgnoreCase("77")||StrRowID.equalsIgnoreCase("137")||StrRowID.equalsIgnoreCase("83")||StrRowID.equalsIgnoreCase("39")||
										StrRowID.equalsIgnoreCase("144")||StrRowID.equalsIgnoreCase("151")||StrRowID.equalsIgnoreCase("89")||StrRowID.equalsIgnoreCase("42")||
										StrRowID.equalsIgnoreCase("45")||StrRowID.equalsIgnoreCase("95")||StrRowID.equalsIgnoreCase("158"))
								{	
									StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("102")||StrRowID.equalsIgnoreCase("48")||StrRowID.equalsIgnoreCase("20")||StrRowID.equalsIgnoreCase("54")||
										StrRowID.equalsIgnoreCase("23")||StrRowID.equalsIgnoreCase("109")||StrRowID.equalsIgnoreCase("26")||StrRowID.equalsIgnoreCase("116")||
										StrRowID.equalsIgnoreCase("60")||StrRowID.equalsIgnoreCase("123")||StrRowID.equalsIgnoreCase("29")||StrRowID.equalsIgnoreCase("66")||
										StrRowID.equalsIgnoreCase("72")||StrRowID.equalsIgnoreCase("130")||StrRowID.equalsIgnoreCase("32")||StrRowID.equalsIgnoreCase("35")||
										StrRowID.equalsIgnoreCase("78")||StrRowID.equalsIgnoreCase("138")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("84")||
										StrRowID.equalsIgnoreCase("145")||StrRowID.equalsIgnoreCase("41")||StrRowID.equalsIgnoreCase("152")||StrRowID.equalsIgnoreCase("90")||
										StrRowID.equalsIgnoreCase("44")||StrRowID.equalsIgnoreCase("159")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("96"))
								{	
									StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("103")||StrRowID.equalsIgnoreCase("49")||StrRowID.equalsIgnoreCase("110")||
										StrRowID.equalsIgnoreCase("55")||StrRowID.equalsIgnoreCase("61")||StrRowID.equalsIgnoreCase("117")||
										StrRowID.equalsIgnoreCase("67")||StrRowID.equalsIgnoreCase("124")||StrRowID.equalsIgnoreCase("73")||
										StrRowID.equalsIgnoreCase("131")||StrRowID.equalsIgnoreCase("79")||StrRowID.equalsIgnoreCase("139")||
										StrRowID.equalsIgnoreCase("146")||StrRowID.equalsIgnoreCase("85")||StrRowID.equalsIgnoreCase("153")||
										StrRowID.equalsIgnoreCase("91")||StrRowID.equalsIgnoreCase("160")||StrRowID.equalsIgnoreCase("97"))
								{	
									StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("104")||StrRowID.equalsIgnoreCase("50")||StrRowID.equalsIgnoreCase("56")||
								StrRowID.equalsIgnoreCase("111")||StrRowID.equalsIgnoreCase("62")||StrRowID.equalsIgnoreCase("118")||
								StrRowID.equalsIgnoreCase("125")||StrRowID.equalsIgnoreCase("68")||StrRowID.equalsIgnoreCase("132")||
								StrRowID.equalsIgnoreCase("74")||StrRowID.equalsIgnoreCase("140")||StrRowID.equalsIgnoreCase("80")||
								StrRowID.equalsIgnoreCase("86")||StrRowID.equalsIgnoreCase("147")||StrRowID.equalsIgnoreCase("92")||
								StrRowID.equalsIgnoreCase("154")||StrRowID.equalsIgnoreCase("161")||StrRowID.equalsIgnoreCase("98"))
								{	
									StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("105")||StrRowID.equalsIgnoreCase("51")||StrRowID.equalsIgnoreCase("57")||
										StrRowID.equalsIgnoreCase("119")||StrRowID.equalsIgnoreCase("63")||StrRowID.equalsIgnoreCase("126")||
										StrRowID.equalsIgnoreCase("69")||StrRowID.equalsIgnoreCase("75")||StrRowID.equalsIgnoreCase("134")||
										StrRowID.equalsIgnoreCase("81")||StrRowID.equalsIgnoreCase("141")||StrRowID.equalsIgnoreCase("148")||
										StrRowID.equalsIgnoreCase("87")||StrRowID.equalsIgnoreCase("155")||StrRowID.equalsIgnoreCase("93")||
										StrRowID.equalsIgnoreCase("99")||StrRowID.equalsIgnoreCase("162"))
								{	
									StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("106")||StrRowID.equalsIgnoreCase("113")||StrRowID.equalsIgnoreCase("120")||
										StrRowID.equalsIgnoreCase("127")||StrRowID.equalsIgnoreCase("135")||StrRowID.equalsIgnoreCase("142")||
										StrRowID.equalsIgnoreCase("149")||StrRowID.equalsIgnoreCase("156")||StrRowID.equalsIgnoreCase("163"))
								{	
									StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("164")||StrRowID.equalsIgnoreCase("175")||StrRowID.equalsIgnoreCase("186")||
										StrRowID.equalsIgnoreCase("198")||StrRowID.equalsIgnoreCase("209")||StrRowID.equalsIgnoreCase("220")||
										StrRowID.equalsIgnoreCase("232")||StrRowID.equalsIgnoreCase("253")||StrRowID.equalsIgnoreCase("266"))
								{	
									StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("165")||StrRowID.equalsIgnoreCase("176")||StrRowID.equalsIgnoreCase("187")||
										StrRowID.equalsIgnoreCase("199")||StrRowID.equalsIgnoreCase("210")||StrRowID.equalsIgnoreCase("221")||
										StrRowID.equalsIgnoreCase("233")||StrRowID.equalsIgnoreCase("249")||StrRowID.equalsIgnoreCase("262"))
								{	
									StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("166")||StrRowID.equalsIgnoreCase("177")||StrRowID.equalsIgnoreCase("188")||
										StrRowID.equalsIgnoreCase("200")||StrRowID.equalsIgnoreCase("211")||StrRowID.equalsIgnoreCase("222")||
										StrRowID.equalsIgnoreCase("234")||StrRowID.equalsIgnoreCase("251")||StrRowID.equalsIgnoreCase("264"))
								{	
									StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("167")||
										StrRowID.equalsIgnoreCase("178")||
												StrRowID.equalsIgnoreCase("189")||
														StrRowID.equalsIgnoreCase("201")||
																StrRowID.equalsIgnoreCase("212")||
																		StrRowID.equalsIgnoreCase("223")||
																				StrRowID.equalsIgnoreCase("235")||
																						StrRowID.equalsIgnoreCase("246")||
																								StrRowID.equalsIgnoreCase("259"))
								{	
									StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("168")||
										StrRowID.equalsIgnoreCase("179")||
												StrRowID.equalsIgnoreCase("190")||
														StrRowID.equalsIgnoreCase("202")||
																StrRowID.equalsIgnoreCase("213")||
																		StrRowID.equalsIgnoreCase("224")||
																				StrRowID.equalsIgnoreCase("236")||
																						StrRowID.equalsIgnoreCase("255")||
																								StrRowID.equalsIgnoreCase("258"))
								{		
									StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("169")||
										StrRowID.equalsIgnoreCase("180")||
												StrRowID.equalsIgnoreCase("191")||
														StrRowID.equalsIgnoreCase("203")||
																StrRowID.equalsIgnoreCase("214")||
																		StrRowID.equalsIgnoreCase("225")||
																				StrRowID.equalsIgnoreCase("237")||
																						StrRowID.equalsIgnoreCase("244")||
																								StrRowID.equalsIgnoreCase("257"))
								{	
									StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("170")||
										StrRowID.equalsIgnoreCase("181")||
												StrRowID.equalsIgnoreCase("192")||
														StrRowID.equalsIgnoreCase("204")||
																StrRowID.equalsIgnoreCase("215")||
																		StrRowID.equalsIgnoreCase("226")||
																				StrRowID.equalsIgnoreCase("238")||
																						StrRowID.equalsIgnoreCase("243")||
																								StrRowID.equalsIgnoreCase("256"))
								{	
									StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("171")||
										StrRowID.equalsIgnoreCase("182")||
												StrRowID.equalsIgnoreCase("193")||
														StrRowID.equalsIgnoreCase("205")||
																StrRowID.equalsIgnoreCase("216")||
																		StrRowID.equalsIgnoreCase("227")||
																				StrRowID.equalsIgnoreCase("239")||
																						StrRowID.equalsIgnoreCase("247")||
																								StrRowID.equalsIgnoreCase("260"))
								{	
									StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("172")||
										StrRowID.equalsIgnoreCase("183")||
												StrRowID.equalsIgnoreCase("194")||
														StrRowID.equalsIgnoreCase("206")||
																StrRowID.equalsIgnoreCase("217")||
																		StrRowID.equalsIgnoreCase("228")||
																				StrRowID.equalsIgnoreCase("240")||
																						StrRowID.equalsIgnoreCase("250")||
																								StrRowID.equalsIgnoreCase("263"))
								{	
									StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
								else if(StrRowID.equalsIgnoreCase("173")||
										StrRowID.equalsIgnoreCase("184")||
												StrRowID.equalsIgnoreCase("195")||
														StrRowID.equalsIgnoreCase("207")||
																StrRowID.equalsIgnoreCase("218")||
																		StrRowID.equalsIgnoreCase("229")||
																				StrRowID.equalsIgnoreCase("241")||
																						StrRowID.equalsIgnoreCase("248")||
																								StrRowID.equalsIgnoreCase("261"))
								{	
									StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_AUDIT"));
								}
							
							}
						}
						else
						{
							rs1=DBUtils.executeLAPSQuery("sel_dailyreportlatestyear^"+StrFinancialId);
							if(rs1.next())
							{
								String strSno=Helper.correctNull((String)rs1.getString("COM_SNO"));
								String strFinType=Helper.correctNull((String)rs1.getString("COM_FINTYPE"));

								rs2=DBUtils.executeLAPSQuery("sel_dailyreportcgtsmefindatacorp^"+Helper.correctNull(rs.getString("app_no"))+"^"+strSno);
								while(rs2.next())
								{
									if(strFinType.equalsIgnoreCase("PROJECTION"))//ESTIMATED  UNAUDITED
									{			String StrRowID=Helper.correctNull((String)rs2.getString("CGTMSE_ROWID"));
									if(StrRowID.equalsIgnoreCase("19")||StrRowID.equalsIgnoreCase("100")||StrRowID.equalsIgnoreCase("46")||StrRowID.equalsIgnoreCase("22")||StrRowID.equalsIgnoreCase("107")||
											StrRowID.equalsIgnoreCase("52")||StrRowID.equalsIgnoreCase("58")||StrRowID.equalsIgnoreCase("25")||StrRowID.equalsIgnoreCase("114")||StrRowID.equalsIgnoreCase("28")||
											StrRowID.equalsIgnoreCase("64")||StrRowID.equalsIgnoreCase("121")||StrRowID.equalsIgnoreCase("31")||StrRowID.equalsIgnoreCase("70")||StrRowID.equalsIgnoreCase("128")||
											StrRowID.equalsIgnoreCase("34")||StrRowID.equalsIgnoreCase("76")||StrRowID.equalsIgnoreCase("136")||StrRowID.equalsIgnoreCase("82")||StrRowID.equalsIgnoreCase("37")||
											StrRowID.equalsIgnoreCase("143")||StrRowID.equalsIgnoreCase("150")||StrRowID.equalsIgnoreCase("88")||StrRowID.equalsIgnoreCase("40")||StrRowID.equalsIgnoreCase("43")||
											StrRowID.equalsIgnoreCase("94")||StrRowID.equalsIgnoreCase("157"))
											{	
												StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("21")||StrRowID.equalsIgnoreCase("101")||StrRowID.equalsIgnoreCase("47")||StrRowID.equalsIgnoreCase("24")||
													StrRowID.equalsIgnoreCase("108")||StrRowID.equalsIgnoreCase("53")||StrRowID.equalsIgnoreCase("59")||StrRowID.equalsIgnoreCase("27")||
													StrRowID.equalsIgnoreCase("115")||StrRowID.equalsIgnoreCase("30")||StrRowID.equalsIgnoreCase("65")||StrRowID.equalsIgnoreCase("122")||
													StrRowID.equalsIgnoreCase("33")||StrRowID.equalsIgnoreCase("71")||StrRowID.equalsIgnoreCase("129")||StrRowID.equalsIgnoreCase("36")||
													StrRowID.equalsIgnoreCase("77")||StrRowID.equalsIgnoreCase("137")||StrRowID.equalsIgnoreCase("83")||StrRowID.equalsIgnoreCase("39")||
													StrRowID.equalsIgnoreCase("144")||StrRowID.equalsIgnoreCase("151")||StrRowID.equalsIgnoreCase("89")||StrRowID.equalsIgnoreCase("42")||
													StrRowID.equalsIgnoreCase("45")||StrRowID.equalsIgnoreCase("95")||StrRowID.equalsIgnoreCase("158"))
											{	
												StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("102")||StrRowID.equalsIgnoreCase("48")||StrRowID.equalsIgnoreCase("20")||StrRowID.equalsIgnoreCase("54")||
													StrRowID.equalsIgnoreCase("23")||StrRowID.equalsIgnoreCase("109")||StrRowID.equalsIgnoreCase("26")||StrRowID.equalsIgnoreCase("116")||
													StrRowID.equalsIgnoreCase("60")||StrRowID.equalsIgnoreCase("123")||StrRowID.equalsIgnoreCase("29")||StrRowID.equalsIgnoreCase("66")||
													StrRowID.equalsIgnoreCase("72")||StrRowID.equalsIgnoreCase("130")||StrRowID.equalsIgnoreCase("32")||StrRowID.equalsIgnoreCase("35")||
													StrRowID.equalsIgnoreCase("78")||StrRowID.equalsIgnoreCase("138")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("84")||
													StrRowID.equalsIgnoreCase("145")||StrRowID.equalsIgnoreCase("41")||StrRowID.equalsIgnoreCase("152")||StrRowID.equalsIgnoreCase("90")||
													StrRowID.equalsIgnoreCase("44")||StrRowID.equalsIgnoreCase("159")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("96"))
											{	
												StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("103")||StrRowID.equalsIgnoreCase("49")||StrRowID.equalsIgnoreCase("110")||
													StrRowID.equalsIgnoreCase("55")||StrRowID.equalsIgnoreCase("61")||StrRowID.equalsIgnoreCase("117")||
													StrRowID.equalsIgnoreCase("67")||StrRowID.equalsIgnoreCase("124")||StrRowID.equalsIgnoreCase("73")||
													StrRowID.equalsIgnoreCase("131")||StrRowID.equalsIgnoreCase("79")||StrRowID.equalsIgnoreCase("139")||
													StrRowID.equalsIgnoreCase("146")||StrRowID.equalsIgnoreCase("85")||StrRowID.equalsIgnoreCase("153")||
													StrRowID.equalsIgnoreCase("91")||StrRowID.equalsIgnoreCase("160")||StrRowID.equalsIgnoreCase("97"))
											{	
												StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("104")||StrRowID.equalsIgnoreCase("50")||StrRowID.equalsIgnoreCase("56")||
											StrRowID.equalsIgnoreCase("111")||StrRowID.equalsIgnoreCase("62")||StrRowID.equalsIgnoreCase("118")||
											StrRowID.equalsIgnoreCase("125")||StrRowID.equalsIgnoreCase("68")||StrRowID.equalsIgnoreCase("132")||
											StrRowID.equalsIgnoreCase("74")||StrRowID.equalsIgnoreCase("140")||StrRowID.equalsIgnoreCase("80")||
											StrRowID.equalsIgnoreCase("86")||StrRowID.equalsIgnoreCase("147")||StrRowID.equalsIgnoreCase("92")||
											StrRowID.equalsIgnoreCase("154")||StrRowID.equalsIgnoreCase("161")||StrRowID.equalsIgnoreCase("98"))
											{	
												StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("105")||StrRowID.equalsIgnoreCase("51")||StrRowID.equalsIgnoreCase("57")||
													StrRowID.equalsIgnoreCase("119")||StrRowID.equalsIgnoreCase("63")||StrRowID.equalsIgnoreCase("126")||
													StrRowID.equalsIgnoreCase("69")||StrRowID.equalsIgnoreCase("75")||StrRowID.equalsIgnoreCase("134")||
													StrRowID.equalsIgnoreCase("81")||StrRowID.equalsIgnoreCase("141")||StrRowID.equalsIgnoreCase("148")||
													StrRowID.equalsIgnoreCase("87")||StrRowID.equalsIgnoreCase("155")||StrRowID.equalsIgnoreCase("93")||
													StrRowID.equalsIgnoreCase("99")||StrRowID.equalsIgnoreCase("162"))
											{	
												StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("106")||StrRowID.equalsIgnoreCase("113")||StrRowID.equalsIgnoreCase("120")||
													StrRowID.equalsIgnoreCase("127")||StrRowID.equalsIgnoreCase("135")||StrRowID.equalsIgnoreCase("142")||
													StrRowID.equalsIgnoreCase("149")||StrRowID.equalsIgnoreCase("156")||StrRowID.equalsIgnoreCase("163"))
											{	
												StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("164")||StrRowID.equalsIgnoreCase("175")||StrRowID.equalsIgnoreCase("186")||
													StrRowID.equalsIgnoreCase("198")||StrRowID.equalsIgnoreCase("209")||StrRowID.equalsIgnoreCase("220")||
													StrRowID.equalsIgnoreCase("232")||StrRowID.equalsIgnoreCase("253")||StrRowID.equalsIgnoreCase("266"))
											{	
												StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("165")||StrRowID.equalsIgnoreCase("176")||StrRowID.equalsIgnoreCase("187")||
													StrRowID.equalsIgnoreCase("199")||StrRowID.equalsIgnoreCase("210")||StrRowID.equalsIgnoreCase("221")||
													StrRowID.equalsIgnoreCase("233")||StrRowID.equalsIgnoreCase("249")||StrRowID.equalsIgnoreCase("262"))
											{	
												StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("166")||StrRowID.equalsIgnoreCase("177")||StrRowID.equalsIgnoreCase("188")||
													StrRowID.equalsIgnoreCase("200")||StrRowID.equalsIgnoreCase("211")||StrRowID.equalsIgnoreCase("222")||
													StrRowID.equalsIgnoreCase("234")||StrRowID.equalsIgnoreCase("251")||StrRowID.equalsIgnoreCase("264"))
											{	
												StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("167")||
													StrRowID.equalsIgnoreCase("178")||
															StrRowID.equalsIgnoreCase("189")||
																	StrRowID.equalsIgnoreCase("201")||
																			StrRowID.equalsIgnoreCase("212")||
																					StrRowID.equalsIgnoreCase("223")||
																							StrRowID.equalsIgnoreCase("235")||
																									StrRowID.equalsIgnoreCase("246")||
																											StrRowID.equalsIgnoreCase("259"))
											{	
												StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("168")||
													StrRowID.equalsIgnoreCase("179")||
															StrRowID.equalsIgnoreCase("190")||
																	StrRowID.equalsIgnoreCase("202")||
																			StrRowID.equalsIgnoreCase("213")||
																					StrRowID.equalsIgnoreCase("224")||
																							StrRowID.equalsIgnoreCase("236")||
																									StrRowID.equalsIgnoreCase("255")||
																											StrRowID.equalsIgnoreCase("258"))
											{		
												StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("169")||
													StrRowID.equalsIgnoreCase("180")||
															StrRowID.equalsIgnoreCase("191")||
																	StrRowID.equalsIgnoreCase("203")||
																			StrRowID.equalsIgnoreCase("214")||
																					StrRowID.equalsIgnoreCase("225")||
																							StrRowID.equalsIgnoreCase("237")||
																									StrRowID.equalsIgnoreCase("244")||
																											StrRowID.equalsIgnoreCase("257"))
											{	
												StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("170")||
													StrRowID.equalsIgnoreCase("181")||
															StrRowID.equalsIgnoreCase("192")||
																	StrRowID.equalsIgnoreCase("204")||
																			StrRowID.equalsIgnoreCase("215")||
																					StrRowID.equalsIgnoreCase("226")||
																							StrRowID.equalsIgnoreCase("238")||
																									StrRowID.equalsIgnoreCase("243")||
																											StrRowID.equalsIgnoreCase("256"))
											{	
												StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("171")||
													StrRowID.equalsIgnoreCase("182")||
															StrRowID.equalsIgnoreCase("193")||
																	StrRowID.equalsIgnoreCase("205")||
																			StrRowID.equalsIgnoreCase("216")||
																					StrRowID.equalsIgnoreCase("227")||
																							StrRowID.equalsIgnoreCase("239")||
																									StrRowID.equalsIgnoreCase("247")||
																											StrRowID.equalsIgnoreCase("260"))
											{	
												StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("172")||
													StrRowID.equalsIgnoreCase("183")||
															StrRowID.equalsIgnoreCase("194")||
																	StrRowID.equalsIgnoreCase("206")||
																			StrRowID.equalsIgnoreCase("217")||
																					StrRowID.equalsIgnoreCase("228")||
																							StrRowID.equalsIgnoreCase("240")||
																									StrRowID.equalsIgnoreCase("250")||
																											StrRowID.equalsIgnoreCase("263"))
											{	
												StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}
											else if(StrRowID.equalsIgnoreCase("173")||
													StrRowID.equalsIgnoreCase("184")||
															StrRowID.equalsIgnoreCase("195")||
																	StrRowID.equalsIgnoreCase("207")||
																			StrRowID.equalsIgnoreCase("218")||
																					StrRowID.equalsIgnoreCase("229")||
																							StrRowID.equalsIgnoreCase("241")||
																									StrRowID.equalsIgnoreCase("248")||
																											StrRowID.equalsIgnoreCase("261"))
											{	
												StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_PROJECTION"));
											}}
									else if(strFinType.equalsIgnoreCase("ESTIMATED"))//  UNAUDITED
									{			String StrRowID=Helper.correctNull((String)rs2.getString("CGTMSE_ROWID"));
									if(StrRowID.equalsIgnoreCase("19")||StrRowID.equalsIgnoreCase("100")||StrRowID.equalsIgnoreCase("46")||StrRowID.equalsIgnoreCase("22")||StrRowID.equalsIgnoreCase("107")||
											StrRowID.equalsIgnoreCase("52")||StrRowID.equalsIgnoreCase("58")||StrRowID.equalsIgnoreCase("25")||StrRowID.equalsIgnoreCase("114")||StrRowID.equalsIgnoreCase("28")||
											StrRowID.equalsIgnoreCase("64")||StrRowID.equalsIgnoreCase("121")||StrRowID.equalsIgnoreCase("31")||StrRowID.equalsIgnoreCase("70")||StrRowID.equalsIgnoreCase("128")||
											StrRowID.equalsIgnoreCase("34")||StrRowID.equalsIgnoreCase("76")||StrRowID.equalsIgnoreCase("136")||StrRowID.equalsIgnoreCase("82")||StrRowID.equalsIgnoreCase("37")||
											StrRowID.equalsIgnoreCase("143")||StrRowID.equalsIgnoreCase("150")||StrRowID.equalsIgnoreCase("88")||StrRowID.equalsIgnoreCase("40")||StrRowID.equalsIgnoreCase("43")||
											StrRowID.equalsIgnoreCase("94")||StrRowID.equalsIgnoreCase("157"))
											{	
												StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("21")||StrRowID.equalsIgnoreCase("101")||StrRowID.equalsIgnoreCase("47")||StrRowID.equalsIgnoreCase("24")||
													StrRowID.equalsIgnoreCase("108")||StrRowID.equalsIgnoreCase("53")||StrRowID.equalsIgnoreCase("59")||StrRowID.equalsIgnoreCase("27")||
													StrRowID.equalsIgnoreCase("115")||StrRowID.equalsIgnoreCase("30")||StrRowID.equalsIgnoreCase("65")||StrRowID.equalsIgnoreCase("122")||
													StrRowID.equalsIgnoreCase("33")||StrRowID.equalsIgnoreCase("71")||StrRowID.equalsIgnoreCase("129")||StrRowID.equalsIgnoreCase("36")||
													StrRowID.equalsIgnoreCase("77")||StrRowID.equalsIgnoreCase("137")||StrRowID.equalsIgnoreCase("83")||StrRowID.equalsIgnoreCase("39")||
													StrRowID.equalsIgnoreCase("144")||StrRowID.equalsIgnoreCase("151")||StrRowID.equalsIgnoreCase("89")||StrRowID.equalsIgnoreCase("42")||
													StrRowID.equalsIgnoreCase("45")||StrRowID.equalsIgnoreCase("95")||StrRowID.equalsIgnoreCase("158"))
											{	
												StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("102")||StrRowID.equalsIgnoreCase("48")||StrRowID.equalsIgnoreCase("20")||StrRowID.equalsIgnoreCase("54")||
													StrRowID.equalsIgnoreCase("23")||StrRowID.equalsIgnoreCase("109")||StrRowID.equalsIgnoreCase("26")||StrRowID.equalsIgnoreCase("116")||
													StrRowID.equalsIgnoreCase("60")||StrRowID.equalsIgnoreCase("123")||StrRowID.equalsIgnoreCase("29")||StrRowID.equalsIgnoreCase("66")||
													StrRowID.equalsIgnoreCase("72")||StrRowID.equalsIgnoreCase("130")||StrRowID.equalsIgnoreCase("32")||StrRowID.equalsIgnoreCase("35")||
													StrRowID.equalsIgnoreCase("78")||StrRowID.equalsIgnoreCase("138")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("84")||
													StrRowID.equalsIgnoreCase("145")||StrRowID.equalsIgnoreCase("41")||StrRowID.equalsIgnoreCase("152")||StrRowID.equalsIgnoreCase("90")||
													StrRowID.equalsIgnoreCase("44")||StrRowID.equalsIgnoreCase("159")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("96"))
											{	
												StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("103")||StrRowID.equalsIgnoreCase("49")||StrRowID.equalsIgnoreCase("110")||
													StrRowID.equalsIgnoreCase("55")||StrRowID.equalsIgnoreCase("61")||StrRowID.equalsIgnoreCase("117")||
													StrRowID.equalsIgnoreCase("67")||StrRowID.equalsIgnoreCase("124")||StrRowID.equalsIgnoreCase("73")||
													StrRowID.equalsIgnoreCase("131")||StrRowID.equalsIgnoreCase("79")||StrRowID.equalsIgnoreCase("139")||
													StrRowID.equalsIgnoreCase("146")||StrRowID.equalsIgnoreCase("85")||StrRowID.equalsIgnoreCase("153")||
													StrRowID.equalsIgnoreCase("91")||StrRowID.equalsIgnoreCase("160")||StrRowID.equalsIgnoreCase("97"))
											{	
												StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("104")||StrRowID.equalsIgnoreCase("50")||StrRowID.equalsIgnoreCase("56")||
											StrRowID.equalsIgnoreCase("111")||StrRowID.equalsIgnoreCase("62")||StrRowID.equalsIgnoreCase("118")||
											StrRowID.equalsIgnoreCase("125")||StrRowID.equalsIgnoreCase("68")||StrRowID.equalsIgnoreCase("132")||
											StrRowID.equalsIgnoreCase("74")||StrRowID.equalsIgnoreCase("140")||StrRowID.equalsIgnoreCase("80")||
											StrRowID.equalsIgnoreCase("86")||StrRowID.equalsIgnoreCase("147")||StrRowID.equalsIgnoreCase("92")||
											StrRowID.equalsIgnoreCase("154")||StrRowID.equalsIgnoreCase("161")||StrRowID.equalsIgnoreCase("98"))
											{	
												StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("105")||StrRowID.equalsIgnoreCase("51")||StrRowID.equalsIgnoreCase("57")||
													StrRowID.equalsIgnoreCase("119")||StrRowID.equalsIgnoreCase("63")||StrRowID.equalsIgnoreCase("126")||
													StrRowID.equalsIgnoreCase("69")||StrRowID.equalsIgnoreCase("75")||StrRowID.equalsIgnoreCase("134")||
													StrRowID.equalsIgnoreCase("81")||StrRowID.equalsIgnoreCase("141")||StrRowID.equalsIgnoreCase("148")||
													StrRowID.equalsIgnoreCase("87")||StrRowID.equalsIgnoreCase("155")||StrRowID.equalsIgnoreCase("93")||
													StrRowID.equalsIgnoreCase("99")||StrRowID.equalsIgnoreCase("162"))
											{	
												StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("106")||StrRowID.equalsIgnoreCase("113")||StrRowID.equalsIgnoreCase("120")||
													StrRowID.equalsIgnoreCase("127")||StrRowID.equalsIgnoreCase("135")||StrRowID.equalsIgnoreCase("142")||
													StrRowID.equalsIgnoreCase("149")||StrRowID.equalsIgnoreCase("156")||StrRowID.equalsIgnoreCase("163"))
											{	
												StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("164")||StrRowID.equalsIgnoreCase("175")||StrRowID.equalsIgnoreCase("186")||
													StrRowID.equalsIgnoreCase("198")||StrRowID.equalsIgnoreCase("209")||StrRowID.equalsIgnoreCase("220")||
													StrRowID.equalsIgnoreCase("232")||StrRowID.equalsIgnoreCase("253")||StrRowID.equalsIgnoreCase("266"))
											{	
												StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("165")||StrRowID.equalsIgnoreCase("176")||StrRowID.equalsIgnoreCase("187")||
													StrRowID.equalsIgnoreCase("199")||StrRowID.equalsIgnoreCase("210")||StrRowID.equalsIgnoreCase("221")||
													StrRowID.equalsIgnoreCase("233")||StrRowID.equalsIgnoreCase("249")||StrRowID.equalsIgnoreCase("262"))
											{	
												StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("166")||StrRowID.equalsIgnoreCase("177")||StrRowID.equalsIgnoreCase("188")||
													StrRowID.equalsIgnoreCase("200")||StrRowID.equalsIgnoreCase("211")||StrRowID.equalsIgnoreCase("222")||
													StrRowID.equalsIgnoreCase("234")||StrRowID.equalsIgnoreCase("251")||StrRowID.equalsIgnoreCase("264"))
											{	
												StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("167")||
													StrRowID.equalsIgnoreCase("178")||
															StrRowID.equalsIgnoreCase("189")||
																	StrRowID.equalsIgnoreCase("201")||
																			StrRowID.equalsIgnoreCase("212")||
																					StrRowID.equalsIgnoreCase("223")||
																							StrRowID.equalsIgnoreCase("235")||
																									StrRowID.equalsIgnoreCase("246")||
																											StrRowID.equalsIgnoreCase("259"))
											{	
												StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("168")||
													StrRowID.equalsIgnoreCase("179")||
															StrRowID.equalsIgnoreCase("190")||
																	StrRowID.equalsIgnoreCase("202")||
																			StrRowID.equalsIgnoreCase("213")||
																					StrRowID.equalsIgnoreCase("224")||
																							StrRowID.equalsIgnoreCase("236")||
																									StrRowID.equalsIgnoreCase("255")||
																											StrRowID.equalsIgnoreCase("258"))
											{		
												StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("169")||
													StrRowID.equalsIgnoreCase("180")||
															StrRowID.equalsIgnoreCase("191")||
																	StrRowID.equalsIgnoreCase("203")||
																			StrRowID.equalsIgnoreCase("214")||
																					StrRowID.equalsIgnoreCase("225")||
																							StrRowID.equalsIgnoreCase("237")||
																									StrRowID.equalsIgnoreCase("244")||
																											StrRowID.equalsIgnoreCase("257"))
											{	
												StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("170")||
													StrRowID.equalsIgnoreCase("181")||
															StrRowID.equalsIgnoreCase("192")||
																	StrRowID.equalsIgnoreCase("204")||
																			StrRowID.equalsIgnoreCase("215")||
																					StrRowID.equalsIgnoreCase("226")||
																							StrRowID.equalsIgnoreCase("238")||
																									StrRowID.equalsIgnoreCase("243")||
																											StrRowID.equalsIgnoreCase("256"))
											{	
												StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("171")||
													StrRowID.equalsIgnoreCase("182")||
															StrRowID.equalsIgnoreCase("193")||
																	StrRowID.equalsIgnoreCase("205")||
																			StrRowID.equalsIgnoreCase("216")||
																					StrRowID.equalsIgnoreCase("227")||
																							StrRowID.equalsIgnoreCase("239")||
																									StrRowID.equalsIgnoreCase("247")||
																											StrRowID.equalsIgnoreCase("260"))
											{	
												StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("172")||
													StrRowID.equalsIgnoreCase("183")||
															StrRowID.equalsIgnoreCase("194")||
																	StrRowID.equalsIgnoreCase("206")||
																			StrRowID.equalsIgnoreCase("217")||
																					StrRowID.equalsIgnoreCase("228")||
																							StrRowID.equalsIgnoreCase("240")||
																									StrRowID.equalsIgnoreCase("250")||
																											StrRowID.equalsIgnoreCase("263"))
											{	
												StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}
											else if(StrRowID.equalsIgnoreCase("173")||
													StrRowID.equalsIgnoreCase("184")||
															StrRowID.equalsIgnoreCase("195")||
																	StrRowID.equalsIgnoreCase("207")||
																			StrRowID.equalsIgnoreCase("218")||
																					StrRowID.equalsIgnoreCase("229")||
																							StrRowID.equalsIgnoreCase("241")||
																									StrRowID.equalsIgnoreCase("248")||
																											StrRowID.equalsIgnoreCase("261"))
											{	
												StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_ESTIMATED"));
											}}
									else if(strFinType.equalsIgnoreCase("UNAUDITED")) 
									{		
										String StrRowID=Helper.correctNull((String)rs2.getString("CGTMSE_ROWID"));
											if(StrRowID.equalsIgnoreCase("19")||StrRowID.equalsIgnoreCase("100")||StrRowID.equalsIgnoreCase("46")||StrRowID.equalsIgnoreCase("22")||StrRowID.equalsIgnoreCase("107")||
											StrRowID.equalsIgnoreCase("52")||StrRowID.equalsIgnoreCase("58")||StrRowID.equalsIgnoreCase("25")||StrRowID.equalsIgnoreCase("114")||StrRowID.equalsIgnoreCase("28")||
											StrRowID.equalsIgnoreCase("64")||StrRowID.equalsIgnoreCase("121")||StrRowID.equalsIgnoreCase("31")||StrRowID.equalsIgnoreCase("70")||StrRowID.equalsIgnoreCase("128")||
											StrRowID.equalsIgnoreCase("34")||StrRowID.equalsIgnoreCase("76")||StrRowID.equalsIgnoreCase("136")||StrRowID.equalsIgnoreCase("82")||StrRowID.equalsIgnoreCase("37")||
											StrRowID.equalsIgnoreCase("143")||StrRowID.equalsIgnoreCase("150")||StrRowID.equalsIgnoreCase("88")||StrRowID.equalsIgnoreCase("40")||StrRowID.equalsIgnoreCase("43")||
											StrRowID.equalsIgnoreCase("94")||StrRowID.equalsIgnoreCase("157"))
											{	
												StrRowID1=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("21")||StrRowID.equalsIgnoreCase("101")||StrRowID.equalsIgnoreCase("47")||StrRowID.equalsIgnoreCase("24")||
													StrRowID.equalsIgnoreCase("108")||StrRowID.equalsIgnoreCase("53")||StrRowID.equalsIgnoreCase("59")||StrRowID.equalsIgnoreCase("27")||
													StrRowID.equalsIgnoreCase("115")||StrRowID.equalsIgnoreCase("30")||StrRowID.equalsIgnoreCase("65")||StrRowID.equalsIgnoreCase("122")||
													StrRowID.equalsIgnoreCase("33")||StrRowID.equalsIgnoreCase("71")||StrRowID.equalsIgnoreCase("129")||StrRowID.equalsIgnoreCase("36")||
													StrRowID.equalsIgnoreCase("77")||StrRowID.equalsIgnoreCase("137")||StrRowID.equalsIgnoreCase("83")||StrRowID.equalsIgnoreCase("39")||
													StrRowID.equalsIgnoreCase("144")||StrRowID.equalsIgnoreCase("151")||StrRowID.equalsIgnoreCase("89")||StrRowID.equalsIgnoreCase("42")||
													StrRowID.equalsIgnoreCase("45")||StrRowID.equalsIgnoreCase("95")||StrRowID.equalsIgnoreCase("158"))
											{	
												StrRowID2=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("102")||StrRowID.equalsIgnoreCase("48")||StrRowID.equalsIgnoreCase("20")||StrRowID.equalsIgnoreCase("54")||
													StrRowID.equalsIgnoreCase("23")||StrRowID.equalsIgnoreCase("109")||StrRowID.equalsIgnoreCase("26")||StrRowID.equalsIgnoreCase("116")||
													StrRowID.equalsIgnoreCase("60")||StrRowID.equalsIgnoreCase("123")||StrRowID.equalsIgnoreCase("29")||StrRowID.equalsIgnoreCase("66")||
													StrRowID.equalsIgnoreCase("72")||StrRowID.equalsIgnoreCase("130")||StrRowID.equalsIgnoreCase("32")||StrRowID.equalsIgnoreCase("35")||
													StrRowID.equalsIgnoreCase("78")||StrRowID.equalsIgnoreCase("138")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("84")||
													StrRowID.equalsIgnoreCase("145")||StrRowID.equalsIgnoreCase("41")||StrRowID.equalsIgnoreCase("152")||StrRowID.equalsIgnoreCase("90")||
													StrRowID.equalsIgnoreCase("44")||StrRowID.equalsIgnoreCase("159")||StrRowID.equalsIgnoreCase("38")||StrRowID.equalsIgnoreCase("96"))
											{	
												StrRowID3=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("103")||StrRowID.equalsIgnoreCase("49")||StrRowID.equalsIgnoreCase("110")||
													StrRowID.equalsIgnoreCase("55")||StrRowID.equalsIgnoreCase("61")||StrRowID.equalsIgnoreCase("117")||
													StrRowID.equalsIgnoreCase("67")||StrRowID.equalsIgnoreCase("124")||StrRowID.equalsIgnoreCase("73")||
													StrRowID.equalsIgnoreCase("131")||StrRowID.equalsIgnoreCase("79")||StrRowID.equalsIgnoreCase("139")||
													StrRowID.equalsIgnoreCase("146")||StrRowID.equalsIgnoreCase("85")||StrRowID.equalsIgnoreCase("153")||
													StrRowID.equalsIgnoreCase("91")||StrRowID.equalsIgnoreCase("160")||StrRowID.equalsIgnoreCase("97"))
											{	
												StrRowID4=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("104")||StrRowID.equalsIgnoreCase("50")||StrRowID.equalsIgnoreCase("56")||
											StrRowID.equalsIgnoreCase("111")||StrRowID.equalsIgnoreCase("62")||StrRowID.equalsIgnoreCase("118")||
											StrRowID.equalsIgnoreCase("125")||StrRowID.equalsIgnoreCase("68")||StrRowID.equalsIgnoreCase("132")||
											StrRowID.equalsIgnoreCase("74")||StrRowID.equalsIgnoreCase("140")||StrRowID.equalsIgnoreCase("80")||
											StrRowID.equalsIgnoreCase("86")||StrRowID.equalsIgnoreCase("147")||StrRowID.equalsIgnoreCase("92")||
											StrRowID.equalsIgnoreCase("154")||StrRowID.equalsIgnoreCase("161")||StrRowID.equalsIgnoreCase("98"))
											{	
												StrRowID5=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("105")||StrRowID.equalsIgnoreCase("51")||StrRowID.equalsIgnoreCase("57")||
													StrRowID.equalsIgnoreCase("119")||StrRowID.equalsIgnoreCase("63")||StrRowID.equalsIgnoreCase("126")||
													StrRowID.equalsIgnoreCase("69")||StrRowID.equalsIgnoreCase("75")||StrRowID.equalsIgnoreCase("134")||
													StrRowID.equalsIgnoreCase("81")||StrRowID.equalsIgnoreCase("141")||StrRowID.equalsIgnoreCase("148")||
													StrRowID.equalsIgnoreCase("87")||StrRowID.equalsIgnoreCase("155")||StrRowID.equalsIgnoreCase("93")||
													StrRowID.equalsIgnoreCase("99")||StrRowID.equalsIgnoreCase("162"))
											{	
												StrRowID6=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("106")||StrRowID.equalsIgnoreCase("113")||StrRowID.equalsIgnoreCase("120")||
													StrRowID.equalsIgnoreCase("127")||StrRowID.equalsIgnoreCase("135")||StrRowID.equalsIgnoreCase("142")||
													StrRowID.equalsIgnoreCase("149")||StrRowID.equalsIgnoreCase("156")||StrRowID.equalsIgnoreCase("163"))
											{	
												StrRowID7=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("164")||StrRowID.equalsIgnoreCase("175")||StrRowID.equalsIgnoreCase("186")||
													StrRowID.equalsIgnoreCase("198")||StrRowID.equalsIgnoreCase("209")||StrRowID.equalsIgnoreCase("220")||
													StrRowID.equalsIgnoreCase("232")||StrRowID.equalsIgnoreCase("253")||StrRowID.equalsIgnoreCase("266"))
											{	
												StrRowID8=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("165")||StrRowID.equalsIgnoreCase("176")||StrRowID.equalsIgnoreCase("187")||
													StrRowID.equalsIgnoreCase("199")||StrRowID.equalsIgnoreCase("210")||StrRowID.equalsIgnoreCase("221")||
													StrRowID.equalsIgnoreCase("233")||StrRowID.equalsIgnoreCase("249")||StrRowID.equalsIgnoreCase("262"))
											{	
												StrRowID9=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("166")||StrRowID.equalsIgnoreCase("177")||StrRowID.equalsIgnoreCase("188")||
													StrRowID.equalsIgnoreCase("200")||StrRowID.equalsIgnoreCase("211")||StrRowID.equalsIgnoreCase("222")||
													StrRowID.equalsIgnoreCase("234")||StrRowID.equalsIgnoreCase("251")||StrRowID.equalsIgnoreCase("264"))
											{	
												StrRowID10=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("167")||
													StrRowID.equalsIgnoreCase("178")||
															StrRowID.equalsIgnoreCase("189")||
																	StrRowID.equalsIgnoreCase("201")||
																			StrRowID.equalsIgnoreCase("212")||
																					StrRowID.equalsIgnoreCase("223")||
																							StrRowID.equalsIgnoreCase("235")||
																									StrRowID.equalsIgnoreCase("246")||
																											StrRowID.equalsIgnoreCase("259"))
											{	
												StrRowID11=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("168")||
													StrRowID.equalsIgnoreCase("179")||
															StrRowID.equalsIgnoreCase("190")||
																	StrRowID.equalsIgnoreCase("202")||
																			StrRowID.equalsIgnoreCase("213")||
																					StrRowID.equalsIgnoreCase("224")||
																							StrRowID.equalsIgnoreCase("236")||
																									StrRowID.equalsIgnoreCase("255")||
																											StrRowID.equalsIgnoreCase("258"))
											{		
												StrRowID12=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("169")||
													StrRowID.equalsIgnoreCase("180")||
															StrRowID.equalsIgnoreCase("191")||
																	StrRowID.equalsIgnoreCase("203")||
																			StrRowID.equalsIgnoreCase("214")||
																					StrRowID.equalsIgnoreCase("225")||
																							StrRowID.equalsIgnoreCase("237")||
																									StrRowID.equalsIgnoreCase("244")||
																											StrRowID.equalsIgnoreCase("257"))
											{	
												StrRowID13=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("170")||
													StrRowID.equalsIgnoreCase("181")||
															StrRowID.equalsIgnoreCase("192")||
																	StrRowID.equalsIgnoreCase("204")||
																			StrRowID.equalsIgnoreCase("215")||
																					StrRowID.equalsIgnoreCase("226")||
																							StrRowID.equalsIgnoreCase("238")||
																									StrRowID.equalsIgnoreCase("243")||
																											StrRowID.equalsIgnoreCase("256"))
											{	
												StrRowID14=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("171")||
													StrRowID.equalsIgnoreCase("182")||
															StrRowID.equalsIgnoreCase("193")||
																	StrRowID.equalsIgnoreCase("205")||
																			StrRowID.equalsIgnoreCase("216")||
																					StrRowID.equalsIgnoreCase("227")||
																							StrRowID.equalsIgnoreCase("239")||
																									StrRowID.equalsIgnoreCase("247")||
																											StrRowID.equalsIgnoreCase("260"))
											{	
												StrRowID15=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("172")||
													StrRowID.equalsIgnoreCase("183")||
															StrRowID.equalsIgnoreCase("194")||
																	StrRowID.equalsIgnoreCase("206")||
																			StrRowID.equalsIgnoreCase("217")||
																					StrRowID.equalsIgnoreCase("228")||
																							StrRowID.equalsIgnoreCase("240")||
																									StrRowID.equalsIgnoreCase("250")||
																											StrRowID.equalsIgnoreCase("263"))
											{	
												StrRowID16=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}
											else if(StrRowID.equalsIgnoreCase("173")||
													StrRowID.equalsIgnoreCase("184")||
															StrRowID.equalsIgnoreCase("195")||
																	StrRowID.equalsIgnoreCase("207")||
																			StrRowID.equalsIgnoreCase("218")||
																					StrRowID.equalsIgnoreCase("229")||
																							StrRowID.equalsIgnoreCase("241")||
																									StrRowID.equalsIgnoreCase("248")||
																											StrRowID.equalsIgnoreCase("261"))
											{	
												StrRowID17=Helper.correctNull((String)rs2.getString("CGTMSE_UNAUDIT"));
											}}
								}
							}
						}	
					}
						
					//loantype
					Double retExistamt=0.00,retProposedAmt=0.00;

					String appRenewFlag=Helper.correctNull(rs.getString("APP_RENEW_FLAG"));
					retExistamt=Double.parseDouble(Helper.correctNull((String)rs.getString("LOAN_RECMDAMT")));
					retProposedAmt=Double.parseDouble(Helper.correctNull((String)rs.getString("LOAN_AMTREQD")));
					
				    String strAadhar="",strConstitution="",strPhyChallenged="",mobileNum="",triEducation="",indNetworth="",networth="",Experience="";
					String loanType=Helper.correctNull(rs.getString("loantype"));
					String cgtMseFlag=Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
					double ExistingAmt=0,proposedAmt=0;
					if(loanType.equalsIgnoreCase("TL") || (loanType.equalsIgnoreCase("DL")))
		             {
				       loanType="Term Loan";
			         }
		            else if(loanType.equalsIgnoreCase("OD"))
		            {
			        if(appRenewFlag.equalsIgnoreCase("R"))
				     {
									
				    if(retExistamt < retProposedAmt)
		              {
					    loanType="Enhancement in WC"; 
				      }
				    else
				      {
					    loanType="Renewal of Cover for WC"; 
				       }
									   
			        }
		          else
			        {
				       loanType="Working Capital";
			        }
									
		           }
					
					if(cgtMseFlag.equalsIgnoreCase("Y"))
					{
						
					String	facilityLoanType=correctNull((String)rs.getString("facility_sel_type"));
					 ExistingAmt=Double.parseDouble(Helper.correctNull((String)rs.getString("FACILITY_EXISTING")));
					  proposedAmt=Double.parseDouble(Helper.correctNull((String)rs.getString("FACILITY_PROPOSED")));
					
						
						    if(loanType.equalsIgnoreCase("Working Capital") &&  !facilityLoanType.equalsIgnoreCase("2"))
						    {
						    	 if(ExistingAmt < proposedAmt)
						    	 {
						    		 loanType="Enhancement in WC";
						    	 }else{
						    		 loanType="Working Capital";
						    	 }
						    	
						    }else if(loanType.equalsIgnoreCase("Working Capital") &&  facilityLoanType.equalsIgnoreCase("2"))
						      {
						    	 
						    		 loanType="Renewal of Cover for WC";
						    	 
						      }else if(loanType.equalsIgnoreCase("Working Capital")){
						    	     loanType="Working Capital";
						      }
						      else if(loanType.equalsIgnoreCase("Term Loan")){
						    	  loanType="Term Loan";
						      }
						       
						
					}
					String Constitutionchk=Helper.correctNull(rs.getString("PERAPP_CONSTITUTION"));			  
					indNetworth=Helper.correctNull(rs.getString("PERAPP_NETWORTH"));
						if(rs1!= null)
						{
						 rs1.close();
						}
					rs1=DBUtils.executeLAPSQuery("sel_cbsid_promoter^"+Helper.correctNull(rs.getString("PERAPP_ID")));
					while(rs1.next()){
					String  promoNetworthr=Helper.correctNull(rs1.getString("PERAPP_NETWORTH"));
					 // String strCONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));
													    
					  if(Constitutionchk.equalsIgnoreCase("01"))
					   {	
					     networth=indNetworth;
					    }
					   else
					    {
					   networth=promoNetworthr;
					    }
					}	
					 if(rs1!= null)
					 {
					 	rs1.close();
					 }
					  rs1=DBUtils.executeLAPSQuery("sel_cbsid_promoterExperience^"+Helper.correctNull(rs.getString("PERAPP_ID")));
					 while(rs1.next()) 
					    {
					  Experience=Helper.correctNull(rs1.getString("PEREMP_EXPINYRS"));
					    }
					arrCol.add(String.valueOf(++size)+"/"+strFinancialYear);//0
					arrCol.add(loanType);//1
					arrCol.add("");    //2
					arrCol.add(Helper.correctNull(rs.getString("org_scode"))+"/"+Helper.correctNull(rs.getString("org_name")));//3
					arrCol.add(Helper.correctNull(rs.getString("org_scode"))); //4
					arrCol.add(Helper.correctNull(rs.getString("orgstatename")));  //5
					arrCol.add(Helper.correctNull(rs.getString("CG_PRV_CGP")));    //6
					arrCol.add(Helper.correctNull(rs.getString("perapp_cbsid")));//7
					arrCol.add(Helper.correctNull(rs.getString("cg_cgpan")));    //8
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_CONSTITUTION")));    //9
					//arrCol.add(Helper.correctNull(rs.getString("perapp_title")));   //10
					arrCol.add(Helper.correctNull(rs.getString("perapp_fname")));    //10
					arrCol.add(Helper.correctNull(rs.getString("address")));    //11
					arrCol.add(Helper.correctNull(rs.getString("currentstate")));    //12
					arrCol.add(Helper.correctNull(rs.getString("currdist")));    //13
					arrCol.add(Helper.correctNull(rs.getString("currentcity")));    //14
					arrCol.add(Helper.correctNull(rs.getString("currzip")));    //15
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_PANNO"))); //16
					//arrCol.add("");    //18
					arrCol.add(Helper.correctNull(rs.getString("CG_NATUREINDUSTRY"))); //17
				    arrCol.add(Helper.correctNull(rs.getString("CG_TYPEOFLOAN")));//18
					arrCol.add(Helper.correctNull(rs.getString("CG_INDUSTRYSECTOR")));    //19
					//arrCol.add(Helper.correctNull(rs.getString("kyc_kycactivity")));    
					arrCol.add(Helper.correctNull(rs.getString("CG_NOEMP")));    //20
					//unit tri/edu/agri
			        String retTri_edu_agri=	Helper.correctNull(rs.getString("CG_EDUCATION"));	
			        String corTri_edu_agri=	Helper.correctNull(rs.getString("CG_UNIT_ENGAGED"));	
			        
			        if(retTri_edu_agri.equalsIgnoreCase("N")||retTri_edu_agri.equalsIgnoreCase("")||corTri_edu_agri.equalsIgnoreCase("N")||corTri_edu_agri.equalsIgnoreCase("")){
			        	triEducation="NO";
			        }
					arrCol.add(triEducation);    //21
					arrCol.add(Helper.correctNull(rs.getString("CG_PROJ_OPTI_SALES")));   //22
					arrCol.add(Helper.correctNull(rs.getString("CG_PROJ_OPTI_EXPORT"))); //23
					arrCol.add(Helper.correctNull(rs.getString("promotertitle")));///24
					arrCol.add(Helper.correctNull(rs.getString("promoterfname")));//25
					arrCol.add("");    //26
					arrCol.add(Helper.correctNull(rs.getString("promoterlastname")));//27
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_SEX")));//28
					arrCol.add(Helper.correctNull(rs.getString("promoterpan")));//29
					arrCol.add(Helper.correctNull(rs.getString("INDINFO_IS_MINOR")));//30
                    String phyChallenged= Helper.correctNull(rs.getString("INDINFO_PHYSICALLY_CHALLANGED"));
					
					strConstitution=Helper.correctNull(rs.getString("PERAPP_CONSTITUTION"));
					
					if(strConstitution.equalsIgnoreCase("Individuals")){
						if(phyChallenged.equalsIgnoreCase("N")||phyChallenged.equalsIgnoreCase("")){
							strPhyChallenged="NO";
						}else{
							strPhyChallenged="yes";
						     }
					}
					
					// 15/12/2021 error starts here.....
					if(rs1!= null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_cbsid_promoDetails^"+Helper.correctNull(rs.getString("PERAPP_ID")));
					while(rs1.next()){
                            
						String strCONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));
						String strCheifPromoter=Helper.correctNull(rs1.getString("COMAPP_CHF_PROMOTER"));
						String proPhyChallenged=Helper.correctNull(rs1.getString("INDINFO_PHYSICALLY_CHALLANGED"));

						
						//physically challenged check
						if(strCONSTITUTION.equalsIgnoreCase("01")){
							if(phyChallenged.equalsIgnoreCase("N")){
								strPhyChallenged="NO";
							}else{
								strPhyChallenged="yes";
							     }
						}else if(strCONSTITUTION != "01"){
							if(strCheifPromoter.equalsIgnoreCase("Y")){
								 if(proPhyChallenged.equalsIgnoreCase("N")){
									 strPhyChallenged="NO";			 
								 }else{
									 strPhyChallenged="YES";
								 }
							}
						}
						
					}
					arrCol.add(strPhyChallenged);     //31  PHYSICALLY_CHALLANGED
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_DOB")));//32
					arrCol.add(Helper.correctNull(rs.getString("CG_SOCIALCATGRY")));    //33 social category---indinfo_caste
					arrCol.add(Helper.correctNull(rs.getString("PERAPP_UDYOG_AADHAR")));//34
					arrCol.add(Helper.correctNull(rs.getString("cbs_Accountno")));//35
					arrCol.add("");//36 
					arrCol.add(""); //37
                    String aadhar=Helper.correctNull(rs.getString("perapp_aadhaar"));
					//Individuals Aadhaar
					strConstitution=Helper.correctNull(rs.getString("PERAPP_CONSTITUTION"));
					if(strConstitution.equalsIgnoreCase("Individuals")){
						if(aadhar ==""){
							strAadhar="NIL";
						
						}else{
							strAadhar=aadhar;
						}
					}
					
					//Non-Individuals
					if(rs1!= null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_cbsid_proDetails^"+Helper.correctNull(rs.getString("PERAPP_ID")));
					while(rs1.next()){
						String strCheifPromoter=Helper.correctNull(rs1.getString("COMAPP_CHF_PROMOTER"));
					    String  promoAadhaar=Helper.correctNull(rs1.getString("PERAPP_AADHAAR"));
					    String strCONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));

						//individual or NonIndividual Aadhar
						if(strCONSTITUTION.equalsIgnoreCase("01")){
							if(aadhar ==""){
								strAadhar="NIL";
							
							}else{
								strAadhar=aadhar;
							}
						}else if(strCONSTITUTION != "01"){
							       if(strCheifPromoter.equalsIgnoreCase("Y")){
							    	   if(promoAadhaar !="")
							    	   strAadhar=promoAadhaar;
							       }else{
							    	   strAadhar="NIL";
							       }
							
						}else {
							 strAadhar="NIL";
						}

					}
					String strMobile=Helper.correctNull(rs.getString("CON_MOBILE"));
			          if(strMobile.equalsIgnoreCase("")){
			        	  mobileNum="Nil";
			          }else{
			        	  mobileNum=strMobile;
			          }
				
				    if(rs1!= null)
				    {
					  rs1.close();
				    }
		           rs1=DBUtils.executeLAPSQuery("sel_cbsid_promoDetails^"+Helper.correctNull(rs.getString("PERAPP_ID")));
				   while(rs1.next()){
					String strCheifPromoter=Helper.correctNull(rs1.getString("COMAPP_CHF_PROMOTER"));
				    
				    String proMobile=Helper.correctNull(rs1.getString("CON_MOBILE"));
				    
				    if(strCheifPromoter.equalsIgnoreCase("Y")){
				    	mobileNum=proMobile;
				    }else
				    {
				    	mobileNum=strMobile;
				    }
		
				    }
				    arrCol.add(strAadhar);//38 Aadhaar No
					arrCol.add(mobileNum);    //39mobileno

					ArrayList arrrow1=new ArrayList();
					ArrayList arrrow2=new ArrayList();
					ArrayList arrrow3=new ArrayList();
					rs1=DBUtils.executeLAPSQuery("ca_division_details_sel^"+Helper.correctNull(rs.getString("PERAPP_ID")));
					while(rs1.next())
					{
						arrrow1.add(Helper.correctNull(rs1.getString("perapp_fname"))); //
						arrrow2.add(Helper.correctNull(rs1.getString("PERAPP_PANNO"))); //
						arrrow3.add(Helper.correctNull(rs1.getString("perapp_dob"))); //
					}
					
					arrCol.add(arrrow1);//40
					arrCol.add(arrrow2);//41
					arrCol.add(arrrow3);//42
					
					if(arrrow1!=null && arrrow1.size()>multCACount)
					{
						multCACount=arrrow1.size();
						
					}
					
					
					arrCol.add(Helper.correctNull(rs.getString("CG_NEW_UNIT")));//43
					arrCol.add(Helper.correctNull(rs.getString("CG_NEW_UNIT_WO")));//44
					String strncgtc=Helper.correctNull(rs.getString("CG_NCGTC"));
					if(strncgtc.equalsIgnoreCase("N")||strncgtc.equalsIgnoreCase(""))
					{
				      strncgtc="NO";
					}
					arrCol.add(strncgtc);    //45
					arrCol.add(Helper.correctNull(rs.getString("CG_MSE_UNIT")));//46
					arrCol.add(Helper.correctNull(rs.getString("CG_MSE_UNIT_WO")));//47
					arrCol.add(Helper.correctNull(rs.getString("cg_firstCharge")));  //48
					arrCol.add(Helper.correctNull(rs.getString("CG_COLSEC")));//49
					arrCol.add(Helper.correctNull(rs.getString("CG_THIRDPARTY")));//50
					arrCol.add(Helper.correctNull(rs.getString("CG_JOINTFINANCE")));//51
					arrCol.add(Helper.correctNull(rs.getString("cg_cgpan")));//52
					arrCol.add(Helper.correctNull(rs.getString("CG_ARTISAN_CC")));//53
					arrCol.add(Helper.correctNull(rs.getString("cg_gf_asf")));  //54
					arrCol.add(Helper.correctNull(rs.getString("cg_identy_dc")));//55
					arrCol.add(Helper.correctNull(rs.getString("cg_issuedate")));//56
					arrCol.add(Helper.correctNull(rs.getString("CG_HANDLOOMSCHEME")));//57
					arrCol.add(Helper.correctNull(rs.getString("cg_namescheme")));  //58
					arrCol.add(Helper.correctNull(rs.getString("cg_checkbx")));//59
				    arrCol.add(Helper.correctNull(rs.getString("CG_INTERNAL_RATING"))); //60
				    arrCol.add("");//61
				    if(Helper.correctNull(rs.getString("loantype")).equalsIgnoreCase("Term Loan"))
				    {
				    	arrCol.add(Helper.correctNull(rs.getString("LOAN_RECMDAMT")));    //62
						arrCol.add(Helper.correctNull(rs.getString("CG_TC_PROMOTERS")));  //63
		                arrCol.add(Helper.correctNull(rs.getString("CG_TC_SUBSIDY")));    //64
						arrCol.add(Helper.correctNull(rs.getString("CG_TC_OTHERS")));    //65
				    }
				    else
				    {
				    	arrCol.add("");    //62
						arrCol.add("");    //63
		                arrCol.add("");    //64
						arrCol.add("");    //65
				    }
				    if(Helper.correctNull(rs.getString("loantype")).equalsIgnoreCase("Working Capital") && Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("F")){
				    	arrCol.add(Helper.correctNull(rs.getString("LOAN_RECMDAMT")));    //66
				    	arrCol.add("");    //67
				    }
				    else if(Helper.correctNull(rs.getString("loantype")).equalsIgnoreCase("Working Capital") && Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("NF")){
				    	arrCol.add("");    //66
				    	arrCol.add(Helper.correctNull(rs.getString("LOAN_RECMDAMT")));    //67
				    	
				    }
				    else
				    {
				    	arrCol.add(""); //66   
						arrCol.add("");//67
				    }
				    
				    if(Helper.correctNull(rs.getString("loantype")).equalsIgnoreCase("Working Capital")){
				    	arrCol.add("");//68
						arrCol.add(Helper.correctNull(rs.getString("CG_TC_PROMOTERS")));    //69
		                arrCol.add(Helper.correctNull(rs.getString("CG_TC_SUBSIDY")));    //70
						arrCol.add(Helper.correctNull(rs.getString("CG_TC_OTHERS")));    //71
				    }
				    else
				    {
				    	arrCol.add("");    //68
						arrCol.add("");    //69
		                arrCol.add("");    //70
						arrCol.add("");    //71
				    }
				     
				    arrCol.add(Helper.correctNull(rs.getString("loan_duedate")));//72 loan termination date
				    arrCol.add("");// 73remarks
				    arrCol.add(Helper.correctNull(rs.getString("processdate")));//74
				    if(Helper.correctNull(rs.getString("loantype")).equalsIgnoreCase("Term Loan"))
				    {
						arrCol.add(Helper.correctDouble(rs.getString("TXNDET_CRDT_AMT")));//75
						arrCol.add(Helper.correctDouble(rs.getString("TXNDET_AMT_DISBURSED")));//76
						arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_FST_DISB")));//77
						arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_LST_DISB")));//78
						arrCol.add(Helper.correctNull(rs.getString("loan_reqterms")));//79
						arrCol.add(Helper.correctNull(rs.getString("LOAN_INTTYPE")));//80
						arrCol.add(Helper.correctNull(rs.getString("loan_baserate")));//81
						arrCol.add(Helper.correctNull(rs.getString("LOAN_INTRATE")));//82
						arrCol.add("");//83  Moratorium
						arrCol.add(Helper.correctNull(rs.getString("TXNDET_FST_INS_DUE_DT")));//84
						arrCol.add(Helper.correctNull(rs.getString("LOAN_PERIODICITY")));//85
						arrCol.add(Helper.correctNull(rs.getString("LOAN_NOOFINSTALLMENT")));//86  rearrangement
						arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTS_BAL_AMT")));//87
						arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTS_BAL_DT")));//88
						arrCol.add("");//89
						arrCol.add("");//90
						arrCol.add("");//91
						arrCol.add("");//92
						arrCol.add("");//93
						arrCol.add("");//94
						arrCol.add("");//95
						arrCol.add("");//96
						arrCol.add("");//97
						arrCol.add("");//98
						arrCol.add("");//99
						arrCol.add("");//100
						arrCol.add("");//101
						arrCol.add("");//102
						arrCol.add("");//103
						arrCol.add("");//104
					}
				    else
				    {
						arrCol.add("");//75
						arrCol.add("");//76
						arrCol.add("");//77
						arrCol.add("");//78
						arrCol.add("");//79
						arrCol.add("");//80
						arrCol.add("");//81
						arrCol.add("");//82
						arrCol.add("");//83
						arrCol.add("");//84
						arrCol.add("");//85
						arrCol.add("");//86
						arrCol.add("");//87
						arrCol.add("");//88
						//WK
						 arrCol.add(Helper.correctNull(rs.getString("LOAN_INTTYPE")));//89  
						arrCol.add(Helper.correctNull(rs.getString("loan_baserate")));//90 
							      
							if(Helper.correctNull(rs.getString("fundtype")).equalsIgnoreCase("F"))
							{
								arrCol.add(Helper.correctNull(rs.getString("LOAN_INTRATE")));//91
								arrCol.add(Helper.correctNull(rs.getString("processdate")));//92
								arrCol.add("");//93
								arrCol.add("");//94
								arrCol.add("");//95
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_CRDT_FUNDBASED")));//96
								arrCol.add("");//97
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_AMT_DISBURSEDWC")));//98
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_FST_DISBWC")));//99
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_LST_DISBWC")));//100
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTSTD_FUND")));//101
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTFB_DT")));//102
								arrCol.add("");//103
								arrCol.add("");//1104
							}
							else
							{
								arrCol.add("");//91
								arrCol.add("");//92
								arrCol.add(Helper.correctNull(rs.getString("LOAN_INTRATE")));//93
								arrCol.add(Helper.correctNull(rs.getString("LOAN_INTCOM")));//94
								arrCol.add(Helper.correctNull(rs.getString("processdate")));//95
								arrCol.add("");//96
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_CRDT_NONFUNDBASED")));//97
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_AMT_DISBURSEDWC")));//98
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_FST_DISBWC")));//99
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_DT_LST_DISBWC")));//100
								arrCol.add("");//101
								arrCol.add("");//102
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTSTD_NONFUND")));//103
								arrCol.add(Helper.correctNull(rs.getString("TXNDET_OUTNFB_DT")));//104							
						}	
				    }
					
				    arrCol.add("");//105 Working Capital Enhancement Interest Type
				    arrCol.add("");//106 Working Capital Enhanced Fund Based Interest
				    arrCol.add("");//107 Working Capital Enhanced Non Fund Based Commission
				    arrCol.add("");//108 WCE Date of Enhancement
				    arrCol.add("");//109 WCE Spread over PLR
				    arrCol.add("");//110 WCE Whether Repayment in Equal Installments
				    arrCol.add("");//111 WCE Tangible Net Worth
				    arrCol.add("");//112 WCE Fixed Asset Coverage Ratio
				    arrCol.add("");//113 WCE Current Ratio
				    arrCol.add("");//114 WCE Minimum DSCR
				    arrCol.add("");//115 WCE Average DSCR
				    arrCol.add(""); //116 WCE Remarks
				    arrCol.add("");//117 WCR Interest Type
				    arrCol.add("");//118 WCR Renewal  Fund Based Interest
				    arrCol.add("");//119 WCR Renewal Non Fund Based Commission
				    arrCol.add("");//120 WCR Base Rate
				    arrCol.add("");//121 WCR Date of Renewal
				    arrCol.add("");//122 WCR Spread Over PLR
				    arrCol.add("");//123 WCR Whether Repayment in Equal Installments
				    arrCol.add("");//124 WCR Tangible Net Worth
				    arrCol.add("");//125 WCR Fixed Asset Coverage Ratio
				    arrCol.add("");//126 WCR Current Ratio
				    arrCol.add("");//127 WCR Minimum DSCR
				    arrCol.add("");//128 WCR Average DSCR
				    arrCol.add("");//129 WCR Remarks
				    arrCol.add("");//130 Is any of the Promoter management
				    arrCol.add("");//131 Credit bureau name
				    arrCol.add("");//132 Credit bureau name 2
				    arrCol.add("");//133 Credit bureau name 3
				    arrCol.add("");//134 Credit bureau name 4
				    arrCol.add("");//135 Credit bureau name 5
				    arrCol.add("");//136 CIBIL MSME Rank of the firm value between 1 and 10
				    arrCol.add(networth);//137 networth of the borrower
				    arrCol.add("");//138 Group Or associate entities of promoters have been into NPA category in past 1 year
				   arrCol.add(StrRowID8);//139
				    arrCol.add(StrRowID10);//140
				    arrCol.add(StrRowID12);//141
				    arrCol.add(StrRowID14);//142
				    arrCol.add(StrRowID16);//143
				    arrCol.add(StrRowID18);//144
				    arrCol.add("");//145 Credit bureau Score of key Promoter between 300 to 900
				    arrCol.add("");//146 Credit bureau Score of Promoter 2 between 300 to 900
				    arrCol.add("");//147 Credit bureau Score of Promoter 3 between 300 to 900
				    arrCol.add("");//148 Credit bureau Score of Promoter 4 between 300 to 900
				    arrCol.add("");//149 Credit bureau Score of Promoter 5 between 300 to 900
				    arrCol.add("");//150 Experian Commerical Score between 300 to 900
				    arrCol.add("");//151 Promotrs contribution in the entity in percentage
				    arrCol.add(Experience);//152
				    arrCol.add(StrRowID9);//153
				    arrCol.add(StrRowID11);//154
				    arrCol.add(StrRowID13);//155
				    arrCol.add(StrRowID15);//156
				    arrCol.add(StrRowID17);//157
				    arrCol.add("");//158 Guarantee Amount wise financial Record Unit
				    arrCol.add(StrRowID1);//159
				    arrCol.add(StrRowID3);//160
				    arrCol.add(StrRowID2);//161
				    arrCol.add(StrRowID6);//162
				    arrCol.add("");//163 Debt Equity Ratio for the unit
				    arrCol.add(StrRowID5);//164
				    arrCol.add(StrRowID4);//165
				    arrCol.add("");//166 Credit Bureau Personal Score Of Chief Promoters
				    arrCol.add("");//167 Debt Service Coverage Ratio
				    arrCol.add(StrRowID7);//168
		
					strHeader="CGTMSE Daily for the period of";
					arrRow.add(arrCol);	
					
				}
				
				StringBuffer strTemp=new StringBuffer();
				strTemp.append("Sl No,Type of Loan,Bank Institution Reference No,Bank Institution Branch Name,Bank Institution Branch Code," +
						"Bank Institution Branch  State,Whether Borrower previously Covered by CGTMSE,Borrower ID,CGPAN,Constitution,Borrower Unit Name," +
						"Unit Address,State,District,City,Pincode,ITPAN of Firm,Nature of Industry,Type of Activity,Industry Sector," +
						"Number of Employees,Whether the Unit is engaged in Training/Education/Agriculture,Projected Optimum Sales Turnover,Projected Optimum Exports,Promoter Title," +
						"Promoter First Name,Promoter Middle Name,Promoter Last Name,Gender,IT PAN of Chief Promoter,Whether the chief Promoter Belongs to Minority Community," +
						"Whether the Chief Promoter is Phisically Handicapped,Date of Birth,Social Category,Udyog Aadhar Number,Loan Account No,Working Capital LoanAccount No(In case of Both TL and WC),Non Fund Based Working Captial Account No,Promoter Adhar Card Number," +
						"Promoter Mobile Number,");
				
				if(multCACount>0)
				{
					for(int i=0;i<multCACount;i++)
					{
						strTemp.append("Name "+(i+1)+",IT PAN "+(i+1)+",DOB "+(i+1)+" ,");
					}
				}
                strTemp.append("Whether Unit assisted is a Greenfield (new) unit,Whether the Unit Assisted is Women Operated," +
						"Whether the credit facility is covered under NCGTC Mudra,Whether the Unit Assisted is an MSE as per the MSMED Act 2006,Whether the Unit Assisted is an Micro Enterprise as per the MSMED Act 2006," +
						"Whether first charge on Primary Securities is available,Collateral Security Taken,Third Party Guarantee,Whether the credit is sanctioned under Joint Finance scheme,Joint Cgpan," +
						"Whether the credit is sanctioned under Artisan Credit Card,Whether GF ASF is re-imbursable from office of DC,I Card Number,I Card Issue date,Whether the credit is sanctioned under DC scheme for Handlooms weavers," +
						"If Yes Please select the name of the Scheme," +
						"We certify that the credit facility being covered under CGTMSE,Internal rating,I/We confirm that the same is an investment grads rating of the bank as per Bank's Policy,Term Credit Sanctioned,TM Promoters Contribution," +
						"TM Subsidy Equity support,TM Others,Fund based,Non Fund Base,Whether provided as margin money under Term Loan,WC Promotors contribution,WC Subsidy Equity Support,WC Others," +
						"Loan Termination Date,Remarks,Date of Sanction,Credit to be Guaranteed,TC Amount Disbursed,TC Date of first disbursement if already made,TC Date of last and final disbursement if already made," +
						"Tenure,TC Interest Type,TC Base Rate,Interest rate,Moratorium,First Instalment Due Date,Periodicity,No of Instalements,Outstanding Amount Rs,Outstanding amount as on," +
						"WC Interest Type,WC Base Rate,Fund Based Intrest Rate,Fund Based Date of Sanction,Non Fund Based Intrest Rate,Non Fund Based Commission Rate," +
						"Non Fund Based Date of sanction,Credit to be guaranteed amount for Fund Based,Credit to be guaranteed amount for Non Fund,WC Amount Disbursed," +
						"WC Date of first disbursement if already made,WC Date of last and final disbursement if already made,Outstanding Amount Fund Based,Outstanding as on Date Fund Based," +
						"Outstanding Amount Non Fund Based,Outstanding as on Date Non Fund Based,Working Capital Enhancement Interest Type,Working Capital Enhanced Fund Based Interest,Working Capital Enhanced Non Fund Based Commission," +
				        "WCE Date of Enhancement,WCE Spread over PLR,WCE Whether Repayment in Equal Installments,WCE Tangible Net Worth,WCE Fixed Asset Coverage Ratio,WCE Current Ratio,WCE Minimum DSCR,WCE Average DSCR,WCE Remarks," +
				        "WCR Interest Type,WCR Renewal Fund Based Interest,WCR Renewal Non Fund Based Commission,WCR Base Rate,WCR Date of Renewal,WCR Spread Over PLR,WCR Whether Repayment in Equal Installments," +
				        "WCR Tangible Net Worth,WCR Fixed Asset Coverage Ratio,WCR Current Ratio,WCR Minimum DSCR,WCR Average DSCR,WCR Remarks,Is any of the Promoter management personnel in the CRILC Or CIBIL Or RBI list of defaulters,Credit bureau name," +
				        "Credit bureau name 2,Credit bureau name 3,Credit bureau name 4,Credit bureau name 5,CIBIL MSME Rank of the firm value between 1 and 10,Networth of the key Promoter Or borrower in Rs Lakhs,Group Or associate entities of promoters have been into NPA category in past 1 year," +
				        "Sales Or Revenue in Rs Lakhs,Interest Payment in Rs Lakhs,Total Current Assets in Rs Lakhs,Total term Liabilities in Rs Lakhs,Preference Capital in Rs Lakhs,Repayments due within an Year in Rs Lakhs,Credit bureau Score of key Promoter between 300 to 900," +
				        "Credit bureau Score of Promoter 2 between 300 to 900,Credit bureau Score of Promoter 3 between 300 to 900,Credit bureau Score of Promoter 4 between 300 to 900,Credit bureau Score of Promoter 5 between 300 to 900,Experian Commerical Score between 300 to 900," +
				        "Promotrs contribution in the entity in percentage,Promoters experience in current or related business in years,PBDIT or Profit before depreciation interest and tax in Rs Lakhs,Tax Amount as sum of Current and Provision in Rs Lakhs,Total current Liabilities in Rs Lakhs," +
				        "Equity Capital in Rs Lakhs,Reserves and Surplus in Rs Lakhs,Guarantee Amount wise financial Record Unit,Operating Income,Networth,Profit after Tax or PAT,Current Ratio of WC Accounts,Debt Equity Ratio for the unit,Debt Service Coverage Ratio of TL Account," +
				        "Debt Equity Ratio,Credit Bureau Personal Score Of Chief Promoters,Debt Service Coverage Ratio,Total Assets");
				strExcelField=strTemp.toString();
				
			hshRec.put("intPromocnt",String.valueOf(multCACount));
			}
			hshRec.put("labels",strExcelField);
			hshRec.put("arrRow", arrRow);
			hshRec.put("strFromDate",strFromDate);
			hshRec.put("strToDate",strToDate);
			hshRec.put("org_name",strOrg_Name);
			hshRec.put("reportType",reportType);
			hshRec.put("strHeader",strHeader);
			hshRec.put("intFundcnt",String.valueOf(intFundcnt));
			hshRec.put("intNonfundcnt",String.valueOf(intNonfundcnt));
		
			}

		
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRec;

	}

	private HashMap getCGTMSEExcelReport(HashMap hshValues) 
	{

		String strEnchancement=null,strOD=null;
		String reportType1="";
		int intRowCount=0,intCellCount=0;
		ArrayList arrCol=new ArrayList();
		try
		{
			hshValues=getCgtmseRunReport(hshValues);

			HSSFWorkbook wb = new HSSFWorkbook();
			wb.isWriteProtected();
			HSSFCellStyle borderstyleright = wb.createCellStyle();
			borderstyleright.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
			HSSFCellStyle borderstyleleft = wb.createCellStyle();
			borderstyleleft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
			arrCol=(ArrayList)hshValues.get("arrRow");

			HSSFFont boldfont2 = wb.createFont();
			boldfont2.setFontName("Verdana");
			boldfont2.setColor(HSSFFont.COLOR_NORMAL);
			boldfont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			borderstylecenter.setFont(boldfont2);

			HSSFCellStyle boldstyle= wb.createCellStyle();
			boldstyle.setBorderLeft(HSSFColor.AQUA.index);
			boldstyle.setBorderRight(HSSFColor.AQUA.index);
			boldstyle.setBorderBottom(HSSFColor.AQUA.index);
			boldstyle.setBorderTop(HSSFColor.AQUA.index);
			boldstyle.setFont(boldfont2);
			boldstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);


			HSSFCellStyle bldborcolstyle= wb.createCellStyle();
			bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
			bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
			bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
			bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
			bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);	    	
			bldborcolstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	    	
			bldborcolstyle.setWrapText(true);	    	
			bldborcolstyle.setFont(boldfont2);

			HSSFSheet sheet = null;
			HSSFRow row = null;
			HSSFCell cell = null;
			String reportType=Helper.correctNull((String)hshValues.get("reportType"));
			int intFcnt = Helper.parseInt((String)hshValues.get("intFundcnt"));
			int intNFcnt = Helper.parseInt((String)hshValues.get("intNonfundcnt"));
			int intPromocnt = Helper.parseInt((String)hshValues.get("intPromocnt"));

			if(reportType.equalsIgnoreCase("enchancement")){
				sheet = wb.createSheet("CGTMSE Enhancement Register");
			}
			else if(reportType.equalsIgnoreCase("od")){
				sheet = wb.createSheet("CGTMSE Reduction");
			}
			else if(reportType.equalsIgnoreCase("ca")){
				sheet = wb.createSheet("CGTMSE CA");
			}
			else if(reportType.equalsIgnoreCase("guarant_rep")){
				sheet = wb.createSheet("CGTMSE Guaranteed Report");
			} 
			else if(reportType.equalsIgnoreCase("register_rep")){
				sheet = wb.createSheet("CGTMSE Register Report");
			} 
			
			 

			String str_newline=Helper.correctNull((String)hshValues.get("labels"));
			//sheet.protectSheet("LAPS");
			String strHeadersSize[]=str_newline.split(",");

			intCellCount=0; 
			intRowCount++;
			row = sheet.createRow((short) intRowCount);

			for(int i=0;i<strHeadersSize.length;i++)
			{
				cell = row.createCell(intCellCount);
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(strHeadersSize[i]);
				cell.setCellStyle(bldborcolstyle);
				sheet.autoSizeColumn(intCellCount);
				intCellCount++;


			}

			String strPreviousVal = "",temp="";
			int rows_count = 0;
			int rows_count_actual = 1;
			int sno=1;
			boolean boolSameCust = true;
			int size=0;

			if(arrCol!=null && arrCol.size()>0)
			{
				for(int i=0;i<arrCol.size();i++)
				{
					intCellCount=0; 
					intRowCount++;
					row = sheet.createRow((short) intRowCount);
					ArrayList arrayData=(ArrayList)arrCol.get(i);

					//int intFcnt=10,intNFcnt=10;
					{
						for(int k=0;k<arrayData.size();k++){
							{
								String tempVal= "";
								if(!(k==40 && reportType.equalsIgnoreCase("ca")))
									tempVal=Helper.correctNull((String)arrayData.get(k));

								if (tempVal.equals(" "))
								{
									tempVal=" ";
								}	
								if((k==11||k==14) && reportType.equals("enchancement"))
								{

									int intTemp=0;
									if(k==11)
										intTemp=intFcnt;
									else
										intTemp=intNFcnt;	

									String[] strArr=((String)arrayData.get(k)).split("@");

									for(int a=0;a<strArr.length;a++)
									{
										String[] strArr1=strArr[a].split("~");
										if(strArr1!=null && strArr1.length>1)
										{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(strArr1[0]);
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(strArr1[1]);
											intCellCount++;
										}else{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

										}

									}

									for(int a=strArr.length;a<intTemp;a++)
									{
										cell = row.createCell(intCellCount);
										cell.setCellType(HSSFCell.CELL_TYPE_STRING);
										cell.setCellValue(" ");
										intCellCount++;

										cell = row.createCell(intCellCount);
										cell.setCellType(HSSFCell.CELL_TYPE_STRING);
										cell.setCellValue(" ");
										intCellCount++;
									}
								}

								else if((k==40) && reportType.equalsIgnoreCase("ca"))
								{
									ArrayList arr1=(ArrayList)arrayData.get(40);
									ArrayList arr2=(ArrayList)arrayData.get(41);
									ArrayList arr3=(ArrayList)arrayData.get(42);


									if(arr1!=null && arr1.size()>0)
									{
										for(int a=0;a<arr1.size();a++)
										{
											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr1.get(a));
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr2.get(a));
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue((String)arr3.get(a));
											intCellCount++;

										}

										if(intPromocnt>arr1.size())
										{
											for(int a=arr1.size();a<intPromocnt;a++)
											{

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

												cell = row.createCell(intCellCount);
												cell.setCellType(HSSFCell.CELL_TYPE_STRING);
												cell.setCellValue(" ");
												intCellCount++;

											}

										}
										k=k+2;
									}
									else
									{
										for(int a=0;a<intPromocnt;a++)
										{

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

											cell = row.createCell(intCellCount);
											cell.setCellType(HSSFCell.CELL_TYPE_STRING);
											cell.setCellValue(" ");
											intCellCount++;

										}
										k=k+2;
									}
								}


								else{
									cell = row.createCell(intCellCount);
									cell.setCellType(HSSFCell.CELL_TYPE_STRING);
									cell.setCellValue(tempVal);
									intCellCount++;
								}
							}



							File foldername = null;


							String path=ApplicationParams.getStrdoclocation()+"/e-Mandate/";
							foldername=new File(path);
							if(!foldername.exists())
							{
								foldername.mkdirs();
							}
							
						}
					}
				}
			}
			String strFileName="REPORTS3";
			FileOutputStream fOut = new FileOutputStream(strFileName);
			hshValues.put("FileDownLoad",strFileName);
			hshValues.put("strFinancialDn","emandate");

			wb.write(fOut);

			fOut.flush();
			fOut.close();
		}

		catch(Exception e)
		{
			throw new EJBException("inside getdata"+e.toString());
		}
		finally
		{
			try
			{
			}
			catch(Exception e)
			{
				throw new EJBException("close"+e.toString()); 
			}
		}
		return hshValues;


	}
	//added for new Data valuation Report//
	public HashMap getDataValuationReport(HashMap hshValues) 
	{
		ResultSet rs = null,rs1=null;
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol1=null;
		ArrayList arrRow1=new ArrayList();
		String strfrmdate="",strtodate="";
		HashMap hshRecord = new HashMap();
		HashMap hshRecord1 = new HashMap();
		String strQuery = null;
		String strDate=null;
		String strFromDate=null;
		String strToDate=null;
		String selLevel="",rpselect1="",strOrgName="",strOrgLevel="";
		String strGen="";
		
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		try
		{
			
			strGen =(String)hshValues.get("strUserId");
			StringBuffer strAppenQuery = new StringBuffer();
			selLevel = correctNull((String)hshValues.get("sellevel"));
			rpselect1 = correctNull((String)hshValues.get("org_name"));
			strDate = correctNull((String)hshValues.get("txtDate"));
			strOrgName = correctNull((String)hshValues.get("strOrgName"));
			strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
			String strOrgCode=correctNull((String)hshValues.get("strOrgCode"));
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				
			}	
			
			
			if(selLevel.equals("C"))
			{	
				strAppenQuery.append("and  o.org_code like '001%'");
				
			}
			else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
			{
				strAppenQuery.append("and o.org_code like '").append(strOrgCode.substring(0,6)).append("%'");
			}
			else if(selLevel.equals("D"))
			{
				strAppenQuery.append("and o.org_code like '").append(strOrgCode.substring(0,9)).append("%'");
			}
			else if(selLevel.equals("A"))
			{
				strAppenQuery.append("and o.org_code like '").append(strOrgCode.substring(0,12)).append("%'");
			}
			int i=0;
			strQuery = SQLParser.getSqlQuery("seldatavalreport^"+strAppenQuery.toString()+"^"+strFromDate+"^"+strToDate+"^"+strAppenQuery.toString()+"^"+strFromDate+"^"+strToDate);
			rs=DBUtils.executeQuery(strQuery); 
			while(rs.next())
			{
				i++;
				arrCol=new ArrayList();
				arrCol.add(String.valueOf(i));
				arrCol.add(Helper.correctNull(rs.getString("VALUER_NAME")));//0
				arrCol.add(Helper.correctNull(rs.getString("SECURITY_OWNER_CUSTOMER_ID")));//1
				arrCol.add(Helper.correctNull(rs.getString("SECURITY_OWNER_NAME")));//2
				arrCol.add(Helper.correctNull(rs.getString("SECURITY_CLASSIFICATION")));//3
				arrCol.add(Helper.correctNull(rs.getString("NET_SECURITY_VALUE")));//4
				arrCol.add(Helper.correctNull(rs.getString("BRANCH_NAME")));//5
				arrRow.add(arrCol);
			}
          		
			if(rs != null)
				rs.close();
			
			int j=0;
			strQuery = SQLParser.getSqlQuery("sel_datavalreportcount^"+strAppenQuery.toString()+"^"+strFromDate+"^"+strToDate+"^"+strAppenQuery.toString()+"^"+strFromDate+"^"+strToDate);
			rs=DBUtils.executeQuery(strQuery); 
			while(rs.next())
			{
				j++;
				arrCol1=new ArrayList();
				arrCol1.add(String.valueOf(i));
				arrCol1.add(Helper.correctNull(rs.getString("CUS_SEC_ID")));//0
				arrCol1.add(Helper.correctNull(rs.getString("VALUERS_NAME")));//1
				arrCol1.add(Helper.correctNull(rs.getString("ORG_SCODE")));//2
				arrCol1.add(Helper.correctNull(rs.getString("CUS_SEC_NETSECURITY")));//3
				//arrCol1.add(Helper.correctNull(rs.getString("NET_SECURITY_VALUE")));//4
				//arrCol1.add(Helper.correctNull(rs.getString("BRANCH_NAME")));//5
				arrRow1.add(arrCol1);
			}
          		
			strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
			rs= DBUtils.executeQuery(strQuery);
			
			if (rs.next())
			{
				strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
			}
			hshValues.put("arrRow",arrRow);
			hshValues.put("arrRow1",arrRow1);
			hshValues.put("branch_name",strOrgName);
			hshValues.put("strFromDate", strFromDate);
			hshValues.put("strToDate", strToDate);
			hshValues.put("genby", strGen);
			
		}
		catch(Exception ce)
		{
			System.out.println(ce.toString());
			throw new EJBException("Error in getDataValuationReport "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
}
	
	public HashMap getXLDataValuationReport(HashMap hshValues)  
	{
		HashMap hshtable = new HashMap();
		ResultSet rs=null;
		try {
			HSSFWorkbook wb = new HSSFWorkbook();
	    	 
			HSSFFont boldfont2 = wb.createFont();
			boldfont2.setFontName("Verdana");
			boldfont2.setColor(HSSFFont.COLOR_NORMAL);
			boldfont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

			HSSFCellStyle borderstylecenter = wb.createCellStyle();
			borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			borderstylecenter.setFont(boldfont2);

	    	 HSSFCellStyle boldstyle= wb.createCellStyle();
	 		boldstyle.setBorderLeft(HSSFColor.AQUA.index);
	 		boldstyle.setBorderRight(HSSFColor.AQUA.index);
	 		boldstyle.setBorderBottom(HSSFColor.AQUA.index);
	 		boldstyle.setBorderTop(HSSFColor.AQUA.index);
	 		boldstyle.setFont(boldfont2);
	 		boldstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

	    	 HSSFCellStyle bldborcolstyle= wb.createCellStyle();
	 		bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
	 		bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
	 		bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
	 		bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
	 		bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
	 		bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
	 		bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);	    	
	 		bldborcolstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	

	    	 hshtable=(HashMap)getDataValuationReport(hshValues);
	    	 
			 HSSFSheet sheet = wb.createSheet("DataValuationExcelReport");
	    	 HSSFRow row = null;
	    	 HSSFCell cell = null;
	    	 int rowno = 0,cellno=0,sno=1,first=1,records=0;
	    	 

		    				 row = sheet.createRow((short) rowno);
		    				 cellno=0;
		    				 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("S.No");
					    	 cell.setCellStyle(bldborcolstyle);//0
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);	 
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Valuer Name");
					    	 cell.setCellStyle(bldborcolstyle);//1
					    	 cellno++;
						
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Security Owner CustomerId");
					    	 cell.setCellStyle(bldborcolstyle);//2
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);	 
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Security OwnerName");
					    	 cell.setCellStyle(bldborcolstyle);//3
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Security Classification");
					    	 cell.setCellStyle(bldborcolstyle);//4
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);	 
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Net Security Value");
					    	 cell.setCellStyle(bldborcolstyle);//5
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("Branch Name");
					    	 cell.setCellStyle(bldborcolstyle);//6
					    	 cellno++;
					    	 
					    						    	 
					    	 rowno++;
			
	    			 ArrayList arrRow=new ArrayList();
					 ArrayList arrCol=new ArrayList();
					 arrRow=new ArrayList();
					 arrRow=(ArrayList)hshtable.get("arrRow");
	    			 if (arrRow!=null && arrRow.size() > 0)
	 				 {
	    				 for(int i=0;i<arrRow.size();i++)
	 					  {
	    					 arrCol = new ArrayList();
	    					 arrCol =(ArrayList)arrRow.get(i);
	    					 records++;
	    					 row = sheet.createRow((short) rowno);
	    					 cellno=0;
	    					 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
					    	 cell.setCellValue(String.valueOf(arrCol.get(0)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(1)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(2)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(3)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(4)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(5)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(6)));
					    	 cell.setCellStyle(boldstyle);
					    	 cellno++;
					    	 
					    	 rowno++;sno++;
						}
	    				 for(int j=1;j<=12;j++)
	    				 {
	    					 sheet.autoSizeColumn(j);	    					 
	    				 }
					
			}	 
					
	    	 else
						{
							 row = sheet.createRow((short) rowno);
							 cellno=0;
							 cell = row.createCell((short) cellno);
					    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					    	 cell.setCellValue("No data found");
					    	 cell.setCellStyle(boldstyle);
						}		
	    
//========================================add next sheet ================================//
	    			 HSSFSheet sheet1 = wb.createSheet("DataValuationExcelReport1");
	    			 HSSFRow row1 = null;
	    	    	 HSSFCell cell2 = null;
	    	    	 int rowno1 = 0,cellno1=0,sno1=1,first1=1,records1=0;


	    		    				 row1 = sheet1.createRow((short) rowno1);
	    		    				 cellno1=0;
	    		    				 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("S.No");
	    					    	 cell2.setCellStyle(bldborcolstyle);//0
	    					    	 cellno1++;
	    					    	 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("Customer Security Id");
	    					    	 cell2.setCellStyle(bldborcolstyle);//0
	    					    	 cellno1++;

	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("Valuer Name");
	    					    	 cell2.setCellStyle(bldborcolstyle);//0
	    					    	 cellno1++;

	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("org scode");
	    					    	 cell2.setCellStyle(bldborcolstyle);//0
	    					    	 cellno1++;

	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("Net Security");
	    					    	 cell2.setCellStyle(bldborcolstyle);//0
	    					    	 cellno1++;

	    					    	 
	    					    	 rowno1++;
	    			
	    					    	 ArrayList arrRow1=new ArrayList();
	    							 ArrayList arrCol1=new ArrayList();
	    							 arrRow=new ArrayList();
	    					 arrRow1=new ArrayList();
	    					 int k=1;
	    					 arrRow1=(ArrayList)hshtable.get("arrRow1");
	    	    			 if (arrRow1!=null && arrRow1.size() > 0)
	    	 				 {
	    	    				 for(int i=0;i<arrRow1.size();i++)
	    	 					  {
	    	    					
	    	    					 arrCol1 = new ArrayList();
	    	    					 arrCol1 =(ArrayList)arrRow1.get(i);
	    	    					 records1++;
	    	    					 row1 = sheet1.createRow((short) rowno1);
	    	    					 cellno1=0;
	    	    					 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    					    	 cell2.setCellValue(k++);
	    					    	 cell2.setCellStyle(boldstyle);
	    					    	 cellno1++;
	    					    	 
	    					    	 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    					    	 cell2.setCellValue(String.valueOf(arrCol1.get(1)));
	    					    	 cell2.setCellStyle(boldstyle);
	    					    	 cellno1++;
	    					    	 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    					    	 cell2.setCellValue(String.valueOf(arrCol1.get(2)));
	    					    	 cell2.setCellStyle(boldstyle);
	    					    	 cellno1++;
	    					    	 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    					    	 cell2.setCellValue(String.valueOf(arrCol1.get(3)));
	    					    	 cell2.setCellStyle(boldstyle);
	    					    	 cellno1++;
	    					    	 
	    					    	 cell2 = row1.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
	    					    	 cell2.setCellValue(String.valueOf(arrCol1.get(4)));
	    					    	 cell2.setCellStyle(boldstyle);
	    					    	 cellno1++;
	    					    	 
	    					    	 rowno1++;sno1++;
	    						}
	    	    				 for(int j=1;j<=12;j++)
	    	    				 {
	    	    					 sheet1.autoSizeColumn(j);	    					 
	    	    				 }
	    					
	    			}	 
	    					
	    	    	 else
	    						{
	    							 row1 = sheet1.createRow((short) rowno1);
	    							 cellno1=0;
	    							 cell2 = row.createCell((short) cellno1);
	    					    	 cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
	    					    	 cell2.setCellValue("No data found");
	    					    	 cell2.setCellStyle(boldstyle);
	    						}		
						/*File Directory=null;

						String strPath="C:/Report";
						Directory =new File(strPath);
						if (!Directory.exists())
						{
								Directory.mkdirs();
						}
						
				    String strFileName=strPath+"/DataValuationExcelReport.xls";
					FileOutputStream fOut = new FileOutputStream(strFileName);
				 	String strmsg="";
				 	strmsg="Data Valuation  Report Format is Successfully exported to Excel!";

				 	hshtable.put("msg",strmsg);
				 	hshtable.put("FileDownload",strFileName);
			 		
				 	wb.write(fOut);
				 	fOut.flush();
				 	fOut.close();*/
	    			 File foldername = null;


						String path=ApplicationParams.getStrdoclocation()+"/e-Mandate/";
						foldername=new File(path);
						if(!foldername.exists())
						{
							foldername.mkdirs();
						}
						String strFileName="REPORTS3";
						FileOutputStream fOut = new FileOutputStream(strFileName);
						hshValues.put("FileDownLoad",strFileName);
						hshValues.put("strFinancialDn","emandate");

						wb.write(fOut);

						fOut.flush();
						fOut.close();
			 } 
		 
		catch (Exception e)
		{
			throw new EJBException("inside getdata" + e.toString());
		}
		finally 
		{
			try 
			{
				//vecT=null;
				if (rs != null) 
				rs.close();

			} catch (Exception e) 
			{
				throw new EJBException("close" + e.toString());
			}
		}
		return hshtable;
	}


private HashMap getOnlineReportAnnexure1(HashMap hshValues) 
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
	
	
	try
	{
		strGen =(String)hshValues.get("strUserId");
		StringBuffer strAppenQuery = new StringBuffer();
		selLevel = correctNull((String)hshValues.get("sellevel"));
		rpselect1 = correctNull((String)hshValues.get("org_name"));
		strDate = correctNull((String)hshValues.get("txtDate"));
		strOrgName = correctNull((String)hshValues.get("strOrgName"));
		strOrgLevel = correctNull((String)hshValues.get("strOrgLevel"));
		if(!strDate.equals("All"))
		{
			strFromDate = strDate.substring(0,strDate.indexOf("-"));
			strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
			
		}	
		
		
		if(selLevel.equals("C"))
		{	
			strAppenQuery.append("and  o1.org_code like '001%'");
			
		}
		else if(selLevel.equalsIgnoreCase("R")||selLevel.equalsIgnoreCase("CPC"))
		{
			strAppenQuery.append("and o1.org_code like ").append(rpselect1.substring(0,6)).append("%'");
		}
		else if(selLevel.equals("D"))
		{
			strAppenQuery.append("and o1.org_code like ").append(rpselect1.substring(0,9)).append("%'");
		}
		else if(selLevel.equals("A"))
		{
			strAppenQuery.append("and o1.org_code like ").append(rpselect1.substring(0,12)).append("%'");
		}
		
		
		strQuery =SQLParser.getSqlQuery("selonlinerepannexure1^"+strAppenQuery.toString()+"^"+strFromDate+"^"+strToDate);
		
		if(rs != null)
			rs.close();
		rs=DBUtils.executeQuery(strQuery);
		while (rs.next())
		{
			
			arrCol = new ArrayList();
			arrCol.add(correctNull(rs.getString("org_scode")));//0
			arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
			arrCol.add(correctNull(rs.getString("regorgcode")));//2
			arrCol.add(correctNull(rs.getString("regorgname")));//3
			arrCol.add(correctNull(rs.getString("INWARD_CUSTNAME")));//4
			arrCol.add(correctNull(rs.getString("INWARD_NO")));//5
			arrCol.add(correctNull(rs.getString("createddate")));//6
			arrCol.add(correctNull(rs.getString("INWARD_PURPOSE")));//7
			arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt")))+Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt")))));//8
			arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt")))));//9
			arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("fundbasedamt")))));//10
			arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("nonfundbasedamt")))));//11
			arrCol.add(correctNull(rs.getString("uploadeddate")));//12
			arrCol.add(correctNull(rs.getString("app_no")));//13
			if(correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
			{
				arrCol.add(correctNull(rs.getString("processdate")));//14
				arrCol.add(" ");//15
			}else if(correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
			{
				arrCol.add(" ");//14
				arrCol.add(correctNull(rs.getString("processdate")));//15
			}else
			{
				arrCol.add(" ");//14
				arrCol.add(" ");//15
			}
			arrCol.add(correctNull(rs.getString("district_desc")));//16
			arrCol.add(correctNull(rs.getString("state_name")));//17
			arrCol.add(" ");//18
			arrCol.add(" ");//19
			arrCol.add(correctNull(rs.getString("status")));//20
			arrRow.add(arrCol);
			
		}
		if(rs != null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
		rs= DBUtils.executeQuery(strQuery);
		
		if (rs.next())
		{
			strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
		}
		hshRecord.put("arrRow",arrRow);
		hshRecord.put("branch_name",strOrgName);
		hshRecord.put("strFromDate", strFromDate);
		hshRecord.put("strToDate", strToDate);
		hshRecord.put("genby", strGen);
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getOnlineReportAnnexure1 ======= "+e.toString());
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
	return hshRecord;
}

public HashMap getXLCreditSaleReport(HashMap hshValues)  
{
	HashMap hshtable = new HashMap();
	ResultSet rs=null;
	try {
		HSSFWorkbook wb = new HSSFWorkbook();
    	 
		HSSFFont boldfont2 = wb.createFont();
		boldfont2.setFontName("Verdana");
		boldfont2.setColor(HSSFFont.COLOR_NORMAL);
		boldfont2.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

		HSSFCellStyle borderstylecenter = wb.createCellStyle();
		borderstylecenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		borderstylecenter.setFont(boldfont2);

		HSSFCellStyle boldstyle= wb.createCellStyle();
		boldstyle.setBorderLeft(HSSFColor.AQUA.index);
		boldstyle.setBorderRight(HSSFColor.AQUA.index);
		boldstyle.setBorderBottom(HSSFColor.AQUA.index);
		boldstyle.setBorderTop(HSSFColor.AQUA.index);
		boldstyle.setFont(boldfont2);
		boldstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);


		HSSFCellStyle bldborcolstyle= wb.createCellStyle();
		bldborcolstyle.setFillPattern(HSSFCellStyle.ALIGN_FILL);
		bldborcolstyle.setFillBackgroundColor(HSSFColor.PALE_BLUE.index);
		bldborcolstyle.setBorderLeft(HSSFColor.AQUA.index);
		bldborcolstyle.setBorderRight(HSSFColor.AQUA.index);
		bldborcolstyle.setBorderBottom(HSSFColor.AQUA.index);
		bldborcolstyle.setBorderTop(HSSFColor.AQUA.index);
		bldborcolstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);	    	
		bldborcolstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	

		 hshtable=(HashMap)getCreditSaleReport(hshValues);
    	 
		 HSSFSheet sheet = wb.createSheet("CreditSaleExcelReport");
    	 HSSFRow row = null;
    	 HSSFCell cell = null;
    	 int rowno = 0,cellno=0,sno=1,first=1,records=0;
    	 

	    				 row = sheet.createRow((short) rowno);
	    				 cellno=0;
	    				 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("S.No");
				    	 cell.setCellStyle(bldborcolstyle);//0
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Disbursed Branch Code");
				    	 cell.setCellStyle(bldborcolstyle);//1
				    	 cellno++;
					
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Disbursed Branch Name");
				    	 cell.setCellStyle(bldborcolstyle);//2
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Regional Office Name");
				    	 cell.setCellStyle(bldborcolstyle);//3
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Customer ID");
				    	 cell.setCellStyle(bldborcolstyle);//4
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Customer Name");
				    	 cell.setCellStyle(bldborcolstyle);//5
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Sanctioned Amount");
				    	 cell.setCellStyle(bldborcolstyle);//6
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Sanctioned On");
				    	 cell.setCellStyle(bldborcolstyle);//7
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Scheme Name");
				    	 cell.setCellStyle(bldborcolstyle);//8
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("LAR Number");
				    	 cell.setCellStyle(bldborcolstyle);//9
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Sanction Reference Number");
				    	 cell.setCellStyle(bldborcolstyle);//10
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Digi Application Number");
				    	 cell.setCellStyle(bldborcolstyle);//11
				    	 cellno++;	
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Eligible Under DIGI");
				    	 cell.setCellStyle(bldborcolstyle);//12
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);	 
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Reasons");
				    	 cell.setCellStyle(bldborcolstyle);//13
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Brief Description");
				    	 cell.setCellStyle(bldborcolstyle);//14
				    	 cellno++;	
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("Comments");
				    	 cell.setCellStyle(bldborcolstyle);//15
				    	 
				    	 rowno++;
		
    			 ArrayList arrRow=new ArrayList();
				 ArrayList arrCol=new ArrayList();
				arrRow=new ArrayList();
				 arrRow=(ArrayList)hshtable.get("arrRow");
    			 if (arrRow!=null && arrRow.size() > 0)
 				 {
    				 for(int i=0;i<arrRow.size();i++)
 					  {
    					 arrCol = new ArrayList();
    					 arrCol =(ArrayList)arrRow.get(i);
    					 records++;
    					 row = sheet.createRow((short) rowno);
    					 cellno=0;
    					 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
				    	 cell.setCellValue(String.valueOf(arrCol.get(0)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(1)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(2)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(3)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(4)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(5)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(6)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(7)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(8)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(9)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(10)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(11)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(12)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(14)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(13)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue(Helper.correctNull((String)arrCol.get(16)));
				    	 cell.setCellStyle(boldstyle);
				    	 cellno++;
				    	 
				    	 rowno++;sno++;
					}
    				  for(int j=1;j<=12;j++)
    				 {
    					 sheet.autoSizeColumn(j);	    					 
    				 }
				
		}	 
				
    	 else
					{
						 row = sheet.createRow((short) rowno);
						 cellno=0;
						 cell = row.createCell((short) cellno);
				    	 cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				    	 cell.setCellValue("No data found");
				    	 cell.setCellStyle(bldborcolstyle);
					}		
    
    			 File foldername = null;


					String path=ApplicationParams.getStrdoclocation()+"/e-Mandate/";
					foldername=new File(path);
					if(!foldername.exists())
					{
						foldername.mkdirs();
					}
					String strFileName="REPORTS3";
					FileOutputStream fOut = new FileOutputStream(strFileName);
					hshValues.put("FileDownLoad",strFileName);
					hshValues.put("strFinancialDn","emandate");

					wb.write(fOut);

					fOut.flush();
					fOut.close();
		 } 
	 
	catch (Exception e)
	{
		throw new EJBException("inside getdata" + e.toString());
	}
	finally 
	{
		try 
		{
			//vecT=null;
			if (rs != null) 
			rs.close();

		} catch (Exception e) 
		{
			throw new EJBException("close" + e.toString());
		}
	}
	return hshtable;
}
private HashMap getDCOEReport(HashMap hshValues) {
	HashMap hshtable = new HashMap();
	ResultSet rs=null;
	HashMap hshRecord=new HashMap();
	String strQuery=null,strQuery1=null;
	String strDate=null;
	String strFromDate="", strToDate="";
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strGen="";
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setGroupingUsed(false);
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	ResultSet rs1 = null;

	
	try
	{
		strGen =(String)hshValues.get("strUserId");
		strFromDate = correctNull((String)hshValues.get("txtFromDate"));
		strToDate = correctNull((String)hshValues.get("txtToDate"));
		
		int i=0;
		strQuery =SQLParser.getSqlQuery("sel_dcoereport^"+strFromDate+"^"+strToDate);
		
		if(rs != null)
			rs.close();
		String streligdigi="",strreason="";
		rs=DBUtils.executeQuery(strQuery);
		while (rs.next())
		{
			i++;
			arrCol = new ArrayList();
			arrCol.add(String.valueOf(i));
			arrCol.add(correctNull(rs.getString("LOANDISBBRANCH")));//0
			arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
			arrCol.add(correctNull(rs.getString("REGIONALOFFICE")));//2
			arrCol.add(correctNull(rs.getString("CBSID")));//3
			arrCol.add(correctNull(rs.getString("CUSTOMOERNAME")));//4
			arrCol.add(correctNull(rs.getString("SANCTIONAMOUNT")));//5
			arrCol.add(correctNull(rs.getString("SANCTIONDATE")));//6
			arrCol.add(correctNull(rs.getString("SCHEME")));//7
			arrCol.add(correctNull(rs.getString("INWARDNO")));//8
			arrCol.add(correctNull(rs.getString("SANCTIONREFNO")));//9
			arrCol.add(correctNull(rs.getString("DIGIAPPNO")));//10
			arrCol.add(correctNull(rs.getString("ELIGDIGI")));//11
			arrCol.add(correctNull(rs.getString("BREIFDISCRIPTION")));//13
			streligdigi=correctNull(rs.getString("ELIGDIGI"));
			strreason=correctNull(rs.getString("REASON"));//12

			if(streligdigi.equalsIgnoreCase("Yes") && !strreason.equalsIgnoreCase("")){
					strQuery=SQLParser.getSqlQuery("selCreditSaleReason^245^"+strreason);
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{				
						arrCol.add(correctNull(rs1.getString("STAT_DATA_DESC1")));//9

					}
				}
				
			else if(streligdigi.equalsIgnoreCase("No") && !strreason.equalsIgnoreCase("")){
					strQuery=SQLParser.getSqlQuery("selCreditSaleReason^246^"+strreason);
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{				
						arrCol.add(correctNull(rs1.getString("STAT_DATA_DESC1")));//12
					}
				}
			else{
				arrCol.add("");//12

			}
			arrCol.add(correctNull(rs.getString("REASON")));//14
			arrRow.add(arrCol);
			
		}
		
		strQuery =SQLParser.getSqlQuery("sel_dcoereport_digi^"+strFromDate+"^"+strToDate);
		
		if(rs != null)
			rs.close();
		rs=DBUtils.executeQuery(strQuery);
		while (rs.next())
		{

			i++;
			arrCol = new ArrayList();
			arrCol.add(String.valueOf(i));
			arrCol.add(correctNull(rs.getString("LOANDISBBRANCH")));//0
			arrCol.add(correctNull(rs.getString("ORG_NAME")));//1
			arrCol.add(correctNull(rs.getString("REGIONALOFFICE")));//2
			arrCol.add(correctNull(rs.getString("CBSID")));//3
			arrCol.add(correctNull(rs.getString("CUSTOMOERNAME")));//4
			arrCol.add(correctNull(rs.getString("SANCTIONAMOUNT")));//5
			arrCol.add(correctNull(rs.getString("SANCTIONDATE")));//6
			arrCol.add(correctNull(rs.getString("SCHEME")));//7
			arrCol.add(correctNull(rs.getString("INWARDNO")));//8
			arrCol.add(correctNull(rs.getString("SANCTIONREFNO")));//9
			arrCol.add("");//10
			arrCol.add("");//11
			arrCol.add("");//13
			arrCol.add("");//14
			
			
			arrRow.add(arrCol);
			
		
		}
		if(rs != null)
			rs.close();
		strQuery = SQLParser.getSqlQuery("selusername^"+strGen);		
		rs= DBUtils.executeQuery(strQuery);
		
		if (rs.next())
		{
			strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
		}
		hshValues.put("arrRow",arrRow);
		hshValues.put("strFromDate", strFromDate);
		hshValues.put("strToDate", strToDate);
		hshValues.put("genby", strGen);
	}

catch (Exception e)
{
	throw new EJBException("inside getdata" + e.toString());
}
finally 
{
	try 
	{
		//vecT=null;
		if (rs != null) 
		rs.close();

	} catch (Exception e) 
	{
		throw new EJBException("close" + e.toString());
	}
}
return hshValues;
	
}

}