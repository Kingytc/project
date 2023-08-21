package com.sai.laps.ejb.monitoringalert;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "MonitoringAlertBean", mappedName = "MonitoringAlertHome")
@Remote (MonitoringAlertRemote.class)
public class MonitoringAlertBean extends BeanAdapter
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	


	static Logger log=Logger.getLogger(MonitoringAlertBean.class);	

	
	public HashMap getData(HashMap hshRequestValues) 
	{
		ResultSet rs = null;	
		
		HashMap hshRecord = null;
		ArrayList arr = null;
		String strQuery="";
					
		try
		{
			hshRecord = new HashMap();
			arr =  new ArrayList();
			strQuery = SQLParser.getSqlQuery("glpoption");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString(1)));	
				arr.add(Helper.correctNull(rs.getString(2)));	
				arr.add(Helper.correctNull(rs.getString(3)));	
				arr.add(Helper.correctNull(rs.getString(4)));	
				arr.add(Helper.correctNull(rs.getString(5)));	
				arr.add(Helper.correctNull(rs.getString(6)));	
			}
			hshRecord.put("arr",arr);
				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
	
	public HashMap getAlertData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strAssetclassification="";
		String strAlertfor="";
		try{
			
			strAssetclassification=correctNull((String)hshValues.get("hidAsset"));
			strAlertfor=correctNull((String)hshValues.get("hidalertfor"));
			if(strAssetclassification.equals("005"))
			{
				hshRecord=getGeneral(hshValues);
			}
			else if(strAlertfor.equals("001"))
			{
				hshRecord=getLoanDefaultData(hshValues);
			}
			else if(strAlertfor.equals("003"))
			{			
				hshRecord=nonRenewal(hshValues);
			}
			else if(strAlertfor.equals("004"))
			{
				hshRecord=noninspectionofsecurities(hshValues);
			}
			else if(strAlertfor.equals("005"))
			{
				hshRecord=getDocumentationdeficiency(hshValues);
			}
			else if(strAlertfor.equals("006"))
			{
				hshRecord=otherdefaults(hshValues);
			}
		}
		catch(Exception ex)
		{
			throw new EJBException ("Error in getData :: "+ex.toString());
		}
		return hshRecord;
	}

	public HashMap getLoanDefaultData (HashMap hshValues) 
	{
		HashMap hshRecord =new HashMap();
		
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		
		ResultSet rs= null;
		ResultSet rs1=null;
		String strQuery = "";
		String strAsset="";
		String strAlertfor="";
		String strorgcode="";
		int cnt1=0,cnt2=0,cnt3=0,cnt4=0,cnt5=0,cnt6=0,cnt7=0,cnt8=0,cnttotal=0;
		try
		{
			strAlertfor = correctNull((String) hshValues.get("hidalertfor"));
			strAsset = correctNull((String) hshValues.get("hidAsset"));
			strorgcode = correctNull((String) hshValues.get("hidorg_code"));
			
			
			if (strAlertfor.equalsIgnoreCase("001") && strAsset.equalsIgnoreCase("001")) 
			{
				// Standard Alerts
				// Standard Alerts for Interest/Installment Alert for Standard
				strQuery = SQLParser.getSqlQuery("getloandefaultstandard^"+ strAlertfor + "^" + strAsset + "^" + ">=" + "^"	+ "<=" + "^" + strorgcode);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					arrValuesCol = new ArrayList();

					arrValuesCol.add(correctNull((String) rs.getString("fund_accno")));
					arrValuesCol.add(correctNull((String) rs.getString("fund_custid")));
					arrValuesCol.add("Overdue less than 30 days");
					arrValuesCol.add("DUEADJ");
					arrValuesCol.add(correctNull((String) rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String) rs.getString("FUND_OVERDUETYPE")));
					arrValuesCol.add(correctNull((String) rs.getString("FUND_OVERDUEAMT")));
					arrValuesCol.add(correctNull((String) rs.getString("fund_sancamt")));
					arrValuesRow.add(arrValuesCol);
					if (rs.isLast()) {
						cnt1 = rs.getRow();
					}

				}
			} 
			else if (!strAsset.equalsIgnoreCase("001")&& strAlertfor.equalsIgnoreCase("001")) 
			{
				strQuery = SQLParser.getSqlQuery("getloandefault^"+ strAlertfor + "^" + strAsset + "^" + ">=" + "^"	+ "<=" + "^" + strorgcode);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next()) {
					arrValuesCol = new ArrayList();

					arrValuesCol.add(correctNull((String) rs.getString("fund_accno")));
					arrValuesCol.add(correctNull((String) rs.getString("fund_custid")));

					if (correctNull(rs.getString("FUND_SCHEMECODE")).equals("DL021") || correctNull(rs.getString("FUND_SCHEMECODE")).equals("DL022")) 
					{
						arrValuesCol.add("Packing Credit");
						arrValuesCol.add("Letter-1");
					}
					else 
					{
						arrValuesCol.add("Installment Overdue");
						arrValuesCol.add("DUEADJ");
					}

					arrValuesCol.add(correctNull((String) rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String) rs.getString("FUND_OVERDUETYPE")));
					arrValuesCol.add(correctNull((String) rs.getString("FUND_OVERDUEAMT")));
					arrValuesCol.add(correctNull((String) rs.getString("fund_sancamt")));
					arrValuesRow.add(arrValuesCol);
					if (rs.isLast()) 
					{
						cnt1 = rs.getRow();
					}
				}
			}

			if (rs != null)
				rs.close();
			// Dormant Account
			strQuery = SQLParser.getSqlQuery("getloandefaultsfordormant^"
					+ strAlertfor + "^" + strAsset + "^" + ">=" + "^" + "<="
					+ "^" + strorgcode);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				arrValuesCol = new ArrayList();

				arrValuesCol.add(correctNull((String) rs.getString("fund_accno")));
				arrValuesCol.add(correctNull((String) rs.getString("fund_custid")));
				arrValuesCol.add("Dormant Account");
				arrValuesCol.add("DUEADJ");//
				arrValuesCol.add(correctNull((String) rs.getString("personal_custname")));
				arrValuesCol.add(correctNull((String) rs.getString("FUND_OVERDUETYPE")));
				arrValuesCol.add(correctNull((String) rs.getString("fund_overdueamt")));
				arrValuesCol.add(correctNull((String) rs.getString("fund_sancamt")));
				
				arrValuesRow.add(arrValuesCol);
				if (rs.isLast()) {
					cnt2 = rs.getRow();
				}
			}

			if (rs != null)
				rs.close();
			// Alert for Bills

			strQuery = SQLParser.getSqlQuery("getloandefaultforbills^" + ">="
					+ "^" + "<=" + "^" + strAlertfor + "^" + strAsset + "^"
					+ strorgcode);
			rs1 = DBUtils.executeQuery(strQuery);

			while (rs1.next()) {
				arrValuesCol = new ArrayList();

				arrValuesCol.add(correctNull((String) rs1.getString("bills_accno")));
				arrValuesCol.add(correctNull((String) rs1.getString("BILLS_CBSID")));
				if (strAsset.equalsIgnoreCase("001")) {
					arrValuesCol.add("Bills Purchased ");
				} else {
					arrValuesCol.add("Bills Purchased and not realized");
				}
				arrValuesCol.add("BILOVR");
				arrValuesCol.add(correctNull((String) rs1.getString("personal_custname")));
				arrValuesCol.add(correctNull((String) rs1.getString("bills_billno")));
				arrValuesCol.add(correctNull((String) rs1.getString("billduedate")));
				arrValuesCol.add(correctNull((String) rs1.getString("BILLS_BILLAMT")));
				arrValuesCol.add(correctNull((String) rs1.getString("bills_accflag")));
				arrValuesCol.add(correctNull((String) rs1.getString("bills_overdueamt")));
				arrValuesCol.add(correctNull((String) rs1.getString("limit_sanctamt")));
				arrValuesRow.add(arrValuesCol);
				if (rs1.isLast()) {
					cnt3 = rs1.getRow();
				}
			}

			// if(rs!=null)rs.close();
			// //Alert for Excess in WC
			//			
			// strQuery =
			// SQLParser.getSqlQuery("getloandefaultforExcessinWC^"+strAlertfor+"^"+strAsset+"^"+">"+"^"+">="+"^"+"<="+"^"+strorgcode);
			// rs=DBUtils.executeQuery(strQuery);
			// while(rs.next())
			// {
			// arrValuesCol=new ArrayList();
			//			
			// arrValuesCol.add(correctNull((String)rs.getString("fund_accno")));
			// arrValuesCol.add(correctNull((String)rs.getString("fund_custid")));
			// if(strAsset.equalsIgnoreCase("001"))
			// {
			// arrValuesCol.add("Excess in Working Capital/Non-adjustment of
			// Adhoc-limit less than 30 days");
			// }
			// else
			// {
			// arrValuesCol.add("Excess in Working Capital");
			// }
			// arrValuesCol.add("");
			// arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
			// arrValuesCol.add(correctNull((String)rs.getString("FUND_OVERDUETYPE")));
			// arrValuesRow.add(arrValuesCol);
			// if(rs.isLast()){
			// cnt5=rs.getRow();
			// }
			// }
			//
			// if(rs!=null)rs.close();
			// //Alert for Interest Overdue for Working Capital
			// strQuery =
			// SQLParser.getSqlQuery("getloandefaultforExcessinWCoverdue^"+strAlertfor+"^"+strAsset+"^"+">"+"^"+">="+"^"+"<="+"^"+strorgcode);
			// rs=DBUtils.executeQuery(strQuery);
			//					
			// while(rs.next())
			// {
			// arrValuesCol=new ArrayList();
			//				
			// arrValuesCol.add(correctNull((String)rs.getString("fund_accno")));
			// arrValuesCol.add(correctNull((String)rs.getString("fund_custid")));
			// if(strAsset.equalsIgnoreCase("001"))
			// {
			// arrValuesCol.add("Interest overdue less than 30 days");
			// }
			// else
			// {
			// arrValuesCol.add("Interest overdue");
			// }
			// arrValuesCol.add("");
			// arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
			// arrValuesCol.add(correctNull((String)rs.getString("FUND_OVERDUETYPE")));
			// arrValuesRow.add(arrValuesCol);
			// if(rs.isLast()){
			// cnt6=rs.getRow();
			// }
			// }

			// Alert for Non-fund based

			String strAlertfornonfund = "002";
			strQuery = SQLParser.getSqlQuery("getloandefaultforNFB^"
					+ strAlertfornonfund + "^" + strAsset + "^" + ">=" + "^"
					+ "<=" + "^" + strorgcode);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next()) {
				arrValuesCol = new ArrayList();

				arrValuesCol.add(correctNull((String) rs
						.getString("fund_accno")));
				arrValuesCol.add(correctNull((String) rs
						.getString("fund_custid")));
				if (correctNull(rs.getString("FUND_SCHEMECODE"))
						.equals("DL004")) {
					// Alert for Bank Guarantee
					arrValuesCol
							.add("Invoked and not-adjusted Bank Guarantee / DPGL");
					arrValuesCol.add("GUAINV");
				} else {
					// Letter of Credit
					arrValuesCol
							.add("Devolved and not-adjusted Letter of Credit");
					arrValuesCol.add("LCDEV");
				}
				arrValuesCol.add(correctNull((String) rs
						.getString("personal_custname")));
				arrValuesCol.add(correctNull((String) rs
						.getString("FUND_OVERDUETYPE")));
				arrValuesCol.add(correctNull((String) rs
						.getString("fund_overdueamt")));
				arrValuesCol.add(correctNull((String) rs
						.getString("fund_sancamt")));
				arrValuesRow.add(arrValuesCol);
				if (rs.isLast()) {
					cnt7 = rs.getRow();
				}
			}

			hshRecord.put("arrAlerts", arrValuesRow);

			cnttotal = cnt1 + cnt2 + cnt3 + cnt4 + cnt5 + cnt6 + cnt7 + cnt8;
			hshRecord.put("arrAlerts", arrValuesRow);
			hshRecord.put("defaultcount", Integer.toString(cnttotal));

			/*
			 * if(rs!=null)rs.close(); //Alert for Bank Guarantee strQuery =
			 * SQLParser.getSqlQuery("getloandefaultforGua^"+strAlertfornonfund+"^"+strAsset+"^"+">"+"^"+"<="+"^"+strorgcode);
			 * rs=DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { arrValuesCol=new ArrayList();
			 * 
			 * arrValuesCol.add(correctNull((String)rs.getString("fund_accno")));
			 * arrValuesCol.add(correctNull((String)rs.getString("fund_custid")));
			 * arrValuesCol.add("Invoked and not-adjusted Bank Guarantee /
			 * DPGL"); arrValuesCol.add("GUAINV");
			 * arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
			 * arrValuesCol.add(correctNull((String)rs.getString("FUND_OVERDUETYPE")));
			 * arrValuesRow.add(arrValuesCol); if(rs.isLast()){
			 * cnt8=rs.getRow(); } }
			 * 
			 * 
			 * if(rs!=null)rs.close();
			 * 
			 * //Alert for Packing Credit
			 * 
			 * strQuery =
			 * SQLParser.getSqlQuery("getloandefaultsforpc^"+strAlertfor+"^"+strAsset+"^"+">"+"^"+"<="+"^"+strorgcode);
			 * rs=DBUtils.executeQuery(strQuery);
			 * 
			 * while(rs.next()) { arrValuesCol=new ArrayList();
			 * arrValuesCol.add(correctNull((String)rs.getString("fund_accno")));
			 * arrValuesCol.add(correctNull((String)rs.getString("fund_custid")));
			 * 
			 * arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
			 * arrValuesCol.add(correctNull((String)rs.getString("FUND_OVERDUETYPE")));
			 * arrValuesRow.add(arrValuesCol); if(rs.isLast()){
			 * cnt4=rs.getRow(); } }
			 */
			hshRecord.put("OrgCode", strorgcode);
			hshRecord.put("strAlertfor",strAlertfor);
			hshRecord.put("strAsset",strAsset);
		}
		catch(Exception ex)
		{
			throw new EJBException ("Error in getLoanDefaultData :: "+ex.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ex)
			{
				throw new EJBException("Error in closing connection in getLoanDefaultData :: "+ex.toString());
			}
		}
		return hshRecord;
	}

	public HashMap nonRenewal(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		String strQuery="";
		String strAlertfor="";
		String strAsset="";
		String strorgcode="";int cnt1=0;
		try
		{
			strAlertfor=correctNull((String)hshValues.get("hidalertfor"));
			strAsset=correctNull((String)hshValues.get("hidAsset"));
			strorgcode=correctNull((String)hshValues.get("hidorg_code"));
			//Standard Alert 
			/*if(strAlertfor.equalsIgnoreCase("003") && strAsset.equalsIgnoreCase("001"))
			{
				//Standard Alerts
				//Standard Alerts for Non-Renewal of Limits
				strQuery = SQLParser.getSqlQuery("getStandarddefaulterforlimit^"+">"+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
				
				while(rs.next())
				{
					arrValuesCol=new ArrayList();
					arrValuesCol.add(correctNull((String)rs.getString("limit_cutaccno")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
					arrValuesCol.add("No Default for Renewal of Limits ");
					arrValuesCol.add("");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("LIMIT_ACCFLAG")));
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnt1=rs.getRow();
					}
					
				}
				hshRecord.put("arrAlerts",arrValuesRow);
				hshRecord.put("nonrenewalcount",Integer.toString(cnt1));
			}
			if(strAsset.equalsIgnoreCase("001")&& strAlertfor.equalsIgnoreCase("003"))
			{*/
				//EAS-I/EAS-II/SMA alerts
				if(rs!=null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("getalertfornonrenewal^"+strAlertfor+"^"+strAsset+"^"+">="+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrValuesCol= new ArrayList();	
					
					arrValuesCol.add(correctNull((String)rs.getString("limit_cutaccno")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
					if(strAsset.equalsIgnoreCase("001")&& strAlertfor.equalsIgnoreCase("003"))
					{
						arrValuesCol.add("No Default for Renewal of Limits ");
						arrValuesCol.add("");
					}
					else
					{
						arrValuesCol.add("Non Renewal of Limits");
						arrValuesCol.add("LIMREN");
					}
					
					arrValuesCol.add(rs.getString("personal_custname"));
					arrValuesCol.add(correctNull((String)rs.getString("LIMIT_ACCFLAG")));
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnt1=rs.getRow();
					}
				}
			
				hshRecord.put("arrAlerts",arrValuesRow);
				hshRecord.put("defaultcount",Integer.toString(cnt1));
				hshRecord.put("OrgCode",strorgcode);
				hshRecord.put("strAlertfor",strAlertfor);
				hshRecord.put("strAsset",strAsset);
			//}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in nonRenewal Method :: "+e.getMessage());
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
				throw new EJBException("Error in Closing Connection in nonRenewal :: "+e.toString() ); 	
			}
		}
		return hshRecord;
	}
	
	public HashMap noninspectionofsecurities(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		String strQuery="";
		String strAlertfor="";
		String strAsset="";
		String strorgcode="";int cnt1=0;
		try
		{
			strAlertfor=correctNull((String)hshValues.get("hidalertfor"));
			strAsset=correctNull((String)hshValues.get("hidAsset"));
			strorgcode=correctNull((String)hshValues.get("hidorg_code"));
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getalertfornoninspectsecurities^"+strAlertfor+"^"+strAsset+"^"+">="+"^"+"<="+"^"+strorgcode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrValuesCol= new ArrayList();	
				
				arrValuesCol.add(correctNull((String)rs.getString("limit_cutaccno")));
				arrValuesCol.add(correctNull((String)rs.getString("mmr_cbsid")));
				arrValuesCol.add("Non-Inspection of securities");
				arrValuesCol.add("Ltr-1");
				arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
				arrValuesCol.add(correctNull((String)rs.getString("limit_accflag")));
				arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
				arrValuesRow.add(arrValuesCol);
				if(rs.isLast())
				{
					cnt1=rs.getRow();
				}
			}
			
			hshRecord.put("arrAlerts",arrValuesRow);
			hshRecord.put("defaultcount",Integer.toString(cnt1));
			hshRecord.put("OrgCode",strorgcode);
			
			hshRecord.put("strAlertfor",strAlertfor);
			hshRecord.put("strAsset",strAsset);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in nonRenewal Method :: "+e.getMessage());
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
				throw new EJBException("Error in Closing Connection in nonRenewal :: "+e.toString() ); 	
			}
		}
		return hshRecord;
	}
	
	public HashMap getDocumentationdeficiency(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		String strAlertfor="";
		String strAsset="";
		String strorgcode="";int cnt1=0,cnt2=0,cnt3=0,cnt4=0,cnt5=0,cnt6=0,cnttotal=0;
		try
		{
				strorgcode=correctNull((String)hshValues.get("hidorg_code"));
				
				strAlertfor=correctNull((String)hshValues.get("hidalertfor"));
    			strAsset=correctNull((String)hshValues.get("hidAsset"));
				//Insurance Date Expired
				if(strAsset.equalsIgnoreCase("003")&& strAlertfor.equalsIgnoreCase("005"))
				{
					strQuery=SQLParser.getSqlQuery("getdefdocumentforinsexpiredate^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
					
						arrValuesCol.add(correctNull((String)rs.getString("ins_accountno")));
						arrValuesCol.add(correctNull((String)rs.getString("ins_cbsid")));
						arrValuesCol.add("Insurance Expired");
						arrValuesCol.add("INSUR");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("ins_accflag")));
						arrValuesCol.add(correctNull((String)rs.getString("ins_srlno")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt1=rs.getRow();
						}
					}
				
					//hshRecord.put("arrAlerts",arrValuesRow);
					if(rs!=null)
					rs.close();
			
					//Adequate Insurance of assets charged
				
//					strQuery=SQLParser.getSqlQuery("getdefdocumentforinsasset^"+"<"+"^"+strorgcode);
//					rs=DBUtils.executeQuery(strQuery);
//					while(rs.next())
//					{
//						arrValuesCol=new ArrayList();
//					
//						arrValuesCol.add(correctNull((String)rs.getString("monsec_accountnumber")));
//						arrValuesCol.add(correctNull((String)rs.getString("ins_cbsid")));
//						arrValuesCol.add("Adequate Insurance of assets charged not obtained");
//						arrValuesCol.add("INSUR");
//						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
//						arrValuesCol.add(correctNull((String)rs.getString("ins_accflag")));
//						arrValuesCol.add(correctNull((String)rs.getString("ins_srlno")));
//						arrValuesRow.add(arrValuesCol);
//						if(rs.isLast()){
//						cnt2=rs.getRow();
//						}
//					}
				
					//vetting of documents
					strQuery=SQLParser.getSqlQuery("getdocumentsvetteddetails^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						
						arrValuesCol.add(correctNull((String)rs.getString("doc_accountnumber")));
						arrValuesCol.add(correctNull((String)rs.getString("doc_cbsid")));
						arrValuesCol.add("Vetting of Documents Pending");
						arrValuesCol.add("Ltr-1");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("DOC_ACCFLAG")));
						arrValuesCol.add("");
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt3=rs.getRow();}
					}

					if(rs!=null)
					rs.close();
				
					//DBC Details
					strQuery=SQLParser.getSqlQuery("getDBCdetails^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						
						arrValuesCol.add(correctNull((String)rs.getString("cbs_accno")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
						arrValuesCol.add("DBC not obtained");
						arrValuesCol.add("Ltr-1");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_accflag")));
						arrValuesCol.add("");
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt4=rs.getRow();}
					}
				
					strQuery=SQLParser.getSqlQuery("getvalueddategreaterthanthree^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						
						arrValuesCol.add(correctNull((String)rs.getString("MONSEC_ACCOUNTNUMBER")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
						arrValuesCol.add("Valuation of Property/ies > 3 Years");
						arrValuesCol.add("Ltr-1");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_accflag")));
						arrValuesCol.add("");
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt6=rs.getRow();}
					}
					hshRecord.put("arrAlerts",arrValuesRow);
					cnttotal=cnt1+cnt2+cnt3+cnt4+cnt6;
					hshRecord.put("cnttotal",Integer.toString(cnttotal));
					if(rs!=null)
					rs.close();
				}
				if(strAsset.equalsIgnoreCase("004")&& strAlertfor.equalsIgnoreCase("005"))
				{
				
					if(rs!=null)
					rs.close();
					//ROC details
					strQuery=SQLParser.getSqlQuery("getrocdetails^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
					arrValuesCol=new ArrayList();
					
					arrValuesCol.add(correctNull((String)rs.getString("limit_cutaccno")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
					arrValuesCol.add("Charge with ROC not registered");
					arrValuesCol.add("Ltr-1");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_accflag")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast()){
						cnt3=rs.getRow();}
					}
	
					//hshRecord.put("arrAlerts",arrValuesRow);
					if(rs!=null)
						rs.close();
					//Guarantor signed
					strQuery=SQLParser.getSqlQuery("getguarantordetails^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						
						arrValuesCol.add(correctNull((String)rs.getString("DOC_ACCOUNTNUMBER")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
						arrValuesCol.add("Guarantor not signed the documents");
						arrValuesCol.add("Ltr-1");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("doc_accflag")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt4=rs.getRow();}
					}
					//hshRecord.put("arrAlerts",arrValuesRow);
					if(rs!=null)
						rs.close();
					//Equitable Mortgage
					strQuery=SQLParser.getSqlQuery("getequitymortgagedetails^"+strorgcode);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						
						arrValuesCol.add(correctNull((String)rs.getString("CBS_ACCNO")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
						arrValuesCol.add("Equitable mortgage not perfected");
						arrValuesCol.add("Ltr-1");
						arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_accflag")));
						arrValuesCol.add(correctNull((String)rs.getString("limit_sanctamt")));
						arrValuesRow.add(arrValuesCol);
						if(rs.isLast()){
							cnt5=rs.getRow();
						
						}
					}
				
					cnttotal=cnt3+cnt4+cnt5;
					hshRecord.put("arrAlerts",arrValuesRow);
					hshRecord.put("defaultcount",Integer.toString(cnttotal));
					if(rs!=null)rs.close();
					//Security of Document Expired
					/*strQuery = SQLParser.getSqlQuery("getStandarddefaulterfordoc^"+">"+"^"+">="+"^"+strscode);
					rs=DBUtils.executeQuery(strQuery);
					
					while(rs.next())
					{
						arrValuesCol=new ArrayList();
						arrValuesCol.add(correctNull((String)rs.getString("doc_accountnumber"));
						arrValuesCol.add(correctNull((String)rs.getString("doc_cbsid"));
						arrValuesCol.add("Security Document Date Expired");
						arrValuesCol.add("SECDOC");
						//arrValuesCol.add("");
						arrValuesRow.add(arrValuesCol);
						
					}
					hshRecord.put("arrAlerts",arrValuesRow);*/
				}
				hshRecord.put("OrgCode",strorgcode);
				hshRecord.put("strAlertfor",strAlertfor);
				hshRecord.put("strAsset",strAsset);
		}
		catch(Exception ae)
		{
			throw new EJBException("Error in getDocumentationdeficiency "+ae.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception ae1)
			{
				throw new EJBException("Error in Closing Connection "+ ae1.toString());
			}
		}
		
		
		return hshRecord;
		
	}

	public HashMap otherdefaults(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		String strQuery="";
		//String strAlertfor="";
		String strAsset="";
		String strdaysfrom="";
		String strdaysto="";
		String strAlertfor  = "";
		String strorgcode="";int cnt1=0,cnt2=0,cnttotal=0;
		try
		{
			strAlertfor = correctNull((String) hshValues.get("hidalertfor"));
			strAsset = correctNull((String) hshValues.get("hidAsset"));
			strorgcode=correctNull((String)hshValues.get("hidorg_code"));
			
			if(strAsset.equalsIgnoreCase("003"))
			{
				strdaysfrom="30";
				strdaysto="60";
			}
			else
			{
				strdaysfrom="60";
				strdaysto="90";
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getotherdefaultsforstockandbookdebts^"+">= "+strdaysfrom+"^"+"<= "+strdaysto+"^"+strorgcode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrValuesCol= new ArrayList();	
				
				arrValuesCol.add(correctNull((String)rs.getString("MSU_ACCTNO")));
				arrValuesCol.add(correctNull((String)rs.getString("MSU_CUSTID")));
				if(correctNull((String)rs.getString("msu_secu_code")).equalsIgnoreCase("107"))
				{
					arrValuesCol.add("Non-Submission of Stock Statement");
					arrValuesCol.add("STKNT");
				}
				else
				{
					arrValuesCol.add("Non-Submission of BookDebt Statement");	
					arrValuesCol.add("BKDNT");
				}
			//	arrValuesCol.add("STKBD");
				arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
				arrValuesCol.add(correctNull((String)rs.getString("msu_secu_date")));
				arrValuesCol.add(correctNull((String)rs.getString("msu_secu_code")));
				arrValuesCol.add(correctNull((String)rs.getString("MSU_ACCFLAG")));
				arrValuesRow.add(arrValuesCol);
				if(rs.isLast()){
					cnttotal=rs.getRow();
				}
			}
			
			hshRecord.put("arrAlerts",arrValuesRow);
			hshRecord.put("defaultcount",Integer.toString(cnttotal));
			hshRecord.put("OrgCode",strorgcode);
			hshRecord.put("strAlertfor",strAlertfor);
			hshRecord.put("strAsset",strAsset);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in Otherdefaults :: "+e.getMessage());
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
				throw new EJBException("Error in Closing Connection in Otherdefaults :: "+e.toString() ); 	
			}
		}
		return hshRecord;
		
	}	
	private HashMap getGeneral(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrValuesRow= new ArrayList();
		ArrayList arrValuesCol= new ArrayList();
		String strQuery="";
		String strorgcode="";
		String strAlertfor="";
		String strAsset = "";
		int cnttotal=0;
		
		try
		{
			strorgcode=correctNull((String)hshValues.get("hidorg_code"));
			strAlertfor=correctNull((String)hshValues.get("hidalertfor"));
			strAsset = correctNull((String) hshValues.get("hidAsset"));
			
			if(strAlertfor.equals("001"))
			{
				//general alert for Document expiry date
				strQuery = SQLParser.getSqlQuery("getStandarddefaulterfordoc^"+">"+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
			
				while(rs.next())
				{
					arrValuesCol=new ArrayList();
					arrValuesCol.add(correctNull((String)rs.getString("doc_accountnumber")));
					arrValuesCol.add(correctNull((String)rs.getString("doc_cbsid")));
					arrValuesCol.add("Document expiring in next three months");
					arrValuesCol.add("SECDOC");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("DOC_ACCFLAG")));
					arrValuesCol.add("");
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnttotal=cnttotal=rs.getRow();
					}
				}
			}
			else if(strAlertfor.equals("002"))
			{
				if(rs!=null)rs.close();
				//General alert for Difference in location
				strQuery=SQLParser.getSqlQuery("getotherdefaultsforstd^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrValuesCol= new ArrayList();	
				
					arrValuesCol.add(correctNull((String)rs.getString("MONSEC_ACCOUNTNUMBER")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
					arrValuesCol.add("Difference in Location of address in Stock and Insurance");
					arrValuesCol.add("");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("LIMIT_ACCFLAG")));
					arrValuesCol.add("");
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnttotal=cnttotal=rs.getRow();
					}
				}
			}
			else if(strAlertfor.equals("003"))
			{
				if(rs!=null)rs.close();
				//General Alerts for insurance date expired
				strQuery = SQLParser.getSqlQuery("getStandarddefaulterforins^"+">"+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
		
				while(rs.next())
				{
					arrValuesCol=new ArrayList();
				
					arrValuesCol.add(correctNull((String)rs.getString("ins_accountno")));
					arrValuesCol.add(correctNull((String)rs.getString("ins_cbsid")));
					arrValuesCol.add("Insurance expiring in next three months");
					arrValuesCol.add("INSEXP");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("INS_ACCFLAG")));
					arrValuesCol.add(correctNull((String)rs.getString("ins_srlno")));
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnttotal=cnttotal=rs.getRow();
					}
				}
			}
			else if(strAlertfor.equals("004"))
			{
				if(rs!=null)rs.close();
				//for bills under Letter of credit
				strQuery=SQLParser.getSqlQuery("getbillspaymentdueunderLC^"+">"+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrValuesCol=new ArrayList();
					arrValuesCol.add(correctNull((String)rs.getString("lc_bills_no")));
					arrValuesCol.add(correctNull((String)rs.getString("lc_cbsid")));
					arrValuesCol.add("Bills payment Due");
					arrValuesCol.add("BILDUE");
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add("");
					arrValuesCol.add("");
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnttotal=cnttotal=rs.getRow();
					}
				}
				//hshRecord.put("OrgCode",strorgcode);
			}
			else if(strAlertfor.equals("005"))
			{
				//Limit due for renewal
				if(rs!=null)rs.close();
				
				if(rs!=null)rs.close();
				//for limit renewal
				strQuery=SQLParser.getSqlQuery("getnonrenewalgeneral^"+">"+"^"+"<="+"^"+strorgcode);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrValuesCol=new ArrayList();
					arrValuesCol.add(correctNull((String)rs.getString("personal_custname")));
					arrValuesCol.add(correctNull((String)rs.getString("limit_custid")));
					arrValuesCol.add(correctNull((String)rs.getString("reviewdate")));
					arrValuesCol.add(correctNull((String)rs.getString("LIMIT_ACCFLAG")));
					arrValuesCol.add("GENREV");
					arrValuesCol.add(correctNull((String)rs.getString("revdate")));
					arrValuesCol.add(correctNull((String)rs.getString("daterev")));
					arrValuesRow.add(arrValuesCol);
					if(rs.isLast())
					{
						cnttotal=cnttotal=rs.getRow();
					}
				}
				
			}
			hshRecord.put("OrgCode",strorgcode);
			hshRecord.put("defaultcount",""+cnttotal);
			hshRecord.put("arrAlerts",arrValuesRow);
			hshRecord.put("strAlertfor",strAlertfor);
			hshRecord.put("strAsset",strAsset);
		}
		
		catch(Exception e)
		{
			throw new EJBException("Error in getGeneralAlerts:: "+e.getMessage());
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
				throw new EJBException("Error in Closing Connection in getGeneral :: "+e.toString() ); 	
			}
		}
		return hshRecord;
	}
}