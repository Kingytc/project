package com.sai.laps.ejb.Register;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;


@Stateless(name = "RegisterBean", mappedName = "RegisterHome")
@Remote (RegisterRemote.class)
public class RegisterBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(RegisterBean.class);	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//karthi for document search
	
	public HashMap getDocSearch(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strCusName="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrValue = new ArrayList();
		ResultSet rs = null;
		String strType="";
		strType=Helper.correctNull((String)hshValues.get("hidCustType"));
		strCusName=Helper.correctNull((String)hshValues.get("txt_cust_name"));
		if(strCusName.trim().equalsIgnoreCase(""))
		{
			strCusName="%";
		}
		try
		{
		if(strType.trim().equalsIgnoreCase("r") || strType.trim().equalsIgnoreCase("p"))
		{
			rs=DBUtils.executeLAPSQuery("selRetailDoc^"+strCusName);
		}
		else if(strType.trim().equalsIgnoreCase("c"))
		{
			rs=DBUtils.executeLAPSQuery("selCorpDoc^"+strCusName);
		}
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString(1)));
				arrCol.add(correctNull((String)rs.getString(2)));
				arrCol.add(correctNull((String)rs.getString(3)));
				arrValue.add(arrCol);
			}			
			hshRecord.put("arrCust",arrValue);
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
				throw new EJBException("Error closing in getDocSearch the connection "+cf.getMessage());						
			}
		}
		return hshRecord;
	}
	

	public void updateLimitRegisster(HashMap hshValues) 
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strUserId = correctNull((String)hshValues.get("strUserId"));
		String strappno = correctNull((String)hshValues.get("cbsaccno"));
	
		try
		
		{
			if(strappno.equalsIgnoreCase(""))
			{
				strappno=Helper.correctNull((String)hshValues.get("mon_accno"));
			}
			String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
				if(strAction.equalsIgnoreCase("Edit"))
				{
				
				 arrValues.add(correctNull((String)hshValues.get("txt_remarks")));
				 arrValues.add(correctNull((String)hshValues.get("txt_margin")));
				 //arrValues.add(correctNull((String)hshValues.get("sel_typelimit")));
				 arrValues.add(strUserId);
				 arrValues.add(correctNull((String)hshValues.get("reviewOf")));
				 arrValues.add(correctNull((String)hshValues.get("txt_marginbookdebt")));
				 arrValues.add(correctNull((String)hshValues.get("cbsaccno")));
				
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_monlimitregister"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				else if(strAction.equalsIgnoreCase("Delete"))
				{
				 arrValues.add("");
				 arrValues.add("");
				 arrValues.add(strUserId);
				 arrValues.add("");
				 arrValues.add("");
				 arrValues.add(correctNull((String)hshValues.get("cbsaccno")));
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_monlimitregister"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			    } 
				//Audit Trial Starts Here
				StringBuilder sbAt = new StringBuilder();
				
				sbAt.append("Nature of Limit =").append(correctNull((String)hshValues.get("txt_nature")));
				sbAt.append(" ~Amount of Limit = ").append(correctNull((String)hshValues.get("txt_amount")));
				if(strAction.equalsIgnoreCase("Delete"))
				{
					sbAt.append(" ~Margin (%) = ").append("");
				}else{
				sbAt.append(" ~Margin (%) = ").append(correctNull((String)hshValues.get("txt_margin")));
				}
				sbAt.append(" ~Interest / commission = ").append(correctNull((String)hshValues.get("txt_rate")));
				sbAt.append(" ~Sanctioned Date = ").append(correctNull((String)hshValues.get("txt_date")));
				sbAt.append(" ~Sanctioned By  = ").append(correctNull((String)hshValues.get("txt_sanction")));
				sbAt.append(" ~Sanction Level  = ").append(correctNull((String)hshValues.get("txt_sanctionlevel")));
				sbAt.append(" ~Expiry Date  = ").append(correctNull((String)hshValues.get("txt_expdate")));
				sbAt.append(" ~Sanction ref. No   = ").append(correctNull((String)hshValues.get("txt_modified")));
				sbAt.append(" ~Renewal / Review Date   = ").append(correctNull((String)hshValues.get("txt_moddate")));
				if(strAction.equalsIgnoreCase("Delete"))
				{
					sbAt.append(" ~Margin for Book debt [%]  = ").append("");
				}else{
					sbAt.append(" ~Margin for Book debt [%]  = ").append(correctNull((String)hshValues.get("txt_marginbookdebt")));
				}
			
				if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
					hshValues.put("hidAction","Insert");
				else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
					hshValues.put("hidAction","update");
				else 
					hshValues.put("hidAction","Delete");
				AuditTrial.auditLog(hshValues,"313",strappno,sbAt.toString());
				
		}catch(Exception e)
		{
			throw new EJBException("Error in updatereldetails "+e.getMessage());
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
				throw new EJBException("Error closing in updateLimitRegisster the connection "+cf.getMessage());						
			}
		}
	}
	
	public HashMap getLimitRegister(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strcbsid=Helper.correctNull((String)hshValues.get("cbsid"));

		String strappno = correctNull((String)hshValues.get("cbsaccno"));
		if(strappno.equalsIgnoreCase("null")|| strappno.equalsIgnoreCase(""))
		{
			strappno=Helper.correctNull((String)hshValues.get("mon_accno"));
		}
		//cbsaccountno
		String strschemecode="",strfacility="";
		String sancode="",sancauth="";
		boolean recordflag=false;
		try
		{
			rs=DBUtils.executeLAPSQuery("sel_monlimitregister^"+strappno);
			
			if(rs.next())
			{
				hshRecord.put("limit_custid",correctNull((String)rs.getString("limit_custid")));
				hshRecord.put("limit_sanctamt",correctNull((String)rs.getString("limit_sanctamt")));
				hshRecord.put("limit_sanctdate",correctNull((String)rs.getString("limit_sanctdate")));
				hshRecord.put("limit_margin",correctNull((String)rs.getString("limit_margin")));
				hshRecord.put("limit_roi",correctNull((String)rs.getString("limit_roi")));
				strschemecode=Helper.correctNull(rs.getString("limit_facility"));
				rs1=DBUtils.executeLAPSQuery("getmonfacility^"+strschemecode);
				if(rs1.next())
				{
					strfacility=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
				}
				hshRecord.put("limit_facility",strfacility);
				hshRecord.put("limit_reviewdate",correctNull((String)rs.getString("limit_reviewdate")));
				hshRecord.put("limit_sancrefno",correctNull((String)rs.getString("limit_sancrefno")));
				sancode=Helper.correctNull(rs.getString("limit_sancauth"));
				rs2=DBUtils.executeLAPSQuery("getsancode^"+sancode);
				if(rs2.next())
				{
					sancauth=Helper.correctNull((String)rs2.getString("stat_data_desc1"));
				}
				hshRecord.put("limit_sancauth",sancauth);
				hshRecord.put("limit_expirydate",correctNull((String)rs.getString("limit_expirydate")));
				hshRecord.put("limit_type",correctNull((String)rs.getString("limit_type")));
				hshRecord.put("limit_remarks",correctNull((String)rs.getString("limit_remarks")));
				hshRecord.put("mon_marginbookdebt",correctNull((String)rs.getString("mon_marginbookdebt")));
				hshRecord.put("limit_sanctionlevel",correctNull((String)rs.getString("limit_sanctionlevel")));
				
				recordflag=true;
			}
			hshRecord.put("strcbsid", strcbsid);
			hshRecord.put("cbsaccno",strappno);
			 if(recordflag)
				hshRecord.put("recordflag","Y");
			 else
				hshRecord.put("recordflag","N");
			 
			 hshRecord.put("orgLevel", Helper.correctNull((String)hshValues.get("strOrgLevel")));
		}catch(Exception e)
		{
			throw new EJBException("Error in getLimitRegister "+e.getMessage());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				} 
				if(rs1 != null)
				{
					rs1.close();
				} 
				if(rs2 != null)
				{
					rs2.close();
				} 
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in getLimitRegister the connection "+cf.getMessage());						
			}
		}
		
		 return hshRecord;
	}

	
	public void updateDocumentRegister(HashMap hshValues)
	{
		ResultSet rs = null,rs1=null;
		
		String strQuery=null;
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		
		ArrayList arrValues = new ArrayList();
		
		try
		{
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String strUserId = correctNull((String)hshValues.get("strUserId"));
			String strDocAccno= correctNull((String)hshValues.get("cbsaccno"));
			String strDocumentName = correctNull((String)hshValues.get("txtdocname"));
			String strSignatoryName = correctNull((String)hshValues.get("txtdocsignatoryname"));
			String strDateExecuted= correctNull((String)hshValues.get("txtdocexecuteddate"));	
			String strExecutedby = correctNull((String)hshValues.get("txtdoccreatedby"));
			String strExpiryDate = correctNull((String)hshValues.get("txtdocexpirydate"));
			String strVettedby = correctNull((String)hshValues.get("txtdocvettedby"));
			String strDateVetted = correctNull((String)hshValues.get("txtdocdatevetted"));
			
			String sel_type_applicant=Helper.correctNull((String)hshValues.get("sel_type_applicant"));
			String sel_docsigned=Helper.correctNull((String)hshValues.get("sel_docsigned"));
			String strSno = correctNull((String)hshValues.get("hidsno"));
			String strApplicantype = correctNull((String)hshValues.get("sel_type_applicant"));
			String strDocsigned = correctNull((String)hshValues.get("sel_docsigned"));
			
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("Insert")||strAction.equalsIgnoreCase("Delete")||strAction.equalsIgnoreCase("Mask"))
			{
				String desc =" and doc_sno='"+strSno+"' ";
				strQuery = SQLParser.getSqlQuery("seldocumentregister^"+strDocAccno);
				strQuery = strQuery + desc;
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strOldAudit.append("~Document Taken = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_documentname")));
					strOldAudit.append("~Date of document = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_executeddate")));
					strOldAudit.append("~Expiry Date = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_expirydate")));
					strOldAudit.append("~Applicant Type = ");
						rs1 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"44"+"^"+Helper.correctNull((String)rs.getString("doc_applicantype")));
						if(rs1.next()){
							strOldAudit.append(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
						}
						else{
							strOldAudit.append("");
						}
					strOldAudit.append("~Name of Signatory = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_signatoryname")));
					strOldAudit.append("~Created By = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_executedby")));
					strOldAudit.append("~Vetted By = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_vettedby")));
					strOldAudit.append("~Vetted Date = ");
					strOldAudit.append(Helper.correctNull((String)rs.getString("doc_datevetted")));
					strOldAudit.append("~Whether Signatory signed the document = ");
					if(Helper.correctNull((String)rs.getString("doc_signed")).equalsIgnoreCase("1"))
					{
						strOldAudit.append("Yes");
					}
					else if(Helper.correctNull((String)rs.getString("doc_signed")).equalsIgnoreCase("2"))
					{
						strOldAudit.append("No");
					}
					else
					{
						strOldAudit.append("");
					}
				}
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				strQuery="selmaxsdocument";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("snorelmax"));
				}
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				
				hshQuery.put("strQueryId","insdocumentregister");
				
				arrValues.add(strSno);
				arrValues.add(strDocAccno);
				arrValues.add(strDocumentName);
				arrValues.add(strDateExecuted);
				arrValues.add(strExecutedby);
				arrValues.add(strSignatoryName);
				arrValues.add(strExpiryDate);
				arrValues.add(strVettedby);
				arrValues.add(strDateVetted);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
				arrValues.add(strApplicantype);
				arrValues.add(strDocsigned);
				 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			else if(strAction.equalsIgnoreCase("update"))
			{
				 hshQueryValues = new HashMap();
				 hshQuery=new HashMap();
				 
				 hshQuery.put("strQueryId","upddocumentregister"); 
				 
				 	arrValues.add(strDocAccno);
					//arrValues.add(strDocumentName);
					arrValues.add(strDateExecuted);
					arrValues.add(strExecutedby);
					arrValues.add(strSignatoryName);
					arrValues.add(strExpiryDate);
					arrValues.add(strVettedby);
					arrValues.add(strDateVetted);
					arrValues.add(strApplicantype);
					arrValues.add(strDocsigned);
				 	arrValues.add(strSno);
					arrValues.add(strDocAccno);
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else if(strAction.equalsIgnoreCase("Delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","deldocumentregister"); 
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strSno);
				arrValues.add(strDocAccno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			else if(strAction.equalsIgnoreCase("Mask"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				
				
				hshQuery.put("strQueryId","mask_document_register"); 
				arrValues.add("Y");
				arrValues.add(strSno);
				arrValues.add(strDocAccno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder strNewAudit=new StringBuilder();
			//hid_apptype
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("Insert")||strAction.equalsIgnoreCase("Delete"))
			{
					strNewAudit.append("~Document Taken = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocname")));
					strNewAudit.append("~Date of document = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocexecuteddate")));
					strNewAudit.append("~Expiry Date = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocexpirydate")));
					strNewAudit.append("~Applicant Type = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("hid_apptype")));
					}
					strNewAudit.append("~Name of Signatory = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocsignatoryname")));
					}
					strNewAudit.append("~Created By = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdoccreatedby")));
					}
					strNewAudit.append("~Vetted By = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocvettedby")));
					}
					strNewAudit.append("~Vetted Date = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txtdocdatevetted")));
					}
					strNewAudit.append("~Whether Signatory signed the document = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}else{
					if(Helper.correctNull((String)hshValues.get("sel_docsigned")).equalsIgnoreCase("1"))
					{
						strNewAudit.append("Yes");
					}
					else if(Helper.correctNull((String)hshValues.get("sel_docsigned")).equalsIgnoreCase("2"))
					{
						strNewAudit.append("No");
					}
					else
					{
						strNewAudit.append("");
					}
					}
					}
			else if(strAction.equalsIgnoreCase("Mask"))
			{
				strNewAudit.append("~ The Record is Masked");
			}
			AuditTrial.auditNewLog(hshValues, "310", strDocAccno, strNewAudit.toString(), strOldAudit.toString());
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateDocumentRegister "+e.getMessage());
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
				throw new EJBException("Error closing in updateDocumentRegister the connection "+cf.getMessage());						
			}
		}
	}

	public HashMap getDocumentRegister(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		//String accno="10000";
		ResultSet rs = null;
		String strcbsaccno=correctNull((String)hshValues.get("cbsaccno"));
		try
		{
			strQuery=SQLParser.getSqlQuery("seldocumentregister^"+strcbsaccno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull((String)rs.getString("doc_sno")));
				arrCol.add(correctNull((String)rs.getString("doc_accountnumber")));
				arrCol.add(correctNull((String)rs.getString("doc_documentname")));
				arrCol.add(correctNull((String)rs.getString("doc_executeddate")));
				arrCol.add(correctNull((String)rs.getString("doc_executedby")));
				arrCol.add(correctNull((String)rs.getString("doc_signatoryname")));
				arrCol.add(correctNull((String)rs.getString("doc_expirydate")));
				arrCol.add(correctNull((String)rs.getString("doc_vettedby")));
				arrCol.add(correctNull((String)rs.getString("doc_datevetted")));
				arrCol.add(correctNull((String)rs.getString("doc_applicantype")));
				arrCol.add(correctNull((String)rs.getString("doc_signed")));
				arrCol.add(correctNull((String)rs.getString("doc_applicantype")));
				arrCol.add(correctNull((String)rs.getString("doc_signed")));

				arrRow.add(arrCol);
			}			
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strcbsaccno",strcbsaccno);
		}
		catch(Exception e1)
		{
			throw new EJBException("Error in getDocumentRegister :: "+e1.getMessage());
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
				e.printStackTrace();
			}
		}
		return hshRecord;
	}
	
	public void updateInsuranceDetails(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null,rs1=null;
		String strQuery;
		String strAction=(String)hshValues.get("hidAction");
		String strSrlno=Helper.correctNull((String)hshValues.get("hidSeqid"));
		String cbsaccount=Helper.correctNull((String)hshValues.get("cbsaccountno"));
		if(cbsaccount.equalsIgnoreCase(""))
		{
			cbsaccount=Helper.correctNull((String)hshValues.get("cbsappno"));
		}
		if(cbsaccount.equalsIgnoreCase(""))
		{
			cbsaccount=Helper.correctNull((String)hshValues.get("cbsaccno"));
		}
		String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
		if(strcbsid.equalsIgnoreCase(""))
		{
			strcbsid = Helper.correctNull((String)hshValues.get("cbsid"));
		}
		
		try
		{
			//for old values in audit trial
			StringBuilder strOldValues = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")|| strAction.equalsIgnoreCase("Delete")||strAction.equalsIgnoreCase("Mask")){
				strQuery = SQLParser.getSqlQuery("sel_insurancereg_audittrial^"+cbsaccount+"^"+strcbsid+"^"+strSrlno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldValues.append("~Insurance Company Name = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_company")));
					strOldValues.append("~Policy Number = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_policyno")));
					strOldValues.append("~Policy Date = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("policydate")));
					strOldValues.append("~Due Date for renewal = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("duedate")));
					strOldValues.append("~Expiry Date = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_expirydate")));
					strOldValues.append("~Insurance Covered Amount = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_coveramt")));
					strOldValues.append("~Cover Note No = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_covernote")));
					strOldValues.append("~Beneficiary Name = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_beneficiary")));
					strOldValues.append("~Whether bank Clause covered = ");
					if(Helper.correctNull((String)rs.getString("ins_clause")).equalsIgnoreCase("Y"))
					{
					strOldValues.append("Yes");
					}
					else if(Helper.correctNull((String)rs.getString("ins_clause")).equalsIgnoreCase("N"))
					{
						strOldValues.append("No");
					}
					else{
						strOldValues.append("");
					}
					strOldValues.append("~Premium paid by = ");
					if(Helper.correctNull((String)rs.getString("ins_paid_by")).equalsIgnoreCase("b"))
					{
					strOldValues.append("bank");
					}
					else if(Helper.correctNull((String)rs.getString("ins_paid_by")).equalsIgnoreCase("a"))
					{
						strOldValues.append("Applicant");
					}
					else{
						strOldValues.append("");
					}
					strOldValues.append("~Premium Amount = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_premiumamt")));
					strOldValues.append("~Whether Exemptions of risk = ");
					if(Helper.correctNull((String)rs.getString("ins_risk")).equalsIgnoreCase("y"))
					{
					strOldValues.append("Yes");
					}
					else if(Helper.correctNull((String)rs.getString("ins_risk")).equalsIgnoreCase("n"))
					{
						strOldValues.append("No");
					}
					else{
						strOldValues.append("");
					}
					strOldValues.append("~Risk Factor = ");
						strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"38"+"^"+Helper.correctNull((String)rs.getString("ins_riskfactor")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strOldValues.append(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
						}
						else
						{
							strOldValues.append("");
						}
					strOldValues.append("~ Address 1 =  ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredaddr1")));
					strOldValues.append("~Address 2=");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredaddr2")));
					strOldValues.append("~Address 3 =  ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredaddr3")));
					strOldValues.append("~City = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredcity")));
					strOldValues.append("~State = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredstate")));
					strOldValues.append("~Pincode = ");
					strOldValues.append(Helper.correctNull((String)rs.getString("ins_insuredpincode")));
				}
			}
			
				if(strAction.equalsIgnoreCase("Update"))
				{
				 arrValues.add(correctNull((String)hshValues.get("insreg_details")));
				 arrValues.add(correctNull((String)hshValues.get("txt_insaddres1")));
				 arrValues.add(correctNull((String)hshValues.get("txt_insaddres2")));
				 arrValues.add(correctNull((String)hshValues.get("txt_insaddres3")));
				 arrValues.add(correctNull((String)hshValues.get("txt_inscity")));
				 arrValues.add(correctNull((String)hshValues.get("txt_insstate")));
				 arrValues.add(correctNull((String)hshValues.get("txt_inspincode")));
				 
				 arrValues.add(correctNull((String)hshValues.get("insreg_coverno")));
				 arrValues.add(correctNull((String)hshValues.get("insreg_premamt")));
				 arrValues.add(correctNull((String)hshValues.get("insreg_beneficial")));
				 arrValues.add(correctNull((String)hshValues.get("bnk_cond")));
				 arrValues.add(correctNull((String)hshValues.get("sel_prempdby")));
				 arrValues.add(correctNull((String)hshValues.get("sel_risk")));
				 arrValues.add(correctNull((String)hshValues.get("txt_rskfactor")));
				 
				 arrValues.add(strUserId);
				 arrValues.add(Helper.getCurrentDateTime());
				 arrValues.add(cbsaccount);
				 arrValues.add(strSrlno);
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_insurance_register"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strAction.equalsIgnoreCase("Delete"))
				{
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
				 arrValues.add(strUserId);
				 arrValues.add(Helper.getCurrentDateTime());
				 arrValues.add(cbsaccount);
				 arrValues.add(strSrlno);
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","upd_insurance_register"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(strAction.equalsIgnoreCase("Mask"))
				{
				 arrValues.add("Y");	
				 arrValues.add(cbsaccount);
				 arrValues.add(strSrlno);
				 arrValues.add(correctNull((String)hshValues.get("insreg_policyno")));
				 hshQuery.put("arrValues",arrValues); 
				 hshQuery.put("strQueryId","mask_insurance_register"); 
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				StringBuilder strNewAudit=new StringBuilder();
				if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Delete")){

					strNewAudit.append("~Insurance Company Name = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_compname")));
					strNewAudit.append("~Policy Number = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_policyno")));
					strNewAudit.append("~Policy Date = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_policydate")));
					strNewAudit.append("~Due Date for renewal = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_duedate")));
					strNewAudit.append("~Expiry Date = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_expirydate")));
					strNewAudit.append("~Insurance Covered Amount = ");
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_credamt")));
					strNewAudit.append("~Cover Note No = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_coverno")));
					}
					
					strNewAudit.append("~Beneficiary Name = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_beneficial")));
					}
					strNewAudit.append("~Whether bank Clause covered = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					if(Helper.correctNull((String)hshValues.get("bnk_cond")).equalsIgnoreCase("Y"))
					{
						strNewAudit.append("Yes");
					}
					else if(Helper.correctNull((String)hshValues.get("bnk_cond")).equalsIgnoreCase("N"))
					{
						strNewAudit.append("No");
					}
					else{
						strNewAudit.append("");
					}
					}
					strNewAudit.append("~Premium paid by = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					if(Helper.correctNull((String)hshValues.get("sel_prempdby")).equalsIgnoreCase("b"))
					{
						strNewAudit.append("bank");
					}
					else if(Helper.correctNull((String)hshValues.get("sel_prempdby")).equalsIgnoreCase("a"))
					{
						strNewAudit.append("Applicant");
					}
					else{
						strNewAudit.append("");
					}
					}
					strNewAudit.append("~Premium Amount = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					strNewAudit.append(Helper.correctNull((String)hshValues.get("insreg_premamt")));
					}
					strNewAudit.append("~Whether Exemptions of risk = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
					if(Helper.correctNull((String)hshValues.get("sel_risk")).equalsIgnoreCase("y"))
					{
						strNewAudit.append("Yes");
					}
					else if(Helper.correctNull((String)hshValues.get("sel_risk")).equalsIgnoreCase("n"))
					{
						strNewAudit.append("No");
					}
					else{
						strNewAudit.append("");
					}
					}
					strNewAudit.append("~Risk Factor = ");
					if(strAction.equalsIgnoreCase("Delete"))
					{
						strNewAudit.append("");
					}
					else{
						strQuery = SQLParser.getSqlQuery("selstatdatabyiddesc^"+"38"+"^"+Helper.correctNull((String)hshValues.get("txt_rskfactor")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							strNewAudit.append(Helper.correctNull((String)rs1.getString("stat_data_desc1")));
						}
						else
						{
							strNewAudit.append("");
						}
					}
						strNewAudit.append("~ Address 1 =  ");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_insaddres1")));
						}
						strNewAudit.append("~Address 2 =");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_insaddres2")));
						}
						strNewAudit.append("~Address 3 =  ");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_insaddres3")));
						}
						strNewAudit.append("~City = ");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_inscity")));
						}
						strNewAudit.append("~State = ");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_insstate")));
						}
						strNewAudit.append("~Pincode = ");
						if(strAction.equalsIgnoreCase("Delete"))
						{
							strNewAudit.append("");
						}
						else{
						strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_inspincode")));
						}
				
				}
				else if(strAction.equalsIgnoreCase("Mask"))
				{
					strNewAudit.append("~ The Record is masked");
				}
				AuditTrial.auditNewLog(hshValues, "312", cbsaccount, strNewAudit.toString(), strOldValues.toString());
			
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
				throw new EJBException("Error closing in updateInsuranceDetails the connection "+cf.getMessage());
						
			}
		}
	}
	
	public HashMap getInsuranceDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		String strappno = correctNull((String)hshValues.get("cbsaccno"));
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = correctNull((String)hshValues.get("cbsappno"));
		}
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = correctNull((String)hshValues.get("txt_accountno"));
		}
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = correctNull((String)hshValues.get("mon_accno"));
		}
		
		String strcbsid = correctNull((String)hshValues.get("cbsid"));
		try
		{
			
			strQuery=SQLParser.getSqlQuery("get_insurance_register^"+strappno+"^"+strcbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("ins_srlno")));
				vecCol.add(correctNull((String)rs.getString("ins_cbsid")));
				vecCol.add(correctNull((String)rs.getString("ins_security")));
				vecCol.add(correctNull((String)rs.getString("ins_company")));
				vecCol.add(correctNull((String)rs.getString("ins_policyno")));
				vecCol.add(correctNull((String)rs.getString("ins_clause")));
				vecCol.add(correctNull((String)rs.getString("ins_coveramt")));
				vecCol.add(correctNull((String)rs.getString("ins_premiumamt")));
				vecCol.add(correctNull((String)rs.getString("ins_paid_by")));
				vecCol.add(correctNull((String)rs.getString("ins_beneficiary")));
				vecCol.add(correctNull((String)rs.getString("duedate")));
				vecCol.add(correctNull((String)rs.getString("ins_risk")));
				vecCol.add(correctNull((String)rs.getString("ins_details")));
				vecCol.add(correctNull((String)rs.getString("ins_covernote")));
				vecCol.add(correctNull((String)rs.getString("policydate")));
				vecCol.add(correctNull((String)rs.getString("ins_expirydate")));
				vecCol.add(correctNull((String)rs.getString("ins_riskfactor")));
				String strriskfactor =correctNull((String)rs.getString("ins_riskfactor"));
				
				strQuery=SQLParser.getSqlQuery("get_insu_staticdesc^"+strriskfactor);
				rs1=DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					strriskfactor=correctNull((String)rs1.getString("stat_data_desc1"));
				}
				//hshRecord.put("strriskfactor",strriskfactor);
				if(!strriskfactor.equalsIgnoreCase(""))
				{
				vecCol.add(strriskfactor);
				}
				else
				{
				vecCol.add("");
				}
				vecCol.add(correctNull((String)rs.getString("ins_insuredaddr1")));
				vecCol.add(correctNull((String)rs.getString("ins_insuredaddr2")));
				vecCol.add(correctNull((String)rs.getString("ins_insuredaddr3")));
				vecCol.add(correctNull((String)rs.getString("ins_insuredcity")));
				vecCol.add(correctNull((String)rs.getString("ins_insuredstate")));
				vecCol.add(correctNull((String)rs.getString("ins_insuredpincode")));
				vecCol.add(correctNull((String)rs.getString("ins_accountno")));
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("Accno",strappno);
			hshRecord.put("strcbsid",strcbsid);
			hshRecord.put("orgLevel", Helper.correctNull((String)hshValues.get("strOrgLevel")));
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
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in the getInsuranceDetails connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}		
	public void updateDBC(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="";
		
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		strAppno=Helper.correctNull((String)hshValues.get("txt_account_no"));
		String str_documentname=Helper.correctNull((String)hshValues.get("txt_document_name"));
		String str_datedbc=Helper.correctNull((String)hshValues.get("txt_dateofdbc"));
		String str_amountdbc=Helper.correctNull((String)hshValues.get("txt_amount_dbc"));
		String str_remarksdbc=Helper.correctNull((String)hshValues.get("txt_remarks_dbc"));
		
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="selmaxmon_dbc^"+strAppno;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("dbc_sno"));
				}
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_mondbc");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_documentname);
				arrValues.add(str_datedbc);
				arrValues.add(str_amountdbc);
				arrValues.add(str_remarksdbc);
				
				
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
				hshQuery.put("strQueryId","upd_mondbc");
				
				
				arrValues.add(str_documentname);
				arrValues.add(str_datedbc);
				arrValues.add(str_amountdbc);
				arrValues.add(str_remarksdbc);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				
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
				hshQuery.put("strQueryId","del_mondbc");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updateDBC"+e.getMessage());
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
				throw new EJBException("Error closing in the updateDBC connection "+cf.getMessage());
						
			}
		}
	
	}
	
	public HashMap getDBC(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_mondbc");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("dbc_sno")));
				vecCol.add(correctNull((String)rs.getString("dbc_appno")));
				vecCol.add(correctNull((String)rs.getString("dbc_documentname")));
				vecCol.add(correctNull((String)rs.getString("dbc_datedbc")));
				vecCol.add(correctNull((String)rs.getString("dbc_amountdbc")));
				vecCol.add(correctNull((String)rs.getString("dbc_remarksdbc")));
				
				
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
				throw new EJBException("Error closing in the getDBC connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}

	
	public void updateConsortium(HashMap hshValues)
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=null;
		String strQuery="";
		String cbsid="29191919";
		ResultSet rs=null;
		String con_seqid=Helper.correctNull((String)hshValues.get("hidSeqid"));
		
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			
			if(strAction.equalsIgnoreCase("Insert"))
			{
				strQuery=SQLParser.getSqlQuery("getmaxconseqid^"+cbsid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					con_seqid=Helper.correctNull((String)rs.getString("maxid"));
				}
				if(con_seqid.equalsIgnoreCase(""))
				{
					con_seqid="0";
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_mon_consortium");
				arrValues.add(cbsid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_bank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_facility")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_asset")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstand")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_drawpower")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_remarks")));
				arrValues.add(con_seqid);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("Update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_mon_consortium");
				arrValues.add(cbsid);
				arrValues.add(con_seqid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_mon_consortium");
				arrValues.add(cbsid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_bank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_bank")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_facility")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_asset")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstand")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_drawpower")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_sanction")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_remarks")));
				arrValues.add(con_seqid);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_mon_consortium");
				arrValues.add(cbsid);
				arrValues.add(con_seqid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
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
			throw new EJBException("Error closing in the updateConsortium connection "+cf.getMessage());
					
		}
	}
	
	
	}
	public HashMap getConstoritum(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String cbsid="29191919";
		String hidSeqid=Helper.correctNull((String)hshValues.get("hidSeqid"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("get_mon_consortium^"+cbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("CON_SEQID")));
				vecCol.add(correctNull((String)rs.getString("CON_CBSID")));
				vecCol.add(correctNull((String)rs.getString("CON_BANKDATE")));
				vecCol.add(correctNull((String)rs.getString("CON_LEAD")));
				vecCol.add(correctNull((String)rs.getString("CON_FACILITY")));
				vecCol.add(correctNull((String)rs.getString("CON_SHARES")));
				vecCol.add(correctNull((String)rs.getString("CON_ASSET")));
				vecCol.add(correctNull((String)rs.getString("CON_OUTSTANDING")));
				vecCol.add(correctNull((String)rs.getString("CON_DRAWING")));
				vecCol.add(correctNull((String)rs.getString("CON_SANCTION")));
				vecCol.add(correctNull((String)rs.getString("CON_REMARKS")));
				
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidSeqid",hidSeqid);
		}
	catch(Exception e)
	{
		throw new EJBException("Error in updatePresentPosition"+e.getMessage());
	}
	
	
		return hshRecord;
	}
	
	

