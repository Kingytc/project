package com.sai.laps.tagdatahelper;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

public class TagDataHelper1 extends BeanAdapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(TagDataHelper1.class);

	public HashMap getAppData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1=null;
		HashMap hshRecord = new HashMap();
		String appno = correctNull((String) hshRequestValues.get("appno"));
		String strSancReferenceno="";
		if(appno.equals(""))
		{
			appno = correctNull((String) hshRequestValues.get("strappno"));
		}
		String formtype = "";
		String check=Helper.correctNull((String) hshRequestValues.get("check"));
		try {
			if(check.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("comfunsel1^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					formtype = Helper.correctDoubleQuote(correctNull(rs.getString("app_loantype")));
				}
				if (formtype.equalsIgnoreCase("P")) {
					strQuery = SQLParser.getSqlQuery("comfunsel2_apptag^" + appno);
				} else if ((formtype.equalsIgnoreCase("C")) || (formtype.equalsIgnoreCase("E")) || (formtype.equalsIgnoreCase("U")) || (formtype.equalsIgnoreCase("H")) || formtype.equalsIgnoreCase("A")) {
					strQuery = SQLParser.getSqlQuery("comfunsel3_apptag^" + appno);
				}else if (formtype.equalsIgnoreCase("T")) {
					strQuery = SQLParser.getSqlQuery("comfunsel4^" + appno + "^N");
				}
				if (rs != null) {
					rs.close();
				}
			
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					hshRecord = new HashMap();
					hshRecord.put("app_name", Helper.correctDoubleQuote(correctNull(rs.getString("app_name"))));
					hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull(rs.getString("app_status"))));
					hshRecord.put("applicantid", rs.getString("demo_appid"));
					hshRecord.put("apporgcode", rs.getString("app_orgcode"));
					hshRecord.put("inwardno", rs.getString("app_inwardno"));
					hshRecord.put("applevel", rs.getString("app_orglevel"));
					hshRecord.put("valuesin", rs.getString("app_valuesin"));
					hshRecord.put("applnholder",correctNull(rs.getString("app_applnholder")));
					strQuery=SQLParser.getSqlQuery("sel_inwardrlpc^"+Helper.correctNull(rs.getString("app_inwardno")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("apporgname",correctNull(rs.getString("org_name"))+" [CLPH]");
					}
					else if(Helper.correctNull(rs.getString("inward_applnprocessat")).equalsIgnoreCase("3"))
					hshRecord.put("apporgname",correctNull(rs.getString("org_name"))+" [CLPU]");
					else
					hshRecord.put("apporgname",correctNull(rs.getString("org_name")));
					hshRecord.put("apploantype",formtype);
					hshRecord.put("repaytype",correctNull(rs.getString("loan_repaymenttype")));
					hshRecord.put("CBSACCOUNTNO",Helper.correctNull(rs.getString("CBS_ACCOUNTNO")));
					hshRecord.put("PERAPP_EMPLOYMENT",Helper.correctNull(rs.getString("PERAPP_EMPLOYMENT")));
					hshRecord.put("applicantnewid",correctNull(rs.getString("demo_appnewid")));
					hshRecord.put("ApplicantType",correctNull(rs.getString("app_renew_flag")));
					hshRecord.put("takeoverflag",correctNull(rs.getString("loan_takeover")));
					hshRecord.put("app_processat",correctNull(rs.getString("inward_applnprocessat")));
					hshRecord.put("digiappno",correctNull(rs.getString("INWARD_DIGIAPPNO")));
				}
				
				if (formtype.equalsIgnoreCase("P")) 
				{
					if(rs!=null)
						rs.close();
					
					strQuery = SQLParser.getSqlQuery("sel_accountopeningretail^" + appno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshRecord.put("strAccopenDate", Helper.correctNull(rs.getString("laps_handoff_time")));
						hshRecord.put("strAccopenFlag", "Done");
					}
					else
					{
						hshRecord.put("strAccopenFlag", "Not Done");
					}
				}
				
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("select_revalidationstat^" + appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("op"))
							hshRecord.put("strRevalidationFlag","Pending");
					else if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
						hshRecord.put("strRevalidationFlag","Approved");
					else if(Helper.correctNull(rs.getString("app_status")).equalsIgnoreCase("pr"))
						hshRecord.put("strRevalidationFlag","Rejected");
				}
				
				
				
				
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("npaapptag^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					hshRecord = new HashMap();
					hshRecord.put("customername", Helper.correctDoubleQuote(correctNull(rs.getString("personal_custname"))));
					hshRecord.put("npaappno", correctNull(rs.getString("npa_appno")));
					hshRecord.put("cbsid", correctNull(rs.getString("personal_cbsid")));
					hshRecord.put("status", correctNull(rs.getString("npa_status")));
					hshRecord.put("demoapptype", correctNull(rs.getString("npa_demoapptype")));
					hshRecord.put("moduletype", correctNull(rs.getString("npa_moduletype")));
					hshRecord.put("holduserid", correctNull(rs.getString("npa_holduser")));
					hshRecord.put("createorgscode", correctNull(rs.getString("npa_orgscode")));
					hshRecord.put("apporgname", correctNull(rs.getString("org_name")));
				}
			}
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_SancRefNo^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSancReferenceno=correctNull(rs.getString("sanctionrefno"));
			}
			hshRecord.put("sanctionrefno", strSancReferenceno);
			
			
			String prdType="";
			strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				prdType=Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));
			}
			
			
			
			hshRecord.put("prdType", prdType);
			
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}


	public HashMap getApplicantIDHelp(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strAppid = correctNull((String) hshValues.get("appid"));
		String strSearchid = correctNull((String) hshValues.get("searchid"));
		boolean bState = false;
		try {
			if (strAppid.equals("")) {
				strQuery = SQLParser.getSqlQuery("pergetappidhelp");
			} else {
				strQuery = SQLParser.getSqlQuery("pergetcoappidhelpNEW^"
						+ strAppid + "^" + strSearchid);
			}
			rs = DBUtils.executeQuery(strQuery);
			bState = rs.next();
			if (!bState) {
				hshResult.put("noData", "noData");
			} else {
				hshResult.put("noData", "Data");
			}
			while (bState) {
				arryCol = new ArrayList();
				arryCol.add(correctNull((String)rs.getString(1)));
				arryCol.add(correctNull((String)rs.getString(2)));
				arryRow.add(arryCol);
				bState = rs.next();
			}
			hshResult.put("arryRow", arryRow);
		} catch (Exception e) {
			throw new EJBException("Error in getApplicantIDHelp "
					+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getToolBarData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strModule = (String) hshRequestValues.get("strModule");
		//String strAppno=correctNull((String)hshRequestValues.get("strAppno"));
		String strQuery="";
		try {
			strQuery=SQLParser.getSqlQuery("seltbarall^" + strModule);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(correctNull((String) rs.getString(1)));
				arryCol.add(correctNull((String) rs.getString(2)));
				arryCol.add(correctNull((String) rs.getString(3)));
				arryCol.add(correctNull((String) rs.getString(4)));
				arryCol.add(correctNull((String) rs.getString(5)));
				arryRow.add(arryCol);
			}
			hshRecord.put("arryRow", arryRow);
			
			/*strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+strAppno);
 			if(rs!=null)
 			{
 				rs.close();
 			}
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				hshRecord.put("proposalvaluesin",correctNull(rs.getString("prop_valuesin")));
 			}*/
		} catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getDataHelp(HashMap hshRequestValues)  {
		ResultSet rs = null,rs1=null;
		HashMap hshBankRecord = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		try {
			hshBankRecord = new HashMap();
			arryRow = new ArrayList();
			arryCol = new ArrayList();
			String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			String strOrgLevel=Helper.correctNull((String)hshRequestValues.get("orglevel"));
			String strUsrOrgCode=Helper.correctNull((String)hshRequestValues.get("orgcode"));
			String strBranchOrgCode="",strLoanDisbBranch="";
			String strCLPUOrgCode="";
			String strRegionOrgCode="";
			String strHeadOfficeOrgCode="";
			String strCPCOrgCode="",strAppOrgLevel="",strAppCreOrg="",strPertainCode="",strAppType="",strPertainBranchCode="";
			
			String strQuery="";
			String strQuery1="";
			String strQuery2="";
			if(!(strAppno.equalsIgnoreCase("") || strOrgLevel.equalsIgnoreCase("") || strUsrOrgCode.equalsIgnoreCase("")))
			{
			rs = DBUtils.executeLAPSQuery("selworkflow^"+strAppno);
			if(rs.next())
			{
				strBranchOrgCode=Helper.correctNull((String)rs.getString("org_code"));
				strAppOrgLevel=Helper.correctNull((String)rs.getString("org_level"));
				strAppCreOrg=Helper.correctNull((String)rs.getString("APP_ORGLEVEL"));
				strAppType=Helper.correctNull((String)rs.getString("app_loantype"));
			}
			if(strAppCreOrg.equalsIgnoreCase("C")||strAppCreOrg.equalsIgnoreCase("D")){
				if(rs !=null){rs.close();}
				if(strAppType.equalsIgnoreCase("P")){
					rs = DBUtils.executeLAPSQuery("selloan_details^"+strAppno);
					if(rs.next())
					{
						strPertainCode=Helper.correctNull((String)rs.getString("LOAN_PERTAINS_BRANCH"));
					}
				}else{
					rs = DBUtils.executeLAPSQuery("sel_corporate_breifbackground^"+strAppno);
					if(rs.next())
					{
						strPertainCode=Helper.correctNull((String)rs.getString("COM_PERTAINS_BRANCH"));
					}
				}
					if(rs1 !=null){rs1.close();}
					rs1 = DBUtils.executeLAPSQuery("selectorgname^"+strPertainCode);
					if(rs1.next())
					{
						strPertainBranchCode=Helper.correctNull(rs1.getString("org_code"));
					}
			}
			if(!strAppno.equalsIgnoreCase("") || strBranchOrgCode.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_finapplicantid^"+strAppno);
				if(rs.next())
				{
					strBranchOrgCode=Helper.correctNull((String)rs.getString("fin_orgcode"));
				}
			}
			if(!strAppno.equalsIgnoreCase("") || strBranchOrgCode.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_solvency_comments^"+strAppno);
				if(rs.next())
				{
					strBranchOrgCode=Helper.correctNull((String)rs.getString("sol_orgcode"));
				}else{
					if(rs !=null)
					{rs.close();}
					
					
					
						
						
						
					rs = DBUtils.executeLAPSQuery("sel_msmeorgtemp^"+strAppno);
					if(rs.next())
					{
						strBranchOrgCode=Helper.correctNull((String)rs.getString("ORG_CODE"));
					}
					if(rs !=null)
					{rs.close();}
					
				}
				
				
				rs = DBUtils.executeLAPSQuery("sel_banker_branchcode^"+strAppno);
				if(rs.next())
				{
					strBranchOrgCode=Helper.correctNull((String)rs.getString("banker_orgcode"));
				}
					if(rs !=null)
					{rs.close();}
					
			}
			
			
			
			
				
				
			if(!strAppno.equalsIgnoreCase("") || strBranchOrgCode.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_permcreatedbranch^"+strAppno);
				if(rs.next())
				{
					strBranchOrgCode=Helper.correctNull(rs.getString("org_code"));
				}
				
				if(!strBranchOrgCode.equalsIgnoreCase(""))
				{
					if((strBranchOrgCode.substring(9, 12)).equalsIgnoreCase("000"))
					{
						if(rs !=null)
						{rs.close();}
						rs = DBUtils.executeLAPSQuery("sel_basicinformation^"+strAppno);
						if(rs.next())
						{
							strBranchOrgCode=Helper.correctNull(rs.getString("PERM_PER_BRANCH"));
							
							if(!strBranchOrgCode.equalsIgnoreCase(""))
							{
								if(rs1!=null)
									rs1.close();
								strQuery = SQLParser.getSqlQuery("getorgcode^"+correctNull(rs.getString("PERM_PER_BRANCH")));
								rs1 = DBUtils.executeQuery(strQuery);
								if(rs1.next())
								{
									strBranchOrgCode=Helper.correctNull(rs1.getString("org_code"));
								}
							}
						}
					}
				}
			}
			if(!strAppno.equalsIgnoreCase("") || strBranchOrgCode.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_kpow_comments^"+strAppno);
				if(rs.next())
				{
					strBranchOrgCode=Helper.correctNull((String)rs.getString("addkbow_orgcode"));
				}
			}
			if(!strAppno.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_cbsacdata^"+strAppno);
				while(rs.next())
				{
					if(strLoanDisbBranch.equalsIgnoreCase(""))
						strLoanDisbBranch=Helper.correctNull(rs.getString("org_code"));
					else
						strLoanDisbBranch=strLoanDisbBranch+","+Helper.correctNull(rs.getString("org_code"));
				}
				
				if(!strLoanDisbBranch.equalsIgnoreCase("")  && false)
				{
					if(rs !=null)
					{rs.close();}
					rs = DBUtils.executeLAPSQuery("selectorgname^"+strLoanDisbBranch);
					if(rs.next())
					{
						if(Helper.correctNull(rs.getString("org_level")).equalsIgnoreCase("A"))
							strLoanDisbBranch=Helper.correctNull(rs.getString("org_code"));
						else
							strLoanDisbBranch="";
					}
				}
				
				if(strLoanDisbBranch.equalsIgnoreCase(strBranchOrgCode))
				{
					strLoanDisbBranch="";
				}
			}
			strCPCOrgCode=strUsrOrgCode.substring(0,6);
			if(strOrgLevel.equalsIgnoreCase("A"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,9);
				strCLPUOrgCode=strCLPUOrgCode+"000000";
				strRegionOrgCode=strUsrOrgCode.substring(0,6);
				strRegionOrgCode=strRegionOrgCode+"000000000";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				strCPCOrgCode="001001000000000";
				
				if(strBranchOrgCode.equalsIgnoreCase(strUsrOrgCode))
				{
					if(strPertainBranchCode.equalsIgnoreCase(""))
						strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strCLPUOrgCode+",";
					else
						strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strCLPUOrgCode+","+strPertainBranchCode+",";
				}
				else
				{
					if(strPertainBranchCode.equalsIgnoreCase(""))
						strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strBranchOrgCode+","+strCLPUOrgCode+",";
					else
						strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strBranchOrgCode+","+strCLPUOrgCode+","+strPertainBranchCode+",";
				}
				
			}
			else if(strOrgLevel.equalsIgnoreCase("D"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,9);
				strCLPUOrgCode=strCLPUOrgCode+"000000";
				strRegionOrgCode=strUsrOrgCode.substring(0,6);
				strRegionOrgCode=strRegionOrgCode+"000000000";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				strCPCOrgCode="001001000000000";
				if(strLoanDisbBranch.equalsIgnoreCase("") && strPertainBranchCode.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strBranchOrgCode+",";
				else if(strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
				strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strCLPUOrgCode+","+strBranchOrgCode+","+strPertainBranchCode+",";
				else if(!strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strCLPUOrgCode+","+strBranchOrgCode+","+strPertainBranchCode+","+strLoanDisbBranch+",";
				else
					strQuery1="where org_code in("+strHeadOfficeOrgCode+","+strCPCOrgCode+","+strRegionOrgCode+","+strBranchOrgCode+","+strLoanDisbBranch+",";
			}
			else if(strOrgLevel.equalsIgnoreCase("R") && strCPCOrgCode.equalsIgnoreCase("001001"))
			{
				strCLPUOrgCode=strUsrOrgCode.substring(0,3);
				strCLPUOrgCode=strCLPUOrgCode+"%";
				if(strLoanDisbBranch.equalsIgnoreCase("") && strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code ="+strBranchOrgCode;
				else if(strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code  in ("+strBranchOrgCode+","+strPertainBranchCode+",";
				else if(!strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in ("+strBranchOrgCode+","+strLoanDisbBranch+","+strPertainBranchCode+",";
				else
					strQuery1="where org_code in ("+strBranchOrgCode+","+strLoanDisbBranch+",";
				//strQuery2=" where org_code like"+" "+"'"+strCLPUOrgCode+"'"+" "+"and org_level not in ('A','R')";
				strQuery2="where org_level not in ('A','R') and org_code in (";
				if(!strQuery2.equalsIgnoreCase("") && !strQuery1.equalsIgnoreCase("") ){
					strQuery2="where org_level not in ('A','R','D','C') ";}
			}
			else if(strOrgLevel.equalsIgnoreCase("R"))
			{
				strCPCOrgCode="001001000000000";
				strCLPUOrgCode=strUsrOrgCode.substring(0,6);
				strCLPUOrgCode=strCLPUOrgCode+"%";
				strHeadOfficeOrgCode=strUsrOrgCode.substring(0,3);
				strHeadOfficeOrgCode=strHeadOfficeOrgCode+"000000000000";
				if(strLoanDisbBranch.equalsIgnoreCase("") && strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in("+strCPCOrgCode+","+strBranchOrgCode+","+strHeadOfficeOrgCode+",";
				else if(strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in("+strCPCOrgCode+","+strBranchOrgCode+","+strHeadOfficeOrgCode+","+strPertainBranchCode+",";
				else if(!strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in("+strCPCOrgCode+","+strBranchOrgCode+","+strHeadOfficeOrgCode+","+strLoanDisbBranch+","+strPertainBranchCode+",";
				else
					strQuery1="where org_code in("+strCPCOrgCode+","+strBranchOrgCode+","+strHeadOfficeOrgCode+","+strLoanDisbBranch+",";
				if(!strAppOrgLevel.equalsIgnoreCase("D")){
					strQuery2="where org_code like "+" "+"'"+strCLPUOrgCode+"'"+" "+"and org_level not in ('A','R')";
					/*strQuery2="where org_level not in ('A','R') and org_code in (";
				if(!strQuery2.equalsIgnoreCase("") && !strQuery1.equalsIgnoreCase("") ){
					strQuery2="where org_level not in ('A','R','D','C') ";
				}*/
				}
			}
			else if(strOrgLevel.equalsIgnoreCase("C"))
			{
				strCLPUOrgCode=strBranchOrgCode.substring(0,6);
				if(strCLPUOrgCode.equalsIgnoreCase("001000")&& !strLoanDisbBranch.equalsIgnoreCase(""))
					strCLPUOrgCode=strLoanDisbBranch.substring(0,6);
				
				strHeadOfficeOrgCode=strCLPUOrgCode+"%";
				if((strLoanDisbBranch.equalsIgnoreCase("") && strPertainBranchCode.equalsIgnoreCase("")) && !strAppOrgLevel.equalsIgnoreCase("C"))
				strQuery1="where org_code in( "+strBranchOrgCode+",";
				else if(strBranchOrgCode.equalsIgnoreCase("001000000000000") && strAppOrgLevel.equalsIgnoreCase("C"))
					strQuery1="where org_code in ("+strLoanDisbBranch+",";
				else if(strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in ("+strBranchOrgCode+","+strPertainBranchCode+",";
				else if(!strLoanDisbBranch.equalsIgnoreCase("") && !strPertainBranchCode.equalsIgnoreCase(""))
					strQuery1="where org_code in ("+strBranchOrgCode+","+strPertainBranchCode+","+strLoanDisbBranch+",";
				else
					strQuery1="where org_code in ("+strBranchOrgCode+","+strLoanDisbBranch+",";
				if(!strAppOrgLevel.equalsIgnoreCase("D")){
					strQuery2="where org_code like"+" "+"'"+strHeadOfficeOrgCode+"'"+" "+"and org_level not in ('A','C')";
					/*strQuery2="where org_level not in ('A','R') and org_code in (";
					if(!strQuery2.equalsIgnoreCase("") && !strQuery1.equalsIgnoreCase("") ){
						strQuery2="where org_level not in ('A','R','D','C') ";}*/
					}else{
					strQuery2="where org_code like"+" "+"'"+strHeadOfficeOrgCode+"'"+" "+"and org_level not in ('A','C','D')";
						/*strQuery2="where org_level not in ('A','R') and org_code in (";
					if(!strQuery2.equalsIgnoreCase("") && !strQuery1.equalsIgnoreCase("") ){
						strQuery2="where org_level not in ('A','R','D','C') ";}*/
				}
			}
			else
			{
				//No Function;
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(!strQuery1.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selbanklistorgtemp^"+strQuery1);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(correctNull((String)rs.getString(1)));
					arryCol.add(correctNull((String)rs.getString(2)));
					arryRow.add(arryCol);
				}
			}
			if(rs !=null)
			{
				rs.close();
			}
			if(!strQuery2.equalsIgnoreCase(""))
			{
				if(!strQuery2.equalsIgnoreCase("") && !strQuery1.equalsIgnoreCase("") ){
				strQuery=SQLParser.getSqlQuery("selbanklistorgs^"+strQuery2);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(correctNull((String)rs.getString(1)));
					arryCol.add(correctNull((String)rs.getString(2)));
					arryRow.add(arryCol);
				}
			}else{
				strQuery=SQLParser.getSqlQuery("selbanklistorgtemp^"+strQuery2);
				rs=DBUtils.executeQuery(strQuery);
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(correctNull((String)rs.getString(1)));
					arryCol.add(correctNull((String)rs.getString(2)));
					arryRow.add(arryCol);
				}
			}
			}
			if(rs !=null)
			{
				rs.close();
			}
		}
			/*rs = DBUtils.executeLAPSQuery("selbanklisthelp");
			while (rs.next()) {
				arryCol = new ArrayList();
				arryCol.add(correctNull((String)rs.getString(1)));
				arryCol.add(correctNull((String)rs.getString(2)));
				arryRow.add(arryCol);
			}*/
		
			hshBankRecord.put("arryRow", arryRow);
		} catch (Exception ce) {
			throw new EJBException("Error in getDataHelp login  "
					+ ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshBankRecord;
	}

	public HashMap updateData(HashMap hsh)  {
		ResultSet rs = null;
		HashMap hshValues = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		try {
			rs = DBUtils.executeLAPSQuery("bankmaster");
			while (rs.next()) {
				arr.add(correctNull(rs.getString("bankid")));
				arr1.add(correctNull(rs.getString("bankname")));
			}
			hshValues.put("arr", arr);
			hshValues.put("arr1", arr1);
		} catch (Exception e) {
			log.error("in bean" + e);
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshValues;
	}

	public HashMap getBorrowerType(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		String strAppNo = "";
		String formtype="";
		double dblappliedamt=0.0;
		double dblwoadvamt=25000.0;
		try {
			strAppNo = correctNull((String) hshValues.get("appno"));
			
			strQuery = SQLParser.getSqlQuery("comfunsel1^"+strAppNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				formtype = Helper.correctDoubleQuote(correctNull(rs.getString("app_loantype")));
			}
			if(formtype.equalsIgnoreCase("C")||formtype.equalsIgnoreCase("A"))
			{
				rs = DBUtils.executeLAPSQuery("selborrowertype^" + strAppNo);
				while (rs.next()) {
					hshRecord.put("comapp_companyname", correctNull((String) rs.getString("perapp_fname")));
					//hshRecord.put("comapp_companyid", correctNull((String) rs.getString("comapp_companyid")));
					//hshRecord.put("comapp_comtype", correctNull((String) rs.getString("comapp_comtype")));
					//hshRecord.put("comapp_ssitype", correctNull((String) rs.getString("comapp_ssitype")));
					hshRecord.put("comapp_id", correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("financialtype", correctNull((String) rs.getString("demo_finstandard")));
				}
			}
			else if(formtype.equalsIgnoreCase("T"))
			{
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selborrowerops^" + strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					hshRecord.put("comapp_companyname", correctNull((String) rs.getString("perapp_fname")));
					hshRecord.put("comapp_companyid", correctNull((String) rs.getString("perapp_cbsid")));
					hshRecord.put("comapp_comtype", "OPS");
					hshRecord.put("comapp_id", correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("financialtype", correctNull((String) rs.getString("demo_finstandard")));
					
					if(correctNull((String) rs.getString("demo_finstandard")).equalsIgnoreCase("8"))
					{
						hshRecord.put("comapp_ssitype", "WOADV");
					}
					else if(correctNull((String) rs.getString("demo_finstandard")).equalsIgnoreCase("7") || correctNull((String) rs.getString("demo_finstandard")).equalsIgnoreCase("10"))
					{
						hshRecord.put("comapp_ssitype", "WADV");
					}
				}
				/*if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selothrparambycode^" + "'WOADV'");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					dblwoadvamt=rs.getDouble("loan_paramval");
				}
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("seltotpropmainlimit^" + strAppNo+"^0");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()) {
					dblappliedamt=rs.getDouble("proposedtotal");
				}
				if(dblwoadvamt>=dblappliedamt)
				{
					hshRecord.put("comapp_ssitype", "WOADV");
					hshRecord.put("financialtype", "8");
				}
				else
				{
					hshRecord.put("comapp_ssitype", "WADV");
					hshRecord.put("financialtype", "7");
				}*/
			}
			else if(formtype.equalsIgnoreCase("E"))
			{
				rs = DBUtils.executeLAPSQuery("selborrowertype^" + strAppNo);
				while (rs.next()) {
					hshRecord.put("comapp_companyname", correctNull((String) rs.getString("perapp_fname")));
					//hshRecord.put("comapp_companyid", correctNull((String) rs.getString("comapp_companyid")));
					//hshRecord.put("comapp_comtype", "SRE");
					//hshRecord.put("comapp_ssitype", correctNull((String) rs.getString("comapp_ssitype")));
					hshRecord.put("comapp_id", correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("financialtype", correctNull((String) rs.getString("demo_finstandard")));
				}
			}
			else if(formtype.equalsIgnoreCase("U"))
			{
				rs = DBUtils.executeLAPSQuery("selborrowertype^" + strAppNo);
				while (rs.next()) {
					hshRecord.put("comapp_companyname", correctNull((String) rs.getString("perapp_fname")));
					//hshRecord.put("comapp_companyid", correctNull((String) rs.getString("comapp_companyid")));
					//hshRecord.put("comapp_comtype", "STL");
					//hshRecord.put("comapp_ssitype", correctNull((String) rs.getString("comapp_ssitype")));
					hshRecord.put("comapp_id", correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("financialtype", correctNull((String) rs.getString("demo_finstandard")));
				}
			}
			else if(formtype.equalsIgnoreCase("H"))
			{
				rs = DBUtils.executeLAPSQuery("selborrowertype^" + strAppNo);
				while (rs.next()) {
					hshRecord.put("comapp_companyname", correctNull((String) rs.getString("perapp_fname")));
					//hshRecord.put("comapp_companyid", correctNull((String) rs.getString("comapp_companyid")));
					//hshRecord.put("comapp_comtype", "ADC");
					//hshRecord.put("comapp_ssitype", correctNull((String) rs.getString("comapp_ssitype")));
					hshRecord.put("comapp_id", correctNull((String) rs.getString("perapp_id")));
					hshRecord.put("financialtype", correctNull((String) rs.getString("demo_finstandard")));
				}
			}
 			
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e1) {
				throw new EJBException("Error closing connection" + e1);
			}
		}
		return hshRecord;
	}


	public HashMap getCatgList(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strCatId = "";
		try {

			strCatId = correctNull((String)hshRequestValues.get("cat_id"));
			rs = DBUtils.executeLAPSQuery("categorylist^" + strCatId);
			hshRecord = new HashMap();
			while (rs.next()) {
				String strId = correctNull((String)rs.getString("cat_id"));
				String strName = correctNull((String)rs.getString("cat_name"));
				hshRecord.put(strId, strName);
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getCatgList " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

//	public HashMap getLegend(HashMap hsh)  {
//		ResultSet rs = null;
//		HashMap hshvalues = new HashMap();
//		ArrayList arr = new ArrayList();
//		ArrayList arr1 = new ArrayList();
//		try {
//			rs = DBUtils.executeLAPSQuery("legendchoice");
//			while (rs.next()) {
//				String totalval;
//				totalval = correctNull(rs.getString("legend_id"));
//				arr.add(totalval);
//				arr1.add(correctNull(rs.getString("legend_desc")));
//			}
//			hshvalues.put("arrVal", arr);
//			hshvalues.put("arrValdesc", arr1);
//		}
//		catch (Exception e) {
//			log.error("error occured" + e.toString());
//		}
//		finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception e1) {
//				log.error("error occured" + e1.toString());
//			}
//		}
//		log.info("the val is " + hshvalues);
//		return hshvalues;
//	}

//	public HashMap getLegendData(HashMap hshRequestValues)  {
//		ResultSet rs = null;
//		ArrayList vecVal = new ArrayList();
//		ArrayList vecRec = new ArrayList();
//		HashMap hshRecord = new HashMap();
//		try {
//			hshRecord = new HashMap();
//			rs = DBUtils.executeLAPSQuery("selectcomlegendid");
//			while (rs.next()) {
//				vecRec = new ArrayList();
//				for (int i = 0; i < 1; i++) {
//					vecRec.add(rs.getString(i + 1));
//				}
//				vecVal.add(vecRec);
//			}
//			hshRecord.put("vecVal", vecVal);
//		} catch (Exception ce) {
//			throw new EJBException("Error in getData login  " + ce.toString());
//		} finally {
//			try {
//				if (rs != null)
//					rs.close();
//			} catch (Exception cf) {
//				throw new EJBException("Error closing the connection "
//						+ cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

	public HashMap getLimitList(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec =  new ArrayList();
		HashMap hshRecord = new HashMap();
		String strPrdType="C";
		try {
			hshRecord = new HashMap();
			strPrdType = correctNull((String)hshRequestValues.get("prdtype"));
			rs = DBUtils.executeLAPSQuery("getlimitlist^" + strPrdType);
			while (rs.next()) {
				vecRec = new ArrayList();
				for (int i = 0; i < 3; i++) {
					vecRec.add(rs.getString(i + 1));
				}
				vecVal.add(vecRec);
			}
			hshRecord.put("vecVal", vecVal);
		} catch (Exception e) {
			throw new EJBException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getAppMailStatus(HashMap hshRequestValues) 
	{
		String strQuery = "";
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		
//		String availstatus="N";
		String appno = correctNull((String) hshRequestValues.get("appno"));
		//String strUserId = correctNull((String) hshRequestValues.get("strUserId"));
		String strappstatus="";
		//String strappuserid="";
		try {
				strQuery=SQLParser.getSqlQuery("get_Appstatus^"+appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strappstatus=correctNull(rs.getString("app_status"));
					//strappuserid=correctNull(rs.getString("app_usrid"));
				}
//				if(strappstatus.equalsIgnoreCase("op"))
//				{
//					strQuery = SQLParser.getSqlQuery("selmailavail^"+appno+"^"+strUserId);
//					rs = DBUtils.executeQuery(strQuery);
//					if (rs.next()) {
//						int intcount=0;
//						intcount=rs.getInt(1);
//						if(intcount==0)
//							if(strUserId.trim().equalsIgnoreCase(strappuserid.trim()))
//								availstatus="Y";
//							else
//							{
//								/*strQuery=SQLParser.getSqlQuery("seltouserorghead^"+strUserId);
//								ResultSet resultset=DBUtils.executeQuery(strQuery);
//								if(rs.next())
//									if(resultset.getString("org_head").trim().equalsIgnoreCase(strappuserid.trim()))
//										availstatus="Y";
//									else*/
//										availstatus="N";
//							}
//						else
//							availstatus="Y";
//					}
//				}
				
//				hshRecord.put("availstatus",availstatus);
				hshRecord.put("strappstatus",strappstatus);
				
		} catch (Exception ce) {
			throw new EJBException("Error in getAppMailStatus ::  " + ce.toString());
		} 
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection in getAppMailStatus :: "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	
	public HashMap getMonData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strcbsaccno = correctNull((String) hshRequestValues.get("cbsaccno"));
		
		//String strschemecode="",strfacility="";
		try
		{
			strQuery=SQLParser.getSqlQuery("getmontag^"+strcbsaccno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("personal_cbsid",Helper.correctNull(rs.getString("personal_cbsid")));
				hshRecord.put("personal_custname",Helper.correctNull(rs.getString("personal_custname")));
				//hshRecord.put("limit_facility",Helper.correctNull(rs.getString("limit_facility")));
				hshRecord.put("limit_facility",Helper.correctNull(rs.getString("stat_data_desc1")));
				hshRecord.put("mon_reviewof",Helper.correctNull(rs.getString("mon_reviewof")));
			}
			/*if(rs!=null)rs.close();
			rs=DBUtils.executeLAPSQuery("getmonfacility^"+strschemecode);
			if(rs.next())
			{
				strfacility=Helper.correctNull((String)rs.getString("stat_data_desc1"));
			}
			hshRecord.put("limit_facility",strfacility);*/
		}
		catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getCreditReportNames(HashMap hshValues)  {
 		String strQuery = "";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strinwardno = correctNull((String) hshValues.get("strinwardno"));
		boolean bState = false;
		try 
		{
			if (!strinwardno.equals("")) 
			{
				strQuery = SQLParser.getSqlQuery("selcreditreportnames^" + strinwardno);
			}
			rs = DBUtils.executeQuery(strQuery);
			bState = rs.next();
			if (!bState)
			{
				hshResult.put("noData", "noData");
			}
			else
			{
				hshResult.put("noData", "Data");
			}
			while (bState)
			{
				arryCol = new ArrayList();
				arryCol.add(correctNull((String)rs.getString("cr_inwardno")));//0
				arryCol.add(correctNull((String)rs.getString("cr_name")));//1
				arryCol.add(correctNull((String)rs.getString("cr_fatname")));//2
				arryCol.add(correctNull((String)rs.getString("cr_appno")));//3
				arryCol.add(correctNull((String)rs.getString("CR_OFFADD")));//4                                                                                                                                                                                                             
				arryCol.add(correctNull((String)rs.getString("CR_OFFTELNO")));//5                                                                                                                                                                                                          
				arryCol.add(correctNull((String)rs.getString("CR_RESADD")));//6                                                                                                                                                                                                     
				arryCol.add(correctNull((String)rs.getString("CR_RESTELNO")));//7                                                                                                                                                                                                          
				arryCol.add(correctNull((String)rs.getString("CR_PERMADD")));//8                                                                                                                                                                                                          
				arryCol.add(correctNull((String)rs.getString("CR_PERMTELNO")));//9                                                                                                                                                                                                           
				arryCol.add(correctNull((String)rs.getString("CR_APPTYPE")));//10                                                                                                                                                                                                              
				arryCol.add(correctNull((String)rs.getString("CR_MINORTYPE")));//11                                                                                                                                                                                                               
				arryCol.add(correctNull((String)rs.getString("CR_AGRITYPE")));//12
				arryCol.add(correctNull((String)rs.getString("CR_SLNO")));//13
				arryRow.add(arryCol);
				bState = rs.next();
			}
			hshResult.put("arryRow", arryRow);
		}
		catch (Exception e) 
		{
			throw new EJBException("Error in getCreditReportNames "+ e.getMessage());
		}
		finally 
		{
			try 
			{
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception e) 
			{
				throw new EJBException("Error in closing Connection "+ e.getMessage());
			}
		}
		return hshResult;
	}

	public HashMap getCBSCustName(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strcbsid = correctNull((String) hshRequestValues.get("cbsid"));
		String strcbsaccno = correctNull((String) hshRequestValues.get("hidtlrno"));

		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_cbscustname^"+strcbsaccno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("personal_cbsid",Helper.correctNull(rs.getString("personal_cbsid")));
				hshRecord.put("personal_custname",Helper.correctNull(rs.getString("personal_custname")));
				hshRecord.put("tlr_holder",Helper.correctNull(rs.getString("tlr_holder")));
				hshRecord.put("tlr_status",Helper.correctNull(rs.getString("tlr_status")));
				hshRecord.put("tlr_year",Helper.correctNull(rs.getString("tlr_year")));
				hshRecord.put("tlr_valuesin",Helper.correctNull(rs.getString("tlr_valuesin")));
				hshRecord.put("org_name",Helper.correctNull(rs.getString("org_name")));
				
			}
			
			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getCBSCustName " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	//
	
	public HashMap getMMRAppDetails(HashMap hshValues)
	{
		HashMap hshRecord=null;
		String strQuery = "";
		ResultSet rs = null;
		try
		{
			String strCustid=correctNull((String)hshValues.get("strcbsid"));
			String strMonth=correctNull((String)hshValues.get("strMon"));
			String strYear=correctNull((String)hshValues.get("strYear"));
			
			strQuery=SQLParser.getSqlQuery("selmmrappdetails^"+strCustid+"^"+strYear+"^"+strMonth);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord=new HashMap();
				hshRecord.put("strcbsid",Helper.correctNull(rs.getString("mmr_cbsid")));
				hshRecord.put("Strmmrno",Helper.correctNull(rs.getString("mmr_no")));
				hshRecord.put("strYear",correctNull((String)rs.getString("mmr_year")));
				hshRecord.put("strMon",correctNull((String)rs.getString("mmr_month")));
				hshRecord.put("mmrStatus",correctNull((String)rs.getString("mmr_status")));
				hshRecord.put("mmrrptholder",correctNull((String)rs.getString("mmr_rptholder")));
				hshRecord.put("mmrorgscode",correctNull((String)rs.getString("mmr_orgscode")));
				hshRecord.put("org_name",correctNull((String)rs.getString("org_name")));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getMMRAppDetails " + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
				}
			}
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getFinAppData(HashMap hshRequestValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appid = Helper.correctNull((String) hshRequestValues.get("appid"));
		String financeid = correctNull((String) hshRequestValues.get("financeid"));
		String strNewFlag = correctNull((String) hshRequestValues.get("strNewFlag"));
		String strSancReferenceno="",strRatAppno="";
		String com_industrytype="";
		String formtype = "";
		hshRecord = new HashMap();
		try {
			
			if(!appid.equalsIgnoreCase("")&& !appid.equalsIgnoreCase("0"))
			{
				strQuery = SQLParser.getSqlQuery("selborrowerdet^"+appid);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if (rs.next()) {
					
					hshRecord.put("perapp_fname", Helper.correctNull(rs.getString("perapp_fname")));
					hshRecord.put("perapp_lname", Helper.correctNull(rs.getString("perapp_lname")));
					hshRecord.put("perapp_cbsid", Helper.correctNull(rs.getString("perapp_cbsid")));
				}
				strQuery = SQLParser.getSqlQuery("selborrowerdet_company^"+appid);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					 com_industrytype=Helper.correctNull(rs.getString("cominfo_industry_type"));
					hshRecord.put("com_groupname", Helper.correctNull(rs.getString("cominfo_groupname")));
					
				}
			}
				if(!com_industrytype.equals("") && !com_industrytype.equals("0"))
				{
					strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"138"+"^"+com_industrytype);
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					
					if (rs.next()) {
					hshRecord.put("com_industrytype", Helper.correctNull(rs.getString("stat_data_desc1")));

					}
				}
				
				if(financeid.equals(""))
				{
					financeid="0";
				}
				strQuery = SQLParser.getSqlQuery("fin_cmano_select^"+financeid);
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				
				if (rs.next()) {
					hshRecord.put("demo_finstandard", Helper.correctNull(rs.getString("fin_cmano")));

					String demo_finstandard=Helper.correctNull(rs.getString("fin_cmano"));
					if(!demo_finstandard.equals(""))
					{
						strQuery = SQLParser.getSqlQuery("com_cma_master^"+demo_finstandard);
						if (rs != null) {
							rs.close();
						}
						rs = DBUtils.executeQuery(strQuery);
						
						if (rs.next()) {
						hshRecord.put("demo_finstandard", Helper.correctNull(rs.getString("cma_format_desc")));

						}
					}
						
				}
				
				if(strNewFlag.equalsIgnoreCase("Y"))
				{
					strRatAppno="new";	
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("sel_finratappno^"+financeid);
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					
					if (rs.next()) {
						strRatAppno=Helper.correctNull(rs.getString("fin_ratappno"));
						hshRecord.put("Rat_BussID", Helper.correctNull(rs.getString("fin_bussid")));
					}else{
						strRatAppno="new";
					}
				}
				hshRecord.put("Rat_Appno", strRatAppno);
		
			}
			
		 catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getAdhocFacilityData(HashMap hshRequestValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appid = Helper.correctNull((String) hshRequestValues.get("appid"));
		String facGroup = correctNull((String) hshRequestValues.get("facGroup"));
		String apptype = correctNull((String) hshRequestValues.get("apptype"));
		String appno = correctNull((String) hshRequestValues.get("appno"));
		hshRecord = new HashMap();
		String strTemp=" ",strModule="",strTemp2="  ",strHeadId="0",strSubHeadId="0";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try {
			
			if(facGroup.equalsIgnoreCase("M"))
			{
				strTemp=" facility_group='0' and";
			}
			else if(facGroup.equalsIgnoreCase("S"))
			{
				strTemp="facility_group!='0' and";
			}
			if(apptype.equalsIgnoreCase("CORP"))
			{
				strModule="C";
			}
			else if(apptype.equalsIgnoreCase("AGR"))
			{
				strModule="A";
			}
			if(!appid.equalsIgnoreCase("")&& !appid.equalsIgnoreCase("0"))
			{
				strQuery = SQLParser.getSqlQuery("sel_facilityforadhoclimits^"+strSubHeadId+"^"+strHeadId+"^"+strTemp+"^"+appid+"^"+strModule+"^"+strSubHeadId+"^"+strHeadId+"^"+strTemp+"^"+appno+"^"+strTemp2);
				if (rs != null) {
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("facility_appno")));
					arrCol.add(Helper.correctNull(rs.getString("facility_sno")));
					arrCol.add(Helper.correctNull(rs.getString("facility_displaydesc")));
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")))));
					arrCol.add(Helper.correctNull(rs.getString("facility_months")));
					if(Double.parseDouble(Helper.correctDouble(rs.getString("facmonths")))<0)
						arrCol.add("Y");
					else
						arrCol.add("N");
					arrCol.add(Helper.correctNull(rs.getString("facility_duedate")));
					arrRow.add(arrCol);
				}
			}
				
		hshRecord.put("arrRow",arrRow);
			}
			
		 catch (Exception ce) {
			throw new EJBException("Error in getData " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getAppType(HashMap hshRequestValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		String strQuery="",strAppno="";
		try {
			
			strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("comfunsel1^"+strAppno);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			
			if (rs.next()) {
				hshRecord.put("strAppType", Helper.correctNull(rs.getString("app_renew_flag")));
			}
			
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getAppType " + ce.toString());
		} 
		finally 
		{
			try 
			{
				if (rs != null)
				{
					rs.close();
				}
			} 
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	//vindhya begin
	public HashMap getProductdescriptionlist(HashMap hshRequestValues)  {
		ResultSet rs = null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumIntegerDigits(4);
		nf.setGroupingUsed(false);
		HashMap hshRecord = new HashMap();
		String strProdcode = "";
		String strProdtype="";
		try {

			strProdcode = correctNull((String)hshRequestValues.get("Prodcode"));
			strProdtype = correctNull((String)hshRequestValues.get("Prodtype"));
			if (strProdtype.equalsIgnoreCase("c")||strProdtype.equalsIgnoreCase("a"))
			{	
				rs	= DBUtils.executeLAPSQuery("sel_facilityCorp^"+strProdcode);
				while (rs.next())
				{
					String strId=strProdcode;
					String strName = correctNull((String)rs.getString("com_facdesc"));
					hshRecord.put(strId, strName);
					
				}
			}			
			else
			{
				rs = DBUtils.executeLAPSQuery("setproductssel^" + strProdcode);
				hshRecord = new HashMap();
				while (rs.next()) {				
					//hshRecord.put("prd_desc", correctNull(rs.getString("prd_desc")));
					String strId = correctNull((String)rs.getString("cat_id"));
					String strName = correctNull((String)rs.getString("catname"));
					hshRecord.put(strId, strName);
				}
			}
			
		} catch (Exception ce) {
			throw new EJBException("Error in getProductdescriptionlist " + ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	//vindhya end
}