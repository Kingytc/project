package com.sai.laps.ejb.perlimitofloan;

import java.sql.ResultSet;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.jfree.util.Log;

import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "LimitofLoanBean", mappedName = "LimitofLoanHome")
@Remote (LimitofLoanRemote.class)
public class LimitofLoanBean extends BeanAdapter {
	private static final long serialVersionUID = 1L;
	public HashMap getData(HashMap hshRequestValues)  {
		
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strQuery = "";
		String strAppno = "";
		String strprdcode = "";
		String streligloanamt="",strRecmdAmt="",strReqAmt="",strMclrCode="";
		String strinttype="";
		String strterm="",strdigiLoanSubType="";
		String strappTitle="";
		String strGreater="<=";
		String strLesser=">=";
		String strProductType="";
		String strIRapprovestatur="";
		
		String strSetupClassForOtherDev="";
		String strSetupClassForModfInt="";
		String strPrdType =Helper.correctNull((String)hshRequestValues.get("strProductType"));
		String comapp_id=correctNull((String)hshRequestValues.get("hidapplicantid"));
		
		
		String strOtherDevFlag="N";
		String strModIntFlag="N";
		double dbAddInt=0.00;

		int intempretireage=0;
		int intTerms=0;
		int intselfempretireage=0;
		int intMoratorium=0;
		int intemployment=0;
		
		double dblcostprd=0.0;
		double dblRepaycapacity=0.0;
		double dblmargin=0.0;
		double dblprodmax=0.0;
		double dblGrossIncome=0.0;
		double dblNetIncome=0.0;
		double dblOthrIncome=0.0;
		double dblOthrDeduc=0.0;
		double dblDeduc=0.0;
		double dblInterestRate=0.0;
		double dblRepaycapacityeligibility=0.0;
		
		boolean boolloanamt=true;
		boolean boolintrate=true;
		boolean booltenor=true;
		boolean boolmargin=true;
		boolean boolmaxage=true;
		boolean boolprocfee=true;
		boolean booldocfee=true;
		boolean boolreapycapcity=true;
		String strArr[]=null;
		NumberFormat nft=NumberFormat.getInstance();
		nft.setMinimumFractionDigits(2);
		nft.setMaximumFractionDigits(2);
		nft.setGroupingUsed(false);
		try{
			strAppno = correctNull((String) hshRequestValues.get("Applicationno"));
			String sessionModuleType=correctNull((String) hshRequestValues.get("sessionModuleType"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String) hshRequestValues.get("appno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String) hshRequestValues.get("strappno"));
			}
			////streditoption=correctNull((String) hshRequestValues.get("editoption"));
			/*
			 * Checking for entry in Appraisal -> Loan Details page
			 */
			double modintrate=0.00,cgtmseSplitup=0.00;
			double cgtmse_coverage=0.00;
			strQuery=SQLParser.getSqlQuery("selLoanType^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strLoanDetFlg",Helper.correctNull(rs.getString("appraisal_flag")));
			}
			String cgtmseappl="";
			strQuery = SQLParser.getSqlQuery("get_perloandetails_renew1^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				modintrate= Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_modintrate")));
				cgtmseSplitup= Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_CG_PERCENT")));
				cgtmseappl=Helper.correctDouble((String)rs.getString("LOAN_CGTMSE_APPLICABLE"));
				
