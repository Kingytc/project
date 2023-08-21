package com.sai.laps.ejb.monitoringsetup; 

import java.rmi.RemoteException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "monitoringsetupBean", mappedName = "monitoringsetupHome")
@Remote (monitoringsetupRemote.class)
public class monitoringsetupBean extends BeanAdapter
{
	/**
	 * 
	 */
	static Logger log=Logger.getLogger(monitoringsetupBean.class);
	private static final long serialVersionUID = 1L;
	
	public void updateMonitoringAlerts(HashMap hshValues)
	{
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		
		ArrayList arrValues=null;
		
		String strAction="";
		String strAlertfor="";
		String strDaysfrom="";
		String strDaysto="";
		String strassettype="";
		
		int intUpdatesize=0;
		
		ResultSet rs=null;
		String strKeyId = "";
		StringBuilder sbolddata = new StringBuilder();
		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strAlertfor=Helper.correctNull((String)hshValues.get("selalertfor"));
		strDaysfrom=Helper.correctNull((String)hshValues.get("txtdaysfrom"));
		strDaysto=Helper.correctNull((String)hshValues.get("txtdaysupto"));
		strassettype=Helper.correctNull((String)hshValues.get("selassettype"));
		
		try
		{
			strKeyId = Helper.correctNull((String)hshValues.get("hidkeyid"));
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				rs = DBUtils.executeLAPSQuery("selmonitalert^"+strAlertfor+"^"+strassettype);
				if(rs.next())
				{
					sbolddata.append("~ Alert For = "+Helper.correctNull((String)hshValues.get("hid_selalertfor")));
					sbolddata.append("~ Asset Classification Type = "+Helper.correctNull((String)hshValues.get("hid_selassettype")));
					sbolddata.append("~ Days From = "+Helper.correctNull((String)rs.getString("daysfrom")));
					sbolddata.append("~ Days Upto = "+Helper.correctNull((String)rs.getString("daysupto")));
				}
				if(rs!=null)
				rs.close();
			}
			if(strAction.equalsIgnoreCase("update"))
		 	{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strassettype);
				
				hshQuery.put("strQueryId","delmonitalert");
				hshQuery.put("arrValues",arrValues);
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strDaysfrom);
				arrValues.add(strDaysto);
				arrValues.add(strassettype);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insmonitalert");
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		 	}
	
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strassettype);
				
				hshQuery.put("strQueryId","delmonitalert");
				hshQuery.put("arrValues",arrValues);
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			
			StringBuilder sbAt = new StringBuilder();
			if(!strAction.equalsIgnoreCase("delete"))
			{
			sbAt.append(" ~Alert For=").append(correctNull((String)hshValues.get("hid_selalertfor")));
			sbAt.append(" ~Asset Classification Type=").append(correctNull((String)hshValues.get("hid_selassettype")));
			sbAt.append(" ~Days From=").append(correctNull((String)hshValues.get("txtdaysfrom")));
			sbAt.append(" ~Days Upto=").append(correctNull((String)hshValues.get("txtdaysupto")));
			
			if(correctNull((String)hshValues.get("hidDelFlag")).equals("Y")){
				hshValues.put("hidAction", "update");
			}else if(correctNull((String)hshValues.get("hidDelFlag")).equals("N")){
				hshValues.put("hidAction", "insert");
			}
			}
			AuditTrial.auditNewLog(hshValues,"123",strKeyId,sbAt.toString(),sbolddata.toString());
		}
		catch(Exception e)
			{
				throw new EJBException("Connection Error in updateNpainterest"+e.getMessage());
			}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}				
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
	}

	
	public HashMap getMonitoringAlerts(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		
		ResultSet rs=null;
		String strQuery="";
		
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAlertfor=Helper.correctNull((String)hshValues.get("alertfor"));
		String strAssettype=Helper.correctNull((String)hshValues.get("assettype"));
		boolean recordflag=false;
		try
		{
			if(strAction.equalsIgnoreCase("get"))
			{
				strQuery=SQLParser.getSqlQuery("selmonitalert^"+strAlertfor+"^"+strAssettype);
				rs=DBUtils.executeQuery(strQuery);
				
				
				if(rs.next())
				{
					recordflag=true;
					hshRecord.put("daysfrom",correctNull(rs.getString("daysfrom")));
					hshRecord.put("daysupto",correctNull(rs.getString("daysupto")));
				}
			}
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
		}
		catch (Exception e)
		{
			throw new EJBException("Connection Error in getMonitoringAlerts :: "+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
			}
			catch (Exception e1)
			{
				log.error("error occured in closing connection in getMonitoringAlerts :: "+e1.toString());
			}
		}
		return hshRecord;
		
	}
	
	
	
	
	
	
