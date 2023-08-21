package com.sai.laps.ejb.npacommon;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.tagdatahelper.TagDataHelper1;

@Stateless(name = "NPACommonBean", mappedName = "NPACommonHome")
@Remote (NPACommonRemote.class)
public class NPACommonBean extends BeanAdapter
{
	private static final long serialVersionUID = 1L;
	
	public 	HashMap getGeneralHistoryData(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery ="";
		String strAppno="";
		try
		{
			strAppno = correctNull((String) hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String) hshValues.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_npagenhistory^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("irregularreasons",correctNull(rs.getString("npagen_irregularreasons")));
				hshResult.put("recoverduesteps",correctNull(rs.getString("npagen_recoverduesteps")));
				hshResult.put("legalaction",correctNull(rs.getString("npagen_legalaction")));
				hshResult.put("sarfaesiaaction",correctNull(rs.getString("npagen_sarfaesiaaction")));
				hshResult.put("bifraction",correctNull(rs.getString("npagen_bifraction")));
				hshResult.put("briefhistory",Helper.CLOBToString(rs.getClob("npagen_briefhistory")));
				hshResult.put("staffaccountability",correctNull(rs.getString("npagen_staffaccountability")));
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getGeneralHistoryData :: " + e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getGeneralHistoryData :: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void  updateGeneralHistoryData(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAppno="";
		String strAction =correctNull((String)hshValues.get("hidAction"));
		try
		{
			strAppno = correctNull((String) hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String) hshValues.get("npa_appno"));
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_npagenhistory");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_npagenhistory");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_briefhistory")));
				arrValues.add(correctNull((String)hshValues.get("txt_irregularreasons")));
				arrValues.add(correctNull((String)hshValues.get("txt_recoverduesteps")));
				arrValues.add(correctNull((String)hshValues.get("txt_legalaction")));
				arrValues.add(correctNull((String)hshValues.get("txt_sarfaesiaaction")));
				arrValues.add(correctNull((String)hshValues.get("txt_bifraction")));
				arrValues.add(correctNull((String)hshValues.get("txt_staffaccountability")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_npagenhistory");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateGeneralHistoryData ::  " + e.getMessage());
		} 
	}
	
	public void updatePresentPosition(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="",strmodule_type="";
		strAppno=correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=correctNull((String)hshValues.get("npa_appno"));
		}
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		String str_nature=Helper.correctNull((String)hshValues.get("txt_facility_hid"));
		String str_amount=Helper.correctNull((String)hshValues.get("txt_amount_limit"));
		String str_running_outstand=Helper.correctNull((String)hshValues.get("txt_running_outstand"));
		String str_prodential=Helper.correctNull((String)hshValues.get("txt_prodential_writeoff"));
		String str_ecgc_claim=Helper.correctNull((String)hshValues.get("txt_ecgc_claim"));
		String str_subtotal=Helper.correctNull((String)hshValues.get("txt_subtotal"));
		String str_unrecover=Helper.correctNull((String)hshValues.get("txt_unrecover"));
		String str_netdues=Helper.correctNull((String)hshValues.get("txt_net_dues"));
		String str_dummyfromdate=Helper.correctNull((String)hshValues.get("txt_dummy_fromdate"));
		String str_dummytodate=Helper.correctNull((String)hshValues.get("txt_dummy_todate"));
		String str_dummay_ledger=Helper.correctNull((String)hshValues.get("txt_dummy_ledger"));
		String str_legal_expenses=Helper.correctNull((String)hshValues.get("txt_legal_expenses"));
		String str_total_dues=Helper.correctNull((String)hshValues.get("txt_total_dues"));
		String strOSECGC=Helper.correctNull((String)hshValues.get("txt_ecgc_os"));
		String strCliamadmitted=Helper.correctNull((String)hshValues.get("txt_ecgc_claimadmitted"));
		String strCoverpercent=Helper.correctNull((String)hshValues.get("txt_ecgc_coverpercent"));
		String strClaimsettled=Helper.correctNull((String)hshValues.get("txt_ecgc_claimsettled"));
		String strNotional=Helper.correctNull((String)hshValues.get("txt_notional"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		
		try
		{
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("getpresentposdet^"+strAppno+"^"+strsno+"^"+strmodule_type);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("OTSCO") || strmodule_type.equalsIgnoreCase("PAWO") || strmodule_type.equalsIgnoreCase("SUIT")){
						sbAuditDataOld.append("NATURE OF LIMIT =" +correctNull(rs.getString("facility")))
						.append("~ AMOUNT OF LIMIT =" +Helper.formatDoubleValue(rs.getDouble("PRE_AMOUNT")))
						.append("~ RUNNING LEDGER OUTSTANDING =" +Helper.formatDoubleValue(rs.getDouble("PRE_RUNNING_OUTSTAND")));
					if(!strmodule_type.equalsIgnoreCase("PAWO") || !strmodule_type.equalsIgnoreCase("SUIT")){
						sbAuditDataOld.append("~ AMOUNT PRUDENTIALLY WRITTEN OFF =" +Helper.formatDoubleValue(rs.getDouble("PRE_PRODENTIAL")));
					}
					if(!strmodule_type.equalsIgnoreCase("SUIT")){
						sbAuditDataOld.append("~ ECGC/DICGC/CGFT CLAIM =" +Helper.formatDoubleValue(rs.getDouble("PRE_ECGC_CLAIM")))
						.append("~ SUB-TOTAL =" +Helper.formatDoubleValue(rs.getDouble("PRE_SUBTOTAL")));
					}
					sbAuditDataOld
					.append("~ UNRECOVERED INT =" +Helper.formatDoubleValue(rs.getDouble("PRE_UNRECOVER")))
					.append("~ NET DUES =" +Helper.formatDoubleValue(rs.getDouble("PRE_NETDUES")))
					.append("~ DUMMY LEDGER INTEREST FROM =" +correctNull(rs.getString("PRE_DUMMY_FROMDATE")))
					.append("~ DUMMY LEDGER INTEREST TO =" +correctNull(rs.getString("PRE_DUMMY_TODATE")))
					.append("~ DUMMY LEDGER INTEREST AMOUNT =" +Helper.formatDoubleValue(rs.getDouble("PRE_DUMMY_LEDGER")))
					.append("~ LEGAL / OTHER EXPENSES =" +Helper.formatDoubleValue(rs.getDouble("PRE_EXPENSES")))
					.append("~ TOTAL DUES =" +Helper.formatDoubleValue(rs.getDouble("PRE_TOTAL_DUES")));
					}
					if(strmodule_type.equalsIgnoreCase("OTSCO")){
						sbAuditDataOld
						.append("~ NOTIONAL INTEREST =" +Helper.formatDoubleValue(rs.getDouble("pre_notionalinterest")))
						.append("~ % OF COVER AVAILABLE =" +Helper.formatDoubleValue(rs.getDouble("pre_coverpercentavail")))
						.append("~ CLAIM ADMITTED =" +Helper.formatDoubleValue(rs.getDouble("pre_claimadmitted")))
						.append("~ CLAIM SETTLED =" +Helper.formatDoubleValue(rs.getDouble("pre_claimsettled")))
						.append("~ O/S. CLAIM IS LODGED WITH ECGC =" +Helper.formatDoubleValue(rs.getDouble("pre_claimlodgedos")));
					}
					else if(strmodule_type.equalsIgnoreCase("SARFI")){
						sbAuditDataOld
						.append("NATURE OF LIMIT =" +correctNull(rs.getString("facility")))
						.append("~ AMOUNT OF LIMIT =" +Helper.formatDoubleValue(rs.getDouble("PRE_AMOUNT")))
						.append("~ RUNNING LEDGER OUTSTANDING =" +Helper.formatDoubleValue(rs.getDouble("PRE_RUNNING_OUTSTAND")))
						.append("~ DUMMY LEDGER INTEREST AMOUNT =" +Helper.formatDoubleValue(rs.getDouble("PRE_DUMMY_LEDGER")))
						.append("~ TOTAL DUES =" +Helper.formatDoubleValue(rs.getDouble("PRE_TOTAL_DUES")));
					}
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxpresentposition^"+strAppno+"^"+strmodule_type;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("present_sno"));
				}
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","inspresentposition");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_nature);
				arrValues.add(str_amount);
				arrValues.add(str_running_outstand);
				arrValues.add(str_prodential);
				arrValues.add(str_ecgc_claim);
				arrValues.add(str_subtotal);
				arrValues.add(str_unrecover);
				arrValues.add(str_netdues);
				arrValues.add(str_dummyfromdate);
				arrValues.add(str_dummytodate);
				arrValues.add(str_dummay_ledger);
				arrValues.add(str_legal_expenses);
				arrValues.add(str_total_dues);
				arrValues.add(strmodule_type);
				arrValues.add(strOSECGC);
				arrValues.add(strCoverpercent);
				arrValues.add(strCliamadmitted);
				arrValues.add(strClaimsettled);
				arrValues.add(strNotional);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(!str_dummyfromdate.equals(""))
				{
					setDummydates(hshValues);
				}
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updpresentposition");
				
				arrValues.add(str_nature);
				arrValues.add(str_amount);
				arrValues.add(str_running_outstand);
				arrValues.add(str_prodential);
				arrValues.add(str_ecgc_claim);
				arrValues.add(str_subtotal);
				arrValues.add(str_unrecover);
				arrValues.add(str_netdues);
				arrValues.add(str_dummyfromdate);
				arrValues.add(str_dummytodate);
				arrValues.add(str_dummay_ledger);
				arrValues.add(str_legal_expenses);
				arrValues.add(str_total_dues);
				arrValues.add(strOSECGC);
				arrValues.add(strCoverpercent);
				arrValues.add(strCliamadmitted);
				arrValues.add(strClaimsettled);
				arrValues.add(strNotional);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(!str_dummyfromdate.equals(""))
				{
					setDummydates(hshValues);
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(str_nature);
				arrValues.add(str_amount);
				arrValues.add(str_running_outstand);
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				hshQuery.put("strQueryId","delpresentposition");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strCode = "";
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("OTSCO") || strmodule_type.equalsIgnoreCase("PAWO") || strmodule_type.equalsIgnoreCase("SUIT")){
				sbAuditData
				.append("NATURE OF LIMIT =" +correctNull((String)hshValues.get("txt_nature_limit")))
				.append("~ AMOUNT OF LIMIT =" +correctNull((String)hshValues.get("txt_amount_limit")))
				.append("~ RUNNING LEDGER OUTSTANDING =" +correctNull((String)hshValues.get("txt_running_outstand")));
				if(!strmodule_type.equalsIgnoreCase("PAWO") || !strmodule_type.equalsIgnoreCase("SUIT")){
					sbAuditData
					.append("~ AMOUNT PRUDENTIALLY WRITTEN OFF =" +correctNull((String)hshValues.get("txt_prodential_writeoff")));
				}
				if(!strmodule_type.equalsIgnoreCase("SUIT")){
				sbAuditData
				.append("~ ECGC/DICGC/CGFT CLAIM =" +correctNull((String)hshValues.get("txt_ecgc_claim")))
				.append("~ SUB-TOTAL =" +correctNull((String)hshValues.get("txt_subtotal")));
				}
				sbAuditData
				.append("~ UNRECOVERED INT =" +correctNull((String)hshValues.get("txt_unrecover")))
				.append("~ NET DUES =" +correctNull((String)hshValues.get("txt_net_dues")))
				.append("~ DUMMY LEDGER INTEREST FROM =" +correctNull((String)hshValues.get("txt_dummy_fromdate")))
				.append("~ DUMMY LEDGER INTEREST TO =" +correctNull((String)hshValues.get("txt_dummy_todate")))
				.append("~ DUMMY LEDGER INTEREST AMOUNT =" +correctNull((String)hshValues.get("txt_dummy_ledger")))
				.append("~ LEGAL / OTHER EXPENSES =" +correctNull((String)hshValues.get("txt_legal_expenses")))
				.append("~ TOTAL DUES =" +correctNull((String)hshValues.get("txt_total_dues")));
				}
				if(strmodule_type.equalsIgnoreCase("OTSCO")){
					sbAuditDataOld
					.append("~ NOTIONAL INTEREST =" +correctNull((String)hshValues.get("txt_notional")))
					.append("~ % OF COVER AVAILABLE =" +correctNull((String)hshValues.get("txt_ecgc_coverpercent")))
					.append("~ CLAIM ADMITTED =" +correctNull((String)hshValues.get("txt_ecgc_claimadmitted")))
					.append("~ CLAIM SETTLED =" +correctNull((String)hshValues.get("txt_ecgc_claimsettled")))
					.append("~ O/S. CLAIM IS LODGED WITH ECGC =" +correctNull((String)hshValues.get("txt_ecgc_os")));
				}
				else if(strmodule_type.equalsIgnoreCase("SARFI")){
					sbAuditData
					.append("NATURE OF LIMIT =" +correctNull((String)hshValues.get("txt_facility_hid")))
					.append("~ AMOUNT OF LIMIT =" +correctNull((String)hshValues.get("txt_amount_limit")))
					.append("~ RUNNING LEDGER OUTSTANDING =" +correctNull((String)hshValues.get("txt_running_outstand")))
					.append("~ DUMMY LEDGER INTEREST AMOUNT =" +correctNull((String)hshValues.get("txt_dummy_ledger")))
					.append("~ TOTAL DUES =" +correctNull((String)hshValues.get("txt_total_dues")));
				}
			}
			