/*	public void updateInterestRegister(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
			
		ResultSet rs=null;
		String strQuery ="";
		String strsno="";
		String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String accno=Helper.correctNull((String)hshValues.get("txt_accno"));
		String amtvalue=Helper.correctNull((String)hshValues.get("txt_amount"));
		String penalvalue=Helper.correctNull((String)hshValues.get("txt_penalintamt"));
		String totalamt=Helper.correctNull((String)hshValues.get("txt_totinterestamt"));
		String appdate=Helper.correctNull((String)hshValues.get("txt_appdate"));
		String servicedate=Helper.correctNull((String)hshValues.get("txt_servicedate"));
		
		String hidsno=Helper.correctNull((String)hshValues.get("hid_sno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxinterestregister";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("intreg_sno"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insinterestregister");
				arrValues.add(accno);
				arrValues.add(strsno);
				arrValues.add(amtvalue);
				arrValues.add(penalvalue);
				arrValues.add(totalamt);
				arrValues.add(appdate);
				arrValues.add(servicedate);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
				
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
				hshQuery.put("strQueryId","updinterestregister");
				arrValues.add(amtvalue);
				arrValues.add(penalvalue);
				arrValues.add(totalamt);
				arrValues.add(appdate);
				arrValues.add(servicedate);
				arrValues.add(accno);
				arrValues.add(hidsno);
				
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
				arrValues.add(accno);
				arrValues.add(hidsno);
				hshQuery.put("strQueryId","delinterestregister");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updateInterestRegister"+e.getMessage());
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
				throw new EJBException("Error closing in the updateInterestRegister connection "+cf.getMessage());
						
			}
		}
}*/
/*	public HashMap getInterestRegister(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
			
		try
		{
			
			if(rs!=null)
			{
					rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selinterestregister");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("intreg_accno")));
				vecCol.add(correctNull((String)rs.getString("intreg_sno")));
				vecCol.add(correctNull((String)rs.getString("intreg_interestamt")));
				vecCol.add(correctNull((String)rs.getString("intreg_penalamt")));
				vecCol.add(correctNull((String)rs.getString("intreg_totalamt")));
				vecCol.add(correctNull((String)rs.getString("intreg_appdate")));
				vecCol.add(correctNull((String)rs.getString("intreg_servicedate")));
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
				throw new EJBException("Error closing in the getInterestRegister connection "+cf.getMessage());
						
			}
		}
		
		return hshRecord;
	}*/
