package com.sai.laps.ejb.undelete;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.targetmaster.TargetMasterBean;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "UndeleteBean", mappedName = "UndeleteHome")
@Remote (UndeleteRemote.class)
public class UndeleteBean extends BeanAdapter {
	private static final long serialVersionUID = -7107026362313548358L;
	static Logger log=Logger.getLogger(UndeleteBean.class);

	public HashMap getData(HashMap hshRequestValues)  {
		ResultSet rs = null;
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strLoanType = "";
		String strSearchType = "";
		String strDispData = "";
		String strSearchText = "";
		strDispData = correctNull((String) hshRequestValues.get("dispData"));
		if (strDispData.equals("Y")) 
		{
			try 
			{
				hshRecord = new HashMap();
				strLoanType = correctNull((String) hshRequestValues.get("optformtype"));
				strSearchType = correctNull((String) hshRequestValues.get("optstype"));
				strSearchText = correctNull((String) hshRequestValues.get("txtsearch"));
				
				if (strLoanType.equals("C")) 
				{
					if (strSearchType.equals("A") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletecomapp^"+ strSearchText);
					} 
					else if (strSearchType.equals("N") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletecomname^"+ strSearchText);
					} 
					else if (strSearchType.equals("S") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletecomssn^"+ strSearchText);
					} 
					else if ((!strSearchType.equals("") && strSearchText.equals(""))
							|| (strSearchType.equals("") && strSearchText.equals(""))) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletecom");
					}
				} 
				else if (strLoanType.equals("P") || strLoanType.equals("A")) 
				{
					if (strSearchType.equals("A") && !strSearchText.equals("")) 
					{						
						strQuery = SQLParser.getSqlQuery("selundeleteperapp^"+strLoanType+"^"+strSearchText);
					}
					else if (strSearchType.equals("N") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletepername^" +strLoanType+"^"+ strSearchText);
					} 
					else if (strSearchType.equals("S") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeleteperssn^"+strLoanType+"^" + strSearchText);
					}
					else if ((!strSearchType.equals("") && strSearchText.equals("")) 
									|| (strSearchType.equals("") && strSearchText.equals(""))) 
					{
						strQuery = SQLParser.getSqlQuery("selundeleteper^"+strLoanType);
					}
				}
				else if (strLoanType.equals("T")) 
				{
					if (strSearchType.equals("A") && !strSearchText.equals("")) 
					{						
						strQuery = SQLParser.getSqlQuery("selundeleteterapp^"+strLoanType+"^"+strSearchText);
					}
					else if (strSearchType.equals("N") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeletetername^" +strLoanType+"^"+ strSearchText);
					} 
					else if (strSearchType.equals("S") && !strSearchText.equals("")) 
					{
						strQuery = SQLParser.getSqlQuery("selundeleteterssn^"+strLoanType+"^" + strSearchText);
					}
					else if ((!strSearchType.equals("") && strSearchText.equals("")) 
									|| (strSearchType.equals("") && strSearchText.equals(""))) 
					{
						strQuery = SQLParser.getSqlQuery("selundeleteter^"+strLoanType);
					}
				}
				
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) 
				{
					vecRec = new ArrayList();
					for (int i = 0; i < 7; i++) 
					{
						vecRec.add(correctNull((String)rs.getString(i + 1)));
					}
					vecVal.add(vecRec);
				}
				hshRecord.put("vecVal", vecVal);
				if (rs != null) 
				{
					rs.close();
				}
			} 
			catch (Exception ce) 
			{
				throw new EJBException("Error in getData login  "
						+ ce.toString());
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
		}
		return hshRecord;
	}

	public HashMap updateData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = null;
		String strAction = null;
		String strDelUser = "";
		String strDelFlag = "";
		String strDelDate = null;
		String strSelAppNo;
		String strAppNo = null;
		String strLoanType = null;
		String strGetAppNo = "";
		int intUpdatesize = 0;
		int intcnt=0;
		String strTemp[] = null;
		String strTemp1[] = null;
		String strQuery = "";
		ResultSet rs = null;
		String strMessages="";
		HashMap hshRecord=new HashMap();
		try 
		{
			strDelFlag = "N";
			strSelAppNo = (String) hshValues.get("selAppno");
			if (strSelAppNo.equals("")) 
			{
				strSelAppNo = "1";
			}
			strAppNo = correctNull((String) hshValues.get("chkappno"));
			strAction = correctNull((String) hshValues.get("hidAction"));
			if (strAction.equalsIgnoreCase("undelete")) 
			{
				strQuery = SQLParser.getSqlQuery("sel_appcountbyinwardno^"+ strAppNo);
				rs = DBUtils.executeQuery(strQuery);
				{
					if (rs.next())
					{
						intcnt=rs.getInt("cnt");
					}
				}
				if(intcnt==0)
				{
					if (!strAppNo.equals("")) 
					{
						intUpdatesize = intUpdatesize + 1;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "updundelete");
						arrValues.add(strDelFlag);
						arrValues.add(strDelDate);
						arrValues.add(strDelUser);
						arrValues.add(strAppNo);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("size", Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
					}
					intUpdatesize = intUpdatesize + 1;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "updinwardappatached");
					arrValues.add("Y");
					arrValues.add("op");
					arrValues.add(correctNull((String)hshValues.get("hidinwardno")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					strMessages="Application No. " + strAppNo + " was restored successfully";
				}
				else
				{
					strMessages="Cannot Restore the Application No. " + strAppNo;
				}
				hshRecord.put("Message",strMessages);
				hshRecord.put("status","Sucess");
			} 
			else if (strAction.equalsIgnoreCase("erase"))
			{
				strLoanType = (String) hshValues.get("optformtype");

				if (strLoanType.equals("P")) 
				{
					String strTableName[] = { "loandetails",
							"per_demographics", "per_loan_secure", "perpropertydet", "per_auto", "per_otherassets",
							"per_verification", "legalopinion", "valuationentry",
							"per_bank", "per_insurance", "per_liabilities", "per_properties", "per_stocks", "per_home", "appdocuments",
							"appdocscanning", "appnotes", "appmailbox",  "appraisalsanction", "applications" };
					String strColName[] = { "loan_appno",
							"demo_appno", "loan_appno", "prop_appid", "auto_appno", "asset_appno",
							"VERIFY_APPNO", "app_no", "app_no",
							"bank_appno", "insu_appno", "liab_appno", "prop_appno", "stoc_appno", "home_appno", "apdoc_appno", 
							"appscan_appno", "not_appno", "mail_appno",  "appsanc_appno", "app_no" };
					strTemp = strTableName;
					strTemp1 = strColName;
				}
				else if (strLoanType.equals("A")) 
				{
					String strTableName[] = { "loandetails",
							"per_demographics", "per_bank", "per_insurance",
							"per_liabilities", "per_properties", "per_stocks",
							"per_auto", "per_home", "appdocuments",
							"appdocscanning", "appnotes",
							"appmailbox", 
							"appraisalsanction", "applications" };
					String strColName[] = { "loan_appno", "demo_appno",
							"bank_appno", "insu_appno", "liab_appno",
							"prop_appno", "stoc_appno", "auto_appno",
							"home_appno", "apdoc_appno", "appscan_appno",
							 "not_appno", "mail_appno",
							 "appsanc_appno", "app_no" };
					strTemp = strTableName;
					strTemp1 = strColName;
				} 
				else if (strLoanType.equals("C")) 
				{
					String strTableName[] = { "loandetails",
							"com_demographics", "com_principals",
							"com_collateral", "fin_years", "fin_finvalues",
							"com_financials", "com_pastperf", "com_presnotes",
							"com_projtechswd", "com_proposals",
							"appdocscanning", "appdocuments", "appmailbox",
							"appnotes", "com_assesment", "com_bankaccounts",
							"com_costprod", "com_postdisbcomts",
							"com_postdisbursal", "com_postdisbmain",
							"facilities",
							"app_termsandcond",
							"com_activities", "com_applntcomments",
							"com_banking", "com_bussturnover", "applications" };
					String strColName[] = { "loan_appno", "demo_appno",
							"prin_appno", "coll_appno", "finyrs_appno",
							"finval_appno", "fin_appno", "prom_appno",
							"fac_appno", "crdhist_appno", "crd_appno",
							"debt_appno", "fin_appno", "infra_appno",
							 "mgmt_appno", "perf_appno",
							"com_appno", "protech_appno", "prop_appno",
							"appscan_appno", "apdoc_appno", "mail_appno", "not_appno",
							"asses_appno", "bankacc_appno", "costprd_appno",
							"pdcmts_appno", "postdisb_appno", "pdmain_appno",
							"facility_appno",
							"app_termappno", "cad_appno", "cad_appno",
							"cad_appno", "cad_appno", "cad_appno", "cad_appno",
							"com_actappno", "com_applntappno", "combk_appno",
							"com_bussappno", "app_no" };
					strTemp = strTableName;
					strTemp1 = strColName;
				}
			}						
		}
		catch (Exception ce) 
		{
			throw new EJBException("inside update" + ce.toString());
		}
		return hshRecord;
	}
}