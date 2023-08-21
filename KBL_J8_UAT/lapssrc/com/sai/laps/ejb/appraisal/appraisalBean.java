 package com.sai.laps.ejb.appraisal;
 
import java.sql.ResultSet;
 
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;
import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.ejb.retailassessment.RetailAssessmentBean;
import com.sai.laps.helper.ApplicantParams;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;
@Stateless(name = "appraisalBean", mappedName = "appraisalHome")
@Remote (appraisalRemote.class)
public class appraisalBean extends BeanAdapter
{	
	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(appraisalBean.class);	

	public HashMap getuserslist (HashMap hshValues) 
	{ 
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecCol = new ArrayList();
		ArrayList vecRow = new ArrayList();		
	
		try
		{
			String strOrgCode = Helper.correctNull((String)hshValues.get("strOrgCode"));
			rs=DBUtils.executeLAPSQuery("selectusername1^"+strOrgCode);
			 		
			while(rs.next())
			{
				vecCol = new ArrayList();
				vecCol.add(correctNull((String)rs.getString("appname")));
				vecCol.add(correctNull((String)rs.getString("usr_id")));
				vecRow.add(vecCol);	
			}						
			hshRecord.put("vecRow",vecRow);			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in help "+ce.toString());
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

	public void insertdates (HashMap hshValues) 
	{ 
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap(); 
		ArrayList arrValues = new ArrayList();
		String strappno ="";
		//String Label = correctNull((String)hshValues.get("Label"));
		String strAction= correctNull((String)hshValues.get("hidAction"));
		String strProductType=correctNull((String)hshValues.get("strProductType"));
		String strhidStatus = correctNull((String)hshValues.get("hidparam"));
		String type="",strFacSno="1";
		StringBuilder sbOldAudit = new StringBuilder();
		String strQuery="";
		String strQuery1="";
		if(!strProductType.equalsIgnoreCase(""))
		{
			type=strProductType.substring(0,1);
		}
		boolean bstate;
		try
		{ 
			
			strappno=correctNull((String)hshValues.get("appno"));
			if(strappno.equalsIgnoreCase(""))
			{
				strappno = correctNull((String)hshValues.get("strappno"));
			}
			String strLoanType = correctNull((String)hshValues.get("txt_loantype"));
			String appraisaldate = correctNull((String)hshValues.get("appraisaldate"));
			String txt_userid = correctNull((String)hshValues.get("txt_userid"));
			//String app_no= correctNull((String)hshValues.get("applicationnumber"));
			String sanction=correctNull((String)hshValues.get("txt_sanction_amount"));
			String premium=correctNull((String)hshValues.get("txt_inspremiumamt"));
			String strSancLevel=correctNull((String)hshValues.get("sel_SancLevel"));
			String strSancAuth=correctNull((String)hshValues.get("sel_SancAuth"));
			String strSancDept=correctNull((String)hshValues.get("sel_SancDept"));
			String strSancRefNo=correctNull((String)hshValues.get("txt_sancrefno"));
			String strSancBranch=correctNull((String)hshValues.get("sel_SancBranch"));
			String strsanctiondate=correctNull((String)hshValues.get("sanctiondate"));
			
			String strVerifyWithCFR=correctNull((String)hshValues.get("CFR_verified"));
			String strNamApprCFR=correctNull((String)hshValues.get("Namein_CFR"));
			String strRefNoCFR=correctNull((String)hshValues.get("txt_CFRdev_refno"));
			String strsel_CERSAI=correctNull((String)hshValues.get("sel_CERSAI_check"));
			String strBranch=correctNull((String)hshValues.get("hid_perbranch"));
			/*if(app_no.equalsIgnoreCase("null"))
			{
				app_no=strappno;
			}*/
			String strschemefor= correctNull((String)hshValues.get("txt_schemefor"));
			
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 12/09/2013
			 */
			strQuery=SQLParser.getSqlQuery("sel_date^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				String strAppraisedByOldAudit=Helper.correctNull((String)rs.getString("apprised_by"));
				String strAppraisedByDescOldAudit="";
				if(!strAppraisedByOldAudit.equals(""))
				{
					strQuery1 = SQLParser.getSqlQuery("sel_username^"+strAppraisedByOldAudit);	
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strAppraisedByDescOldAudit=Helper.correctNull((String)rs1.getString("username"));
					}
				}
				String strSancLevelCodeOldAudit=Helper.correctNull((String)rs.getString("appraisal_sanclevel"));
				String strSancLevelDescOldAudit=MastApplicantBean.getMasterDesc("CBSMast","14",strSancLevelCodeOldAudit);
				String strSancAuthCodeOldAudit=Helper.correctNull((String)rs.getString("appraisal_sancauth"));
				String strSancAuthDescOldAudit=MastApplicantBean.getMasterDesc("CBSMast","15",strSancAuthCodeOldAudit);
				String strSancDeptCodeOldAudit=Helper.correctNull((String)rs.getString("appraisal_department"));
				String strSancDeptDescOldAudit=MastApplicantBean.getMasterDesc("CBSMast","26",strSancDeptCodeOldAudit);
				sbOldAudit
				.append("~Date of Appraisal =").append(Helper.correctNull((String)rs.getString("apprisal_date")))
				.append("~Appraised by =").append(strAppraisedByDescOldAudit)
				.append("~Sanction Level =").append(strSancLevelDescOldAudit)
				.append("~Sanctioning Authority =").append(strSancAuthDescOldAudit)
				.append("~Sanctioning Department =").append(strSancDeptDescOldAudit)
				.append("~Sanctioning Loan Amount =").append(Helper.correctDouble((String)rs.getString("sanction_amount")))
				.append("~Sanctioning Branch =").append(Helper.correctDouble((String)rs.getString("APPRAISAL_BRANCH")));
			}
			/***
			 * End - Audit Trial Old Data
			 */
			rs=DBUtils.executeLAPSQuery("sel_date^"+strappno);
			bstate = rs.next();
			if(bstate)
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();				
				arrValues.add(appraisaldate);
				arrValues.add(txt_userid);
				
				arrValues.add(strschemefor);
				arrValues.add(sanction);
				arrValues.add(premium);
				arrValues.add("Y");
				arrValues.add(strSancLevel);
				arrValues.add(strSancAuth);
				arrValues.add(strSancDept);
				arrValues.add(strSancRefNo);
				if(strSancDept.equalsIgnoreCase("017")){
					arrValues.add("CLPSC");
					}else{
						arrValues.add(strSancBranch);
					}
				arrValues.add(strsanctiondate);
				arrValues.add(strappno);
				
				
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","upd_loandetails_sanref");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();				
				arrValues.add(appraisaldate);
				arrValues.add(txt_userid);
				arrValues.add(strappno);
				arrValues.add(strschemefor);
				arrValues.add(sanction);
				arrValues.add(premium);
				arrValues.add("Y");
				arrValues.add(strSancLevel);
				arrValues.add(strSancAuth);
				arrValues.add(strSancDept);
				arrValues.add(strSancRefNo);
				if(strSancDept.equalsIgnoreCase("017")){
					arrValues.add("CLPSC");
					}else{
						arrValues.add(strSancBranch);
					}
				arrValues.add(strsanctiondate);
							
				
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","Ins_date");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();  
				arrValues.add(strappno);
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","del_date");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			
			if(strProductType.equalsIgnoreCase("pG"))
			{
				strQuery=SQLParser.getSqlQuery("selgoldratemaster^Y");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();  
					arrValues.add(Helper.correctNull(rs.getString("grm_sno")));
					arrValues.add(strappno);
					hshQueryValues.put("size","1");
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_loanmasterid");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			}
			
			if(type.equalsIgnoreCase("a") && strAction.equalsIgnoreCase("edit"))
			{
				String strCollpercent="";
				PerApplicantBean perapp = new PerApplicantBean();
				strCollpercent = perapp.getCollateralpercent(strappno, sanction);
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(sanction);//For updating the eligible loan amount
				arrValues.add(sanction);//For updating margin offered by the borrower
				arrValues.add(strCollpercent);
				arrValues.add(strappno);
				hshQueryValues.put("size", "1");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agr_ins_loandetail");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			//Updating the sanctioned Loan amount and EMI for the Loan
			if(!type.equalsIgnoreCase("a"))
			{
				String strCollpercent="";
				PerApplicantBean perapp = new PerApplicantBean();
				strCollpercent = perapp.getCollateralpercent(strappno, correctNull((String)hshValues.get("txt_sanction_amount")));
				
				String strLoanProcFee = "",strPrdCode="";
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPrdCode=Helper.correctNull(rs.getString("app_prdcode"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				if (!strPrdCode.trim().equals(""))
				{
					HashMap hshTemp=new HashMap();
					hshTemp.put("appid", strappno);
					hshTemp.put("prdcode", strPrdCode);
					hshTemp.put("recamt",correctNull((String)hshValues.get("txt_sanction_amount"))); 
																								
					hshTemp = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getDocFee");
					strLoanProcFee = Helper.correctDouble((String) hshTemp.get("procfeenew"));
				}
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();				
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_amount")));
				arrValues.add(correctNull((String)hshValues.get("txt_EMI")));
				arrValues.add(correctNull((String)hshValues.get("txt_interest_EMI")));
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_amount")));
				arrValues.add(correctNull((String)hshValues.get("txt_repaycapacity")));
				arrValues.add(strCollpercent);
				
				arrValues.add(correctNull((String)hshValues.get("txtloan_modintrate")));
				arrValues.add(correctNull((String)hshValues.get("hidmclrrate")));
				if(Helper.correctNull((String)hshValues.get("hidInterestType")).equals("Floating"))
					arrValues.add("");
				else
					arrValues.add(correctNull((String)hshValues.get("hidInterestIndexId")));
				arrValues.add(correctNull((String)hshValues.get("hidcreditrskpremium")));
				arrValues.add(correctNull((String)hshValues.get("hidbusstrategicpremium")));
				arrValues.add(strLoanProcFee);
				
				arrValues.add(strVerifyWithCFR);
				arrValues.add(strNamApprCFR);
				arrValues.add(strRefNoCFR);			
				arrValues.add(Helper.correctNull((String)hshValues.get("status_verified")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("hid_userid1")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("appref_Appr_date")));
				arrValues.add(strsel_CERSAI);
				arrValues.add(strBranch);
				arrValues.add(correctNull((String)hshValues.get("txt_EMI")));
				arrValues.add(correctNull((String)hshValues.get("txtloan_modintrate")));
				arrValues.add(strappno);
				
				hshQueryValues.put("size","1");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","upd_sanction_amount");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(correctNull((String)hshValues.get("txt_sanction_amount")));
				arrValues.add(strappno);
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","upd_securityamount"); 
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				
				perapp.updateRepaymentCapacityValue(hshValues);
			}
			if(strhidStatus.equalsIgnoreCase("MISDEL"))
			{
				String strAppProposal="";
				strQuery=SQLParser.getSqlQuery("comfunsel1^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppProposal=Helper.correctNull(rs.getString("APP_RENEW_FLAG"));
				}
				if(strAppProposal.equalsIgnoreCase("P"))
				{
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strappno+"^"+strFacSno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							arrValues.add(correctNull((String)hshValues.get("txt_sanction_amount")));
							arrValues.add(strappno);
							arrValues.add(strFacSno);
							hshQuery.put("arrValues",arrValues); 
							hshQuery.put("strQueryId","updcbsdetails"); 
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
				}
				else
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strappno);
					arrValues.add(strFacSno);
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","update_mis_appdetailssno"); 
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strappno+"^"+strFacSno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						if(Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							arrValues.add(correctNull((String)hshValues.get("txt_sanction_amount")));
							arrValues.add(strappno);
							arrValues.add(strFacSno);
							hshQuery.put("arrValues",arrValues); 
							hshQuery.put("strQueryId","updcbsdetails"); 
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
						else
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							arrValues.add(strappno);
							arrValues.add(strFacSno);
							hshQuery.put("arrValues",arrValues); 
							hshQuery.put("strQueryId","setcbsdetailsdel"); 
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
						}
					}
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		
				/*hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strappno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","del_misappdisplayscreen"); 
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strappno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","setcbsdetailsdel"); 
				hshQueryValues.put("3",hshQuery);
				hshQueryValues.put("size","3");*/
				
			}
			
			if(Helper.correctNull((String)hshValues.get("hidSancAuth")).equalsIgnoreCase("Y"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delete_delegation");
				arrValues.add(strappno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 18/09/2013
			 */
			StringBuilder sbAuditTrial=new StringBuilder();
			String strSancLevelCode=Helper.correctNull((String)hshValues.get("sel_SancLevel"));
			String strSancLevelDesc=MastApplicantBean.getMasterDesc("CBSMast","14",strSancLevelCode);
			String strSancAuthCode=Helper.correctNull((String)hshValues.get("sel_SancAuth"));
			String strSancAuthDesc=MastApplicantBean.getMasterDesc("CBSMast","15",strSancAuthCode);
			String strSancDeptCode=Helper.correctNull((String)hshValues.get("sel_SancDept"));
			String strSancDeptDesc=MastApplicantBean.getMasterDesc("CBSMast","26",strSancDeptCode);
			sbAuditTrial
			.append("~Date of Appraisal =").append(correctNull((String)hshValues.get("appraisaldate")))
			.append("~Appraised by =").append(correctNull((String)hshValues.get("appraisedby")))
			.append("~Sanction Level =").append(strSancLevelDesc)
			.append("~Sanctioning Authority =").append(strSancAuthDesc)
			.append("~Sanctioning Department =").append(strSancDeptDesc)
			.append("~Sanctioning Branch =").append(correctNull((String)hshValues.get("sel_SancBranch")))
			.append("~Sanctioning Loan Amount =").append(correctNull((String)hshValues.get("txt_sanction_amount")));
			if(strLoanType.trim().equalsIgnoreCase("Y"))
			{
				sbAuditTrial.append("~Insurance Premium Amount =").append(correctNull((String)hshValues.get("txt_inspremiumamt")));
			}
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("N"))
			{
				hshValues.put("hidAction","insert");
			}
			else
			{
				hshValues.put("hidAction","update");
			}
			AuditTrial.auditNewLog(hshValues, "229", strappno, sbAuditTrial.toString(), sbOldAudit.toString());
			/***
			 * End - Audit Trial New Data
			 */
			/*if(!correctNull((String)hshValues.get("hidCheckAgr")).equals(""))
			{	
				AuditTrial.auditLog(hshValues,"236",strappno,sbAuditTrial.toString());	
			}
			else
			{	
				AuditTrial.auditLog(hshValues,"59",strappno,sbAuditTrial.toString());	
			}*/
		
			String sessionModuleType=Helper.correctNull((String)hshValues.get("sessionModuleType"));
	   		if(sessionModuleType.equalsIgnoreCase("DIGI"))
	   		{
		   		/*hshQuery=new HashMap();
				arrValues=new ArrayList();   		
				arrValues.add("N");
				arrValues.add(strappno);		    					
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","updt_loan_dtls_recalc_faclty");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
				
	   			hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();   		
				arrValues.add(strappno);		    					
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_digi_procesingfee");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
	   		}
		
		
		
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getloandetails "+e.getMessage());	
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
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
	}
	
	public HashMap getloandetails(HashMap hshValues) 
	{ 
		String strQuery="";
		String Apprised_by = "";
		String SENT_FLAG="N";
		String READSENT_FLAG="N";
		String PROPERTY_FLAG="N";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null,rs5=null;
		HashMap hshram =new HashMap();
		HashMap hshram1 =new HashMap();
		HashMap hshrepay =new HashMap();
		String recordflag="N";String strDate = "",strAppCreatedOrg=""; 
		String strProdPurpose="",strVehicleType="", staffproduct="", strPrdcode="";
		ArrayList arrayCol = new ArrayList();
		
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strappno = Helper.correctNull((String)hshValues.get("appno"));
		String strhidPROD = Helper.correctNull((String)hshValues.get("hidPROD"));
		String strAppstatus = Helper.correctNull((String)hshValues.get("strappstatus"));
		String appstatus = Helper.correctNull((String)hshValues.get("appstatus"));
		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
		String strEmployment="", strDemoAppId="",strDocRecvd = "";
		String prd_code="0",strGoldMasterID="";
		String ApprUserid="";
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)hshValues.get("hid_appno"));
		}
		if(strappno.equalsIgnoreCase(""))
		{
			strappno = Helper.correctNull((String)hshValues.get("strappno"));
		}
		String Label1 = Helper.correctNull((String)hshValues.get("Label1"));
		String Label ="";
		if(Label1.equalsIgnoreCase(""))
		{
			 Label = Helper.correctNull((String)hshValues.get("Label"));
		}
		if(!Label1.equalsIgnoreCase(""))
		{
			Label=Label1;
		}
		HashMap hshRecord = new HashMap();	
		try
		{ 
			if(prd_type!="" && prd_type.charAt(0)=='p')
			{
				strQuery = SQLParser.getSqlQuery("getretailscore^" + strappno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					hshRecord.put("rating_score",Helper.correctNull((String)rs.getString("rating_score")));
				}
			}
			if(rs!=null)rs.close();
			
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("appname", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
				hshRecord.put("app_termflag",correctNull(rs.getString("app_termflag")));
				strDemoAppId=rs.getString("demo_appid");
			}
			if(prd_type.equalsIgnoreCase("pR"))
			{
				updateDepositROIData(strappno);
				if(!strDemoAppId.equalsIgnoreCase(""))
				{
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("sel_employmentstatus^"+strDemoAppId);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						strEmployment=Helper.correctNull(rs.getString("perapp_employment"));
					}
					if(rs!=null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("getlreq^"+strappno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
					{
						strDocRecvd=rs.getString("loan_docrecvd");
					}
					//if(!strEmployment.equalsIgnoreCase(""))
					{
						updateDepositRepayPeriod(strappno, strEmployment, strAppstatus, strDocRecvd);
					}
				}
			}
			
			if(rs != null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_date^"+strappno);
			if(rs.next())
			{
				hshRecord.put("apprisal_Date",correctNull((String)rs.getString("apprisal_Date")));
				hshRecord.put("Apprised_by",correctNull((String)rs.getString("Apprised_by")));
				hshRecord.put("apprised_scheme",correctNull((String)rs.getString("apprised_scheme")));
				hshRecord.put("premium_amount",correctNull((String)rs.getString("premium_amount")));
				Apprised_by = Helper.correctNull((String)rs.getString("Apprised_by"));
				hshRecord.put("bstate", "True");
				hshRecord.put("recordflag","Y");
				hshRecord.put("appraisal_sanclevel",Helper.correctNull((String)rs.getString("appraisal_sanclevel")));
				hshRecord.put("appraisal_sancauth",Helper.correctNull((String)rs.getString("appraisal_sancauth")));
				hshRecord.put("appraisal_department",Helper.correctNull((String)rs.getString("appraisal_department")));
				hshRecord.put("appraisal_sancrefno",Helper.correctNull((String)rs.getString("Sanc_Ref_No")));
				hshRecord.put("APPRAISAL_BRANCH",Helper.correctNull((String)rs.getString("APPRAISAL_BRANCH")));
				hshRecord.put("appref_sancdate",Helper.correctNull((String)rs.getString("appref_sancdate")));

				
				
				recordflag="Y";
			}
			else
			{
				hshRecord.put("recordflag",recordflag);
				hshRecord.put("bstate","False");
			}
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selloan_details^"+strappno);			 
			while(rs.next())
			{
				hshRecord.put("loan_VerifyWithCFR",(correctNull((String)rs.getString("LOAN_CFR_VERIFIED"))));
				hshRecord.put("loan_NamApprCFR",(correctNull((String)rs.getString("LOAN_CFR_BORNAME"))));
				hshRecord.put("loan_RefNoCFR",(correctNull((String)rs.getString("LOAN_CFR_DEV_RENFO"))));

				hshRecord.put("status_verified1",(correctNull((String)rs.getString("STATUS_VERIFIED"))));
				hshRecord.put("loan_Appr_date",(correctNull((String)rs.getString("LOAN_APPR_DATE"))));
				hshRecord.put("loan_appr_userid1",Helper.correctNull((String)rs.getString("LOAN_USERID1")));
				hshRecord.put("LOAN_CERSAI_CHECK",(correctNull((String)rs.getString("LOAN_CERSAI_CHECK"))));
				ApprUserid = Helper.correctNull((String)rs.getString("LOAN_USERID1"));
				
				if(ApprUserid!="")
				{
					if(rs1!=null)
						{
							rs1.close();
						}
						
				strQuery = SQLParser.getSqlQuery("selectusername^"+ApprUserid);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
					{
						hshRecord.put("appuserid",correctNull((String)rs1.getString("name")));
					}
				}
				hshRecord.put("prodcategory",(correctNull((String)rs.getString("category"))));
				hshRecord.put("subcategory",(correctNull((String)rs.getString("subcategory"))));
				hshRecord.put("mintrate",(correctNull((String)rs.getString("mintrate"))));
				hshRecord.put("lreqterms",(correctNull((String)rs.getString("lreqterms"))));
				hshRecord.put("amtreqd",(correctNull((String)rs.getString("amtreqd"))));
				hshRecord.put("emi",(correctNull((String)rs.getString("emi"))));
				hshRecord.put("loan_purposeofloan",(Helper.CLOBToString(rs.getClob("loan_purposeofloan"))));
				hshRecord.put("prd_desc",(correctNull((String)rs.getString("prd_desc"))));
				hshRecord.put("loan_margin",(correctNull((String)rs.getString("loan_margin"))));
				if(recordflag.equalsIgnoreCase("N") && (prd_type.equalsIgnoreCase("pG") || prd_type.equalsIgnoreCase("pR")))
				{
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("selectmpbfeligibleamount^" + strappno);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("sanction_amount", String.valueOf(rs1.getDouble("mpbf_eligibleamount")));
							   
					}
				}
				else
				{
					hshRecord.put("sanction_amount", correctNull((String)rs.getString("loan_recmdamt")));
				}
				hshRecord.put("StaffFlag", correctNull((String)rs.getString("indinfo_is_staff")));
				hshRecord.put("PrincipalRatio", correctNull((String)rs.getString("prd_principal")));
				hshRecord.put("InterestRatio", correctNull((String)rs.getString("prd_interest")));
				hshRecord.put("InterestEMI", correctNull((String)rs.getString("loan_interest_emi")));
				hshRecord.put("loan_govt", correctNull((String)rs.getString("loan_govt")));
				hshRecord.put("loan_filedon", correctNull((String)rs.getString("loan_filedon")));			
				hshRecord.put("staffproduct", correctNull((String)rs.getString("prd_staffprd")));
				hshRecord.put("homeplusproduct", correctNull((String)rs.getString("prd_homeplus")));
				hshRecord.put("scorepattern", correctNull((String)rs.getString("buss_bussid")));
				hshRecord.put("loan_interestcharged", correctNull((String)rs.getString("loan_interestcharged")));
				hshRecord.put("loan_intcalcmode", Helper.correctNull((String)rs.getString("loan_intcalcmode")));
				hshRecord.put("loan_repaymenttype", Helper.correctNull(rs.getString("loan_repaymenttype")));
				if((prd_type.equalsIgnoreCase("pE") || prd_type.equalsIgnoreCase("pG")|| prd_type.equalsIgnoreCase("pL")|| prd_type.equalsIgnoreCase("pR")|| prd_type.equalsIgnoreCase("pI"))){
					hshRecord.put("repaycapacity", "0.00");
				}else if(prd_type.equalsIgnoreCase("pM") && Helper.correctNull((String)rs.getString("prd_loantype")).equalsIgnoreCase("OD")){
					hshRecord.put("repaycapacity", "0.00");
				}else{
					RetailAssessmentBean rab=new RetailAssessmentBean();
					hshrepay=rab.getRepaymentCapacity(hshValues);
					hshRecord.put("repaycapacity",Helper.correctDouble((String)hshrepay.get("dbl_perannualtot")));
					hshRecord.put("repaycapacity_staff",Helper.correctDouble((String)hshrepay.get("Percentageofloancommitment")));
				}
				strDate = correctNull((String)rs.getString("app_processdate"));
				prd_code=correctNull((String)rs.getString("prd_code"));
				
				hshRecord.put("loan_mclrrate", Helper.correctNull(rs.getString("loan_baserate")));
				hshRecord.put("loan_inttype", Helper.correctNull(rs.getString("loan_inttype")));
				hshRecord.put("loan_creditrskval", Helper.correctNull(rs.getString("loan_creditrskval")));
				hshRecord.put("loan_busstatval", Helper.correctNull(rs.getString("loan_busstatval")));
				hshRecord.put("loan_mclrtype", Helper.correctNull(rs.getString("loan_mclrtype")));
				hshRecord.put("loan_interestid", Helper.correctNull(rs.getString("loan_interestid")));
				hshRecord.put("govt_scheme", Helper.correctNull(rs.getString("govt_scheme")));
				//hshRecord.put("recalculate_facility", Helper.correctNull(rs.getString("LOAN_RECALCULATE_FACILITY")));
				if(rs1!=null)
					rs1.close();
				strQuery = SQLParser.getSqlQuery("getorgcode^"+correctNull(rs.getString("LOAN_PERTAINS_BRANCH")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("strBranchName", Helper.correctNull(rs1.getString("org_name")));
					hshRecord.put("strBranchOrgCode", Helper.correctNull(rs1.getString("org_code")));
					hshRecord.put("strBranchCode", Helper.correctNull(rs.getString("LOAN_PERTAINS_BRANCH")));
				}
				hshRecord.put("strAppCreatedOrg", Helper.correctNull(rs.getString("APP_ORGLEVEL")));//For OrgLevel
				strGoldMasterID=Helper.correctNull(rs.getString("loan_goldrate_masterid"));
				String strFlag="Y";
				if(prd_type.equalsIgnoreCase("pG"))
				{
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^118");
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						if(!Helper.correctNull((String)rs1.getString("LOAN_PARAMVAL")).equalsIgnoreCase(""))
						{
							if((Helper.dateDiff(Helper.correctNull((String)rs1.getString("LOAN_PARAMVAL")), Helper.correctNull((String)hshValues.get("strAppCreateDate"))))>=0)
								strFlag="N";	
						}
					}
					
				}
				if(prd_type.equalsIgnoreCase("pG") && strFlag.equalsIgnoreCase("Y"))
				{
					if(rs1!=null)
						rs1.close();
					double dblLatestMargin=0.00,dblAvgMargin=0.00,dblAgriLatestMargin=0.0,dblAgriAvgMargin=0.0;
					if(!appstatus.equalsIgnoreCase("Open/Pending")&& !strGoldMasterID.equalsIgnoreCase(""))
						strQuery = SQLParser.getSqlQuery("selgoldratemaster_id^"+strGoldMasterID);
					else
						strQuery = SQLParser.getSqlQuery("selgoldratemaster^Y");
					rs1 = DBUtils.executeQuery(strQuery);
					if (rs1.next())
					{
						dblLatestMargin=rs1.getDouble("grm_latestmargin");
						dblAvgMargin=rs1.getDouble("grm_avgmargin");
						if(Helper.correctNull(rs.getString("prd_whetheragri")).equalsIgnoreCase("Y"))
						{
							dblLatestMargin=rs1.getDouble("grm_agrilatestmargin_ibja");
							dblAvgMargin=rs1.getDouble("grm_agriavgmargin_ibja");
						}
						
						if(dblAvgMargin>dblLatestMargin)
							dblLatestMargin=dblAvgMargin;
						
						if(Double.parseDouble(Helper.correctDouble(rs.getString("loan_margin")))!=dblLatestMargin)
						{
							hshRecord.put("loan_margin",Helper.formatDoubleValue(dblLatestMargin));
							
							if(appstatus.equalsIgnoreCase("Open/Pending"))
							{
								ArrayList arrValues = new ArrayList();
								HashMap hshQuery = new HashMap();
								HashMap hshQueryValues = new HashMap();
								arrValues.add(String.valueOf(dblLatestMargin));
								arrValues.add(strappno);
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "upd_margin_loandetails");
								hshQueryValues.put("1", hshQuery);
								hshQueryValues.put("size", "1");
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
							
						}
						
					}
				}
			}
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("securesel^"+strappno);			
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("loan_noofinstallment",correctNull((String)rs.getString("loan_noofinstallment")));
				hshRecord.put("loan_servised", correctNull((String)rs.getString("loan_servised")));
				
			}
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_staffprd^"+prd_code);			
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("staff_under",correctNull((String)rs.getString("staff_under")));
				hshRecord.put("strMaxRepaymentperiodPrin",correctNull(rs.getString("prd_staff_maxterm_prin")));
				hshRecord.put("strMaxRepaymentperiodIntr",correctNull(rs.getString("prd_staff_maxterm_intr")));
				hshRecord.put("strPRDPURPOSE",correctNull(rs.getString("PRD_PURPOSE")));
			}
			if(rs!=null){
				rs.close();
			}
			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			ArrayList vecReport=new ArrayList();
			ArrayList vecCoapp=null;
			String strType="";
			String NetAssets="";
			String strName="";
			String strId="", strRel="", strRelDesc="";
			
			if(strAppstatus.equalsIgnoreCase("op") || appstatus.equalsIgnoreCase("Open/Pending"))
			{
				strDate = Helper.getCurrentDateTime();
			}
			
			rs=DBUtils.executeLAPSQuery("appraisal_experienceservice^"+strDate+"^"+strDate+"^"+strappno);
			while(rs.next())
			{					
				vecCoapp=new ArrayList();
				strType=correctNull(correctNull((String)rs.getString("demo_type")));				
				strId=strType+correctNull(correctNull((String)rs.getString("demo_appid")));
				if (strType.trim().equalsIgnoreCase("a"))
				{
					strType="Applicant";
				}
				else if (strType.trim().equalsIgnoreCase("c"))
				{
					strType="Joint-Applicant";
				}
				else if (strType.trim().equalsIgnoreCase("g"))
				{
					strType="Guarantor";
				}
				else if (strType.trim().equalsIgnoreCase("o"))
				{
					strType="Co-Obligant";
				}
				else if (strType.trim().equalsIgnoreCase("p"))
				{
					strType="Sole properitier";
				}
				
				vecCoapp.add(strType);
				strName=correctNull(correctNull((String)rs.getString("coappname")));
				vecCoapp.add(strName);
				vecCoapp.add(correctNull((String)rs.getString("demo_appno")));
				vecCoapp.add(correctNull((String)rs.getString("demo_type")));
				vecCoapp.add(correctNull((String)rs.getString("demo_appid")));
				strRel=Helper.correctNull(rs.getString("demo_relation"));
				if(!strRel.equalsIgnoreCase(""))
				{
					rs2 = DBUtils.executeLAPSQuery("selcoappguar^"+strRel);
					if(rs2.next())
					{
						strRelDesc=Helper.correctNull(rs2.getString("stat_data_desc1"));
					}
				}
				vecCoapp.add(strRelDesc);
				vecCoapp.add(correctNull((String)rs.getString("perapp_dob")));
				vecCoapp.add(Helper.correctInt(rs.getString("age")));
				NetAssets="0.0";
				NetAssets=Helper.correctInt(rs.getString("networth"));
				if(correctNull((String)rs.getString("perapp_employment")).equals("1") || correctNull((String)rs.getString("perapp_employment")).equals("9"))
					vecCoapp.add(correctNull((String)rs.getString("remempage")));
				else
					vecCoapp.add(correctNull((String)rs.getString("remselfage")));
				
				/*strQuery=SQLParser.getSqlQuery("selcreditreport2^"+strappno+"^"+strId);
				if(rs1 != null)
					rs1.close();
				rs1=DBUtils.executeQuery(strQuery);
				NetAssets="0.0";
				if(rs1.next())
				{
					NetAssets=correctNull((String)rs1.getString("CR_Total_MEANS"));
				}*/
				vecCoapp.add(NetAssets);
				
				vecReport.add(vecCoapp);
				
				if(!correctNull(correctNull((String)rs.getString("demo_type"))).equalsIgnoreCase("p"))
				{
					if(rs1!=null)
						rs1.close();
					strQuery = SQLParser.getSqlQuery("due_report_sel^"+correctNull(rs.getString("demo_appno"))+"^"+correctNull((String)rs.getString("demo_oldappid")));
					rs1=DBUtils.executeQuery(strQuery);
					if(!rs1.next())
					{
						hshRecord.put("strDDRAppFlag","N");
					}
				}
			}
			
			if(!Apprised_by.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_username^"+Apprised_by);	
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("username",correctNull((String)rs.getString("username")));
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			HashMap hshTemp =new HashMap();
			hshTemp.put("appno",strappno);	
			hshRecord.put("appno",strappno);
			hshRecord.put("vecReport",vecReport);
			hshRecord.put("filesuccess",hshValues.get("filesuccess"));
			hshRecord.put("Label",Label);
			hshRecord.put("hidvalue",Helper.correctNull((String)hshValues.get("hidvalue")));
						
			if(strAction.equalsIgnoreCase("READ SCORING"))
			{			
				hshram =new HashMap();
				hshram=(HashMap)EJBInvoker.executeStateLess("RAMTOLAPS",hshValues,"ramtolaps_retailscoring");
				READSENT_FLAG=Helper.correctNull((String)hshram.get("READSENT_FLAG"));
				hshram.put("ram","ram");
			}
			if(strAction.equalsIgnoreCase("WRITE SCORING"))
			{			
				hshram1 =new HashMap();
				if(strhidPROD.equalsIgnoreCase("EDU"))
				{
					 hshram1=(HashMap)EJBInvoker.executeStateLess("LapsToRam",hshValues,"createELoanModelFlatFile");
					 SENT_FLAG=Helper.correctNull((String)hshram1.get("SENT_FLAG"));
					 PROPERTY_FLAG=Helper.correctNull((String)hshram1.get("propertyflag"));
				}
				else if(strhidPROD.equalsIgnoreCase("CUS"))
				{
					 hshram1=(HashMap)EJBInvoker.executeStateLess("LapsToRam",hshValues,"createRCustomerFlatFile");
					 SENT_FLAG=Helper.correctNull((String)hshram1.get("SENT_FLAG"));
					 PROPERTY_FLAG=Helper.correctNull((String)hshram1.get("propertyflag"));
				}
			}
			if(rs !=null)
			{rs.close();}
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
			strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
			if(rs !=null)
			{rs.close();}
			if(prd_type!="" && prd_type.charAt(0)=='a')
			{
				// this calculation for eligible loan amount
				String costofproject="",min_margin="",subsidy_amt="",sub_check="",amt_request="",govt_scheme="";
				
				if(rs !=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+strappno);
				if(rs.next())
				strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+strappno);

				}
				else
				{
					rs=DBUtils.executeLAPSQuery("pergetloanProduct^"+strappno);
				}
				if (rs.next())
				{
					costofproject=Helper.correctNull((String)rs.getString("cloanprd"));
					min_margin=Helper.correctNull((String)rs.getString("downpay"));
					subsidy_amt=Helper.correctNull((String)rs.getString("loan_sub"));
					sub_check=Helper.correctNull((String)rs.getString("loan_govt"));
					amt_request=Helper.correctNull((String)rs.getString("amtreqd"));
				    govt_scheme=Helper.correctNull((String)rs.getString("govt_scheme"));
				}
				
				double dblcostofproject=0.00,dblmin_margin=0.00,dblsubsidy_amt=0.00,eliB=0.00,amt_cal1=0.00,amt_cal2=0.00,
				eliA=0.00,eliAmount=0.00;
				dblcostofproject=Double.parseDouble(costofproject);
				dblmin_margin=Double.parseDouble(min_margin);
				if(!subsidy_amt.equalsIgnoreCase(""))
				{
					dblsubsidy_amt=Double.parseDouble(subsidy_amt);
				}
				else
				{
					dblsubsidy_amt=0.0;
				}
				eliB=Double.parseDouble(amt_request);
				
				amt_cal1=dblcostofproject-dblmin_margin;
				
				if(!sub_check.equalsIgnoreCase("2"))
				{
					amt_cal2=dblcostofproject-dblsubsidy_amt;
				}
				else
				{
					amt_cal2=dblcostofproject;
				}
				if(amt_cal1<=amt_cal2)
				{
					eliA=amt_cal2;
				}
				else if(amt_cal1>=amt_cal2)
				{
					eliA=amt_cal1;
				}
				if(eliA<=eliB)
				{
					eliAmount=eliA;
				}
				else if(eliA>=eliB)
				{
					eliAmount=eliB;
				}
				hshRecord.put("eliAmount",Helper.formatDoubleValue(eliAmount));
				
				
				strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+strappno+"^"+prd_type);			
				rs1 =DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					
					hshRecord.put("loanamount_check",correctNull((String)rs1.getString("loanamount")));
					
				}
			}	
			
			/*rs = DBUtils.executeLAPSQuery("agr_appraisal_sel_loandetail^" +strappno);
			if (rs.next())
			{

				hshRecord.put("txt_loanamount",correctNull((String)rs.getString("loan_recmdamt")));
			}*/
			
			

			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strModifyterms", "@"+Helper.correctNull(rs.getString("ps_modify_terms")));
			}
			
			hshRecord.put("strProdPurpose", strProdPurpose);
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_deviated_interest^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("dblDevIntRate", Helper.correctNull(rs.getString("deviation_newvalue")));
			}
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_edu_loan^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("eduDetails","Y");
			}
			if(rs!=null) rs.close();
			rs=DBUtils.executeLAPSQuery("appraisalprint1^"+strappno);
			if(rs.next())
			{	
				hshRecord.put("strVehDetails","Y");
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_ddr_generalinfo^"+ strappno);
			if(!rs.next())
			{
				hshRecord.put("strDDRGeneralInfo","N");
			}
			//for mis check
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_misappdetails^"+ strappno+"^"+"1");
			if(rs.next())
			{
				hshRecord.put("MisDetails_check","Y");
			}
			
			//source of margin check
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("persourceofmargin_sel^"+ strappno);
			if(rs.next())
			{
				hshRecord.put("per_margin_total_fund", Helper.correctDouble(rs.getString("per_margin_total_fund")));
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selperprdmargin^"+ strappno);
			if(rs.next())
			{
				hshRecord.put("loan_costloanprd", Helper.correctDouble(rs.getString("loan_costloanprd")));
			}
			
			//Added by Sunil
			
			if(rs!=null)
				rs.close();
		
		strQuery=SQLParser.getSqlQuery("sel_doc_branchdet^"+strappno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{				
			hshRecord.put("DIGI_DEVIATION_ROI_CONC",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_CONC")));	
			hshRecord.put("DIGI_DEVIATION_ROI_PENALTY",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_PENALTY")));
		}
		
		
		if(rs!=null)
			rs.close();
		
		
		rs = DBUtils.executeLAPSQuery("selloan_details^" + strappno);
		if (rs.next()) {
			staffproduct = correctNull(rs.getString("prd_staffprd"));
			
		}
		hshRecord.put("staffproduct",staffproduct );
		
		
		strQuery = SQLParser.getSqlQuery("sel_branchname^"+ strappno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
			strPrdcode = Helper.correctNull(rs.getString("app_prdcode"));
		}
		
		if (staffproduct.equalsIgnoreCase("Y")) {
			hshRecord.put("WhetherEMI", "No");
			if (rs1 != null)
				rs1.close();
			ArrayList arrROI = new ArrayList();
			rs = DBUtils.executeLAPSQuery("rulechoice^fixed^" + strPrdcode+"^O");
			while (rs.next()) {
				rs1 = DBUtils.executeLAPSQuery("ruleresult^"+ Helper.correctInt(rs.getString("prdint_sno")));
				while (rs1.next()) {
					arrayCol = new ArrayList();
					arrayCol.add(correctNull(rs.getString("prd_amtrangefrom")));
					arrayCol.add(correctNull(rs.getString("prd_amtrangeto")));
					arrayCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("prd_baserate")))+Double.parseDouble(Helper.correctDouble(rs1.getString("prd_adjust")))));
					arrROI.add(arrayCol);
				}

			}
			hshRecord.put("arrROI", arrROI);
		
		}
				
		String strIntType="",strPassCode="";
		strQuery = SQLParser.getSqlQuery("selLoanAmt^" + strappno);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			 strIntType= Helper.correctNull(rs.getString("loan_inttype"));
		}
		hshRecord.put("strIntType", Helper.correctNull(rs.getString("loan_inttype")));
		
		
		if (strProdPurpose.equalsIgnoreCase("H")|| strProdPurpose.equalsIgnoreCase("U")|| strVehicleType.equalsIgnoreCase("2")) {
			strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^"+ strappno);
		} else {
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+ strappno);
		}
		if (rs != null) {
			rs.close();
		}
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
		if (!staffproduct.equalsIgnoreCase("Y")&& strIntType.equalsIgnoreCase("Floating")) {
			
			String strTemp = Helper.correctNull(rs.getString("loan_mclrtype"));
			if (!strTemp.equalsIgnoreCase("")) {
				String[] strArr = strTemp.split("@");
				if (strArr.length > 1) {
					
					if (rs3 != null)
						rs3.close();
					rs3 = DBUtils.executeLAPSQuery("selcbsiddatadesc^34^"+ strArr[0]);
					if (rs3.next()) {
						strTemp = Helper.correctNull(rs3.getString("cbs_static_data_desc"));
						strPassCode=Helper.correctNull(rs3.getString("cbs_static_data_passing_code"));
					}
					if(strPassCode.equalsIgnoreCase("O")){
					hshRecord.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%" + "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Bussiness strategic Premium)"
							+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
					}else{
						hshRecord.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%"+ "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Fixed Spread)"
								+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
					}
						
				} else {
					hshRecord.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
				}

			} else {
				hshRecord.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
			}

		} else {
			hshRecord.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
		}
		
		}
		if(rs!=null){
			rs.close();
		}
		String strLARorgcode = "";
		String livedate=ApplicationParams.getStrCLPHdate();
		String postsanctionflag="";
		String applicationStatus="";
		// check when application is created
		String appcreatedate="";
		
			strQuery = SQLParser.getSqlQuery("getcreatedate^"+strappno);
			rs5= DBUtils.executeQuery(strQuery);
			if (rs5.next()){
				
				appcreatedate= rs5.getString("createddate");
				applicationStatus= rs5.getString("APP_STATUS");
			}
			System.out.println("Application created date-->"+appcreatedate);
			System.out.println("Sanction  Live Date-->"+livedate);
	       if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
			 String Pattern="dd/MM/yyyy";
				DateFormat df=new SimpleDateFormat(Pattern);
				Date appcreationdate=df.parse(appcreatedate);
				Date postsanclivedate=df.parse(livedate);

				if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
				{
					hshRecord.put("clphchk","Y");	
				}
	       }
		}
			
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in getloandetails "+ce.toString());
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		hshRecord.put("hshram",hshram);
		hshRecord.put("SENT_FLAG",SENT_FLAG);
		hshRecord.put("READSENT_FLAG",READSENT_FLAG);
		hshRecord.put("PROPERTY_FLAG",PROPERTY_FLAG);
		
		return hshRecord;	
	}
	
	public HashMap updateDataQuest(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();		 
		ResultSet rs = null;
		try 
		{ 
			int intUpdatesize = 0;	
			intUpdatesize=intUpdatesize+1;				
			hshqueryval.put("1",hshQry);
			hshQry = new HashMap();
			arrVal = new ArrayList();
			intUpdatesize=intUpdatesize+1;	
			hshQry.put("arrValues",arrVal);
			hshQry.put("strQueryId","Upd_globalparameters");
			hshqueryval.put("size","1");
			hshqueryval.put("1",hshQry);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			hshqueryval = getDataQuestParameters(hshqueryval);
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured"+e.getMessage());
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
		return hshqueryval;
	}
	
	public HashMap getDataQuestParameters(HashMap hshValues)  
	{ 
		double dblnetTradeIn = 0.0;
		double dblTradeIn = 0.0;
		double dblloanTradeIn = 0.0;
		double dblloanValratio = 0.0;
		double dblamtRequested = 0.0;
		double dblcostLoanPrd = 0.0;
		double dbldownPay = 0.0;
		double dblAloanValratio = 0.0;
		double dblamtRecommended = 0.0;
		String strPrdCode = "" ;
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();	
		ArrayList vecData = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData2=new ArrayList();
		ArrayList vecRec2=new ArrayList();
		String strAction="",strQuery="";	
		String strappno="";
		
		String costofproject="";
		String min_margin="";
		String subsidy_amt="";
		String sub_check="";
		String amt_request="";
		String govt_scheme="";
		
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		int val=0;
		
		
		double dblcostofproject=0.0;
		double dblmin_margin=0.0;
		double dblsubsidy_amt=0.0;
		double eliA=0.0;
		double eliB=0.0;
		double eliAmount=0.0;
		
		double amt_cal1=0.0;
		double amt_cal2=0.0;
		
		int vecsize=0;
		int vecsize1=0;
		 strPrdCode = Helper.correctNull((String)hshValues.get("strprdcode"));
 		if(strPrdCode.equals(""))
 		{
 			strPrdCode = Helper.correctNull((String)hshValues.get("prdcode"));
 		}
 		String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
 	
		try 
		{ 
			strAction ="select";
			String appno="";
			String prdcode="";
			if(appno.equalsIgnoreCase("")){
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")){
				appno=Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("appname", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="",strVehicleType="";
			rs=DBUtils.executeLAPSQuery("selprodpurpose^"+appno);
			if(rs.next()){
				strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));
				}
			/*
			 * 			For Purchase of Ready Built House and Used Vehicle loan, 
			 * 				Margin is based on age of the building / vehicle respectively
			 */
			if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
			{
				rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+appno);
			}
			else if(prd_type.equalsIgnoreCase("pI"))
			{
				rs = DBUtils.executeLAPSQuery("pergetloanProductInstaCash^" + appno);
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("pergetloanProduct^"+appno);
			}
			
			while (rs.next())
			{
					
				hshRecord.put("appno", correctNull((String)rs.getString("appno")));
				hshRecord.put("status", correctNull((String)rs.getString("status")));
				hshRecord.put("aname", correctNull((String)rs.getString("aname")));
				hshRecord.put("appid", correctNull((String)rs.getString("appid")));
				hshRecord.put("category", correctNull((String)rs.getString("category")));
				hshRecord.put("subcategory", correctNull((String)rs.getString("subcategory")));
				hshRecord.put("rfrom", correctNull((String)rs.getString("rfrom")));
				hshRecord.put("rangeto", correctNull((String)rs.getString("rangeto")));
				strPrdCode = correctNull((String)rs.getString("prdcode"));
				hshRecord.put("prdcode", strPrdCode);
				hshRecord.put("mintrate", correctNull((String)rs.getString("mintrate")));
				hshRecord.put("lterms", correctNull((String)rs.getString("lterms")));
				hshRecord.put("amtreqd", correctNull((String)rs.getString("amtreqd")));
				hshRecord.put("cloanprd", correctNull((String)rs.getString("cloanprd")));
				hshRecord.put("tradein", correctNull((String)rs.getString("tradein")));
				hshRecord.put("loantrade", correctNull((String)rs.getString("loantrade")));
				hshRecord.put("staff_flag", correctNull((String)rs.getString("indinfo_is_staff")));
				hshRecord.put("PrincipalRatio",correctNull((String)rs.getString("prd_principal")));
				hshRecord.put("InterestRatio",correctNull((String)rs.getString("prd_interest")));
				hshRecord.put("monthpay", correctNull((String)rs.getString("loan_emi")));  //MODIFIED to retrieve EMI from table itself
				hshRecord.put("InterestEMI", correctNull((String)rs.getString("loan_interest_emi")));
				hshRecord.put("loan_govt", correctNull((String)rs.getString("loan_govt")));
				hshRecord.put("app_processdate",correctNull((String)rs.getString("app_processdate")));
				hshRecord.put("loanfiledon", correctNull((String)rs.getString("loan_filedon")));
				
				if (!correctNull((String)rs.getString("loan_margin")).trim().equals(""))
				

				{
					hshRecord.put("margin_perct", correctNull((String)rs.getString("loan_margin")));
					dblloanValratio = rs.getDouble("loan_margin");
				}

				String strabc = Helper.correctNull((String)rs.getString("tradein"));
				if (strabc.equals(""))
				{
					strabc = "0.00";
				}
				dblTradeIn = Double.parseDouble(strabc);
				String strabc1 = correctNull((String)rs.getString("loantrade"));
				if (strabc1.equals(""))
				{
					strabc1 = "0.00";
				}
				dblloanTradeIn = Double.parseDouble(strabc1);
				dblnetTradeIn = dblTradeIn - dblloanTradeIn;
				hshRecord.put("netTradein", correctNull(Helper.formatDoubleValue(dblnetTradeIn)));
				dblamtRequested = Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd")));
				dblcostLoanPrd = Double.parseDouble(Helper.correctDouble(rs.getString("cloanprd")));

				if (dblcostLoanPrd == dblamtRequested)
				{
					if (dblnetTradeIn == 0.0)
					{
						dbldownPay = dblamtRequested - (dblamtRequested * dblloanValratio / 100);
						dblAloanValratio = dblloanValratio;
					}
					else
					{
						dbldownPay = (dblamtRequested - (dblamtRequested * dblloanValratio / 100)) + dblnetTradeIn;
						dblAloanValratio = ((dblamtRequested - dbldownPay) / dblamtRequested) * 100;
					}
					dblamtRecommended = dblAloanValratio * dblamtRequested / 100;
				}
				else if (dblcostLoanPrd > dblamtRequested)
				{
					double dblcostloan = (dblcostLoanPrd * dblloanValratio / 100);
					if (dblcostloan < dblamtRequested)
					{
						dblamtRecommended = dblcostloan;
						dbldownPay = (dblcostLoanPrd - dblamtRecommended) + dblnetTradeIn;
					}
					else
					{
						dblamtRecommended = dblamtRequested;
						dbldownPay = (dblcostLoanPrd - dblamtRecommended) + dblnetTradeIn;
					}
					if (dblnetTradeIn > 0)
					{
						dblamtRecommended = dblamtRecommended - dblnetTradeIn;
					}
					dblAloanValratio = ((dblcostLoanPrd - dbldownPay) / dblcostLoanPrd) * 100;
				}
				
					hshRecord.put("lreqterms", correctNull((String)rs.getString("lreqterms")));
					String loan_receivedate = Helper.correctNull((String)rs.getString("loan_receivedate"));

				if (loan_receivedate.equalsIgnoreCase("01/01/1900"))
				{
					hshRecord.put("loan_receivedate", "");
				}
				else
				{
					hshRecord.put("loan_receivedate", loan_receivedate);
				}
				hshRecord.put("perapp_salaryrouted", Helper.correctNull((String) rs.getString("perapp_salaryrouted")));
				hshRecord.put("measurementtype", Helper.correctNull((String)rs.getString("LAND_MEASUREMENT")));
				hshRecord.put("govt_scheme", Helper.correctNull((String)rs.getString("govt_scheme")));
				hshRecord.put("loan_annualincome", Helper.correctNull((String)rs.getString("loan_annualincome")));
				
				prdcode=Helper.correctNull((String)rs.getString("prdcode"));
				// Calculation for eligible loan amount
				costofproject=Helper.correctNull((String)rs.getString("cloanprd"));
				min_margin=Helper.correctNull((String)rs.getString("downpay"));
				subsidy_amt=Helper.correctNull((String)rs.getString("loan_sub"));
				sub_check=Helper.correctNull((String)rs.getString("loan_govt"));
				amt_request=Helper.correctNull((String)rs.getString("amtreqd"));
			    govt_scheme=Helper.correctNull((String)rs.getString("govt_scheme"));
			}
			
			dblcostofproject=Double.parseDouble(costofproject);
			dblmin_margin=Double.parseDouble(Helper.correctDouble(min_margin));
			if(!subsidy_amt.equalsIgnoreCase(""))
			{
				dblsubsidy_amt=Double.parseDouble(subsidy_amt);
			}
			else
			{
				dblsubsidy_amt=0.0;
			}
			eliB=Double.parseDouble(amt_request);
			
			amt_cal1=dblcostofproject-dblmin_margin;
			
			if(!sub_check.equalsIgnoreCase("2"))
			{
				amt_cal2=dblcostofproject-dblsubsidy_amt;
			}
			else
			{
				amt_cal2=dblcostofproject;
			}
			if(amt_cal1<=amt_cal2)
			{
				eliA=amt_cal2;
			}
			else if(amt_cal1>=amt_cal2)
			{
				eliA=amt_cal1;
			}
			if(eliA<=eliB)
			{
				eliAmount=eliA;
			}
			else if(eliA>=eliB)
			{
				eliAmount=eliB;
			}
			hshRecord.put("eliAmount",Helper.formatDoubleValue(eliAmount));
			
			if(rs!=null)
			{
				rs.close(); 
			}
			
			//vecsize1=vecData.size();
			String data_Flag="";
			if(strAction.equals("select"))
			{			
				if((strappno.equalsIgnoreCase("null"))||(strappno.equals("")))
				{
					strappno = Helper.correctNull((String)hshValues.get("appno"));
				}
				if((strappno.equalsIgnoreCase("null"))||(strappno.equals("")))
				{
					strappno = Helper.correctNull((String)hshValues.get("strappno"));
				}
				
				//to get data from application level
				 arrRow=new ArrayList();
				 arrCol=new ArrayList();
				
				 if(Helper.correctNull((String)hshRecord.get("app_status")).equalsIgnoreCase("pa"))
					 strQuery=SQLParser.getSqlQuery("sel_appraisalQuest3^"+strappno+"^"+prdcode);
				 else
					 strQuery=SQLParser.getSqlQuery("sel_appraisalQuest^"+strappno+"^"+prdcode);
				 rs1=DBUtils.executeQuery(strQuery);
				if (rs1.next()) 
				{
					do
					{
					arrCol=new ArrayList();
					arrCol.add(correctNull((String)rs1.getString("GENE_SLNO")));//0
					arrCol.add(correctNull((String)rs1.getString("GENE_QUESTION")));//1
					arrCol.add(correctNull((String)rs1.getString("Ques_Flag")));//2
					arrCol.add(correctNull((String)rs1.getString("Remarks")));//3
					arrRow.add(arrCol);	
					}while(rs1.next());
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("sel_appconfparamerters^"+prdcode);			 
					while (rs.next()) 
					{				
						arrCol=new ArrayList();
						arrCol.add(correctNull((String)rs.getString("gene_slno")));
						arrCol.add(correctNull((String)rs.getString("gene_question")));
						arrCol.add("");
						arrCol.add("");
						arrRow.add(arrCol);				
					}
				}
			}		
			//String str=Integer.toString(vecsize);
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strappno",strappno);
			//hshRecord.put("str",str);
			//hshRecord.put("vecData",vecData);
			
			 /***********************starts AgriGuarantor Details*************************/
			ArrayList vecCoapp12=new ArrayList();
			ArrayList vecReport12=new ArrayList();
			String strType="",strId="",strName="",strFatherName="";
			rs=DBUtils.executeLAPSQuery("appreport_gua^"+strappno);
			 
			while(rs.next())
			{				
				vecCoapp12=new ArrayList();
				strType=correctNull((String)rs.getString("demo_type"));
			
				strId=strType+correctNull((String)rs.getString("demo_appid"));
				
				if (strType.trim().equalsIgnoreCase("g"))
				{
					strType="Guarantor";
				}
				if (strType.trim().equalsIgnoreCase("o"))
				{
					strType="Co-Obligant";
				}
				
				 vecCoapp12.add(strType);
				strName=correctNull((String)rs.getString("coappname"));
				strFatherName=correctNull((String)rs.getString("perapp_fatname"));
				vecCoapp12.add(strName);
				vecCoapp12.add(strFatherName);
				
				vecReport12.add(vecCoapp12);
			}
			hshRecord.put("vecReport12",vecReport12);
			strQuery = SQLParser.getSqlQuery("agr_sel_bullockrepay^"+appno+ "^" +prd_type);			
			rs1 =DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				hshRecord.put("txt_holiday",correctNull((String)rs1.getString("bullock_holiday")));
				hshRecord.put("sel_payment",correctNull((String)rs1.getString("bullock_payment")));
				hshRecord.put("txt_installment",correctNull((String)rs1.getString("bullock_installment")));
				hshRecord.put("txt_date",correctNull((String)rs1.getString("bullock_date")));
				hshRecord.put("txt_lastinstallment",correctNull((String)rs1.getString("bullock_lastinstallment")));
				hshRecord.put("txt_loanamount",correctNull((String)rs1.getString("loanamount")));
				hshRecord.put("txt_farmdate",correctNull((String)rs1.getString("agr_farmdate")));
				hshRecord.put("txt_hypo",correctNull((String)rs1.getString("agr_hypo")));
				hshRecord.put("sel_insurance",correctNull((String)rs1.getString("agr_insurance")));
				hshRecord.put("sel_sec1",correctNull((String)rs1.getString("agr_security1")));
				hshRecord.put("sel_sec2",correctNull((String)rs1.getString("agr_security2")));
				hshRecord.put("sel_sec3",correctNull((String)rs1.getString("agr_security3")));
				hshRecord.put("txt_securityval1",correctNull((String)rs1.getString("agr_securityval1")));
				hshRecord.put("txt_securityval2",correctNull((String)rs1.getString("agr_securityval2")));
				hshRecord.put("txt_securityval3",correctNull((String)rs1.getString("agr_securityval3")));
				hshRecord.put("auditFlag", "Y");
			}
			
			
			rs = DBUtils.executeLAPSQuery("securesel^" +appno);
			if (rs.next())
			{
				hshRecord.put("loan_noofinstallment", Helper.correctNull((String)rs.getString("loan_noofinstallment")));
				hshRecord.put("loan_periodicity", correctNull((String)rs.getString("loan_periodicity")));
				hshRecord.put("loan_secure", correctNull((String)rs.getString("loan_secure")));
				hshRecord.put("loan_secureamount", correctNull((String)rs.getString("loan_secureamount")));
				hshRecord.put("loan_servised", correctNull((String)rs.getString("loan_servised")));
			}
			
			if(!govt_scheme.equalsIgnoreCase(""))
			{
			rs = DBUtils.executeLAPSQuery("getstatdatavalue^" +11+"^" + govt_scheme);
			if (rs.next())
			{
				hshRecord.put("stat_data_sno", Helper.correctNull((String)rs.getString("stat_data_sno")));
				hshRecord.put("stat_data_desc", correctNull((String)rs.getString("stat_data_desc")));
			}
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
				if (rs1!= null) 
				{
					rs1.close();
				}
			} 			
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}

	public HashMap getDataQuest(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecRec1 = new ArrayList();
		ArrayList vecData2=new ArrayList();; 
		ArrayList vecRec2=new ArrayList();; 
		String strAction=null;	
		String strappno="";
		int vecsize=0;
		
		try 
		{ 
			String []strOption=null;
			strAction ="select";
			if((String)hshValues.get("sel_option") instanceof java.lang.String)
			{
				strOption[0]=(String)hshValues.get("sel_option");
			}
			else
			{
				strOption=(String[])hshValues.get("sel_option");
			}
			strappno = Helper.correctNull((String)hshValues.get("appno"));	
			if((strappno==null)||(strappno==""))
			{
				strappno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			rs=DBUtils.executeLAPSQuery("sel_appconfparamerters");			 
			vecData=new ArrayList();
			while (rs.next()) 
			{				
				vecRec1=new ArrayList();
				vecRec1.add(correctNull((String)rs.getString("STAT_DATA_SNO")));
				vecRec1.add(correctNull((String)rs.getString("STAT_DATA_DESC")));
				vecData.add(vecRec1);
			}
			if(strAction.equals("select"))
			{
				rs=DBUtils.executeLAPSQuery("sel_appraisalQuest2^"+strappno);
				vecRec2=new ArrayList();
				vecData2=new ArrayList();
				while (rs.next()) 
				{
					vecRec2=new ArrayList();
				    vecRec2.add(correctNull((String)rs.getString("Ques_Flag")));
					vecRec2.add(correctNull((String)rs.getString("Remarks")));
					vecData2.add(vecRec2);
				}
				vecsize=vecData2.size();
				String str=Integer.toString(vecsize);
				hshRecord.put("vecData2",vecData2);
				hshRecord.put("strappno",strappno);
				hshRecord.put("str",str);
				hshRecord.put("vecData",vecData);
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}		
		return hshRecord;
	}	
		
	public void updateDataQuestParameters(HashMap hshValues)  
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshquery2 = new HashMap();
		ArrayList arrValues ;		 
		ResultSet rs=null;
		String strAction="";			
		String strappno="";	
        String prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
        StringBuilder sbOldAudit = new StringBuilder();
        String strQuery="";
        ArrayList arrRow=new ArrayList();
        ArrayList arrCol=new ArrayList();
        ArrayList arrRow1=new ArrayList();
        ArrayList arrCol1=new ArrayList();
        ArrayList arrOldAudit=new ArrayList();
        ArrayList arrOldAudit1=new ArrayList();
        ArrayList arrVal=new ArrayList();
		try
		{ 
			String []strOption=null;
			 String []sl_no=null;
			String []strDet=null;
			int intUpdatesize = 0;	
			
			String sel_sec1=Helper.correctNull((String)hshValues.get("sel_sec1"));;
			String sel_sec2=Helper.correctNull((String)hshValues.get("sel_sec2"));;
			String sel_sec3=Helper.correctNull((String)hshValues.get("sel_sec3"));;
			String txt_hypo2=Helper.correctNull((String)hshValues.get("txt_hypo2"));;
			String txt_hypo3=Helper.correctNull((String)hshValues.get("txt_hypo3"));;
			
			intUpdatesize=intUpdatesize+1;	
			strAction =correctNull((String)hshValues.get("hidAction"));
			if(hshValues.get("txt_staticdataid") instanceof java.lang.String){
				sl_no= new String[1];
				sl_no[0]=(String)hshValues.get("txt_staticdataid");
			}else{
				sl_no=(String[])hshValues.get("txt_staticdataid");
			}
			if(hshValues.get("sel_option") instanceof java.lang.String){
				strOption= new String[1];
				strOption[0]=(String)hshValues.get("sel_option");
			}else{
			strOption=(String[])hshValues.get("sel_option");
			}
			if(hshValues.get("txt_comments") instanceof java.lang.String){
				strDet= new String[1];
				strDet[0] = (String)hshValues.get("txt_comments");	
			}else{
				strDet = (String[])hshValues.get("txt_comments");	
			}
				
			strappno = Helper.correctNull((String)hshValues.get("appno"));	
			if(strappno.equals("") || strappno.equals("null"))
			{
				strappno = Helper.correctNull((String)hshValues.get("strappno"));	
			}
			int len=strOption.length;
			String strAction1="";
			
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
			 */
			String strPrdCode=Helper.correctNull((String)hshValues.get("prdcode"));
			strQuery=SQLParser.getSqlQuery("sel_appconfparamerters^"+strPrdCode);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("gene_slno")));
				arrCol.add(Helper.correctNull((String)rs.getString("gene_question")));
				arrRow.add(arrCol);
			}
			strQuery=SQLParser.getSqlQuery("sel_appraisalQuest2^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol1=new ArrayList();
				arrCol1.add(Helper.correctNull((String)rs.getString("Ques_Flag")));
				arrCol1.add(Helper.correctNull((String)rs.getString("Remarks")));
				arrRow1.add(arrCol1);
			}
			if((arrRow.size()==arrRow1.size())&&(arrRow!=null)&&(arrRow.size()>0))
			{
				for(int i=0;i<arrRow.size();i++)
				{
					arrOldAudit=new ArrayList();
					arrOldAudit=(ArrayList)arrRow.get(i);
					arrOldAudit1=(ArrayList)arrRow1.get(i);
					String strValOldAudit=Helper.correctNull((String)arrOldAudit1.get(0));
					String strValDescOldAudit="";
					if(strValOldAudit.equalsIgnoreCase("1"))
					{
						strValDescOldAudit="Yes";
					}
					else if(strValOldAudit.equalsIgnoreCase("2"))
					{
						strValDescOldAudit="No";
					}
					else if(strValOldAudit.equalsIgnoreCase("3"))
					{
						strValDescOldAudit="Not Applicable";
					}
					sbOldAudit.append("~Appraisal = ").append(Helper.correctNull((String)arrOldAudit.get(0))).append(".").append(Helper.correctNull((String)arrOldAudit.get(1)))
					.append("~Value = ").append(strValDescOldAudit).append("~Remarks = ").append(Helper.correctNull((String)arrOldAudit1.get(1)));
				}
			}
			/***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","del_appraisalQuest");		
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				//hshQuery.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for(int k=0;k<len;k++)
				{
					hshQuery.put("strQueryId","ins_app_test");
					arrValues=new ArrayList();				
					arrValues.add(strappno);
					arrValues.add(strOption[k]);
					arrValues.add(strDet[k]);
					arrValues.add(sl_no[k]);	
					hshQuery.put("arrValues",arrValues);					
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					hshquery2.put("appno",strappno);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}	
				strAction1="insert";
			}
			String  txt_holiday="",sel_payment="",txt_installment="",txt_date="";
			String txt_loanamount="",txt_farmdate="",txt_hypo="",sel_insurance="";
			
			 arrValues=new ArrayList();
			if(strAction1.equals("insert") && prd_type.startsWith("a"))
			{
				intUpdatesize=0;
				arrValues = new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","agr_del_bullockrepay");
				arrValues.add(strappno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
		        hshQuery = new HashMap();
				arrValues = new ArrayList();
				intUpdatesize=intUpdatesize+1;
				arrValues.add(strappno);
				txt_holiday= Helper.correctNull((String)hshValues.get("txt_holiday"));
				sel_payment= Helper.correctNull((String)hshValues.get("hidpayment"));
				txt_installment = Helper.correctNull((String)hshValues.get("txt_installment"));
				txt_date = Helper.correctNull((String)hshValues.get("txt_date"));
				txt_loanamount= Helper.correctNull((String)hshValues.get("txt_loanamount"));
				txt_farmdate = Helper.correctNull((String)hshValues.get("txt_farmdate"));
				txt_hypo= Helper.correctNull((String)hshValues.get("txt_hypo"));
				sel_insurance= Helper.correctNull((String)hshValues.get("sel_insurance"));
				
				arrValues.add("");
				
				if(txt_holiday.equalsIgnoreCase(""))
				{	
					txt_holiday="0";
				}
				arrValues.add(txt_holiday);
				
				if(sel_payment.equalsIgnoreCase(""))
				{	
					sel_payment ="1";
				}
				arrValues.add(sel_payment);
									
				if(txt_installment.equalsIgnoreCase(""))
				{	
					txt_installment="0.00";
				}
				arrValues.add(txt_installment);
				
				arrValues.add(txt_date);
				
				arrValues.add("0.00");		
				arrValues.add(prd_type);
				arrValues.add(txt_loanamount);
				arrValues.add(txt_farmdate);
				arrValues.add(txt_hypo);
				arrValues.add(sel_insurance);
				arrValues.add(sel_sec1);
				arrValues.add(sel_sec2);
				arrValues.add(sel_sec3);
				arrValues.add(txt_hypo);
				arrValues.add(txt_hypo2);
				arrValues.add(txt_hypo3);
				
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_bullockrepay");
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			}
			if(strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				hshQuery.put("strQueryId","agr_del_bullockrepay");		
				arrValues.add(strappno);
				arrValues.add(prd_type);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				
				hshQuery=new HashMap();				
				arrValues=new ArrayList();	
				intUpdatesize++;
				hshQuery.put("strQueryId","del_date");		
				arrValues.add(strappno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			StringBuilder sbAuditTrial=new StringBuilder();
			if(strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update"))
			{
			/*sbAuditTrial.append(
			"~Recommendations of the Appraising Officer: ^").append(
			"~The relevant Land record/documents have been obtained and verified and found correct.The farm was visited by me on  = ").append(correctNull((String )hshValues.get("txt_farmdate"))).append(
			"~Loan Recommended = ").append(correctNull((String )hshValues.get("txt_loanamount"))).append(
			"~Security Proposed = ").append(ApplicantParams.getApplicantParams("AgricultureConfirmation",correctNull((String )hshValues.get("sel_sec1"))))
			.append(" ").append(correctNull((String )hshValues.get("txt_hypo"))).append(
			"~Security Proposed = ").append(ApplicantParams.getApplicantParams("AgricultureConfirmation",correctNull((String )hshValues.get("sel_sec2"))))
			.append(" ").append(correctNull((String )hshValues.get("txt_hypo2"))).append(
			"~Security Proposed = ").append(ApplicantParams.getApplicantParams("AgricultureConfirmation",correctNull((String )hshValues.get("sel_sec3"))))
			.append(" ").append(correctNull((String )hshValues.get("txt_hypo3"))).append(
			"~Insurance wherever applicable: = ").append(ApplicantParams.getApplicantParams("PresenceGurantor",correctNull((String )hshValues.get("sel_insurance"))));*/
				if((arrRow!=null)&&(arrRow.size()>0))
				{
					for(int j=0;j<arrRow.size();j++)
					{
						String strVal=strOption[j];
						String strValDesc="";
						if(strVal.equalsIgnoreCase("1"))
						{
							strValDesc="Yes";
						}
						else if(strVal.equalsIgnoreCase("2"))
						{
							strValDesc="No";
						}
						else if(strVal.equalsIgnoreCase("3"))
						{
							strValDesc="Not Applicable";
						}
						arrVal=new ArrayList();
						arrVal=(ArrayList)arrRow.get(j);
						sbAuditTrial.append("~Appraisal = ").append(arrVal.get(0)).append(".").append(arrVal.get(1))
						.append("~Value = ").append(strValDesc).append("~Remarks = ").append(strDet[j]);
					}
				}
			if(correctNull((String)hshValues.get("hidAuditFlag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "update");
			}
			else
			{
				hshValues.put("strAction", "insert");
			}
			}
			AuditTrial.auditNewLog(hshValues,"235",strappno,sbAuditTrial.toString(),sbOldAudit.toString());	
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
	
	public void updateAppraisalData(HashMap hshValues) 
	{	
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		HashMap hshRecord = new HashMap();		
		ArrayList arrValues=new ArrayList();		 
		ResultSet rs=null;
		boolean bstate;
		String strQuery="";
		String strAction="";
		String strappno ="";
		String strper_appid = "";
		String strPagename = "";
		String strComments = "";
		String strquestion1 = "";
		String strquestion2 = "";	
		String strquestion3 = "";
		String strquestion4 = "";
		String strquestion5 = "";
		String strquestion6 = "";
		String strquestion7 = "";
		String strsanction = "";
		String strsanctionref ="";
		try
		{ 			
			strAction = correctNull((String)hshValues.get("hidAction"));	
			strappno = correctNull((String)hshValues.get("appno"));	
			if(strappno.equals("") || strappno.equalsIgnoreCase("null"))
			{
				strappno = correctNull((String)hshValues.get("strappno"));	
			}
			strper_appid = correctNull((String)hshValues.get("chk_apptype"));
			int len =0;
			len = strper_appid.length();
			if(strper_appid!="")
			{
				strper_appid = strper_appid.substring(1,len);
			}
			else
			{
				strper_appid ="0";
			}
			strPagename = correctNull((String)hshValues.get("sel_comments"));	
			strComments = correctNull((String)hshValues.get("txt_comments"));		
			strquestion1 = correctNull((String)hshValues.get("sel_question1"));			
			strquestion2 = correctNull((String)hshValues.get("sel_question2"));
			strquestion3 = correctNull((String)hshValues.get("sel_question3"));
			strquestion4 = correctNull((String)hshValues.get("sel_question4"));
			strquestion5 = correctNull((String)hshValues.get("sel_question5"));
			strquestion6 = correctNull((String)hshValues.get("sel_question6"));
			strquestion7 = correctNull((String)hshValues.get("sel_question7"));
			strsanction=correctNull((String)hshValues.get("chk_sanction"));
			strsanctionref=correctNull((String)hshValues.get("chk_recombranch"));
			if(strAction.equals("Edit"))
			{	
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				if(strPagename.equalsIgnoreCase("BG") || strPagename.equalsIgnoreCase("IE") || strPagename.equalsIgnoreCase("SF") || strPagename.equalsIgnoreCase("ES") || strPagename.equalsIgnoreCase("CO") || strPagename.equalsIgnoreCase("RA"))
				{
					bstate=false;					
					strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal^"+strappno+"^"+strPagename+"^"+strper_appid);
					rs=DBUtils.executeQuery(strQuery);				
					bstate = rs.next();
					if(bstate)
					{
						hshQuery.put("strQueryId","upd_perapp_Apprisal");
						arrValues=new ArrayList();				 
						//arrValues.add(strappno);
						//arrValues.add(strper_appid);
						arrValues.add(strComments);
						arrValues.add(strPagename);
						arrValues.add(strquestion1);
						arrValues.add(strquestion2);
						arrValues.add(strquestion3);
						arrValues.add(strsanction);
						arrValues.add(strsanctionref);
						arrValues.add(strquestion4);
						arrValues.add(strquestion5);
						arrValues.add(strquestion6);
						arrValues.add(strquestion7);
						arrValues.add(strappno);
						arrValues.add(strper_appid);
						arrValues.add(strPagename);						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					else
					{
						hshQuery.put("strQueryId","ins_perapp_Apprisal");
						arrValues=new ArrayList();				 
						arrValues.add(strappno);
						arrValues.add(strper_appid);
						arrValues.add(strComments);
						arrValues.add(strPagename);
						arrValues.add(strquestion1);
						arrValues.add(strquestion2);
						arrValues.add(strquestion3);
						arrValues.add(strsanction);
						arrValues.add(strsanctionref);
						arrValues.add(strquestion4);
						arrValues.add(strquestion5);
						arrValues.add(strquestion6);
						arrValues.add(strquestion7);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			if(strAction.equals("Delete"))
			{
				hshQuery.put("strQueryId","del_perapp_Apprisal");
				arrValues=new ArrayList();				 
				arrValues.add(strappno);
				arrValues.add(strPagename);
				arrValues.add(strper_appid);
				
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			
			
			
			hshRecord.put("strper_appid",correctNull((String)hshValues.get("chk_apptype")));
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
	public void updatePresanction(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues=new ArrayList();		 
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strQuery="",strQuery1="";
		//String hidslno = correctNull((String)hshValues.get("hidsno"));
		String strGradeId =  correctNull((String )hshValues.get("sel_refno"));	
		String strExilimit =  correctNull((String )hshValues.get("sel_exilimit"));	
		
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAction1=Helper.correctNull((String)hshValues.get("hidAction1"));
		
		String strappno=Helper.correctNull((String)hshValues.get("strappno"));
		String strDate=Helper.correctNull((String)hshValues.get("txt_date"));
		String strFamdesc=Helper.correctNull((String)hshValues.get("txt_famdesc"));
		String	strPresentincome=Helper.correctNull((String)hshValues.get("txt_presentincome"));
		String	strOtherinfo=Helper.correctNull((String)hshValues.get("txt_otherinfo"));
		String	strLandparticulars=Helper.correctNull((String)hshValues.get("txt_landparticulars"));
		String	strWatersource=Helper.correctNull((String)hshValues.get("txt_watersource"));
		String	strAppliedamount=Helper.correctNull((String)hshValues.get("txt_appliedamount"));
		String strDetailscrops=Helper.correctNull((String)hshValues.get("txt_detailscrops"));
		String	strAapplicantasset=Helper.correctNull((String)hshValues.get("txt_applicantasset"));
		String	strLiabilities=Helper.correctNull((String)hshValues.get("txt_liabilities"));
		String	strSanctionrefno=Helper.correctNull((String)hshValues.get("txt_sanctionrefno"));;
		String	strSanctiondate=Helper.correctNull((String)hshValues.get("txt_sanctiondate"));
		String strLoansanction=Helper.correctNull((String)hshValues.get("txt_loansanction"));
		String strPurpose=Helper.correctNull((String)hshValues.get("txt_purpose"));
		String	strSanctionautho=Helper.correctNull((String)hshValues.get("txt_sanctionautho"));
		String	strLoanamount=Helper.correctNull((String)hshValues.get("txt_loanamount"));
		String	strDatedisbursed=Helper.correctNull((String)hshValues.get("txt_datedisbursed"));
		String	strAmountoutstanding=Helper.correctNull((String)hshValues.get("txt_amountoutstanding"));
		String strAmountoverdue=Helper.correctNull((String)hshValues.get("txt_amountoverdue"));
		String	strAccounttype=Helper.correctNull((String)hshValues.get("sel_accounttype"));
		String strDetailirrgular=Helper.correctNull((String)hshValues.get("txt_detailirrgular"));
		String	strTermcond=Helper.correctNull((String)hshValues.get("sel_accreg"));
		String strAppexpenses=Helper.correctNull((String)hshValues.get("txt_appexpenses"));
		String strComrecomd=Helper.correctNull((String)hshValues.get("txt_comrecomd"));
		String sel_borrower=Helper.correctNull((String)hshValues.get("sel_borrower"));
		String sel_map=Helper.correctNull((String)hshValues.get("sel_map"));
		String txr_east=Helper.correctNull((String)hshValues.get("txr_east"));
		String txr_west=Helper.correctNull((String)hshValues.get("txr_west"));
		String txr_north=Helper.correctNull((String)hshValues.get("txr_north"));
		String txr_south=Helper.correctNull((String)hshValues.get("txr_south"));
		String sel_construction=Helper.correctNull((String)hshValues.get("sel_construction"));
		String inspname=Helper.correctNull((String)hshValues.get("inspname"));
		String inspanumb=Helper.correctNull((String)hshValues.get("inspanumb"));
		String strinwardno=Helper.correctNull((String)hshValues.get("inwardno"));
		
		
		try
		{ 	
			String desc= "";
			StringBuilder strOldAudit = new StringBuilder();		
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));	
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				
				hshQueryValues.put("size","1");
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					hshQuery.put("strQueryId","delpresanctionbyinwardno"); 
					arrValues.add(strinwardno);
				}
				else
				{
					hshQuery.put("strQueryId","delpresanction"); 
					arrValues.add(strappno);
				}
				
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","inspresanction");
				
				arrValues.add(strappno);
				arrValues.add(strFamdesc);
				arrValues.add(strPresentincome);
				arrValues.add(strOtherinfo);
				arrValues.add(strLandparticulars);
				arrValues.add(strWatersource);
				arrValues.add(strAppliedamount);
				arrValues.add(strDetailscrops);
				arrValues.add(strAapplicantasset);
				arrValues.add(strLiabilities);
				
				arrValues.add(strAppexpenses);
				arrValues.add(strComrecomd);
				arrValues.add(strDate);
				
				arrValues.add(sel_borrower);
				arrValues.add(sel_map);
				arrValues.add(txr_east);
				arrValues.add(txr_west);
				arrValues.add(txr_north);
				arrValues.add(txr_south);
				arrValues.add(sel_construction);
				arrValues.add(strExilimit);
				arrValues.add(inspname);
				arrValues.add(inspanumb);
				
				arrValues.add(strinwardno);
				
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}	
			
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				 
				hshQuery=new HashMap();
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					hshQuery.put("strQueryId","updpresanctionbyinwardno"); 
				}
				else
				{
					hshQuery.put("strQueryId","updpresanction"); 
				}
				
				arrValues.add(strDate);
				arrValues.add(strFamdesc);
				arrValues.add(strPresentincome);
				arrValues.add(strOtherinfo);
				arrValues.add(strLandparticulars);
				arrValues.add(strWatersource);
				arrValues.add(strAppliedamount);
				arrValues.add(strDetailscrops);
				arrValues.add(strAapplicantasset);
				arrValues.add(strLiabilities);
				
				arrValues.add(strAppexpenses);
				arrValues.add(strComrecomd);
				arrValues.add(strDate);
				arrValues.add(sel_borrower);
				arrValues.add(sel_map);
				arrValues.add(txr_east);
				arrValues.add(txr_west);
				arrValues.add(txr_north);
				arrValues.add(txr_south);
				arrValues.add(sel_construction);
				arrValues.add(strExilimit);
				arrValues.add(inspname);
				arrValues.add(inspanumb);
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					arrValues.add(strinwardno);
				}
				else
				{
					arrValues.add(strappno);
				}
				
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
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					hshQuery.put("strQueryId","delpresanctionbyinwardno"); 
					arrValues.add(strinwardno);
				}
				else
				{
					hshQuery.put("strQueryId","delpresanction"); 
					arrValues.add(strappno);
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			String strStatId="";
			if(strAction1.equalsIgnoreCase("insert"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
		  		if(strGradeId.equalsIgnoreCase("0") && !strSanctionrefno.equalsIgnoreCase(""))
		  		{
					strGradeId = Integer.toString(getSancMaxGradeId(strStatId));
					hshQueryValues.put("size","1");
					if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
					{
						hshQuery.put("strQueryId","delpresanction1byinwardno"); 
						arrValues.add(strinwardno);
						arrValues.add(strGradeId);
					}
					else
					{
						hshQuery.put("strQueryId","delpresanction1"); 
						arrValues.add(strappno);
						arrValues.add(strGradeId);
					}
					
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","inspresanction1");	
					arrValues.add(strappno);
					arrValues.add(strGradeId);
					arrValues.add(strSanctionrefno);
					arrValues.add(strSanctiondate);
					arrValues.add(strLoansanction);
					arrValues.add(strPurpose);
					arrValues.add(strSanctionautho);
					arrValues.add(strLoanamount);
					arrValues.add(strDatedisbursed);
					arrValues.add(strAmountoutstanding);
					arrValues.add(strAmountoverdue);
					arrValues.add(strAccounttype);
					arrValues.add(strDetailirrgular);
					arrValues.add(strTermcond);
					
					arrValues.add(strinwardno);
					
				//	arrValues.add(inspname);
				//	arrValues.add(inspanumb);
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		  		}
			}	
			
			else if(strAction1.equalsIgnoreCase("update"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
		  		if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
		  			hshQuery.put("strQueryId","updpresanction1byinwardno"); 
				}
				else
				{
					hshQuery.put("strQueryId","updpresanction1"); 
				}
			
				arrValues.add(strSanctionrefno);
				arrValues.add(strSanctiondate);
				arrValues.add(strLoansanction);
				arrValues.add(strPurpose);
				arrValues.add(strSanctionautho);
				arrValues.add(strLoanamount);
				arrValues.add(strDatedisbursed);
				arrValues.add(strAmountoutstanding);
				arrValues.add(strAmountoverdue);
				arrValues.add(strAccounttype);
				arrValues.add(strDetailirrgular);
				arrValues.add(strTermcond);
				//arrValues.add(strExilimit);
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					arrValues.add(strinwardno);
					arrValues.add(strGradeId); 
				}
				else
				{
					arrValues.add(strappno);
					arrValues.add(strGradeId); 
				}
				
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("1",hshQuery);
				 hshQueryValues.put("size","1");	
				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction1.equalsIgnoreCase("delete"))
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
				{
					hshQuery.put("strQueryId","delpresanction1byinwardno"); 
					arrValues.add(strinwardno);
					arrValues.add(strGradeId);
				}
				else
				{
					hshQuery.put("strQueryId","delpresanction1"); 
					arrValues.add(strappno);
					arrValues.add(strGradeId);
				}
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if (correctNull((String) hshValues.get("hidsaral"))
					.equalsIgnoreCase("saral")) {
			strQuery = SQLParser.getSqlQuery("sel_presanctionbyinwardno^"+ strinwardno );
			}
			else{
			strQuery = SQLParser.getSqlQuery("sel_presanction^"+strappno);
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOldAudit.append("~Name of the Inspecting Officer = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("nameofinsp")));
				strOldAudit.append("~ Date of Inspection = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("INSPECTION_DATE")));
				strOldAudit.append("~ P.F Number of Inspecting Officer = ");
				strOldAudit.append(Helper.correctNull((String)rs.getString("panum")));
				strOldAudit.append("~ Whether borrower is from service area of branch = ");
				if(Helper.correctNull((String)rs.getString("SEL_BORROWER")).equalsIgnoreCase("Y"))
				{
				strOldAudit.append("Yes");
				}
				else if(Helper.correctNull((String)rs.getString("DUESERVICE")).equalsIgnoreCase("N"))
				{
				strOldAudit.append("No");
				}
				else 
				{
					strOldAudit.append("");
				}
				strOldAudit.append("~ Revenue Map Obtained = ");
				if(Helper.correctNull((String)rs.getString("SEL_MAP")).equalsIgnoreCase("Y"))
				{
				strOldAudit.append("Yes");
				}
				else if(Helper.correctNull((String)rs.getString("SEL_MAP")).equalsIgnoreCase("N"))
				{
				strOldAudit.append("No");
				}
				else 
				{
					strOldAudit.append("");
				}
				strOldAudit.append("~ Type of Construction = ");
				if(Helper.correctNull((String)rs.getString("SEL_CONSTRUCTION")).equalsIgnoreCase("1"))
				{
				strOldAudit.append("RCC Construction");
				}
				else if(Helper.correctNull((String)rs.getString("SEL_CONSTRUCTION")).equalsIgnoreCase("2"))
				{
				strOldAudit.append("Mud &amp; Brick");
				}
				else if(Helper.correctNull((String)rs.getString("SEL_CONSTRUCTION")).equalsIgnoreCase("3"))
				{
				strOldAudit.append("Shed");
				}
				else if(Helper.correctNull((String)rs.getString("SEL_CONSTRUCTION")).equalsIgnoreCase("4"))
				{
				strOldAudit.append("Kacha");
				}
				else if(Helper.correctNull((String)rs.getString("SEL_CONSTRUCTION")).equalsIgnoreCase("5"))
				{
				strOldAudit.append("Tile roof houses");
				}
				
				else 
				{
					strOldAudit.append("");
				}
				strOldAudit.append("~The Details of Existing Limits  = ");
				if(Helper.correctNull((String)rs.getString("pre_selexilimit")).equalsIgnoreCase("y"))
				{
				strOldAudit.append("Yes");
				}
				else if(Helper.correctNull((String)rs.getString("pre_selexilimit")).equalsIgnoreCase("n"))
				{
				strOldAudit.append("No");
				}
				
				if (correctNull((String) hshValues.get("hidsaral"))
						.equalsIgnoreCase("saral")) {
				strQuery1 = SQLParser.getSqlQuery("sel_presanction1byinwardno^"+ strinwardno+"^"+strGradeId );
				}
				else{
				strQuery1= SQLParser.getSqlQuery("sel_presanction1^"+strappno+"^"+strGradeId);
				}
				rs2 = DBUtils.executeQuery(strQuery1);
				if(rs2.next())
				{
					strOldAudit.append("~ Sanction Reference No = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_refno")));
					strOldAudit.append("~ Date = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_date")));
					strOldAudit.append("~ Amount Of Loan Sanctioned = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_sanctionamount")));
					strOldAudit.append("~ Purpose = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_purpose")));
					strOldAudit.append("~ Sanctioning Authority = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_sanctionauthority")));
					strOldAudit.append("~ Loan Amount Disbursed = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_amountdisbursed")));
					strOldAudit.append("~ Date Of Disbursement = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_disbursedate")));
					strOldAudit.append("~ Amount Outstanding = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_outstandamount")));
					strOldAudit.append("~ Amount Overdue = ");
					strOldAudit.append(Helper.correctNull((String)rs2.getString("pre_amountoverdue")));
					strOldAudit.append("~ Whether Account Is Regular  = ");
					if(Helper.correctNull((String)rs2.getString("pre_acountregular")).equalsIgnoreCase("y"))
					{
						strOldAudit.append("yes");
					}
					else if(Helper.correctNull((String)rs2.getString("pre_acountregular")).equalsIgnoreCase("n"))
					{
						strOldAudit.append("No");
					}
					else
					{
						strOldAudit.append("");
					}
					strOldAudit.append("~ Whether All The Terms & Conditions Stipulated In The Sanction Advice Have Been Complied With  = ");
					if(Helper.correctNull((String)rs2.getString("pre_termcond")).equalsIgnoreCase("Y"))
					{
						strOldAudit.append("Yes");
					}
					else if(Helper.correctNull((String)rs2.getString("pre_termcond")).equalsIgnoreCase("n"))
					{
						strOldAudit.append("No");
					}
					else
					{
						strOldAudit.append("");
					}
				}
			}
			if (!correctNull((String) hshValues.get("auditflag")).equalsIgnoreCase("Y")) {
				if(!strAction.equalsIgnoreCase("delete"))
				{
					hshValues.put("strAction", "insert");
				}
			
			}
			else
			{
				if(!strAction.equalsIgnoreCase("delete"))
				{
					hshValues.put("strAction", "update");
				}
			}
			if (correctNull((String) hshValues.get("hidsaral")).equalsIgnoreCase("saral")) {
				AuditTrial.auditLog(hshValues,"410",strinwardno,strOldAudit.toString());	
				}
				else 
				{
					AuditTrial.auditLog(hshValues,"410",strappno,strOldAudit.toString());	
				}
			
		}
		catch(Exception e)
		{
				e.printStackTrace();
			
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
	public HashMap getPresanction(HashMap hshValues) 
	{
		HashMap hshRecord=new HashMap();
		
		ResultSet rs = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		
		String strQuery1="";
		String strQuery2="";
		String agecal="";
		String strappno="";
		String strAppId="";
		String hidslno = "";
		String strQuery="";
		String preSancReport =  correctNull((String)hshValues.get("presancreport"));
		String strhidvalue=correctNull((String)hshValues.get("hidvalue"));
		String strinwardno=correctNull((String)hshValues.get("inwardno"));
		
		
		
		try
		{
			
			strappno=correctNull((String)hshValues.get("appno"));
			if(strappno.equals(""))
			{
				strappno=correctNull((String)hshValues.get("strappno"));
			}
			
			strAppId=correctNull((String)hshValues.get("hidapplicantid"));
						
			hidslno = correctNull((String)hshValues.get("sel_refno"));
			if(hidslno.trim().equalsIgnoreCase(""))
			{
				hidslno = "0";
			}
			
			if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("sel_presanctionbyinwardno^"+strinwardno);
				rs=DBUtils.executeQuery(strQuery);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_presanction^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
			}
			
			
			while(rs.next())
			{
				 
				hshRecord.put("other_family_members",correctNull((String)rs.getString("other_family_members")));
				hshRecord.put("present_income_source",correctNull((String)rs.getString("present_income_source")));
				hshRecord.put("other_information",correctNull((String)rs.getString("other_information")));
				hshRecord.put("land_particulars",correctNull((String)rs.getString("land_particulars")));
				hshRecord.put("water_avail_details",correctNull((String)rs.getString("water_avail_details")));
				hshRecord.put("benefit_area",correctNull((String)rs.getString("benefit_area")));
				hshRecord.put("crops_details",correctNull((String)rs.getString("crops_details")));
				hshRecord.put("asset_details",correctNull((String)rs.getString("asset_details")));
				hshRecord.put("liability_details",correctNull((String)rs.getString("liability_details")));
				hshRecord.put("applicant_arrangements",correctNull((String)rs.getString("applicant_arrangements")));
				hshRecord.put("recommendation",Helper.CLOBToString(rs.getClob("recommendation"))); 
				hshRecord.put("inspection_date",correctNull((String)rs.getString("inspection_date"))); 

				hshRecord.put("sel_borrower",correctNull((String)rs.getString("SEL_BORROWER")));
				hshRecord.put("sel_map",correctNull((String)rs.getString("SEL_MAP")));
				hshRecord.put("txr_east",correctNull((String)rs.getString("TXR_EAST")));
				hshRecord.put("txr_west",correctNull((String)rs.getString("TXR_WEST"))); 
				hshRecord.put("txr_north",correctNull((String)rs.getString("TXR_NORTH")));
				hshRecord.put("txr_south",correctNull((String)rs.getString("TXR_SOUTH"))); 
				hshRecord.put("sel_construction",correctNull((String)rs.getString("SEL_CONSTRUCTION"))); 
				
				
				if(strhidvalue.equalsIgnoreCase("get"))
				{
					hshRecord.put("pre_selexilimit","y");
				}
				else
				{
				hshRecord.put("pre_selexilimit",correctNull((String)rs.getString("pre_selexilimit")));
				}
				hshRecord.put("nameofinsp",correctNull((String)rs.getString("nameofinsp"))); 
				hshRecord.put("panum",correctNull((String)rs.getString("panum"))); 
				hshRecord.put("inwardno",correctNull((String)rs.getString("pre_inwardno"))); 
				hshRecord.put("audit_flag","Y");
				
				
			}	
			if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
			{
				rs=DBUtils.executeLAPSQuery("sel_presanction1byinwardno^"+strinwardno+"^"+hidslno);
			}
			else
			{
				rs=DBUtils.executeLAPSQuery("sel_presanction1^"+strappno+"^"+hidslno);
			}
			
			while(rs.next())
			{
				 
				hshRecord.put("sanction_ref_no",correctNull((String)rs.getString("pre_refno")));
				hshRecord.put("sanction_date",correctNull((String)rs.getString("pre_date")));
				hshRecord.put("sanction_amount",correctNull((String)rs.getString("pre_sanctionamount")));
				hshRecord.put("loan_purpose",correctNull((String)rs.getString("pre_purpose")));
				hshRecord.put("sanction_authority",correctNull((String)rs.getString("pre_sanctionauthority")));
				hshRecord.put("disbursed_amount",correctNull((String)rs.getString("pre_amountdisbursed")));
				hshRecord.put("disbursement_date",correctNull((String)rs.getString("pre_disbursedate")));
				hshRecord.put("outstanding_amount",correctNull((String)rs.getString("pre_outstandamount"))); 
				hshRecord.put("overdue_amount",correctNull((String)rs.getString("pre_amountoverdue")));
				hshRecord.put("regular_account",correctNull((String)rs.getString("pre_acountregular")));
				hshRecord.put("irregular_details",correctNull((String)rs.getString("pre_irregualdetail")));
				hshRecord.put("terms_cond_complied",correctNull((String)rs.getString("pre_termcond")));
				hshRecord.put("inwardno",correctNull((String)rs.getString("pre_inwardno"))); 
				hshRecord.put("audit_flag","Y");

			}		
			String Curdate="";
			String Date="";
			String Month="";
			String year="";
			rs=DBUtils.executeLAPSQuery("selCurrentdate");
			if(rs.next())
			{
				 Curdate=correctNull((String)rs.getString("currentdate"));
				 Date=Curdate.substring(0,2);
				 Month=Curdate.substring(3,5);
				 year=Curdate.substring(6,10);
				
				if(!(correctNull((String)hshValues.get("hidsaral")).equals("saral")))
				{	
					if(!strAppId.equals(""))
					{
						strQuery1=SQLParser.getSqlQuery("selAgecal^"+strAppId);
						if(rs3!=null)
						{
							rs.close();
						}
						rs3=DBUtils.executeQuery(strQuery1);
						if(rs3.next())
						{
							 String Age=correctNull((String)rs3.getString("perapp_dob")); 
							 String Agecal=Age.substring(0,4);
							 int age=Integer.parseInt(Agecal);
							 int year11=Integer.parseInt(year);
							 agecal=Integer.toString(year11-age);
							 
							 
						}
					}
				}
			//	
				ArrayList arrRow = new ArrayList();
				ArrayList arrCol = null;
				
				if(preSancReport.equals("yes"))
				{
					if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
					{
						rs=DBUtils.executeLAPSQuery("sel_presanctionReportbyinwardno^"+strinwardno);
					}
					else
					{
						rs=DBUtils.executeLAPSQuery("sel_presanctionReport^"+strappno);
					}
					while(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(correctNull((String)rs.getString("pre_refno")));
						arrCol.add(correctNull((String)rs.getString("pre_date")));
						arrCol.add(correctNull((String)rs.getString("pre_sanctionamount")));
						arrCol.add(correctNull((String)rs.getString("pre_purpose")));
						arrCol.add(correctNull((String)rs.getString("pre_sanctionauthority")));
						arrCol.add(correctNull((String)rs.getString("pre_amountdisbursed")));
						arrCol.add(correctNull((String)rs.getString("pre_disbursedate")));
						arrCol.add(correctNull((String)rs.getString("pre_outstandamount"))); 
						arrCol.add(correctNull((String)rs.getString("pre_amountoverdue")));
						arrCol.add(correctNull((String)rs.getString("pre_acountregular")));
						arrCol.add(correctNull((String)rs.getString("pre_irregualdetail")));
						arrCol.add(correctNull((String)rs.getString("pre_termcond")));
						//hshRecord.put("pre_selexilimit",correctNull((String)rs.getString("pre_selexilimit")));
						
						arrRow.add(arrCol);
					}		
				}
				
				hshRecord.put("Date",Date);
				hshRecord.put("Month",Month);
				hshRecord.put("year",year);
				hshRecord.put("Curdate",Curdate);
				hshRecord.put("agecal",agecal);
				hshRecord.put("arrRow", arrRow);
				
			}
			
			if(!(correctNull((String)hshValues.get("hidsaral")).equals("saral")))
			{
				strQuery=SQLParser.getSqlQuery("selapplicant_byappno^"+strappno+"^a"); 
				if(rs4!=null)
				{
					rs4.close();
				}
				rs4=DBUtils.executeQuery(strQuery);
				
				if(rs4.next())
				{
					hshRecord.put("perapp_fname",correctNull((String)rs4.getString("perapp_fname")));	
					/*hshRecord.put("perapp_address1",correctNull((String)rs4.getString("perapp_address1")));
					String address2=correctNull((String)rs4.getString("perapp_address2"));
					String address3=correctNull((String)rs4.getString("perapp_address3"));
					String address4=address2+address3;
					hshRecord.put("address4",address4);
					hshRecord.put("City",correctNull((String)rs4.getString("comm_city")));
					hshRecord.put("State",correctNull((String)rs4.getString("comm_state")));
					hshRecord.put("Pincode",correctNull((String)rs4.getString("perapp_zip")));
					String perapp_education=correctNull((String)rs4.getString("perapp_education"));
					
					if(perapp_education.equalsIgnoreCase("1"))
					{
						perapp_education="M.B.B.S/MD/MS";
					}else  if(perapp_education.equalsIgnoreCase("2"))
					{
						perapp_education="C.A";
					}
					else  if(perapp_education.equalsIgnoreCase("3"))
					{
						perapp_education="M.B.A";
					}
					else  if(perapp_education.equalsIgnoreCase("4"))
					{
						perapp_education="A.C.S";
					}
					else  if(perapp_education.equalsIgnoreCase("5"))
					{
						perapp_education="Professional";
					}
					else  if(perapp_education.equalsIgnoreCase("6"))
					{
						perapp_education="Post Graduate";
					}
					else  if(perapp_education.equalsIgnoreCase("7"))
					{
						perapp_education="Graduate";
					}
					else  if(perapp_education.equalsIgnoreCase("8"))
					{
						perapp_education="Diploma";
					}
					else  if(perapp_education.equalsIgnoreCase("9"))
					{
						perapp_education="PUC";
					}
					else  if(perapp_education.equalsIgnoreCase("10"))
					{
						perapp_education="SSLC";
					}
					else  if(perapp_education.equalsIgnoreCase("11"))
					{
						perapp_education="VIII Pass";
					}
					else  if(perapp_education.equalsIgnoreCase("12"))
					{
						perapp_education="Illiterate";
					}
					else  if(perapp_education.equalsIgnoreCase("13"))
					{
						perapp_education="LLB/LLM";
					}
					else  if(perapp_education.equalsIgnoreCase("14"))
					{
						perapp_education="Others";
					} 
					hshRecord.put("perapp_education",perapp_education);*/
				}
			}
			hshRecord.put("appno",strappno);
			hshRecord.put("sel_refno",hidslno);
			
			if(correctNull((String)hshValues.get("hidsaral")).equals("saral"))
			{
				strQuery1=SQLParser.getSqlQuery("selinwardreg^"+strinwardno);
				if(rs3!=null)
				{
					rs.close();
				}
				rs3=DBUtils.executeQuery(strQuery1);
				if(rs3.next())
				{
					 String Age=correctNull((String)rs3.getString("inward_dob")); 
					 String Agecal=Age.substring(6,10);
					 int age=Integer.parseInt(Agecal);
					 int year11=Integer.parseInt(year);
					 agecal=Integer.toString(year11-age);
					 
					 hshRecord.put("strAge",agecal);
				}
			}
			else
			{
				if(!strAppId.equals(""))
				{
					strQuery2=SQLParser.getSqlQuery("sel_presanactionage^"+strAppId);
					rs5=DBUtils.executeQuery(strQuery2);
					if(rs5.next())
					{
						double age=Double.parseDouble(Helper.correctDouble((String)rs5.getString("age")));
						if(age<0)
							age=age+100;
						int dblAge=(int)age;
										
						hshRecord.put("strAge",Integer.toString(dblAge));
						//hshRecord.put("strAge",Helper.formatDoubleValue(age1));
					}
				}
			}
			strQuery = SQLParser.getSqlQuery("sel_sanctionbranch^"+strappno+"^"+strappno);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{	
				hshRecord.put("org_name",correctNull((String)rs.getString("org_name")));
				
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(strinwardno.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("selBranchCityName^"+strappno);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selinwardreg^"+strinwardno);				
			}
				
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("orgname",correctNull((String)rs.getString("org_name")));
				hshRecord.put("orgadd1",correctNull((String)rs.getString("org_add1")));
				hshRecord.put("orgadd2",correctNull((String)rs.getString("org_add2")));
				hshRecord.put("orgcity",correctNull((String)rs.getString("org_city")));
				hshRecord.put("orgstate",correctNull((String)rs.getString("org_state")));
				hshRecord.put("orgzip",correctNull((String)rs.getString("org_zip")));
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
				if(rs3 != null)
				{
					rs3.close();
				} 
				if(rs4 != null)
				{
					rs4.close();
				} 
				if(rs5 != null)
				{
					rs5.close();
				} 
			}
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		
		return hshRecord;
	}
	
	
	
	public HashMap getAppraisalData(HashMap hshRequestValues) 
	{ 
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		
		ArrayList vecRow=new ArrayList();
		ArrayList vecData=new ArrayList();
		try
		{ 		
			String strPagename = Helper.correctNull((String)hshRequestValues.get("sel_comments"));
			if(strPagename.equalsIgnoreCase(""))
			{
				strPagename = Helper.correctNull((String)hshRequestValues.get("hid_pagename"));
			}
			String strappname = Helper.correctNull((String)hshRequestValues.get("chk_apptype"));
			String strappname1 = Helper.correctNull((String)hshRequestValues.get("chk_apptype"));
			String strappno= "",strDate="";
			String strAppstatus = Helper.correctNull((String)hshRequestValues.get("appstatus"));
			if(!strPagename.equalsIgnoreCase("CO") && !strPagename.equalsIgnoreCase("ES") && !strPagename.equalsIgnoreCase("SF"))
			{
				strappno = Helper.correctNull((String)hshRequestValues.get("appno"));
			}
			if(strappno.equalsIgnoreCase("") || strappno.equalsIgnoreCase("null"))
			{
				strappno = Helper.correctNull((String)hshRequestValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + strappno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("appname", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_name"))));
				hshRecord.put("app_status", Helper.correctDoubleQuote(correctNull((String)rs.getString("app_status"))));
				hshRecord.put("applicantid", rs.getString("demo_appid"));
			}
			int len =0;
			len = strappname.length();
			if(!strappname.equalsIgnoreCase(""))
			{
				strappname = strappname.substring(1,len);
			}
			else
			{
				strappname ="0";
			}			
			if(rs!=null)
			{
				rs.close();
			}
			if(strPagename.equalsIgnoreCase("IE"))
			{
				strQuery=SQLParser.getSqlQuery("sel_perappApraisal_incomeexpenses^"+ strappno);
				rs=DBUtils.executeQuery(strQuery);
				 
				while(rs.next()) 
				{
					vecRow=new ArrayList();
					vecRow.add(correctNull((String)rs.getString("perinc_id")));
					vecRow.add(correctNull((String)rs.getString("perinc_yearsalary")));
					vecRow.add(correctNull((String)rs.getString("perinc_secincome")));
					vecRow.add(correctNull((String)rs.getString("perinc_yeardeduction")));
					vecRow.add(correctNull((String)rs.getString("perinc_yearotherdeduc")));
					vecRow.add(correctNull((String)rs.getString("perinc_takehome")));
					vecRow.add(correctNull((String)rs.getString("demo_type")));
					String strType=correctNull((String)rs.getString("demo_type"));
					if (strType.trim().equalsIgnoreCase("a"))
					{
						strType="Applicant";
					}
					else if (strType.trim().equalsIgnoreCase("c"))
					{
						strType="Joint-Applicant";
					}
					else if (strType.trim().equalsIgnoreCase("g"))
					{
						strType="Guarantor";
					}
					else if (strType.trim().equalsIgnoreCase("o"))
					{
						strType="Co-Obligant";
					}
					vecRow.add(strType);
					vecRow.add(correctNull((String)rs.getString("perapp_fname")));
					vecData.add(vecRow);
				}
				hshRecord.put("vecReport",vecData);
				if(strPagename.equalsIgnoreCase("IE") && !strappname.equalsIgnoreCase("0"))
				{
					strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal2^"+strappno+"^"+strPagename+"^"+strappname);			
					rs1=DBUtils.executeQuery(strQuery);		
			
					if(rs1.next())
					{
						hshRecord.put("app_no",correctNull((String)rs1.getString("app_no")));
					    hshRecord.put("perapp_id",correctNull((String)rs1.getString("perapp_id")));
					    hshRecord.put("Comme_Type",correctNull((String)rs1.getString("Comme_Type")));
					    hshRecord.put("Comments",correctNull((String)rs1.getString("Comments")));
					    hshRecord.put("Ques1",correctNull((String)rs1.getString("Ques1")));
					    hshRecord.put("Ques2",correctNull((String)rs1.getString("Ques2")));
					    hshRecord.put("Ques3",correctNull((String)rs1.getString("Ques3")));
					    hshRecord.put("Ques4",correctNull((String)rs1.getString("Ques4")));
					    hshRecord.put("Ques5",correctNull((String)rs1.getString("Ques5")));
					    hshRecord.put("Ques6",correctNull((String)rs1.getString("Ques6")));
					    hshRecord.put("Ques7",correctNull((String)rs1.getString("Ques7")));
					    hshRecord.put("Sanction_Flag",correctNull((String)rs1.getString("Sanction_Flag")));							
					}
				}
			}
			if(strPagename.equalsIgnoreCase("ES"))
			{
				java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
				nf.setGroupingUsed(false);
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				ArrayList vecReport=new ArrayList();
				ArrayList vecCoapp=null;
				String strType="";
				String NetAssets="";
				String strName="";
				String strId="";
				if(rs != null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("selloan_details^"+strappno);			 
				if(rs.next())
				{
					strDate = correctNull((String)rs.getString("app_processdate"));
				}
				if(rs != null)
					rs.close();
				if(strAppstatus.equalsIgnoreCase("Open/Pending"))
				{
					strDate = Helper.getCurrentDateTime();
				}
				rs=DBUtils.executeLAPSQuery("appraisal_experienceservice^"+strDate+"^"+strDate+"^"+strappno);
				while(rs.next())
				{					
					vecCoapp=new ArrayList();
					strType=correctNull((String)rs.getString("demo_type"));				
					strId=strType+correctNull((String)rs.getString("demo_appid"));
					if (strType.trim().equalsIgnoreCase("a"))
					{
						strType="Applicant";
					}
					else if (strType.trim().equalsIgnoreCase("c"))
					{
						strType="Joint-Applicant";
					}
					else if (strType.trim().equalsIgnoreCase("g"))
					{
						strType="Guarantor";
					}
					else if (strType.trim().equalsIgnoreCase("o"))
					{
						strType="Co-Obligant";
					}
					vecCoapp.add(strType);
					strName=correctNull((String)rs.getString("coappname"));
					vecCoapp.add(strName);
					
					vecCoapp.add(correctNull((String)rs.getString("demo_appno")));
					vecCoapp.add(correctNull((String)rs.getString("demo_type")));
					vecCoapp.add(correctNull((String)rs.getString("demo_appid")));
					vecCoapp.add(correctNull((String)rs.getString("demo_relation")));
					vecCoapp.add(correctNull((String)rs.getString("perapp_dob")));
					vecCoapp.add(Helper.correctInt(rs.getString("age")));
					if(correctNull((String)rs.getString("perapp_employment")).equals("1") || correctNull((String)rs.getString("perapp_employment")).equals("9"))
						vecCoapp.add(correctNull((String)rs.getString("remempage")));
					else
						vecCoapp.add(correctNull((String)rs.getString("remselfage")));
					
					
					strQuery=SQLParser.getSqlQuery("selcreditreport2^"+strappno+"^"+strId);
					if(rs1 != null)
						rs1.close();
					rs1=DBUtils.executeQuery(strQuery);
					NetAssets="0.0";
					if(rs1.next())
					{
						NetAssets=correctNull((String)rs1.getString("CR_Total_MEANS"));
					}
					vecCoapp.add(NetAssets);
					vecReport.add(vecCoapp);
				}
				hshRecord.put("vecReport",vecReport);
				if(strPagename.equalsIgnoreCase("ES") && !strappname.equalsIgnoreCase("0"))
				{
					strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal2^"+strappno+"^"+strPagename+"^"+strappname);			
					 rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("app_no",correctNull((String)rs1.getString("app_no")));
					    hshRecord.put("perapp_id",correctNull((String)rs1.getString("perapp_id")));
					    hshRecord.put("Comme_Type",correctNull((String)rs1.getString("Comme_Type")));
					    hshRecord.put("Comments",correctNull((String)rs1.getString("Comments")));
					    hshRecord.put("Ques1",correctNull((String)rs1.getString("Ques1")));
					    hshRecord.put("Ques2",correctNull((String)rs1.getString("Ques2")));
					    hshRecord.put("Ques3",correctNull((String)rs1.getString("Ques3")));
					    hshRecord.put("Sanction_Flag",correctNull((String)rs1.getString("Sanction_Flag")));		
					    hshRecord.put("Sanction_ref",correctNull((String)rs1.getString("Sanction_ref")));	
					    hshRecord.put("Ques4",correctNull((String)rs1.getString("Ques4")));
					    hshRecord.put("Ques5",correctNull((String)rs1.getString("Ques5")));
					    hshRecord.put("Ques6",correctNull((String)rs1.getString("Ques6")));
					    hshRecord.put("Ques7",correctNull((String)rs1.getString("Ques7")));
					}
				}
			}
			/*if (strPagename.equalsIgnoreCase("IE") || strPagename.equalsIgnoreCase("ES") || strPagename.equalsIgnoreCase("CO"))
			{				
				strQuery = SQLParser.getSqlQuery("sel_perapp_Appid^"+strappno+"^"+strPagename);			
				rs=DBUtils.executeQuery(strQuery);		    
				if(rs.next())
				{
					strdemoappid= correctNull((String)rs.getString("demo_appid"));
				}	
				if(rs!=null)
				{
					rs.close();
				}
			}*/
			if(strPagename.equalsIgnoreCase("CO") && !strappname.equalsIgnoreCase("0"))
			{
				strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal2^"+strappno+"^"+strPagename+"^"+strappname);			
				 rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshRecord.put("app_no",correctNull((String)rs1.getString("app_no")));
				    hshRecord.put("perapp_id",correctNull((String)rs1.getString("perapp_id")));
				    hshRecord.put("Comme_Type",correctNull((String)rs1.getString("Comme_Type")));
				    hshRecord.put("Comments",correctNull((String)rs1.getString("Comments")));
				    hshRecord.put("Ques1",correctNull((String)rs1.getString("Ques1")));
				    hshRecord.put("Ques2",correctNull((String)rs1.getString("Ques2")));
				    hshRecord.put("Ques3",correctNull((String)rs1.getString("Ques3")));
				    hshRecord.put("Sanction_Flag",correctNull((String)rs1.getString("Sanction_Flag")));
				    hshRecord.put("Sanction_ref",correctNull((String)rs1.getString("Sanction_ref")));	
				    hshRecord.put("Ques4",correctNull((String)rs1.getString("Ques4")));
				    hshRecord.put("Ques5",correctNull((String)rs1.getString("Ques5")));
				    hshRecord.put("Ques6",correctNull((String)rs1.getString("Ques6")));
				    hshRecord.put("Ques7",correctNull((String)rs1.getString("Ques7")));
				}
			}
			if(strappname.equalsIgnoreCase("0") && (strPagename.equalsIgnoreCase("RA")||strPagename.equalsIgnoreCase("SF") || strPagename.equalsIgnoreCase("BG")))
			{
				strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal1^"+strappno+"^"+strPagename);			
				 rs1=DBUtils.executeQuery(strQuery);
			
				if(rs1.next())
				{
					hshRecord.put("app_no",correctNull((String)rs1.getString("app_no")));
				    hshRecord.put("perapp_id",correctNull((String)rs1.getString("perapp_id")));
				    hshRecord.put("Comme_Type",correctNull((String)rs1.getString("Comme_Type")));
				    hshRecord.put("Comments",correctNull((String)rs1.getString("Comments")));
				    hshRecord.put("Ques1",correctNull((String)rs1.getString("Ques1")));
				    hshRecord.put("Ques2",correctNull((String)rs1.getString("Ques2")));
				    hshRecord.put("Ques3",correctNull((String)rs1.getString("Ques3")));
				    hshRecord.put("Sanction_Flag",correctNull((String)rs1.getString("Sanction_Flag")));
				    hshRecord.put("Sanction_ref",correctNull((String)rs1.getString("Sanction_ref")));	
				    hshRecord.put("Ques4",correctNull((String)rs1.getString("Ques4")));
				    hshRecord.put("Ques5",correctNull((String)rs1.getString("Ques5")));
				    hshRecord.put("Ques6",correctNull((String)rs1.getString("Ques6")));
				    hshRecord.put("Ques7",correctNull((String)rs1.getString("Ques7")));
				}
			}		
			
			hshRecord.put("strper_appid",strappname1);	
			hshRecord.put("appno", strappno);
			hshRecord.put("Pagename",strPagename);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
		finally
		{
			try
			{	if(rs != null)
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}	
	
	private int getMaxGradeId(String qry)  
	{ 
		ResultSet rs = null;
		int termId = 0;
		try 
		{
			rs=DBUtils.executeLAPSQuery(qry);
			while (rs.next()) 
			{
				if (rs.getString(1) != null) 
				{
					termId = Integer.parseInt(rs.getString(1)) ;
				}
			}
			rs.close();
		} 
		catch (Exception ce) 
		{
			throw new EJBException("Error in getData " + ce.toString());
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
		return termId;
	}
	
	public HashMap getProductList(HashMap hshValues) 
	{ 
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshResult=new HashMap();
		ArrayList vecRow =new ArrayList();
		ArrayList vecData =new ArrayList();
	
		try
		{ 
			rs1=DBUtils.executeLAPSQuery("sel_generalInfoproducts");
			 
			while (rs1.next())
			{
				vecRow=new ArrayList();
				vecRow.add(Helper.correctNull((String)rs1.getString("prdcode")));
				vecRow.add(Helper.correctNull((String)rs1.getString("category")));
				vecRow.add(Helper.correctNull((String)rs1.getString("subcategory")));
				vecRow.add(Helper.correctNull((String)rs1.getString("rangefrom")));
				vecRow.add(Helper.correctNull((String)rs1.getString("rangeto")));				
				vecData.add(vecRow);	
			}
			hshResult.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getData"+ce.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(rs1!=null)
				{
					rs1.close();
				}				 
			}
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}		
		return hshResult;
	}

	public HashMap getEMIData(HashMap hshValues) 
	{
		String strQuery="", sancamount="", CheckbState1="", prd_type="", auto_category="";
		String prop_totalcost="", mintrate ="", marginvalue="", cloanprd ="";
		String ApplicantIncome="", margin_perct="", loan_repaycapacity="",
		strRecAmt="", strTerms="", prd_interest="",  strstepintrate="", strsteptoamt="", applicantname="";
		String domesticexpenses="", edu_studies_in="", perapp_salaryrouted="";
		String prd_oldvehiclemargin = "", perapp_id="";
		ArrayList arrincome=new ArrayList();
		ArrayList arrtotalnetincome=new ArrayList();
		String netincome="", monincome="", monthlyincome="";
		//double applicantnetincome=0;
		String loan_deviationloanamount ="0.00";
		ResultSet rs=null;
		ResultSet rs4=null;
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshResult=new HashMap();
		double dblnetTradeIn=0.0;
		double dblTradeIn=0.0;
		double dblloanTradeIn=0.0;
		double dblloanValratio=0.0;
		double dblamtRequested=0.0;
		double dblcostLoanPrd=0.0;
		double dbldownPay=0.0;
		double dblAloanValratio=0.0;
		double dblamtRecommended=0.0;
		String dblnumterms="", strPrdCode="", loan_noofinstallment="";
		double dblnumreqterms=0.0;
		double dblmodintrate=0.0;
		double dblnumer=0.0;
		double dbldenom=0.0;
		double dblemi=0.0;
		double dbltotalpay=0.0;
		boolean bstate;
		String strAction="";
		String strappno ="";
//		String lreqterms="";
		String Ques2="";
		String strrecommendedloanamount = "";
		String productmaxamount ="";
		DecimalFormat dc=new DecimalFormat();
		String strPage=correctNull((String)hshValues.get("page"));
		String strApplicationNo=correctNull((String)hshValues.get("appno"));
		String strPrimayDetails=correctNull((String)hshValues.get("strApp"));
		String strEditLock=correctNull((String)hshValues.get("hidEditLock"));
		String strHidMode=correctNull((String)hshValues.get("radLoan"));
		String strUserId = correctNull((String)hshValues.get("strUserId"));
		boolean bState1;	
		boolean bState;	
		HashMap hshGetDocFee =new HashMap();		
		String producttype = Helper.correctNull((String)hshValues.get("hid_producttype"));
		String vehicletype = Helper.correctNull((String)hshValues.get("hid_vechicletype"));
		try
		{
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
			 
			strAction = Helper.correctNull((String)hshValues.get("hidAction"));	
			String emi_reqamount = Helper.correctNull((String)hshValues.get("txt_loanamount"));
			if(emi_reqamount.equalsIgnoreCase(""))
			{
				emi_reqamount = "0";
			}
			String emi_interestrate= Helper.correctNull((String)hshValues.get("txt_interest"));
			if(emi_interestrate.equalsIgnoreCase(""))
			{
				emi_interestrate = "0";
			}
			String emi_modifyrate= Helper.correctNull((String)hshValues.get("txt_modifyrate"));
			if(emi_modifyrate.equalsIgnoreCase(""))
			{
				emi_modifyrate = "0";
			}
			String emi_repayperiod=Helper.correctNull((String)hshValues.get("txt_terms"));
			if(emi_repayperiod.equalsIgnoreCase(""))
			{
				emi_repayperiod = "0";
			}
			String emi_emiamount=Helper.correctNull((String)hshValues.get("txt_emi"));
			if(emi_emiamount.equalsIgnoreCase(""))
			{
				emi_emiamount = "0";
			}
			String emi_totalcost=Helper.correctNull((String)hshValues.get("txt_totalcost"));
			if(emi_totalcost.equalsIgnoreCase(""))
			{
				emi_totalcost = "0.00";
			}
			String emi_minmargin = Helper.correctNull((String)hshValues.get("txt_minmargin"));
			if(emi_minmargin.equalsIgnoreCase(""))
			{
				emi_minmargin="0";
			}
			String emi_minmarginvalue = Helper.correctNull((String)hshValues.get("txt_minmarginvalue"));
			if(emi_minmarginvalue.equalsIgnoreCase(""))
			{
				emi_minmarginvalue="0";
			}
			if(emi_minmarginvalue.equalsIgnoreCase(""))
			{
				emi_minmarginvalue = "0.00";				
			}
			String emi_permisibleloanamount=Helper.correctNull((String)hshValues.get("txt_permisibleloanB"));
			if(emi_permisibleloanamount.equalsIgnoreCase(""))
			{
				emi_permisibleloanamount="0.00";
			}
			String emi_maxloanamount=Helper.correctNull((String)hshValues.get("txt_maxloanamount"));
			if(emi_maxloanamount.equalsIgnoreCase(""))
			{
				emi_maxloanamount="0.00";
			}
			String emi_maxperamount=Helper.correctNull((String)hshValues.get("txt_maxpermisibleloan"));
			if(emi_maxperamount.equalsIgnoreCase(""))
			{
				emi_maxperamount="0.00";
			}
			String emi_leastamount=Helper.correctNull((String)hshValues.get("txt_Leastamount"));
			if(emi_leastamount.equalsIgnoreCase(""))
			{
				emi_leastamount = "0";
			}
			String emi_sancamount=Helper.correctNull((String)hshValues.get("txt_recommloanamount"));
			if(emi_sancamount.equalsIgnoreCase(""))
			{
				emi_sancamount = "0";
			}
			String emi_maxperemiamount=Helper.correctNull((String)hshValues.get("txt_maxperrepay"));
			if(emi_maxperemiamount.equalsIgnoreCase(""))
			{
				emi_maxperemiamount="0.00";
			}
			String emi_totfactor=Helper.correctNull((String)hshValues.get("txt_factortoused"));
			if(emi_totfactor.equalsIgnoreCase(""))
			{
				emi_totfactor="0.00";
			}
			String emi_coappincome=Helper.correctNull((String)hshValues.get("txt_totalAppcoappIncome"));
			if(emi_coappincome.equalsIgnoreCase(""))
			{
				emi_coappincome = "0";
			}
			if(strAction.equals("Apply"))
			{	
				if(!strrecommendedloanamount.equalsIgnoreCase(""))
				{
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					bstate=false;					
					rs=DBUtils.executeLAPSQuery("check_appraisalsanction^"+strappno);
					 
					if(rs!=null)
					{
						bstate = rs.next();
						if(bstate)
						{
							hshQuery.put("strQueryId","update_appraisalsanction");
							arrValues=new ArrayList(); 
							arrValues.add(strrecommendedloanamount);
							arrValues.add(strappno);											
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							hshQuery.put("strQueryId","insert_appraisalsanction");
							arrValues=new ArrayList();				 
							
							arrValues.add(strappno);
							arrValues.add(strrecommendedloanamount);
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}					
					}
					if(rs!=null)
					{
						rs.close();
					}					
				}
			}
			if(strAction.equals("Apply"))
			{	
				if(!emi_sancamount.equalsIgnoreCase(""))
				{
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					 rs=DBUtils.executeLAPSQuery("check_emiabcdlogic^"+strappno);
					 
					if(rs!=null)
					{
						bState1 = rs.next();
						
						if(bState1)
						{
							hshQuery.put("strQueryId","upd_emiabcdlogic");
							arrValues=new ArrayList();
							arrValues.add(strappno);
							arrValues.add(emi_reqamount);
							arrValues.add(emi_interestrate);
							arrValues.add(emi_modifyrate);
							arrValues.add(emi_repayperiod);
							arrValues.add(emi_emiamount);
							arrValues.add(emi_totalcost);
							arrValues.add(emi_minmargin);
							arrValues.add(emi_minmarginvalue);
							arrValues.add(emi_permisibleloanamount);							
							arrValues.add(emi_maxloanamount);
							arrValues.add(emi_maxperamount);  
							arrValues.add(emi_leastamount);
							arrValues.add(emi_sancamount);
							arrValues.add(emi_maxperemiamount); 
							arrValues.add(emi_totfactor);    
							arrValues.add(emi_coappincome);
							arrValues.add(strappno);
											
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							
							String strCollpercent="";
							PerApplicantBean perapp = new PerApplicantBean();
							strCollpercent = perapp.getCollateralpercent(strappno, emi_emiamount);
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_loandetailsleastvalue");
							arrValues.add(emi_sancamount);	
							arrValues.add(emi_emiamount);
							arrValues.add(strCollpercent);
							arrValues.add(strappno);
											
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
							
//							hshQuery=new HashMap();
//							arrValues=new ArrayList();
//							arrValues.add(emi_sancamount);
//							arrValues.add(strappno);
//							hshQuery.put("arrValues",arrValues);
//							hshQuery.put("strQueryId","apphistoryUpd3");
//							hshQueryValues.put("3",hshQuery);
//							hshQueryValues.put("size","3");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						else
						{
							CheckbState1="False";
							hshQuery.put("strQueryId","ins_emiabcdlogic");
							arrValues=new ArrayList();
							
							arrValues.add(strappno);
							arrValues.add(emi_reqamount);
							arrValues.add(emi_interestrate);
							arrValues.add(emi_modifyrate);
							arrValues.add(emi_repayperiod);
							arrValues.add(emi_emiamount);
							arrValues.add(emi_totalcost);
							arrValues.add(emi_minmargin);
							arrValues.add(emi_minmarginvalue);
							arrValues.add(emi_permisibleloanamount);							
							arrValues.add(emi_maxloanamount);
							arrValues.add(emi_maxperamount);
							arrValues.add(emi_leastamount);
							arrValues.add(emi_sancamount);
							arrValues.add(emi_maxperemiamount);
							arrValues.add(emi_totfactor);
							arrValues.add(emi_coappincome);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");
							
							String strCollpercent="";
							PerApplicantBean perapp = new PerApplicantBean();
							strCollpercent = perapp.getCollateralpercent(strappno, emi_emiamount);
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_loandetailsleastvalue");
							arrValues.add(emi_sancamount);	
							arrValues.add(emi_emiamount);
							arrValues.add(strCollpercent);
							arrValues.add(strappno);
											
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);
							hshQueryValues.put("size","2");
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							arrValues.add(emi_sancamount);
							arrValues.add(strappno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","apphistoryUpd3");
							hshQueryValues.put("3",hshQuery);
							hshQueryValues.put("size","3");
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}						
					}
				}				
			}
			if(producttype.equalsIgnoreCase("pA") && vehicletype.equalsIgnoreCase("1"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_margin_loandetails");
				arrValues.add(emi_minmargin);	
				arrValues.add(strappno);
								
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strHidMode.equalsIgnoreCase("Y"))
			{ 
				 rs=DBUtils.executeLAPSQuery("sel_totalcost^"+strApplicationNo);
				 
				bState=rs.next();
				if(bState)
				{
					prop_totalcost=Helper.correctNull((String)rs.getString("prop_totalcost"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				String strProdPurpose="",strVehicleType="";

				 rs=DBUtils.executeLAPSQuery("selprodpurpose^"+strApplicationNo);

				if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					 rs=DBUtils.executeLAPSQuery("pergetloanProductbymargin^"+strApplicationNo);
				}
				else
				{
					 rs=DBUtils.executeLAPSQuery("pergetloanProduct^"+strApplicationNo);
				}
				bState=rs.next();
				if(bState)
				{
					hshResult.put("noData","Data");
				}
				else
				{
					hshResult.put("noData","noData");
				}
				if(bState)
				{
					hshResult.put("appno",correctNull((String)rs.getString("appno")));
					hshResult.put("status",correctNull((String)rs.getString("status")));
					hshResult.put("aname",correctNull((String)rs.getString("aname")));
					hshResult.put("appid",correctNull((String)rs.getString("appid")));
					hshResult.put("category",correctNull((String)rs.getString("category")));
					hshResult.put("subcategory",correctNull((String)rs.getString("subcategory")));
					hshResult.put("rfrom",correctNull((String)rs.getString("rfrom")));
					hshResult.put("rangeto",correctNull((String)rs.getString("rangeto")));
					strPrdCode = correctNull((String)rs.getString("prdcode"));
					hshResult.put("prdcode",strPrdCode);
					hshResult.put("mintrate",correctNull((String)rs.getString("mintrate")));
					mintrate=correctNull((String)rs.getString("mintrate"));
					hshResult.put("lterms",correctNull((String)rs.getString("lterms")));
					hshResult.put("amtreqd",correctNull((String)rs.getString("amtreqd")));
					hshResult.put("cloanprd",correctNull((String)rs.getString("cloanprd")));
					sancamount=correctNull((String)rs.getString("sancamount"));
					cloanprd=Helper.correctNull((String)rs.getString("cloanprd"));
					hshResult.put("tradein",correctNull((String)rs.getString("tradein")));
					hshResult.put("loantrade",correctNull((String)rs.getString("loantrade")));
					hshResult.put("loan_margin",correctNull((String)rs.getString("loan_margin")));
					marginvalue=correctNull((String)rs.getString("loan_margin"));
					hshResult.put("cloanprd",correctNull((String)rs.getString("cloanprd")));
//					lreqterms=correctNull((String)rs.getString("lreqterms"));
					loan_repaycapacity=correctNull((String)rs.getString("loan_repaycapacity"));
					hshResult.put("lreqterms",correctNull((String)rs.getString("lreqterms")));
					if(correctNull((String)rs.getString("loan_margin")).trim().equals("") || 
					correctNull((String)rs.getString("loan_margin")).trim().equals("0")||
					correctNull((String)rs.getString("loan_margin")).trim().equals("0.0")||
					correctNull((String)rs.getString("loan_margin")).trim().equals("0.00"))
					{
						hshResult.put("margin_perct",correctNull((String)rs.getString("margin_perct")));
						margin_perct=correctNull((String)rs.getString("margin_perct"));
					}
					else
					{
						hshResult.put("margin_perct",correctNull((String)rs.getString("loan_margin")));
						margin_perct=correctNull((String)rs.getString("loan_margin"));
					}
										
					String strabc=Helper.correctNull((String)rs.getString("tradein"));
					if(strabc.equals(""))
					{
						strabc="0.00";
					}
					dblTradeIn=Double.parseDouble(strabc);					
					String strabc1=correctNull((String)rs.getString("loantrade"));
					if(strabc1.equals(""))
					{
						strabc1="0.00";
					}
					dblloanTradeIn=Double.parseDouble(strabc1);
					dblnetTradeIn=dblTradeIn-dblloanTradeIn;						
					hshResult.put("netTradein",correctNull(Helper.formatDoubleValue(dblnetTradeIn)));
					dblamtRequested=Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd")));
					dblcostLoanPrd=Double.parseDouble(Helper.correctDouble(rs.getString("cloanprd")));
					
					if(dblcostLoanPrd==dblamtRequested)
					{
						if(dblnetTradeIn==0.0)
						{
							dbldownPay=dblamtRequested-(dblamtRequested*dblloanValratio/100);
							dblAloanValratio=dblloanValratio;
						}
						else
						{
							dbldownPay=(dblamtRequested-(
							dblamtRequested*dblloanValratio/100))+dblnetTradeIn;
							dblAloanValratio=((dblamtRequested-dbldownPay)/dblamtRequested)*100;
						}
						dblamtRecommended=dblAloanValratio*dblamtRequested/100;
					}
					else if(dblcostLoanPrd > dblamtRequested)
					{
						double dblcostloan=(dblcostLoanPrd*dblloanValratio/100);
						if(dblcostloan<dblamtRequested)
						{
							dblamtRecommended=dblcostloan;
							dbldownPay=(dblcostLoanPrd-dblamtRecommended)+dblnetTradeIn;
						}
						else
						{
							dblamtRecommended=dblamtRequested;
							dbldownPay=(dblcostLoanPrd-dblamtRecommended)+dblnetTradeIn;
						}
						if(dblnetTradeIn>0)
						{
							dblamtRecommended=dblamtRecommended-dblnetTradeIn;
						}
						dblAloanValratio=((dblcostLoanPrd-dbldownPay)/dblcostLoanPrd)*100;
					}
					dblnumterms=correctNull((String)rs.getString("lterms"));
					dblmodintrate=Double.parseDouble(Helper.correctDouble(rs.getString("mintrate")));
					
					if(rs.getString("lreqterms")==null)
					{
						dblnumreqterms = 0.00;
					}
					else
					{
						dblnumreqterms = Double.parseDouble (Helper.correctDouble(rs.getString("lreqterms")));
					}
					hshResult.put("downpay",correctNull((String)rs.getString("downpay")));
					hshResult.put("sancmount",correctNull((String)rs.getString("sancamount")));
					hshResult.put("ramount",correctNull((String)rs.getString("raamount")));
					hshResult.put("actuallvalratio",correctNull(Helper.formatDoubleValue(dblAloanValratio)));
					hshResult.put("prd_renew",correctNull((String)rs.getString("prd_renew")));
					hshResult.put("hidClass",correctNull((String)rs.getString("hidclass")));
					hshResult.put("lreqterms",correctNull((String)rs.getString("lreqterms")));
					hshResult.put("loantermrange",correctNull((String)rs.getString("loan_termrange")));
					hshResult.put("loaninttype",correctNull((String)rs.getString("loan_inttype")));
					hshResult.put("loanpurposeofloan",Helper.CLOBToString(rs.getClob("loan_purposeofloan")));
					hshResult.put("loanfiledon",correctNull((String)rs.getString("loan_filedon")));
					hshResult.put("repaymenttype",correctNull((String)rs.getString("loan_repaymenttype")));
					hshResult.put("loan_repaycapacity",correctNull((String)rs.getString("loan_repaycapacity")));					
					hshResult.put("loan_bank_refno",correctNull((String)rs.getString("loan_bank_refno")));
					hshResult.put("loan_interestcharged",correctNull((String)rs.getString("loan_interestcharged")));
					hshResult.put("loan_steptype",correctNull((String)rs.getString("loan_steptype")));
					hshResult.put("loan_fileno", Helper.correctNull((String)rs.getString("loan_fileno")));
					hshResult.put("loan_intrate", Helper.correctNull((String)rs.getString("loan_intrate")));
					hshResult.put("prd_type", Helper.correctNull((String)rs.getString("prd_type")));
					hshResult.put("loan_receivedate", Helper.correctNull((String)rs.getString("loan_receivedate")));
					hshResult.put("perapp_salaryrouted", Helper.correctNull((String)rs.getString("perapp_salaryrouted")));
					hshResult.put("loan_deviationloanamount", Helper.correctNull((String)rs.getString("loan_deviationloanamount")));
					loan_deviationloanamount = Helper.correctNull((String)rs.getString("loan_deviationloanamount"));
					perapp_salaryrouted = Helper.correctNull((String)rs.getString("perapp_salaryrouted"));
					String strLoanDocFee="",strLoanProcFee="";
					if(!strPrdCode.trim().equals(""))
					{							
						if(correctNull((String)hshResult.get("amtreqd")).equals(""))
						{
							strRecAmt="0.00";
						}
						else
						{	
							double inttemp = 0.00;
							double inttemp1 = 0.00;
							String strTemp = correctNull((String)hshResult.get("amtreqd"));
							inttemp1 = inttemp * Double.parseDouble(strTemp);
							strRecAmt = Helper.formatDoubleValue(inttemp1);
						}		
						strLoanDocFee = (String)hshGetDocFee.get("docfee");
						strLoanProcFee = (String)hshGetDocFee.get("procfeenew");
					}					
					 rs=DBUtils.executeLAPSQuery("selapplicantname^"+strApplicationNo);
					 
					while(rs.next())
					{   						
						arrincome=new ArrayList();
						monincome=Helper.correctNull((String)rs.getString("netincome"));
						netincome=Helper.correctNull((String)rs.getString("netincome1"));	
						domesticexpenses=Helper.correctNull((String)rs.getString("perinc_othermondesc"));	
						arrincome.add(netincome);
						arrincome.add(domesticexpenses);
						arrincome.add(monincome);
						arrincome.add(Helper.correctNull((String)rs.getString("applicantname")));
						arrtotalnetincome.add(arrincome);
					}					
					if(rs!=null)
					{
						rs.close();
					}					
					hshResult.put("docfee",correctNull(strLoanDocFee));
					hshResult.put("procfee",correctNull(strLoanProcFee));					
				}
			}
			if(strHidMode.equalsIgnoreCase("Y"))
			{	
				String typeofint =(String)hshResult.get("loaninttype");
			 				
				String strIntType   = " ";	
				String  strLesser   = ">=";
				String  strGreater  = "<=";					
				HashMap hshStepup  = new HashMap();
				if(correctNull((String)hshResult.get("amtreqd")).equals(""))
				{ 
					strRecAmt="0.00";
				}
				else
				{	
					String strTemp = correctNull((String)hshResult.get("amtreqd"));
					strRecAmt = strTemp;
				}
				if(correctNull((String)hshResult.get("lreqterms")).equals(""))
				{
					strTerms="0.00";
				}
				else
				{
					strTerms=correctNull((String)hshResult.get("lreqterms"));
				}
				if(correctNull((String)hshResult.get("loaninttype")).equals(""))
				{
					strIntType=" ";
				}
				else
				{
					strIntType=correctNull((String)hshResult.get("loaninttype"));
				}
				hshStepup.put("recamt",strRecAmt);
				hshStepup.put("prdcode",strPrdCode);
				hshStepup.put("recamt",strRecAmt);
				hshStepup.put("terms",strTerms);
				hshStepup.put("inttype",strIntType);
				if(typeofint.equals("Fixed")||typeofint.equals("Floating"))
				{
					strQuery = SQLParser.getSqlQuery("selinttyperate^"+strIntType+"^"+strPrdCode+"^"+strGreater+"^"+strRecAmt+"^"+strLesser+"^"+strRecAmt+"^O^"+strGreater+"^"+strTerms+"^"+strLesser+"^"+strTerms);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{  	
						hshResult.put("prd_interest",correctNull((String)rs.getString("prd_interest")));
						prd_interest = correctNull((String)rs.getString("prd_interest"));
					}
					else
					{
						hshResult.put("prd_interest",correctNull("0.00"));				
					}
					dblmodintrate=dblmodintrate/(12*100);
					dbldenom=Math.pow(dblmodintrate+1,dblnumreqterms)-1;
					dblnumer=dblmodintrate*Math.pow(dblmodintrate+1,dblnumreqterms);
					dblemi=(dblnumer/dbldenom)*dblamtRecommended;
					dbltotalpay=dblemi*dblnumreqterms;
					hshResult.put("monthpay",correctNull(dc.format(dblemi)));
					hshResult.put("totalpay",correctNull(dc.format(dbltotalpay)));
					hshResult.put("strstepintrate","0.00");
					hshResult.put("strsteptoamt","0.00");
				}
				rs4=DBUtils.executeLAPSQuery("product_maxamount^"+strPrdCode);				 
				if(rs4.next())
				{
					productmaxamount=Helper.correctNull((String)rs4.getString("prd_rng_to"));
				}
				if(rs4!=null)
				{
					rs4.close();
				}
				rs=DBUtils.executeLAPSQuery("securesel^"+strApplicationNo);
				 
				if(rs.next())
				{	
					hshResult.put("loan_noofinstallment",(String)correctNull((String)rs.getString("loan_noofinstallment")));
					loan_noofinstallment=correctNull((String)rs.getString("loan_noofinstallment"));
					hshResult.put("loan_noofinstallment",loan_noofinstallment);
				}
				hshResult.put("strstepintrate",correctNull(strstepintrate));
				hshResult.put("strsteptoamt",correctNull(strsteptoamt));
				hshResult.put("prop_totalcost",prop_totalcost);
				try
				{	if(rs!=null)
					{
						rs.close();
					} 
				}
				catch(Exception exp)
				{
					throw new EJBException("Error in closing Connection in get"+exp.getMessage());		
				}
			}
			HashMap hshRecord = new HashMap();
			String Monthltyincome="";
			String strAppno="";
			String strPrdid="";
			String strAmtReq="";
			String strMonthlyEMI="0.00";
			String strCostLoanPrd="0.00";
			String Grossincome="";
			String strnoofterms ="";
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
			//String strAppid="";
			try
			{				
				strPrdid=strPrdCode;
				strAmtReq=strRecAmt;
				strnoofterms = strTerms;
				String strActualMargin = margin_perct;
				rs=DBUtils.executeLAPSQuery("selloan_details^"+strAppno);
				 
				if(rs.next())
				{
					strMonthlyEMI = correctNull((String)rs.getString("emi"));
				}
				if(rs!=null)
				{
					rs.close();
				}				
				rs=DBUtils.executeLAPSQuery("sel_perappApraisal_incomeexpenses1^"+strApplicationNo);
				 
				if(rs.next())
				{
					perapp_id = correctNull((String)rs.getString("perapp_id"));
					ApplicantIncome = correctNull((String)rs.getString("yearnetincome"));
					Monthltyincome = correctNull((String)rs.getString("monthlyincome"));
					applicantname =correctNull((String)rs.getString("applicantname"));
					Grossincome =correctNull((String)rs.getString("perinc_monsalary"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				strCostLoanPrd =prop_totalcost;
				HashMap hshTemp=new HashMap();
				//hshTemp.put("orgappno",strAppno);
				//hshTemp.put("prdid",strPrdid);
				//hshTemp.put("amtreq",strAmtReq);
				//hshTemp.put("nooftrms",strnoofterms);				
				//hshTemp.put("margin",strActualMargin);
				//hshTemp.put("monthlyemi",strMonthlyEMI);
				//hshTemp.put("strUserId",strUserId);
				//hshTemp.put("costofloanprd",strCostLoanPrd);
				hshResult.put("strApp",strPrimayDetails);
				hshResult.put("hidEditLock",strEditLock);
				hshResult.put("hidEditMode",correctNull((String)hshValues.get("hidEditMode")));
				hshResult.put("page",strPage);
				hshResult.put("productmaxamount",productmaxamount);		
				hshResult=(HashMap)EJBInvoker.executeStateLess("perlimitofloan",hshTemp,"getData");
				rs=DBUtils.executeLAPSQuery("sel_prdinterest^"+strPrdCode);
				 
				if(rs.next())
				{					
					hshResult.put("prd_selfretireage",correctNull((String)rs.getString("prd_selfretireage")));
					hshResult.put("prd_empretireage",correctNull((String)rs.getString("prd_empretireage")));					
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("pergetemploy^"+perapp_id);
				 
				if(rs.next())
				{					
					hshResult.put("perapp_employment",correctNull((String)rs.getString("perapp_employment")));									
				}				
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("check_emiabcdlogic^"+strappno);
				 
				bState1 = rs.next();
				if(bState1)
				{
					CheckbState1="True";
				}
				else
				{
					CheckbState1="False";
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("per_auto_vehicletype^"+strappno);
				 
				if(rs.next())
				{
					hshResult.put("auto_category",Helper.correctNull((String)rs.getString("auto_category")));
					auto_category = Helper.correctNull((String)rs.getString("auto_category"));
					hshResult.put("total_newvehiclecost", Helper.correctNull((String)rs.getString("total_newvehiclecost")));
					hshResult.put("auto_leastvalue", Helper.correctNull((String)rs.getString("auto_leastvalue")));
				}
				if(rs!=null)
				{
					rs.close();
				}				
			
				rs=DBUtils.executeLAPSQuery("setproductssel^"+strPrdCode);
				 
				if(rs.next())
				{	
					hshResult.put("prd_type",correctNull((String)rs.getString("prd_type")));
					prd_type = Helper.correctNull((String)rs.getString("prd_type"));
					/*rs=DBUtils.executeLAPSQuery("sel_prdinterest^"+strPrdCode);
					 
					if(rs.next())
					{	
						hshResult.put("prd_lvr",correctNull((String)rs.getString("prd_lvr")));
						hshResult.put("prd_oldvehiclemargin",correctNull((String)rs.getString("prd_oldvehiclemargin")));
						prd_oldvehiclemargin = correctNull((String)rs.getString("prd_oldvehiclemargin"));
					}*/
				}			
				if(rs!=null)
				{
					rs.close();
				}	
				rs=DBUtils.executeLAPSQuery("sel_edutype^"+strappno);
				 
				if(rs.next())
				{
					hshResult.put("edu_studies_in",Helper.correctNull((String)rs.getString("edu_studies_in")));
					edu_studies_in = Helper.correctNull((String)rs.getString("edu_studies_in"));
				}				
				if(rs!=null)
				{
					rs.close();
				}
				String comme_type="ES";
				strQuery = SQLParser.getSqlQuery("sel_perapp_Apprisal2^"+strappno+"^"+comme_type+"^"+perapp_id);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{					
					Ques2 = correctNull((String)rs.getString("Ques2"));									
				}
				hshResult.put("orgappno",strAppno);
				hshResult.put("prdid",strPrdid);
				hshResult.put("hshResult",hshRecord);
				hshResult.put("strApp",strPrimayDetails);
				hshResult.put("hidEditLock",strEditLock);
				hshResult.put("hidEditMode",correctNull((String)hshValues.get("hidEditMode")));
				hshResult.put("page",strPage);
				hshResult.put("productmaxamount",productmaxamount);				
				hshResult.put("strstepintrate",correctNull(strstepintrate));
				hshResult.put("strsteptoamt",correctNull(strsteptoamt));
				hshResult.put("prop_totalcost",prop_totalcost);
				hshResult.put("amtreqd",strAmtReq);
				hshResult.put("prd_interest",prd_interest);
				hshResult.put("mintrate",mintrate);
				hshResult.put("strrecommendedloanamount",strrecommendedloanamount);
				hshResult.put("txt_minmargin",emi_minmargin);
				hshResult.put("txt_permisibleloanB",emi_permisibleloanamount);
				hshResult.put("txt_minmarginvalue",emi_minmarginvalue);
				hshResult.put("txt_Leastamount",emi_leastamount);
				hshResult.put("txt_recommloanamount",emi_sancamount);
				hshResult.put("nooftrms",strnoofterms);
				hshResult.put("loan_noofinstallment",loan_noofinstallment);
				hshResult.put("cloanprd",cloanprd);
				hshResult.put("marginvalue",marginvalue);
				hshResult.put("arrtotalnetincome",arrtotalnetincome);
				hshResult.put("loan_repaycapacity",loan_repaycapacity);
				hshResult.put("ApplicantIncome",ApplicantIncome);
				hshResult.put("Monthltyincome",monthlyincome);
				hshResult.put("Monthltyincome",Monthltyincome);
				hshResult.put("hidAction",strAction);
				hshResult.put("sancamount",sancamount);
				hshResult.put("bstate",CheckbState1);
				hshResult.put("monincome", monincome);
				hshResult.put("applicantname",applicantname);
				hshResult.put("prd_type",prd_type);
				hshResult.put("auto_category",auto_category);
//				hshResult.put("prd_oldvehiclemargin",prd_oldvehiclemargin);
				hshResult.put("edu_studies_in",edu_studies_in);
				hshResult.put("perapp_salaryrouted", perapp_salaryrouted);
				hshResult.put("Ques2",Ques2);
				hshResult.put("Grossincome",Grossincome);
				hshResult.put("loan_deviationloanamount",loan_deviationloanamount);				
//				String Eval="e";
//				String Exp="s";
//				strQuery=SQLParser.getSqlQuery("educoursedet^"+strAppno+"^"+Eval);
//				rs=DBUtils.executeQuery(strQuery);
//				ArrayList eduarrRowEval=new ArrayList();
//				ArrayList arrCol=new ArrayList();
//				String temp1="";
//				String temp2="";
//				String temp3="";
//				String temp4="";
//				String temp5="";
//				String temp6="";				
//				while(rs.next())
//				{
//					arrCol=new ArrayList();
//					arrCol.add(correctNull((String)rs.getString("edu_id")));
//					temp1=correctNull((String)rs.getString("edu_year1"));
//					if(temp1.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year1")));
//					}					
//					temp2=correctNull((String)rs.getString("edu_year2"));
//					if(temp2.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year2")));
//					}
//					temp3=correctNull((String)rs.getString("edu_year3"));
//					if(temp3.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year3")));
//					}
//					temp4=correctNull((String)rs.getString("edu_year4"));
//					if(temp4.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year4")));
//					}
//					temp5=correctNull((String)rs.getString("edu_year5"));
//					if(temp5.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year5")));
//					}
//					temp6=correctNull((String)rs.getString("edu_year6"));
//					if(temp6.equalsIgnoreCase(""))
//					{
//						arrCol.add("0");
//					}
//					else
//					{
//						arrCol.add(correctNull((String)rs.getString("edu_year6")));
//					}
//					arrCol.add(correctNull((String)rs.getString("edu_comments")));
//					eduarrRowEval.add(arrCol);
//				}
//				hshResult.put("EduarrRowEval",eduarrRowEval);
//				if(rs!=null)
//				{
//					rs.close();
//				}
//				strQuery=SQLParser.getSqlQuery("educoursedet^"+strAppno+"^"+Exp);
//				rs=DBUtils.executeQuery(strQuery);
//				ArrayList eduarrRowEval1=new ArrayList();
//				ArrayList arrCol1=new ArrayList();
//				temp1="";
//				temp2="";
//				temp3="";
//				temp4="";
//				temp5="";
//				temp6="";
//				while(rs.next())
//				{
//					arrCol1=new ArrayList();
//					arrCol1.add(correctNull((String)rs.getString("edu_id")));
//					temp1=correctNull((String)rs.getString("edu_year1"));
//					if(temp1.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//					arrCol1.add(correctNull((String)rs.getString("edu_year1")));
//					}
//					
//					temp2=correctNull((String)rs.getString("edu_year2"));
//					if(temp2.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//						arrCol1.add(correctNull((String)rs.getString("edu_year2")));
//					}
//					temp3=correctNull((String)rs.getString("edu_year3"));
//					if(temp3.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//					arrCol1.add(correctNull((String)rs.getString("edu_year3")));
//					}
//					temp4=correctNull((String)rs.getString("edu_year4"));
//					if(temp4.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//						arrCol1.add(correctNull((String)rs.getString("edu_year4")));
//					}
//					temp5=correctNull((String)rs.getString("edu_year5"));
//					if(temp5.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//						arrCol1.add(correctNull((String)rs.getString("edu_year5")));
//					}
//					temp6=correctNull((String)rs.getString("edu_year6"));
//					if(temp6.equalsIgnoreCase(""))
//					{
//						arrCol1.add("0");
//					}
//					else
//					{
//						arrCol1.add(correctNull((String)rs.getString("edu_year6")));
//					}
//					arrCol1.add(correctNull((String)rs.getString("edu_comments")));
//					eduarrRowEval1.add(arrCol1);
//				}
//				hshResult.put("EduarrRowEval1",eduarrRowEval1);
				if(rs!=null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("perotherassetselect^"+strAppno+"^1");
				rs=DBUtils.executeQuery(strQuery);
				double MeditectTotalCost = 0.00;
				double MeditectTotalCost1 = 0.00;				
				while(rs.next())
				{
					MeditectTotalCost = Double.parseDouble(Helper.correctDouble((String)rs.getString("asset_puchaseprice")));
					MeditectTotalCost1 = MeditectTotalCost1 + MeditectTotalCost;
				}
				hshResult.put("MeditectTotalCost", Helper.formatDoubleValue(MeditectTotalCost1));
				if(rs!=null)
				{
					rs.close();
				}
				/*strQuery=SQLParser.getSqlQuery("selapplicant_byappno^"+strAppno+"^a");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("perapp_emp",Helper.correctNull((String)rs.getString("perapp_eduothers")));
					hshResult.put("perapp_salaryrouted",Helper.correctNull((String)rs.getString("perapp_salaryrouted")));
				}*/
				strQuery=SQLParser.getSqlQuery("selincexp_byappno^"+strAppno+"^a");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{	
					String inc_proof=Helper.correctNull((String)rs.getString("perinc_proof"));
					if(inc_proof.equalsIgnoreCase(""))
					{
						inc_proof="0";
					}
					hshResult.put("perinc_proof",inc_proof);
				}
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in getData login lifestyle "+ce.toString());
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
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in closing getData"+ce.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}	
				if(rs4!=null)
				{
					rs4.close();
				}
			}
			catch(Exception e)
			{
				throw new EJBException("Error in closing Connection "+e.getMessage());
			}
		}
		return hshResult;
	}
	
	public  HashMap getEMIAGRIData(HashMap hshValues) 
	{		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs = null;
		HashMap hshResult = new HashMap();	
	//	ArrayList arryRow = new ArrayList();
	//	ArrayList arryCol = null;
	//	double crop_leastamt=0.00;
		String recordflag="N";
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next())
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull((String)rs1.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull((String)rs1.getString("app_status"))));
				hshResult.put("applicantid", rs1.getString("demo_appid"));
			}
			strQuery = SQLParser.getSqlQuery("per_get_assesmentdetails^" + appno+"^"+"k1");
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				hshResult.put("loan_amount_kh",correctNull((String)rs1.getString("loan_amount")));
			}
			strQuery = SQLParser.getSqlQuery("per_get_assesmentdetails^" + appno+"^"+"r1");
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				hshResult.put("loan_amount_rb",correctNull((String)rs1.getString("loan_amount")));
			}
			strQuery = SQLParser.getSqlQuery("per_get_assesmentdetails^" + appno+"^"+"s1");
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				hshResult.put("loan_amount_su",correctNull((String)rs1.getString("loan_amount")));
			}
			strQuery = SQLParser.getSqlQuery("per_get_assesmentdetails^" + appno+"^"+"a1");
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				hshResult.put("loan_amount_an",correctNull((String)rs1.getString("loan_amount")));
			}
			strQuery = SQLParser.getSqlQuery("per_get_assesmentdetails^" + appno+"^"+"p1");
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				hshResult.put("loan_amount_pe",correctNull((String)rs1.getString("loan_amount")));
			}
								
			strQuery = SQLParser.getSqlQuery("per_get_capital^"+appno);	
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 =DBUtils.executeQuery(strQuery);
			double totworkcap=0.00;
			double totworkcap1=0.00;
			double totworkcap2=0.00;
			double crop_roiwc=0.00;
			while(rs1.next())
			{
				totworkcap1 = totworkcap1 + Double.parseDouble(Helper.correctDouble((String)rs1.getString("crop_requirements")));
				
				hshResult.put("crop_roiwc",correctNull((String)rs1.getString("crop_roiwc")));
				crop_roiwc=Double.parseDouble(Helper.correctDouble((String)rs1.getString("crop_roiwc")));
			}
			totworkcap2=(crop_roiwc/100)*totworkcap1;
			totworkcap=totworkcap1-totworkcap2;
			hshResult.put("totworkcap",Helper.formatDoubleValue(totworkcap));
			
			
			
			boolean bstate;
			strQuery = SQLParser.getSqlQuery("sel_agr_termloans^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 = DBUtils.executeQuery(strQuery);
			String grossmon=null;
			String expenses=null;
			String estimated = "";
			String marg="";
			double temp1=0;
			double temp2=0;
			double temp3=0;
			double temp4=0;
			double temp5=0;
			double temptotmar=0;
			double tempest=0;
			double tempmar=0;
			bstate = rs1.next();
			//ArrayList grossExp = null;
			//ArrayList grossExpRow = new ArrayList();
			if(bstate == true)
			{
				while(rs.next())
				{
					temp1=0;
					temp2=0;
					temp3=0;
					temp4=0;
					
					grossmon = Helper.correctNull((String)rs.getString("agr_grossincome"));
					expenses = Helper.correctNull((String)rs.getString("agr_totalexpenditure"));
					if(grossmon.equalsIgnoreCase(""))
					{
						grossmon="0.00";
					}
					if(expenses.equalsIgnoreCase(""))
					{
						expenses="0.00";
					}
					temp1= Double.parseDouble(Helper.correctDouble((String)grossmon)) * 12 ;
					temp2=Double.parseDouble(Helper.correctDouble((String)expenses)) * 12;
					temp3=(temp1)-(temp2);

					estimated = Helper.correctNull((String)rs.getString("agr_estimatedcost"));
					if(estimated.equalsIgnoreCase(""))
					{
						estimated = "0.00";
					}
					tempest=Double.parseDouble(Helper.correctDouble((String)estimated));
					
					marg = Helper.correctNull((String)rs.getString("agr_margin"));
					if(marg.equalsIgnoreCase(""))
					{
						marg = "0.00";
					}
					tempmar=Double.parseDouble(Helper.correctDouble((String)marg));
					temp4 = tempest - tempmar; 
					temp5 = temp5 + temp4;
					temptotmar = temptotmar + tempmar; 
				
				}
			}
			hshResult.put("totloanamt",Helper.formatDoubleValue(temp5));
// ================================================
			/*strQuery = SQLParser.getSqlQuery("per_get_coffeeassesmentdata^" + appno);
			rs2 = DBUtils.executeQuery(strQuery);
			double coffee_leastamt=0.00;
			while (rs2.next())
			{
			coffee_leastamt=Double.parseDouble((Helper.correctDouble((String)rs2.getString("coffee_leastamt"))));
			
			}
			hshResult.put("coffee_leastamt",Helper.formatDoubleValue(coffee_leastamt));
	
//			-------------------------------------------------	
			strQuery = SQLParser.getSqlQuery("per_get_interassesment^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			while (rs1.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs1.getString("crop_leastamount"));
				crop_leastamt = crop_leastamt + Double.parseDouble((Helper.correctDouble((String)rs1.getString("crop_leastamount"))));
				arryRow.add(arryCol);
			}
			hshResult.put("crop_leastamt",Helper.formatDoubleValue(crop_leastamt));	*/	
			strQuery = SQLParser.getSqlQuery("agr_get_croploan^"+appno);	
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1 =DBUtils.executeQuery(strQuery);
			double prdcredit=0.00,consumption=0.00,contingency=0.00;
			double margincom=0.00;
			double margincom1=0.00;double crop_adhocval=0.00;
			double crop_adhoclimit=0.00;
			double crop_adhocval1=0.00;
			while(rs1.next())
			{
				hshResult.put("crop_prdcredit",correctNull((String)rs1.getString("crop_prdcredit")));
				prdcredit=Double.parseDouble((Helper.correctDouble(rs1.getString("crop_prdcredit"))));
				hshResult.put("crop_consumption",correctNull((String)rs1.getString("crop_consumption")));
				consumption=Double.parseDouble((Helper.correctDouble(rs1.getString("crop_consumption"))));
				margincom=(consumption/prdcredit)*100;
				margincom=Math.round(margincom);
				hshResult.put("margincom",Helper.formatDoubleValue(margincom));
				hshResult.put("crop_operativelimit",correctNull((String)rs1.getString("crop_operativelimit")));
				hshResult.put("crop_contingency",correctNull((String)rs1.getString("crop_contingency")));
				contingency=Double.parseDouble((Helper.correctDouble(rs1.getString("crop_contingency"))));
				margincom1=(contingency/prdcredit)*100;
				margincom1=Math.round(margincom1);
				hshResult.put("margincom1",Helper.formatDoubleValue(margincom1));
			
				hshResult.put("crop_adhoclimit",correctNull((String)rs1.getString("crop_adhoclimit")));
				crop_adhoclimit=Double.parseDouble((Helper.correctDouble(rs1.getString("crop_adhoclimit"))));
				hshResult.put("crop_documentation",correctNull((String)rs1.getString("crop_documentation")));
				crop_adhocval=Double.parseDouble((Helper.correctDouble(rs1.getString("crop_adhocval"))));
				crop_adhocval1=(crop_adhoclimit/crop_adhocval)*100;
				crop_adhocval1=Math.round(crop_adhocval1);
				hshResult.put("crop_adhocval",Helper.formatDoubleValue(crop_adhocval1));
				hshResult.put("crop_firsthighest",correctNull((String)rs1.getString("crop_firsthighest")));
				hshResult.put("crop_secondhighest",correctNull((String)rs1.getString("crop_secondhighest")));
				hshResult.put("crop_loan",correctNull((String)rs1.getString("crop_loan")));
				hshResult.put("crop_total_loan",correctNull((String)rs1.getString("crop_total_loan")));
				hshResult.put("crop_total_coffeeloan",correctNull((String)rs1.getString("crop_total_coffeeloan")));
				recordflag="Y";
				hshResult.put("recordflag",recordflag);
			}	
			
		return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs1 != null)
				{
					rs1.close();
				}
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
	}

//	farm mechanisation

	public  HashMap getfarmemiData(HashMap hshValues) 
	{		
		String strQuery="";
		long ownacre = 0;
		long ownGuntas = 0;
		long ownmachine = 0;
		long ofamilyacre = 0;
		long ofamilyGuntas = 0;
		long ofamilymachine = 0;
		long customacre = 0;
		long customGuntas = 0;
		long custommachine = 0, totowncusmachin=0;
		String measurement="", ownfamilyacre="", totownfammachine="",owncusgunt="";
		String cusacr="", cusgunt="", cususage="";
		String netamt="" , strProductType="";
		long temp1=0, tmpownfammachine=0;
		long temp2=0, temp3=0;
		long tmpcusguntas=0, tmpcusguntas1=0, totowncusacre=0;
		
		double repair_cost_am =0, fuel_cost_am =0, insurence_am=0, other_cost_am=0,Totalexpense_am=0,agr_expect_addition=0;
		double cropinterest_am=0, bullockmaintanence_am=0,driversalary_am=0;
		double totnetincome_bm=0, totnetincome_am=0, totcustomerservice_am=0 ,Totalexpense_bm=0;
		double netincrementalinc_am=0,netincrementalinc_bm=0, incrementalincome=0;
		double cropinterest_bm=0, bullockmaintanence_bm=0;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		HashMap hshResult = new HashMap();	
		
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			strProductType=correctNull((String)hshValues.get("strProductType"));
			
			strQuery = SQLParser.getSqlQuery("agrcomfunsel2^" + appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if (rs1.next())
			{
				hshResult.put("app_name", Helper.correctDoubleQuote(correctNull((String)rs1.getString("app_name"))));
				hshResult.put("app_status", Helper.correctDoubleQuote(correctNull((String)rs1.getString("app_status"))));
				hshResult.put("applicantid", rs1.getString("demo_appid"));
			}
			
			if(rs1!=null)
				rs1.close();
			strQuery = SQLParser.getSqlQuery("agr_selcroppingpatterndata^"+appno);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshResult.put("appno",Helper.correctNull((String)rs1.getString("appno")));
				totnetincome_bm=Double.parseDouble(Helper.correctDouble((String)rs1.getString("totnetincomee")));
				totnetincome_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("totnetincomep")));
				hshResult.put("totnetincome_bm",Helper.formatDoubleValue(totnetincome_bm));
				hshResult.put("totnetincome_am",Helper.formatDoubleValue(totnetincome_am));
				hshResult.put("totnetincome",Helper.correctNull((String)rs1.getString("totnetincome")));
				hshResult.put("totmaintenance",Helper.correctNull((String)rs1.getString("totmaintenance")));
				hshResult.put("totnetincyear",Helper.correctNull((String)rs1.getString("totnetincyear")));
			}		
			
			strQuery = SQLParser.getSqlQuery("sellandrevenue^"+appno);
			if(rs1!=null)
				rs1.close();
			rs1 = DBUtils.executeQuery(strQuery);
			double landrevenue=0;
			if(rs1.next())
			{
				landrevenue= Double.parseDouble(Helper.correctDouble((String)rs1.getString("landrevenue")));
			}
			
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			if(rs1!=null)
				rs1.close();
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				measurement = rs1.getString("land_measurement");
			}
			
			if(strProductType.equalsIgnoreCase("aF"))
			{
				strQuery = SQLParser.getSqlQuery("agr_selfarmmechanism^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					ownacre = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_olandacre")));
					ownGuntas = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_oguntas")));
					ownmachine = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_omachinery")));
					
					ofamilyacre = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_omember")));
					ofamilyGuntas = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_omem_guntas")));
					ofamilymachine = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_omem_machinery")));
				
					customacre = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_clandacre")));
					cusacr=Helper.correctNull((String)rs1.getString("agr_clandacre"));
					customGuntas = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_cguntas")));
					cusgunt=Helper.correctNull((String)rs1.getString("agr_cguntas"));
					custommachine = Integer.parseInt((String)Helper.correctDouble(rs1.getString("agr_cmachinery")));
					cususage=Helper.correctNull((String)rs1.getString("agr_cmachinery"));
					totcustomerservice_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_cmember")));
					
					//babu
					repair_cost_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_repair_cost")));
					cropinterest_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("AGR_INTEREST")));
					bullockmaintanence_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("AGR_BULLOCK_COST")));
					driversalary_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("AGR_SALARY")));
					fuel_cost_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_fuel_cost")));
					insurence_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_insurence")));
					other_cost_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_other_cost")));
					
					cropinterest_bm=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_interestbm")));
					bullockmaintanence_bm=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_bullockcostbm")));
					netamt= rs1.getString("netamt");
				
					//Total Usage machinery(ownmachinery + familymembermachinery)
					tmpownfammachine = ownmachine + ofamilymachine;
					totownfammachine = Integer.toString((int)tmpownfammachine);
				
					//Find out the total of own machinery usage + custom service machine usage
					totowncusmachin = tmpownfammachine + custommachine;
				 
					if(measurement.equalsIgnoreCase("g"))
					{
						temp1= ownGuntas + ofamilyGuntas+customGuntas;
						while(temp1>39)
						{
							temp2=temp2+1;
							temp1=temp1-40;
						}
						temp3= ownacre + ofamilyacre+customacre;
						temp3 = temp3 + temp2;
						ownfamilyacre = Integer.toString((int)temp3);
						ownfamilyacre = ownfamilyacre +"."+ temp1;
						
						// Find out the total of ownland acre + customer acre
						tmpcusguntas = temp1 + customGuntas+customGuntas;
						while(tmpcusguntas>39)
						{
							tmpcusguntas1=tmpcusguntas1 + 1;
							tmpcusguntas=tmpcusguntas-40;
						}
						totowncusacre = customacre + temp3;
						totowncusacre = totowncusacre + tmpcusguntas1;
						owncusgunt = Integer.toString((int)totowncusacre);
						owncusgunt = owncusgunt +"."+ tmpcusguntas;				
					} //measurement guntas end
					else if(measurement.equalsIgnoreCase("c"))
					{
						temp1= ownGuntas + ofamilyGuntas+customGuntas;
						while(temp1>99)
						{
							temp2=temp2+1;
							temp1=temp1-100;
						}
						temp3= ownacre + ofamilyacre+customacre;
						temp3 = temp3 + temp2;
						ownfamilyacre = Integer.toString((int)temp3);
						ownfamilyacre = ownfamilyacre +"."+ temp1;
						
						// Find out the total of ownland acre + customer acre
						tmpcusguntas = temp1 + customGuntas;
						while(tmpcusguntas>99)
						{
							tmpcusguntas1=tmpcusguntas1 + 1;
							tmpcusguntas=tmpcusguntas-100;
						}
						totowncusacre = customacre + temp3;
						totowncusacre = totowncusacre + tmpcusguntas1;
						owncusgunt = Integer.toString((int)totowncusacre);
						owncusgunt = owncusgunt +"."+ tmpcusguntas;		
						
					}//measurement cents end
				}
				Totalexpense_am=(repair_cost_am + cropinterest_am +
					bullockmaintanence_am + driversalary_am +
					fuel_cost_am + insurence_am + landrevenue + other_cost_am);
			
				Totalexpense_bm=landrevenue+cropinterest_bm+bullockmaintanence_bm;
				
				netincrementalinc_am=totnetincome_am - Totalexpense_am + totcustomerservice_am;
				netincrementalinc_bm=totnetincome_bm-Totalexpense_bm;
			
				incrementalincome =netincrementalinc_am-netincrementalinc_bm;
			
				hshResult.put("agr_repair_cost_am",Helper.formatDoubleValue(repair_cost_am));
				hshResult.put("agr_interest_am",Helper.formatDoubleValue(cropinterest_am));
				hshResult.put("agr_bullock_cost_am",Helper.formatDoubleValue(bullockmaintanence_am));
				hshResult.put("agr_salary_am",Helper.formatDoubleValue(driversalary_am));
				hshResult.put("agr_fuel_cost_am",Helper.formatDoubleValue(fuel_cost_am));
				hshResult.put("agr_insurence_am",Helper.formatDoubleValue(insurence_am));
				hshResult.put("agr_other_cost_am",Helper.formatDoubleValue(other_cost_am));
				hshResult.put("landrevenue_am",Helper.formatDoubleValue(landrevenue));
				hshResult.put("totcustomerservice_am", Helper.formatDoubleValue(totcustomerservice_am));
				
				hshResult.put("agr_interest_bm", Helper.formatDoubleValue(cropinterest_bm));
				hshResult.put("agr_bullock_cost_bm", Helper.formatDoubleValue(bullockmaintanence_bm));
				hshResult.put("netamt",netamt);
			
				hshResult.put("Totalexpense_am",Helper.formatDoubleValue(Totalexpense_am));
				hshResult.put("Totalexpense_bm",Helper.formatDoubleValue(Totalexpense_bm));
				hshResult.put("netincrementalinc_bm",Helper.formatDoubleValue(netincrementalinc_bm));
				hshResult.put("netincrementalinc_am",Helper.formatDoubleValue(netincrementalinc_am));
			
				hshResult.put("ownfamilyacre",ownfamilyacre);
				hshResult.put("ownfamilymachine",totownfammachine);
				hshResult.put("cusacr",cusacr+"."+cusgunt);
				hshResult.put("cususage",cususage);
				hshResult.put("owncusgunt",owncusgunt);
				hshResult.put("totowncusmachin",Integer.toString((int)totowncusmachin));
			}
			if(strProductType.equalsIgnoreCase("aU"))
			{
				strQuery = SQLParser.getSqlQuery("agr_selfarmmechMinorIrrig^"+appno);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					totcustomerservice_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_waterProposeInc")));
					repair_cost_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_elecworks")));
					other_cost_am=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_netamount")));
					agr_expect_addition=Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_expect_addition")));
					
				}	
				hshResult.put("totcustomerservice1",Helper.formatDoubleValue(totcustomerservice_am));
				hshResult.put("agr_netIncomeIrrig", Helper.formatDoubleValue(other_cost_am));
				hshResult.put("agr_elecworks", Helper.formatDoubleValue(repair_cost_am));
				hshResult.put("agr_expect_addition", Helper.formatDoubleValue(agr_expect_addition));
				incrementalincome=(totnetincome_am-totnetincome_bm) + totcustomerservice_am + agr_expect_addition +
									other_cost_am-repair_cost_am;
			}
			
			hshResult.put("incrementalincome",Helper.formatDoubleValue(incrementalincome));
			
			return hshResult;
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
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
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}		
	}