/*	public void updateInstallmentRegister(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues= new ArrayList();
			
		ResultSet rs=null;
		String strQuery ="";
		String strsno="";
		String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String accno=Helper.correctNull((String)hshValues.get("txt_accno"));
		String installamt=Helper.correctNull((String)hshValues.get("txt_installamount"));
		String installdue=Helper.correctNull((String)hshValues.get("txt_installdue"));
		String installpaid=Helper.correctNull((String)hshValues.get("txt_installpaid"));
				
		String hidsno=Helper.correctNull((String)hshValues.get("hid_sno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxinstallmentregister";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("intstallreg_sno"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insinstallmentregister");
				arrValues.add(accno);
				arrValues.add(strsno);
				arrValues.add(installamt);
				arrValues.add(installdue);
				arrValues.add(installpaid);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
								
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
				hshQuery.put("strQueryId","updinstallmentregister");
				arrValues.add(installamt);
				arrValues.add(installdue);
				arrValues.add(installpaid);
				arrValues.add(accno);
				arrValues.add(hidsno);
				
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
				arrValues.add(accno);
				arrValues.add(hidsno);
				hshQuery.put("strQueryId","delinstallmentregister");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updateInstallmentRegister"+e.getMessage());
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
				throw new EJBException("Error closing in the updateInstallmentRegister connection "+cf.getMessage());
						
			}
		}	
		
		
		
}*/
/*	public HashMap getInstallmentRegister(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
			
		try
		{
			
			if(rs!=null)
			{
					rs.close();

			}
			rs=DBUtils.executeLAPSQuery("selinstallmentregister");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("intstallreg_accno")));
				vecCol.add(correctNull((String)rs.getString("intstallreg_sno")));
				vecCol.add(correctNull((String)rs.getString("intstall_amt")));
				vecCol.add(correctNull((String)rs.getString("intstall_duedate")));
				vecCol.add(correctNull((String)rs.getString("intstall_paiddate")));
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
				throw new EJBException("Error closing in the getInstallmentRegister connection "+cf.getMessage());
						
			}
		}
		
		return hshRecord;
	}*/

	public void updateSecurityMaster(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="";
		
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		strAppno=Helper.correctNull((String)hshValues.get("txt_account_no"));
		String str_typesecurity=Helper.correctNull((String)hshValues.get("sel_security"));
		String str_detailsecurity=Helper.correctNull((String)hshValues.get("txt_detail_security"));
		String str_valuername=Helper.correctNull((String)hshValues.get("txt_valuer_name"));
		String str_valuationdate=Helper.correctNull((String)hshValues.get("txt_valuationdate"));
		String str_valuesecurity=Helper.correctNull((String)hshValues.get("txt_valuesecurity"));
		String str_nature=Helper.correctNull((String)hshValues.get("sel_nature"));
		String str_insuranceno=Helper.correctNull((String)hshValues.get("txt_insuranceno"));
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="selmaxmonsecuritymaster^"+strAppno;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("secu_sno"));
				}
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_monsecuritymaster");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_typesecurity);
				arrValues.add(str_detailsecurity);
				arrValues.add(str_valuername);
				if(str_valuationdate.equalsIgnoreCase("")||str_valuationdate.equalsIgnoreCase("null"))
				{
					arrValues.add("");
				}
				else
				{
				arrValues.add(str_valuationdate);
				}
				arrValues.add(str_valuesecurity);
				arrValues.add(str_nature);
				arrValues.add(str_insuranceno);
				
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
				hshQuery.put("strQueryId","upd_monsecuritymaster");
				
				
				arrValues.add(str_typesecurity);
				arrValues.add(str_detailsecurity);
				arrValues.add(str_valuername);
				arrValues.add(str_valuationdate);
				arrValues.add(str_valuesecurity);
				arrValues.add(str_nature);
				arrValues.add(str_insuranceno);
				
				arrValues.add(strAppno);
				arrValues.add(strsno);
				
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
				hshQuery.put("strQueryId","del_monsecuritymaster");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updatePresentPosition"+e.getMessage());
		}
	}
	
	public HashMap getSecurityMaster(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_monsecuritymaster");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				
				vecCol.add(correctNull((String)rs.getString("secu_sno")));
				vecCol.add(correctNull((String)rs.getString("secu_appno")));
				vecCol.add(correctNull((String)rs.getString("secu_typesecurity")));
				vecCol.add(correctNull((String)rs.getString("secu_detailsecurity")));
				vecCol.add(correctNull((String)rs.getString("secu_valuername")));
				vecCol.add(correctNull((String)rs.getString("secu_valuationdate")));
				vecCol.add(correctNull((String)rs.getString("secu_valuesecurity")));
				vecCol.add(correctNull((String)rs.getString("secu_nature")));
				vecCol.add(correctNull((String)rs.getString("secu_insurancepolicy")));
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
		/*try
		{
		strQuery = SQLParser.getSqlQuery("facSecurityStatData^"+12);
		
		if(rs != null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecVal=new ArrayList();
			vecVal.add(rs.getString(1));
			vecVal.add(rs.getString(2));
			vecVal.add("");
			vecVal.add("");
			vecVal.add("");
			vecVal.add("");
			vecVal.add("S");
			vecData.add(vecVal);
		}
		hshRecord.put("vecData",vecData);
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSecurityMaster"+e.getMessage());
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
				throw new EJBException("Error closing in the getSecurityMaster connection "+cf.getMessage());
						
			}
		}
		return hshRecord;*/
	}

