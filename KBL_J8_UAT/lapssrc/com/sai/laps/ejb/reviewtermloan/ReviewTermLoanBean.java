package com.sai.laps.ejb.reviewtermloan;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ReviewTermLoanBean", mappedName = "ReviewTermLoanHome")
@Remote (ReviewTermLoanRemote.class)
public class ReviewTermLoanBean extends BeanAdapter
{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1588917774981690674L;

	public HashMap getReviewFinancial(HashMap hshValues) 
	{	
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		try
		{
			String strCustid = correctNull((String) hshValues.get("cbsid"));
	 		String strCustAccno = correctNull((String) hshValues.get("hidtlrno"));
	 		String strReviewYear = correctNull((String) hshValues.get("reviewYear"));
	 		String reviewOf = correctNull((String)hshValues.get("reviewOf"));
	 		
	 		ArrayList arrRow = new ArrayList();
	 		ArrayList arrCol = new ArrayList();
			
	 		String strQuery=SQLParser.getSqlQuery("sel_reviewtermloanfinancial^"+strReviewYear+"^"+strCustid+"^"+strCustAccno+"^"+reviewOf);
	 		
		 	rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
			{
	 			arrCol = new ArrayList();
	 			arrCol.add(rs.getString("review_firstyear"));
	 			arrCol.add(rs.getString("review_secondyear"));
	 			arrCol.add(rs.getString("review_thirdyear"));
	 			arrCol.add(rs.getString("review_fourthyear"));
	 			arrRow.add(arrCol);
	 	    }
	 		
	 		hshRecord.put("arrRow",arrRow);
	 		strQuery=SQLParser.getSqlQuery("tlr_financialcomments_select^"+strCustAccno);
	 		rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
	 		{
	 			hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
	 		}
		}
		catch (Exception e) {
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
				throw new EJBException("Error closing in getReviewFinancial the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
		
	}
	
	public void updateReviewFinancial(HashMap hshValues) 
	{
		
		try
		{
				HashMap hshQuery = new HashMap();
		 		HashMap hshQueryValues=new HashMap();
				ArrayList arrValues=new ArrayList();
				String strCustid = correctNull((String) hshValues.get("cbsid"));
		 		String strCustAccno = correctNull((String) hshValues.get("hidtlrno"));
		 		String strReviewYear = correctNull((String) hshValues.get("reviewYear"));
		 		String reviewOf = correctNull((String)hshValues.get("reviewOf"));
		 		String[] strIncurred1 = (String[]) hshValues.get("txt_incurred1");
		 		String[] strIncurred2 = (String[]) hshValues.get("txt_incurred2");
		 		String[] strIncurred3 = (String[]) hshValues.get("txt_incurred3");
		 		String[] strIncurred4 = null;
		 		
		 		if(reviewOf.equals("2"))
		 		{
		 			strIncurred4 = (String[]) hshValues.get("txt_incurred4");
		 		}
		 		
		 		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		 		
		 		
		 		
		 		
				if(strAction.equalsIgnoreCase("update"))
				{
					 hshQuery = new HashMap();
				 	 hshQueryValues=new HashMap();
					 arrValues=new ArrayList();
					 arrValues.add(strReviewYear);
					 arrValues.add(strCustid);
					 arrValues.add(strCustAccno);
					 arrValues.add(reviewOf);
					 hshQuery.put("arrValues",arrValues);
					 hshQuery.put("strQueryId","del_reviewtermloanfinancial");
					 hshQueryValues.put("size","1");
					 hshQueryValues.put("1",hshQuery);
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 
					 hshQuery = new HashMap();
				 	 hshQueryValues=new HashMap();
					 arrValues=new ArrayList();
				     arrValues.add(strCustAccno);
					 hshQuery.put("arrValues",arrValues);
					 hshQuery.put("strQueryId","tlr_financialcomments_delete");
					 hshQueryValues.put("size","1");
					 hshQueryValues.put("1",hshQuery);
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 
					int intSize=0;
					hshQueryValues=new HashMap();
					for(int i=0;i<strIncurred1.length;i++)
					{
						 intSize++;
						 hshQuery = new HashMap();
					 	 arrValues=new ArrayList();
						 arrValues.add(""+i);
						 arrValues.add(strReviewYear);
						 arrValues.add(strCustid);
						 arrValues.add(strCustAccno);
						 
						 
						
						 arrValues.add(strIncurred1[i]);
						 arrValues.add(strIncurred2[i]);
						 arrValues.add(strIncurred3[i]);
						 if(reviewOf.equals("2"))
					 	 {
							 arrValues.add(strIncurred4[i]);
					 	 }
						 else
						 {
							 arrValues.add("");
						 }
						 arrValues.add(reviewOf);
						 hshQuery.put("arrValues",arrValues);
						 hshQuery.put("strQueryId","ins_reviewtermloanfinancial");
						 hshQueryValues.put(""+intSize,hshQuery);
						 hshQueryValues.put("size",""+intSize);
					
					}
					
					if(reviewOf.equals("2"))
			 		{
						 intSize++;
						 hshQuery = new HashMap();
					 	 arrValues=new ArrayList();
						 arrValues.add(""+strIncurred1.length);
						 arrValues.add(strReviewYear);
						 arrValues.add(strCustid);
						 arrValues.add(strCustAccno);
						 arrValues.add(correctNull((String) hshValues.get("combo1")));
						 arrValues.add(correctNull((String) hshValues.get("combo2")));
						 arrValues.add(correctNull((String) hshValues.get("combo3")));
						 arrValues.add(correctNull((String) hshValues.get("combo4")));
					 	 arrValues.add(reviewOf);
						 hshQuery.put("arrValues",arrValues);
						 hshQuery.put("strQueryId","ins_reviewtermloanfinancial");
						 hshQueryValues.put(""+intSize,hshQuery);
						 hshQueryValues.put("size",""+intSize);
			 		}
					
					 intSize++;
					 hshQuery = new HashMap();
				 	 arrValues=new ArrayList();
					 arrValues.add(strCustAccno);
					  arrValues.add(correctNull((String) hshValues.get("txt_fincomments")));
					 hshQuery.put("arrValues",arrValues);
					 hshQuery.put("strQueryId","tlr_financialcomments_insert");
					 hshQueryValues.put(""+intSize,hshQuery);
					 hshQueryValues.put("size",""+intSize);
					
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 
					 
					
				}
				else
				{
					 hshQuery = new HashMap();
				 	 hshQueryValues=new HashMap();
					 arrValues=new ArrayList();
					 arrValues.add(strReviewYear);
					 arrValues.add(strCustid);
					 arrValues.add(strCustAccno);
					 arrValues.add(reviewOf);
					 hshQuery.put("arrValues",arrValues);
					 hshQuery.put("strQueryId","del_reviewtermloanfinancial");
					 hshQueryValues.put("size","1");
					 hshQueryValues.put("1",hshQuery);
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					 
					 hshQuery = new HashMap();
				 	 hshQueryValues=new HashMap();
					 arrValues=new ArrayList();
					 arrValues.add(strCustAccno);
					 hshQuery.put("arrValues",arrValues);
					 hshQuery.put("strQueryId","tlr_financialcomments_delete");
					 hshQueryValues.put("size","1");
					 hshQueryValues.put("1",hshQuery);
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				 
		 		
		 		
		 		
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	
	
	public HashMap updateTypeReviewTermLoan(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
 		HashMap hshQueryValues=new HashMap();
 		HashMap hshRecord=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strQuery = null;
		ResultSet rs = null;
		int intUpdatesize=0;
		String strCustid = null;
		String strReviewYear = null;
		String strTLReviewNo = null;
		try
		{
		    	String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		    	strCustid=correctNull((String)hshValues.get("cbsid"));
		    	strReviewYear=correctNull((String)hshValues.get("reviewYear"));
		    	strTLReviewNo=strCustid+strReviewYear;
		    	
				if(strAction.equalsIgnoreCase("update"))
				{
					 arrValues.add(correctNull((String)hshValues.get("reviewOf")));
					 arrValues.add(correctNull((String)hshValues.get("cbsaccno")));
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","upd_mon_limitregister_review"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					 arrValues.add("");
					 arrValues.add(correctNull((String)hshValues.get("cbsaccno")));
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","upd_mon_limitregister_review"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				//update General Details
				//End
				//Update Facility Deatails
				strQuery=SQLParser.getSqlQuery("getpostfundbased^"+strCustid);
				rs=DBUtils.executeQuery(strQuery);
				int index=0;
				while(rs.next())
				{
					index++;
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
     				arrValues.add(strTLReviewNo);
					arrValues.add(Integer.toString(index));
					arrValues.add(correctNull(rs.getString("fund_schemecode")));
					arrValues.add(correctNull(rs.getString("facility")));
					arrValues.add(correctNull(rs.getString("fund_sancamt")));
					arrValues.add("");
					arrValues.add(correctNull(rs.getString("fund_osamt")));
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(rs.getString("fund_overdueamt")));
					arrValues.add("");
					hshQuery.put("strQueryId","tlr_facilities_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));	
					
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				//End
				hshValues.put("tlreviewno",strTLReviewNo);
				hshRecord = getTypeReviewTermLoan(hshValues);
				hshRecord.put("tlreviewno",strTLReviewNo);
		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateTypeReviewTermLoan"+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	
	public void updateReviewCorpCompany(HashMap hshValues) 
	{
		
		

		try
		{
				
		 		
		 		HashMap hshQuery = new HashMap();
		 		HashMap hshQueryValues=new HashMap();
				ArrayList arrValues=new ArrayList();
				
				String strCustid = correctNull((String) hshValues.get("cbsid"));
		 		String strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
		 		String strReviewYear = correctNull((String) hshValues.get("reviewYear"));
		 		//String reviewOf = correctNull((String)hshValues.get("reviewOf"));
				
		 		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
				
				 //arrValues.add(correctNull((String)hshValues.get("sel_typelimit")));
				if(strAction.equalsIgnoreCase("update"))
				{	
					
					 arrValues.add(strCustid);
					 arrValues.add(strCustAccno);
					 arrValues.add(strReviewYear);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_reviewcorporate_company_details"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					 hshQuery = new HashMap();
				 	 hshQueryValues=new HashMap();
					 arrValues=new ArrayList();
					 arrValues.add(correctNull((String)hshValues.get("txt_group")));
					 arrValues.add(correctNull((String)hshValues.get("txt_banking")));
					 arrValues.add(correctNull((String)hshValues.get("txt_monthreview")));
					 arrValues.add(correctNull((String)hshValues.get("txt_accountclassification")));
					 arrValues.add(correctNull((String)hshValues.get("txt_creditrating")));
					 arrValues.add(correctNull((String)hshValues.get("status_account")));
					 arrValues.add(correctNull((String)hshValues.get("partner")));
					 arrValues.add(correctNull((String)hshValues.get("partner1")));
					 arrValues.add(correctNull((String)hshValues.get("partner2")));
					 arrValues.add(correctNull((String)hshValues.get("partner3")));
					 arrValues.add(correctNull((String)hshValues.get("partner4")));
					 arrValues.add(correctNull((String)hshValues.get("partner5")));
					 arrValues.add(correctNull((String)hshValues.get("partner6")));
					 arrValues.add(correctNull((String)hshValues.get("partner7")));
					 arrValues.add(correctNull((String)hshValues.get("partner8")));
					 arrValues.add(correctNull((String)hshValues.get("partner9")));
					 arrValues.add(strCustid);
					 arrValues.add(strCustAccno);
					 arrValues.add(strReviewYear);
					 arrValues.add(correctNull((String)hshValues.get("txt_branch")));
					 arrValues.add(correctNull((String)hshValues.get("txt_sharepercent")));
					 arrValues.add(correctNull((String)hshValues.get("txt_dateprposal")));
					 
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","ins_reviewcorporate_company_details"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				else
				{
					 arrValues.add(strCustid);
					 arrValues.add(strCustAccno);
					 arrValues.add(strReviewYear);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_reviewcorporate_company_details"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				 
		 		
		 		
		 		
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	public HashMap getReviewCorpCompany(HashMap hshValues) 
	{	
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		try
		{
			String strCustid = correctNull((String) hshValues.get("cbsid"));
	 		String strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
	 		String strReviewYear = correctNull((String) hshValues.get("reviewYear"));
	 		//String reviewOf = correctNull((String)hshValues.get("reviewOf"));
	 		
	 		
			
	 		String strQuery=SQLParser.getSqlQuery("sel_reviewcorporate_company_details^"+strCustid+"^"+strCustAccno+"^"+strReviewYear);
	 		
		 	rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
			{
	 			hshRecord.put("mon_group",correctNull((String)rs.getString("mon_group")));
	 			hshRecord.put("mon_banking",correctNull((String)rs.getString("mon_banking")));
	 			hshRecord.put("mon_review",correctNull((String)rs.getString("mon_review")));
	 			hshRecord.put("mon_accountclassification",correctNull((String)rs.getString("mon_accountclassification")));
	 			hshRecord.put("mon_creditrating",correctNull((String)rs.getString("mon_creditrating")));
	 			hshRecord.put("mon_status_account",correctNull((String)rs.getString("mon_status_account")));
	 			hshRecord.put("mon_partner1",correctNull((String)rs.getString("mon_partner1")));
	 			hshRecord.put("mon_partner2",correctNull((String)rs.getString("mon_partner2")));
	 			hshRecord.put("mon_partner3",correctNull((String)rs.getString("mon_partner3")));
	 			hshRecord.put("mon_partner4",correctNull((String)rs.getString("mon_partner4")));
	 			hshRecord.put("mon_partner5",correctNull((String)rs.getString("mon_partner5")));
	 			hshRecord.put("mon_partner6",correctNull((String)rs.getString("mon_partner6")));
	 			hshRecord.put("mon_partner7",correctNull((String)rs.getString("mon_partner7")));
	 			hshRecord.put("mon_partner8",correctNull((String)rs.getString("mon_partner8")));
	 			hshRecord.put("mon_partner9",correctNull((String)rs.getString("mon_partner9")));
	 			hshRecord.put("mon_partner10",correctNull((String)rs.getString("mon_partner10")));
	 			
	 			hshRecord.put("mon_leadbank",correctNull((String)rs.getString("mon_leadbank")));
	 			hshRecord.put("mon_sharepercent",correctNull((String)rs.getString("mon_sharepercent")));
	 			
	 			hshRecord.put("dateproposal",correctNull((String)rs.getString("dateproposal")));
	 	    }
	 		
	 		
			
		}
		catch (Exception e) 
		{
			throw new EJBException("Error occured in getReviewCorpCompany"+e.toString());
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
				throw new EJBException("Error closing in getReviewCorpCompany the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
		
	}
	
	
	 public HashMap getTLReviewCorporatePrint(HashMap hshValues)
	 {
		 	HashMap hshRecord=new HashMap();
		 	ResultSet rs = null;
		 	ResultSet rs1 = null;
		 	String strCustid = null;
		 	String tlrAppno = null;
		 	String strReviewYear = null;
		 	String strQuery = null;
		 	String strCustName = null;
		 	String reviewOf = null;
		 	ArrayList arrCol = null;
		 	ArrayList arrRow = null;
		 	String valuesin = null;
		 	String strOrgCode = null;
 		 	try
		 	{
		 		strCustid=correctNull((String)hshValues.get("cbsid"));
		 		tlrAppno=correctNull((String)hshValues.get("hidtlrno"));
		 		strCustName=correctNull((String)hshValues.get("cbsname"));
		 		strReviewYear = correctNull((String) hshValues.get("reviewYear"));
		 		reviewOf = correctNull((String)hshValues.get("reviewOf"));
		
		 	//Values in (lacs,crores,Rs.)
		 		strQuery=SQLParser.getSqlQuery("tlr_applications_select^"+tlrAppno);
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			valuesin = correctNull((String)rs.getString("tlr_valuesin"));
		 			strOrgCode = correctNull((String)rs.getString("tlr_orgcode"));
		 		}
		 		else{
		 			valuesin = "";
		 		}
		 		hshRecord.put("valuesin",valuesin);
		 	//organisation Details
		 		strQuery=SQLParser.getSqlQuery("getbranchaddress^"+strOrgCode);
		 		if(rs!=null)
		 			rs.close();
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			hshRecord.put("branchName",correctNull((String)rs.getString("org_name")));
		 		}
		 	//Get financial Details
		 	    arrRow = new ArrayList();
		 	    strQuery=SQLParser.getSqlQuery("sel_reviewtermloanfinancial^"+strReviewYear+"^"+strCustid+"^"+tlrAppno+"^"+reviewOf);
		 	    if(rs!=null)
		 	    	rs.close();
		 	 	rs=DBUtils.executeQuery(strQuery);
		 		while(rs.next())
				{
		 			arrCol = new ArrayList();
		 			arrCol.add(rs.getString("review_firstyear"));
		 			arrCol.add(rs.getString("review_secondyear"));
		 			arrCol.add(rs.getString("review_thirdyear"));
		 			arrCol.add(rs.getString("review_fourthyear"));
		 			arrRow.add(arrCol);
		 	    }
		 		
		 		hshRecord.put("arrRow",arrRow);
		 	//Internal Credit Rating
		 		    arrRow = new ArrayList();
			 	    strQuery=SQLParser.getSqlQuery("tlr_internalratingparameter_select^"+tlrAppno);
			 	    if(rs!=null)
			 	    	rs.close();
			 	 	rs=DBUtils.executeQuery(strQuery);
			 		while(rs.next())
					{
			 			arrCol = new ArrayList();
			 			arrCol.add(rs.getString("tlr_prevyear"));
			 			arrCol.add(rs.getString("tlr_currentyear"));
			 			arrRow.add(arrCol);
			 	    }
			 		hshRecord.put("arrInternalParam",arrRow);
		 	//end	
		 		strQuery=SQLParser.getSqlQuery("tlr_financialcomments_select^"+tlrAppno);
		 		if(rs!=null)
		 			rs.close();
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
		 		}
				//
		 	//Get Banking Arrangement	
		 		strQuery = SQLParser.getSqlQuery("tlr_bankingdetails_select^"+tlrAppno);
		 		if(rs!=null)
		 			rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_group",correctNull((String)rs.getString("tlr_group")));
					hshRecord.put("tlr_status",correctNull((String)rs.getString("tlr_status")));
					hshRecord.put("tlr_reviewdate1",correctNull((String)rs.getString("tlr_reviewdate1")));
					hshRecord.put("tlr_bankarrangement",correctNull((String)rs.getString("tlr_bankarrangement")));
					hshRecord.put("tlr_leadbank",correctNull((String)rs.getString("tlr_leadbank")));
					hshRecord.put("tlr_ourshare",correctNull((String)rs.getString("tlr_ourshare")));
					hshRecord.put("tlr_agencyname",correctNull((String)rs.getString("tlr_agencyname")));
					hshRecord.put("tlr_lastrating",correctNull((String)rs.getString("tlr_lastrating")));
					hshRecord.put("tlr_currating",correctNull((String)rs.getString("tlr_currating")));
						
				}
			   //General Details
				
				strQuery=SQLParser.getSqlQuery("tlr_generaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
			 	rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
				{
		 			hshRecord.put("tlr_proposaltype",correctNull((String)rs.getString("tlr_proposaltype")));
		 			hshRecord.put("tlr_activity",correctNull((String)rs.getString("tlr_activity")));
		 			hshRecord.put("tlr_banksince",correctNull((String)rs.getString("tlr_banksince")));
		 			hshRecord.put("tlr_assetclassify",correctNull((String)rs.getString("assetstatdesc")));
		 			
		 			hshRecord.put("tlr_renewal",correctNull((String)rs.getString("tlr_renewal")));
		 			hshRecord.put("tlr_facilitysince",correctNull((String)rs.getString("tlr_facilitysince")));
		 			hshRecord.put("tlr_nextreview",correctNull((String)rs.getString("tlr_nextreview")));
		 			hshRecord.put("tlr_indcode",correctNull((String)rs.getString("tlr_indcode")));
				}
		 	    //Promoter Details
		 		arrRow=new ArrayList();
		 		strQuery=SQLParser.getSqlQuery("tlr_promoterdetails_select^"+tlrAppno);
		 		if(rs!=null)
		 			rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_prom_sno")));
					arrCol.add(correctNull(rs.getString("tlr_prom_name")));
					arrCol.add(correctNull(rs.getString("tlr_prom_desig")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrPromoterDetails",arrRow);
				//present status of the project
				strQuery = SQLParser.getSqlQuery("tlr_presentstatus_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_presentstatus", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				//BriefBackground
				strQuery = SQLParser.getSqlQuery("tlr_briefbackgroud_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_briefbackground", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				//Internal rating
				strQuery = SQLParser.getSqlQuery("tlr_internalrating_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{
					hshRecord.put("tlr_prevyearscore",correctNull((String)rs.getString("tlr_prevyearscore")));
					hshRecord.put("tlr_currentyearscore",correctNull((String)rs.getString("tlr_currentyearscore")));
					hshRecord.put("tlr_prevyeargrade",correctNull((String)rs.getString("tlr_prevyeargrade")));
					hshRecord.put("tlr_currentyeargrade",correctNull((String)rs.getString("tlr_currentyeargrade")));
					hshRecord.put("tlr_prevyearrisk",correctNull((String)rs.getString("tlr_prevyearrisk")));
					hshRecord.put("tlr_currentyearrisk",correctNull((String)rs.getString("tlr_currentyearrisk")));
				}
				
				//Operation in CD account
				strQuery = SQLParser.getSqlQuery("tlr_cdaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_maxdebit",correctNull((String)rs.getString("tlr_maxdebit")));
					hshRecord.put("tlr_mindebit",correctNull((String)rs.getString("tlr_mindebit")));
					hshRecord.put("tlr_maxcredit",correctNull((String)rs.getString("tlr_maxcredit")));
					hshRecord.put("tlr_mincredit",correctNull((String)rs.getString("tlr_mincredit")));
					hshRecord.put("tlr_noofdaysdebit",correctNull((String)rs.getString("tlr_noofdaysdebit")));
					hshRecord.put("tlr_noofdayscredit",correctNull((String)rs.getString("tlr_noofdayscredit")));
							
				}
				//Operation in TL account
				strQuery = SQLParser.getSqlQuery("tlr_tlaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_repay", correctNull(Helper.CLOBToString(rs.getClob("tlr_repay"))));
					hshRecord.put("tlr_disbursaldate",correctNull((String)rs.getString("tlr_disbursaldate")));
					hshRecord.put("tlr_instalmentpaid",correctNull((String)rs.getString("tlr_instalmentpaid")));
					hshRecord.put("tlr_intserviced",correctNull((String)rs.getString("tlr_intserviced")));
				}
				strQuery = SQLParser.getSqlQuery("tlr_compliance_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_formalities",correctNull((String)rs.getString("tlr_formalities")));
					hshRecord.put("tlr_registrationcharge",correctNull((String)rs.getString("tlr_registrationcharge")));
					hshRecord.put("tlr_doccheck",correctNull((String)rs.getString("tlr_doccheck")));
					hshRecord.put("tlr_dbcdate",correctNull((String)rs.getString("tlr_dbcdate")));
					hshRecord.put("tlr_inspectiondate",correctNull((String)rs.getString("tlr_inspectiondate")));
					hshRecord.put("tlr_secdesc",correctNull((String)rs.getString("tlr_secdesc")));
					hshRecord.put("tlr_observ",correctNull((String)rs.getString("tlr_observ")));
				
					
				}
				arrRow=new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
				
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrTermLoanFacility",arrRow);
				strQuery = SQLParser.getSqlQuery("tlr_facilities_totamount^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					hshRecord.put("proposedlimit",correctNull((String)rs.getString("proposedlimit")));
				}
				//Auditor observation

				String audit_type = "";
				strQuery = SQLParser.getSqlQuery("tlr_auditobservations_selectall^"+tlrAppno);
			
				ArrayList arrInternal=new ArrayList();
				ArrayList arrStatutory =new ArrayList();
				ArrayList arrConcurrent=new ArrayList();
				ArrayList arrStock=new ArrayList();
				ArrayList arrRBI=new ArrayList();
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_auditorcomments")));
					arrCol.add(correctNull(rs.getString("tlr_officercomments")));
					
					audit_type = correctNull((String) rs.getString("tlr_audittype"));
					if (audit_type.equalsIgnoreCase("1")) {
						arrInternal.add(arrCol);
						hshRecord.put("audit_internal_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("2")) {
						arrConcurrent.add(arrCol);
						hshRecord.put("audit_concurrent_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("3")) {
						arrRBI.add(arrCol);
						hshRecord.put("audit_inspection_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("4")) {
						arrStatutory.add(arrCol);
						hshRecord.put("audit_statutory_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("5")) {
						arrStock.add(arrCol);
						hshRecord.put("audit_stock_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
				}
				
				hshRecord.put("arrInternal", arrInternal);
				hshRecord.put("arrConcurrent", arrConcurrent);
				hshRecord.put("arrRBI", arrRBI);
				hshRecord.put("arrStatutory", arrStatutory);
				hshRecord.put("arrStock", arrStock);
				
				//Security Details
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_securities_select_sectype^"+tlrAppno+"^"+"Collateral");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_secno")));
					arrCol.add(correctNull(rs.getString("tlr_sectype")));
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_secdetails")));
					arrCol.add(correctNull(rs.getString("tlr_secremarks")));
					arrCol.add(correctNull(rs.getString("tlr_secvalue")));
					arrCol.add(correctNull(rs.getString("tlr_secdate")));
    				arrRow.add(arrCol);
				}
				hshRecord.put("arrCollSec",arrRow);
				// Facility Details & Security Details
				ArrayList arrSecRow=new ArrayList();
				ArrayList arrSecCol = new ArrayList();
				ArrayList arrSecRemarkscol = new ArrayList();
				ArrayList arrSecRemarksrow = new ArrayList();
				ArrayList arrIntRemarkscol = new ArrayList();
				ArrayList arrIntRemarksrow = new ArrayList();
				
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrIntRemarkscol = new ArrayList();
					String strFacno=correctNull(rs.getString("tlr_facno"));
					arrCol.add(strFacno);
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
						
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrIntRemarkscol.add(correctNull(rs.getString("tlr_intremarks")));
					arrIntRemarksrow.add(arrIntRemarkscol);
					arrSecRow=new ArrayList();
					strQuery=SQLParser.getSqlQuery("tlr_securities_select_facilitywise^"+tlrAppno+"^"+strFacno);
					int j=0;
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrSecCol=new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrSecCol.add(correctNull(rs1.getString("tlr_secdetails"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_secvalue"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_margin"))); 
						if(!correctNull(rs1.getString("tlr_secremarks")).equals(""))
						{
							arrSecRemarkscol.add(correctNull(rs1.getString("tlr_secremarks")));
							arrSecRemarksrow.add(arrSecRemarkscol);
						}
						arrSecRow.add(arrSecCol);
						j++;
					}
					arrCol.add(arrSecRow);
					arrCol.add(Integer.toString(j));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrFacility",arrRow);
				hshRecord.put("arrSecRemarks",arrSecRemarksrow);
				hshRecord.put("arrIntRemarksrow",arrIntRemarksrow);
				
				//Term & conditions
				strQuery = SQLParser.getSqlQuery("tlr_termsdetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_condtions", correctNull(Helper.CLOBToString(rs.getClob("tlr_condtions"))));
						
				}
				//Any other matter
				strQuery = SQLParser.getSqlQuery("tlr_others_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_others", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				
				//Group Concern
				double dblgccomlimit = 0.0;
				double dblgccomos = 0.0;
				double dblgcfbwclt = 0.0;
				double dblgcfbwcpd = 0.0;
				double dblgcfbwcos = 0.0;
				double dblgctllt = 0.0;
				double dblgctlos = 0.0;
				double dblgcins = 0.0;
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_groupconcerns_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("TLR_GCCONNAME")));
					arrCol.add(correctNull(rs.getString("TLR_GCBRANCH")));
					arrCol.add(correctNull(rs.getString("TLR_GCCOA")));
					dblgccomlimit = dblgccomlimit
					+ (rs.getDouble("TLR_GCCOMLIMIT"));
					arrCol.add(correctNull(rs.getString("TLR_GCCOMLIMIT")));
					dblgccomos = dblgccomos + (rs.getDouble("TLR_GCCOMOS"));
					arrCol.add(correctNull(rs.getString("TLR_GCCOMOS")));
					dblgcfbwclt = dblgcfbwclt + (rs.getDouble("TLR_GCFBWCLT"));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCLT")));
					dblgcfbwcpd = dblgcfbwcpd + (rs.getDouble("TLR_GCFBWCDP"));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCDP")));
					dblgcfbwcos = dblgcfbwcos + (rs.getDouble("TLR_GCFBWCOS"));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCOS")));
					dblgctllt = dblgctllt + (rs.getDouble("TLR_GCTLLT"));
					arrCol.add(correctNull(rs.getString("TLR_GCTLLT")));
					dblgctlos = dblgctlos + (rs.getDouble("TLR_GCTLOS"));
					arrCol.add(correctNull(rs.getString("TLR_GCTLOS")));
					dblgcins = dblgcins + (rs.getDouble("TLR_GCINS"));
					arrCol.add(correctNull(rs.getString("TLR_GCINS")));
					arrCol.add(correctNull(rs.getString("TLR_GCMOR")));
					arrCol.add(correctNull(rs.getString("TLR_GCIRREG")));
					arrCol.add(correctNull(rs.getString("TLR_GCSNO")));
					arrRow.add(arrCol);
				}
				hshRecord.put("TLR_GCCOMLIMIT", Helper.formatDoubleValue(dblgccomlimit));
				hshRecord.put("TLR_GCCOMOS", Helper.formatDoubleValue(dblgccomos));
				hshRecord.put("TLR_GCFBWCLT", Helper.formatDoubleValue(dblgcfbwclt));
				hshRecord.put("TLR_GCFBWCDP", Helper.formatDoubleValue(dblgcfbwcpd));
				hshRecord.put("TLR_GCFBWCOS", Helper.formatDoubleValue(dblgcfbwcos));
				hshRecord.put("TLR_GCTLLT", Helper.formatDoubleValue(dblgctllt));
				hshRecord.put("TLR_GCTLOS", Helper.formatDoubleValue(dblgctlos));
				hshRecord.put("TLR_GCINS", Helper.formatDoubleValue(dblgcins));
				hshRecord.put("arrGroupConcern",arrRow);
				
				//proposal data
				StringBuffer sbfsignatories=null;
				StringBuffer sbfgridcomments=null;
				strQuery = SQLParser.getSqlQuery("tlr_proposaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_proposaldate",correctNull((String)rs.getString("tlr_proposaldate")));
					hshRecord.put("tlr_sancauthority",correctNull((String)rs.getString("tlr_sancauthority")));
					hshRecord.put("tlr_agendano",correctNull((String)rs.getString("tlr_agendano")));
					hshRecord.put("tlr_mcmdate",correctNull((String)rs.getString("tlr_mcmdate")));
					sbfsignatories = new StringBuffer(correctNull(rs.getString("tlr_signatories")));
					hshRecord.put("tlr_mcmresolution",correctNull((String)rs.getString("tlr_mcmresolution")));
					hshRecord.put("tlr_gridmeeting",correctNull((String)rs.getString("tlr_gridmeeting")));
					hshRecord.put("tlr_meetingdate",correctNull((String)rs.getString("tlr_meetingdate")));
					hshRecord.put("tlr_refno",correctNull((String)rs.getString("tlr_refno")));
					
				}
				if(sbfsignatories!=null)
				{
					for (int i = 0;i < sbfsignatories.length(); i++) {
						if (sbfsignatories.charAt(i) == '\n') {
							sbfsignatories.replace(i, i + 1, "<br>");
						}
						if (sbfsignatories.charAt(i) == ' ') {
							sbfsignatories.replace(i, i + 1, "&nbsp;");
						}
					}
					hshRecord.put("tlr_signatories",sbfsignatories.toString());
				}
				
				hshRecord.put("notapplicable","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">N.A</td>");
				hshRecord.put("Nil","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">Nil</td>");
	    		hshRecord.put("custName",strCustName);
				
		 	}catch (Exception exp){
		 		throw new EJBException("Error in getTLReviewCorporatePrint"+ exp.getMessage());
		 	}finally
		 	{
		 		try
		 		{
		 			if(rs!=null)
		 				rs.close();
		 			if(rs1!=null)
		 				rs1.close();
		 		}catch(Exception exp)
		 		{
		 			throw new EJBException("Error in closing the connection in getTLReviewCorporatePrint "+ exp.toString()); 
		 		}
		 	}
		 	
		 	return hshRecord;
	 }
	 
	
	
	public void updateReviewTermLoanYear(HashMap hshValues) 
	{
		try
		{	
				String strCustid = correctNull((String) hshValues.get("cbsid"));
		 		String strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
		 		String strReviewYear = correctNull((String) hshValues.get("txt_year"));
		 		
		 		HashMap hshQuery = new HashMap();
		 		HashMap hshQueryValues=new HashMap();
		 		ArrayList arrValues=new ArrayList();
				arrValues.add(strCustid);
				arrValues.add(strCustAccno);
				arrValues.add(strReviewYear);
				arrValues.add("op");
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				arrValues.add(correctNull((String)hshValues.get("strUserId")));
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","ins_reviewnotetermloanyear"); 
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	 			
	 		
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	
	public HashMap getTypeReviewTermLoan(HashMap hshValues) 
	{	
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		String strCustid = null;
		String strCustAccno = null;
		String strReviewYear = null;
		String strbankingsince = null;
		String strreview_date = null;
		String strTLReviewno = null;

		try
		{
			strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
			strCustid=correctNull((String)hshValues.get("cbsid"));
	 		strCustAccno=correctNull((String)hshValues.get("cbsaccno"));
	 		strReviewYear = correctNull((String) hshValues.get("reviewYear"));
	 		strTLReviewno = correctNull((String) hshValues.get("hidtlrno"));

	 		//temp
	 		String strQuery=SQLParser.getSqlQuery("sel_monlimitregister^"+strCustAccno);
		 	rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
			{
	 			hshRecord.put("reviewOf",correctNull((String)rs.getString("mon_reviewof")));
			}
	 		//end
	 		
			if(rs!=null)
				rs.close();
    		strQuery=SQLParser.getSqlQuery("selReviewNoteForTermLoan^"+strCustid+"^"+strCustAccno+"^"+strReviewYear);
			rs=DBUtils.executeQuery(strQuery);
			
	 		if(rs.next())
	 		{
	 			strbankingsince=correctNull((String)rs.getString("BANKSINCE"));
	 			hshRecord.put("personal_bankingsince",strbankingsince);
	 			
	 			strreview_date=correctNull((String)rs.getString("REVIEWDATE"));
	 			hshRecord.put("LIMIT_REVIEWDATE",strreview_date);
	 		
	 		}
 			if(strbankingsince.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selMonPersonalInfo^"+strCustid);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("personal_bankingsince",correctNull((String)rs.getString("personal_bankingsince")));
				}
			}
	 		
	 		if(strreview_date.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selMonLimitRegister^"+strCustid+"^"+strCustAccno);
			 	rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("LIMIT_REVIEWDATE",correctNull((String)rs.getString("LIMIT_REVIEWDATE")));
					
				}
			}	
	 		hshRecord.put("tlreviewno",strTLReviewno);
			
		}
		catch (Exception e) {
			throw new EJBException(""+e.getMessage());
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
				throw new EJBException("Error closing in getLimitRegister the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
		
	}
	
	public void updateReviewNoteTermLoan(HashMap hshValues) 
	 {
	 	HashMap hshQueryValues=new HashMap();
	 	HashMap hshQuery=new HashMap();
	 	ArrayList arrValues= new ArrayList();
	 	String strCustAccno="", strCustid="", strReviewYear = "";
	 	String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
	 	try
	 	{
	 		strCustid = correctNull((String) hshValues.get("cbsid"));
	 		strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
	 		strReviewYear = correctNull((String) hshValues.get("reviewYear"));
	 		
	 		
	 		
	 		if(strAction.equalsIgnoreCase("update"))
	 		{
	 			arrValues = new ArrayList();
	 			hshQuery = new HashMap();
	 			hshQueryValues.put("size","1");
	 			hshQuery.put("strQueryId","updReviewNoteForTermLoan");

	 			arrValues.add(correctNull((String)hshValues.get("txtNatureValSecurity")));//1
	 			arrValues.add(correctNull((String)hshValues.get("txtPresentStatusPrj")));//2
	 			arrValues.add(correctNull((String)hshValues.get("txtOperationCDAcc")));//3
	 			arrValues.add(correctNull((String)hshValues.get("txtMaxDebit")));//4
	 			arrValues.add(correctNull((String)hshValues.get("txtMaxCredit")));//5
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txtMinDebit")));//6
	 			arrValues.add(correctNull((String)hshValues.get("txtMinCredit")));//7
	 			arrValues.add(correctNull((String)hshValues.get("txtDaysDebit")));//8
	 			arrValues.add(correctNull((String)hshValues.get("txtOperTermLoanACC")));//9
	 			arrValues.add(correctNull((String)hshValues.get("txtRepaySchedule")));//10
	  			
	 			arrValues.add(correctNull((String)hshValues.get("selInstallment")));//11
	 			arrValues.add(correctNull((String)hshValues.get("selInterest")));//12
	 			arrValues.add(correctNull((String)hshValues.get("txtCompliance")));//13
	 			arrValues.add(correctNull((String)hshValues.get("txtCompletionMort")));//14
	 			arrValues.add(correctNull((String)hshValues.get("txtRegistCharge")));//15
	  			
	 			arrValues.add(correctNull((String)hshValues.get("selDocuments")));//16
	 			arrValues.add(correctNull((String)hshValues.get("txtCollSecurityDet")));//17
	 			arrValues.add(correctNull((String)hshValues.get("txtInspectionDate")));//18
	 			arrValues.add(correctNull((String)hshValues.get("txtSecAdequtely")));//19
	 			arrValues.add(correctNull((String)hshValues.get("txtInspectingOfficial")));//20
	  			
	 			arrValues.add(correctNull((String)hshValues.get("txtAuditObserv")));//21
	 			arrValues.add(correctNull((String)hshValues.get("txtRecommendation")));//22
	 			arrValues.add(correctNull((String)hshValues.get("txtActivity")));//23
	 			arrValues.add(correctNull((String)hshValues.get("hidBankSince")));//24
	 			arrValues.add(correctNull((String)hshValues.get("hidReviewDate")));//25
	  			
	 			arrValues.add(correctNull((String)hshValues.get("hidOSAmt")));//26
	 			arrValues.add(correctNull((String)hshValues.get("hidOverDue")));//27
	 			arrValues.add(correctNull((String)hshValues.get("hidDBCDate")));//28
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txtDayscredit")));//29
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txtfirstdisbursement")));//30
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txt_assetclasification")));//31
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txt_purposeofloan")));//32
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txt_datecredit")));//33
	 			
	 			arrValues.add(correctNull((String)hshValues.get("txt_installremarks")));//34
	 			arrValues.add(correctNull((String)hshValues.get("txt_interestremarks")));//35
	 			
	 			arrValues.add(correctNull((String)hshValues.get("hidFacilityname")));//36
	 			arrValues.add(correctNull((String)hshValues.get("hidFacilitylimit")));//37
	 			arrValues.add(correctNull((String)hshValues.get("txtnextreviedate")));//38
	 			
	 			arrValues.add(strCustid);//39
	 			arrValues.add(strCustAccno);//40
	 			arrValues.add(strReviewYear);//41
	 			
	 			hshQuery.put("arrValues",arrValues);
	 			hshQueryValues.put("1",hshQuery);	
	 			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	 		} 
	 		else if(strAction.equalsIgnoreCase("delete"))
	 		{
	 			arrValues = new ArrayList();
	 			hshQuery = new HashMap();
	 			hshQueryValues.put("size","1");
	 			hshQuery.put("strQueryId","updReviewNoteForTermLoan");

	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//5
	 			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//10
	  			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//15
	  			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//20
	  			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//25
	  			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//30
	 			
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");
	 			arrValues.add("");//35
	 			
	 			arrValues.add("");
	 			arrValues.add("");//37
	 			arrValues.add("");//38
	 			
	 			arrValues.add(strCustid);//39
	 			arrValues.add(strCustAccno);//40
	 			arrValues.add(strReviewYear);//41
	 			
	 			hshQuery.put("arrValues",arrValues);
	 			hshQueryValues.put("1",hshQuery);	
	 			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	 		}
	 	}catch (Exception e)
	 	{
	 		throw new EJBException("Error in Insert Data " + e.getMessage());
	 	} 
	 }

	 public HashMap getTLReviewSMEPrint(HashMap hshValues)
	 {
		 	HashMap hshRecord=new HashMap();
		 	ResultSet rs = null;
		 	ResultSet rs1 = null;
		 	String strCustid = null;
		 	String tlrAppno = null;
		 	String strReviewYear = null;
		 	String strQuery = null;
		 	String strCustName = null;
		 	String reviewOf = null;
		 	ArrayList arrCol = null;
		 	ArrayList arrRow = null;
		 	String valuesin = null;
 
		 	try
		 	{
		 		strCustid=correctNull((String)hshValues.get("cbsid"));
		 		tlrAppno=correctNull((String)hshValues.get("hidtlrno"));
		 		strCustName=correctNull((String)hshValues.get("cbsname"));
		 		strReviewYear = correctNull((String) hshValues.get("reviewYear"));
		 		reviewOf = correctNull((String)hshValues.get("reviewOf"));
		 		
//Values in (lacs,crores,Rs.)
		 		strQuery=SQLParser.getSqlQuery("tlr_applications_select^"+tlrAppno);
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			valuesin = correctNull((String)rs.getString("tlr_valuesin"));
		 		}
		 		else{
		 			valuesin = "";
		 		}
		 		hshRecord.put("valuesin",valuesin);
		 		
		 	//Get financial Details
		 	    arrRow = new ArrayList();
		 	    strQuery=SQLParser.getSqlQuery("sel_reviewtermloanfinancial^"+strReviewYear+"^"+strCustid+"^"+tlrAppno+"^"+reviewOf);
		 	   if(rs!=null)
		 			rs.close();
		 	 	rs=DBUtils.executeQuery(strQuery);
		 		while(rs.next())
				{
		 			arrCol = new ArrayList();
		 			arrCol.add(rs.getString("review_firstyear"));
		 			arrCol.add(rs.getString("review_secondyear"));
		 			arrCol.add(rs.getString("review_thirdyear"));
		 			arrCol.add(rs.getString("review_fourthyear"));
		 			arrRow.add(arrCol);
		 	    }
		 		
		 		hshRecord.put("arrRow",arrRow);
		 		strQuery=SQLParser.getSqlQuery("tlr_financialcomments_select^"+tlrAppno);
		 		if(rs!=null)
		 			rs.close();
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			hshRecord.put("comments",correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
		 		}

			   //General Details
				
				strQuery=SQLParser.getSqlQuery("tlr_generaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
			 	rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
				{
		 			hshRecord.put("tlr_proposaltype",correctNull((String)rs.getString("tlr_proposaltype")));
		 			hshRecord.put("tlr_activity",correctNull((String)rs.getString("tlr_activity")));
		 			hshRecord.put("tlr_banksince",correctNull((String)rs.getString("tlr_banksince")));
		 			hshRecord.put("tlr_assetclassify",correctNull((String)rs.getString("assetstatdesc")));
		 			
		 			hshRecord.put("tlr_renewal",correctNull((String)rs.getString("tlr_renewal")));
		 			hshRecord.put("tlr_facilitysince",correctNull((String)rs.getString("tlr_facilitysince")));
		 			hshRecord.put("tlr_nextreview",correctNull((String)rs.getString("tlr_nextreview")));
		 			hshRecord.put("tlr_indcode",correctNull((String)rs.getString("tlr_indcode")));
				}
		 	    //Promoter Details
		 		arrRow=new ArrayList();
		 		strQuery=SQLParser.getSqlQuery("tlr_promoterdetails_select^"+tlrAppno);
		 		if(rs!=null)
		 			rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_prom_sno")));
					arrCol.add(correctNull(rs.getString("tlr_prom_name")));
					arrCol.add(correctNull(rs.getString("tlr_prom_desig")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrPromoterDetails",arrRow);
				//present status of the project
				strQuery = SQLParser.getSqlQuery("tlr_presentstatus_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_presentstatus", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				//BriefBackground
				strQuery = SQLParser.getSqlQuery("tlr_briefbackgroud_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_briefbackground", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				
				//Operation in CD account
				strQuery = SQLParser.getSqlQuery("tlr_cdaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_maxdebit",correctNull((String)rs.getString("tlr_maxdebit")));
					hshRecord.put("tlr_mindebit",correctNull((String)rs.getString("tlr_mindebit")));
					hshRecord.put("tlr_maxcredit",correctNull((String)rs.getString("tlr_maxcredit")));
					hshRecord.put("tlr_mincredit",correctNull((String)rs.getString("tlr_mincredit")));
					hshRecord.put("tlr_noofdaysdebit",correctNull((String)rs.getString("tlr_noofdaysdebit")));
					hshRecord.put("tlr_noofdayscredit",correctNull((String)rs.getString("tlr_noofdayscredit")));
							
				}
				//Operation in TL account
				strQuery = SQLParser.getSqlQuery("tlr_tlaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_repay", correctNull(Helper.CLOBToString(rs.getClob("tlr_repay"))));
					hshRecord.put("tlr_disbursaldate",correctNull((String)rs.getString("tlr_disbursaldate")));
					hshRecord.put("tlr_instalmentpaid",correctNull((String)rs.getString("tlr_instalmentpaid")));
					hshRecord.put("tlr_intserviced",correctNull((String)rs.getString("tlr_intserviced")));
				}
				strQuery = SQLParser.getSqlQuery("tlr_compliance_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_formalities",correctNull((String)rs.getString("tlr_formalities")));
					hshRecord.put("tlr_registrationcharge",correctNull((String)rs.getString("tlr_registrationcharge")));
					hshRecord.put("tlr_doccheck",correctNull((String)rs.getString("tlr_doccheck")));
					hshRecord.put("tlr_dbcdate",correctNull((String)rs.getString("tlr_dbcdate")));
					hshRecord.put("tlr_inspectiondate",correctNull((String)rs.getString("tlr_inspectiondate")));
					hshRecord.put("tlr_secdesc",correctNull((String)rs.getString("tlr_secdesc")));
					hshRecord.put("tlr_observ",correctNull((String)rs.getString("tlr_observ")));
				
					
				}
				arrRow=new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrTermLoanFacility",arrRow);
				strQuery = SQLParser.getSqlQuery("tlr_facilities_totamount^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("proposedlimit",correctNull((String)rs.getString("proposedlimit")));
				}
				//Auditor observation

				String audit_type = "";
				strQuery = SQLParser.getSqlQuery("tlr_auditobservations_selectall^"+tlrAppno);
			
				ArrayList arrInternal=new ArrayList();
				ArrayList arrStatutory =new ArrayList();
				ArrayList arrConcurrent=new ArrayList();
				ArrayList arrStock=new ArrayList();
				ArrayList arrRBI=new ArrayList();
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_auditorcomments")));
					arrCol.add(correctNull(rs.getString("tlr_officercomments")));
					
					audit_type = correctNull((String) rs.getString("tlr_audittype"));
					if (audit_type.equalsIgnoreCase("1")) {
						arrInternal.add(arrCol);
						hshRecord.put("audit_internal_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("2")) {
						arrConcurrent.add(arrCol);
						hshRecord.put("audit_concurrent_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("3")) {
						arrRBI.add(arrCol);
						hshRecord.put("audit_inspection_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("4")) {
						arrStatutory.add(arrCol);
						hshRecord.put("audit_statutory_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("5")) {
						arrStock.add(arrCol);
						hshRecord.put("audit_stock_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
				}
				
				hshRecord.put("arrInternal", arrInternal);
				hshRecord.put("arrConcurrent", arrConcurrent);
				hshRecord.put("arrRBI", arrRBI);
				hshRecord.put("arrStatutory", arrStatutory);
				hshRecord.put("arrStock", arrStock);
				
				//Security Details
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_securities_select_sectype^"+tlrAppno+"^"+"Collateral");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_secno")));
					arrCol.add(correctNull(rs.getString("tlr_sectype")));
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_secdetails")));
					arrCol.add(correctNull(rs.getString("tlr_secremarks")));
					arrCol.add(correctNull(rs.getString("tlr_secvalue")));
					arrCol.add(correctNull(rs.getString("tlr_secdate")));
    				arrRow.add(arrCol);
				}
				hshRecord.put("arrCollSec",arrRow);
				// Facility Details & Security Details
				ArrayList arrSecRow=new ArrayList();
				ArrayList arrSecCol = new ArrayList();
				ArrayList arrSecRemarkscol = new ArrayList();
				ArrayList arrSecRemarksrow = new ArrayList();
				ArrayList arrIntRemarkscol = new ArrayList();
				ArrayList arrIntRemarksrow = new ArrayList();
				
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrIntRemarkscol = new ArrayList();
					String strFacno=correctNull(rs.getString("tlr_facno"));
					arrCol.add(strFacno);
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrIntRemarkscol.add(correctNull(rs.getString("tlr_intremarks")));
					arrIntRemarksrow.add(arrIntRemarkscol);
					arrSecRow=new ArrayList();
					strQuery=SQLParser.getSqlQuery("tlr_securities_select_facilitywise^"+tlrAppno+"^"+strFacno);
					int j=0;
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrSecCol=new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrSecCol.add(correctNull(rs1.getString("tlr_secdetails"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_secvalue"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_margin"))); 
						if(!correctNull(rs1.getString("tlr_secremarks")).equals(""))
						{
							arrSecRemarkscol.add(correctNull(rs1.getString("tlr_secremarks")));
							arrSecRemarksrow.add(arrSecRemarkscol);
						}	
						arrSecRow.add(arrSecCol);
						j++;
					}
					arrCol.add(arrSecRow);
					arrCol.add(Integer.toString(j));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrFacility",arrRow);
				hshRecord.put("arrSecRemarks",arrSecRemarksrow);
				hshRecord.put("arrIntRemarksrow",arrIntRemarksrow);
				
				//Term & conditions
				strQuery = SQLParser.getSqlQuery("tlr_termsdetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_condtions", correctNull(Helper.CLOBToString(rs.getClob("tlr_condtions"))));
						
				}
				//Any other matter
				strQuery = SQLParser.getSqlQuery("tlr_others_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_others", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}

				
				//proposal data
				StringBuffer sbfsignatories=null;
				strQuery = SQLParser.getSqlQuery("tlr_proposaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_proposaldate",correctNull((String)rs.getString("tlr_proposaldate")));
					hshRecord.put("tlr_sancauthority",correctNull((String)rs.getString("tlr_sancauthority")));
					hshRecord.put("tlr_agendano",correctNull((String)rs.getString("tlr_agendano")));
					hshRecord.put("tlr_mcmdate",correctNull((String)rs.getString("tlr_mcmdate")));
					sbfsignatories = new StringBuffer(correctNull(rs.getString("tlr_signatories")));
					hshRecord.put("tlr_mcmresolution",correctNull((String)rs.getString("tlr_mcmresolution")));
					hshRecord.put("tlr_gridmeeting",correctNull((String)rs.getString("tlr_gridmeeting")));
					hshRecord.put("tlr_meetingdate",correctNull((String)rs.getString("tlr_meetingdate")));
					hshRecord.put("tlr_refno",correctNull((String)rs.getString("tlr_refno")));
					
				}
				if(sbfsignatories!=null)
				{
					for (int i = 0;i < sbfsignatories.length(); i++) {
						if (sbfsignatories.charAt(i) == '\n') {
							sbfsignatories.replace(i, i + 1, "<br>");
						}
						if (sbfsignatories.charAt(i) == ' ') {
							sbfsignatories.replace(i, i + 1, "&nbsp;");
						}
					}
					hshRecord.put("tlr_signatories",sbfsignatories.toString());
				}
				
				hshRecord.put("notapplicable","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">N.A</td>");
				hshRecord.put("Nil","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">Nil</td>");
	    		hshRecord.put("custName",strCustName);
				
		 	}catch (Exception exp){
		 		throw new EJBException("Error in getTLReviewSMEPrint"+ exp.getMessage());
		 	}finally
		 	{
		 		try
		 		{
		 			if(rs!=null)
		 				rs.close();
		 			if(rs1!=null)
		 				rs1.close();
		 		}catch(Exception exp)
		 		{
		 			throw new EJBException("Error in closing the connection in getTLReviewSMEPrint "+ exp.toString()); 
		 		}
		 	}
		 	
		 	return hshRecord;
	 }
	 public HashMap getTLReviewRetailPrint(HashMap hshValues)
	 {
		 	HashMap hshRecord=new HashMap();
		 	ResultSet rs = null;
		 	ResultSet rs1 = null;
		 	String tlrAppno = null;
		 	String strQuery = null;
		 	String strCustName = null;
		  	ArrayList arrCol = null;
		 	ArrayList arrRow = null;
		 	String valuesin = null;
		 
 
		 	try
		 	{
		 		
		 		tlrAppno=correctNull((String)hshValues.get("hidtlrno"));
		 		strCustName=correctNull((String)hshValues.get("cbsname"));
		 			 	
		 		//Values in (lacs,crores,Rs.)
		 		strQuery=SQLParser.getSqlQuery("tlr_applications_select^"+tlrAppno);
		 		rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
		 		{
		 			valuesin = correctNull((String)rs.getString("tlr_valuesin"));
		 			hshRecord.put("tlr_status",correctNull((String)rs.getString("tlr_status")));
		 			hshRecord.put("tlr_processedby",correctNull((String)rs.getString("tlr_processedby")));
		 			hshRecord.put("tlr_comments",correctNull((String)rs.getString("tlr_comments")));
		 			hshRecord.put("tlr_processdate",correctNull((String)rs.getString("tlr_processdate")));
		 		}
		 		else{
		 			valuesin = "";
		 		
		 		}
		 		hshRecord.put("valuesin",valuesin);
			   //General Details
				strQuery=SQLParser.getSqlQuery("tlr_generaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
			 	rs=DBUtils.executeQuery(strQuery);
		 		if(rs.next())
				{
		 			hshRecord.put("tlr_proposaltype",correctNull((String)rs.getString("tlr_proposaltype")));
		 			hshRecord.put("tlr_activity",correctNull((String)rs.getString("tlr_activity")));
		 			hshRecord.put("tlr_banksince",correctNull((String)rs.getString("tlr_banksince")));
		 			hshRecord.put("tlr_assetclassify",correctNull((String)rs.getString("assetstatdesc")));
		 			
		 			hshRecord.put("tlr_renewal",correctNull((String)rs.getString("tlr_renewal")));
		 			hshRecord.put("tlr_facilitysince",correctNull((String)rs.getString("tlr_facilitysince")));
		 			hshRecord.put("tlr_nextreview",correctNull((String)rs.getString("tlr_nextreview")));
		 			hshRecord.put("tlr_indcode",correctNull((String)rs.getString("tlr_indcode")));
				}
		 	   
				//present status of the project
				strQuery = SQLParser.getSqlQuery("tlr_presentstatus_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_presentstatus", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
//				BriefBackground
				strQuery = SQLParser.getSqlQuery("tlr_briefbackgroud_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_briefbackground", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
				//Operation in CD account
				strQuery = SQLParser.getSqlQuery("tlr_cdaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_maxdebit",correctNull((String)rs.getString("tlr_maxdebit")));
					hshRecord.put("tlr_mindebit",correctNull((String)rs.getString("tlr_mindebit")));
					hshRecord.put("tlr_maxcredit",correctNull((String)rs.getString("tlr_maxcredit")));
					hshRecord.put("tlr_mincredit",correctNull((String)rs.getString("tlr_mincredit")));
					hshRecord.put("tlr_noofdaysdebit",correctNull((String)rs.getString("tlr_noofdaysdebit")));
											
				}
				//Operation in TL account
				strQuery = SQLParser.getSqlQuery("tlr_tlaccount_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_repay", correctNull(Helper.CLOBToString(rs.getClob("tlr_repay"))));
					hshRecord.put("tlr_disbursaldate",correctNull((String)rs.getString("tlr_disbursaldate")));
					hshRecord.put("tlr_instalmentpaid",correctNull((String)rs.getString("tlr_instalmentpaid")));
					hshRecord.put("tlr_intserviced",correctNull((String)rs.getString("tlr_intserviced")));
				}
				strQuery = SQLParser.getSqlQuery("tlr_compliance_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_formalities",correctNull((String)rs.getString("tlr_formalities")));
					hshRecord.put("tlr_registrationcharge",correctNull((String)rs.getString("tlr_registrationcharge")));
					hshRecord.put("tlr_doccheck",correctNull((String)rs.getString("tlr_doccheck")));
					hshRecord.put("tlr_dbcdate",correctNull((String)rs.getString("tlr_dbcdate")));
					hshRecord.put("tlr_inspectiondate",correctNull((String)rs.getString("tlr_inspectiondate")));
					hshRecord.put("tlr_secdesc",correctNull((String)rs.getString("tlr_secdesc")));
					hshRecord.put("tlr_observ",correctNull((String)rs.getString("tlr_observ")));
				
					
				}
				arrRow=new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrTermLoanFacility",arrRow);
				strQuery = SQLParser.getSqlQuery("tlr_facilities_totamount^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					hshRecord.put("proposedlimit",correctNull((String)rs.getString("proposedlimit")));
				}
				//Auditor observation

				String audit_type = "";
				strQuery = SQLParser.getSqlQuery("tlr_auditobservations_selectall^"+tlrAppno);
			
				ArrayList arrInternal=new ArrayList();
				ArrayList arrStatutory =new ArrayList();
				ArrayList arrConcurrent=new ArrayList();
				ArrayList arrStock=new ArrayList();
				ArrayList arrRBI=new ArrayList();
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_auditorcomments")));
					arrCol.add(correctNull(rs.getString("tlr_officercomments")));
					
					audit_type = correctNull((String) rs.getString("tlr_audittype"));
					if (audit_type.equalsIgnoreCase("1")) {
						arrInternal.add(arrCol);
						hshRecord.put("audit_internal_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("2")) {
						arrConcurrent.add(arrCol);
						hshRecord.put("audit_concurrent_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("3")) {
						arrRBI.add(arrCol);
						hshRecord.put("audit_inspection_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("4")) {
						arrStatutory.add(arrCol);
						hshRecord.put("audit_statutory_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
					if (audit_type.equalsIgnoreCase("5")) {
						arrStock.add(arrCol);
						hshRecord.put("audit_stock_date","&nbsp; as on &nbsp;"+correctNull(rs.getString("tlr_auditdate")));
					}
				}
				
				hshRecord.put("arrInternal", arrInternal);
				hshRecord.put("arrConcurrent", arrConcurrent);
				hshRecord.put("arrRBI", arrRBI);
				hshRecord.put("arrStatutory", arrStatutory);
				hshRecord.put("arrStock", arrStock);
				
				//Security Details
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_securities_select_sectype^"+tlrAppno+"^"+"Collateral");
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_secno")));
					arrCol.add(correctNull(rs.getString("tlr_sectype")));
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_secdetails")));
					arrCol.add(correctNull(rs.getString("tlr_secremarks")));
					arrCol.add(correctNull(rs.getString("tlr_secvalue")));
					arrCol.add(correctNull(rs.getString("tlr_secdate")));
    				arrRow.add(arrCol);
				}
				hshRecord.put("arrCollSec",arrRow);
				// Facility Details & Security Details
				ArrayList arrSecRow=new ArrayList();
				ArrayList arrSecCol = new ArrayList();
				ArrayList arrSecRemarkscol = new ArrayList();
				ArrayList arrSecRemarksrow = new ArrayList();
				ArrayList arrIntRemarkscol = new ArrayList();
				ArrayList arrIntRemarksrow = new ArrayList();
				
				arrRow = new ArrayList();
				strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrIntRemarkscol = new ArrayList();
					String strFacno=correctNull(rs.getString("tlr_facno"));
					arrCol.add(strFacno);
					arrCol.add(correctNull(rs.getString("tlr_facname")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					if(valuesin.trim().equalsIgnoreCase("L"))
					{
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToLakhs(rs.getString("tlr_overdue")));
					}else if(valuesin.trim().equalsIgnoreCase("C"))
					{
						arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
						arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));
					}
					else
					{
						arrCol.add(correctNull(rs.getString("tlr_existlimit")));
						arrCol.add(correctNull(rs.getString("tlr_oslimit")));
						arrCol.add(correctNull(rs.getString("tlr_overdue")));
					}
					arrCol.add(correctNull(rs.getString("tlr_facscheme")));
					arrCol.add(correctNull(rs.getString("tlr_proposed")));
					arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
					arrCol.add(correctNull(rs.getString("tlr_intremarks")));
					arrCol.add(correctNull(rs.getString("tlr_loanpurpose")));
					arrIntRemarkscol.add(correctNull(rs.getString("tlr_intremarks")));
					arrIntRemarksrow.add(arrIntRemarkscol);
					arrSecRow=new ArrayList();
					strQuery=SQLParser.getSqlQuery("tlr_securities_select_facilitywise^"+tlrAppno+"^"+strFacno);
					int j=0;
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						arrSecCol=new ArrayList();
						arrSecRemarkscol=new ArrayList();
						arrSecCol.add(correctNull(rs1.getString("tlr_secdetails"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_secvalue"))); 
						arrSecCol.add(correctNull(rs1.getString("tlr_margin"))); 
						if(!correctNull(rs1.getString("tlr_secremarks")).equals(""))
						{
							arrSecRemarkscol.add(correctNull(rs1.getString("tlr_secremarks")));
							arrSecRemarksrow.add(arrSecRemarkscol);
						}
						arrSecRow.add(arrSecCol);
						j++;
					}
					arrCol.add(arrSecRow);
					arrCol.add(Integer.toString(j));
					arrRow.add(arrCol);
					
				}
				hshRecord.put("arrFacility",arrRow);
				hshRecord.put("arrSecRemarks",arrSecRemarksrow);
				hshRecord.put("arrIntRemarksrow",arrIntRemarksrow);
				
			
				//Any other matter
				strQuery = SQLParser.getSqlQuery("tlr_others_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("tlr_others", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
				}
						
				//proposal data
				StringBuffer sbfsignatories=null;
				strQuery = SQLParser.getSqlQuery("tlr_proposaldetails_select^"+tlrAppno);
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshRecord.put("tlr_proposaldate",correctNull((String)rs.getString("tlr_proposaldate")));
					sbfsignatories = new StringBuffer(correctNull(rs.getString("tlr_signatories")));
					hshRecord.put("tlr_refno",correctNull((String)rs.getString("tlr_refno")));
					
				}
				if(sbfsignatories!=null)
				{
					for (int i = 0;i < sbfsignatories.length(); i++) {
						if (sbfsignatories.charAt(i) == '\n') {
							sbfsignatories.replace(i, i + 1, "<br>");
						}
						if (sbfsignatories.charAt(i) == ' ') {
							sbfsignatories.replace(i, i + 1, "&nbsp;");
						}
					}
					hshRecord.put("tlr_signatories",sbfsignatories.toString());
				}
				
				   if(rs!=null)rs.close();
			       rs = DBUtils.executeLAPSQuery("tlr_mailboxcomments_select^"+tlrAppno);
			       arrRow=new ArrayList();
			       arrCol=new ArrayList();
			       while(rs.next())
			       {
			    	   arrCol=new ArrayList();
			    	   arrCol.add(correctNull(rs.getString("usr_fname")));
			    	   arrCol.add(correctNull(Helper.CLOBToString(rs.getClob("mail_comments"))));
			    	   arrRow.add(arrCol);
			       }
			       
			       hshRecord.put("mailcomments",arrRow);
				
				hshRecord.put("notapplicable","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">N.A</td>");
				hshRecord.put("Nil","<td valign=\"top\" width=\"3%\">&nbsp;</td><td valign=\"top\" colspan=\"3\">Nil</td>");
	    		hshRecord.put("custName",strCustName);
				
		 	}catch (Exception exp){
		 		throw new EJBException("Error in getTLReviewRetailPrint"+ exp.getMessage());
		 	}finally
		 	{
		 		try
		 		{
		 			if(rs!=null)
		 				rs.close();
		 			if(rs1!=null)
		 				rs1.close();
		 		}catch(Exception exp)
		 		{
		 			throw new EJBException("Error in closing the connection in getTLReviewRetailPrint "+ exp.toString()); 
		 		}
		 	}
		 	
		 	return hshRecord;
	 }
	 
	 public HashMap getReviewYear(HashMap hshRequestValues) 
		{

			ResultSet rs = null;
			HashMap hshRecord = new HashMap();
			String strcbsCustId = (String) hshRequestValues.get("cbsCustId");
			String strcbsAccNo = (String) hshRequestValues.get("cbsAccNo");
			String strQuery = null;
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;

			try
			{
				strQuery = SQLParser.getSqlQuery("getReviewYear^" + strcbsCustId +"^"+strcbsAccNo);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next())
				{
					arrCol = new ArrayList();
					arrCol.add(correctNull(rs.getString(1)));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);
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
		
		public HashMap getReviewYearAndStatus(HashMap hshRequestValues) 
		{

			ResultSet rs = null;
			ResultSet rs1 = null;
			HashMap hshRecord = new HashMap();
			String strcbsCustId = correctNull((String) hshRequestValues.get("cbsid"));
			String strcbsAccNo = correctNull((String) hshRequestValues.get("cbsaccno"));
			String strQuery = null;
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = null;
			String newButtonDisable=null;
			String tempString=null;
			String strreviewyear="";
			String strtousrid=""; 
			
			try
			{
				strQuery = SQLParser.getSqlQuery("getReviewYear^" + strcbsCustId +"^"+strcbsAccNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strtousrid="";
					arrCol = new ArrayList();
					strreviewyear=correctNull(rs.getString("reviewyear"));
					arrCol.add(strreviewyear);
					
					if(correctNull(rs.getString("review_status")).equals("pa"))
					{
						tempString = "Approved";
					}
					else
					{
						tempString = "Pending";
					}
					arrCol.add(tempString);
					
					strQuery=SQLParser.getSqlQuery("sel_reviewcurtholder^"+strcbsCustId+"^"+strcbsAccNo+"^"+strreviewyear+"^"+strcbsCustId+"^"+strcbsAccNo+"^"+strreviewyear);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strtousrid=correctNull(rs1.getString("MON_TERMLOANREVIEW_TOUSRID"));		
					}
					if(strtousrid.equals(correctNull((String) hshRequestValues.get("strUserId"))) || strtousrid.equalsIgnoreCase(""))
					{
						arrCol.add("O");
					}
					else
					{
						arrCol.add("C");
					}
					if(correctNull(rs.getString("review_status")).equals("op"))
					{
						newButtonDisable = "Y";
					}
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow", arrRow);
				hshRecord.put("newButtonDisable",newButtonDisable);
				
			
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
		public void updateAuditorObservationData(HashMap hsh) 
		{
			HashMap hshqueryval =new HashMap();
			HashMap hshquery = new HashMap();
			ArrayList arrValues = new ArrayList();
			String strAppno="";
			String strSelAuditType="";
			String strAction="";
			String strSno="";
			ResultSet rs=null;
			
			try
			{
				strSelAuditType=correctNull((String)hsh.get("sel_audittype"));
				strAction=correctNull((String)hsh.get("hidAction"));
				strSno=correctNull((String)hsh.get("hidsno"));
				strAppno=correctNull((String)hsh.get("hidtlrno"));
				if(strAction.equalsIgnoreCase("insert"))
				{
					arrValues = new ArrayList();
					hshquery = new HashMap();
					hshqueryval = new HashMap();
					
					String strQuery=SQLParser.getSqlQuery("tlr_auditobservations_max^"+strAppno+"^"+strSelAuditType);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSno=correctNull(rs.getString("maxcnt"));
					}
					
					arrValues.add(strAppno);
					arrValues.add(strSno);
					arrValues.add(strSelAuditType);
					arrValues.add(correctNull((String)hsh.get("txt_auditorsobservations")));
					arrValues.add(correctNull((String)hsh.get("txt_branchcomments")));
					arrValues.add(correctNull((String)hsh.get("auditdate")));
			    	hshqueryval.put("1",hshquery);
					hshquery.put("arrValues",arrValues);			
					hshquery.put("strQueryId","tlr_auditobservations_insert");
					hshqueryval.put("size","1");			
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				else if(strAction.equalsIgnoreCase("update"))
				{
					arrValues = new ArrayList();
					hshquery = new HashMap();
					hshqueryval = new HashMap();
					
					arrValues.add(correctNull((String)hsh.get("txt_auditorsobservations")));
					arrValues.add(correctNull((String)hsh.get("txt_branchcomments")));
					arrValues.add(correctNull((String)hsh.get("auditdate")));
					arrValues.add(strSno);
					arrValues.add(strSelAuditType);
					arrValues.add(strAppno);
					
					hshqueryval.put("1",hshquery);
					hshquery.put("arrValues",arrValues);			
					hshquery.put("strQueryId","tlr_auditobservations_update");
					hshqueryval.put("size","1");			
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}
				else if(strAction.equalsIgnoreCase("delete"))
				{
					hshqueryval = new HashMap();
					hshquery = new HashMap();	
					arrValues = new ArrayList();
					
					arrValues.add(strAppno);
					arrValues.add(strSelAuditType);
					arrValues.add(strSno);
					
					hshqueryval.put("size","1");
					hshquery.put("strQueryId","tlr_auditobservations_delete");						
					hshquery.put("arrValues",arrValues);
					hshqueryval.put("1",hshquery);
					EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				}

			}catch(Exception e)
			{
				throw new EJBException("Exception in updateAuditorObservationData"+e.getMessage());
			}
		}
		
		public HashMap getAuditorObservationData(HashMap hsh) 
		{
			HashMap hshValues = new HashMap();
			String strSelType = "";
			String strAppno = "";
			ResultSet rs =null;
			ArrayList arrCol=new ArrayList();
			ArrayList arrRow=new ArrayList();
			
			try
			{
				strAppno = Helper.correctNull((String)hsh.get("hidtlrno"));
				strSelType=correctNull((String)hsh.get("sel_audittype"));
				
				String strQuery = SQLParser.getSqlQuery("tlr_auditobservations_selectone^"+strAppno+"^"+strSelType);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_auditorcomments")));
					arrCol.add(correctNull(rs.getString("tlr_officercomments")));
					arrCol.add(correctNull(rs.getString("tlr_auditsno")));
					hshValues.put("auditdate",correctNull(rs.getString("tlr_auditdate")));
					arrRow.add(arrCol);
				}
				hshValues.put("arrRow",arrRow);
				hshValues.put("seltype",strSelType);
										
			}catch(Exception e)
			{
				throw new EJBException("Exception in getAuditorObservationData"+e.getMessage());
			}
			return hshValues;
		}
		
		public void updateSecuritiesData(HashMap hshValues)
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			String strAppno="",strQuery = "";
			ResultSet rs = null;
			String strAction="";
			String strSecno="";
			String strFacsno="";
			String strSectype="";
			int intUpdatesize=0;
			StringBuilder sbAuditDataOld = new StringBuilder();
			try
			{
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strSecno=correctNull((String)hshValues.get("hidsno"));
				strSectype=correctNull((String)hshValues.get("selsectype"));
				
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
				{
					if(rs != null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("gettlrsecuritydet^"+strSecno+"^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						sbAuditDataOld
						.append("Security Type =" +ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull((String)rs.getString("TLR_SECTYPE"))));
						if(correctNull((String)rs.getString("TLR_SECTYPE")).equalsIgnoreCase("Primary")){
						sbAuditDataOld
						.append("~ Facility =" +correctNull((String)rs.getString("TLR_CBSACCNO")) +"-"+ correctNull((String)rs.getString("TLR_FACNAME")));
						}
						sbAuditDataOld
						.append("~ Margin (%) =" +correctNull((String)rs.getString("TLR_MARGIN")))
						.append("~ Security Value =" +Helper.formatDoubleValue(rs.getDouble("TLR_SECVALUE")))
						.append("~ Date of Last Valuation =" +correctNull((String)rs.getString("TLR_SECDATE")));
					}
				}
				if(strSectype.equalsIgnoreCase("Primary"))
				{
					strFacsno=correctNull((String)hshValues.get("selfacility"));
				}
				
				if(strAction.equals("Insert"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					strSecno=getMaxsecno(strAppno);
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					arrValues.add(correctNull((String)hshValues.get("selsectype")));
					arrValues.add(strFacsno);
					arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
					arrValues.add(correctNull((String)hshValues.get("txtsecremarks")));
					arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
					arrValues.add(correctNull((String)hshValues.get("txt_lastvaluationdate")));
					arrValues.add(correctNull((String)hshValues.get("txt_secmargin")));
					hshQuery.put("strQueryId","tlr_securities_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
    				arrValues.add(correctNull((String)hshValues.get("selsectype")));
					arrValues.add(strFacsno);
					arrValues.add(correctNull((String)hshValues.get("txtsecdetails")));
					arrValues.add(correctNull((String)hshValues.get("txtsecremarks")));
					arrValues.add(correctNull((String)hshValues.get("txtsecvalue")));
					arrValues.add(correctNull((String)hshValues.get("txt_lastvaluationdate")));
					arrValues.add(correctNull((String)hshValues.get("txt_secmargin")));
		        	arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_securities_update");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_securities_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
					.append("Security Type =" +ApplicantParams.getApplicantParams("SECURITYTYPE", correctNull((String)hshValues.get("selsectype"))));
					if(correctNull((String)hshValues.get("selsectype")).equalsIgnoreCase("Primary")){
					sbAuditData
					.append("~ Facility =" +correctNull((String)hshValues.get("hidFacility")));
					}
					sbAuditData
					.append("~ Margin (%) =" +correctNull((String)hshValues.get("txt_secmargin")))
					.append("~ Security Value =" +correctNull((String)hshValues.get("txtsecvalue")))
					.append("~ Date of Last Valuation =" +correctNull((String)hshValues.get("txt_lastvaluationdate")));
				}
				AuditTrial.auditNewLog(hshValues, "329", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			}catch(Exception ex)
			{
				throw new EJBException("Error in updateSecuritiesData:: "+ex.toString());
			}
		}
		
		private String getMaxsecno(String strAppno) 
		{
			String strSecno="";
			ResultSet rs=null;
			String strQuery="";
			try
			{
				strQuery=SQLParser.getSqlQuery("tlr_securities_max^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSecno=rs.getString("snomax");
				}
				
			}catch(Exception ex)
			{
				throw new EJBException("Error in getMaxsecno :: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return strSecno;
		}
		
		public HashMap getSecuritiesData(HashMap hshValues)
		{
			HashMap hshRecord=null;
		    ResultSet rs=null;
			String strAppno="";
			String strQuery="";
			
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				hshRecord=new HashMap();
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strQuery=SQLParser.getSqlQuery("tlr_securities_select^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_secno")));
					arrCol.add(correctNull(rs.getString("tlr_sectype")));
					arrCol.add(correctNull(rs.getString("tlr_facno")));
					arrCol.add(correctNull(rs.getString("tlr_secdetails")));
					arrCol.add(correctNull(rs.getString("tlr_secremarks")));
					arrCol.add(correctNull(rs.getString("tlr_secvalue")));
					arrCol.add(correctNull(rs.getString("tlr_secdate")));
					arrCol.add(correctNull(rs.getString("tlr_margin")));
    				arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
			}catch(Exception ex)
			{
				throw new EJBException("Error in getSecuritiesData:: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return hshRecord;
		}
		public void updatePromotersData(HashMap hshValues)
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			String strAppno="",strQuery = "";
			String strAction="";
			String strSecno="";
			int intUpdatesize=0;
			ResultSet rs = null;
			StringBuilder sbAuditDataOld = new StringBuilder();
			try
			{
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strSecno=correctNull((String)hshValues.get("hidsno"));
							
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
				{
					if(rs != null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("gettlrpromoterdet^"+strAppno+"^"+strSecno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
					sbAuditDataOld
					.append("Name =" +correctNull((String)rs.getString("TLR_PROM_NAME")))
					.append("~ Designation =" +correctNull((String)rs.getString("TLR_PROM_DESIG")));
					}
				}
				if(strAction.equals("Insert"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					strSecno=getMaxpromoterno(strAppno);
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					arrValues.add(correctNull((String)hshValues.get("txt_proname")));
					arrValues.add(correctNull((String)hshValues.get("txt_desig")));
					hshQuery.put("strQueryId","tlr_promoterdetails_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
    				arrValues.add(correctNull((String)hshValues.get("txt_proname")));
					arrValues.add(correctNull((String)hshValues.get("txt_desig")));
				   	arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_promoterdetails_update");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_promoterdetails_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
					.append("Name =" +correctNull((String)hshValues.get("txt_proname")))
					.append("~ Designation =" +correctNull((String)hshValues.get("txt_desig")));
				}
				AuditTrial.auditNewLog(hshValues, "327", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			}catch(Exception ex)
			{
				throw new EJBException("Error in updatePromotersData:: "+ex.toString());
			}
		}
		
		private String getMaxpromoterno(String strAppno) 
		{
			String strSecno="";
			ResultSet rs=null;
			String strQuery="";
			try
			{
				strQuery=SQLParser.getSqlQuery("tlr_promoterdetails_max^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSecno=rs.getString("snomax");
				}
				
			}catch(Exception ex)
			{
				throw new EJBException("Error in getMaxpromoterno :: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return strSecno;
		}
		
		public HashMap getPromotersData(HashMap hshValues)
		{
			HashMap hshRecord=null;
		    ResultSet rs=null;
			String strAppno="";
			String strQuery="";
			
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				hshRecord=new HashMap();
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strQuery=SQLParser.getSqlQuery("tlr_promoterdetails_select^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("tlr_prom_sno")));
					arrCol.add(correctNull(rs.getString("tlr_prom_name")));
					arrCol.add(correctNull(rs.getString("tlr_prom_desig")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
			}catch(Exception ex)
			{
				throw new EJBException("Error in getPromotersData:: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return hshRecord;
		}
		public void updateGroupConcernData(HashMap hshValues)
		{
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = new HashMap();
			ArrayList arrValues = new ArrayList();
			
			String strAppno="",strQuery = "";
			ResultSet rs = null;
			String strAction="";
			String strSecno="";
			int intUpdatesize=0;
			StringBuilder sbAuditDataOld = new StringBuilder();
			try
			{
				strAction=correctNull((String)hshValues.get("hidAction"));
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strSecno=correctNull((String)hshValues.get("hidsno"));
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
				{
					if(rs != null)
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("getpromgroupcondet^"+strAppno+"^"+strSecno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						sbAuditDataOld
						.append("Name of the Concern =" +correctNull((String)rs.getString("TLR_GCCONNAME")))
						.append("~ Branch =" +correctNull((String)rs.getString("TLR_GCBRANCH")))
						.append("~ CoA =" +correctNull((String)rs.getString("TLR_GCCOA")))
						.append("~ Contingent Limit =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCCOMLIMIT")))
						.append("~ Contingent O/S =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCCOMOS")))
						.append("~ FBWC Limit =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCFBWCLT")))
						.append("~ FBWC DP =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCFBWCDP")))
						.append("~ FBWC O/S =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCFBWCOS")))
						.append("~ TermLoan Limit =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCTLLT")))
						.append("~ TermLoan O/S =" +Helper.formatDoubleValue(rs.getDouble("TLR_GCTLOS")))
						.append("~ Investment =" +correctNull((String)rs.getString("TLR_GCINS")))
						.append("~ MOR =" +correctNull((String)rs.getString("TLR_GCMOR")))
						.append("~ Irregularity =" +correctNull((String)rs.getString("TLR_GCIRREG")));
					}
				}
							
				if(strAction.equals("Insert"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					strSecno=getMaxGroupConcernNo(strAppno);
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					arrValues.add(correctNull((String)hshValues.get("txt_concern")));
					arrValues.add(correctNull((String)hshValues.get("txt_brch")));
					arrValues.add(correctNull((String)hshValues.get("txt_coa")));
					arrValues.add(correctNull((String)hshValues.get("txt_climit")));
					arrValues.add(correctNull((String)hshValues.get("txt_cos")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwclim")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwcdp")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwcos1")));
			    	arrValues.add(correctNull((String)hshValues.get("txt_tllimit")));
					arrValues.add(correctNull((String)hshValues.get("txt_tlos")));
					arrValues.add(correctNull((String)hshValues.get("txt_inv")));
					arrValues.add(correctNull((String)hshValues.get("txt_mor2")));
					arrValues.add(correctNull((String)hshValues.get("txt_irr")));
					
					hshQuery.put("strQueryId","tlr_groupconcerns_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Update"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(correctNull((String)hshValues.get("txt_concern")));
					arrValues.add(correctNull((String)hshValues.get("txt_brch")));
					arrValues.add(correctNull((String)hshValues.get("txt_coa")));
					arrValues.add(correctNull((String)hshValues.get("txt_climit")));
					arrValues.add(correctNull((String)hshValues.get("txt_cos")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwclim")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwcdp")));
					arrValues.add(correctNull((String)hshValues.get("txt_fbwcos1")));
			    	arrValues.add(correctNull((String)hshValues.get("txt_tllimit")));
					arrValues.add(correctNull((String)hshValues.get("txt_tlos")));
					arrValues.add(correctNull((String)hshValues.get("txt_inv")));
					arrValues.add(correctNull((String)hshValues.get("txt_mor2")));
					arrValues.add(correctNull((String)hshValues.get("txt_irr")));
				   	arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_groupconcerns_update");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(strAction.equals("Delete"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strAppno);
					arrValues.add(strSecno);
					hshQuery.put("strQueryId","tlr_groupconcerns_delete");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
					.append("Name of the Concern =" +correctNull((String)hshValues.get("txt_concern")))
					.append("~ Branch =" +correctNull((String)hshValues.get("txt_brch")))
					.append("~ CoA =" +correctNull((String)hshValues.get("txt_coa")))
					.append("~ Contingent Limit =" +correctNull((String)hshValues.get("txt_climit")))
					.append("~ Contingent O/S =" +correctNull((String)hshValues.get("txt_cos")))
					.append("~ FBWC Limit =" +correctNull((String)hshValues.get("txt_fbwclim")))
					.append("~ FBWC DP =" +correctNull((String)hshValues.get("txt_fbwcdp")))
					.append("~ FBWC O/S =" +correctNull((String)hshValues.get("txt_fbwcos1")))
					.append("~ TermLoan Limit =" +correctNull((String)hshValues.get("txt_tllimit")))
					.append("~ TermLoan O/S =" +correctNull((String)hshValues.get("txt_tlos")))
					.append("~ Investment =" +correctNull((String)hshValues.get("txt_inv")))
					.append("~ MOR =" +correctNull((String)hshValues.get("txt_mor2")))
					.append("~ Irregularity =" +correctNull((String)hshValues.get("txt_irr")));
				}
				AuditTrial.auditNewLog(hshValues, "328", strAppno, sbAuditData.toString(), sbAuditDataOld.toString());
			}catch(Exception ex)
			{
				throw new EJBException("Error in updateGroupConcernData:: "+ex.toString());
			}
		}
		
		private String getMaxGroupConcernNo(String strAppno) 
		{
			String strSecno="";
			ResultSet rs=null;
			String strQuery="";
			try
			{
				strQuery=SQLParser.getSqlQuery("tlr_groupconcerns_max^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSecno=rs.getString("snomax");
				}
				
			}catch(Exception ex)
			{
				throw new EJBException("Error in getMaxGroupConcernNo :: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return strSecno;
		}
		
		public HashMap getGroupConcernData(HashMap hshValues)
		{
			HashMap hshRecord=null;
		    ResultSet rs=null;
			String strAppno="";
			String strQuery="";
			
			ArrayList arrRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			try
			{
				hshRecord=new HashMap();
				strAppno=correctNull((String)hshValues.get("hidtlrno"));
				strQuery=SQLParser.getSqlQuery("tlr_groupconcerns_select^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("TLR_GCCONNAME")));
					arrCol.add(correctNull(rs.getString("TLR_GCBRANCH")));
					arrCol.add(correctNull(rs.getString("TLR_GCCOA")));
					arrCol.add(correctNull(rs.getString("TLR_GCCOMLIMIT")));
					arrCol.add(correctNull(rs.getString("TLR_GCCOMOS")));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCLT")));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCDP")));
					arrCol.add(correctNull(rs.getString("TLR_GCFBWCOS")));
					arrCol.add(correctNull(rs.getString("TLR_GCTLLT")));
					arrCol.add(correctNull(rs.getString("TLR_GCTLOS")));
					arrCol.add(correctNull(rs.getString("TLR_GCINS")));
					arrCol.add(correctNull(rs.getString("TLR_GCMOR")));
					arrCol.add(correctNull(rs.getString("TLR_GCIRREG")));
					arrCol.add(correctNull(rs.getString("TLR_GCSNO")));
					arrRow.add(arrCol);
				}
				hshRecord.put("arrRow",arrRow);
			}catch(Exception ex)
			{
				throw new EJBException("Error in getGroupConcernData:: "+ex.toString());
			}
			finally
			{
				try{
					if(rs!=null)
						rs.close();
				}catch(Exception ex)
				{
					throw new EJBException("Error in Closing Connection"+ex.toString());
				}
			}
			return hshRecord;
		}
}
