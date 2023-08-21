/******************************************************************************
 * Package:			com.sai.laps.ejb.perrepapptrack
 * File:			PerRepAppTrackBean.java
 * Description:		Bean Implementation Class for Personal Application 	 Tracking Report
 * @author			R.Saraswathi 
 ******************************************************************************/

package com.sai.laps.ejb.perrepapptrack;


import java.io.File;
import java.io.FileOutputStream;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "PerRepAppTrackBean", mappedName = "PerRepAppTrackHome")
@Remote (PerRepAppTrackRemote.class)
public class PerRepAppTrackBean extends BeanAdapter
{
	
	static Logger log=Logger.getLogger(PerRepAppTrackBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public HashMap getData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strMethod ="";

		try
		{
			strMethod=(String)hshValues.get("hidMethod");

			if (strMethod.equalsIgnoreCase("getRepDetails"))
			{
				hshRecord =(HashMap)getRepDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getRepDetails1"))
			{
				hshRecord =(HashMap)getRepDetails1(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getRepDetails2"))
			{
				hshRecord =(HashMap)getRepDetails2(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getParamList1"))
			{
				hshRecord =(HashMap)getParamList1(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList2"))
			{
				hshRecord =(HashMap)getParamList2(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList3"))
			{
				hshRecord =(HashMap)getParamList3(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getUserClassDetails"))
			{
				hshRecord =(HashMap)getUserClassDetails(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getUserClass"))
			{
				hshRecord =(HashMap)getUserClass(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getUsers"))
			{
				hshRecord =(HashMap)getUserId(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("showProfile"))
			{
				hshRecord =(HashMap)showProfile(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getParamList"))
			{
				hshRecord =(HashMap)getParamList(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getAppno"))
			{
				hshRecord =(HashMap)getAppno(hshValues);
			} 
			
			else if (strMethod.equalsIgnoreCase("getUserDetails"))
			{
				hshRecord =(HashMap)getUserDetails(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getUserDetails1"))
			{
				hshRecord =(HashMap)getUserDetails1(hshValues);
			} 
			else if (strMethod.equalsIgnoreCase("getUserCount"))
			{
				hshRecord =(HashMap)getUserCount(hshValues);
			} 
			
			else if(strMethod.equalsIgnoreCase("getBuilderReport"))
			{
				hshRecord=(HashMap)getBuilderReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getProposalReport"))
			{
				hshRecord=(HashMap)getProposalReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getUserProposalReport"))
			{
				hshRecord=(HashMap)getUserProposalReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getadhocreport"))
			{
				hshRecord =(HashMap)getAdhocReport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getinterestreport"))
			{
				hshRecord =(HashMap)getinterestreport(hshValues);
			}
			else if (strMethod.equalsIgnoreCase("getspreadreport"))
			{
				hshRecord =(HashMap)getspreadreport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getSpreadSheetTwoExcel"))
			{
				hshRecord = (HashMap)getSpreadSheetTwoExcel(hshValues);
			}
			
			
			/*else if(strMethod.equalsIgnoreCase("getBuilderReport"))
			{
				hshRecord=(HashMap)getBuilderReport(hshValues);
			}
			else if(strMethod.equalsIgnoreCase("getAppRepCount"))
			{
				hshRecord=(HashMap)getAppRepCount(hshValues);
			}*/
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdata "+ce.toString());
		}
		
		return hshRecord;

	}

	private HashMap getinterestreport(HashMap hshValues) {
		
		ResultSet rs = null;
		HashMap hshRec=null;
		ArrayList arrCol =null;
		String strTemp=null;
		ArrayList arrRow =null;
		String strSelFields="";
		ArrayList arrVAlues = new ArrayList();
		String strFromDate=correctNull((String)hshValues.get("txtFromDate"));
		String strToDate=correctNull((String)hshValues.get("txtToDate"));
		
		try{
			strSelFields="PRODUCT CODE,PRODUCT INTEREST CODE,PRODUCT PURPOSE,PRODUCT DESCRIPTION,PRODUCT TYPE,PRODUCT RANGE FROM,PRODUCT RANGE TO,PRODUCT LOAN TYPE,SCHEME CODE,BANK SCHEME,ROI REFERENCE TYPES,INTEREST TYPE" +
					",INT RANGE FROM,INT RANGE TO,ROI TYPE,INT TENOR FROM,INT TENOR TO,REFERENCE TYPE,INT SCORE FROM,INT SCORE TO,CREDIT RISK PREMIUM,BUSINESS STRATEGIC PREMIUM" +
					",RATING CODES,SECTOR,MODIFICATION,MODULE,EXCEL SNO,UPLOADED DATE,EXCEL UPLOADEDBY,EXECUTIONDATE,EXECUTION NO,SNO,CIRCULAR REFNO";
			
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				arrVAlues.add(st.nextToken());
			}
			if(rs != null)
				rs.close();
			hshRec = new HashMap();
			arrCol = new ArrayList();
			
			rs=DBUtils.executeLAPSQuery("sel_inteestReport^"+strFromDate +"^"+strToDate);

			while (rs.next())
			{	
				arrRow = new ArrayList();
				if(arrVAlues.contains("PRODUCT CODE"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_CODE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT INTEREST CODE"))
				{
					strTemp =correctNull(rs.getString("PRDINTEREST_ID"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT PURPOSE"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_PURPOSE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT DESCRIPTION"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_DESCRIPTION"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT TYPE"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_TYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT RANGE FROM"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_RANGE_FROM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT RANGE TO"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_RANGE_TO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT LOAN TYPE"))
				{
					strTemp =correctNull(rs.getString("PRODUCT_LOAN_TYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SCHEME CODE"))
				{
					strTemp =correctNull(rs.getString("SCHEME_CODE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("BANK SCHEME"))
				{
					strTemp =correctNull(rs.getString("BANK_SCHEME"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("ROI REFERENCE TYPES"))
				{
					strTemp =correctNull(rs.getString("ROI_REFERENCE_TYPES"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INTEREST TYPE"))
				{
					strTemp =correctNull(rs.getString("INTEREST_TYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT RANGE FROM"))
				{
					strTemp =correctNull(rs.getString("INT_RANGE_FROM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT RANGE TO"))
				{
					strTemp =correctNull(rs.getString("INT_RANGE_TO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("ROI TYPE"))
				{
					strTemp =correctNull(rs.getString("ROI_TYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT TENOR FROM"))
				{
					strTemp =correctNull(rs.getString("INT_TENOR_FROM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT TENOR TO"))
				{
					strTemp =correctNull(rs.getString("INT_TENOR_TO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("REFERENCE TYPE"))
				{
					strTemp =correctNull(rs.getString("REFERENCE_TYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT SCORE FROM"))
				{
					strTemp =correctNull(rs.getString("INT_SCORE_FROM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INT SCORE TO"))
				{
					strTemp =correctNull(rs.getString("INT_SCORE_TO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("CREDIT RISK PREMIUM"))
				{
					strTemp =correctNull(rs.getString("CREDIT_RISK_PREMIUM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("BUSINESS STRATEGIC PREMIUM"))
				{
					strTemp =correctNull(rs.getString("BUSINESS_STRATEGIC_PREMIUM"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("RATING CODES"))
				{
					strTemp =correctNull(rs.getString("RATING_CODES"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SECTOR"))
				{
					strTemp =correctNull(rs.getString("SECTOR"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("MODIFICATION"))
				{
					strTemp =correctNull(rs.getString("MODIFICATION"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("MODULE"))
				{
					strTemp =correctNull(rs.getString("MODULE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRD UPDATE FLAG"))
				{
					strTemp =correctNull(rs.getString("PRD_UPDATE_FLAG"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXCEL SNO"))
				{
					strTemp =correctNull(rs.getString("EXCEL_SNO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("UPLOADED DATE"))
				{
					strTemp =correctNull(rs.getString("UPLOADED_DATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXCEL UPLOADEDBY"))
				{
					strTemp =correctNull(rs.getString("EXCEL_UPLOADEDBY"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXECUTIONDATE"))
				{
					strTemp =correctNull(rs.getString("EXECUTIONDATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXECUTION NO"))
				{
					strTemp =correctNull(rs.getString("EXECUTION_NO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SNO"))
				{
					strTemp =correctNull(rs.getString("SNO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("CIRCULAR REFNO"))
				{
					strTemp =correctNull(rs.getString("CIRCULAR_REFNO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				arrCol.add(arrRow);
				
			}
			hshRec.put("vecValues",arrCol);
			hshRec.put("labels",strSelFields);
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
private HashMap getspreadreport(HashMap hshValues) {
		
		ResultSet rs = null;
		HashMap hshRec=null;
		ArrayList arrCol =null;
		String strTemp=null;
		ArrayList arrRow =null;
		String strSelFields="";
		ArrayList arrVAlues = new ArrayList();
		String strFromDate=correctNull((String)hshValues.get("txtFromDate"));
		String strToDate=correctNull((String)hshValues.get("txtToDate"));
		
		try{
			strSelFields="APPLICATION NO,APPLICATION SNO,PRODUCT CODE,AMOUNT REQUEST,AMOUNT RECOMMENDED,TENOR,INTEREST TYPE,DEF INTEREST RATE,MOD INTEREST RATE" +
					",MCLR TYPE,REFERENCE SPREAD,CREDIT RISK VALUE,BUSINESS RISK VALUE,ROI TYPE,ROI SCORE,SETUP CORP,SETUP BSP,EXECUTION NO,EXECUTION DATE,EXECUTION FLAG,CREDIT RISK VALUE AFTER,BUSINESS RISK VALUE AFTER,SETUP CORP AFTER,SETUP BSP AFTER" +
					",DEF INTEREST RATE AFTER,MOD INTEREST RATE AFTER,DEVIATION OLD VALUE,DEVIATION NEW VALUE,DEVIATION OLD VALUE AFTER,DEVIATION NEW VALUE AFTER,UPDATE DATE";
			
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				arrVAlues.add(st.nextToken());
			}
			if(rs != null)
				rs.close();
			hshRec = new HashMap();
			arrCol = new ArrayList();
			
			rs=DBUtils.executeLAPSQuery("sel_appspreadReport^"+strFromDate +"^"+strToDate);

			while (rs.next())
			{	
				arrRow = new ArrayList();
				if(arrVAlues.contains("APPLICATION NO"))
				{
					strTemp =correctNull(rs.getString("APP_NO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("APPLICATION SNO"))
				{
					strTemp =correctNull(rs.getString("APP_SNO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("PRODUCT CODE"))
				{
					strTemp =correctNull(rs.getString("APP_PRDCODE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("AMOUNT REQUEST"))
				{
					strTemp =correctNull(rs.getString("APP_AMTREQ"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("AMOUNT RECOMMENDED"))
				{
					strTemp =correctNull(rs.getString("APP_AMTRECMD"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("TENOR"))
				{
					strTemp =correctNull(rs.getString("APP_APPTENOR"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("INTEREST TYPE"))
				{
					strTemp =correctNull(rs.getString("APP_INTTYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEF INTEREST RATE"))
				{
					strTemp =correctNull(rs.getString("APP_DEFINTRATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("MOD INTEREST RATE"))
				{
					strTemp =correctNull(rs.getString("APP_MODINTRATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("MCLR TYPE"))
				{
					strTemp =correctNull(rs.getString("APP_MCLRTYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("REFERENCE SPREAD"))
				{
					strTemp =correctNull(rs.getString("APP_REFERENCESPREAD"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("CREDIT RISK VALUE"))
				{
					strTemp =correctNull(rs.getString("APP_CREDITRSKVAL"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("BUSINESS RISK VALUE"))
				{
					strTemp =correctNull(rs.getString("APP_BUSINESSRSKVAL"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("ROI TYPE"))
				{
					strTemp =correctNull(rs.getString("APP_ROITYPE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("ROI SCORE"))
				{
					strTemp =correctNull(rs.getString("APP_ROISCORE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SETUP CORP"))
				{
					strTemp =correctNull(rs.getString("APP_SETUPCRP"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SETUP BSP"))
				{
					strTemp =correctNull(rs.getString("APP_SETUPBSP"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXECUTION NO"))
				{
					strTemp =correctNull(rs.getString("APP_EXECUTIONNO"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXECUTION DATE"))
				{
					strTemp =correctNull(rs.getString("APP_EXEDATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("EXECUTION FLAG"))
				{
					strTemp =correctNull(rs.getString("APP_EXEFLAG"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("CREDIT RISK VALUE AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_CREDITRSKVAL_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("BUSINESS RISK VALUE AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_BUSINESSRSKVAL_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SETUP CORP AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_SETUPCRP_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("SETUP BSP AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_SETUPBSP_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEF INTEREST RATE AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_DEFINTRATE_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("MOD INTEREST RATE AFTER"))
				{
					strTemp =correctNull(rs.getString("APP_MODINTRATE_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEVIATION OLD VALUE"))
				{
					strTemp =correctNull(rs.getString("DEVIATION_OLDVALUE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEVIATION NEW VALUE"))
				{
					strTemp =correctNull(rs.getString("DEVIATION_NEWVALUE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEVIATION OLD VALUE AFTER"))
				{
					strTemp =correctNull(rs.getString("DEVIATION_OLDVALUE_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("DEVIATION NEW VALUE AFTER"))
				{
					strTemp =correctNull(rs.getString("DEVIATION_NEWVALUE_AFTER"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				if(arrVAlues.contains("UPDATE DATE"))
				{
					strTemp =correctNull(rs.getString("APP_UPDATEDATE"));
					arrRow.add(strTemp);  
					arrRow.add("left");
				}
				arrCol.add(arrRow);
				
			}
			hshRec.put("vecValues",arrCol);
			hshRec.put("labels",strSelFields);
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

	private HashMap getRepDetails(HashMap hshRequestValues) 
	{
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strQuery=null;
		String strOrgCode = null;
		String strSelFields=null;
		String strAppno = null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strOrgName = "";
		String strDate=null;
		String strGen=null;
		String strStat="";
		String strToDate=null;
		String strFromDate=null;
		String strQ=" ";
		
		try
		{
			strDate =(String)hshRequestValues.get("txtDate");
			if(strDate.equalsIgnoreCase(""))
			{
				strDate="All";
			}
			strStat =(String)hshRequestValues.get("hidStatus");
            strGen =(String)hshRequestValues.get("strUserId");
			strOrgCode =(String)hshRequestValues.get("hidOrgCode");
			strAppno =(String)hshRequestValues.get("hidOpFields");
			strSelFields="Application Number,Applicant Name,Applied Date,Amount,Organisation,Application Status,Product Name,Approval/Rejection Date,Approved/Rejected By";
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
			
			strQuery = SQLParser.getSqlQuery("selperappusertrack4^"+strOrgCode+"^"+strAppno);
			
			
			if(!strDate.equals("All"))
			{
				strFromDate = strDate.substring(0,strDate.indexOf("-"));
				strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
				strQuery = strQuery + strQ;
			}			
			if (strStat.equalsIgnoreCase("R"))
			{
				strQuery = strQuery + "and  upper(app_status) = 'PR' " ;
			}		
			else if (strStat.equalsIgnoreCase("A"))
			{
				strQuery = strQuery + "and  upper(app_status) ='PA'" ;
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strQuery = strQuery + "and  upper(app_status) ='OP'" ;
			}
			if(rs != null)
				rs.close();

			
			rs=DBUtils.executeQuery(strQuery);
			hshRec = new HashMap();
			vecVal = new ArrayList();
			while (rs.next())
			{
				vecRecords = new ArrayList();
				strStat =correctNull(rs.getString("app_status"));
				if (vecT.contains("Application Number"))
				{
					strTemp =correctNull(rs.getString("app_no"));
					if (strTemp.equals(strOrgName))
					{
						vecRecords.add("&nbsp;");
					}
					else
					{
						vecRecords.add(strTemp);
					}
					vecRecords.add("left");
					strOrgName=strTemp;
										
				}
				if (vecT.contains("Applicant Name"))
				{
					strTemp =correctNull(rs.getString("perapp_fname"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
				}
				if (vecT.contains("Applied Date"))
				{
					strTemp =correctNull(rs.getString("app_date"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Amount"))
				{
					strTemp =correctNull(rs.getString("loan_recmdamt"));
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				if (vecT.contains("Organisation"))
				{
					strTemp =correctNull(rs.getString("org_name"));
					vecRecords.add(strTemp);
					vecRecords.add("left");
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
				if (vecT.contains("Approved/Rejected By"))
				{
					strTemp =correctNull(rs.getString("app_approvedby"));
					 
					
					
					if(rs1 != null)
						rs1.close();

					
					rs1=DBUtils.executeLAPSQuery("seluserstatusapp^"+strTemp);
					if(rs1.next())
					{
						strTemp =correctNull(rs1.getString("usr_name"));
					}
					vecRecords.add(strTemp);
					vecRecords.add("center");
				}
				
				
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("txtDate",strDate);
			hshRec.put("genby",strGen);
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
				if(rs1!=null)
				{
					rs1.close();
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
		String strQuery = null;
		HashMap hshRecord = new HashMap();
		HashMap hshTemp = new HashMap();
		ArrayList vecLabel = new ArrayList();
		ArrayList vecValue = new ArrayList();
		String strParam = null;
		String strOrgLevel = null;
		String hidOrgCode = null;
		String hidOpFields = null;
		String hidSelFields = null;
		String strProfileName = null;
		String strAppno=null;
		String strStat=null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strParam = (String)hshTemp.get("param");
			strProfileName =(String)hshTemp.get("profilename");
			
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strOrgLevel = st.nextToken();
			hidOrgCode = st.nextToken();
			strAppno = st.nextToken();
			strAppno = strAppno.replace('\'',' ');
			hidOpFields =st.nextToken();
			hidSelFields = st.nextToken();
			strStat = st.nextToken();
			vecLabel.add("Profile Name");
			vecLabel.add("Organisation Level");
			vecLabel.add("Process Status");
			vecLabel.add("Organisation Names");
			vecLabel.add("Application Numbers");
			vecLabel.add("Output Fields");

			vecValue.add(strProfileName);						
			vecValue.add(strOrgLevel);
			if (strStat.equalsIgnoreCase("R"))
			{
				strStat ="Rejected";
			}
			else if (strStat.equalsIgnoreCase("A"))
			{
				strStat ="Approved";
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strStat ="Pending";
			}
			
			vecValue.add(strStat);
			strQuery=SQLParser.getSqlQuery("repbanknames^"+hidOrgCode);
			rs=DBUtils.executeQuery(strQuery);
			hidOrgCode="";
			while(rs.next())
			{
				hidOrgCode += correctNull(rs.getString("org_name"))+",";		
			}
			hidOrgCode = hidOrgCode.substring(0,hidOrgCode.length()-1);
			vecValue.add(hidOrgCode);
			vecValue.add(strAppno);
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
		String strAppno = null;
		String strDate =null;
		String strGen =null;
		String strStat =null;

		try
		{
						
			hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter");
			strGen =(String)hshTemp.get("genby");
			strDate =(String)hshTemp.get("txtDate");
			strParam =(String)hshTemp.get("param");
			StringTokenizer st = new StringTokenizer(strParam,";");
			
			strTemp= st.nextToken();
			strOrgCode = st.nextToken();
			strAppno = st.nextToken();
			hidOpFields = st.nextToken();
			hidSelFields =st.nextToken();
			strStat = st.nextToken();
			
			hshRecord.put("hidOrgCode",strOrgCode);
			hshRecord.put("hidAppno",strAppno);
			hshRecord.put("hidSelFields",hidSelFields);
			hshRecord.put("hidOpFields",hidOpFields);
			hshRecord.put("txtDate",strDate);
			hshRecord.put("strUserId",strGen);
			hshRecord.put("hidStatus",strStat);
			
			hshPar = new HashMap();
			hshPar =(HashMap)getRepDetails(hshRecord);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
		}
		
		return hshPar;
	}

	private HashMap getAppno(HashMap hshPar) 
	{
		HashMap hshRec = new HashMap();
		
		ResultSet rs = null;
		String strQuery = null;
		String strOrgCode = null;
		ArrayList vecAppno = new ArrayList();
		String strStat = null;
		String strProdtype=null;
		
		try
		{
			
			
			strOrgCode=correctNull((String)hshPar.get("hidOrgCode"));
			strStat =(String)hshPar.get("hidStatus");
			strProdtype=correctNull((String)hshPar.get("prodtype"));
			String strOrgLevel=correctNull((String)hshPar.get("hidOrgLevel"));
			
			if(strOrgLevel.equalsIgnoreCase("CPC"))
			{
			strQuery = SQLParser.getSqlQuery("selrepappno_cpc^"+strProdtype+"^"+strOrgCode);
			if (strStat.equalsIgnoreCase("R"))
			{strQuery = strQuery + "and  upper(app_status) like upper('_R')  and app_approvedby=usr_id" ; 
			}		
			else if (strStat.equalsIgnoreCase("A"))
			{
				strQuery = strQuery + "and  upper(app_status) like upper('_A')  and app_approvedby=usr_id" ;
			}
			else if (strStat.equalsIgnoreCase("P"))
			{
				strQuery = strQuery + "and  upper(app_status) like upper('_P')  and app_applnholder=usr_id" ;
			}
			else if (strStat.equalsIgnoreCase("L"))
			{
				strQuery = strQuery + "and  upper(app_status) like upper('_L') and app_applnholder=usr_id" ;
			}
			}else{
				strQuery = SQLParser.getSqlQuery("selrepappno^"+strProdtype+"^"+strOrgCode);
				if (strStat.equalsIgnoreCase("R"))
				{strQuery = strQuery + "and  upper(app_status) like upper('_R')  " ; 
				}		
				else if (strStat.equalsIgnoreCase("A"))
				{
					strQuery = strQuery + "and  upper(app_status) like upper('_A') " ;
				}
				else if (strStat.equalsIgnoreCase("P"))
				{
					strQuery = strQuery + "and  upper(app_status) like upper('_P') " ;
				}
				else if (strStat.equalsIgnoreCase("L"))
				{
					strQuery = strQuery + "and  upper(app_status) like upper('_L')" ;
				}
			}
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecAppno.add(correctNull(rs.getString("app_no")));		
			}
			hshRec.put("vecValues",vecAppno);
						
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
		return hshRec;
	}
		
		private HashMap getUserId(HashMap hshPar) 
		{
			HashMap hshRec = new HashMap();
			ResultSet rs = null;
			String strQuery = null;
			String strOrgCode = null;
			ArrayList vecAppno = new ArrayList();
			ArrayList vecUser= new ArrayList();
			String strName="";
			
			try
			{
				
				
				strOrgCode=correctNull((String)hshPar.get("hidOrgCode"));
				
				strQuery = SQLParser.getSqlQuery("gerUserIDRep^"+strOrgCode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	strName=correctNull(rs.getString("username"));
					vecAppno.add(correctNull(rs.getString("usr_id")));	
					vecUser.add(strName);	
					
				}
				hshRec.put("vecValues",vecAppno);
				hshRec.put("vecUser",vecUser);
							
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
			return hshRec;
		
	}
		
		private HashMap getUserClass(HashMap hshPar) 
		{
			HashMap hshRec = new HashMap();
			ResultSet rs = null;
			String strQuery = null;
			String strOrgCode = null;
			ArrayList vecAppno = new ArrayList();
			ArrayList vecUser= new ArrayList();
			String strName="";
			
			try
			{
				
				
				strOrgCode=correctNull((String)hshPar.get("hidOrgCode"));
				
				
				strQuery = SQLParser.getSqlQuery("sel_users_class^"+strOrgCode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{	strName=correctNull(rs.getString("username"));
					vecAppno.add(correctNull(rs.getString("usr_id")));	
					vecUser.add(strName);	
					
				}
				
				hshRec.put("vecValues",vecAppno);
				hshRec.put("vecUser",vecUser);
							
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
			return hshRec;
		
	}
		
		private HashMap getUserDetails(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ResultSet rs1 = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strOrgCode = null;
			String strOpFields = null;
			String strSelFields=null;
			String strAppno = null;
			String strTemp=null;
			ArrayList vecT = new ArrayList();
			String strOrgName = "";
			String strDate=null;
			String strGen=null;
			String strStat="";
			String strToDate=null;
			String strFromDate=null;
			String strQ="";
			String strapprovedby="",strApp_Name="";
			String strDatetype="";
			String strOrglevel=null;
			StringBuffer strbufOrgcode=new StringBuffer();
			String strOrg_Name = "";
			try
			{
				strDate =(String)hshRequestValues.get("txtDate");
				if(strDate.equalsIgnoreCase(""))
				{
					strDate="All";
				}
				strStat =(String)hshRequestValues.get("hidStatus");
                strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidAppno");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
				strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
				strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
				strApp_Name=correctNull((String)hshRequestValues.get("hidappname"));
				strOrgCode=strOrgCode.replaceAll("'","");
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
				
				if (strStat.equalsIgnoreCase("R"))
				{
					strapprovedby = "app_approvedby" ;
				}		
				else if (strStat.equalsIgnoreCase("A"))
				{
					strapprovedby = "app_approvedby" ;
				}
				else if (strStat.equalsIgnoreCase("P"))
				{
					strapprovedby = "app_applnholder" ;
				}
				else if (strStat.equalsIgnoreCase("L"))
				{
					strapprovedby = "app_applnholder" ;
				}
				
				if(strStat.equalsIgnoreCase("L")){
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
				
				if(strStat.equalsIgnoreCase("P")||strStat.equalsIgnoreCase("L"))
				{
					strDatetype="loan_receivedate";
				}
				else
				{
					strDatetype="app_processdate";
				}
				if(!strDate.equals("All"))
				{
					strFromDate = strDate.substring(0,strDate.indexOf("-"));
					strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
				}
				if(strOrglevel.equalsIgnoreCase("CPC"))
				strQuery = SQLParser.getSqlQuery("selperappusertrack_cpc^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strapprovedby+"^"+strAppno);
				else
				strQuery = SQLParser.getSqlQuery("selperappusertrack^"+strOpFields+"^"+strbufOrgcode.toString()+"^"+strStat+"^"+strapprovedby+"^"+strAppno);	
				
				/*if(!strDate.equals("All"))
				{
					strFromDate = strDate.substring(0,strDate.indexOf("-"));
					strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					if(strStat.equalsIgnoreCase("P"))
					{
						strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
					}
					else
					{
						strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);	
					}
					strQuery = strQuery + strQ;
				}	*/		
				
				
				if(rs != null)
					rs.close();

				
				rs=DBUtils.executeQuery(strQuery);
				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					vecRecords = new ArrayList();
					strStat =correctNull(rs.getString("app_status"));
					if (vecT.contains("Proposal Number"))
					{
						strTemp =correctNull(rs.getString("app_no"));
						if (strTemp.equals(strOrgName))
						{
							vecRecords.add("&nbsp;");
						}
						else
						{
							vecRecords.add(strTemp);
						}
						vecRecords.add("left");
						strOrgName=strTemp;
											
					}
					if (vecT.contains("Applicant Name"))
					{
						strTemp =correctNull(rs.getString("perapp_fname"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
					if (vecT.contains("Amount"))
					{
						strTemp =Helper.correctDouble(rs.getString("loan_recmdamt"));
						vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
						vecRecords.add("right");
					}
					if (vecT.contains("Branch"))
					{
						strTemp =correctNull(rs.getString("org_name"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
						
						vecRecords.add(strTemp);
						vecRecords.add("left");
					}
					if (vecT.contains("Product Name"))
					{
						
						String a = correctNull(rs.getString("cat_name"));
						//String b = correctNull(rs.getString("scatname"));
					//	String c = correctNull(rs.getString("prd_desc"));
					//	strTemp = a+"-"+b+"-"+c;
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
					if ((vecT.contains("Approved By"))||(vecT.contains("Rejected By")))
					{
						strTemp =correctNull(rs.getString("app_approvedby"));
						 
						
						
						if(rs1 != null)
							rs1.close();
 
						if(!strTemp.equalsIgnoreCase(""))
						{
							rs1=DBUtils.executeLAPSQuery("seluserstatusapp^"+strTemp);
							if(rs1.next())
							{
								strTemp =correctNull(rs1.getString("usr_name"));
							}
						}
						vecRecords.add(strTemp);
						vecRecords.add("center");
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
							strTemp = "Restructure";
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
				if((strStat.equalsIgnoreCase("A"))||(strStat.equalsIgnoreCase("pa")))
				{
					strStat="Approved";
				}
				else if((strStat.equalsIgnoreCase("R"))||(strStat.equalsIgnoreCase("pr")))
				{
					strStat="Rejected";
				}
				else if((strStat.equalsIgnoreCase("L"))||(strStat.equalsIgnoreCase("ol")))
				{
					strStat="Lodged";
				}
				else
				{
					strStat="Pending";
				}
				hshRec.put("strStatus",strStat);
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate1",strFromDate);
				hshRec.put("txtDate",strToDate);
				hshRec.put("genby",strGen);
				hshRec.put("Org_Name",strOrg_Name);
				hshRec.put("App_Name",strApp_Name);
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
					if(rs1!=null)
					{
						rs1.close();
					}
					
					
					
				}
				catch(Exception e)
				{
					throw new EJBException("close"+e.toString()); 
				}
			}
			return hshRec;
		}
		
		
		private HashMap getUserCount(HashMap hshRequestValues) 
		{
			
			ResultSet rs  = null;
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strQuery1=null;
			String strQuery2=null;
			String strOrgCode = null;
			String strAppno = null;
			String strDate="";
			String strGen=null;
			String strToDate="";
			String strFromDate="";
			String strQ="";
			String strOrglevel=null;
			StringBuffer strbufOrgcode=new StringBuffer();
			String user_name=null;
			String strOrgName=null;
			String strfeildname=null;
			String strStatus=null;
			
			try
			{
				strDate =(String)hshRequestValues.get("txtDate");
				strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidAppno");
				strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
				strOrgName=correctNull((String)hshRequestValues.get("hidOrgName"));
				strStatus=correctNull((String)hshRequestValues.get("hidstatus"));
				
				strOrgCode=strOrgCode.replaceAll("'","");
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
				
				
				rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
				while (rs.next())
				{
					strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
				}
				if(rs != null)
					rs.close();

				strQuery = SQLParser.getSqlQuery("selrepusrs^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				String usrname="";
				
				hshRec = new HashMap();
				vecVal = new ArrayList();
				
				while (rs.next())
				{
					vecRecords = new ArrayList();
					usrname =correctNull(rs.getString("usr_id"));
					//added for getting the Fname,Mname,Lname of the user 
					
					user_name =correctNull(rs.getString("USR_FNAME"));
					strfeildname="APP_USRID";
					if(strOrglevel.equalsIgnoreCase("CPC"))
					strQuery1 = SQLParser.getSqlQuery("usrsappcount_cpc^"+strfeildname+"^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^pa");	
					else
						strQuery1 = SQLParser.getSqlQuery("usrsappcount^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^pa");	
					
					if(!strDate.equals("All"))
			         {
					   strFromDate = strDate.substring(0,strDate.indexOf("-"));
					   strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					   //strQ =SQLParser.getSqlQueryByCode("sel_datewise^"+"app_processdate"+"^"+strFromDate+"^"+strToDate);
					   
					   strQ=" and TO_DATE(to_char(app_processdate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate+"','DD/MM/YYYY') and TO_DATE('"+strToDate+"','DD/MM/YYYY')" ;
				   
					   strQuery1 = strQuery1 + strQ;
			    	}
					
						strQuery1 = strQuery1 + "group by app_status";
					
					rs1=DBUtils.executeQuery(strQuery1);
					vecRecords.add(user_name);
					if (rs1.next())
					{
						vecRecords.add(correctNull(rs1.getString(2)));
						vecRecords.add(correctNull(rs1.getString(3)));
					}
					else
					{
						vecRecords.add("0");
						vecRecords.add("0");
					}
					if(strOrglevel.equalsIgnoreCase("CPC"))
					strQuery2 = SQLParser.getSqlQuery("usrsappcount_cpc^"+strfeildname+"^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^pr");
					else
					strQuery2 = SQLParser.getSqlQuery("usrsappcount^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^pr");
					if(!strDate.equals("All"))
			         {
				   strFromDate = strDate.substring(0,strDate.indexOf("-"));
				   strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				   //strQ =SQLParser.getSqlQuery("sel_datewise^"+"app_processdate"+"^"+strFromDate+"^"+strToDate);
				   
				   strQ=" and TO_DATE(to_char(app_processdate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate+"','DD/MM/YYYY') and TO_DATE('"+strToDate+"','DD/MM/YYYY')" ;
				   strQuery2 = strQuery2 + strQ;
			    	}
					strQuery2= strQuery2 + "group by app_status";
				
					rs2=DBUtils.executeQuery(strQuery2);
					
					if (rs2.next())
					{
						vecRecords.add(correctNull(rs2.getString(2)));
						vecRecords.add(correctNull(rs2.getString(3)));
					}
					else
					{
						vecRecords.add("0");
						vecRecords.add("0");
						
					}
					//added for getting the open pending application
					strfeildname="APP_USRID";
					if(strOrglevel.equalsIgnoreCase("CPC"))
					strQuery2 = SQLParser.getSqlQuery("usrsappcount_cpc^"+strfeildname+"^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^op");
					else
					strQuery2 = SQLParser.getSqlQuery("usrsappcount^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^op");
					if(!strDate.equals("All"))
			         {
				   strFromDate = strDate.substring(0,strDate.indexOf("-"));
				   strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				  // strQ =SQLParser.getSqlQueryByCode("sel_datewise^"+"loan_receivedate"+"^"+strFromDate+"^"+strToDate);
				   
				   strQ=" and TO_DATE(to_char(loan_receivedate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate+"','DD/MM/YYYY') and TO_DATE('"+strToDate+"','DD/MM/YYYY')" ;
				   strQuery2 = strQuery2 + strQ;
			    	}
					strQuery2= strQuery2 + "group by app_status";
				
					rs2=DBUtils.executeQuery(strQuery2);
					
					if (rs2.next())
					{
						vecRecords.add(correctNull(rs2.getString(2)));
						vecRecords.add(correctNull(rs2.getString(3)));
					}
					else
					{
						vecRecords.add("0");
						vecRecords.add("0");
						
					}					
					
					//added for getting the open Lodged application
					strfeildname="APP_USRID";
					if(strOrglevel.equalsIgnoreCase("CPC"))
					strQuery2 = SQLParser.getSqlQuery("usrsappcount_cpc^"+strfeildname+"^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^ol");
					else
						strQuery2 = SQLParser.getSqlQuery("usrsappcount^"+strbufOrgcode.toString()+"^"+strfeildname+"^"+usrname+"^"+strStatus+"^ol");
					if(!strDate.equals("All"))
			         {
				   strFromDate = strDate.substring(0,strDate.indexOf("-"));
				   strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
				   
				   strQ=" and TO_DATE(to_char(loan_receivedate,'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('"+strFromDate+"','DD/MM/YYYY') and TO_DATE('"+strToDate+"','DD/MM/YYYY')" ;
				   strQuery2 = strQuery2 + strQ;
			    	}
					strQuery2= strQuery2 + "group by app_status";
				
					rs2=DBUtils.executeQuery(strQuery2);
					
					if (rs2.next())
					{
						vecRecords.add(correctNull(rs2.getString(2)));
						vecRecords.add(correctNull(rs2.getString(3)));
					}
					else
					{
						vecRecords.add("0");
						vecRecords.add("0");
						
					}
					
					vecVal.add(vecRecords);
					
				}
				
				hshRec.put("vecValues",vecVal);
				hshRec.put("genby",strGen);
				hshRec.put("OrgName",strOrgName);
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
					
					
					if(rs1!=null)
					{
						rs1.close();
					}
					
					
					if(rs2!=null)
					{
						rs2.close();
					}
					
				}
				catch(Exception e)
				{
					throw new EJBException("close"+e.toString()); 
				}
			}
			return hshRec;
		}
		
		
		
		private HashMap getBuilderReport(HashMap hshRequestValues) 
		{
			HashMap hshRecord=new HashMap();
			String strQuery="";
			ResultSet rs=null;
			String strbuilname="";
			String strsurveyno="";
			ArrayList vecVal =new ArrayList();
			ArrayList vecData=new ArrayList();
			
			
			
			
			try
			{
				
				strbuilname =(String)hshRequestValues.get("txtbuilname");
				strsurveyno=(String)hshRequestValues.get("txt_surveyno");
							
			

			if((!strbuilname.equalsIgnoreCase(""))&&(!strsurveyno.equalsIgnoreCase("")))
			{
			strQuery = SQLParser.getSqlQuery("selbuildernamerep^"+strbuilname+"^"+strsurveyno);
			}
			if((!strbuilname.equalsIgnoreCase(""))&&(strsurveyno.equalsIgnoreCase("")))
			{
			strQuery = SQLParser.getSqlQuery("selbuildernamerep1^"+strbuilname);
			}
			if((strbuilname.equalsIgnoreCase(""))&&(!strsurveyno.equalsIgnoreCase("")))
			{
			strQuery = SQLParser.getSqlQuery("selbuildernamerep2^"+strsurveyno);
			}

			String prop_name="";
			if(rs != null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecData = new ArrayList();
				prop_name=rs.getString("prop_name");
			
				
				vecData.add(correctNull(rs.getString("prop_name")));
				vecData.add(correctNull(rs.getString("prop_address")));
				vecData.add(correctNull(rs.getString("prop_phone")));
				vecData.add(correctNull(rs.getString("per_name")));
				vecData.add(correctNull(rs.getString("prop_builder")));
				vecVal.add(vecData);
				
			}
			hshRecord.put("vecVal",vecVal);
			
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

		private HashMap getUserClassDetails(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ResultSet rs1 = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null,strQuery1=null;
			String strOrgCode = null;
			String strOpFields = null;
			String strSelFields=null;
			String strAppno = null;
			String strTemp=null;
			ArrayList vecT = new ArrayList();
			String strOrgName = "";
			String strGen=null;
			String strToDate=null;
			String strFromDate=null;
			String strLoantype=null;
			String strOrglevel=null;
			String strQ=" ";
			String strStatus="",strapprovedby="",strDatetype="";
			String strOrg_Name="",strApp_Name="";
			String strDate=null;
			boolean flag=false;
			StringBuffer strbufOrgcode=new StringBuffer();
			try
			{
				strDate =(String)hshRequestValues.get("txtDate");
				if(strDate.equalsIgnoreCase(""))
				{
					strDate="All";
				}
                strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidAppno");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
				strOrglevel=correctNull((String)hshRequestValues.get("orglevel"));
				strLoantype=correctNull((String)hshRequestValues.get("loantype"));
				strStatus=correctNull((String)hshRequestValues.get("hidstatus"));
				strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
				strApp_Name=correctNull((String)hshRequestValues.get("hidappname"));
				
				strOrgCode=strOrgCode.replaceAll("'","");
				if(strOrglevel.equalsIgnoreCase("C"))
				{
					strbufOrgcode.append("org_code like '001%'");
				}
				else if(strOrglevel.equalsIgnoreCase("R"))
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
				
				if (strStatus.equalsIgnoreCase("R"))
				{
					strapprovedby = "app_approvedby" ;
				}		
				else if (strStatus.equalsIgnoreCase("A"))
				{
					strapprovedby = "app_approvedby" ;
				}
				else if (strStatus.equalsIgnoreCase("P"))
				{
					strapprovedby = "app_applnholder" ;
				}
				
				/*if (strStatus.equalsIgnoreCase("R"))
				{
					strStatus = "PR" ;
				}		
				else if (strStatus.equalsIgnoreCase("A"))
				{
					strStatus = "PA" ;
				}
				else if (strStatus.equalsIgnoreCase("P"))
				{
					strStatus = "OP" ;
				}*/
				
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
				
				
				
				 if(strStatus.equalsIgnoreCase("P"))
				{
					strDatetype="loan_receivedate";
				}
				else
				{
					strDatetype="app_processdate";
				}
				if(!strDate.equals("All"))
				{
					strFromDate = strDate.substring(0,strDate.indexOf("-"));
					strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype).append(",'DD/MM/YYYY'),'DD/MM/YYYY')between TO_DATE('")
					.append(strFromDate).append("','DD/MM/YYYY') and TO_DATE('").append(strToDate).append("','DD/MM/YYYY'))");
				}
				 
				strQuery = SQLParser.getSqlQuery("selperappuserProductwise^"+strOpFields+"^"+strLoantype+"^"+strbufOrgcode+"^"+strStatus+"^"+strapprovedby+"^"+strAppno);
				
				/*if(strFromDate.equals("") && strToDate.equals(""))
				{
					strQuery = SQLParser.getSqlQuery("selperappuserProductwise^"+strOpFields+"^"+strLoantype+"^"+strbufOrgcode+"^"+strStatus+"^"+strapprovedby+"^"+strAppno);	
				}
				
				if(!strFromDate.equals("") && !strToDate.equals(""))
				
				{
					strQuery = SQLParser.getSqlQuery("selperappuserProductwise^"+strOpFields+"^"+strLoantype+"^"+strbufOrgcode+"^"+strStatus+"^"+strapprovedby+"^"+strAppno);
					if(strStatus.equalsIgnoreCase("P"))
					{
						strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
					}
					else
					{
						strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);	
					}
					
					strQuery = strQuery + strQ;
				}*/
				if(rs != null)
					rs.close();

				
				rs=DBUtils.executeQuery(strQuery);
				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					/*if(strStatus.equalsIgnoreCase("P")||strStatus.equalsIgnoreCase("OP"))
					{
						String strappwith="";
						strQuery1 = SQLParser.getSqlQuery("selapplicationwith^"+Helper.correctNull((String)rs.getString("app_no")));
						if(rs1 != null)
							rs1.close();
						rs1=DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strappwith =correctNull(rs1.getString("usr_id"));
						}
						
						if(strappwith.equalsIgnoreCase(strAppno)||strappwith.equalsIgnoreCase(""))
						{
							flag=true;
						}
					 }*/
					
						vecRecords = new ArrayList();
						
						if (vecT.contains("Application Number"))
						{
							strTemp =correctNull(rs.getString("app_no"));
							if (strTemp.equals(strOrgName))
							{
								vecRecords.add("&nbsp;");
							}
							else
							{
								vecRecords.add(strTemp);
							}
							vecRecords.add("center");
							strOrgName=strTemp;
						}
						if (vecT.contains("Applicant Name"))
						{
							strTemp =correctNull(rs.getString("perapp_fname"));
							vecRecords.add(strTemp);
							vecRecords.add("left");
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
						if (vecT.contains("Amount"))
						{
							strTemp =Helper.correctDouble(rs.getString("loan_recmdamt"));
							vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
							vecRecords.add("right");
						}
						if (vecT.contains("Branch"))
						{
							strTemp =correctNull(rs.getString("org_name"));
							vecRecords.add(strTemp);
							vecRecords.add("left");
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
							
							vecRecords.add(strTemp);
							vecRecords.add("left");
						}	
						if (vecT.contains("Product Name"))
						{
							
							String a = correctNull(rs.getString("cat_name"));
							//String b = correctNull(rs.getString("scatname"));
							//String c = correctNull(rs.getString("prd_desc"));
							//strTemp = a+"-"+b+"-"+c;
							strTemp = a;
							vecRecords.add(strTemp);
							vecRecords.add("left");
						}
						if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date"))
						{
							strTemp =correctNull(rs.getString("app_processdate"));
							vecRecords.add(strTemp);
							vecRecords.add("center");
						}
						
							
							if(rs1 != null)
								rs1.close();
						vecVal.add(vecRecords);
				}
				
				if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("pa")))
				{
					strStatus="Approved";
				}
				else if((strStatus.equalsIgnoreCase("R"))||(strStatus.equalsIgnoreCase("pr")))
				{
					strStatus="Rejected";
				}
				else
				{
					strStatus="Initiated";
				}
				hshRec.put("strStatus",strStatus);
				
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate1",strFromDate);
				hshRec.put("txtDate",strToDate);
				hshRec.put("genby",strGen);
				hshRec.put("Loan_type",strLoantype);
				hshRec.put("Org_Name",strOrg_Name);
				hshRec.put("App_Name",strApp_Name);
				
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
					if(rs1!=null)
					{
						rs1.close();
					}
					
					
					
				}
				catch(Exception e)
				{
					throw new EJBException("close"+e.toString()); 
				}
			}
			return hshRec;
		}
		private HashMap getRepDetails2(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ResultSet rs1 = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strOrgCode = null;
			String strOpFields = null;
			String strSelFields=null;
			String strAppno = null;
			String strTemp=null;
			ArrayList vecT = new ArrayList();
			String strOrgName = "";
			String strGen=null;
			String strToDate=null;
			String strFromDate=null;
			String strQ=" ";
			
			try
			{
				strFromDate =(String)hshRequestValues.get("txtDate");
				strToDate =(String)hshRequestValues.get("txtDate2");
                strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidappno");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
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
				
				if(strFromDate.equalsIgnoreCase("1") && strToDate.equalsIgnoreCase("2"))
				{
					strQuery = SQLParser.getSqlQuery("selperappusertrack1^"+strOpFields+"^"+strOrgCode+"^"+strAppno);	
				}
				
				if(!strFromDate.equals("1") && !strToDate.equals("2"))
				{
					strQuery = SQLParser.getSqlQuery("selperappusertrack2^"+strOpFields+"^"+strOrgCode+"^"+strAppno);
					
					strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);
					strQuery = strQuery + strQ;
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
						if (strTemp.equals(strOrgName))
						{
							vecRecords.add("&nbsp;");
						}
						else
						{
							vecRecords.add(strTemp);
						}
						vecRecords.add("left");
						strOrgName=strTemp;
											
					}
					if (vecT.contains("Applicant Name"))
					{
						strTemp =correctNull(rs.getString("perapp_fname"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
					}
					if (vecT.contains("Applied Date"))
					{
						strTemp =correctNull(rs.getString("app_date"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					}
					if (vecT.contains("Amount"))
					{
						strTemp =correctNull(rs.getString("loan_recmdamt"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					}
					if (vecT.contains("Organisation"))
					{
						strTemp =correctNull(rs.getString("org_name"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
					
						
						if(rs1 != null)
							rs1.close();
					vecVal.add(vecRecords);
				}
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate1",strFromDate);
				hshRec.put("txtDate2",strToDate);
				hshRec.put("genby",strGen);
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
					if(rs1!=null)
					{
						rs1.close();
					}
					
					
					
				}
				catch(Exception e)
				{
					throw new EJBException("close"+e.toString()); 
				}
			}
			return hshRec;
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
							
				hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter1");
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
				hshPar =(HashMap)getRepDetails(hshRecord);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
			}
			
			return hshPar;
		}
		private HashMap getParamList2(HashMap hshPar) 
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
			String hidappno="";
			try
			{
							
				hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter1");
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
				hidappno=st.nextToken();
				hidOpFields = st.nextToken();
				hidSelFields =st.nextToken();
				hshRecord.put("hidOrgCode",strOrgCode);
				hshRecord.put("hidStatus",strStatus);
				hshRecord.put("txtDate",strPeriod);
				hshRecord.put("hidappno",hidappno);
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
		private HashMap getParamList3(HashMap hshPar) 
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
			String hidappno="";
			try
			{
							
				hshTemp=(HashMap)EJBInvoker.executeStateLess("repData",hshPar,"getParameter1");
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
				hidappno=st.nextToken();
				hidOpFields = st.nextToken();
				hidSelFields =st.nextToken();
				hshRecord.put("hidOrgCode",strOrgCode);
				hshRecord.put("txtDate",strStatus);
				hshRecord.put("txtDate2",strPeriod);
				hshRecord.put("hidappno",hidappno);
				hshRecord.put("hidSelFields",hidSelFields);
				hshRecord.put("hidOpFields",hidOpFields);
				hshRecord.put("txtSaveDate",strSaveDate);
				hshRecord.put("strUserId",strGen);
				hshRecord.put("txtSaveDate",strSaveDate);
				hshRecord.put("strUserId",strGen);
				hshRecord.put("txtfromamt",txtfromamt);
				hshRecord.put("txttoamt",txttoamt);
				hshPar = new HashMap();
				hshPar =(HashMap)getRepDetails2(hshRecord);
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in help "+ce.toString());
			}
			
			return hshPar;
		}
		private HashMap getRepDetails1(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strOrgCode = null;
			String strOpFields = null;
			String strSelFields=null;
			String strAppno = null;
			String strTemp=null;
			ArrayList vecT = new ArrayList();
			String strOrgName = "";
			String strDate=null;
			String strGen=null;
			String strStat=null;	
			
			String strToDate="";
			String strFromDate="";
			String strQ=" ";
			try
			{
				
				
				strDate =(String)hshRequestValues.get("txtDate");
				strStat =(String)hshRequestValues.get("hidStatus");
				strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidappno");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
				
				
				strDate =(String)hshRequestValues.get("txtDate");
				
				if(strDate.equalsIgnoreCase(""))
				{
					strDate="All";
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
				
				strQuery = SQLParser.getSqlQuery("selperapptrack^"+strOpFields+"^"+strOrgCode+"^"+strAppno);
				
				if(!strDate.equals("All"))
				{
					strFromDate = strDate.substring(0,strDate.indexOf("-"));
					strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
					strQuery = strQuery + strQ;
				}		
				
				if (strStat.equalsIgnoreCase("R"))
				{
					strQuery = strQuery + "and  upper(app_status) = 'PR' " ;
				}		
				else if (strStat.equalsIgnoreCase("A"))
				{
					strQuery = strQuery + "and  upper(app_status) ='PA'" ;
				}
				else if (strStat.equalsIgnoreCase("P"))
				{
					strQuery = strQuery + "and  upper(app_status) ='OP'" ;
				}
				
				if(rs != null)
					rs.close();
				
				rs=DBUtils.executeQuery(strQuery);
				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					vecRecords = new ArrayList();
					strStat =correctNull(rs.getString("app_status"));
					if (vecT.contains("Application Number"))
					{
						strTemp =correctNull(rs.getString("app_no"));
						if (strTemp.equals(strOrgName))
						{
							vecRecords.add("&nbsp;");
						}
						else
						{
							vecRecords.add(strTemp);
						}
						vecRecords.add("left");
						strOrgName=strTemp;
											
					}
					if (vecT.contains("Applicant Name"))
					{
						strTemp =correctNull(rs.getString("perapp_fname"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
					}
					if (vecT.contains("Applied Date"))
					{
						strTemp =correctNull(rs.getString("app_date"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					}
					if (vecT.contains("Amount"))
					{
						strTemp =correctNull(rs.getString("loan_recmdamt"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					}
					if (vecT.contains("Organisation"))
					{
						strTemp =correctNull(rs.getString("org_name"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
			
					
					vecVal.add(vecRecords);
				}
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate",strDate);
				hshRec.put("genby",strGen);
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
	
		private HashMap getUserDetails1(HashMap hshRequestValues) 
		{
			
			ResultSet rs = null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null;
			String strOrgCode = null;
			String strOpFields = null;
			String strSelFields=null;
			String strAppno = null;
			String strTemp=null;
			ArrayList vecT = new ArrayList();
			String strOrgName = "";
			String strDate=null;
			String strGen=null;
			String strStat=null;	
			
			String strToDate="";
			String strFromDate="";
			String strQ=" ";
			String strOrg_Name = "";
			String strprodtype="";
			try
			{
				
				
				strDate =(String)hshRequestValues.get("txtDate");
				strStat =(String)hshRequestValues.get("hidStatus");
				strGen =(String)hshRequestValues.get("strUserId");
				strOrgCode =(String)hshRequestValues.get("hidOrgCode");
				strAppno =(String)hshRequestValues.get("hidAppno");
				strSelFields =(String)hshRequestValues.get("hidSelFields");
				strOpFields =(String)hshRequestValues.get("hidOpFields");
				strOrg_Name=correctNull((String)hshRequestValues.get("hidOrgName"));
				strprodtype=correctNull((String)hshRequestValues.get("hidprodtype"));
				String strOrgLevel=correctNull((String)hshRequestValues.get("hidOrgLevel"));
				
				strDate =(String)hshRequestValues.get("txtDate");
				
				if(strDate.equalsIgnoreCase(""))
				{
					strDate="All";
				}
				if(strStat.equalsIgnoreCase("L")){
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
				
				if((strStat.equalsIgnoreCase("A"))||(strStat.equalsIgnoreCase("R")))
				{
					strQ=" applications.app_approvedby = users.usr_id";
					//strDatetype="app_processdate";
				}
				else
				{
					strQ=" applications.app_applnholder = users.usr_id";
					//strDatetype="loan_receivedate";
				}
				
				if(strOrgLevel.equalsIgnoreCase("CPC"))
				{
				strQuery = SQLParser.getSqlQuery("selperapptrack_cpc^"+strOpFields+"^"+strprodtype
						+"^"+strOrgCode+"^"+strStat+"^"+strQ+"^"+strAppno);
				}else{
					strQuery = SQLParser.getSqlQuery("selperapptrack^"+strOpFields+"^"+strprodtype
							+"^"+strOrgCode+"^"+strStat+"^"+strQ+"^"+strAppno);
				}
				
				/*if(!strDate.equals("All"))
				{
					strFromDate = strDate.substring(0,strDate.indexOf("-"));
					strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
					//strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
					
					if(strStat.equalsIgnoreCase("P"))
					{
						strQ =SQLParser.getSqlQuery("seldatewise^"+strFromDate+"^"+strToDate);
					}
					else
					{
						strQ =SQLParser.getSqlQuery("seldatewise1^"+strFromDate+"^"+strToDate);	
					}
					
					strQuery = strQuery + strQ;
				}*/		
				
				/*if (strStat.equalsIgnoreCase("R"))
				{
					strQuery = strQuery + "and  upper(app_status) = 'PR' " ;
				}		
				else if (strStat.equalsIgnoreCase("A"))
				{
					strQuery = strQuery + "and  upper(app_status) ='PA'" ;
				}
				else if (strStat.equalsIgnoreCase("P"))
				{
					strQuery = strQuery + "and  upper(app_status) ='OP'" ;
				}*/
				
				if(rs != null)
					rs.close();
				
				rs=DBUtils.executeQuery(strQuery);
				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					vecRecords = new ArrayList();
					strStat =correctNull(rs.getString("app_status"));
					if (vecT.contains("Proposal Number"))
					{
						strTemp =correctNull(rs.getString("app_no"));
						if (strTemp.equals(strOrgName))
						{
							vecRecords.add("&nbsp;");
						}
						else
						{
							vecRecords.add(strTemp);
						}
						vecRecords.add("left");
						strOrgName=strTemp;
											
					}
					if (vecT.contains("Applicant Name"))
					{
						strTemp =correctNull(rs.getString("perapp_fname"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
					if (vecT.contains("Amount"))
					{
						strTemp =Helper.correctDouble(rs.getString("loan_recmdamt"));
						vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
						vecRecords.add("right");
					}
					if (vecT.contains("Branch"))
					{
						strTemp =correctNull(rs.getString("org_name"));
						vecRecords.add(strTemp);
						vecRecords.add("left");
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
						
						vecRecords.add(strTemp);
						vecRecords.add("left");
					}
					if (vecT.contains("Product Name"))
					{
						String a = correctNull(rs.getString("cat_name"));
						//String b = correctNull(rs.getString("scatname"));
						//String c = correctNull(rs.getString("prd_desc"));
						//strTemp = a+"-"+b+"-"+c;
						strTemp=a;
						vecRecords.add(strTemp);
						vecRecords.add("left");
					}
					if ((vecT.contains("Approved Date"))||vecT.contains("Rejected Date")||vecT.contains("Date"))
					{
						strTemp =correctNull(rs.getString("app_processdate"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
					}
					if ((vecT.contains("Approved By"))||vecT.contains("Rejected By")||vecT.contains("Pending with"))
					{
						strTemp =correctNull(rs.getString("usr_fname"));
						vecRecords.add(strTemp);
						vecRecords.add("center");
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
							strTemp = "Restructure";
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
				hshRec.put("vecValues",vecVal);
				hshRec.put("labels",strSelFields);
				hshRec.put("txtDate1",strDate);
				//hshRec.put("txtDate",strToDate);
				hshRec.put("genby",strGen);
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
		
		
		
		private HashMap getProposalReport(HashMap hshRequestValues) 
		{
					
					ResultSet rs = null;
					ArrayList vecRecords=null;
					HashMap hshRec=null;
					ArrayList vecVal =null;
					String strTemp=null;
					ArrayList vecT = new ArrayList();
					String strvarcbsid = "";
					String strSelFields="";
					String strGen =(String)hshRequestValues.get("strUserId");
					try
					{
						strvarcbsid =(String)hshRequestValues.get("varcbsid");
						rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
						while (rs.next())
						{
							strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
						}
						strSelFields="CBS ID,CUSTOMER NAME,LOAN TYPE,CUSTOMER TYPE,PROPOSAL NUMBER,FACILITY S.NO,LIMIT TYPE,NATURE OF FACILITY,RENEW FLAG,PRODUCT DESCRIPTION,LOAN AMOUNT,SANCTION REFERENCES NUMBER,PROCESSED DATE,ACCOUNT NUMBER";
						StringTokenizer st = new StringTokenizer(strSelFields,",");
						while (st.hasMoreTokens())
						{
							vecT.add(st.nextToken());
						}
						if(rs != null)
							rs.close();
						
						rs=DBUtils.executeLAPSQuery("sel_proposalReports^"+strvarcbsid+"^"+strvarcbsid+"^"+strvarcbsid);
						hshRec = new HashMap();
						vecVal = new ArrayList();
						while (rs.next())
						{
							vecRecords = new ArrayList();
							if (vecT.contains("CBS ID"))
							{
								strTemp =correctNull(rs.getString("CBS"));
								vecRecords.add(strTemp);
								vecRecords.add("left");										
							}
							if (vecT.contains("CUSTOMER NAME"))
							{
								strTemp =correctNull(rs.getString("ACNM"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("LOAN TYPE"))
							{
								strTemp =correctNull(rs.getString("MODULE"));
								vecRecords.add(strTemp);
								vecRecords.add("center");
							}
							if (vecT.contains("CUSTOMER TYPE"))
							{
								strTemp =correctNull(rs.getString("Type"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("PROPOSAL NUMBER"))
							{
								strTemp =correctNull(rs.getString("APPNO"));
								vecRecords.add(strTemp);
								vecRecords.add("left");	
							}
							if (vecT.contains("FACILITY S.NO"))
							{
								strTemp =correctNull(rs.getString("FAC_SNO"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("LIMIT TYPE"))
							{
								strTemp =correctNull(rs.getString("LIMITTYPE"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("NATURE OF FACILITY"))
							{
								strTemp =correctNull(rs.getString("faccateogry"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("RENEW FLAG"))
							{
								strTemp =correctNull(rs.getString("FACILITYTYPE"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("PRODUCT DESCRIPTION"))
							{
								strTemp =correctNull(rs.getString("PRDDE"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("LOAN AMOUNT"))
							{
								strTemp =Helper.correctDouble(rs.getString("LOANAMOUNT"));
								vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));
								vecRecords.add("right");
							}
							if (vecT.contains("SANCTION REFERENCES NUMBER"))
							{
								strTemp =correctNull(rs.getString("SANREF"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("PROCESSED DATE"))
							{
								strTemp =correctNull(rs.getString("APDT"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("ACCOUNT NUMBER"))
							{
								strTemp =correctNull(rs.getString("ACNUM"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							vecVal.add(vecRecords);
						}
						hshRec.put("vecValues",vecVal);
						hshRec.put("labels",strSelFields);
						hshRec.put("genby",strGen);
						hshRec.put("desc","List of Proposals of a Customer");
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
		private HashMap getUserProposalReport(HashMap hshRequestValues) 
		{
					
					ResultSet rs = null;
					ArrayList vecRecords=null;
					HashMap hshRec=null;
					ArrayList vecVal =null;
					String strTemp=null;
					ArrayList vecT = new ArrayList();
					String strvarusrid = "";
					String strSelFields="";
					String strGen =(String)hshRequestValues.get("strUserId");
					try
					{
						strvarusrid =(String)hshRequestValues.get("varusrid");
						rs=DBUtils.executeLAPSQuery("selusername^"+strGen);
						while (rs.next())
						{
							strGen =correctNull(rs.getString(1))+" "+correctNull(rs.getString(2));
						}
						strSelFields="PROPOSAL NUMBER,CBS ID,CUSTOMER NAME,LOAN TYPE";
						StringTokenizer st = new StringTokenizer(strSelFields,",");
						while (st.hasMoreTokens())
						{
							vecT.add(st.nextToken());
						}
						if(rs != null)
							rs.close();
						String strQuery=SQLParser.getSqlQuery("sel_userproposalreport^"+strvarusrid+"^"+strvarusrid+"^"+strvarusrid+"^"+strvarusrid+"^"+strvarusrid+"^"+strvarusrid);
						rs=DBUtils.executeLAPSQuery(strQuery);
						hshRec = new HashMap();
						vecVal = new ArrayList();
						while (rs.next())
						{
							vecRecords = new ArrayList();
							if (vecT.contains("PROPOSAL NUMBER"))
							{
								strTemp =correctNull(rs.getString("App_no"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("CBS ID"))
							{
								strTemp =correctNull(rs.getString("CBS_ID"));
								vecRecords.add(strTemp);
								vecRecords.add("left");										
							}
							if (vecT.contains("CUSTOMER NAME"))
							{
								strTemp =correctNull(rs.getString("App_name"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							if (vecT.contains("LOAN TYPE"))
							{
								strTemp =correctNull(rs.getString("Loan_type"));
								vecRecords.add(strTemp);
								vecRecords.add("left");
							}
							vecVal.add(vecRecords);
						}
						hshRec.put("vecValues",vecVal);
						hshRec.put("labels",strSelFields);
						hshRec.put("genby",strGen);
						hshRec.put("desc","List of Proposals of a User");
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
		
		
		
		
		
		/*private HashMap getAppRepCount(HashMap hshValues) 
		{
			
	 		ResultSet rs = null;
	 		ResultSet rs1=null;
			ArrayList vecRecords=null;
			HashMap hshRec=null;
			ArrayList vecVal =null;
			String strQuery=null,strQuery1=null;
			String strOrgCode = null;
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
			StringBuffer strbufOrgcode=new StringBuffer();
			String strorglevel="",strLoantype="";	
			try
			{
				
				
				strSaveDate =(String)hshValues.get("txtSaveDate");
				strGen =(String)hshValues.get("strUserId");
				strOrgCode =(String)hshValues.get("hidOrgCode");
				strSelFields =(String)hshValues.get("hidSelFields");
				strStatus =(String)hshValues.get("hidStatus");
				strDate =(String)hshValues.get("txtDate");
				txtfromamt=correctNull((String)hshValues.get("txtfromamt"));
				txttoamt=(String)hshValues.get("txttoamt");
				strOrglevel=correctNull((String)hshValues.get("orglevel"));
				strOrg_Name=correctNull((String)hshValues.get("hidOrgName"));
				strLoantype=correctNull((String)hshValues.get("loantype"));
				
				if(strOrglevel.equalsIgnoreCase("D"))
				{
				 strbufOrgcode.append("v_organisation.org_code= organisations.org_code");
				}
				else 
				{
				strbufOrgcode.append("v_organisation.region= organisations.org_code");
				}
				
				strOrgCode=strOrgCode.replaceAll("'","");
				if(strOrglevel.equalsIgnoreCase("C"))
				{
					strbufOrgcode.append("organisations.org_code like '001%'");
					strorglevel="D";
				}
				else if(strOrglevel.equalsIgnoreCase("R"))
				{
					strbufOrgcode.append("organisations.org_code like '").append(strOrgCode.substring(0,6)).append("%'");
					strorglevel="D";
				}
				else if(strOrglevel.equalsIgnoreCase("D"))
				{
					strbufOrgcode.append("organisations.org_code like '").append(strOrgCode.substring(0,9)).append("%'");
					strorglevel="A";
				}
				else if(strOrglevel.equalsIgnoreCase("A"))
				{
					strbufOrgcode.append("organisations.org_code like '").append(strOrgCode.substring(0,12)).append("%'");
				}
				else if(strOrglevel.equalsIgnoreCase("B"))
				{
					strbufOrgcode.append("organisations.org_code = '").append(strOrgCode).append("'");
				}
				if((strStatus.equalsIgnoreCase("A"))||(strStatus.equalsIgnoreCase("R")))
				{
					strDatetype="app_processdate";
				}
				else
				{
					strDatetype="app_createdate";
				}
				if(!strDate.equalsIgnoreCase("All"))
				{
					if(!strFromDate.equalsIgnoreCase(""))
					{
						strFromDate = strDate.substring(0,strDate.indexOf("-"));
						strToDate = strDate.substring(strDate.indexOf("-")+1,strDate.length());
						strbufOrgcode.append(" and (TO_DATE(to_char(").append(strDatetype)
						.append(",'DD/MM/YYYY'),'DD/MM/YYYY') between TO_DATE('").append(strFromDate)
						.append("','DD/MM/YYYY') and TO_DATE( '").append(strToDate)
						.append("','DD/MM/YYYY'))");
					}
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
					
				strQuery =SQLParser.getSqlQuery("selapprepcount^"+strLoantype+"^"+strStatus+"^"+strorglevel+"^"+strbufOrgcode.toString());

				if(rs != null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				hshRec = new HashMap();
				vecVal = new ArrayList();
				while (rs.next())
				{
					vecRecords = new ArrayList();
					vecRecords.add(correctNull(rs.getString("count")));
					vecRecords.add(correctNull(rs.getString("org_name")));
				}
				hshRec.put("strStatus",strStatus);
				hshRec.put("vecValues",vecVal);
				hshRec.put("txtDate",strDate);
				hshRec.put("labels",strSelFields);
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
		}*/
		
		

		private HashMap getAdhocReport(HashMap hshRequestValues) 
{
		ResultSet rs = null;
		ArrayList vecRecords=null;
		HashMap hshRec=null;
		ArrayList vecVal =null;
		String strTemp=null;
		ArrayList vecT = new ArrayList();
		String strvarcbsid = "";
		String strSelFields="",strQuery="",strorgScode="";
		String strOrgCode="";
		String strGen =(String)hshRequestValues.get("strUserId");
		String strFromDate=correctNull((String)hshRequestValues.get("txtFromDate"));
		String strToDate=correctNull((String)hshRequestValues.get("txtToDate"));
		String strOrg=correctNull((String)hshRequestValues.get("hidOrgCode")).replaceAll("'", "");
		String orglevel=correctNull((String)hshRequestValues.get("orglevel"));
		String strpageType=correctNull((String)hshRequestValues.get("pageType"));
		String rptType=correctNull((String)hshRequestValues.get("reportType"));
		
		
		try
		{
			strQuery=SQLParser.getSqlQuery("repbankname^"+strOrg);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strorgScode=correctNull((String)rs.getString("org_scode"));
			}
			strSelFields="CUSTOMER ID,CUSTOMER NAME,ADHOC PROPOSAL NO,ADHOC PROPOSAL SNO,SANCTION LIMIT,CBS ACCOUNT NO,ADHOC DUEDATE,SANCTION REF NO,SANCTION DATE,PARENT PROPOSAL NO,PARENT PROPOSAL SNO";
			StringTokenizer st = new StringTokenizer(strSelFields,",");
			while (st.hasMoreTokens())
			{
				vecT.add(st.nextToken());
			}
			if(rs != null)
				rs.close();
			
			hshRec = new HashMap();
			vecVal = new ArrayList();
		    rs=DBUtils.executeLAPSQuery("sel_adhocReport^"+strFromDate +"^"+strToDate +"^"+strorgScode);

			while (rs.next())
			{
				vecRecords = new ArrayList();
				if (vecT.contains("CUSTOMER ID"))
				{
					strTemp =correctNull(rs.getString("CUSTOMER_ID"));
					vecRecords.add(strTemp);//0
					vecRecords.add("left");		//1								
				}
				if (vecT.contains("CUSTOMER NAME"))
				{
					strTemp =correctNull(rs.getString("CUSTOMER_NAME"));
					vecRecords.add(strTemp);//2
					vecRecords.add("left");//3
				}
				if (vecT.contains("ADHOC PROPOSAL NO"))
				{
					strTemp =correctNull(rs.getString("ADHOC_PROPOSAL_NO"));
					vecRecords.add(strTemp);//4
					vecRecords.add("center");//5
				}
				if (vecT.contains("ADHOC PROPOSAL SNO"))
				{
					strTemp =correctNull(rs.getString("ADHOC_PROPOSAL_SNO"));
					vecRecords.add(strTemp);//6
					vecRecords.add("left");//7
				}
				if (vecT.contains("SANCTION LIMIT"))
				{
					strTemp =Helper.correctDouble(rs.getString("SANCTION_LIMIT"));
					vecRecords.add(Helper.formatDoubleValue(Double.parseDouble(strTemp)));//8
					vecRecords.add("right");	//9
				}
				if (vecT.contains("CBS ACCOUNT NO"))
				{
					strTemp =correctNull(rs.getString("CBS_ACCOUNT_NO"));
					vecRecords.add(strTemp);//10
					vecRecords.add("left");//11
				}
				if (vecT.contains("ADHOC DUEDATE"))
				{
					strTemp =correctNull(rs.getString("ADHOC_DUEDATE"));
					vecRecords.add(strTemp);//12
					vecRecords.add("left");//13
				}
				if (vecT.contains("SANCTION REF NO"))
				{
					strTemp =correctNull(rs.getString("SANCTION_REF_NO"));
					vecRecords.add(strTemp);//14
					vecRecords.add("left");//15
				}
				if (vecT.contains("SANCTION DATE"))
				{
					strTemp =correctNull(rs.getString("SANCTION_DATE"));
					vecRecords.add(strTemp);//16
					vecRecords.add("left");//17
				}
				if (vecT.contains("PARENT PROPOSAL NO"))
				{
					strTemp =Helper.correctNull(rs.getString("PARENT_PROPOSAL_NO"));
					vecRecords.add(strTemp);//18
					vecRecords.add("right");//19
				}
				if (vecT.contains("PARENT PROPOSAL SNO"))
				{
					strTemp =correctNull(rs.getString("PARENT_PROPOSAL_SNO"));
					vecRecords.add(strTemp);//20
					vecRecords.add("left");//21
				}
				
				vecVal.add(vecRecords);
			}
			hshRec.put("vecValues",vecVal);
			hshRec.put("labels",strSelFields);
			hshRec.put("strPageType",strpageType);
			hshRec.put("reportType",rptType);
			hshRec.put("genby",strGen);
			hshRec.put("desc","ADHOC Facility Report");
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
		private HashMap getSpreadSheetTwoExcel(HashMap hshValues) {


			String strEnchancement=null,strOD=null;
			String reportType1="";
			int intRowCount=0,intCellCount=0;
			ArrayList arrCol=new ArrayList();
			try
			{
				hshValues=getspreadreportTwo(hshValues);

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

				
				sheet = wb.createSheet("Spreadsheet Report Two");
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
		private HashMap getspreadreportTwo(HashMap hshValues) {

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
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy");
		       int size=0;
				
			 if (rs != null) {
					rs.close();
				}
	        	strExcelField="APPLICATION NO,APPLICATION SNO,PRODUCT CODE,AMOUNT REQUEST,AMOUNT RECOMMENDED,TENOR,INTEREST TYPE,DEF INTEREST RATE,MOD INTEREST RATE" +
					",MCLR TYPE,REFERENCE SPREAD,CREDIT RISK VALUE,BUSINESS RISK VALUE,ROI TYPE,ROI SCORE,SETUP CORP,SETUP BSP,EXECUTION NO,EXECUTION DATE,EXECUTION FLAG,CREDIT RISK VALUE AFTER,BUSINESS RISK VALUE AFTER,SETUP CORP AFTER,SETUP BSP AFTER" +
					",DEF INTEREST RATE AFTER,MOD INTEREST RATE AFTER,DEVIATION OLD VALUE,DEVIATION NEW VALUE,DEVIATION OLD VALUE AFTER,DEVIATION NEW VALUE AFTER,UPDATE DATE";	
	        	
					rs = DBUtils.executeLAPSQuery("sel_appspreadReport^"+strFromDate+"^"+strToDate);
					while(rs.next()){
						arrCol=new ArrayList();
					
						arrCol.add(Helper.correctNull(rs.getString("APP_NO")));  //0
						arrCol.add(Helper.correctNull(rs.getString("APP_SNO"))); //1
						arrCol.add(Helper.correctNull(rs.getString("APP_PRDCODE"))); //2
						arrCol.add(Helper.correctNull(rs.getString("APP_AMTREQ"))); //3
						arrCol.add(Helper.correctNull(rs.getString("APP_AMTRECMD"))); //4
						arrCol.add(Helper.correctNull(rs.getString("APP_APPTENOR"))); //5
						arrCol.add(Helper.correctNull(rs.getString("APP_INTTYPE"))); //6
						arrCol.add(Helper.correctNull(rs.getString("APP_DEFINTRATE"))); //7
						arrCol.add(Helper.correctNull(rs.getString("APP_MODINTRATE"))); //8
						arrCol.add(Helper.correctNull(rs.getString("APP_MCLRTYPE"))); //9
						arrCol.add(Helper.correctNull(rs.getString("APP_REFERENCESPREAD"))); //10
						arrCol.add(Helper.correctNull(rs.getString("APP_CREDITRSKVAL")));//11
						arrCol.add(Helper.correctNull(rs.getString("APP_BUSINESSRSKVAL")));//12
						arrCol.add(Helper.correctNull(rs.getString("APP_ROITYPE")));//13
						arrCol.add(Helper.correctNull(rs.getString("APP_ROISCORE")));//14
						arrCol.add(Helper.correctNull(rs.getString("APP_SETUPCRP")));//15
						arrCol.add(Helper.correctNull(rs.getString("APP_SETUPBSP")));//16
						arrCol.add(Helper.correctNull(rs.getString("APP_EXECUTIONNO")));//17
						arrCol.add(Helper.correctNull(rs.getString("APP_EXEDATE")));//18
						arrCol.add(Helper.correctNull(rs.getString("APP_EXEFLAG")));//19
						arrCol.add(Helper.correctNull(rs.getString("APP_CREDITRSKVAL_AFTER")));//20
						arrCol.add(Helper.correctNull(rs.getString("APP_BUSINESSRSKVAL_AFTER")));//21
						arrCol.add(Helper.correctNull(rs.getString("APP_SETUPCRP_AFTER"))); //22
						arrCol.add(Helper.correctNull(rs.getString("APP_SETUPBSP_AFTER"))); //23
						arrCol.add(Helper.correctNull(rs.getString("APP_DEFINTRATE_AFTER"))); //24
						arrCol.add(Helper.correctNull(rs.getString("APP_MODINTRATE_AFTER")));//25
						arrCol.add(Helper.correctNull(rs.getString("DEVIATION_OLDVALUE")));//26
						arrCol.add(Helper.correctNull(rs.getString("DEVIATION_NEWVALUE")));//27
						arrCol.add(Helper.correctNull(rs.getString("DEVIATION_OLDVALUE_AFTER")));//28
						arrCol.add(Helper.correctNull(rs.getString("DEVIATION_NEWVALUE_AFTER")));//29
						arrCol.add(Helper.correctNull(rs.getString("APP_UPDATEDATE")));//30
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


}