/*	public void updateRenewalRegister(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		ArrayList arrValues= new ArrayList();
				
		ResultSet rs=null;
		String strQuery ="";
		String strsno="";
		String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		String straccno=Helper.correctNull((String)hshValues.get("txt_accno"));
		String strsanctioneddate=Helper.correctNull((String)hshValues.get("txt_sanctioneddue"));
		String strrenewaldate=Helper.correctNull((String)hshValues.get("txt_renewaldate"));
						
		String hidsno=Helper.correctNull((String)hshValues.get("hid_sno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="sel_maxrenewalregister";
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("renewal_sno"));
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","insrenewalregister");
				arrValues.add(straccno);
				arrValues.add(strsno);
				arrValues.add(strsanctioneddate);
				arrValues.add(strrenewaldate);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
								
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
				hshQuery.put("strQueryId","updrenewalregister");
				arrValues.add(strsanctioneddate);
				arrValues.add(strrenewaldate);
				arrValues.add(straccno);
				arrValues.add(hidsno);
				
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
				arrValues.add(straccno);
				arrValues.add(hidsno);
				hshQuery.put("strQueryId","delrenewalregister");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
					
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updateRenewalRegister"+e.getMessage());
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
				throw new EJBException("Error closing in the updateRenewalRegister connection "+cf.getMessage());
						
			}
		}
		
}*/
	/*public HashMap getRenewalRegister(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
			
		try
		{
			
			if(rs!=null)
			{
					rs.close();

			}
			rs=DBUtils.executeLAPSQuery("selrenewalregister");
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("renewal_accno")));
				vecCol.add(correctNull((String)rs.getString("renewal_sno")));
				vecCol.add(correctNull((String)rs.getString("renewal_sanctioneddate")));
				vecCol.add(correctNull((String)rs.getString("renewal_renewaldate")));
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
				throw new EJBException("Error closing in the getRenewalRegister connection "+cf.getMessage());
						
			}
		}
		
		
		return hshRecord;
	}*/
	public void updateDrawingpower(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ResultSet rs=null;
		ArrayList arrValues=null;
		String strAppno="";
		String strQuery="";
		String strsno="";
		
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		
		
		strsno=Helper.correctNull((String)hshValues.get("hid_strsno"));
		String str_name=Helper.correctNull((String)hshValues.get("txt_name"));
		strAppno=Helper.correctNull((String)hshValues.get("txt_accno"));
		String str_facility=Helper.correctNull((String)hshValues.get("txt_facility"));
		String str_limit=Helper.correctNull((String)hshValues.get("txt_limit"));
		String str_limitsanctionedate=Helper.correctNull((String)hshValues.get("txt_limitsanctionedate"));
		String str_stockvalue=Helper.correctNull((String)hshValues.get("txt_stockvalue"));
		String str_stockdate=Helper.correctNull((String)hshValues.get("txt_stockdate"));
		String str_margin=Helper.correctNull((String)hshValues.get("txt_margin"));
		String str_drawingpower=Helper.correctNull((String)hshValues.get("txt_drawingpower"));
		
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				if(rs!=null)
				{
					rs.close();
				}
				strQuery="selmaxmondrawingpower^"+strAppno;
				rs=DBUtils.executeLAPSQuery(strQuery);
				if(rs.next())
				{
					 strsno=Helper.correctNull((String)rs.getString("draw_sno"));
				}
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","ins_mondrawingpower");
				arrValues.add(strAppno);
				arrValues.add(strsno);
				arrValues.add(str_name);
				arrValues.add(str_facility);
				arrValues.add(str_limit);
				arrValues.add(str_limitsanctionedate);
				arrValues.add(str_stockvalue);
				arrValues.add(str_stockdate);
				arrValues.add(str_margin);
				arrValues.add(str_drawingpower);
				
				
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
				hshQuery.put("strQueryId","upd_mondrawingpower");
				
				
				arrValues.add(str_name);
				arrValues.add(str_facility);
				arrValues.add(str_limit);
				arrValues.add(str_limitsanctionedate);
				arrValues.add(str_stockvalue);
				arrValues.add(str_stockdate);
				arrValues.add(str_margin);
				arrValues.add(str_drawingpower);
				arrValues.add(strAppno);
				arrValues.add(strsno);
				
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
				hshQuery.put("strQueryId","del_mondrawingpower");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		}catch(Exception e)
		{
			throw new EJBException("Error in updateDrawingpower"+e.getMessage());
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
				throw new EJBException("Error closing in the updateDrawingpower connection "+cf.getMessage());
						
			}
		}
	
		
	}
	
	public HashMap getDrawingpower(HashMap hshValues)
	{
		ResultSet rs=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_mondrawingpower");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				
				
				vecCol.add(correctNull((String)rs.getString("draw_sno")));
				vecCol.add(correctNull((String)rs.getString("draw_appno")));
				vecCol.add(correctNull((String)rs.getString("draw_name")));
				vecCol.add(correctNull((String)rs.getString("draw_facility")));
				vecCol.add(correctNull((String)rs.getString("draw_limit")));
				vecCol.add(correctNull((String)rs.getString("draw_limitsanctionedate")));
				vecCol.add(correctNull((String)rs.getString("draw_stockvalue")));
				vecCol.add(correctNull((String)rs.getString("draw_stockdate")));
				vecCol.add(correctNull((String)rs.getString("draw_margin")));
				vecCol.add(correctNull((String)rs.getString("draw_drawingpower")));
				
				
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
				throw new EJBException("Error closing in the getDrawingpower connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}
	
	/*public void updatemonitorguarantor(HashMap hshValues) 
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=null;
		ArrayList arrValues=null;
		String strQuery="";
		String CUST_ID="29191919";
		ResultSet rs=null;
		String con_seqid=Helper.correctNull((String)hshValues.get("hidSeqid"));
		String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
		
		try
		{
			
			if(strAction.equalsIgnoreCase("Insert"))
			{
				strQuery=SQLParser.getSqlQuery("getmaxguarantorconseqid^"+CUST_ID);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					con_seqid=Helper.correctNull((String)rs.getString("FIL_SNO"));
				}
				if(con_seqid.equalsIgnoreCase(""))
				{
					con_seqid="0";
				}
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_mon_guarantor");
				arrValues.add(CUST_ID);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accountno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applicanttype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applicantname")));
				arrValues.add(con_seqid);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("Update"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_mon_guarantor");
				arrValues.add(CUST_ID);
				arrValues.add(con_seqid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","ins_mon_guarantor");
				arrValues.add(CUST_ID);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_accountno")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applicanttype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_applicantname")));
				arrValues.add(con_seqid);
				arrValues.add(strUserId);
				arrValues.add(Helper.getCurrentDateTime());
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("Delete"))
			{
				hshQuery=new HashMap();
				hshQueryValues=new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_mon_guarantor");
				arrValues.add(CUST_ID);
				arrValues.add(con_seqid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
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
			throw new EJBException("Error closing in the updatemonitorguarantor connection "+cf.getMessage());
					
		}
	}
	
	
	}*/
	/*	public HashMap getmonitorguarantor(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String CUST_ID="29191919";
		String hidSeqid=Helper.correctNull((String)hshValues.get("hidSeqid"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("get_mon_guarantor^"+CUST_ID);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("FIL_SNO")));
				vecCol.add(correctNull((String)rs.getString("CUST_ID")));
				vecCol.add(correctNull((String)rs.getString("FIL_ACCOUNTNO")));
				vecCol.add(correctNull((String)rs.getString("FIL_TYPE_APPLICANT")));
				vecCol.add(correctNull((String)rs.getString("FIL_APPLICANT_NAME")));
				
				
				vecRow.add(vecCol);
			}
			hshRecord.put("vecRow",vecRow);
			hshRecord.put("hidSeqid",hidSeqid);
		}
	catch(Exception e)
	{
		throw new EJBException("Error in getmonitorguarantor"+e.getMessage());
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
			throw new EJBException("Error closing in the getmonitorguarantor connection "+cf.getMessage());
					
		}
	}
	

		return hshRecord;
	}*/

public HashMap getSecurity(HashMap hshValues) 
{
	HashMap hshRecord=new HashMap();
	ResultSet rs=null;
	String strQuery="";
	
	ArrayList vecCol = new ArrayList();
	ArrayList vecRow = new ArrayList();
	String strAppno="";
	strAppno=Helper.correctNull((String)hshValues.get("txt_accno"));
	try
	{
		strQuery=SQLParser.getSqlQuery("getSecurityDetails^"+strAppno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			vecCol = new ArrayList();
			vecCol.add(correctNull((String)rs.getString("secu_sno")));
			vecCol.add(correctNull((String)rs.getString("secu_appno")));
			vecCol.add(correctNull((String)rs.getString("secu_typesecurity")));
			vecCol.add(correctNull((String)rs.getString("secu_detailsecurity")));
			vecCol.add(correctNull((String)rs.getString("secu_valuername")));
			vecCol.add(correctNull((String)rs.getString("secu_valuationdate")));
			vecCol.add(correctNull((String)rs.getString("secu_valuesecurity")));
			vecRow.add(vecCol);
		}
		
		hshRecord.put("vecRow",vecRow);
		
	}
	catch(Exception ae)
	{
		throw new EJBException("Error in Security Details "+ae.getMessage());
	}
	
	return hshRecord;
	
}

public void updatebranchcomments(HashMap hshValues)
{
	HashMap hshQuery=null;
	HashMap hshQueryValues=null;
	ArrayList arrValues=new ArrayList();
	
	String strUserId =correctNull((String)hshValues.get("strUserId"));
	String strAction =correctNull((String)hshValues.get("hidAction"));
	String strRecordFlag="";
	try
	{
		strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","del_branchheadcomments");
			arrValues.add(correctNull((String)hshValues.get("mmrno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			
			hshQuery.put("strQueryId","ins_branchheadcomments");
			arrValues.add(correctNull((String)hshValues.get("cbsid")));
			arrValues.add(correctNull((String)hshValues.get("sel_operations")));
			arrValues.add(correctNull((String)hshValues.get("txt_operations")));
			arrValues.add(correctNull((String)hshValues.get("sel_sanction")));
			arrValues.add(correctNull((String)hshValues.get("txt_sanction")));
			arrValues.add(correctNull((String)hshValues.get("sel_irregular")));
			arrValues.add(correctNull((String)hshValues.get("txt_irregularities")));
			arrValues.add(correctNull((String)hshValues.get("sel_observation")));
			arrValues.add(correctNull((String)hshValues.get("txt_observations")));
			arrValues.add(correctNull((String)hshValues.get("mon_year")));
			arrValues.add(correctNull((String)hshValues.get("mon_month")));
			arrValues.add(strUserId);
			arrValues.add(Helper.getCurrentDateTime());
			arrValues.add(correctNull((String)hshValues.get("mmrno")));
			// Added by Subha for MMR Print Format as per suresh said on 04/04/2012
			arrValues.add(correctNull((String)hshValues.get("sel_limits")));
			arrValues.add(correctNull((String)hshValues.get("txt_limits")));
			// End
			
			//Added By Zahoorunnisa.S as per Suresh on 19th April 2012
			arrValues.add(correctNull((String)hshValues.get("txt_noname")));
			arrValues.add(correctNull((String)hshValues.get("txt_nodesgn")));
			arrValues.add(correctNull((String)hshValues.get("txt_ainame")));
			arrValues.add(correctNull((String)hshValues.get("txt_aidesgn")));
			arrValues.add(correctNull((String)hshValues.get("txt_bhname")));
			arrValues.add(correctNull((String)hshValues.get("txt_bhdesgn")));
			//End
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQuery=new HashMap();
			hshQueryValues=new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","del_branchheadcomments");
			arrValues.add(correctNull((String)hshValues.get("mmrno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		
		// Audit Trial
		StringBuilder sbAt = new StringBuilder();
		if(!strAction.equals("delete"))
		{
			sbAt.append("WHETHER LIMITS ARE VALID AND IN FORCE =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_limits"))));
			sbAt.append("~ ARE YOU SATISFIED WITH THE OPERATIONS IN THE ACCOUNT =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_operations"))));
			sbAt.append("~ WHETHER ALL THE SANCTION STIPULATIONS INCLUDING CREATION OF EM/ROC ARE COMPLIED WITH =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_sanction"))));
			sbAt.append("~ WHETHER IRREGULARITIES OF EARLIER MONITORING REPORT OBSERVED BY YOU AND POINTED OUT BY RO/FGMO/CO ARE RECTIFIED. IF NOT, REASONS THEREOF. =").append(SetupParams.getSetupParams("YesNoFlag", correctNull((String)hshValues.get("sel_irregular"))));
			
			if(strRecordFlag.equalsIgnoreCase("Y")){
				hshValues.put("hidAction", "update");
			}else if(strRecordFlag.equalsIgnoreCase("N")){
				hshValues.put("hidAction", "insert");
			}
		}
		AuditTrial.auditLog(hshValues,"413",correctNull((String)hshValues.get("mmrno")),sbAt.toString());
	}
	catch(Exception e1)
	{
		e1.printStackTrace();
		//throw new EJBException(e1.getMessage());
	}
}
public HashMap getbranchcomments(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs=null;
	String strQuery="";
	String strmmrno=correctNull((String)hshValues.get("mmrno"));
	String strEXI=Helper.correctNull((String)hshValues.get("hidEXCheck"));
	String strExists="N";
	boolean recordflag=false;
	try
	{
		if(strEXI.equalsIgnoreCase("EXI"))
		{
			strQuery = SQLParser.getSqlQuery("sel_branchheadcomments^"+strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strExists="Y";
			}
			hshResult.put("exists",strExists);
		}
		else
		{
			strQuery = SQLParser.getSqlQuery("sel_branchheadcomments^"+strmmrno);
			rs = DBUtils.executeQuery(strQuery);	
			if (rs.next())
			{ 
				recordflag=true;
				//hshResult.put("cbs_id",correctNull(rs.getString("cbs_id")));
				hshResult.put("mon_operation",correctNull(rs.getString("mon_operation")));
				hshResult.put("mon_operationdetails",correctNull(rs.getString("mon_operationdetails")));
				hshResult.put("mon_sanction",correctNull(rs.getString("mon_sanction")));
				hshResult.put("mon_sanctiondetails",correctNull(rs.getString("mon_sanctiondetails")));
				hshResult.put("mon_irregular",correctNull(rs.getString("mon_irregular")));
				hshResult.put("mon_irregulardetails",correctNull(rs.getString("mon_irregulardetails")));
				hshResult.put("mon_observation",correctNull(rs.getString("mon_observation")));
				hshResult.put("mon_observationdetails",correctNull(rs.getString("mon_observationdetails")));	
				// Added by Subha for MMR print format as per suresh said on 04/04/2012
				hshResult.put("mon_limits",correctNull(rs.getString("mon_limits")));
				hshResult.put("mon_limitsreason",correctNull(rs.getString("mon_limitsreason")));
				//Added By Zahoorunnisa.S as per Suresh on 19th April 2012
				hshResult.put("mon_noname",correctNull(rs.getString("mon_noname")));
				hshResult.put("mon_nodesgn",correctNull(rs.getString("mon_nodesgn")));
				hshResult.put("mon_ainame",correctNull(rs.getString("mon_ainame")));
				hshResult.put("mon_aidesgn",correctNull(rs.getString("mon_aidesgn")));
				hshResult.put("mon_bhname",correctNull(rs.getString("mon_bhname")));
				hshResult.put("mon_bhdesgn",correctNull(rs.getString("mon_bhdesgn")));
				//end
			}
			
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
		}
		if(rs!=null)
		{
			rs.close();
		}
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getBranchCommentsData-- "+ce.toString());
	}
	finally
	{
		try
		{	
			if(rs != null)
				rs.close();
		}
		catch(Exception cf)
		{
			throw new EJBException("Error closing the connection "+cf.getMessage());
		}
	}
	return hshResult;
}


public void updateAuditorsInspection(HashMap hshValues) 
{
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	ArrayList arrValues= new ArrayList();
	
	String strAudittype="";
	
	String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
	strAudittype=correctNull((String)hshValues.get("sel_audittype"));
	
	String strcbsid =Helper.correctNull((String)hshValues.get("cbsid"));
	if(strcbsid.equalsIgnoreCase(""))
	{
		strcbsid =Helper.correctNull((String)hshValues.get("hidcbsid"));
	}
	String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	String Strmmrno=Helper.correctNull((String)hshValues.get("mmrno"));
	try
	{
		//strCustid = correctNull((String) hshValues.get("mon_custid"));
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_monauditcomments");
			//arrValues.add(strcbsid);
			arrValues.add(strAudittype);
			//arrValues.add(stryear);
			//arrValues.add(strmonth);
			arrValues.add(Strmmrno);
		
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
		
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","ins_monauditcomments");
		
			arrValues.add(strcbsid);
			arrValues.add(correctNull((String)hshValues.get("sel_audittype")));
			arrValues.add(correctNull((String)hshValues.get("txt_auditor")));
			arrValues.add(correctNull((String)hshValues.get("txt_officer")));
			arrValues.add(correctNull((String)hshValues.get("txt_auditdate")));
			
			arrValues.add(stryear);
			arrValues.add(strmonth);
			arrValues.add(Strmmrno);
			//arrValues.add(correctNull((String)hshValues.get("stryear")));
			//arrValues.add(correctNull((String)hshValues.get("strmonth")));
			//arrValues.add(strUserId);
		//	arrValues.add(Helper.getCurrentDateTime());
						
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_monauditcomments");
			//arrValues.add(strcbsid);
			arrValues.add(strAudittype);
			//arrValues.add(stryear);
			//arrValues.add(strmonth);
			arrValues.add(Strmmrno);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
	}catch (Exception e)
	{
		throw new EJBException("Error in Insert Data " + e.getMessage());
	} 
}


