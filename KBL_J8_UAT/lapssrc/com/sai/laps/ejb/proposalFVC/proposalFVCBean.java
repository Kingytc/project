package com.sai.laps.ejb.proposalFVC;

import java.util.Date;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.excelfunction.ExcelFunctionBean;
import com.sai.laps.ejb.staticdata.staticdataBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "proposalFVCBean", mappedName = "proposalFVCHome")
@Remote (proposalFVCRemote.class)
public class proposalFVCBean extends BeanAdapter
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6247830558007536603L;
	static Logger log=Logger.getLogger(staticdataBean.class);
	/**
	 * 
	 */
	
	public void updatedata(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null,rsOld=null;
		String strQuery ="";
		String strStartdate="";
		String strEnddate="";
		String strFlowStartdate="";
		String strIntDmddate="";
		String strCBSAccountNo= "",strProposal="";
		String strPagetype = Helper.correctNull((String)hshValues.get("hidPageTypeFrom"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno="",strFacSno="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		int intTotAcc=0;
		boolean boolAccins=false;
		
		Connection connTemp = null; 
		CallableStatement CallStmt = null;
		
		java.text.NumberFormat nf= java.text.NumberFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		try
		{
			strStartdate = Helper.correctNull((String)hshValues.get("txt_fromdate"));
			strEnddate = Helper.correctNull((String)hshValues.get("txt_todate"));
			
//			if(strStartdate.equalsIgnoreCase(""))
//			{
//				strStartdate = "01/01/1990";
//			}
//			if(strEnddate.equalsIgnoreCase(""))
//			{
//				strEnddate = Helper.getCurrentDateTime();
//			}
			
			if("delete".equalsIgnoreCase(strAction))
			{
				arrValues = new ArrayList();
				hshQueryValues =  new HashMap();
				hshRecord = new HashMap();
				
				hshRecord.put("strQueryId", "del_FVC_value_proposal");
				hshQueryValues.put("size", "1");
				arrValues.add(Helper.correctNull((String)hshValues.get("hidAppNo")));
				arrValues.add( Helper.correctNull((String)hshValues.get("sel_facilitysno")));
				hshRecord.put("arrValues", arrValues);
				hshQueryValues.put("1", hshRecord);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
			}
			else if("flatfile".equalsIgnoreCase(strAction))
			{
				log.info("********** FVC_FILE_UPLOAD Procedure Started  ************");
				
				connTemp = ConnectionFactory.getConnection();
				CallStmt = connTemp.prepareCall("call FVC_FILE_UPLOAD()");
				CallStmt.execute();
				CallStmt.clearParameters();
				CallStmt.close();
				connTemp.close();
				
				log.info("********** FVC_FILE_UPLOAD Procedure Completed  ************");
			}
			else
			{			
			//To select and insert the restructured accounts into FVC_CALCULATION table
				if(strPagetype.equalsIgnoreCase("P"))
				{
					strProposal="Y";
					strFlowStartdate = Helper.correctNull((String)hshValues.get("txt_flowstartdate"));
					strIntDmddate = Helper.correctNull((String)hshValues.get("txt_intdmddate"));
					strAppno = Helper.correctNull((String)hshValues.get("hidAppNo"));
					strFacSno = Helper.correctNull((String)hshValues.get("sel_facilitysno"));
					strQuery = SQLParser.getSqlQuery("sel_restructured_accounts_FVC_One^"+strAppno+"^"+strFacSno+"^"+strAppno);
				}
				else
				{
					//Modification done by punitha on 21/06/2019 as per guhan instruction
					//strQuery = SQLParser.getSqlQuery("sel_restructured_accounts_FVC^"+strStartdate+"^"+strEnddate+"^"+strStartdate+"^"+strEnddate);	
					strQuery = SQLParser.getSqlQuery("sel_restructured_accounts_FVC");	
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					boolAccins=false;
					arrValues = new ArrayList();
					hshQueryValues =  new HashMap();
					hshRecord = new HashMap();
					
					String strFacAppno=Helper.correctNull((String)rs.getString("FACILITY_APPNO"));
					String strFacSlno=Helper.correctInt((String)rs.getString("FACILITY_SNO"));
					
					if(!strPagetype.equalsIgnoreCase("P"))
					{
						if(rsOld!=null)
							rsOld.close();
						strQuery=SQLParser.getSqlQuery("sel_LAPSaccountdetails^"+Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"))+"^"+Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO")));
						rsOld = DBUtils.executeQuery(strQuery);
						if(rsOld.next())
						{
							strFacAppno=Helper.correctNull(rsOld.getString("FACILITY_APPNO"));
							strFacSlno=Helper.correctNull(rsOld.getString("FACILITY_SNO"));
						}
					}
					
					hshRecord.put("strQueryId", "ins_restructured_accounts_FVC");
					hshQueryValues.put("size", "1");
					arrValues.add(strFacAppno);
					arrValues.add(strFacSlno);
					arrValues.add(Helper.correctNull((String)rs.getString("PERAPP_CBSID")));
					arrValues.add(Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO")));
					arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_FITL_ACC")));
					
					if(Helper.correctNull((String)rs.getString("FACILITY_FITL_ACC")).equalsIgnoreCase("Y"))
					{
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add(strFlowStartdate);
						arrValues.add(strIntDmddate);
						arrValues.add(strProposal);
						boolAccins=true;
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("sel_old_acc_no_Restructure^"+strFacAppno+"^"+strFacSlno);
						rsOld = DBUtils.executeQuery(strQuery);
						if(rsOld.next())
						{
							arrValues.add(Helper.correctNull((String)rsOld.getString("APP_EXAPPNO")));
							arrValues.add(Helper.correctNull((String)rsOld.getString("APP_EXAPPSNO")));
							arrValues.add(Helper.correctNull((String)rsOld.getString("APP_EXAPPCBSACCNO")));
							arrValues.add(strFlowStartdate);
							arrValues.add(strIntDmddate);
							arrValues.add(strProposal);
							boolAccins=true;
						}
						else
						{
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							arrValues.add(strFlowStartdate);
							arrValues.add(strIntDmddate);
							arrValues.add(strProposal);
							boolAccins=true;
						}
					}
					hshRecord.put("arrValues", arrValues);
					hshQueryValues.put("1", hshRecord);
					
					if(boolAccins)
					{
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
					}
				}
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error on proposalFVCBean -> updatedata==== "+e.toString());
		}
	}
	
	public HashMap getdata(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		ResultSet rs=null,rsGet = null;
		String strQuery = "";
		String strFromDate = "";
		String strToDate = "";
		String strSortType = "",strPageType="",strAppno="",strFacSno="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		strFromDate = Helper.correctNull((String)hshValues.get("txt_fromdate"));
		strToDate = Helper.correctNull((String)hshValues.get("txt_todate"));
		strAppno = Helper.correctNull((String)hshValues.get("hidAppNo"));
		strFacSno = Helper.correctNull((String)hshValues.get("sel_facilitysno"));
		strSortType = Helper.correctNull((String)hshValues.get("hidSortType"));
		strPageType = Helper.correctNull((String)hshValues.get("hidPageTypeFrom"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			if(strAction.equalsIgnoreCase("flatfile"))
			{
				strQuery = SQLParser.getSqlQuery("sel_vw_fvc_accounts_entry");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("File_Upload", "S");
				}
				else
				{
					hshRecord.put("File_Upload", "F");
				}
			}
			if(strPageType.equalsIgnoreCase("P"))
			{
				hshRecord.put("strFacSno", strFacSno);
				strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_one^"+strAppno+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("flowstartdate", Helper.correctNull((String)rs.getString("FVC_FLOWSTRTDATE_PROPOSAL")));
					hshRecord.put("IntDmdDate", Helper.correctNull((String)rs.getString("FVC_INTDMDDATE_PROPOSAL")));
					hshRecord.put("BeforeVal", Helper.correctDouble((String)rs.getString("FVC_BEFORE_XNPV")));
					hshRecord.put("AfterVal", Helper.correctDouble((String)rs.getString("FVC_AFTER_XNPV")));
					hshRecord.put("Fairvalue", Helper.correctDouble((String)rs.getString("FVC_PROFIT_LOSS")));
				}
				
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_FVC_acc_available^"+strAppno+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("Accflag", "Y");
				}
				
				if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
				{
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_facLoanRepayType_Ret^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("repay_type", Helper.correctNull((String)rs.getString("LOAN_REPAYMENTTYPE")));
					}
				}
				else
				{
					if(rs!=null)rs.close();
					strQuery = SQLParser.getSqlQuery("sel_facLoanRepayType_Corp^"+strAppno+"^"+strFacSno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("repay_type", Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE")));
					}
				}
			}
			else
			{
				if(strSortType.equalsIgnoreCase("A"))
				{
					strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_result_Acc^"+Helper.getCurrentDateTime()+"^"+Helper.getCurrentDateTime());
					rsGet = DBUtils.executeQuery(strQuery);
					while(rsGet.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rsGet.getString("CBS_ACCOUNTNO")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("CBS_ACCOUNTNO_OLD")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CBS_ID")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("borrower")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_BEFORE_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_AFTER_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_PROFIT_LOSS")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CALC_DATE")));
						arrRow.add(arrCol);
					}
				}
				else if(strSortType.equalsIgnoreCase("B"))
				{
					strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_result_borr^"+Helper.getCurrentDateTime()+"^"+Helper.getCurrentDateTime());
					rsGet = DBUtils.executeQuery(strQuery);
					while(rsGet.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CBS_ID")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("borrower")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_BEFORE_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_AFTER_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_PROFIT_LOSS")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CALC_DATE")));
						arrRow.add(arrCol);
					}
				}
				
				hshRecord.put("fromdate",strFromDate);
				hshRecord.put("todate",strToDate);
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("strSortType",strSortType);
				hshRecord.put("hidReport",Helper.correctNull((String)hshValues.get("hidReport")));
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getdata -->"+e.toString());
		}
		return hshRecord;
	}

	public void updateFVCaccounts(HashMap hshValues)
	{
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null,rsAcc=null,rsDate=null;
		String strQuery ="";
		String strQuery1 ="";
		String strStartdate="";
		String strEnddate="";
		String strAppno="",strSno="",strCBSAccountNo= "",strCBSAccountNo1="",strType="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		int intTotAcc=0,intfreqvalue=0;
		boolean boolTypeChk=false;
		String strModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
		String strPageType = Helper.correctNull((String)hshValues.get("hidPageTypeFrom"));
		String strCalcAppNo = "";
		String strFacSno = "";
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date date1 = null;
		Date date2 = null;
		
		try
		{
			//From proposal FVC calculation page
			if(strPageType.equalsIgnoreCase("P"))
			{
				strCalcAppNo = Helper.correctNull((String)hshValues.get("hidAppNo"));
				strFacSno = Helper.correctNull((String)hshValues.get("sel_facilitysno"));
				strQuery = SQLParser.getSqlQuery("sel_accountsforcalc_FVC_one^"+strCalcAppNo+"^"+strFacSno+"^"+strCalcAppNo+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(boolTypeChk == false && Helper.correctNull((String)rs.getString("FVC_FITL_ACC")).equalsIgnoreCase("Y"))
					{
						boolTypeChk = true;
						continue;
					}
					if(boolTypeChk == false)
					{
						strAppno = Helper.correctNull((String)rs.getString("FVC_PROPOSAL_NO_OLD"));
						strSno = Helper.correctNull((String)rs.getString("FVC_PROPOSAL_SNO_OLD"));
						strCBSAccountNo = Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO_OLD"));
						boolTypeChk = true;
						strType = "B";
					}
					else
					{
						strAppno = Helper.correctNull((String) rs.getString("FVC_PROPOSAL_NO"));
						strSno = Helper.correctNull((String) rs.getString("FVC_PROPOSAL_SNO"));
						strCBSAccountNo = Helper.correctNull((String) rs.getString("CBS_ACCOUNTNO"));
						strType = "A";
						boolTypeChk = false;
					}
					
					if(strType.equalsIgnoreCase("B"))
					{
						if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
							strQuery = SQLParser.getSqlQuery("sel_acc_details_FVC_newconnection^"+strCBSAccountNo+"^"+Helper.correctNull((String)rs.getString("FVC_CBS_ID"))+"^ and SHDL_STATUS='A'");
						}
						else
						{
							strQuery = SQLParser.getSqlQuery("sel_acc_details_FVC^"+strCBSAccountNo+"^"+Helper.correctNull((String)rs.getString("FVC_CBS_ID")));
						}
						rsAcc = DBUtils.executeQuery(strQuery);
						
						while(rsAcc.next())
						{
							arrValues = new ArrayList();
							hshQueryValues =  new HashMap();
							hshRecord = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues.add(strAppno);
							arrValues.add(strSno);
							arrValues.add(Helper.correctNull((String)rsAcc.getString("FORACID")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("ACCT_NAME")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("CUST_ID")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("CLR_BAL_AMT")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("FLOW_ID")));
							arrValues.add(strType);
							arrValues.add(Helper.correctNull((String)rsAcc.getString("NUM_OF_FLOWS")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("FLOW_AMT")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("FLOW_START_DATE")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("IDMD_EFF_DATE")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("ROI")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("SHDL_NUM")));
							arrValues.add(Helper.correctNull((String)rsAcc.getString("DUE_DATE")));
							hshRecord.put("arrValues", arrValues);
							hshRecord.put("strQueryId", "ins_FVCacc_details");
							hshQueryValues.put("1", hshRecord);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
					}
					else if(strType.equalsIgnoreCase("A"))
					{
						String strRepayType="",strBorrName="",strCBSid="",strSancAmt="",strDueDate="",strIntrate="",strInstallFreq="",strTenor="",strHoliday="";
						String strFlowstrtDate = Helper.correctNull((String)hshValues.get("txt_flowstartdate"));
						String strIntDmdDate = Helper.correctNull((String)hshValues.get("txt_intdmddate"));
						ResultSet rs1 = null,rs2=null;
						if(strModuleType.equalsIgnoreCase("CORP")||strModuleType.equalsIgnoreCase("AGR"))
						{
							strQuery = SQLParser.getSqlQuery("sel_repaytype_corp^"+strCalcAppNo+"^"+strFacSno);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								strBorrName = Helper.correctNull((String)rs1.getString("PERAPP_FNAME")); 
								strCBSid = Helper.correctNull((String)rs1.getString("PERAPP_CBSID")); 
								strSancAmt = Helper.correctNull((String)rs1.getString("FACILITY_PROPOSED")); 
								strRepayType = Helper.correctNull((String)rs1.getString("FACILITY_REPAYTYPE")); 
								strDueDate = Helper.correctNull((String)rs1.getString("FACILITY_DUEDATE")); 
								strIntrate = Helper.correctNull((String)rs1.getString("BPLR")); 
								strInstallFreq = Helper.correctNull((String)rs1.getString("FACILITY_PERINSTALL")); 
								strTenor = Helper.correctNull((String)rs1.getString("FACILITY_MONTHS")); 
								strHoliday = Helper.correctNull((String)rs1.getString("FACILITY_HOLIDAYPERIOD")); 
							}
						}
						else
						{
							strFacSno = "1";
							strQuery = SQLParser.getSqlQuery("sel_repaytype^"+strCalcAppNo);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								strBorrName = Helper.correctNull((String)rs1.getString("PERAPP_FNAME")); 
								strCBSid = Helper.correctNull((String)rs1.getString("PERAPP_CBSID")); 
								strSancAmt = Helper.correctNull((String)rs1.getString("LOAN_RECMDAMT")); 
								strRepayType = Helper.correctNull((String)rs1.getString("LOAN_REPAYMENTTYPE")); 
								strIntrate = Helper.correctNull((String)rs1.getString("LOAN_MODINTRATE")); 
								strInstallFreq = Helper.correctNull((String)rs1.getString("LOAN_PERIODICITY"));
								strTenor = Helper.correctNull((String)rs1.getString("LOAN_REQTERMS"));
								strHoliday = Helper.correctNull((String)rs1.getString("LOAN_NOOFINSTALLMENT"));
							} 
						}
							
						if(strRepayType.equalsIgnoreCase("NE"))
						{
							strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"+strCalcAppNo+"^"+strFacSno);
							rs2 = DBUtils.executeQuery(strQuery);
							
							if(strInstallFreq.equalsIgnoreCase("Q"))
								intfreqvalue=3;
							else if(strInstallFreq.equalsIgnoreCase("H"))
								intfreqvalue=6;
							else if(strInstallFreq.equalsIgnoreCase("T"))
								intfreqvalue=9;
							else if(strInstallFreq.equalsIgnoreCase("Y"))
								intfreqvalue=12;
							else if(strInstallFreq.equalsIgnoreCase("M"))
								intfreqvalue=1;
							
								
							while(rs2.next())
							{
								strFlowstrtDate = Helper.addMonthWithDate(sdf.parse(strFlowstrtDate),intfreqvalue);
								arrValues = new ArrayList();
								hshQueryValues =  new HashMap();
								hshRecord = new HashMap();
								hshQueryValues.put("size", "1");
								arrValues.add(strCalcAppNo);
								arrValues.add(strFacSno);
								arrValues.add("");
								arrValues.add(strBorrName);
								arrValues.add(strCBSid);
								arrValues.add(strSancAmt);
								arrValues.add(strRepayType);
								arrValues.add(strType);
								arrValues.add(Helper.correctNull((String)rs2.getString("TL_NOOFINST")));
								arrValues.add(Helper.correctNull((String)rs2.getString("TL_INSTAMT")));
								arrValues.add(strFlowstrtDate);
								arrValues.add(strInstallFreq);
								arrValues.add(strIntDmdDate);
								arrValues.add(strIntrate);
								arrValues.add(Helper.correctNull((String)rs2.getString("tl_slno")));
								arrValues.add("");
								hshRecord.put("arrValues", arrValues);
								hshRecord.put("strQueryId", "ins_FVCacc_details");
								hshQueryValues.put("1", hshRecord);
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
							}
						}
						else if(strRepayType.equalsIgnoreCase("E"))
						{
							double dblNum = Double.parseDouble(strSancAmt)*(Double.parseDouble(strIntrate)/1200)*(Math.pow(1+(Double.parseDouble(strIntrate)/1200), Double.parseDouble(strTenor)));
							double dblDenom = (Math.pow(1+(Double.parseDouble(strIntrate)/1200), Double.parseDouble(strTenor)))-1;
							String strEMI = String.valueOf(Math.ceil(dblNum/dblDenom));
							
							arrValues = new ArrayList();
							hshQueryValues =  new HashMap();
							hshRecord = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues.add(strCalcAppNo);
							arrValues.add(strFacSno);
							arrValues.add("");
							arrValues.add(strBorrName);
							arrValues.add(strCBSid);
							arrValues.add(strSancAmt);
							arrValues.add(strRepayType);
							arrValues.add(strType);
							arrValues.add(String.valueOf(Integer.parseInt(strTenor) - Integer.parseInt(strHoliday)));
							arrValues.add(strEMI);
							arrValues.add(strFlowstrtDate);
							arrValues.add(strInstallFreq);
							arrValues.add(strIntDmdDate);
							arrValues.add(strIntrate);
							arrValues.add("1");
							arrValues.add("");
							hshRecord.put("arrValues", arrValues);
							hshRecord.put("strQueryId", "ins_FVCacc_details");
							hshQueryValues.put("1", hshRecord);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
						else
						{
							arrValues = new ArrayList();
							hshQueryValues =  new HashMap();
							hshRecord = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues.add(strCalcAppNo);
							arrValues.add(strFacSno);
							arrValues.add("");
							arrValues.add(strBorrName);
							arrValues.add(strCBSid);
							arrValues.add(strSancAmt);
							arrValues.add("O");
							arrValues.add(strType);
							arrValues.add("1");
							arrValues.add(strSancAmt);
							arrValues.add(strDueDate);
							arrValues.add(strInstallFreq);
							arrValues.add(strIntDmdDate);
							arrValues.add(strIntrate);
							arrValues.add("1");
							arrValues.add("");
							hshRecord.put("arrValues", arrValues);
							hshRecord.put("strQueryId", "ins_FVCacc_details");
							hshQueryValues.put("1", hshRecord);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
					}
				}
				if(rs!=null)
					rs.close();
			}
			//To select the accounts and get the details from DC
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_accountsforcalc_FVC");
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(boolTypeChk == false && Helper.correctNull((String)rs.getString("FVC_FITL_ACC")).equalsIgnoreCase("Y"))
					{
						boolTypeChk = true;
						continue;
					}
					if(boolTypeChk == false)
					{
						strAppno = Helper.correctNull((String)rs.getString("FVC_PROPOSAL_NO_OLD"));
						strSno = Helper.correctNull((String)rs.getString("FVC_PROPOSAL_SNO_OLD"));
						//strCBSAccountNo = Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO_OLD"));
						//if(strCBSAccountNo.equalsIgnoreCase(""))
						strCBSAccountNo = Helper.correctNull((String) rs.getString("CBS_ACCOUNTNO"));
						
						strCBSAccountNo1 = Helper.correctNull((String) rs.getString("CBS_ACCOUNTNO"));
						boolTypeChk = true;
						strType = "B";
					}
					else
					{
						strAppno = Helper.correctNull((String) rs.getString("FVC_PROPOSAL_NO"));
						strSno = Helper.correctNull((String) rs.getString("FVC_PROPOSAL_SNO"));
						strCBSAccountNo = Helper.correctNull((String) rs.getString("CBS_ACCOUNTNO"));
						strCBSAccountNo1 = Helper.correctNull((String) rs.getString("CBS_ACCOUNTNO_OLD"));
						strType = "A";
						boolTypeChk = false;
					}
					
					/*if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						if(strCBSAccountNo.equalsIgnoreCase(strCBSAccountNo1))
							strQuery = SQLParser.getSqlQuery("sel_acc_details_FVC_newconnection^"+strCBSAccountNo+"^"+Helper.correctNull((String)rs.getString("FVC_CBS_ID"))+"^and SHDL_STATUS='"+strType+"'");
						else
							strQuery = SQLParser.getSqlQuery("sel_acc_details_FVC_newconnection^"+strCBSAccountNo+"^"+Helper.correctNull((String)rs.getString("FVC_CBS_ID"))+"^ ");
					}
					else*/
					{
						strQuery = SQLParser.getSqlQuery("sel_acc_details_FVC^"+strCBSAccountNo+"^"+Helper.correctNull((String)rs.getString("FVC_CBS_ID"))+"^"+strType);
						//strQuery = SQLParser.getSqlQuery("select_acc_details_FVC");
					}
					rsAcc = DBUtils.executeQuery(strQuery);
					String FlowDate = "";int intFlowValue=0;
					boolean boolFirstFlow = true;
					while(rsAcc.next())
					{
						if(boolFirstFlow)
						{
							FlowDate = Helper.correctNull((String)rsAcc.getString("FLOW_START_DATE"));
							boolFirstFlow = false;
						}
						arrValues = new ArrayList();
						hshQueryValues =  new HashMap();
						hshRecord = new HashMap();
						hshQueryValues.put("size", "1");
						arrValues.add(strAppno);
						arrValues.add(strSno);
						arrValues.add(Helper.correctNull((String)rsAcc.getString("FORACID")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("ACCT_NAME")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("CUST_ID")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("CLR_BAL_AMT")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("FLOW_ID")));
						arrValues.add(strType);
//						arrValues.add(Helper.correctNull((String)rsAcc.getString("SHDL_STATUS")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("NUM_OF_FLOWS")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("FLOW_AMT")));
						arrValues.add(FlowDate);
						arrValues.add(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")));
						
						if(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")).equalsIgnoreCase("m"))
							intFlowValue = 1 * Integer.parseInt(Helper.correctInt((String)rsAcc.getString("NUM_OF_FLOWS")));
						else if(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")).equalsIgnoreCase("q"))
							intFlowValue = 3 * Integer.parseInt(Helper.correctInt((String)rsAcc.getString("NUM_OF_FLOWS")));
						else if(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")).equalsIgnoreCase("h"))
							intFlowValue = 6 * Integer.parseInt(Helper.correctInt((String)rsAcc.getString("NUM_OF_FLOWS")));
						else if(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")).equalsIgnoreCase("t"))
							intFlowValue = 9 * Integer.parseInt(Helper.correctInt((String)rsAcc.getString("NUM_OF_FLOWS")));
						else if(Helper.correctNull((String)rsAcc.getString("LR_FREQ_TYPE")).equalsIgnoreCase("y"))
							intFlowValue = 12 * Integer.parseInt(Helper.correctInt((String)rsAcc.getString("NUM_OF_FLOWS")));
						
						strQuery1 = SQLParser.getSqlQuery("sel_add_months^"+FlowDate+"^"+intFlowValue);
						rsDate = DBUtils.executeQuery(strQuery1);
						if(rsDate.next())
						{
							FlowDate = Helper.correctNull((String)rsDate.getString(1));
						}
						//FlowDate = Helper.addMonthWithDate(sdf.parse(FlowDate), intFlowValue);
						
						arrValues.add(Helper.correctNull((String)rsAcc.getString("IDMD_EFF_DATE")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("ROI")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("SHDL_NUM")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("DUE_DATE")));
						arrValues.add(Helper.correctNull((String)rsAcc.getString("DISC_RATE")));
						hshRecord.put("arrValues", arrValues);
						hshRecord.put("strQueryId", "ins_FVCacc_details");
						hshQueryValues.put("1", hshRecord);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					}
				}
				if(rs!=null)
					rs.close();
				if(rsAcc!=null)
					rsAcc.close();
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error on proposalFVCBean -> updatedata==== "+e.toString());
		}
	}
	
	public HashMap getFVCaccounts(HashMap hshValues)
	{
		HashMap hshExcelData = new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		String strQuery="";
		ResultSet rs=null,rs5=null,rs7=null,rs9=null,rsFVC=null,rsGet=null,rsDis1=null,rsDis2=null,rsDis3=null;
		ArrayList arrBeforedate = new ArrayList();
		ArrayList arrBeforePrin = new ArrayList();
		ArrayList arrBeforeInt = new ArrayList();
		ArrayList arrBeforeOS = new ArrayList();
		ArrayList arrBeforecashflow = new ArrayList();
		String strOSbal="",strIntrate="",strflowamt="",strDueValue="0",strDueValuePrev="0";
		String strRepayType="",strDiscRate="",strFVCtype="",strInsFreq="",strBorrName="";
		int intnoofflows=0,intfreqvalue=0,intdatediff=0;
		String strIntDmdDate="",strTotFlowStrtDate="",strCalcAppNo="",strFacSno="";
		String strCurrentdate="",strCurrentdate1="",strCalDate = "",strFlowStrtDate="",strCalDate1="";
				
		String strNumeVal="",strDenomVal="",strFairVal="0.00",strType="";
		String strDatsDiffFV="",strAppno="",strSno="",strCBSaccno="",strDueDate="";
		
		String strBaserate="0.00",strDefaultPrem="0.00",strTenorPrem="0.00",strRatingPrem="0.00",strDiscIntrate="0.00";
		String strPageType = Helper.correctNull((String)hshValues.get("hidPageTypeFrom"));
		String strBeforeVal="0.00",strAfterVal = "0.00",strFVProfitLoss = "";
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		Date date1 = null;
		Date date2 = null;
		
		Date date3 = null;
		Date date4 = null;
			
		boolean boolCheckFlag=false,boolTypeChk=false,boolInsert=false,boolMidDate=false,boolEMIbackDate=false,boolDueOver=false;
			
		try
		{
			if(strPageType.equalsIgnoreCase("P"))
			{
				strCalcAppNo = Helper.correctNull((String)hshValues.get("hidAppNo"));
				strFacSno = Helper.correctNull((String)hshValues.get("sel_facilitysno"));
				strQuery = SQLParser.getSqlQuery("sel_accountsforcalc_FVC_one^"+strCalcAppNo+"^"+strFacSno+"^"+strCalcAppNo+"^"+strFacSno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_accountsforcalc_FVC");
			}
			rsFVC = DBUtils.executeQuery(strQuery);
			while(rsFVC.next())
			{
				boolInsert = false;
				boolDueOver = false;
				if(boolTypeChk == false && Helper.correctNull((String)rsFVC.getString("FVC_FITL_ACC")).equalsIgnoreCase("Y"))
				{
					strBeforeVal = "0.00";
					boolTypeChk = true;
					continue;
				}
				if(boolTypeChk == false)
				{
					strAppno = Helper.correctNull((String)rsFVC.getString("FVC_PROPOSAL_NO_OLD"));
					strSno = Helper.correctNull((String)rsFVC.getString("FVC_PROPOSAL_SNO_OLD"));
					//strCBSaccno = Helper.correctNull((String)rsFVC.getString("CBS_ACCOUNTNO_OLD"));
					//if(strCBSaccno.equalsIgnoreCase(""))
					strCBSaccno = Helper.correctNull((String)rsFVC.getString("CBS_ACCOUNTNO"));
					boolTypeChk = true;
					strType = "B";
				}
				else
				{
					strAppno = Helper.correctNull((String)rsFVC.getString("FVC_PROPOSAL_NO"));
					strSno = Helper.correctNull((String)rsFVC.getString("FVC_PROPOSAL_SNO"));
					strCBSaccno = Helper.correctNull((String)rsFVC.getString("CBS_ACCOUNTNO"));
					strType = "A";
					boolTypeChk = false;
				}
				hshExcelData.put("strCBSaccno", strCBSaccno);
				
				strQuery = SQLParser.getSqlQuery("sel_FVC_cashflow^"+strCBSaccno+"^"+strType);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strBorrName = Helper.correctNull((String)rs.getString("FVC_BORROWER_NAME"));
					strRepayType = Helper.correctNull((String)rs.getString("FVC_REPAY_TYPE"));
					strDiscRate = Helper.correctNull((String)rs.getString("FVC_DISCRATE"));
			//For Non EMI Accounts
					if(strRepayType.equalsIgnoreCase("NE") || strRepayType.equalsIgnoreCase("O") || strRepayType.equalsIgnoreCase("N") || strRepayType.equalsIgnoreCase("OD"))
					{						
						strFlowStrtDate = Helper.correctNull((String)rs.getString("FVC_FLOW_START_DATE"));
						boolMidDate =false;
						if(!strFlowStrtDate.equalsIgnoreCase(Helper.addMonthWithLastDate(sdf.parse(strFlowStrtDate), 0)))
						{
							boolMidDate = true;
						}
						
//							strCurrentdate = Helper.getCurrentDateTime();
						strCurrentdate = Helper.correctNull((String)hshValues.get("hid_calc_date"));
						strCurrentdate1 = strCurrentdate;
						
						strCalDate = strFlowStrtDate;
						strCalDate1 = strFlowStrtDate;
						if(!boolCheckFlag)
						{
							strOSbal = Helper.correctNull((String)rs.getString("FVC_OS_BAL"));
							strIntrate = Helper.correctNull((String)rs.getString("FVC_INT_RATE"));
							strIntDmdDate = Helper.correctNull((String)rs.getString("FVC_DMD_EFF_DATE"));
							strInsFreq = Helper.correctNull((String)rs.getString("FVC_PAYMENT_FREQ"));
							strFVCtype = Helper.correctNull((String)rs.getString("FVC_TYPE"));
							strDueDate = Helper.correctNull((String)rs.getString("FVC_DUEDATE"));
							
							if(strRepayType.equalsIgnoreCase("O") || strRepayType.equalsIgnoreCase("OD"))
							{
								strIntDmdDate = strCurrentdate1;
								strInsFreq = "M";
							}
							
							if(strInsFreq.equalsIgnoreCase("Q"))
								intfreqvalue=3;
							else if(strInsFreq.equalsIgnoreCase("H"))
								intfreqvalue=6;
							else if(strInsFreq.equalsIgnoreCase("T"))
								intfreqvalue=9;
							else if(strInsFreq.equalsIgnoreCase("Y"))
								intfreqvalue=12;
							else if(strInsFreq.equalsIgnoreCase("M"))
								intfreqvalue=1;
							
							strQuery = SQLParser.getSqlQuery("getDiffvehicledate^"+strFlowStrtDate+"^"+strCurrentdate);
							rs9 = DBUtils.executeQuery(strQuery);
							if(rs9.next())
								intdatediff =  Integer.parseInt(Helper.correctInt((String)rs9.getString("years")));
							for(int i=1;i<=intdatediff;i++)
							{
								arrBeforedate.add(strCurrentdate);
								arrBeforePrin.add("0.00");
								strCurrentdate = Helper.addMonthWithLastDate(sdf.parse(strCurrentdate1), i);
							}
							
							if(boolMidDate)
							{
								arrBeforedate.add(strCurrentdate);
								arrBeforePrin.add("0.00");
							}
							
							boolCheckFlag=true;
						}
						
						//For Handling Improper schedules
						strInsFreq = Helper.correctNull((String)rs.getString("FVC_PAYMENT_FREQ"));
						if(strRepayType.equalsIgnoreCase("O") || strRepayType.equalsIgnoreCase("OD"))
						{
							strIntDmdDate = strCurrentdate1;
							strInsFreq = "M";
						}
						
						if(strInsFreq.equalsIgnoreCase("Q"))
							intfreqvalue=3;
						else if(strInsFreq.equalsIgnoreCase("H"))
							intfreqvalue=6;
						else if(strInsFreq.equalsIgnoreCase("T"))
							intfreqvalue=9;
						else if(strInsFreq.equalsIgnoreCase("Y"))
							intfreqvalue=12;
						else if(strInsFreq.equalsIgnoreCase("M"))
							intfreqvalue=1;
						
						strflowamt = Helper.correctNull((String)rs.getString("FVC_FLOW_AMT"));
						intnoofflows = Integer.parseInt(Helper.correctInt((String)rs.getString("FVC_NO_OF_FLOWS")));
											
						strTotFlowStrtDate="";
						
						for(int i=0;i<intnoofflows*intfreqvalue;i=i+intfreqvalue)
						{
							if(boolMidDate)
							strTotFlowStrtDate = strTotFlowStrtDate+Helper.addMonthWithDate(sdf.parse(strFlowStrtDate), i)+"@";//New line
							else
							strTotFlowStrtDate = strTotFlowStrtDate+Helper.addMonthWithLastDate(sdf.parse(strFlowStrtDate), i)+"@";
						}
						for(int i=1;i<=(intnoofflows*intfreqvalue);i++)
						{
							date1 = sdf.parse(strCalDate);
							date2 = sdf.parse(strCurrentdate);
							date3 = sdf.parse(strDueDate);
		
							int mindate =  date1.compareTo(date2);
							int mindate1 =  date3.compareTo(date2);
							
							if(mindate1 >= 0)
							{
								if(strTotFlowStrtDate.contains(strCalDate) && mindate>=0)
								{
									arrBeforedate.add(strCalDate);
									arrBeforePrin.add(String.valueOf(strflowamt));
									if(boolMidDate)
									{
										arrBeforedate.add(Helper.addMonthWithLastDate(sdf.parse(strCalDate), 0));
										arrBeforePrin.add("0.00");
									}
								}
								else if (mindate>=0) 
								{
									if(boolMidDate)
									{
										arrBeforedate.add(Helper.addMonthWithLastDate(sdf.parse(strCalDate), 0));
										arrBeforePrin.add("0.00");
									}
									else
									{
										arrBeforedate.add(strCalDate);
										arrBeforePrin.add("0.00");
									}
								}
							}
							else
							{
								boolDueOver = true;
							}
							
							if(boolMidDate)
							strCalDate = Helper.addMonthWithDate(sdf.parse(strCalDate1), i);
							else
							strCalDate = Helper.addMonthWithLastDate(sdf.parse(strCalDate1), i);
						}
					}
					
			//For EMI Accounts
					if(strRepayType.equalsIgnoreCase("E"))
					{
						strFlowStrtDate = Helper.correctNull((String)rs.getString("FVC_FLOW_START_DATE"));
						
//							strCurrentdate = Helper.getCurrentDateTime();
						strCurrentdate = Helper.correctNull((String)hshValues.get("hid_calc_date"));
						strCurrentdate1 = strCurrentdate;
						
						strCalDate = strFlowStrtDate;
						strCalDate1 = strFlowStrtDate;
						
						if(!boolCheckFlag)
						{
							strOSbal = Helper.correctNull((String)rs.getString("FVC_OS_BAL"));
							strIntrate = Helper.correctNull((String)rs.getString("FVC_INT_RATE"));
							strIntDmdDate = Helper.correctNull((String)rs.getString("FVC_DMD_EFF_DATE"));
							strInsFreq = Helper.correctNull((String)rs.getString("FVC_PAYMENT_FREQ"));
							strFVCtype = Helper.correctNull((String)rs.getString("FVC_TYPE"));
							strDueDate = Helper.correctNull((String)rs.getString("FVC_DUEDATE"));
							
							if(strInsFreq.equalsIgnoreCase("Q"))
								intfreqvalue=3;
							else if(strInsFreq.equalsIgnoreCase("H"))
								intfreqvalue=6;
							else if(strInsFreq.equalsIgnoreCase("T"))
								intfreqvalue=9;
							else if(strInsFreq.equalsIgnoreCase("Y"))
								intfreqvalue=12;
							else if(strInsFreq.equalsIgnoreCase("M"))
								intfreqvalue=1;
							
							strQuery = SQLParser.getSqlQuery("getDiffvehicledate^"+strFlowStrtDate+"^"+strCurrentdate);
							rs9 = DBUtils.executeQuery(strQuery);
							if(rs9.next())
								intdatediff =  Integer.parseInt(Helper.correctInt((String)rs9.getString("years")));
							for(int i=1;i<=intdatediff;i++)
							{
								arrBeforedate.add(strCurrentdate);
								arrBeforePrin.add("0.00");
								strCurrentdate = Helper.addMonthWithDate(sdf.parse(strCurrentdate1), i);
								boolEMIbackDate = true;
							}
							
							if(!boolEMIbackDate)
							{
								arrBeforedate.add(strCurrentdate);
								arrBeforePrin.add("0.00");
							}
							
							boolCheckFlag=true;
						}
							
						strflowamt = Helper.correctNull((String)rs.getString("FVC_FLOW_AMT"));
						intnoofflows = Integer.parseInt(Helper.correctInt((String)rs.getString("FVC_NO_OF_FLOWS")));
											
						strTotFlowStrtDate="";
						
						for(int i=0;i<intnoofflows*intfreqvalue;i=i+intfreqvalue)
						{
							strTotFlowStrtDate = strTotFlowStrtDate+Helper.addMonthWithDate(sdf.parse(strFlowStrtDate), i)+"@";
						}
						for(int i=1;i<=(intnoofflows*intfreqvalue);i++)
						{
							date1 = sdf.parse(strCalDate);
							date2 = sdf.parse(strCurrentdate);
							date3 = sdf.parse(strDueDate);
		
							int mindate =  date1.compareTo(date2);
							int mindate1 =  date3.compareTo(date2);
							
							if(mindate1 >= 0)
							{
								if(strTotFlowStrtDate.contains(strCalDate) && mindate>=0 && !strCalDate.equalsIgnoreCase(strCurrentdate1))
								{
									arrBeforedate.add(strCalDate);
									arrBeforePrin.add(String.valueOf(strflowamt));
								}
								else if (mindate>=0 && !strCalDate.equalsIgnoreCase(strCurrentdate1)) 
								{
									arrBeforedate.add(strCalDate);
									arrBeforePrin.add("0.00");
								}
							}
							else
							{
								boolDueOver = true;
							}
							
							strCalDate = Helper.addMonthWithDate(sdf.parse(strCalDate1), i);
						}
					}
				}
				
				if(boolDueOver && (arrBeforedate.size() == 0))
				{
					arrBeforedate.add(strCalDate);
					arrBeforePrin.add("0.00");
				}
				
				log.info("arrBeforedate not remove==="+arrBeforedate);
				log.info("arrBeforePrin not remove==="+arrBeforePrin);
				
				int sizeVal = 0;
				if(boolMidDate && !strRepayType.equalsIgnoreCase("E"))
				{
					sizeVal = intfreqvalue+1;
				}
				else
				{
					sizeVal = intfreqvalue;
				}
				
				if(arrBeforedate != null && arrBeforedate.size() >= sizeVal)
				{
					for(int i=1;i<sizeVal;i++)
					{
						arrBeforedate.remove(arrBeforedate.size()-1);
						arrBeforePrin.remove(arrBeforePrin.size()-1);
					}
				}
				
				strDueValue = "0.00";
				strDueValuePrev = "0.00";
				if(!strRepayType.equalsIgnoreCase("E") && arrBeforePrin !=null && arrBeforePrin.size()>0)
				{
					for(int i=1;i<arrBeforePrin.size()-1;i++)
					{
						strDueValuePrev = strDueValue;
						strDueValue = String.valueOf(Double.parseDouble(strDueValue)+Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i))));
						
						if(Double.parseDouble(strOSbal)<Double.parseDouble(strDueValue))
						{
							for(int j=arrBeforePrin.size()-1;j>i;j--)
							{
								arrBeforedate.remove(j);
							}
							
							for(int j=arrBeforePrin.size()-1;j>=i;j--)
							{
								arrBeforePrin.remove(j);
							}
							
							arrBeforePrin.add(String.valueOf(Double.parseDouble(strOSbal)-Double.parseDouble(strDueValuePrev)));
						}
					}
					if((Double.parseDouble(strOSbal)-Double.parseDouble(strDueValue))>=0)
					{
						arrBeforePrin.remove(arrBeforePrin.size()-1);
						arrBeforePrin.add(String.valueOf(Double.parseDouble(strOSbal)-Double.parseDouble(strDueValue)));
	//					arrBeforePrin.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get((arrBeforePrin.size()-1))))+Double.parseDouble(strOSbal)-Double.parseDouble(strDueValue)));
					}
				}
								
				log.info("arrBeforedate==="+arrBeforedate);
				log.info("arrBeforePrin==="+arrBeforePrin);
				
	//			To assign the cashflows based on the repayment
				
				if(arrBeforedate !=null && arrBeforedate.size()>0)
				{
					if(arrBeforedate.size() == 1)
					{
						arrBeforeOS.add(strOSbal);
						arrBeforeInt.add("0.00");
						arrBeforecashflow.add(strOSbal);
					}
					else
					{
						arrBeforeOS.add(strOSbal);
						arrBeforeInt.add("0.00");
						arrBeforecashflow.add("0.00");
					}
					double dblintvalue=0;
					
					int size = arrBeforedate.size();
					if(strRepayType.equalsIgnoreCase("NE") || strRepayType.equalsIgnoreCase("O") || strRepayType.equalsIgnoreCase("N") || strRepayType.equalsIgnoreCase("OD"))
					{
						for(int i=0;i<arrBeforedate.size()-1;i++)
						{
							strOSbal = String.valueOf(Double.parseDouble(strOSbal) - Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i+1))));
							arrBeforeOS.add(strOSbal);
							
							date3 = sdf.parse(strIntDmdDate);
							date4 = sdf.parse(Helper.correctNull((String)arrBeforedate.get(i+1)));
							int intIDDval = date4.compareTo(date3);
							if(intIDDval<0)
							{
								dblintvalue=0.00;
							}
							else
							{
								strQuery = SQLParser.getSqlQuery("sel_daydiff^"+Helper.correctNull((String)arrBeforedate.get(i+1))+"^"+Helper.correctNull((String)arrBeforedate.get(i)));
								rs5 = DBUtils.executeQuery(strQuery);
								if(rs5.next())							
								dblintvalue = Double.parseDouble(Helper.correctDouble((String)arrBeforeOS.get(i))) * (Double.parseDouble(strIntrate)/100) * Double.parseDouble(Helper.correctDouble((String)rs5.getString("no_of_days")))/365;
							}
							arrBeforeInt.add(String.valueOf(nf.format(dblintvalue)));
							arrBeforecashflow.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i+1))) + Double.parseDouble(Helper.correctDouble((String)arrBeforeInt.get(i+1)))));
						}
					}
					else if(strRepayType.equalsIgnoreCase("E"))
					{
						for(int i=0;i<arrBeforedate.size()-1;i++)
						{
							date3 = sdf.parse(strIntDmdDate);
							date4 = sdf.parse(Helper.correctNull((String)arrBeforedate.get(i+1)));
							int intIDDval = date4.compareTo(date3);
							if(intIDDval<0)
							{
								dblintvalue=0.00;
							}
							else
							{
								strQuery = SQLParser.getSqlQuery("sel_daydiff^"+Helper.correctNull((String)arrBeforedate.get(i+1))+"^"+Helper.correctNull((String)arrBeforedate.get(i)));
								rs5 = DBUtils.executeQuery(strQuery);
								if(rs5.next())							
								dblintvalue = Double.parseDouble(Helper.correctDouble((String)arrBeforeOS.get(i))) * (Double.parseDouble(strIntrate)/100) * Double.parseDouble(Helper.correctDouble((String)rs5.getString("no_of_days")))/365;
							}
							arrBeforeInt.add(String.valueOf(nf.format(dblintvalue)));
							
							if(i < arrBeforedate.size()-2 && Double.parseDouble(strOSbal)>= Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i))))
							//if(i < arrBeforedate.size()-1)
							{
								if(Helper.correctNull((String)arrBeforePrin.get(i+1)).equalsIgnoreCase("0") || Helper.correctNull((String)arrBeforePrin.get(i+1)).equalsIgnoreCase("0.00"))
								{
									strOSbal = String.valueOf(Double.parseDouble(strOSbal) - Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i+1))));
								}
								else
								{
									strOSbal = String.valueOf(Double.parseDouble(strOSbal) - Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i+1))) + Double.parseDouble(Helper.correctDouble((String)arrBeforeInt.get(i+1))));
								}
								arrBeforeOS.add(strOSbal);
								
	//							if(i==size-3)
	//							{
	//								arrBeforePrin.add(strOSbal);	
	//							}
								
								if(Helper.correctDouble((String)arrBeforePrin.get(i+1)).equalsIgnoreCase("0.00"))
								{
									arrBeforecashflow.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrBeforeInt.get(i+1)))));
								}
								else
								{
									arrBeforecashflow.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrBeforePrin.get(i+1)))));
								}
							}
							else
							{
								for(int j=arrBeforePrin.size()-1;j>(i+1);j--)
								{
									arrBeforedate.remove(j);
								}
								
								for(int j=arrBeforePrin.size()-1;j>=(i+1);j--)
								{
									arrBeforePrin.remove(j);
								}
								
								arrBeforePrin.add(String.valueOf(Double.parseDouble(strOSbal)+dblintvalue));
								arrBeforeOS.add("0.00");
								
								//arrBeforecashflow.remove(arrBeforecashflow.size()-1);
								arrBeforecashflow.add(String.valueOf(Double.parseDouble(strOSbal)+dblintvalue));
							}
						}
					}
				}
				
				
				log.info("arrBeforeOS==="+arrBeforeOS);
				log.info("arrBeforeInt==="+arrBeforeInt);
				log.info("arrBeforecashflow==="+arrBeforecashflow);
				
	//			To find the fair value for the account
				
				if(arrBeforecashflow !=null && arrBeforecashflow.size()>0)
				{
					//New weighted average method to calculate Discount rate     		by Guhan T
					
					double dblNumerator=0.00,dblDenominator=0.00,dblDiscRate = 0.00;
					strQuery = SQLParser.getSqlQuery("sel_accounts_weighted_average^"+strAppno+"^"+strSno+"^"+strAppno);
					rsDis2 = DBUtils.executeQuery(strQuery);
					while(rsDis2.next())
					{
						dblNumerator = dblNumerator + Double.parseDouble(Helper.correctDouble((String)rsDis2.getString("numerator")));
						dblDenominator = dblDenominator + Double.parseDouble(Helper.correctDouble((String)rsDis2.getString("FACILITY_SANCAMT")));
					}
					
					if(dblNumerator!=0.00 && dblDenominator!=0.00)
					strDiscIntrate = nf.format(dblNumerator/dblDenominator);
					
					strDiscIntrate = nf.format(Double.parseDouble(Helper.correctDouble(strDiscRate)));
					
					log.info("strDiscIntrate===="+strDiscIntrate);
					
					strFairVal="0.00";
					for(int i=0;i<arrBeforecashflow.size();i++)
					{
						strNumeVal = Helper.correctNull((String)arrBeforecashflow.get(i));
						strQuery = SQLParser.getSqlQuery("sel_daydiff^"+Helper.correctNull((String)arrBeforedate.get(i))+"^"+Helper.correctNull((String)arrBeforedate.get(0)));
						rs7 = DBUtils.executeQuery(strQuery);
						if(rs7.next())
							strDatsDiffFV = Helper.correctNull((String)rs7.getString("no_of_days"));
						strDenomVal = String.valueOf(Math.pow((1 + (Double.parseDouble(strDiscIntrate)/100)),(Double.parseDouble(strDatsDiffFV)/365)));
						
						strFairVal = String.valueOf(Double.parseDouble(strFairVal) + (Double.parseDouble(strNumeVal) / Double.parseDouble(strDenomVal)));
					}
					
					if(strType.equalsIgnoreCase("B"))
					{
						strBeforeVal = strFairVal;
						
						hshExcelData.put("arrBeforeDate", arrBeforedate);
						hshExcelData.put("arrBeforePrin", arrBeforePrin);
						hshExcelData.put("arrBeforeInt", arrBeforeInt);
						hshExcelData.put("arrBeforeOS", arrBeforeOS);
						hshExcelData.put("arrBeforeCashFlow", arrBeforecashflow);
						hshExcelData.put("strBorrName", strBorrName);
						hshExcelData.put("strBeforeVal", strBeforeVal);

						arrBeforedate = new ArrayList();
						arrBeforePrin = new ArrayList();
						arrBeforeInt = new ArrayList();
						arrBeforeOS = new ArrayList();
						arrBeforecashflow = new ArrayList();
						boolCheckFlag = false;
					}
					else if(strType.equalsIgnoreCase("A"))
					{
						strAfterVal = strFairVal;
						
						hshExcelData.put("arrAfterDate", arrBeforedate);
						hshExcelData.put("arrAfterPrin", arrBeforePrin);
						hshExcelData.put("arrAfterInt", arrBeforeInt);
						hshExcelData.put("arrAfterOS", arrBeforeOS);
						hshExcelData.put("arrAfterCashFlow", arrBeforecashflow);
						hshExcelData.put("strBorrName", strBorrName);
						hshExcelData.put("strAfterVal", strAfterVal);
						
						arrBeforedate = new ArrayList();
						arrBeforePrin = new ArrayList();
						arrBeforeInt = new ArrayList();
						arrBeforeOS = new ArrayList();
						arrBeforecashflow = new ArrayList();
						boolCheckFlag = false;
						
						boolInsert = true;
					}
				}
				else
				{
					if(strType.equalsIgnoreCase("B"))
					{
						strBeforeVal = strOSbal;
						
						arrBeforedate = new ArrayList();
						arrBeforePrin = new ArrayList();
						arrBeforeInt = new ArrayList();
						arrBeforeOS = new ArrayList();
						arrBeforecashflow = new ArrayList();
						
						boolCheckFlag = false;
					}
					else if(strType.equalsIgnoreCase("A"))
					{
						strAfterVal = strOSbal;
						
						arrBeforedate = new ArrayList();
						arrBeforePrin = new ArrayList();
						arrBeforeInt = new ArrayList();
						arrBeforeOS = new ArrayList();
						arrBeforecashflow = new ArrayList();
						
						boolCheckFlag = false;
						boolInsert = true;
					}
				}
				log.info("Before Val===="+strBeforeVal);
				log.info("After val====="+strAfterVal);
				
				if(boolInsert)
				{
					strFVProfitLoss = String.valueOf(Double.parseDouble(Helper.correctDouble(strAfterVal)) - Double.parseDouble(Helper.correctDouble(strBeforeVal)));
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_FVCValues");
					arrValues.add(strBeforeVal);
					arrValues.add(strAfterVal);
					arrValues.add(strFVProfitLoss);
					arrValues.add(strCBSaccno);
					//arrValues.add(strAppno);
					//arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", "1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					//For Excel upload of this account
					hshExcelData.put("calc_date", strCurrentdate1);
					hshExcelData.put("strFVProfitLoss", strFVProfitLoss);
					EJBInvoker.executeStateLess("excelfunction", hshExcelData, "doFVCExportFormat");
				}
			}
			
			//To clean up the Finacle data in database
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "ins_FVCvalues_bkp");
			arrValues.add(Helper.getCurrentDateTime());
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "delete_fvc_cbs_values");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "delete_fvc_view_table_values");
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size", "1");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			//End
			
			
			if(strPageType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_one^"+strCalcAppNo+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("flowstartdate", Helper.correctNull((String)rs.getString("FVC_FLOWSTRTDATE_PROPOSAL")));
					hshRecord.put("IntDmdDate", Helper.correctNull((String)rs.getString("FVC_INTDMDDATE_PROPOSAL")));
					hshRecord.put("strFacSno", strFacSno);
					hshRecord.put("BeforeVal", Helper.correctDouble((String)rs.getString("FVC_BEFORE_XNPV")));
					hshRecord.put("AfterVal", Helper.correctDouble((String)rs.getString("FVC_AFTER_XNPV")));
					hshRecord.put("Fairvalue", Helper.correctDouble((String)rs.getString("FVC_PROFIT_LOSS")));
				}
			}
			else
			{
				//To retrieve the data
				String strFromDate = "";
				String strToDate = "";
				String strSortType = "";
				ArrayList arrCol = new ArrayList();
				ArrayList arrRow = new ArrayList();
				//strFromDate = Helper.correctNull((String)hshValues.get("txt_fromdate"));
				//strToDate = Helper.correctNull((String)hshValues.get("txt_todate"));
				strSortType = Helper.correctNull((String)hshValues.get("hidSortType"));
				
				if(strFromDate.equalsIgnoreCase(""))
				{
					strFromDate = Helper.getCurrentDateTime();
				}
				if(strToDate.equalsIgnoreCase(""))
				{
					strToDate = Helper.getCurrentDateTime();
				}
				
				if(strSortType.equalsIgnoreCase("A"))
				{
					strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_result_Acc^"+strFromDate+"^"+strToDate);
					rsGet = DBUtils.executeQuery(strQuery);
					while(rsGet.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rsGet.getString("CBS_ACCOUNTNO")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("CBS_ACCOUNTNO_OLD")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CBS_ID")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("borrower")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_BEFORE_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_AFTER_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_PROFIT_LOSS")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CALC_DATE")));
						arrRow.add(arrCol);
					}
				}
				else if(strSortType.equalsIgnoreCase("B"))
				{
					strQuery = SQLParser.getSqlQuery("sel_FVCaccounts_result_borr^"+strFromDate+"^"+strToDate);
					rsGet = DBUtils.executeQuery(strQuery);
					while(rsGet.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CBS_ID")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("borrower")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_BEFORE_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_AFTER_XNPV")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_PROFIT_LOSS")));
						arrCol.add(Helper.correctNull((String)rsGet.getString("FVC_CALC_DATE")));
						arrRow.add(arrCol);
					}
				}
				
				hshRecord.put("fromdate",strFromDate);
				hshRecord.put("todate",strToDate);
				hshRecord.put("arrRow",arrRow);
				hshRecord.put("strSortType",strSortType);
			}
		
			if(rsFVC != null)
				rsFVC.close();
			if(rs != null)
				rs.close();
			if(rs5 != null)
				rs5.close();
			if(rs7 != null)
				rs7.close();
			if(rs9 != null)
				rs9.close();
			
			return hshRecord;	
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getFVCaccounts== "+ce.toString());
		}
	}
}