			if(strmodule_type.equalsIgnoreCase("STAT")){
				strCode = "368";
			}else if(strmodule_type.equalsIgnoreCase("OTSCO")){
				strCode = "376";
			}else if(strmodule_type.equalsIgnoreCase("SARFI")){
				strCode = "382";
			}else if(strmodule_type.equalsIgnoreCase("PAWO")){
				strCode = "390";
			}else if(strmodule_type.equalsIgnoreCase("SUIT")){
				strCode = "396";
			}
			AuditTrial.auditNewLog(hshValues, strCode, strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updatePresentPosition"+e.getMessage());
		}finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				} 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in updatePresentPosition"+cf.getMessage());						
			}
		}
	}
	
	private void setDummydates(HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strmodule_type="";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("npa_appno"));
			}
			strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
			String str_dummyfromdate=Helper.correctNull((String)hshValues.get("txt_dummy_fromdate"));
			String str_dummytodate=Helper.correctNull((String)hshValues.get("txt_dummy_todate"));
			
			if(!str_dummyfromdate.equals(""))
			{
				hshQueryValues=new  HashMap();
				hshQuery  =new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				arrValues.add(str_dummyfromdate);
				arrValues.add(str_dummytodate);
				arrValues.add(strAppno);
				arrValues.add(strmodule_type);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upddummydate");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in setDummydates:"+e.getMessage());
		}
	}
	
	public HashMap getPresentPosition(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno="";
		String strmoduletype="";
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
		}
		try
		{
			strmoduletype=Helper.correctNull((String)hshValues.get("hidmoduletype"));
			strQuery=SQLParser.getSqlQuery("selpresentposition^"+strAppno+"^"+strmoduletype);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("PRE_SNO")));
				vecCol.add(correctNull((String)rs.getString("facility")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_AMOUNT")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_RUNNING_OUTSTAND")));
				vecCol.add(correctNull((String)rs.getString("PRE_PRODENTIAL")));
				vecCol.add(correctNull((String)rs.getString("PRE_ECGC_CLAIM")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_SUBTOTAL")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_UNRECOVER")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_NETDUES")));
				vecCol.add(correctNull((String)rs.getString("PRE_DUMMY_FROMDATE")));
				hshRecord.put("intfrom",correctNull((String)rs.getString("PRE_DUMMY_FROMDATE")));
				hshRecord.put("intto",correctNull((String)rs.getString("PRE_DUMMY_TODATE")));
				vecCol.add(correctNull((String)rs.getString("PRE_DUMMY_TODATE")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_DUMMY_LEDGER")));
				vecCol.add(Helper.formatDoubleValue(rs.getDouble("PRE_EXPENSES")));
				vecCol.add(correctNull((String)rs.getString("PRE_TOTAL_DUES")));
				vecCol.add(correctNull((String)rs.getString("NPA_MODULE_TYPE")));
				vecCol.add(correctNull((String)rs.getString("pre_claimlodgedos")));
				vecCol.add(correctNull((String)rs.getString("pre_coverpercentavail")));
				vecCol.add(correctNull((String)rs.getString("pre_claimadmitted")));
				vecCol.add(correctNull((String)rs.getString("pre_claimsettled")));
				vecCol.add(correctNull((String)rs.getString("pre_notionalinterest")));
				vecCol.add(correctNull((String)rs.getString("PRE_NATURE")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			if(strmoduletype.equalsIgnoreCase("OTSCO") || strmoduletype.equalsIgnoreCase("PAWO"))
			{
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sel_npageneralinfo^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("ecgc",correctNull(rs.getString("npagen_ecgcclaim")));
					hshRecord.put("pwo",correctNull(rs.getString("npagen_pwo")));
				}
			}
			if(strmoduletype.equalsIgnoreCase("OTSCO"))
			{	
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("getnpainterest^002");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("notionalintrate",correctNull(rs.getString("npa_intrate")));
				}
			}
		}
		catch(Exception exp)
		{
			throw new EJBException(exp.getMessage());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateSecurities(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="",strmodule_type="";
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		String str_security=Helper.correctNull((String)hshValues.get("sel_security"));
		String str_nature=Helper.correctNull((String)hshValues.get("txt_nature"));
		String str_renew_valuedate=Helper.correctNull((String)hshValues.get("txt_renew_valuedate"));
		String str_renew_valueamount=Helper.correctNull((String)hshValues.get("txt_renew_valueamount"));
		String str_present_valuedate=Helper.correctNull((String)hshValues.get("txt_present_valuedate"));
		String str_present_valueamount=Helper.correctNull((String)hshValues.get("txt_present_valueamount"));
		String str_present_inspecdate=Helper.correctNull((String)hshValues.get("txt_present_inspecdate"));
		String str_present_inspecby=Helper.correctNull((String)hshValues.get("txt_present_inspecby"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				strQuery = SQLParser.getSqlQuery("getsecuritiesdet^"+strAppno+"^"+strsno+"^"+strmodule_type);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					sbAuditDataOld
					.append("TYPE OF SECURITY =" +ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull(rs.getString("secu_securities_type"))));
					if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("PAWO")){
						sbAuditDataOld.append("~ NATURE =" +correctNull(rs.getString("secu_nature")));
					}
					sbAuditDataOld
					.append("~ RENEWAL VALUATION DATE =" +correctNull(rs.getString("secu_renew_valuedate")))
					.append("~ RENEWAL VALUATION AMOUNT =" +Helper.formatDoubleValue(rs.getDouble("secu_renew_valueamount")))
					.append("~ PRESENT VALUATION DATE =" +correctNull(rs.getString("secu_present_valuedate")))
					.append("~ PRESENT VALUATION AMOUNT =" +Helper.formatDoubleValue(rs.getDouble("secu_present_valueamount")))
					.append("~ INSPECTION DATE =" +correctNull(rs.getString("secu_present_inspecdate")))
					.append("~ INSPECTED BY =" +correctNull(rs.getString("secu_present_inspectedby")));
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxnpasecurities^"+strAppno+"^"+strmodule_type;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("SECU_SNO"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_npasecurities");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_security);
				arrValues.add(str_nature);
				arrValues.add(str_renew_valuedate);
				arrValues.add(str_renew_valueamount);
				arrValues.add(str_present_valuedate);
				arrValues.add(str_present_valueamount);
				arrValues.add(str_present_inspecdate);
				arrValues.add(str_present_inspecby);
				arrValues.add(strmodule_type);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_npasecurities");
				
				arrValues.add(str_security);
				arrValues.add(str_nature);
				arrValues.add(str_renew_valuedate);
				arrValues.add(str_renew_valueamount);
				arrValues.add(str_present_valuedate);
				arrValues.add(str_present_valueamount);
				arrValues.add(str_present_inspecdate);
				arrValues.add(str_present_inspecby);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				hshQuery.put("strQueryId","del_npasecurities");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strCode = "";
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("TYPE OF SECURITY =" +ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull((String)hshValues.get("sel_security"))));
				if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("PAWO")){
				sbAuditData.append("~ NATURE =" +correctNull((String)hshValues.get("txt_nature")));
				}
				sbAuditData
				.append("~ RENEWAL VALUATION DATE =" +correctNull((String)hshValues.get("txt_renew_valuedate")))
				.append("~ RENEWAL VALUATION AMOUNT =" +correctNull((String)hshValues.get("txt_renew_valueamount")))
				.append("~ PRESENT VALUATION DATE =" +correctNull((String)hshValues.get("txt_present_valuedate")))
				.append("~ PRESENT VALUATION AMOUNT =" +correctNull((String)hshValues.get("txt_present_valueamount")))
				.append("~ INSPECTION DATE =" +correctNull((String)hshValues.get("txt_present_inspecdate")))
				.append("~ INSPECTED BY =" +correctNull((String)hshValues.get("txt_present_inspecby")));
			  }
			if(strmodule_type.equalsIgnoreCase("STAT")){
				strCode = "369";
			}else if(strmodule_type.equalsIgnoreCase("OTSCO")){
				strCode = "377";
			}else if(strmodule_type.equalsIgnoreCase("SARFI")){
				strCode = "383";
			}else if(strmodule_type.equalsIgnoreCase("PAWO")){
				strCode = "391";
			}
			AuditTrial.auditNewLog(hshValues, strCode, strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updateSecurities"+e.getMessage());
		}finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				} 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in updateSecurities"+cf.getMessage());						
			}
		}
	}
	
	public HashMap getSecurities(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno="",strmodule_type="";
		
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
			strQuery=SQLParser.getSqlQuery("sel_npasecurities^"+strAppno+"^"+strmodule_type);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("SECU_SNO")));
				vecCol.add(correctNull((String)rs.getString("SECU_SECURITIES_TYPE")));
				vecCol.add(correctNull((String)rs.getString("SECU_NATURE")));
				vecCol.add(correctNull((String)rs.getString("SECU_RENEW_VALUEDATE")));
				vecCol.add(correctNull((String)rs.getString("SECU_RENEW_VALUEAMOUNT")));
				vecCol.add(correctNull((String)rs.getString("SECU_PRESENT_VALUEDATE")));
				vecCol.add(correctNull((String)rs.getString("SECU_PRESENT_VALUEAMOUNT")));
				vecCol.add(correctNull((String)rs.getString("SECU_PRESENT_INSPECDATE")));
				vecCol.add(correctNull((String)rs.getString("SECU_PRESENT_INSPECTEDBY")));
				vecCol.add(correctNull((String)rs.getString("NPA_MODULE_TYPE")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateBorrwerDetails(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="",strmodule_type="";
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		String str_type_applicant=Helper.correctNull((String)hshValues.get("sel_type_applicant"));
		String str_name_applicant=Helper.correctNull((String)hshValues.get("txt_name_applicant"));
		String str_present_activity=Helper.correctNull((String)hshValues.get("txt_present_activity"));
		String str_renew_means=Helper.correctNull((String)hshValues.get("txt_renew_means"));
		String str_renew_date=Helper.correctNull((String)hshValues.get("txt_renew_date"));
		String str_present_means=Helper.correctNull((String)hshValues.get("txt_present_means"));
		String str_present_date=Helper.correctNull((String)hshValues.get("txt_present_date"));
		String str_address=Helper.correctNull((String)hshValues.get("txt_address"));
		String str_phone=Helper.correctNull((String)hshValues.get("txt_phone"));
		StringBuilder sbAuditDataOld = new StringBuilder();
		try
		{
			
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery = SQLParser.getSqlQuery("getborrowerdet^"+strAppno+"^"+strsno+"^"+strmodule_type);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
				sbAuditDataOld
				.append("TYPE OF APPLICANT =" +correctNull(rs.getString("facility")))
				.append("~ NAME OF APPLICANT =" +correctNull(rs.getString("APP_NAME_NPA")));
				if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("SARFI") || strmodule_type.equalsIgnoreCase("SUIT")){
					sbAuditDataOld.append("~ PHONE =" +correctNull(rs.getString("APP_PHONE")));
				}
				sbAuditDataOld
				.append("~ RENEWAL MEANS =" +Helper.formatDoubleValue(rs.getDouble("RENEW_MEANS_NPA")))
				.append("~ RENEWAL DATE =" +correctNull(rs.getString("RENEW_DATE_NPA")))
				.append("~ PRESENT MEANS =" +Helper.formatDoubleValue(rs.getDouble("PRESENT_MEANS_NPA")))
				.append("~ PRESENT DATE =" +correctNull(rs.getString("PRESENT_DATE_NPA")));
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxnpaborrwerdetails^"+strAppno+"^"+strmodule_type;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("APPSNO_NPA"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_npaborrwerdetails");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_type_applicant);
				arrValues.add(str_name_applicant);
				arrValues.add(str_present_activity);
				arrValues.add(str_renew_means);
				arrValues.add(str_renew_date);
				arrValues.add(str_present_means);
				arrValues.add(str_present_date);
				arrValues.add(str_address);
				arrValues.add(str_phone);
				arrValues.add(strmodule_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_npaborrwerdetails");
				arrValues.add(str_type_applicant);
				arrValues.add(str_name_applicant);
				arrValues.add(str_present_activity);
				arrValues.add(str_renew_means);
				arrValues.add(str_renew_date);
				arrValues.add(str_present_means);
				arrValues.add(str_present_date);
				arrValues.add(str_address);
				arrValues.add(str_phone);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(strmodule_type);
				hshQuery.put("strQueryId","del_npaborrwerdetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strCode = "";
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				sbAuditData
				.append("TYPE OF APPLICANT =" +correctNull((String)hshValues.get("hidAppType")))
				.append("~ NAME OF APPLICANT =" +correctNull((String)hshValues.get("txt_name_applicant")));
				if(strmodule_type.equalsIgnoreCase("STAT") || strmodule_type.equalsIgnoreCase("SARFI") || strmodule_type.equalsIgnoreCase("SUIT")){
					sbAuditData.append("~ PHONE =" +correctNull((String)hshValues.get("txt_phone")));
				}
				sbAuditData
				.append("~ RENEWAL MEANS =" +correctNull((String)hshValues.get("txt_renew_means")))
				.append("~ RENEWAL DATE =" +correctNull((String)hshValues.get("txt_renew_date")))
				.append("~ PRESENT MEANS =" +correctNull((String)hshValues.get("txt_present_means")))
				.append("~ PRESENT DATE =" +correctNull((String)hshValues.get("txt_present_date")));
			}
			if(strmodule_type.equalsIgnoreCase("STAT")){
				strCode = "370";
			}else if(strmodule_type.equalsIgnoreCase("OTSCO")){
				strCode = "378";
			}else if(strmodule_type.equalsIgnoreCase("SARFI")){
				strCode = "384";
			}else if(strmodule_type.equalsIgnoreCase("PAWO")){
				strCode = "392";
			}else if(strmodule_type.equalsIgnoreCase("PAWO")){
				strCode = "398";
			}
			AuditTrial.auditNewLog(hshValues, strCode, strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		}catch(Exception e)
		{
			throw new EJBException("Error in updateBorrwerDetails"+e.getMessage());
		}finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				} 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in updateBorrwerDetails"+cf.getMessage());						
			}
		}
	}
	
	public HashMap getBorrowerDetails(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strAppno="";
		String strmodule_type="";
		strmodule_type=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
		}
		try
		{
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_npaborrwerdetails^"+strAppno+"^"+strmodule_type);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("APPSNO_NPA")));
			    vecCol.add(correctNull((String)rs.getString("APP_TYPE_NPA")));
				vecCol.add(correctNull((String)rs.getString("APP_NAME_NPA")));
				vecCol.add(correctNull((String)rs.getString("PRESENTACTIVITY_NPA")));
				vecCol.add(correctNull((String)rs.getString("RENEW_MEANS_NPA")));
				vecCol.add(correctNull((String)rs.getString("RENEW_DATE_NPA")));
				vecCol.add(correctNull((String)rs.getString("PRESENT_MEANS_NPA")));
				vecCol.add(correctNull((String)rs.getString("PRESENT_DATE_NPA")));
				vecCol.add(correctNull((String)rs.getString("NPA_MODULE_TYPE")));
				vecCol.add(correctNull((String)rs.getString("APP_ADDRESS")));
				vecCol.add(correctNull((String)rs.getString("APP_PHONE")));
				vecCol.add(correctNull((String)rs.getString("STAT_DATA_DESC1")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
		}
		catch(Exception e1)
		{
			throw new EJBException(e1.getMessage());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updateAuditorsObservation(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAppno="" , strAudittype="";
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		strAudittype=correctNull((String)hshValues.get("sel_audittype"));
		String npatype=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_npaauditcomments");
				arrValues.add(strAppno);
				arrValues.add(strAudittype);
				arrValues.add(npatype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_npaauditcomments");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("sel_audittype")));
				arrValues.add(correctNull((String)hshValues.get("txt_auditor")));
				arrValues.add(correctNull((String)hshValues.get("txt_officer")));
				arrValues.add(correctNull((String)hshValues.get("txt_auditdate")));
				arrValues.add(npatype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_npaauditcomments");
				arrValues.add(strAppno);
				arrValues.add(strAudittype);
				arrValues.add(npatype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}catch (Exception e)
		{
			throw new EJBException("Error in Insert Data " + e.getMessage());
		} 
	}
	
	public HashMap getAuditorsObservation(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs = null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		String strAppno="", strAudittype="", strQuery="";
		String selPrint=Helper.correctNull((String)hshValues.get("selPrint"));
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			strAudittype=correctNull((String)hshValues.get("sel_audittype"));
			String npatype=Helper.correctNull((String)hshValues.get("hidmoduletype"));
			if(strAudittype.equalsIgnoreCase(""))
			{
				strAudittype="0";
			}
			if(!selPrint.equalsIgnoreCase("Get"))
			{
				strQuery=SQLParser.getSqlQuery("sel_npaauditcomments^"+strAppno+"^"+strAudittype+"^"+npatype);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("auditorscomments",correctNull((String)rs.getString("npa_auditorcomment")));
					hshResult.put("officercomments",correctNull((String)rs.getString("npa_officerscomment")));
					hshResult.put("auditdate",correctNull((String)rs.getString("npa_auditdate")));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(selPrint.equalsIgnoreCase("Get"))
			{
				strQuery=SQLParser.getSqlQuery("sel_getnpaauditcomments^"+strAppno+"^"+npatype);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();	
					arrCol.add(Helper.correctNull((String)rs.getString("npa_auditorcomment")));
					arrCol.add(Helper.correctNull((String)rs.getString("npa_officerscomment")));
					arrCol.add(Helper.correctNull((String)rs.getString("npa_auditdate")));
					arrCol.add(Helper.correctNull((String)rs.getString("npa_audittype")));
					arrRow.add(arrCol);
				}
			}
			hshResult.put("arrRow",arrRow);	
			hshResult.put("audittype",strAudittype);
		}catch (Exception exp){
			throw new EJBException("Error in getAuditorsObservation :: "+ exp.getMessage());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in getAuditorsObservation :: "+ exp.toString()); 
			}
		}
		
		return hshResult;
	}

	public HashMap getdelegatedwork(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strUserId ="";
		String strAppno="";
		String strModuletype="";
		String approveflag="";
		strModuletype=Helper.correctNull((String)hshValues.get("hidmoduletype"));
		double dbldelegatedpower=0;
		double dblsanctioningamt=0;
		
		try
		{	
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
			}
			if(!strAppno.equalsIgnoreCase(""))
			{
				strUserId = correctNull((String)hshValues.get("strUserId"));
				
				if(rs != null)
				rs.close();
			
				rs=DBUtils.executeLAPSQuery("chkdelegatepower^"+strUserId);
	
				if(rs.next())
				{
					if(strModuletype.equalsIgnoreCase("OTSCO"))
					{
						dbldelegatedpower=rs.getDouble("NPA_SACRIFICELIMIT");
					}
					else if(strModuletype.equalsIgnoreCase("SARFI"))
					{
						dbldelegatedpower=rs.getDouble("NPA_SARFAESILIMIT");
					}
					else if(strModuletype.equalsIgnoreCase("PAWO"))
					{
						dbldelegatedpower=rs.getDouble("NPA_WRITEOFFLIMIT");
					}
					else if(strModuletype.equalsIgnoreCase("SUIT"))
					{
						dbldelegatedpower=rs.getDouble("NPA_SUITLIMIT");
					}
					else if(strModuletype.equalsIgnoreCase("STAT"))
					{
						dbldelegatedpower=rs.getDouble("NPA_STATUSNOTE");
					}
				}
				if(rs != null)
					rs.close();
				
				if(strModuletype.equalsIgnoreCase("OTSCO"))
				{
					hshRecord=new HashMap();
					hshRecord=(HashMap) EJBInvoker.executeStateLess("npa",hshValues, "getCompromiseReliefSought");
					dblsanctioningamt=Double.parseDouble(Helper.correctDouble((String)hshRecord.get("Notionalsacrificeamt")));
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("selpresentpositiontotal^"+strAppno);
			
					if(rs.next())
					{
						if(strModuletype.equalsIgnoreCase("SARFI") || strModuletype.equalsIgnoreCase("SUIT"))
						{
							dblsanctioningamt=Double.parseDouble(Helper.correctDouble((String)rs.getString("totaldues")));
						}
						else if(strModuletype.equalsIgnoreCase("PAWO"))
						{
							dblsanctioningamt=rs.getDouble("runningos")-rs.getDouble("unrecoveredint")-rs.getDouble("ecgcclaimedamt");
						}
						else if(strModuletype.equalsIgnoreCase("STAT"))
						{
							dblsanctioningamt=Double.parseDouble(Helper.correctDouble((String)rs.getString("runningos")));
						}
					}
				}
				if(dblsanctioningamt>0.00)
				{
					if (dbldelegatedpower>=dblsanctioningamt)
					{
						approveflag ="Y";
					}
					else
					{
						approveflag ="N";
					}
				}
				else
				{
					approveflag ="N";
				}
			}
			else
			{
				hshRecord.put("chkappno","Application Number not Available");
			}
			hshRecord.put("approveflag",approveflag);
		}
		catch(Exception e)
		{
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
			catch(Exception e)
			{
				throw new EJBException(e.toString());
			}
		}
		return hshRecord;
	}

	/*
	 * Created by G.sureshkumar
	 * For loading the datas from the cbs table to the npa application table
	 * 
	 */
//	public void loadcbsnpadata(HashMap hshValues) 
//	{
//		String strModuletype="";
//		String strCBSid="";
//		String strAppno="";
//			
//		int intUpdatesize=0;
//		
//		ArrayList arrValues = null;
//		
//		HashMap hshQuery = null;
//		HashMap hshQueryValues=null;
//		
//		strAppno=Helper.correctNull((String)hshValues.get("strAppno"));
//		strCBSid=Helper.correctNull((String)hshValues.get("cbsid"));
//		strModuletype=Helper.correctNull((String)hshValues.get("npatype"));
//		
//		try
//		{
//			if(!strCBSid.equalsIgnoreCase("") && !strModuletype.equalsIgnoreCase("")) 
//			{
//				hshQueryValues = new HashMap();
//				/*
//				 * For inserting the datas into present position table
//				 */
				
//				if(strModuletype.equalsIgnoreCase("SARFI"))
//				{
					
					
					/*hshQuery = new HashMap();	
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inssarfgeneral_cbsnpa");
					intUpdatesize++;
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("solid")));
					arrValues.add(strCBSid);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
//				}
				
				/*if(strModuletype.equalsIgnoreCase("OTSCO"))
				{
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insotsgeneral_cbsnpa");
					intUpdatesize++;
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("solid")));
					arrValues.add(strCBSid);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}*/
				
				/*if(strModuletype.equalsIgnoreCase("PAWO"))
				{
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inspwogeneral_cbsnpa");
					intUpdatesize++;
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("solid")));
					arrValues.add(strCBSid);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}*/
				
				/*if(strModuletype.equalsIgnoreCase("SUIT"))
				{
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","inssuitgeneral_cbsnpa");
					intUpdatesize++;
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("solid")));
					arrValues.add(strCBSid);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}*/
				
				/*if(strModuletype.equalsIgnoreCase("STAT"))
				{
					
				}*/
//				hshQueryValues.put("size",Integer.toString(intUpdatesize));
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
//		}
//		catch(Exception ex)
//		{
//			throw new EJBException("Error in loadcbsnpadata :: "+ex.toString());
//		}
//	}
	
	public void updateotherbankdues(HashMap hshValues)
	{
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strAppno="";
		String strAction="";
		String strBanktype="",strQuery = "";
		StringBuilder sbAuditDataOld = new StringBuilder();
		ResultSet rs = null;
		
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			strAction =correctNull((String)hshValues.get("hidAction"));
			strBanktype=correctNull((String)hshValues.get("banktype"));
			if(strBanktype.equals(""))
			{
				strBanktype=correctNull((String)hshValues.get("hidbanktype"));
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				String strSerNo = correctNull((String)hshValues.get("hidsno"));
				strQuery = SQLParser.getSqlQuery("getbankingdt^"+strAppno+"^"+strSerNo+"^"+strBanktype);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(strBanktype.equalsIgnoreCase("CON")){
						sbAuditDataOld
					.append("Name of Bank ="+correctNull(rs.getString("npabk_bankname")))
					.append("~ Limit Sanctioned ="+Helper.formatDoubleValue(rs.getDouble("npabk_limit")))
					.append("~ Sharing Pattern ="+correctNull(rs.getString("npabk_sharepatern")))
					.append("~ Present Outstanding ="+Helper.formatDoubleValue(rs.getDouble("npabk_os")))
					.append("~ Account Status ="+ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull(rs.getString("npabk_status"))));
				}
				else if(strBanktype.equalsIgnoreCase("MUL"))
				{
					sbAuditDataOld
					.append("Name of Bank ="+correctNull(rs.getString("npabk_bankname")))
					.append("~ Limit Sanctioned ="+Helper.formatDoubleValue(rs.getDouble("npabk_limit")))
					.append("~ Present Outstanding ="+Helper.formatDoubleValue(rs.getDouble("npabk_os")))
					.append("~ Account Status ="+ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull(rs.getString("npabk_status"))));
				}
				else if(strBanktype.equalsIgnoreCase("TF"))
				{
					sbAuditDataOld
					.append("Name of FI ="+correctNull(rs.getString("npabk_bankname")))
					.append("~ Principal Amt (Rs.)="+Helper.formatDoubleValue(rs.getDouble("npabk_limit")))
					.append("~ Present O/S (Rs.)="+Helper.formatDoubleValue(rs.getDouble("npabk_os")))
					.append("~ Nature of Security ="+correctNull(rs.getString("npabk_security")))
					.append("~ Present value of security (Rs.) ="+Helper.formatDoubleValue(rs.getDouble("npabk_secvalue")));
				}
			  }
			}
		 
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(getbankid(strAppno,strBanktype));
				arrValues.add(correctNull((String)hshValues.get("txt_consortium")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_sharing_pattern")));
				arrValues.add(correctNull((String)hshValues.get("txt_present_outstanding")));
				arrValues.add(correctNull((String)hshValues.get("status")));
				arrValues.add(correctNull((String)hshValues.get("txt_security")));
				arrValues.add(correctNull((String)hshValues.get("txt_secvalue")));
				arrValues.add(strBanktype);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_npabanking");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("txt_consortium")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(correctNull((String)hshValues.get("txt_sharing_pattern")));
				arrValues.add(correctNull((String)hshValues.get("txt_present_outstanding")));
				arrValues.add(correctNull((String)hshValues.get("status")));
				arrValues.add(correctNull((String)hshValues.get("txt_security")));
				arrValues.add(correctNull((String)hshValues.get("txt_secvalue")));
				arrValues.add(strAppno);
				arrValues.add(strBanktype);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_npabanking");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_npabanking");
				arrValues.add(strAppno);
				arrValues.add(strBanktype);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strBanktype.equalsIgnoreCase("CON")){
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
				sbAuditData
					.append("Name of Bank ="+ correctNull((String)hshValues.get("txt_consortium")))
					.append("~ Limit Sanctioned ="+correctNull((String)hshValues.get("txt_limit")))
					.append("~ Sharing Pattern ="+correctNull((String)hshValues.get("txt_sharing_pattern")))
					.append("~ Present Outstanding ="+correctNull((String)hshValues.get("txt_present_outstanding")))
					.append("~ Account Status ="+ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull((String)hshValues.get("status"))));
			}
			AuditTrial.auditNewLog(hshValues, "364", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		}
			else if(strBanktype.equalsIgnoreCase("MUL")){
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
						.append("Name of Bank ="+ correctNull((String)hshValues.get("txt_consortium")))
						.append("~ Limit Sanctioned ="+correctNull((String)hshValues.get("txt_limit")))
						.append("~ Present Outstanding ="+correctNull((String)hshValues.get("txt_present_outstanding")))
						.append("~ Account Status ="+ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull((String)hshValues.get("status"))));
				}
				AuditTrial.auditNewLog(hshValues, "365", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			}
			else if(strBanktype.equalsIgnoreCase("TF")){
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
						.append("Name of FI ="+ correctNull((String)hshValues.get("txt_consortium")))
						.append("~ Principal Amt ="+correctNull((String)hshValues.get("txt_limit")))
						.append("~ Present O/S ="+correctNull((String)hshValues.get("txt_present_outstanding")))
						.append("~ Present value of security (Rs.) ="+correctNull((String)hshValues.get("txt_secvalue")))
					.append("~ Nature of security ="+correctNull((String)hshValues.get("txt_security")));
				}
				AuditTrial.auditNewLog(hshValues, "366", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			}
	   }
		catch (Exception e)
		{
			throw new EJBException("Error in updateprudentialpage1Data ::  " + e.getMessage());
		} 
	}
	
	private String getbankid(String strappno,String strBanktype)
	{
		String strId="";
		ResultSet rs=null;
		String strQuery="";
		try{
			strQuery=SQLParser.getSqlQuery("getmaxnpabanking^"+strappno+"^"+strBanktype);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
				strId=correctNull(rs.getString("maxcnt"));
		}catch(Exception ex)
		{
			throw new EJBException("Error in getbankid ::  " + ex.getMessage());
		}
		return strId;
	}
	
	public HashMap getotherbankdues(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="";
		String strAppno="";
		String strBanktype="";
		try
		{
			strAppno = correctNull((String) hshValues.get("appno"));
			strBanktype=correctNull((String)hshValues.get("banktype"));
			if(strBanktype.equals(""))
			{
				strBanktype=correctNull((String)hshValues.get("hidbanktype"));
			}
			
			strQuery = SQLParser.getSqlQuery("sel_npabanking^"+strAppno+"^"+strBanktype);
			rs = DBUtils.executeQuery(strQuery);
			arrRow = new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("npabk_sno")));
				arrCol.add(correctNull((String)rs.getString("npabk_bankname")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npabk_limit")));
				arrCol.add(correctNull((String)rs.getString("npabk_sharepatern")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npabk_os")));
				arrCol.add(correctNull((String)rs.getString("npabk_status")));
				arrCol.add(correctNull((String)rs.getString("npabk_security")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npabk_secvalue")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getotherbankdues::: "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getotherbankdues::: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void updatesisterconcernsdata(HashMap hshValues)
	{
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strAppno="";
		String strAction="";
		StringBuilder sbAuditDataOld = new StringBuilder();
		
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction =correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete")){
				String strSerNo = correctNull((String)hshValues.get("hidsno"));
				String strQuery = SQLParser.getSqlQuery("getsisbankingdet^"+strAppno+"^"+strSerNo);
				ResultSet rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					sbAuditDataOld
					.append("Name of Associate Concern  =" +correctNull(rs.getString("npasisbk_concern")))
					.append("~ Name of Partner's/Director's =" +correctNull(rs.getString("npasisbk_partners")))
					.append("~ Bankers =" +correctNull(rs.getString("npasisbk_bankname")))
					.append("~ Limit Sanctioned Rs. =" +Helper.formatDoubleValue(rs.getDouble("npasisbk_limit")))
					.append("~ Status of A/c. =" +ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull(rs.getString("npasisbk_status"))));
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(getsisconcernid(strAppno));
				arrValues.add(correctNull((String)hshValues.get("txt_concern")));
				arrValues.add(correctNull((String)hshValues.get("txt_partners")));
				arrValues.add(correctNull((String)hshValues.get("txt_bankers")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("status")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_npasisbanking");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("txt_concern")));
				arrValues.add(correctNull((String)hshValues.get("txt_partners")));
				arrValues.add(correctNull((String)hshValues.get("txt_bankers")));
				arrValues.add(correctNull((String)hshValues.get("txt_limit")));
				arrValues.add("");
				arrValues.add(correctNull((String)hshValues.get("status")));
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_npasisbanking");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_npasisbanking");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")){
				sbAuditData
				.append("Name of Associate Concern  =" +correctNull((String)hshValues.get("txt_concern")))
				.append("~ Name of Partner's/Director's =" +correctNull((String)hshValues.get("txt_partners")))
				.append("~ Bankers =" +correctNull((String)hshValues.get("txt_bankers")))
				.append("~ Limit Sanctioned Rs. =" +correctNull((String)hshValues.get("txt_limit")))
				.append("~ Status of A/c. =" +ApplicantParams.getApplicantParams("ACCOUNTSTATUS", correctNull((String)hshValues.get("status"))));
			}
			AuditTrial.auditNewLog(hshValues, "367", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatesisterconcernsdata ::  " + e.getMessage());
		} 
	}
	
	private String getsisconcernid(String strappno)
	{
		String strId="";
		ResultSet rs=null;
		String strQuery="";
		try{
			strQuery=SQLParser.getSqlQuery("getmaxnpasisbanking^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
				strId=correctNull(rs.getString("maxcnt"));
		}catch(Exception ex)
		{
			throw new EJBException("Error in getsisconcernid ::  " + ex.getMessage());
		}
		return strId;
	}
	
	public HashMap getsisterconcerndata(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="";
		String strAppno="";
		try
		{
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_npasisbanking^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			arrRow = new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("npasisbk_sno")));
				arrCol.add(correctNull((String)rs.getString("npasisbk_concern")));
				arrCol.add(correctNull((String)rs.getString("npasisbk_partners")));
				arrCol.add(correctNull((String)rs.getString("npasisbk_bankname")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npasisbk_limit")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npasisbk_os")));
				arrCol.add(correctNull((String)rs.getString("npasisbk_status")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getsisterconcerndata::: "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getsisterconcerndata::: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void updatedepaccountdata(HashMap hshValues)
	{
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		String strAppno="";
		String strAction="";
		
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction =correctNull((String)hshValues.get("hidAction"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(getdepaccntid(strAppno));
				arrValues.add(correctNull((String)hshValues.get("txt_acctholdname")));
				arrValues.add(correctNull((String)hshValues.get("txt_relation")));
				arrValues.add(correctNull((String)hshValues.get("txt_accnttype")));
				arrValues.add(correctNull((String)hshValues.get("txt_osamt")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_npadepositdetails");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("txt_acctholdname")));
				arrValues.add(correctNull((String)hshValues.get("txt_relation")));
				arrValues.add(correctNull((String)hshValues.get("txt_accnttype")));
				arrValues.add(correctNull((String)hshValues.get("txt_osamt")));
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_npadepositdetails");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_npadepositdetails");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("hidsno")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatedepaccountdata ::  " + e.getMessage());
		} 
	}
	
	private String getdepaccntid(String strappno)
	{
		String strId="";
		ResultSet rs=null;
		String strQuery="";
		try{
			strQuery=SQLParser.getSqlQuery("getmaxnpadepositdetails^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
				strId=correctNull(rs.getString("maxcnt"));
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getsisconcernid ::  " + ex.getMessage());
		}
		return strId;
	}
	
	public HashMap getdepaccountdata(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strQuery="";
		String strAppno="";
		try
		{
			strAppno = correctNull((String) hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_npadepositdetails^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			arrRow = new ArrayList();
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("npadacnt_sno")));
				arrCol.add(correctNull((String)rs.getString("npadacnt_actholdname")));
				arrCol.add(correctNull((String)rs.getString("npadacnt_relation")));
				arrCol.add(correctNull((String)rs.getString("npadacnt_typeofaccnt")));
				arrCol.add(Helper.formatDoubleValue(rs.getDouble("npadacnt_osamt")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getdepaccountdata::: "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getdepaccountdata::: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap getGeneralinfoData(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		HashMap hshAppdata=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		String strAppno="";
		String strCbsid="";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			if(strAppno.equals("") || strAppno.equalsIgnoreCase("New"))
			{
				strAppno=correctNull((String)hshValues.get("npa_appno"));
			}
			strCbsid=correctNull((String)hshValues.get("hidapplicantid"));
			strQuery=SQLParser.getSqlQuery("sel_npageneralinfo^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("constitutioncode",correctNull(rs.getString("npagen_constitution")));
				hshResult.put("provision",correctNull(rs.getString("npagen_provision")));
				hshResult.put("activitycode",correctNull(rs.getString("npagen_activity")));
				hshResult.put("advancesince",correctNull(rs.getString("npagen_advancesince")));
				hshResult.put("banksince",correctNull(rs.getString("npagen_banksince")));
				hshResult.put("npasince",correctNull(rs.getString("npagen_npasince")));
				hshResult.put("lossdoubtsince",correctNull(rs.getString("npagen_lossdoubtsince")));
				hshResult.put("bankarrangement",correctNull(rs.getString("npagen_bankarrangement")));
				hshResult.put("unitstatus",correctNull(rs.getString("npagen_unitstatus")));
				hshResult.put("unitrunfor",correctNull(rs.getString("npagen_unitrunfor")));
				hshResult.put("unitclosedsince",correctNull(rs.getString("npagen_unitclosedsince")));
				hshResult.put("livehoodsrc",correctNull(rs.getString("npagen_livehoodsrc")));
				hshResult.put("regoffaddr",correctNull(rs.getString("npagen_regoffaddr")));
				hshResult.put("regoffpremises",correctNull(rs.getString("npagen_regoffpremises")));
				hshResult.put("facoffaddr",correctNull(rs.getString("npagen_facoffaddr")));
				hshResult.put("facpremises",correctNull(rs.getString("npagen_facpremises")));
				hshResult.put("presentclassify",correctNull(rs.getString("npagen_presentclassify")));
				hshResult.put("propfor",correctNull(rs.getString("npagen_propfor")));
				hshResult.put("propamt",correctNull(rs.getString("npagen_propamt")));
				hshResult.put("propcounteramt",correctNull(rs.getString("npagen_propcounteramt")));
				hshResult.put("sancauth",correctNull(rs.getString("npagen_sancauth")));
				hshResult.put("lastrevdate",correctNull(rs.getString("npagen_lastrevdate")));
				hshResult.put("disbdate",correctNull(rs.getString("npagen_disbdate")));
				hshResult.put("do_ieb",correctNull(rs.getString("npagen_do_ieb")));
				hshResult.put("sector",correctNull(rs.getString("npagen_sector")));
				hshResult.put("constitution",correctNull(rs.getString("constitution")));
				hshResult.put("presentclassification",correctNull(rs.getString("presentclassification")));
				hshResult.put("activity",correctNull(rs.getString("activity")));
				hshResult.put("sancauthname",correctNull(rs.getString("npagen_lastrevby")));
				hshResult.put("sta_scale",correctNull(rs.getString("npagen_revauthscale")));
				hshResult.put("sta_lastfinancedate",correctNull(rs.getString("npagen_lasfinstamt")));
				hshResult.put("sta_excessdate",correctNull(rs.getString("npagen_excesssince")));
				hshResult.put("sta_maxexcessallowed",correctNull(rs.getString("npagen_maxexcessallowed")));
				hshResult.put("sta_stepstaken",correctNull(rs.getString("npagen_adjsteps")));
				hshResult.put("writeoff",correctNull(rs.getString("npagen_pwo")));
				hshResult.put("sinceexcess",correctNull(rs.getString("npagen_excessdate")));
				hshResult.put("ecgcclaimed",correctNull(rs.getString("npagen_ecgcclaim")));
				hshResult.put("defaulter",correctNull(rs.getString("npagen_defaulter")));
				hshResult.put("fraud",correctNull(rs.getString("npagen_fraud")));  
				hshResult.put("compro_effectprofit",correctNull(rs.getString("npagen_profitability"))); 
				hshResult.put("recordFlag","Y");
			}
			else
			{
				hshResult.put("recordFlag","N");
			}
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				strQuery = SQLParser.getSqlQuery("sel_gennotecbsnpa^"+strCbsid);			
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("banksince",correctNull(rs.getString("personal_bankingsince")));
					hshResult.put("constitutioncode",correctNull(rs.getString("personal_constitution")));
					hshResult.put("activitycode",correctNull(rs.getString("personal_natofactivity")));
					hshResult.put("presentclassify",correctNull(rs.getString("personal_classification")));
					hshResult.put("assetclassification",correctNull((String)rs.getString("assetclassification")));
					hshResult.put("regoffaddr",correctNull(rs.getString("personal_address"))+" , "
							+correctNull(rs.getString("personal_address1"))+" , "
							+correctNull(rs.getString("personal_city"))+" , "
							+correctNull(rs.getString("personal_state"))+" , "
							+correctNull(rs.getString("personal_pincode")));
					hshResult.put("constitution",correctNull((String)rs.getString("constitution")));
					hshAppdata.put("customername", correctNull((String)rs.getString("personal_custname")));
				}
				
				hshAppdata.put("npaappno",correctNull((String)hshValues.get("appno")));
				hshAppdata.put("cbsid", correctNull((String)hshValues.get("hidappid")));
				hshAppdata.put("status", "op");
				hshAppdata.put("demoapptype", correctNull((String)hshValues.get("hidapptype")));
				hshAppdata.put("moduletype", correctNull((String)hshValues.get("hidmoduletype")));
				hshAppdata.put("year", correctNull((String)hshValues.get("year")));
				hshAppdata.put("quarter", correctNull((String)hshValues.get("quarter")));
				hshAppdata.put("btnenable", "Y");
			}
			else
			{
				TagDataHelper1 tagDataHelper1=new TagDataHelper1();
				hshValues.put("check","NPA");
				hshAppdata=(HashMap)tagDataHelper1.getAppData(hshValues);
				if(correctNull((String)hshValues.get("hidmoduletype")).equalsIgnoreCase("STAT")){
				hshAppdata.put("year",strAppno.substring(6,10));
				hshAppdata.put("quarter",strAppno.substring(10,11));
				}
				
				String struserrights=correctNull((String)hshValues.get("strGroupRights"));
				hshAppdata.put("readflag",""+struserrights.charAt(18));
				
				if((""+struserrights.charAt(18)).equalsIgnoreCase("w"))
				{
					if(correctNull((String)hshAppdata.get("status")).equalsIgnoreCase("op") || correctNull((String)hshAppdata.get("status")).equalsIgnoreCase("pp"))
					{
						if(correctNull((String)hshValues.get("strUserId")).equalsIgnoreCase(correctNull((String)hshAppdata.get("holduserid"))))
						{
							if(correctNull((String)hshValues.get("strOrgShortCode")).equalsIgnoreCase(correctNull((String)hshAppdata.get("createorgscode"))))
							{
								hshAppdata.put("btnenable","Y");
							}
							else
							{
								hshAppdata.put("btnenable","N");
							}
						}
						else
						{
							hshAppdata.put("btnenable","N");
						}
					}
					else
					{
						hshAppdata.put("btnenable","N");
					}
				}
				else
				{
					hshAppdata.put("btnenable","N");
				}
			}
			hshResult.put("hshAppdata",hshAppdata);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getGeneralinfoData::: "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection in getGeneralinfoData::: "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public HashMap updateGeneralinfoData(HashMap hshValues)
	{
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues=new HashMap();
		HashMap hshRecord=new HashMap();
		HashMap hshUpload=null;
		String strAppno="";
		String strAction="";
		String strNpatype="";
		String strApptype="C";
		String strCbsid="";
		String oldAppno="";
		String strQuery="";
		String strStatusAppno="";
		String strExp="$";
		ResultSet rs=null;
		int intUpdatesize=0;
		
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strAction =correctNull((String)hshValues.get("hidAction"));
			strNpatype=correctNull((String)hshValues.get("hidmoduletype"));
			strCbsid = correctNull((String)hshValues.get("cbsid"));
			if(strCbsid.equals(""))
			{
				strCbsid=correctNull((String)hshValues.get("hidapplicantid"));
			}
			String strNPASince=correctNull((String)hshValues.get("txt_npasince"));
			String strProvision=correctNull((String)hshValues.get("txt_provision"));
			String strAdvancesince=correctNull((String)hshValues.get("txt_advancesince"));
			String strBankarrangement=correctNull((String)hshValues.get("sel_bankarrangement"));
			String strUnitstatus=correctNull((String)hshValues.get("sel_unitstatus"));
			String strUnitrunfor=correctNull((String)hshValues.get("sel_unitrunfor"));
			String strUnitclosedsince=correctNull((String)hshValues.get("txt_unitclosedsince"));
			String strSrclivehood=correctNull((String)hshValues.get("txt_srclivehood"));
			String strSancauth=correctNull((String)hshValues.get("sel_sancauth"));
			String strlastrevdate=correctNull((String)hshValues.get("txt_lastreview"));
			
			if(strAppno.equalsIgnoreCase("NEW"))
			{
				if(strNpatype.equalsIgnoreCase("STAT"))
				{
					String strOrgSCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
					String stryear=Helper.correctNull((String)hshValues.get("year"));
					String strquarter=Helper.correctNull((String)hshValues.get("quarter"));
					
					strAppno=strOrgSCode+stryear+strquarter+strCbsid;

					int year=0;
					int quarter=0;
					if(strquarter.equalsIgnoreCase("1"))
					{
						year=Integer.parseInt(stryear);
						year=year-1;
						stryear=String.valueOf(year);
						strquarter="4";
					}
					else
					{
						quarter=Integer.parseInt(strquarter);
						quarter=quarter-1;
						strquarter=String.valueOf(quarter);
					}
								
					oldAppno=strOrgSCode+stryear+strquarter+strCbsid;
					
					hshValues.put("appno",strAppno);	
					hshValues.put("oldappno",oldAppno);	
					hshValues.put("cbsid",strCbsid);
				}
				else
				{
					hshUpload=new HashMap();
					String strType="NPA";
					hshUpload.put("comapp_id",strCbsid);
					hshUpload.put("apptype",strType);
					hshUpload.put("npatype",strNpatype);
					strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshUpload,"getNPAAppno");
					hshValues.put("appno",strAppno);	
					
					
					strQuery = SQLParser.getSqlQuery("sel_MaxNPAstatApplnNo^"+strCbsid+"^"+"C"+"^"+" and npa_status='ca' and npa_demoappno=npa_appno");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{	
						strStatusAppno=correctNull(rs.getString("npa_appno"));
					}
					if(strStatusAppno.equalsIgnoreCase(""))
					{
						strQuery = SQLParser.getSqlQuery("sel_MaxNPAstatApplnNo^"+strCbsid+"^"+"C"+"^"+" and npa_demoappno=npa_appno");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{	
							strStatusAppno=correctNull(rs.getString("npa_appno"));
						}
						if(strStatusAppno.equalsIgnoreCase(""))
						{
							strExp = strExp+"Cannot Create a new Application Since You have not created the Status note";
							throw new Exception(strExp);
						} 
						else
						{
							strExp = strExp+"Cannot Create a new Application Since You have not Freezed the Status note";
							throw new Exception(strExp);
						}
					}
				}
				if(!strAppno.equalsIgnoreCase(""))
				{
					hshQueryValues = new HashMap();
					
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQuery.put("strQueryId","ins_npaapplication");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(strNpatype);
					arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQuery.put("strQueryId","ins_npademographics");
					arrValues.add(strAppno);
					arrValues.add(strCbsid);
					arrValues.add(strApptype);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQuery.put("strQueryId","ins_npageneralinfo");
					arrValues.add(strAppno);
					arrValues.add(strCbsid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					hshQueryValues.put("size","3");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					intUpdatesize=0;
					
					if(strNpatype.equalsIgnoreCase("SARFI"))
					{
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insdocumentation_cbsnpa");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strCbsid);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					
					if(strNpatype.equalsIgnoreCase("STAT"))
					{
						//oldAppno
						//EJBInvoker.executeStateLess("npa",hshValues,"updateNPAStatusnote");
						
						/*
						 * This to update the status of the application of perivous Quater 
						 * 
						 */
						
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();
						hshQuery.put("strQueryId","inspresentposition_cbsnpa");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strNpatype);
						arrValues.add(strCbsid);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						intUpdatesize++;
						
						hshQuery.put("strQueryId","upd_npaapplnclosed");
						arrValues.add("ca");
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(oldAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						
						strQuery=SQLParser.getSqlQuery("npaapptag^"+oldAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							/*
							 * To Copy the Means  Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npaborrowerdetails");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(strNpatype);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							/*
							 * To Copy the Means  Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_statuscomments");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							/*
							 * To Copy the Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_statuscomments2");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							/*
							 * To Copy the Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_statuscomments3");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

							/*
							 * To Copy the Securities Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","insnpa_securities");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(strNpatype);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
							/*
							 * To Copy the History Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npahistory");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the OTS Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npaots");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Sarfaesia Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npasarfaesia1");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Sarfaesia Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npasarfaesia2");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Suit Filed Comments Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","ins_npasuitfield");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Audit Observations Information  
							 * 
							 */
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","insnpa_auditcomments");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(strNpatype);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Banking Details
							 * 
							 */ 
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","insnpa_banking");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/*
							 * To Copy the Sister concern Details
							 * 
							 */ 
							hshQuery = new HashMap();	
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","insnpa_sisbanking");
							intUpdatesize++;
							arrValues.add(strAppno);
							arrValues.add(oldAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					}
					else
					{
						/****** Update General Info *******/
						strQuery=SQLParser.getSqlQuery("sel_npageneralinfo^"+strStatusAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strNPASince=correctNull(rs.getString("npagen_npasince"));
							strProvision=correctNull(rs.getString("npagen_provision"));
							strAdvancesince=correctNull(rs.getString("npagen_advancesince"));
							strBankarrangement=correctNull(rs.getString("npagen_bankarrangement"));
							strUnitstatus=correctNull(rs.getString("npagen_unitstatus"));
							strUnitrunfor=correctNull(rs.getString("npagen_unitrunfor"));
							strUnitclosedsince=correctNull(rs.getString("npagen_unitclosedsince"));
							strSrclivehood=correctNull(rs.getString("npagen_livehoodsrc"));
							strSancauth=correctNull(rs.getString("npagen_sancauth"));
							strlastrevdate=correctNull(rs.getString("npagen_lastrevdate"));
						}
						
						/******  Into presentpostion Table   *******/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_npapresentposition");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strNpatype);
						arrValues.add(strStatusAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/******  Into Means Table   *******/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_npaborrowerdetails");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strNpatype);
						arrValues.add(strStatusAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
	
						/******  Into Security Table   *******/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insnpa_securities");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strNpatype);
						arrValues.add(strStatusAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/******  Into Banking Details Table   *******/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insnpa_banking");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strStatusAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/******  Into Sister concern Details Table   *******/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insnpa_sisbanking");
						intUpdatesize++;
						
						arrValues.add(strAppno);
						arrValues.add(strStatusAppno);
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/*** To Copy the Audit Observations Information ***/
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insnpa_auditcomments");
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(strNpatype);
						arrValues.add(strStatusAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/*** To Copy the the History Information   ***/
						
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_npahistory");
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(strStatusAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					hshQueryValues.put("size",Integer.toString(intUpdatesize));	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{	
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_npageneralinfo");
				
				arrValues.add(correctNull((String)hshValues.get("selproptype")));
				arrValues.add(strNPASince);
				arrValues.add(correctNull((String)hshValues.get("sel_regoffpremises")));
				arrValues.add(correctNull((String)hshValues.get("txt_facaddr")));
				arrValues.add(correctNull((String)hshValues.get("sel_facpremises")));
				arrValues.add(strAdvancesince);
				arrValues.add(strBankarrangement);
				arrValues.add(strUnitstatus);
				arrValues.add(strUnitrunfor);
				arrValues.add(strUnitclosedsince);
				arrValues.add(strSrclivehood);
				arrValues.add(strlastrevdate);
				arrValues.add(correctNull((String)hshValues.get("txt_propamt")));
				arrValues.add(correctNull((String)hshValues.get("txt_propcounteramt")));
				arrValues.add(strSancauth);
				arrValues.add(correctNull((String)hshValues.get("txt_disbdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_do_ieb")));
				arrValues.add(correctNull((String)hshValues.get("txt_sector")));
				arrValues.add(strProvision);
				arrValues.add(correctNull((String)hshValues.get("txt_lossdoubtfulsince")));
				arrValues.add(correctNull((String)hshValues.get("txt_lastreviewby")));
				arrValues.add(correctNull((String)hshValues.get("txt_scale")));
				arrValues.add(correctNull((String)hshValues.get("txt_lastfinancedate")));
				arrValues.add(correctNull((String)hshValues.get("txt_excessdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_maxexcessallowed")));
				arrValues.add(correctNull((String)hshValues.get("txt_stepstaken")));
				arrValues.add(correctNull((String)hshValues.get("sel_fraud")));
				arrValues.add(correctNull((String)hshValues.get("sel_defaulter")));
				arrValues.add(correctNull((String)hshValues.get("sel_ecgc")));
				arrValues.add(correctNull((String)hshValues.get("txt_excessdate")));
				arrValues.add(correctNull((String)hshValues.get("sel_pwo")));
				arrValues.add(correctNull((String)hshValues.get("txt_effect_profit")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strAppno);
				hshQuery.put("strQueryId","upd_npageneralinfo");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshRecord=getGeneralinfoData(hshValues);
			if(correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("insert"))
			{
				hshRecord.put("npa_appno",strAppno);
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strCode = "";
			String strDataflag = correctNull((String)hshValues.get("hidDataFlag"));
			if(strDataflag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "Update");
			}
			else if(strDataflag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "Insert");
			}
			if(strAction.equalsIgnoreCase("insert") && strNpatype.equalsIgnoreCase("STAT"))
			{
				sbAuditData
				.append("STATUS OF ACCOUNT ="+ApplicantParams.getApplicantParams("BNKACCOUNTSTATUS", correctNull((String)hshValues.get("selproptype"))))
				.append("~ NPAs AS ON ="+correctNull((String)hshValues.get("txt_npasince")))
				.append("~ Registered Office Address"+correctNull((String)hshValues.get("txt_regoffaddr")))
				.append("~ Factory Address"+correctNull((String)hshValues.get("txt_facaddr")))
				.append("~ Factory Premises ="+ApplicantParams.getApplicantParams("FACTORYPREMISES", correctNull((String)hshValues.get("sel_facpremises"))))
				.append("~ Banking since ="+correctNull((String)hshValues.get("txt_banksince")))
				.append("~ Advance since ="+correctNull((String)hshValues.get("txt_advancesince")))
				.append("~ Constitution ="+correctNull((String)hshValues.get("txt_consititution")))
				.append("~ Activity ="+correctNull((String)hshValues.get("txt_activity")))
				.append("~ (a) Banking arrangement ="+ApplicantParams.getApplicantParams("BANKINGARRANGEMENT", correctNull((String)hshValues.get("sel_bankarrangement"))))
				.append("~ Present Asset Classification ="+correctNull((String)hshValues.get("txt_preclassification")))
				.append("~ Provision held ="+correctNull((String)hshValues.get("txt_provision")))
				.append("~ Date of last review ="+correctNull((String)hshValues.get("txt_lastreview")))
				.append("~ Last Reviewed Authority ="+correctNull((String)hshValues.get("hidReviewAuth")))
				.append("~ Last reviewed by ="+correctNull((String)hshValues.get("txt_lastreviewby")))
				.append("~ Reviewed Officer Scale ="+correctNull((String)hshValues.get("txt_scale")))
				.append("~ Last financial statement held on record="+correctNull((String)hshValues.get("txt_lastfinancedate")))
				.append("~ Date since A/c., is in excess ="+correctNull((String)hshValues.get("txt_excessdate")))
				.append("~ Steps taken for adjustment ="+correctNull((String)hshValues.get("txt_stepstaken")))
				.append("~ Maximum excess allowed ="+correctNull((String)hshValues.get("txt_maxexcessallowed")))
				.append("~ Whether unit is working/closed ="+ApplicantParams.getApplicantParams("UNITSTATUS", correctNull((String)hshValues.get("sel_unitstatus"))));
				if(correctNull((String)hshValues.get("sel_unitstatus")).equalsIgnoreCase("1")){
					sbAuditData.append("~ Stautus of Working =" +ApplicantParams.getApplicantParams("WORKINGSTATUS", correctNull((String)hshValues.get("sel_unitrunfor"))));
				}
				else if(correctNull((String)hshValues.get("sel_unitstatus")).equalsIgnoreCase("2")){
					sbAuditData.append("~ Date Since Unit is closed ="+correctNull((String)hshValues.get("txt_unitclosedsince")));
					sbAuditData.append("~ Sources of Livelihood : ="+correctNull((String)hshValues.get("txt_srclivehood")));
				}				
				strCode = "363";
			}
			else if(strAction.equalsIgnoreCase("insert") && strNpatype.equalsIgnoreCase("OTSCO")){
				sbAuditData
				.append("PROPOSAL FOR SETTLEMENT =" +ApplicantParams.getApplicantParams("PROPOSALSETTLEMENT", correctNull((String)hshValues.get("selproptype"))))
				.append("~ PRESENT CLASSIFICATION =" +correctNull((String)hshValues.get("txt_present_classfication")))
				.append("~ PROVISION HELD =" +correctNull((String)hshValues.get("txt_provision")))
				.append("~ OTS AMOUNT PROPOSED =" +correctNull((String)hshValues.get("txt_propamt")))
				.append("~ COUNTER OFFER AMOUNT =" +correctNull((String)hshValues.get("txt_propcounteramt")))
				.append("~ EFFECT ON PROFITABILTY =" +correctNull((String)hshValues.get("txt_effect_profit")))
				.append("~ CONSTITUTION =" +correctNull((String)hshValues.get("txt_constitution")))
				.append("~ PRESENT ACTIVITY =" +correctNull((String)hshValues.get("txt_present_act")))
				.append("~ BANKING SINCE =" +correctNull((String)hshValues.get("txt_banksince")))
				.append("~ ADVANCE SINCE =" +correctNull((String)hshValues.get("txt_advancesince")))
				.append("~ NPA SINCE =" +correctNull((String)hshValues.get("txt_npasince")))
				.append("~ SECTOR CODE =" +correctNull((String)hshValues.get("txt_sector")))
				.append("~ ACCOUNT IS CLASSIFIED AS FRAUD =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_fraud"))))
				.append("~ ACCOUNT IS CLASSIFIED AS WILFULL DEFAULTER =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_defaulter"))))
				.append("~ ECGC/CGFT/DICGC CLAIM SETTLED =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_ecgc"))))
				.append("~ ECGC/CGFT/DICGC CLAIM SETTLED DATE =" +correctNull((String)hshValues.get("txt_excessdate")))
				.append("~ ACCOUNT IS PRUDENTIALLY WRITTEN OFF =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_pwo"))));
				
				strCode = "375";
			}
			else if(strAction.equalsIgnoreCase("insert") && strNpatype.equalsIgnoreCase("SARFI")){
				sbAuditData
				.append("ACTIVITY FOR WHICH FINANCED =" +correctNull((String)hshValues.get("txt_activity")))
				.append("~ CONSTITUTION =" +correctNull((String)hshValues.get("sel_constitution")))
				.append("~ BANKING ARRANGEMENT ="+ApplicantParams.getApplicantParams("BANKINGARRANGEMENT", correctNull((String)hshValues.get("sel_bankarrangement"))))
				.append("~ ADVANCE SINCE =" +correctNull((String)hshValues.get("txt_advancesince")))
				.append("~ NPA SINCE =" +correctNull((String)hshValues.get("txt_npasince")))
				.append("~ ASSET CLASSIFICATION ="+correctNull((String)hshValues.get("asset_class")))
				.append("~ PROVISION ="+correctNull((String)hshValues.get("txt_provision")));
				
				strCode = "381";
			}
			else if(strAction.equalsIgnoreCase("insert") && strNpatype.equalsIgnoreCase("PAWO")){
				sbAuditData
				.append("CONSTITUTION =" +correctNull((String)hshValues.get("txtconstitution")))
				.append("~ PROVISION ="+correctNull((String)hshValues.get("txt_provision")))
				.append("~ ACTIVITY ="+correctNull((String)hshValues.get("txt_activity")))
				.append("~ ADVANCE SINCE =" +correctNull((String)hshValues.get("txt_advancesince")))
				.append("~ NPA SINCE =" +correctNull((String)hshValues.get("txt_npasince")))
				.append("~ DOUBTFUL/LOSS SINCE =" +correctNull((String)hshValues.get("txt_lossdoubtfulsince")))
				.append("~ PROPOSAL TYPE ="+ApplicantParams.getApplicantParams("TYPEOFPROPOSAL", correctNull((String)hshValues.get("selproptype"))))
				.append("~ NOMINAL BALANCE =" +correctNull((String)hshValues.get("txt_propamt")))
				.append("~ BANKING ARRANGEMENT ="+correctNull((String)hshValues.get("txt_bankarrangement")))
				.append("~ DICGC/ECGC CLAIM SETTLED =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_ecgc"))))
				.append("~ DATE OF SETTLEMENT =" +correctNull((String)hshValues.get("txt_excessdate")))
				.append("~ WHETHER UNIT IS RUNNING OR CLOSED =" +correctNull((String)hshValues.get("txt_unitstatus")));
								
				strCode = "388";
			}
			else if(strAction.equalsIgnoreCase("insert") && strNpatype.equalsIgnoreCase("SUIT")){
				sbAuditData
				.append("SUIT TO BE FILED AT ="+ApplicantParams.getApplicantParams("PROPOSALS", correctNull((String)hshValues.get("selproptype"))))
				.append("~ SECTORAL CATEGORY ="+correctNull((String)hshValues.get("txt_Sectoral_cat")))
				.append("~ CONSTITUTION =" +correctNull((String)hshValues.get("sel_constitution")))
				.append("~ BANKING ARRANGEMENT ="+correctNull((String)hshValues.get("txt_bankarrangement")))
				.append("~ OFFICE PREMISES ="+ApplicantParams.getApplicantParams("FACTORYPREMISES", correctNull((String)hshValues.get("sel_regoffpremises"))))
				.append("~ FACTORY PREMISES ="+ApplicantParams.getApplicantParams("FACTORYPREMISES", correctNull((String)hshValues.get("sel_facpremises"))))
				.append("~ NATURE OF BUSINESS ="+correctNull((String)hshValues.get("txt_Nature_Business")))
				.append("~ DATE OF ESTABLISHMENT ="+correctNull((String)hshValues.get("txt_do_ieb")))
				.append("~ DATE ACCOUNT OPENED =" +correctNull((String)hshValues.get("txt_advancesince")))
				.append("~ NPA SINCE =" +correctNull((String)hshValues.get("txt_npasince")))
				.append("~ LAST REVIEW DATE =" +correctNull((String)hshValues.get("txt_lastreview")))
				.append("~ PROVISION AMOUNT ="+correctNull((String)hshValues.get("txt_provision")))
				.append("~ ORIGINALLY SANCTIONED DATE =" +correctNull((String)hshValues.get("txt_sanctioned_date")))
				.append("~ DISBURSED DATE =" +correctNull((String)hshValues.get("txt_disbdate")))
				.append("~ SANCTIONING AUTHORITY =" +correctNull((String)hshValues.get("hidSancAuth")))
				.append("~ WHETHER CREDIT FACILITY RENEWED =" +ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("sel_enforce"))));
								
				strCode = "388";
			}
			AuditTrial.auditLog(hshValues, strCode, strAppno, sbAuditData.toString());
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateGeneralinfoData ::  " + e.getMessage());
		}
		return hshRecord;
	}
	
	public 	HashMap getsignatories(HashMap hshValues)
	{

		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery ="";
		
		String strAppno="";
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			strQuery = SQLParser.getSqlQuery("sel_npasignatories^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				hshResult.put("refno",correctNull(rs.getString("npa_proprefno")));
				hshResult.put("propdate",correctNull(rs.getString("npa_propdate")));
				hshResult.put("sancauth",correctNull(rs.getString("npa_propsancauth")));
				hshResult.put("agendano",correctNull(rs.getString("npa_agendaitemno")));
				hshResult.put("mcmof",correctNull(rs.getString("npa_mcmof")));
				hshResult.put("mcmresolution",correctNull(rs.getString("npa_mcmresolution")));
				hshResult.put("commobservations",correctNull(rs.getString("npa_commobservations")));
				hshResult.put("signatures",correctNull(rs.getString("npa_signatories")));
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getsignatories ::  " + e.getMessage());
		} 
		finally
		{
			try
			{	if(rs != null)
					rs.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void  updatesignatories(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
		String strAppno="";
		
		String strAction =correctNull((String)hshValues.get("hidAction"));
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_npasignatories");
				
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_npasignatories");
				
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)hshValues.get("txt_propdate")));
				arrValues.add(correctNull((String)hshValues.get("txt_refno")));
				arrValues.add(correctNull((String)hshValues.get("selsancauth")));
				arrValues.add(correctNull((String)hshValues.get("txt_signatures")));
				arrValues.add(correctNull((String)hshValues.get("txt_mcmresolution")));
				arrValues.add(correctNull((String)hshValues.get("txt_commobservations")));
				arrValues.add(correctNull((String)hshValues.get("txt_agenda")));
				arrValues.add(correctNull((String)hshValues.get("txt_mcmof")));
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_npasignatories");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updatesignatories :: " + e.getMessage());
		} 
	}
	
	public void updateorganisationrecommendations(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();

		String strAppno = "", strAction = "";
		strAction = correctNull((String) hshValues.get("hidAction"));
		String strRecmdorglevel = correctNull((String) hshValues.get("sel_orglevel"));
		
		try {
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) 
			{
				strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
			}
		
			if (strAction.equalsIgnoreCase("insert")) 
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_otsorgrecmds");
				arrValues.add(strAppno);
				arrValues.add(strRecmdorglevel);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
		
				arrValues = new ArrayList();
				hshQuery = new HashMap();
		
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId", "ins_otsorgrecmds");
		
				arrValues.add(strAppno);
				arrValues.add(strRecmdorglevel);
				arrValues.add(correctNull((String) hshValues.get("txt_recommendations")));
		
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if (strAction.equalsIgnoreCase("delete")) 
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strRecmdorglevel);
				hshQuery.put("strQueryId", "del_otsorgrecmds");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		} catch (Exception e) {
			throw new EJBException(
					"Error in updateorganisationrecommendations :: "
							+ e.getMessage());
		}
	}

	public HashMap getorganisationrecmmendations(HashMap hshValues) 
	{
		HashMap hshResult = new HashMap();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";
		
		try 
		{
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			if (strAppno.equalsIgnoreCase("")) 
			{
				strAppno = Helper.correctNull((String) hshValues.get("npa_appno"));
			}
			String strRecmdorglevel = correctNull((String) hshValues.get("sel_orglevel"));
			if (correctNull((String) hshValues.get("printdata")).equalsIgnoreCase("print")) 
			{
				strQuery = SQLParser.getSqlQuery("sel_otsallorgrecmds^"+ strAppno);
				rs = DBUtils.executeQuery(strQuery);
		
				while (rs.next()) 
				{
					String strrecmdorglevel = correctNull(rs.getString("npa_recmdsorglevel"));
					if (strrecmdorglevel.equals("C")) 
					{
						hshResult.put("CRLDrecommendation", correctNull(rs.getString("npa_recommendation")));
					} else if (strrecmdorglevel.equals("R")) 
					{
						hshResult.put("FGMOrecommendation", correctNull(rs.getString("npa_recommendation")));
					} else if (strrecmdorglevel.equals("D")) 
					{
						hshResult.put("ROrecommendation", correctNull(rs.getString("npa_recommendation")));
					} else if (strrecmdorglevel.equals("A")) 
					{
						hshResult.put("BRrecommendation", correctNull(rs.getString("npa_recommendation")));
					}
				}
			} 
			else 
			{
				strQuery = SQLParser.getSqlQuery("sel_otsorgrecmds^" + strAppno+ "^" + strRecmdorglevel);
				rs = DBUtils.executeQuery(strQuery);
		
				if (rs.next()) 
				{
					hshResult.put("recommendation", correctNull(rs.getString("npa_recommendation")));
				}
				hshResult.put("recmds_orglevel", strRecmdorglevel);
			}
		} catch (Exception e)
		{
			throw new EJBException("Error in getorganisationrecmmendations :: "+ e.getMessage());
		} finally 
		{
			try 
			{
				if (rs != null)
					rs.close();
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshResult;
	}
	
	public void updateStatusnoteOTS(HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
		}
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		/*String strMonth=Helper.correctNull((String)hshValues.get("sel_month"));
		String strYear=Helper.correctNull((String)hshValues.get("txt_year"));*/
		String strOts=Helper.correctNull((String)hshValues.get("sel_OTS"));
		String strOtspossible=Helper.correctNull((String)hshValues.get("sel_otspossible"));
		String strdetails=Helper.correctNull((String)hshValues.get("txt_details"));
		String strmeasures=Helper.correctNull((String)hshValues.get("txt_measure"));
		String strsanctiondate=Helper.correctNull((String)hshValues.get("txt_sanctiondate"));
		String strsanctionauthority=Helper.correctNull((String)hshValues.get("txt_sancauthority"));
		String strpwoamount=Helper.correctNull((String)hshValues.get("txt_pwoamount"));
		String strdummyamount=Helper.correctNull((String)hshValues.get("txt_dummyamount"));
		String strlegalcharge=Helper.correctNull((String)hshValues.get("txt_legalcharge"));
		String strtotaldues=Helper.correctNull((String)hshValues.get("txt_totaldues"));
		String strclaimamount=Helper.correctNull((String)hshValues.get("txt_claimamount"));
		String strsettleamount=Helper.correctNull((String)hshValues.get("txt_settleamount"));
		String strwriteoff=Helper.correctNull((String)hshValues.get("txt_writeoff"));
		String strwaiver=Helper.correctNull((String)hshValues.get("txt_waiver"));
		String strabsortion=Helper.correctNull((String)hshValues.get("txt_absortionexp"));
		String strtotalrelief=Helper.correctNull((String)hshValues.get("txt_totalrelief"));
		String strrecoveryeffect=Helper.correctNull((String)hshValues.get("txt_recoveryeffect"));
		String strbalanceeffect=Helper.correctNull((String)hshValues.get("txt_balanceeffect"));
		String stroverdues=Helper.correctNull((String)hshValues.get("txt_overdue"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues=new HashMap();	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_npastatusots");
				arrValues.add(strAppno);
				/*arrValues.add(strMonth);
				arrValues.add(strYear);*/
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_npastatusots");
				arrValues.add(strAppno);
				/*arrValues.add(strMonth);
				arrValues.add(strYear);*/
				arrValues.add(strOts);
				arrValues.add(strOtspossible);
				arrValues.add(strdetails);
				arrValues.add(strmeasures);
				arrValues.add(strsanctiondate);
				arrValues.add(strsanctionauthority);
				arrValues.add(strpwoamount);
				arrValues.add(strdummyamount);
				arrValues.add(strlegalcharge);
				arrValues.add(strtotaldues);
				arrValues.add(strclaimamount);
				arrValues.add(strsettleamount);
				arrValues.add(strwriteoff);
				arrValues.add(strwaiver);
				arrValues.add(strabsortion);
				arrValues.add(strtotalrelief);
				arrValues.add(strrecoveryeffect);
				arrValues.add(strbalanceeffect);
				arrValues.add(stroverdues);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues=new HashMap();	
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_npastatusots");
				arrValues.add(strAppno);
				/*arrValues.add(strMonth);
				arrValues.add(strYear);*/
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditflag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditflag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "update");
			}else if(strAuditflag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert")){
				sbAuditData
				.append("Is OTS Approved =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_OTS"))))
				.append("~ Whether OTS possible =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_otspossible"))))
				.append("~ Date Of Sanction =" +correctNull((String)hshValues.get("txt_sanctiondate")))
				.append("~ Sanctioning Authority =" +correctNull((String)hshValues.get("txt_sancauthority")))
				.append("~ PWO amount =" +correctNull((String)hshValues.get("txt_pwoamount")))
				.append("~ O/s. in D/L =" +correctNull((String)hshValues.get("txt_dummyamount")))
				.append("~ Legal Charges =" +correctNull((String)hshValues.get("txt_legalcharge")))
				.append("~ Total Dues =" +correctNull((String)hshValues.get("txt_totaldues")))
				.append("~ Claim Settled amount =" +correctNull((String)hshValues.get("txt_claimamount")))
				.append("~ Settlement Amount =" +correctNull((String)hshValues.get("txt_settleamount")))
				.append("~ Write-off =" +correctNull((String)hshValues.get("txt_writeoff")))
				.append("~ Waiver =" +correctNull((String)hshValues.get("txt_waiver")))
				.append("~ Absorption of Expenditure =" +correctNull((String)hshValues.get("txt_absortionexp")))
				.append("~ Total Relief =" +correctNull((String)hshValues.get("txt_totalrelief")))
				.append("~ Recovery effected =" +correctNull((String)hshValues.get("txt_recoveryeffect")))
				.append("~ Balance Recovery =" +correctNull((String)hshValues.get("txt_balanceeffect")))
				.append("~ Overdue Recovery =" +correctNull((String)hshValues.get("txt_overdue")));
			}
			AuditTrial.auditLog(hshValues, "371", strAppno, sbAuditData.toString());
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateStatusNoteOts Method:--"+e.getMessage());
		}finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				} 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in updateStatusnoteOTS"+cf.getMessage());						
			}
		}
	}
	
	public HashMap getStatusnoteOTS(HashMap hshValues)
	{ 
		HashMap hshResult=new HashMap();
		String strQuery="";
		ResultSet rs=null;
		String strAppno="";
		strAppno=Helper.correctNull((String)hshValues.get("appno"));
		if(strAppno.equalsIgnoreCase(""))
		{
			strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
		}
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_npastatusots^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("sta_appno",Helper.correctNull((String)rs.getString("sta_appno")));
				//hshResult.put("sta_month",Helper.correctNull((String)rs.getString("sta_month")));
				//hshResult.put("sta_year",Helper.correctNull((String)rs.getString("sta_year")));
				hshResult.put("sta_ots",Helper.correctNull((String)rs.getString("sta_ots")));
				hshResult.put("sta_otspossible",Helper.correctNull((String)rs.getString("sta_otspossible")));
				hshResult.put("sta_details",Helper.correctNull((String)rs.getString("sta_details")));
				hshResult.put("sta_measures",Helper.correctNull((String)rs.getString("sta_measures")));
				hshResult.put("sta_sanctiondate",Helper.correctNull((String)rs.getString("sta_sanctiondate")));
				hshResult.put("sta_sanctionauth",Helper.correctNull((String)rs.getString("sta_sanctionauth")));
				hshResult.put("sta_pwoamount",Helper.correctNull((String)rs.getString("sta_pwoamount")));
				hshResult.put("sta_dummyamount",Helper.correctNull((String)rs.getString("sta_dummyamount")));
				hshResult.put("sta_legalcharge",Helper.correctNull((String)rs.getString("sta_legalcharge")));
				hshResult.put("sta_totaldues",Helper.correctNull((String)rs.getString("sta_totaldues")));
				hshResult.put("sta_claimamount",Helper.correctNull((String)rs.getString("sta_claimamount")));
				hshResult.put("sta_settleamount",Helper.correctNull((String)rs.getString("sta_settleamount")));
				hshResult.put("sta_writeoff",Helper.correctNull((String)rs.getString("sta_writeoff")));
				hshResult.put("sta_waiver",Helper.correctNull((String)rs.getString("sta_waiver")));
				hshResult.put("sta_absortion",Helper.correctNull((String)rs.getString("sta_absortion")));
				hshResult.put("sta_totalrelief",Helper.correctNull((String)rs.getString("sta_totalrelief")));
				hshResult.put("sta_recoveryeffect",Helper.correctNull((String)rs.getString("sta_recoveryeffect")));
				hshResult.put("sta_balanceeffect",Helper.correctNull((String)rs.getString("sta_balanceeffect")));
				hshResult.put("sta_overdues",Helper.correctNull((String)rs.getString("sta_overdues")));
				hshResult.put("AuditFlag", "Y");
			}
			else
			{
				hshResult.put("AuditFlag", "N");
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getStatusnoteOTS"+e.getMessage());
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
					throw new EJBException("Error while Closing the Connection"+e.getMessage());
			}
		}
		return hshResult;
	}
	