public HashMap getAuditorsInspection(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs = null;
	String strAudittype="", strQuery="";
	try
	{
		strAudittype=correctNull((String)hshValues.get("sel_audittype"));
		//String strcbsid =correctNull((String)hshValues.get("cbsid"));
		//String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
		//String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
		String Strmmrno=Helper.correctNull((String)hshValues.get("mmrno"));
		if(strAudittype.equalsIgnoreCase(""))
		{
			strAudittype="0";
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("sel_monauditcomments^"+strAudittype+"^"+Strmmrno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshResult.put("auditorscomments",correctNull((String)rs.getString("mon_auditorcomments")));
			hshResult.put("officercomments",correctNull((String)rs.getString("mon_officerscomments")));
			hshResult.put("auditdate",correctNull((String)rs.getString("mon_auditdate")));
		}
	
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
			throw new EJBException("Error in closing the connection in getAuditorsInspection :: "+ exp.toString()); 
		}
	}
	
	return hshResult;
}
public void updatemonitorchecklist(HashMap hshValues) 
{
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery=new HashMap();
	ArrayList arrValues= new ArrayList();
	
	String strCustAccno="" ;
	String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
	String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
	try
	{
		strCustAccno = correctNull((String) hshValues.get("cbsaccno"));
		if(strAction.equalsIgnoreCase("insert"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_monchecklist");
			arrValues.add(strCustAccno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
		
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues.put("size","2");
			hshQuery.put("strQueryId","ins_monchecklist");
			arrValues.add(strCustAccno);
			arrValues.add(correctNull((String)hshValues.get("sel_roc")));
			arrValues.add(correctNull((String)hshValues.get("txt_rocdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_resoludate")));
			arrValues.add(correctNull((String)hshValues.get("sel_dbc")));
			arrValues.add(correctNull((String)hshValues.get("txt_dbcdate")));
			arrValues.add(correctNull((String)hshValues.get("txt_dbcamount")));
			arrValues.add(correctNull((String)hshValues.get("sel_gua")));
			arrValues.add(correctNull((String)hshValues.get("sel_guasign")));
			arrValues.add(correctNull((String)hshValues.get("sel_equitable")));
			arrValues.add(correctNull((String)hshValues.get("sel_equitperfect")));
			arrValues.add(strUserId);
			arrValues.add(Helper.getCurrentDateTime());
			arrValues.add(correctNull((String)hshValues.get("sel_msod")));
			arrValues.add(correctNull((String)hshValues.get("sel_stock")));
			arrValues.add(correctNull((String)hshValues.get("sel_bookdebts")));
			arrValues.add(correctNull((String)hshValues.get("sel_qpr")));
			arrValues.add(correctNull((String)hshValues.get("sel_inspection")));
			
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","del_monchecklist");
			arrValues.add(strCustAccno);
					
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			hshValues.put("hidAction","Update");
		
		StringBuilder strAudit = new StringBuilder();
		if(strAction.equalsIgnoreCase("insert"))
		{
			strAudit.append("~Charge with ROC Registered =");
			if(Helper.correctNull((String)hshValues.get("sel_roc")).equalsIgnoreCase("Y"))
			{
				strAudit.append("Yes");
				strAudit.append("~Date of ROC =");
				strAudit.append(Helper.correctNull((String)hshValues.get("txt_rocdate")));
				strAudit.append("~Date of Resolution =");
				strAudit.append(Helper.correctNull((String)hshValues.get("txt_resoludate")));
				
			}
			else if(Helper.correctNull((String)hshValues.get("sel_roc")).equalsIgnoreCase("n"))
			{
				strAudit.append("No");
			}
			else if(Helper.correctNull((String)hshValues.get("sel_roc")).equalsIgnoreCase("na")){
				strAudit.append("Not Applicable");
			}
			strAudit.append("~Whether DBC obtained =");
			if(Helper.correctNull((String)hshValues.get("sel_dbc")).equalsIgnoreCase("Y"))
			{
				strAudit.append("Yes");
				strAudit.append("~Date of DBC =");
				strAudit.append(Helper.correctNull((String)hshValues.get("txt_dbcdate")));
				strAudit.append("~Amount of DBC=");
				strAudit.append(ApplicationParams.getCurrency() + " "+Helper.correctNull((String)hshValues.get("txt_dbcamount")));
				
			}
			else if(Helper.correctNull((String)hshValues.get("sel_dbc")).equalsIgnoreCase("n"))
			{
				strAudit.append("No");
			}
			strAudit.append("~Whether equitable mortgage applicable =");
			if(Helper.correctNull((String)hshValues.get("sel_equitable")).equalsIgnoreCase("Y"))
			{
				strAudit.append("Yes");
				strAudit.append("~Equitable mortgage perfected =");
				if(Helper.correctNull((String)hshValues.get("sel_equitperfect")).equalsIgnoreCase("Y"))
				{
					strAudit.append("Yes");
				}
				else if(Helper.correctNull((String)hshValues.get("sel_equitperfect")).equalsIgnoreCase("n"))
				{
					strAudit.append("No");
				}
			}
			else if(Helper.correctNull((String)hshValues.get("sel_equitable")).equalsIgnoreCase("n"))
			{
				strAudit.append("No");
			}
			strAudit.append("~Whether MSOD to be obtained =");
			if(Helper.correctNull((String)hshValues.get("sel_msod")).equalsIgnoreCase("Y"))
			{
				strAudit.append("Yes");
				strAudit.append("~Stock statement to be obtained? =");
				if(Helper.correctNull((String)hshValues.get("sel_stock")).equalsIgnoreCase("Y"))
				{
					strAudit.append("Yes");
				}
				else if(Helper.correctNull((String)hshValues.get("sel_stock")).equalsIgnoreCase("n"))
				{
					strAudit.append("No");
				}
				strAudit.append("~Book Debts to be obtained? =");
				if(Helper.correctNull((String)hshValues.get("sel_bookdebts")).equalsIgnoreCase("Y"))
				{
					strAudit.append("Yes");
				}
				else if(Helper.correctNull((String)hshValues.get("sel_bookdebts")).equalsIgnoreCase("n"))
				{
					strAudit.append("No");
				}
				
			}
			else if(Helper.correctNull((String)hshValues.get("sel_msod")).equalsIgnoreCase("n"))
			{
				strAudit.append("No");
			}
			strAudit.append("~Whether QPR to be Obtained? =");
			if(Helper.correctNull((String)hshValues.get("sel_qpr")).equalsIgnoreCase("Y"))
			{
				strAudit.append("Yes");
			}
			else if(Helper.correctNull((String)hshValues.get("sel_qpr")).equalsIgnoreCase("n"))
			{
				strAudit.append("No");
			}
		}
		AuditTrial.auditLog(hshValues, "309" , strCustAccno, strAudit.toString());
		
	}catch (Exception e)
	{
		throw new EJBException("Error in Insert Data " + e.getMessage());
	} 
}


public HashMap getmonitorchecklist(HashMap hshValues)
{
	HashMap hshResult=new HashMap();
	ResultSet rs = null;
	String strCustAccno="",strQuery="";
	String recordflag = "N";
	try
	{
		strCustAccno=correctNull((String)hshValues.get("cbsaccno"));
		strQuery=SQLParser.getSqlQuery("sel_monchecklist^"+strCustAccno);
		rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				recordflag="Y";
				hshResult.put("cbs_accno",correctNull((String)rs.getString("cbs_accno")));
				hshResult.put("mon_roc",correctNull((String)rs.getString("mon_roc")));
				hshResult.put("mon_rocdate",correctNull((String)rs.getString("mon_rocdate")));
				hshResult.put("mon_resolutiondate",correctNull((String)rs.getString("mon_resolutiondate")));
				
				hshResult.put("mon_dbc",correctNull((String)rs.getString("mon_dbc")));
				hshResult.put("mon_dbcdate",correctNull((String)rs.getString("mon_dbcdate")));
				hshResult.put("mon_dbcamount",correctNull((String)rs.getString("mon_dbcamount")));
				hshResult.put("mon_guarantor",correctNull((String)rs.getString("mon_guarantor")));
				hshResult.put("mon_guarantorsigned",correctNull((String)rs.getString("mon_guarantorsigned")));
				hshResult.put("mon_equitable",correctNull((String)rs.getString("mon_equitable")));
				hshResult.put("mon_equitperfect",correctNull((String)rs.getString("mon_equitperfect")));
				
				hshResult.put("mon_checkmsod",correctNull((String)rs.getString("mon_checkmsod")));
				hshResult.put("mon_checkstock",correctNull((String)rs.getString("mon_checkstock")));
				hshResult.put("mon_checkbkdebts",correctNull((String)rs.getString("mon_checkbkdebts")));
				hshResult.put("mon_checkqpr",correctNull((String)rs.getString("mon_checkqpr")));
				hshResult.put("mon_inspection",correctNull((String)rs.getString("mon_inspection")));
			}
			
			hshResult.put("recordflag",recordflag);
			hshResult.put("strCustAccno",strCustAccno);
	
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


public void updatemonSecurityregister(HashMap hshValues)
{
	ResultSet rs = null;
	
	String strQuery=null;
	
	HashMap hshQueryValues=new HashMap();
	HashMap hshQuery = new HashMap();
	
	ArrayList arrValues = new ArrayList();
	
	
	try
	{
		String strAction = correctNull((String)hshValues.get("hidAction"));
		String strUserId = correctNull((String)hshValues.get("strUserId"));
		
		String strAccountnumber=Helper.correctNull((String)hshValues.get("cbsaccno"));
		
		
		String strsecuritytype = correctNull((String)hshValues.get("sel_securitytype"));
		String strsecuritynature = correctNull((String)hshValues.get("sel_securitynature"));
		String strotherdetails= correctNull((String)hshValues.get("txt_otherdetails"));	
		String stradd1 = correctNull((String)hshValues.get("txt_add1"));
		String stradd2 = correctNull((String)hshValues.get("txt_add2"));
		String strcity = correctNull((String)hshValues.get("txt_city"));
		String strstate = correctNull((String)hshValues.get("txt_state"));
		
		String strpincode = correctNull((String)hshValues.get("txt_pincode"));
		String strinsuranceno = correctNull((String)hshValues.get("txt_insuranceno"));
		String strvalueamout = correctNull((String)hshValues.get("txt_valueamout"));
		String strvaluedate = correctNull((String)hshValues.get("txt_valuedate"));
		String strvaluationdoneby = correctNull((String)hshValues.get("txt_valuationdoneby"));
		String strinspectedon = correctNull((String)hshValues.get("txt_inspectedon"));
		String strinspectedby = correctNull((String)hshValues.get("txt_inspectedby"));
		String straddresscheck = correctNull((String)hshValues.get("sel_addresscheck"));
		String monsec_shortfallnoticed = correctNull((String)hshValues.get("shortfallnotice"));
		
		String strSno = correctNull((String)hshValues.get("hidsno"));
		
		
		///old audit trial
		StringBuilder strOldAudit = new StringBuilder();
		if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Delete")||strAction.equalsIgnoreCase("Mask"))
		{
			strQuery = SQLParser.getSqlQuery("sel_monSecurity_audittrial^"+strAccountnumber+"^"+strSno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next()){
				strOldAudit.append("~ Type of security = ");
				if(Helper.correctNull((String)rs.getString("MONSEC_SECURITYTYPE")).equalsIgnoreCase("1"))
				{
					strOldAudit.append("Primary");
				}
				else if(Helper.correctNull((String)rs.getString("MONSEC_SECURITYTYPE")).equalsIgnoreCase("2"))
				{
					strOldAudit.append("Collateral");
				}
				else
				{
					strOldAudit.append("");
				}
				strOldAudit.append("~ Nature of security = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("STAT_DATA_DESC1")));
				strOldAudit.append("~ Address 1 = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_ADD1")));
				strOldAudit.append("~ Address 2 = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_ADD2")));
				strOldAudit.append("~ City = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_CITY")));
				strOldAudit.append("~ State = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_STATE")));
				strOldAudit.append("~ Pincode = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_PINCODE")));
				strOldAudit.append("~ Valuation Amount  = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_VALUATAMOUNT")));
				strOldAudit.append("~ Valued Date = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_VALUATDATE")));
				strOldAudit.append("~ Valuation Done By = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_VALUTDONEBY")));
				strOldAudit.append("~ Last Inspected On = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_INSPECTEDON")));
				strOldAudit.append("~ TLast Inspected By = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("MONSEC_INSPECTEDBY")));
				strOldAudit.append("~ Whether the address in the Insurance register is same = ");
				if(Helper.correctNull((String)rs.getString("MONSEC_SAMEADDRESS")).equalsIgnoreCase("1"))
				{
					strOldAudit.append("Yes");
				}
				else if(Helper.correctNull((String)rs.getString("MONSEC_SAMEADDRESS")).equalsIgnoreCase("2"))
				{
					strOldAudit.append("No");
				}
				else
				{
					strOldAudit.append("");
				}
			}
		}
		if(strAction.equalsIgnoreCase("insert"))
		{
			
			strQuery=SQLParser.getSqlQuery("selmaxsecurityreg^"+strAccountnumber);
			//strQuery="selmaxsecurityreg";
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strSno=Helper.correctNull((String)rs.getString("snorelmax"));
			}
			
			hshQueryValues = new HashMap();
			hshQuery=new HashMap();
			
			hshQuery.put("strQueryId","inssecurityreg");
			
			arrValues.add(strSno);
			arrValues.add(strAccountnumber);
			arrValues.add(strsecuritytype);
			arrValues.add(strsecuritynature);
			arrValues.add(strotherdetails);
			arrValues.add(stradd1);
			arrValues.add(stradd2);
			arrValues.add(strcity);
			arrValues.add(strstate);
			
			arrValues.add(strpincode);
			arrValues.add(strinsuranceno);
			arrValues.add(strvalueamout);
			arrValues.add(strvaluedate);
			arrValues.add(strvaluationdoneby);
			arrValues.add(strinspectedon);
			arrValues.add(strinspectedby);
			arrValues.add(straddresscheck);
			arrValues.add(strUserId);
			arrValues.add(monsec_shortfallnoticed);
			arrValues.add("N");
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}	
		else if(strAction.equalsIgnoreCase("update"))
		{
			 hshQueryValues = new HashMap();
			 hshQuery=new HashMap();
			 
			 hshQuery.put("strQueryId","updsecurityreg"); 
			 
			
				arrValues.add(strsecuritytype);
				arrValues.add(strsecuritynature);
				arrValues.add(strotherdetails);
				arrValues.add(stradd1);
				arrValues.add(stradd2);
				arrValues.add(strcity);
				arrValues.add(strstate);
				
				arrValues.add(strpincode);
				arrValues.add(strinsuranceno);
				arrValues.add(strvalueamout);
				arrValues.add(strvaluedate);
				arrValues.add(strvaluationdoneby);
				arrValues.add(strinspectedon);
				arrValues.add(strinspectedby);
				arrValues.add(straddresscheck);
			 
			 arrValues.add(strUserId);
			 arrValues.add(monsec_shortfallnoticed);
			 arrValues.add("N");
			 
			 arrValues.add(strSno);
			 arrValues.add(strAccountnumber);
			 
			 hshQuery.put("arrValues",arrValues);
			 hshQueryValues.put("1",hshQuery);
			 hshQueryValues.put("size","1");	
			 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
		else if(strAction.equalsIgnoreCase("Delete"))
		{
			arrValues = new ArrayList();
			hshQueryValues = new HashMap();
	  		hshQuery=new HashMap();
			hshQueryValues.put("size","1");
			
			
			hshQuery.put("strQueryId","delsecurityreg"); 
			arrValues.add(strSno);
			arrValues.add(strAccountnumber);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		else if(strAction.equalsIgnoreCase("Mask"))
		{
			arrValues = new ArrayList();
			hshQueryValues = new HashMap();
	  		hshQuery=new HashMap();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","mon_securityregister_updatemaskflag"); 
			arrValues.add("Y");
			arrValues.add(strSno);
			arrValues.add(strAccountnumber);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		///old audit trial
		StringBuilder strNewAudit=new StringBuilder();
		if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Insert"))
		{
			strNewAudit.append("~ Type of security = ");
			if(Helper.correctNull((String)hshValues.get("sel_securitytype")).equalsIgnoreCase("1"))
			{
				strNewAudit.append("Primary");
			}
			else if(Helper.correctNull((String)hshValues.get("sel_securitytype")).equalsIgnoreCase("2"))
			{
				strNewAudit.append("Collateral");
			}
			else
			{
				strNewAudit.append("");
			}
			strNewAudit.append("~ Nature of security = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("hid_securityNature")));
			strNewAudit.append("~ Address 1 = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_add1")));
			strNewAudit.append("~ Address 2 = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_add2")));
			strNewAudit.append("~ City = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_city")));
			strNewAudit.append("~ State = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_state")));
			strNewAudit.append("~ Pincode = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_pincode")));
			strNewAudit.append("~ Valuation Amount  = ");
			strNewAudit.append(ApplicationParams.getCurrency()+" "+Helper.correctNull((String)hshValues.get("txt_valueamout")));
			strNewAudit.append("~ Valued Date = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_valuedate")));
			strNewAudit.append("~ Valuation Done By = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_valuationdoneby")));
			strNewAudit.append("~ Last Inspected On = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_inspectedon")));
			strNewAudit.append("~ TLast Inspected By = ");
			strNewAudit.append(Helper.correctNull((String)hshValues.get("txt_inspectedby")));
			strNewAudit.append("~ Whether the address in the Insurance register is same = ");
			if(Helper.correctNull((String)hshValues.get("sel_addresscheck")).equalsIgnoreCase("1"))
			{
				strNewAudit.append("Yes");
			}
			else if(Helper.correctNull((String)hshValues.get("sel_addresscheck")).equalsIgnoreCase("2"))
			{
				strNewAudit.append("No");
			}
			else
			{
				strNewAudit.append("");
			}
		}
		else if(strAction.equalsIgnoreCase("Mask"))
		{
			strNewAudit.append("~The Record is masked");
		}
		AuditTrial.auditNewLog(hshValues, "311", strAccountnumber, strNewAudit.toString(), strOldAudit.toString());
	}
	catch(Exception e)
	{
		throw new EJBException("Error in updateDocumentRegister "+e.getMessage());
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
			throw new EJBException("Error closing in updateDocumentRegister the connection "+cf.getMessage());						
		}
	}
}

