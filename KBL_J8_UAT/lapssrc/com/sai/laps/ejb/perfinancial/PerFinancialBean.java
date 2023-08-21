package com.sai.laps.ejb.perfinancial;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "PerFinancialBean", mappedName = "PerFinancialHome")
@Remote (PerFinancialRemote.class)
public class PerFinancialBean extends BeanAdapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	static Logger log = Logger.getLogger(PerFinancialBean.class);

//	public HashMap getData(HashMap hshValues)  {
//		ResultSet rs = null;
//		HashMap hshResult = new HashMap();
//		ArrayList arryRow = new ArrayList();
//		ArrayList arryCol = null;
//		
//		String strGetLock = correctNull((String) hshValues.get("hidEditLock"));
//		String strAction = correctNull((String) hshValues.get("hidAction"));
//		String strApplicationNo = correctNull((String) hshValues.get("appno"));
//		
//		String recordflag="N";
//		
//		try {
//			String accDt = "";
//			rs = DBUtils.executeLAPSQuery("pergetfinancialbnk^"
//					+ strApplicationNo);
//			while (rs.next()) {
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("bank_appno"));
//				arryCol.add(rs.getString("bank_apptype"));
//				arryCol.add(rs.getString("bank_serialno"));
//				arryCol.add(rs.getString("bank_name"));
//				arryCol.add(rs.getString("bank_accntno"));
//				arryCol.add(rs.getString("bank_accnttype"));
//				arryCol.add(rs.getString("bank_balance"));
//				arryCol.add(rs.getString("bank_iscoll"));
//				arryCol.add(rs.getString("remarks"));
//				accDt = correctNull((String) rs.getString("bank_yrsacchold"));
//				if (accDt.equalsIgnoreCase("01/01/1900")) {
//					arryCol.add("");
//				} else {
//					arryCol.add(accDt);
//				}
//				arryRow.add(arryCol);
//				recordflag="Y";
//			}
//			hshResult.put("arryRow", arryRow);
//			hshResult.put("recordflag",recordflag);
//		} catch (Exception ce) {
//			throw new EJBException("Error in closing getData" + ce.getMessage());
//		} finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception e) {
//				throw new EJBException("Error in closing Connection " + e.getMessage());
//			}
//		}
//		return hshResult;
//	}

	/**
	 * Function insertData used for inserting financial bank account datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

//	public HashMap insertData(HashMap hshValues)  {
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshpasValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		String strApplicationNo = "";
//		String[] strtxtbank_name = null;
//		String[] strtxtbank_branchname = null;
//		String[] strchobank_accnttype = null;
//		String[] strtxtbank_accntno = null;
//		String[] strtxtbank_balance = null;
//		String[] strchobank_apptype = null;
//		String[] strchkbank_iscoll = null;
//		String[] strremarks = null;
//		HashMap hshResult = new HashMap();
//		HashMap hshlockvalues = new HashMap();
//		StringBuilder sbAt = new StringBuilder();
//		
//		int intUpdatesize = 0;
//		String strGetLock = "";
//		String strEditMode = correctNull((String) hshValues.get("hidEditMode"));
//		String strAppUser = correctNull((String) hshValues.get("strUserId"));
//		strApplicationNo = correctNull((String) hshValues.get("appno"));
//		strtxtbank_name = (String[]) hshValues.get("txtbank_name");
//		strtxtbank_branchname = (String[]) hshValues
//				.get("txtbank_branchname");
//		strchobank_accnttype = (String[]) hshValues
//				.get("chobank_accnttype");
//		strtxtbank_accntno = (String[]) hshValues.get("txtbank_accntno");
//		strtxtbank_balance = (String[]) hshValues.get("txtbank_balance");
//		strchobank_apptype = (String[]) hshValues.get("chobank_apptype");
//		strchkbank_iscoll = (String[]) hshValues.get("hidbank_iscoll");
//		strremarks = (String[]) hshValues.get("remarks");
//		String[] strhid_chobank_apptype=(String[])hshValues.get("hid_chobank_apptype");
//		try {
//
//			if (strEditMode.equalsIgnoreCase("E")) {
//				hshlockvalues.put("appno", strApplicationNo);
//				hshlockvalues.put("strUserId", strAppUser);
//				//strGetLock = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "lockApplication");
//			} else if (strEditMode.equalsIgnoreCase("U")) {
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(strApplicationNo);
//				hshQuery.put("arrValues", arrValues);
//				hshQuery.put("strQueryId", "perdelfinancialbnk");
//				intUpdatesize = 1;
//				hshQueryValues.put("1", hshQuery);
//				for (int i = 2; i < strtxtbank_name.length + 2; i++) {
//					if (!strtxtbank_name[i - 2].equals("")) {
//						intUpdatesize = intUpdatesize + 1;
//						hshQuery = new HashMap();
//						arrValues = new ArrayList();
//						hshQuery.put("strQueryId", "perinsfinancialbnk");
//						arrValues.add(strApplicationNo);
//						arrValues.add(correctNull(strchobank_apptype[i - 2]));
//						arrValues.add(new Integer(i - 1).toString());
//						arrValues.add(correctNull(strtxtbank_name[i - 2]));
//						arrValues
//								.add(correctNull(strtxtbank_branchname[i - 2]));
//						arrValues.add(correctNull(strtxtbank_accntno[i - 2]));
//						arrValues.add(correctNull(strchobank_accnttype[i - 2]));
//						if (correctNull(strtxtbank_balance[i - 2]).equals("")) {
//							arrValues.add("0.0");
//						} else {
//							arrValues
//									.add(correctNull(strtxtbank_balance[i - 2]));
//						}
//						arrValues.add(correctNull(strchkbank_iscoll[i - 2]));
//						arrValues.add(correctNull(strremarks[i - 2]));
//						hshQuery.put("arrValues", arrValues);
//						hshQueryValues.put("size", Integer
//								.toString(intUpdatesize));
//						hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
//					}
//				}
//				
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
//						"updateData");
//				//EJBInvoker.executeStateLess("appeditlock", hshlockvalues,"unLockApplication");
//				strGetLock = "n";
//				// Start of Audit Trial
//				
//				
//				
//				
//				
//
//				hshQueryValues = new HashMap();
//				intUpdatesize = 0;
//				//String strActionData = "";
//			/*	
//				for (int j = 0; j < strtxtbank_name.length; j++) {
//					if (!strtxtbank_name[j].equals("")) {
//						intUpdatesize = intUpdatesize + 1;
//						hshQuery = new HashMap();
//						arrValues = new ArrayList();
//						// for Entering the values into auditrial
//						strActionData = "Bank Name ="
//								+ correctNull(strtxtbank_name[j])
//								+ "~No. Of Years Account = "
//								+ correctNull(strtxtbank_branchname[j])
//								+ "~Type of Account= "
//								+ correctNull(strchobank_accnttype[j])
//								+ "~Account Number  = "
//								+ correctNull(strtxtbank_accntno[j])
//								+ "~Account Balance = "
//								+ correctNull(strtxtbank_balance[j])
//								+ "~Applicant Type = "
//								+ correctNull(strchobank_apptype[j])
//								+ "~Collateral = "
//								+ correctNull(strchkbank_iscoll[j])
//								+ "~remarks = " + correctNull(strremarks[j]);
//						hshQuery.put("strQueryId", "audittrial");
//						arrValues.add("47");
//						arrValues.add(correctNull((String) hshValues
//								.get("strUserId")));
//						arrValues.add(correctNull((String) hshValues
//								.get("strClientIP")));
//						arrValues.add(strApplicationNo);
//						arrValues.add(strActionData);
//						arrValues.add("Insert");
//						hshQuery.put("arrValues", arrValues);
//						hshQueryValues.put("size", Integer
//								.toString(intUpdatesize));
//						hshQueryValues.put(Integer.toString(intUpdatesize),
//								hshQuery);
//								
//					}
//				}
//				*/
//			//	EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
//			//			"updateData");
//				// End of Audit trial
//			}
//			else if(strEditMode.equalsIgnoreCase("D"))
//			{			
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				arrValues.add(strApplicationNo);
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","perdelfinancialbnk");
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			
//			String strAccountType=null;
//			for (int j = 0; j < strtxtbank_name.length; j++) {
//				if (!strtxtbank_name[j].equals("")) {
//		
//			sbAt.append("Bank/Branch Name & Telephone No=").append(strtxtbank_name[j]);
//			sbAt.append(" ~ Opened On=").append(strtxtbank_branchname[j]);
//			if(strchobank_accnttype[j].equals("AI"))strAccountType="Current";
//			else if(strchobank_accnttype[j].equals("AS"))strAccountType="Savings";
//			sbAt.append(" ~ Type of Account=").append(correctNull(strAccountType));
//			sbAt.append(" ~ Account Number =").append(correctNull(strtxtbank_accntno[j]));
//			sbAt.append(" ~ Account Balance =").append(correctNull(strtxtbank_balance[j]));
//			sbAt.append(" ~ Average Balance & Remarks =").append(correctNull(strremarks[j]));
//			sbAt.append(" ~ Applicant Type =").append(correctNull(strhid_chobank_apptype[j]));
//			sbAt.append(" ~ Collateral=").append(strchkbank_iscoll[j]);
//				}
//				}
//			if(strEditMode.equals("E"))hshValues.put("strAction","Update");
//			if(strEditMode.equals("U"))hshValues.put("strAction","Update");
//			else if(strEditMode.equals("D"))hshValues.put("strAction","Delete");
//			AuditTrial.auditLog(hshValues,"47",strApplicationNo,sbAt.toString());
//			
//			hshpasValues.put("appno", strApplicationNo);
//			hshResult = getData(hshpasValues);
//		} catch (Exception e) {
//			throw new EJBException("Error in Insert Data " + e.getMessage());
//		}
//		return hshResult;
//	}

	/**
	 * Function getInvestMent This Method is invoked for getting personal
	 * financial investment datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public HashMap getInvestMent(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		//double dblshareval = 0.0;

		//double dblnoofshares = 0.0;
		//double dblcusip = 0.0;
		String strApplicationNo="";
		String strQuery="";
		String strAppValue="";
		String recordflag="N";  
		try {
			
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			
			if(!strApplicationNo.equals("") && !strAppValue.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("pergetfinancialinv^"+strAppValue +"^" +strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				
				while (rs.next()) 
				{
					arryCol = new ArrayList();
					
					arryCol.add(rs.getString("stoc_serialno")); //0
					arryCol.add(rs.getString("stoc_desc")); //1
					arryCol.add(rs.getString("stoc_issusing"));//2
					arryCol.add(rs.getString("stoc_dateofissue")); //3
					arryCol.add(rs.getString("stoc_dateofmaturity")); //4
					arryCol.add(Helper.formatDoubleValue(rs.getDouble("stoc_amount"))); //5
					arryCol.add(Helper.formatDoubleValue(rs.getDouble("stoc_shareval"))); //6
					//arryCol.add(rs.getString("stoc_applnt")); //7
					arryCol.add(rs.getString("stoc_iscoll")); //8
					arryRow.add(arryCol);
					
	//				arryCol.add(rs.getString("stoc_isshare"));//1
	//				arryCol.add(rs.getString("stoc_noofshares")); //7
	//				dblshareval = Double.parseDouble(rs.getString("stoc_shareval")); //9
					//dblnoofshares = Double.parseDouble(rs.getString("stoc_noofshares"));
					//dblcusip = dblshareval * dblnoofshares;
					//arryCol.add(new Double(dblcusip).toString());//10
					recordflag="Y"; //audit trial
					
				}
			}
            hshResult.put("recordflag",recordflag);
			hshResult.put("arryRow", arryRow);
			hshResult.put("strAppValue", strAppValue);
			
		} catch (Exception ce) {
			throw new EJBException("Error in getInvestMent :: " + ce.getMessage());
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

	/**
	 * Function insertInvestMent used for inserting financial investment datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public void insertInvestMent(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		//HashMap hshpasValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strApplicationNo = "";
		String strAction="";
		String strQuery="";
		String strSno="";
		String strAppValue="";
		ResultSet rs=null;
		StringBuilder sbolddata=new StringBuilder();
		//HashMap hshResult = new HashMap();
		
		int intUpdatesize = 0;
		
		try {
			
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strSno=correctNull((String)hshValues.get("hidsno"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("pergetfinancialinvbysno^"+strSno+"^"+correctNull((String)hshValues.get("selapptype"))+"^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					sbolddata.append("Receipt No=").append(correctNull(rs.getString("stoc_desc")));
					sbolddata.append(" ~Issued By=").append(correctNull(rs.getString("stoc_issusing")));
					sbolddata.append(" ~Date of Issue=").append(correctNull(rs.getString("stoc_dateofissue")));
					sbolddata.append(" ~Date of Maturity=").append(correctNull(rs.getString("stoc_dateofmaturity")));
					sbolddata.append(" ~Current Value=").append(correctNull(rs.getString("stoc_shareval")));
					sbolddata.append(" ~Amount Invested=").append(correctNull(rs.getString("stoc_amount")));
					sbolddata.append(" ~Applicant Type=").append((String)hshValues.get("chostoc_applnt1"));
					sbolddata.append(" ~Collateral =").append(SetupParams.getSetupParams("SacrificeLimit",correctNull(rs.getString("stoc_iscoll"))));
				}
			}
			if (strAction.equalsIgnoreCase("insert")) 
			{
				
				strQuery=SQLParser.getSqlQuery("permaxfinancialinv^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					strSno=correctNull(rs.getString(1));	
				}
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId", "perinsfinancialinv");
				arrValues = new ArrayList();
				
				arrValues.add(strApplicationNo);
				arrValues.add(strSno);
				arrValues.add(strAppValue);
				arrValues.add(correctNull((String) hshValues.get("txtstoc_desc")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_shareval")));
				//arrValues.add(correctNull((String) hshValues.get("txtstoc_noofshares")));
				arrValues.add(correctNull((String) hshValues.get("hidstoc_iscoll")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_txt_DI")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_txt_DM")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_issusing")));
				//arrValues.add(correctNull((String) hshValues.get("hidstoc_isshare")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("update")) 
			{
				intUpdatesize = intUpdatesize + 1;
				hshQuery = new HashMap();
				
				hshQuery.put("strQueryId", "perupdfinancialinv");
				arrValues = new ArrayList();
				
				
				arrValues.add(strAppValue);
				arrValues.add(correctNull((String) hshValues.get("txtstoc_desc")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_shareval")));
				//arrValues.add(correctNull((String) hshValues.get("txtstoc_noofshares")));
				arrValues.add(correctNull((String) hshValues.get("hidstoc_iscoll")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_txt_DI")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_txt_DM")));
				arrValues.add(correctNull((String) hshValues.get("txtstoc_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_issusing")));
				//arrValues.add(correctNull((String) hshValues.get("hidstoc_isshare")));
				
				arrValues.add(strSno);
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
				{			
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(strSno);
					arrValues.add(strApplicationNo);
					
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","perdelfinancialinv");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}	
			
			StringBuilder sbAt = new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert"))) 
			{
				sbAt.append("Receipt No=").append(correctNull((String) hshValues.get("txtstoc_desc")));
				sbAt.append(" ~ Issued By=").append(correctNull((String) hshValues.get("txt_issusing")));
				sbAt.append(" ~ Date of Issue=").append(correctNull((String) hshValues.get("txtstoc_txt_DI")));
				sbAt.append(" ~ Date of Maturity=").append(correctNull((String) hshValues.get("txtstoc_txt_DM")));
				sbAt.append(" ~ Current Value=").append(correctNull((String) hshValues.get("txtstoc_shareval")));
				sbAt.append(" ~ Amount Invested=").append(correctNull((String) hshValues.get("txtstoc_amount")));
				sbAt.append(" ~ Applicant Type=").append((String)hshValues.get("chostoc_applnt1"));
				sbAt.append(" ~ Collateral=").append(SetupParams.getSetupParams("SacrificeLimit",correctNull((String) hshValues.get("hidstoc_iscoll"))));
			}
			AuditTrial.auditNewLog(hshValues,"48",strApplicationNo,sbAt.toString(),sbolddata.toString());
			
		} catch (Exception e) {
			throw new EJBException("Error in Delete Data " + e.getMessage());
		}
	}
	public HashMap getFinancialInvesmentCheck(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strReceiptNo = correctNull((String) hshRequestValues.get("hidid"));
		ArrayList arrAppno1 = new ArrayList();
		try
		{
			if (!strReceiptNo.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("getInvesmentColcheck^" + strReceiptNo);
				while (rs.next())
				{
					arrAppno1.add(rs.getString(1));
				}
				hshRecord.put("arrAppno1", arrAppno1);
			}
		}
		catch (Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	/**
	 * Function getPolicy This Method is invoked for getting personal financial
	 * policy datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public HashMap getFinancialInsuranceCheck(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strPolicyNo = correctNull((String) hshRequestValues.get("hidid"));
		ArrayList arrAppno1 = new ArrayList();
		try
		{
			if (!strPolicyNo.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("getInsuranceColcheck^" + strPolicyNo);
				while (rs.next())
				{
					arrAppno1.add(rs.getString(1));
				}
				hshRecord.put("arrAppno1", arrAppno1);
			}
		}
		catch (Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch (Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap getPolicy(HashMap hshValues)  {
		ResultSet rs = null;
		
		HashMap hshResult = new HashMap();
		
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		
		String strApplicationNo ="";
		String strAppValue="";
		String strQuery="";
		String recordflag="N";  
		
		try {
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			
			strQuery=SQLParser.getSqlQuery("pergetfinancialpol^"+strAppValue+"^"+strApplicationNo);
			
			rs = DBUtils.executeQuery(strQuery);
			
			while (rs.next()) 
			{
				arryCol = new ArrayList();
			
				arryCol.add(rs.getString("insu_serialno"));
				arryCol.add(rs.getString("insu_policyno"));
				arryCol.add(rs.getString("insu_matdate"));
				arryCol.add(rs.getString("insu_prepaid"));
				arryCol.add(rs.getString("insu_surrenderval"));
				arryCol.add(rs.getString("insu_agencyname"));
				arryCol.add(rs.getString("insu_agencyphone"));
				arryCol.add(rs.getString("insu_iscoll"));
				arryRow.add(arryCol);
				recordflag="Y";
			}
			
			hshResult.put("arryRow", arryRow);
			hshResult.put("strAppValue", strAppValue);
		
		} catch (Exception ce) {
			throw new EJBException("Error in closing getData" + ce.getMessage());
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

	/**
	 * Function insertPolicy used for inserting financial investment datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public void insertPolicy(HashMap hshValues)  
	{
	
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQuery1 = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		
		String strApplicationNo = "";
		String strAction="";
		String strSno="";
		String strQuery="";
		StringBuilder sbolddata=new StringBuilder();
		ResultSet rs=null;
		
		int intUpdatesize = 0;
		
		try 
		{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAction=correctNull((String)hshValues.get("hidAction"));
			strSno=correctNull((String)hshValues.get("hidsno"));
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("pergetfinancialpolbysno^"+strSno+"^"+correctNull((String)hshValues.get("selapptype"))+"^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Policy Number =").append(correctNull(rs.getString("insu_policyno")));
					sbolddata.append(" ~Maturity Date = ").append(correctNull(rs.getString("insu_matdate")));
					sbolddata.append(" ~Last Premium Paid upto = ").append(correctNull(rs.getString("insu_prepaid")));
					sbolddata.append(" ~Surrender/Paidup Value = ").append(correctNull(rs.getString("insu_surrenderval")));
					sbolddata.append(" ~Insurance Company Name = ").append(correctNull(rs.getString("insu_agencyname")));
					sbolddata.append(" ~Sum Assured = ").append(correctNull(rs.getString("insu_agencyphone")));
					sbolddata.append(" ~Applicant Type = ").append(correctNull((String)hshValues.get("hid_choinsu_applnt")));
					if(correctNull(rs.getString("insu_iscoll")).equalsIgnoreCase("Y")){
						sbolddata.append(" ~Collateral = ").append("Yes");
					}
					else if(correctNull(rs.getString("insu_iscoll")).equalsIgnoreCase("n")){
						sbolddata.append(" ~Collateral = ").append("No");
					}
					else
					{
						sbolddata.append(" ~Collateral = ").append("");
					}
				}
			}
			if (strAction.equalsIgnoreCase("insert")) 
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
					
				strQuery=SQLParser.getSqlQuery("permaxfinancialins^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
	
				if(rs.next())
				{
					strSno=correctNull(rs.getString(1));	
				}
				
				hshQuery.put("strQueryId", "perinsfinancialpol");
				
			
				arrValues.add(strApplicationNo);
				arrValues.add(correctNull((String)hshValues.get("selapptype")));
				arrValues.add(strSno);
			
				arrValues.add(correctNull((String)hshValues.get("txtinsu_policyno")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_surrenderval")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_agencyname")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_agencyphone")));
				arrValues.add(correctNull((String)hshValues.get("hidinsu_iscoll")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_matdate")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_prepaid")));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("update")) 
			{
				hshQuery1=new HashMap();
				strApplicationNo = correctNull((String) hshValues.get("appno"));
				strAction=correctNull((String)hshValues.get("hidAction"));
				strSno=correctNull((String)hshValues.get("hidsno"));
				//strQuery=SQLParser.getSqlQuery("permaxfinancialins^"+strApplicationNo);
				//rs=DBUtils.executeQuery(strQuery);
	
				//if(rs.next())
				//{
				//	strSno=correctNull(rs.getString(1));	
				//}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize = intUpdatesize + 1;
					
				hshQuery.put("strQueryId", "perupdfinancialpol");
				
				arrValues.add(correctNull((String)hshValues.get("selapptype")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_policyno")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_surrenderval")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_agencyname")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_agencyphone")));
				arrValues.add(correctNull((String)hshValues.get("hidinsu_iscoll")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_matdate")));
				arrValues.add(correctNull((String)hshValues.get("txtinsu_prepaid")));
				
				arrValues.add(strSno);
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize + 1;
				
				hshQuery.put("strQueryId","perdelfinancialpol");
				
				arrValues.add(strSno);
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			
			/** Audit Trial**/
			StringBuilder sbAt = new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert"))) 
			{	
				sbAt.append("Policy Number =").append(correctNull((String)hshValues.get("txtinsu_policyno")));
				sbAt.append(" ~Maturity Date = ").append(correctNull((String)hshValues.get("txtinsu_matdate")));
				sbAt.append(" ~Last Premium Paid upto = ").append(correctNull((String)hshValues.get("txtinsu_prepaid")));
				sbAt.append(" ~Surrender/Paidup Value = ").append(correctNull((String)hshValues.get("txtinsu_surrenderval")));
				sbAt.append(" ~Insurance Company Name= ").append(correctNull((String)hshValues.get("txtinsu_agencyname")));
				sbAt.append(" ~Sum Assured = ").append(correctNull((String)hshValues.get("txtinsu_agencyphone")));
				sbAt.append(" ~Applicant Type = ").append(correctNull((String)hshValues.get("hid_choinsu_applnt")));
				if(correctNull((String)hshValues.get("hidinsu_iscoll")).equalsIgnoreCase("Y")){
					sbAt.append(" ~Collateral = ").append("Yes");
				}
				else if(correctNull((String)hshValues.get("hidinsu_iscoll")).equalsIgnoreCase("n")){
					sbAt.append(" ~Collateral = ").append("No");
				}
				else
				{
					sbAt.append(" ~Collateral = ").append("");
				}
			}
			AuditTrial.auditNewLog(hshValues,"49",strApplicationNo,sbAt.toString(),sbolddata.toString());
		} catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
		//return hshResult;
	}

	/**
	 * Function getProperty This Method is invoked for getting personal
	 * financial policy datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

//	public HashMap getProperty(HashMap hshValues)  {
//		ResultSet rs = null;
//		HashMap hshResult = new HashMap();
//		ArrayList arryRow = new ArrayList();
//		ArrayList arryCol = null;
//		String strApplicationNo = correctNull((String) hshValues.get("appno"));
//		String recordflag="N";
//		try {
//			rs = DBUtils.executeLAPSQuery("pergetfinancialprop^"
//					+ strApplicationNo);
//			while (rs.next()) {
//				arryCol = new ArrayList();
//				arryCol.add(rs.getString("prop_appno"));
//				arryCol.add(rs.getString("prop_applnt"));
//				arryCol.add(rs.getString("prop_serialno"));
//				arryCol.add(rs.getString("prop_desc"));
//				arryCol.add(rs.getString("prop_purchaseval"));
//				arryCol.add(rs.getString("prop_marketval"));
//				arryCol.add(rs.getString("prop_iscoll"));
//				arryCol.add(rs.getString("prop_valuation_date"));
//				arryCol.add(rs.getString("prop_valuation_by"));
//				arryCol.add(rs.getString("prop_charged"));
//				arryCol.add(rs.getString("prop_assettype"));
//				arryCol.add(rs.getString("pro_whether_leased"));
//				arryRow.add(arryCol);
//				recordflag="Y";
//			}
//			hshResult.put("arryRow", arryRow);
//			hshResult.put("recordflag", recordflag);
//		} catch (Exception ce) {
//			throw new EJBException("Error in closing getData" + ce.getMessage());
//		} finally {
//			try {
//				if (rs != null) {
//					rs.close();
//				}
//			} catch (Exception e) {
//				throw new EJBException("Error in closing Connection "
//						+ e.getMessage());
//			}
//		}
//		return hshResult;
//	}

	/**
	 * Function insertProperty used for inserting financial investment datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

//	public HashMap insertProperty(HashMap hshValues)  {
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshpasValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		String strApplicationNo = "";
//		String[] strtxtprop_desc = null;
//		String[] strtxtprop_purchaseval = null;
//		String[] strtxtprop_marketval = null;
//		String[] strchoprop_applnt = null;
//		String[] strchkprop_iscoll = null;
//		String[] strchkprop_valuationdate = null;
//		String[] strchkprop_valuationdoneby = null;
//		String[] strchkprop_charged = null;
//		String[] strchkprop_assettype = null;
//		String[] strpro_whether_leased = null;
//		HashMap hshResult = new HashMap();
//		int intUpdatesize = 0;
//		String strAction=correctNull((String)hshValues.get("hidAction"));
//		strApplicationNo = correctNull((String) hshValues.get("appno"));
//		strtxtprop_desc = (String[]) hshValues.get("txtprop_desc");
//		strtxtprop_purchaseval = (String[]) hshValues.get("txtprop_purchaseval");
//		strtxtprop_marketval = (String[])hshValues.get("txtprop_marketval");
//		strchoprop_applnt = (String[])hshValues.get("choprop_applnt");
//		strchkprop_iscoll = (String[])hshValues.get("hidprop_iscoll");
//		strchkprop_valuationdate = (String[]) hshValues.get("txtprop_valuationdate");
//		strchkprop_valuationdoneby = (String[]) hshValues.get("txtprop_valuationdoneby");
//		strchkprop_charged = (String[])hshValues.get("txtprop_charged");
//		strchkprop_assettype =(String[]) hshValues.get("txtprop_assettype");
//		strpro_whether_leased =(String[]) hshValues.get("txtpro_whether_leased");    
//		String[] strhid_choprop_applnt =(String[]) hshValues.get("hid_choprop_applnt"); 
//		String[] strhid_txtprop_assettype =(String[]) hshValues.get("hid_txtprop_assettype"); 
//		
//		try {
//			if (strAction.equalsIgnoreCase("update")) {
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(strApplicationNo);
//				hshQuery.put("arrValues", arrValues);
//				intUpdatesize = 1;
//				hshQuery.put("strQueryId", "perdelfinancialprop");
//				hshQueryValues.put("1", hshQuery);
//				for (int i = 2; i < strtxtprop_desc.length + 2; i++) {
//					if (!strtxtprop_desc[i - 2].equals("")) {
//						hshQuery = new HashMap();
//						arrValues = new ArrayList();
//						intUpdatesize = intUpdatesize + 1;
//						hshQuery.put("strQueryId", "perinsfinancialprop");
//						arrValues.add(strApplicationNo);
//						arrValues.add(correctNull(strchoprop_applnt[i - 2]));
//						arrValues.add(new Integer(i - 1).toString());
//						arrValues.add(correctNull(strtxtprop_desc[i - 2]));
//						if (correctNull(strtxtprop_purchaseval[i - 2]).equals("")) {
//							arrValues.add("0.0");
//						} else {
//							arrValues.add(correctNull(strtxtprop_purchaseval[i - 2]));
//						}
//						if (correctNull(strtxtprop_marketval[i - 2]).equals("")) {
//							arrValues.add("0.0");
//						} else {
//							arrValues.add(correctNull(strtxtprop_marketval[i - 2]));
//						}
//						arrValues.add(correctNull(strchkprop_iscoll[i - 2]));
//
//						if (correctNull(strchkprop_valuationdate[i - 2]).equals("")) {
//							arrValues.add("01/01/1900");
//						} else {
//							arrValues.add(correctNull(strchkprop_valuationdate[i - 2]));
//						}
//						arrValues.add(correctNull(strchkprop_valuationdoneby[i - 2]));
//						if (correctNull(strchkprop_charged[i - 2]).equals("")) {
//							arrValues.add("0");
//						} else {
//							arrValues.add(correctNull(strchkprop_charged[i - 2]));
//						}
//						if (correctNull(strchkprop_assettype[i - 2]).equals("")) {
//							arrValues.add("0");
//						} else {
//							arrValues.add(correctNull(strchkprop_assettype[i - 2]));
//						}
//						if (correctNull(strpro_whether_leased[i - 2]).equals(
//								"")) {
//							arrValues.add("0");
//						} else {
//							arrValues.add(correctNull(strpro_whether_leased[i - 2]));// strchkprop_assettype
//						}
//						hshQuery.put("arrValues", arrValues);
//						hshQueryValues.put("size", Integer.toString(intUpdatesize));
//						hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
//					}
//				}
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
//				
//			}// end of else if(strEditMode.equalsIgnoreCase("U"))
//			
//			else if(strAction.equalsIgnoreCase("delete"))
//			{			
//				hshQuery=new HashMap();
//				arrValues=new ArrayList();
//				arrValues.add(strApplicationNo);
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","perdelfinancialprop");
//				hshQueryValues.put("1",hshQuery);
//				hshQueryValues.put("size","1");
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//			
//			StringBuilder sbAt = new StringBuilder();
//			
//			for (int j = 0; j < strtxtprop_desc.length; j++) {
//				if (!strtxtprop_desc[j].equals("")) {
//			sbAt.append("Description /Address Details =").append( correctNull(strtxtprop_desc[j]));
//			sbAt.append(" ~ Purchase Value=").append(correctNull(strtxtprop_purchaseval[j]));
//			sbAt.append(" ~ Present Value/Market Value=").append(correctNull(strtxtprop_marketval[j]));
//			sbAt.append(" ~ Valuation Date=").append(correctNull(strchkprop_valuationdate[j]));
//			sbAt.append(" ~ Valuation Done By=").append(correctNull(strchkprop_valuationdoneby[j]));
//			sbAt.append(" ~ whether leaseholder or ownership =").append(correctNull(strpro_whether_leased[j]).equals("0")?"LEASED":"OWNED");
//			sbAt.append(" ~ Applicant Type =").append(strhid_choprop_applnt[j]);
//			sbAt.append(" ~ Already Charged=").append(correctNull(strchkprop_charged[j]).equals("Y")?"YES":"NO");
//			sbAt.append(" ~ Asset Type=").append(correctNull(strhid_txtprop_assettype[j]));
//			sbAt.append(" ~ Collateral=").append(strchkprop_iscoll[j]);
//				}
//			}
//			AuditTrial.auditLog(hshValues,"50",strApplicationNo,sbAt.toString());
//			hshpasValues.put("appno", strApplicationNo);
//			hshResult = getProperty(hshpasValues);
//		} catch (Exception e) {
//			throw new EJBException("Error in Insert Data " + e.getMessage());
//		}
//		return hshResult;
//	}

	/**
	 * Function getLiability This Method is invoked for getting personal
	 * liabilities datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */
 
	public HashMap getLiability(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		String strApplicationNo="";
		String strAppValue="";
		String strQuery="";
		try {
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			
			strQuery=SQLParser.getSqlQuery("pergetfinancialliab^"+ strAppValue+"^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				arrCol = new ArrayList();
				
				arrCol.add(correctNull(rs.getString("liab_serialno")));
				arrCol.add(correctNull(rs.getString("liab_company")));
				arrCol.add(correctNull(rs.getString("liab_loantype")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("liab_crdlimit")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("liab_balance")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("liab_minpayment")));
				arrCol.add(correctNull(rs.getString("liab_accountno")));
				arrCol.add(correctNull(rs.getString("per_defaultoverdue")));
				arrCol.add(correctNull(rs.getString("per_securities")));
				arrCol.add(correctNull(rs.getString("per_ourbank")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("liab_overdueamount")));
				arrCol.add(Helper.correctNull(rs.getString("liab_sancrefno")));
				arrCol.add(Helper.correctNull(rs.getString("liab_presentstatus")));
				
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			hshResult.put("strAppValue", strAppValue);
			hshResult.put("strAppNo", strApplicationNo);
		} catch (Exception ce) {
			throw new EJBException("Error in closing getLiability :: " + ce.getMessage());
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

	/**
	 * Function insertLiability used for inserting financial liabilities datas
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.ejb.EJBException
	 */

	public void insertLiability(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "";
		String strtxtliab_inst = "";
		String strtxtliab_accountno = "";
		String strtxtliab_overdue = "";
		String strtxtliab_minpayment = "";
		String strchkourbank = "";
		String strtxtliab_loanamt = "";
		String strtxtliab_balance = "";
		String strAppValue = "";
		String strcholiab_loantype = "";
		String strliab_overdueamount = "";
		String strtxtliab_secur = "";
		String strslno = "";
		String strhid_choliab_applnt="";
		String strhid_choliab_loantype="";
		String strQuery="";
		String strtxtliab_sancrefno="";
		String strtxtliab_presentstatus="";
		StringBuilder sbolddata=new StringBuilder();
		
		ResultSet rs = null;
		String strAction = correctNull((String) hshValues.get("hidAction"));
		try 
		{
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			strAppValue = correctNull((String) hshValues.get("selapptype"));
			strslno = correctNull((String) hshValues.get("hidsno"));
			
			strtxtliab_inst = correctNull((String) hshValues.get("txtliab_inst"));
			strcholiab_loantype = correctNull((String) hshValues.get("choliab_loantype"));
			strtxtliab_loanamt = correctNull((String) hshValues.get("txtliab_loanamt"));
			strtxtliab_balance = correctNull((String) hshValues.get("txtliab_balance"));
			strtxtliab_minpayment = correctNull((String) hshValues.get("txtliab_minpayment"));
			strtxtliab_accountno = correctNull((String) hshValues.get("txtliab_accountno"));
			strtxtliab_overdue = correctNull((String) hshValues.get("txtliab_overduesince"));
			strtxtliab_secur = correctNull((String) hshValues.get("txtliab_secur"));
			strchkourbank = correctNull((String) hshValues.get("checkourbank"));
			strhid_choliab_applnt = correctNull((String) hshValues.get("hidAppType"));
			strliab_overdueamount = correctNull((String) hshValues.get("txtliab_overdueamount"));
			strhid_choliab_loantype = correctNull((String) hshValues.get("hid_choliab_loantype"));
			strtxtliab_sancrefno = correctNull((String) hshValues.get("txtliab_sancrefno"));
			strtxtliab_presentstatus = correctNull((String) hshValues.get("txtliab_presentstatus"));
			
			if (strchkourbank.equalsIgnoreCase("")) {
				strchkourbank = "N";
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("pergetfinancialliabbysno^"+strslno+"^"+correctNull((String)hshValues.get("selapptype"))+"^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbolddata.append("Name of the Institution =").append(correctNull(rs.getString("liab_company")));
					sbolddata.append(" ~Purpose of Loan=").append(correctNull(rs.getString("liab_accountno")));
					sbolddata.append(" ~Of Which Overdue =").append(correctNull(rs.getString("liab_overdueamount")));
					sbolddata.append(" ~Monthly/Min Payment  =").append(correctNull(rs.getString("liab_minpayment")));
					if(correctNull(rs.getString("per_ourbank")).equalsIgnoreCase("Y"))
					{
						sbolddata.append(" ~Our Bank =").append("Yes");
					}
					else if(correctNull(rs.getString("per_ourbank")).equalsIgnoreCase("N"))
					{
						sbolddata.append(" ~Our Bank =").append("No");
					}
					sbolddata.append(" ~Loan Amount  =").append(correctNull(rs.getString("liab_crdlimit")));
					sbolddata.append(" ~Outstanding Balance =").append(correctNull(rs.getString("liab_balance")));
					sbolddata.append(" ~Applicant Type  =").append(strhid_choliab_applnt);//Doubt have to ask Suresh
					String loantype=correctNull(rs.getString("liab_loantype"));
					sbolddata.append(" ~Loan Type=").append(correctNull(ApplicantParams.getApplicantParams("LOANTYPE",loantype)));
					sbolddata.append(" ~Overdue since =").append(correctNull(rs.getString("per_defaultoverdue")));
					//sbolddata.append(" ~Securities Offered  =").append(correctNull(rs.getString("per_securities"))); //TextArea
				}
			}
			
			if (strAction.equalsIgnoreCase("insert")) 
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "perinsfinancialliab");
				
				rs = DBUtils.executeLAPSQuery("perfinancialliabmax^"+strApplicationNo);
				if (rs.next()) {
					strslno = rs.getString("maxid");
				}
				
				arrValues.add(correctNull(strApplicationNo));
				arrValues.add(correctNull(strAppValue));
				arrValues.add(correctNull(strslno));
				arrValues.add(correctNull(strtxtliab_inst));
				arrValues.add(correctNull(strcholiab_loantype));
				arrValues.add(Helper.correctDouble(strtxtliab_loanamt));
				arrValues.add(Helper.correctDouble(strtxtliab_balance));
				arrValues.add(Helper.correctDouble(strtxtliab_minpayment));
				arrValues.add(correctNull(strtxtliab_accountno));
				arrValues.add(correctNull(strtxtliab_overdue));
				arrValues.add(correctNull(strtxtliab_secur));
				arrValues.add(correctNull(strchkourbank));
				arrValues.add(correctNull(strliab_overdueamount));
				arrValues.add(correctNull(strtxtliab_sancrefno));
				arrValues.add(correctNull(strtxtliab_presentstatus));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			} 
			else if (strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues.put("size", "1");

				hshQuery.put("strQueryId", "perupdfinancialliab");
				arrValues.add(correctNull(strApplicationNo));
				arrValues.add(correctNull(strAppValue));
				arrValues.add(correctNull(strtxtliab_inst));
				arrValues.add(correctNull(strcholiab_loantype));
				arrValues.add(Helper.correctDouble(strtxtliab_loanamt));
				arrValues.add(Helper.correctDouble(strtxtliab_balance));
				arrValues.add(Helper.correctDouble(strtxtliab_minpayment));
				arrValues.add(correctNull(strtxtliab_accountno));
				arrValues.add(correctNull(strtxtliab_overdue));
				arrValues.add(correctNull(strtxtliab_secur));
				arrValues.add(correctNull(strchkourbank));
				arrValues.add(correctNull(strliab_overdueamount));
				arrValues.add(correctNull(strtxtliab_sancrefno));
				arrValues.add(correctNull(strtxtliab_presentstatus));

				arrValues.add(correctNull(strslno));
				arrValues.add(correctNull(strApplicationNo));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			} 
			else if (strAction.equalsIgnoreCase("delete")) 
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "perdelfinancialliab");
				
				arrValues.add(correctNull(strslno));
				arrValues.add(correctNull(strApplicationNo));

				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			//    for audit trial
			StringBuilder sbAt = new StringBuilder();
			if((strAction.equalsIgnoreCase("update"))||(strAction.equalsIgnoreCase("insert")))
			{
				sbAt.append("Name of the Institution =").append(strtxtliab_inst);
				sbAt.append(" ~ Purpose of Loan=").append(strtxtliab_accountno);
				sbAt.append(" ~ Of Which Overdue =").append(strliab_overdueamount);
				
				sbAt.append(" ~Monthly/Min Payment  =").append(strtxtliab_minpayment);
				
				if(strchkourbank.equalsIgnoreCase("Y"))
				{
					sbAt.append(" ~Our Bank =").append("Yes");
				}
				else if(strchkourbank.equalsIgnoreCase("N"))
				{
					sbAt.append(" ~Our Bank =").append("No");
				}
				sbAt.append(" ~Loan Amount  =").append(strtxtliab_loanamt);
				sbAt.append(" ~Outstanding Balance =").append(strtxtliab_balance);
				sbAt.append(" ~Applicant Type  =").append(strhid_choliab_applnt);
				sbAt.append(" ~ Loan Type=").append(strhid_choliab_loantype);
				sbAt.append(" ~Overdue since =").append(strtxtliab_overdue);
				//sbAt.append(" ~Securities Offered  =").append(strtxtliab_secur);
			}				
			AuditTrial.auditNewLog(hshValues,"51",strApplicationNo,sbAt.toString(),sbolddata.toString());
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}
	public HashMap getComments(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno=Helper.correctNull((String)hshValues.get("hidAppNo"));
		String page=Helper.correctNull((String)hshValues.get("hidCommentPage"));
		if(appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull((String)hshValues.get("hidDemoId"));
		}
		String pagetype=Helper.correctNull((String)hshValues.get("hidCommentPage"));
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_retailcomments^"+ appno+"^"+pagetype);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshResult.put("cmt_comments", Helper.CLOBToString(rs.getClob("cmt_comments")));
				hshResult.put("cmt_cmtinter", Helper.CLOBToString(rs.getClob("cmt_intercomments")));
			}
			hshResult.put("page", page);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getComments" + e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}
	public HashMap getBankComments(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String appno=Helper.correctNull((String)hshValues.get("hidDemoId"));
		String pagetype=Helper.correctNull((String)hshValues.get("hidCommentPage"));
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_bankcomments^"+ appno+"^"+pagetype);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) 
			{
				hshResult.put("cmt_comments", Helper.CLOBToString(rs.getClob("cmt_bankcomments")));
				hshResult.put("cmt_cmtinter", Helper.CLOBToString(rs.getClob("cmt_bankcomments2")));
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getComments" + e.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection "
						+ e.getMessage());
			}
		}
		return hshResult;
	}
	public void updateComments(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("hidAppNo"));
		if(appno.equalsIgnoreCase(""))
		{
			appno=Helper.correctNull((String)hshValues.get("hidDemoId"));
		}
		String pagetype=Helper.correctNull((String)hshValues.get("hidCommentPage"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strComments=Helper.correctNull((String)hshValues.get("txtarea_comments"));
		String strComminter=Helper.correctNull((String)hshValues.get("txtarea_comments1"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_retailcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_retailcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				arrValues.add(strComments);
				arrValues.add(strComminter);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_retailcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}
	public void updateBankComments(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String appno=Helper.correctNull((String)hshValues.get("hidDemoId"));
		String pagetype=Helper.correctNull((String)hshValues.get("hidCommentPage"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strComments=Helper.correctNull((String)hshValues.get("txtarea_comments"));
		String strComments1=Helper.correctNull((String)hshValues.get("txtarea_comments1"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "del_bankcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "ins_bankcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				arrValues.add(strComments);				
				arrValues.add(strComments1); 				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_bankcomments");
				arrValues.add(appno);
				arrValues.add(pagetype);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		}
	}
	
	public HashMap invokeProcedureCIBIL(HashMap hshValues)  
	{
		HashMap hshResult = new HashMap();
		HashMap hshResultCibil = new HashMap();
		HashMap hshResultProcCall = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshAuditVal = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "", strAppId = "", strAppSno="";
		Connection connectionORC = null;
		CallableStatement callableStmt2 = null;
		FileWriter fout = null;
		ResultSet rs = null;
		String SeqID = "",strQuery="",strReqStatus="",strOverAllStatus="",strExp="$",strReqID="",StrKeyVal="",strScore="",strBureau="",strBureauAction="";
		String strUserID = Helper.correctNull((String) hshValues.get("strUserId"));
		List arrParameterValues = null;
		try 
		{
			String strModuleType=correctNull((String) hshValues.get("sessionModuleType"));
			String strBorrowerType=correctNull((String) hshValues.get("hidBorrowerType"));
			String strAction = correctNull((String) hshValues.get("hidAction"));
			strApplicationNo = correctNull((String) hshValues.get("appno"));			
			strAppId = correctNull((String) hshValues.get("hidAppIdVal"));
			String strMailSeqId = correctNull((String) hshValues.get("hidMailSeqId"));
			String strRequestType = correctNull((String) hshValues.get("hidRequest"));
			String strPageID = Helper.correctNull((String) hshValues.get("hidPageId"));
			if("".equals(strPageID))
				strPageID = Helper.correctNull((String) hshValues.get("PageId"));			
			
			String hidPageId=Helper.correctNull((String) hshValues.get("hidPageId"));
			if(hidPageId.equals("BureauReport"))
			{
				strApplicationNo=Helper.correctNull((String) hshValues.get("hidBRappno"));
			}
			
			if(strAction.equalsIgnoreCase("procCall") || strAction.equalsIgnoreCase("ReGenReport")){
				
				/*
			     * update CIBIL Report Checkbox
			     * Added by Kishan on 16062015
			     */
			    String[] strChrVal = Helper.correctNull((String) hshValues.get("hidSelChk")).split("@");
			    hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(Helper.correctNull(strChrVal[0]));
				//arrValues.add(Helper.correctNull(strChrVal[1]));
				//arrValues.add(Helper.correctNull(strChrVal[2]));
				arrValues.add(strApplicationNo);
				arrValues.add(strAppId);
				
				if(hidPageId.equals("BureauReport"))
				{
					hshQuery.put("strQueryId", "upd_cibilreport_bureaulinkflag");
				}
				else
				{
					if(strModuleType.equals("CORP") || strModuleType.equals("AGRI"))
					{
						if(strBorrowerType.equalsIgnoreCase("a"))
							hshQuery.put("strQueryId", "upd_cibilreport_CorpAppl");
						else
							hshQuery.put("strQueryId", "upd_cibilreport_corpBorr");
					}
					else
					{
						hshQuery.put("strQueryId", "upd_cibilreport");
					}
				}
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				
				// CRIF --harish check
			 	connectionORC = ConnectionFactory.getConnection();
			 	if(hidPageId.equals("BureauReport"))
				{
				 	callableStmt2 = connectionORC.prepareCall("call PROC_CRIF_REQ_BUREAU(?,?,?,?,?)");
				}
			 	else
			 	{
				 	callableStmt2 = connectionORC.prepareCall("call PROC_CRIF_REQ(?,?,?,?,?)");
			 	}
			    
			    callableStmt2.setString(1,Helper.correctNull(strApplicationNo));
			    callableStmt2.setString(2,Helper.correctNull(strAppId));
				if(hidPageId.equals("BureauReport"))
				{
			    	callableStmt2.setString(3,"BR");
				}
				else
				{
				    if(strModuleType.equalsIgnoreCase("CORP"))
				    callableStmt2.setString(3,"C");
				    else if(strModuleType.equalsIgnoreCase("AGR"))
				    	callableStmt2.setString(3,"A");
				    else
				    	callableStmt2.setString(3,"P");
				}
			    callableStmt2.setString(4,strBorrowerType);
			    callableStmt2.setString(5,strRequestType);
			    callableStmt2.execute();
			    callableStmt2.clearParameters();
			    callableStmt2.close();
			    connectionORC.close();	  
			    
			    /*
				 * insert user details
				 * added by Kishan on 16062015
				 */
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strApplicationNo);
				arrValues.add(strAppId);
				arrValues.add(strUserID);
				hshQuery.put("strQueryId", "ins_cibil_userdetails");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}else if(strAction.equalsIgnoreCase("GenReport")){
				
				if(rs!=null)
					rs.close();
				
				hshResultProcCall = (HashMap)EJBInvoker.executeStateLess("perfinancial", hshValues, "cibilReportCheckProcCall");
				strReqStatus = Helper.correctNull((String) hshResultProcCall.get("strReqStatus"));
				strOverAllStatus = Helper.correctNull((String) hshResultProcCall.get("strOverAllStatus"));
				strReqID = Helper.correctNull((String) hshResultProcCall.get("strReqID"));
				
				
				if("9".equals(strReqStatus) && "FINISH".equalsIgnoreCase(strOverAllStatus))
				{
					String strURL = "http://"+ApplicationParams.getStrCIBILPATH()+"/InquiryAgentOriginal/showBaseReport.action";
	                log.info("Interface URL ==============> "+strURL);
					String charset = "UTF-8";																																		
					String query = String.format("customerId=%s&loanId=%s",						  
				    URLEncoder.encode(strAppId,charset),
				    URLEncoder.encode(strApplicationNo,charset)			    
				    );
					URLConnection connection = new URL(strURL+ "?" + query).openConnection();
					connection.setDoOutput(true);
					connection.setRequestProperty("Accept-Charset", charset);	
					log.info("Response URL ==============> "+strURL);
					
					if(rs!=null)
						rs.close();
					strQuery=SQLParser.getSqlQuery("select_cibil_seqno");
					rs=DBUtils.executeQuery(strQuery);
					if (rs.next()){
						SeqID = Helper.correctNull(rs.getString("seqNo"));
					}			
					
					String FileName = ApplicationParams.getStrCIBILReportPath()+"//"+SeqID+".html";
					log.info("FileName ==============> "+FileName);
					BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
					BufferedWriter writer = new BufferedWriter(new FileWriter(FileName));
					String inputfile;
					while((inputfile=in.readLine()) != null)
					{
						writer.write(inputfile);
					}
					in.close();
					writer.close();
					
					InputStream is = new FileInputStream(FileName);
	     			byte[] byFileName = new byte[is.available()];
					int i = is.read(byFileName);	
					
					hshQuery.put("strQueryId", "insert_cibil_data");
					arrValues.add(SeqID);
					arrValues.add(byFileName);
					arrValues.add(String.valueOf(byFileName.length));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);								
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "insert_cibil_nomapping");			
					arrValues.add(strApplicationNo);
					arrValues.add(strAppId);
					arrValues.add(SeqID);
					arrValues.add(strReqID);
					arrValues.add(strUserID);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("2", hshQuery);
					hshQueryValues.put("size", "2");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					
					hshResultCibil = (HashMap)EJBInvoker.executeStateLess("perfinancial", hshValues, "cibilReportScore");
					strScore = Helper.correctNull((String) hshResultCibil.get("strScore"));
					strBureau = Helper.correctNull((String) hshResultCibil.get("strBureau"));
					strBureauAction = Helper.correctNull((String) hshResultCibil.get("strBureau"));
					
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					log.info("Score updation ============== in Customer profile");
					if(hidPageId.equals("BureauReport"))
					{
						if(strBureauAction.equalsIgnoreCase("CIBIL"))
							hshQuery.put("strQueryId", "upd_cibilreport_bureaulink^BUR_CIBIL_SCORE^BUR_CIBILDATE");
						else
							hshQuery.put("strQueryId", "upd_cibilreport_bureaulink^BUR_CRIF_SCORE^BUR_CRIFDATE");
					}
					else
					{
						if(strModuleType.equals("CORP") || strModuleType.equals("AGRI"))
						{
							if(strBorrowerType.equalsIgnoreCase("a"))
							{
								if(strBureauAction.equalsIgnoreCase("CIBIL"))
									hshQuery.put("strQueryId", "upd_demographics_cibilscore_CorpAppl^demo_cibil_score");
								else
									hshQuery.put("strQueryId", "upd_demographics_cibilscore_CorpAppl^demo_crif_score");
							}
							else
							{
								if(strBureauAction.equalsIgnoreCase("CIBIL"))
									hshQuery.put("strQueryId", "upd_demographics_cibilscore_corpBorr^demo_cibil_score");
								else
									hshQuery.put("strQueryId", "upd_demographics_cibilscore_corpBorr^demo_crif_score");
							}
						}
						else
						{
							if(strBureauAction.equalsIgnoreCase("CIBIL"))
								hshQuery.put("strQueryId","upd_demographics_cibilscore^demo_cibil_score");
							else
								hshQuery.put("strQueryId","upd_demographics_cibilscore^demo_crif_score");
						}
					}
					arrValues.add(strScore);
					arrValues.add(strApplicationNo);
					arrValues.add(strAppId);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					
					//Store CIBIL score in customer Profile
					if(rs!=null)
						rs.close();
					boolean cibildata=false;
					
					if(hidPageId.equals("BureauReport"))
					{
						strQuery=SQLParser.getSqlQuery("sel_CIBILdetails_bureau^"+strApplicationNo);
					}
					else
					{
						if(strModuleType.equals("CORP") || strModuleType.equals("AGRI"))
						{
							if(strBorrowerType.equalsIgnoreCase("a"))
								strQuery=SQLParser.getSqlQuery("sel_CIBILdetails_corpAppl^"+strApplicationNo);
							else
								strQuery=SQLParser.getSqlQuery("sel_CIBILdetails_corpBorr^"+strApplicationNo);
						}
						else
						{
							strQuery=SQLParser.getSqlQuery("sel_CIBILdetails^"+strApplicationNo);
						}
					}
					
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						cibildata=true;
						
						if(hidPageId.equals("BureauReport"))
						{
							strAppId=Helper.correctNull((String)rs.getString("PERAPP_ID"));
						}
					} 
					
					if(cibildata==true)
					{
						if(strBureauAction.equalsIgnoreCase("CIBIL"))
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_cibilScore_CIBIL");
							arrValues.add("Y");
							arrValues.add(strScore);
							arrValues.add(strAppId);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
						else
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_cibilScore_CRIF");
							arrValues.add("Y");
							arrValues.add(strScore);
							arrValues.add(strAppId);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
					}
					else
					{
						if(strBureauAction.equalsIgnoreCase("CIBIL"))
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_cibilScore_CIBIL");
							arrValues.add("Y");
							arrValues.add(strScore);
							arrValues.add(strAppId);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
						else
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_cibilScore_CRIF");
							arrValues.add("Y");
							arrValues.add(strScore);
							arrValues.add(strAppId);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
					}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");					
					
				}
			}else if(strAction.equalsIgnoreCase("ReGenReport"))
			{
				 
			}
			hshResult = (HashMap)EJBInvoker.executeStateLess("perapplicant", hshValues, "getCIBILReport");
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data  invokeProcedureCIBIL" + e.getMessage());
		}
		return hshResult;
	}
	
	public HashMap getCIBILView(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshResult=new HashMap();		
		String strRefNo="",strQuery="",strFileName="";		
		String strMimeType="";		
		int size = 0;
		try
		{		
			strRefNo = Helper.correctNull((String)hshValues.get("varrefno"));
			Blob btemp = null;
			byte[] byteImgData = null;
			if(strRefNo.length()>0)
			{			
				strQuery=SQLParser.getSqlQuery("select_hw_cibil_blobdata^"+strRefNo);
				rs =DBUtils.executeQuery(strQuery);
			}			
			if(rs != null)
			{
				if(rs.next())
				{						
					btemp = (rs.getBlob("hwc_cibildata"));
					size = Integer.parseInt(Helper.correctInt(rs.getString("hwc_bloblength")));
					InputStream is = btemp.getBinaryStream();				
					byteImgData = new byte[size];
					int i = is.read(byteImgData);																			
				}
				strMimeType = "text/html";	
				strFileName = strRefNo+".html";		
			}
			
			hshResult.put("retdoc_file",byteImgData);
			if(byteImgData!=null)
			{		
				hshResult.put("photoimg", byteImgData);
				hshResult.put("FILE_STREAM_NAME", strFileName );
				hshResult.put("FILE_STREAM_TYPE", strMimeType);
				hshResult.put("FILE_STREAM", byteImgData);
				hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");						
			}
	    }
		catch(Exception e)
		{
			log.error(e.getMessage());
			throw new EJBException("Error in getCIBILView " + e.getMessage());
		}
		finally
		{			
			try{
				   if(rs != null)
				   rs.close();
			   } 
		   catch (SQLException e) {e.printStackTrace();}										
		}
		return hshResult;
	}
	
	
	public HashMap cibilReportScore(HashMap hshValues)  
	{
		HashMap hshResult = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshAuditVal = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "", strAppId = "", strAppSno="",strBureauAction="";
		ResultSet rs = null;
		String strQuery="",strScore="",strBureau="";
		String strUserID = Helper.correctNull((String) hshValues.get("strUserId"));
		List arrParameterValues = null;
		try 
		{
			strApplicationNo = correctNull((String) hshValues.get("appno"));			
			strAppId = correctNull((String) hshValues.get("hidAppIdVal"));
			if(strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo=Helper.correctNull((String) hshValues.get("hidBRappno"));
			}
			 
			strQuery="";
			rs=null;
			arrParameterValues = new ArrayList();
			arrParameterValues.add(strApplicationNo);
			arrParameterValues.add(strAppId);
			rs=DBUtils.executeQueryCibil("sel_HM_LOS_INQUIRY_score",arrParameterValues);
			if(rs.next())
			{
				strScore = Helper.correctNull((String) rs.getString("SCORE"));
				strBureau = Helper.correctNull((String) rs.getString("BUREAU"));
				strBureauAction = Helper.correctNull(rs.getString("action"));
			}
			 
			if(rs!=null) rs.close();
			hshResult.put("strScore", strScore);
			hshResult.put("strBureau", strBureau);
			hshResult.put("strBureauAction", strBureauAction);
					
		}
		catch (Exception e) {
			throw new EJBException("Error in Insert Data  cibilReportScore " + e.getMessage());
		}
		return hshResult;
	}
	
	public HashMap cibilReportCheckProcCall(HashMap hshValues)  
	{
		HashMap hshResult = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshAuditVal = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strApplicationNo = "", strAppId = "", strAppSno="",strCIBILAction="";
		Connection connectionORC = null;
		CallableStatement callableStmt2 = null;
		FileWriter fout = null;
		ResultSet rs = null;
		String strQuery="",strScore="",strBureau="",strReqStatus="",strOverAllStatus="",strReqID="",strResultFlag="";
		String strUserID = Helper.correctNull((String) hshValues.get("strUserId"));
		List arrParameterValues = null;
		boolean flag = false;
		try 
		{
			strApplicationNo = correctNull((String) hshValues.get("appno"));			
			strAppId = correctNull((String) hshValues.get("hidAppIdVal"));
			
			String hidPageId=Helper.correctNull((String) hshValues.get("hidPageId"));
			if(hidPageId.equals("BureauReport"))
			{
				strApplicationNo=Helper.correctNull((String) hshValues.get("hidBRappno"));
			}
			
			strQuery=SQLParser.getSqlQuery("check_proc_call^"+strApplicationNo+"^"+strAppId);
			rs=DBUtils.executeQueryCIBIL(strQuery);
			if (rs.next())
			{
				flag = true;
				strReqStatus = correctNull(rs.getString("REQUEST_STATUS"));
				strOverAllStatus = correctNull(rs.getString("HM_STATUS"));
				strReqID = correctNull(rs.getString("REQUEST_ID"));
				strCIBILAction = correctNull(rs.getString("action"));
				strResultFlag ="Y";
			}
			
			if(rs!=null) rs.close();
			hshResult.put("strReqStatus", strReqStatus);
			hshResult.put("strOverAllStatus", strOverAllStatus);
			hshResult.put("strReqID", strReqID);
			hshResult.put("strResultFlag", strResultFlag);
			hshResult.put("strCIBILAction", strCIBILAction);
					
		}
		catch (Exception e) {
			throw new EJBException("Error in cibilReportCheckProcCall" + e.getMessage());
		}
		return hshResult;
	}
 
	public HashMap getCIBILReportView(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshResult=new HashMap();		
		String strRefNo="",strQuery="",strFileName="";		
		String strMimeType="";		
		int size = 0;
		try
		{		
			strRefNo = Helper.correctNull((String)hshValues.get("varrefno"));
			Blob btemp = null;
			byte[] byteImgData = null;
			if(strRefNo.length()>0)
			{			
				strQuery=SQLParser.getSqlQuery("select_hw_cibil_blobdata^"+strRefNo);
				rs =DBUtils.executeQuery(strQuery);
			}			
			if(rs != null)
			{
				if(rs.next())
				{						
					btemp = (rs.getBlob("hwc_cibildata"));
					size = Integer.parseInt(Helper.correctInt(rs.getString("hwc_bloblength")));
					InputStream is = btemp.getBinaryStream();				
					byteImgData = new byte[size];
					int i = is.read(byteImgData);																			
				}
				strMimeType = "text/html";	
				strFileName = strRefNo+".html";		
			}
			
			hshResult.put("retdoc_file",byteImgData);
			if(byteImgData!=null)
			{		
				hshResult.put("photoimg", byteImgData);
				hshResult.put("FILE_STREAM_NAME", strFileName );
				hshResult.put("FILE_STREAM_TYPE", strMimeType);
				hshResult.put("FILE_STREAM", byteImgData);
				hshResult.put("FILE_STREAM_DISPOSITION_TYPE","inline");						
			}
	    }
		catch(Exception e)
		{
			log.error(e.getMessage());
			throw new EJBException("Error in getCIBILReportView " + e.getMessage());
		}
		finally
		{			
			try{
				   if(rs != null)
				   rs.close();
			   } 
		   catch (SQLException e) {e.printStackTrace();}										
		}
		return hshResult;
	}
	
	
	
	
}