//	public HashMap updateMonthlyMonitorBorrowerData(HashMap hsh) 
//	{
//		
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		
//		ResultSet rs=null;
//		HashMap hshQuery ;
//		ArrayList arrValues ;
//		String strBid="54",strDate="";
//		int intValue = 0;
//		
//		String facdesc="";
//		String FB="0.00";
//		
//		
//		try
//		{
//			
//			strBid=correctNull((String)hsh.get("bid"));
//			int intUpdatesize=0;
//			
//			//String snolength = correctNull((String)hsh.get("snolength"));
//			int snovalue=1;//Integer.parseInt(snolength);
//			
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","del_monthlylimitfacility");
//			//arr.add(strBid);
//		
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);	
//			
//			
//			
//			hshquery = new HashMap();
//			
//		
//			String []headid =null;
//			String []chid =null;
//			String []outstand =null;
//			String []endamount=null;
//			String []ageoverdue = null;
//			String []reasonsutil =null;
//			String []outstandNFB=null;
//			String []dpamount=null;
//			String []debitcurrent = null;
//			String []currentmonth =null;
//			String []cumulative=null;
//
//			String headid1="";
//			String chid1="";
//			String outstand1 ="";
//			String outstandNFB1= "";
//			String endamount1="";
//			String ageoverdue1 ="";
//			String reasonsutil1 ="";
//			String dpamount1= "";
//			String debitcurrent1="";
//			String currentmonth1 ="";
//			String cumulative1 ="";
//				
//				
//			
//			
//			
//			
//				headid=(String [])hsh.get("headid");
//				chid=(String [])hsh.get("chid");
//				outstand= (String [])hsh.get("outstand");
//				outstandNFB= (String [])hsh.get("outstandNFB");
//				endamount = (String [])hsh.get("endamount");
//				ageoverdue = (String [])hsh.get("ageoverdue");
//				reasonsutil = (String [])hsh.get("reasonsutil");
//				
//				dpamount= (String [])hsh.get("txt_fac_dp");
//				debitcurrent = (String [])hsh.get("txt_fac_debitcurrent");
//				currentmonth = (String [])hsh.get("txt_fac_current");
//				cumulative = (String [])hsh.get("txt_fac_cumulative");
//
//		
//				
//			
//			
//			hshQuery = new HashMap();
//			arrValues=new ArrayList();
//			int num=0;
//			
//				
//			if(snovalue>1)
//			{
//			 for(int k=2;k<outstand.length+2;k++)
//			  {				
//				if(outstand[k-2].equals(""))
//				{
//					outstand[k-2] = "0.00";
//				}
//				
//				if(outstandNFB[k-2].equals(""))
//				{
//					outstandNFB[k-2] = "0.00";
//				}
//				if(endamount[k-2].equals(""))
//				{
//					endamount[k-2] = "0.00";
//				}
//				if(reasonsutil[k-2].equals(""))
//				{
//					reasonsutil[k-2] = "";
//				}
//
//				if(headid[k-2].equals(""))
//				{
//					headid[k-2] = "0";
//				}
//				if(chid[k-2].equals(""))
//				{
//					chid[k-2] = "0";
//				}
//				if(ageoverdue[k-2].equals(""))
//					ageoverdue[k-2]="0";
//				
//				
//				if(dpamount[k-2].equals(""))
//				{
//					dpamount[k-2] = "";
//				}
//
//				if(debitcurrent[k-2].equals(""))
//				{
//					debitcurrent[k-2] = "0";
//				}
//				if(currentmonth[k-2].equals(""))
//				{
//					currentmonth[k-2] = "0";
//				}
//				if(cumulative[k-2].equals(""))
//					cumulative[k-2]="0";
//
//							
//							num=num+1;	
//							hshQuery = new HashMap();
//							arrValues=new ArrayList();
//							intUpdatesize=intUpdatesize+1;
//							hshqueryval.put("size",Integer.toString(intUpdatesize));
//							hshQuery.put("strQueryId","ins_monthlylimitfacility");
//							arrValues.add(strBid);	
//							arrValues.add(strDate);
//							intValue=intValue+1;
//							String i=Integer.toString(intValue);
//							arrValues.add(i);	
//							arrValues.add(headid[k-2]);
//							arrValues.add(chid[k-2]);							
//							arrValues.add(facdesc);
//							arrValues.add(FB);
//							arrValues.add(correctNull(outstandNFB[k-2]));//Outstanding NFB Data Stored in this Field
//							arrValues.add(correctNull(outstand[k-2]));
//							arrValues.add(correctNull(endamount[k-2]));
//							arrValues.add(correctNull(ageoverdue[k-2]));							
//							arrValues.add(correctNull(reasonsutil[k-2]));
//							arrValues.add("Reg");
//							arrValues.add("");
//							arrValues.add(correctNull(dpamount[k-2]));
//							arrValues.add(correctNull(debitcurrent[k-2]));
//							arrValues.add(correctNull(currentmonth[k-2]));							
//							arrValues.add(correctNull(cumulative[k-2]));
//							hshQuery.put("arrValues",arrValues);
//							hshqueryval.put(Integer.toString(k),hshQuery);	
//													
//						
//				}
//			}
//			else
//			{
//				if(headid1.equals(""))
//				{
//					headid1 = "0";
//				}
//				if(chid1.equals(""))
//				{
//					chid1= "0";
//				}
//
//				if(outstand1.equals(""))
//				{
//					outstand1 = "0.00";
//				}
//				if(outstandNFB1.equals(""))
//				{
//					outstandNFB1 = "0.00";
//				}
//				
//				if(endamount1.equals(""))
//				{
//					endamount1 = "0.00";
//				}
//				if(reasonsutil1.equals(""))
//				{
//					reasonsutil1 = "";
//				}
//				
//				if(ageoverdue1.equals(""))
//					ageoverdue1="0";
//				
//				if(dpamount1.equals(""))
//				{
//					dpamount1 = "0.00";
//				}
//				
//				if(debitcurrent1.equals(""))
//				{
//					debitcurrent1 = "0.00";
//				}
//				if(currentmonth1.equals(""))
//				{
//					currentmonth1 = "";
//				}
//				
//				if(cumulative1.equals(""))
//					cumulative1="0";
//
//			
//							num=num+1;	
//							hshQuery = new HashMap();
//							arrValues=new ArrayList();
//							intUpdatesize=intUpdatesize+1;
//							hshqueryval.put("size",Integer.toString(intUpdatesize));
//							hshQuery.put("strQueryId","ins_monthlylimitfacility");
//							arrValues.add(strBid);	
//							//arrValues.add(strDate);
//							intValue=intValue+1;
//							String i=Integer.toString(intValue);
//							arrValues.add(i);
//							arrValues.add(headid1);
//							arrValues.add(chid1);
//							arrValues.add(facdesc);
//							arrValues.add(FB);
//							arrValues.add(outstandNFB1);//Outstanding NFB Data Stored in this field
//							arrValues.add(correctNull(outstand1));
//							arrValues.add(correctNull(endamount1));
//							arrValues.add(correctNull(ageoverdue1));
//							arrValues.add(correctNull(reasonsutil1));
//							arrValues.add(correctNull(debitcurrent1));
//							arrValues.add(correctNull(currentmonth1));
//							arrValues.add(correctNull(cumulative1));
//							hshQuery.put("arrValues",arrValues);
//							hshqueryval.put("2",hshQuery);	
//			
//				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");		
//			//	updateAdHocMonthlyMonitor(hsh);
//		
//			}
//			}
//		
//		catch (Exception e)
//			{
//			throw new EJBException("Error Occured  "+e.getMessage());
//			}
//
//			finally
//			{
//				try
//				{
//					if(rs!= null)
//					{
//						rs.close();
//					}
//				
//				}
//				catch (Exception e1)
//				{
//					throw new EJBException("Error Occured  "+e1.getMessage());
//				}
//			}
//
//			HashMap hshRecord=getMonthlyMonitorBorrowerData(hsh);
//			return hshRecord;
//			
//	}

	
	
	
	/**/

	