public HashMap getmonSecurityregister(HashMap hshValues) 
{
	HashMap hshRecord=new HashMap();
	String strQuery="";
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ResultSet rs = null;
	String cbsaccno="";
	try
	{
		cbsaccno=Helper.correctNull((String)hshValues.get("cbsaccno"));
		strQuery=SQLParser.getSqlQuery("selsecurityreg^"+cbsaccno);
		rs=DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
			arrCol = new ArrayList();
			arrCol.add(correctNull((String)rs.getString("MONSEC_SNO"))); //0
			arrCol.add(correctNull((String)rs.getString("MONSEC_ACCOUNTNUMBER"))); //1
			arrCol.add(correctNull((String)rs.getString("MONSEC_SECURITYTYPE"))); //2
			arrCol.add(correctNull((String)rs.getString("MONSEC_SECURITYNATURE")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_OTHERDETAILS")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_ADD1")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_ADD2")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_CITY")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_STATE")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_PINCODE")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_INSURANCENO")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_VALUATAMOUNT")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_VALUATDATE")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_VALUTDONEBY")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_INSPECTEDBY")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_INSPECTEDON")));
			arrCol.add(correctNull((String)rs.getString("MONSEC_SAMEADDRESS")));
			arrCol.add(correctNull((String)rs.getString("STAT_DATA_DESC1")));
			arrCol.add(correctNull((String)rs.getString("STAT_DATA_SNO")));
			arrCol.add(correctNull((String)rs.getString("monsec_shortfallnoticed")));
			arrCol.add(correctNull((String)rs.getString("monsec_maskflag")));
			arrRow.add(arrCol);
		}			
		hshRecord.put("arrRow",arrRow);
		
		hshRecord.put("cbsaccno",cbsaccno);
	}
	catch(Exception e1)
	{
		throw new EJBException("Error in getDocumentRegister :: "+e1.getMessage());
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
			e.printStackTrace();
		}
	}
	return hshRecord;
}





