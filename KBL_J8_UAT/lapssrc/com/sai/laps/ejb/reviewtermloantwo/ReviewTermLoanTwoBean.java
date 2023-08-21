package com.sai.laps.ejb.reviewtermloantwo;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "ReviewTermLoanTwoBean", mappedName = "ReviewTermLoanTwoHome")
@Remote (ReviewTermLoanTwoRemote.class)
public class ReviewTermLoanTwoBean extends BeanAdapter
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1588917774981690674L;
	
	static Logger log=Logger.getLogger(ReviewTermLoanTwoBean.class);
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
		    	strTLReviewNo = correctNull((String) hshValues.get("hidtlrno"));
	

		    	if(!strTLReviewNo.equals("New") && !strTLReviewNo.equals(""))
				{
		    		if(strAction.equals("update"))
					{
		    			arrValues=new ArrayList();
						hshQuery=new HashMap();
						intUpdatesize++;
    					arrValues.add(correctNull((String)hshValues.get("reviewOf")));
				 		arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
				 		arrValues.add(correctNull((String)hshValues.get("hidBankSince")));
				 		arrValues.add(correctNull((String)hshValues.get("sel_assetclasification")));
						arrValues.add(correctNull((String)hshValues.get("txt_renewaldate")));
						arrValues.add(correctNull((String)hshValues.get("txt_creditfacsince")));
						arrValues.add(correctNull((String)hshValues.get("txt_nextreviewdate")));
						arrValues.add(correctNull((String)hshValues.get("comapp_indcode")));
						arrValues.add(strTLReviewNo);
						hshQuery.put("strQueryId","tlr_generaldetails_update");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						intUpdatesize++;
    					arrValues.add(correctNull((String)hshValues.get("sel_valuesin")));
    					arrValues.add(strTLReviewNo);
						hshQuery.put("strQueryId","tlr_applications_update_valuesin");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
						
						
			 			
			    	}else if(strAction.equals("delete"))
			    	{
			    		arrValues=new ArrayList();
						hshQuery=new HashMap();
						intUpdatesize++;
						arrValues.add(strTLReviewNo);
						hshQuery.put("strQueryId","tlr_generaldetails_delete");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		    		
			    	}
		    		
		    	}
		    	else
		    	{
		    		String solid = correctNull((String)hshValues.get("strSolid"));
		    		strTLReviewNo = strCustid+solid+strReviewYear;
		 			
		 			arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strTLReviewNo);
					arrValues.add(correctNull((String)hshValues.get("reviewOf")));
			 		arrValues.add(correctNull((String)hshValues.get("comapp_companyid")));
			 		arrValues.add(correctNull((String)hshValues.get("hidBankSince")));
			 		arrValues.add(correctNull((String)hshValues.get("sel_assetclasification")));
					arrValues.add(correctNull((String)hshValues.get("txt_renewaldate")));
					arrValues.add(correctNull((String)hshValues.get("txt_creditfacsince")));
					arrValues.add(correctNull((String)hshValues.get("txt_nextreviewdate")));
					arrValues.add(correctNull((String)hshValues.get("comapp_indcode")));
					hshQuery.put("strQueryId","tlr_generaldetails_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					
					//Insert application Details
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					intUpdatesize++;
					arrValues.add(strTLReviewNo);
					arrValues.add(strReviewYear);
			 		arrValues.add(strCustid);
			 		arrValues.add(correctNull((String)hshValues.get("strUserId")));
			 		arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("sel_valuesin")));
					hshQuery.put("strQueryId","tlr_applications_insert");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					//end
					
					//Insert Facility Deatails
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
								arrValues.add(correctNull(rs.getString("FUND_ACCNO")));
								hshQuery.put("strQueryId","tlr_facilities_insert");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));	
								
							}
					//End
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		    	}
		    	
				hshValues.put("tlreviewno",strTLReviewNo);
				hshRecord = getTypeReviewTermLoan(hshValues);
				hshRecord.put("tlreviewno",strTLReviewNo);
				
				StringBuilder sbAuditData=new StringBuilder();
				String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
				if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete")){
					hshValues.put("strAction", "update");
				}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
					hshValues.put("strAction", "insert");
				}
				if(!strAction.equalsIgnoreCase("delete"))
				{
					sbAuditData
					.append("Proposal Type =" +ApplicantParams.getApplicantParams("PROPOSALTYPES", correctNull((String)hshValues.get("reviewOf"))))
					.append("~ Activity =" +correctNull((String)hshValues.get("comapp_companyid")))
					.append("~ Dealing with Bank since =" +correctNull((String)hshValues.get("hidBankSince")))
					.append("~ Asset Classification =" +correctNull((String)hshValues.get("hidAssetClass")))
					.append("~ Renewal Due =" +correctNull((String)hshValues.get("txt_renewaldate")))
					.append("~ Credit facilities since =" +correctNull((String)hshValues.get("txt_creditfacsince")))
					.append("~ Next Review Date =" +correctNull((String)hshValues.get("txt_nextreviewdate")))
					.append("~ Proposal in =" +ApplicantParams.getApplicantParams("PROPOSALIN", correctNull((String)hshValues.get("sel_valuesin"))));
				}
				AuditTrial.auditLog(hshValues, "325", strTLReviewNo, sbAuditData.toString());
		
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
	public HashMap getTypeReviewTermLoan(HashMap hshValues) 
	{	
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		String strCustid = null;
		String strTLReviewno = null;
		String strQuery = null;
		try
		{
			strQuery ="";
			strCustid=correctNull((String)hshValues.get("cbsid"));
	 		strTLReviewno = correctNull((String)hshValues.get("hidtlrno"));
	 		
	 		if(strTLReviewno.equals("") || strTLReviewno.equalsIgnoreCase("New"))
	 	    	strTLReviewno = correctNull((String)hshValues.get("tlreviewno"));
	 		
	 		 	   
			strQuery=SQLParser.getSqlQuery("selMonPersonalInfo^"+strCustid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("personal_bankingsince",correctNull((String)rs.getString("personal_bankingsince")));
			
			}

	//Get General Details 
			
	 		strQuery=SQLParser.getSqlQuery("tlr_generaldetails_select^"+strTLReviewno);
		 	rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
			{
	 			hshRecord.put("reviewOf",correctNull((String)rs.getString("tlr_proposaltype")));
	 			hshRecord.put("tlr_activity",correctNull((String)rs.getString("tlr_activity")));
	 			hshRecord.put("tlr_banksince",correctNull((String)rs.getString("tlr_banksince")));
	 			hshRecord.put("tlr_assetclassify",correctNull((String)rs.getString("tlr_assetclassify")));
	 			hshRecord.put("tlr_renewal",correctNull((String)rs.getString("tlr_renewal")));
	 			hshRecord.put("tlr_facilitysince",correctNull((String)rs.getString("tlr_facilitysince")));
	 			hshRecord.put("tlr_nextreview",correctNull((String)rs.getString("tlr_nextreview")));
	 			hshRecord.put("tlr_indcode",correctNull((String)rs.getString("tlr_indcode")));
	 			hshRecord.put("AuditFlag", "Y");
			}
	 		else{
	 			hshRecord.put("AuditFlag", "N");
	 		}
	 		strQuery=SQLParser.getSqlQuery("tlr_applications_select^"+strTLReviewno);
	 		if(rs!=null)
	 			rs.close();
		 	rs=DBUtils.executeQuery(strQuery);
	 		if(rs.next())
			{
	 			hshRecord.put("tlr_holder",correctNull((String)rs.getString("tlr_holder")));
	 			hshRecord.put("tlr_status",correctNull((String)rs.getString("tlr_status")));
	 			hshRecord.put("valuesin",correctNull((String)rs.getString("tlr_valuesin")));
	 			hshRecord.put("apporgname",correctNull((String)rs.getString("org_name")));
	 			
	 			
	 			if(correctNull(rs.getString("tlr_status")).equalsIgnoreCase("OP") &&
						correctNull(rs.getString("tlr_holder")).equalsIgnoreCase(correctNull((String)hshValues.get("strUserId"))))
				{
					hshRecord.put("btnenable","Y");
				}
				else
				{
					hshRecord.put("btnenable","N");
				}
	 		 	
			}
	 		
	 //end		
	 
	 		hshRecord.put("tlreviewno",strTLReviewno);
			
		}
		catch (Exception e) {
					   throw new EJBException("Error in getTypeReviewTermLoan"+e.getMessage());
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
	public HashMap getTermLoanReviewFacilities(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=null;
		String tlreviewno = null;
		String strQuery=null;
		String valuesin = null;
		try
		{
			tlreviewno = "";
			strQuery = "";
			tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
			valuesin=correctNull((String)hshValues.get("valuesin"));
		
			strQuery=SQLParser.getSqlQuery("tlr_facilities_select^"+tlreviewno);
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
				}
				else if(valuesin.trim().equalsIgnoreCase("C"))
				{
					arrCol.add(Helper.converToCores(rs.getString("tlr_existlimit")));
					arrCol.add(Helper.converToCores(rs.getString("tlr_oslimit")));
					arrCol.add(Helper.converToCores(rs.getString("tlr_overdue")));	
				}else
				{
					arrCol.add(correctNull(rs.getString("tlr_existlimit")));
					arrCol.add(correctNull(rs.getString("tlr_oslimit")));
					arrCol.add(correctNull(rs.getString("tlr_overdue")));	
				}
						
				arrCol.add(correctNull(rs.getString("tlr_facscheme")));
				arrCol.add(correctNull(rs.getString("tlr_proposed")));
				arrCol.add(correctNull(rs.getString("tlr_intrecomm")));
				arrCol.add(correctNull(rs.getString("tlr_intremarks")));
				arrCol.add(correctNull(rs.getString("tlr_cbsaccno")));
				arrRow.add(arrCol);
				
			}
			hshRecord.put("arrRow",arrRow);
	
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getTermLoanReviewFacilities"+e.getMessage());
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
		return hshRecord;
	}
	
	public void updateTermLoanReviewFacilities(HashMap hshValues) 
	{
		
		HashMap hshQuery = new HashMap();
 		HashMap hshQueryValues=new HashMap();
 		ArrayList arrValues=new ArrayList();
 		String tlrappno = null;
 		String strAction = null;
 		String strQuery = "",strfacid = "";
 		ResultSet rs = null;
 		int updateSize=0;
 		StringBuilder sbAuditDataOld = new StringBuilder(); 	
		try
		{	
				tlrappno = correctNull((String) hshValues.get("hidtlrno"));
				strAction = correctNull((String) hshValues.get("hidAction"));
				strfacid = correctNull((String)hshValues.get("hidfacid"));
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
				{
					strQuery = SQLParser.getSqlQuery("gettlrfacilitydet^"+tlrappno+"^"+strfacid);
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						sbAuditDataOld
						.append("Nature of facilities =" +correctNull((String)rs.getString("TLR_FACNAME")))
						.append("~ Existing Limit =" +correctNull((String)rs.getString("TLR_EXISTLIMIT")))
						.append("~ Proposed Limit =" +correctNull((String)rs.getString("TLR_PROPOSED")))
						.append("~ O/s as on =" +correctNull((String)rs.getString("TLR_OSLIMIT")))
						.append("~ Overdue, if any =" +correctNull((String)rs.getString("TLR_OVERDUE")))
						.append("~ Purpose of Loan =" +correctNull((String)rs.getString("TLR_LOANPURPOSE")))
						.append("~ Interest Recommended =" +correctNull((String)rs.getString("TLR_INTRECOMM")));
						
					}
				}
				if(strAction.equalsIgnoreCase("delete"))
				{
					updateSize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add(tlrappno);
					arrValues.add(correctNull((String)hshValues.get("hidfacid")));
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","tlr_facilities_update"); 
					hshQueryValues.put(Integer.toString(updateSize),hshQuery);
					hshQueryValues.put("size",Integer.toString(updateSize));
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}else if(strAction.equalsIgnoreCase("update"))
				{
		
						updateSize++;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String)hshValues.get("txt_proposedlimit")));
						arrValues.add(correctNull((String)hshValues.get("txt_purpose")));
						arrValues.add(correctNull((String)hshValues.get("txt_intrecomm")));
						arrValues.add(correctNull((String)hshValues.get("txt_intRemarks")));
						arrValues.add(tlrappno);
						arrValues.add(correctNull((String)hshValues.get("hidfacid")));
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","tlr_facilities_update"); 
						hshQueryValues.put(Integer.toString(updateSize),hshQuery);
						hshQueryValues.put("size",Integer.toString(updateSize));
					   	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				StringBuilder sbAuditData=new StringBuilder();
				if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
				{
					sbAuditData
					.append("Nature of facilities =" +correctNull((String)hshValues.get("txt_facname")))
					.append("~ Existing Limit =" +correctNull((String)hshValues.get("txt_existlimit")))
					.append("~ Proposed Limit =" +correctNull((String)hshValues.get("txt_proposedlimit")))
					.append("~ O/s as on =" +correctNull((String)hshValues.get("txt_oslimit")))
					.append("~ Overdue, if any =" +correctNull((String)hshValues.get("txt_overdue")))
					.append("~ Purpose of Loan =" +correctNull((String)hshValues.get("txt_purpose")))
					.append("~ Interest Recommended =" +correctNull((String)hshValues.get("txt_intrecomm")));
				}
			
	 		AuditTrial.auditNewLog(hshValues, "326", tlrappno, sbAuditData.toString(), sbAuditDataOld.toString());
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateTermLoanReviewFacilities method"+ce.toString());
		}
	}
	
	public void updateBriefBackgroundData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		int updateSize=0;
		String tlrappno = null;
 		String strAction = null;
	
		try {
			
			strAction = (String) hshValues.get("hidAction");
			tlrappno = correctNull((String) hshValues.get("hidtlrno"));
			if (strAction.trim().equals("update")) {
		
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_briefbackgroud_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
					
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_briefbackgroud_insert");
    			arrValues.add(tlrappno);
				arrValues.add(correctNull((String) hshValues.get("txt_briefbackground")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_briefbackgroud_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}

		catch (Exception ce) {
			throw new EJBException("Errorn in updateBriefBackgroundData" + ce.toString());
		}

	}
	public HashMap getBirefBackgroundData(HashMap hshValues)  {
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String tlreviewno = null;
		String strQuery=null;

		try {
			tlreviewno = "";
			strQuery = "";
			tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
			strQuery = SQLParser.getSqlQuery("tlr_briefbackgroud_select^"+tlreviewno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("tlr_comments", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getBirefBackgroundData " + ce.toString());
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
	public void updatePresentStatusData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		int updateSize=0;
		String tlrappno = null;
 		String strAction = null;
	
		try {
			
			strAction = (String) hshValues.get("hidAction");
			tlrappno = correctNull((String) hshValues.get("hidtlrno"));
			if (strAction.trim().equals("update")) {
		
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_presentstatus_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
					
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_presentstatus_insert");
    			arrValues.add(tlrappno);
				arrValues.add(correctNull((String) hshValues.get("txt_presentstatus")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_presentstatus_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}

		catch (Exception ce) {
			throw new EJBException("Errorn in updateBriefBackgroundData" + ce.toString());
		}

	}
	public HashMap getPresentStatusData(HashMap hshValues)  {
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String tlreviewno = null;
		String strQuery=null;

		try {
			tlreviewno = "";
			strQuery = "";
			tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
			strQuery = SQLParser.getSqlQuery("tlr_presentstatus_select^"+tlreviewno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("tlr_comments", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getPresentStatusData " + ce.toString());
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
	public void updateOthersData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		int updateSize=0;
		String tlrappno = null;
 		String strAction = null;
	
		try {
			
			strAction = (String) hshValues.get("hidAction");
			tlrappno = correctNull((String) hshValues.get("hidtlrno"));
			if (strAction.trim().equals("update")) {
		
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_others_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
					
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_others_insert");
    			arrValues.add(tlrappno);
				arrValues.add(correctNull((String) hshValues.get("txt_others")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_others_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
		}

		catch (Exception ce) {
			throw new EJBException("Errorn in updateOthersData" + ce.toString());
		}

	}
	public HashMap getOthersData(HashMap hshValues)  {
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String tlreviewno = null;
		String strQuery=null;

		try {
			tlreviewno = "";
			strQuery = "";
			tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
			strQuery = SQLParser.getSqlQuery("tlr_others_select^"+tlreviewno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("tlr_comments", correctNull(Helper.CLOBToString(rs.getClob("tlr_comments"))));
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getBirefBackgroundData " + ce.toString());
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
	public void updateCDAccountData(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		int updateSize=0;
		String tlrappno = null;
 		String strAction = null;
	
		try {
			
			strAction = (String) hshValues.get("hidAction");
			tlrappno = correctNull((String) hshValues.get("hidtlrno"));
			if (strAction.trim().equals("update")) {
		
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_cdaccount_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
					
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_cdaccount_insert");
				arrValues.add(tlrappno);
				arrValues.add(correctNull((String) hshValues.get("txt_maxdebit")));
				arrValues.add(correctNull((String) hshValues.get("txt_mindebit")));
				arrValues.add(correctNull((String) hshValues.get("txt_maxcredit")));
				arrValues.add(correctNull((String) hshValues.get("txt_mincredit")));
				arrValues.add(correctNull((String) hshValues.get("txt_noofdaysdebit")));
				arrValues.add(correctNull((String) hshValues.get("txt_noofdayscredit")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			
			else if (strAction.trim().equals("delete")) {
				updateSize++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "tlr_cdaccount_delete");
				arrValues.add(tlrappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(updateSize),hshQuery);
				hshQueryValues.put("size",Integer.toString(updateSize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			}
			StringBuilder sbAuditData=new StringBuilder();
			String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
			if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
			{
				hshValues.put("strAction", "update");
			}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
				hshValues.put("strAction", "insert");
			}
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{	
				sbAuditData
				.append("Maximum Debit =" +correctNull((String) hshValues.get("txt_maxdebit")))
				.append("~ Minimum Debit =" +correctNull((String) hshValues.get("txt_mindebit")))
				.append("~ Maximum Credit =" +correctNull((String) hshValues.get("txt_maxcredit")))
				.append("~ Minimum Credit =" +correctNull((String) hshValues.get("txt_mincredit")))
				.append("~ No.Of Days in Debit =" +correctNull((String) hshValues.get("txt_noofdaysdebit")))
				.append("~ No.Of Days in Credit =" +correctNull((String) hshValues.get("txt_noofdayscredit")));
			}
			AuditTrial.auditLog(hshValues, "332", tlrappno, sbAuditData.toString());
		}

		catch (Exception ce) {
			throw new EJBException("Errorn in updateCDAccountData" + ce.toString());
		}

	}
public HashMap getCDAccountData(HashMap hshValues)  {
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String tlreviewno = null;
		String strQuery=null;

		try {
			tlreviewno = "";
			strQuery = "";
			tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
			strQuery = SQLParser.getSqlQuery("tlr_cdaccount_select^"+tlreviewno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				hshRecord.put("tlr_maxdebit",correctNull((String)rs.getString("tlr_maxdebit")));
				hshRecord.put("tlr_mindebit",correctNull((String)rs.getString("tlr_mindebit")));
				hshRecord.put("tlr_maxcredit",correctNull((String)rs.getString("tlr_maxcredit")));
				hshRecord.put("tlr_mincredit",correctNull((String)rs.getString("tlr_mincredit")));
				hshRecord.put("tlr_noofdaysdebit",correctNull((String)rs.getString("tlr_noofdaysdebit")));
				hshRecord.put("tlr_noofdayscredit",correctNull((String)rs.getString("tlr_noofdayscredit")));
				hshRecord.put("AuditFlag", "Y");		
			}
			else{
				hshRecord.put("AuditFlag", "N");
			}

		} catch (Exception ce) {
			log.error(ce.toString());
			throw new EJBException("Error in getCDAccountData " + ce.toString());
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
public void updateTLAccountData(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = new ArrayList();
	int updateSize=0;
	String tlrappno = null;
		String strAction = null;

	try {
		
		strAction = (String) hshValues.get("hidAction");
		tlrappno = correctNull((String) hshValues.get("hidtlrno"));
		if (strAction.trim().equals("update")) {
	
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_tlaccount_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
				
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_tlaccount_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_disbursal")));
			arrValues.add(correctNull((String)hshValues.get("txt_repayschedule")));
			arrValues.add(correctNull((String)hshValues.get("sel_installment")));
			arrValues.add(correctNull((String)hshValues.get("sel_interestservice")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		else if (strAction.trim().equals("delete")) {
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_tlaccount_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
		StringBuilder sbAuditData=new StringBuilder();
		String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
		if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
		{
			hshValues.put("strAction", "update");
		}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
			hshValues.put("strAction", "insert");
		}
		if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
		{
			sbAuditData
			.append("Date of first disbursal =" +correctNull((String)hshValues.get("txt_disbursal")))
			.append("~ Whether installments are paid regularly? =" +correctNull((String)hshValues.get("hidInsReg")))
			.append("~ Whether interest serviced regularly? =" +correctNull((String)hshValues.get("hidIntReg")));
		}
		AuditTrial.auditLog(hshValues, "333", tlrappno, sbAuditData.toString());
	}

	catch (Exception ce) {
		throw new EJBException("Errorn in updateTLAccountData" + ce.toString());
	}

}
public HashMap getTLAccountData(HashMap hshValues)  {
	
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	String tlreviewno = null;
	String strQuery=null;

	try {
		
		tlreviewno = "";
		strQuery = "";
		tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_tlaccount_select^"+tlreviewno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			hshRecord.put("tlr_repay", correctNull(Helper.CLOBToString(rs.getClob("tlr_repay"))));
			hshRecord.put("tlr_disbursaldate",correctNull((String)rs.getString("tlr_disbursaldate")));
			hshRecord.put("tlr_instalmentpaid",correctNull((String)rs.getString("tlr_instalmentpaid")));
			hshRecord.put("tlr_intserviced",correctNull((String)rs.getString("tlr_intserviced")));
			hshRecord.put("AuditFlag", "Y");
		}
		else{
			hshRecord.put("AuditFlag", "N");
		}
	} catch (Exception ce) {
		log.error(ce.toString());
		throw new EJBException("Error in getTLAccountData " + ce.toString());
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
public void updateProposalData(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = new ArrayList();
	int updateSize=0;
	String tlrappno = null;
		String strAction = null;

	try {
		strAction = (String) hshValues.get("hidAction");
		tlrappno = correctNull((String) hshValues.get("hidtlrno"));
		if (strAction.trim().equals("update")) {
	
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_proposaldetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
				
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_proposaldetails_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_proposaldate")));
			arrValues.add(correctNull((String)hshValues.get("sel_sancauthority")));
			arrValues.add(correctNull((String)hshValues.get("txt_agendano")));
			arrValues.add(correctNull((String)hshValues.get("txt_mcmdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_signatories")));
			arrValues.add(correctNull((String)hshValues.get("txt_mcmresolution")));
			arrValues.add(correctNull((String)hshValues.get("txt_grid")));
			arrValues.add(correctNull((String)hshValues.get("txt_meetingdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_refno")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		else if (strAction.trim().equals("delete")) {
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_proposaldetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
		StringBuilder sbAuditData=new StringBuilder();
		if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
		{
			sbAuditData
			.append("Date of Proposal =" +correctNull((String)hshValues.get("txt_proposaldate")))
			.append("~ Reference No =" +correctNull((String)hshValues.get("txt_refno")))
			.append("~ Sanctioning Authority =" +correctNull((String)hshValues.get("hidSancAuth")))
			.append("~ Grid Meeting =" +correctNull((String)hshValues.get("txt_grid")))
			.append("~ Meeting Date =" +correctNull((String)hshValues.get("txt_meetingdate")));
			if(correctNull((String)hshValues.get("sel_sancauthority")).equalsIgnoreCase("7"))
			{
				sbAuditData
				.append("~ Agenda Item no =" +correctNull((String)hshValues.get("txt_agendano")))
				.append("~ MCM of =" +correctNull((String)hshValues.get("txt_mcmdate")));
			}
		}
		AuditTrial.auditLog(hshValues, "335", tlrappno, sbAuditData.toString());
	}

	catch (Exception ce) {
		throw new EJBException("Errorn in updateProposalData" + ce.toString());
	}

}
public HashMap getProposalData(HashMap hshValues)  {
	
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	String tlreviewno = null;
	String strQuery=null;

	try {
		
		tlreviewno = "";
		strQuery = "";
		tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_proposaldetails_select^"+tlreviewno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			hshRecord.put("tlr_proposaldate",correctNull((String)rs.getString("tlr_proposaldate")));
			hshRecord.put("tlr_sancauthority",correctNull((String)rs.getString("tlr_sancauthority")));
			hshRecord.put("tlr_agendano",correctNull((String)rs.getString("tlr_agendano")));
			hshRecord.put("tlr_mcmdate",correctNull((String)rs.getString("tlr_mcmdate")));
			hshRecord.put("tlr_signatories",correctNull((String)rs.getString("tlr_signatories")));
			hshRecord.put("tlr_mcmresolution",correctNull((String)rs.getString("tlr_mcmresolution")));
			hshRecord.put("tlr_gridmeeting",correctNull((String)rs.getString("tlr_gridmeeting")));
			hshRecord.put("tlr_meetingdate",correctNull((String)rs.getString("tlr_meetingdate")));
			hshRecord.put("tlr_refno",correctNull((String)rs.getString("tlr_refno")));
			
		}
		
		

	} catch (Exception ce) {
		log.error(ce.toString());
		throw new EJBException("Error in getProposalData " + ce.toString());
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
public void updateComplianceData(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = new ArrayList();
	int updateSize=0;
	String tlrappno = null;
		String strAction = null;

	try {
		strAction = (String) hshValues.get("hidAction");
		tlrappno = correctNull((String) hshValues.get("hidtlrno"));
		if (strAction.trim().equals("update")) {
	
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_compliance_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
				
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_compliance_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_mortgageformal")));
			arrValues.add(correctNull((String)hshValues.get("txt_regcharges")));
			arrValues.add(correctNull((String)hshValues.get("sel_docvalid")));
			arrValues.add(correctNull((String)hshValues.get("txt_dbcdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_inspecdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_adequatesec")));
			arrValues.add(correctNull((String)hshValues.get("txt_observ")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		else if (strAction.trim().equals("delete")) {
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_compliance_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
		StringBuilder sbAuditData=new StringBuilder();
		String strAuditFlag = correctNull((String)hshValues.get("hidAuditFlag"));
		if(strAuditFlag.equalsIgnoreCase("Y") && !strAction.equalsIgnoreCase("delete"))
		{
			hshValues.put("strAction", "update");
		}else if(strAuditFlag.equalsIgnoreCase("N") && !strAction.equalsIgnoreCase("delete")){
			hshValues.put("strAction", "insert");
		}
		if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
		{
			sbAuditData
			.append("Whether documents are valid and in force =" +ApplicantParams.getApplicantParams("DEFAULTYESNO", correctNull((String)hshValues.get("sel_docvalid"))))
			.append("~ Date of last DBC obtained =" +correctNull((String)hshValues.get("txt_dbcdate")))
			.append("~ Date of last inspection of securities =" +correctNull((String)hshValues.get("txt_inspecdate")));
		}
		AuditTrial.auditLog(hshValues, "334", tlrappno, sbAuditData.toString());
	}

	catch (Exception ce) {
		throw new EJBException("Errorn in updateComplianceData" + ce.toString());
	}

}
public HashMap getComplianceData(HashMap hshValues)  {
	
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	String tlreviewno = null;
	String strQuery=null;

	try {
		
		tlreviewno = "";
		strQuery = "";
		tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_compliance_select^"+tlreviewno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			hshRecord.put("tlr_formalities",correctNull((String)rs.getString("tlr_formalities")));
			hshRecord.put("tlr_registrationcharge",correctNull((String)rs.getString("tlr_registrationcharge")));
			hshRecord.put("tlr_doccheck",correctNull((String)rs.getString("tlr_doccheck")));
			hshRecord.put("tlr_dbcdate",correctNull((String)rs.getString("tlr_dbcdate")));
			hshRecord.put("tlr_inspectiondate",correctNull((String)rs.getString("tlr_inspectiondate")));
			hshRecord.put("tlr_secdesc",correctNull((String)rs.getString("tlr_secdesc")));
			hshRecord.put("tlr_observ",correctNull((String)rs.getString("tlr_observ")));
			hshRecord.put("AuditFlag", "Y");
			
		}
		else{
			hshRecord.put("AuditFlag", "N");
		}	

	} catch (Exception ce) {
		log.error(ce.toString());
		throw new EJBException("Error in getComplianceData " + ce.toString());
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
public void updateTermAndConditionsData(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = new ArrayList();
	int updateSize=0;
	String tlrappno = null;
		String strAction = null;

	try {
		strAction = (String) hshValues.get("hidAction");
		tlrappno = correctNull((String) hshValues.get("hidtlrno"));
		if (strAction.trim().equals("update")) {
	
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_termsdetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
				
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_termsdetails_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_terms")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		else if (strAction.trim().equals("delete")) {
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_termsdetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
	}

	catch (Exception ce) {
		throw new EJBException("Errorn in updateTermAndConditionsData" + ce.toString());
	}

}
public HashMap getTermAndConditionsData(HashMap hshValues)  {
	
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	String tlreviewno = null;
	String strQuery=null;

	try {
		
		tlreviewno = "";
		strQuery = "";
		tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_termsdetails_select^"+tlreviewno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			hshRecord.put("tlr_condtions", correctNull(Helper.CLOBToString(rs.getClob("tlr_condtions"))));
				
		}
		
		

	} catch (Exception ce) {
		log.error(ce.toString());
		throw new EJBException("Error in getTermAndConditionsData " + ce.toString());
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
public void updateBankingArrangementData(HashMap hshValues)  {
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues = new ArrayList();
	int updateSize=0;
	String tlrappno = null;
		String strAction = null;

	try {
		strAction = (String) hshValues.get("hidAction");
		tlrappno = correctNull((String) hshValues.get("hidtlrno"));
		if (strAction.trim().equals("update")) {
	
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_bankingdetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
				
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_bankingdetails_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_group")));
			arrValues.add(correctNull((String)hshValues.get("status_account")));
			arrValues.add(correctNull((String)hshValues.get("txt_reviewdate")));
			arrValues.add(correctNull((String)hshValues.get("mulbank")));
			arrValues.add(correctNull((String)hshValues.get("leadbank")));
			arrValues.add(correctNull((String)hshValues.get("txt_ourshare")));
			arrValues.add(correctNull((String)hshValues.get("txt_agent")));
			arrValues.add(correctNull((String)hshValues.get("txt_lastyear")));
			arrValues.add(correctNull((String)hshValues.get("txt_currentyear")));
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		
		else if (strAction.trim().equals("delete")) {
			updateSize++;
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "tlr_bankingdetails_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(updateSize),hshQuery);
			hshQueryValues.put("size",Integer.toString(updateSize));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
		}
		StringBuilder sbAuditTrial=new StringBuilder();
		if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
		{
			sbAuditTrial
			.append("Group =" +correctNull((String)hshValues.get("txt_group")))
			.append("~ Status of Account =" +correctNull((String)hshValues.get("hidAccountStatus")))
			.append("~ Month of Review =" +correctNull((String)hshValues.get("txt_reviewdate")))
			.append("~ Sole/Consortium/Multiple Banking =" +correctNull((String)hshValues.get("hidMulBank")));
			String strMulBank = correctNull((String)hshValues.get("mulbank"));
			if(strMulBank.equalsIgnoreCase("2") || strMulBank.equalsIgnoreCase("4") || strMulBank.equalsIgnoreCase("6") || strMulBank.equalsIgnoreCase("7"))
			{
				sbAuditTrial
				.append("~ Lead Bank =" +correctNull((String)hshValues.get("leadbank")))
				.append("~ Our Share (%) =" +correctNull((String)hshValues.get("txt_ourshare")));
			}
			sbAuditTrial
			.append("~ Agency Name =" +correctNull((String)hshValues.get("txt_agent")))
			.append("~ Last Year Rating =" +correctNull((String)hshValues.get("txt_lastyear")))
			.append("~ Current Year Rating =" +correctNull((String)hshValues.get("txt_currentyear")));
		}
		AuditTrial.auditLog(hshValues, "330", tlrappno, sbAuditTrial.toString());
	}

	catch (Exception ce) {
		throw new EJBException("Errorn in updateBankingArrangementData" + ce.toString());
	}

}
public HashMap getBankingArrangementData(HashMap hshValues)  {
	
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	String tlreviewno = null;
	String strQuery=null;

	try {
		
		tlreviewno = "";
		strQuery = "";
		tlreviewno=correctNull((String)hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_bankingdetails_select^"+tlreviewno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			hshRecord.put("tlr_group",correctNull((String)rs.getString("tlr_group")));
			hshRecord.put("tlr_status",correctNull((String)rs.getString("tlr_status")));
			hshRecord.put("tlr_reviewdate",correctNull((String)rs.getString("tlr_reviewdate")));
			hshRecord.put("tlr_bankarrangement",correctNull((String)rs.getString("tlr_bankarrangement")));
			hshRecord.put("tlr_leadbank",correctNull((String)rs.getString("tlr_leadbank")));
			hshRecord.put("tlr_ourshare",correctNull((String)rs.getString("tlr_ourshare")));

			hshRecord.put("tlr_agencyname",correctNull((String)rs.getString("tlr_agencyname")));
			hshRecord.put("tlr_lastrating",correctNull((String)rs.getString("tlr_lastrating")));
			hshRecord.put("tlr_currating",correctNull((String)rs.getString("tlr_currating")));
				
		}
		
		

	} catch (Exception ce) {
		log.error(ce.toString());
		throw new EJBException("Error in getBankingArrangementData " + ce.toString());
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
public void updateInternalRatingData(HashMap hshValues)  
{
	ResultSet rs = null;
	String tlrappno = null;
	String strAction = null;
    ArrayList arrValues=null;
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=null;
    String []desc=null;
	String []pre_year=null;	
	String []cur_year=null;
	int intUpdatesize=0;
	try
	{
		strAction=Helper.correctNull((String) hshValues.get("hidAction"));
		tlrappno=Helper.correctNull((String) hshValues.get("hidtlrno"));
		desc= (String [])hshValues.get("txt_parameter");
		pre_year= (String [])hshValues.get("txt_previous");
		cur_year= (String [])hshValues.get("txt_current");
		
		if (strAction.trim().equals("edit"))
		{
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			hshQuery.put("strQueryId", "tlr_internalrating_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));	
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			hshQuery.put("strQueryId", "tlr_internalratingparameter_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));	
			
				
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize=intUpdatesize+1;
			hshQuery.put("strQueryId","tlr_internalrating_insert");
			arrValues.add(tlrappno);
			arrValues.add(correctNull((String)hshValues.get("txt_lastyearscore")));
			arrValues.add(correctNull((String)hshValues.get("txt_currentyearscore")));
			arrValues.add(correctNull((String)hshValues.get("txt_lastyeargrade")));
			arrValues.add(correctNull((String)hshValues.get("txt_currentyeargrade")));
			arrValues.add(correctNull((String)hshValues.get("txt_lastyearrisk")));
			arrValues.add(correctNull((String)hshValues.get("txt_currentyearrisk")));
			hshQuery.put("arrValues",arrValues);						
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));	
			
			for(int k=0;k<5;k++)
			{			
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","tlr_internalratingparameter_insert");
					arrValues.add(tlrappno);
					arrValues.add(Integer.toString(k+1));
					arrValues.add(correctNull((String)desc[k]));
					arrValues.add(correctNull((String)pre_year[k]));
					arrValues.add(correctNull((String)cur_year[k]));
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
					hshQueryValues.put("size", Integer.toString(intUpdatesize));	
			}	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if (strAction.trim().equals("delete"))
		{
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			intUpdatesize++;
			hshQuery.put("strQueryId", "tlr_internalrating_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));	
				
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId", "tlr_internalratingparameter_delete");
			arrValues.add(tlrappno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
			hshQueryValues.put("size", Integer.toString(intUpdatesize));	
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

		}
		StringBuilder sbAuditData=new StringBuilder();
		if(strAction.equalsIgnoreCase("edit") || strAction.equalsIgnoreCase("update"))
		{
			sbAuditData
			.append("Total Score Previous Year=" +correctNull((String)hshValues.get("txt_lastyearscore")))
			.append("~ Total Score Current Year=" +correctNull((String)hshValues.get("txt_currentyearscore")))
			.append("~ Grade Previous Year=" +correctNull((String)hshValues.get("txt_lastyeargrade")))
			.append("~ Grade Current Year=" +correctNull((String)hshValues.get("txt_currentyeargrade")))
			.append("~ Risk Definition Previous Year=" +correctNull((String)hshValues.get("txt_lastyearrisk")))
			.append("~ Risk Definition Current Year=" +correctNull((String)hshValues.get("txt_currentyearrisk")));
			for(int i=0;i<5;i++)
			{
				sbAuditData
				.append("~ "+correctNull((String)desc[i])+" Previous Year =" +correctNull((String)pre_year[i]))
				.append("~ "+correctNull((String)desc[i])+" Current Year =" +correctNull((String)cur_year[i]));
			}
		}
		AuditTrial.auditLog(hshValues, "331", tlrappno, sbAuditData.toString());
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in updateInternalRatingData " + ce.toString());
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
}
public HashMap getInternalRatingData(HashMap hshValues)  
{
	String strQuery = null;
	ResultSet rs = null;
	HashMap hshRecord = new HashMap();
	ArrayList arrVal = new ArrayList();
	ArrayList arrRec= new ArrayList();
	String appno = null;
	
	try
	{
		appno = correctNull((String) hshValues.get("hidtlrno"));
		strQuery = SQLParser.getSqlQuery("tlr_internalrating_select^"+appno);
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
		strQuery = SQLParser.getSqlQuery("tlr_internalratingparameter_select^"+appno);
    	if (rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		boolean recordflag=false;
		recordflag=rs.next();
		if(recordflag)
		{
			do
			{
				arrRec = new ArrayList();						
				arrRec.add(correctNull(rs.getString("tlr_prevyear")));
				arrRec.add(correctNull(rs.getString("tlr_currentyear")));
				arrVal.add(arrRec);
			}
			while (rs.next());
		}
		else
		{
			arrRec = new ArrayList();	
			arrRec.add("");
			arrRec.add("");
			arrVal.add(arrRec);
			
			arrRec = new ArrayList();	
			arrRec.add("");
			arrRec.add("");
			arrVal.add(arrRec);
			
			arrRec = new ArrayList();	
			arrRec.add("");
			arrRec.add("");
			arrVal.add(arrRec);
			
			arrRec = new ArrayList();	
			arrRec.add("");
			arrRec.add("");
			arrVal.add(arrRec);
			
			arrRec = new ArrayList();	
			arrRec.add("");
			arrRec.add("");
			arrVal.add(arrRec);
			
		}
		hshRecord.put("arrVal",arrVal);
	}
	catch (Exception ce) 
	{
		throw new EJBException("Error in getInternalRatingData " + ce.toString());
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
}