public void updateStatusNoteSarfaesia(HashMap hshValues)
{
	HashMap hshQuery=null;
	HashMap hshQueryValues=null;
	ResultSet rs=null;
	ArrayList arrValues=null;
	String strAppno="";
	strAppno=Helper.correctNull((String)hshValues.get("appno"));
	if(strAppno.equalsIgnoreCase(""))
	{
		strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
	}
	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
	
	String strUndersarfaesia=Helper.correctNull((String)hshValues.get("sel_undersarfaesia"));
	String strDemandnoticedate=Helper.correctNull((String)hshValues.get("txt_demandnoticedate"));
	String strPostionnotice=Helper.correctNull((String)hshValues.get("sel_postionnotice"));
	String strNotpositionreason=Helper.correctNull((String)hshValues.get("txt_notpositionreason"));
	String strPositionnoticedate=Helper.correctNull((String)hshValues.get("txt_positionnoticedate"));
	String strPositiontaken=Helper.correctNull((String)hshValues.get("sel_positiontaken"));
	String strApproached=Helper.correctNull((String)hshValues.get("sel_approached"));
	String strDetailofapplication=Helper.correctNull((String)hshValues.get("txt_detailofapplication"));
	String strNottakingposition=Helper.correctNull((String)hshValues.get("txt_nottakingposition"));
	
	
	String strSecurity[]=null;
	String strValuationdate[]=null;
	String strValuationamount[]=null;
	String strDateofsale[]=null;
	String strDateofauction[]=null;
	String strSaleamount[]=null;
	String strSaleconfirmationdate[]=null;
	String strAppropriatedacountdate[]=null;
	
	
	
	if(hshValues.get("txt_security") instanceof String)
	{
		strSecurity=new String[1];
		strSecurity[0]=(String)hshValues.get("txt_security");
	}
	else
	{
		strSecurity=(String[])hshValues.get("txt_security");
	}
	if(hshValues.get("txt_valuationdate") instanceof String)
	{
		strValuationdate=new String[1];	
		strValuationdate[0]=(String)hshValues.get("txt_valuationdate");
	}
	else
	{
		strValuationdate=(String[])hshValues.get("txt_valuationdate");
	}
	if(hshValues.get("txt_valuationamount") instanceof String)
	{
		strValuationamount=new String[1];
		strValuationamount[0]=(String)hshValues.get("txt_valuationamount");
	}
	else
	{
		strValuationamount=(String[])hshValues.get("txt_valuationamount");
	}
	if(hshValues.get("txt_dateofsale") instanceof String)
	{
		strDateofsale=new String[1];
		strDateofsale[0]=(String)hshValues.get("txt_dateofsale");
	}
	else
	{
		strDateofsale=(String[])hshValues.get("txt_dateofsale");
	}
	if(hshValues.get("txt_dateofauction") instanceof String)
	{
		strDateofauction=new String[1];
		strDateofauction[0]=(String)hshValues.get("txt_dateofauction");
	}
	else
	{
		strDateofauction=(String[])hshValues.get("txt_dateofauction");
	}
	if(hshValues.get("txt_saleamount") instanceof String)
	{
		strSaleamount=new String[1];
		strSaleamount[0]=(String)hshValues.get("txt_saleamount");
	}
	else
	{
		strSaleamount=(String[])hshValues.get("txt_saleamount");
	}
	if(hshValues.get("txt_saleconfirmationdate") instanceof String)
	{
		strSaleconfirmationdate=new String[1];
		strSaleconfirmationdate[0]=(String)hshValues.get("txt_saleconfirmationdate");
	}
	else
	{
		strSaleconfirmationdate=(String[])hshValues.get("txt_saleconfirmationdate");
	}
	
	
	if(hshValues.get("txt_appropriatedacountdate") instanceof String)
	{
		strAppropriatedacountdate=new String[1];
		strAppropriatedacountdate[0]=(String)hshValues.get("txt_appropriatedacountdate");
	}
	else
	{
		strAppropriatedacountdate=(String[])hshValues.get("txt_appropriatedacountdate");
	}
	
	try
	{
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQueryValues=new HashMap();	
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_npastatussarfaesia1");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_npastatussarfaesia2");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","ins_npastatussarfaesia1");
			arrValues.add(strAppno);
			arrValues.add(strUndersarfaesia);
			arrValues.add(strDemandnoticedate);
			arrValues.add(strPostionnotice);
			arrValues.add(strNotpositionreason);
			arrValues.add(strPositionnoticedate);
			arrValues.add(strPositiontaken);
			arrValues.add(strApproached);
			arrValues.add(strDetailofapplication);
			arrValues.add(strNottakingposition);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			for(int i=0; strSecurity!=null && i< strSecurity.length;i++)
			{
				if(!strSecurity[i].equals(""))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_npastatussarfaesia2");
					arrValues.add(strAppno);
					arrValues.add(Integer.toString(i+1));
					arrValues.add(strSecurity[i]);
					arrValues.add(strValuationdate[i]);
					arrValues.add(strValuationamount[i]);
					arrValues.add(strDateofsale[i]);
					arrValues.add(strDateofauction[i]);
					arrValues.add(strSaleamount[i]);
					arrValues.add(strSaleconfirmationdate[i]);
					arrValues.add(strAppropriatedacountdate[i]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}	
			}
			
		}
		else if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues=new HashMap();	
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_npastatussarfaesia1");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","del_npastatussarfaesia2");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQueryValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		StringBuilder sbAuditData=new StringBuilder();
		String strAuditflag = correctNull((String)hshValues.get("hidAuditFlag"));
		if(strAuditflag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete")){
			hshValues.put("strAction", "update");
		}else if(strAuditflag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
			hshValues.put("strAction", "insert");
		}
		if(strAction.equalsIgnoreCase("insert"))
		{
			sbAuditData
			.append("Action Under sarfaesia =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_undersarfaesia"))))
			.append("~ Date of Demand notice =" +correctNull((String)hshValues.get("txt_demandnoticedate")))
			.append("~ Whether possession Notice given =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_postionnotice"))))
			.append("~ Date of possession Notice =" +correctNull((String)hshValues.get("txt_positionnoticedate")))
			.append("~ Whether possession Taken =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_positiontaken"))));
			if(correctNull((String)hshValues.get("sel_positiontaken")).equalsIgnoreCase("1")){
				sbAuditData
				.append("~ Date of Sale Notice =" +correctNull((String)hshValues.get("txt_dateofsale")))
				.append("~ Date of Auction =" +correctNull((String)hshValues.get("txt_dateofauction")))
				.append("~ Sale Amount =" +correctNull((String)hshValues.get("txt_saleamount")))
				.append("~ Date of Sale Confirmation =" +correctNull((String)hshValues.get("txt_saleconfirmationdate")))
				.append("~ Date sale amount appropriated =" +correctNull((String)hshValues.get("txt_appropriatedacountdate")));
			}else if(correctNull((String)hshValues.get("sel_positiontaken")).equalsIgnoreCase("2")){
			sbAuditData
			.append("~ Whether DM / CMM approached =" +ApplicantParams.getApplicantParams("OTSCOMMENTS", correctNull((String)hshValues.get("sel_approached"))));
			}
		}
		AuditTrial.auditLog(hshValues, "372", strAppno, sbAuditData.toString());
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateStatusNoteSarfaesia:--"+e.getMessage()); 
	}finally
	{
		try
		{
			if(rs != null)
			{
				rs.close();
			} 
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing in updateStatusNoteSarfaesia"+cf.getMessage());						
		}
	}
}
public HashMap getStatusNoteSarfaesia(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	String strQuery="";
	ResultSet rs=null;
	String strAppno="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=null;
	boolean flag=false;
	strAppno=Helper.correctNull((String)hshValues.get("appno"));
	if(strAppno.equalsIgnoreCase(""))
	{
		strAppno=Helper.correctNull((String)hshValues.get("npa_appno"));
	}
	try
	{
		strQuery=SQLParser.getSqlQuery("sel_npastatussarfaesia1^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshResult.put("sta_appno",Helper.correctNull((String)rs.getString("sta_appno")));
			hshResult.put("sta_undersarfaesia",Helper.correctNull((String)rs.getString("sta_undersarfaesia")));
			hshResult.put("sta_demandnoticedate",Helper.correctNull((String)rs.getString("sta_demandnoticedate")));
			hshResult.put("sta_positionnotice",Helper.correctNull((String)rs.getString("sta_positionnotice")));
			hshResult.put("sta_notpositionreason",Helper.correctNull((String)rs.getString("sta_notpositionreason")));
			hshResult.put("sta_positionnoticedate",Helper.correctNull((String)rs.getString("sta_positionnoticedate")));
			hshResult.put("sta_positiontaken",Helper.correctNull((String)rs.getString("sta_positiontaken")));
			hshResult.put("sta_approached",Helper.correctNull((String)rs.getString("sta_approached")));
			hshResult.put("sta_detailsofapplication",Helper.correctNull((String)rs.getString("sta_detailsofapplication")));
			hshResult.put("sta_nottakingposition",Helper.correctNull((String)rs.getString("sta_nottakingposition")));
			hshResult.put("AuditFlag", "Y");
		}
		else{
			hshResult.put("AuditFlag", "N");
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("sel_npastatussarfaesia2^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		flag=rs.next();
		if(flag)
		{
			do
			{
				arrCol=new ArrayList();	
				arrCol.add(Helper.correctNull((String)rs.getString("sta_security")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_valuationdate")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_valuationamount")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_dateofsale")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_dateofauction")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_saleamount")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_saleconfirmationdate")));
				arrCol.add(Helper.correctNull((String)rs.getString("sta_appropriatedaccountdate")));
				arrRow.add(arrCol);
			}while(rs.next());
		}
		else
		{
			if(rs!=null)
			{
				rs.close();
			}
		
			strQuery=SQLParser.getSqlQuery("sel_npasecuritiescoltype^"+strAppno+"^"+"STAT");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();	
				arrCol.add(Helper.correctNull((String)rs.getString("SECU_NATURE")));
				arrCol.add(Helper.correctNull((String)rs.getString("SECU_RENEW_VALUEDATE")));
				arrCol.add(Helper.correctNull((String)rs.getString("SECU_RENEW_VALUEAMOUNT")));
				arrCol.add("");
				arrCol.add("");
				arrCol.add("");
				arrCol.add("");
				arrCol.add("");
				arrRow.add(arrCol);
			}
		}
		hshResult.put("arrRow",arrRow);
	}
	catch(Exception e)
	{
		throw new EJBException("Error in getStatusNoteSarfaesia"+e.getMessage());
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
				throw new EJBException("Error while Closing the Connection"+e.getMessage());
		}
	}
	return hshResult;

}
	
}