/*public HashMap updateMonthlyReport(HashMap hshValues) 
{
	HashMap hshQueryValues =new HashMap();
	HashMap hshQuery=new HashMap();
	String strQuery="";
	ResultSet rs=null;
	ArrayList arrValues= new ArrayList();
	HashMap hshResult=new HashMap();
	ArrayList vecCol = new ArrayList();
	ArrayList vecRow = new ArrayList();
	String stryear="",strmonth="",strcustid="";
	try
	{
		stryear=correctNull((String)hshValues.get("txt_year"));
		strmonth=correctNull((String)hshValues.get("selmonth"));
		strcustid=correctNull((String)hshValues.get("id"));
		strQuery=SQLParser.getSqlQuery("sel_monthlyrep^"+strcustid);
		rs=DBUtils.executeQuery(strQuery);
		if(rs!=null)
		{
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("monrep_year")));
				vecCol.add(correctNull((String)rs.getString("monrep_mon")));
				vecRow.add(vecCol);
			}
			hshResult.put("vecRow",vecRow);
		}
		else
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","ins_monthlyrep");
			arrValues.add(stryear);
			arrValues.add(strmonth);
			arrValues.add(strcustid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
			
			
			
		
		
	}
	catch(Exception ae)
	{
		throw new EJBException("Error in Insert Data " + ae.getMessage());
	}
}*/
	public HashMap getBorrowerInfo(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs = null;
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();
		String strcbsid="",strQuery="";
		try
		{
			
			strcbsid =correctNull((String)hshValues.get("cbsid"));
			String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
			String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
			if(!stryear.equalsIgnoreCase("")&&(strmonth.equalsIgnoreCase("S")))
			{
			strQuery=SQLParser.getSqlQuery("sel_monborrowerinfo^"+strcbsid);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("mon_commentsyear")));
				vecCol.add(correctNull((String)rs.getString("mon_commentsmonth")));
				vecRow.add(vecCol);
			}
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_monborrowerinfo1^"+strcbsid+"^"+stryear);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull((String)rs.getString("mon_commentsyear")));
					vecCol.add(correctNull((String)rs.getString("mon_commentsmonth")));
					vecRow.add(vecCol);
				}
				
			}
			
			hshResult.put("vecRow",vecRow);
				
		}
		catch (Exception exp)
		{
			throw new EJBException("Error in getBorrowerInfo"+ exp.getMessage());
		}
		finally
				{
					try
					{
						if(rs!=null)
							rs.close();
					}
					catch(Exception exp)
					{
						throw new EJBException("Error in closing the connection in getBorrowerInfo "+ exp.toString()); 
					}
				}
				
				return hshResult;
	}		
		public HashMap getBorrowerInform(HashMap hshValues) 
		{
			ResultSet rs=null;
			String strQuery;
			HashMap hshResult=new HashMap();
			
			String strCustid="";
			      
			strCustid="20154522";//Helper.correctNull((String)hshValues.get("CBSAPP_CUSTID"));		
			try
			{
				
				strQuery=SQLParser.getSqlQuery("sel_npaapplicant^"+strCustid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("CBSAPP_CUSTID",correctNull(rs.getString("CBSAPP_CUSTID")));
					hshResult.put("CBSAPP_TITLE",correctNull(rs.getString("CBSAPP_TITLE")));
					hshResult.put("CBSAPP_NAME",correctNull(rs.getString("CBSAPP_NAME")));
					hshResult.put("CBSAPP_BRANCH",correctNull(rs.getString("CBSAPP_BRANCH")));
					hshResult.put("CBSAPP_CONSTITUTION",correctNull(rs.getString("CBSAPP_CONSTITUTION")));
					hshResult.put("CBSAPP_BANKINGSINCE",correctNull(rs.getString("CBSAPP_BANKINGSINCE")));
					hshResult.put("CBSAPP_ADDRESS",correctNull(rs.getString("CBSAPP_ADDRESS")));
					hshResult.put("CBSAPP_SOLID",correctNull(rs.getString("CBSAPP_SOLID")));				
				}
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
			return hshResult;		
		}				

		 public void updateStockStatement(HashMap hshValues) 
		 {
			 	HashMap hshQueryValues=new HashMap();
				HashMap hshQuery=new HashMap();
				ArrayList arrValues= new ArrayList();
					
				ResultSet rs=null;
				ResultSet rs1=null;
				String strQuery ="";
				String strsno="";
				String strstatdesc="";
				String cbsid=Helper.correctNull((String)hshValues.get("cbsid"));
				String strUserId = Helper.correctNull((String)hshValues.get("strUserId"));
				String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
				String straccno=Helper.correctNull((String)hshValues.get("mon_accno"));
				String strstocktype=Helper.correctNull((String)hshValues.get("sel_stocktype"));
				String strmatdesc=Helper.correctNull((String)hshValues.get("txt_matdesc"));
				String strstorplace=Helper.correctNull((String)hshValues.get("txt_storplace"));
				String strpackageno=Helper.correctNull((String)hshValues.get("txt_packageno"));
				String strquantity=Helper.correctNull((String)hshValues.get("txt_quantity"));
				String strrate=Helper.correctNull((String)hshValues.get("txt_rate"));
				String strvalue=Helper.correctNull((String)hshValues.get("txt_value"));
				String hidsno=Helper.correctNull((String)hshValues.get("hidsno"));
				//String strmonth="01";
				//String stryear="2008";
				String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
				String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
				String Strmmrno=correctNull((String)hshValues.get("mmrno"));
				try
				{
					strQuery = SQLParser.getSqlQuery("sel_printstatement^"+"39"+"^"+straccno+"^"+Strmmrno+"^"+strstocktype);	
					rs1 = DBUtils.executeQuery(strQuery);
				
					while (rs1.next()) 
					{				
						
						strstatdesc=Helper.correctNull((String)rs1.getString("stat_data_desc1"));
								
					}	
					if (rs1 != null) 
					{
						rs1.close();					 
					}			
					if(strAction.equalsIgnoreCase("insert"))
					{	
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("sel_maxstockID^"+Strmmrno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							 strsno=Helper.correctNull((String)rs.getString("stock_sno"));
							 
						}
						hshQuery=new HashMap();
						hshQueryValues=new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","ins_stockstatement");
						
						arrValues.add(straccno);
						arrValues.add(cbsid);
						arrValues.add(strsno);
						arrValues.add(strstocktype);
						arrValues.add(strmatdesc);
						arrValues.add(strstorplace);
						arrValues.add(strpackageno);
						arrValues.add(strquantity);
						arrValues.add(strrate);
						arrValues.add(strvalue);
						arrValues.add(strmonth);
						arrValues.add(stryear);
						arrValues.add(strUserId);
						arrValues.add(Helper.getCurrentDateTime());
						arrValues.add(Strmmrno);
						
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
						hshQuery.put("strQueryId","upd_stockstatement");
						
						arrValues.add(strstocktype);
						arrValues.add(strmatdesc);
						arrValues.add(strstorplace);
						arrValues.add(strpackageno);
						arrValues.add(strquantity);
						arrValues.add(strrate);
						arrValues.add(strvalue);
						arrValues.add(hidsno);
						
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
						arrValues.add(hidsno);
						hshQuery.put("strQueryId","del_stockstatement");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
							
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						
						hshQuery=new HashMap();
						hshQueryValues=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(cbsid);
						arrValues.add(strmonth);
						arrValues.add(stryear);
						arrValues.add(straccno);
						arrValues.add(strstatdesc);
						hshQuery.put("strQueryId","del_insurancestock");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
							
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
					}
					// Audit Trial
					StringBuilder sbAt = new StringBuilder();
					if(!strAction.equals("delete"))
					{
						if(rs!=null)
						{
							rs.close();
						}
						if(!correctNull((String)hshValues.get("sel_stocktype")).equalsIgnoreCase(""))
						{
							strQuery=SQLParser.getSqlQuery("getstatdatavalue^"+"39"+"^"+correctNull((String)hshValues.get("sel_stocktype")));
					 		rs=DBUtils.executeQuery(strQuery);
					 		if(rs.next())
					 		{
					 			sbAt.append("Type =").append(correctNull((String)rs.getString("stat_data_desc1")));
					 		}
						}
						sbAt.append("~ Description of Materials  =").append(correctNull((String)hshValues.get("txt_matdesc")));
						sbAt.append("~ Place of Storage =").append(correctNull((String)hshValues.get("txt_storplace")));
						sbAt.append("~ No. of Package  =").append(correctNull((String)hshValues.get("txt_packageno")));
						sbAt.append("~ Quantity  =").append(correctNull((String)hshValues.get("txt_quantity")));
						sbAt.append("~ Rate  =").append(correctNull((String)hshValues.get("txt_rate")));
						sbAt.append("~ Value  =").append(correctNull((String)hshValues.get("txt_value")));
					}
					AuditTrial.auditLog(hshValues,"421",Strmmrno,sbAt.toString());
				}catch(Exception e)
				{
					throw new EJBException("Error in updateStock Statement"+e.getMessage());
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
						throw new EJBException("Error closing in the updateStock Statement connection "+cf.getMessage());
								
					}
					}
		 }
 public HashMap getStockStatement(HashMap hshValues)
 {
 	HashMap hshResult=new HashMap();
 	ResultSet rs = null;
 	ResultSet rs1=null;
 	ArrayList vecCol = new ArrayList();
 	ArrayList vecRow=new ArrayList();
 	String strQuery="";
 	String strstocktype="";

 	
 	String mon_msod=Helper.correctNull((String)hshValues.get("mon_msod"));
	String mon_stock=Helper.correctNull((String)hshValues.get("mon_stock"));
	String mon_bkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
	String mon_qpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
	String Strmmrno=correctNull((String)hshValues.get("mmrno"));
	
 	try
 	{
 		String straccno=Helper.correctNull((String)hshValues.get("mon_accno"));
 		//String stryear=Helper.correctNull((String)hshValues.get("mon_year"));
		//String strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
		//String strcbsid =Helper.correctNull((String)hshValues.get("cbsid"));
 		strQuery=SQLParser.getSqlQuery("sel_stockstatement^"+straccno+"^"+Strmmrno);
 		rs=DBUtils.executeQuery(strQuery);
 		
 		
 		
 		while(rs.next())
 			{
 				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("stock_sno")));
				vecCol.add(correctNull((String)rs.getString("stock_accno")));
				//vecCol.add(correctNull((String)rs.getString("stock_type")));
				
				strstocktype=Helper.correctNull((String)rs.getString("stock_type"));
				strQuery = SQLParser.getSqlQuery("sel_printstatement^"+"39"+"^"+straccno+"^"+Strmmrno+"^"+strstocktype);	
				rs1 = DBUtils.executeQuery(strQuery);
			
				if (rs1.next()) 
				{				
					
					vecCol.add(correctNull(rs1.getString("stat_data_desc1")));
							
				}else {
					
					vecCol.add("");
				}
				if (rs1 != null) 
				{
					rs1.close();					 
				}
				
				
							
				vecCol.add(correctNull((String)rs.getString("stock_desc")));
				vecCol.add(correctNull((String)rs.getString("stock_storplace")));
				vecCol.add(correctNull((String)rs.getString("stock_noofpackage")));
				vecCol.add(correctNull((String)rs.getString("stock_quantity")));
				vecCol.add(correctNull((String)rs.getString("stock_rate")));
				vecCol.add(correctNull((String)rs.getString("stock_value")));
				vecCol.add(correctNull((String)rs.getString("stock_type")));
				
				vecRow.add(vecCol);
				
			}		
 			
 			hshResult.put("vecRow",vecRow);
 			hshResult.put("mon_msod",mon_msod);
 			hshResult.put("mon_stock",mon_stock);
 			hshResult.put("mon_bkdebts",mon_bkdebts);
 			hshResult.put("mon_qpr",mon_qpr);
 		
 	
 	}catch (Exception exp){
 		throw new EJBException("Error in getStockStatement"+ exp.getMessage());
 	}finally
 	{
 		try
 		{
 			if(rs!=null)
 				rs.close();
 		}catch(Exception exp)
 		{
 			throw new EJBException("Error in closing the connection in getStockStatement "+ exp.toString()); 
 		}
 	}
 	
 	return hshResult;
 }

 
 

 public HashMap getInsuranceno(HashMap hshValues)
 {
	 HashMap hshResult=new HashMap();
 	ResultSet rs = null;
 	ArrayList vecCol = new ArrayList();
 	ArrayList vecRow=new ArrayList();
 	String strQuery="";
 	String index	=	null;
 	String size		=	null;
 	try
 	{
 		String straccno=Helper.correctNull((String)hshValues.get("cbsaccno"));
 		String flag=Helper.correctNull((String)hshValues.get("flag"));
 		String strInsuranceno=Helper.correctNull((String)hshValues.get("txt_insurance"));
 		if(!flag.equalsIgnoreCase("y"))
 		{
	 			strQuery=SQLParser.getSqlQuery("sel_insurancenostatement^"+strInsuranceno+"^"+straccno);
		 		rs=DBUtils.executeQuery(strQuery);
		 		while(rs.next())
		 			{
		 				vecCol = new ArrayList();
						//vecCol.add(correctNull((String)rs.getString("insur_sno")));
						vecCol.add(correctNull((String)rs.getString("ins_policyno")));
						
						vecRow.add(vecCol);
					}
	 	}
 		else
 		{
 			String appno=Helper.correctNull((String)hshValues.get("appno"));
 			String cbsid=Helper.correctNull((String)hshValues.get("cbsid"));
 			
 			strQuery=SQLParser.getSqlQuery("sel_insurancepolicyno^"+appno+"^"+cbsid);
	 		rs=DBUtils.executeQuery(strQuery);
	 		while(rs.next())
	 			{
	 				vecCol = new ArrayList();
					//vecCol.add(correctNull((String)rs.getString("insur_sno")));
					vecCol.add(correctNull((String)rs.getString("ins_policyno")));
					vecCol.add(correctNull((String)rs.getString("ins_coveramt")));
					vecCol.add(correctNull((String)rs.getString("ins_expirydate")));
					vecCol.add(correctNull((String)rs.getString("ins_clause")));
					vecRow.add(vecCol);
				}
 		}
 			hshResult.put("vecRow",vecRow);
 			index =Helper.correctNull((String)hshValues.get("index"));
 			size =Helper.correctNull((String)hshValues.get("size"));
 			hshResult.put("index",index);
 			hshResult.put("size",size);
 	
 	}catch (Exception exp){
 		throw new EJBException("Error in getStockStatement"+ exp.getMessage());
 	}finally
 	{
 		try
 		{
 			if(rs!=null)
 				rs.close();
 		}catch(Exception exp)
 		{
 			throw new EJBException("Error in closing the connection in getStockStatement "+ exp.toString()); 
 		}
 	}
 	
 	return hshResult;
 }
 
 public void updateSecuInsuranceMapping(HashMap hshValues) 
	{
	 	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		ResultSet rs=null;
		String strAction=(String)hshValues.get("hidAction");
		String ins_seqid=Helper.correctNull((String)hshValues.get("hidSeqid"));
		String cbsaccount=Helper.correctNull((String)hshValues.get("cbsaccountno"));
		if(cbsaccount.equalsIgnoreCase(""))
		{
			cbsaccount=Helper.correctNull((String)hshValues.get("hidcbsid"));
		}
		if(cbsaccount.equalsIgnoreCase(""))
		{
			cbsaccount=Helper.correctNull((String)hshValues.get("cbsaccno"));
		}
		String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
		if(strcbsid.equalsIgnoreCase(""))
		{
			strcbsid = Helper.correctNull((String)hshValues.get("hidcbsid"));
		}
		String strInsuranceSlrno = "";
		double dblInsuranceamt=0.0;
		String strmindate="";
		strInsuranceSlrno=correctNull((String)hshValues.get("hidinsurance"));
		String strInsurance=correctNull((String)hshValues.get("hidinsuranceno"));
		String strRecordFlag = Helper.correctNull((String)hshValues.get("hidAuditFlag"));
		StringBuilder sbolddata = new StringBuilder();
		
		if(!strInsuranceSlrno.equals(""))
		{
			strInsuranceSlrno = strInsuranceSlrno.substring(0,strInsuranceSlrno.length()-1);
			strInsurance = strInsurance.substring(0,strInsurance.length()-1);
			 String [] strtempfull= strInsurance.split("@");
			 String [] stremp = strInsuranceSlrno.split("@");
			 String [] strempdate=new String[stremp.length];
			 
			 for(int i=0;i<stremp.length;i++)
			 {
				 for(int j=0;i<strtempfull.length;j++)
				 {
					 String strval =  (String)strtempfull[j];
					 String [] stremp1 = strval.split("~");
					 if(stremp[i].equals(stremp1[0]))
					 {
						 dblInsuranceamt=dblInsuranceamt + Double.parseDouble(stremp1[2]);
						 strempdate[i]=stremp1[1];
						 break;
					 }
				 }
			 }
			 Calendar  c1 = Calendar.getInstance();
			 Calendar  temp = Calendar.getInstance();
			 temp.set(Integer.parseInt(strempdate[0].substring(6,10)),Integer.parseInt(strempdate[0].substring(3,5))-1,Integer.parseInt(strempdate[0].substring(0,2)));
			 long  diff_intime=0;
			 strmindate=strempdate[0];
			 for(int i=0;i<strempdate.length;i++)
			 {
				 c1.set(Integer.parseInt(strempdate[i].substring(6,10)),Integer.parseInt(strempdate[i].substring(3,5))-1,Integer.parseInt(strempdate[i].substring(0,2)));
				 long mill1=c1.getTimeInMillis();
				 long mill2=temp.getTimeInMillis();
				 
				 diff_intime = mill1 - mill2;
				 diff_intime = diff_intime/(24*60*60*1000);
				 if(diff_intime <= 0)
				 {
					 temp.set(Integer.parseInt(strempdate[i].substring(6,10)),Integer.parseInt(strempdate[i].substring(3,5))-1,Integer.parseInt(strempdate[i].substring(0,2)));
					 strmindate=strempdate[i];
				 }
				
					 
			 }
			
			 
			 
			
		}
		String strmmrno =correctNull((String)hshValues.get("mmrno"));
		String straccount =correctNull((String)hshValues.get("sel_account"));
		String strsec=correctNull((String)hshValues.get("sel_securitynature"));
		
		
		try
		{
			if(strRecordFlag.equalsIgnoreCase("Y") || strAction.equalsIgnoreCase("delete"))
			{
					sbolddata.append("Account Number =").append(correctNull((String)hshValues.get("sel_account")));
					rs = DBUtils.executeLAPSQuery("sel_monsecurity_sno_select^"+straccount+"^"+strsec.split("~")[0]);
					if(rs.next())
					{
						sbolddata.append("~ Type of security =").append(correctNull((String)rs.getString("SECURITYTYPE"))).append("-")
						.append(correctNull((String)rs.getString("STAT_DATA_DESC1"))).append("-").append(correctNull((String)rs.getString("MONSEC_VALUATAMOUNT")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					sbolddata.append("~ Insurance =");
					rs = DBUtils.executeLAPSQuery("get_insurance_register_map_select1^"+straccount+"^"+cbsaccount);
					int i=0;
					while(rs.next())
					{
						if(i==0)
						{
							sbolddata.append(correctNull((String)rs.getString("ins_company")).trim()).append("-")
							.append(correctNull((String)rs.getString("ins_policyno"))).append("-").append(correctNull((String)rs.getString("ins_coveramt")));
						}
						else
						{
							sbolddata.append(",");
							sbolddata.append(correctNull((String)rs.getString("ins_company"))).append("-")
							.append(correctNull((String)rs.getString("ins_policyno"))).append("-").append(correctNull((String)rs.getString("ins_coveramt")));
						}
						i++;
					}
				if(rs!=null)
				rs.close();
			}
				if(strAction.equalsIgnoreCase("insert"))
				{
					 arrValues.add(strmmrno);
					 arrValues.add(cbsaccount);
					 arrValues.add(straccount);
					 arrValues.add(strsec.split("~")[0]);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_secuinsumap"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					/*
					 * mon_secuslrno ,mon_secuinsumapaccno
    	,mon_secuinsumapcbsid , mon_insuslrno ,mon_insuamt
					 * 
					 */
					
						
						 hshQueryValues=new HashMap();
						 hshQuery=new HashMap();
						 arrValues=new ArrayList();
						 arrValues.add(strsec.split("~")[0]);
						 arrValues.add(strsec.split("~")[1]);
						 arrValues.add(straccount);
						 arrValues.add(cbsaccount);
						 arrValues.add(strInsuranceSlrno);
						 arrValues.add(jtn.format(dblInsuranceamt));
						 arrValues.add(strmindate);
						 arrValues.add(strmmrno);
						 arrValues.add(correctNull((String)hshValues.get("mmr_month")));
						 arrValues.add(correctNull((String)hshValues.get("strYear")));
						 hshQuery.put("arrValues",arrValues); 
						 hshQuery.put("strQueryId","ins_secuinsumap"); 
						 hshQueryValues.put("1",hshQuery);
						 hshQueryValues.put("size","1");	
						 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				}
				if(strAction.equalsIgnoreCase("Delete"))
				{
					 arrValues.add(strmmrno);
					 arrValues.add(cbsaccount);
					 arrValues.add(straccount);
					 arrValues.add(strsec.split("~")[0]);
					 hshQuery.put("arrValues",arrValues); 
					 hshQuery.put("strQueryId","del_secuinsumap"); 
					 hshQueryValues.put("1",hshQuery);
					 hshQueryValues.put("size","1");	
					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				if(rs!=null)
				{
					rs.close();
				}
				
				// Audit Trial
				StringBuilder sbAt = new StringBuilder();
				if(!strAction.equalsIgnoreCase("delete"))
				{
					sbAt.append("Account Number =").append(correctNull((String)hshValues.get("sel_account")));
					rs = DBUtils.executeLAPSQuery("sel_monsecurity_sno_select^"+straccount+"^"+strsec.split("~")[0]);
					if(rs.next())
					{
						sbAt.append("~ Type of security =").append(correctNull((String)rs.getString("SECURITYTYPE"))).append("-")
						.append(correctNull((String)rs.getString("STAT_DATA_DESC1"))).append("-").append(correctNull((String)rs.getString("MONSEC_VALUATAMOUNT")));
					}
					if(rs!=null)
					{
						rs.close();
					}
					sbAt.append("~ Insurance =");
					 String [] stremp1 = strInsuranceSlrno.split("@");
					 for(int j=0;j<stremp1.length;j++)
					 {
						rs = DBUtils.executeLAPSQuery("get_insurance_register_map_select^"+straccount+"^"+cbsaccount+"^"+stremp1[j]);
						int i=0;
						while(rs.next())
						{
							if(i==0)
							{
								sbAt.append(correctNull((String)rs.getString("ins_company")).trim()).append("-")
								.append(correctNull((String)rs.getString("ins_policyno"))).append("-").append(correctNull((String)rs.getString("ins_coveramt")));
							}
							else
							{
								sbAt.append(",");
								sbAt.append(correctNull((String)rs.getString("ins_company"))).append("-")
								.append(correctNull((String)rs.getString("ins_policyno"))).append("-").append(correctNull((String)rs.getString("ins_coveramt")));
							}
							i++;
						}
					}
					
					if(strRecordFlag.equalsIgnoreCase("Y")){
						hshValues.put("hidAction", "update");
					}else if(strRecordFlag.equalsIgnoreCase("N")){
						hshValues.put("hidAction", "insert");
					}
				}
				AuditTrial.auditNewLog(hshValues,"430",strmmrno,sbAt.toString(),sbolddata.toString());
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
				throw new EJBException("Error closing in updateSecuInsuranceMapping the connection "+cf.getMessage());
						
			}
		}
	}
	
	public HashMap getSecuInsuranceMapping(HashMap hshValues) 
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery;
		HashMap hshRecord=new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		String strAccno = correctNull((String)hshValues.get("cbsaccno"));
		if(strAccno.equalsIgnoreCase(""))
		{
			strAccno = correctNull((String)hshValues.get("cbsappno"));
		}
		if(strAccno.equalsIgnoreCase(""))
		{
			strAccno = correctNull((String)hshValues.get("cbsid"));
		}
		
		String strcbsid = correctNull((String)hshValues.get("strcbsid"));
					
		String straccno = correctNull((String)hshValues.get("sel_account"));
		if(straccno.equals(""))
		{
			straccno= correctNull((String)hshValues.get("acc_no"));
		}
		String strsecuritynature="";
		String strInsurance="";
		String strsecurity="";
		
		boolean recordflag=false;
		
		try
		{
			
			strsecuritynature= correctNull((String)hshValues.get("sel_securitynature"));
			if(strsecuritynature.equals(""))
				strsecuritynature= correctNull((String)hshValues.get("securitynature")); 
			String strmmrno = correctNull((String)hshValues.get("mmrno"));
			if(strmmrno.equals(""))
			{
				strmmrno= correctNull((String)hshValues.get("mmr_no"));
			}
			
			if((!strAccno.equals("")&& !strsecuritynature.equals("")))
			{	strsecurity = strsecuritynature.substring(0,1);
				strQuery=SQLParser.getSqlQuery("sel_secuinsumap^"+straccno+"^"+strAccno+"^"+strsecurity+"^"+strmmrno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					recordflag=true;
					arrCol = new ArrayList();
					//vecCol.add(correctNull((String)rs.getString("mon_secuslrno")));
					//vecCol.add(correctNull((String)rs.getString("mon_secuinsumapaccno")));
					//vecCol.add(correctNull((String)rs.getString("mon_secuinsumapcbsid")));
					
					strInsurance= correctNull((String)rs.getString("mon_insuslrno"))+"@";
					strsecurity = strsecurity+"-"+correctNull((String)rs.getString("MON_SECUAMT"));
					arrCol.add(correctNull((String)rs.getString("mon_insuamt")));
					
					arrRow.add(arrCol);
				}
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("Accno",strAccno);
			hshRecord.put("Cbsid",strcbsid);
			hshRecord.put("Insurance",strInsurance);
			hshRecord.put("securitynature",strsecuritynature);
			hshRecord.put("straccno",straccno);
			
			if(recordflag)
				hshRecord.put("recordflag","Y");
			else
				hshRecord.put("recordflag","N");
			
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
				if(rs1 != null)
				{
					rs1.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing in the getSecuInsuranceMapping connection "+cf.getMessage());
						
			}
		}
		return hshRecord;
	}
 
	
	
	public HashMap getSecurityInsuranceDetail(HashMap hshValues)
	{
		ResultSet rs=null;
		HashMap hshRecord=new HashMap();
		ArrayList arrSec = new ArrayList();
		ArrayList arrSecCol = new ArrayList();
		ArrayList arrInsu = new ArrayList();
		ArrayList arrInsuCol = new ArrayList();
		
		try
		{
			String stracc_no = correctNull((String) hshValues.get("acc_no"));
			String strcbsid = correctNull((String) hshValues.get("cbsid"));
			String strsecurity = correctNull((String) hshValues.get("securitynature"));
			String strinsurance = correctNull((String) hshValues.get("insurance"));
			
			rs = DBUtils.executeLAPSQuery("sel_monsecurity^"+stracc_no);
			
			hshRecord = new HashMap();
			while(rs.next())
			{
				arrSecCol = new ArrayList();
				arrSecCol.add(correctNull(rs.getString("SECURITYTYPE")));//0
				arrSecCol.add(correctNull(rs.getString("STAT_DATA_DESC1")));//1
				arrSecCol.add(correctNull(rs.getString("MONSEC_VALUATAMOUNT")));//2
				arrSecCol.add(correctNull(rs.getString("MONSEC_SNO")));//3
				arrSec.add(arrSecCol);	
			}
			if(rs !=null)
				rs.close();
			hshRecord.put("arrSec",arrSec);	
			
			rs = DBUtils.executeLAPSQuery("get_insurance_register^"+stracc_no+"^"+strcbsid);
			while(rs.next())
			{
				arrInsuCol = new ArrayList();
				arrInsuCol.add(correctNull(rs.getString("ins_srlno")));//0
				arrInsuCol.add(correctNull(rs.getString("ins_policyno")));//1
				arrInsuCol.add(correctNull(rs.getString("ins_coveramt")));//2
				arrInsuCol.add(correctNull(rs.getString("ins_company")));//3
				arrInsuCol.add(correctNull(rs.getString("ins_expirydate")));//4
				arrInsu.add(arrInsuCol);	
			}
			if(rs !=null)
				rs.close();
			hshRecord.put("arrInsu",arrInsu);	
			hshRecord.put("strsecurity",strsecurity);	
			hshRecord.put("Insurance",strinsurance);	
			
			
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
				throw new EJBException("Error closing in the getSecurityInsuranceDetail connection "+cf.getMessage());
						
			}
		}
		
		
		return hshRecord;
	}
}


//public HashMap getDisposal(HashMap hshValues) 
//{
//	HashMap hshRecord=new HashMap();
//	ArrayList vecCol = new ArrayList();
//	ArrayList vecRow = new ArrayList();
//	ResultSet rs = null;
//	try
//	{
//
//		rs=DBUtils.executeLAPSQuery("seldisposedetails");
//
//
//		while(rs.next())
//		{
//			vecCol = new ArrayList();
//			vecCol.add(correctNull((String)rs.getString("register_id")));
//			vecCol.add(correctNull((String)rs.getString("customer_type")));
//			vecCol.add(correctNull((String)rs.getString("receipt_date")));
//			vecCol.add(correctNull((String)rs.getString("disposal_purpose")));
//			vecCol.add(correctNull((String)rs.getString("application_scheme")));
//			vecCol.add(correctNull((String)rs.getString("loan_amount")));
//			vecCol.add(correctNull((String)rs.getString("sanction_date")));
//			vecCol.add(correctNull((String)rs.getString("return_date")));
//			vecCol.add(correctNull((String)rs.getString("rejection_date")));
//			vecCol.add(correctNull((String)rs.getString("remarks")));
//			vecCol.add(correctNull((String)rs.getString("customer_name")));
//			vecCol.add(correctNull((String)rs.getString("customer_id")));
//			vecRow.add(vecCol);
//		}			
//		hshRecord.put("vecRow",vecRow);
//		//hshRecord.put("comapp_id",comapp_id);
//		
//	}
//	catch(Exception e1)
//	{
//		throw new EJBException(e1.getMessage());
//	}
//	finally
//	{
//		try
//		{
//			if(rs != null)
//			{
//				rs.close();
//			} 
//		}
//		catch(Exception cf)
//		{
//			throw new EJBException("Error closing getDisposal the connection "+cf.getMessage());						
//		}
//	}
//	
//	return hshRecord;
//}

//public HashMap getDisposalByRegisterId(HashMap hshValues) 
//{
//	HashMap hshRecord=new HashMap();
//	String register_id="";
//	ArrayList vecCol = new ArrayList();
//	ArrayList vecRow = new ArrayList();
//	ResultSet rs = null;
//	try
//	{
//		register_id=Helper.correctNull((String)hshValues.get("register_id"));
//		rs=DBUtils.executeLAPSQuery("seldisposedetails1^"+register_id);
//		while(rs.next())
//		{
//			vecCol = new ArrayList();
//			vecCol.add(correctNull((String)rs.getString("strsno")));
//			vecCol.add(correctNull((String)rs.getString("customer_type")));
//			vecCol.add(correctNull((String)rs.getString("receipt_date")));
//			vecCol.add(correctNull((String)rs.getString("disposal_purpose")));
//			vecCol.add(correctNull((String)rs.getString("application_scheme")));
//			vecCol.add(correctNull((String)rs.getString("loan_amount")));
//			vecCol.add(correctNull((String)rs.getString("sanction_date")));
//			vecCol.add(correctNull((String)rs.getString("return_date")));
//			vecCol.add(correctNull((String)rs.getString("rejection_date")));
//			vecCol.add(correctNull((String)rs.getString("remarks")));
//			vecCol.add(correctNull((String)rs.getString("customer_name")));
//			vecRow.add(vecCol);
//		}			
//		hshRecord.put("vecRow",vecRow);
//		//hshRecord.put("comapp_id",comapp_id);
//		
//	}
//	catch(Exception e1)
//	{
//		throw new EJBException(e1.getMessage());
//	}
//	finally
//	{
//		try
//		{
//			if(rs != null)
//			{
//				rs.close();
//			} 
//		}
//		catch(Exception cf)
//		{
//			throw new EJBException("Error closing in getDisposalByRegisterId the connection "+cf.getMessage());						
//		}
//	}
//	
//	return hshRecord;
//}

//public void updateDisposal(HashMap hshValues)
//{
//	ResultSet rs = null;
//	String strQuery=null;
//	HashMap hshQueryValues=new HashMap();
//	ArrayList arrValues = new ArrayList();
//	
//	String strsno ="";
//	String strcomappid="";
//	
//	HashMap hshQuery = new HashMap();
//	try
//	{
//		String strAction =Helper.correctNull((String)hshValues.get("hidAction"));
//		strsno=Helper.correctNull((String)hshValues.get("hidsno"));
//		String strtype=Helper.correctNull((String)hshValues.get("sel_type"));
//		strcomappid=Helper.correctNull((String)hshValues.get("hidCustomerId"));
//		 if(strcomappid.equalsIgnoreCase(""))
//		 {
//			 strcomappid=Helper.correctNull((String)hshValues.get("customer_id"));
//		 }
//		String strreceipt=Helper.correctNull((String)hshValues.get("txt_receiptdate"));
//		String strpurpose=Helper.correctNull((String)hshValues.get("txt_purpose"));
//		String strscheme=Helper.correctNull((String)hshValues.get("txt_scheme"));
//		
//		String strloan=Helper.correctNull((String)hshValues.get("txt_loan"));
//		String strsanction=Helper.correctNull((String)hshValues.get("txt_sanction"));
//		String strreturn=Helper.correctNull((String)hshValues.get("txt_return"));
//		String strrejection=Helper.correctNull((String)hshValues.get("txt_rejection"));
//		String strremarks=Helper.correctNull((String)hshValues.get("txt_remarks"));
//		String strname=Helper.correctNull((String)hshValues.get("txt_name"));
//				
//		if(strAction.equalsIgnoreCase("insert"))
//		{
//			strQuery="selmaxapplication";
//			rs=DBUtils.executeLAPSQuery(strQuery);
//			if(rs.next())
//			{
//				strsno=Helper.correctNull((String)rs.getString("registerid"));
//			}
//			 hshQueryValues = new HashMap();
//			 								 
//			 hshQuery=new HashMap();
//			 hshQuery.put("strQueryId","insdisposaldetails"); 
//		
//			 arrValues.add(strsno);
//			 arrValues.add(strcomappid);
//			 arrValues.add(strtype);
//			 arrValues.add(strreceipt);
//			 arrValues.add(strpurpose);
//			 arrValues.add(strscheme);
//			 arrValues.add(strloan);
//			 arrValues.add(strsanction);
//			 arrValues.add(strreturn);
//			 arrValues.add(strrejection);
//			 arrValues.add(strremarks);
//			 arrValues.add(strname);
//			 hshQuery.put("arrValues",arrValues);
//			 hshQueryValues.put("1",hshQuery);
//			 hshQueryValues.put("size","1");	
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			
//		}
//		else if(strAction.equalsIgnoreCase("update"))
//		{
//			 hshQueryValues = new HashMap();
//			 hshQuery=new HashMap();
//			 hshQuery.put("strQueryId","upddisposaldetails"); 
//			 arrValues.add(strsno);
//			 arrValues.add(strcomappid);
//			 arrValues.add(strtype);
//			 arrValues.add(strreceipt);
//			 arrValues.add(strpurpose);
//			 arrValues.add(strscheme);
//			 arrValues.add(strloan);
//			 arrValues.add(strsanction);
//			 arrValues.add(strreturn);
//			 arrValues.add(strrejection);
//			 arrValues.add(strremarks);
//			 arrValues.add(strname);
//			 arrValues.add(strsno);
//			 
//			 
//			 hshQuery.put("arrValues",arrValues);
//			 hshQueryValues.put("1",hshQuery);
//			 hshQueryValues.put("size","1");	
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			
//		}
//		else if(strAction.equalsIgnoreCase("Delete"))
//		{
//			arrValues = new ArrayList();
//			hshQueryValues = new HashMap();
//	  		hshQuery=new HashMap();
//			hshQueryValues.put("size","1");
//			hshQuery.put("strQueryId","deldisposal"); 
//			arrValues.add(strsno);
//			hshQuery.put("arrValues",arrValues);
//			hshQueryValues.put("1",hshQuery);	
//			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//		}
//	}
//	catch(Exception e)
//	{
//		throw new EJBException("Error in updatereldetails "+e.getMessage());
//	}
//	
//	finally
//	{
//		try
//		{
//			if(rs != null)
//			{
//				rs.close();
//			} 
//		}
//		catch(Exception cf)
//		{
//			throw new EJBException("Error closing in updateDisposal the connection "+cf.getMessage());						
//		}
//	}
//}