//	eligibility fr crop loan
	public void  updateEMIAGRIData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery =  new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String appno=correctNull((String)hshValues.get("strappno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = Helper.correctNull((String)hshValues.get("appno"));
		}
		//ResultSet rs = null;
		try
		{			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues.put("size","4");
				hshQuery.put("strQueryId","agr_del_croploan");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","agr_del_assesment");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				
	            hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(appno);
				String txt_prdcredit=Helper.correctNull((String) hshValues.get("txt_prdcredit"));
				if(txt_prdcredit.equalsIgnoreCase(""))
				{
					txt_prdcredit="0";
				}
				arrValues.add(txt_prdcredit);				
				String txt_consumption=Helper.correctNull((String) hshValues.get("txt_consumption"));
				if(txt_consumption.equalsIgnoreCase(""))
				{
					txt_consumption="0";
				}
				arrValues.add(txt_consumption);
				String txt_operativelimit=Helper.correctNull((String) hshValues.get("txt_operativelimit"));
				if(txt_operativelimit.equalsIgnoreCase(""))
				{
					txt_operativelimit="0";
				}
				arrValues.add(txt_operativelimit);
				String txt_contingency=Helper.correctNull((String) hshValues.get("txt_contingency"));
				if(txt_contingency.equalsIgnoreCase(""))
				{
					txt_contingency="0";
				}
				arrValues.add(txt_contingency);
				String txt_adhoclimit=Helper.correctNull((String) hshValues.get("txt_adhoclimit"));
				if(txt_adhoclimit.equalsIgnoreCase(""))
				{
					txt_adhoclimit="0";
				}
				arrValues.add(txt_adhoclimit);
				String txt_documentation=Helper.correctNull((String) hshValues.get("txt_documentation"));
				if(txt_documentation.equalsIgnoreCase(""))
				{
					txt_documentation="0";
				}
				arrValues.add(txt_documentation);
				String adhocval=Helper.correctNull((String) hshValues.get("txt_total_coffee"));
				if(adhocval.equalsIgnoreCase(""))
				{
					adhocval="0";
				}
				arrValues.add(adhocval);
				//added
				String txt_firstHighest=Helper.correctNull((String) hshValues.get("txt_firstHighest"));
				if(txt_firstHighest.equalsIgnoreCase(""))
				{
					txt_firstHighest="0";
				}
				arrValues.add(txt_firstHighest);
				String txt_secondHighest=Helper.correctNull((String) hshValues.get("txt_secondHighest"));
				if(txt_secondHighest.equalsIgnoreCase(""))
				{
					txt_secondHighest="0";
				}
				arrValues.add(txt_secondHighest);
				String txt_crop_loan=Helper.correctNull((String) hshValues.get("txt_crop_loan"));
				if(txt_crop_loan.equalsIgnoreCase(""))
				{
					txt_crop_loan="0";
				}
				arrValues.add(txt_crop_loan);
				String txt_total_crop_loan=Helper.correctNull((String) hshValues.get("txt_total_crop_loan"));
				if(txt_total_crop_loan.equalsIgnoreCase(""))
				{
					txt_total_crop_loan="0";
				}
				arrValues.add(txt_total_crop_loan);
				String txt_total_coffee=Helper.correctNull((String) hshValues.get("txt_total_coffee"));
				if(txt_total_coffee.equalsIgnoreCase(""))
				{
					txt_total_coffee="0";
				}
				arrValues.add(txt_total_coffee);
				
				//hshQueryValues.put("size", "2");
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "agr_ins_croploan");
				hshQueryValues.put("3", hshQuery);
				
				
				
				   hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(appno);
					String txt_amount_pe=Helper.correctNull((String) hshValues.get("txt_amount_pe"));
					if(txt_amount_pe.equalsIgnoreCase(""))
					{
						txt_amount_pe="0";
					}
					arrValues.add(txt_amount_pe);				
					String txt_amount_an=Helper.correctNull((String) hshValues.get("txt_amount_an"));
					if(txt_amount_an.equalsIgnoreCase(""))
					{
						txt_amount_an="0";
					}
					arrValues.add(txt_amount_an);
					String txt_amount_kh=Helper.correctNull((String) hshValues.get("txt_amount_kh"));
					if(txt_amount_kh.equalsIgnoreCase(""))
					{
						txt_amount_kh="0";
					}
					arrValues.add(txt_amount_kh);
					String txt_amount_rb=Helper.correctNull((String) hshValues.get("txt_amount_rb"));
					if(txt_amount_rb.equalsIgnoreCase(""))
					{
						txt_amount_rb="0";
					}
					arrValues.add(txt_amount_rb);
					String txt_amount_su=Helper.correctNull((String) hshValues.get("txt_amount_su"));
					if(txt_amount_su.equalsIgnoreCase(""))
					{
						txt_amount_su="0";
					}
					arrValues.add(txt_amount_su);
					
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "agr_ins_assesment");
					hshQueryValues.put("4", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_del_croploan");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}
			/*if(strAction.equalsIgnoreCase("insert"))
				
			{	ArrayList arrValues1=new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				String txt_documentation=Helper.correctNull((String) hshValues.get("txt_documentation"));
				if(txt_documentation.equalsIgnoreCase(""))
				{
				txt_documentation="0";
				}
				arrValues1.add(txt_documentation);
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","agr_ins_loandetail");
				arrValues1.add(appno);
				hshQuery.put("arrValues",arrValues1);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");  
			}*/
			
			//Added By Zahoorunnisa.S for Audit Trial
			StringBuilder sbAuditTrial=new StringBuilder();
			if (strAction.equalsIgnoreCase("insert") || strAction.equalsIgnoreCase("update")) {
					
				sbAuditTrial.append("Crop Loan Eligible for different Perennial Crops=").append(correctNull((String )hshValues.get("txt_amount_pe"))+" (A)")
				.append("~Crop Loan Eligible for different Annual Crops =").append(correctNull((String )hshValues.get("txt_amount_an"))+" (B)")
				.append("~Crop Loan Eligible for different Khariff Crops  =").append(correctNull((String )hshValues.get("txt_amount_kh"))+" (C1)")
				.append("~Crop Loan Eligible for different Rabi Crops =").append(correctNull((String )hshValues.get("txt_amount_rb"))+" (C2)")
				.append("~Crop Loan Eligible for different Summer Crops =").append(correctNull((String )hshValues.get("txt_amount_su"))+" (C3)")
				.append("~Loan Amount for Seasonal Crops =").append(correctNull((String )hshValues.get("txt_crop_loan"))+" (C=C1+C2+C3)")
				.append("~Total Crop Loan =").append(correctNull((String )hshValues.get("txt_total_crop_loan"))+" (A+B+C)")
				.append("~Working Capital (Allied/Activity/Activities per Cycle)=").append(correctNull((String )hshValues.get("txt_allied"))+" (D)")
				.append("~Term Loan=").append(correctNull((String )hshValues.get("txt_nfs"))+"(E)")
				.append("~Total UGC limit =").append(correctNull((String )hshValues.get("txt_prdcredit"))+" I(A+B+C+D+E)")
				.append("~I Consumption Credit =").append(correctNull((String )hshValues.get("txt_consumption"))+" (Edited Value)(G)")
				.append("~Operative Limit  =").append(correctNull((String )hshValues.get("txt_operativelimit"))+ " (II)(I+G)")
				.append("~Overall Limit for Documentation =").append(correctNull((String )hshValues.get("txt_documentation"))+" (II)");
				
				
				if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
				{
					hshValues.put("strAction", "update");
				}
					
			}
				AuditTrial.auditLog(hshValues, "404", appno, sbAuditTrial.toString());	
				
				
			
			//End
			
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
	}
	private int getSancMaxGradeId(String strStatId)
	{		
		String strQuery="";
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			strQuery = SQLParser.getSqlQuery("Sancvalmax");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(rs.getString(1) != null)
				{
					termId = Integer.parseInt(rs.getString(1)) + 1;
				}
				else
				{
					termId = 1;
				}
			}
			rs.close();			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
		return termId;
	}
	
	public  HashMap getUGCEligibility(HashMap hshValues) 
	{			
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		String strQuery="";
		String app_type="";
		String tot_acerage="0",total_acerage="0";
		String tot_acerage1="0";
		String amt_requested="0",eligible_amount="0";
		String land_measurement="";
		
		double acerage=0.00;
		double acerage1=0.00;
		double guntas=0.00;
		double guntas1=0.00;
		double cent=0.00;
		double cent1=0.00;		
		
		try
		{
			String appno=correctNull((String)hshValues.get("appno"));			
			if(appno.equalsIgnoreCase("null") || appno.equalsIgnoreCase(""))
			{
				appno = Helper.correctNull((String)hshValues.get("strappno"));
			}
			
			String appid=correctNull((String)hshValues.get("hidapplicantid"));			
			if(appid.equalsIgnoreCase("null") || appid.equalsIgnoreCase(""))
			{
				appid = Helper.correctNull((String)hshValues.get("comappid"));
			}
			
			/*	
			if(appid.equalsIgnoreCase("null") || appid.equalsIgnoreCase(""))
			{
				appid = Helper.correctNull((String)hshValues.get("per_appid"));
			} 	*/
			app_type="a";
			
			//To get total acerage of applicant from Land Holdings
			strQuery = SQLParser.getSqlQuery("sel_total_acerage^"+appno+"^"+app_type+appid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				tot_acerage=Helper.correctDouble(rs.getString("tot_acerage"));
				tot_acerage1=Helper.correctDouble(rs.getString("tot_acerage1"));
			}
			
			if(rs != null)
			{
				rs.close();
			}	
			
			//To get land measurement and amount requested from loan details
			strQuery = SQLParser.getSqlQuery("agrlandmeasurement^"+appno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				land_measurement=Helper.correctNull((String)rs.getString("land_measurement"));
				amt_requested=Helper.correctNull((String)rs.getString("loan_amtreqd"));
			}
			
			acerage=Double.parseDouble(tot_acerage);
			acerage1=Double.parseDouble(tot_acerage1);
			
			if(land_measurement.equalsIgnoreCase("g"))
			{
				guntas = acerage1 % 40;
				guntas1 = acerage1 / 40;
				
				if(guntas1 >0)
				{
					acerage = 	acerage + guntas1;
				}
				//acerage = Math.round(acerage);
			}
			else 
            {
				cent = acerage1 % 100;
				cent1 = acerage1 / 100;
				
				if(cent1 > 0)
				{
					acerage = 	acerage + cent1;
				}
				//acerage = Math.round(acerage);
				
            }	
			
			//To get Eligibile amount from UGC Parameters
			
			if(rs != null)
			{
				rs.close();
			}	
			
			total_acerage=Helper.formatDoubleValue(acerage);			
			
			if(acerage>0)
			{			
				strQuery = SQLParser.getSqlQuery("sel_ugc_amount^"+total_acerage);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{				
					eligible_amount=Helper.correctDouble(rs.getString("ugc_value"));
				}
				
				if(eligible_amount.equalsIgnoreCase("0") || eligible_amount.equalsIgnoreCase(""))
				{
					if(rs != null)
					{
						rs.close();
					}	
				
					strQuery = SQLParser.getSqlQuery("sel_ugc_maxamount");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{				
						eligible_amount=Helper.correctDouble(rs.getString("ugc_value"));
					}
				 }
			}
			
			hshResult.put("eligible_amount",eligible_amount);
			hshResult.put("amt_requested",amt_requested);
			
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getUGCEligibility "+ce.toString());
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
	/**
	 * @author:Karthikeyan.S
	 * @date:June 03, 2013-11:10:51 PM
	 * @category to update ROI for Deposit Loan
	 * @return
	 * @
	 */
	public void updateDepositROIData(String strAppno) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		double dblROI=0.00, dblFinalROI=0.00;
		String strDepType="",strDepLoanfor="";
		boolean bFlag=false;
		try
		{
		
			strQuery=SQLParser.getSqlQuery("findapptype^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strDepType=Helper.correctNull(rs.getString("prd_deposittype"));
				strDepLoanfor=Helper.correctNull(rs.getString("prd_depositloanfor"));
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
					dblROI=rs.getDouble("loan_rateincharges");
					dblFinalROI=Math.max(dblFinalROI,dblROI);
					
					if(Helper.correctNull(rs.getString("loan_banktype")).equalsIgnoreCase("2"))
						bFlag=true;
			}
			
			if(rs!=null)
				rs.close();
			
			if(strDepType.equalsIgnoreCase("G") &&  bFlag==false)
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","update_interest_loandetails");
				arrValues.add(jtn.format(dblFinalROI));
				arrValues.add(jtn.format(dblFinalROI));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateDepositROIData "+ce.toString());
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
	}
	/**
	 * @author:Karthikeyan.S
	 * @date:June 03, 2013-12:41:54 PM
	 * @category to update Repayment Period for Deposit Loan
	 * @return
	 * @
	 */
	public void updateDepositRepayPeriod(String strAppno, String strEmployment, String strAppstatus, String strDocRecvd) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs=null;
		ResultSet rs1=null;
		String strQuery="", strSanctionDate="";
		int intRepayPeriod=0, intFinalRepayPeriod=0;
		boolean boolFinalRepay=false;
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_depositrepayperiod^"+strAppno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				intRepayPeriod=rs1.getInt("loan_repayperiod");
				intFinalRepayPeriod=intRepayPeriod;
				boolFinalRepay=true;
			}
			if(strEmployment.equalsIgnoreCase("4") && !strDocRecvd.equalsIgnoreCase("4"))
			{
				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery=SQLParser.getSqlQuery("selprodinfo^"+strAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					intRepayPeriod=rs1.getInt("prd_term");
					if((intRepayPeriod<intFinalRepayPeriod)&&boolFinalRepay==true)
					{
						intFinalRepayPeriod=intRepayPeriod;
					}
				}
			}
			if(intFinalRepayPeriod>=0)
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_terms_loandetails");
				arrValues.add(jtn.format(intFinalRepayPeriod));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateDepositRepayPeriod "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}				
				if(rs1!= null)
				{
					rs1.close();
				}				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	public void updateBIRData(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();		 
		ResultSet rs = null;
		String strAction="",strAppno="";
		
		try 
		{ 
			int intUpdatesize = 0;	
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				String strBirType="";
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_per_bir");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
				
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_bir")));
				strBirType=Helper.correctNull((String)hshValues.get("sel_bir"));
				if(strBirType.equalsIgnoreCase("Y")){
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_submitteddate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_receiptdate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_charges")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_bircomments")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_birprocess_date")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_name")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_qual_report")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_opinion")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_convertedid")));
				arrVal.add(Helper.correctNull((String)hshValues.get("birverifidate")));
				}else{
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_bircomments")));
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
					
				}

				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","ins_per_bir");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_per_bir");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured in updateBIRData"+e.getMessage());
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
	public HashMap getBIRData(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strappno="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try 
		{ 
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_per_bir^"+strappno);
			if (rs.next()) 
			{
				hshValues.put("bir_flag", Helper.correctNull(rs.getString("bir_flag")));	
				hshValues.put("bir_submitteddate", Helper.correctNull(rs.getString("bir_submitteddate")));	
				hshValues.put("bir_receiptdate", Helper.correctNull(rs.getString("bir_receiptdate")));	
				hshValues.put("bir_charges", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("bir_charges")))));
				hshValues.put("bir_comments", Helper.correctNull(rs.getString("bir_comments")));
				hshValues.put("bir_processdate", Helper.correctNull(rs.getString("bir_processdate")));	
				hshValues.put("bir_service_name", Helper.correctNull(rs.getString("bir_service_name")));
				hshValues.put("bir_quality_report", Helper.correctNull(rs.getString("bir_quality_report")));
				hshValues.put("bir_opinion_all", Helper.correctNull(rs.getString("bir_opinion_all")));	
				hshValues.put("birverifiedby", Helper.correctNull(rs.getString("BIR_VERIFIED_BY")));
				if(!Helper.correctNull(rs.getString("BIR_VERIFIED_BY")).equalsIgnoreCase(""))
				{
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("selectusername^"+Helper.correctNull(rs.getString("BIR_VERIFIED_BY")));
					if(rs1.next())
					{
						hshValues.put("BIR_verified_name",Helper.correctNull(rs1.getString("name")));	
					}
				}
				hshValues.put("birverifieddate", Helper.correctNull(rs.getString("BIR_VERIFIED_DATE")));	

			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException("Exception in getBIRData==="+e.getMessage());
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
		return hshValues;
	}
	public void updateGSTDetails(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList listVal = new ArrayList();		 
		ResultSet rs = null;
		String strAction="",strAppno="";
		try 
		{ 
			int intUpdatesize = 0;	
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			
			intUpdatesize=intUpdatesize+1;				
			hshQry = new HashMap();
			listVal = new ArrayList();
			listVal.add(strAppno);
			hshQry.put("arrValues",listVal);
			hshQry.put("strQueryId","delgstreturndetails");
			hshQueryValues.put("size",String.valueOf(intUpdatesize));
			hshQueryValues.put(String.valueOf(intUpdatesize),hshQry);
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(hshValues.get("txt_year") instanceof java.lang.String)
				{
					if(!Helper.correctNull((String)hshValues.get("txt_year")).equalsIgnoreCase(""))
					{
						intUpdatesize=intUpdatesize+1;				
						hshQry = new HashMap();
						listVal = new ArrayList();
						listVal.add(strAppno);
						listVal.add(Helper.correctNull((String)hshValues.get("txt_year")));
						listVal.add(Helper.correctNull((String)hshValues.get("txt_amt")));
						listVal.add("1");
						hshQry.put("arrValues",listVal);
						hshQry.put("strQueryId","ins_gstreturndetails");
						hshQueryValues.put("size",String.valueOf(intUpdatesize));
						hshQueryValues.put(String.valueOf(intUpdatesize),hshQry);
					}
				}
				else
				{
					
					String[] strYear=(String [])hshValues.get("txt_year");
					String[] strAmount=(String [])hshValues.get("txt_amt");
					for(int i=0;i<strYear.length;i++)
					{
						intUpdatesize=intUpdatesize+1;				
						hshQry = new HashMap();
						listVal = new ArrayList();
						listVal.add(strAppno);
						listVal.add(strYear[i]);
						listVal.add(strAmount[i]);
						listVal.add(String.valueOf(i+1));
						hshQry.put("arrValues",listVal);
						hshQry.put("strQueryId","ins_gstreturndetails");
						hshQueryValues.put("size",String.valueOf(intUpdatesize));
						hshQueryValues.put(String.valueOf(intUpdatesize),hshQry);
					}
				}
			}
			
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured in updateGSTDetails"+e.getMessage());
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
	public HashMap getGSTDetails(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		String strappno="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ArrayList listRow=new ArrayList();
		ArrayList listCol=new ArrayList();
		
		try 
		{ 
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_gstreturndetails^"+strappno);
			while (rs.next()) 
			{
				
				listCol=new ArrayList();
				listCol.add(Helper.correctNull(rs.getString("gst_year")));
				listCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("gst_returnamt")))));
				listRow.add(listCol);
			}
			
			hshValues.put("listRow",listRow);
			
			rs=DBUtils.executeLAPSQuery("sel_app_perm_no^"+strappno);
			if (rs.next()) 
			{
				hshValues.put("strCategoryType",Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException("Exception in getGSTDetails==="+e.getMessage());
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
		return hshValues;
	}
	
	public void updateCreditSalesData(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();		 
		ResultSet rs = null;
		String strAction="",strAppno="";
		try 
		{ 
			int intUpdatesize = 0;	
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_app_creditsales");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
				
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_digiappno")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_eligdigi")));
				String strelgdigi=Helper.correctNull((String)hshValues.get("sel_eligdigi"));
				if(strelgdigi.equalsIgnoreCase("Y")){
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_reason")));
				}
				if(strelgdigi.equalsIgnoreCase("N")){
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_reason1")));
				}
				arrVal.add(Helper.correctNull((String)hshValues.get("Otherreason")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_techcommets")));
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","ins_app_creditsales");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_app_creditsales");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured in updateCreditSalesData"+e.getMessage());
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
	public HashMap getCreditSalesData(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strappno="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strQuery = "";
		String strPrdcode = Helper.correctInt((String) hshValues.get("prdcode"));
		String strcode="",stractiveflag="Y";
		try 
		{ 
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_app_creditsales^"+strappno);
			if (rs.next()) 
			{
				hshValues.put("APP_DIGIAPPNO", Helper.correctNull(rs.getString("APP_DIGIAPPNO")));	
				hshValues.put("APP_ELIGCRITERIA", Helper.correctNull(rs.getString("APP_ELIGCRITERIA")));	
				hshValues.put("APP_REASON", Helper.correctNull(rs.getString("APP_REASON")));	
				hshValues.put("APP_OTHERREASON", Helper.correctNull(rs.getString("APP_OTHERREASON")));
				hshValues.put("APP_COMMENTS", Helper.CLOBToString(rs.getClob("APP_COMMENTS")));
				if(Helper.correctInt((String) hshValues.get("strappstatus")).equalsIgnoreCase("pa")){
					if(Helper.correctNull(rs.getString("APP_ELIGCRITERIA")).equalsIgnoreCase("Y"))
						strcode="245";
					else
						strcode="246";
					
					rs1=DBUtils.executeLAPSQuery("sel_staticcredit_desc^"+strcode+"^"
							+ Helper.correctNull(rs.getString("APP_REASON")));
					if (rs1.next()) {
						stractiveflag = Helper.correctNull(rs1.getString("STAT_DATA_ACTIVE"));
					}
				}
				hshValues.put("stractiveflag",stractiveflag);
			}
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_branchname^"
					+ strappno);
			if (rs.next()) {
				strPrdcode = Helper.correctNull(rs.getString("app_prdcode"));
			}
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_products_education^"
					+ strPrdcode);
			if (rs.next()) {
				hshValues.put("prd_purpose", Helper.correctNull((String) rs
						.getString("prd_purpose")));
			}

			if (rs != null) {
				rs.close();
			}
		} 		
		catch (Exception e) 
		{
			throw new EJBException("Exception in getCreditSalesData==="+e.getMessage());
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
		return hshValues;
	}
	
	// ******************************addede for restructure Assessment ****************************//
	public void updateRestruceAssessment(HashMap hshValues)  
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshQry = new HashMap();
		ArrayList arrVal = new ArrayList();		 
		ResultSet rs = null,rs1=null;
		String strAction="",strAppno="";
		String strallied="",strpurposeloan="",strborroweravailed="",strborrowertype="",strgstnumber="",srwhethergstn="",strexempted="";
		try 
		{ 
			int intUpdatesize = 0;	
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			rs1 = DBUtils.executeLAPSQuery("sel_common_customer^"+ Helper.correctNull((String) hshValues.get("hidapplicantnewid")));
			if(rs1.next())
			{
				hshValues.put("COMINFO_GSTIN", correctNull(rs1.getString("COMINFO_GSTIN")));
				strgstnumber=correctNull(rs1.getString("COMINFO_GSTIN"));
				srwhethergstn=correctNull(rs1.getString("COMINFO_GSTINREG"));
				strexempted=correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
				hshValues.put("COMINFO_GSTINREG", correctNull(rs1.getString("COMINFO_GSTINREG")));
				hshValues.put("COMINFO_GST_EXEMPTED", correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));
				hshValues.put("perapp_cbsid", correctNull(rs1.getString("perapp_cbsid")));
				hshValues.put("perapp_fname", correctNull(rs1.getString("perapp_title"))+"."+correctNull(rs1.getString("perapp_fname"))+" "+correctNull(rs1.getString("perapp_lname")));
				
			}
			if(rs1!=null){
				rs1.close();
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_rest_Assesment");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
				
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_type_borrower")));
				strborrowertype=Helper.correctNull((String)hshValues.get("sel_type_borrower"));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_purpose")));
				 strallied=Helper.correctNull((String)hshValues.get("sel_purpose"));
				if(strallied.equalsIgnoreCase("3")){
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_alliedactivity")));
				}else{
					arrVal.add("");
				}
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_per_Activity")));
				strpurposeloan=Helper.correctNull((String)hshValues.get("sel_per_Activity"));
				if(strpurposeloan.equalsIgnoreCase("6")){
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_others")));
				}else{
					arrVal.add("");
				}
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_per_Activity_eligible")));
				arrVal.add(Helper.correctNull((String)hshValues.get("txt_Aggregate")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_Aggregate_eligible")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_whether_borrower")));
				arrVal.add(Helper.correctNull((String)hshValues.get("sel_whether_borrower_eligible")));
				
				strborroweravailed=Helper.correctNull((String)hshValues.get("sel_whether_borrower"));
				
				if(strborrowertype.equalsIgnoreCase("1")&& strborroweravailed.equalsIgnoreCase("Y")){
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_previous_mortorium")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_present_morotorium")));
					arrVal.add(Helper.correctNull((String)hshValues.get("txt_extended_date")));

				}else{
					arrVal.add("");
					arrVal.add("");
					arrVal.add("");
				}
				if(srwhethergstn.equalsIgnoreCase("Y")){
				arrVal.add(strgstnumber);
				}else if(srwhethergstn.equalsIgnoreCase("N")){
					arrVal.add(strexempted);
				}else{
					arrVal.add("");
				}
				if(strborrowertype.equalsIgnoreCase("3")){
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_restructure_scheme")));
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_restructure_scheme_eligible")));
				}else{
					arrVal.add("");
					arrVal.add("");
				}
				if(strborrowertype.equalsIgnoreCase("2")){
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_resolution_framework")));
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_resolution_framework_eligible")));
				}else{
					arrVal.add("");
					arrVal.add("");
				}
				if(strborrowertype.equalsIgnoreCase("4")){
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_restructure_agriallied")));
					arrVal.add(Helper.correctNull((String)hshValues.get("sel_restructure_agriallied_eligible")));
				}else{
					arrVal.add("");
					arrVal.add("");
				}
				
				
				
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","ins_rest_Assesment");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				intUpdatesize=intUpdatesize+1;				
				hshQry = new HashMap();
				arrVal = new ArrayList();
				arrVal.add(strAppno);
				hshQry.put("arrValues",arrVal);
				hshQry.put("strQueryId","del_rest_Assesment");
				hshqueryval.put("size",String.valueOf(intUpdatesize));
				hshqueryval.put(String.valueOf(intUpdatesize),hshQry);
			}
			
			if(intUpdatesize>0)
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		} 
		catch (Exception e) 
		{
			throw new EJBException("Error Occured in updateRestruceAssessment"+e.getMessage());
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
	
	public HashMap getRestruceAssessment(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null,rs3=null;
		String strappno="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strQuery = "";
		String strPrdcode = Helper.correctInt((String) hshValues.get("prdcode"));
		String strcode="",stractiveflag="Y";
		String strmoduletype= Helper.correctInt((String) hshValues.get("sessionModuleType"));
		if(strmoduletype.equalsIgnoreCase("")){
			strmoduletype=Helper.correctInt((String) hshValues.get("hidCategoryType"));
		}
		if(strmoduletype.equalsIgnoreCase("")){
			strmoduletype=Helper.correctInt((String) hshValues.get("cattype"));
		}
		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();
		ArrayList arrloanCol= new ArrayList();
		ArrayList arrloanRow= new ArrayList();
		String strgstnumber="",srwhethergstn="",strexempted="";
		try 
		{ 
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			
			
		
			rs=DBUtils.executeLAPSQuery("sel_rest_Assesment^"+strappno);
			if (rs.next()) 
			{
				hshValues.put("COM_APPNO", Helper.correctNull(rs.getString("COM_APPNO")));	
				hshValues.put("COM_TYPE_OF_BORROWER", Helper.correctNull(rs.getString("COM_TYPE_OF_BORROWER")));	
				hshValues.put("COM_PURPOSE_OF_LOAN", Helper.correctNull(rs.getString("COM_PURPOSE_OF_LOAN")));	
				hshValues.put("COM_AGRI_ALLIED", Helper.correctNull(rs.getString("COM_AGRI_ALLIED")));
				hshValues.put("COM_PERM_ACT", Helper.correctNull(rs.getString("COM_PERM_ACT")));
				hshValues.put("COM_PERM_ACT_ELIGIBLE", Helper.correctNull(rs.getString("COM_PERM_ACT_ELIGIBLE")));	
				hshValues.put("COM_EXPOSUE", Helper.correctNull(rs.getString("COM_EXPOSUE")));	
				hshValues.put("COM_EXPOSUE_ELIGIBLE", Helper.correctNull(rs.getString("COM_EXPOSUE_ELIGIBLE")));	
				hshValues.put("COM_BRW_AVAILED", Helper.correctNull(rs.getString("COM_BRW_AVAILED")));
				hshValues.put("COM_BRW_AVAILED_ELIGIBIE",Helper.correctNull(rs.getString("COM_BRW_AVAILED_ELIGIBIE")));
				hshValues.put("COM_PRESENT_MOROTORIUM", Helper.correctNull(rs.getString("COM_PRESENT_MOROTORIUM")));	
				hshValues.put("COM_PREVIOUS_MOROTORIUM", Helper.correctNull(rs.getString("COM_PREVIOUS_MOROTORIUM")));	
				hshValues.put("COM_EXTENDED_DATE", Helper.correctNull(rs.getString("COM_EXTENDED_DATE")));
				hshValues.put("COM_GST_NUMBER", Helper.correctNull(rs.getString("COM_GST_NUMBER")));
				hshValues.put("COM_MSME_REST_SCHEME", Helper.correctNull(rs.getString("COM_MSME_REST_SCHEME")));	
				hshValues.put("COM_MSME_RESTR_SCHEME_ELIG", Helper.correctNull(rs.getString("COM_MSME_RESTR_SCHEME_ELIG")));	
				hshValues.put("COM_RESOL_FW", Helper.correctNull(rs.getString("COM_RESOL_FW")));
				hshValues.put("COM_RESOL_FW_ELIGIBLE", Helper.correctNull(rs.getString("COM_RESOL_FW_ELIGIBLE")));
				hshValues.put("COM_OTHER_LOAN", Helper.correctNull(rs.getString("COM_OTHER_LOAN")));
				hshValues.put("COM_RESTRUCTURE_ALLIED", Helper.correctNull(rs.getString("COM_RESTRUCTURE_ALLIED")));
				hshValues.put("COM_REST_ALLIED_ELIGIBLE", Helper.correctNull(rs.getString("COM_REST_ALLIED_ELIGIBLE")));
			}
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_branchname^"
					+ strappno);
			if (rs.next()) {
				strPrdcode = Helper.correctNull(rs.getString("app_prdcode"));
			}
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_products_education^"
					+ strPrdcode);
			if (rs.next()) {
				hshValues.put("prd_purpose", Helper.correctNull((String) rs
						.getString("prd_purpose")));
			}
			if (rs != null) {
				rs.close();
			}
			if(strmoduletype.equalsIgnoreCase("RET")){
			rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"260"+"^"+ "264"+"^"+"ret");
			}else if(strmoduletype.equalsIgnoreCase("CORP")){
				rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"260"+"^"+ "264"+"^"+"corp");
			}else{
				rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"260"+"^"+ "264"+"^"+"agr");
			}
				
			while(rs.next())
			{				
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("STAT_DATA_DESC")));
				arrCol.add(Helper.correctNull((String)rs.getString("STAT_DATA_DESC1")));
				arrRow.add(arrCol);	
			}
			hshValues.put("arrRow", arrRow);
			
			if (rs != null) {
				rs.close();
			}
			if(strmoduletype.equalsIgnoreCase("RET")){
			rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"263"+"^"+ "265"+"^"+"ret");
			}else if(strmoduletype.equalsIgnoreCase("CORP")){
				rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"263"+"^"+ "265"+"^"+"corp");
			}else{
				rs=DBUtils.executeLAPSQuery("sel_restr_static^"+"263"+"^"+ "265"+"^"+"agr");
			}
				
			while(rs.next())
			{				
				arrloanCol = new ArrayList();
				arrloanCol.add(Helper.correctNull((String)rs.getString("STAT_DATA_DESC")));
				arrloanCol.add(Helper.correctNull((String)rs.getString("STAT_DATA_DESC1")));
				arrloanRow.add(arrloanCol);	
			}
			hshValues.put("arrloanRow", arrloanRow);
			hshValues.put("appno", strappno);
			
			if (rs != null) {
				rs.close();
			}
			if(rs1!=null){
				rs1.close();
			}
				rs1 = DBUtils.executeLAPSQuery("getloansecure_renew^" + strappno);
				if(rs1.next())
				{
					hshValues.put("loan_moratorium_ex", correctNull(rs1.getString("loan_noofinstallment")));
				}
				if(rs1!=null){
					rs1.close();
				}
				rs1 = DBUtils.executeLAPSQuery("sel_common_customer^"+ Helper.correctNull((String) hshValues.get("hidapplicantnewid")));
				if(rs1.next())
				{
					hshValues.put("COMINFO_GSTIN", correctNull(rs1.getString("COMINFO_GSTIN")));
					strgstnumber=correctNull(rs1.getString("COMINFO_GSTIN"));
					srwhethergstn=correctNull(rs1.getString("COMINFO_GSTINREG"));
					strexempted=correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
					hshValues.put("COMINFO_GSTINREG", correctNull(rs1.getString("COMINFO_GSTINREG")));
					hshValues.put("COMINFO_GST_EXEMPTED", correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));
					hshValues.put("perapp_cbsid", correctNull(rs1.getString("perapp_cbsid")));
					hshValues.put("perapp_fname", correctNull(rs1.getString("perapp_title"))+"."+correctNull(rs1.getString("perapp_fname"))+" "+correctNull(rs1.getString("perapp_lname")));
					
				}
				
				
		} 		
		catch (Exception e) 
		{
			throw new EJBException("Exception in getCreditSalesData==="+e.getMessage());
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
		return hshValues;
	}
	
	
	public HashMap getRestruceAnnexure(HashMap hshValues)  
	{ 
		ResultSet rs = null;
		ResultSet rs1 = null,rs2=null,rs3=null;
		String strappno="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strQuery = "";
		String strPrdcode = Helper.correctInt((String) hshValues.get("prdcode"));
		String strcode="",stractiveflag="Y";
		String strmoduletype= Helper.correctNull((String) hshValues.get("sessionModuleType"));
		if(strmoduletype.equalsIgnoreCase("")){
			strmoduletype=Helper.correctNull((String) hshValues.get("hidCategoryType"));
		}
		if(strmoduletype.equalsIgnoreCase("")){
			strmoduletype=Helper.correctNull((String) hshValues.get("cattype"));
		}
	    String 	strAppId= correctNull((String)hshValues.get("appid"));

		ArrayList arrCol= new ArrayList();
		ArrayList arrRow= new ArrayList();
		ArrayList arrloanCol= new ArrayList();
		ArrayList arrloanRow= new ArrayList();
		String strgstnumber="",srwhethergstn="",strexempted="";
		String strborrower="",strpurposeloan="",stragriallied="",strpermact="",strpermactelig="",
		strexposueelig="",strborroweravailed="",strborroweravailedelig="",strmsmerestscheme="",strmsmerestschemeelig="",strframework="",strframeworkelig="";
		ArrayList arrRestRow	= new ArrayList();
		ArrayList arrRestCol	= new ArrayList();
		try 
		{ 
			strappno=Helper.correctNull((String)hshValues.get("appno"));
			
			
		
			rs=DBUtils.executeLAPSQuery("sel_rest_Assesment^"+strappno);
			if (rs.next()) 
			{
				hshValues.put("COM_APPNO", Helper.correctNull(rs.getString("COM_APPNO")));	
				hshValues.put("COM_TYPE_OF_BORROWER", Helper.correctNull(rs.getString("COM_TYPE_OF_BORROWER")));	
				strborrower=Helper.correctNull(rs.getString("COM_TYPE_OF_BORROWER"));
				hshValues.put("COM_PURPOSE_OF_LOAN", Helper.correctNull(rs.getString("COM_PURPOSE_OF_LOAN")));
				strpurposeloan=Helper.correctNull(rs.getString("COM_PURPOSE_OF_LOAN"));
				hshValues.put("COM_AGRI_ALLIED", Helper.correctNull(rs.getString("COM_AGRI_ALLIED")));
				stragriallied=Helper.correctNull(rs.getString("COM_AGRI_ALLIED"));
				hshValues.put("COM_PERM_ACT", Helper.correctNull(rs.getString("COM_PERM_ACT")));
				strpermact=Helper.correctNull(rs.getString("COM_PERM_ACT"));
				hshValues.put("COM_PERM_ACT_ELIGIBLE", Helper.correctNull(rs.getString("COM_PERM_ACT_ELIGIBLE")));	
				strpermactelig=Helper.correctNull(rs.getString("COM_PERM_ACT_ELIGIBLE"));
				if(strpermactelig.equalsIgnoreCase("Y")){
					strpermactelig="Yes";
				}else if(strpermactelig.equalsIgnoreCase("N")){
					strpermactelig="No";
				}else{
					strpermactelig="";
				}
				hshValues.put("strpermactelig", strpermactelig);	
				hshValues.put("COM_EXPOSUE", Helper.correctNull(rs.getString("COM_EXPOSUE")));	
				hshValues.put("COM_EXPOSUE_ELIGIBLE", Helper.correctNull(rs.getString("COM_EXPOSUE_ELIGIBLE")));
				strexposueelig=Helper.correctNull(rs.getString("COM_EXPOSUE_ELIGIBLE"));
				if(strexposueelig.equalsIgnoreCase("Y")){
					strexposueelig="Yes";
				}else if(strexposueelig.equalsIgnoreCase("N")){
					strexposueelig="No";
				}else{
					strexposueelig="";
				}
				hshValues.put("strexposueelig", strexposueelig);
				hshValues.put("COM_BRW_AVAILED", Helper.correctNull(rs.getString("COM_BRW_AVAILED")));
				strborroweravailed=Helper.correctNull(rs.getString("COM_BRW_AVAILED"));
				if(strborroweravailed.equalsIgnoreCase("Y")){
					strborroweravailed="Yes";
				}else if(strborroweravailed.equalsIgnoreCase("N")){
					strborroweravailed="No";
				}else{
					strborroweravailed="";
				}
				hshValues.put("strborroweravailed", strborroweravailed);
				hshValues.put("COM_BRW_AVAILED_ELIGIBIE",Helper.correctNull(rs.getString("COM_BRW_AVAILED_ELIGIBIE")));
				strborroweravailedelig=Helper.correctNull(rs.getString("COM_BRW_AVAILED_ELIGIBIE"));
				if(strborroweravailedelig.equalsIgnoreCase("Y")){
					strborroweravailedelig="Yes";
				}else if(strborroweravailedelig.equalsIgnoreCase("N")){
					strborroweravailedelig="No";
				}else{
					strborroweravailedelig="";
				}
				hshValues.put("strborroweravailedelig", strborroweravailedelig);
				hshValues.put("COM_PRESENT_MOROTORIUM", Helper.correctNull(rs.getString("COM_PRESENT_MOROTORIUM")));	
				hshValues.put("COM_PREVIOUS_MOROTORIUM", Helper.correctNull(rs.getString("COM_PREVIOUS_MOROTORIUM")));	
				hshValues.put("COM_EXTENDED_DATE", Helper.correctNull(rs.getString("COM_EXTENDED_DATE")));
				hshValues.put("COM_GST_NUMBER", Helper.correctNull(rs.getString("COM_GST_NUMBER")));
				hshValues.put("COM_MSME_REST_SCHEME", Helper.correctNull(rs.getString("COM_MSME_REST_SCHEME")));
				strmsmerestscheme= Helper.correctNull(rs.getString("COM_MSME_REST_SCHEME"));
				if(strmsmerestscheme.equalsIgnoreCase("Y")){
					strmsmerestscheme="Yes";
				}else if(strmsmerestscheme.equalsIgnoreCase("N")){
					strmsmerestscheme="No";
				}else{
					strmsmerestscheme="";
				}
				hshValues.put("strmsmerestscheme", strmsmerestscheme);
				
				hshValues.put("COM_MSME_RESTR_SCHEME_ELIG", Helper.correctNull(rs.getString("COM_MSME_RESTR_SCHEME_ELIG")));	
				strmsmerestschemeelig= Helper.correctNull(rs.getString("COM_MSME_RESTR_SCHEME_ELIG"));
				if(strmsmerestschemeelig.equalsIgnoreCase("Y")){
					strmsmerestschemeelig="Yes";
				}else if(strmsmerestschemeelig.equalsIgnoreCase("N")){
					strmsmerestschemeelig="No";
				}else{
					strmsmerestschemeelig="";
				}
				hshValues.put("strmsmerestschemeelig", strmsmerestschemeelig);
				
				hshValues.put("COM_RESOL_FW", Helper.correctNull(rs.getString("COM_RESOL_FW")));
				
				strframework= Helper.correctNull(rs.getString("COM_RESOL_FW"));
				if(strframework.equalsIgnoreCase("Y")){
					strframework="Yes";
				}else if(strframework.equalsIgnoreCase("N")){
					strframework="No";
				}else{
					strframework="";
				}
				hshValues.put("strframework", strframework);
				hshValues.put("COM_RESOL_FW_ELIGIBLE", Helper.correctNull(rs.getString("COM_RESOL_FW_ELIGIBLE")));
				
				strframeworkelig= Helper.correctNull(rs.getString("COM_RESOL_FW_ELIGIBLE"));
				if(strframeworkelig.equalsIgnoreCase("Y")){
					strframeworkelig="Yes";
				}else if(strframeworkelig.equalsIgnoreCase("N")){
					strframeworkelig="No";
				}else{
					strframeworkelig="";
				}
				hshValues.put("strframeworkelig", strframeworkelig);
				hshValues.put("COM_OTHER_LOAN", Helper.correctNull(rs.getString("COM_OTHER_LOAN")));
				
			String 	strrestallied= Helper.correctNull(rs.getString("COM_RESTRUCTURE_ALLIED"));
				if(strrestallied.equalsIgnoreCase("Y")){
					strrestallied="Yes";
				}else if(strrestallied.equalsIgnoreCase("N")){
					strrestallied="No";
				}else{
					strrestallied="";
				}
				hshValues.put("strrestallied", strrestallied);
				
		 String	strrestalliedelig= Helper.correctNull(rs.getString("COM_REST_ALLIED_ELIGIBLE"));
				if(strrestalliedelig.equalsIgnoreCase("Y")){
					strrestalliedelig="Yes";
				}else if(strrestalliedelig.equalsIgnoreCase("N")){
					strrestalliedelig="No";
				}else{
					strrestalliedelig="";
				}
				hshValues.put("strrestalliedelig", strrestalliedelig);
				
				hshValues.put("COM_RESTRUCTURE_ALLIED", Helper.correctNull(rs.getString("COM_RESTRUCTURE_ALLIED")));
				hshValues.put("COM_REST_ALLIED_ELIGIBLE", Helper.correctNull(rs.getString("COM_REST_ALLIED_ELIGIBLE")));
			}
			if (rs != null) {
				rs.close();
			}
			
			hshValues.put("appno", strappno);
			
			if (rs != null) {
				rs.close();
			}
			if(rs1!=null){
				rs1.close();
			}
				
				rs1 = DBUtils.executeLAPSQuery("sel_common_customer^"+ strAppId);
				if(rs1.next())
				{
					hshValues.put("COMINFO_GSTIN", correctNull(rs1.getString("COMINFO_GSTIN")));
					strgstnumber=correctNull(rs1.getString("COMINFO_GSTIN"));
					srwhethergstn=correctNull(rs1.getString("COMINFO_GSTINREG"));
					strexempted=correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
					hshValues.put("COMINFO_GSTINREG", correctNull(rs1.getString("COMINFO_GSTINREG")));
					hshValues.put("COMINFO_GST_EXEMPTED", correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));
					hshValues.put("perapp_cbsid", correctNull(rs1.getString("perapp_cbsid")));
					hshValues.put("perapp_fname", correctNull(rs1.getString("perapp_title"))+"."+correctNull(rs1.getString("perapp_fname")));
					hshValues.put("PERAPP_INVOCDATE", Helper.correctNull((String) rs1.getString("PERAPP_INVOCDATE")));

				}
				if(rs1!=null){
					rs1.close();
				}
				if(!strborrower.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"260"+"^"+strborrower);
				if(rs1.next())
				{
					strborrower=Helper.correctNull(rs1.getString("stat_data_desc1"));
				}
				else
				{
					strborrower="";
				}
				}
				else
				{
					strborrower="";
				}
				hshValues.put("strborrower", strborrower);
				if(rs1!=null){
					rs1.close();
				}
				if(!strpurposeloan.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"261"+"^"+strpurposeloan);
				if(rs1.next())
				{
					strpurposeloan=Helper.correctNull(rs1.getString("stat_data_desc1"));
				}
				else
				{
					strpurposeloan="";
				}
				}
				else
				{
					strpurposeloan="";
				}
				hshValues.put("strpurposeloan", strpurposeloan);
				
				
				if(rs1!=null){
					rs1.close();
				}
				if(!stragriallied.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"262"+"^"+stragriallied);
				if(rs1.next())
				{
					stragriallied=Helper.correctNull(rs1.getString("stat_data_desc1"));
				}
				else
				{
					stragriallied="";
				}
				}
				else
				{
					stragriallied="";
				}
				hshValues.put("stragriallied", stragriallied);
				
				if(rs1!=null){
					rs1.close();
				}
				if(!strpermact.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"263"+"^"+strpermact);
				if(rs1.next())
				{
					strpermact=Helper.correctNull(rs1.getString("stat_data_desc1"));
				}
				else
				{
					strpermact="";
				}
				}
				else
				{
					strpermact="";
				}
				hshValues.put("strpermact", strpermact);
				
				String strrestscheme="",strfacsno="";
				if(strmoduletype.equalsIgnoreCase("RET")){
					strQuery=SQLParser.getSqlQuery("sel_ret_rest_processnote^"+strappno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{				
						hshValues.put("APP_RENEW_FLAG",correctNull((String)rs.getString("APP_RENEW_FLAG")));	
						hshValues.put("LOAN_RESTR_SCHEME",correctNull((String)rs.getString("LOAN_RESTR_SCHEME")));
						hshValues.put("LOAN_REQTERMS",correctNull((String)rs.getString("LOAN_REQTERMS")));
						hshValues.put("LOAN_INTRATE",correctNull((String)rs.getString("LOAN_INTRATE")));
						hshValues.put("LOAN_RECMDAMT",correctNull((String)rs.getString("LOAN_RECMDAMT")));
						
						strrestscheme=correctNull((String)rs.getString("LOAN_RESTR_SCHEME"));
					}
					if(!strrestscheme.equalsIgnoreCase(""))
					{
					rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"154"+"^"+strrestscheme);
					if(rs1.next())
					{
						strrestscheme=Helper.correctNull(rs1.getString("stat_data_desc1"));
					}
					else
					{
						strrestscheme="";
					}
					}
					else
					{
						strrestscheme="";
					}
					hshValues.put("strrestscheme", strrestscheme);
				}else{
				strQuery=SQLParser.getSqlQuery("sel_corp_rest_processnote^"+strappno);
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{		
					arrRestCol		= new ArrayList();
					hshValues.put("APP_RENEW_FLAG",correctNull((String)rs.getString("APP_RENEW_FLAG")));	
					hshValues.put("FAC_RESTR_SCHEME",correctNull((String)rs.getString("FAC_RESTR_SCHEME")));
					strrestscheme=correctNull((String)rs.getString("FAC_RESTR_SCHEME"));
					strfacsno=correctNull((String)rs.getString("FACILITY_SNO"));
				if(!strrestscheme.equalsIgnoreCase(""))
				{
				rs1=DBUtils.executeLAPSQuery("selstatdatabyiddesc^"+"154"+"^"+strrestscheme);
				if(rs1.next())
				{
					strrestscheme=Helper.correctNull(rs1.getString("stat_data_desc1"));
					arrRestCol.add(Helper.correctNull((String)rs1.getString("stat_data_desc1"))+" - " +strfacsno);	
				}
				else
				{
					arrRestCol.add("");
				}
				}
				else
				{
					arrRestCol.add("");
				}
				arrRestCol.add(Helper.correctNull((String)rs.getString("FACILITY_PROPOSED"))+" - " +strfacsno);
				arrRestCol.add(Helper.correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD"))+" - " +strfacsno);
				arrRestCol.add(Helper.correctNull((String)rs.getString("FACILITY_MONTHS"))+" - " +strfacsno);
				arrRestCol.add(Helper.correctNull((String)rs.getString("FACILITY_INTEREST"))+" - " +strfacsno);
				arrRestCol.add(Helper.correctNull((String)rs.getString("FACILITY_INTERESTREC"))+" - " +strfacsno);
				arrRestRow.add(arrRestCol);
				}
				}
				hshValues.put("arrRestRow", arrRestRow);
				hshValues.put("strmoduletype",strmoduletype);
				if(rs!=null){
					rs.close();
				}
				if(rs1!=null){
					rs1.close();
				}
				String strAppOrgCode="";
				rs = DBUtils.executeLAPSQuery("sel_ApplnBranch^" + strappno);
				if(rs.next())
				{
					hshValues.put("org_name", correctNull(rs.getString("org_name")));
					strAppOrgCode=Helper.correctNull(rs.getString("org_code"));
					hshValues.put("strLodgedDate", correctNull(rs.getString("app_lodgeddate")));
					hshValues.put("strDelodgedDate", correctNull(rs.getString("app_delodgeddate")));
					
					if(Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("C")||Helper.correctNull(rs.getString("APP_ORGLEVEL")).equalsIgnoreCase("D"))
					{
						if(rs != null)
						{
							rs.close();
						}
						rs = DBUtils.executeLAPSQuery("sel_pertainingbr^" + strappno);
						if(rs.next())
						{
							hshValues.put("org_name", correctNull(rs.getString("org_name")));
							strAppOrgCode=Helper.correctNull(rs.getString("org_code"));
						}
					}
				}
				
				
				if(!strAppOrgCode.equals(""))
				{
					strAppOrgCode	= strAppOrgCode.substring(0, 6)+"%";
				}
				if(rs!=null){rs.close();}
				rs	= DBUtils.executeLAPSQuery("sel_region^"+strAppOrgCode);
				if(rs.next())
				{
					hshValues.put("Reg_org_name", correctNull(rs.getString("org_name")));
				}
				if(rs!=null){
					rs.close();
				}
				
				rs = DBUtils.executeLAPSQuery("sel_rest_holiday_details^" + strappno);
				if (rs.next())
				{
					hshValues.put("loan_noofinstallment", Helper.correctNull((String)rs.getString("loan_noofinstallment")));
					hshValues.put("loan_periodicity", correctNull((String)rs.getString("loan_periodicity")));
					hshValues.put("loan_secure", correctNull((String)rs.getString("loan_secure")));
					hshValues.put("loan_secureamount", correctNull((String)rs.getString("loan_secureamount")));
					hshValues.put("loan_servised", correctNull((String)rs.getString("loan_servised")));
				}
		} 		
		catch (Exception e) 
		{
			throw new EJBException("Exception in getCreditSalesData==="+e.getMessage());
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
		return hshValues;
	}
	
}