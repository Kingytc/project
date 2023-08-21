package com.sai.laps.ejb.refdetails;

 
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "refdetailsBean", mappedName = "refdetailsHome")
@Remote (refdetailsRemote.class)

public class refdetailsBean extends BeanAdapter
{	
	static Logger log=Logger.getLogger(refdetailsBean.class);
	private static final long serialVersionUID = 1L;


	public void updrefData(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		ResultSet rs=null;
		String strAction=null;	
		String strsno="";
		String strid1 = null;
		String strName="";			
		String strDesg="";
		String strPhn="";			
		String strDet="";
		String strActionData="";
		String strQuery = "";
		
		try
		{ 
			strAction =correctNull((String)hshValues.get("hidAction"));
			strsno=correctNull((String)hshValues.get("hid_sno"));			
			strid1=correctNull((String)hshValues.get("hid_comappid"));
			strName = correctNull((String)hshValues.get("txt_name"));		
			strDesg = correctNull((String)hshValues.get("txt_design"));			
			strPhn = correctNull((String)hshValues.get("txt_phone"));
			strDet = correctNull((String)hshValues.get("txt_comments"));
			
			StringBuilder strOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("Delete"))
			{
				strQuery = SQLParser.getSqlQuery("sel_ref_test1^"+strid1+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
				strOldAudit.append("~ Contact person name = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("ref_name")));
				strOldAudit.append("~ Relationship with the applicant = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("ref_design")));
				strOldAudit.append("~ Phone Number = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("ref_phoneno")));
				}
			}
			if(strAction.equals("insert"))
			{	
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Ins_ref_test");
				arrValues=new ArrayList();
				rs=DBUtils.executeLAPSQuery("Sel_MaxId_ref_test^"+strid1);
				 
				if(rs.next())
				{
					strsno = correctNull((String)rs.getString("maxid"));
				}
				 
				arrValues.add(strsno);				
				arrValues.add(strid1);
				arrValues.add(strName);
				arrValues.add(strDesg);
				arrValues.add(strPhn);
				arrValues.add(strDet);				 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Upd_ref_test");
				arrValues=new ArrayList();
				arrValues.add(strName);
				arrValues.add(strDesg);
				arrValues.add(strPhn);
				arrValues.add(strDet);
				arrValues.add(strid1);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","Del_ref_test");
				arrValues=new ArrayList();
				arrValues.add(strid1);
				arrValues.add(strsno);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			StringBuilder strNewAudit=new StringBuilder();
			if(strAction.equalsIgnoreCase("Update")||strAction.equalsIgnoreCase("insert"))
			{
				strNewAudit.append("~ Contact person name = ");
				strNewAudit.append(strName);
				strNewAudit.append("~ Relationship with the applicant = ");
				strNewAudit.append(strDesg);
				strNewAudit.append("~ Phone Number = ");
				strNewAudit.append(strPhn);
			}
			
			AuditTrial.auditNewLog(hshValues, "80", strid1, strNewAudit.toString(), strOldAudit.toString());
		}
		catch(Exception e)
		{
			log.error("Error in delete applicant Informations.. "+e);
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	
	public HashMap getrefData(HashMap hshRequestValues) 
	{ 
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecRow =new ArrayList();
		ArrayList vecData =new ArrayList();
		String strappid="",strid ="";
		String strAction = null;
		try
		{ 
			strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			strappid=correctNull((String)hshRequestValues.get("hid_comappid"));
			if(strappid.equalsIgnoreCase(""))
			{
				strappid = Helper.correctNull((String)hshRequestValues.get("hid_comappid2"));
			}
			if(strappid.equalsIgnoreCase(""))
			{
				strappid = Helper.correctNull((String)hshRequestValues.get("hid_comappid1"));
			}
			strid=correctNull((String)hshRequestValues.get("hid_sno"));
			String strAppname=Helper.correctNull((String)hshRequestValues.get("hidapp_name"));
			if(strAction.trim().equals("insert"))
			{
				 rs=DBUtils.executeLAPSQuery("Sel_CurrMaxId_ref_test^"+strappid);				
				 
				while(rs.next())
				{	
					strid = rs.getString("maxid");
					strAction="update";
				}
			}	
			else if(strAction.trim().equals("update"))
			{
				//strappid=correctNull((String)hshRequestValues.get("hid_comappid1"));
				strid=correctNull((String)hshRequestValues.get("hid_sno"));
			}
			if((strid.trim().equals("")))
			{
				strid="0";
			}
			if(strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("delete"))
			{
				strQuery = SQLParser.getSqlQuery("sel_ref_test1^"+strappid+"^"+strid);	
				 rs=DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					hshRecord.put("ref_id",correctNull((String)rs.getString("ref_id")));
					hshRecord.put("strid",correctNull((String)rs.getString("perapp_id")));
					hshRecord.put("strName",correctNull((String)rs.getString("ref_name")));
				    hshRecord.put("strDesg",correctNull((String)rs.getString("ref_design")));
				    hshRecord.put("strPhn",correctNull((String)rs.getString("ref_phoneno")));
				    hshRecord.put("strDet",correctNull((String)rs.getString("ref_oth_details")));				   
				}
			}
			
			 rs=DBUtils.executeLAPSQuery("sel_ref_test^"+strappid);				
			 		
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(rs.getString(1));
				vecRow.add(rs.getString(2));
				vecRow.add(rs.getString(3));
				vecRow.add(rs.getString(4));
				vecRow.add(rs.getString(5));
				vecRow.add(rs.getString(6));
				vecData.add(vecRow);
			}
			hshRecord.put("vecData",vecData);	
			hshRecord.put("id1",strappid);	
			hshRecord.put("strAppname", strAppname);
		}
		catch(Exception ce)
		{
			log.error(ce.toString());
			throw new EJBException("Error in getrefList "+ce.toString());
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
	
	public void updatenriData(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues ;
		 
		ResultSet rs=null;
		String strAction=null;	
		String strappno="";
		String strvisavalidupto="";			
		String strvisaparticulars="";
		String stroverseasaddress="";
		String strempcontract="";
		String strcontractvaliddate="";
		String strbalanceperiod="";		
		String strnatureemploy="";
		String strprovrenewal="";
		String strrenewal="";
		String strtermsofcontract="";
		String strworkpermit="";
		String strworkpermitno="";		
		String strdtissue="";
		String strissuingauthority="";
		String strvalidupto="";
		String strtermsofpermit="";
		String strActionData="";
		String strActionFlag="N";
		String strPassportNo="";
		String strPassportIssuedby="";
		String strPassportIssueDt="";
		String strPassportExpiryDt="";
		String sbOldAudit = "";
		try
		{ 
			strAction =correctNull((String)hshValues.get("hidAction"));	
			strappno=correctNull((String)hshValues.get("hid_comappid1"));
			if(strappno.equalsIgnoreCase(""))
			{
				strappno=correctNull((String)hshValues.get("hid_appnriid"));
			}
			strvisavalidupto = correctNull((String)hshValues.get("txt_visavaliddate"));		
			strvisaparticulars = correctNull((String)hshValues.get("txt_visaparticulars"));			
			stroverseasaddress=correctNull((String)hshValues.get("txt_overseasaddress"));
			strempcontract=correctNull((String)hshValues.get("txt_empcontract"));
			strcontractvaliddate=correctNull((String)hshValues.get("txt_contractvaliddate"));
			strbalanceperiod=correctNull((String)hshValues.get("txt_balanceperiod"));	
			strnatureemploy=correctNull((String)hshValues.get("txt_natureemploy"));
			strprovrenewal=correctNull((String)hshValues.get("sel_provrenewal"));
			strrenewal=correctNull((String)hshValues.get("txt_renewal"));
			strtermsofcontract=correctNull((String)hshValues.get("txt_termsofcontract"));
			strworkpermit=correctNull((String)hshValues.get("sel_workpermit"));
			strworkpermitno=correctNull((String)hshValues.get("txt_workpermitno"));	
			strdtissue=correctNull((String)hshValues.get("txt_dtissue"));
			strissuingauthority=correctNull((String)hshValues.get("txt_issuingauthority"));
			strvalidupto=correctNull((String)hshValues.get("txt_validupto"));
			strtermsofpermit=correctNull((String)hshValues.get("txt_termsofpermit"));
			strPassportNo=correctNull((String)hshValues.get("txt_passportno"));
			strPassportIssuedby=correctNull((String)hshValues.get("txt_passportissuby"));
			strPassportIssueDt=correctNull((String)hshValues.get("txt_dateofissue"));
			strPassportExpiryDt=correctNull((String)hshValues.get("txt_dateofexpiry"));
/** by gokul - for the purpose of audit trial*/
			rs = DBUtils.executeLAPSQuery("sel_nridetails^"+strappno);
			if(rs.next())
			{
				strActionFlag = "Y";
				
				/***
				 * For Audit Trial Old Data - By Karthikeyan.S on 12/09/2013
				 */
				
				sbOldAudit="Visa Valid upto="+Helper.correctNull((String)rs.getString("appnri_visaupto"))+
							"~Passport Number="+Helper.correctNull((String)rs.getString("appnri_passport_no"))+
							"~Passport Issued By="+Helper.correctNull((String)rs.getString("appnri_passport_issuedby"))+
							"~Date of Issue(Date)="+Helper.correctNull((String)rs.getString("perapp_passissuedt"))+
							"~Date of Expiry(Date)="+Helper.correctNull((String)rs.getString("perapp_passexpiry"))+
							"~Employment Contract="+Helper.correctNull((String)rs.getString("appnri_emp_cont"))+
							"~Contract Valid upto="+Helper.correctNull((String)rs.getString("appnri_contractdt"))+
							"~Balance Period in Contract="+Helper.correctNull((String)rs.getString("appnri_balaprd_cont"))+
							"~Provision for Renewal="+Helper.correctNull((String)rs.getString("appnri_prov_renew"))+
							"~Work Permit/Labour Card="+Helper.correctNull((String)rs.getString("appnri_wl_flg"))+
							"~Work Permit No/Labour Card No="+Helper.correctNull((String)rs.getString("appnri_wl_no"))+
							"~Date of Issue="+Helper.correctNull((String)rs.getString("appnri_issuedt"))+
							"~Issuing Authority="+Helper.correctNull((String)rs.getString("appnri_issauth"))+
							"~Valid upto="+Helper.correctNull((String)rs.getString("appnri_vaildupto"));
				
				/***
				 * End - Audit Trial Old Data
				 */
			}
			if(rs!=null)
				rs.close();
/** end */			
			int intUpdatesize=0;
			if(strAction.equals("Edit"))
			{
				arrValues = new ArrayList();
				intUpdatesize=1;
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQuery.put("strQueryId","del_nridetails");
				arrValues.add(strappno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);			
				intUpdatesize = intUpdatesize + 1;
				arrValues = new ArrayList();
				hshQuery = new HashMap();				
				hshQuery.put("strQueryId","ins_nridetails");
				arrValues.add(strappno);
				arrValues.add(strvisavalidupto);
				arrValues.add(strvisaparticulars);
				arrValues.add(stroverseasaddress);				
				arrValues.add(strempcontract);
				arrValues.add(strtermsofcontract);
				arrValues.add(strcontractvaliddate);
				arrValues.add(strbalanceperiod);
				arrValues.add(strnatureemploy);
				arrValues.add(strprovrenewal);
				arrValues.add(strrenewal);
				arrValues.add(strworkpermit);
				arrValues.add(strworkpermitno);				
				arrValues.add(strdtissue);
				arrValues.add(strissuingauthority);
				arrValues.add(strvalidupto);
				arrValues.add(strtermsofpermit);
				arrValues.add(strPassportNo);
				arrValues.add(strPassportIssuedby);
				arrValues.add(strPassportIssueDt);
				arrValues.add(strPassportExpiryDt);
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}			
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = 1;
				hshQuery.put("strQueryId","del_nridetails");
				arrValues.add(strappno);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
/** by gokul - for Audit Trial */
			String strEmpCon="";
			String strProvRen="";
			String strWrkPermit="";
			if(correctNull((String)hshValues.get("txt_empcontract")).trim().equalsIgnoreCase("0"))
				strEmpCon = "Yes";
			else
				strEmpCon = "No";
			if(correctNull((String)hshValues.get("sel_provrenewal")).trim().equalsIgnoreCase("0"))
				strProvRen = "Yes";
			else
				strProvRen = "No";
			if(correctNull((String)hshValues.get("sel_workpermit")).trim().equalsIgnoreCase("0"))
				strWrkPermit = "Yes";
			else
				strWrkPermit = "No";
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 12/09/2013
			 */
			strActionData="Visa Valid upto="+correctNull((String)hshValues.get("txt_visavaliddate"))+
							"~Passport Number="+correctNull((String)hshValues.get("txt_passportno"))+
							"~Passport Issued By="+correctNull((String)hshValues.get("txt_passportissuby"))+
							"~Date of Issue(Date)="+correctNull((String)hshValues.get("txt_dateofissue"))+
							"~Date of Expiry(Date)="+correctNull((String)hshValues.get("txt_dateofexpiry"))+
							"~Employment Contract="+correctNull(strEmpCon)+
							"~Contract Valid upto="+correctNull((String)hshValues.get("txt_contractvaliddate"))+
							"~Balance Period in Contract="+correctNull((String)hshValues.get("txt_balanceperiod"))+
							"~Provision for Renewal="+correctNull(strProvRen)+
							"~Work Permit/Labour Card="+correctNull(strWrkPermit)+
							"~Work Permit No/Labour Card No="+correctNull((String)hshValues.get("txt_workpermitno"))+
							"~Date of Issue="+correctNull((String)hshValues.get("txt_dtissue"))+
							"~Issuing Authority="+correctNull((String)hshValues.get("txt_issuingauthority"))+
							"~Valid upto="+correctNull((String)hshValues.get("txt_validupto"));
			
			
			
			
			if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("hidAction","Update");
			}
			else if(Helper.correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","Insert");
			}
			AuditTrial.auditNewLog(hshValues, "204", strappno, strActionData, sbOldAudit);
			/***
			 * End - Audit Trial New Data
			 */
/**	end	*/	
			
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	
	public HashMap getnriData(HashMap hshRequestValues) 
	{ 
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strappid="";
		String recordflag = "N";
		try
		{ 
			strappid=correctNull((String)hshRequestValues.get("hid_comappid1"));
			if(rs!=null)
			{
				rs.close();
			}
			
			 rs=DBUtils.executeLAPSQuery("sel_nridetails^"+strappid);	
			 			
			if(rs.next())
			{
				hshRecord.put("APPNRI_ID",correctNull((String)rs.getString("APPNRI_ID")));
				String APPNRI_VISAUPTO = Helper.correctNull((String)rs.getString("APPNRI_VISAUPTO"));
				if(APPNRI_VISAUPTO.equalsIgnoreCase("01/01/1900"))
				{
				  	hshRecord.put("APPNRI_VISAUPTO","");
				}
				else
				{
				   	hshRecord.put("APPNRI_VISAUPTO",correctNull((String)rs.getString("APPNRI_VISAUPTO")));
				}					
				hshRecord.put("APPNRI_VISADESC",correctNull((String)rs.getString("APPNRI_VISADESC")));
			 	hshRecord.put("APPNRI_OVERSEA_ADD",correctNull((String)rs.getString("APPNRI_OVERSEA_ADD")));
				hshRecord.put("APPNRI_EMP_CONT",correctNull((String)rs.getString("APPNRI_EMP_CONT")));
			    hshRecord.put("APPNRI_TERMS_CONT",correctNull((String)rs.getString("APPNRI_TERMS_CONT")));
			    String APPNRI_CONTRACTDT = Helper.correctNull((String)rs.getString("APPNRI_CONTRACTDT"));
			    if(APPNRI_CONTRACTDT.equalsIgnoreCase("01/01/1900"))
			    {
			    	hshRecord.put("APPNRI_CONTRACTDT","");
			    }
			    else
			    {
			    	hshRecord.put("APPNRI_CONTRACTDT",correctNull((String)rs.getString("APPNRI_CONTRACTDT")));
			    }			    
			    hshRecord.put("APPNRI_BALAPRD_CONT",correctNull((String)rs.getString("APPNRI_BALAPRD_CONT")));	
			    hshRecord.put("APPNRI_EMPLOYNAT",correctNull((String)rs.getString("APPNRI_EMPLOYNAT")));
				hshRecord.put("APPNRI_PROV_RENEW",correctNull((String)rs.getString("APPNRI_PROV_RENEW")));
			    String APPNRI_RENE_DET = Helper.correctNull((String)rs.getString("APPNRI_RENE_DET"));
			    if(APPNRI_RENE_DET.equalsIgnoreCase("01/01/1900"))
			    {
			    	hshRecord.put("APPNRI_RENE_DET","");
			    }
			    else
			    {
			    	hshRecord.put("APPNRI_RENE_DET",correctNull((String)rs.getString("APPNRI_RENE_DET")));
			    }
				hshRecord.put("APPNRI_WL_FLG",correctNull((String)rs.getString("APPNRI_WL_FLG")));
			    hshRecord.put("APPNRI_WL_NO",correctNull((String)rs.getString("APPNRI_WL_NO")));
			    String APPNRI_ISSUEDT = Helper.correctNull((String)rs.getString("APPNRI_ISSUEDT"));
			    if(APPNRI_ISSUEDT.equalsIgnoreCase("01/01/1900"))
			    {
			    	hshRecord.put("APPNRI_ISSUEDT","");
			    }
			    else
			    {
			    	hshRecord.put("APPNRI_ISSUEDT",correctNull((String)rs.getString("APPNRI_ISSUEDT")));
			    }
			    hshRecord.put("APPNRI_ISSAUTH",correctNull((String)rs.getString("APPNRI_ISSAUTH")));
			    
			    String APPNRI_VAILDUPTO = Helper.correctNull((String)rs.getString("APPNRI_VAILDUPTO"));
			    if(APPNRI_VAILDUPTO.equalsIgnoreCase("01/01/1900"))
			    {
			    	hshRecord.put("APPNRI_VAILDUPTO","");
			    }
			    else
			    {
			    	hshRecord.put("APPNRI_VAILDUPTO",correctNull((String)rs.getString("APPNRI_VAILDUPTO")));
			    }
			    hshRecord.put("APPNRI_TERM_WL",correctNull((String)rs.getString("APPNRI_TERM_WL")));
			    
			    
			    hshRecord.put("perapp_passissue",correctNull((String)rs.getString("appnri_passport_issuedby")));
				String perapp_passexpiry = correctNull((String)rs.getString("perapp_passexpiry"));
				if(perapp_passexpiry.equalsIgnoreCase("01/01/1900"))
				{
					hshRecord.put("perapp_passexpiry", "");
				}
				else
				{
					hshRecord.put("perapp_passexpiry", Helper.correctNull((String)rs.getString("perapp_passexpiry")));
				}
				hshRecord.put("perapp_passport",correctNull((String)rs.getString("appnri_passport_no")));
				String perapp_passissuedt = correctNull((String)rs.getString("perapp_passissuedt"));
				if(perapp_passissuedt.equalsIgnoreCase("01/01/1900"))
				{
					hshRecord.put("perapp_passissuedt", "");
				}
				else
				{
					hshRecord.put("perapp_passissuedt", Helper.correctNull((String)rs.getString("perapp_passissuedt")));
				}
				
			    recordflag = "Y";
			}			
			hshRecord.put("id1",strappid);			
			hshRecord.put("recordflag",recordflag);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getrefList "+ce.toString());
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
	
	public void UpdatePartnerDetailsData(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues =new ArrayList();
		ResultSet rs=null;
		String strAction=null;
		String strid1 = null;
		String strName="";			
		String strDesignation="";
		String strAge="";			
		String strQualification="";
		String strNetworth ="";
		String strsno ="";
		String strPhoneno ="";
		String strshare="";
		String strdob ="";
		String strgurantee ="";
		String fname ="";
		String peradd ="";
		String offadd ="";
		String resadd ="", strQueryId="";
		String annual ="";
		String incometax ="";
		String incometaxass ="";
		String wealth ="";
		String credit ="";
		String creditother ="";
		String fixedasset ="";
		String relationship="";
		String dependent="";
		String strActionData="",strDIN="";
		try
		{ 
			strAction =correctNull((String)hshValues.get("hidAction"));
			strsno=correctNull((String)hshValues.get("hid_sno"));		
			if(strsno.equalsIgnoreCase(""))
				strsno="0";
			
			strid1=Helper.correctNull((String)hshValues.get("hid_comappid2"));
			strName = Helper.correctNull((String)hshValues.get("txt_name"));		
			strAge = Helper.correctNull((String)hshValues.get("txt_age"));	
			strQualification =Helper.correctNull((String)hshValues.get("txt_qualification"));
			strDesignation = Helper.correctNull((String)hshValues.get("txt_designation"));
			strNetworth = Helper.correctNull((String)hshValues.get("txt_networth"));
			strPhoneno = Helper.correctNull((String)hshValues.get("txt_Phoneno"));
			strshare = Helper.correctNull((String)hshValues.get("share"));
			strdob =Helper.correctNull((String)hshValues.get("dob"));
			strgurantee =Helper.correctNull((String)hshValues.get("select")); 
		    fname=	Helper.correctNull((String)hshValues.get("txt_father")); 		
		    peradd=Helper.correctNull((String)hshValues.get("txt_per")); 	
			offadd=	Helper.correctNull((String)hshValues.get("txt_office")); 	
		    resadd=	Helper.correctNull((String)hshValues.get("txt_res")); 	
		    annual =Helper.correctNull((String)hshValues.get("txt_annual")); 
		    incometax =Helper.correctNull((String)hshValues.get("txt_incometax")); 
		    incometaxass =Helper.correctNull((String)hshValues.get("txt_incometaxass")); 
			wealth =Helper.correctNull((String)hshValues.get("txt_wealth")); 
		    credit =Helper.correctNull((String)hshValues.get("txt_credit")); 
			creditother =Helper.correctNull((String)hshValues.get("txt_creditother")); 
		    fixedasset =Helper.correctNull((String)hshValues.get("txt_fixedasset")); 
		    relationship =Helper.correctNull((String)hshValues.get("txt_relationship")); 
		    dependent =Helper.correctNull((String)hshValues.get("sel_dependent")); 
		    strDIN=Helper.correctNull((String)hshValues.get("txt_din")); 
	    	
		    String strQuery="";
		    StringBuilder sbOldAudit = new StringBuilder();
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("delete"))
			{
				strQuery = SQLParser.getSqlQuery("select_partnerdetails^"+strid1+"^"+strsno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strPerGuar = "";
					String strDependent = "";
					if(correctNull((String)rs.getString("part_gurantee")).trim().equalsIgnoreCase("1"))
						strPerGuar = "Yes";
					else
						strPerGuar = "No";
					if(correctNull((String)rs.getString("part_dependent")).trim().equalsIgnoreCase("1"))
						strDependent = "Yes";
					else
						strDependent = "No";
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 12/09/2013
					 */
					sbOldAudit.append("Name="+correctNull((String)rs.getString("part_name"))+
					"~DOB (dd/mm/yyyy)="+correctNull((String)rs.getString("part_dob"))+
					"~Age="+correctNull((String)rs.getString("part_age"))+
					"~Father/Husband  Name="+correctNull((String)rs.getString("fathers_name"))+
					"~Office / Bussiness Address="+correctNull((String)rs.getString("office_add"))+
					"~Residence Address="+correctNull((String)rs.getString("residence_add"))+
					"~Permanent Address="+correctNull((String)rs.getString("permeninant_add"))+
					"~Phone No.="+correctNull((String)rs.getString("part_phoneno"))+
					"~Qualification (Technical / Educational)="+correctNull((String)rs.getString("part_qualification"))+
					"~Designation="+correctNull((String)rs.getString("part_designation"))+
					"~Networth="+correctNull((String)rs.getString("part_networth"))+
					"~% Share="+correctNull((String)rs.getString("part_share"))+
					"~Personal Guarantee="+correctNull(strPerGuar)+
					"~Annual Income(last Financial year)="+correctNull((String)rs.getString("part_annual"))+
					"~Income Tax Repayment (Assessment for the last Year)="+correctNull((String)rs.getString("part_repayment"))+
					"~Income Tax Assessment (Completed till)="+correctNull((String)rs.getString("part_itassesment"))+
					"~Wealth Tax Payments(Assessment)="+correctNull((String)rs.getString("part_wealthtax"))+
					"~Credit Facilities Enjoyed with our Bank="+correctNull((String)rs.getString("part_credit"))+
					"~Credit Facilities Enjoyed with Other Bank="+correctNull((String)rs.getString("part_creditother"))+
					"~Details of fixed/Moveable assets="+correctNull((String)rs.getString("part_fixedasset"))+
					"~Relationship="+correctNull((String)rs.getString("part_relationship"))+
					"~Whether Dependent="+correctNull(strDependent)+"~DIN="+correctNull(strDIN));
					/***
					 * End - Audit Trial Old Data
					 */
				}
			}
			if(strAction.equals("insert"))
			{	
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","ins_partnerdetails");
				arrValues=new ArrayList();
				arrValues.add(strid1);	
				strQueryId="sel_max_partnerdetails1^"+strid1;
				rs=DBUtils.executeLAPSQuery(strQueryId);				
				 
				while(rs.next())
				{	
					strsno = correctNull((String)rs.getString("maxid"));
					
				}
				arrValues.add(strName);
				arrValues.add(strAge);
				arrValues.add(strQualification);
				arrValues.add(strDesignation);
				arrValues.add(strNetworth);
				arrValues.add(strPhoneno);
				arrValues.add(strshare);
				arrValues.add(strdob);
				arrValues.add(strgurantee);
				arrValues.add(fname);
				arrValues.add(peradd);
				arrValues.add(offadd);
				arrValues.add(resadd);
				arrValues.add(strsno);
				arrValues.add(annual);
				arrValues.add(incometax);
			    arrValues.add(incometaxass);
			    arrValues.add(wealth);
			    arrValues.add(credit) ;
			    arrValues.add(creditother);
			    arrValues.add(fixedasset) ;
			    arrValues.add(relationship);
			    arrValues.add(dependent) ;
			    arrValues.add(strDIN) ; 
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","upd_partnerdetails");
				arrValues=new ArrayList();
				arrValues.add(strid1);
				arrValues.add(strName);
				arrValues.add(strAge);
				arrValues.add(strQualification);
				arrValues.add(strDesignation);
				arrValues.add(strNetworth);	
				arrValues.add(strPhoneno);
				arrValues.add(strshare);
				arrValues.add(strdob);
				arrValues.add(strgurantee);
				arrValues.add(fname);
				arrValues.add(peradd);
				arrValues.add(offadd);
				arrValues.add(resadd);
				arrValues.add(annual);
				arrValues.add(incometax);
			    arrValues.add(incometaxass);
			    arrValues.add(wealth);
			    arrValues.add(credit) ;
			    arrValues.add(creditother);
			    arrValues.add(fixedasset) ;
			    arrValues.add(relationship);
			    arrValues.add(dependent) ;
			    arrValues.add(strDIN) ; 
				arrValues.add(strid1);
				arrValues.add(strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}			
			else if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","del_partnerdetails");
				arrValues=new ArrayList();
				arrValues.add(strid1);
				arrValues.add(strsno);				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equals("insert") || strAction.equals("update"))
			{
				/** By gokul - for audit trial */
				String strPerGuar = "";
				String strDependent = "";
				if(correctNull((String)hshValues.get("select")).trim().equalsIgnoreCase("1"))
					strPerGuar = "Yes";
				else
					strPerGuar = "No";
				if(correctNull((String)hshValues.get("sel_dependent")).trim().equalsIgnoreCase("1"))
					strDependent = "Yes";
				else
					strDependent = "No";
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				/***
				 * For Audit Trial New Data - By Karthikeyan.S on 12/09/2013
				 */
				strActionData="Name="+correctNull((String)hshValues.get("txt_name"))+
				"~DOB (dd/mm/yyyy)="+correctNull((String)hshValues.get("dob"))+
				"~Age="+correctNull((String)hshValues.get("txt_age"))+
				"~Father/Husband  Name="+correctNull((String)hshValues.get("txt_father"))+
				"~Office / Bussiness Address="+correctNull((String)hshValues.get("txt_office"))+
				"~Residence Address="+correctNull((String)hshValues.get("txt_res"))+
				"~Permanent Address="+correctNull((String)hshValues.get("txt_per"))+
				"~Phone No.="+correctNull((String)hshValues.get("txt_Phoneno"))+
				"~Qualification (Technical / Educational)="+correctNull((String)hshValues.get("txt_qualification"))+
				"~Designation="+correctNull((String)hshValues.get("txt_designation"))+
				"~Networth="+correctNull((String)hshValues.get("txt_networth"))+
				"~% Share="+correctNull((String)hshValues.get("share"))+
				"~Personal Guarantee="+correctNull(strPerGuar)+
				"~Annual Income(last Financial year)="+correctNull((String)hshValues.get("txt_annual"))+
				"~Income Tax Repayment (Assessment for the last Year)="+correctNull((String)hshValues.get("txt_incometax"))+
				"~Income Tax Assessment (Completed till)="+correctNull((String)hshValues.get("txt_incometaxass"))+
				"~Wealth Tax Payments(Assessment)="+correctNull((String)hshValues.get("txt_wealth"))+
				"~Credit Facilities Enjoyed with our Bank="+correctNull((String)hshValues.get("txt_credit"))+
				"~Credit Facilities Enjoyed with Other Bank="+correctNull((String)hshValues.get("txt_creditother"))+
				"~Details of fixed/Moveable assets="+correctNull((String)hshValues.get("txt_fixedasset"))+
				"~Relationship="+correctNull((String)hshValues.get("txt_relationship"))+
				"~Whether Dependent="+correctNull(strDependent)+"~DIN="+correctNull(strDIN);
			}
			AuditTrial.auditNewLog(hshValues, "202", strid1, strActionData.toString(), sbOldAudit.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}		
	}
	
	public HashMap getPartnerDetailsData(HashMap hshRequestValues) 
	{ 
		String strQuery="";
 		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecRow =new ArrayList();
		ArrayList vecData =new ArrayList();
		String strappid="",strid ="";
		String strAction = null;
		String strAppname = null;
		try
		{ 
			strAction=Helper.correctNull((String)hshRequestValues.get("hidAction"));
			strappid=correctNull((String)hshRequestValues.get("hid_comappid2"));
			strid=correctNull((String)hshRequestValues.get("hid_sno"));
			if(strAction.trim().equals("insert"))
			{
				 rs=DBUtils.executeLAPSQuery("sel_max_partnerdetails^"+strappid);				
				 
				while(rs.next())
				{	
					strid = rs.getString("maxid");
					strAction="update";
				}
			}	
			else if(strAction.trim().equals("update"))
			{
				strappid=correctNull((String)hshRequestValues.get("hid_comappid2"));
				strid=correctNull((String)hshRequestValues.get("hid_sno"));
				strAppname=Helper.correctNull((String)hshRequestValues.get("hidapp_name"));
			}
			if((strid.trim().equals("")))
			{
				strid="0";
			}
					
			
			rs=DBUtils.executeLAPSQuery("sel_partnerdetails^"+strappid);				
			 		
			while(rs.next())
			{
				vecRow = new ArrayList();
				vecRow.add(correctNull((String)rs.getString(1)));
				vecRow.add(correctNull((String)rs.getString(2)));
				vecRow.add(correctNull((String)rs.getString(3)));
				vecRow.add(correctNull((String)rs.getString(4)));
				vecRow.add(correctNull((String)rs.getString(5)));
				vecRow.add(correctNull((String)rs.getString(6)));
				vecRow.add(correctNull((String)rs.getString(7)));
				vecRow.add(correctNull((String)rs.getString(8)));
				vecRow.add(correctNull((String)rs.getString(9)));
				vecRow.add(correctNull((String)rs.getString(10)));
				vecRow.add(correctNull((String)rs.getString(11)));
				vecRow.add(correctNull((String)rs.getString(12)));
				vecRow.add(correctNull((String)rs.getString(13)));
				vecRow.add(correctNull((String)rs.getString(14)));
				vecRow.add(correctNull((String)rs.getString(15)));
				vecRow.add(correctNull((String)rs.getString(16)));
				vecRow.add(correctNull((String)rs.getString(17)));
				vecRow.add(correctNull((String)rs.getString(18)));
				vecRow.add(correctNull((String)rs.getString(19)));
				vecRow.add(correctNull((String)rs.getString(20)));
				vecRow.add(correctNull((String)rs.getString(21)));
				vecRow.add(correctNull((String)rs.getString(22)));
				vecRow.add(correctNull((String)rs.getString(23)));
				vecRow.add(correctNull((String)rs.getString(24)));
				vecRow.add(correctNull((String)rs.getString(25)));
				vecData.add(vecRow);
			}
			if(strAction.equalsIgnoreCase("update") )
			{
				strQuery = SQLParser.getSqlQuery("select_partnerdetails^"+strappid+"^"+strid);	
				 rs=DBUtils.executeQuery(strQuery);			
				if(rs.next())
				{
					hshRecord.put("perapp_id",correctNull((String)rs.getString("perapp_id")));
					hshRecord.put("part_slno",correctNull((String)rs.getString("part_slno")));
					hshRecord.put("part_name",correctNull((String)rs.getString("part_name")));
				    hshRecord.put("part_age",correctNull((String)rs.getString("part_age")));
				   // hshRecord.put("part_months",correctNull((String)rs.getString("part_months")));
				    hshRecord.put("part_qualification",correctNull((String)rs.getString("part_qualification")));
				    hshRecord.put("part_designation",correctNull((String)rs.getString("part_designation")));
				    hshRecord.put("part_networth",correctNull((String)rs.getString("part_networth")));
				    hshRecord.put("part_phoneno",correctNull((String)rs.getString("part_phoneno")));
				    hshRecord.put("part_dob",correctNull((String)rs.getString("part_dob")));
				    hshRecord.put("part_share",correctNull((String)rs.getString("part_share")));
				    hshRecord.put("part_gurantee",correctNull((String)rs.getString("part_gurantee")));
				    hshRecord.put("fathers_name",correctNull((String)rs.getString("fathers_name")));
				    hshRecord.put("permeninant_add",correctNull((String)rs.getString("permeninant_add"))); 
				    hshRecord.put("office_add",correctNull((String)rs.getString("office_add"))); 
				    hshRecord.put("residence_add",correctNull((String)rs.getString("residence_add"))); 
				    hshRecord.put("part_annual",correctNull((String)rs.getString("part_annual"))); 
				    hshRecord.put("part_repayment",correctNull((String)rs.getString("part_repayment"))); 
				    hshRecord.put("part_itassesment",correctNull((String)rs.getString("part_itassesment"))); 
				    hshRecord.put("part_wealthtax",correctNull((String)rs.getString("part_wealthtax"))); 
				    hshRecord.put("part_credit",correctNull((String)rs.getString("part_credit"))); 
				    hshRecord.put("part_creditother",correctNull((String)rs.getString("part_creditother"))); 
				    hshRecord.put("part_fixedasset",correctNull((String)rs.getString("part_fixedasset")));
				    hshRecord.put("part_relationship",correctNull((String)rs.getString("part_relationship"))); 
				    hshRecord.put("part_dependent",correctNull((String)rs.getString("part_dependent")));
				    hshRecord.put("part_din",correctNull(rs.getString("part_din")));
				}
			}
			hshRecord.put("vecData",vecData);	
			hshRecord.put("id1",strappid);		
			hshRecord.put("strAppname", strAppname);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getPartnerDetails "+ce.toString());
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
}	