//	public HashMap getMonthlyMonitorBorrowerData(HashMap hshValues) 
//	{
//		
//		String strQuery="";
//		ResultSet rs=null;
//		String strBid="";
//		
//		HashMap hshRecord = new HashMap();		
//		
//		
//		try
//			{	
//				
//			strBid=correctNull((String)hshValues.get("bid"));
//			
//			
//			strQuery = SQLParser.getSqlQuery("selectlimittype^"+strBid);
//			if(rs!=null)
//				rs.close();	
//			
//			rs= DBUtils.executeQuery(strQuery);
//			ArrayList vecValF=new ArrayList();
//			ArrayList vecRecF=new ArrayList();
//			//ArrayList vecData=new ArrayList();
//
//				while(rs.next())
//				{
//						vecRecF = new ArrayList();
//						vecRecF.add(correctNull(rs.getString("REGISTER_ID")));
//						vecRecF.add(correctNull(rs.getString("CUSTOMER_ID")));
//						vecRecF.add(correctNull(rs.getString("CUSTOMER_TYPE")));
//						vecRecF.add(correctNull(rs.getString("REGISTER_DATE")));
//						vecRecF.add(correctNull(rs.getString("SANCTIONED_BY")));
//						vecRecF.add(correctNull(rs.getString("NATURE_OF_LIMIT")));
//						vecRecF.add(correctNull(rs.getString("AMOUNT_OF_LIMIT")));
//						vecRecF.add(correctNull(rs.getString("MARGIN")));
//						vecRecF.add(correctNull(rs.getString("INTEREST_RATE")));
//						vecRecF.add(correctNull(rs.getString("SECURITY")));
//						vecRecF.add(correctNull(rs.getString("REMARKS")));
//						vecRecF.add(correctNull(rs.getString("MODIFIED_BY")));
//						vecRecF.add(correctNull(rs.getString("MODIFIED_DATE")));
//						vecRecF.add(correctNull(rs.getString("customer_name")));
//						vecRecF.add(correctNull(rs.getString("ACCOUNT_NO")));
//						vecRecF.add(correctNull(rs.getString("exp_date")));
//						
//
//						vecValF.add(vecRecF);
//						
//				}
//				hshRecord.put("VecValF",vecValF);
//
//			}
//		catch (Exception e)
//			{
//			throw new EJBException("Error Occured"+e.getMessage());
//			}
//
//			finally
//			{
//				try
//				{
//					if(rs!= null)
//					{
//						rs.close();
//					}
//				
//				}
//				catch (Exception e1)
//				{
//				throw new EJBException("Error closing the connection "+e1.getMessage());
//				}
//			}
//	
//	return hshRecord;
//			
//	}
	
	
	public void updateMonReviewCorporatePersonal(HashMap hshValues) 
	{
		HashMap hshQueryValues=null;
		HashMap hshQuery=null;
		
		ArrayList arrValues=null;
		
		String strAction="";
		String strAlertfor="";
		String strDaysfrom="";
		String strDaysto="";
		String strassettype="";
		
		int intUpdatesize=0;
		
		ResultSet rs=null;
		
		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		strAlertfor=Helper.correctNull((String)hshValues.get("selalertfor"));
		strDaysfrom=Helper.correctNull((String)hshValues.get("txtdaysfrom"));
		strDaysto=Helper.correctNull((String)hshValues.get("txtdaysupto"));
		strassettype=Helper.correctNull((String)hshValues.get("selassettype"));
		
		try
		{
			if(strAction.equalsIgnoreCase("update"))
		 	{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strassettype);
				
				hshQuery.put("strQueryId","delmonitalert");
				hshQuery.put("arrValues",arrValues);
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strDaysfrom);
				arrValues.add(strDaysto);
				arrValues.add(strassettype);
				
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","insmonitalert");
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
		 	}
	
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				
				arrValues=new ArrayList();
				
				intUpdatesize++;
				
				arrValues.add(strAlertfor);
				arrValues.add(strassettype);
				
				hshQuery.put("strQueryId","delmonitalert");
				hshQuery.put("arrValues",arrValues);
				
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updatedata");
			}
			
			StringBuilder sbAt = new StringBuilder();
			sbAt.append(" ~Alert For=").append(correctNull((String)hshValues.get("hid_selalertfor")));
			sbAt.append(" ~Asset Classification Type=").append(correctNull((String)hshValues.get("hid_selassettype")));
			sbAt.append(" ~Days From=").append(correctNull((String)hshValues.get("txtdaysfrom")));
			sbAt.append(" ~Days Upto=").append(correctNull((String)hshValues.get("txtdaysupto")));
		    AuditTrial.auditLog(hshValues,"123","",sbAt.toString());
			
			
			
			
			
		
		}
		catch(Exception e)
			{
				throw new EJBException("Connection Error in updateNpainterest"+e.getMessage());
			}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
	}
	
	
	public HashMap getMonReviewCorporatePersonal(HashMap hshValues) 
	{

	 	HashMap hshResult=new HashMap();
	 	ResultSet rs = null;
	 	String strCustAccno="",strQuery="", strCustid="", strReviewYear="" ,strreviewdate="";
	 	boolean bool=false;
	 	try
	 	{
	 		strCustid=correctNull((String)hshValues.get("strcbsid"));
	 		strCustAccno=correctNull((String)hshValues.get("cbsaccno"));
	 		strReviewYear = correctNull((String) hshValues.get("reviewYear"));
	 		
	 				
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selMonLimitRegister^"+strCustid+"^"+strCustAccno);
		 	rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strreviewdate=correctNull((String)rs.getString("LIMIT_REVIEWDATE"));
				hshResult.put("LIMIT_REVIEWDATE",strreviewdate);
				hshResult.put("LIMIT_SANCTAMT",correctNull((String)rs.getString("LIMIT_SANCTAMT")));
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_nextreviewdate^"+strreviewdate+"^"+strCustid+"^"+strCustAccno);
		 	rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("nextreview",correctNull((String)rs.getString("nextreview")));
			}
					
			if(rs!=null)
			{
				rs.close();
			}
	 		
			strQuery=SQLParser.getSqlQuery("selReviewNoteForTermLoan^"+strCustid+"^"+strCustAccno+"^"+strReviewYear);
			rs=DBUtils.executeQuery(strQuery);
			bool=rs.next();
	 		if(bool)
	 		{
	 			/* hshResult.put("cbsid",correctNull((String)rs.getString("cbsid")));
	 			hshResult.put("cbsAccountNo",correctNull((String)rs.getString("cbsAccountNo")));
	 			hshResult.put("seqno",correctNull((String)rs.getString("seqno"))); */
	 			//hshResult.put("natureValSecurity",correctNull((String)rs.getString("natureValSecurity")));
	 			//hshResult.put("presentStatusPrj",correctNull((String)rs.getString("presentStatusPrj")));
	 			
	 			//hshResult.put("operationCDAcc",correctNull((String)rs.getString("operationCDAcc")));
	 			//hshResult.put("maxDebit",correctNull((String)rs.getString("maxDebit")));
	 			//hshResult.put("maxCredit",correctNull((String)rs.getString("maxCredit")));
	 			//hshResult.put("minDebit",correctNull((String)rs.getString("minDebit")));
	 			//hshResult.put("minCredit",correctNull((String)rs.getString("minCredit")));
	 			
	 			//hshResult.put("daysDebit",correctNull((String)rs.getString("daysDebit")));
	 			//hshResult.put("operTermLoanACC",correctNull((String)rs.getString("operTermLoanACC")));
	 			//hshResult.put("repaySchedule",correctNull((String)rs.getString("repaySchedule")));
	 			//hshResult.put("installment",correctNull((String)rs.getString("installment"))); //sel
	 			//hshResult.put("interest",correctNull((String)rs.getString("interest"))); //sel
	 			
	 			//hshResult.put("compliance",correctNull((String)rs.getString("compliance")));
	 			//hshResult.put("completionMort",correctNull((String)rs.getString("completionMort")));
//	 			hshResult.put("registCharge",correctNull((String)rs.getString("registCharge")));
//	 			hshResult.put("documents",correctNull((String)rs.getString("documents"))); //sel
//	 			hshResult.put("collSecurityDet",correctNull((String)rs.getString("collSecurityDet")));
	 				
//	 			hshResult.put("inspectionDate",correctNull((String)rs.getString("inspectionDate"))); //date
//	 			hshResult.put("secAdequtely",correctNull((String)rs.getString("secAdequtely")));
//	 			hshResult.put("inspectingOfficial",correctNull((String)rs.getString("inspectingOfficial")));
//	 			hshResult.put("auditObserv",correctNull((String)rs.getString("auditObserv")));
	 			hshResult.put("recommendation",correctNull((String)rs.getString("recommendation")));
	 				
	 			hshResult.put("personal_natofactivity",correctNull((String)rs.getString("activity"))); //date
	 			hshResult.put("personal_bankingsince",correctNull((String)rs.getString("banksince")));
	 			hshResult.put("LIMIT_REVIEWDATE",correctNull((String)rs.getString("reviewdate")));
	 			hshResult.put("FUND_OSAMT",correctNull((String)rs.getString("osamt")));
	 			hshResult.put("FUND_OVERDUEAMT",correctNull((String)rs.getString("overdue")));
	 			hshResult.put("REVIEW_STATUS",correctNull((String)rs.getString("REVIEW_STATUS")));
	 			hshResult.put("review_comments",correctNull((String)rs.getString("review_comments")));
	 		}
	 		else
	 		{
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
	 			strQuery=SQLParser.getSqlQuery("sel_overdefaults^"+strCustid+"^"+strCustAccno);
	 			rs=DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				hshResult.put("FUND_OVERDUEAMT",correctNull((String)rs.getString("FUND_OVERDUEAMT")));
	 				//hshResult.put("fund_overduesince",correctNull((String)rs.getString("fund_overduesince")));
	 				hshResult.put("FUND_OSAMT",correctNull((String)rs.getString("FUND_OSAMT")));
	 			}
	 			if(rs!=null)
	 			{
	 				rs.close();
	 			}
	 			
	 			
	 			strQuery=SQLParser.getSqlQuery("selMonPersonalInfo^"+strCustid);
	 			rs=DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				hshResult.put("personal_bankingsince",correctNull((String)rs.getString("personal_bankingsince")));
	 				hshResult.put("personal_natofactivity",correctNull((String)rs.getString("personal_natofactivity")));
	 			}
	 		}
	 		
			

	 		
	 		hshResult.put("strCBSCustid",correctNull((String)hshValues.get("strcbsid")));
			hshResult.put("strCBSCustAccno",correctNull((String)hshValues.get("cbsaccno")));
			hshResult.put("strappname",correctNull((String)hshValues.get("strappname")));
			hshResult.put("strfacility",correctNull((String)hshValues.get("strfacility")));
			hshResult.put("strReviewYear",correctNull((String)hshValues.get("reviewYear")));
	 	}catch (Exception exp){
	 		throw new EJBException("Error in getMonitorCheckList"+ exp.getMessage());
	 	}finally
	 	{
	 		try
	 		{
	 			if(rs!=null)
	 				rs.close();
	 		}catch(Exception exp)
	 		{
	 			throw new EJBException("Error in closing the connection in getMonitorCheckList "+ exp.toString()); 
	 		}
	 	}
	 	
	 	return hshResult;
 }
	

	
}