				cgtmse_coverage=Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt")));
			}
			if(cgtmseappl.equals("Y"))
			{
				if (rs != null)
					rs.close();	
				double paramval_CGTMSEint=0.00;
				double dblsancintrate=0.00;
				strQuery = SQLParser.getSqlQuery("sel_laps_cg_parms");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					paramval_CGTMSEint=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_paramval")));
					hshRecord.put("paramval_CGTMSEint", String.valueOf(paramval_CGTMSEint));
				}
				if((modintrate+cgtmseSplitup)>paramval_CGTMSEint)
				{
					hshRecord.put("strCGTMSEtotintrate","Y");	
				}
				else
				{
					hshRecord.put("strCGTMSEtotintrate","N");	
				}
				
				if (rs != null)
					rs.close();
			}
			/*
			 * End
			 */
			if(rs!=null)
				rs.close();
			String strDeviatedUserClass = "",strApprovedUserid="",strDeviatedUserId="",strUserClass="";
			strQuery=SQLParser.getSqlQuery("seldeviateduser^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(correctNull((String) hshRequestValues.get("strUserId")).equalsIgnoreCase(correctNull(rs.getString("app_applnholder"))))
				{
					hshRecord.put("applholder","Y");
				}
				if(!correctNull(rs.getString("app_deviateduserid")).equalsIgnoreCase(""))
				{
					hshRecord.put("deviationapproved","Y");
					strDeviatedUserId=correctNull(rs.getString("app_deviateduserid"));
					strQuery=SQLParser.getSqlQuery("sel_deviationauthorityuser^"+correctNull(rs.getString("app_deviateduserid")));
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strDeviatedUserClass = correctNull(rs1.getString("usr_class"));
					}
				}
			}
			hshRecord.put("strDeviatedUserClass", strDeviatedUserClass);
			
			strQuery=SQLParser.getSqlQuery("sel_deviationauthorityuser^"+correctNull((String) hshRequestValues.get("strUserId")));
			rs1=DBUtils.executeQuery(strQuery);
 			if(rs1.next())
			{
				strUserClass = correctNull(rs1.getString("usr_class"));
			}
			
			hshRecord.put("strUserClass", strUserClass);
			
			if(strDeviatedUserId.equalsIgnoreCase(correctNull((String) hshRequestValues.get("strUserId")))||strDeviatedUserId.equalsIgnoreCase(""))
			{
				hshRecord.put("strDeviatedUserId","Y");
			}
			else
			{
				hshRecord.put("strDeviatedUserId","N");
			}
			
			hshRecord.put("strAppno", strAppno);
			
			strQuery = SQLParser.getSqlQuery("selprodinfo^" + strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strRecmdAmt = correctNull((String) rs.getString("loan_recmdamt"));
				strReqAmt = correctNull((String) rs.getString("amtreqd"));
				strinttype = correctNull((String) rs.getString("loan_inttype"));
				strterm=correctNull((String) rs.getString("loan_terms"));
				strprdcode = correctNull((String) rs.getString("app_prdcode"));
				intempretireage=rs.getInt("prd_empretireage");
				intTerms= rs.getInt("loan_terms");
				intselfempretireage=rs.getInt("prd_selfretireage");
				dblcostprd=rs.getDouble("cloanprd");
				dblmargin=rs.getDouble("loan_margin");
				//dblRepaycapacity=rs.getDouble("loan_repaycapacity");
				dblprodmax=rs.getDouble("prd_rng_to");
				intMoratorium=rs.getInt("loan_noofinstallment");
				dblInterestRate=rs.getDouble("loan_intrate");
				strProductType= correctNull((String) rs.getString("prd_type"));
				intemployment=rs.getInt("perapp_employment");
				strappTitle=correctNull((String) rs.getString("perapp_title"));
				strMclrCode=correctNull((String) rs.getString("loan_mclrtype"));
				if(!strMclrCode.equalsIgnoreCase(""))
					{
						strArr=strMclrCode.split("@");
						if(strArr.length>1)
						{
							if(rs1!=null)
								rs1.close();
							rs1=DBUtils.executeLAPSQuery("selcbsiddatadesc^34^"+strArr[0]);
							if(rs1.next())
							{
								hshRecord.put("mclr_type_code",Helper.correctNull(rs1.getString("cbs_static_data_passing_code")));
							}
						}
					}
				
				hshRecord.put("moratorium",""+intMoratorium);
				hshRecord.put("interestcharged",correctNull(rs.getString("loan_interestcharged")));
				hshRecord.put("servised",correctNull(rs.getString("loan_servised")));
			}
			hshRecord.put("strMaxAmount",nft.format(dblprodmax));
			strQuery=SQLParser.getSqlQuery("pergetIncome^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblGrossIncome = rs.getDouble("perinc_yearsalary");
				dblNetIncome = rs.getDouble("perinc_takehome");
				dblOthrIncome=rs.getDouble("perinc_secincome");
				dblOthrDeduc=rs.getDouble("perinc_yearotherdeduc");
				dblDeduc=rs.getDouble("perinc_yeardeduction");
			}
			
			//added by bhaskar to check od class and int class
			if(rs1!=null)
			{
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("sel_deviationauthority^"+strprdcode);
			if(rs1.next())
			{
				strSetupClassForModfInt = correctNull(rs1.getString("prd_maxintclass"));
				strSetupClassForOtherDev=correctNull(rs1.getString("prd_otherdevclass"));
			}	
			
			if(Integer.parseInt(Helper.correctInt(strUserClass))<Integer.parseInt(Helper.correctInt(strSetupClassForModfInt)))
			{
				strModIntFlag="Y";
			}
			if(Integer.parseInt(Helper.correctInt(strUserClass))<Integer.parseInt(Helper.correctInt(strSetupClassForOtherDev)))
			{
				strOtherDevFlag="Y";
			}
				
			hshRecord.put("strOtherDevFlag", strOtherDevFlag);
			hshRecord.put("strModIntFlag", strModIntFlag);
			hshRecord.put("strSetupClassForOtherDev", strSetupClassForOtherDev);
			//ende
			
			if(sessionModuleType.equals("DIGI"))
			{
				strQuery = SQLParser.getSqlQuery("Sel_app_deviation_digi^"+ strAppno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("Sel_app_deviation^"+ strAppno);
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strDeviationtype=correctNull(rs.getString("deviation_type"));
				if(strApprovedUserid.equalsIgnoreCase("")){
				strApprovedUserid = correctNull(rs.getString("deviation_apprejuserid"));}
				if(strDeviationtype.equalsIgnoreCase("LA"))
				{
					hshRecord.put("amtreq",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_loanamount",correctNull(rs.getString("deviation_req")));
					hshRecord.put("txt_loanamountnew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_loanremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_la",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_lauserid",correctNull(rs.getString("deviation_apprejuserid")));
					hshRecord.put("select_la_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					boolloanamt=false;
				}
				else if(strDeviationtype.equalsIgnoreCase("IR"))
				{
					hshRecord.put("loan_intrate",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_interestrate",correctNull(rs.getString("deviation_req")));
					hshRecord.put("txt_interestratenew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_interestrateremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_intrate",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_intrateuserid",correctNull(rs.getString("deviation_apprejuserid")));
					strIRapprovestatur=Helper.correctNull(rs.getString("deviation_apprej"));
					boolintrate=false;
					hshRecord.put("select_intrate_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
				}
				else if(strDeviationtype.equalsIgnoreCase("TR"))
				{
					hshRecord.put("loan_reqterms",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_tenor",correctNull(rs.getString("deviation_req")));
					hshRecord.put("txt_tenornew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_tenorremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_tenor",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_tenoruserid",correctNull(rs.getString("deviation_apprejuserid")));
					booltenor=false;
					hshRecord.put("select_tenor_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("MN"))
				{
					hshRecord.put("margin",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_margin",correctNull(rs.getString("deviation_req")));
					hshRecord.put("txt_marginnew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_marginremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_margin",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_marginuserid",correctNull(rs.getString("deviation_apprejuserid")));
					boolmargin=false;
					hshRecord.put("select_margin_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("RA"))
				{
					hshRecord.put("txt_retirementold",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_retirement",correctNull(rs.getString("deviation_req")));
					hshRecord.put("txt_retirementnew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_retirementremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_rage",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_rageuserid",correctNull(rs.getString("deviation_apprejuserid")));
					boolmaxage=false;
					hshRecord.put("select_rage_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("RC"))
				{
					hshRecord.put("repayold",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("repayreq",correctNull(rs.getString("deviation_req")));
					hshRecord.put("repaynew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("repayremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_repayment",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_repaymentuserid",correctNull(rs.getString("deviation_apprejuserid")));
					boolreapycapcity=false;
					hshRecord.put("select_repayment_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("PF"))
				{
					hshRecord.put("procfeeold",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("procfeereq",correctNull(rs.getString("deviation_req")));
					hshRecord.put("procfeenew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("procfeeremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_processfee",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_processfeeuserid",correctNull(rs.getString("deviation_apprejuserid")));
					boolprocfee=false;
					hshRecord.put("select_processfee_intr",correctNull(rs.getString("deviation_incrinterest")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("DF"))
				{
					hshRecord.put("docfeeold",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("docfeereq",correctNull(rs.getString("deviation_req")));
					hshRecord.put("docfeenew",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("docfeeremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("select_docfee",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_docfeeuserid",correctNull(rs.getString("deviation_apprejuserid")));
					booldocfee=false;
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("OD"))
				{
					hshRecord.put("txt_otherdevremarks",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("sel_ODdev",correctNull(rs.getString("DEVIATION_REQ")));
				}
				else if(strDeviationtype.equalsIgnoreCase("IRRN"))
				{
					hshRecord.put("txt_intraterefnumber",correctNull(rs.getString("deviation_remarks")));
				}
				else if(strDeviationtype.equalsIgnoreCase("O1"))
				{
					hshRecord.put("deviation_oldvalue1",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("deviation_req1",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue1",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("deviation_remarks1",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("deviation_specification1",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_otherspec1",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_otherspec1userid",correctNull(rs.getString("deviation_apprejuserid")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("O2"))
				{
					hshRecord.put("deviation_oldvalue2",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("deviation_req2",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue2",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("deviation_remarks2",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("deviation_specification2",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_otherspec2",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_otherspec2userid",correctNull(rs.getString("deviation_apprejuserid")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("O3"))
				{
					hshRecord.put("deviation_oldvalue3",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("deviation_req3",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue3",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("deviation_remarks3",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("deviation_specification3",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_otherspec3",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_otherspec3userid",correctNull(rs.getString("deviation_apprejuserid")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}}
				else if(strDeviationtype.equalsIgnoreCase("O4"))
				{
					hshRecord.put("deviation_oldvalue4",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("deviation_req4",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue4",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("deviation_remarks4",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("deviation_specification4",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_otherspec4",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_otherspec4userid",correctNull(rs.getString("deviation_apprejuserid")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("O5"))
				{
					hshRecord.put("deviation_oldvalue5",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("deviation_req5",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue5",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("deviation_remarks5",correctNull(rs.getString("deviation_remarks")));
					hshRecord.put("deviation_specification5",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_otherspec5",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("hid_otherspec5userid",correctNull(rs.getString("deviation_apprejuserid")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
					}
				else if(strDeviationtype.equalsIgnoreCase("OC"))
				{
					hshRecord.put("deviation_oldvalue5",correctNull(rs.getString("deviation_oldvalue")));
					hshRecord.put("sel_otherdev",correctNull(rs.getString("deviation_req")));
					hshRecord.put("deviation_newvalue5",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("txt_odrem",correctNull(rs.getString("deviation_remarks")));
					//hshRecord.put("deviation_specification5",correctNull(rs.getString("deviation_specification")));
					hshRecord.put("select_od",correctNull(rs.getString("deviation_apprej")));
					hshRecord.put("otherdevuserid",correctNull(rs.getString("deviation_apprejuserid")));
					hshRecord.put("select_od_intr",correctNull(rs.getString("deviation_incrinterest")));
					hshRecord.put("txtnmi",correctNull(rs.getString("deviation_newvalue")));
					hshRecord.put("NMI_REMARK",correctNull(rs.getString("DEVIATION_REMARKS")));
					strQuery = SQLParser.getSqlQuery("seldevdetails^"+ strAppno);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next()){
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
					}
				}
				
				//added for interest rate
				if(!(strDeviationtype.equalsIgnoreCase("IR") || strDeviationtype.equalsIgnoreCase("OC")))
				{
					if(correctNull(rs.getString("deviation_req")).equalsIgnoreCase("Y") && correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("A")&& correctNull(rs.getString("deviation_incrinterest")).equalsIgnoreCase("1"))
					{
						rs1=DBUtils.executeLAPSQuery("seladdintratedev");
						if(rs1.next())
						{
							dbAddInt+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("loan_paramval")));
						}
					}
				}
				//Adding interest rate for other parameters
				if(strDeviationtype.equalsIgnoreCase("OC"))
				{
					HashMap hshEligibiility = new HashMap();
					int intCount=0;
					hshRequestValues.put("strPrdType", strPrdType);
					hshRequestValues.put("prd_type", strPrdType);
					hshRequestValues.put("appno", strAppno);
					hshRequestValues.put("comappid",comapp_id);
					
					hshEligibiility=(HashMap)EJBInvoker.executeStateLess("checkeligibility",hshRequestValues,"getEligibility");
					intCount=Integer.parseInt(Helper.correctInt((String)hshEligibiility.get("intCount")));
					for(int k=0;k<intCount;k++)
					{
						if(correctNull(rs.getString("deviation_req")).equalsIgnoreCase("Y") && correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("A")&& correctNull(rs.getString("deviation_incrinterest")).equalsIgnoreCase("1"))
						{
							rs1=DBUtils.executeLAPSQuery("seladdintratedev");
							if(rs1.next())
							{
								dbAddInt+=Double.parseDouble(Helper.correctDouble((String)rs1.getString("loan_paramval")));
							}
						}
					}
				}
			}
			if(strApprovedUserid.equalsIgnoreCase(correctNull((String) hshRequestValues.get("strUserId"))))
			{
				hshRecord.put("strApprovedUserid","Y");
			}
			else
			{
				hshRecord.put("strApprovedUserid","N");
			}
			if(boolreapycapcity)
			{
				if(rs !=null)
				{
					rs.close();
				}
				String strProdPurpose="",strVehicleType="";
				strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strAppno);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strAppno);
				}
				if(rs !=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblRepaycapacity=rs.getDouble("loan_repaycapacity");
				}
				hshRecord.put("repayold",Helper.formatDoubleValue(dblRepaycapacity));
			}
			if(boolloanamt || boolintrate || boolmargin || boolprocfee || booldocfee)
			{
				HashMap hshInput = new HashMap();
				hshInput.put("appno",strAppno);
				hshInput.put("txt_sanction_amount",strRecmdAmt);
				//Calculation of eligible loan amount
//				HashMap hshOutput=(HashMap)EJBInvoker.executeStateLess("perapplicant",hshInput,"checkEligibility");
//				streligloanamt = Helper.correctDouble((String)hshOutput.get("strEligibleLoanAmt"));
				streligloanamt = strRecmdAmt;
			}
			if(boolloanamt)
			{
				hshRecord.put("amtreq",streligloanamt);
			}
			if(boolmaxage)
			{
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("get_age^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					double dbleligiblemonths=0.0;
					double dbltemp =Math.floor(rs.getDouble("agecompleted"));
					String strAge="";
					int intemploydetail=rs.getInt("perapp_employment");
					
					if((intempretireage>0 && intemploydetail==1) || (intempretireage>0 && intemploydetail==9))
					{
						dbleligiblemonths=(intempretireage*12)-(dbltemp+intTerms);
						strAge=""+intempretireage;
					}
					else if(intselfempretireage>0)
					{
						dbleligiblemonths=(intselfempretireage*12)-(dbltemp+intTerms);
						strAge=""+intselfempretireage;
					}
						hshRecord.put("txt_retirementold",strAge);
						break;
				}
			}
			
			if(booltenor)
			{
				hshRecord.put("loan_reqterms",strterm);
			}
			
			if(!Helper.correctNull((String)hshRequestValues.get("strappstatus")).equalsIgnoreCase("pa") && !Helper.correctNull((String)hshRequestValues.get("strappstatus")).equalsIgnoreCase("pa"))
			{
				if((boolintrate || (!strIRapprovestatur.equalsIgnoreCase("A"))) && (!sessionModuleType.equals("DIGI")) )
				{
					if(rs!=null)
						rs.close();
					
					strQuery=SQLParser.getSqlQuery("selperprdmargin^" +strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						double dbIntProd=0.00;
						dbIntProd=Double.parseDouble(Helper.correctDouble(rs.getString("loan_intrate")));
						dbIntProd=dbIntProd+dbAddInt;
						hshRecord.put("loan_intrate",nft.format(dbIntProd));
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(jtn.format(dbIntProd));
						if(Helper.correctNull(rs.getString("loan_inttype")).equalsIgnoreCase("Floating"))
						{
							if(!correctNull((String) rs.getString("loan_mclrtype")).equalsIgnoreCase(""))
							{
								if(Helper.correctNull((String)hshRecord.get("mclr_type_code")).equalsIgnoreCase("O"))
								{
									arrValues.add(Helper.correctNull(rs.getString("loan_crp")));
									arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_bsp")))+dbAddInt));
								}
								else
								{
									arrValues.add(nft.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_crp")))+dbAddInt));
									arrValues.add(Helper.correctNull(rs.getString("loan_bsp")));
								}
							}
							else
							{
								arrValues.add(Helper.correctNull(rs.getString("loan_creditrskval")));
								arrValues.add(Helper.correctNull(rs.getString("loan_busstatval")));
							}
						}
						else
						{
							arrValues.add(Helper.correctNull(rs.getString("loan_creditrskval")));
							arrValues.add(Helper.correctNull(rs.getString("loan_busstatval")));
						}
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_interest_loandetails");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
				else if(strIRapprovestatur.equalsIgnoreCase("A"))
				{
					if(rs!=null)
						rs.close();
					
					strQuery=SQLParser.getSqlQuery("selperprdmargin^" +strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						double dbIntProd=Double.parseDouble(Helper.correctDouble(rs.getString("loan_modintrate")));
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						arrValues.add(jtn.format(dbIntProd));
						if(Helper.correctNull(rs.getString("loan_inttype")).equalsIgnoreCase("Floating"))
						{
							if(!correctNull((String) rs.getString("loan_mclrtype")).equalsIgnoreCase(""))
							{
								if(Helper.correctNull((String)hshRecord.get("mclr_type_code")).equalsIgnoreCase("O"))
								{
									arrValues.add(Helper.correctNull(rs.getString("loan_creditrskval")));
									arrValues.add(nft.format(dbIntProd-Double.parseDouble(Helper.correctDouble(rs.getString("loan_baserate")))-Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval")))));
								}
								else
								{
									arrValues.add(nft.format(dbIntProd-Double.parseDouble(Helper.correctDouble(rs.getString("loan_baserate")))-Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval")))));
									arrValues.add(Helper.correctNull(rs.getString("loan_busstatval")));
									
								}
							}
							else
							{
								arrValues.add(Helper.correctNull(rs.getString("loan_creditrskval")));
								arrValues.add(Helper.correctNull(rs.getString("loan_busstatval")));
							}
						}
						else
						{
							arrValues.add(Helper.correctNull(rs.getString("loan_creditrskval")));
							arrValues.add(Helper.correctNull(rs.getString("loan_busstatval")));
						}
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_interest_loandetails");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
				}
			}
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				 strdigiLoanSubType = Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI"));
				if(!strdigiLoanSubType.equalsIgnoreCase("PR")){
				hshRecord.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));}
			}
			if(boolmargin)
			{
				if(rs!=null)
					rs.close();
				String strProdPurpose="",hidtxt_vehage="";
				strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				hidtxt_vehage=Helper.correctNull((String) hshRequestValues.get("hidtxt_vehage"));}
				if(strdigiLoanSubType.equalsIgnoreCase("PR"))
				{
					strQuery = SQLParser.getSqlQuery("getloanterms^" + strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hidtxt_vehage=Helper.correctNull(rs.getString("loan_ageofveh"));
					}
					
				}
				if((strProductType.equalsIgnoreCase("pH") || strProductType.equalsIgnoreCase("pS")) && (strProdPurpose.equalsIgnoreCase("H")))
				{
					strQuery=SQLParser.getSqlQuery("selmarginrate^" + strprdcode+"^<=^"+hidtxt_vehage+"^>=^"+hidtxt_vehage);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next())
						hshRecord.put("margin",correctNull((String) rs.getString("margin_perct")));
				}
				else
				{
				strQuery=SQLParser.getSqlQuery("selmarginrate^" + strprdcode+"^<=^"+strReqAmt+"^>=^"+strReqAmt);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
					hshRecord.put("margin",correctNull((String) rs.getString("margin_perct")));
				}
			}
			if(boolprocfee)
			{
				HashMap hshrec = new HashMap();
				hshrec.put("prdcode",strprdcode);
				hshrec.put("recamt",streligloanamt);
				hshrec.put("appid",strAppno);
				hshrec=getDocFee(hshrec);
				hshRecord.put("procfeeold",Helper.roundVal(correctNull(((String)hshrec.get("procfee")))));
			}
			
			if(booldocfee)
			{
				HashMap hshrec = new HashMap();
				hshrec.put("prdcode",strprdcode);
				hshrec.put("recamt",streligloanamt);
				hshrec.put("appid",strAppno);
				hshrec=getDocFee(hshrec);
				hshRecord.put("docfeeold",correctNull((String)hshrec.get("docfee")));
			}
			
			////hshRecord.put("editoption",streditoption);
			int i=0, j=0;
			strQuery = SQLParser.getSqlQuery("Sel_app_deviation_check^"+ strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
						  
				if(((Helper.correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("A")||
						Helper.correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("R"))))
				{
					i++;
					
				}
				j++;
			}
			
			
//			if(rs!=null)
//			{
//				rs.close();
//			}
//			rs=DBUtils.executeLAPSQuery("sel_date^"+strAppno);
//			if(rs.next())
//			{
//				if(!Helper.correctNull(rs.getString("appsanc_interest_refno")).equalsIgnoreCase(""))
//				{
//					hshRecord.put("strIntRefNoFlag", "Y");
//				}
//			}
			String strPassValue="";
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_prdloantype^"+strAppno);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("prd_bankscheme")).equalsIgnoreCase("999"))
					strPassValue = "105";
				else
					strPassValue = "103";
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^"+strPassValue);
			if(rs.next())
			{
				hshRecord.put("strIntDevLimit", Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
			}
			
			if(i==j){
				hshRecord.put("strapprej", "Y");
			}else{
				hshRecord.put("strapprej", "N");
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_loandetails_digi_extra^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("DIGI_DEVIATION_ROI",Helper.correctNull(rs.getString("DIGI_DEVIATION_ROI_PENALTY")));
				hshRecord.put("LOAN_BRE_UPDATE",Helper.correctNull(rs.getString("LOAN_BRE_UPDATE")));
				hshRecord.put("DIGI_DEVIATION_FOIR",Helper.correctNull(rs.getString("DIGI_DEVIATION_FOIR")));
				hshRecord.put("DIGI_NMI_MULTIPLIER",Helper.correctNull(rs.getString("DIGI_NMI_MULTIPLIER")));
				hshRecord.put("LOAN_DIGI_TOT_PROCESSINGFEE",Helper.correctNull(rs.getString("LOAN_DIGI_TOT_PROCESSINGFEE")));
				hshRecord.put("DIGI_DEVIATION_CALMAXLOAN",Helper.correctNull(rs.getString("DIGI_DEVIATION_CALMAXLOAN")));
				hshRecord.put("LOAN_COSTLOANPRD",Helper.correctNull(rs.getString("LOAN_COSTLOANPRD")));
				
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("strHouseFlag","N");
				}
			}
			
			if(rs!=null) rs.close();
			String STRAPPREJSTATUS="",strstatusflag="Y";
	  		strQuery = SQLParser.getSqlQuery("sel_DiviationBREstatus^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				STRAPPREJSTATUS=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(STRAPPREJSTATUS.equalsIgnoreCase("A"))
				{
					strstatusflag="N";
				}
			}
			hshRecord.put("strstatusflag",strstatusflag);
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_DiviationBRECount^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
    		int count =0;
			while(rs.next()) 
			{
				count++;
			}
			hshRecord.put("BREcount",String.valueOf(count));
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_DiviationBRECount^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
    		String strNewDevValue="";
    		while(rs.next()) 
			{
    			strNewDevValue=Helper.correctNull((String)rs.getString("DEVIATION_NEWVALUE"));
    			if(strNewDevValue.equals("0"));
    				break;
			}
    		hshRecord.put("NewDevValue",strNewDevValue);
    		
			
			int intSetupClassForOtherDev = (Integer.parseInt(strSetupClassForOtherDev));
			int intUserClass = (Integer.parseInt(strUserClass));
			
			if(intUserClass >= intSetupClassForOtherDev)
			{
				hshRecord.put("DelegatedAuthority","Y");
			}
			
			//String retappdevchk="N";
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_deviation_approval^"+ strAppno);
    		rs = DBUtils.executeQuery(strQuery);
    		String strApprovalAccRej="";
    		while(rs.next()) 
			{
    			strApprovalAccRej=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
    			if(strApprovalAccRej.equalsIgnoreCase("A"))
    				break;
			}
			
    		hshRecord.put("ApprovalAccRej",strApprovalAccRej);
			
			/*
			String retappdevchk="N";
			strQuery = SQLParser.getSqlQuery("seldevdetails1^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs1.next())
			{
				
				retappdevchk="Y";   ///loan details record checking 
				
		    }
			if(rs1!=null){
				rs1.close();
			}
			if(retappdevchk.equalsIgnoreCase("Y")){
				strQuery = SQLParser.getSqlQuery("seldevdetails^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
				}
			}else{
				strQuery = SQLParser.getSqlQuery("selretappdeviationchk^"+strAppno);
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					hshRecord.put("DEVIATION_PENALITY",correctNull(rs1.getString("DEVIATION_PENALITY")));
					hshRecord.put("DEVIATION_CONCESSION",correctNull(rs1.getString("DEVIATION_CONCESSION")));
					hshRecord.put("DEVIATION_AS_PER_CIRCULAR",correctNull(rs1.getString("DEVIATION_AS_PER_CIRCULAR")));
					hshRecord.put("DEVIATION_MOD_REASON",correctNull(rs1.getString("DEVIATION_MOD_REASON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CON",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CON")));
					hshRecord.put("DEVIATION_MOD_INTRATE_CIR",correctNull(rs1.getString("DEVIATION_MOD_INTRATE_CIR")));
				}
			}*/
		
    		if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("Sel_app_deviation^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String strdigiApprovedUserid=correctNull(rs.getString("deviation_apprejuserid"));
				if(!strdigiApprovedUserid.equalsIgnoreCase(""))
				{
					hshRecord.put("strdigiApprovedUserid",strdigiApprovedUserid);
				}
			}
						

			if (rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_demodata^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!correctNull((String) rs.getString("DEMO_DIGI_AMBERRULES")).equalsIgnoreCase(""))
				{
					hshRecord.put("AMBER_APPROVAL", Helper.correctNull((String)rs.getString("DEMO_AMBER_APPROVAL")) );
					hshRecord.put("AMBER_APPROVAL_ID", Helper.correctNull((String)rs.getString("DEMO_USERID")) );
					hshRecord.put("DEMO_AMBER_APPROVAL", Helper.correctNull((String)rs.getString("DEMO_AMBER_APPROVAL")) );
					hshRecord.put("DEMO_AMBER_DATE", Helper.correctNull((String)rs.getString("DEMO_AMBER_DATE")) );
				}
			}
			
			} catch (Exception ce) {
			throw new EJBException("Error in getData of Limit of Loan ::  "+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getEligibleAmount(HashMap hshRequestValues)
			 {

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		//String strQuery = "";
		String strOrgAppno = "";
		//String strAppno = "";
		//String strPrdid = "";
		//String strAmtReq = "";
		//String strEmployment = "";
		//String strTemp = "";
		//String strRepCapacityRate = "1";
		//String strMonthlyIncome = "1";
		String strActualMargin = "0.00";
		//String strTotalIncome = "";
		//String strMonthlyEMI = "0.00";
		String strCostLoanPrd = "0.00";
		//String strCheckEmployment = "";
		//String emiamt = "";
		//double intRate = 1.00;
		//double intTemp = 0.00;
		double lessmarginamt = 0.0;
		//String strnoofterms = "";
		double appnetincome = 0.0;
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		double annualnetincome = 0.0;
		//double fourannualnetincome = 0.0;
		//double threeannualnetincome = 0.0;

		try {

			hshRecord = new HashMap();
			strOrgAppno = correctNull((String) hshRequestValues.get("orgappno"));
			//strAppno = correctNull((String) hshRequestValues.get("appno"));
			//strPrdid = correctNull((String) hshRequestValues.get("prdid"));
			//strAmtReq = correctNull((String) hshRequestValues.get("amtreq"));
			//strnoofterms = correctNull((String) hshRequestValues.get("noofterms"));
			strActualMargin = correctNull((String) hshRequestValues
					.get("margin"));
			//strMonthlyEMI = correctNull((String) hshRequestValues.get("monthlyemi"));
			strCostLoanPrd = correctNull((String) hshRequestValues
					.get("costofloanprd"));
			hshRecord.put("strCostLoanPrd", strCostLoanPrd);
			hshRecord.put("strActualMargin", strActualMargin);
			lessmarginamt = ((100) - (Double.parseDouble(strActualMargin)))
					/ 100 * (Double.parseDouble(strCostLoanPrd));
			hshRecord.put("lessmarginamt", Helper.formatDoubleValue(lessmarginamt));
			String StrId = "";
			rs = DBUtils.executeLAPSQuery("perselappid^" + strOrgAppno);

			if (rs.next()) {
				StrId = rs.getString(1);
			}
			rs = DBUtils.executeLAPSQuery("perselappnetincome^" + StrId);

			while (rs.next()) {
				appnetincome = rs.getDouble(1);
			}
			annualnetincome = 12 * appnetincome;
			hshRecord.put("AnnualNetIncome", Helper.formatDoubleValue(annualnetincome));
			//rs = DBUtils.executeLAPSQuery("setprdintrsel^" + strPrdid);

			//double temp1 = 1;
			//String temp2 = "";
			//if (rs.next()) {
			//	temp1 = rs.getDouble("prd_collpass");
				//temp2 = Helper.correctDoubleQuote(correctNull(rs.getString("prd_liqpass")));
			//}
			//fourannualnetincome = annualnetincome * temp1;
			//hshRecord.put("FourAnnualNetIncome", Double
			//		.toString(fourannualnetincome));
			//hshRecord.put("temp1", Helper.formatDoubleValue(temp1));
			//threeannualnetincome = annualnetincome * 3;
			//hshRecord.put("ThreeAnnualNetIncome", Double
			//		.toString(threeannualnetincome));
			//hshRecord.put("strAmtReq", strAmtReq);
			/*if (Double.parseDouble(strAmtReq) < fourannualnetincome) {
				if (Double.parseDouble(strAmtReq) < lessmarginamt) {
					hshRecord.put("EligibleAmt", strAmtReq);
				} else {
					hshRecord
							.put("EligibleAmt", Helper.formatDoubleValue(lessmarginamt));
				}
			} else {
				if (fourannualnetincome < lessmarginamt) {
					hshRecord.put("EligibleAmt", Double
							.toString(fourannualnetincome));
				} else {
					hshRecord
							.put("EligibleAmt", Helper.formatDoubleValue(lessmarginamt));
				}
			}*/
		} catch (Exception ce) {
			throw new EJBException("Error in getData login lifestyle "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getDocFee(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strRecAmt = "0";
		String strPrdCode = "";
		String strLesser = "<=";
		String strGreater = ">=";
		String chkStrPrdcode="";
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		double dblMinProc = 0.00, dblMaxProc = 0.00, dblPerProc = 0.00;
		double dblMinDoc = 0.00, dblMaxDoc = 0.00, dblPerDoc = 0.00;
		double dblRecAmt = 0.00, dblDocvalue = 0.00, dblProcvalue = 0.00;
		String strPrepayChargeFixed = "" , strPrepayChargeFloating="", strUpfrontFee = "";

		try {
			hshRecord = new HashMap();
			chkStrPrdcode=correctNull((String)hshRequestValues.get("prdcode"));
			String strAppno=correctNull((String)hshRequestValues.get("appid"));
			if(chkStrPrdcode.equalsIgnoreCase("")) 
			{	
				strPrdCode=correctNull((String)hshRequestValues.get("prdcode1"));
			}
			else
			{
				strPrdCode=correctNull((String)hshRequestValues.get("prdcode"));
			}	
			//strPrdCode = correctNull((String) hshRequestValues.get("prdcode"));
			strRecAmt = correctNull((String) hshRequestValues.get("recamt"));
			if (strRecAmt.trim().equals("")) {
				strRecAmt = "0.00";
			}
			dblRecAmt = Double.parseDouble(strRecAmt);
			strQuery = SQLParser.getSqlQuery("selprdprocessfee^" + strPrdCode
					+ "^" + strLesser + "^" + strRecAmt + "^" + strGreater
					+ "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				dblPerProc = rs.getDouble(1);
				dblMinProc = rs.getDouble(2);
				dblMaxProc = rs.getDouble(3);
			}
			if (dblPerProc != 0.00) {
				dblProcvalue = (dblPerProc / 100) * dblRecAmt;
			}
			/*if (dblMinProc == 0.00 && dblMaxProc == 0.00) {
				dblProcvalue = dblProcvalue;
			}*/
			if (dblPerProc == 0.00 && dblMaxProc == 0.00) {
				dblProcvalue = dblMinProc;
			}
			if (dblMinProc != 0.00 || dblMaxProc != 0.00) {
				if (dblProcvalue < dblMinProc) {
					dblProcvalue = dblMinProc;
				} else if (dblProcvalue > dblMaxProc) {
					if (dblMaxProc != 0.00) {
						dblProcvalue = dblMaxProc;
					} /*else {
						dblProcvalue = dblProcvalue;
					}*/
				}
			}
			String strQuery1;
			strQuery1 = SQLParser.getSqlQuery("selprddocumentfee^" + strPrdCode
					+ "^" + strLesser + "^" + strRecAmt + "^" + strGreater
					+ "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				dblPerDoc = rs.getDouble(1);
				dblMinDoc = rs.getDouble(2);
				dblMaxDoc = rs.getDouble(3);
			}
			if ((dblPerDoc) != 0.00) {
				dblDocvalue = (dblPerDoc / 100) * dblRecAmt;
			}
			/*if (dblMinDoc == 0.00 && dblMaxDoc == 0.00) {
				dblDocvalue = dblDocvalue;
			}*/
			if (dblPerDoc == 0.00 && dblMaxDoc == 0.00) {
				dblDocvalue = dblMinDoc;
			}
			if (dblMinDoc != 0.00 && dblMaxDoc != 0.00) {
				if (dblDocvalue < dblMinDoc) {
					dblDocvalue = dblMinDoc;
				} else if (dblDocvalue > dblMaxDoc) {
					if (dblMaxDoc != 0.00) {
						dblDocvalue = dblMaxDoc;
					} /*else {
						dblDocvalue = dblDocvalue;
					}*/
				}
			}
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("sel_prdinterest^" + strPrdCode);
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				strPrepayChargeFixed=Helper.correctDouble((String)rs.getString("prd_prepayfixed"));
				strPrepayChargeFloating=Helper.correctDouble((String)rs.getString("prd_prepayfloating"));
				strUpfrontFee=Helper.correctDouble((String)rs.getString("prd_upfrontfee"));
			}
			hshRecord.put("docfee", Helper.checkDecimal(Double
					.toString(dblDocvalue)));
			hshRecord.put("procfee", Helper.checkDecimal(Double
					.toString(dblProcvalue)));
			hshRecord.put("procfeenew", Helper.checkDecimal(Double
					.toString(dblProcvalue)));
			hshRecord.put("strPrepayChargeFixed", Helper.checkDecimal(strPrepayChargeFixed));
			hshRecord.put("strPrepayChargeFloating", Helper.checkDecimal(strPrepayChargeFloating));
			hshRecord.put("strUpfrontFee", Helper.checkDecimal(strUpfrontFee));
			
			//processing fee waived		
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("selloan_details^" + strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next()) 
			{
				hshRecord.put("indinfo_is_staff",correctNull(rs.getString("indinfo_is_staff")));
				if(hshRecord.get("indinfo_is_staff").equals("02"))
				{
					hshRecord.put("procfee","0.00");
					hshRecord.put("procfeenew","0.00");
				}
			}
			
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("sel_per_house_proposed_asset_new^" + strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next()) 
			{
				hshRecord.put("phpa_loan_purpose",correctNull(rs.getString("phpa_loan_purpose")));
				hshRecord.put("phpa_project_finance",correctNull(rs.getString("phpa_project_finance")));
				if((hshRecord.get("phpa_loan_purpose").equals("H") && hshRecord.get("phpa_project_finance").equals("Y")))
				{
					hshRecord.put("procfee","0.00");
					hshRecord.put("procfeenew","0.00");
				}
			}	
			// Check Deviated Value
			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("Sel_app_deviation1^" + strAppno+"^PF");
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) {
				
				if(Helper.correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("A"))
				{
					hshRecord.put("procfeenew", Helper.checkDecimal(Helper.correctDouble(rs.getString("deviation_newvalue"))));
				}
			}
			
		} catch (Exception ce) {
			throw new EJBException("Error in getData login lifestyle "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap updateDeviationData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";
		String strAction = "";
		String strUserId="",strsno="";
		String strExp="$";
		int intupdatesize=0;
		boolean bstate = false;
		boolean bolisdeviated=false;
		StringBuilder sbActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String PRD_CGTMSE=correctNull((String) hshValues.get("PRD_CGTMSE")); 
		try
		{
			strAppno = correctNull((String) hshValues.get("Applicationno"));
			if (strAppno.equalsIgnoreCase("")) 
			{
				strAppno = correctNull((String) hshValues.get("orgappno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String) hshValues.get("appno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String) hshValues.get("strappno"));
			}
			
			strAction=correctNull((String) hshValues.get("hidAction"));
			strUserId = correctNull((String)hshValues.get("strUserId"));
			strQuery = "sel_maxretailsno^" + strAppno;
			rs = DBUtils.executeLAPSQuery(strQuery);
			if (rs.next()) {
				strsno = Helper.correctNull((String) rs
						.getString("COM_SNO"));
			}
			/*String strPrdcode="",strRecmdLnamt="",strIntRate="";
			if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("selperprdintrate^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPrdcode = correctNull(rs.getString("app_prdcode"));
					strRecmdLnamt = Helper.correctDouble(rs.getString("loan_recmdamt"));
					strIntRate = Helper.correctDouble(rs.getString("loan_intrate"));
				}
				if(rs!=null){
					rs.close();
				}
			}*/
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
			 */
			String strLADevOldVal="";
			String strLADevNewVal="";
			String strLADevOldAudit="";
			String strLADevDescOldAudit="";
			String strLADevApprRejOldAudit="";
			String strLADevApprRejDescOldAudit="";
			String strMNDevOldVal="";
			String strMNDevNewVal="";
			String strMNDevOldAudit="";
			String strMNDevDescOldAudit="";
			String strMNDevApprRejOldAudit="";
			String strMNDevApprRejDescOldAudit="";
			String strPFDevApprRejOldAudit="";
			String strPFDevApprRejDescOldAudit="";
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^LA");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLADevOldVal=Helper.correctDouble((String)rs.getString("DEVIATION_OLDVALUE"));
				strLADevNewVal=Helper.correctDouble((String)rs.getString("DEVIATION_NEWVALUE"));
				strLADevOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_REQ"));
				if(strLADevOldAudit.equalsIgnoreCase("Y"))
				{
					strLADevDescOldAudit="Yes";
				}
				else if(strLADevOldAudit.equalsIgnoreCase("N"))
				{
					strLADevDescOldAudit="No";
				}
				strLADevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strLADevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strLADevApprRejDescOldAudit="Approve";
				}
				else if(strLADevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strLADevApprRejDescOldAudit="Reject";
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^MN");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strMNDevOldVal=Helper.correctDouble((String)rs.getString("DEVIATION_OLDVALUE"));
				strMNDevNewVal=Helper.correctDouble((String)rs.getString("DEVIATION_NEWVALUE"));
				strMNDevOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_REQ"));
				if(strMNDevOldAudit.equalsIgnoreCase("Y"))
				{
					strMNDevDescOldAudit="Yes";
				}
				else if(strMNDevOldAudit.equalsIgnoreCase("N"))
				{
					strMNDevDescOldAudit="No";
				}
				strMNDevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strMNDevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strMNDevApprRejDescOldAudit="Approve";
				}
				else if(strMNDevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strMNDevApprRejDescOldAudit="Reject";
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^PF");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPFDevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strMNDevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strPFDevApprRejDescOldAudit="Approve";
				}
				else if(strMNDevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strPFDevApprRejDescOldAudit="Reject";
				}
			}
			sbOldAudit.append("~Loan Amount Defined Value = ").append(strLADevOldVal)
			.append("~Loan Amount Deviation = ").append(strLADevDescOldAudit)
			.append("~Loan Amount New Value = ").append(strLADevNewVal)
			.append("~Loan Amount Approval = ").append(strLADevApprRejDescOldAudit)
			.append("~Margin (%) Defined Value = ").append(strMNDevOldVal)
			.append("~Margin (%) Deviation = ").append(strMNDevDescOldAudit)
			.append("~Margin (%) New Value = ").append(strMNDevNewVal)
			.append("~Margin (%) Approval = ").append(strMNDevApprRejDescOldAudit);
			/***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("approve"))
			{
				if (correctNull((String) hshValues.get("sel_loanamount")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_loandivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_loanamount")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_loanamount")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
						
					}
	
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_amount_loandetails");
					intupdatesize++;
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_loanamountnew")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);					
				}
				else if (correctNull((String) hshValues.get("sel_loanamount")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(correctNull((String) hshValues.get("sel_interestrate")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_interestdivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_interestrate")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//

						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_interestrate")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
				}
				else if (correctNull((String) hshValues.get("sel_interestrate")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_tenor")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_tenordivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
						arrValues.add(correctNull((String) hshValues.get("sel_tenor")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
						arrValues.add(correctNull((String) hshValues.get("sel_tenor")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_tenor")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_margin")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_margindivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_margin")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_margin")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//

						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_margin")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("Y")) {
					
					bolisdeviated=true;
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_retirementdivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_retirement")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_retirement")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					
						
				}
				else if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
	
				if (correctNull((String) hshValues.get("sel_repaycapacity")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_repaydivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_repaymentold")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
						arrValues.add(correctNull((String) hshValues.get("sel_repaycapacity")));
						arrValues.add(correctNull((String) hshValues.get("txt_repayremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaymentold")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
						arrValues.add(correctNull((String) hshValues.get("sel_repaycapacity")));
						arrValues.add(correctNull((String) hshValues.get("txt_repayremarks")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//

						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_repaycapacity")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_procfeedivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_procfee")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeerem")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_procfee")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeerem")));
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
					
				}
				else if (correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				/*if (correctNull((String) hshValues.get("sel_documentationfees"))
						.equalsIgnoreCase("Y")) {
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesdivtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeestold")));
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesnew")));
					arrValues.add(correctNull((String) hshValues.get("sel_documentationfees")));
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesremarks")));
					arrValues.add("");
					hshQueryValues.put("size", "1");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
				}
				else if (correctNull((String) hshValues.get("sel_documentationfees")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}*/
				if(correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_otherdevtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add(correctNull((String) hshValues.get("sel_otherdev")));
						arrValues.add(correctNull((String) hshValues.get("txt_odrem")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add(correctNull((String) hshValues.get("sel_otherdev")));
						arrValues.add(correctNull((String) hshValues.get("txt_odrem")));
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				else if(correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("N"))
				{
					
					intupdatesize++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				//----- added by prashanth for other specify---------------------------------------------------
				//1
				/*if (correctNull((String) hshValues.get("sel_otherspecify1")).equalsIgnoreCase("Y")) 
				{
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
						
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1divtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1old")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1new")));
					arrValues.add(correctNull((String) hshValues.get("sel_otherspecify1")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1remarks")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1")));
					hshQueryValues.put("size", Integer.toString(intupdatesize));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				else if (correctNull((String) hshValues.get("sel_otherspecify1")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify1divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				//2
				
				if (correctNull((String) hshValues.get("sel_otherspecify2")).equalsIgnoreCase("Y")) 
				{
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
						
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2old")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2new")));
					arrValues.add(correctNull((String) hshValues.get("sel_otherspecify2")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2remarks")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2")));
					hshQueryValues.put("size", Integer.toString(intupdatesize));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				else if (correctNull((String) hshValues.get("sel_otherspecify2")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				//3
				
				if (correctNull((String) hshValues.get("sel_otherspecify3")).equalsIgnoreCase("Y")) 
				{
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
						
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3old")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3new")));
					arrValues.add(correctNull((String) hshValues.get("sel_otherspecify3")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3remarks")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3")));
					hshQueryValues.put("size", Integer.toString(intupdatesize));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				else if (correctNull((String) hshValues.get("sel_otherspecify3")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				//4
				
				if (correctNull((String) hshValues.get("sel_otherspecify4")).equalsIgnoreCase("Y")) 
				{
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
						
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4old")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4new")));
					arrValues.add(correctNull((String) hshValues.get("sel_otherspecify4")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4remarks")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4")));
					hshQueryValues.put("size", Integer.toString(intupdatesize));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				else if (correctNull((String) hshValues.get("sel_otherspecify4")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				//5
				
				if (correctNull((String) hshValues.get("sel_otherspecify5")).equalsIgnoreCase("Y")) 
				{
					
					bolisdeviated=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
						
					hshQuery.put("strQueryId", "ins_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5old")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5new")));
					arrValues.add(correctNull((String) hshValues.get("sel_otherspecify5")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5remarks")));
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5")));
					hshQueryValues.put("size", Integer.toString(intupdatesize));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				else if (correctNull((String) hshValues.get("sel_otherspecify5")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}*/
				
				//-----End ---------------  
				
				if(strAction.equalsIgnoreCase("update"))
				{
					if(bolisdeviated)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_isdeviated_appln");
						intupdatesize++;
						arrValues.add("Y");
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else if(!bolisdeviated)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_isdeviated_appln");
						intupdatesize++;
						arrValues.add("N");
						arrValues.add("");
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				//if(!(correctNull((String)hshValues.get("dev_prop_no")).equalsIgnoreCase("")))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("dev_prop_no")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_permprop_no");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
				}
				
				hshQueryValues.put("size",Integer.toString(intupdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}	
		    if(strAction.equalsIgnoreCase("approve"))
			{
				//if(checkDiscretionarypower(hshValues))
				//{
		    		intupdatesize=0;
		    		hshQueryValues=new HashMap();
					boolean boolloanamt=false;
					boolean boolrepaycapcity=false;
					boolean boolapproveorreject = false;
					int intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenorold")));
					double dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestrateold")));
					double dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
					double dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("repayold")));
										
					/* 
					 * For updating the Sanctioned loan amount in loan details table
					 */
					if (correctNull((String) hshValues.get("hidloanamt")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_laflag")))))
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						bolisdeviated=true;
						boolloanamt=true;
						hshQuery.put("strQueryId", "agr_ins_EMI_loandetail");
						if(Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase("A")){
							String strCollpercent="";
							PerApplicantBean perapp = new PerApplicantBean();
							strCollpercent = perapp.getCollateralpercent(strAppno, correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(strCollpercent);
							dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountnew")));	
						}
						else if(Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase("R")){
							//bring calculated value
							String strCollpercent="";
							PerApplicantBean perapp = new PerApplicantBean();
							strCollpercent = perapp.getCollateralpercent(strAppno, correctNull((String) hshValues.get("txt_loanamountold")));
							arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountold")));
							arrValues.add(strCollpercent);
							dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
						}
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						 
						if(Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase("A"))
						{
							if(!strPFDevApprRejDescOldAudit.equals("A"))
							{
								HashMap hshGetDocFee=new HashMap();
								HashMap hshTemp=new HashMap();
								String strPrdcode="";
								if(rs!=null){
									rs.close();
								}
								strQuery=SQLParser.getSqlQuery("selperprdintrate^"+strAppno);
								rs=DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strPrdcode = correctNull(rs.getString("app_prdcode"));
								}
								
								hshTemp.put("appid", strAppno);
								hshTemp.put("prdcode", strPrdcode);
								hshTemp.put("recamt", Helper.correctNull((String) hshValues.get("txt_loanamountnew")));
								
								hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getDocFee");
								String strLoanDocFee = Helper.correctDouble((String)hshGetDocFee.get("docfee"));
								String strLoanProcFee = Helper.correctDouble((String) hshGetDocFee.get("procfeenew"));
								
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								intupdatesize++;
								arrValues.add(strLoanProcFee);
								arrValues.add(strLoanDocFee);
								arrValues.add(strAppno);
								hshQuery.put("arrValues",arrValues);				
								hshQuery.put("strQueryId","upd_procfee_docfee_loandetails");
								hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
							}
							
							//Update CBS Details tab
							if(rs!=null)
								rs.close();
							strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^1");
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								if(Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
								{
									intupdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									arrValues.add(correctNull((String)hshValues.get("txt_loanamountnew")));
									arrValues.add(strAppno);
									arrValues.add("1");
									hshQuery.put("arrValues",arrValues); 
									hshQuery.put("strQueryId","updcbsdetails"); 
									hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
								}
								else
								{
									intupdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									arrValues.add(strAppno);
									arrValues.add("1");
									hshQuery.put("arrValues",arrValues); 
									hshQuery.put("strQueryId","setcbsdetailsdel"); 
									hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
								}
							}
						}						
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_la")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_la_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						
					}
					
					/* 
					 * For updating the Sanctioned interest amount in loan details table
					 */
					if (correctNull((String) hshValues.get("hidintrate")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_intrate")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_intrate")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_intflag"))))) 
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_interest_EMI_loandetails");
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_intrate")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_interestratenew")));
							dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestratenew")));	
						}
						else if(Helper.correctNull((String) hshValues.get("select_intrate")).equalsIgnoreCase("R")){
							arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
							dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestrateold")));	
						
						}
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
												
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_intrate")));
						arrValues.add(strUserId);
						arrValues.add("");
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "update_creditdevspreadval");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("hidcreditrskpremium")));
						arrValues.add(correctNull((String) hshValues.get("hidbusstrategicpremium")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						
						if(PRD_CGTMSE.equals("Y"))
						{
							double CGTMSE_intSplitup=0.00;
							if(rs!=null)
							{
								rs.close();
							}
							strQuery=SQLParser.getSqlQuery("select_loandetails^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								CGTMSE_intSplitup=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_CG_PERCENT")));
							}
							
							double cgtmse_totint=dblInterestRate+CGTMSE_intSplitup;
							
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							intupdatesize++;
							arrValues.add(String.valueOf(cgtmse_totint));
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);				
							hshQuery.put("strQueryId","upd_cg_totIntrate");
							hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						}
						
					}
					/* 
					 * For updating the Sanctioned repayment period in loan details table
					 */
					if (correctNull((String) hshValues.get("hidtenor")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_tenor")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_tenor")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_tenorflag"))))) 
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_terms_EMI_loandetails");
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_tenor")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
							intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenornew")));	
						}
						else if(Helper.correctNull((String) hshValues.get("select_tenor")).equalsIgnoreCase("R"))
						{
							arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
							intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenorold")));	
						}
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_tenor")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_tenor_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					/* 
					 * For updating the Sanctioned margin in loan details table
					 */
					if (correctNull((String) hshValues.get("hidmargin")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_margin")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_margin")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_marginflag"))))) 
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_margin_EMI_loandetails");
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_margin")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));}
						else if(Helper.correctNull((String) hshValues.get("select_margin")).equalsIgnoreCase("R"))
						{
							arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
						}
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hidMarinEligibleAmt")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEligibleAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_margin")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_margin_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					/*
					 * For updating the retirement age
					 */
					if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("Y")
							&& !Helper.correctNull((String) hshValues.get("select_rage")).equalsIgnoreCase("S")
							&& !(Helper.correctNull((String) hshValues.get("select_rage")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_rageflag"))))) 
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "update_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_rage")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_rage_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					/*
					 * For updating the Sanctioned Repayment Capacity in loan details table
					 */
					if (correctNull((String) hshValues.get("hidrepaycapacity")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_repayment")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_repayment")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_repayflag")))))
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_repay_loandetails");
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_repayment")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
							dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_repaynew")));	
						}
						else if(Helper.correctNull((String) hshValues.get("select_repayment")).equalsIgnoreCase("R"))
						{
							arrValues.add(correctNull((String) hshValues.get("txt_repayold")));
							dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_repayold")));	
						}
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_repayment")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_repayment_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					} 
					
					/*
					 * For updating the Sanctioned processing fees in loan details table
					 */
					if (correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("Y")
							&& !(Helper.correctNull((String) hshValues.get("select_processfee")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_processfee")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_PFflag")))))
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_process_loandetails");
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_processfee")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));}
						else if(Helper.correctNull((String) hshValues.get("select_processfee")).equalsIgnoreCase("R"))
						{
							arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
						}
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_processfee")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_processfee_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					} 
					/*if (correctNull((String) hshValues.get("sel_documentationfees")).equalsIgnoreCase("Y")&& !(Helper.correctNull((String) hshValues.get("select_docfee")).equalsIgnoreCase("S"))) 
					{
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_documentation_loandetails");
						bolisdeviated=true;
						intupdatesize++;
						if(Helper.correctNull((String) hshValues.get("select_docfee")).equalsIgnoreCase("A")){
							arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesnew")));}
						else if(Helper.correctNull((String) hshValues.get("select_docfee")).equalsIgnoreCase("R"))
						{
							arrValues.add(correctNull((String) hshValues.get("txt_documentationfeestold")));
						}
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_docfee")));
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesdivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					} */
					//Added by Anitha
					if (correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("Y") 
							&& !(Helper.correctNull((String) hshValues.get("select_od")).equalsIgnoreCase("S"))
							&& !(Helper.correctNull((String) hshValues.get("select_od")).equalsIgnoreCase(Helper.correctNull((String) hshValues.get("hid_ODflag"))))) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_od")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_od_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					/*
					if (correctNull((String) hshValues.get("sel_otherspecify2")).equalsIgnoreCase("Y") && !(Helper.correctNull((String) hshValues.get("select_otherspec2")).equalsIgnoreCase("S"))) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_otherspec2")));
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					if (correctNull((String) hshValues.get("sel_otherspecify3")).equalsIgnoreCase("Y") && !(Helper.correctNull((String) hshValues.get("select_otherspec3")).equalsIgnoreCase("S"))) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_otherspec3")));
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					if (correctNull((String) hshValues.get("sel_otherspecify4")).equalsIgnoreCase("Y") && !(Helper.correctNull((String) hshValues.get("select_otherspec4")).equalsIgnoreCase("S"))) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_otherspec4")));
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					if (correctNull((String) hshValues.get("sel_otherspecify5")).equalsIgnoreCase("Y") && !(Helper.correctNull((String) hshValues.get("select_otherspec5")).equalsIgnoreCase("S"))) 
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_otherspec5")));
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}*/
					//Ends
					if (!correctNull((String) hshValues.get("txt_otherdevremarks")).equalsIgnoreCase("")) 
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("OD");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation");
						bolisdeviated=true;
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdivtype")));
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("Y");
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevremarks")));
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					//Interest Rate Reference number by Guhan Tamilvanan
					if (!correctNull((String) hshValues.get("txt_intrefno")).equalsIgnoreCase("")) 
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("IRRN");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation1");
						bolisdeviated=true;
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_intraterefnotype")));
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("Y");
						arrValues.add(correctNull((String) hshValues.get("txt_intrefno")));
						/*arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						*/
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//==========added for sacnction  rate deviation//
						intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String) hshValues.get("txt_concession")));
						arrValues.add(correctNull((String) hshValues.get("txt_asper_circular")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String) hshValues.get("hidsel_reasonforcir")));
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","insertdevdetails"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));
                       //==================end========================//
						/*intupdatesize++;
					   	hshQuery=new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strsno);
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String)hshValues.get("txt_app_roi")));
						arrValues.add(correctNull((String)hshValues.get("txt_dev_penality")));
						arrValues.add(correctNull((String)hshValues.get("txt_concession")));
						arrValues.add(correctNull((String)hshValues.get("txt_asper_circular")));
						
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonfor")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcon")));
						arrValues.add(correctNull((String)hshValues.get("hidsel_reasonforcir")));
						arrValues.add(strUserId);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","ins_retail_sancrate_history"); 
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intupdatesize));*/
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("IRRN");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
//					if(bolisdeviated)
//					{
//						int intMoratorium=Integer.parseInt(Helper.correctInt((String)hshValues.get("moratorium")));
//						String strInterestservised=correctNull((String)hshValues.get("servised"));
//						String strInterestcharged=correctNull((String)hshValues.get("interestcharged"));
//						if(intMoratorium > 0)
//						{
//							intTerms=intTerms-intMoratorium;	
//						}
//						if(strInterestservised.equalsIgnoreCase("y") && strInterestcharged.equals("3"))
//						{
//							double tmp =  (1+(dblInterestRate /1200));		
//							dblSanctionAmount  = 	dblSanctionAmount *(Math.pow(tmp,intMoratorium));
//						}
//						dblInterestRate = dblInterestRate / (12 * 100);
//						double dbldenom = Math.pow(dblInterestRate + 1, intTerms) - 1;
//						double dblnumer = dblInterestRate * Math.pow(dblInterestRate + 1, intTerms);
//						double dblEMI = (dblnumer / dbldenom) * dblSanctionAmount;
//
//						
//						hshQuery=new HashMap();
//						arrValues=new ArrayList();		
//						intupdatesize++;
//
//						arrValues.add(""+dblSanctionAmount);
//						arrValues.add("0.00");
//						arrValues.add("0.00");
//						arrValues.add(correctNull((String) hshValues.get("hideligibleamt")));
//						arrValues.add(""+dblrepaycapcity);
//						arrValues.add(strAppno);
//						
//						hshQuery.put("arrValues",arrValues);				
//						hshQuery.put("strQueryId","upd_sanction_amount");
//						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
//					}
					//Deleteing entries from loandetails table if deviation is approved or rejected
//					if(boolapproveorreject)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "del_date");
						intupdatesize++;
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					hshQueryValues.put("size",Integer.toString(intupdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("undo"))
			{
				//Added by Anitha
				int intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenorold")));
				double dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestrateold")));
				double dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
				double dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("repayold")));
				boolean boolisChange=false;
				String strUndoval = Helper.correctNull((String)hshValues.get("hidundoval")); 
				if (correctNull((String) hshValues.get("hidloanamt")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("loan"))
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					String strCollpercent="";
					PerApplicantBean perapp = new PerApplicantBean();
					strCollpercent = perapp.getCollateralpercent(strAppno, Helper.correctNull((String) hshValues.get("txt_loanamountold")));
					hshQuery.put("strQueryId", "agr_ins_EMI_loandetail");
					arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountold")));
					arrValues.add(strCollpercent);
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					if(!strPFDevApprRejDescOldAudit.equals("A"))
					{
						HashMap hshGetDocFee=new HashMap();
						HashMap hshTemp=new HashMap();
						String strPrdcode="";
						if(rs!=null){
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("selperprdintrate^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strPrdcode = correctNull(rs.getString("app_prdcode"));
						}
						
						hshTemp.put("appid", strAppno);
						hshTemp.put("prdcode", strPrdcode);
						hshTemp.put("recamt", Helper.correctNull((String) hshValues.get("txt_loanamountold")));
						
						hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getDocFee");
						String strLoanDocFee = Helper.correctDouble((String)hshGetDocFee.get("docfee"));
						String strLoanProcFee = Helper.correctDouble((String) hshGetDocFee.get("procfeenew"));
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strLoanProcFee);
						arrValues.add(strLoanDocFee);
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","upd_procfee_docfee_loandetails");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					
					if(strLADevApprRejDescOldAudit.equalsIgnoreCase("Approve"))
					{
						//Update CBS Details tab
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^1");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							if(Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
							{
								intupdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(correctNull((String)hshValues.get("txt_loanamountold")));
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","updcbsdetails"); 
								hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
							}
							else
							{
								intupdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","setcbsdetailsdel"); 
								hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
							}
						}
					}
				}
				if (correctNull((String) hshValues.get("hidintrate")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("int")) 
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_interest_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add("IRRN");
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","del_app_deviation");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "update_creditdevspreadval");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("hidcreditrskpremium")));
					arrValues.add(correctNull((String) hshValues.get("hidbusstrategicpremium")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
				
					if(PRD_CGTMSE.equals("Y"))
					{
						double CGTMSE_intSplitup=0.00;
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("select_loandetails^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							CGTMSE_intSplitup=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_CG_PERCENT")));
						}
						
						double cgtmse_totint= Double.parseDouble(correctNull((String) hshValues.get("txt_interestrateold")))+CGTMSE_intSplitup;
						
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(String.valueOf(cgtmse_totint));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","upd_cg_totIntrate");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					
				}
				if (correctNull((String) hshValues.get("hidtenor")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("tenor")) 
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_terms_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("hidmargin")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("margin")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_margin_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidMarinEligibleAmt")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEligibleAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("age")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "update_app_deviation");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
					arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("hidrepaycapacity")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("repay"))
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_repay_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_repayold")));
					dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_repayold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("profee"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_process_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				/*if (correctNull((String) hshValues.get("sel_documentationfees")).equalsIgnoreCase("Y")&& strUndoval.equalsIgnoreCase("docfee")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_documentation_loandetails");
					bolisdeviated=true;
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeestold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_documentationfeesdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}*/
				if (correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("Y") && strUndoval.equalsIgnoreCase("other")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(correctNull((String) hshValues.get("select_od_intr")));
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				
				/*
				if (correctNull((String) hshValues.get("sel_otherspecify2")).equalsIgnoreCase("Y") && strUndoval.equalsIgnoreCase("O2")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify2divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_otherspecify3")).equalsIgnoreCase("Y") && strUndoval.equalsIgnoreCase("O3")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify3divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_otherspecify4")).equalsIgnoreCase("Y") && strUndoval.equalsIgnoreCase("O4")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify4divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_otherspecify5")).equalsIgnoreCase("Y") && strUndoval.equalsIgnoreCase("O5")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherspecify5divtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}*/
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intupdatesize++;
				arrValues.add(strAppno);
				arrValues.add("OD");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","del_app_deviation");
				hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_date");
				intupdatesize++;
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				
//				if(boolisChange)
//				{
//					int intMoratorium=Integer.parseInt(Helper.correctInt((String)hshValues.get("moratorium")));
//					String strInterestservised=correctNull((String)hshValues.get("servised"));
//					String strInterestcharged=correctNull((String)hshValues.get("interestcharged"));
//					if(intMoratorium > 0)
//					{
//						intTerms=intTerms-intMoratorium;	
//					}
//					if(strInterestservised.equalsIgnoreCase("y") && strInterestcharged.equals("3"))
//					{
//						double tmp =  (1+(dblInterestRate /1200));		
//						dblSanctionAmount  = 	dblSanctionAmount *(Math.pow(tmp,intMoratorium));
//					}
//					dblInterestRate = dblInterestRate / (12 * 100);
//					double dbldenom = Math.pow(dblInterestRate + 1, intTerms) - 1;
//					double dblnumer = dblInterestRate * Math.pow(dblInterestRate + 1, intTerms);
//					double dblEMI = (dblnumer / dbldenom) * dblSanctionAmount;
//					
//					hshQuery=new HashMap();
//					arrValues=new ArrayList();		
//					intupdatesize++;
//					arrValues.add(""+dblSanctionAmount);
//					arrValues.add(""+dblEMI);
//					arrValues.add("0.00");
//					arrValues.add(""+dblSanctionAmount);
//					arrValues.add(""+dblrepaycapcity);
//					arrValues.add(strAppno);
//					
//					hshQuery.put("arrValues",arrValues);				
//					hshQuery.put("strQueryId","upd_sanction_amount");
//					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
//				}
				hshQueryValues.put("size",Integer.toString(intupdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("approve"))
			{
				String strLADev=Helper.correctNull((String)hshValues.get("sel_loanamount"));
				String strLADevDesc="";
				if(strLADev.equalsIgnoreCase("Y"))
				{
					strLADevDesc="Yes";
				}
				else if(strLADev.equalsIgnoreCase("N"))
				{
					strLADevDesc="No";
				}
				String strLADevApprRej=Helper.correctNull((String)hshValues.get("select_la"));
				String strLADevApprRejDesc="";
				if(strLADevApprRej.equalsIgnoreCase("A"))
				{
					strLADevApprRejDesc="Approve";
				}
				else if(strLADevApprRej.equalsIgnoreCase("R"))
				{
					strLADevApprRejDesc="Reject";
				}
				String strMNDev=Helper.correctNull((String)hshValues.get("sel_margin"));
				String strMNDevDesc="";
				if(strMNDev.equalsIgnoreCase("Y"))
				{
					strMNDevDesc="Yes";
				}
				else if(strMNDev.equalsIgnoreCase("N"))
				{
					strMNDevDesc="No";
				}
				String strMNDevApprRej=Helper.correctNull((String)hshValues.get("select_margin"));
				String strMNDevApprRejDesc="";
				if(strMNDevApprRej.equalsIgnoreCase("A"))
				{
					strMNDevApprRejDesc="Approve";
				}
				else if(strMNDevApprRej.equalsIgnoreCase("R"))
				{
					strMNDevApprRejDesc="Reject";
				}
				sbActionData.append("~Loan Amount Defined Value = ").append(Helper.correctDouble((String)hshValues.get("txt_loanamountold")))
				.append("~Loan Amount Deviation = ").append(strLADevDesc)
				.append("~Loan Amount New Value = ").append(Helper.correctDouble((String)hshValues.get("txt_loanamountnew")))
				.append("~Loan Amount Approval = ").append(strLADevApprRejDesc)
				.append("~Margin (%) Defined Value = ").append(Helper.correctDouble((String)hshValues.get("txt_marginold")))
				.append("~Margin (%) Deviation = ").append(strMNDevDesc)
				.append("~Margin (%) New Value = ").append(Helper.correctDouble((String)hshValues.get("txt_marginnew")))
				.append("~Margin (%) Approval = ").append(strMNDevApprRejDesc);
			}
			AuditTrial.auditNewLog(hshValues, "236", strAppno, sbActionData.toString(), sbOldAudit.toString());
		    /***
		     * End - Audit Trial New Data
		     */
			
			
			
		} catch (Exception ce) {
			throw new EJBException("Error found in LimitofLoan bean <-- "+ ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshValues;
	}
	
	
	private boolean checkDiscretionarypower(HashMap hshValues) 
	{
		double dbldeviatedamt=0.0;
		double dblloanrecmd=0.0;
		double dblloanreqst=0.0;
		double dblPrdSancLimit=0.0;
		
		boolean boolloanamtdeviated=false;
		
		String strQuery="";
		String strAppno="";
		String strPrdCode="";
		String strUserId="";
		ResultSet rs=null;
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		nf.setGroupingUsed(false);
		try{
			
			strUserId=correctNull((String)hshValues.get("strUserId"));
			strAppno=correctNull((String)hshValues.get("appno"));
			
			if(rs != null)
			rs.close();
			
			rs=DBUtils.executeLAPSQuery("selperprdintrate^"+strAppno);
			if(rs.next())
			{
				strPrdCode = correctNull((String)rs.getString("app_prdcode"));
			}
			
			strQuery=SQLParser.getSqlQuery("selretailsanctionlimit^"+strPrdCode+"^"+strUserId);
			if(rs != null)
			rs.close();
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblPrdSancLimit = Double.parseDouble((Helper.correctDouble((String)rs.getString("sanction_limit"))));
			}
			
			
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^LA");
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dbldeviatedamt=Double.parseDouble(Helper.correctDouble(rs.getString("deviation_newvalue")));
				boolloanamtdeviated=true;
			}
			
			if(boolloanamtdeviated)
			{
				dblloanrecmd=dbldeviatedamt;
			}
			else
			{
				
				dblloanrecmd=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
				/*if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("selloan_details^"+strAppno);			 
				if(rs.next())
				{
					dblloanreqst=rs.getDouble("amtreqd");
					dblloanrecmd=rs.getDouble("loan_recmdamt");
				}
				dblloanrecmd=dblloanreqst;/*/
			}
			
			int count=0;
			strQuery=SQLParser.getSqlQuery("selprdsanclimits^"+strPrdCode+"^<"+nf.format(dblPrdSancLimit));
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(dblloanrecmd<=rs.getDouble("sanction_limit"))
				{
					count++;
				}
			}
			
			if(count>0)
				return true;
			else
				return false;
		}catch (Exception e) {
			throw new EJBException("Error in checkDiscretionarypower :: "+e.toString());
		}
		finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch (Exception e) {
				throw new EJBException("Error in Closing Connection  :: "+e.getMessage());
			}
		}
	}
	public HashMap getPermissionPropSearch(HashMap hshRequestValues)  {
		ResultSet rs = null,rs1=null,rs2 = null;
		ArrayList arrData=new ArrayList();
		String SearchType="",strQuery="",searchVal="",strDevAppno="";
		String strappno="";
		try {
			searchVal=correctNull((String)hshRequestValues.get("txt_val"));
			SearchType=correctNull((String)hshRequestValues.get("rdovalue"));
			
			strappno=correctNull((String)hshRequestValues.get("strappno"));
			boolean bflag=false;
			if(strappno.equals(""))
			{
				
				strappno= correctNull((String)hshRequestValues.get("hidAppNo"));
			}
			String sessionModuleType=correctNull((String)hshRequestValues.get("sessionModuleType"));
			if(strappno.equals("")&&(sessionModuleType.equals("CORP") || sessionModuleType.equals("AGR")))
			{
				
				strappno= correctNull((String)hshRequestValues.get("appnofortest"));
			}
			if(SearchType.equalsIgnoreCase("cbsid"))
			{
				bflag=false;
				if(sessionModuleType.equals("RET") || sessionModuleType.equals("LAD"))
				{
					strQuery=SQLParser.getSqlQuery("sel_permappl_cbsserach_ret^"+strappno+"^"+searchVal);
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						bflag=true;
					}
				}
				else if(sessionModuleType.equals("CORP") || sessionModuleType.equals("AGR"))
				{
					strQuery=SQLParser.getSqlQuery("sel_permappl_cbsserach_corpagri^"+strappno+"^"+searchVal+"^"+strappno+"^"+searchVal);
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						bflag=true;
					}
				}
				if(bflag)
				{
					strQuery=SQLParser.getSqlQuery("sel_cbsid^"+searchVal);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strDevAppno="";
						ArrayList arrVal=new ArrayList();
						arrVal.add(Helper.correctNull(rs.getString("DEV_APPNO")));
						if(rs1!=null)
						{rs1.close();}
							strQuery=SQLParser.getSqlQuery("sel_cbsid1^"+Helper.correctNull(rs.getString("DEV_APPNO")));
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								strDevAppno=strDevAppno+","+Helper.correctNull(rs1.getString("appl_attach"));
							}
						arrVal.add(strDevAppno.replaceFirst(",", ""));
						arrVal.add(Helper.correctNull(rs.getString("PG_APPLIANTNAME")));
						arrVal.add(Helper.correctNull(rs.getString("DEV_PROCESSDATE")));
						//arrVal.add("2022-5-22");
						arrVal.add(Helper.correctNull(rs.getString("SYSDATE")));
						arrData.add(arrVal);
					}
				}
			}
			else if(SearchType.equalsIgnoreCase("perm_no"))
			{
				bflag=false;
				strQuery=SQLParser.getSqlQuery("sel_permission_no^"+searchVal);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					String DEV_CBSID=Helper.correctNull(rs.getString("DEV_CBSID"));
					String dev_type=Helper.correctNull(rs.getString("dev_type"));
					
					if(!DEV_CBSID.equals("") && !dev_type.equals("2"))
					{
						if(sessionModuleType.equals("RET") || sessionModuleType.equals("LAD"))
						{
							strQuery=SQLParser.getSqlQuery("sel_permappl_cbsserach_ret^"+strappno+"^"+DEV_CBSID);
							rs2 = DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								bflag=true;
							}
						}
						else if(sessionModuleType.equals("CORP") || sessionModuleType.equals("AGR"))
						{
							strQuery=SQLParser.getSqlQuery("sel_permappl_cbsserach_corpagri^"+strappno+"^"+DEV_CBSID+"^"+strappno+"^"+DEV_CBSID);
							rs2 = DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								bflag=true;
							}
						}
					}
					else
					{
						bflag=true;
					}
						
					if(bflag)
					{
						strDevAppno="";
						ArrayList arrVal=new ArrayList();
						arrVal.add(Helper.correctNull(rs.getString("DEV_APPNO")));
						if(rs1!=null)
						{rs1.close();}
							strQuery=SQLParser.getSqlQuery("sel_cbsid1^"+Helper.correctNull(rs.getString("DEV_APPNO")));
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								strDevAppno=strDevAppno+","+Helper.correctNull(rs1.getString("appl_attach"));
							}
						arrVal.add(strDevAppno.replaceFirst(",", ""));
						arrVal.add(Helper.correctNull(rs.getString("PG_APPLIANTNAME")));
						arrVal.add(Helper.correctNull(rs.getString("DEV_PROCESSDATE")));
						//arrVal.add("2022-5-22");
						arrVal.add(Helper.correctNull(rs.getString("SYSDATE")));
						arrData.add(arrVal);
					}
				}
			}
			else 
			{
				
				bflag=true;
				if(sessionModuleType.equals("RET") || sessionModuleType.equals("LAD"))
					strQuery=SQLParser.getSqlQuery("sel_perm_approvappl_cbsid_ret^"+strappno);
				else if(sessionModuleType.equals("CORP") || sessionModuleType.equals("AGR"))
					strQuery=SQLParser.getSqlQuery("sel_perm_approvappl_cbsid_corpagri^"+strappno);

				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strDevAppno="";
					ArrayList arrVal=new ArrayList();
					arrVal.add(Helper.correctNull(rs.getString("DEV_APPNO")));
					if(rs1!=null)
					{rs1.close();}
						strQuery=SQLParser.getSqlQuery("sel_cbsid1^"+Helper.correctNull(rs.getString("DEV_APPNO")));
						rs1 = DBUtils.executeQuery(strQuery);
						while(rs1.next())
						{
							strDevAppno=strDevAppno+","+Helper.correctNull(rs1.getString("appl_attach"));
						}
					arrVal.add(strDevAppno.replaceFirst(",", ""));
					arrVal.add(Helper.correctNull(rs.getString("PG_APPLIANTNAME")));
					arrVal.add(Helper.correctNull(rs.getString("DEV_PROCESSDATE")));
					//arrVal.add("2022-5-22");
					arrVal.add(Helper.correctNull(rs.getString("SYSDATE")));
					arrData.add(arrVal);
				}
			}
			hshRequestValues.put("arrData",arrData);
			hshRequestValues.put("strappno",strappno);
			hshRequestValues.put("bflag",String.valueOf(bflag));	
			if(rs!=null)
			{
				rs.close();
			}
		} catch (Exception ce) {
			throw new EJBException("Error in getPermissionPropSearch "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRequestValues;
	}
	
	
	public HashMap updateDigiDeviationData(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs = null;
		String strQuery = "";
		String strAppno = "";
		String strAction = "";
		String strUserId="";
		String strExp="$";
		int intupdatesize=0;
		boolean bstate = false;
		boolean bolisdeviated=false;
		StringBuilder sbActionData=new StringBuilder();
		StringBuilder sbOldAudit = new StringBuilder();
		String PRD_CGTMSE=correctNull((String) hshValues.get("PRD_CGTMSE")); 
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	try
		{  
    		String selInterestrate=""; //Helper.correctNull((String) hshValues.get("sel_interestrate"));
			
			 selInterestrate= Helper.correctNull((String) hshValues.get("sel_interestrate"));
			strAppno = correctNull((String) hshValues.get("Applicationno"));
			if (strAppno.equalsIgnoreCase("")) 
			{
				strAppno = correctNull((String) hshValues.get("orgappno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String) hshValues.get("appno"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String) hshValues.get("strappno"));
			}
			strAction=correctNull((String) hshValues.get("hidAction"));
			strUserId = correctNull((String)hshValues.get("strUserId"));
			/*String strPrdcode="",strRecmdLnamt="",strIntRate="";
			if(strAction.equalsIgnoreCase("approve") || strAction.equalsIgnoreCase("undo"))
			{
				strQuery=SQLParser.getSqlQuery("selperprdintrate^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strPrdcode = correctNull(rs.getString("app_prdcode"));
					strRecmdLnamt = Helper.correctDouble(rs.getString("loan_recmdamt"));
					strIntRate = Helper.correctDouble(rs.getString("loan_intrate"));
				}
				if(rs!=null){
					rs.close();
				}
			}*/
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
			 */
			String strLADevOldVal="";
			String strLADevNewVal="";
			String strLADevOldAudit="";
			String strLADevDescOldAudit="";
			String strLADevApprRejOldAudit="";
			String strLADevApprRejDescOldAudit="";
			String strMNDevOldVal="";
			String strMNDevNewVal="";
			String strMNDevOldAudit="";
			String strMNDevDescOldAudit="";
			String strMNDevApprRejOldAudit="";
			String strMNDevApprRejDescOldAudit="";
			String strPFDevApprRejOldAudit="";
			String strPFDevApprRejDescOldAudit="";
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^LA");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strLADevOldVal=Helper.correctDouble((String)rs.getString("DEVIATION_OLDVALUE"));
				strLADevNewVal=Helper.correctDouble((String)rs.getString("DEVIATION_NEWVALUE"));
				strLADevOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_REQ"));
				if(strLADevOldAudit.equalsIgnoreCase("Y"))
				{
					strLADevDescOldAudit="Yes";
				}
				else if(strLADevOldAudit.equalsIgnoreCase("N"))
				{
					strLADevDescOldAudit="No";
				}
				strLADevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strLADevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strLADevApprRejDescOldAudit="Approve";
				}
				else if(strLADevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strLADevApprRejDescOldAudit="Reject";
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^MN");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strMNDevOldVal=Helper.correctDouble((String)rs.getString("DEVIATION_OLDVALUE"));
				strMNDevNewVal=Helper.correctDouble((String)rs.getString("DEVIATION_NEWVALUE"));
				strMNDevOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_REQ"));
				if(strMNDevOldAudit.equalsIgnoreCase("Y"))
				{
					strMNDevDescOldAudit="Yes";
				}
				else if(strMNDevOldAudit.equalsIgnoreCase("N"))
				{
					strMNDevDescOldAudit="No";
				}
				strMNDevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strMNDevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strMNDevApprRejDescOldAudit="Approve";
				}
				else if(strMNDevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strMNDevApprRejDescOldAudit="Reject";
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strAppno+"^PF");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPFDevApprRejOldAudit=Helper.correctNull((String)rs.getString("DEVIATION_APPREJ"));
				if(strMNDevApprRejOldAudit.equalsIgnoreCase("A"))
				{
					strPFDevApprRejDescOldAudit="Approve";
				}
				else if(strMNDevApprRejOldAudit.equalsIgnoreCase("R"))
				{
					strPFDevApprRejDescOldAudit="Reject";
				}
			}
			sbOldAudit.append("~Loan Amount Defined Value = ").append(strLADevOldVal)
			.append("~Loan Amount Deviation = ").append(strLADevDescOldAudit)
			.append("~Loan Amount New Value = ").append(strLADevNewVal)
			.append("~Loan Amount Approval = ").append(strLADevApprRejDescOldAudit)
			.append("~Margin (%) Defined Value = ").append(strMNDevOldVal)
			.append("~Margin (%) Deviation = ").append(strMNDevDescOldAudit)
			.append("~Margin (%) New Value = ").append(strMNDevNewVal)
			.append("~Margin (%) Approval = ").append(strMNDevApprRejDescOldAudit);
			/***
			 * End - Audit Trial Old Data
			 */
			if(strAction.equalsIgnoreCase("update"))
			{
				if (correctNull((String) hshValues.get("sel_loanamount")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_loandivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_loanamount")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_loanamount")));
						arrValues.add(correctNull((String) hshValues.get("txt_loanremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
	
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_amount_loandetails");
					intupdatesize++;
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_loanamountnew")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);					
				}
				else if (correctNull((String) hshValues.get("sel_loanamount")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(correctNull((String) hshValues.get("sel_interestrate")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_interestdivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_interestrate")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestratenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_interestrate")));
						arrValues.add(correctNull((String) hshValues.get("txt_interestrateremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
				}
				else if (correctNull((String) hshValues.get("sel_interestrate")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_tenor")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_tenordivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
						arrValues.add(correctNull((String) hshValues.get("sel_tenor")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
						arrValues.add(correctNull((String) hshValues.get("sel_tenor")));
						arrValues.add(correctNull((String) hshValues.get("txt_tenorremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_tenor")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if (correctNull((String) hshValues.get("sel_margin")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_margindivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_margin")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_margin")));
						arrValues.add(correctNull((String) hshValues.get("txt_marginremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_margin")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("Y")) {
					
					bolisdeviated=true;
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_retirementdivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_retirement")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(correctNull((String) hshValues.get("sel_retirement")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
						
				}
				else if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
	
				if (correctNull((String) hshValues.get("sel_repaycapacity")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_repaydivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_repaymentold")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
						arrValues.add(correctNull((String) hshValues.get("sel_repaycapacity")));
						arrValues.add(correctNull((String) hshValues.get("txt_repayremarks")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaymentold")));
						arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
						arrValues.add(correctNull((String) hshValues.get("sel_repaycapacity")));
						arrValues.add(correctNull((String) hshValues.get("txt_repayremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				else if (correctNull((String) hshValues.get("sel_repaycapacity")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				if(correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("Y"))
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_procfeedivtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_procfee")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeerem")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));
						arrValues.add(correctNull((String) hshValues.get("sel_procfee")));
						arrValues.add(correctNull((String) hshValues.get("txt_procfeerem")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
					
				}
				else if (correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("N"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				 
				if(correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("Y")) 
				{
					bolisdeviated=true;
					
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("Sel_app_deviation1^"+strAppno+"^"+correctNull((String) hshValues.get("txt_otherdevtype")));
					if(rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_app_deviation1");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationOld")));
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationNew")));
						arrValues.add(correctNull((String) hshValues.get("sel_otherdev")));
						arrValues.add(correctNull((String) hshValues.get("txt_odrem")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationOld")));
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationNew")));
						arrValues.add(correctNull((String) hshValues.get("sel_otherdev")));
						arrValues.add(correctNull((String) hshValues.get("txt_odrem")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				else if(correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("N"))
				{
					
					intupdatesize++;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "del_app_deviation");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				}
				
				if(strAction.equalsIgnoreCase("update"))
				{
					if(bolisdeviated)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_isdeviated_appln");
						intupdatesize++;
						arrValues.add("Y");
						arrValues.add(strUserId);
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else if(!bolisdeviated)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "upd_isdeviated_appln");
						intupdatesize++;
						arrValues.add("N");
						arrValues.add("");
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					
				}
				
				//if(!(correctNull((String)hshValues.get("dev_prop_no")).equalsIgnoreCase("")))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("dev_prop_no")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_permprop_no");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
				}
				
				hshQueryValues.put("size",Integer.toString(intupdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				
				//interest penalty 
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(correctNull((String) hshValues.get("txt_penall_int")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","upd_loandetail_digi_penalint");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add("Y");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","upd_BREupdate_flag");
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
			}	
		    if(strAction.equalsIgnoreCase("approve"))
			{
				//if(checkDiscretionarypower(hshValues))
				//{
		    		intupdatesize=0;
		    		hshQueryValues=new HashMap();
					boolean boolloanamt=false;
					boolean boolrepaycapcity=false;
					boolean boolapproveorreject = false;
					int intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenorold")));
					double dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestrateold")));
					double dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
					double dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("repayold")));
										
					/* 
					 * For updating the Sanctioned loan amount in loan details table
					 */
					 
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						bolisdeviated=true;
						boolloanamt=true;
						hshQuery.put("strQueryId", "agr_ins_EMI_loandetail");
							String strCollpercent="";
							PerApplicantBean perapp = new PerApplicantBean();
							strCollpercent = perapp.getCollateralpercent(strAppno, correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountnew")));
							arrValues.add(strCollpercent);
							dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountnew")));	
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						 
						{
							//Update CBS Details tab
							if(rs!=null)
								rs.close();
							strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^1");
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								if(Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
								{
									intupdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									arrValues.add(correctNull((String)hshValues.get("txt_loanamountnew")));
									arrValues.add(strAppno);
									arrValues.add("1");
									hshQuery.put("arrValues",arrValues); 
									hshQuery.put("strQueryId","updcbsdetails"); 
									hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
								}
								else
								{
									intupdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									arrValues.add(strAppno);
									arrValues.add("1");
									hshQuery.put("arrValues",arrValues); 
									hshQuery.put("strQueryId","setcbsdetailsdel"); 
									hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
								}
							}
						}						
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_la")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_la_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
					
					/* 
					 * For updating the Sanctioned interest amount in loan details table
					 */
					 
						//interest rate removed
					/* 
					 * For updating the Sanctioned repayment period in loan details table
					 */
					 
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_terms_EMI_loandetails");
						intupdatesize++;
							arrValues.add(correctNull((String) hshValues.get("txt_tenornew")));
							intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenornew")));	
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_tenor")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_tenor_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					/* 
					 * For updating the Sanctioned margin in loan details table
					 */
					 
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_margin_EMI_loandetails");
						intupdatesize++;
							arrValues.add(correctNull((String) hshValues.get("txt_marginnew")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
						arrValues.add(Helper.correctNull((String)hshValues.get("hidMarinEligibleAmt")));
						arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_margin")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_margin_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					/*
					 * For updating the retirement age
					 */
					 
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "update_app_deviation");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
						arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_rage")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_rage_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					/*
					 * For updating the Sanctioned Repayment Capacity in loan details table
					 */
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_repay_loandetails");
						intupdatesize++;
						arrValues.add(correctNull((String) hshValues.get("txt_repaynew")));
						dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_repaynew")));	
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_repayment")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_repayment_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					/*
					 * For updating the Sanctioned processing fees in loan details table
					 */
						boolapproveorreject=true;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						bolisdeviated=true;
						hshQuery.put("strQueryId", "upd_process_loandetails");
						intupdatesize++;
							arrValues.add(correctNull((String) hshValues.get("txt_procfeenew")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
						
						//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_processfee")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_processfee_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					//Added by Anitha
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(Helper.correctNull((String) hshValues.get("select_od")));
						arrValues.add(strUserId);
						arrValues.add(Helper.correctNull((String) hshValues.get("select_od_intr")));
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","app_deviation_apprej");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					if (!correctNull((String) hshValues.get("txt_otherdevremarks")).equalsIgnoreCase("")) 
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("OD");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						bolisdeviated=true;
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_otherdivtype")));
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationOld")));
						arrValues.add(correctNull((String) hshValues.get("txt_otherDeviationNew")));
						arrValues.add("Y");
						arrValues.add(correctNull((String) hshValues.get("txt_otherdevremarks")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					//Interest Rate Reference number by Guhan Tamilvanan
					if (!correctNull((String) hshValues.get("txt_intrefno")).equalsIgnoreCase("")) 
					{
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("IRRN");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_app_deviation_digi");
						bolisdeviated=true;
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add(correctNull((String) hshValues.get("txt_intraterefnotype")));
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add("Y");
						arrValues.add(correctNull((String) hshValues.get("txt_intrefno")));
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					else
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(strAppno);
						arrValues.add("IRRN");
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","del_app_deviation");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}

					//Deleteing entries from loandetails table if deviation is approved or rejected
//					if(boolapproveorreject)
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "del_date");
						intupdatesize++;
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					}
					hshQueryValues.put("size",Integer.toString(intupdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					
			
				//update additional data for DIGI
					

					if ( (Helper.correctNull((String) hshValues.get("select_la")).equalsIgnoreCase("A") ) || 
						  (Helper.correctNull((String) hshValues.get("select_intrate")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_tenor")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_margin")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_rage")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_repayment")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_processfee")).equalsIgnoreCase("A")) ||
						  (Helper.correctNull((String) hshValues.get("select_od")).equalsIgnoreCase("A")) )
					{
							
						String  LOAN_DIGI_DEVIATION="",LOAN_BRE_UPDATE="",DIGI_DEVIATION_ROI="",DIGI_DEVIATION_LOAMAMT="",DIGI_DEVIATION_FOIR="",DIGI_NMI_MULTIPLIER="",DIGI_LAPSEMI="",
						DIGI_DEVIATION_MAX_EMI="",DIGI_DEVIATION_EMI="",DIGI_DEVIATION_MARGIN="",LOAN_MCLRTYPE="",loan_digi_maxemi_oldvalue="";
						double DIGI_DEVIATION_ROI_FIXED=0.00,DIGI_DEVIATION_ROI_CSP=0.00,DIGI_DEVIATION_ROI_PENALTY=0.00;
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_loandetails_digi_extra^"+strAppno);
						if(rs.next())
						{
							LOAN_DIGI_DEVIATION=Helper.correctNull(rs.getString("LOAN_DIGI_DEVIATION"));
							LOAN_BRE_UPDATE=Helper.correctNull(rs.getString("LOAN_BRE_UPDATE"));
							DIGI_DEVIATION_ROI=Helper.correctNull(rs.getString("DIGI_DEVIATION_ROI"));
							DIGI_DEVIATION_LOAMAMT=Helper.correctNull(rs.getString("DIGI_DEVIATION_LOAMAMT"));
							DIGI_DEVIATION_FOIR=Helper.correctNull(rs.getString("DIGI_DEVIATION_FOIR"));
							DIGI_NMI_MULTIPLIER=Helper.correctNull(rs.getString("DIGI_NMI_MULTIPLIER"));
							DIGI_DEVIATION_ROI_FIXED=Double.parseDouble(Helper.correctDouble(rs.getString("DIGI_DEVIATION_ROI_FIXED")));
							DIGI_DEVIATION_ROI_CSP=Double.parseDouble(Helper.correctDouble(rs.getString("DIGI_DEVIATION_ROI_CSP")));
							DIGI_DEVIATION_ROI_PENALTY=Double.parseDouble(Helper.correctDouble(rs.getString("DIGI_DEVIATION_ROI_PENALTY")));
							DIGI_DEVIATION_MAX_EMI=Helper.correctNull(rs.getString("DIGI_DEVIATION_MAX_EMI"));
							DIGI_DEVIATION_EMI=Helper.correctNull(rs.getString("DIGI_DEVIATION_EMI"));
							DIGI_DEVIATION_MARGIN=Helper.correctNull(rs.getString("DIGI_DEVIATION_MARGIN"));
							LOAN_MCLRTYPE=Helper.correctNull(rs.getString("LOAN_MCLRTYPE"));
							LOAN_MCLRTYPE=LOAN_MCLRTYPE.split("@")[0];
							loan_digi_maxemi_oldvalue=Helper.correctNull(rs.getString("loan_digi_maxemi_oldvalue"));

						}
						
						String mclrtype="",mclrtabcode="",mclrbaserate="";
						strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+LOAN_MCLRTYPE);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
							mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
							mclrbaserate=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))));
						}
						
						double tot_intrate=0.00;
						tot_intrate= Double.parseDouble(mclrbaserate) + DIGI_DEVIATION_ROI_FIXED + DIGI_DEVIATION_ROI_CSP + DIGI_DEVIATION_ROI_PENALTY;
						double fincsp = DIGI_DEVIATION_ROI_CSP + DIGI_DEVIATION_ROI_PENALTY;
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "upd_loandetails_digi_bre");
						arrValues = new ArrayList();
						arrValues.add(String.valueOf(tot_intrate));
						arrValues.add(String.valueOf(tot_intrate));
						arrValues.add(DIGI_DEVIATION_EMI);
						arrValues.add(mclrbaserate);
						arrValues.add(String.valueOf(fincsp));
						arrValues.add(String.valueOf(DIGI_DEVIATION_ROI_FIXED));
						arrValues.add(mclrtabcode);
						arrValues.add(mclrtype);
						arrValues.add(DIGI_DEVIATION_MAX_EMI);
						arrValues.add(correctNull((String) hshValues.get("txt_loanamountnew")));
						arrValues.add(loan_digi_maxemi_oldvalue);
						arrValues.add("");
						arrValues.add("");
						arrValues.add(strAppno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
						
					}
										
			}
			if(strAction.equalsIgnoreCase("undo"))
			{
				//Added by Anitha
				int intTerms=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenorold")));
				double dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_interestrateold")));
				double dblSanctionAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_loanamountold")));
				double dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("repayold")));
				boolean boolisChange=false;
				String strUndoval = Helper.correctNull((String)hshValues.get("hidundoval")); 
				//if (correctNull((String) hshValues.get("hidloanamt")).equalsIgnoreCase("Y")&& strUndoval.contains("loan"))
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					String strCollpercent="";
					PerApplicantBean perapp = new PerApplicantBean();
					strCollpercent = perapp.getCollateralpercent(strAppno, Helper.correctNull((String) hshValues.get("txt_loanamountold")));
					hshQuery.put("strQueryId", "agr_ins_EMI_loandetail");
					arrValues.add(correctNull((String) hshValues.get("txt_loanamountold")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountold")));
					arrValues.add(strCollpercent);
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_loandivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					if(strLADevApprRejDescOldAudit.equalsIgnoreCase("Approve"))
					{
						//Update CBS Details tab
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^1");
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							if(Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
							{
								intupdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(correctNull((String)hshValues.get("txt_loanamountold")));
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","updcbsdetails"); 
								hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
							}
							else
							{
								intupdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strAppno);
								arrValues.add("1");
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","setcbsdetailsdel"); 
								hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
							}
						}
					}
				}
				//if (correctNull((String) hshValues.get("hidintrate")).equalsIgnoreCase("Y")&& strUndoval.contains("int")) 
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_interest_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_interestrateold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add(strAppno);
					arrValues.add("IRRN");
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","del_app_deviation");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_interestdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "update_creditdevspreadval");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("hidcreditrskpremium")));
					arrValues.add(correctNull((String) hshValues.get("hidbusstrategicpremium")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					
				
					if(PRD_CGTMSE.equals("Y"))
					{
						double CGTMSE_intSplitup=0.00;
						if(rs!=null)
						{
							rs.close();
						}
						strQuery=SQLParser.getSqlQuery("select_loandetails^"+strAppno);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							CGTMSE_intSplitup=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_CG_PERCENT")));
						}
						
						double cgtmse_totint= Double.parseDouble(correctNull((String) hshValues.get("txt_interestrateold")))+CGTMSE_intSplitup;
						
						arrValues = new ArrayList();
						intupdatesize++;
						arrValues.add(String.valueOf(cgtmse_totint));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","upd_cg_totIntrate");
						hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					}
					
				}
				//if (correctNull((String) hshValues.get("hidtenor")).equalsIgnoreCase("Y")&& strUndoval.contains("tenor")) 
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_terms_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_tenorold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_tenordivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				//if (correctNull((String) hshValues.get("hidmargin")).equalsIgnoreCase("Y")&& strUndoval.contains("margin")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_margin_EMI_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_marginold")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidEMIAmount")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidMarinEligibleAmt")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_loanamountold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_margindivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				//if (correctNull((String) hshValues.get("sel_retirement")).equalsIgnoreCase("Y")&& strUndoval.contains("age")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "update_app_deviation");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_retirementold")));
					arrValues.add(correctNull((String) hshValues.get("txt_retirementnew")));
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_retirementdivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				//if (correctNull((String) hshValues.get("hidrepaycapacity")).equalsIgnoreCase("Y")&& strUndoval.contains("repay"))
				{
					boolisChange=true;
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_repay_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_repayold")));
					dblrepaycapcity=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_repayold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_repaydivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				//if (correctNull((String) hshValues.get("sel_procfee")).equalsIgnoreCase("Y")&& strUndoval.contains("profee"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "upd_process_loandetails");
					intupdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txt_procfeeold")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_procfeedivtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				//if (correctNull((String) hshValues.get("sel_otherdev")).equalsIgnoreCase("Y") && strUndoval.contains("other")) 
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strUserId);
					arrValues.add(correctNull((String) hshValues.get("select_od_intr")));
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_apprej");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("S");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","app_deviation_undo");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
					
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intupdatesize++;
					arrValues.add("");
					arrValues.add("N");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String) hshValues.get("txt_otherdevtype")));
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_app_deviation_digi");
					hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				intupdatesize++;
				arrValues.add(strAppno);
				arrValues.add("OD");
				hshQuery.put("arrValues",arrValues);				
				hshQuery.put("strQueryId","del_app_deviation");
				hshQueryValues.put(Integer.toString(intupdatesize),hshQuery);
				
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_date");
				intupdatesize++;
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_BREupdate_flag");
				intupdatesize++;
				arrValues.add("Y");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				
				/*String loan_digi_maxemi_oldvalue="";
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_loandetails_digi_extra^"+strAppno);
				if(rs.next())
				{
					loan_digi_maxemi_oldvalue=Helper.correctNull(rs.getString("loan_digi_maxemi_oldvalue"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_loan_digi_maxemi");
				intupdatesize++;
				arrValues.add(loan_digi_maxemi_oldvalue);
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);*/
				
				String digi_deviationoldval="";
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_digi_deviationoldval^"+strAppno);
				if(rs.next())
				{
					digi_deviationoldval=Helper.correctNull(rs.getString("DEVIATION_OLDVALUE"));
				}
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_loan_digi_maxemi");
				intupdatesize++;
				arrValues.add(digi_deviationoldval);
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(Integer.toString(intupdatesize), hshQuery);
				
				
				hshQueryValues.put("size",Integer.toString(intupdatesize));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("approve"))
			{
				String strLADev=Helper.correctNull((String)hshValues.get("sel_loanamount"));
				String strLADevDesc="";
				if(strLADev.equalsIgnoreCase("Y"))
				{
					strLADevDesc="Yes";
				}
				else if(strLADev.equalsIgnoreCase("N"))
				{
					strLADevDesc="No";
				}
				String strLADevApprRej=Helper.correctNull((String)hshValues.get("select_la"));
				String strLADevApprRejDesc="";
				if(strLADevApprRej.equalsIgnoreCase("A"))
				{
					strLADevApprRejDesc="Approve";
				}
				else if(strLADevApprRej.equalsIgnoreCase("R"))
				{
					strLADevApprRejDesc="Reject";
				}
				String strMNDev=Helper.correctNull((String)hshValues.get("sel_margin"));
				String strMNDevDesc="";
				if(strMNDev.equalsIgnoreCase("Y"))
				{
					strMNDevDesc="Yes";
				}
				else if(strMNDev.equalsIgnoreCase("N"))
				{
					strMNDevDesc="No";
				}
				String strMNDevApprRej=Helper.correctNull((String)hshValues.get("select_margin"));
				String strMNDevApprRejDesc="";
				if(strMNDevApprRej.equalsIgnoreCase("A"))
				{
					strMNDevApprRejDesc="Approve";
				}
				else if(strMNDevApprRej.equalsIgnoreCase("R"))
				{
					strMNDevApprRejDesc="Reject";
				}
				sbActionData.append("~Loan Amount Defined Value = ").append(Helper.correctDouble((String)hshValues.get("txt_loanamountold")))
				.append("~Loan Amount Deviation = ").append(strLADevDesc)
				.append("~Loan Amount New Value = ").append(Helper.correctDouble((String)hshValues.get("txt_loanamountnew")))
				.append("~Loan Amount Approval = ").append(strLADevApprRejDesc)
				.append("~Margin (%) Defined Value = ").append(Helper.correctDouble((String)hshValues.get("txt_marginold")))
				.append("~Margin (%) Deviation = ").append(strMNDevDesc)
				.append("~Margin (%) New Value = ").append(Helper.correctDouble((String)hshValues.get("txt_marginnew")))
				.append("~Margin (%) Approval = ").append(strMNDevApprRejDesc);
			}
			AuditTrial.auditNewLog(hshValues, "236", strAppno, sbActionData.toString(), sbOldAudit.toString());
		    /***
		     * End - Audit Trial New Data
		     */
			
			
			
		} catch (Exception ce) {
			throw new EJBException("Error found in LimitofLoan bean <-- "+ ce.toString());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "+ cf.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap getDeviationData(HashMap hshValues)  {
		ResultSet rs = null;
		ResultSet rs1 = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "", strQuery1 = "";
		
 		ArrayList ArrRow = new ArrayList();
		ArrayList ArrCol = new ArrayList();
        String strAppno="";
        String cubsid="";
        String newConcode="";
        String strfacsno="";
        String cubsid1="";
        String permitted="";
        String appraised="";
        String vetted="";
        ArrayList arrRow = new ArrayList();
		ArrayList arrCol= new ArrayList();
		ArrayList arrCode= new ArrayList();
		String strUserid="";
		String appholder="";
		String appholdercheck="";
		String limitprice="";
		String limitmonth="";
		String facility_code="";
		String limitamtfrom="";
        String limitamtto="";
        String limitmonmin="";
        String limitmonmax="";
		try 
		{
			strUserid=Helper.correctNull((String)hshValues.get("strUserId"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
 			strfacsno=Helper.correctNull((String)hshValues.get("sel_facility"));
 			if(!strfacsno.equalsIgnoreCase(""))
 			{
 			hshRecord.put("FACILITY_SN",strfacsno);
 			strQuery = SQLParser.getSqlQuery("commworkflowsel2^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
		
				appholder=correctNull(rs.getString("APP_APPLNHOLDER"));
				hshRecord.put("appholder",appholder);
				
			}
			if(strUserid.equalsIgnoreCase(appholder))
			{
				appholdercheck="Y";
			}
			else
			{
				appholdercheck="N";
			}
			hshRecord.put("appholdercheck",appholdercheck);
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selcusidnewforcheckbenforagricorp^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			String age="";
			if(rs.next())
			{
				cubsid=Helper.correctNull((rs.getString("DEMO_COMAPPNEWID")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selCONSTITUTIONNEW^"+cubsid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				newConcode=Helper.correctNull((rs.getString("PERAPP_CONSTITUTIONNEW")));
				age=Helper.correctNull((rs.getString("age")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getlimitamount^"+strAppno+"^"+strfacsno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				limitprice=Helper.correctNull((rs.getString("FACILITY_SANCAMT")));
				limitmonth=Helper.correctNull((rs.getString("FACILITY_MONTHS")));
				facility_code=Helper.correctNull((rs.getString("FACILITY_MONTHS")));
				
			}
			if(!facility_code.equalsIgnoreCase(""))
			{
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+facility_code);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				limitamtfrom=Helper.correctNull((rs.getString("COM_RANGEFROM")));
		        limitamtto=Helper.correctNull((rs.getString("COM_RANGETO")));
		        limitmonmin=Helper.correctNull((rs.getString("COM_MINREPAYPERIOD")));
		        limitmonmax=Helper.correctNull((rs.getString("COM_MAXREPAYPERIOD")));
		        hshRecord.put("limitamtfrom",limitamtfrom);
		        hshRecord.put("limitamtto",limitamtto);
		        hshRecord.put("limitmonmin",limitmonmin);
		        hshRecord.put("limitmonmax",limitmonmax);
				
			}
		}
			if(rs != null)
			{
				rs.close();
			}
			if(newConcode.equalsIgnoreCase("01"))
			{
				hshRecord.put("agelimitforind",age);
				hshRecord.put("individuals","Y");
				hshRecord.put("FAC_AGE_APPROV","Y");
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("seldeviaforagrcorp^"+cubsid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				newConcode=Helper.correctNull((rs.getString("PERAPP_CONSTITUTIONNEW")));
				age=Helper.correctNull((rs.getString("age")));
			}
			if(rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("seldeviaforagrcorp^"+strAppno+"^"+strfacsno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(!newConcode.equalsIgnoreCase("01"))
				{
				hshRecord.put("agelimitforind",Helper.correctNull((rs.getString("FAC_AGE_DEF"))));//1
				}
				hshRecord.put("FAC_AGE_DEV",Helper.correctNull((rs.getString("FAC_AGE_DEV"))));//2
				hshRecord.put("FAC_AGE_NEW",Helper.correctNull((rs.getString("FAC_AGE_NEW"))));//3
				hshRecord.put("FAC_AGE_REMARKS",Helper.correctNull((rs.getString("FAC_AGE_REMARKS"))));//4
				hshRecord.put("FAC_AGE_APPROV",Helper.correctNull((rs.getString("FAC_AGE_APPROV"))));//5
				
				hshRecord.put("FAC_AGE_APPREMARK",Helper.correctNull((rs.getString("FAC_AGE_APPREMARK"))));//6
				hshRecord.put("FAC_LP_DEF",limitmonth);//7
				hshRecord.put("FAC_LP_DEV",Helper.correctNull((rs.getString("FAC_LP_DEV"))));//8
				hshRecord.put("FAC_LP_NEW",Helper.correctNull((rs.getString("FAC_LP_NEW"))));//9
				hshRecord.put("FAC_LP_REMARKS",Helper.correctNull((rs.getString("FAC_LP_REMARKS"))));//10
				hshRecord.put("FAC_LP_APPROV",Helper.correctNull((rs.getString("FAC_LP_APPROV"))));//11
				hshRecord.put("FAC_LP_APPREMARK",Helper.correctNull((rs.getString("FAC_LP_APPREMARK"))));//12
				hshRecord.put("FAC_LA_DEF",limitprice);//13
				hshRecord.put("FAC_LA_DEV",Helper.correctNull((rs.getString("FAC_LA_DEV"))));//14
				hshRecord.put("FAC_LA_NEW",Helper.correctNull((rs.getString("FAC_LA_NEW"))));//15
				hshRecord.put("FAC_LA_REMARKS",Helper.correctNull((rs.getString("FAC_LA_REMARKS"))));//16
				hshRecord.put("FAC_LA_APPROV",Helper.correctNull((rs.getString("FAC_LA_APPROV"))));//17
				hshRecord.put("FAC_LA_APPREMARK",Helper.correctNull((rs.getString("FAC_LA_APPREMARK"))));//18
				hshRecord.put("FAC_REP_DEF",Helper.correctNull((rs.getString("FAC_REP_DEF"))));//19
				hshRecord.put("FAC_REP_DEV",Helper.correctNull((rs.getString("FAC_REP_DEV"))));//20
				hshRecord.put("FAC_REP_NEW",Helper.correctNull((rs.getString("FAC_REP_NEW"))));//21
				hshRecord.put("FAC_REP_REMARKS",Helper.correctNull((rs.getString("FAC_REP_REMARKS"))));//22
				hshRecord.put("FAC_REP_APPROV",Helper.correctNull((rs.getString("FAC_REP_APPROV"))));//23
				hshRecord.put("FAC_REP_APPREMARK",Helper.correctNull((rs.getString("FAC_REP_APPREMARK"))));//24
				//hshRecord.put("FAC_CIBIL_DEF",Helper.correctNull((rs.getString("FAC_CIBIL_DEF"))));//25
				hshRecord.put("FAC_CIBIL_DEV",Helper.correctNull((rs.getString("FAC_CIBIL_DEV"))));//26
				hshRecord.put("FAC_CIBIL_REMARKS",Helper.correctNull((rs.getString("FAC_CIBIL_REMARKS"))));//27
				hshRecord.put("FAC_CIBIL_APPROV",Helper.correctNull((rs.getString("FAC_CIBIL_APPROV"))));//28
				hshRecord.put("FAC_CIBIL_APPREMARK",Helper.correctNull((rs.getString("FAC_CIBIL_APPREMARK"))));//29
				hshRecord.put("FAC_TOLTOW_PBM",Helper.correctNull((rs.getString("FAC_TOLTOW_PBM"))));//30
				hshRecord.put("FAC_TOLTOW_ACT",Helper.correctNull((rs.getString("FAC_TOLTOW_ACT"))));//31
				hshRecord.put("FAC_TOLTOW_DEV",Helper.correctNull((rs.getString("FAC_TOLTOW_DEV"))));//32
				hshRecord.put("FAC_TOLTOW_REMARKS",Helper.correctNull((rs.getString("FAC_TOLTOW_REMARKS"))));//33
				hshRecord.put("FAC_TOLTOW_APPROV",Helper.correctNull((rs.getString("FAC_TOLTOW_APPROV"))));//34
				hshRecord.put("FAC_TOLTOW_APPREMARK",Helper.correctNull((rs.getString("FAC_TOLTOW_APPREMARK"))));//35
				hshRecord.put("FAC_NWC_PBM",Helper.correctNull((rs.getString("FAC_NWC_PBM"))));//36
				hshRecord.put("FAC_NWC_ACT",Helper.correctNull((rs.getString("FAC_NWC_ACT"))));//37
				hshRecord.put("FAC_NWC_DEV",Helper.correctNull((rs.getString("FAC_NWC_DEV"))));//38
				hshRecord.put("FAC_NWC_REMARKS",Helper.correctNull((rs.getString("FAC_NWC_REMARKS"))));//39
				hshRecord.put("FAC_NWC_APPROV",Helper.correctNull((rs.getString("FAC_NWC_APPROV"))));//40
				hshRecord.put("FAC_NWC_APPREMARK",Helper.correctNull((rs.getString("FAC_NWC_APPREMARK"))));//41
				hshRecord.put("FAC_CURR_RAT_PBM",Helper.correctNull((rs.getString("FAC_CURR_RAT_PBM"))));//42
				hshRecord.put("FAC_CURR_RAT_ACT",Helper.correctNull((rs.getString("FAC_CURR_RAT_ACT"))));//43
				hshRecord.put("FAC_CURR_RAT_DEV",Helper.correctNull((rs.getString("FAC_CURR_RAT_DEV"))));//44
				hshRecord.put("FAC_CURR_RAT_REMARKS",Helper.correctNull((rs.getString("FAC_CURR_RAT_REMARKS"))));//45
				hshRecord.put("FAC_CURR_RAT_APPROV",Helper.correctNull((rs.getString("FAC_CURR_RAT_APPROV"))));//46
				hshRecord.put("FAC_CURR_RAT_APPREMARK",Helper.correctNull((rs.getString("FAC_CURR_RAT_APPREMARK"))));//47
				hshRecord.put("FAC_DEBT_EQ_RAT_PBM",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_PBM"))));//48
				hshRecord.put("FAC_DEBT_EQ_RAT_ACT",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_ACT"))));//49
				hshRecord.put("FAC_DEBT_EQ_RAT_DEV",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_DEV"))));//50
				hshRecord.put("FAC_DEBT_EQ_RAT_REMARKS",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_REMARKS"))));//51
				hshRecord.put("FAC_DEBT_EQ_RAT_APPROV",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_APPROV"))));//52
				hshRecord.put("FAC_DEBT_EQ_RAT_APPREMARK",Helper.correctNull((rs.getString("FAC_DEBT_EQ_RAT_APPREMARK"))));//53
				hshRecord.put("FAC_DV_PBM",Helper.correctNull((rs.getString("FAC_DV_PBM"))));//54
				hshRecord.put("FAC_DV_ACT",Helper.correctNull((rs.getString("FAC_DV_ACT"))));//55
				hshRecord.put("FAC_DV_DEV",Helper.correctNull((rs.getString("FAC_DV_DEV"))));//56
				hshRecord.put("FAC_DV_REMARKS",Helper.correctNull((rs.getString("FAC_DV_REMARKS"))));//57
				hshRecord.put("FAC_DV_APPROV",Helper.correctNull((rs.getString("FAC_DV_APPROV"))));//58
				hshRecord.put("FAC_DV_APPREMARK",Helper.correctNull((rs.getString("FAC_DV_APPREMARK"))));//59
				hshRecord.put("FAC_NETW_PBM",Helper.correctNull((rs.getString("FAC_NETW_PBM"))));//60
				hshRecord.put("FAC_NETW_ACT",Helper.correctNull((rs.getString("FAC_NETW_ACT"))));//61
				hshRecord.put("FAC_NETW_DEV",Helper.correctNull((rs.getString("FAC_NETW_DEV"))));//62
				hshRecord.put("FAC_NETW_REMARKS",Helper.correctNull((rs.getString("FAC_NETW_REMARKS"))));//63
				hshRecord.put("FAC_NETW_APPROV",Helper.correctNull((rs.getString("FAC_NETW_APPROV"))));//64
				hshRecord.put("FAC_NETW_APPREMARK",Helper.correctNull((rs.getString("FAC_NETW_APPREMARK"))));//65
				hshRecord.put("FAC_SELANDOTH_PBM",Helper.correctNull((rs.getString("FAC_SELANDOTH_PBM"))));//66
				hshRecord.put("FAC_SELANDOTH_ACT",Helper.correctNull((rs.getString("FAC_SELANDOTH_ACT"))));//67
				hshRecord.put("FAC_SELANDOTH_DEV",Helper.correctNull((rs.getString("FAC_SELANDOTH_DEV"))));//68
				hshRecord.put("FAC_SELANDOTH_REMARKS",Helper.correctNull((rs.getString("FAC_SELANDOTH_REMARKS"))));//69
				hshRecord.put("FAC_SELANDOTH_APPROV",Helper.correctNull((rs.getString("FAC_SELANDOTH_APPROV"))));//70
				hshRecord.put("FAC_SELANDOTH_APPREMARK",Helper.correctNull((rs.getString("FAC_SELANDOTH_APPREMARK"))));//71
				hshRecord.put("FAC_ACC_STMNT_CHQRTN_REMARKS",Helper.correctNull((rs.getString("FAC_ACC_STMNT_CHQRTN_REMARKS"))));//72
				hshRecord.put("FAC_ACC_STMNT_CHQRTN_APPROV",Helper.correctNull((rs.getString("FAC_ACC_STMNT_CHQRTN_APPROV"))));//73
				hshRecord.put("FAC_ACC_STMNT_CHQRTN_APPREMARK",Helper.correctNull((rs.getString("FAC_ACC_STMNT_CHQRTN_APPREMARK"))));//74
				hshRecord.put("FAC_FRAUD_CHK_REMARKS",Helper.correctNull((rs.getString("FAC_FRAUD_CHK_REMARKS"))));//75
				hshRecord.put("FAC_FRAUD_CHK_APPROV",Helper.correctNull((rs.getString("FAC_FRAUD_CHK_APPROV"))));//76
				hshRecord.put("FAC_FRAUD_CHK_APPREMARK",Helper.correctNull((rs.getString("FAC_FRAUD_CHK_APPREMARK"))));//77
				hshRecord.put("FAC_IN_TAX_RTN_REMARKS",Helper.correctNull((rs.getString("FAC_IN_TAX_RTN_REMARKS"))));//78
				hshRecord.put("FAC_IN_TAX_RTN_APPROV",Helper.correctNull((rs.getString("FAC_IN_TAX_RTN_APPROV"))));//79
				hshRecord.put("FAC_IN_TAX_RTN_APPREMARK",Helper.correctNull((rs.getString("FAC_IN_TAX_RTN_APPREMARK"))));//80
				hshRecord.put("FAC_ANY_OTH_DEV_REMARKS",Helper.correctNull((rs.getString("FAC_ANY_OTH_DEV_REMARKS"))));//81
				hshRecord.put("FAC_ANY_OTH_DEV_APPROV",Helper.correctNull((rs.getString("FAC_ANY_OTH_DEV_APPROV"))));//82
				hshRecord.put("FAC_ANY_OTH_DEV_APPREMARK",Helper.correctNull((rs.getString("FAC_ANY_OTH_DEV_APPREMARK"))));//83
				//hshRecord.put("FAC_PERMIT_DEVP",Helper.correctNull((rs.getString("FAC_PERMIT_DEVP"))));//84
				//hshRecord.put("FAC_PERMIT_AUT",Helper.correctNull((rs.getString("FAC_PERMIT_AUT"))));//85
				hshRecord.put("FAC_PERMIT_AUT_REM",Helper.correctNull((rs.getString("FAC_PERMIT_AUT_REM"))));//86
				hshRecord.put("FAC_ADD_INT_IF",Helper.correctNull((rs.getString("FAC_ADD_INT_IF"))));//87
				hshRecord.put("FAC_HAND_CHA_IF",Helper.correctNull((rs.getString("FAC_HAND_CHA_IF"))));//88
				hshRecord.put("FAC_ADD_INT_VAL",Helper.correctNull((rs.getString("FAC_ADD_INT_VAL"))));//89
				hshRecord.put("FAC_HAND_CHA_VAL",Helper.correctNull((rs.getString("FAC_HAND_CHA_VAL"))));//90
		        appraised=Helper.correctNull((rs.getString("FAC_APPRAISED_BY")));//91
				vetted=Helper.correctNull((rs.getString("FAC_VETTED_BY")));//92
				permitted=Helper.correctNull((rs.getString("FAC_PERMIT_BY")));//93
				hshRecord.put("appraised",appraised);
				hshRecord.put("vetted",vetted);
				hshRecord.put("permitted",permitted);
				hshRecord.put("nodata","N");
				
			}
			else
			{
				hshRecord.put("nodata","Y");	
			}
			if(!appraised.equalsIgnoreCase(""))
			{
				arrCol = new ArrayList();
				arrCol.add(appraised);//1
				if (rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("getuserdetailsfordeviation^"+appraised);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrCol.add(Helper.correctNull((rs.getString("nameofuseer"))));//2
				
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//3
				}
				else{
					arrCol.add("");//3
				}
				arrCol.add("A");//4
				arrRow.add(arrCol);	
				
			}
			if(!vetted.equalsIgnoreCase(""))
			{
				String splitat="";
				String[] valArray=null;
				arrCol = new ArrayList();
				splitat=vetted;
				valArray=splitat.split("\\@");
				for(int k=0;k<valArray.length;k++)
				{
					
				   String getstringat=valArray[k];
				   arrCol = new ArrayList();
					arrCol.add(getstringat);//1
					if(!getstringat.equalsIgnoreCase(""))
					{
					if (rs != null)
					{
						rs.close();
					}
					strQuery=SQLParser.getSqlQuery("getuserdetailsfordeviation^"+getstringat);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						arrCol.add(Helper.correctNull((rs.getString("nameofuseer"))));//2
					
					}
					if (rs1 != null)
					{
						rs1.close();
					}
					strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//3
					}
					else{
						arrCol.add("");//3
					}
					arrCol.add("V");//4
					arrRow.add(arrCol);	
					}
				   
				}
			}
			if(!permitted.equalsIgnoreCase(""))
			{
				arrCol = new ArrayList();
				arrCol.add(permitted);//1
				if (rs != null)
				{
					rs.close();
				}
				strQuery=SQLParser.getSqlQuery("getuserdetailsfordeviation^"+permitted);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrCol.add(Helper.correctNull((rs.getString("nameofuseer"))));//2
				
				}
				if (rs1 != null)
				{
					rs1.close();
				}
				strQuery = SQLParser.getSqlQuery("selcbsiddatadesc^"+"27^"+Helper.correctNull((String)rs.getString("user_designation")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));//3
				}
				else{
					arrCol.add("");//3
				}
				arrCol.add("S");//4
				arrRow.add(arrCol);	
				
			}
			hshRecord.put("arrRoww",arrRow);
			if (rs != null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("getapplicantcbilrate^"+cubsid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(newConcode.equalsIgnoreCase("01"))
				{
					hshRecord.put("cibilorcrifofapplicant",Helper.correctNull((rs.getString("CIBIL_SCORE"))));
				}
				else
				{
					hshRecord.put("cibilorcrifofapplicant",Helper.correctNull((rs.getString("CRIF_SCORE"))));
				}
			
			}
			if (rs != null)
				rs.close();
			if (rs1 != null)
			{
				rs1.close();
			}
			strQuery=SQLParser.getSqlQuery("getcoappgurantid^"+strAppno);				
			rs = DBUtils.executeQuery(strQuery);				
			while (rs.next())
			{
				cubsid1=Helper.correctNull((rs.getString("COM_COMPDTID")));
				strQuery1=SQLParser.getSqlQuery("getapplicantcbilrate^"+cubsid1);				
				rs1 = DBUtils.executeQuery(strQuery1);				
				if (rs1.next())
				{
					ArrCol = new ArrayList();
					ArrCol.add(Helper.correctNull(rs.getString("COM_COMPDTTYPE")));
					if(newConcode.equalsIgnoreCase("01"))
					{
						ArrCol.add(Helper.correctNull(rs1.getString("CIBIL_SCORE")));
					}
					else
					{
						ArrCol.add(Helper.correctNull(rs1.getString("CRIF_SCORE")));
					}
					ArrRow.add(ArrCol);
					
				}
			}
			hshRecord.put("ArrRow", ArrRow);
			    int deviationrights=0;
		        int deviationuser=0;
		        strQuery=SQLParser.getSqlQuery("checkDeviationApprove");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					deviationrights=Integer.parseInt(Helper.correctNull((String)rs.getString("STAT_DATA_DESC")));
				}
				if(rs != null)
				{
					rs.close();
				}
				
				strQuery=SQLParser.getSqlQuery("checkUserclassforLodgeRights^"+strUserid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					deviationuser=Integer.parseInt(Helper.correctNull((String)rs.getString("USR_CLASS")));
				}
				if(deviationrights<=deviationuser)
				{
					hshRecord.put("deviationapproverights","Y");
				}
				else
				{
					hshRecord.put("deviationapproverights","N");
				}
				
			
			
		} 
		}
			
		
		
		
		
		
		catch (Exception ce) {
			throw new EJBException("Error in :: "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection::getDocFee: " +cf.toString());			

			}
		}
		return hshRecord;
	}
	public void updateDeviationDataforcorpandagri(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		ResultSet rs = null;
		
		String strAction = Helper.correctNull((String) hshValues.get("hidAction"));
		String strApplicationNo = "";
		String strAppid="";
		StringBuilder sbolddata=new StringBuilder();
		
		
		String strchobank_accnttype_text = null;	
		String strsno="";
		int intUpdatesize = 0;
		String appno=Helper.correctNull((String)hshValues.get("appno"));
		String facilityno=Helper.correctNull((String)hshValues.get("hidfacility"));
		try
		{
			if (strAction.equals("insert"))
			{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "del_deviation_foragricorp");
			arrValues.add(appno);
			arrValues.add(facilityno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			
			
			arrValues=new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "2");
			hshQuery.put("strQueryId", "insert_into_fac_deviation");
			arrValues.add(Helper.correctNull((String)hshValues.get("appno")));//1
			arrValues.add(facilityno);//2
			arrValues.add(Helper.correctNull((String)hshValues.get("agelimit")));//3
			arrValues.add(Helper.correctNull((String)hshValues.get("agedeviation")));//4
			arrValues.add(Helper.correctNull((String)hshValues.get("agenewval")));//5
			arrValues.add(Helper.correctNull((String)hshValues.get("ageremarks")));//6
			arrValues.add(Helper.correctNull((String)hshValues.get("ageapprov")));//7
			arrValues.add(Helper.correctNull((String)hshValues.get("ageapprovremark")));//8
			arrValues.add(Helper.correctNull((String)hshValues.get("lpdif")));//9
			arrValues.add(Helper.correctNull((String)hshValues.get("lpdev")));//10
			arrValues.add(Helper.correctNull((String)hshValues.get("lpnew")));//11
			arrValues.add(Helper.correctNull((String)hshValues.get("lpremarks")));//12
			arrValues.add(Helper.correctNull((String)hshValues.get("lpapprove")));//13
			arrValues.add(Helper.correctNull((String)hshValues.get("lpapproveremarks")));//14
			arrValues.add(Helper.correctNull((String)hshValues.get("ladef")));//15
			arrValues.add(Helper.correctNull((String)hshValues.get("ladev")));//16
			arrValues.add(Helper.correctNull((String)hshValues.get("lanew")));//17
			arrValues.add(Helper.correctNull((String)hshValues.get("laremark")));//18
			arrValues.add(Helper.correctNull((String)hshValues.get("laapprove")));//19
			arrValues.add(Helper.correctNull((String)hshValues.get("laapproveremark")));//20
			arrValues.add(Helper.correctNull((String)hshValues.get("repaydef")));//21
			arrValues.add(Helper.correctNull((String)hshValues.get("repaydev")));//22
			arrValues.add(Helper.correctNull((String)hshValues.get("repaynew")));//23
			arrValues.add(Helper.correctNull((String)hshValues.get("repayremarks")));//24
			arrValues.add(Helper.correctNull((String)hshValues.get("repayapprove")));//25
			arrValues.add(Helper.correctNull((String)hshValues.get("repayapproveremark")));//26
			//arrValues.add(Helper.correctNull((String)hshValues.get("cibildef")));//27
			arrValues.add(Helper.correctNull((String)hshValues.get("cibildev")));//28
			arrValues.add(Helper.correctNull((String)hshValues.get("cibilremark")));//29
			arrValues.add(Helper.correctNull((String)hshValues.get("cibilapprove")));//30
			arrValues.add(Helper.correctNull((String)hshValues.get("cibilapproveremark")));//31
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowpbm")));//32
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowact")));//33
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowdev")));//34
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowremarks")));//35
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowapprove")));//36
			arrValues.add(Helper.correctNull((String)hshValues.get("toltowapproveremark")));//37
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcpbm")));//38
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcact")));//39
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcdev")));//40
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcremarks")));//41
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcapprove")));//42
			arrValues.add(Helper.correctNull((String)hshValues.get("nwcapproveremark")));//43
			arrValues.add(Helper.correctNull((String)hshValues.get("crpbm")));//44
			arrValues.add(Helper.correctNull((String)hshValues.get("crpact")));//45
			arrValues.add(Helper.correctNull((String)hshValues.get("crdev")));//46
			arrValues.add(Helper.correctNull((String)hshValues.get("crremarks")));//47
			arrValues.add(Helper.correctNull((String)hshValues.get("crrapprove")));//48
			arrValues.add(Helper.correctNull((String)hshValues.get("currapproveremark")));//49
			arrValues.add(Helper.correctNull((String)hshValues.get("derpbm")));//50
			arrValues.add(Helper.correctNull((String)hshValues.get("deract")));//51
			arrValues.add(Helper.correctNull((String)hshValues.get("derdev")));//52
			arrValues.add(Helper.correctNull((String)hshValues.get("derremarks")));//53
			arrValues.add(Helper.correctNull((String)hshValues.get("derapprove")));//54
			arrValues.add(Helper.correctNull((String)hshValues.get("derapproveremarks")));//55
			arrValues.add(Helper.correctNull((String)hshValues.get("dvpbm")));//56
			arrValues.add(Helper.correctNull((String)hshValues.get("dvact")));//57
			arrValues.add(Helper.correctNull((String)hshValues.get("dvdev")));//58
			arrValues.add(Helper.correctNull((String)hshValues.get("dvremarks")));//59
			arrValues.add(Helper.correctNull((String)hshValues.get("dvapprove")));//60
			arrValues.add(Helper.correctNull((String)hshValues.get("dvapproveremark")));//61
			arrValues.add(Helper.correctNull((String)hshValues.get("netwpbm")));//62
			arrValues.add(Helper.correctNull((String)hshValues.get("netwact")));//63
			arrValues.add(Helper.correctNull((String)hshValues.get("netwdev")));//64
			arrValues.add(Helper.correctNull((String)hshValues.get("netwremarks")));//65
			arrValues.add(Helper.correctNull((String)hshValues.get("netwapprove")));//66
			arrValues.add(Helper.correctNull((String)hshValues.get("netwapproveremark")));//67
			arrValues.add(Helper.correctNull((String)hshValues.get("saopbm")));//68
			arrValues.add(Helper.correctNull((String)hshValues.get("saoact")));//69
			arrValues.add(Helper.correctNull((String)hshValues.get("saodev")));//70
			arrValues.add(Helper.correctNull((String)hshValues.get("saoremarks")));//71
			arrValues.add(Helper.correctNull((String)hshValues.get("saoapprove")));//72
			arrValues.add(Helper.correctNull((String)hshValues.get("saoapproveremarks")));//73
			arrValues.add(Helper.correctNull((String)hshValues.get("accstachkremarks")));//74
			arrValues.add(Helper.correctNull((String)hshValues.get("accstachkapprove")));//75
			arrValues.add(Helper.correctNull((String)hshValues.get("accstachkapproveremarks")));//76
			arrValues.add(Helper.correctNull((String)hshValues.get("fraudchkremarks")));//77
			arrValues.add(Helper.correctNull((String)hshValues.get("fraudchkapprove")));//78
			arrValues.add(Helper.correctNull((String)hshValues.get("fraudchkapproveremark")));//79
			arrValues.add(Helper.correctNull((String)hshValues.get("taxremarks")));//80
			arrValues.add(Helper.correctNull((String)hshValues.get("taxapprove")));//81
			arrValues.add(Helper.correctNull((String)hshValues.get("taxapproveremarks")));//82
			arrValues.add(Helper.correctNull((String)hshValues.get("anyotherremarks")));//83
			arrValues.add(Helper.correctNull((String)hshValues.get("anyotherapprove")));//84
			arrValues.add(Helper.correctNull((String)hshValues.get("anyotherapproveremarks")));//85
			//arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancDept")));//86
			//arrValues.add(Helper.correctNull((String)hshValues.get("sel_SancAuth")));//87
			arrValues.add(Helper.correctNull((String)hshValues.get("perauttremar")));//88
			arrValues.add(Helper.correctNull((String)hshValues.get("additint")));//89
			arrValues.add(Helper.correctNull((String)hshValues.get("handcharge")));//90
			arrValues.add(Helper.correctNull((String)hshValues.get("additintval")));//91
			arrValues.add(Helper.correctNull((String)hshValues.get("handchargesval")));//92
			arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));//93
			arrValues.add(Helper.correctNull((String)hshValues.get("vettedby")));//94
			arrValues.add("");//95
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("2", hshQuery);			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			
			
			
			}
			if (strAction.equals("delete"))
			{
				/*if(Helper.correctNull((String)hshValues.get("sel_details")).equalsIgnoreCase("B"))
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "updateFAC_APPRAISED_BY");
					arrValues.add("");
					arrValues.add(appno);
					arrValues.add(facilityno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}*/
				if(Helper.correctNull((String)hshValues.get("sel_details")).equalsIgnoreCase("V"))
				    {
					
						String splitat="";
						String[] valArray=null;
					    String finallist="";
						splitat=Helper.correctNull((String)hshValues.get("vettedby"));
						valArray=splitat.split("\\@");
						for(int k=0;k<valArray.length;k++)
						{
							
						   String getstringat=valArray[k];
						   if(!getstringat.equalsIgnoreCase(Helper.correctNull((String)hshValues.get("txtuserID"))))
						   {
							   finallist=finallist + getstringat + "@";
						   }
						  
						   
						}
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("strQueryId", "updateFAC_VETTED_BY");
						arrValues.add(finallist);
						arrValues.add(appno);
						arrValues.add(facilityno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						
					}
				}
			if (strAction.equals("deleteall"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId", "del_deviation_foragricorp");
				arrValues.add(appno);
				arrValues.add(facilityno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			}
				
				
				
			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getData" + ce.getMessage());
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
			catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
		}
	}
	
	// ********************added by reddemma for solvency processing charges ************************//
	public HashMap getSolvencyDocFee(HashMap hshRequestValues)  {
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "", strQuery1 = "";
		String strRecAmt = "0";
		String strPrdCode = "";
		String strLesser = "<=";
		String strGreater = ">=";
		String chkStrPrdcode = "";
		String strQueryval = "";
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		double dblMinProc = 0.00, dblMaxProc = 0.00, dblPerProc = 0.00;
		double dblMinDoc = 0.00, dblMaxDoc = 0.00, dblPerDoc = 0.00;
		double dblMinApp = 0.00, dblMaxApp = 0.00, dblPerApp = 0.00;
		double dblRecAmt = 0.00, dblDocvalue = 0.00, dblProcvalue = 0.00, dblAppvalue=0.0;

		try 
		{
			
			hshRecord = new HashMap();
			chkStrPrdcode = correctNull((String) hshRequestValues
					.get("prdcode"));
			if (chkStrPrdcode.equalsIgnoreCase("")) {
				strPrdCode = correctNull((String) hshRequestValues
						.get("prdcode1"));
			} else {
				strPrdCode = correctNull((String) hshRequestValues
						.get("prdcode"));
			}
			if(correctNull((String) hshRequestValues
					.get("strPage")).equalsIgnoreCase("bankcert"))
				
				
			{
				if(correctNull((String) hshRequestValues
						.get("sel_sanctionfor")).equalsIgnoreCase("BC"))
				{
				strPrdCode	="6";
			    }
				if(correctNull((String) hshRequestValues
						.get("sel_sanctionfor")).equalsIgnoreCase("LC"))
				{
				strPrdCode	="7";
			    }
			}
			strRecAmt = correctNull((String) hshRequestValues.get("recamt"));
			if (strRecAmt.trim().equals("")) {
				strRecAmt = "0.00";
			}
			dblRecAmt = Double.parseDouble(strRecAmt);
			
				strQuery = SQLParser.getSqlQuery("selprdsolvencyprocessfee^" + strPrdCode
						+ "^" + strLesser + "^" + strRecAmt + "^" + strGreater
						+ "^" + strRecAmt+ "^" +strQueryval);
				
		
			
			if (rs != null) {rs.close();}
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				dblPerProc = rs.getDouble(1);//0.00
				dblMinProc = rs.getDouble(2);//0.00
				dblMaxProc = rs.getDouble(3);//0.00
			}
			if (dblPerProc != 0.00) {
				dblProcvalue = (dblPerProc / 100) * dblRecAmt;
			}
			if (dblMinProc == 0.00 && dblMaxProc == 0.00) {
				dblProcvalue = dblProcvalue;
			}
			if (dblPerProc == 0.00 && dblMaxProc == 0.00) {
				dblProcvalue = dblMinProc;
			}
			if (dblMinProc != 0.00 || dblMaxProc != 0.00) {
				if (dblProcvalue < dblMinProc) {
					dblProcvalue = dblMinProc;
				} else if (dblProcvalue > dblMaxProc) {
					if (dblMaxProc != 0.00) {
						dblProcvalue = dblMaxProc;
					} else {
						dblProcvalue = dblProcvalue;
					}
				}
			}
			
			hshRecord.put("procfee", Helper.checkDecimal(Double
					.toString(dblProcvalue)));
			 System.out.println("***********processing fee****************"+ Helper.checkDecimal(Double
						.toString(dblProcvalue)));
			
		} catch (Exception ce) {
			throw new EJBException("Error in getsolvencyDocFee:: "
					+ ce.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection::getDocFee: " +cf.toString());			

			}
		}
		return hshRecord;
	}
	

}