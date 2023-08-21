package com.sai.laps.ejb.perapplicant;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.kalyptorisk.www.credit.rating.RatingSoapProxy;
import com.sai.laps.ejb.agrotherassets.agrotherBean;
import com.sai.laps.ejb.facilities.FacilitiesBean;
import com.sai.laps.ejb.financial.FinancialBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.mastapplicant.MastApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.LAlerts;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;

@Stateless(name = "PerApplicantBean", mappedName = "PerApplicantHome")
@Remote (PerApplicantRemote.class)

public class PerApplicantBean extends BeanAdapter
{
	static Logger log=Logger.getLogger(PerApplicantBean.class);	
	//static Logger log=Logger.getLogger(PerApplicantBean.class);
	/*
	 * Calculations for LoanDetails
	 * 
	 * 1. Cost of Loan Product == Amount Requested
	 * 
	 * a. NetTrade = 0 DownPayment = AmountRequested - (AmountRequseted *
	 * Recommended Loan to value Ratio/ 100) Actual Loan to value Ratio =
	 * Recommended Loan to value Ratio
	 * 
	 * b. NetTrade != 0 DownPayment = (AmountRequested - (AmountRequseted *
	 * Recommended Loan to value Ratio/ 100))+ NetTradein Actual Loan to value
	 * Ratio = ( (AmountRequested - DownPayment)/Amount Requested)*100
	 * 
	 * Amount Recommended = Actual Loan to value Ratio * AmountRequested /100
	 * 
	 * 2. Cost of Loan Product != Amount Requested
	 * 
	 * a. Cost of Loan Product < Amount Requested Amount Recommended = Cost of
	 * the LoanProduct * Recommended Loan to value Ratio /100 Down Payment = (
	 * Cost of the LoanProduct - Amount Recommended) + Net Trade
	 * 
	 * b. Cost of Loan Product > Amount Requested
	 * 
	 * Amount Recommended = Amount Requested Down Payment = ( Cost of the
	 * LoanProduct - Amount Recommended) + Net Trade
	 * 
	 * NetTradein > 0 Amount Recommended = Amount Recommended - NetTradein
	 * 
	 * 
	 * Actual Loan to value Ratio = (Cost of the Loan Product -
	 * downpayment)/Cost of lOan Product * 100
	 * 
	 */

	private static final long serialVersionUID = 1L;
	private static final String strCIBILRenew = ApplicationParams.getStrCIBILRENEW();
	/**
	 * Function getLoanProducts This Method is used to get values for
	 * loanproducts for personal application
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.lang.Exception
	 */

	public HashMap getLoanProducts(HashMap hshValues) 
	{
		ResultSet rs = null,rsPS=null,rs1=null,rs3=null;
		HashMap hshResult = new HashMap();
		boolean recordflag=false;  
		String  strPrdCode = "";
		String strApplicationNo ="";
		double dblmodintrate = 0.0;
		double dbltotalpay = 0.0;
		String strPrdType="";
		String strProAvailFor="",strReasonCode="",strcode="",stractiveflag="";
		//Renew
		
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		String strQuery="";
		String strQuery1="";
		String strQuery4="";
		String strQuery5="";
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		HashMap hshRecord = new HashMap();		
		ArrayList vecData = new ArrayList();
		String strAppno="";
		HashMap hshformula =  new HashMap();//mck
		String strAction="";
		String strBorrowDesc="",strBorrowId="";
		String strOrglevel="";
        String strissaral="";
        String strAppValuesin="";
        String strCreateDate="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQueryValues1=new HashMap();
		HashMap hshQuery1=new HashMap();
		HashMap hshQueryValues2=new HashMap();
		HashMap hshQuery2=new HashMap();
		String strUserId="",strOrgCode="",strOrgLevel="",usrOrgCode="",strcustid="",strAppStatus="",strOrgSCode="";
		String strInwardno="",strExistInwardNo ="",strExistDevstatus="",strExistDevusrid="",strParentdigi="",strInwardnum="";		
		String strCBSACNo="";
		String strApptype = Helper.correctNull((String)hshValues.get("apploantype"));
		String strPrdFlag = Helper.correctNull((String)hshValues.get("strPrdFlag"));
		String strGLdate = Helper.correctNull((String)hshValues.get("varGLdate"));
		String strAppReceicedDate="",strExcelFlag="",strAPPCGStatus="",strOldid="0";
		String strAppType=Helper.correctNull((String)hshValues.get("strAppType"));
		String loantype="";
		String typeofagsec="";
		String strPage = correctNull((String) hshValues.get("page1"));// from
																		// which
																		// page
																		// new/renewal
																		// or
																		// existing
		// String strRdoAppPan=correctNull((String)hshValues.get("radSearch"));
		
		String strAppid = "";
		
		if (strAppid.equalsIgnoreCase("") || strAppid.equalsIgnoreCase("null"))
		{
			strAppid = Helper.correctNull((String) hshValues.get("appid"));
		}
 		if (strAppid.equalsIgnoreCase("") || strAppid.equalsIgnoreCase("null"))
		{
			strAppid = correctNull((String) hshValues.get("hidapplicantid"));
		}
 		strAction=Helper.correctNull((String)hshValues.get("hidAction"));
 		strPrdCode = Helper.correctNull((String)hshValues.get("prdcode"));
 		strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
		boolean bState = false;
		String strslabintrate = "";
		String strslabtoamt = "";
		String strinternet_app ="",strMclrDesc="";		
		strInwardnum = Helper.correctNull((String)hshValues.get("inwardno"));
		if(!strInwardnum.equalsIgnoreCase(""))
		{
			strInwardnum = Helper.correctNull((String)hshValues.get("hidApplicationNum"));
		}
		try
		{
			if(rs !=null){
				rs.close();
			}
			//Gold & Deposit Loan Application Renewal Created by Venkata Prasad Chowdary.
			
			
			
			
			
			
			
			
			if(strAction.equalsIgnoreCase("renew")||strAction.equalsIgnoreCase("restructure")|| strAction.equalsIgnoreCase("postsanction")){
				String hidCategoryType=correctNull((String)hshValues.get("hidCategoryType"));
			strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));		
			if(strcustid.equalsIgnoreCase("")){
				strcustid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			}
			strAppid=strcustid;
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));				
			strAppno = correctNull((String)hshValues.get("appno"));
			String strExecappno=correctNull((String)hshValues.get("txtSearch"));
			strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            strissaral=correctNull((String)hshValues.get("strIsSaral"));
            String strAppNumber = correctNull((String)hshValues.get("txtSearch"));
            String strCountcheck="",strCountcheck1="";
            String strSolid=correctNull((String)hshValues.get("strSolid"));
            strInwardno=correctNull((String)hshValues.get("txt_appinwardno"));
			//Application Number check
            String strExCBSAccno=correctNull((String)hshValues.get("hidCBSAccno"));
            
    		if(rs !=null){
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_orglevel_usinguserid^"
					+ strUserId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
			
				strOrgLevel=Helper.correctNull((String)rs.getString("org_level"));
				
			}
			if(strOrgLevel.equalsIgnoreCase("A")){
				
				usrOrgCode=strOrgCode.substring(0,12)+"%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("D")){
				
				usrOrgCode=strOrgCode.substring(0,9)+"%%%%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("R")){
				
				usrOrgCode=strOrgCode.substring(0,6)+"%%%%%%%%%";
				
			}else{
				
				usrOrgCode=strOrgCode.substring(0,3)+"%%%%%%%%%%%%";
				
			}
			
			strOrgSCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
			
			if (rs != null) {
				rs.close();
			}
			if(hidCategoryType.equalsIgnoreCase("RET"))
			{
				if(strAction.equalsIgnoreCase("restructure")){
					strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid3^"+ strcustid+"^ and prd_type not in ('pR','pG') and app_renew_status is null^"+strOrgSCode+"^"+strOrgSCode);
				}else if(strAction.equalsIgnoreCase("postsanction")){
						strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid2^"+ strcustid+"^ and prd_type not in ('pR','pG') and app_renew_status is null^"+usrOrgCode+"^"+usrOrgCode);
				}else{
				strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid1^"+ strcustid+"^ and prd_type not in ('pR','pG') and prd_loantype='OD' and app_renew_status is null^"+usrOrgCode+"^"+usrOrgCode);
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid4^"+ strcustid+"^ and prd_type in ('pR','pG') and prd_loantype='OD' and app_renew_status is null^"+strOrgSCode+"^"+strOrgSCode);
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				String strcheckappno=correctNull((String)rs.getString("app_no"));
				
				if(strAppNumber .equalsIgnoreCase(strcheckappno))
				{
					strCountcheck="Yes";
					break;
				}
				
			}if(!strAppNumber.equalsIgnoreCase(""))
			{
				if(strCountcheck.equalsIgnoreCase(""))
				{
					strCountcheck1="Yes";
					hshRecord.put("strCountcheck",strCountcheck1);
				}
			}
        	
			
			
			if(!(strAppNumber.equalsIgnoreCase("")))
			{				
				if(!strCountcheck1.equalsIgnoreCase("Yes"))
				{
					if(strAppno.equalsIgnoreCase("new") && !strExecappno.equalsIgnoreCase(""))
					{
						String strType="P";
						hshformula.put("comapp_id",strcustid);
						hshformula.put("apptype",strType);
						hshformula.put("strSolid", strSolid);
						strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
						hshValues.put("appno",strAppno);			
					}
					if(!strExecappno.equalsIgnoreCase("") && !strAppno.equalsIgnoreCase(""))
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();	
						String demo_appid="";
						String demo_type="";
						String demo_relation="";
						String demo_includeincome="";
						String demo_oldid="";
						String demo_original_id="";
						
						
						int intUpdatesize=0;
						int intUpdatesize1=0;
						int intUpdatesize2=0;
						
						strQuery1 = SQLParser.getSqlQuery("sel_applications_renew^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						if(rs.next())
						{
							strPrdCode=Helper.correctNull((String)rs.getString("app_prdcode"));
							strAppValuesin=correctNull(rs.getString("app_valuesin"));
							strExistInwardNo=correctNull(rs.getString("app_inwardno"));
							strCBSACNo=correctNull(rs.getString("cbs_accountno"));
							strExistDevstatus=correctNull(rs.getString("app_isdeviated"));
							strExistDevusrid=correctNull(rs.getString("APP_DEVIATEDUSERID"));
							strParentdigi=correctNull(rs.getString("APP_LOANSUBTYPE_DIGI"));
						}
						if((hidCategoryType.equalsIgnoreCase("RET")&& strAction.equalsIgnoreCase("postsanction")))
						{
							strInwardno=getMaxInwardno(strSolid);
							strAppReceicedDate=Helper.getCurrentDateTime();
						}
//						if(hidCategoryType.equalsIgnoreCase("LAD"))
//							strAppReceicedDate=Helper.getCurrentDateTime();
							
						
						if(rs!=null)
							rs.close();
						strQuery1 = SQLParser.getSqlQuery("selinwardcreatedate^" + strInwardno);
						rs = DBUtils.executeQuery(strQuery1);
						
						if(rs.next())
						{
							strAppReceicedDate=Helper.correctNull(rs.getString("inward_appliedon"));
						}
						
					
						//Applications
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(strPrdCode);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
						arrValues.add("P");
						arrValues.add(strInwardno);
						arrValues.add(strAppValuesin);
						arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("Y");
						if(strOrglevel.equalsIgnoreCase("D")&&strAction.equalsIgnoreCase("postsanction"))
							arrValues.add(Helper.getCurrentDateTime());
						else
							arrValues.add(correctNull((String)hshValues.get("txt_receiptclpu")));
						arrValues.add(null);
						if(strAction.equalsIgnoreCase("restructure"))
							arrValues.add("S");
						else if(strAction.equalsIgnoreCase("postsanction"))
							arrValues.add("P");
						else
							arrValues.add("R");
						arrValues.add(strExecappno);
						arrValues.add("");
						arrValues.add(strExistDevstatus);
						arrValues.add(strExistDevusrid);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","insapplications_renew");
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						//Demographics
						if(hidCategoryType.equalsIgnoreCase("RET")&& (strAction.equalsIgnoreCase("postsanction")||strAction.equalsIgnoreCase("renew")))
						{
							strQuery1 = SQLParser.getSqlQuery("selcoappguardetails^" + strExecappno);
						}
						else
						{
							strQuery1 = SQLParser.getSqlQuery("get_perdemographics_renew^" + strExecappno);
						}
						rs = DBUtils.executeQuery(strQuery1);
						
						while(rs.next())
						{
							demo_original_id="";
							demo_type=correctNull((String)rs.getString("demo_type"));
							demo_relation=correctNull((String)rs.getString("demo_relation"));
							demo_includeincome=correctNull((String)rs.getString("demo_includeincome"));
							strQuery4 = SQLParser.getSqlQuery("get_perdemographics_oldid_renew^" + correctNull((String)rs.getString("demo_appid")));
							rs4 = DBUtils.executeQuery(strQuery4);
							if(rs4.next()){								
								strQuery5 = SQLParser.getSqlQuery("get_perdemographics_newid_renew^" + correctNull((String)rs4.getString("perapp_oldid")));
								rs5 = DBUtils.executeQuery(strQuery5);
								if(rs5.next()){									
									demo_original_id=correctNull((String)rs5.getString("perapp_id"));
										}
							
							}
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","ins_perdemographics_renew");
							arrValues.add(strAppno);
							arrValues.add(demo_original_id);							
							arrValues.add(demo_type);
							arrValues.add(demo_relation);
							arrValues.add(demo_includeincome);
							arrValues.add(correctNull(rs.getString("demo_oldappid")));
							arrValues.add(correctNull(rs.getString("demo_cbsrelationtype")));
							arrValues.add(demo_type);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}	
						if((hidCategoryType.equalsIgnoreCase("RET")&& strAction.equalsIgnoreCase("postsanction"))){
							// Inward no generation
							if(rs!=null)
							rs=null;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","insinwardreg_renew");
							arrValues.add(strInwardno);
						
							strQuery = SQLParser.getSqlQuery("selinwardreg_renew^"+strExistInwardNo);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
							arrValues.add(correctNull(rs.getString("inward_sector")));//0
							//arrValues.add(correctNull(rs.getString("inward_createdon")));//1
							//arrValues.add(correctNull(rs.getString("inward_appliedon")));//2
							arrValues.add(correctNull(rs.getString("inward_custname")));//3
							arrValues.add(correctNull(rs.getString("inward_add1")));//4
							arrValues.add(correctNull(rs.getString("inward_add2")));//5
							arrValues.add(correctNull(rs.getString("inward_city")));//6
							arrValues.add(correctNull(rs.getString("inward_state")));//7
							arrValues.add(correctNull(rs.getString("inward_zipcode")));//8
							arrValues.add(correctNull(rs.getString("inward_phone")));//9
							arrValues.add(correctNull(rs.getString("inward_mobile")));//10
							arrValues.add(correctNull(rs.getString("inward_email")));//11
							arrValues.add(correctNull(rs.getString("inward_dob")));//12
							arrValues.add(correctNull(rs.getString("inward_pantan")));//13
							arrValues.add(correctNull(rs.getString("inward_purpose")));//14
							arrValues.add(correctNull(rs.getString("inward_scheme")));//15
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("inward_termloanamt")))));//16
							arrValues.add(Helper.correctNull(rs.getString("inward_wcloanamt")));//17
							arrValues.add(Helper.correctNull(rs.getString("inward_nonwcloanamt")));//18
							arrValues.add(correctNull(rs.getString("inward_ADDITIONALDETAILS")));//19
							//arrValues.add(correctNull(rs.getString("inward_docreceivedon")));//20
							arrValues.add(correctNull(rs.getString("inward_docreceived")));//21							
							arrValues.add(correctNull(rs.getString("inward_appcreateat")));//22
							arrValues.add(strSolid);//23
							arrValues.add(correctNull(rs.getString("inward_appatached")));//24
							arrValues.add(correctNull(rs.getString("inward_applnprocessat")));//25
							arrValues.add(correctNull(rs.getString("inward_brstatus")));//26
							arrValues.add(correctNull(rs.getString("inward_valuesin")));//27
							arrValues.add(correctNull(rs.getString("inward_usrid")));
							arrValues.add(correctNull(rs.getString("inward_assignusrid")));
							arrValues.add(correctNull(rs.getString("inward_modifiedby")));
							//arrValues.add(correctNull(rs.getString("inward_modifieddate")));
							//arrValues.add(correctNull(rs.getString("inward_assigndate")));							
							arrValues.add(correctNull(rs.getString("inward_borrowertype")));
							arrValues.add(correctNull(rs.getString("inward_cbscustid")));
							arrValues.add(correctNull(rs.getString("inward_appliedfor")));
							arrValues.add(correctNull(rs.getString("inward_proptype")));
							arrValues.add(correctNull(rs.getString("inward_cibilreport")));
							arrValues.add(correctNull(rs.getString("inward_passportnumber")));
							arrValues.add(correctNull(rs.getString("inward_voterid")));				
							arrValues.add(correctNull(rs.getString("inward_enquirypurpose")));
							arrValues.add(correctNull(rs.getString("inward_gender")));
							arrValues.add(correctNull(rs.getString("inward_internetapp")));
							arrValues.add(correctNull(rs.getString("inward_dist")));
							arrValues.add("1");
							arrValues.add(correctNull(rs.getString("inward_rejreason")));
							arrValues.add(correctNull(rs.getString("inward_schemedesc")));
							arrValues.add(correctNull(rs.getString("inward_bankscheme")));
							arrValues.add(correctNull(rs.getString("inward_subsamount")));
							arrValues.add(correctNull(rs.getString("inward_sponagency")));
							arrValues.add(correctNull(rs.getString("inward_govtspons")));
							arrValues.add(correctNull(rs.getString("inward_schmetype")));
							arrValues.add(correctNull(rs.getString("inward_subsdtype")));
							arrValues.add(correctNull(rs.getString("inward_otheragency")));
							arrValues.add(correctNull(rs.getString("inward_ssi")));
							arrValues.add(correctNull(rs.getString("inward_tiny")));
							arrValues.add(correctNull(rs.getString("inward_exceluploadflag")));
							arrValues.add(correctNull(rs.getString("inward_phone_stdcode")));
							arrValues.add(correctNull(rs.getString("inward_totalloanamt")));
							arrValues.add(correctNull(rs.getString("inward_drivinglic")));
							arrValues.add(correctNull(rs.getString("inward_aadhar")));
							arrValues.add(correctNull(rs.getString("inward_canvassedbystaff")));
							arrValues.add(correctNull(rs.getString("inward_borrowerstatus")));
							arrValues.add(correctNull(rs.getString("inward_staffid")));
							}
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						
						// loandetails
						if(strAction.equalsIgnoreCase("renew")||strAction.equalsIgnoreCase("postsanction"))
						{
						if(rs!=null)
							rs=null;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","insperloandetails_renew");
						arrValues.add(strAppno);
						
						strQuery = SQLParser.getSqlQuery("get_perloandetails_renew1^"+strExecappno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							//arrValues.add(correctNull(rs.getString("loan_appno")));//0
							arrValues.add(correctNull(rs.getString("loan_modintrate")));//1
							arrValues.add(correctNull(rs.getString("loan_terms")));//2
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_amtreqd")))));//3
							arrValues.add(correctNull(rs.getString("loan_costloanprd")));//4
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")))));//5
							arrValues.add(correctNull(rs.getString("loan_downpay")));//6
							arrValues.add(correctNull(rs.getString("loan_tradein")));//7
							arrValues.add(correctNull(rs.getString("loan_loantrade")));//8
							arrValues.add(correctNull(rs.getString("loan_modusrid")));//9
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_appamt")))));//10
							arrValues.add(correctNull(rs.getString("loan_reqterms")));//11
							arrValues.add(correctNull(rs.getString("loan_termrange")));//12
							arrValues.add(correctNull(rs.getString("loan_inttype")));//13
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_emi")))));//14
							arrValues.add(Helper.CLOBToString(rs.getClob("loan_purposeofloan")));//15
							arrValues.add(correctNull(rs.getString("loan_repaymenttype")));//
							arrValues.add(correctNull(rs.getString("loan_margin")));//
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_docfee")))));//
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_profee")))));//
							arrValues.add(correctNull(rs.getString("loan_bank_refno")));//
							arrValues.add(correctNull(rs.getString("loan_interestcharged")));//
							arrValues.add(correctNull(rs.getString("loan_repaycapacity")));//
							arrValues.add(correctNull(rs.getString("loan_steptype")));//
							arrValues.add(correctNull(rs.getString("loan_fileno")));
							arrValues.add(correctNull(rs.getString("loan_intrate")));//intrate
							arrValues.add(strAppReceicedDate);
							arrValues.add(correctNull(rs.getString("loan_deviationloanamount")));
							arrValues.add(correctNull(rs.getString("loan_furmargin")));
							arrValues.add(correctNull(rs.getString("loan_type")));
							arrValues.add(correctNull(rs.getString("loan_modeofpay")));
							arrValues.add(correctNull(rs.getString("loan_facility")));
							arrValues.add(correctNull(rs.getString("loan_govt")));
							arrValues.add(correctNull(rs.getString("loan_sub")));
							arrValues.add(correctNull(rs.getString("offeredmargin")));
							arrValues.add(correctNull(rs.getString("salarylimit")));
							arrValues.add(correctNull(rs.getString("land_measurement")));
							arrValues.add(correctNull(rs.getString("govt_scheme")));				
							arrValues.add(correctNull(rs.getString("loan_annualincome")));
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_interest_emi")))));//16
							arrValues.add(correctNull(rs.getString("loan_operativeaccno")));
							arrValues.add(correctNull(rs.getString("loan_sponseragency")));
							arrValues.add(correctNull(rs.getString("loan_subsidytype")));
							arrValues.add(correctNull(rs.getString("loan_copsociety")));
							arrValues.add(correctNull(rs.getString("loan_intcalcmode")));							
							arrValues.add(correctNull(rs.getString("loan_prepaycharge")));
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_upfrontfee")))));
							arrValues.add(correctNull(rs.getString("loan_cgtmse")));
							arrValues.add(correctNull(rs.getString("loan_docrecvd")));
							arrValues.add(correctNull(rs.getString("loan_docspecify")));
							arrValues.add(correctNull(rs.getString("loan_specialcust")));
							arrValues.add(correctNull(rs.getString("loan_interestid")));
							arrValues.add(correctNull(rs.getString("loan_baserate")));
							arrValues.add(correctNull(rs.getString("loan_ageofveh")));
							arrValues.add(correctNull(rs.getString("loan_schemedesc")));
							arrValues.add(correctNull(rs.getString("loan_bankscheme")));
							arrValues.add(correctNull(rs.getString("loan_takeover")));
							arrValues.add(correctNull(rs.getString("loan_creditrskval")));
							arrValues.add(correctNull(rs.getString("loan_busstatval")));
							arrValues.add(correctNull(rs.getString("loan_mclrtabcode")));
							arrValues.add(correctNull(rs.getString("loan_mclrtype")));
							arrValues.add(correctNull(rs.getString("loan_goldrate_masterid")));
							arrValues.add(correctNull(rs.getString("loan_lockperiod")));
							arrValues.add(correctNull(rs.getString("loan_dnw_revisions")));
							arrValues.add(correctNull(rs.getString("loan_metlifepremiumamt")));
							arrValues.add(correctNull(rs.getString("loan_duedate")));
							arrValues.add(correctNull(rs.getString("LOAN_AGENCYNAME")));
							arrValues.add(correctNull(rs.getString("LOAN_CGTMSE_APPLICABLE")));
							arrValues.add(correctNull(rs.getString("LOAN_RESTR_SCHEME")));
							String LOAN_ROITYPE = correctNull(rs.getString("LOAN_ROITYPE"));
							if(LOAN_ROITYPE.equalsIgnoreCase("") && strAction.equalsIgnoreCase("postsanction") && strParentdigi.equalsIgnoreCase("PR")){
							arrValues.add("O");
							}else{
								arrValues.add(LOAN_ROITYPE);
							}
							arrValues.add(correctNull(rs.getString("LOAN_ROISCORE")));
							arrValues.add(correctNull(rs.getString("LOAN_PROCESSED_TYPE")));
							arrValues.add(correctNull(rs.getString("LOAN_PREMIUM_TENOR")));
							arrValues.add(correctNull(rs.getString("LOAN_PREMIUM_LOAN_AMOUNT")));
							arrValues.add(correctNull(rs.getString("LOAN_INS_ACCOUNT_NO")));
							arrValues.add(correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
							arrValues.add(correctNull(rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")));
							arrValues.add(correctNull(rs.getString("LOAN_CG_PERCENT")));
							arrValues.add(correctNull(rs.getString("LOAN_TOT_INT")));
							arrValues.add(correctNull(rs.getString("LOAN_CRP")));
							arrValues.add(correctNull(rs.getString("LOAN_BSP")));
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						//Insert into com_banking details by Guhan Tamilvanan on 14.01.2016
						/*hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","combankinginsertNEW_retail");
						arrValues.add(strAppno);
						arrValues.add(strAppno);
						arrValues.add(strAppid);
						arrValues.add(strExecappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
						
						//Loan Secure Details
						if(rs!=null)
							rs=null;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","insloansecure_renew");
						arrValues.add(strAppno);
						
						strQuery = SQLParser.getSqlQuery("getloansecure_renew^"+strExecappno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							//arrValues.add(correctNull(rs.getString("loan_appno")));//0
							arrValues.add(correctNull(rs.getString("loan_noofinstallment")));//1
							arrValues.add(correctNull(rs.getString("loan_periodicity")));//2
							arrValues.add(correctNull(rs.getString("loan_secure")));//3
							arrValues.add(correctNull(rs.getString("loan_secureamount")));//4
							arrValues.add(correctNull(rs.getString("loan_servised")));//6
							
						}else{
							arrValues.add("");//1
							arrValues.add("");//2
							arrValues.add("");//3
							arrValues.add("");//4
							arrValues.add("");//5
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						//CGTMSE
						if(rs!=null)
							rs=null;
						
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","CropCgtmse_insert_Renew");
						arrValues.add(strAppno);
						arrValues.add(strExecappno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
						
						}
						else{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","insertloandetails");
							arrValues.add(strAppno);
							arrValues.add(strAppReceicedDate);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						//Workflow
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","insworkflow_renew");
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("1");
						arrValues.add("1");
						arrValues.add("C");	
						
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
						
						if(strAction.equalsIgnoreCase("renew")||strAction.equalsIgnoreCase("postsanction"))
						{
						//Documents
						if(rs !=null){
							rs.close();
						}
						 strQuery = SQLParser.getSqlQuery("getappdocuments_renew^"+ strExecappno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next())
							{
								hshQuery2=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize2 = intUpdatesize2+1;
								hshQuery2.put("strQueryId","insappdocuments_renew");
								arrValues.add(strAppno);
								arrValues.add(correctNull((String) rs.getString("apdoc_doccode")));
								arrValues.add(correctNull((String) rs.getString("apdoc_substatus")));
								arrValues.add(correctNull((String) rs.getString("apdoc_subdate")));
								arrValues.add(correctNull((String) rs.getString("apdoc_totpages")));
								arrValues.add(correctNull((String) rs.getString("apdoc_rendate")));
								arrValues.add(correctNull((String) rs.getString("apdoc_doctype")));
								arrValues.add(correctNull((String) rs.getString("apdoc_remarks")));
								arrValues.add(correctNull((String) rs.getString("doc_created_date")));								
								hshQuery2.put("arrValues",arrValues);
								hshQueryValues2.put("size",Integer.toString(intUpdatesize2));
								hshQueryValues2.put(Integer.toString(intUpdatesize2),hshQuery2);			

							}
							if(hshQueryValues2.size()>0)
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues2, "updateData");
						}
						
						if(rs !=null){
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("getproductstype_renew^"+strPrdCode);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()){
							strPrdType=Helper.correctNull((String)rs.getString("prd_type"));
						}
						if(false){//strPrdType.equalsIgnoreCase("pG")
							//Gold Ornaments
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("getgolddetails_renew^"+strExecappno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next())
							{	
								
								hshQuery1=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize1 = intUpdatesize1+1;
								hshQuery1.put("strQueryId","insgoldloan_renew");
								arrValues.add(strAppno);
								arrValues.add(correctNull((String) rs.getString("AGR_ARTNO")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTDESC")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTGROSSWT")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTQTYTOUCH")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTMKTRATE")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTRATE")));
								arrValues.add(correctNull((String) rs.getString("AGR_ESTRATE")));
								arrValues.add(correctNull((String)rs.getString("agr_quantity")));
								arrValues.add(correctNull((String)rs.getString("AGR_BANKVALUE")));
								arrValues.add(correctNull((String)rs.getString("agr_grsno")));
								arrValues.add(correctNull((String)rs.getString("agr_secid")));
								arrValues.add(correctNull((String)rs.getString("agr_articletype")));
								arrValues.add(correctNull(rs.getString("agr_netvalue")));
								
								hshQuery1.put("arrValues",arrValues);
								hshQueryValues1.put("size",Integer.toString(intUpdatesize1));
								hshQueryValues1.put(Integer.toString(intUpdatesize1),hshQuery1);
								
							}
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
							}
						//No need to take the deposits - Bank confirmation on 22-09-2016
						/*	if(strPrdType.equalsIgnoreCase("pR")){
								//Deposite Loan Details
								if(rs!=null)
								{
									rs.close();
								}
								strQuery = SQLParser.getSqlQuery("getloanagainstdeposit_renew^"+strExecappno);
								rs = DBUtils.executeQuery(strQuery);
								while (rs.next())
								{	
									hshQuery1=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize1 = intUpdatesize1+1;
									hshQuery1.put("strQueryId","insloanagainstdep_renew");
									arrValues.add(correctNull((String) rs.getString("loan_SLNO")));
									arrValues.add(strAppno);
									arrValues.add(correctNull((String) rs.getString("loan_issuebranch")));
									arrValues.add(correctNull((String) rs.getString("loan_STANDNAME")));
									arrValues.add(correctNull((String) rs.getString("loan_accno")));
									arrValues.add(correctNull((String) rs.getString("laon_dateofissue")));
									arrValues.add(correctNull((String) rs.getString("loan_faceval")));
									arrValues.add(correctNull((String) rs.getString("loan_rateofint")));
									arrValues.add(correctNull((String) rs.getString("loan_presentos")));
									arrValues.add(correctNull((String) rs.getString("loan_presentason")));
									arrValues.add(correctNull((String)rs.getString("loan_maturityval")));
									arrValues.add(correctNull((String)rs.getString("loan_tenure")));
									arrValues.add(correctNull((String)rs.getString("loan_matdate")));
									arrValues.add(correctNull((String)rs.getString("loan_rateincharges")));
									arrValues.add(correctNull((String)rs.getString("loan_margin")));
									arrValues.add(correctNull((String)rs.getString("loan_banktype")));
									arrValues.add(correctNull((String)rs.getString("loan_secid")));
									arrValues.add(correctNull((String)rs.getString("loan_updflag")));
									arrValues.add(correctNull((String)rs.getString("loan_entryflag")));
									hshQuery1.put("arrValues",arrValues);
									hshQueryValues1.put("size",Integer.toString(intUpdatesize1));
									hshQueryValues1.put(Integer.toString(intUpdatesize1),hshQuery1);									
								}
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
								}*/
						
						/*
						 * For Inserting Data in app_renewal table by Karthikeyan.S
						 */
							
						/*Commented by Punitha. because Existing application no stored in Application table.
						 * 
						 * hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","ins_AppRenew");
						arrValues.add("1");
						arrValues.add(strAppNumber);
						arrValues.add(strAppno);
						arrValues.add(strCBSACNo);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
						
						/*
						 * End
						 */
						
						//EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						if(strAction.equalsIgnoreCase("renew")||strAction.equalsIgnoreCase("postsanction"))
						{
							
						if(hidCategoryType.equalsIgnoreCase("RET"))
						{
							// For Renewal of CBS Details
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							intUpdatesize = intUpdatesize+1;
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","renew_cbsrenewdata");
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					  		//Ended of CBS Details Renewal
					  		
					  		// For Renewal of MIS Details
					  		arrValues = new ArrayList();
							hshQuery = new HashMap();
							intUpdatesize = intUpdatesize+1;
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","renew_misappdetails");
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					  		
					  		arrValues = new ArrayList();
							hshQuery = new HashMap();
							intUpdatesize = intUpdatesize+1;
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","renew_misappdisplayscreen");
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					  		
					  		arrValues = new ArrayList();
							hshQuery = new HashMap();
							intUpdatesize = intUpdatesize+1;
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQuery.put("strQueryId","renew_misappclassification");
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						
						
						if(strAction.equalsIgnoreCase("renew") && strPrdType.equalsIgnoreCase("pI"))
						{
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								intUpdatesize = intUpdatesize+1;
								arrValues.add("");
								arrValues.add(strAppno);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","upd_costofloan_loandetails_pI");
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						
						//Ended of MIS Details Renewal
						}
				  		
				  		arrValues = new ArrayList();
						hshQuery = new HashMap();
						intUpdatesize = intUpdatesize+1;
						if(strAction.equalsIgnoreCase("restructure"))
							arrValues.add("S");
						else if(strAction.equalsIgnoreCase("postsanction"))
							arrValues.add("P");
						else
							arrValues.add("Y");
						arrValues.add(strExecappno);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","renew_applicationflag");
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updinwardappatached");
						arrValues.add("Y");
						arrValues.add("op");
						arrValues.add(strInwardno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						if(strAction.equalsIgnoreCase("restructure"))
						{
							String strCount="";
							String strQueryCount = SQLParser.getSqlQuery("sel_restraccountcount^"+strExCBSAccno);
							ResultSet rsCount = DBUtils.executeQuery(strQueryCount);
							if(rsCount.next())
							{
								strCount = Helper.correctInt((String)rsCount.getString("countval"));
							}
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","insapprestructure");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							arrValues.add("1");
							arrValues.add(strExCBSAccno);
							arrValues.add("P");
							arrValues.add("1");
							arrValues.add(strCount);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						if(strAction.equalsIgnoreCase("postsanction"))
						{
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","insapppostsanction");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add(strExecappno);
							arrValues.add("1");
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","inssecurityrenew_postsanc");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							arrValues.add("P");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_repayschedulerenew");
							arrValues.add(strAppno);
							arrValues.add("1");
							arrValues.add(strExecappno);
							arrValues.add("1");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
//							hshQuery=new HashMap();
//							arrValues=new ArrayList();
//							intUpdatesize = intUpdatesize+1;
//							hshQuery.put("strQueryId","upd_receivedate_loandetails");
//							arrValues.add(strAppno);
//							hshQuery.put("arrValues",arrValues);
//							hshQueryValues.put("size",Integer.toString(intUpdatesize));
//							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","insmpbfcalc_postsanc");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","edudetailsrenew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","eduscholarsrenew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","eduparticularsrenew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","educoursedetrenew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","instacash_renew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_pmay_houseloan_details_renew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_per_house_proposed_asset_renew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_app_deviation_renew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							

							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_ratingdet_postsanction");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","ins_ahp_houseloan_details_renew");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
						}
						if(strAction.equalsIgnoreCase("renew"))
						{
							// Customer Background copy
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","renew_retailcomments");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							//Security details
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","renew_securities");
							arrValues.add(strAppno);
							arrValues.add(strExecappno);
							arrValues.add("P");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						
						
				  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				  		
				  		if(strAction.equalsIgnoreCase("renew"))
						{
				  			hshQueryValues=new HashMap();
				  			hshQuery=new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","update_mis_appdetails");
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
				  		
						hshRecord.put("borrowid",strBorrowId);
						hshRecord.put("borrowdesc",strBorrowDesc);
						hshRecord.put("hidAction",strAction);
						hshRecord.put("appno",strAppno);
						hshRecord.put("vecData",vecData);
						hshRecord.put("comapp_id",correctNull((String)hshValues.get("comapp_id")));
						hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("cattype")));
						hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));
						hshRecord.put("strApplicationNo",strAppno);
						hshResult.put("appinwardno",strInwardno);
						hshResult.put("strAppno",strAppno);
						hshResult.put("loan_receivedate",strAppReceicedDate);
					}
								
				}
			}
			
            }
			
			HashMap hshQueryValueschk=new HashMap();
			HashMap hshQuerychk = new HashMap();
			ArrayList arrValuechk=new ArrayList();
			String roiflag="";
			String loan_modintrateold="";
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selpostsanroiselection^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				
				roiflag=Helper.correctNull((String)rs.getString("PS_MODIFY_TERMS"));
				if(roiflag.contains("MRI"))
				{
					hshValues.put("roiflagval","S");
				}
				
			}
			
			if(strAction.equalsIgnoreCase("postsanction") && Helper.correctNull((String)hshValues.get("roiflagval")).equalsIgnoreCase("S"))
			{
				strQuery1 = SQLParser.getSqlQuery("selretduedate^" + strAppno);
				rs = DBUtils.executeQuery(strQuery1);
				
				if(rs.next())
				{
					loan_modintrateold=String.valueOf(Double.parseDouble(Helper.correctNull(rs.getString("loan_modintrate"))));
				}
				
				hshQueryValueschk=new HashMap();
				hshQuerychk = new HashMap();
				arrValuechk=new ArrayList();
				arrValuechk.add(loan_modintrateold);
				arrValuechk.add(strAppno);
				hshQuerychk.put("strQueryId","updateROIInFInancleoldroi"); 
				hshQuerychk.put("arrValues",arrValuechk);
				hshQueryValueschk.put("size","1");
				hshQueryValueschk.put("1",hshQuerychk);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValueschk,"updateData");
				
			}
			
			strApplicationNo = correctNull((String) hshValues.get("appno"));
			if (strApplicationNo.equalsIgnoreCase(""))
			{
				strApplicationNo = correctNull((String) hshValues.get("hidappno1"));
			}
			/*if(strAction.equalsIgnoreCase("updateparams"))
			{
				String	strFacilitySno=correctNull((String)hshValues.get("hidParameters")); 
				String strFacdetails[]=new String[2];
				String strFacsno[]=strFacilitySno.split("~");
				for(int i=0;i<strFacsno.length; i++)
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();

					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("\\^");

					hshQuery.put("strQueryId","upd_apppostsanction");
					arrValues.add(Helper.correctNull(strFacdetails[1]));
					arrValues.add("");
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctNull(strFacdetails[0]));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
			}*/
			if(strApplicationNo.equalsIgnoreCase("new") && !strAppid.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{rs.close();}
				String strQuery23 = SQLParser.getSqlQuery("selrenewappid^" + strAppid);
				rs = DBUtils.executeQuery(strQuery23);
				if(rs.next()){strAppid=Helper.correctNull((String)rs.getString("perapp_id"));}
				hshResult.put("hidapplicantid",strAppid);
			}
			if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
			{
				if(rs !=null)
				{
					rs.close();
				}
				String strProdPurpose="",strVehicleType="";
				String strQuery23 = SQLParser.getSqlQuery("selprodpurpose^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery23);
				if(rs.next())
				{
					strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
					strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));
				}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(rs !=null)
				{
					rs.close();
				}		
				if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
				{
				rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+strApplicationNo);
				if(rs.next())
				{
					strPrdType=Helper.correctNull((String)rs.getString("PRD_TYPE"));
					hshResult.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
					hshResult.put("prd_purpose", Helper.correctNull((String)rs.getString("prd_purpose")));
					hshResult.put("PRD_STAFFPRD", Helper.correctNull((String)rs.getString("PRD_STAFFPRD")));
				}
				}
				if(rs !=null)
				{
					rs.close();
				}					
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
					{
					rs = DBUtils.executeLAPSQuery("pergetloanProductbymargin^" + strApplicationNo);
					}
				}
				else
				{
					if(strPrdType.equalsIgnoreCase("pI"))
					{
						if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
						{
						rs = DBUtils.executeLAPSQuery("pergetloanProductInstaCash^" + strApplicationNo);
						}
					}
					else
					{
					   if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
					   {
					   rs = DBUtils.executeLAPSQuery("pergetloanProduct^" + strApplicationNo);
					   }
					}
				}
				bState = rs.next();
				if (bState)
				{
					hshResult.put("noData", "Data");
				}
				else
				{
					hshResult.put("noData", "noData");
				}
				while (bState)
				{
					hshResult.put("PRD_CGTMSEFALG", correctNull(rs.getString("PRD_CGTMSEFALG")));
					hshResult.put("appno", correctNull((String)rs.getString("appno")));
					hshResult.put("status", correctNull((String)rs.getString("status")));
					hshResult.put("aname", correctNull((String)rs.getString("aname")));
					hshResult.put("appid", correctNull((String)rs.getString("appid")));
					hshResult.put("category", correctNull((String)rs.getString("category")));
					hshResult.put("subcategory", correctNull((String)rs.getString("subcategory")));
					hshResult.put("rfrom", correctNull((String)rs.getString("rfrom")));
					hshResult.put("rangeto", correctNull((String)rs.getString("rangeto")));
					strPrdCode = correctNull((String)rs.getString("prdcode"));
					hshResult.put("prdcode", strPrdCode);
					
					hshResult.put("lterms", correctNull((String)rs.getString("lterms")));
					hshResult.put("amtreqd", correctNull((String)rs.getString("amtreqd")));
					hshResult.put("cloanprd", correctNull((String)rs.getString("cloanprd")));
					hshResult.put("tradein", correctNull((String)rs.getString("tradein")));
					hshResult.put("loantrade", correctNull((String)rs.getString("loantrade")));
					hshResult.put("staff_flag", correctNull((String)rs.getString("indinfo_is_staff")));
					hshResult.put("PrincipalRatio",correctNull((String)rs.getString("prd_principal")));
					hshResult.put("InterestRatio",correctNull((String)rs.getString("prd_interest")));
					hshResult.put("PRD_STAFF_MAXTERM_PRIN",correctNull((String)rs.getString("PRD_STAFF_MAXTERM_PRIN")));
					hshResult.put("PRD_STAFF_MAXTERM_INTR",correctNull((String)rs.getString("PRD_STAFF_MAXTERM_INTR")));
					hshResult.put("staffproduct",correctNull((String)rs.getString("prd_staffprd")));
					hshResult.put("monthpay", correctNull((String)rs.getString("loan_emi")));  //MODIFIED to retrieve EMI from table itself
					hshResult.put("InterestEMI", correctNull((String)rs.getString("loan_interest_emi")));
					hshResult.put("margin_perct", correctNull((String)rs.getString("loan_margin")));
					
					dblmodintrate = Double.parseDouble(Helper.correctDouble((String)rs.getString("mintrate")));
					hshResult.put("downpay", correctNull((String)rs.getString("downpay")));// Helper.formatDoubleValue(dbldownPay)
					hshResult.put("sancmount", correctNull((String)rs.getString("sancamount")));
					hshResult.put("loan_deviationloanamount", correctNull(rs.getString("loan_deviationloanamount")));
					hshResult.put("ramount", correctNull((String)rs.getString("raamount")));
					hshResult.put("prd_renew", correctNull((String)rs.getString("prd_renew")));
					hshResult.put("hidClass", correctNull((String)rs.getString("hidclass")));
					hshResult.put("lreqterms", correctNull((String)rs.getString("lreqterms")));
					hshResult.put("loantermrange", correctNull((String)rs.getString("loan_termrange")));
					hshResult.put("loaninttype", correctNull((String)rs.getString("loan_inttype")));
					hshResult.put("loanpurposeofloan", Helper.CLOBToString(rs.getClob("loan_purposeofloan")));
					hshResult.put("loanfiledon", correctNull((String)rs.getString("loan_filedon")));
					hshResult.put("repaymenttype", correctNull((String)rs.getString("loan_repaymenttype")));
					hshResult.put("loan_repaycapacity", correctNull((String)rs.getString("loan_repaycapacity")));
					hshResult.put("loan_bank_refno", correctNull((String)rs.getString("loan_bank_refno")));
					hshResult.put("loan_interestcharged", correctNull((String)rs.getString("loan_interestcharged")));
					hshResult.put("loan_steptype", correctNull((String)rs.getString("loan_steptype")));
					hshResult.put("loan_fileno", Helper.correctNull((String)rs.getString("loan_fileno")));
					
					hshResult.put("prd_type", Helper.correctNull((String)rs.getString("prd_type")));
					hshResult.put("loan_type", Helper.correctNull((String)rs.getString("loan_type")));
					hshResult.put("loan_modeofpay", Helper.correctNull((String)rs.getString("loan_modeofpay")));
					hshResult.put("loan_operativeaccno", Helper.correctNull((String)rs.getString("loan_operativeaccno")));
					hshResult.put("loan_secvalue", Helper.correctNull((String)rs.getString("loan_secvalue")));					
					hshResult.put("LOAN_DIGI_RESIDUAL", Helper.correctNull((String)rs.getString("LOAN_DIGI_RESIDUAL")));
					hshResult.put("LOAN_ECSBANKNAME", Helper.correctNull((String)rs.getString("LOAN_ECSBANKNAME")));
					hshResult.put("LOAN_ECSACCOUNTTYPE", Helper.correctNull((String)rs.getString("LOAN_ECSACCOUNTTYPE")));
					hshResult.put("LOAN_ECSOPERACCNUM", Helper.correctNull((String)rs.getString("LOAN_ECSOPERACCNUM")));
					hshResult.put("LOAN_ECSATHUNMODE", Helper.correctNull((String)rs.getString("LOAN_ECSATHUNMODE")));
					hshResult.put("LOAN_ECSIFSCCODE", Helper.correctNull((String)rs.getString("LOAN_ECSIFSCCODE")));
					hshResult.put("loan_facility", Helper.correctNull((String)rs.getString("loan_facility")));
					hshResult.put("loan_govt", Helper.correctNull((String)rs.getString("loan_govt")));
					hshResult.put("loan_sub", Helper.correctNull((String)rs.getString("loan_sub")));
					hshResult.put("offeredmargin", Helper.correctNull((String)rs.getString("offeredmargin")));
					hshResult.put("loan_copsociety", Helper.correctNull((String)rs.getString("loan_copsociety")));
					hshResult.put("PRD_LOANTYPE", Helper.correctNull((String)rs.getString("PRD_LOANTYPE")));
					String loan_receivedate = Helper.correctNull((String)rs.getString("loan_receivedate"));

					if (loan_receivedate.equalsIgnoreCase("01/01/1900"))
					{
						hshResult.put("loan_receivedate", "");
					}
					else
					{
						hshResult.put("loan_receivedate", loan_receivedate);
					}
					
					hshResult.put("Loan_Sanct_Eff_ROI_date", Helper.correctNull((String) rs.getString("Loan_Sanct_Eff_ROI_date")));
					hshResult.put("perapp_salaryrouted", Helper.correctNull((String) rs.getString("perapp_salaryrouted")));
					hshResult.put("measurementtype", Helper.correctNull((String)rs.getString("LAND_MEASUREMENT")));
					hshResult.put("govt_scheme", Helper.correctNull((String)rs.getString("govt_scheme")));
					hshResult.put("loan_annualincome", Helper.correctNull((String)rs.getString("loan_annualincome")));
					hshResult.put("sponseragency", Helper.correctNull((String)rs.getString("loan_sponseragency")));
					hshResult.put("subsidytype", Helper.correctNull((String)rs.getString("loan_subsidytype")));
					hshResult.put("AGENCYNAME", Helper.correctNull((String)rs.getString("LOAN_AGENCYNAME")));
					hshResult.put("appinwardno", Helper.correctNull((String)rs.getString("app_inwardno")));
					hshResult.put("docfee", correctNull((String)rs.getString("loan_docfee")));
					hshResult.put("procfee", correctNull((String)rs.getString("loan_profee")));
					hshResult.put("schemecode", correctNull((String)rs.getString("scheme_code")));
					hshResult.put("loan_intcalcmode", Helper.correctNull((String)rs.getString("loan_intcalcmode")));
					hshResult.put("loan_prepaycharge", Helper.correctNull((String)rs.getString("loan_prepaycharge")));
					hshResult.put("loan_upfrontfee", Helper.correctNull((String)rs.getString("loan_upfrontfee")));
					hshResult.put("loan_cgtmse", Helper.correctNull((String)rs.getString("loan_cgtmse")));
					hshResult.put("loan_docrecvd", Helper.correctNull((String)rs.getString("loan_docrecvd")));
					
					hshResult.put("loan_docspecify", Helper.correctNull((String)rs.getString("loan_docspecify")));
					hshResult.put("loan_specialcust", Helper.correctNull((String)rs.getString("loan_specialcust")));
					hshResult.put("loan_ageofveh", Helper.correctNull((String)rs.getString("loan_ageofveh")));
					hshResult.put("loan_interestid", Helper.correctNull((String)rs.getString("loan_interestid")));
					
					hshResult.put("LOAN_TIMESOFABOVE", Helper.correctNull((String)rs.getString("LOAN_TIMESOFABOVE")));
					hshResult.put("loan_mongrossrent", Helper.correctNull((String)rs.getString("loan_mongrossrent")));
					hshResult.put("prd_purpose", Helper.correctNull((String)rs.getString("prd_purpose")));
					hshResult.put("receiptclpu", Helper.correctNull((String)rs.getString("app_clpudate")));
					hshResult.put("receiptcpc",Helper.correctNull((String)rs.getString("app_cpcdate")));
					hshResult.put("receiptroho",Helper.correctNull((String)rs.getString("APP_ROHODATE")));
					hshResult.put("loan_takeover",Helper.correctNull((String)rs.getString("loan_takeover")));
					hshResult.put("perapp_employment", correctNull((String) rs.getString("perapp_employment")));
					hshResult.put("APP_RENEW_FLAG", correctNull((String) rs.getString("APP_RENEW_FLAG")));
					hshResult.put("loan_creditrskval", correctNull(rs.getString("loan_creditrskval")));
					hshResult.put("loan_busstatval", correctNull(rs.getString("loan_busstatval")));
					hshResult.put("loan_mclrtabcode", correctNull(rs.getString("loan_mclrtabcode")));
					
					hshResult.put("perapp_invocdate", correctNull(rs.getString("perapp_invocdate")));
					if(!(strAction.equalsIgnoreCase("restructure")||strAppType.equalsIgnoreCase("S")))
					{
					hshResult.put("strprdminterm", correctNull(rs.getString("prd_minterm")));
					hshResult.put("prd_holiday", Helper.correctNull((String)rs.getString("prd_holiday")));
					hshResult.put("maxterms", correctNull((String)rs.getString("prd_term")));
					}else{
						hshResult.put("strprdminterm", correctNull(rs.getString("PRD_MINTERM_REST")));
						hshResult.put("prd_holiday", correctNull(rs.getString("PRD_HOLIDAY_REST")));
						hshResult.put("maxterms", correctNull(rs.getString("PRD_TERM_REST")));
					}
					if(!correctNull(rs.getString("loan_mclrtype")).equalsIgnoreCase(""))
	 				{
						loantype=Helper.correctNull((String)hshResult.get("prd_type"));
						typeofagsec=Helper.correctNull((String)hshResult.get("loan_mclrtabcode"));
						String applicationtype="";
						String appstatusforop="";
						String parameterselect="";
						String chckdigi="";
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("get_APP_RENEW_FLAG^"+Helper.correctNull((String)hshValues.get("appno")));			
						if(rs1.next())
						{
							
							applicationtype=Helper.correctNull(rs1.getString("APP_RENEW_FLAG"));
							hshResult.put("APP_RENEW_FLAG_for_ph",applicationtype );
							appstatusforop=Helper.correctNull(rs1.getString("APP_STATUS"));
							hshResult.put("APP_STATUS_for_ph",appstatusforop );
						}

						if(rs1!=null)
						{
							rs1.close();
						}
						rs1=DBUtils.executeLAPSQuery("getmodrateparameter^"+Helper.correctNull((String)hshValues.get("appno")));			
						if(rs1.next())
						{
							parameterselect="Y";
						}
						else
						{
							parameterselect="N";
						}

						
						/*if(rs1!=null)
							rs1.close();
						
						rs1=DBUtils.executeLAPSQuery("checkdigiapplication^"+Helper.correctNull((String)hshValues.get("appno")));			
						if(rs1.next())
						{
							chckdigi="Y";
							hshResult.put("chckdigi",chckdigi);
						}
						else
						{
							chckdigi="N";
							hshResult.put("chckdigi",chckdigi);
						}*/
						
						if(loantype.equalsIgnoreCase("pH")&&typeofagsec.equalsIgnoreCase("AGSEC")&&appstatusforop.equalsIgnoreCase("op")&&applicationtype.equalsIgnoreCase("P")&&parameterselect.equalsIgnoreCase("Y"))
						
						{
							
							if(rs1!=null)
								rs1.close();
							
							rs1=DBUtils.executeLAPSQuery("checkdigiapplication^"+Helper.correctNull((String)hshValues.get("appno")));			
							if(rs1.next())
							{
								HashMap hshQueryValuesDigichk = new HashMap();
								HashMap hshQueryDigichk = new HashMap();
								ArrayList arrValueDigichk = new ArrayList();

								String parentAppno = correctNull(rs1.getString("APP_PARENT_APPNO"));
								if(correctNull(rs.getString("loan_crp")).equalsIgnoreCase("") || correctNull(rs.getString("loan_bsp")).equalsIgnoreCase(""))
								{
								
								hshQueryValuesDigichk=new HashMap();
								hshQueryDigichk = new HashMap();
								arrValueDigichk=new ArrayList();
								arrValueDigichk.add(correctNull(rs.getString("loan_creditrskval")));
								arrValueDigichk.add(correctNull(rs.getString("loan_busstatval")));
								arrValueDigichk.add(Helper.correctNull((String)hshValues.get("appno")));
								hshQueryDigichk.put("strQueryId","upd_baseratedetails_digi"); 
								hshQueryDigichk.put("arrValues",arrValueDigichk);
								hshQueryValuesDigichk.put("size","1");
								hshQueryValuesDigichk.put("1",hshQueryDigichk);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValuesDigichk,"updateData");
								}
								if(rs3!=null)
									rs3.close();
								if(!parentAppno.equalsIgnoreCase(""))
								{
								rs3=DBUtils.executeLAPSQuery("selperprdmargin^"+parentAppno);			
								if(rs3.next())
								{
									if(correctNull(rs3.getString("loan_crp")).equalsIgnoreCase("") || correctNull(rs3.getString("loan_bsp")).equalsIgnoreCase(""))
									{
									hshQueryValuesDigichk=new HashMap();
									hshQueryDigichk = new HashMap();
									arrValueDigichk=new ArrayList();
									arrValueDigichk.add(correctNull(rs.getString("loan_creditrskval")));
									arrValueDigichk.add(correctNull(rs.getString("loan_busstatval")));
									arrValueDigichk.add(parentAppno);
									hshQueryDigichk.put("strQueryId","upd_baseratedetails_digi"); 
									hshQueryDigichk.put("arrValues",arrValueDigichk);
									hshQueryValuesDigichk.put("size","1");
									hshQueryValuesDigichk.put("1",hshQueryDigichk);
									EJBInvoker.executeStateLess("dataaccess",hshQueryValuesDigichk,"updateData");
									}
									
								}
								}
							
							}
							String maxval="";
							String loan_mclrtypeforph="";
							 hshQueryValueschk = new HashMap();
							 hshQuerychk = new HashMap();
							 arrValuechk = new ArrayList();
							
							rs1=DBUtils.executeLAPSQuery("select_BASERATESPREAD");			
							if(rs1.next())
							{
								
								maxval=Helper.correctNull(rs1.getString("MCLR_BASERATESPREAD"));
								
								hshResult.put("loan_baserate",maxval );
							}
							if(!correctNull(rs.getString("loan_mclrtype")).equalsIgnoreCase(""))
			 				{
							String strArr[]=correctNull(rs.getString("loan_mclrtype")).split("@");

							strArr[1]=maxval;
							int lengthofstr=strArr.length;
							lengthofstr=lengthofstr - 1;
							for(int i=0;i<strArr.length;i++)
							{
								if(i==lengthofstr)
								{
									loan_mclrtypeforph=loan_mclrtypeforph+strArr[i];
								}
								else
									
								{
								loan_mclrtypeforph=loan_mclrtypeforph+strArr[i]+"@";
								}	
							}
							hshResult.put("loan_mclrtype",loan_mclrtypeforph );
							double d1=0.0;
							double d2=0.0;
							double d3=0.0;
							double d4=0.0;
							if(correctNull(rs.getString("loan_creditrskval")).equalsIgnoreCase(""))
							{
								d1=0.0;
							}
							else
							{
								d1=Double.parseDouble(correctNull(rs.getString("loan_creditrskval")));
							}
							if(correctNull(rs.getString("loan_busstatval")).equalsIgnoreCase(""))
							{
								d2=0.0;
							}
							else
							{
								d2=Double.parseDouble(correctNull(rs.getString("loan_busstatval")));
							}
							double updateloan_mod=Double.parseDouble(maxval)+d1+d2;
							String updateloan_mod_inrate=String.valueOf(updateloan_mod);
							
							if(correctNull(rs.getString("loan_crp")).equalsIgnoreCase(""))
							{
								d3=0.0;
							}
							else
							{
								d3=Double.parseDouble(correctNull(rs.getString("loan_crp")));
							}
							if(correctNull(rs.getString("loan_bsp")).equalsIgnoreCase(""))
							{
								d4=0.0;
							}
							else
							{
								d4=Double.parseDouble(correctNull(rs.getString("loan_bsp")));
							}
							double updateloaninrate=Double.parseDouble(maxval)+d3+d4;
							String update_loan_inrate=String.valueOf(updateloaninrate);
							
							
							
							hshResult.put("mintrate", updateloan_mod_inrate); //modified	
							hshResult.put("loan_intrate", update_loan_inrate);
		 					if(strArr!=null && strArr.length>0)
		 					{
		 						if(rs1!=null)
									rs1.close();
								rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
								if(rs1.next())
								{
									
									strMclrDesc=Helper.correctNull(rs1.getString("cbs_static_data_desc"));
									hshResult.put("strMCLRtypeDesc",strMclrDesc);
								}
		 					}
		 					hshQueryValueschk=new HashMap();
							hshQuerychk = new HashMap();
							arrValuechk=new ArrayList();
							arrValuechk.add(maxval);
							arrValuechk.add(loan_mclrtypeforph);
							arrValuechk.add(updateloan_mod_inrate);
							arrValuechk.add(update_loan_inrate);
							arrValuechk.add(Helper.correctNull((String)hshValues.get("appno")));
							hshQuerychk.put("strQueryId","upd_baseratedetails"); 
							hshQuerychk.put("arrValues",arrValuechk);
							hshQueryValueschk.put("size","1");
							hshQueryValueschk.put("1",hshQuerychk);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValueschk,"updateData");
						}
						}
						else
						{
						hshResult.put("mintrate", correctNull((String)rs.getString("mintrate"))); //modified	
						hshResult.put("loan_intrate", Helper.correctNull((String)rs.getString("loan_intrate")));
						hshResult.put("loan_baserate", Helper.correctNull((String)rs.getString("loan_baserate")));
						hshResult.put("loan_mclrtype", correctNull(rs.getString("loan_mclrtype")));
	 					String strArr[]=correctNull(rs.getString("loan_mclrtype")).split("@");
	 					if(strArr!=null && strArr.length>0)
	 					{
	 						if(rs1!=null)
								rs1.close();
							rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
							if(rs1.next())
							{
								
								strMclrDesc=Helper.correctNull(rs1.getString("cbs_static_data_desc"));
								hshResult.put("strMCLRtypeDesc",strMclrDesc);
							}
	 					}
						}
	 				}
					else
					{
						hshResult.put("mintrate", correctNull((String)rs.getString("mintrate"))); //modified	
						hshResult.put("loan_intrate", Helper.correctNull((String)rs.getString("loan_intrate")));
						hshResult.put("loan_baserate", Helper.correctNull((String)rs.getString("loan_baserate")));
						hshResult.put("loan_mclrtype", correctNull(rs.getString("loan_mclrtype")));
					}
					hshResult.put("prd_deposittype", correctNull(rs.getString("prd_deposittype")));
					hshResult.put("prd_depositloanfor", correctNull(rs.getString("prd_depositloanfor")));
					hshResult.put("prd_whetheragri", correctNull(rs.getString("prd_whetheragri")));
					hshResult.put("strprdbankscheme", correctNull(rs.getString("prd_bankscheme")));
					hshResult.put("loan_lockperiod", correctNull(rs.getString("loan_lockperiod")));
					hshResult.put("loan_dnw_revisions", correctNull(rs.getString("loan_dnw_revisions")));
					hshResult.put("loan_metlifepremiumamt", correctNull(rs.getString("loan_metlifepremiumamt")));
					hshResult.put("prd_vehitype", correctNull(rs.getString("prd_vehitype")));
					hshResult.put("LOAN_DUEDATE", correctNull(rs.getString("LOAN_DUEDATE")));
					hshResult.put("LOAN_CG_PERCENT", correctNull(rs.getString("LOAN_CG_PERCENT")));
					hshResult.put("LOAN_TOT_INT", correctNull(rs.getString("LOAN_TOT_INT")));
					hshResult.put("LOAN_CGTMSE_APPLICABLE", correctNull(rs.getString("LOAN_CGTMSE_APPLICABLE")));
					//hshResult.put("LOAN_CGTMSE_STAT", correctNull(rs.getString("LOAN_CGTMSE_STAT")));
					//hshResult.put("inward_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
					hshResult.put("LOAN_MCLR_MIGRATION_DATE", correctNull(rs.getString("LOAN_MCLR_MIGRATION_DATE")));
					hshResult.put("strParentAppno", correctNull(rs.getString("APP_PARENT_APPNO")));
					hshResult.put("app_processdate", correctNull(rs.getString("app_processdate")));
					hshResult.put("PRD_DESC", correctNull(rs.getString("PRD_DESC")));
					hshResult.put("PRD_SHARETYPE", correctNull(rs.getString("PRD_SHARETYPE")));
					hshResult.put("loan_restr_scheme", correctNull(rs.getString("loan_restr_scheme")));
					strReasonCode=Helper.correctNull(rs.getString("loan_restr_scheme"));
					if(Helper.correctInt((String) hshValues.get("strappstatus")).equalsIgnoreCase("pa")){
						strcode="154";
					
					rs1=DBUtils.executeLAPSQuery("sel_staticcredit_desc^"+strcode+"^"
							+ Helper.correctNull(rs.getString("loan_restr_scheme")));
					if (rs1.next()) {
						stractiveflag = Helper.correctNull(rs1.getString("STAT_DATA_ACTIVE"));
						
					}
					}else{
					}
					hshResult.put("stractiveflag",stractiveflag);
					hshResult.put("strAppCreateDate", correctNull((String)rs.getString("APP_CREATEDATE")));
					hshResult.put("APP_PERM_NO", correctNull((String)rs.getString("APP_PERM_NO")));
					hshResult.put("strROIType", correctNull((String)rs.getString("loan_roitype")));
					hshResult.put("loan_roiscore", correctNull(rs.getString("loan_roiscore")));
					hshResult.put("LOAN_INS_COMPANY_NAME", correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					hshResult.put("LOAN_PREMIUM_TENOR", correctNull(rs.getString("LOAN_PREMIUM_TENOR")));
					hshResult.put("LOAN_PREMIUM_LOAN_AMOUNT", correctNull(rs.getString("LOAN_PREMIUM_LOAN_AMOUNT")));
					hshResult.put("LOAN_INS_ACCOUNT_NO", correctNull(rs.getString("LOAN_INS_ACCOUNT_NO")));
					hshResult.put("LOAN_PREMIUM_AMOUNT", correctNull(rs.getString("LOAN_PREMIUM_AMOUNT")));
					hshResult.put("LOAN_INS_FUNDED_COMPANY_NAME", correctNull(rs.getString("LOAN_INS_FUNDED_COMPANY_NAME")));
					hshResult.put("LOAN_INS_COMPANY_NAME", correctNull(rs.getString("LOAN_INS_COMPANY_NAME")));
					hshResult.put("loan_crp", correctNull(rs.getString("loan_crp")));
					hshResult.put("loan_bsp", correctNull(rs.getString("loan_bsp")));
					if(!Helper.correctNull(rs.getString("app_parent_appno")).equalsIgnoreCase(""))
					{
						if(rsPS!=null)
							rsPS.close();
						rsPS=DBUtils.executeLAPSQuery("getappamt^"+Helper.correctNull(rs.getString("app_parent_appno")));
						if(rsPS.next())
						{
							hshResult.put("strParentSancamt", Helper.correctDouble(rsPS.getString("loan_recmdamt")));
						}
					}
					//hshResult.put("LOAN_CFR_BORNAME", correctNull(rs.getString("LOAN_CFR_BORNAME")));
					//hshResult.put("LOAN_CFR_DEV_RENFO", correctNull(rs.getString("LOAN_CFR_DEV_RENFO")));
					//if(strAppid.equalsIgnoreCase(""))
						strAppid=correctNull((String)rs.getString("appid"));
					//strCreateDate=correctNull((String)rs.getString("APP_CREATEDATE"));
					recordflag=true;
					bState = rs.next();
					
					//if (!correctNull(rs.getString("loan_margin")).trim().equals(""))
					//{
						//dblloanValratio = rs.getDouble("loan_margin");
					//}

					//String strabc = Helper.correctNull(rs.getString("tradein"));
					//if (strabc.equals(""))
					//{
					//	strabc = "0.00";
					//}
					//dblTradeIn = Double.parseDouble(strabc);
					//String strabc1 = correctNull(rs.getString("loantrade"));
					//if (strabc1.equals(""))
					//{
					//	strabc1 = "0.00";
					//}
					//dblloanTradeIn = Double.parseDouble(strabc1);
					//dblnetTradeIn = dblTradeIn - dblloanTradeIn;
					//hshResult.put("netTradein", correctNull(Helper.formatDoubleValue(dblnetTradeIn)));
					/*dblamtRequested = Double.parseDouble(Helper.correctDouble(rs.getString("amtreqd")));
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
					}*/
					//dblnumterms = correctNull(rs.getString("lterms"));
					/*if (rs.getString("lreqterms") == null)
					{
						dblnumreqterms = 0.00;
					}
					else
					{
						dblnumreqterms = Double.parseDouble(Helper.correctDouble(rs.getString("lreqterms")));
					}*/
				}
				String strFreeze="";
				if(!strApplicationNo.equalsIgnoreCase(""))
				{
					if(rs!=null) rs.close();
			  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strApplicationNo);
		    		rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) 
					{
						strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
					}
					hshResult.put("strFreeze",strFreeze);
				}
				
		  		
				
				String typeofint = correctNull((String)hshResult.get("loaninttype"));
				
				if (typeofint.equals("Fixed") || typeofint.equals("Floating"))
				{
					hshResult.put("prd_interest", Helper.formatDoubleValue(dblmodintrate));
				}
				else if (typeofint.equalsIgnoreCase("slab"))
				{
					String strRecAmt = "";
					String strTerms = "";
					String strIntType = " ";
					HashMap hshStepup = new HashMap();
					strRecAmt = Helper.correctDouble((String) hshResult.get("amtreqd"));
					strTerms = Helper.correctDouble((String) hshResult.get("lreqterms"));
					
					if (correctNull((String) hshResult.get("loaninttype")).equals(""))
					{
						strIntType = " ";
					}
					else
					{
						strIntType = correctNull((String) hshResult.get("loaninttype"));
					}
					hshStepup.put("recamt", strRecAmt);
					hshStepup.put("prdcode", strPrdCode);
					hshStepup.put("recamt", strRecAmt);
					hshStepup.put("terms", strTerms);
					hshStepup.put("inttype", strIntType);
					
					hshStepup = getStepupRate(hshStepup);
					
					ArrayList arrtoamt = (ArrayList) hshStepup.get("slab_Toamt");
					ArrayList arrvalues = (ArrayList) hshStepup.get("slab_Tointerest");
					
					hshResult.put("prd_interest", correctNull("0.00"));
					int arrsize = arrvalues.size();

					if (arrsize > 0)
					{
						for (int i = 0; i < arrsize; i++)
						{
							strslabintrate = strslabintrate + arrvalues.get(i) + "^";
							strslabtoamt = strslabtoamt + arrtoamt.get(i) + "^";
						}
					}
					hshResult.put("totalpay", correctNull(Helper.formatDoubleValue(dbltotalpay)));
				}
				hshResult.put("strslabintrate", correctNull(strslabintrate));
				hshResult.put("strslabtoamt", correctNull(strslabtoamt));
				
				if(rs != null)
					{rs.close();}
				if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
				{
				rs = DBUtils.executeLAPSQuery("securesel^" + strApplicationNo);
				if (rs.next())
				{
					hshResult.put("loan_noofinstallment", Helper.correctNull((String)rs.getString("loan_noofinstallment")));
					hshResult.put("loan_periodicity", correctNull((String)rs.getString("loan_periodicity")));
					hshResult.put("loan_secure", correctNull((String)rs.getString("loan_secure")));
					hshResult.put("loan_secureamount", correctNull((String)rs.getString("loan_secureamount")));
					hshResult.put("loan_servised", correctNull((String)rs.getString("loan_servised")));
				}
				}
				if (rs != null)
				{
					rs.close();
				}
			}
			
			hshResult.put("hidEditMode", correctNull((String) hshValues.get("hidEditMode")));
			hshResult.put("page", strPage);
			HashMap hshAppData = new HashMap();
			hshAppData.put("appno", strApplicationNo);
			hshAppData.put("strApptype",strApptype);
			hshAppData = (HashMap) EJBInvoker.executeStateLess("appeditlock", hshAppData, "getAppData");
			char readFlag=correctNull((String)hshValues.get("strGroupRights")).charAt(18);
			String appstatus=correctNull((String)hshAppData.get("app_status"));
			String btnenable=(""+readFlag).equals("r")?"N":(appstatus.equalsIgnoreCase("OP") && correctNull((String)hshAppData.get("applnholder")).equals(correctNull((String)hshValues.get("strUserId"))))?"Y":"N";
			hshAppData.put("btnenable",btnenable);
			hshResult.put("hshAppData", hshAppData);
			/******
			 * 
			 * Delete this part after 29 Feb 2010
			 * 
			 */
			if(rs!=null)
				rs.close();
			if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
			{
			strQuery = SQLParser.getSqlQuery("selinwardnorequired^"+strApplicationNo+"^<");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("inwardnorequired",correctNull((String)rs.getString("output")));
			}
			}
			/*****
			 * End of delete after 29 feb 2010
			 * 
			 */

			rs = DBUtils.executeLAPSQuery("pergetemploy^" + strAppid);
			if (rs.next())
			{
				hshResult.put("perapp_employment", correctNull((String) rs.getString("perapp_employment")));
			//	hshResult.put("perapp_eduothers", correctNull((String) rs.getString("perapp_eduothers"))); - COMMCUST
				hshResult.put("perapp_title", correctNull((String) rs.getString("perapp_title")));
				hshResult.put("perapp_dob", correctNull((String) rs.getString("perapp_dob")));
				String birthdate = correctNull((String) rs.getString("perapp_dob"));
				String currentdate = Helper.getCurrentDateTime();
				currentdate = currentdate.substring(6, 10);
				birthdate = birthdate.substring(6, 10);
				String strAge = Integer.toString(Integer.parseInt(currentdate) - Integer.parseInt(birthdate));
				hshResult.put("perapp_age", strAge);
				hshResult.put("perapp_status", correctNull((String) rs.getString("perapp_status")));
				hshResult.put("staff_flag", correctNull((String) rs.getString("indinfo_is_staff")));
				hshResult.put("perapp_exservice", correctNull((String) rs.getString("indinfo_service_years")));
				hshResult.put("perapp_selexservice", correctNull((String) rs.getString("indinfo_exservice_man")));
				hshResult.put("serviceleft", correctNull((String) rs.getString("serviceleft")));
				hshResult.put("perapp_exserviceyear",correctNull((String)rs.getString("indinfo_service_years")));
				hshResult.put("peremp_yearsinbuss", correctNull((String) rs.getString("peremp_yearsinbuss")));
				hshResult.put("perapp_constitutionnew", correctNull(rs.getString("perapp_constitutionnew")));
				strOldid=correctNull(rs.getString("perapp_oldid"));
				
				if(Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitutionnew")))>=183 &&
						Integer.parseInt(Helper.correctInt(rs.getString("perapp_constitutionnew")))<=191)
				{
					hshResult.put("SHGcustomer", "Y");
				}
				
				if(rs !=null){
					rs.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_cg_app_status^"
						+ strAppid);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
				
					hshResult.put("AS_PERAPP_CONSTITUTION_CGTMSE", Helper.correctNull((String)rs.getString("AS_PERAPP_CONSTITUTION_CGTMSE")));
					
				}
				
			} 
			if(rs!=null)
				rs.close();
			if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
			{
			rs = DBUtils.executeLAPSQuery("selinwardappdata^" + strApplicationNo);
			if (rs.next()){
				
				strinternet_app = Helper.correctNull((String) rs.getString("inward_internetapp"));	
				strExcelFlag = Helper.correctNull(rs.getString("app_exceluploadflag"));	
				if(Helper.correctNull((String)hshResult.get("appinwardno")).equalsIgnoreCase(""))
					hshResult.put("appinwardno", Helper.correctNull((String)rs.getString("inward_no")));
				hshResult.put("appProposalType", Helper.correctNull(rs.getString("app_renew_flag")));
				hshResult.put("strLARbankscheme", Helper.correctNull(rs.getString("inward_bankscheme")));
				hshResult.put("strInwardReqAmt",String.valueOf(Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt")))+
						Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt")))+
						Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt")))));
				
				if(Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("P"))
				{
					if(rs5!=null)
					rs5.close();
					rs5 = DBUtils.executeLAPSQuery("getappamt^" + Helper.correctNull(rs.getString("APP_PARENT_APPNO")));
					if(rs5.next())
					{
						hshResult.put("loan_reqterms_ex", correctNull(rs5.getString("loan_reqterms")));
					}
					
					if(rs5!=null)
					rs5.close();
					rs5 = DBUtils.executeLAPSQuery("cnt_post_sanction_appl^" + Helper.correctNull(rs.getString("APP_PARENT_APPNO")));
					if(rs5.next())
					{
						hshResult.put("strAppCount", correctNull(rs5.getString("appno")));
					}
					
					if(rs5!=null)
					rs5.close();
					strQuery=SQLParser.getSqlQuery("selloanagainstparams^119','120");
					rs5 = DBUtils.executeQuery(strQuery);
					while(rs5.next())
					{
						if(Helper.correctNull(rs5.getString("LOAN_PARAMSLNO")).equalsIgnoreCase("119"))
							hshResult.put("strAppMaxCount", correctNull(rs5.getString("LOAN_PARAMVAL")));
						else if(Helper.correctNull(rs5.getString("LOAN_PARAMSLNO")).equalsIgnoreCase("120"))
							hshResult.put("strMaxMoratorium", correctNull(rs5.getString("LOAN_PARAMVAL")));
					}
					
					if(rs5!=null)
					rs5.close();
					rs5 = DBUtils.executeLAPSQuery("getloansecure_renew^" + Helper.correctNull(rs.getString("APP_PARENT_APPNO")));
					if(rs5.next())
					{
						hshResult.put("loan_moratorium_ex", correctNull(rs5.getString("loan_noofinstallment")));
					}
				}
				if(!Helper.correctNull(rs.getString("inward_nsdlrefno")).equalsIgnoreCase(""))
				{
					hshResult.put("strNSDLFlag","Y");
				}
				
				hshResult.put("strNSDLRefNo",Helper.correctNull(rs.getString("inward_nsdlrefno")));
				
				if(Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("R")||Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("P"))
				{
					if(rs5!=null)
						rs5.close();
						rs5 = DBUtils.executeLAPSQuery("comfunsel1^" + Helper.correctNull(rs.getString("APP_PARENT_APPNO")));
						if(rs5.next())
						{
							hshResult.put("exstrCBSAccNo", correctNull(rs5.getString("cbs_accountno")));
						}
				}
					
			}
			}
			if(strinternet_app.equalsIgnoreCase("Y")){
				hshResult.put("internetappln","Y");
			}else{
				hshResult.put("internetappln","N");
			}
			
			if(recordflag)
				hshResult.put("recordflag","Y");
			else
				hshResult.put("recordflag","N");
			if(rs!=null)
			{
				rs.close();
			}
			if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
			{
			/* Commented by Arsath for performance tuning
			 * Put New Query only for below two fields
			 * */	
			//rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset^"+ strApplicationNo);	
			rs=DBUtils.executeLAPSQuery("sel_per_house_proposed_asset_new^"+ strApplicationNo);		
			if (rs.next()) 
			{
				hshResult.put("phpa_loan_purpose",correctNull(rs.getString("phpa_loan_purpose")));
				hshResult.put("phpa_project_finance",correctNull(rs.getString("phpa_project_finance")));
			}
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			/* Added by Arsath for Performance Tunings
			 * Samething inserted into pergetloanproducts
			 * 
			 * */
			//rs = DBUtils.executeLAPSQuery("sel_clpucpcdate^"+strApplicationNo);
			/*
			if (!strApplicationNo.equalsIgnoreCase("") && !strApplicationNo.equalsIgnoreCase("new"))
			{
			rs=DBUtils.executeLAPSQuery("sel_clpucpcdate^"+strApplicationNo);
			if (rs.next())
			{
				hshResult.put("receiptclpu", Helper.correctNull((String)rs.getString("app_clpudate")));
				hshResult.put("receiptcpc",Helper.correctNull((String)rs.getString("app_cpcdate")));
				
			}
			}
			
			if (rs != null)
			{
				rs.close();
			}
			*/


			// done for credit scoring by rajesh on  22/12/2013
			String strQry="where CRE_APPNO='"+strApplicationNo+"'";
			strQuery = SQLParser.getSqlQuery("selcreditscoring^"+strQry);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshResult.put("cre_freeze", Helper.correctNull((String)rs.getString("cre_freeze")));
							
			}
			
			if (rs != null)
			{
				rs.close();
			}

			/* 
			 * Commented by Arsath for quick access
			 * Same thing put into pergetloanproduct query
			 * 
			if(!strPrdCode.equals(""))
			{
				rs=DBUtils.executeLAPSQuery("selLoanPurpose^"+strPrdCode);
				if (rs.next())
				{
					hshResult.put("prd_purpose", Helper.correctNull((String)rs.getString("prd_purpose")));
					
				}
				if (rs != null)
				{
					rs.close();
				}
			}
			*/			
			String str_orgcode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			rs=DBUtils.executeLAPSQuery("sel_orglevel^"+str_orgcode);
			if(rs.next())
			{
				hshResult.put("hshorglevel", Helper.correctNull((String)rs.getString("org_level")));
				hshResult.put("hshorgcode", Helper.correctNull((String)rs.getString("org_code")));
			}
			if(rs!=null)
			{
				rs.close();
			}

			rs=DBUtils.executeLAPSQuery("getbusidbyproduct^"+strApplicationNo);
			if(rs.next())
			{
				hshResult.put("bus_id", Helper.correctNull((String)rs.getString("BUSS_BUSSID")));
			}
			if(rs!=null)
				rs.close();
			
			rs=DBUtils.executeLAPSQuery("sel_emiornot^"+strApplicationNo);
			if(rs.next())
			{
				//hshResult.put("inwardcreatedate", Helper.correctNull((String)rs.getString("inward_createdon")));
				hshResult.put("loan_receivedate", Helper.correctNull((String)rs.getString("loan_receivedate")));
			}
			
			if(rs!=null) rs.close();
			String strQuery21 = SQLParser.getSqlQuery("getprofilestatusfromdemographic^"+strAppid);
			rs = DBUtils.executeQuery(strQuery21);
			if(rs.next())
			{
				hshResult.put("inward_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshResult.put("strCBSID",Helper.correctNull((String)rs.getString("perapp_cbsid")));
			}
			
			if(rs!=null) rs.close();
			if(!strPrdCode.equalsIgnoreCase(""))
			{
				strQuery21 = SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery21);
				if(rs.next())
				{
					hshResult.put("prd_maxageofvehicle", Helper.correctNull((String)rs.getString("prd_maxageofvehicle")));
				}
			
				if(rs!=null) rs.close();
				strQuery21 = SQLParser.getSqlQuery("sel_staffprd^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery21);
				if(rs.next())
				{
					hshResult.put("staff_under", Helper.correctNull((String)rs.getString("staff_under")));
				}
			}
			
			if(rs!=null) rs.close();
			int strFreezecount=0;
		   	String strFreezeflag="N";
		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			hshResult.put("strSecFreezeflag",strFreezeflag);
			hshResult.put("strPrdFlag",strPrdFlag);
			
			arrRow=new ArrayList();
			if(strAction.equalsIgnoreCase("postsanction"))
			{
				if(rs!=null) rs.close();
				strQuery = SQLParser.getSqlQuery("sel_postsancdetails^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));
					arrCol.add(Helper.correctNull(rs.getString("ps_old_app_no")));
					arrCol.add(Helper.correctNull(rs.getString("cat_name")));
					arrCol.add(Helper.correctNull(rs.getString("prdsubcat")));
					arrCol.add(Helper.correctNull(rs.getString("loan_recmdamt")));
					arrCol.add("");
					arrCol.add("1");
					arrCol.add(strApplicationNo);
					arrCol.add(Helper.correctNull(rs.getString("PRD_STAFFPRD")));//8
					arrCol.add(Helper.correctNull(rs.getString("PRD_TYPE")));//9
					
					if(rsPS!=null) rsPS.close();
					strQuery = SQLParser.getSqlQuery("sel_oldfac_processdate_PS^" +strApplicationNo+"^1");
					rsPS = DBUtils.executeQuery(strQuery);
					if(rsPS.next())
					{
						if(Integer.parseInt(Helper.correctInt(rsPS.getString("dayval")))<0)
						{
							if(Helper.correctNull(rs.getString("LOAN_INTTYPE")).equalsIgnoreCase("Fixed"))
								arrCol.add("");//10
							else
								arrCol.add("Y");//10	
						}
						else
						{
							arrCol.add("");//10
						}
					}
					else
					{
						arrCol.add("");//10
					}
					
					if(Helper.correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("TL")||Helper.correctNull(rs.getString("prd_loantype")).equalsIgnoreCase("DL"))
						arrCol.add("Y");
					else
						arrCol.add("N");
					
					if(Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODGEN")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("DGDQ")||
							Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODPSA")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODPS")
							||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODAG")||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODSEC")
							||Helper.correctNull(rs.getString("scheme_code")).equalsIgnoreCase("ODSECPS"))
						arrCol.add("Y");
					else
						arrCol.add("N");
					
					arrRow.add(arrCol);
				}
			}
			hshResult.put("arrFacRow",arrRow);
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("takeoversel^"+ strApplicationNo);			 
			if(rs.next()) 
			{
				hshResult.put("TakeOverAvailFlag","Y");
			}
			else
			{
				hshResult.put("TakeOverAvailFlag","N");
			}
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("strModifyterms", "@"+Helper.correctNull(rs.getString("ps_modify_terms")));
			}
			
			if(strPrdType.equalsIgnoreCase("pR"))
			{
				if(rs!=null) rs.close();
				strQuery = SQLParser.getSqlQuery("sel_loanagainstdeposit^"+strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("loan_banktype")).equalsIgnoreCase("2"))
					{
						hshResult.put("strOtherDepFlag", "Y");
						continue;
					}
				}
			}
			
			if(rs!=null)
				rs.close();
			
			strQuery=SQLParser.getSqlQuery("selLoanType^"+strApplicationNo);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("appraisalFlag","Y");
			}
			
			double dblMarketRate = 0,dblBankRate=0;
			
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selgoldratevalue");
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				dblMarketRate=Double.parseDouble(Helper.correctDouble(rs.getString("per_goldrate")));
 				dblBankRate=Double.parseDouble(Helper.correctDouble(rs.getString("per_avg_rate")));
 			}

 			if(rs!=null)
 				rs.close();
 			strQuery=SQLParser.getSqlQuery("sel_goldloandate^"+strApplicationNo);
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				strCreateDate=Helper.correctNull(rs.getString("agr_date"));
 			}
 			
			if(appstatus.equalsIgnoreCase("OP") && strPrdType.equalsIgnoreCase("pG") && strGLdate.equalsIgnoreCase("Y") && !strCreateDate.equals(Helper.getCurrentDateTime()))
			{
				int sizeval=1;
				hshQueryValues2 = new HashMap();
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","sel_ins_gold_details");
				arrValues.add(String.valueOf(dblMarketRate));
				arrValues.add(String.valueOf(dblBankRate));
				arrValues.add(String.valueOf(dblMarketRate));
				arrValues.add(String.valueOf(dblBankRate));
				arrValues.add(String.valueOf(dblBankRate));
				arrValues.add(String.valueOf(dblMarketRate));
				arrValues.add(strApplicationNo);
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);
				
				sizeval++;				
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","delete_golddet_withdate");
				arrValues.add(strApplicationNo);
				hshQuery2.put("strAppendString","< to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'))");
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);

				sizeval++;
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","del_date");
				arrValues.add(strApplicationNo);
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);
				
				sizeval++;
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","del_misappdetails");
				arrValues.add(strApplicationNo);
				arrValues.add("1");
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);
				
				
				MISLogger.UpdateLogger("MISappdetails table delete ==="+hshQuery2);
				
				sizeval++;
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strApplicationNo);
				arrValues.add("1");
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);
				
				MISLogger.UpdateLogger("misappdisplayscreen table delete ==="+hshQuery2);
				
				sizeval++;
				hshQuery2=new HashMap();
				arrValues=new ArrayList();
				hshQuery2.put("strQueryId","del_misappclassification");
				arrValues.add(strApplicationNo);
				arrValues.add("1");
				hshQuery2.put("arrValues",arrValues);
				hshQueryValues2.put(String.valueOf(sizeval),hshQuery2);
				
				MISLogger.UpdateLogger("misappclassification table delete ==="+hshQuery2);
				
				hshQueryValues2.put("size", String.valueOf(sizeval));
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues2, "updateData");
				
				hshResult.put("AlertForGL", "Y");
			}
			
			if(strPrdType.equalsIgnoreCase("pG") && strExcelFlag.equalsIgnoreCase("Y") && appstatus.equalsIgnoreCase("OP") && (Helper.correctNull((String)hshResult.get("cloanprd"))).equalsIgnoreCase(""))
			{
				double dblcostofproj=0.0;
				if(rs!=null)
	 				rs.close();
	 			strQuery=SQLParser.getSqlQuery("selgolddetailstotal^"+strApplicationNo);
	 			rs = DBUtils.executeQuery(strQuery);
	 			if(rs.next())
	 			{
	 				//dblcostofproj=Double.parseDouble(Helper.correctDouble(rs.getString("estimatevalue")));  // commented because of wrong alias name in rs.getstring
	 				dblcostofproj=Double.parseDouble(Helper.correctDouble(rs.getString("agr_artnetwttotal")));
	 			}
	 			
				agrotherBean ag=new agrotherBean();
				ag.updateSecurityValue(strApplicationNo, dblcostofproj);
				hshResult.put("cloanprd",String.valueOf(dblcostofproj));
				
			}
			
			if(rs!=null)
 				rs.close();
 			strQuery=SQLParser.getSqlQuery("sel_restracc^"+strApplicationNo);
 			rs = DBUtils.executeQuery(strQuery);
 			if(rs.next())
 			{
 				hshResult.put("strRestrFrom",Helper.correctNull((String)rs.getString("APP_EXAPPCBSACCNO")));
 			}
 			
 			if(Helper.correctNull((String)hshValues.get("appProposalType")).equalsIgnoreCase("R"))
			{
				if(rs!=null) rs.close();
				strQuery = SQLParser.getSqlQuery("sel_product_availability^" + strPrdCode);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(Double.parseDouble(Helper.correctDouble(rs.getString("datediff")))< 0 || Helper.correctNull(rs.getString("prd_stop")).equals("y"))
						hshResult.put("strReselectprd","Y");
				}
			}
 			//Processing fee deviation check
 			if (rs != null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("Sel_app_deviation1^" + strApplicationNo+"^PF");
			rs = DBUtils.executeQuery(strQuery1);
			if (rs.next()) 
			{
				if(Helper.correctNull(rs.getString("deviation_apprej")).equalsIgnoreCase("A"))
				{
					hshResult.put("procfeenew", Helper.checkDecimal(Helper.correctDouble(rs.getString("deviation_newvalue"))));
				}
				hshResult.put("procfeeDevFlag", Helper.correctNull(rs.getString("deviation_apprej")) );
			}
			
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_cg_paramval");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("loan_paramval",Helper.correctNull((String)rs.getString("loan_paramval")));
			}
			if (rs != null)
				rs.close();
			
			
			strQuery = SQLParser.getSqlQuery("sel_laps_cg_parms");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("loan_paramval_sub",Helper.correctNull((String)rs.getString("loan_paramval")));
			}
			if (rs != null)
				rs.close();
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_PMAY_desc^"+ strApplicationNo);			 
			if(rs.next()) 
			{
				hshResult.put("strPMAYDet","Y");
			}
			else
			{
				hshResult.put("strPMAYDet","N");
			}
			
		// for cgtmse check	
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_per_CGTMSE^"+ strApplicationNo);
			if(rs.next())
			{	
				hshResult.put("ApplicationExist","Y");
			}
			else
			{
				hshResult.put("ApplicationExist","N");
			}	
			//Loan against share check
			{
				
				double dblDematAmt=0.0,dblPhysicalShareAmt=0.0;
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_otherbanksharelimit^"+strOldid);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("PERBANK_LOANPURPOSE")).equalsIgnoreCase("4"))
						dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
					else if(Helper.correctNull(rs.getString("PERBANK_LOANPURPOSE")).equalsIgnoreCase("5"))
						dblDematAmt +=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
				}
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sum_retailloanagainstshare^"+strOldid);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("PRD_SHARETYPE")).equalsIgnoreCase("P"))
						dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
					else if(Helper.correctNull(rs.getString("PRD_SHARETYPE")).equalsIgnoreCase("D"))
						dblDematAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
				}
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sum_corpagriloanagainstshare^"+strOldid);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("com_sharetype")).equalsIgnoreCase("P"))
						dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
					else if(Helper.correctNull(rs.getString("com_sharetype")).equalsIgnoreCase("D"))
						dblDematAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
				}
				
				double dblPhysicalShareLimit=0.0,dblDematshareLimit=0.0;
				strQuery = SQLParser.getSqlQuery("selloanagainstparams^113','114");
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("113"))
						dblPhysicalShareLimit=Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")));
					if(Helper.correctNull(rs.getString("loan_paramslno")).equalsIgnoreCase("114"))
						dblDematshareLimit=Double.parseDouble(Helper.correctDouble(rs.getString("loan_paramval")));
				}
				
				if(dblPhysicalShareAmt>dblPhysicalShareLimit)
				{
					hshResult.put("strPhyLimitExceeds","Y");
				}
				if(dblDematAmt>dblDematshareLimit)
				{
					hshResult.put("strDematLimitExceeds","Y");
				}
				
				hshResult.put("strDematLimitAvailed",jtn.format(dblDematAmt));
				hshResult.put("strPhyLimitAvailed",jtn.format(dblPhysicalShareAmt));
				hshResult.put("strDematLimit",jtn.format(dblDematshareLimit));
				hshResult.put("strPhyLimit",jtn.format(dblPhysicalShareLimit));
				
			}
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_querystatus^"+strApplicationNo);
			if(rs.next())
			{
				if(Integer.parseInt(Helper.correctInt(rs.getString("cnt")))>0)
					hshResult.put("Query_Status", "No");
			}
			//CIBIL&CRIF Details
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("select_cuscibildetails^"+strAppid);
			if(rs.next())
			{
				hshResult.put("strCIBILDetails", Helper.correctInt(rs.getString("cibil_rat_status")).trim()+"~"+Helper.correctInt(rs.getString("cibil_score")).trim());	
				hshResult.put("strCRIFDetails", Helper.correctInt(rs.getString("CRIF_REFERED")).trim()+"~"+Helper.correctInt(rs.getString("CRIF_SCORE")).trim());	
			}
			
			
			//digi max emi calculation
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("getemiinfo^"+strApplicationNo);
			if(rs.next())
			{
				hshResult.put("strLOAN_DIGI_MAXEMI", Helper.correctNull(rs.getString("LOAN_DIGI_MAXEMI")));	
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
			
			String userClass="";
	  		strQuery = SQLParser.getSqlQuery("selectusername^"+ strUserId);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				userClass=Helper.correctNull((String)rs.getString("USR_CLASS"));	
			}
			hshResult.put("userClass",userClass);
			
			String subLoanType="",STRLOANUPDROIFLAG="",Strroiupddate="";
	  		strQuery = SQLParser.getSqlQuery("seldigiprd_appl^"+ strApplicationNo);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				subLoanType=Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));	
			}
			hshResult.put("subLoanType",subLoanType);
			
			strQuery = SQLParser.getSqlQuery("sel_roiUpdate_mclrdate^"+ strApplicationNo);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				STRLOANUPDROIFLAG=Helper.correctNull((String)rs.getString("LOAN_UPDROI_FLAG"));
				Strroiupddate = Helper.correctNull(rs.getString("LOAN_UPDROI_DATE"));//LOAN_UPDROI_DATE
				
				
				String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());

				if(Strroiupddate.equalsIgnoreCase(NOwCalender))
				{
					hshResult.put("ROIDATECHECK","Y");
				}
			}
			hshResult.put("STRLOANUPDROIFLAG",STRLOANUPDROIFLAG);
					
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("selborrowerdet_company^"+strAppid);
			if(rs.next())
			{
				hshResult.put("cominfo_total_employees", Helper.correctInt(rs.getString("cominfo_total_employees")));	
			}
			strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
				hshValues.put("strAppCreatedOrg",Helper.correctNull(rs.getString("APP_ORGLEVEL")));
				//hshValues.put("APP_LOANSUBTYPE_DIGI",Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
				hshResult.put("APP_LOANSUBTYPE_DIGI",Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));

			}
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_digi_rate_score^"+strApplicationNo);
			if(rs.next())
			{				
				hshResult.put("DigiRating", "Exist");		
			}
			

			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("seleligibileconst^"+strApplicationNo);
			if(rs.next())
			{	
				hshResult.put("perapp_constitution", correctNull(rs.getString("perapp_constitution")));
			}
		
			
			//added by Sunil
			if(rs!=null)
				rs.close();
		
		strQuery=SQLParser.getSqlQuery("sel_doc_branchdet^"+strApplicationNo);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{				
			hshResult.put("DIGI_DEVIATION_ROI_CONC",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_CONC")));	
			hshResult.put("DIGI_DEVIATION_ROI_PENALTY",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_PENALTY")));
		}
		
		// Concession description,  loandetails table, DIGI_DEVIATION_ROI_CONDESC   column
		
		if(rs!=null)
			rs.close();
		
		strQuery=SQLParser.getSqlQuery("Sel_roi_details_Condesc^"+strApplicationNo);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshResult.put("DIGI_DEVIATION_ROI_CONDESC",correctNull((String)rs.getString("DIGI_DEVIATION_ROI_CONDESC")));
		}
		
		
		if(rs!=null)
			rs.close();
		String staffproduct="",strPrdcode="";
		ArrayList arrayCol = new ArrayList();
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		//rs = DBUtils.executeLAPSQuery("selloan_details^" + strApplicationNo);
		//if (rs.next()) {
		//	staffproduct = correctNull(rs.getString("prd_staffprd"));
			
		//}
		//hshResult.put("staffproduct",staffproduct );
		
		
		strQuery = SQLParser.getSqlQuery("sel_branchname^"+ strApplicationNo);
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
			hshResult.put("arrROI", arrROI);
		
		}
				
		String strIntType="",strPassCode="",strProdPurpose="",strVehicleType="";
		strQuery = SQLParser.getSqlQuery("selLoanAmt^" + strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if (rs.next()) {
		
			 strIntType= Helper.correctNull(rs.getString("loan_inttype"));
		}
		hshResult.put("strIntType", strIntType);
		
		strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
		strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));
		}
		
		if (strProdPurpose.equalsIgnoreCase("H")|| strProdPurpose.equalsIgnoreCase("U")|| strVehicleType.equalsIgnoreCase("2")) {
			strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^"+ strApplicationNo);
		} else {
			strQuery = SQLParser.getSqlQuery("pergetloanProduct^"+ strApplicationNo);
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
						hshResult.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%" + "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Bussiness strategic Premium)"
							+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
					}else{
						hshResult.put("ROI",strTemp+ "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_creditrskval"))))+"%"+ "(Credit Risk Premium)" + "+"+ nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_busstatval"))))+"%" +"(Fixed Spread)"
								+ " presently at "+ Double.parseDouble(Helper.correctDouble(rs.getString("mintrate"))));
					}
						
				} else {
					hshResult.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
				}

			} else {
				hshResult.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
			}

		} else {
			hshResult.put("ROI", Helper.checkDecimal(Helper.correctDouble((String) rs.getString("mintrate"))));
		}
		
		}
		
			//end
		
		
		
		// check post sanction parameter enable/disable starts
		 String livedate=ApplicationParams.getStrPostSancEnabDisablelivedate();
			String modofpaymentflag="";
			String applicationStatus="";
			// check when application is created
			String appcreatedate="";
			if(strApplicationNo.equalsIgnoreCase("NEW")){
				modofpaymentflag="NEW";  // new application created on live date or  after live date,Mode of Payment has to come,NEW - New one
			}else{
				strQuery = SQLParser.getSqlQuery("getcreatedate^"+strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					appcreatedate= rs.getString("createddate");
					applicationStatus= rs.getString("APP_STATUS");
				}
				System.out.println("Application created date-->"+appcreatedate);
			System.out.println("Post Sanction  Live Date-->"+livedate);
		       if(!livedate.equalsIgnoreCase("") && !appcreatedate.equalsIgnoreCase("")){
				 String Pattern="dd/MM/yyyy";
					DateFormat df=new SimpleDateFormat(Pattern);
					Date appcreationdate=df.parse(appcreatedate);
					Date postsanclivedate=df.parse(livedate);
					if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("op"))
					{
						modofpaymentflag="EOP";  // existing old open/pending application,Mode of Payment must come infront end,EOP - exiting open pending
					}
					if(appcreationdate.before(postsanclivedate) && applicationStatus.equalsIgnoreCase("pa"))
					{
						modofpaymentflag="EPA"; // existing old approved application,Mode of Payment should not come,EPA - existing process approved/undo
					}
					if(appcreationdate.equals(postsanclivedate) || appcreationdate.after(postsanclivedate))
					{
						modofpaymentflag="NEW";    // new application created on live date or  after live date,Mode of Payment has to come,NEW - New one
					}
		       }
			}
			
	       hshResult.put("modofpaymentflag", modofpaymentflag);
	       System.out.println("mode of payment Flag for gold/deposit loan-->"+modofpaymentflag);
	       
		   	if(rs!=null)
				rs.close();
		
		strQuery=SQLParser.getSqlQuery("sel_cbsaccno^"+strApplicationNo);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{				
			hshResult.put("app_enchflag",correctNull((String)rs.getString("app_enchflag")));	
			hshResult.put("app_enachdate",correctNull((String)rs.getString("app_enachdate")));	
		}
	    // ends
			
	       if(rs!=null){
				rs.close();
			}
			String retrestructureval="N";
			strQuery = SQLParser.getSqlQuery("sel_ret_tab_validation^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				retrestructureval="Y";
				
			}
			hshResult.put("retrestructureval",retrestructureval);
			 if(rs!=null){
					rs.close();
				}
			
			rs=DBUtils.executeLAPSQuery("sel_ahp_details^"+ strApplicationNo);			 
			if(rs.next()) 
			{
				hshResult.put("strAHPDet","Y");
			}
			else
			{
				hshResult.put("strAHPDet","N");
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("comfunsel1^" + strApplicationNo);
			if (rs.next()){
				
				hshResult.put("appRenewprop", Helper.correctNull(rs.getString("app_renew_flag")));
				
				if(Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("P")){
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeLAPSQuery("sel_parentDigiStatus^" + strApplicationNo);
					if (rs1.next()){
						hshResult.put("apppostparentdigi", "Y");
					}
				}
			}
			
			if(rs!=null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("sel_inward_proposed_values^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery1);
			
			if(rs.next())
			{
				hshResult.put("digiappno",Helper.correctNull(rs.getString("INWARD_DIGIAPPNO")));
			}
			
			
			 if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("selupdateROIInFInancle^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshResult.put("Loan_Sanct_Eff_ROI",Helper.correctNull((String)rs.getString("Loan_Sanct_Eff_ROI")));
					hshResult.put("Loan_Applicable_ROI",Helper.correctNull((String)rs.getString("Loan_Applicable_ROI")));
					hshResult.put("Loan_Proposed_ROI",Helper.correctNull((String)rs.getString("Loan_Proposed_ROI")));
				}
				
				
				
				 hshQueryValueschk=new HashMap();
				 hshQuerychk = new HashMap();
				 arrValuechk=new ArrayList();
				
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("selpostsanroiselection^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					roiflag=Helper.correctNull((String)rs.getString("PS_MODIFY_TERMS"));
					if(roiflag.contains("MRI"))
					{
						hshValues.put("roiflagval","S");
					}
					
				}
				
				if(strAction.equalsIgnoreCase("postsanction") && Helper.correctNull((String)hshValues.get("roiflagval")).equalsIgnoreCase("S"))
				{
					strQuery1 = SQLParser.getSqlQuery("selretduedate^" + strApplicationNo);
					rs = DBUtils.executeQuery(strQuery1);
					
					if(rs.next())
					{
						loan_modintrateold=String.valueOf(Double.parseDouble(Helper.correctNull(rs.getString("loan_modintrate"))));
					}
					
					hshQueryValueschk=new HashMap();
					hshQuerychk = new HashMap();
					arrValuechk=new ArrayList();
					arrValuechk.add(loan_modintrateold);
					arrValuechk.add(strApplicationNo);
					hshQuerychk.put("strQueryId","updateROIInFInancleoldroi"); 
					hshQuerychk.put("arrValues",arrValuechk);
					hshQueryValueschk.put("size","1");
					hshQueryValueschk.put("1",hshQuerychk);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValueschk,"updateData");
					
					hshResult.put("loan_modintrateold", loan_modintrateold);
				}
				//vindhya begin PAN check
				
				double dblchecklimit = 0.0;
				 double dblchecklimit3 = 0.0;
				 String strQuery11="";
				 String strQuery12="";
				 
					 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^135");
						rs = DBUtils.executeQuery(strQuery11);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
				
						hshResult.put("strChecklimit", jtn.format(dblchecklimit));
						double dblExplimit = 0.0;
						String sessionModuleType = correctNull((String) hshValues.get("sessionModuleType"));
						if (!sessionModuleType.equalsIgnoreCase("AGR")) {
							
							dblExplimit = getExposureTotalLimit(strAppno, "R",sessionModuleType);

							hshResult.put("strdblExplimit", jtn.format(dblExplimit));
							//if (dblExplimit >= 50000)
							if (dblExplimit>= dblchecklimit)
								hshResult.put("strExplimitchk", "F");
							else
								hshResult.put("strExplimitchk", "S");			
							
						}
				 String strPanCheck="";
				 if (rs != null)
						rs.close();

					strQuery = SQLParser
							.getSqlQuery("sel_lapsapplicationparameters^132"); 
					rs = DBUtils.executeQuery(strQuery);					
					
					if (rs.next()) {
						strPanCheck = Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
						hshResult.put("strPanCheck", strPanCheck);
					}
					if (rs != null)
						rs.close();
					int pancount=0;
					strAppno = correctNull((String)hshValues.get("appno"));
					strQuery = SQLParser.getSqlQuery("getapplicantPAN^" + strAppno+"^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next()) {
						if ((correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("") || correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("NOPAN")))
								{
									pancount++;
								}
						if(pancount>0)
						{
							hshResult.put("Pancount", "N");
						}
						else
							hshResult.put("Pancount", "Y");
						
					}
					String strFreeze="";
			  		if(rs!=null) rs.close();
			  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
		    		rs = DBUtils.executeQuery(strQuery);
					if(rs.next()) 
					{
						strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
					}
					hshRecord.put("strFreeze",strFreeze);
				//vindhya begin PAN check	
				
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getLoanProducts" + ce.getMessage());
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
		return hshResult;
	}

	public HashMap interfaceSanctionDetails(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		try
		{
			EJBInvoker.executeStateLess("FinacleBean", hshValues, "SanctionDetails");
		}
		catch (Exception e)
		{
			throw new EJBException(e.toString());
		}
		return hshRecord;
	}

	public HashMap calculateAmortization(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		int i = 1;
		int intMoratorium=0;
		double dblInterest = 0.0;
		double dblPrincipal = 0.0;
		double dblloans = 0.0;
		double dblEMI = 0.0;
		double dblDenomi = 0.0;
		double dblNumeri = 0.0;
		double dblRate = 0.0;
		double dblActualAmtDue = 0.0;
		double dblTotalInterest = 0.0;
		double dblTotalEMI = 0.0;
		double dblTotalPrincipal = 0.0;
		double dblModIntRate = 0.0;
		int intTerms,intRepayMonths = 0;
		double dblRecAmount = 0.0;
		String bool = "false";
		String emdate = "";

		String strrepaymenttype = correctNull((String) hshValues.get("hidrepaymenttype"));
		emdate = correctNull((String) hshValues.get("emidate"));

		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		String strperidicity = correctNull((String)hshValues.get("peridicity"));
		if(strperidicity.equalsIgnoreCase(""))
		{
			strperidicity="m";
		}
		
		try
		{
			if (strrepaymenttype.equals("repay"))
			{
				String strstartterms = correctNull((String) hshValues.get("hidstartterms"));
				dblModIntRate = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txtloan_modintrate")));
				intTerms = Integer.parseInt(Helper.correctInt((String) hshValues.get("txtloan_reqterms")));
				dblRecAmount = Double.parseDouble(Helper.correctDouble((String) hshValues.get("txtloan_sancamt")));
				intMoratorium = Integer.parseInt(Helper.correctInt((String) hshValues.get("txt_installments")));				
				intRepayMonths = intTerms - intMoratorium;
				String strAppNo = correctNull((String) hshValues.get("appno"));
				hshResult.put("txtloan_modintrate", Helper.formatDoubleValue(dblModIntRate));
				hshResult.put("txtloan_reqterms", Integer.toString(intTerms));
				hshResult.put("txtloan_RepayMonths", Integer.toString(intRepayMonths));
				hshResult.put("txtloan_sancamt", Helper.formatDoubleValue(dblRecAmount));
				hshResult.put("txt_installments", Integer.toString(intMoratorium));
				hshResult.put("appno", correctNull(strAppNo));
				
				intTerms = intRepayMonths;
				rs = DBUtils.executeLAPSQuery("selamortization^" + strAppNo);
				while (rs.next())
				{
					double dblTemp = 0.00;
					double dblActualInt = 0.00;
					double dblActualPrincipal = 0.00;
					double dblTotalAmount = 0.00;

					bool = "true";
					arryCol = new ArrayList();
					dblTemp = Double.parseDouble((String) (rs.getString("amort_terms")));
					arryCol.add(new Double(dc.format(dblTemp)));
					dblTemp = Double.parseDouble((String) (rs.getString("amort_orginalamountos")));
					arryCol.add(new Double(dc.format(dblTemp)));
					dblActualInt = Double.parseDouble((String) (rs.getString("amort_actualinterest")));
					arryCol.add(new Double(dc.format(dblActualInt)));
					dblTemp = Double.parseDouble((String) (rs.getString("amort_orginalinterest")));
					arryCol.add(new Double(dc.format(dblTemp)));
					dblActualPrincipal = Double.parseDouble((String) (rs.getString("amort_actualprincipal")));
					arryCol.add(new Double(dc.format(dblActualPrincipal)));
					dblTemp = Double.parseDouble((String) (rs.getString("amort_orginalprincipal")));
					arryCol.add(new Double(dc.format(dblTemp)));
					dblTotalAmount = dblActualInt + dblActualPrincipal;
					arryCol.add(new Double(dc.format(dblTotalAmount)));
					dblTemp = Double.parseDouble((String) (rs.getString("amort_actualamountos")));
					arryCol.add(new Double(dc.format(dblTemp)));

					arryRow.add(arryCol);
				}
				if (bool.equals("false"))
				{
					dblRate = dblModIntRate / (12 * 100);
					
					dblDenomi = Math.pow(dblRate + 1, intTerms) - 1;

					dblNumeri = dblRate * Math.pow(dblRate + 1, intTerms);

					if(dblDenomi!=0.0)
					{
						dblEMI = (dblNumeri / dblDenomi) * dblRecAmount;
					}
					else
						dblEMI=0.0;

					dblPrincipal = dblEMI - (dblRecAmount * dblRate);
					if(dblPrincipal<0)
						dblPrincipal=0.0;

					dblInterest = dblRecAmount * dblRate;

					dblActualAmtDue = dblRecAmount - dblPrincipal;

					dblTotalEMI = dblEMI * intTerms;

					arryCol = new ArrayList();
					arryCol.add(new Integer(i));
					arryCol.add(new Double(dc.format(dblRecAmount)));
					arryCol.add(new Double(dc.format(dblInterest)));
					arryCol.add(new Double(dc.format(dblInterest)));
					dblTotalInterest = dblInterest;
					arryCol.add(new Double(dc.format(dblPrincipal)));
					arryCol.add(new Double(dc.format(dblPrincipal)));
					dblTotalPrincipal = dblPrincipal;
					double tempTot = dblPrincipal + dblInterest;
					arryCol.add(new Double(dc.format(tempTot)));
					// arryCol.add(new Double(dc.format(dblEMI)));
					arryCol.add(new Double(dc.format(dblActualAmtDue)));
					arryRow.add(arryCol);

					// i=i+1;

					while (i <= intTerms)
					{
						arryCol = new ArrayList();
						arryCol.add(new Integer(i));
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryCol.add(new Double(dc.format(dblInterest)));
						dblInterest = dblActualAmtDue * dblRate;
						arryCol.add(new Double(dc.format(dblInterest)));
						dblTotalInterest = dblTotalInterest + dblInterest;
						dblPrincipal = dblEMI - (dblActualAmtDue * dblRate);
						arryCol.add(new Double(dc.format(dblPrincipal)));
						arryCol.add(new Double(dc.format(dblPrincipal)));
						dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;

						double TotalAmt = dblInterest + dblPrincipal;
						arryCol.add(new Double(dc.format(TotalAmt)));
						dblActualAmtDue = dblActualAmtDue - dblPrincipal;
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryRow.add(arryCol);
						i = i + 1;
					}
				}
				hshResult.put("arryRow", arryRow);
				hshResult.put("hidstartterms", strstartterms);

				if (bool.equals("false"))
				{
					hshResult.put("isDataDb", "true");
				}
				else
				{
					hshResult.put("isDataDb", "true");
				}
			}
			else if (strrepaymenttype.equals("amort"))
			{	
				double dblPendingPayment=0,dblHolidayEMI=0,dblHolidayInterest=0;
				dblModIntRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("modIntRate")));
				String strLockPayment="B",strPendingPaymentMode=correctNull((String)hshValues.get("sel_interestcharge"));
				intTerms = Integer.parseInt(Helper.correctInt((String) hshValues.get("terms")));
				int intHolidayPeriod = Integer.parseInt(Helper.correctInt((String)hshValues.get("terms2")));
				dblRecAmount=Double.parseDouble(Helper.correctDouble((String)hshValues.get("recmdAmt")));
				double dblTenor=intTerms-intHolidayPeriod;
				String txtmonPayamor=correctNull((String)hshValues.get("txtmonPay"));
				hshResult.put("txtmonPayamor",txtmonPayamor);
				hshResult.put("dblrequested_amount",(correctNull((String)hshValues.get("recmdAmt"))));
				hshResult.put("terms",Integer.toString(intTerms-intHolidayPeriod));
				hshResult.put("loan_noofinstallment",Helper.correctInt((String)hshValues.get("terms3")));
				hshResult.put("inttype",Helper.correctNull((String)hshValues.get("inttype")));
				hshResult.put("cattype",Helper.correctNull((String)hshValues.get("cattype")));
				dblRate=dblModIntRate/(12*100);
				String txt_date = Helper.correctNull((String) hshValues.get("calmonth"));
				hshResult.put("txt_date", txt_date);
				if(strLockPayment.trim().equalsIgnoreCase("I") && strPendingPaymentMode.trim().equals("2"))
				{
					dblDenomi=Math.pow(dblRate+1,(intTerms))-1;	
					dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms));
				}	
				else{
					dblDenomi=Math.pow(dblRate+1,(dblTenor))-1;	
					dblNumeri=dblRate*Math.pow(dblRate+1,(dblTenor));
				}
				
				if(dblNumeri!=0.0 && dblDenomi!=0.0)
				{
					dblEMI=Math.ceil((dblNumeri/dblDenomi)*dblRecAmount);
				}
				/*	dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
				dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
				if(dblNumeri!=0.0 && dblDenomi!=0.0)
				{
				dblEMI=(dblNumeri/dblDenomi)*dblRecAmount;
				}
				dblInterest=(dblRecAmount*dblRate);
				dblloans = dblRecAmount;*/
					
					dblInterest=(dblRecAmount*dblRate); //monthly interest 
					dblloans = dblRecAmount; //loan amount
					double dblInterest_new=0.00;
					double dblActualAmtDue_new=0.00;					
					double dblloans_new=dblRecAmount;
				// Amortization for Holiday Period
				if(!strLockPayment.trim().equalsIgnoreCase("S") && intHolidayPeriod>0)
				{
					while(i<=intHolidayPeriod)
					{
						if(strLockPayment.trim().equalsIgnoreCase("P"))
						{
							arryCol=new ArrayList();
							arryCol.add(new Integer(i));
							i=i+1;
							
							//Lock Only Principal amount. Only interest will be paid.  No change in balance amount and OS Loan amount.
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans;   
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblTotalPrincipal=0.0;
							//dblTotalPrincipal=dblTotalPrincipal+0;
							//dblloans=(dblloans+dblInterest-dblEMI);							
							//dblPendingPayment = dblPendingPayment + dblEMI - dblInterest;
							dblPendingPayment=0.0;
							
							arryCol.add(new Double(dc.format(dblActualAmtDue+dblInterest)));	//Loan Amount OS						
							arryCol.add(new Double(dc.format(dblInterest)));		//Interest Amount
							arryCol.add(new Double(dc.format(0)));					//Principal Amount
							arryCol.add(new Double(dc.format((dblInterest))));		//EMI
							arryCol.add(new Double(dc.format(dblloans)));				//Balance Amount	
							
							arryRow.add(arryCol);
							dblHolidayEMI+=dblInterest;//changes* For toal calculation

						}
						else if(strLockPayment.trim().equalsIgnoreCase("I"))
						{//calamort
							arryCol=new ArrayList();
							arryCol.add(new Integer(i));
							i=i+1;
							
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							//dblloans = dblloans+dblInterest-dblEMI;
							dblloans = dblloans+dblInterest-dblPrincipal;
							
							dblInterest_new=(dblloans_new*dblRate);
							dblActualAmtDue_new=dblloans_new+dblInterest_new;
							dblloans_new = dblloans_new+dblInterest_new-dblPrincipal;
							
							dblPendingPayment = dblPendingPayment + dblInterest_new;
							dblTotalInterest=dblTotalInterest+dblInterest_new;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
							
							arryCol.add(new Double(dc.format(dblActualAmtDue_new)));	//Balance Amount
							arryCol.add(new Double(dc.format(0))); 				//Interest Amount
							arryCol.add(new Double(dc.format(dblPrincipal))); 		//Principal Amount
							arryCol.add(new Double(dc.format((dblPrincipal))));		//EMI
							arryCol.add(new Double(dc.format(dblloans_new)));			//Loan Amount OS
							arryRow.add(arryCol);
							dblHolidayEMI+=dblPrincipal;//changes* For toal calculation*/
						}
						else if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(strPendingPaymentMode.trim().equals("1"))
							{
								//Amortization for regular Customers
								dblRate = dblModIntRate / (12 * 100);
								dblDenomi = Math.pow(dblRate + 1, dblTenor) - 1;
								dblNumeri = dblRate * Math.pow(dblRate + 1, dblTenor);
								dblEMI =Math.ceil( (dblNumeri / dblDenomi) * dblRecAmount);
								dblPrincipal = dblEMI - (dblRecAmount * dblRate);
								dblInterest = dblRecAmount * dblRate;
								dblPrincipal = (dblEMI - dblInterest);
				
				
								dblActualAmtDue = dblRecAmount - dblPrincipal;// change negleted dblEMI by  mohan
								// dblloans = dblActualAmtDue+dblInterest;
				
								dblTotalEMI = dblEMI * dblTenor;
				
								arryCol = new ArrayList();
								arryCol.add(new Integer(i));
								i = i + 1;
								arryCol.add(new Double(dc.format(dblRecAmount)));
								arryCol.add(new Double(dc.format(dblInterest)));
								dblTotalInterest = dblInterest;
								arryCol.add(new Double(dc.format(dblPrincipal)));
								dblTotalPrincipal = dblPrincipal;
								arryCol.add(new Double(dc.format(dblEMI)));
								arryCol.add(new Double(dc.format(dblActualAmtDue)));
								arryRow.add(arryCol);
								while (i <= intTerms)
								{
									arryCol = new ArrayList();
									arryCol.add(new Integer(i));
									i = i + 1;
									// dblActualAmtDue=dblloans;//change emi negleted
									arryCol.add(new Double(dc.format(dblActualAmtDue)));
				
									dblInterest = dblActualAmtDue * dblRate;
				
									arryCol.add(new Double(dc.format(dblInterest)));
				
									dblTotalInterest = dblTotalInterest + dblInterest;
				
									dblPrincipal = (dblEMI - dblInterest);
				
									arryCol.add(new Double(dc.format(dblPrincipal)));
				
									dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
				
									arryCol.add(new Double(dc.format(dblEMI)));
				
									dblActualAmtDue = dblActualAmtDue - dblPrincipal;
				
									dblloans = dblActualAmtDue;
									
									if(dblActualAmtDue<0)
										dblActualAmtDue=0.0;
				
									arryCol.add(new Double(dc.format(dblActualAmtDue)));
				
									arryRow.add(arryCol);
								}
								arryCol = new ArrayList();
								arryCol.add(new String("Total"));
								arryCol.add(new Double(dc.format(dblTotalInterest)));
								arryCol.add(new Double(dc.format(dblTotalPrincipal)));
								arryCol.add(new Double(dc.format(dblTotalEMI)));
								arryRow.add(arryCol);
							}
							else if(strPendingPaymentMode.trim().equals("2"))
							{
								arryCol=new ArrayList();
								arryCol.add(new Integer(i));
								i=i+1;					
											
								// Lock both Interest and Principal
								dblInterest=(dblloans*dblRate);
								dblActualAmtDue=dblloans+dblInterest;
								dblTotalInterest=dblTotalInterest+dblInterest;
								dblPrincipal=0;
								dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
								
								/*
								 * Compound Interest Calculation
								 * During holiday period, Interest added to Principal in each month till repayment
								 */
								dblloans = dblloans + dblInterest;  
								dblPendingPayment = dblPendingPayment + dblInterest;
								if(dblloans<=0)
								{
									dblloans=0.00;
								}							
								arryCol.add(new Double(dc.format(dblActualAmtDue)));	//Balance Amount
								arryCol.add(new Double(dc.format(0)));					//Interest Amount
								arryCol.add(new Double(dc.format(0)));					//Principal Amount
								arryCol.add(new Double(dc.format(0)));					//EMI
								arryCol.add(new Double(dc.format(dblloans)));			//Loan Amount OS
								arryRow.add(arryCol);
							}
							
							
						}
					}
				}
				//Recalculating EMI
				boolean blnPendingPayment = false;
				double dblFirstEMI = 0.0;
				
								
				double dblTotIntPrincLock=0.00;
				if(!strLockPayment.trim().equalsIgnoreCase("S") && intHolidayPeriod>0)
				{
					 if(strPendingPaymentMode.trim().equals("2"))
					{
						//Add pending payments to the Principal and recalculate the EMI
						//commented ---- dblloans = dblloans + dblPendingPayment;
						dblRate=dblModIntRate/(12*100);
						dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
						dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
						//if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=Math.floor((dblNumeri/dblDenomi)*dblloans);
							}
						}/*else
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=dblNumeri/dblDenomi*(dblloans + dblPendingPayment);
							}
						}*/
						dblInterest=((dblloans + dblPendingPayment)*dblRate);
						dblPrincipal=dblEMI-dblInterest;
						//dblActualAmtDue=dblloans + dblInterest;
						dblActualAmtDue=dblloans + dblPendingPayment+ dblInterest;
						dblTotalEMI=(dblEMI*(intTerms-intHolidayPeriod) + dblHolidayEMI);
						
					}	
					else if(strPendingPaymentMode.trim().equals("1"))
					{
						//Add pending payments to the Principal and recalculate the EMI
						//commented ---- dblloans = dblloans + dblPendingPayment;
						dblRate=dblModIntRate/(12*100);
						dblDenomi=Math.pow(dblRate+1,(intTerms-intHolidayPeriod))-1;	
						dblNumeri=dblRate*Math.pow(dblRate+1,(intTerms-intHolidayPeriod));
						
					
						dblloans+=dblPendingPayment;
						//if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=(dblNumeri/dblDenomi*dblloans);
							}
						}/*else
						{
							if(dblNumeri!=0.0 && dblDenomi!=0.0)
							{
								dblEMI=dblNumeri/dblDenomi*(dblloans + dblPendingPayment);
							}
						}*/
						dblInterest=(dblloans*dblRate);
						dblPrincipal=dblEMI-dblInterest;
						//dblActualAmtDue=dblloans + dblInterest;
						dblActualAmtDue=dblloans + dblInterest;
						dblTotalEMI=(dblEMI*(intTerms-intHolidayPeriod) + dblHolidayEMI);
						
					}	
					else
					{
						dblTotalEMI=(dblHolidayEMI);
					}
				}
				int j=0;
				while(i<=(dblTenor+intHolidayPeriod))
				{
					arryCol=new ArrayList();
					arryCol.add(new Integer(i));
					if(blnPendingPayment && j==0)
					{
						
						dblFirstEMI =(dblEMI + dblPendingPayment);
						dblInterest=(dblloans*dblRate);	
						dblTotalInterest=dblTotalInterest+dblInterest;
						
						dblPrincipal=dblEMI-dblInterest;
						dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
						dblActualAmtDue=dblloans+dblInterest;  //Formula: Balance Amt := OS Loan + IR
						if(strLockPayment.trim().equalsIgnoreCase("B"))
						{
							dblloans = dblloans+dblInterest-dblFirstEMI;
						}else if(strLockPayment.trim().equalsIgnoreCase("I"))
						{
							dblloans = dblloans+dblInterest-dblEMI;
						}
						
						dblInterest+=dblPendingPayment;
						if(dblloans<=0)
						{
							dblloans=0.00;
						}	
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryCol.add(new Double(dc.format(dblInterest)));
						arryCol.add(new Double(dc.format(dblPrincipal)));
						arryCol.add(new Double(dc.format((dblFirstEMI))));
						arryCol.add(new Double(dc.format(dblloans)));
						
						dblTotalEMI+=(dblFirstEMI);
					
					}
					else
					{
						//Checking for Last Entry(To Adjust final amount)
						if(i==dblTenor+intHolidayPeriod)
						{
							double dblTempLoans = 0.0;
							dblInterest=(dblloans*dblRate);
							dblActualAmtDue=dblloans+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							dblTempLoans =dblloans+dblInterest-dblEMI;
							
							//Add the balance to the EMI and recalculate
							dblEMI =(dblEMI + dblTempLoans);
							dblPrincipal=dblEMI-dblInterest;
							dblloans = dblloans+dblInterest-dblEMI;
							if(strLockPayment.trim().equalsIgnoreCase("B"))
							{
								dblTotIntPrincLock+=dblInterest+dblPendingPayment;//changes* Total interest calculation
							}else
							{
								dblTotIntPrincLock+=dblInterest;
							}
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
						}
						else
						{
							dblInterest=(dblloans*dblRate);
							dblTotIntPrincLock+=dblInterest;//changes*
							dblActualAmtDue=dblloans+dblInterest;
							dblTotalInterest=dblTotalInterest+dblInterest;
							dblPrincipal=dblEMI-dblInterest;
							dblTotalPrincipal=dblTotalPrincipal+dblPrincipal;
							dblloans = dblloans+dblInterest-dblEMI;
						}
						if(dblloans<=0)
						{
							dblloans=0.00;
						}	
						arryCol.add(new Double(dc.format(dblActualAmtDue)));
						arryCol.add(new Double(dc.format(dblInterest)));
						arryCol.add(new Double(dc.format(dblPrincipal)));
						arryCol.add(new Double(dc.format((dblEMI))));
						arryCol.add(new Double(dc.format(dblloans)));
						/*if( strLockPayment.trim().equalsIgnoreCase("P"))
							dblTotalEMI+=(dblEMI);*/
						dblTotalEMI=(dblTotalPrincipal+dblTotalInterest);
					}
					arryRow.add(arryCol);	
					
					i=i+1;
					j++;
				}
				if(strPendingPaymentMode.trim().equals("2") || strPendingPaymentMode.trim().equals("1"))
				{
					dblTotalInterest=dblTotIntPrincLock;  // for showing total interest when pricipal is locked
				}
				if(!strPendingPaymentMode.trim().equals("1") || intHolidayPeriod==0 )
				{
				arryCol=new ArrayList();
				arryCol.add(new String("Total"));
				
				 if((strLockPayment.trim().equalsIgnoreCase("B"))&&(strPendingPaymentMode.trim().equals("1")))
				{
					 arryCol.add(new Double(dc.format(dblTotalInterest-dblHolidayInterest)));
				}
				else
				{
					arryCol.add(new Double(dc.format(dblTotalInterest)));
				}
				arryCol.add(new Double(dc.format(dblTotalPrincipal)));
				if(strLockPayment.trim().equalsIgnoreCase("P"))
				{
					arryCol.add(new Double(dc.format((dblTotalInterest+dblTotalPrincipal))));
				}else
				{
					arryCol.add(new Double(dc.format((dblTotalEMI))));
				}
				
				arryRow.add(arryCol);
				}
				hshResult.put("arryRow",arryRow);
				hshResult.put("emidate",emdate);
				hshResult.put("totalInterest",dc.format(dblTotalInterest));
				hshResult.put("strperidicity",strperidicity);
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in closing calcAmortization" + e.getMessage());
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
		return hshResult;
	}

	public HashMap calcRepayment1(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();

		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		String strAppNo = "";
		String strStartTerm = "";
		String strEndTerm = "";
		String strIndex = "";
		int intindex = 1;
		int intTotalTerms = 1;
		int i = 0, j = 0;

		double dblTemp = 0.00;

		double dblRate = 0.00;
		double dblRecAmount = 0.00;
		double dblNumerator = 0.00;
		double dblDenominator = 0.00;
		double dblEMI = 0.00;
		double dblOriginalOSAmt = 0.00;
		double dblActualIntAmt = 0.00;
		double dblOriginalIntAmt = 0.00;
		double dblDiffIntAmtOS = 0.00;
		double dblActualPrincipalAmt = 0.00;
		double dblOriginalPrincipalAmt = 0.00;
		double dblDiffPrincipalAmtOS = 0.00;
		double dblActualOSAmt = 0.00;
		double dblTotalAmount = 0.00;

		try
		{
			strAppNo = correctNull((String) hshValues.get("appno"));
			
			strStartTerm = correctNull((String) hshValues.get("hidstartterms"));
			
			strEndTerm = correctNull((String) hshValues.get("hidendterms"));
			
			strIndex = correctNull((String) hshValues.get("index"));
			
			intindex = Integer.parseInt(strIndex);
			
			dblRate = Double.parseDouble(((String) hshValues.get("interestrate")));
			
			intTotalTerms = Integer.parseInt(Helper.correctInt((String) hshValues.get("totterms")));
			
			dblOriginalOSAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("orginalamountOS")));
			
			dblOriginalIntAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("originalinterestamt")));
			
			dblOriginalPrincipalAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("originalprincpalamt")));
			
			dblTotalAmount = Double.parseDouble(Helper.correctDouble((String) hshValues.get("totalamt")));
			if (dblTotalAmount <= dblOriginalIntAmt)
			{
				dblActualIntAmt = dblTotalAmount;
			}
			else
			{
				dblActualIntAmt = dblOriginalIntAmt;
			}
			dblActualPrincipalAmt = dblTotalAmount - dblActualIntAmt;

			dblRate = dblRate / (12 * 100);
			
			dblDenominator = Math.pow(dblRate + 1, intTotalTerms) - 1;
		
			dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms);
			
			dblTemp = dblNumerator / dblDenominator;
			
			String isactualinterestamt = correctNull((String) hshValues.get("isactualinterestamt"));

			for (i = intindex; i <= intTotalTerms; i++)
			{
				arryCol = new ArrayList();
				if (isactualinterestamt.equals("notnull"))
				{
					dblDiffIntAmtOS = dblOriginalIntAmt - dblActualIntAmt;
					
					if (dblActualPrincipalAmt != 0)
					{
						if (dblOriginalPrincipalAmt > dblActualPrincipalAmt)
						{
							dblDiffPrincipalAmtOS = dblActualPrincipalAmt;
						}
						else
						{
							dblDiffPrincipalAmtOS = dblActualPrincipalAmt;
						}
					}
					else if (dblActualPrincipalAmt == 0)
					{
						dblDiffPrincipalAmtOS = 0;
					}
					
					dblActualOSAmt = dblOriginalOSAmt - dblDiffPrincipalAmtOS + dblDiffIntAmtOS;
					
					dblTotalAmount = dblActualIntAmt + dblActualPrincipalAmt;
					
					arryCol.add(Integer.toString(i));
					arryCol.add(Helper.formatDoubleValue(dblOriginalOSAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblTotalAmount));
					arryCol.add(Helper.formatDoubleValue(dblActualOSAmt));

					j = i + 1;
					if (j <= intTotalTerms)
					{
						dblOriginalOSAmt = dblOriginalOSAmt - dblDiffPrincipalAmtOS + dblDiffIntAmtOS;

						dblRecAmount = dblOriginalOSAmt;						

						dblDenominator = Math.pow(dblRate + 1, intTotalTerms - i) - 1;
					
						dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms - i);
						
						dblTemp = dblNumerator / dblDenominator;

						dblEMI = dblTemp * dblRecAmount;
						
						dblOriginalIntAmt = dblRecAmount * dblRate;						

						dblActualIntAmt = dblRecAmount * dblRate;
						
						dblOriginalPrincipalAmt = dblEMI - dblOriginalIntAmt;
						
						dblActualPrincipalAmt = dblEMI - dblActualIntAmt;
					}
				}
				else
				{
					dblRecAmount = dblOriginalOSAmt;

					dblDenominator = Math.pow(dblRate + 1, intTotalTerms - (i - 1)) - 1;
					
					dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms - (i - 1));
					
					dblTemp = dblNumerator / dblDenominator;

					dblEMI = dblTemp * dblRecAmount;

					dblOriginalIntAmt = dblRecAmount * dblRate;
					dblOriginalPrincipalAmt = dblEMI - dblOriginalIntAmt;
					dblActualIntAmt = dblRecAmount * dblRate;
					dblActualPrincipalAmt = dblEMI - dblActualIntAmt;
					dblActualOSAmt = dblRecAmount - dblOriginalPrincipalAmt;
					dblTotalAmount = dblActualIntAmt + dblActualPrincipalAmt;

					arryCol.add(Integer.toString(i));
					arryCol.add(Helper.formatDoubleValue(dblOriginalOSAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblTotalAmount));
					arryCol.add(Helper.formatDoubleValue(dblActualOSAmt));

					j = i + 1;
					if (j <= intTotalTerms)
					{
						dblOriginalOSAmt = dblRecAmount - dblOriginalPrincipalAmt;
					}
				}
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow", arryRow);
			hshResult.put("hidstartterms", strIndex);
			hshResult.put("hidendterms", strEndTerm);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in closing calcRepayment" + e.getMessage());
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
		return hshResult;
	}

	public HashMap calcRepayment(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();
		String strAppNo = "";
		String strStartTerm = "";
		String strEndTerm = "";
		String strIndex = "";
		int intindex = 1;
		int intTotalTerms = 1;
		int i = 0, j = 0;

		double dblTemp = 0.00;
		double dblRate = 0.00;
		double dblRecAmount = 0.00;
		double dblNumerator = 0.00;
		double dblDenominator = 0.00;
		double dblEMI = 0.00;
		double dblOriginalOSAmt = 0.00;
		double dblActualIntAmt = 0.00;
		double dblOriginalIntAmt = 0.00;
		double dblDiffIntAmtOS = 0.00;
		double dblActualPrincipalAmt = 0.00;
		double dblOriginalPrincipalAmt = 0.00;
		double dblDiffPrincipalAmtOS = 0.00;
		double dblActualOSAmt = 0.00;
		double dblTotalAmount = 0.00;

		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);

		try
		{
			strAppNo = correctNull((String) hshValues.get("appno"));
			strStartTerm = correctNull((String) hshValues.get("hidstartterms"));
			strEndTerm = correctNull((String) hshValues.get("hidendterms"));
			strIndex = correctNull((String) hshValues.get("index"));
			intindex = Integer.parseInt(strIndex);
			dblRate = Double.parseDouble(((String) hshValues.get("interestrate")));
			intTotalTerms = Integer.parseInt((String) hshValues.get("totterms"));
			dblOriginalOSAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("orginalamountOS")));
			dblActualIntAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("actualinterestamt")));
			dblOriginalIntAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("originalinterestamt")));
			dblActualPrincipalAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("actualprincpalamt")));
			dblOriginalPrincipalAmt = Double.parseDouble(Helper.correctDouble((String) hshValues.get("originalprincpalamt")));

			dblRate = dblRate / (12 * 100);
			dblDenominator = Math.pow(dblRate + 1, intTotalTerms) - 1;
			dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms);
			dblTemp = dblNumerator / dblDenominator;

			String isactualinterestamt = correctNull((String) hshValues.get("isactualinterestamt"));

			for (i = intindex; i <= intTotalTerms; i++)
			{
				arryCol = new ArrayList();
				if (isactualinterestamt.equals("notnull"))
				{
					dblDiffIntAmtOS = dblOriginalIntAmt - dblActualIntAmt;
					
					if (dblActualPrincipalAmt != 0)
					{
						if (dblOriginalPrincipalAmt > dblActualPrincipalAmt)
						{
							dblDiffPrincipalAmtOS = dblActualPrincipalAmt - dblOriginalPrincipalAmt;
						}
						else
						{
							dblDiffPrincipalAmtOS = dblActualPrincipalAmt;
						}
					}
					else if (dblActualPrincipalAmt == 0)
					{
						dblDiffPrincipalAmtOS = 0;
					}
					
					dblActualOSAmt = dblOriginalOSAmt - dblDiffPrincipalAmtOS + dblDiffIntAmtOS;
				
					dblTotalAmount = dblActualIntAmt + dblActualPrincipalAmt;
					
					arryCol.add(Integer.toString(i));
					arryCol.add(Helper.formatDoubleValue(dblOriginalOSAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblTotalAmount));
					arryCol.add(Helper.formatDoubleValue(dblActualOSAmt));

					j = i + 1;
					if (j <= intTotalTerms)
					{
						dblOriginalOSAmt = dblOriginalOSAmt - dblDiffPrincipalAmtOS + dblDiffIntAmtOS;

						dblRecAmount = dblOriginalOSAmt;
						
						dblDenominator = Math.pow(dblRate + 1, intTotalTerms - i) - 1;
						
						dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms - i);
						
						dblTemp = dblNumerator / dblDenominator;

						dblEMI = dblTemp * dblRecAmount;
						
						dblOriginalIntAmt = dblRecAmount * dblRate;
						
						dblActualIntAmt = dblRecAmount * dblRate;
						
						dblOriginalPrincipalAmt = dblEMI - dblOriginalIntAmt;
						
						dblActualPrincipalAmt = dblEMI - dblActualIntAmt;
					}
				}
				else
				{
					dblRecAmount = dblOriginalOSAmt;

					dblDenominator = Math.pow(dblRate + 1, intTotalTerms - (i - 1)) - 1;
					
					dblNumerator = dblRate * Math.pow(dblRate + 1, intTotalTerms - (i - 1));
					
					dblTemp = dblNumerator / dblDenominator;

					dblEMI = dblTemp * dblRecAmount;

					dblOriginalIntAmt = dblRecAmount * dblRate;
					dblOriginalPrincipalAmt = dblEMI - dblOriginalIntAmt;
					dblActualIntAmt = dblRecAmount * dblRate;
					dblActualPrincipalAmt = dblEMI - dblActualIntAmt;
					dblActualOSAmt = dblRecAmount - dblOriginalPrincipalAmt;
					dblTotalAmount = dblActualIntAmt + dblActualPrincipalAmt;

					arryCol.add(Integer.toString(i));
					arryCol.add(Helper.formatDoubleValue(dblOriginalOSAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalIntAmt));
					arryCol.add(Helper.formatDoubleValue(dblActualPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblOriginalPrincipalAmt));
					arryCol.add(Helper.formatDoubleValue(dblTotalAmount));
					arryCol.add(Helper.formatDoubleValue(dblActualOSAmt));

					j = i + 1;
					if (j <= intTotalTerms)
					{
						dblOriginalOSAmt = dblRecAmount - dblOriginalPrincipalAmt;
					}
				}
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow", arryRow);
			hshResult.put("hidstartterms", strIndex);
			hshResult.put("hidendterms", strEndTerm);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in closing calcRepayment" + e.getMessage());
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
		return hshResult;
	}

	/*
	 * new method for repayment shedule public HashMap calcRepayment1(HashMap
	 * hshValues)  {
	 * Logger.log("calcRepayment&&&&&&&&%%%%%%%hshValues======"+hshValues);
	 * ResultSet rs = null;
	 * 
	 * HashMap hshResult = new HashMap();
	 * 
	 * ArrayList arryRow = new ArrayList(); ArrayList arryCol = new ArrayList();
	 * 
	 * 
	 * String strAppNo =""; String strStartTerm =""; String strEndTerm ="";
	 * String strIndex =""; int intindex = 1; int intTotalTerms = 1; int
	 * i=0,j=0;
	 * 
	 * double dblTemp = 0.00;
	 * 
	 * double dblRate = 0.00; double dblRecAmount = 0.00; double dblNumerator
	 * =0.00; double dblDenominator =0.00; double dblEMI = 0.00;
	 * 
	 * double dblOriginalOSAmt =0.00;
	 * 
	 * double dblActualIntAmt =0.00; double dblOriginalIntAmt =0.00; double
	 * dblDiffIntAmtOS =0.00;
	 * 
	 * double dblActualPrincipalAmt =0.00; double dblOriginalPrincipalAmt =0.00;
	 * double dblDiffPrincipalAmtOS =0.00;
	 * 
	 * double dblActualOSAmt =0.00; double dblTotalAmount =0.00;
	 * 
	 * 
	 * DecimalFormat dc = new DecimalFormat(); dc.setGroupingUsed(false);
	 * dc.setMaximumFractionDigits(2); dc.setMinimumFractionDigits(2);
	 * 
	 * 
	 * 
	 * 
	 * try { strAppNo = correctNull((String)hshValues.get("appno"));
	 * Logger.log("strAppNo======"+strAppNo);
	 * 
	 * strStartTerm = correctNull((String)hshValues.get("hidstartterms"));
	 * Logger.log("strStartTerm======"+strStartTerm);
	 * 
	 * strEndTerm = correctNull((String)hshValues.get("hidendterms"));
	 * Logger.log("strEndTerm======"+strEndTerm);
	 * 
	 * strIndex = correctNull((String)hshValues.get("index"));
	 * Logger.log("strIndex======"+strIndex);
	 * 
	 * intindex = Integer.parseInt(strIndex);
	 * Logger.log("intindex======"+intindex);
	 * 
	 * dblRate = Double.parseDouble(((String)hshValues.get("interestrate")));
	 * Logger.log("dblRate======"+dblRate);
	 * 
	 * intTotalTerms =Integer.parseInt((String)hshValues.get("totterms"));
	 * Logger.log("intTotalTerms======"+intTotalTerms);
	 * 
	 * dblOriginalOSAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("orginalamountOS")));
	 * Logger.log("dblOriginalOSAmt======"+dblOriginalOSAmt);
	 * 
	 * //dblActualIntAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("actualinterestamt")));
	 * Logger.log("dblActualIntAmt======"+dblActualIntAmt);
	 * 
	 * dblOriginalIntAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("originalinterestamt")));
	 * Logger.log("dblOriginalIntAmt======"+dblOriginalIntAmt);
	 * 
	 * //dblActualPrincipalAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("actualprincpalamt")));
	 * Logger.log("dblActualPrincipalAmt======"+dblActualPrincipalAmt);
	 * 
	 * dblOriginalPrincipalAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("originalprincpalamt")));
	 * Logger.log("dblOriginalPrincipalAmt======"+dblOriginalPrincipalAmt);
	 * 
	 * //change dblTotalAmount =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalamt")));
	 * if(dblTotalAmount<= dblOriginalIntAmt) { dblActualIntAmt =
	 * dblTotalAmount-dblOriginalIntAmt; } else { dblActualIntAmt =
	 * dblOriginalIntAmt; } dblTotalAmount=dblTotalAmount-dblOriginalIntAmt;
	 * //dblActualPrincipalAmt = dblTotalAmount-dblActualIntAmt;
	 * 
	 * dblRate=dblRate/(12*100); Logger.log("dblRate afetr
	 * Division======"+dblRate);
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms)-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms);
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator; Logger.log("dblTemp
	 * ======"+dblTemp);
	 * 
	 * String isactualinterestamt
	 * =correctNull((String)hshValues.get("isactualinterestamt"));
	 * 
	 * for(i = intindex ;i<=intTotalTerms;i++) { arryCol = new ArrayList();
	 * if(isactualinterestamt.equals("notnull")) {
	 * 
	 * Logger.log("actualinterestamt exists not equal to zero");
	 * Logger.log("dblOriginalOSAmt inside
	 * for----"+i+"--"+dblOriginalOSAmt); Logger.log("dblOriginalIntAmt
	 * inside for----"+i+"--"+dblOriginalIntAmt);
	 * Logger.log("dblActualIntAmt inside
	 * for----"+i+"--"+dblActualIntAmt);
	 * 
	 * //dblDiffIntAmtOS = dblOriginalIntAmt - dblActualIntAmt;
	 * Logger.log("dblDiffIntAmtOS inside
	 * for----"+i+"--"+dblDiffIntAmtOS);
	 * 
	 * Logger.log("dblActualPrincipalAmt inside
	 * --"+i+"--"+dblActualPrincipalAmt);
	 * Logger.log("OriginalPrincipalAmt
	 * inside-"+i+"--"+dblOriginalPrincipalAmt);
	 * 
	 * if(dblTotalAmount>0) { /* if(dblOriginalPrincipalAmt > dblTotalAmount) {
	 */
	// dblDiffPrincipalAmtOS = dblActualPrincipalAmt - dblOriginalPrincipalAmt;
	/* dblActualPrincipalAmt= dblTotalAmount; */
	/*
	 * } else { // dblDiffPrincipalAmtOS = dblActualPrincipalAmt;
	 *  }
	 */

	/*
	 * } else //if (dblActualPrincipalAmt==0) { dblActualPrincipalAmt = 0; }
	 * Logger.log("DiffPrincipalAmtOSnsidefor-"+j+"--"+dblActualPrincipalAmt);
	 * 
	 * dblActualOSAmt = dblOriginalOSAmt - dblActualPrincipalAmt +
	 * dblActualIntAmt; Logger.log("dblActualOSAmt inside
	 * for----"+j+"--"+dblActualOSAmt); dblTotalAmount = dblActualIntAmt +
	 * dblActualPrincipalAmt; Logger.log("dblTotalAmount inside
	 * for----"+j+"--"+dblTotalAmount);
	 * 
	 * arryCol.add(Integer.toString(i));
	 * arryCol.add((dc.format(dblOriginalOSAmt)));
	 * arryCol.add((dc.format(dblActualIntAmt)));
	 * arryCol.add((dc.format(dblOriginalIntAmt)));
	 * arryCol.add((dc.format(dblActualPrincipalAmt)));
	 * arryCol.add((dc.format(dblOriginalPrincipalAmt)));
	 * arryCol.add((dc.format(dblTotalAmount)));
	 * arryCol.add((dc.format(dblActualOSAmt)));
	 * 
	 * j = i+1; if (j <= intTotalTerms) { Logger.log("dblRecAmount next
	 * ----"+j+"--********"); dblOriginalOSAmt =
	 * dblActualOSAmt;//dblOriginalOSAmt - dblDiffPrincipalAmtOS +
	 * dblDiffIntAmtOS;
	 * 
	 * dblRecAmount = dblOriginalOSAmt; Logger.log("dblRecAmount next
	 * for----"+j+"--"+dblRecAmount);
	 * 
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms-i)-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms-i);
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator;
	 * 
	 * dblEMI = dblTemp*dblRecAmount; Logger.log("dblEMI next
	 * for----"+j+"--"+dblEMI); dblOriginalIntAmt =dblRecAmount*dblRate;
	 * Logger.log("dblOriginalIntAmt----"+j+"--"+dblOriginalIntAmt);
	 * 
	 * dblActualIntAmt = dblRecAmount*dblRate;
	 * Logger.log("dblActualIntAmt next----"+j+"--"+dblActualIntAmt);
	 * 
	 * dblOriginalPrincipalAmt =dblEMI-dblOriginalIntAmt;
	 * Logger.log("dblOriginalPrincipalAmt--"+j+"--"+dblOriginalPrincipalAmt);
	 * 
	 * dblActualPrincipalAmt =dblEMI-dblActualIntAmt;
	 * Logger.log("dblActualPrincipalAmt
	 * ---"+j+"--"+dblActualPrincipalAmt);
	 *  } } else { Logger.log("actualinterestamt === 0000000 equal to
	 * zero"); dblRecAmount = dblOriginalOSAmt;
	 * 
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms-(i-1))-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms-(i-1));
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator;
	 * 
	 * dblEMI = dblTemp*dblRecAmount;
	 * 
	 * dblOriginalIntAmt =dblRecAmount*dblRate; dblOriginalPrincipalAmt
	 * =dblEMI-dblOriginalIntAmt; dblActualIntAmt =dblRecAmount*dblRate;
	 * dblActualPrincipalAmt =dblEMI-dblActualIntAmt; dblActualOSAmt =
	 * dblRecAmount - dblOriginalPrincipalAmt ; dblTotalAmount = dblActualIntAmt +
	 * dblActualPrincipalAmt;
	 * 
	 * 
	 * arryCol.add(Integer.toString(i));
	 * arryCol.add((dc.format(dblOriginalOSAmt)));
	 * arryCol.add((dc.format(dblActualIntAmt)));
	 * arryCol.add((dc.format(dblOriginalIntAmt)));
	 * arryCol.add((dc.format(dblActualPrincipalAmt)));
	 * arryCol.add((dc.format(dblOriginalPrincipalAmt)));
	 * arryCol.add((dc.format(dblTotalAmount)));
	 * arryCol.add((dc.format(dblActualOSAmt)));
	 * 
	 * //dblOriginalOSAmt = dblRecAmount - dblOriginalPrincipalAmt; j = i+1; if
	 * (j <= intTotalTerms) { dblOriginalOSAmt = dblRecAmount -
	 * dblOriginalPrincipalAmt; }
	 *  } arryRow.add(arryCol); //isactualinterestamt ="notnull";
	 *  } hshResult.put("arryRow",arryRow);
	 * hshResult.put("hidstartterms",strIndex);
	 * hshResult.put("hidendterms",strEndTerm);
	 *  } catch(Exception e) { throw new EJBException("Error in closing
	 * calcRepayment"+e.getMessage()); } finally { try { if(rs!=null) {
	 * rs.close(); }
	 *  } catch(Exception e) { throw new EJBException("Error in closing
	 * Connection "+e.getMessage()); } } Logger.log("hshResult-------in
	 * calaRepayment---"+hshResult); return hshResult; }
	 * 
	 * public HashMap calcRepayment(HashMap hshValues)  {
	 * Logger.log("calcRepayment&&&&&&&&%%%%%%%hshValues======"+hshValues);
	 * //Connection con = null; //Statement stmt = null; ResultSet rs = null;
	 * 
	 * HashMap hshResult = new HashMap();
	 * 
	 * ArrayList arryRow = new ArrayList(); ArrayList arryCol = new ArrayList();
	 * 
	 * 
	 * String strQuery = ""; String strAppNo =""; String strStartTerm ="";
	 * String strEndTerm =""; String strIndex =""; int intindex = 1; int
	 * intTotalTerms = 1; int i=0,j=0;
	 * 
	 * double dblTemp = 0.00;
	 * 
	 * double dblRate = 0.00; double dblRecAmount = 0.00; double dblNumerator
	 * =0.00; double dblDenominator =0.00; double dblEMI = 0.00;
	 * 
	 * double dblOriginalOSAmt =0.00;
	 * 
	 * double dblActualIntAmt =0.00; double dblOriginalIntAmt =0.00; double
	 * dblDiffIntAmtOS =0.00;
	 * 
	 * double dblActualPrincipalAmt =0.00; double dblOriginalPrincipalAmt =0.00;
	 * double dblDiffPrincipalAmtOS =0.00;
	 * 
	 * double dblActualOSAmt =0.00; double dblTotalAmount =0.00;
	 * 
	 * 
	 * DecimalFormat dc = new DecimalFormat(); dc.setGroupingUsed(false);
	 * dc.setMaximumFractionDigits(2); dc.setMinimumFractionDigits(2);
	 * 
	 * 
	 * 
	 * 
	 * try { strAppNo = correctNull((String)hshValues.get("appno"));
	 * Logger.log("strAppNo======"+strAppNo); strStartTerm =
	 * correctNull((String)hshValues.get("hidstartterms"));
	 * Logger.log("strStartTerm======"+strStartTerm); strEndTerm =
	 * correctNull((String)hshValues.get("hidendterms"));
	 * Logger.log("strEndTerm======"+strEndTerm); strIndex =
	 * correctNull((String)hshValues.get("index"));
	 * Logger.log("strIndex======"+strIndex); intindex =
	 * Integer.parseInt(strIndex);
	 * Logger.log("intindex======"+intindex); dblRate =
	 * Double.parseDouble(((String)hshValues.get("interestrate")));
	 * Logger.log("dblRate======"+dblRate); intTotalTerms
	 * =Integer.parseInt((String)hshValues.get("totterms"));
	 * Logger.log("intTotalTerms======"+intTotalTerms); dblOriginalOSAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("orginalamountOS")));
	 * Logger.log("dblOriginalOSAmt======"+dblOriginalOSAmt);
	 * dblActualIntAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("actualinterestamt")));
	 * Logger.log("dblActualIntAmt======"+dblActualIntAmt);
	 * dblOriginalIntAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("originalinterestamt")));
	 * Logger.log("dblOriginalIntAmt======"+dblOriginalIntAmt);
	 * dblActualPrincipalAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("actualprincpalamt")));
	 * Logger.log("dblActualPrincipalAmt======"+dblActualPrincipalAmt);
	 * dblOriginalPrincipalAmt =
	 * Double.parseDouble(Helper.correctDouble((String)hshValues.get("originalprincpalamt")));
	 * Logger.log("dblOriginalPrincipalAmt======"+dblOriginalPrincipalAmt);
	 * 
	 * dblRate=dblRate/(12*100); Logger.log("dblRate afetr
	 * Division======"+dblRate);
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms)-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms);
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator; Logger.log("dblTemp
	 * ======"+dblTemp);
	 * 
	 * String isactualinterestamt
	 * =correctNull((String)hshValues.get("isactualinterestamt"));
	 * 
	 * for(i = intindex ;i<=intTotalTerms;i++) { arryCol = new ArrayList();
	 * if(isactualinterestamt.equals("notnull")) {
	 * 
	 * Logger.log("actualinterestamt exists not equal to zero");
	 * Logger.log("dblOriginalOSAmt inside
	 * for----"+i+"--"+dblOriginalOSAmt); Logger.log("dblOriginalIntAmt
	 * inside for----"+i+"--"+dblOriginalIntAmt);
	 * Logger.log("dblActualIntAmt inside
	 * for----"+i+"--"+dblActualIntAmt);
	 * 
	 * dblDiffIntAmtOS = dblOriginalIntAmt - dblActualIntAmt;
	 * Logger.log("dblDiffIntAmtOS inside
	 * for----"+i+"--"+dblDiffIntAmtOS);
	 * 
	 * Logger.log("dblActualPrincipalAmt inside
	 * --"+i+"--"+dblActualPrincipalAmt);
	 * Logger.log("OriginalPrincipalAmt
	 * inside-"+i+"--"+dblOriginalPrincipalAmt);
	 * 
	 * if(dblActualPrincipalAmt!=0) { if(dblOriginalPrincipalAmt >
	 * dblActualPrincipalAmt) { dblDiffPrincipalAmtOS = dblActualPrincipalAmt -
	 * dblOriginalPrincipalAmt; } else { dblDiffPrincipalAmtOS =
	 * dblActualPrincipalAmt; }
	 *  } else if (dblActualPrincipalAmt==0) { dblDiffPrincipalAmtOS = 0; }
	 * Logger.log("DiffPrincipalAmtOSnsidefor-"+j+"--"+dblDiffPrincipalAmtOS);
	 * 
	 * dblActualOSAmt = dblOriginalOSAmt - dblDiffPrincipalAmtOS +
	 * dblDiffIntAmtOS; Logger.log("dblActualOSAmt inside
	 * for----"+j+"--"+dblActualOSAmt); dblTotalAmount = dblActualIntAmt +
	 * dblActualPrincipalAmt; Logger.log("dblTotalAmount inside
	 * for----"+j+"--"+dblTotalAmount);
	 * 
	 * arryCol.add(Integer.toString(i));
	 * arryCol.add((dc.format(dblOriginalOSAmt)));
	 * arryCol.add((dc.format(dblActualIntAmt)));
	 * arryCol.add((dc.format(dblOriginalIntAmt)));
	 * arryCol.add((dc.format(dblActualPrincipalAmt)));
	 * arryCol.add((dc.format(dblOriginalPrincipalAmt)));
	 * arryCol.add((dc.format(dblTotalAmount)));
	 * arryCol.add((dc.format(dblActualOSAmt)));
	 * 
	 * j = i+1; if (j <= intTotalTerms) { Logger.log("dblRecAmount next
	 * ----"+j+"--********"); dblOriginalOSAmt = dblOriginalOSAmt -
	 * dblDiffPrincipalAmtOS + dblDiffIntAmtOS;
	 * 
	 * dblRecAmount = dblOriginalOSAmt; Logger.log("dblRecAmount next
	 * for----"+j+"--"+dblRecAmount);
	 * 
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms-i)-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms-i);
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator;
	 * 
	 * dblEMI = dblTemp*dblRecAmount; Logger.log("dblEMI next
	 * for----"+j+"--"+dblEMI); dblOriginalIntAmt =dblRecAmount*dblRate;
	 * Logger.log("dblOriginalIntAmt----"+j+"--"+dblOriginalIntAmt);
	 * 
	 * dblActualIntAmt = dblRecAmount*dblRate;
	 * Logger.log("dblActualIntAmt next----"+j+"--"+dblActualIntAmt);
	 * 
	 * dblOriginalPrincipalAmt =dblEMI-dblOriginalIntAmt;
	 * Logger.log("dblOriginalPrincipalAmt--"+j+"--"+dblOriginalPrincipalAmt);
	 * 
	 * dblActualPrincipalAmt =dblEMI-dblActualIntAmt;
	 * Logger.log("dblActualPrincipalAmt
	 * ---"+j+"--"+dblActualPrincipalAmt);
	 *  } } else { Logger.log("actualinterestamt === 0000000 equal to
	 * zero"); dblRecAmount = dblOriginalOSAmt;
	 * 
	 * dblDenominator=Math.pow(dblRate+1,intTotalTerms-(i-1))-1;
	 * Logger.log("dblDenominator ======"+dblDenominator);
	 * dblNumerator=dblRate*Math.pow(dblRate+1,intTotalTerms-(i-1));
	 * Logger.log("dblNumerator ======"+dblNumerator); dblTemp =
	 * dblNumerator/dblDenominator;
	 * 
	 * dblEMI = dblTemp*dblRecAmount;
	 * 
	 * dblOriginalIntAmt =dblRecAmount*dblRate; dblOriginalPrincipalAmt
	 * =dblEMI-dblOriginalIntAmt; dblActualIntAmt =dblRecAmount*dblRate;
	 * dblActualPrincipalAmt =dblEMI-dblActualIntAmt; dblActualOSAmt =
	 * dblRecAmount - dblOriginalPrincipalAmt ; dblTotalAmount = dblActualIntAmt +
	 * dblActualPrincipalAmt;
	 */

	/*
	 * arryCol.add(new Integer(i)); arryCol.add(new
	 * Double(dc.format(dblOriginalOSAmt))); arryCol.add(new
	 * Double(dc.format(dblActualIntAmt))); arryCol.add(new
	 * Double(dc.format(dblOriginalIntAmt))); arryCol.add(new
	 * Double(dc.format(dblActualPrincipalAmt))); arryCol.add(new
	 * Double(dc.format(dblOriginalPrincipalAmt))); arryCol.add(new
	 * Double(dc.format(dblTotalAmount))); arryCol.add(new
	 * Double(dc.format(dblActualOSAmt)));
	 */

	/*
	 * arryCol.add(Integer.toString(i));
	 * arryCol.add((dc.format(dblOriginalOSAmt)));
	 * arryCol.add((dc.format(dblActualIntAmt)));
	 * arryCol.add((dc.format(dblOriginalIntAmt)));
	 * arryCol.add((dc.format(dblActualPrincipalAmt)));
	 * arryCol.add((dc.format(dblOriginalPrincipalAmt)));
	 * arryCol.add((dc.format(dblTotalAmount)));
	 * arryCol.add((dc.format(dblActualOSAmt)));
	 * 
	 * //dblOriginalOSAmt = dblRecAmount - dblOriginalPrincipalAmt; j = i+1; if
	 * (j <= intTotalTerms) { dblOriginalOSAmt = dblRecAmount -
	 * dblOriginalPrincipalAmt; }
	 *  } arryRow.add(arryCol); //isactualinterestamt ="notnull";
	 *  } hshResult.put("arryRow",arryRow);
	 * hshResult.put("hidstartterms",strIndex);
	 * hshResult.put("hidendterms",strEndTerm);
	 *  } catch(Exception e) { throw new EJBException("Error in closing
	 * calcRepayment"+e.getMessage()); } finally { try { if(rs!=null) {
	 * rs.close(); } /*if(stmt!=null) { stmt.close(); } if(con!=null) {
	 * con.close(); }
	 */
	/*
	 * } catch(Exception e) { throw new EJBException("Error in closing
	 * Connection "+e.getMessage()); } } Logger.log("hshResult-------in
	 * calaRepayment---"+hshResult); return hshResult; }
	 */

	public HashMap updateAmortization(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		HashMap hshRecord = new HashMap();

		ArrayList arrValues = new ArrayList();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = new ArrayList();

		String strTerm = null;
		String strAppNo = null;
		String strTemp = null;
		String strAction = null;

		String strStartTerms = null;
		String strEndTerms = null;
		String strRate = "1";

		int intTerms = 1;
		int intstartterms = 1;
		int intendterms = 1;
		int intnextendterms = 1;

		int i = 0, j = 0;
		int intUpdatesize = 0;

		try
		{
			strAppNo = correctNull((String) hshValues.get("appno"));
			
			strTerm = correctNull((String) hshValues.get("txtloan_reqterms"));
			
			strRate = correctNull((String) hshValues.get("txtloan_modintrate"));
			
			strStartTerms = correctNull((String) hshValues.get("hidstartterms"));
			
			intstartterms = Integer.parseInt(strStartTerms);

			intTerms = Integer.parseInt(strTerm);

			strAction = correctNull((String) hshValues.get("hidAction"));
			
			if (strAction.equals("insert"))
			{
				strEndTerms = correctNull((String) hshValues.get("hidendterms"));
				
				intendterms = Integer.parseInt(strEndTerms);

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "delamortization");
				arrValues.add(correctNull(strAppNo));
				arrValues.add(correctNull(strStartTerms));
				arrValues.add(correctNull(strTerm));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);

				intUpdatesize = 1;

				for (i = intstartterms; i <= intendterms; i++)
				{
					intUpdatesize = intUpdatesize + 1;

					hshQuery = new HashMap();
					arrValues = new ArrayList();

					arrValues.add(correctNull(strAppNo));
					arrValues.add(Integer.toString(i));
					strTemp = "txt_originalOSamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					strTemp = "txt_actualinterestamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					strTemp = "hidoriginalinterestamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					strTemp = "txt_actualprincipalamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					strTemp = "hidoriginalprincipalamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					strTemp = "txt_actualOSamt" + i;
					arrValues.add((hshValues.get(strTemp)));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "insertamortization");
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
				}
				if ((intendterms + 1) + 49 > intTerms)
				{
					intnextendterms = intTerms;
				}
				else
				{
					intnextendterms = (intendterms + 1) + 49;
				}
				hshRecord.put("appno", strAppNo);
				hshRecord.put("hidstartterms", Integer.toString(intendterms + 1));
				hshRecord.put("hidendterms", Integer.toString(intnextendterms));
				hshRecord.put("index", Integer.toString(intendterms + 1));
				hshRecord.put("interestrate", strRate);
				hshRecord.put("totterms", strTerm);
				hshRecord.put("orginalamountOS", correctNull((String) (hshValues.get("txt_actualOSamt" + (i - 1)))));
				hshRecord.put("actualinterestamt", "0.00");
				hshRecord.put("originalinterestamt", "0.00");
				hshRecord.put("actualprincpalamt", "0.00");
				hshRecord.put("originalprincpalamt", "0.00");
				hshRecord.put("isactualinterestamt", "null");

				hshRecord = (HashMap) calcRepayment(hshRecord);
				
				arryRow = (ArrayList) hshRecord.get("arryRow");
				intstartterms = Integer.parseInt((String) hshRecord.get("hidstartterms"));
				intendterms = Integer.parseInt((String) hshRecord.get("hidendterms"));
				
				for (i = intstartterms; i <= intTerms; i++)
				{
					if (arryRow != null && arryRow.size() > 0)
					{
						arryCol = (ArrayList) arryRow.get(j);
						if (arryCol != null)
						{
							intUpdatesize = intUpdatesize + 1;
							hshQuery = new HashMap();
							arrValues = new ArrayList();

							arrValues.add((strAppNo));
							arrValues.add(((String) arryCol.get(0)));
							arrValues.add(((String) arryCol.get(1)));
							arrValues.add(((String) arryCol.get(2)));
							arrValues.add(((String) arryCol.get(3)));
							arrValues.add(((String) arryCol.get(4)));
							arrValues.add(((String) arryCol.get(5)));
							arrValues.add(((String) arryCol.get(7)));
						}
					}
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "insertamortization");
					hshQueryValues.put(Integer.toString(intUpdatesize), hshQuery);
					j = j + 1;
				}
				hshQueryValues.put("size", Integer.toString(intUpdatesize));
			}
			else if (strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();

				hshQuery.put("strQueryId", "delamortization");
				arrValues.add(correctNull(strAppNo));
				arrValues.add(correctNull("1"));
				arrValues.add(correctNull(strTerm));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			}
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			hshValues.put("hidrepaymenttype", new String("repay"));
			hshRecord = (HashMap) calculateAmortization(hshValues);
			if (strAction.equals("delete"))
			{
				hshRecord.put("hidstartterms", "1");
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("inside updateAmortization" + ce.toString());
		}
		return hshRecord;
	}

	/**
	 * Function updateLoanProducts This Method is used for updating or inserting
	 * the application form details
	 * 
	 * @param hshValues
	 * @return HashMap
	 * @exception java.lang.Exception
	 */
	public HashMap updateLoanProducts(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
				
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValueschk = new HashMap();
		HashMap hshQuerychk = new HashMap();
		ArrayList arrValues = new ArrayList();
		ArrayList arrValuechk = new ArrayList();
		
		HashMap hshResult = new HashMap();
		int intUpdatesize=0;
		HashMap hshGLRecord=new HashMap();
		boolean resflag=false;
		ResultSet rs = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rsfreeze = null;
		String strGetLock = "";
		String strEditMode = correctNull((String) hshValues.get("hidEditMode"));
		String strPrdType = correctNull((String) hshValues.get("prd_type")).toUpperCase();
		String strPrd = correctNull((String) hshValues.get("prd_type"));
		HashMap hshLoanProduct = new HashMap();
		String strApplicationNo = correctNull((String) hshValues.get("appno"));
		String strtxt_operativeaccno=correctNull((String) hshValues.get("txt_operativeaccno"));
		if(strtxt_operativeaccno.equalsIgnoreCase("")||strtxt_operativeaccno == null){
			hshValues.put("txt_operativeaccno", correctNull((String) hshValues.get("hidoperativeacc")));
		}
		HashMap hshlockvalues = new HashMap();
		String strPage = correctNull((String) hshValues.get("page"));
		String strOldAppno = correctNull((String) hshValues.get("appno"));
		String strApplicantid = correctNull((String) hshValues.get("comappid"));
		String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
        String strissaral=correctNull((String)hshValues.get("strIsSaral"));
        String strFromuserid=Helper.correctNull((String)hshValues.get("strUserId"));
        String strAppcgstatus=correctNull((String)hshValues.get("hidAppCGStatus"));
        String strAction="",strQuery="", strQuery1="";
		String strappprdcode = "";
		String strAppOldID="";
		String strExp="$";
		String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
		StringBuilder sbOldAudit=new StringBuilder();
		String strPrdTypeOld="",loan_modintrateold="";
		String strAppType=Helper.correctNull((String)hshValues.get("strAppType"));
		if(strAppType.equalsIgnoreCase("")){
			strAppType=Helper.correctNull((String)hshValues.get("strAppTypeval"));
		}
		if (strApplicantid.equalsIgnoreCase("") || strApplicantid.equalsIgnoreCase("null") || strApplicantid.equalsIgnoreCase(null))
		{
			strApplicantid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
		}
		if (strApplicantid.equalsIgnoreCase(""))
		{
			strApplicantid = Helper.correctNull((String) hshValues.get("appid"));
		}
		try
		{
			if(!strApplicantid.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("seloldrefidforapp^"+strApplicantid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("getcomappid^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppOldID=Helper.correctNull(rs.getString("demo_appid"));
					strApplicantid=Helper.correctNull(rs.getString("demo_oldappid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			
			
			
			 hshQueryValueschk=new HashMap();
			 hshQuerychk = new HashMap();
			 arrValuechk=new ArrayList();
			String roiflag="";
			if (rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selpostsanroiselection^" + strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				
				roiflag=Helper.correctNull((String)rs.getString("PS_MODIFY_TERMS"));
				if(roiflag.contains("MRI"))
				{
					hshValues.put("roiflagval","S");
				}
				
			}
			
			if(strAction.equalsIgnoreCase("postsanction") && Helper.correctNull((String)hshValues.get("roiflagval")).equalsIgnoreCase("S"))
			{
				strQuery1 = SQLParser.getSqlQuery("selretduedate^" + strApplicationNo);
				rs = DBUtils.executeQuery(strQuery1);
				
				if(rs.next())
				{
					loan_modintrateold=String.valueOf(Double.parseDouble(Helper.correctNull(rs.getString("loan_modintrate"))));
				}
				
				hshQueryValueschk=new HashMap();
				hshQuerychk = new HashMap();
				arrValuechk=new ArrayList();
				arrValuechk.add(loan_modintrateold);
				arrValuechk.add(strApplicationNo);
				hshQuerychk.put("strQueryId","updateROIInFInancleoldroi"); 
				hshQuerychk.put("arrValues",arrValuechk);
				hshQueryValueschk.put("size","1");
				hshQueryValueschk.put("1",hshQuerychk);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValueschk,"updateData");
				
			}
			
			
			
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strApplicationNo);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{

				if(Double.parseDouble(Helper.correctDouble(rs.getString("cloanprd")))!=Double.parseDouble(Helper.correctDouble((String)hshValues.get("txtloan_costloanprd"))))
				{
					hshQueryValueschk=new HashMap();
					hshQuerychk = new HashMap();
					arrValuechk=new ArrayList();
					arrValuechk.add(strApplicationNo);
					hshQuerychk.put("strQueryId","sel_misdupdateflag"); 
					hshQuerychk.put("arrValues",arrValuechk);
					hshQueryValueschk.put("size","1");
					hshQueryValueschk.put("1",hshQuerychk);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValueschk,"updateData");
				}
		}
		if(rs!=null)
		{
			rs.close();
		}
			strAction=correctNull((String)hshValues.get("hidAction"));
			if (strEditMode.equalsIgnoreCase("E"))
			{
				hshLoanProduct.put("appno", strApplicationNo);
				hshLoanProduct.put("strApp", correctNull((String) hshValues.get("strApp")));
				hshLoanProduct.put("prdcode", correctNull((String) hshValues.get("prdcode")));
				hshLoanProduct.put("hidEditLock", strGetLock);
				hshLoanProduct.put("radLoan", "Y");
				hshLoanProduct.put("hidEditMode", "E");
				hshLoanProduct.put("page", strPage);
				hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
				hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
				hshLoanProduct.put("strAppType", strAppType);
				hshResult = getLoanProducts(hshLoanProduct);
			}
			String strPrdCode=correctNull((String) hshValues.get("hidProductID"));
			String strOldPrdCode=correctNull((String) hshValues.get("hidOldProductCode"));
			HashMap hshTemp = new HashMap();
			HashMap hshGetDocFee = null;
			String strLoanDocFee = "", strLoanProcFee = "";
			String strPrepayCharge= "", strUpfrontFee="";
			if (!strPrdCode.trim().equals(""))
			{
				hshTemp.put("appid", strApplicationNo);
				hshTemp.put("prdcode", strPrdCode);
				hshTemp.put("recamt", correctNull((String) hshValues.get("txtloan_sancamt"))); // afetr
																							// slab
				hshGetDocFee = (HashMap) EJBInvoker.executeStateLess("perlimitofloan", hshTemp, "getDocFee");
				strLoanDocFee = Helper.correctDouble((String)hshGetDocFee.get("docfee"));
				strLoanProcFee = Helper.correctDouble((String) hshGetDocFee.get("procfeenew"));
				if(Helper.correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("1"))
				{
					strPrepayCharge=Helper.correctDouble((String)hshGetDocFee.get("strPrepayChargeFixed"));
				}
				else if(Helper.correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("2"))
				{
					strPrepayCharge=Helper.correctDouble((String)hshGetDocFee.get("strPrepayChargeFloating"));
				}
				strUpfrontFee=Helper.correctDouble((String)hshGetDocFee.get("strUpfrontFee"));
			}
			/***
			 * For Audit Trial Old Data - By Karthikeyan.S on 18/09/2013
			 */
			if(!strApplicationNo.equalsIgnoreCase(""))
			{				
				if(correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("LAD"))
				{
					
					if(rs !=null)
					{
						rs.close();
					}
					String strProdPurpose="";
					strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strApplicationNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));}
					/*
					 * 			For Purchase of Ready Built House and Used Vehicle loan, 
					 * 				Margin is based on age of the building / vehicle respectively
					 */
					if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")) 
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strApplicationNo);
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strApplicationNo);
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						String strDocRecvdOldAudit=Helper.correctNull((String)rs.getString("loan_docrecvd"));
						String strDocRecvdDescOldAudit="";
						if(strDocRecvdOldAudit.equalsIgnoreCase("1"))
						{
							strDocRecvdDescOldAudit="RTC";
						}
						else if(strDocRecvdOldAudit.equalsIgnoreCase("2"))
						{
							strDocRecvdDescOldAudit="Declaration by Applicant";
						}
						else if(strDocRecvdOldAudit.equalsIgnoreCase("3"))
						{
							strDocRecvdDescOldAudit="Other Agri Documents";
						}
						else if(strDocRecvdOldAudit.equalsIgnoreCase("4"))
						{
							strDocRecvdDescOldAudit="General";
						}
						String strSpecialCustOldAudit=Helper.correctNull((String)rs.getString("loan_specialcust"));
						String strSpecialCustDescOldAudit="";
						if(strSpecialCustOldAudit.equalsIgnoreCase("Y"))
						{
							strSpecialCustDescOldAudit="Yes";
						}
						else if(strSpecialCustOldAudit.equalsIgnoreCase("N"))
						{
							strSpecialCustDescOldAudit="No";
						}
						String strIntTypeDescOldAudit=Helper.correctNull((String)rs.getString("loan_inttype"));
						String strRepayTypeOldAudit=Helper.correctNull((String) rs.getString("loan_repaymenttype"));
						String strRepayTypeDescOldAudit="";
						if(strRepayTypeOldAudit.equalsIgnoreCase("1"))
						{
							strRepayTypeDescOldAudit= "Equated Monthly Installment";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("2"))
						{
							strRepayTypeDescOldAudit= "Non-EMI";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("3"))
						{
							strRepayTypeDescOldAudit= "Graduated installments";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("4"))
						{
							strRepayTypeDescOldAudit= "Step Up";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("5"))
						{
							strRepayTypeDescOldAudit= "Step Down";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("6"))
						{
							strRepayTypeDescOldAudit= "Taper Down";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("7"))
						{
							strRepayTypeDescOldAudit= "Balloon";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("8"))
						{
							strRepayTypeDescOldAudit= "Bullet";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("9"))
						{
							strRepayTypeDescOldAudit= "Flip Method";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("10"))
						{
							strRepayTypeDescOldAudit= "Equal Installments";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("11"))
						{
							strRepayTypeDescOldAudit= "Slab";
						}
						else if(strRepayTypeOldAudit.equalsIgnoreCase("12"))
						{
							strRepayTypeDescOldAudit= "OverDraft";
						}
						String strGovtSponsOldAudit=Helper.correctNull((String)rs.getString("loan_govt"));
						String strGovtSponsDescOldAudit="";
						if(strGovtSponsOldAudit.equalsIgnoreCase("1"))
						{
							strGovtSponsDescOldAudit="Yes";
						}
						else if(strGovtSponsOldAudit.equalsIgnoreCase("2"))
						{
							strGovtSponsDescOldAudit="No";
						}
						String strSchemeTypeOldAudit=Helper.correctNull((String)rs.getString("govt_scheme"));
						String strSchemeTypeDescOldAudit="";
						rs4 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"11^"+strSchemeTypeOldAudit);
						if(rs4.next())
							strSchemeTypeDescOldAudit = Helper.correctNull((String)rs4.getString("stat_data_desc1"));
						if(rs4!=null)
						rs4.close();
						String strSponsAgencyOldAudit=Helper.correctNull((String)rs.getString("loan_sponseragency"));
						String strSponseAgencyDescOldAudit="";
						rs4 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"3^"+strSponsAgencyOldAudit);
						if(rs4.next())
							strSponseAgencyDescOldAudit = Helper.correctNull((String)rs4.getString("stat_data_desc1"));
						if(rs4!=null)
						rs4.close();
						String strSubsidyTypeOldAudit=Helper.correctNull((String)rs.getString("loan_subsidytype"));
						String strSubsidyTypeDescOldAudit="";
						rs4 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"5^"+strSubsidyTypeOldAudit);
						if(rs4.next())
							strSubsidyTypeDescOldAudit = Helper.correctNull((String)rs4.getString("stat_data_desc1"));
						if(rs4!=null)
						rs4.close();
						strPrdTypeOld=Helper.correctNull((String)rs.getString("prd_type"));
						sbOldAudit.append("Application No=").append(Helper.correctNull((String)rs.getString("app_inwardno")))
								.append("~Party File No=").append(Helper.correctNull((String)rs.getString("loan_fileno")))
								.append("~Scheme Code=").append(Helper.correctNull((String)rs.getString("scheme_code")))
								.append("~Documents Received from Agriculturist=").append(strDocRecvdDescOldAudit)
								.append("~Specify=").append(Helper.correctNull((String)rs.getString("loan_docspecify")))
								.append("~Loan Product=").append(Helper.correctNull((String)rs.getString("category")))
								.append("-").append(Helper.correctNull((String)rs.getString("subcategory")))
								.append("-").append(Helper.correctNull((String)rs.getString("rfrom")))
								.append("-").append(Helper.correctNull((String)rs.getString("rangeto")))
								.append("-").append(Helper.correctNull((String)rs.getString("scheme_code")));
						if(strPrdTypeOld.equalsIgnoreCase("pG"))
						{
							sbOldAudit.append("~Interest Rate Defined p.a.%=").append(Helper.correctNull((String)rs.getString("loan_intrate")))
								.append("~Interest Rate Modified p.a.%=").append(Helper.correctNull((String)rs.getString("mintrate")))
								.append("~Interest Type=").append(strIntTypeDescOldAudit);
						}
							sbOldAudit.append("~Amount Requested=").append(Helper.correctNull((String)rs.getString("amtreqd")))
								.append("~Security Value=").append(Helper.correctNull((String)rs.getString("cloanprd")))
								.append("~Margin Offered by Borrower=").append(Helper.correctNull((String)rs.getString("offeredmargin")))
								.append("~Repayment Type=").append(strRepayTypeDescOldAudit)
								.append("~Special Customer=").append(strSpecialCustDescOldAudit)
								.append("~Govt. Sponsor Scheme=").append(strGovtSponsDescOldAudit);
						if(strGovtSponsOldAudit.equalsIgnoreCase("1"))
						{
							sbOldAudit.append("~Scheme Type=").append(strSchemeTypeDescOldAudit)
								.append("~Sponsor Agency=").append(strSponseAgencyDescOldAudit)
								.append("~Subsidy Type=").append(strSubsidyTypeDescOldAudit)
								.append("~Subsidy Amount=").append(Helper.correctDouble((String)rs.getString("loan_sub")));
						}
							sbOldAudit.append("~Application Received on=").append(Helper.correctNull((String)rs.getString("loan_receivedate")))
								.append("~Processed On=").append(Helper.correctNull((String)rs.getString("loan_filedon")));
					}
					if(rs!=null)
					{
						rs.close();
					}
				}
				/***
				 * For Retail Audit Trial Old Data - By Guhan.T on 10/10/2013
				 */				
				else
				{
					
					if(rs !=null)
					{
						rs.close();
					}
					String strProdPurpose="",strVehicleType="";
					strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strApplicationNo);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
					strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));
					}
					/*
					 * 			For Purchase of Ready Built House and Used Vehicle loan, 
					 * 				Margin is based on age of the building / vehicle respectively
					 */
					if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strApplicationNo);
					}
					else
					{
						strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strApplicationNo);
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						String strNoOfInstOldAudit="";
						String strPeriodOldAudit="";
						String strSecureOldAudit="";
						String strSecureAmtOldAudit="";
						String strServicedOldAudit="";
						strQuery=SQLParser.getSqlQuery("securesel^" + strApplicationNo);
						rs5 = DBUtils.executeQuery(strQuery);
						if (rs5.next())
						{
							strNoOfInstOldAudit=Helper.correctNull((String)rs5.getString("loan_noofinstallment"));
							strPeriodOldAudit=Helper.correctNull((String)rs5.getString("loan_periodicity"));
							strSecureOldAudit=Helper.correctNull((String)rs5.getString("loan_secure"));
							strSecureAmtOldAudit=Helper.correctNull((String)rs5.getString("loan_secureamount"));
							strServicedOldAudit=Helper.correctNull((String)rs5.getString("loan_servised"));
						}
						String strIntTypeoldaudit = "";
						String strIntTypeFormoldaudit = "";
						String strPeriodicityoldaudit = "";
						String strIntHolidayoldaudit = "";
						String strIntChargedoldaudit = "";
						String strGovtSchemeoldaudit = "";
						String strSchemeTypeoldaudit = "";
						String strSponsorAgncyoldaudit = "";
						String strSubsidyTypeoldaudit = "";
						String strWhSecuredoldaudit = "";
						String strPaymentModeoldaudit = "";
						String strRepayTypeoldaudit = "";
						String strFacTypeoldaudit = "";
						String strMeasrmntTypeoldaudit = "";
						String strUnioncreditsocietyoldaudit="";
						String strStaffFlagoldaudit="";
						ResultSet rs1 = null;
			//Interest Type
						if(Helper.correctNull((String) rs.getString("loan_inttype")).trim().equalsIgnoreCase("Fixed"))
							strIntTypeoldaudit = "Fixed";
						else if(Helper.correctNull((String) rs.getString("loan_inttype")).trim().equalsIgnoreCase("Floating"))
							strIntTypeoldaudit = "Floating";
						else if(Helper.correctNull((String) rs.getString("loan_inttype")).trim().equalsIgnoreCase("3"))
							strIntTypeoldaudit = "Slab";
			//Interest Type - Sub
						if(Helper.correctNull((String) rs.getString("loan_steptype")).trim().equalsIgnoreCase("1"))
							strIntTypeFormoldaudit = "Regular";
						else if(Helper.correctNull((String) rs.getString("loan_steptype")).trim().equalsIgnoreCase("2"))
							strIntTypeFormoldaudit = "StepUp";
						else if(Helper.correctNull((String) rs.getString("loan_steptype")).trim().equalsIgnoreCase("3"))
							strIntTypeFormoldaudit = "Step Down";
			//Interest Charged(Holiday period)
						if(strServicedOldAudit.equalsIgnoreCase("n"))
							strIntHolidayoldaudit = "No";
						else if(strServicedOldAudit.equalsIgnoreCase("y"))
							strIntHolidayoldaudit = "Yes";
						else if(strServicedOldAudit.equalsIgnoreCase("s"))
							strIntHolidayoldaudit = "Not Applicable";
			//Interest Charged 
						if(Helper.correctNull((String) rs.getString("loan_interestcharged")).trim().equalsIgnoreCase("1"))
							strIntChargedoldaudit = "To be paid as and when debited";
						else if(Helper.correctNull((String) rs.getString("loan_interestcharged")).trim().equalsIgnoreCase("2"))
							strIntChargedoldaudit = "To be accumulated and paid before commencement of repayment";
						else if(Helper.correctNull((String) rs.getString("loan_interestcharged")).trim().equalsIgnoreCase("3"))
							strIntChargedoldaudit = "To be accumulated and added to the principal to calculate EMI";
			//Govt.Sponsor Scheme
						if(Helper.correctNull((String) rs.getString("loan_govt")).trim().equalsIgnoreCase("1"))
							strGovtSchemeoldaudit = "Yes";
						else if(Helper.correctNull((String) rs.getString("loan_govt")).trim().equalsIgnoreCase("2"))
							strGovtSchemeoldaudit = "No";
			//Scheme Type
						strQuery=SQLParser.getSqlQuery("sel_static_desc_audit^"+"11^"+Helper.correctNull((String)rs.getString("govt_scheme")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
							strSchemeTypeoldaudit = Helper.correctNull((String)rs1.getString("stat_data_desc1"));
						if(rs1!=null)
							rs1.close();
			//Sponsor Agency
						strQuery=SQLParser.getSqlQuery("sel_static_desc_audit^"+"3^"+Helper.correctNull((String)rs.getString("loan_sponseragency")));
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
							strSponsorAgncyoldaudit = Helper.correctNull((String)rs1.getString("stat_data_desc1"));
						if(rs1!=null)
							rs1.close();
			//Periodicity of Installments
						if(strPeriodOldAudit.equalsIgnoreCase("m"))
							strPeriodicityoldaudit = "Monthly";
						else if(strPeriodOldAudit.equalsIgnoreCase("q"))
							strPeriodicityoldaudit = "Quarterly";
						else if(strPeriodOldAudit.equalsIgnoreCase("h"))
							strPeriodicityoldaudit = "Half-Yearly";
						else if(strPeriodOldAudit.equalsIgnoreCase("y"))
							strPeriodicityoldaudit = "Yearly";
						else if(strPeriodOldAudit.equalsIgnoreCase("n"))
							strPeriodicityoldaudit = "Not Applicable";
			//Subsidy Type
						rs1 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"5^"+Helper.correctNull((String)rs.getString("loan_subsidytype")));
						if(rs1.next())
							strSubsidyTypeoldaudit = correctNull((String)rs1.getString("stat_data_desc1"));
						if(rs1!=null)
							rs1.close();
			//Whether Secured
						if(strSecureOldAudit.equalsIgnoreCase("s"))
							strWhSecuredoldaudit = "Secured";
						else if(strSecureOldAudit.equalsIgnoreCase("u"))
							strWhSecuredoldaudit = "Unsecured";
						else if(strSecureOldAudit.equalsIgnoreCase("p"))
							strWhSecuredoldaudit = "Partially Secured";
			//Repayment Type
						if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("1"))
							strRepayTypeoldaudit = "Equated Monthly Installment";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("2"))
							strRepayTypeoldaudit = "Non-EMI";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("3"))
							strRepayTypeoldaudit = "Graduated installments";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("4"))
							strRepayTypeoldaudit = "Step Up";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("5"))
							strRepayTypeoldaudit = "Step Down";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("6"))
							strRepayTypeoldaudit = "Taper Down";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("7"))
							strRepayTypeoldaudit = "Balloon";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("8"))
							strRepayTypeoldaudit = "Bullet";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("9"))
							strRepayTypeoldaudit = "Flip Method";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("10"))
							strRepayTypeoldaudit = "Equal Installments";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("11"))
							strRepayTypeoldaudit = "Slab";
						else if(Helper.correctNull((String) rs.getString("loan_repaymenttype")).trim().equalsIgnoreCase("12"))
							strRepayTypeoldaudit = "OverDraft";
			//Mode of Payment
						if(Helper.correctNull((String) rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("S"))
							strPaymentModeoldaudit = "Recover From Salary";
						else if(Helper.correctNull((String) rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("P"))
							strPaymentModeoldaudit = "Post Dated Cheque";
						else if(Helper.correctNull((String) rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("E"))
							strPaymentModeoldaudit = "Transfer from Saving/Current a/c";
						else if(Helper.correctNull((String) rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("D"))
							strPaymentModeoldaudit = "Electronic Cheque Clearing(ECS)";
						else if(Helper.correctNull((String) rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("N"))
							strPaymentModeoldaudit = "Cash Recovery";
			//Measurement Type
						if(Helper.correctNull((String) rs.getString("LAND_MEASUREMENT")).trim().equalsIgnoreCase("g"))
							strMeasrmntTypeoldaudit = "Guntas";
						else if(Helper.correctNull((String) rs.getString("LAND_MEASUREMENT")).trim().equalsIgnoreCase("c"))
							strMeasrmntTypeoldaudit = "Cents";
			//Facility Type
						if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("1"))
							strFacTypeoldaudit="Short Term Loan";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("2"))
							strFacTypeoldaudit ="Term Loan-Medium";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("3"))
							strFacTypeoldaudit ="Long Term Loan";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("4"))
							strFacTypeoldaudit ="Secured-Over Draft";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("5"))
							strFacTypeoldaudit ="Clean-Over Draft";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("6"))
							strFacTypeoldaudit = "Cash Credit-Pledge";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("7"))
							strFacTypeoldaudit = "Cash Credit-Hypo of stock";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("8"))
							strFacTypeoldaudit = "Cash Credit-Hypo of Book/Debt";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("9"))
							strFacTypeoldaudit = "OD - Reducing";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("10"))
							strFacTypeoldaudit = "DLRI";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).trim().equalsIgnoreCase("11"))
							strFacTypeoldaudit = "ILROD-Inland loan Repayable on Demand";
						//for Union credit scoiety
						if(Helper.correctNull((String) rs.getString("loan_facility")).equalsIgnoreCase("1"))
							strUnioncreditsocietyoldaudit="Yes";
						else if(Helper.correctNull((String) rs.getString("loan_facility")).equalsIgnoreCase("2"))
							strUnioncreditsocietyoldaudit="No";
						strStaffFlagoldaudit=correctNull((String) hshValues.get("staff_flag"));
												
						
					sbOldAudit.append("Application Inward No=").append(Helper.correctNull((String)rs.getString("appno")))
					.append("~File No=").append(Helper.correctNull((String)rs.getString("loan_fileno")))
					.append("~Scheme Code=").append(Helper.correctNull((String)rs.getString("scheme_code")))
					.append("~Product=").append(Helper.correctNull((String)rs.getString("category")))
					.append("-").append(Helper.correctNull((String)rs.getString("subcategory")))
					.append("-").append(Helper.correctNull((String)rs.getString("rfrom")))
					.append("-").append(Helper.correctNull((String)rs.getString("rangeto")))
					.append("-").append(Helper.correctNull((String)rs.getString("scheme_code")))
					.append("~Interest Rate Defined p.a.=").append(Helper.correctNull((String)rs.getString("loan_intrate"))).append(
					"~Interest Rate Modified p.a.=").append(Helper.correctNull((String)rs.getString("mintrate"))).append(
					"~Interest Type=").append(strIntTypeoldaudit).append("(").append(strIntTypeFormoldaudit).append(")").append(
					"~Amount Requested=").append(Helper.correctNull((String)rs.getString("amtreqd"))).append(
					"~Cost of Project=").append(Helper.correctNull((String)rs.getString("cloanprd"))).append(
					"~Repayment Period (in months)=").append(Helper.correctNull((String)rs.getString("lreqterms"))).append(
					"~Initial Holiday/Gestation/ Moratorium Period (in Months)=").append(strNoOfInstOldAudit).append(
					"~Interest charged during Repayment Holiday=").append(strIntHolidayoldaudit).append(
					"~Interest charged=").append(strIntChargedoldaudit).append(
					"~Periodicity of Installments=").append(strPeriodicityoldaudit).append(
					"~Govt.Sponsor Scheme=").append(strGovtSchemeoldaudit);
					
					if(strGovtSchemeoldaudit.equals("Yes"))
					{
						sbOldAudit.append("~Scheme Type=").append(strSchemeTypeoldaudit).append(
						"~Sponsor Agency=").append(strSponsorAgncyoldaudit).append(
						"~Subsidy Amount=").append(Helper.correctNull((String)rs.getString("loan_sub"))).append(
						"~Subsidy Type=").append(strSubsidyTypeoldaudit);
				    }
					sbOldAudit.append("~Repayment Capacity(%)=").append(Helper.correctNull((String)rs.getString("loan_repaycapacity"))).append(
					"~Minimum Margin=").append(Helper.correctNull((String)rs.getString("downpay"))).append(
					"(").append(Helper.correctNull((String)rs.getString("margin_perct"))).append("%").append(")").append(
					"~Margin Offered by Borrower=").append(Helper.correctNull((String)rs.getString("offeredmargin")));
					double hidPrincipalRatio=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_principal")));
					double hidInterestRatio=Double.parseDouble(Helper.correctDouble((String)rs.getString("prd_interest")));
					sbOldAudit.append(
				"~Eligibility based on margin=").append(Helper.correctNull((String)rs.getString("raamount"))).append(
				"~Eligible Loan Amount=").append(Helper.correctNull((String)rs.getString("sancamount")));
					if(Helper.correctNull((String) rs.getString("indinfo_is_staff")).equalsIgnoreCase("Y"))
					{
						sbOldAudit.append("~Principal Installment=").append(Helper.correctNull((String)rs.getString("loan_emi")));
					}
					else
					{
						sbOldAudit.append("~Installment Amount=").append(Helper.correctNull((String)rs.getString("loan_emi")));
					}
					
					sbOldAudit.append("~Documentation Fee=").append(strLoanDocFee)
					.append("~Processing Fee=").append(strLoanProcFee)
					.append("~Whether Secured=").append(strWhSecuredoldaudit);
					if(strSecureOldAudit.equalsIgnoreCase("p"))
						sbOldAudit.append("~Amount Secured=").append(strSecureAmtOldAudit);
					sbOldAudit.append("~Repayment Type=").append(strRepayTypeoldaudit).append(
					"~Mode of Payment=").append(strPaymentModeoldaudit);
					if(Helper.correctNull((String)rs.getString("loan_modeofpay")).trim().equalsIgnoreCase("E"))
						sbOldAudit.append("~Operative Account Number=").append(Helper.correctNull((String)rs.getString("loan_operativeaccno")));
					//if(strPrdType.charAt(0)=='A')				
						//sbOldAudit.append("~Measurement Type=").append(strMeasrmntTypeoldaudit);
					sbOldAudit.append("~Facility Type=").append(strFacTypeoldaudit).append(
					"~Application Received on=").append(Helper.correctNull((String)rs.getString("loan_receivedate"))).append(
					"~Processed On=").append(Helper.correctNull((String)rs.getString("loan_filedon")));
					if(strStaffFlagoldaudit.equals("Y"))
					{
						sbOldAudit.append("~Loan From Union Bank Co-Operative Credit Society=").append(strUnioncreditsocietyoldaudit);
					}
					}
					if(rs!=null)
					{
						rs.close();
					}
				}
			}
			/***
			 * End - Audit Trial Old Data
			 */
			
			String strCollpercent = "";
			String strRecmdvalue = Helper.correctNull((String)hshValues.get("txtloan_sancamt"));
			strCollpercent = getCollateralpercent(strApplicationNo,strRecmdvalue);
			
			
			if (strAction.equalsIgnoreCase("insert") && !strApplicantid.equals(""))
			{
				if(strPrdType.equalsIgnoreCase("pG"))
				{
					int intCount=0;
					int intMaxCount=0;
					hshGLRecord=getGoldLoanCount(strAppOldID);
					intCount=Integer.parseInt(Helper.correctInt((String)hshGLRecord.get("hshCount")));
					intMaxCount=Integer.parseInt(Helper.correctInt((String)hshGLRecord.get("hshMaxCount")));
					if(intCount>intMaxCount)
					{
						strExp=strExp+"Cannot Create Proposal. The Applicant has already availed maximum number of Gold Loans";
						throw new Exception(strExp);
					}
				}
				String hidApploanType=correctNull((String) hshValues.get("hidApploanType"));	
				hshlockvalues = new HashMap();
				hshlockvalues.put("apptype", hidApploanType.toUpperCase());
				hshlockvalues.put("comapp_id", strApplicantid);
				hshlockvalues.put("strSolid", strSolid);
				strApplicationNo = (String) EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "getAppno");
				if(strApplicationNo.equalsIgnoreCase("new"))
				{
					throw new Exception("$ Cannot Create Proposal. Application Number Not found.");
				}
				if (!(strApplicationNo.equalsIgnoreCase("new") && hidApploanType.equalsIgnoreCase("")))
				{
					/* For inserting in application table */
					intUpdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add(strPrdCode);
					arrValues.add(correctNull((String) hshValues.get("strUserId")));
					arrValues.add(correctNull((String) hshValues.get("strOrgCode")));									
					arrValues.add(hidApploanType.toUpperCase());
					arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
					arrValues.add("R");
					arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add("Y");
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptclpu")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptcpc")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptroho")));
					arrValues.add("N");
					
					
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "insapplications");
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					/* For inserting in demographic table */
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;
					arrValues.add(strApplicationNo);
					arrValues.add(strApplicantid);
					arrValues.add("a");
					arrValues.add("");
					arrValues.add("2");
					arrValues.add(strAppOldID);
					arrValues.add("");
					arrValues.add("a");
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "perloandetailsdemoins");
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					/****
					 * For Updating in inward register
					 */
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("Y");
					arrValues.add("op");
					arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					/* For inserting in loandetails table */
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;//
					arrValues.add(strApplicationNo);
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_modintrate")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_amtreqd")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_costloanprd")));
					if (correctNull((String) hshValues.get("txtloan_sancamt")).equals(""))
					{
						arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_recmdamt")));
					}
					else
					{
						arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_sancamt")));
					}
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_downpay")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_recmdamt")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_reqterms")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("hidinterest")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtmonPay")));
					arrValues.add(correctNull((String) hshValues.get("txtloan_purposeofloan")));
					arrValues.add(correctNull((String) hshValues.get("txtloan_filedon")));
					arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));
					
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtMarginpercent")));
					arrValues.add(strLoanDocFee);
					arrValues.add(strLoanProcFee);
					arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));
					
					if (correctNull((String) hshValues.get("sel_interestcharge")).equalsIgnoreCase(""))
					{
						arrValues.add("1");
					}
					else
					{
						arrValues.add(correctNull((String) hshValues.get("sel_interestcharge")));
					}
				
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_repaycapacity")));
					arrValues.add(correctNull((String) hshValues.get("sel_steptype")));
					arrValues.add(correctNull((String) hshValues.get("txt_fileNo")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtloan_intrate")));
					arrValues.add(correctNull((String) hshValues.get("txt_receivedRH")));
					arrValues.add(correctNull((String) hshValues.get("selmodepayment")));
					arrValues.add(correctNull((String) hshValues.get("sel_facilitytype")));
					arrValues.add(correctNull((String) hshValues.get("selectgovt")));
					arrValues.add(correctNull((String) hshValues.get("sub")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtmarginoffered")));
					arrValues.add(correctNull((String) hshValues.get("measurementtype")));
					arrValues.add(correctNull((String) hshValues.get("schemetype")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txtInterestEMI")));
					arrValues.add(correctNull((String) hshValues.get("txt_operativeaccno")));
					arrValues.add(correctNull((String) hshValues.get("sel_sponser_agency")));
					arrValues.add(correctNull((String) hshValues.get("sel_subsidytype")));
					arrValues.add(correctNull((String) hshValues.get("co_operative")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_intcalcmode")));
					arrValues.add(strPrepayCharge);
					arrValues.add(strUpfrontFee);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_facility_cover")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_docreceived")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_specify")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_SpecialCust")));
					if(Helper.correctDouble((String) hshValues.get("hidinterest")).equalsIgnoreCase("Floating"))
					{
						arrValues.add("");
					}
					else
					{
						arrValues.add(Helper.correctNull((String)hshValues.get("hidInterestIndexId")));
					}
					arrValues.add(Helper.correctNull((String)hshValues.get("hidBaserate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehage")));
					arrValues.add(jtn.format(Double.parseDouble((Helper.correctDouble(strCollpercent)))));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_leaseperiod")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_monthgrossrent")));	
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_take_over")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidcreditrskpremium")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidbusstrategicpremium")));	
					arrValues.add(Helper.correctNull((String)hshValues.get("hidMCLRTableCode")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_mclrtype")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_unexpiredlock")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_downwardrevision")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_metloanpremium")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_agency")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_duedate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_migrationdate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_cg_fee")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_cg_int_rate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_wht_cgtmse")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_restr_scheme")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_interesttype")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidScore")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_Processed_Type")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_tenor")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_loan_amt")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_Account_no")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_amt")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_Funded_Comp_Name")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidCRP")));
					arrValues.add(Helper.correctNull((String)hshValues.get("hidBSP")));
					//arrValues.add(Helper.correctNull((String)hshValues.get("txt_restructdate")));
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSBankName"))); 
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSaccnttype"))); 
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSoperaccno"))); 
					arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSauthmode")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSifsccode")));
					arrValues.add(Helper.correctNull((String) hshValues.get("txt_intrate_effroi")));
					
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "perloandetailsins");
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					hshQuery.put("strQueryId","commworkflowins");
					arrValues.add(strApplicationNo);
					arrValues.add(strFromuserid);
					arrValues.add(strFromuserid);
					arrValues.add("1");
					arrValues.add("1");
					arrValues.add("C");
					
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					
					arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
					if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
					else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
					else
						arrValues.add("");
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					//for adding deviation 
					
					if(correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("LAD"))
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						intUpdatesize++;
						arrValues.add(correctNull((String) hshValues.get("dev_prop_no")));
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);				
						hshQuery.put("strQueryId","upd_permprop_no");
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));	
					}
					//EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					//hshQueryValues = new HashMap();
					//hshQueryValues.put("size", "1");
//					hshQuery=new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize++;
//					
//					arrValues.add(strApplicationNo);
//					hshQuery.put("arrValues", arrValues);
//					hshQuery.put("strQueryId", "securedel");
//					hshQueryValues.put(""+intUpdatesize, hshQuery);

					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;
					arrValues.add(strApplicationNo);
					if (correctNull((String) hshValues.get("txt_installments")).equals(""))
					{
						arrValues.add("0");
					}
					else
					{
						arrValues.add(correctNull((String) hshValues.get("txt_installments")));
					}
					arrValues.add(correctNull((String) hshValues.get("sel_peridicity")));
					arrValues.add(correctNull((String) hshValues.get("sel_secured")));
					arrValues.add(Helper.correctDouble((String) hshValues.get("txt_secured")));
					arrValues.add(Helper.correctNull((String) hshValues.get("interestservised")));
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "secureins");
					hshQueryValues.put(""+intUpdatesize, hshQuery);					
					hshQueryValues.put("size", Integer.toString(intUpdatesize));
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

					/*
					 * Added by suresh to insert products documents details in
					 * appdocuments table
					 * 
					 */
					
				    strQuery = SQLParser.getSqlQuery("getprodcode^"+ correctNull((String) hshValues.get("hidProductID")));
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("arrValues", arrValues);
						String status = "N";
						arrValues.add(correctNull((String)rs.getString("doc_id")));						
						arrValues.add(correctNull((String)rs.getString("doc_create_date")));
						
						if (correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("a"))
						{
							arrValues.add("PA");
						}
						else if (correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("i"))
						{
							arrValues.add("PI");
						}
						
						arrValues.add(correctNull(strApplicationNo));
						
						arrValues.add(status);

						hshQuery.put("strQueryId", "insappdocuments");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

					}
					hshLoanProduct.put("appno", strApplicationNo);
					hshLoanProduct.put("prdcode", correctNull((String) hshValues.get("prdcode")));
					hshLoanProduct.put("radLoan", "Y");
					hshLoanProduct.put("hidapplicantid", strApplicantid);
					hshLoanProduct.put("page", "ep");
					hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
					hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
					hshLoanProduct.put("strAppType", strAppType);
					/**
					 * Calculating and Inserting Repayment Capacity Based on Applicant/JointApplicant/CoObligant/Guarantor's income
					 */
					hshValues.put("strApplicationNo", strApplicationNo);
					
					ArrayList arrTerms=new ArrayList();
					ArrayList arrTermsId=new ArrayList();
					ArrayList arrTermsType=new ArrayList();  
					rs=DBUtils.executeLAPSQuery("apptermscond_prd_select^"+strPrdCode);
					while(rs.next())
					{
						arrTermsId.add(correctNull(rs.getString(1)));
						arrTerms.add(correctNull(rs.getString(2)));
						arrTermsType.add(correctNull(rs.getString(3)));
					}
					int intTerm=0;
					if(arrTermsId.size()> 0 && arrTermsId!=null)
					{
						intTerm=arrTermsId.size()-1;
						int intSize=0;
						 hshQueryValues = new HashMap();
						 hshQuery = new HashMap();
						 arrValues = null;
						for(int i=0;i<arrTermsId.size();i++)
						{
							hshQueryValues.put("size",String.valueOf(++intSize));
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","apptermscondins");
							arrValues=new ArrayList();
							arrValues.add(strApplicationNo);
							arrValues.add(String.valueOf(i));
							arrValues.add(correctNull((String)arrTerms.get(i)));
							arrValues.add("P");
							arrValues.add("N");
							arrValues.add("S");
							arrValues.add("");
							arrValues.add(correctNull((String)arrTermsType.get(i)));
							arrValues.add(correctNull((String)arrTermsId.get(i)));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intSize),hshQuery);
						}
						if(arrTermsId.size()>0)
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					//Terms & Cond
					{

						int intSize=0;
						rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"R"+"^"+"G"+"^"+"pre");							
						while(rs2.next())
						{
							hshQueryValues.put("size",String.valueOf(++intSize));
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","apptermscondins");
							arrValues=new ArrayList();
							arrValues.add(strApplicationNo);
							arrValues.add(String.valueOf(intTerm++));
							arrValues.add(Helper.correctNull(rs2.getString("fac_terms")));
							arrValues.add("P");
							arrValues.add("N");
							arrValues.add(Helper.correctNull(rs2.getString("fac_mode")));
							arrValues.add(Helper.correctNull(rs2.getString("fac_prepost")));
							arrValues.add("");
							arrValues.add(Helper.correctNull(rs2.getString("fac_sno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intSize),hshQuery);							

						}
						if(rs2 !=null){
						rs2.close();
					}
						rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"R"+"^"+"G"+"^"+"post");			
						while(rs2.next())
						{
							hshQueryValues.put("size",String.valueOf(++intSize));
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","apptermscondins");
							arrValues=new ArrayList();
							arrValues.add(strApplicationNo);
							arrValues.add(String.valueOf(intTerm++));
							arrValues.add(Helper.correctNull(rs2.getString("fac_terms")));
							arrValues.add("P");
							arrValues.add("N");
							arrValues.add(Helper.correctNull(rs2.getString("fac_mode")));
							arrValues.add(Helper.correctNull(rs2.getString("fac_prepost")));
							arrValues.add("");
							arrValues.add(Helper.correctNull(rs2.getString("fac_sno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intSize),hshQuery);							

						}
						
						if(rs2 !=null){
							rs2.close();
						}
						//Instructions to Branch terms&Conditions 
							rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"R"+"^"+"B");			
							while(rs2.next())
							{
								hshQueryValues.put("size",String.valueOf(++intSize));
								hshQuery=new HashMap();
								hshQuery.put("strQueryId","apptermscondins");
								arrValues=new ArrayList();
								arrValues.add(strApplicationNo);
								arrValues.add(String.valueOf(intTerm++));
								arrValues.add(Helper.correctNull(rs2.getString("fac_terms")));
								arrValues.add("P");
								arrValues.add("N");
								arrValues.add(Helper.correctNull(rs2.getString("fac_mode")));
								arrValues.add(Helper.correctNull(rs2.getString("fac_prepost")));
								arrValues.add("");
								arrValues.add(Helper.correctNull(rs2.getString("fac_sno")));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intSize),hshQuery);							

							}
							if(rs2 !=null){
								rs2.close();
							}
							//Specific Conditions 
							rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"R"+"^"+"P");			
							while(rs2.next())
							{
								hshQueryValues.put("size",String.valueOf(++intSize));
								hshQuery=new HashMap();
								hshQuery.put("strQueryId","apptermscondins");
								arrValues=new ArrayList();
								arrValues.add(strApplicationNo);
								arrValues.add(String.valueOf(intTerm++));
								arrValues.add(Helper.correctNull(rs2.getString("fac_terms")));
								arrValues.add("P");
								arrValues.add("N");
								arrValues.add(Helper.correctNull(rs2.getString("fac_mode")));
								arrValues.add(Helper.correctNull(rs2.getString("fac_prepost")));
								arrValues.add("");
								arrValues.add(Helper.correctNull(rs2.getString("fac_sno")));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intSize),hshQuery);							

							}
							if(rs2 !=null){
								rs2.close();
							}
							
							//Other conditions 
							rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"R"+"^"+"O");			
							while(rs2.next())
							{
								hshQueryValues.put("size",String.valueOf(++intSize));
								hshQuery=new HashMap();
								hshQuery.put("strQueryId","apptermscondins");
								arrValues=new ArrayList();
								arrValues.add(strApplicationNo);
								arrValues.add(String.valueOf(intTerm++));
								arrValues.add(Helper.correctNull(rs2.getString("fac_terms")));
								arrValues.add("P");
								arrValues.add("N");
								arrValues.add(Helper.correctNull(rs2.getString("fac_mode")));
								arrValues.add(Helper.correctNull(rs2.getString("fac_prepost")));
								arrValues.add("");
								arrValues.add(Helper.correctNull(rs2.getString("fac_sno")));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intSize),hshQuery);							

							}
							if(rs2 !=null){
								rs2.close();
							}
							if(intSize>0)
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
					String strNSDLRefNo="";
					if(strPrdType.equalsIgnoreCase("pE"))
					{
						if(rs != null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("sel_nsdl_refid^"+ correctNull((String) hshValues.get("txt_appinwardno")));
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next())
						{
							strNSDLRefNo=Helper.correctNull(rs.getString("nsdl_ref_id"));
						}
					}
					
					if(strPrdType.equalsIgnoreCase("pE") && !strNSDLRefNo.equalsIgnoreCase(""))
					{
						
						StringBuilder strOldAudit=new StringBuilder();

						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("sel_nsdlremarks^"+strNSDLRefNo);
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							strOldAudit.append("NSDL Status =").append(correctNull(rs.getString("nsdl_status")))
							.append("~Remarks= ").append(correctNull(rs.getString("nsdl_remarks")));
						}
						
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strApplicationNo);  
						arrValues.add("02");
						arrValues.add("In Process");
						arrValues.add(strNSDLRefNo);  
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","updNSDLAppno");
						hshQueryValues.put("1", hshQuery);
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						arrValues.add(strApplicationNo);
						arrValues.add(strNSDLRefNo);  
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","ins_educoursedetails");
						hshQueryValues.put("2", hshQuery);
						hshQueryValues.put("size","2");
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
						StringBuilder sbAuditTrial1=new StringBuilder();
						sbAuditTrial1.append("NSDL Status = 02").append("~Remarks= In Process");

						AuditTrial.auditNewLog(hshValues,"432",strNSDLRefNo,sbAuditTrial1.toString(),strOldAudit.toString());

						String eduyearexp1[]= new String[27];
						String eduyearexp2[]= new String[27];
						String eduyearexp3[]= new String[27];
						String eduyearexp4[]= new String[27];
						String eduyearexp5[]= new String[27];
						String eduyearexp6[]= new String[27];
						String eduyearsrc1[]= new String[27];
						String eduyearsrc2[]= new String[27];
						String eduyearsrc3[]= new String[27];
						String eduyearsrc4[]= new String[27];
						String eduyearsrc5[]= new String[27];
						String eduyearsrc6[]= new String[27];
						String totalexpenses[]= new String[27];
						String edusec_expenses[]= new String[27];
						
						String strSno[]={"College Fees","Books/Equipments/instruments/uniforms","Cost of Computer","Examination Fees","Library  / Laboratory Fee","Travel Expenses","Refundable Deposit","Boarding	Fee/Expenses","Hostel Fees or Lodge Rent","Caution Deposit","Insurance Premium","Sundries","","","","Loan Amount from UBI Bank","Own Savings","Provident Fund Withdrawal","Disposal of Investments","FDs","Shares","LIC Policies","","","","",""};
						
						if(rs != null)
						{
							rs.close();
						}
						rs=DBUtils.executeLAPSQuery("sel_educourseexp^"+strNSDLRefNo);
						while(rs.next())
						{
							if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("1"))
							{
								eduyearexp1[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp1[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp1[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp1[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp1[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp1[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc1[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc1[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
							else if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("2"))
							{
								eduyearexp2[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp2[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp2[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp2[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp2[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp2[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc2[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc2[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
							else if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("3"))
							{
								eduyearexp3[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp3[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp3[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp3[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp3[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp3[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc3[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc3[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
							else if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("4"))
							{
								eduyearexp4[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp4[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp4[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp4[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp4[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp4[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc4[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc4[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
							else if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("5"))
							{
								eduyearexp5[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp5[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp5[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp5[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp5[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp5[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc5[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc5[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
							else if(Helper.correctNull(rs.getString("CAF_YR_YEARVAL")).equalsIgnoreCase("6"))
							{
								eduyearexp6[0]=Helper.correctNull(rs.getString("CAF_YR_TUTIONFEE"));
								eduyearexp6[3]=Helper.correctNull(rs.getString("CAF_YR_EXAMFEE"));
								eduyearexp6[1]=Helper.correctNull(rs.getString("CAF_YR_BOOKSANDSTATIONARY"));
								eduyearexp6[2]=Helper.correctNull(rs.getString("CAF_YR_EQUIPMENTCOMPUTER"));
								eduyearexp6[8]=Helper.correctNull(rs.getString("CAF_YR_HOSTELEXPENSES"));
								eduyearexp6[11]=Helper.correctNull(rs.getString("CAF_YR_SUNDRIESTRAVEL"));
								eduyearsrc6[0]=Helper.correctNull(rs.getString("CAF_YR_LOANREQUIRED"));
								eduyearsrc6[7]=Helper.correctNull(rs.getString("CAF_YR_SCHOLARSHIPAMOUNT"));
							}
						}
						
						int count = 0,expensesid = 0,sourceid = 0;
						int  expenses1 = 0,source1= 0,source2=0,source3= 0,source4=0,source5=0,source6=0,totalsource=0;
						double dblTemp=0.00,dblTemp2=0.00;
						for(int k=0;k<27;k++)
						{	
							hshQueryValues = new HashMap();
							arrValues=new ArrayList();
							hshQuery=new HashMap();
							dblTemp=Double.parseDouble(Helper.correctDouble(eduyearsrc1[source1]))+
							Double.parseDouble(Helper.correctDouble(eduyearsrc2[source2]))+
							Double.parseDouble(Helper.correctDouble(eduyearsrc3[source3]))+
							Double.parseDouble(Helper.correctDouble(eduyearsrc4[source4]))+Double.parseDouble(Helper.correctDouble(eduyearsrc5[source5]))+
							Double.parseDouble(Helper.correctDouble(eduyearsrc6[source6]));
							
							hshQuery.put("strQueryId","ins_educoursedet");
							arrValues.add(strApplicationNo);
							count = count + 1;
							
							if(count>15)
							{
								sourceid = sourceid +1;
								if(Integer.toString(sourceid)=="")
									arrValues.add("0");
								else
									arrValues.add(correctNull(Integer.toString(sourceid)));
							}
							else
							{
								expensesid = expensesid +1;
								if(Integer.toString(sourceid)=="")
									arrValues.add("0");
								else
									arrValues.add(correctNull(Integer.toString(expensesid)));
							}
							if (count > 15)
								arrValues.add("s");
							else
								arrValues.add("e");
							arrValues.add(strSno[k]);
							if (count > 15)
							{		
								if(correctNull(eduyearsrc1[source1])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc1[source1]));
								source1 = source1 + 1;
							} else if(correctNull(eduyearexp1[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp1[k]));
							if (count > 15)
							{		
								if(correctNull(eduyearsrc2[source2])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc2[source2]));
								source2 = source2 + 1;
							} else if(correctNull(eduyearexp2[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp2[k]));
							if (count > 15)
							{	
								if(correctNull(eduyearsrc3[source3])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc3[source3]));
								source3 = source3 + 1;
							} else if(correctNull(eduyearexp3[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp3[k]));
							if (count > 15)
							{
								if(correctNull(eduyearsrc4[source4])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc4[source4]));
								source4 = source4 + 1;
							} else if(correctNull(eduyearexp4[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp4[k]));
							if (count > 15)
							{		
								if(correctNull(eduyearsrc5[source5])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc5[source5]));
								source5 = source5 + 1;
							} else if(correctNull(eduyearexp5[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp5[k]));
							if (count > 15)
							{
								if(correctNull(eduyearsrc6[source6])=="")
									arrValues.add("0.0");
								else
									arrValues.add(correctNull(eduyearsrc6[source6]));
								source6 = source6 + 1;
							} else if(correctNull(eduyearexp6[k])=="")
								arrValues.add("0.0");
							else
								arrValues.add(correctNull(eduyearexp6[k]));
							arrValues.add(String.valueOf(dblTemp));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size","1");
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
					
					updateRepaymentCapacityValue(hshValues);
					hshResult = getLoanProducts(hshLoanProduct);
				}
				//updAppNumforSARAL(strApplicationNo,correctNull((String) hshValues.get("txt_appinwardno")));
				resflag=true;
			}
			else if (strAction.equalsIgnoreCase("update"))
			{
				String strCGTMSE_APPLICABLE="";
				strQuery=SQLParser.getSqlQuery("applications_CGTMSEFlag^"+strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);							
				if (rs.next()){
					strCGTMSE_APPLICABLE =  Helper.correctNull((String)rs.getString("LOAN_CGTMSE_APPLICABLE"));
				}
				
				if(rs != null){
					rs.close();	
				}
				
				strQuery=SQLParser.getSqlQuery("applications_select^"+strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);							
				if (rs.next()){
					strappprdcode =  Helper.correctNull((String)rs.getString("app_prdcode"));
				}
				
				if(rs != null){
					rs.close();	
				}
				
				String cgtmseappl="";
				strQuery=SQLParser.getSqlQuery("getlreq^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					cgtmseappl=Helper.correctNull((String)rs.getString("LOAN_CGTMSE_APPLICABLE"));
				}
				
				/* For updating in application table */
				intUpdatesize++;
				arrValues.add(correctNull((String) hshValues.get("hidProductID")));
				arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
				arrValues.add("A");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptclpu")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptcpc")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptroho")));
				arrValues.add("N");
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "updapplications");
				hshQueryValues.put(""+intUpdatesize, hshQuery);

				/* For inserting in demographic table */
				/*arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(strApplicantid);
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsdemoupd");
				hshQueryValues.put(""+intUpdatesize, hshQuery);*/
				
				if(!(correctNull((String) hshValues.get("txt_appinwardno")).equals(correctNull((String) hshValues.get("inwardno")))))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("N");
					arrValues.add("");
					arrValues.add(correctNull((String) hshValues.get("inwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize, hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("Y");
					arrValues.add("op");
					arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize, hshQuery);
				}

				/* For inserting in loandetails table */
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;///
				arrValues.add(correctNull((String) hshValues.get("txtloan_modintrate")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_amtreqd")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_costloanprd")));
				String strLoanSancAmt=correctNull((String) hshValues.get("txtloan_sancamt"));
				String strLoanRecmdAmt=correctNull((String) hshValues.get("txtloan_recmdamt"));
				if (strLoanSancAmt.equals(""))
				{
					strLoanSancAmt=strLoanRecmdAmt;
				}
				double dblAmtRecommended=Double.parseDouble(Helper.correctDouble(strLoanSancAmt));
				double dblMPBFAmt=0.00;
				strQuery1=SQLParser.getSqlQuery("selectmpbfeligibleamount^"+strApplicationNo);
				rs3=DBUtils.executeQuery(strQuery1);
				if(rs3.next())
				{
					dblMPBFAmt=Double.parseDouble(Helper.correctDouble((String)rs3.getString("mpbf_eligibleamount")));
				}
				if((dblMPBFAmt!=0.00)&&(dblMPBFAmt<dblAmtRecommended))
				{
					dblAmtRecommended=dblMPBFAmt;
				}
				arrValues.add(jtn.format(dblAmtRecommended));
				arrValues.add(correctNull((String) hshValues.get("txtloan_downpay")));
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_recmdamt")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_reqterms")));
				arrValues.add(correctNull((String) hshValues.get("hidinterest")));
				arrValues.add(correctNull((String) hshValues.get("txtmonPay")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_purposeofloan")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_filedon")));
				arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));
				arrValues.add(correctNull((String) hshValues.get("txtMarginpercent")));
				arrValues.add(strLoanDocFee);
				arrValues.add(strLoanProcFee);
				arrValues.add(correctNull((String) hshValues.get("txt_branchreference")));
				if (correctNull((String) hshValues.get("sel_interestcharge")).equalsIgnoreCase(""))
				{
					arrValues.add("1");
				}
				else
				{
					arrValues.add(correctNull((String) hshValues.get("sel_interestcharge")));
				}
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_repaycapacity")));
				arrValues.add(correctNull((String) hshValues.get("sel_steptype")));
				arrValues.add(correctNull((String) hshValues.get("txt_fileNo")));
				arrValues.add(correctNull((String) hshValues.get("txtloan_intrate")));
				arrValues.add(correctNull((String) hshValues.get("txt_receivedRH")));
				arrValues.add(correctNull((String) hshValues.get("selmodepayment")));
				arrValues.add(correctNull((String) hshValues.get("sel_facilitytype")));
				arrValues.add(correctNull((String) hshValues.get("selectgovt")));
				arrValues.add(correctNull((String) hshValues.get("sub")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtmarginoffered")));
				arrValues.add(correctNull((String) hshValues.get("measurementtype")));
				arrValues.add(correctNull((String) hshValues.get("schemetype")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txtInterestEMI")));
				arrValues.add(correctNull((String) hshValues.get("txt_operativeaccno")));
				arrValues.add(correctNull((String) hshValues.get("sel_sponser_agency")));
				arrValues.add(correctNull((String) hshValues.get("sel_subsidytype")));
				arrValues.add(correctNull((String) hshValues.get("co_operative")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_intcalcmode")));
				arrValues.add(strPrepayCharge);
				arrValues.add(strUpfrontFee);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_facility_cover")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_docreceived")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_specify")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_SpecialCust")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_vehage")));
				if(Helper.correctDouble((String) hshValues.get("hidinterest")).equalsIgnoreCase("Floating"))
				{
					arrValues.add("");
				}
				else
				{
					arrValues.add(Helper.correctNull((String)hshValues.get("hidInterestIndexId")));
				}
				arrValues.add(Helper.correctNull((String)hshValues.get("hidBaserate")));
				arrValues.add(strCollpercent);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_leaseperiod")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_monthgrossrent")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_take_over")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcreditrskpremium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidbusstrategicpremium")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("hidMCLRTableCode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_mclrtype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_unexpiredlock")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_downwardrevision")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_metloanpremium")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_agency")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_duedate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_migrationdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_cg_fee")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_cg_int_rate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_wht_cgtmse")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_restr_scheme")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_interesttype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidScore")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Processed_Type")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_tenor")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_loan_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_Account_no")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_premium_amt")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_Funded_Comp_Name")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidCRP")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidBSP")));
			//	arrValues.add(Helper.correctNull((String)hshValues.get("txt_restructdate")));
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSBankName"))); 
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSaccnttype"))); 
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSoperaccno"))); 
				arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSauthmode")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSifsccode")));
				arrValues.add(Helper.correctNull((String) hshValues.get("txt_intrate_effroi")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "perloandetailsupd");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				hshQueryValues.put("size",""+intUpdatesize);
				
				if(correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("LAD"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(correctNull((String) hshValues.get("dev_prop_no")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_permprop_no");
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));	
				}
				
				if(strPrdType.equalsIgnoreCase("pR") && Helper.correctNull((String)hshValues.get("hidOtherDepFlag")).equalsIgnoreCase("Y"))
				{
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					intUpdatesize++;
					arrValues.add(correctNull((String) hshValues.get("txtloan_modintrate")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);				
					hshQuery.put("strQueryId","upd_loanagainstdeposit_intrate");
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));	
				}
				
				strQuery=SQLParser.getSqlQuery("securesel^"+strApplicationNo);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					if(correctNull((String) hshValues.get("selrepaymenttype")).equalsIgnoreCase("2") && !Helper.correctNull(rs.getString("loan_periodicity")).equalsIgnoreCase(correctNull((String) hshValues.get("sel_peridicity"))))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId", "delete_retail_repayschedule");
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));	
						
					}
				}
				
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				
				// deleting cgtmse data if CGTMSE is NO by raja
				if(Helper.correctNull((String)hshValues.get("sel_wht_cgtmse")).equalsIgnoreCase("N"))
				{
					hshQueryValues = new HashMap();
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "del_cgtmsedata");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
					/*strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strApplicationNo+"^"+"1");
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						if(Helper.correctNull((String)rs.getString("app_guarantee")).equalsIgnoreCase("11"))
						{
							//added by santhosh
							hshQueryValues = new HashMap();
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQueryValues.put("size", "1");
							arrValues.add(strApplicationNo);
							arrValues.add("1");
							hshQuery.put("arrValues", arrValues);
							hshQuery.put("strQueryId", "update_mis_appdetailssno");
							hshQueryValues.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}	
					}	*/
					
				}

				// Start of Modified for secured loan and Installements
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "2");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "securedel");
				hshQueryValues.put("1", hshQuery);

				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(strApplicationNo);
				if (correctNull((String) hshValues.get("txt_installments")).equals(""))
				{
					arrValues.add("0");
				}
				else
				{
					arrValues.add(correctNull((String) hshValues.get("txt_installments")));
				}
				arrValues.add(correctNull((String) hshValues.get("sel_peridicity")));
				arrValues.add(correctNull((String) hshValues.get("sel_secured")));
				arrValues.add(Helper.correctDouble((String) hshValues.get("txt_secured")));
				arrValues.add(Helper.correctNull((String) hshValues.get("interestservised")));
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "secureins");
				hshQueryValues.put("2", hshQuery);
				if (!strApplicationNo.equalsIgnoreCase("new"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size", "1");
				
				arrValues.add(strApplicationNo);
				
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "del_date");
				hshQueryValues.put("1", hshQuery);
				
				if (!strApplicationNo.equalsIgnoreCase("new"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				
				
				// End of Modified for secured loan and Installements

				/* calling the getloanproducts to obtain the update values */
				hshLoanProduct.put("appno", strApplicationNo);
				hshLoanProduct.put("strApp", correctNull((String) hshValues.get("strApp")));
				hshLoanProduct.put("prdcode", correctNull((String) hshValues.get("prdcode")));
				//hshlockvalues.put("strUserId", correctNull((String) hshValues.get("strUserId")));
				//EJBInvoker.executeStateLess("appeditlock", hshlockvalues, "unLockApplication");
				hshLoanProduct.put("hidEditLock", "n");
				hshLoanProduct.put("radLoan", "Y");
				hshLoanProduct.put("page", "ep");
				hshLoanProduct.put("hidapplicantid", strApplicantid);
				hshLoanProduct.put("strUserId", correctNull((String) hshValues.get("strUserId")));
				hshLoanProduct.put("strGroupRights", correctNull((String) hshValues.get("strGroupRights")));
				hshLoanProduct.put("strAppType", strAppType);
				if(strAction.equalsIgnoreCase("update") || strAction.equalsIgnoreCase("insert"))
				{
					String noofinstall = Helper.correctNull((String) hshValues.get("txtloan_reqterms"));
					String sel_payment = Helper.correctNull((String) hshValues.get("sel_peridicity"));
					String installment = Helper.correctInt((String) hshValues.get("txt_installments"));
					String duedate = "";
					String noofinsminusholiday = Helper.formatDoubleValue(Double.parseDouble(noofinstall) 
														- Double.parseDouble(installment));
					
					int t = 0;

					if (sel_payment.equalsIgnoreCase("m")) {
						t = Integer.parseInt(installment) + 1;

					} else if (sel_payment.equalsIgnoreCase("q")) {
						t = Integer.parseInt(installment) + 3;
					} else if (sel_payment.equalsIgnoreCase("h")) {
						t = Integer.parseInt(installment) + 6;
					} else if (sel_payment.equalsIgnoreCase("y")) {
						t = Integer.parseInt(installment) + 12;
					}

					//  String pdate = Helper.correctNull((String)hshValues.get("app_processdate"));
					String pdate = Helper.correctNull((String) hshValues.get("txtloan_filedon"));
							

					if (!pdate.equalsIgnoreCase("")) {
						int pdays = Integer.parseInt(pdate.substring(0, 2));
						int pdays1 = pdays;
						int leaps = 0;
						int pmonths = Integer.parseInt(pdate.substring(3, 5));

						int pyears = Integer.parseInt(pdate.substring(6, 10));

						pmonths = pmonths + t;

						if (pmonths > 12) {
							int tempyear = pmonths / 12;

							pmonths = pmonths % 12;
							if (pmonths == 0) {
								pmonths = 12;
								tempyear--;
							}
							pyears = pyears + tempyear;
						}

						if (pmonths == 1 || pmonths == 3 || pmonths == 5
								|| pmonths == 7 || pmonths == 8 || pmonths == 10
								|| pmonths == 12) {

							if (pdays == 31) {
								pdays = pdays + 0;
								pdays1 = 31;
							} else {
								pdays1 = pdays;
							}

						} else if (pmonths == 4 || pmonths == 6 || pmonths == 9
								|| pmonths == 11) {
							if (pdays == 31 || pdays1 == 30) {
								pdays = pdays + 0;
								pdays1 = 30;
							} else {
								pdays1 = pdays;
							}

						}
						leaps = pyears % 4;
						if ((pmonths == 2) && (leaps == 0))

						{
							if (pdays == 31 || pdays == 30 || pdays == 29) {
								pdays1 = 29;
							} else {
								pdays1 = pdays;
							}
						} else if (pmonths == 2) {
							if (pdays == 31 || pdays == 30 || pdays == 29
									|| pdays == 28) {
								pdays1 = 28;
							} else {
								pdays1 = pdays;
							}
						}

						if (pmonths < 10) {
							duedate = Integer.toString(pdays1) + "/0"
									+ Integer.toString(pmonths) + "/"
									+ Integer.toString(pyears);
						} else {
							duedate = Integer.toString(pdays1) + "/"
									+ Integer.toString(pmonths) + "/"
									+ Integer.toString(pyears);
						}

						pmonths = pmonths + 1;
						if (pmonths > 12) {
							pmonths = 1;
							pyears = pyears + 1;
						}

						if (sel_payment.equalsIgnoreCase("n")) {
							duedate = "";
						}

					}
					
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
			  		hshQuery=new HashMap();
					hshQueryValues.put("size","1");
					arrValues.add(noofinsminusholiday);
					arrValues.add(sel_payment);
					arrValues.add(installment);
					arrValues.add(duedate);
					arrValues.add(strApplicationNo);
					arrValues.add(strPrd);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","agr_upd_bullockrepay");
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				if(rs != null){
					rs.close();	
				}
				/**
				 * Calculating and Inserting Repayment Capacity Based on Applicant/JointApplicant/CoObligant/Guarantor's income
				 */
				hshValues.put("strApplicationNo", strApplicationNo);
				if(!strPrdCode.equalsIgnoreCase(strOldPrdCode))
				{
					hshValues.put("appno", strApplicationNo);
					hshValues.put("selsno", "1");
					hshValues.put("strProductCode", strOldPrdCode);
					hshValues.put("strModuleType", "P");
					FacilitiesBean fac=new FacilitiesBean();
					fac.updateMISCBSDetails(hshValues);
					
					if(Helper.correctNull((String)hshValues.get("strProductType")).equalsIgnoreCase("pE"))
					{
						String strProdPurpose="";
						strQuery = SQLParser.getSqlQuery("findapptype^" + strApplicationNo);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
							strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
				  		hshQuery=new HashMap();
						hshQueryValues.put("size","1");
						arrValues.add(strProdPurpose);
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","upd_eduparticulars");
						hshQueryValues.put("1",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				updateRepaymentCapacityValue(hshValues);
				hshResult = getLoanProducts(hshLoanProduct);
				//if(!(correctNull((String) hshValues.get("txt_appinwardno")).equals(correctNull((String) hshValues.get("inwardno")))))
				//{
				//	updAppNumforSARAL(strApplicationNo,correctNull((String) hshValues.get("txt_appinwardno")));
				//}
				resflag=true;
				
				
				//Govt sponser Scheme changes
				if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("P") && Helper.correctNull((String)hshValues.get("hidPSterms")).contains("MODGSS@"))
				{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
			  		hshQuery=new HashMap();
					hshQueryValues.put("size","1");
					arrValues.add(Helper.correctNull((String)hshValues.get("selectgovt")));
					arrValues.add(Helper.correctNull((String)hshValues.get("schemetype")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("sub")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_sponser_agency")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_subsidytype")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_agency")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_appinwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","upd_appinwardreg");
					hshQueryValues.put("1",hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				String propCgtmseAppl=Helper.correctNull((String)hshValues.get("sel_wht_cgtmse"));
				if(!cgtmseappl.equals(propCgtmseAppl))
				{
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","upd_msmeflagchk");
					arrValues.add("N");
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
	    			hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				if(!Helper.correctNull((String)hshValues.get("sel_wht_cgtmse")).equalsIgnoreCase(strCGTMSE_APPLICABLE))
				{
					hshQueryValues = new HashMap();
					hshQueryValues.put("size","3");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","del_misappdetails");
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","del_misappdisplayscreen");
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","del_misappclassification");
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("3",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
			}
			else if (strAction.equalsIgnoreCase("delete"))
			{
				String strInwardno = correctNull((String)hshValues.get("inwardno"));
				intUpdatesize=0;
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(strApplicationNo);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "delapplications");
				hshQueryValues.put(""+intUpdatesize, hshQuery);
				
				
			/*	if(!(strInwardno.equals("")))
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					intUpdatesize++;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("N");
					arrValues.add("");
					arrValues.add(correctNull((String)hshValues.get("inwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
				}*/
				hshQueryValues.put("size", ""+intUpdatesize);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				hshResult.put("hidEditMode", "D");
				resflag=true;
				if(!(strInwardno.equals("")))
				{
					updAppNumforSARAL("",correctNull((String) hshValues.get("txt_appinwardno")));
				}
				
				if(rs != null){
					rs.close();	
				}
				
				strQuery = SQLParser.getSqlQuery("sel_facilityrequired^"+strApplicationNo);
				strQuery=strQuery+"and APP_RENEW_FLAG in ('R','S','P')";
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues=new HashMap();
					arrValues.add("");
					arrValues.add(Helper.correctNull(rs.getString("app_parent_appno")));
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","renew_applicationflag");
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
				
			}
			/*else
			{
				HashMap hshAppData = new HashMap();
				hshAppData.put("appno", strApplicationNo);
				hshAppData = (HashMap) EJBInvoker.executeStateLess("appeditlock", hshAppData, "getAppData");
				hshResult.put("appno", strApplicationNo);
				hshResult.put("hshAppData", hshAppData);
			}*/
			/** 
			 *  If loan product is changed, corresponding entries in Deviation table must be deleted
			 *  By Karthikeyan.S
			 */
			String strDeleteDeviationFlag=Helper.correctNull((String)hshValues.get("hidDeleteDeviationFlag"));
			String strOldPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update"))
			{
				if(strDeleteDeviationFlag.trim().equalsIgnoreCase("true"))
				{
					/* Updating Documents table */ 
					/*hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					arrValues.add(correctNull(strApplicationNo));
					hshQuery.put("strQueryId", "appdocuments_delete");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size", "1");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					if(rs!=null)
					{
						rs.close();
					}
					hshQueryValues=new HashMap();
					strQuery = SQLParser.getSqlQuery("getprodcode^"+ correctNull((String) hshValues.get("hidProductID")));
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size", "1");
						hshQuery.put("arrValues", arrValues);
						String status = "N";
						arrValues.add(correctNull(rs.getString("doc_id")));						
						arrValues.add(correctNull(rs.getString("doc_create_date")));
						
						if (correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("a"))
						{
							arrValues.add("PA");
						}
						else if (correctNull(rs.getString("doc_doctype")).equalsIgnoreCase("i"))
						{
							arrValues.add("PI");
						}
						
						arrValues.add(correctNull(strApplicationNo));
						
						arrValues.add(status);

						hshQuery.put("strQueryId", "insappdocuments");
						hshQueryValues.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");

					}*/
					/* Deleting entries in Deviation table */
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delete_app_deviation");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					if(strOldPrdType.equalsIgnoreCase("pH"))
					{
						/* Deleting entries in Property Details table */
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","delete_per_home");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					else if(strOldPrdType.equalsIgnoreCase("pA"))
					{
						/* Deleting entries in Proposed Assets table */
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","delete_per_auto");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					else if(strOldPrdType.equalsIgnoreCase("pR"))
					{
						/* Updating Deposit Details */
						hshQueryValues=new HashMap();
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","delete_depositdet");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					else if(strOldPrdType.equalsIgnoreCase("pG")||strOldPrdType.equalsIgnoreCase("aH"))
					{
						String strGoldSecID="";
						strQuery=SQLParser.getSqlQuery("sel_goldsecid^"+strApplicationNo);
						rs2=DBUtils.executeQuery(strQuery);
						while(rs2.next())
						{
							strGoldSecID=Helper.correctNull((String)rs2.getString("agr_secid"));
							if(!strGoldSecID.equalsIgnoreCase(""))
							{
								hshQueryValues=new HashMap();
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strGoldSecID);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","del_jeweldetail");
								hshQueryValues.put("1",hshQuery);
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strGoldSecID);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","del_ownership_securities");
								hshQueryValues.put("2",hshQuery);
								arrValues=new ArrayList();
								hshQuery=new HashMap();
								arrValues.add(strGoldSecID);
								hshQuery.put("arrValues",arrValues);
								hshQuery.put("strQueryId","del_securities");
								hshQueryValues.put("3",hshQuery);
								hshQueryValues.put("size","3");
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
						}
						/* Updating Gold Ornaments */
						hshQueryValues=new HashMap();
						arrValues=new ArrayList();
						hshQuery=new HashMap();
						arrValues.add(strApplicationNo);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","delete_golddet");
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					/* Updating Terms & Conditions */
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","apptermscond_delete");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					ArrayList arrTerms=new ArrayList();
					ArrayList arrTermsId=new ArrayList();
					ArrayList arrTermsType=new ArrayList();  
					rs=DBUtils.executeLAPSQuery("apptermscond_prd_select^"+strPrdCode);
					while(rs.next())
					{
						arrTermsId.add(correctNull(rs.getString(1)));
						arrTerms.add(correctNull(rs.getString(2)));
						arrTermsType.add(correctNull(rs.getString(3)));
					}				 
					if(arrTermsId.size()> 0 && arrTermsId!=null)
					{
						int intSize=0;
						 hshQueryValues = new HashMap();
						 hshQuery = new HashMap();
						 arrValues = null;
						for(int i=0;i<arrTermsId.size();i++)
						{
							hshQueryValues.put("size",String.valueOf(++intSize));
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","apptermscondins");
							arrValues=new ArrayList();
							arrValues.add(strApplicationNo);
							arrValues.add(correctNull(Integer.toString(i)));
							arrValues.add(correctNull((String)arrTerms.get(i)));
							arrValues.add("P");
							arrValues.add("N");
							arrValues.add("S");
							arrValues.add("");
							arrValues.add(correctNull((String)arrTermsType.get(i)));
							arrValues.add(correctNull((String)arrTermsId.get(i)));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(String.valueOf(intSize),hshQuery);
						}
						if(arrTermsId.size()>0)
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
					/* Deleting Entries in CBS Details Page */
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","setcbsdetailsdel");
					hshQueryValues.put("1",hshQuery);
					
					/* Deleting Entries in MIS Details Page */
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_misappdetails");
					hshQueryValues.put("2",hshQuery);
					
					MISLogger.UpdateLogger("misappdetails table delete ==="+hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_misappdisplayscreen");
					hshQueryValues.put("3",hshQuery);
					
					MISLogger.UpdateLogger("misappdisplayscreen table delete ==="+hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_misappclassification");
					hshQueryValues.put("4",hshQuery);
					
					MISLogger.UpdateLogger("misappclassification table delete ==="+hshQuery);
					
					hshQueryValues.put("size","4");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					// Delete CGTMSE tab data
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","delExt_CropCgtmse");
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

				}
				
				//Insert or Update in com_banking table for retail loans By Guhan Tamilvanan on 14.01.2016
				
				if(rs!=null)rs.close();
				String strProcessdate="",strSancRefno="",strCBSAccoutno="";
				strQuery = SQLParser.getSqlQuery("sel_renewalproposaldetails^"+strApplicationNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strProcessdate=Helper.correctNull(rs.getString("app_processdate"));
					strSancRefno=Helper.correctNull(rs.getString("sanctionrefno"));
					strCBSAccoutno=Helper.correctNull(rs.getString("cbs_accountno"));
				}
				
				boolean bankingentry = true;
				if(rs!=null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_Bankingval^"+strApplicationNo+"^ and combk_credittype='P'");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					bankingentry = false;
				}
				
				if(bankingentry)
				{
					String strLoanType="";
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","combankinginsertNEW");
					arrValues.add(strApplicationNo);
					arrValues.add("1");
					if(Helper.correctNull((String)hshValues.get("hidODFlag")).equalsIgnoreCase("OD"))
						strLoanType = "1";
					else
						strLoanType = "2";
					arrValues.add(strLoanType);
					arrValues.add(strPrdCode+"~"+strLoanType);
					arrValues.add("S");
					if(correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("1"))
					{
						arrValues.add("NOTAP");
					}
					else
					{
						if(correctNull((String) hshValues.get("sel_mclrtype")).contains("ST@"))
							arrValues.add("ST");
						else if(correctNull((String) hshValues.get("sel_mclrtype")).contains("TG@"))
							arrValues.add("GS");
						else
							arrValues.add("MCLR");
					}
					arrValues.add("P");
					arrValues.add(strSancRefno);//refno
					arrValues.add(strProcessdate);//date
					arrValues.add("");
					arrValues.add("");
					arrValues.add(strAppOldID);
					arrValues.add("Our");
					arrValues.add("Karnataka Bank");
					arrValues.add("F");
					arrValues.add(correctNull((String) hshValues.get("txtloan_amtreqd")));
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("1");
					arrValues.add("p");
					arrValues.add("");
					arrValues.add(strCBSAccoutno);
					arrValues.add(correctNull((String) hshValues.get("txtloan_modintrate")));
					arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));
					arrValues.add("");
					arrValues.add(correctNull((String) hshValues.get("txtloan_purposeofloan")));
					arrValues.add("");
					arrValues.add("M");
					arrValues.add("0");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("Y");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("R");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
				}
				else
				{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
			  		hshQuery=new HashMap();
					hshQueryValues.put("size","1");
					arrValues.add(strPrdCode);
					arrValues.add(Helper.correctNull((String)hshValues.get("selectinttype")));
					arrValues.add(correctNull((String) hshValues.get("txtloan_amtreqd")));
					arrValues.add(correctNull((String) hshValues.get("txtloan_modintrate")));
					arrValues.add(correctNull((String) hshValues.get("selrepaymenttype")));
					arrValues.add(correctNull((String) hshValues.get("txtloan_purposeofloan")));
					arrValues.add(strApplicationNo);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","combankingupdateNEW_retail");
					hshQueryValues.put("1",hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				if(rs!=null)rs.close();
				
				//End for Com_banking entry
			}
			
			String strFreeze = "";			
			if(!strApplicationNo.equalsIgnoreCase(""))
			{
				if(rsfreeze !=null)
				{
					rsfreeze.close();
				}
				
				strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strApplicationNo);
				rsfreeze = DBUtils.executeQuery(strQuery);
				if (rsfreeze.next()) 
				{
					strFreeze = Helper.correctNull((String)rsfreeze.getString("app_freeze_flag"));
				}
				else
				{
					strFreeze = "";
				}
			}
			if(strFreeze.equalsIgnoreCase(""))
			{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			arrValues.add("N");
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");//added by ganesan
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(rs!=null){
				rs.close();
			}
			String retrestructureval="N";
			strQuery = SQLParser.getSqlQuery("sel_ret_tab_validation^"+strApplicationNo);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next()){
				retrestructureval="Y";
				
			}
			if(retrestructureval.equalsIgnoreCase("N")){
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			arrValues.add(strApplicationNo);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","del_rest_Assesment");//added by ganesan
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			}
			if(rs!=null){
				rs.close();
			}	
			if(resflag)
			{
				StringBuilder sbAuditTrial = new StringBuilder();
				//if (strAction.equalsIgnoreCase("insert")) {  
				/** Start of Audit Trial */
				String strIntType = "";
				String strIntTypeForm = "";
				String strPeriodicity = "";
				String strIntHoliday = "";
				String strIntCharged = "";
				String strGovtScheme = "";
				String strSchemeType = "";
				String strSponsorAgncy = "";
				String strSubsidyType = "";
				String strWhSecured = "";
				String strPaymentMode = "";
				String strRepayType = "";
				String strFacType = "";
				String strMeasrmntType = "";
				String strUnioncreditsociety="";
				String strStaffFlag="";
				ResultSet rs1 = null;
	//Interest Type
				if(correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("1"))
					strIntType = "Fixed";
				else if(correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("2"))
					strIntType = "Floating";
				else if(correctNull((String) hshValues.get("selectinttype")).trim().equalsIgnoreCase("3"))
					strIntType = "Slab";
	//Interest Type - Sub
				if(correctNull((String)hshValues.get("sel_steptype")).trim().equalsIgnoreCase("1"))
					strIntTypeForm = "Regular";
				else if(correctNull((String)hshValues.get("sel_steptype")).trim().equalsIgnoreCase("2"))
					strIntTypeForm = "StepUp";
				else if(correctNull((String)hshValues.get("sel_steptype")).trim().equalsIgnoreCase("3"))
					strIntTypeForm = "Step Down";
	//Interest Charged(Holiday period)
				if(correctNull((String)hshValues.get("interestservised")).trim().equalsIgnoreCase("n"))
					strIntHoliday = "No";
				else if(correctNull((String)hshValues.get("interestservised")).trim().equalsIgnoreCase("y"))
					strIntHoliday = "Yes";
				else if(correctNull((String)hshValues.get("interestservised")).trim().equalsIgnoreCase("s"))
					strIntHoliday = "Not Applicable";
	//Interest Charged 
				if(correctNull((String)hshValues.get("sel_interestcharge")).trim().equalsIgnoreCase("1"))
					strIntCharged = "To be paid as and when debited";
				else if(correctNull((String)hshValues.get("sel_interestcharge")).trim().equalsIgnoreCase("2"))
					strIntCharged = "To be accumulated and paid before commencement of repayment";
				else if(correctNull((String)hshValues.get("sel_interestcharge")).trim().equalsIgnoreCase("3"))
					strIntCharged = "To be accumulated and added to the principal to calculate EMI";
	//Govt.Sponsor Scheme
				if(correctNull((String)hshValues.get("selectgovt")).trim().equalsIgnoreCase("1"))
					strGovtScheme = "Yes";
				else if(correctNull((String)hshValues.get("selectgovt")).trim().equalsIgnoreCase("2"))
					strGovtScheme = "No";
	//Scheme Type
				rs1 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"11^"+correctNull((String)hshValues.get("schemetype")));
				if(rs1.next())
					strSchemeType = correctNull((String)rs1.getString("stat_data_desc1"));
				if(rs1!=null)
					rs1.close();
	//Sponsor Agency
				rs1 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"3^"+correctNull((String)hshValues.get("sel_sponser_agency")));
				if(rs1.next())
					strSponsorAgncy = correctNull((String)rs1.getString("stat_data_desc1"));
				if(rs1!=null)
					rs1.close();
	//Periodicity of Installments
				if(correctNull((String)hshValues.get("sel_peridicity")).trim().equalsIgnoreCase("m"))
					strPeriodicity = "Monthly";
				else if(correctNull((String)hshValues.get("sel_peridicity")).trim().equalsIgnoreCase("q"))
					strPeriodicity = "Quarterly";
				else if(correctNull((String)hshValues.get("sel_peridicity")).trim().equalsIgnoreCase("h"))
					strPeriodicity = "Half-Yearly";
				else if(correctNull((String)hshValues.get("sel_peridicity")).trim().equalsIgnoreCase("y"))
					strPeriodicity = "Yearly";
				else if(correctNull((String)hshValues.get("sel_peridicity")).trim().equalsIgnoreCase("n"))
					strPeriodicity = "Not Applicable";
	//Subsidy Type
				rs1 = DBUtils.executeLAPSQuery("sel_static_desc_audit^"+"5^"+correctNull((String)hshValues.get("sel_subsidytype")));
				if(rs1.next())
					strSubsidyType = correctNull((String)rs1.getString("stat_data_desc1"));
				if(rs1!=null)
					rs1.close();
	//Whether Secured
				if(correctNull((String)hshValues.get("sel_secured")).trim().equalsIgnoreCase("s"))
					strWhSecured = "Secured";
				else if(correctNull((String)hshValues.get("sel_secured")).trim().equalsIgnoreCase("u"))
					strWhSecured = "Unsecured";
				else if(correctNull((String)hshValues.get("sel_secured")).trim().equalsIgnoreCase("p"))
					strWhSecured = "Partially Secured";
	//Repayment Type
				if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("1"))
					strRepayType = "Equated Monthly Installment";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("2"))
					strRepayType = "Non_EMI";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("3"))
					strRepayType = "Graduated installments";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("4"))
					strRepayType = "Step Up";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("5"))
					strRepayType = "Step Down";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("6"))
					strRepayType = "Taper Down";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("7"))
					strRepayType = "Balloon";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("8"))
					strRepayType = "Bullet";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("9"))
					strRepayType = "Flip Method";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("10"))
					strRepayType = "Equal Installments";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("11"))
					strRepayType = "Slab";
				else if(correctNull((String) hshValues.get("selrepaymenttype")).trim().equalsIgnoreCase("12"))
					strRepayType = "OverDraft";
	//Mode of Payment
				if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("S"))
					strPaymentMode = "Recover From Salary";
				else if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("P"))
					strPaymentMode = "Post Dated Cheque";
				else if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("E"))
					strPaymentMode = "Transfer from Saving/Current a/c";
				else if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("D"))
					strPaymentMode = "Electronic Cheque Clearing(ECS)";
				else if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("N"))
					strPaymentMode = "Cash Recovery";
	//Measurement Type
				if(correctNull((String)hshValues.get("measurementtype")).trim().equalsIgnoreCase("g"))
					strMeasrmntType = "Guntas";
				else if(correctNull((String)hshValues.get("measurementtype")).trim().equalsIgnoreCase("c"))
					strMeasrmntType = "Cents";
	//Facility Type
				if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("1"))
					strFacType="Short Term Loan";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("2"))
					strFacType ="Term Loan-Medium";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("3"))
					strFacType ="Long Term Loan";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("4"))
					strFacType ="Secured-Over Draft";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("5"))
					strFacType ="Clean-Over Draft";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("6"))
					strFacType = "Cash Credit-Pledge";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("7"))
					strFacType = "Cash Credit-Hypo of stock";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("8"))
					strFacType = "Cash Credit-Hypo of Book/Debt";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("9"))
					strFacType = "OD - Reducing";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("10"))
					strFacType = "DLRI";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).trim().equalsIgnoreCase("11"))
					strFacType = "ILROD-Inland loan Repayable on Demand";
				//for Union credit scoiety
				if(correctNull((String)hshValues.get("sel_facilitytype")).equalsIgnoreCase("1"))
					strUnioncreditsociety="Yes";
				else if(correctNull((String)hshValues.get("sel_facilitytype")).equalsIgnoreCase("2"))
					strUnioncreditsociety="No";
				strStaffFlag=correctNull((String) hshValues.get("hidStaffFlag"));
				
	//			---------------------------------------Audittrial------------------------
				
				if(correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("LAD"))
				{
					/***
					 * For Audit Trial New Data - By Karthikeyan.S on 18/09/2013
					 */
					String strDocRecvd=Helper.correctNull((String)hshValues.get("sel_docreceived"));
					String strDocRecvdDesc="";
					if(strDocRecvd.equalsIgnoreCase("1"))
					{
						strDocRecvdDesc="RTC";
					}
					else if(strDocRecvd.equalsIgnoreCase("2"))
					{
						strDocRecvdDesc="Declaration by Applicant";
					}
					else if(strDocRecvd.equalsIgnoreCase("3"))
					{
						strDocRecvdDesc="Other Agri Documents";
					}
					else if(strDocRecvd.equalsIgnoreCase("4"))
					{
						strDocRecvdDesc="General";
					}
					String strSpecialCust=Helper.correctNull((String)hshValues.get("sel_SpecialCust"));
					String strSpecialCustDesc="";
					if(strSpecialCust.equalsIgnoreCase("Y"))
					{
						strSpecialCustDesc="Yes";
					}
					else if(strSpecialCust.equalsIgnoreCase("N"))
					{
						strSpecialCustDesc="No";
					}
					sbAuditTrial.append("Application No=").append(correctNull((String)hshValues.get("txt_appinwardno")))
					.append("~Party File No=").append(correctNull((String)hshValues.get("txt_fileNo")))
					.append("~Scheme Code=").append(correctNull((String)hshValues.get("txt_schemecode")))
					.append("~Documents Received from Agriculturist=").append(strDocRecvdDesc)
					.append("~Specify=").append(correctNull((String)hshValues.get("txt_specify")))
					.append("~Loan Product=").append(correctNull((String)hshValues.get("txtprd_desc")));
					if(strPrdType.equalsIgnoreCase("pG"))
					{
					sbAuditTrial.append(
					"~Interest Rate Defined p.a.%=").append(correctNull((String)hshValues.get("txtloan_intrate"))).append(
					"~Interest Rate Modified p.a.%=").append(correctNull((String)hshValues.get("txtloan_modintrate"))).append(
					"~Interest Type=").append(strIntType);
					}
					sbAuditTrial.append(
					"~Amount Requested=").append(correctNull((String)hshValues.get("txtloan_amtreqd"))).append(
					"~Security Value=").append(correctNull((String)hshValues.get("txtloan_costloanprd")));
					//"~Repayment Period (in months)=").append(correctNull((String)hshValues.get("txtloan_reqterms"))).append(
					//"~Initial Holiday/Gestation/ Moratorium Period (in Months)=").append(correctNull((String)hshValues.get("txt_installments"))).append(
					//"~Interest charged during Repayment Holiday=").append(strIntHoliday).append(
					//"~Interest charged=").append(strIntCharged).append(
					//"~Periodicity of Installments=").append(strPeriodicity).append("~Facility Type=").append(strFacType);
					//"~Govt.Sponsor Scheme=").append(strGovtScheme);
					
					//sbAuditTrial.append("~Repayment Capacity(%)=").append(correctNull((String)hshValues.get("txt_repaycapacity")))
					//sbAuditTrial.append("~Minimum Margin=").append(correctNull((String)hshValues.get("txtloan_downpay")))
					//.append("Minimum Margin Percent").append(correctNull((String)hshValues.get("txtMarginpercent"))).append("(%)")
					sbAuditTrial.append("~Margin Offered by Borrower=").append(correctNull((String)hshValues.get("txtmarginoffered")))
					.append("~Repayment Type=").append(strRepayType)
					.append("~Special Customer=").append(strSpecialCustDesc)
					.append("~Govt. Sponsor Scheme=").append(strGovtScheme);
					if(strGovtScheme.equals("Yes"))
					{
						sbAuditTrial.append("~Scheme Type=").append(strSchemeType).append(
						"~Sponsor Agency=").append(strSponsorAgncy).append(
						"~Subsidy Type=").append(strSubsidyType).append(
						"~Subsidy Amount=").append(correctNull((String)hshValues.get("sub")));
				    }
					sbAuditTrial.append("~Application Received on=").append(correctNull((String)hshValues.get("txt_receivedRH")))
					.append("~Processed On=").append(correctNull((String)hshValues.get("txtloan_filedon")));
					
					AuditTrial.auditNewLog(hshValues,"225",strApplicationNo,sbAuditTrial.toString(),sbOldAudit.toString());
					/***
					 * End - Audit Trial New Data
					 */
				}
				else
				{
					sbAuditTrial.append("Application Inward No=").append(correctNull((String)hshValues.get("txt_appinwardno")))
					.append("~File No=").append(correctNull((String)hshValues.get("txt_fileNo")))
					.append("~Scheme Code=").append(correctNull((String)hshValues.get("txt_schemecode")))
					.append("~Product=").append(correctNull((String)hshValues.get("txtprd_desc"))).append(
					"~Interest Rate Defined p.a.=").append(correctNull((String)hshValues.get("txtloan_intrate"))).append(
					"~Interest Rate Modified p.a.=").append(correctNull((String)hshValues.get("txtloan_modintrate"))).append(
					"~Interest Type=").append(strIntType).append("(").append(strIntTypeForm).append(")").append(
					"~Amount Requested=").append(correctNull((String)hshValues.get("txtloan_amtreqd"))).append(
					"~Cost of Project=").append(correctNull((String)hshValues.get("txtloan_costloanprd"))).append(
					"~Repayment Period (in months)=").append(correctNull((String)hshValues.get("txtloan_reqterms"))).append(
					"~Initial Holiday/Gestation/ Moratorium Period (in Months)=").append(correctNull((String)hshValues.get("txt_installments"))).append(
					"~Interest charged during Repayment Holiday=").append(strIntHoliday).append(
					"~Interest charged=").append(strIntCharged).append(
					"~Periodicity of Installments=").append(strPeriodicity).append(
					"~Govt.Sponsor Scheme=").append(strGovtScheme);
					
					if(strGovtScheme.equals("Yes"))
					{
						sbAuditTrial.append("~Scheme Type=").append(strSchemeType).append(
						"~Sponsor Agency=").append(strSponsorAgncy).append(
						"~Subsidy Amount=").append(correctNull((String)hshValues.get("sub"))).append(
						"~Subsidy Type=").append(strSubsidyType);
				    }
					sbAuditTrial.append("~Repayment Capacity(%)=").append(correctNull((String)hshValues.get("txt_repaycapacity"))).append(
					"~Minimum Margin=").append(correctNull((String)hshValues.get("txtloan_downpay"))).append(
					"(").append(correctNull((String)hshValues.get("txtMarginpercent"))).append("%").append(")").append(
					"~Margin Offered by Borrower=").append(correctNull((String)hshValues.get("txtmarginoffered")));
					double hidPrincipalRatio=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidPrincipalRatio")));
					double hidInterestRatio=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidInterestRatio")));
					sbAuditTrial.append(
				"~Eligibility based on margin=").append(correctNull((String)hshValues.get("txtloan_recmdamt"))).append(
				"~Eligible Loan Amount=").append(correctNull((String)hshValues.get("txtloan_sancamt")));
					if(correctNull((String)hshValues.get("staffloan")).equalsIgnoreCase("Y"))
					{
						sbAuditTrial.append("~Principal Installment=").append(correctNull((String)hshValues.get("txtmonPay")));
					}
					else
					{
						sbAuditTrial.append("~Installment Amount=").append(correctNull((String)hshValues.get("txtmonPay")));
					}
					
					sbAuditTrial.append("~Documentation Fee=").append(strLoanDocFee)
					.append("~Processing Fee=").append(strLoanProcFee)
					.append("~Whether Secured=").append(strWhSecured);
					if(correctNull((String)hshValues.get("sel_secured")).trim().equalsIgnoreCase("p"))
					sbAuditTrial.append("~Amount Secured=").append(correctNull((String)hshValues.get("txt_secured")));
					sbAuditTrial.append("~Repayment Type=").append(strRepayType).append(
					"~Mode of Payment=").append(strPaymentMode);
					if(correctNull((String)hshValues.get("selmodepayment")).trim().equalsIgnoreCase("E"))
					sbAuditTrial.append("~Operative Account Number=").append(correctNull((String)hshValues.get("txt_operativeaccno")));
					//if(strPrdType.charAt(0)=='A')				
					//sbAuditTrial.append("~Measurement Type=").append(strMeasrmntType);
					sbAuditTrial.append("~Facility Type=").append(strFacType).append(
					"~Application Received on=").append(correctNull((String)hshValues.get("txt_receivedRH"))).append(
					"~Processed On=").append(correctNull((String)hshValues.get("txtloan_filedon")));
					if(strStaffFlag.equals("Y"))
					{
						sbAuditTrial.append("~Loan From Union Bank Co-Operative Credit Society=").append(strUnioncreditsociety);
					}
					AuditTrial.auditNewLog(hshValues,"238",strApplicationNo,sbAuditTrial.toString(),sbOldAudit.toString());
				}
			}
			
//			if(rs!=null)
//			{rs.close();}
//			intUpdatesize=0;
//			hshQueryValues=new HashMap();
//			String strCBSID=correctNull((String)hshResult.get("strCBSID"));
//			if(strOldAppno.equalsIgnoreCase("new") && !strCBSID.equalsIgnoreCase(""))
//			{
//				strQuery=SQLParser.getSqlQuery("sel_op_ratingproposal^"+strCBSID);
//				rs=DBUtils.executeQuery(strQuery);
//				while(rs.next())
//				{
//					if(rs4!=null)
//					{rs4.close();}
//					String strRatAppNo=correctNull(rs.getString("fin_ratappno"));
//					strQuery=SQLParser.getSqlQuery("selcrefreezeflag^"+strRatAppNo);
//					rs4=DBUtils.executeQuery(strQuery);
//					if(rs4.next())
//					{
//						if(correctNull(rs4.getString("cre_rating")).equalsIgnoreCase("") && correctNull(rs4.getString("cre_weight")).equalsIgnoreCase(""))
//						{
//							intUpdatesize++;
//							hshQuery = new HashMap();
//							arrValues=new ArrayList();
//							hshQuery.put("strQueryId","updfinrating");
//							arrValues.add(strRatAppNo);
//							hshQuery.put("arrValues",arrValues);
//							hshQueryValues.put(""+intUpdatesize,hshQuery);
//							
//						}
//						
//					}
//					else
//					{
//						intUpdatesize++;
//						hshQuery = new HashMap();
//						arrValues=new ArrayList();
//						hshQuery.put("strQueryId","updfinrating");
//						arrValues.add(strRatAppNo);
//						hshQuery.put("arrValues",arrValues);
//						hshQueryValues.put(""+intUpdatesize,hshQuery);
//					}
//				}
//				hshQueryValues.put("size", ""+intUpdatesize);
//				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//			}
		
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateLoanProducts " + e.getMessage());
		}
		return hshResult;
	}
	
	//To get the collateral security percentage from Products page by Guhan T
	public String getCollateralpercent(String strAppno,String RecmdValue) 
	{
		int strPercent=0;
		int strCollPercent=0;
		int strOtherPercent=0;
		int strImmovblePercent=0;
		ResultSet rs = null;
		try
		{		
			if(rs!=null) rs.close();
			String strQuery2 = SQLParser.getSqlQuery("sel_collpercentforloandet^"+strAppno+"^"+RecmdValue);
			rs = DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				strCollPercent = Integer.parseInt(Helper.correctInt((String)rs.getString("COL_PERCENT")));
				strOtherPercent = Integer.parseInt(Helper.correctInt((String)rs.getString("COL_OTHER_PER")));
				strImmovblePercent = Integer.parseInt(Helper.correctInt((String)rs.getString("COL_IMMOVABLE_PER")));
			}
			strPercent = Math.max(strCollPercent,Math.max(strOtherPercent,strImmovblePercent));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getCollateralpercent==>" +e.toString());
		}
	return String.valueOf(strPercent);
	}
	

	//End

	

	public HashMap getPersonalSearch(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strOrgLevel = correctNull((String) hshValues.get("strOrgLevel"));
		String strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
		String strGroupRights = correctNull((String) hshValues.get("strGroupRights"));
		String strUserId = correctNull((String) hshValues.get("strUserId"));
		String strRdodesk = correctNull((String) hshValues.get("rdodesk"));
		String strRdosel = correctNull((String) hshValues.get("rdosel"));
		String strRdomsel = correctNull((String) hshValues.get("rdomsel"));
		String strrdowhere = correctNull((String) hshValues.get("rdowhere"));
		String strtxtsearch = correctNull((String) hshValues.get("txtsearch"));
		String strtextPer = "%";
		String strNoTrimOrgCode = strOrgCode;
		strGroupRights = strGroupRights.substring(8, 11);
		try
		{
			if (strOrgLevel.equalsIgnoreCase("C"))
			{
				strOrgCode = strOrgCode.substring(0, 3);
			}
			else if (strOrgLevel.equalsIgnoreCase("R"))
			{
				strOrgCode = strOrgCode.substring(0, 6);
			}
			else if (strOrgLevel.equalsIgnoreCase("D"))
			{
				strOrgCode = strOrgCode.substring(0, 9);
			}
			else if (strOrgLevel.equalsIgnoreCase("A"))
			{
				strOrgCode = strOrgCode.substring(0, 12);
			}
			if (strRdodesk.equalsIgnoreCase("D"))
			{
				rs = DBUtils.executeLAPSQuery("persearchbasedesk");
				if (strRdosel.equalsIgnoreCase("M"))
				{
					rs = DBUtils.executeLAPSQuery("persearchbasedeskme^" + strUserId);
				}
				else if (strRdosel.equalsIgnoreCase("O"))
				{
					rs = DBUtils.executeLAPSQuery("persearchbasedeskmyorg^" + strNoTrimOrgCode);
				}
				else if (strRdosel.equalsIgnoreCase("OC"))
				{
					strQuery = strQuery + " "
							+ SQLParser.getSqlQuery("persearchbasedeskmyorgcld^" + strOrgCode + "^" + strNoTrimOrgCode);
					String strtemrights = strGroupRights.substring(1, 2);
					if (strtemrights.equalsIgnoreCase("x"))
					{
						strQuery = strQuery + " " + "and 1=2";
					}
				}
				else if (strRdosel.equalsIgnoreCase("A"))
				{
					/*
					 * Not taking the applications if the group rights for
					 * current organisation children is not present and other
					 * organisation is not present
					 */
					String strtemrights = strGroupRights.substring(1, 2);
					String strtemrights1 = strGroupRights.substring(2, 3);
					if (strtemrights.equalsIgnoreCase("x") && strtemrights1.equalsIgnoreCase("x"))
					{
						rs = DBUtils.executeLAPSQuery("persearchbasedeskmyorg^" + strNoTrimOrgCode);
					}
					else if (strtemrights.equalsIgnoreCase("x"))
					{
						strQuery = strQuery
								+ " "
								+ SQLParser.getSqlQuery("persearchbasedeskmyorgcld^" + strNoTrimOrgCode + "^"
										+ strOrgCode);
					}
					else if (strtemrights1.equalsIgnoreCase("x"))
					{
						strQuery = strQuery + " "
								+ SQLParser.getSqlQuery("persearchbasedeskallothernone^" + strOrgCode);
					}
					else
					{
						strQuery = strQuery + " " + SQLParser.getSqlQuery("persearchbasedeskall");
					}
				}
			}
			else if (strRdodesk.equalsIgnoreCase("M"))
			{
				if (strRdomsel.equalsIgnoreCase("I"))
				{
					strQuery = SQLParser.getSqlQuery("persearchinbox^" + strUserId + "^" + strUserId);
				}
				else if (strRdomsel.equalsIgnoreCase("O"))
				{
					strQuery = SQLParser.getSqlQuery("persearchoutbox^" + strUserId + "^" + strUserId);
				}
			}
			if (strrdowhere.equalsIgnoreCase("A"))
			{
				if (strtxtsearch.equalsIgnoreCase(""))
				{
					strtxtsearch = "%";
				}
				strQuery = strQuery
						+ " "
						+ SQLParser
								.getSqlQuery("persearchcommon^" + strtxtsearch + "^" + strtextPer + "^" + strtextPer);
			}
			else if (strrdowhere.equalsIgnoreCase("C"))
			{
				if (strtxtsearch.equalsIgnoreCase(""))
				{
					strtxtsearch = "%";
				}
				strQuery = strQuery
						+ " "
						+ SQLParser
								.getSqlQuery("persearchcommon^" + strtextPer + "^" + strtxtsearch + "^" + strtextPer);
			}
			else if (strrdowhere.equalsIgnoreCase("F"))
			{
				if (strtxtsearch.equalsIgnoreCase(""))
				{
					strtxtsearch = "%";
				}
				strQuery = strQuery
						+ " "
						+ SQLParser
								.getSqlQuery("persearchcommon^" + strtextPer + "^" + strtextPer + "^" + strtxtsearch);
			}
			else
			{
				strQuery = strQuery + " "
						+ SQLParser.getSqlQuery("persearchcommon^" + strtextPer + "^" + strtextPer + "^" + strtextPer);
			}
			rs = DBUtils.executeQuery(strQuery);
			if (strRdodesk.equalsIgnoreCase("D"))
			{
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("app_no"));
					arryCol.add(rs.getString("aname"));
					arryCol.add(rs.getString("perapp_panno"));
					arryCol.add(rs.getString("org_name"));
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("op"))
					{
						arryCol.add("Open");
						arryCol.add("Pending");
					}
					else if (correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
					{
						arryCol.add("Processed");
						arryCol.add("Approved");
					}
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("pr"))
					{
						arryCol.add("Processed");
						arryCol.add("Rejected");
					}
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("ca"))
					{
						arryCol.add("Closed");
						arryCol.add("Approved");
					}
					else if (correctNull(rs.getString("app_status")).equalsIgnoreCase("cr"))
					{
						arryCol.add("Closed");
						arryCol.add("Rejected");
					}
					arryRow.add(arryCol);
				}
			}
			else
			{
				while (rs.next())
				{
					arryCol = new ArrayList();
					arryCol.add(rs.getString("app_no"));
					arryCol.add(rs.getString("aname"));
					arryCol.add(rs.getString("perapp_panno"));
					arryCol.add(rs.getString("org_name"));
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("op"))
					{
						arryCol.add("Open");
						arryCol.add("Pending");
					}
					else if (correctNull(rs.getString("app_status")).equalsIgnoreCase("pa"))
					{
						arryCol.add("Processed");
						arryCol.add("Approved");
					}
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("pr"))
					{
						arryCol.add("Processed");
						arryCol.add("Rejected");
					}
					if (correctNull(rs.getString("app_status")).equalsIgnoreCase("ca"))
					{
						arryCol.add("Closed");
						arryCol.add("Approved");
					}
					else if (correctNull(rs.getString("app_status")).equalsIgnoreCase("cr"))
					{
						arryCol.add("Closed");
						arryCol.add("Rejected");
					}
					arryCol.add(rs.getString("mail_fromusrid"));
					arryCol.add(rs.getString("mail_date"));
					arryRow.add(arryCol);
				}
			}
			hshResult.put("arryRow", arryRow);
		}
		catch (Exception e)
		{
			throw new EJBException("Error in getApplicantIDHelp " + e.getMessage());
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
		return hshResult;
	}

	public HashMap getInterestTerms(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshResult = new HashMap();
		ArrayList arryRow = new ArrayList();
		ArrayList arryCol = null;
		String strProductCode = (String) hshValues.get("appid");
		try
		{
			rs = DBUtils.executeLAPSQuery("seltermsint^" + strProductCode);

			while (rs.next())
			{
				arryCol = new ArrayList();
				arryCol.add(rs.getString("prd_termfrom"));
				arryCol.add(rs.getString("prd_termto"));
				arryCol.add(rs.getString("prd_interest"));
				arryRow.add(arryCol);
			}
			hshResult.put("arryRow", arryRow);
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
		return hshResult;
	}

	public HashMap getInterestRate(HashMap hshRequestValues) 
	{
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		String strQuery = "",strQuery1="";
		String strPrdcode = "";
		String strRecAmt = "";
		String strTerms = "";
		String strIntType = "";
		int intMorTerms=1;
		String strLesser = ">=";
		String strGreater = "<=";
		String chkStrPrdcode = "";
		String strprdType="",strMarsetRentPerCent="",strROI="",strScore="",strWeight="KB4",strsector="01",strSubsector="",strMCLRType="",strRefType="O";
		try
		{
			String strappno=Helper.correctNull((String)hshRequestValues.get("strappno"));
			hshRecord = new HashMap();
			chkStrPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			if (chkStrPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdcode"));
			}
			else
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			}
			strRecAmt = Helper.correctDouble((String) hshRequestValues.get("recamt"));
			strTerms = correctNull((String) hshRequestValues.get("terms"));
			intMorTerms=Integer.parseInt(Helper.correctInt((String) hshRequestValues.get("morterms")))+1;
			strIntType = correctNull((String) hshRequestValues.get("inttype"));
			strROI = correctNull((String) hshRequestValues.get("strROI"));
			strScore = Helper.correctInt((String) hshRequestValues.get("strScore"));
			strMCLRType = Helper.correctNull((String) hshRequestValues.get("strMCLRType"));
			if(strIntType.equalsIgnoreCase("Combo"))
			{
				strQuery = SQLParser.getSqlQuery("selintratecombo^" + strIntType + "^" + strPrdcode + "^" + strGreater + "^"
						+ strRecAmt + "^" + strLesser + "^" + strRecAmt );
			}
			else if(strIntType.equalsIgnoreCase("Floating"))
			{
				
				if(!strMCLRType.equalsIgnoreCase(""))
				{
					String strArr[]=strMCLRType.split("@");
					if(strArr!=null && strArr.length>1)
					{
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
						if(rs1.next())
						{
							if(strROI.equalsIgnoreCase("O"))
								strROI=Helper.correctNull(rs1.getString("cbs_static_data_passing_code"));
							else
								strRefType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code"));  
							
						}
					}
				}
				
				{
					strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^" + strIntType + "^" + strPrdcode + "^" + strGreater + "^"
							+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^"+strROI+"^O^" + strGreater + "^" + strTerms + "^"
							+ strLesser + "^" + strTerms );
				}
				if(!strROI.equalsIgnoreCase("") && !strScore.equalsIgnoreCase("0") && !strROI.equalsIgnoreCase("O")&& !strROI.equalsIgnoreCase("RATING"))
				{
					strQuery = SQLParser.getSqlQuery("select_inttypefloatingrate^" + strIntType + "^" + strPrdcode + "^" + strGreater + "^"
							+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^"+strROI+"^" + strGreater + "^" + strTerms + "^"
							+ strLesser + "^" + strTerms+"^"+strRefType+"^"+strScore );
				}
				else if(strROI.equalsIgnoreCase("RATING"))
				{
					//select sector
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_misappclassification^"+strappno+"^1");			
					if(rs1.next())
					{
						strsector=Helper.correctNull(rs1.getString("app_sector"));  //01 ,02
						strSubsector=Helper.correctNull(rs1.getString("app_sensitivesector"));
					}
					
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_creditRatingType^"+strappno);			
					if(rs1.next())
					{
						strWeight=Helper.correctNull(rs1.getString("CRE_WEIGHT"));
					}
					
					strQuery = SQLParser.getSqlQuery("selinttypefloatingrate^" + strIntType + "^" + strPrdcode + "^" + strGreater + "^"
							+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^"+strRefType+"^O^" + strGreater + "^" + strTerms + "^"
							+ strLesser + "^" + strTerms );
				}
			}
			else
			{
				
				strQuery = SQLParser.getSqlQuery("selinttyperate^" + strIntType + "^" + strPrdcode + "^" + strGreater + "^"
					+ strRecAmt + "^" + strLesser + "^" + strRecAmt + "^O^" + strGreater + "^" + strTerms + "^"
					+ strLesser + "^" + strTerms);
			}
			
			if(rs!=null)
				rs.close();
			
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				hshRecord.put("prd_interest", correctNull(rs.getString("prd_interest")));
				hshRecord.put("prd_adjust", correctNull(rs.getString("prd_adjust")));
				hshRecord.put("prd_interestid", correctNull(rs.getString("prd_interestid")));
				hshRecord.put("prd_baserate", correctNull(rs.getString("prd_baserate")));
				
				if(strROI.equalsIgnoreCase("RATING"))
				{
					if(strSubsector.equalsIgnoreCase("11")) {
						strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^"+strWeight+"^"+Helper.correctNull((String)rs.getString("prd_intid"))+"^"+Helper.correctNull((String)rs.getString("prd_sno"))
								+"^"+strSubsector);
						rs1 = DBUtils.executeQuery(strQuery1);
						}
						else if(strsector.equalsIgnoreCase("01") || strsector.equalsIgnoreCase("02"))
						{
							strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^" +strWeight+"^"+Helper.correctNull((String)rs.getString("prd_intid"))+"^"+Helper.correctNull((String)rs.getString("prd_sno"))
									+"^"+strsector);
							rs1 = DBUtils.executeQuery(strQuery1);
						}
						else
						{
							strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^KB4^"+Helper.correctNull((String)rs.getString("prd_intid"))+"^"+Helper.correctNull((String)rs.getString("prd_sno"))
									+"^01");
							rs1 = DBUtils.executeQuery(strQuery1);
						}
						if(rs1.next())
						{
							hshRecord.put("prd_creditrskpremium", correctNull(rs1.getString("ROI_CRP")));
							hshRecord.put("prd_busstrategicpremium", correctNull(rs1.getString("ROI_BSP")));
						}
				}
				else
				{
					hshRecord.put("prd_creditrskpremium", correctNull(rs.getString("prd_creditrskpremium")));
					hshRecord.put("prd_busstrategicpremium", correctNull(rs.getString("prd_busstrategicpremium")));
				}
				
			}
			
			
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection " + cf.getMessage());
			}

			String  strPropAmt=correctNull((String)hshRequestValues.get("costloanprd"));			
	       //added by bhaskar for setup level margin percent			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("setproductssel^"+strPrdcode);
			if(rs.next())
			{
				strprdType=Helper.correctNull((String)rs.getString("prd_type"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(strprdType.equalsIgnoreCase("pL"))
			{
				
			  rs=DBUtils.executeLAPSQuery("selrentpercsetup^"+strPrdcode);
			  if(rs.next())
			  {
				  strMarsetRentPerCent=Helper.correctNull((String)rs.getString("prd_leasenrReceivable"));
				
			  }			  
			
			}	
			if(rs!=null)
			{
				rs.close();
			}
			//ende			
			//added by bhaskar for maregin for pL
			if(strprdType.equalsIgnoreCase("pL"))
			{
			  double dbStrLoanAmout=Double.parseDouble(Helper.correctDouble(strPropAmt));
			  double dbStrMargper=Double.parseDouble(Helper.correctDouble(strMarsetRentPerCent));
		      double dbDedRent=0.00;
		      dbDedRent=(dbStrMargper/100)*dbStrLoanAmout;
		      dbStrLoanAmout=dbStrLoanAmout-dbDedRent;
		      strRecAmt=String.valueOf(dbStrLoanAmout);
			}	
			//ended
			
			String strFlag="Y";
			
			if(strprdType.equalsIgnoreCase("pG"))
			{
				strQuery=SQLParser.getSqlQuery("selloanagainstparams^118");
				rs1 = DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					if(!Helper.correctNull((String)rs1.getString("LOAN_PARAMVAL")).equalsIgnoreCase(""))
					{
						if((Helper.dateDiff(Helper.correctNull((String)rs1.getString("LOAN_PARAMVAL")), Helper.correctNull((String)hshRequestValues.get("strAppCreateDate"))))>=0)
							strFlag="N";	
					}
				}
				
			}
			
			strQuery = SQLParser.getSqlQuery("selmarginrate^" + strPrdcode + "^" + strGreater + "^" + strRecAmt + "^"
					+ strLesser + "^" + strRecAmt);

			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				hshRecord.put("margin_perct", correctNull(rs.getString("margin_perct")));
				
				
				if(strprdType.equalsIgnoreCase("pG") && strFlag.equalsIgnoreCase("N"))
				{
					double dblLatestMargin=Double.parseDouble(Helper.correctDouble(rs.getString("margin_perct")));
					double dblAvgMargin=Double.parseDouble(Helper.correctDouble(rs.getString("margin_perct_othersec")));
					
					if(dblAvgMargin>dblLatestMargin)
						dblLatestMargin=dblAvgMargin;
					
					hshRecord.put("margin_perct", Helper.formatDoubleValue(dblLatestMargin));
				}
			}			
			if(strprdType.equalsIgnoreCase("pI"))
			{	
				//hshRecord.put("margin_perct", "10");												
			}
			
			if(strROI.equalsIgnoreCase("RATING"))
			{
				strScore=strWeight;
			}
			hshRecord.put("strScore", strScore);	
			
			
			//Deviation changes
			strQuery=SQLParser.getSqlQuery("Sel_app_deviation1^"+strappno+"^IR");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Helper.correctNull(rs.getString("DEVIATION_REQ")).equalsIgnoreCase("Y")&& Helper.correctNull(rs.getString("DEVIATION_APPREJ")).equalsIgnoreCase("A"))
				{
					hshRecord.put("strDevIntRate", correctNull(rs.getString("DEVIATION_NEWVALUE")));
					hshRecord.put("strDevIntFlag", "Y");
				}
			}


		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getInterestRate login" + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection " + cf.getMessage());
			}
		}
		hshRecord.put("interesttype", "fixedfloating");
		return hshRecord;
	}

	public HashMap getMargin(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		String strPrdcode = "";
		String strPropAmt = "";
		String strLesser = ">=";
		String strGreater = "<=";
		String chkStrPrdcode = "";
		try
		{
			hshRecord = new HashMap();
			chkStrPrdcode = correctNull((String) hshRequestValues.get("prdcode"));
			if (chkStrPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			}
			else
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdcode"));
			}
			strPropAmt = correctNull((String) hshRequestValues.get("costloanprd"));

			strQuery = SQLParser.getSqlQuery("selmarginrate^" + strPrdcode + "^" + strGreater + "^" + strPropAmt + "^"
					+ strLesser + "^" + strPropAmt);

			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				hshRecord.put("margin_perct", correctNull(rs.getString("margin_perct")));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getInterestRate login" + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection " + cf.getMessage());
			}
		}
		return hshRecord;
	}

	public HashMap getStepupRate(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrToAmount = new ArrayList();
		ArrayList arrInterest = new ArrayList();
		String strQuery = "";
		String strPrdcode = "";
		String strRecAmt = "";
		String strTerms = "";
		String strIntType = "";
		String stronlyGreat = "<";
		String strLesser = ">=";
		String strGreater = "<=";
		
		try
		{
			hshRecord = new HashMap();
			String chkStrPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			strPrdcode = chkStrPrdcode;
			if (strPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdcode"));
			}
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			}
			
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshRequestValues.get("hidProductID"));
			}
			
		
			strRecAmt = correctNull((String) hshRequestValues.get("recamt"));
			strTerms = correctNull((String) hshRequestValues.get("terms"));
			strIntType = correctNull((String) hshRequestValues.get("inttype"));
			
			strRecAmt = correctNull((String) hshRequestValues.get("recamt"));
			strTerms = correctNull((String) hshRequestValues.get("terms"));
			strIntType = correctNull((String) hshRequestValues.get("inttype"));
		
			strQuery = SQLParser.getSqlQuery("selslabrate1^" + strPrdcode + "^" + stronlyGreat + "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next())
			{
				arrToAmount.add(correctNull(rs.getString("toamt")));
				arrInterest.add(correctNull(rs.getString("interest")));
			}
			try
			{
				if (rs != null)
				{
					rs.close();
				}
			}
			catch (Exception exp)
			{
				throw new EJBException("Error in closing Connection in get" + exp.getMessage());
			} 
			strQuery = SQLParser.getSqlQuery("selslabrate2^" + strPrdcode + "^" + strGreater + "^"
					+ strRecAmt + "^" + strLesser + "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrToAmount.add(correctNull(rs.getString("toamt")));
				arrInterest.add(correctNull(rs.getString("interest")));
			}
		
			strQuery = SQLParser.getSqlQuery("selslabrate2^" + strPrdcode + "^" + strGreater + "^"
					+ strRecAmt + "^" + strLesser + "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("prd_interest",correctNull(rs.getString("interest")));
			}
			
			hshRecord.put("slab_Toamt", arrToAmount);
			hshRecord.put("slab_Tointerest", arrInterest);
			
			
		/*	hshRecord.put("prd_interest", arrInterest.get());
			hshRecord.put("prd_adjust", correctNull(rs.getString("prd_adjust")));
			hshRecord.put("prd_interestid", correctNull(rs.getString("prd_interestid"))); */			
		
					
			strQuery = SQLParser.getSqlQuery("selmarginrate^" + strPrdcode + "^" + strGreater + "^" + strRecAmt + "^"
					+ strLesser + "^" + strRecAmt);

			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				hshRecord.put("margin_perct", correctNull(rs.getString("margin_perct")));
			}
			
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getStepupRate login" + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection getStepupRate " + cf.getMessage());
			}
		}
		hshRecord.put("interesttype", "slabrate");
		return hshRecord;
	}

	private ArrayList calculateOverDraft(HashMap hshValues) 
	{
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		ArrayList arrRow = new ArrayList();
		try
		{
			String strrepay = correctNull((String) hshValues.get("reptype"));
			double intTerms = Double.parseDouble((String) hshValues.get("terms")) / 12;
			double intrecmdAmt = Double.parseDouble((String) hshValues.get("recmdAmt"));
			int noofyears = (int) Math.ceil(intTerms);
			double ODValue = intrecmdAmt / noofyears;
			ArrayList arrCol = null;
			double opvalue = intrecmdAmt - ODValue;
			for (int i = 1; i < noofyears + 1; i++)
			{
				arrCol = new ArrayList();
				arrCol.add(Integer.toString(i));
				arrCol.add(dc.format(intrecmdAmt));
				if (strrepay.equals("4"))
				{
					if (i == 1)
					{
						arrCol.add(dc.format(intrecmdAmt));
					}
					if (i == 2)
					{
						opvalue = intrecmdAmt - (ODValue * 2);
						arrCol.add(dc.format(opvalue));
						opvalue = opvalue - ODValue;
					}
					else
					{
						arrCol.add(dc.format(opvalue));
						opvalue = opvalue - ODValue;
					}
				}
				else
				{
					arrCol.add("");
				}
				arrRow.add(arrCol);
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in calculateOverDraft login" + ce.toString());
		}
		return arrRow;
	}

//	public void updateOverDraft(HashMap hshValues) 
//	{
//		String strAppno = (String) hshValues.get("appno");
//		String strType = (String) hshValues.get("hidType");
//		String[] strId = null;
//		String[] strSancAmt = null;
//		String[] strOprAmt = null;
//		HashMap hshQuery = null;
//		HashMap hshQueryValues = null;
//		ArrayList arrValues = null;
//
//		try
//		{
//			strId = (String[]) hshValues.get("txtid");
//			strSancAmt = (String[]) hshValues.get("txtsancamt");
//			strOprAmt = (String[]) hshValues.get("txtoprlimit");
//			int intSize = 1;
//			hshQueryValues = new HashMap();
//			hshQuery = new HashMap();
//			hshQuery.put("strQueryId", "overdraftdel");
//			arrValues = new ArrayList();
//			arrValues.add(strAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQueryValues.put(Integer.toString(intSize), hshQuery);
//
//			for (int i = 1; i < strId.length + 1; i++)
//			{
//				intSize++;
//				hshQuery = new HashMap();
//				hshQuery.put("strQueryId", "overdraftins");
//				arrValues = new ArrayList();
//				arrValues.add(strAppno);
//				arrValues.add(strId[i - 1]);
//				arrValues.add(Helper.correctDouble((String) strSancAmt[i - 1]));
//				arrValues.add(Helper.correctDouble((String) strOprAmt[i - 1]));
//				arrValues.add(strType);
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put(Integer.toString(intSize), hshQuery);
//			}
//			hshQueryValues.put("size", Integer.toString(intSize));
//			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//		}
//		catch (Exception e)
//		{
//			throw new EJBException(e.getMessage());
//		}
//	}

//	public HashMap getOverDraft(HashMap hshValues) 
//	{
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		String strAppno = (String) hshValues.get("appno");
//		String strAction = (String) hshValues.get("hidAction");
//		String strQuery = null;
//		ArrayList arrRow = new ArrayList();
//		ArrayList arrCol = null;
//		String strType = (String) hshValues.get("hidType");
//		try
//		{
//			strQuery = SQLParser.getSqlQuery("overdraftsel^" + strAppno + "^" + strType);
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{
//				arrCol = new ArrayList();
//				arrCol.add(correctNull(rs.getString(1)));
//				arrCol.add(correctNull(rs.getString(2)));
//				arrCol.add(correctNull(rs.getString(3)));
//				arrRow.add(arrCol);
//			}
//			if (arrRow.size() != 0)
//			{
//				hshRecord.put("overdraft", arrRow);
//			}
//			else
//			{
//				hshRecord.put("overdraft", calculateOverDraft(hshValues));
//			}
//			if (strAction.equals("Refresh"))
//			{
//				hshRecord.put("overdraft", calculateOverDraft(hshValues));
//			}
//		}
//		catch (Exception e)
//		{
//			throw new EJBException(e.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				throw new EJBException(e1.getMessage());
//			}
//		}
//		return hshRecord;
//	}

	public void updateCoAppGuarantor(HashMap hshRequestValues) 
	{
		HashMap hshQuery = null;
		HashMap hshQueryValues = null;
		ArrayList arrValues = null;
		StringBuilder sbolddata=new StringBuilder();
		String strQuery = "",strOldid="";
		ResultSet rs=null;
		try
		{
			String strAppno = (String) hshRequestValues.get("appno");
			String strType = (String) hshRequestValues.get("seltype");
			String strHidId = Helper.correctInt((String) hshRequestValues.get("hidCoDemoId"));
			String strAction = (String) hshRequestValues.get("hidAction");
			String strRelation = (String) hshRequestValues.get("txtrelation");
			String strIncludeIncome = (String) hshRequestValues.get("sel_incomeeligibility");
			String strRelationType = (String) hshRequestValues.get("sel_relation_type");
			
			strQuery=SQLParser.getSqlQuery("seloldrefidforapp^"+strHidId);
			rs=DBUtils.executeQuery(strQuery);	
			if(rs.next())
			{
				strOldid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				strQuery=SQLParser.getSqlQuery("sel_perloandetailsdemo_audit^"+strAppno+"^"+strHidId);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					/***
					 * For Audit Trial Old Data - By Karthikeyan.S on 20/09/2013
					 */
					MastApplicantBean MAB=new MastApplicantBean();
					String strRelationship=Helper.correctNull(rs.getString("DEMO_RELATION"));
					String strRelationshipDesc="";
					strRelationshipDesc=MAB.getMasterDesc("StatMast", "123", strRelationship);
					if(correctNull(rs.getString("DEMO_TYPE")).equalsIgnoreCase("c"))
					{
						sbolddata.append("Applicant Type=").append("Joint-Applicant");
					}
					else if(correctNull(rs.getString("DEMO_TYPE")).equalsIgnoreCase("g"))
					{
						sbolddata.append("Applicant Type=").append("Guarantor");
					}
					else if(correctNull(rs.getString("DEMO_TYPE")).equalsIgnoreCase("o"))
					{
						sbolddata.append("Applicant Type=").append("Co-Obligant");
					}
					sbolddata.append(" ~Name of the Person=").append(correctNull(rs.getString("DEMO_NAME")));
					sbolddata.append(" ~Relationship with the Applicant=").append(strRelationshipDesc);
					if(correctNull(rs.getString("DEMO_INCLUDEINCOME")).equals("1"))
					{
						sbolddata.append(" ~Include Income for Eligibility=").append("No");
					}
					else
					{
						sbolddata.append(" ~Include Income for Eligibility=").append("Yes");
					}
					/***
					 * End - Audit Trial Old Data
					 */
				}
			}
			if (strAction.equals("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "perloandetailsdemoins");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strHidId);
				arrValues.add(strType);
				arrValues.add(strRelation);
				arrValues.add(strIncludeIncome);
				arrValues.add(strOldid);
				arrValues.add(strRelationType);
				arrValues.add(strType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			}
			else if (strAction.equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "perloandetailsdemodel");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strHidId);
				arrValues.add(strType);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				
				//FOR CREDIT REPORT
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delcreditreport");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strType+strHidId);				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delcreditreport2");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strType+strHidId);				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size", "2");
				
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delcreditreport3");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strType+strHidId);				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size", "3");
				
				
				if(Helper.correctNull((String)hshRequestValues.get("strAppType")).equalsIgnoreCase("P"))
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQueryValues.put("size","4");
					hshQuery.put("strQueryId","upd_dettachflag_coappguarwise");
					arrValues.add(strOldid);
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("4",hshQuery);
					
				}
				else
				{
					arrValues=new ArrayList();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","deletecoappguarpropsec");
					arrValues.add(strAppno);
					arrValues.add("P");
					arrValues.add(strOldid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","4");
					hshQueryValues.put("4",hshQuery);
				}
				
				arrValues=new ArrayList();
				hshQuery=new HashMap();
				hshQuery.put("strQueryId","delcoappguarexistingsec");
				arrValues.add(strAppno);
				arrValues.add("E");
				arrValues.add(strOldid);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","5");
				hshQueryValues.put("5",hshQuery);
			}
			else if (strAction.equals("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "perloandetailsdemoupd1");
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strHidId);
				arrValues.add(strType);
				arrValues.add(strRelation);
				arrValues.add(strIncludeIncome);
				arrValues.add(strHidId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			}
			if(strAction.equalsIgnoreCase("Undo"))
			{
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues=new HashMap();
				arrValues.add("N");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");//added by ganesan
				hshQueryValues.put("size","4");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_groupconcern_freeze");//added by ganesan
				hshQueryValues.put("size","4");
				hshQueryValues.put("2",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add("E");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_banking_freeze");
				hshQueryValues.put("size","4");
				hshQueryValues.put("3",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_appsecurities_freeze");
				hshQueryValues.put("size","4");
				hshQueryValues.put("4",hshQuery);
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strAppno);
				arrValues.add("E");
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","del_comfacility_details");
				hshQueryValues.put("size","5");
				hshQueryValues.put("5",hshQuery);
				
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(strAppno);
//				arrValues.add(strAppno);
//				hshQuery.put("arrValues",arrValues);
//				hshQuery.put("strQueryId","del_appsecurities_freeze_retail");
//				hshQueryValues.put("size","5");
//				hshQueryValues.put("5",hshQuery);
				
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("update")||strAction.equalsIgnoreCase("delete"))
			{
				updateRepaymentCapacityValue(hshRequestValues);
			}
			StringBuilder sbAt = new StringBuilder();
			/***
			 * For Audit Trial New Data - By Karthikeyan.S on 20/09/2013
			 */
			if ((strAction.equalsIgnoreCase("insert"))||(strAction.equalsIgnoreCase("update")))
			{
				MastApplicantBean MAB=new MastApplicantBean();
				String strRelationCode=Helper.correctNull((String) hshRequestValues.get("txtrelation"));
				String strRelationDesc="";
				strRelationDesc=MAB.getMasterDesc("StatMast", "123", strRelationCode);
				if (correctNull((String) hshRequestValues.get("seltype")).equalsIgnoreCase("c"))
				{
					sbAt.append("Applicant Type =").append("Joint-Applicant");
				}
				else if (correctNull((String) hshRequestValues.get("seltype")).equalsIgnoreCase("o"))
				{
					sbAt.append("Applicant Type =").append("Co-Obligant");
				}
				else if(correctNull((String) hshRequestValues.get("seltype")).equalsIgnoreCase("g"))
				{
					sbAt.append("Applicant Type =").append("Guarantor");
				}
				sbAt.append("  ~ Name of the Person =").append(correctNull((String) hshRequestValues.get("txtloan_cname")));
				sbAt.append("  ~ Relationship with the Applicant =").append(strRelationDesc);
				if (correctNull((String) hshRequestValues.get("sel_incomeeligibility")).equalsIgnoreCase("1")) 
				{
					sbAt.append(" ~ Include Income for Eligibility =").append("No");
				}
				else if (correctNull((String) hshRequestValues.get("sel_incomeeligibility")).equalsIgnoreCase("2")) {
					sbAt.append(" ~ Include Income for Eligibility =").append("Yes");
				}
			}
			AuditTrial.auditNewLog(hshRequestValues,"228",strAppno,sbAt.toString(),sbolddata.toString());
			/***
			 * End - Audit Trial New Data
			 */
		}
		catch (Exception e)
		{
			throw new EJBException(e.getMessage());
		}
	}

	public HashMap getCoAppGuarantor(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 =null;
		ResultSet rs2 =null;
		HashMap hshRecord = new HashMap();
		String strAppno = (String) hshRequestValues.get("appno");
		String strPrdType = (String) hshRequestValues.get("strProductType");
		String strPrdCode = Helper.correctInt((String) hshRequestValues.get("prdcode"));
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;
		String strRel="", strRelDesc="",strQuery="",strQuery4="",strDemoType1="",strattachavail="N";
		String ModuleType="";
		try
		{
			String strAppId=Helper.correctNull((String) hshRequestValues.get("hidapplicantnewid"));
			ModuleType=Helper.correctNull((String) hshRequestValues.get("sessionModuleType"));
			if(strAppId.equalsIgnoreCase(""))
				strAppId=Helper.correctNull((String) hshRequestValues.get("hidapplicantid"));
			
			// For Coapp/Guarantor removal while freeze
			if(rs!=null)
				rs.close();
			int cgtmseGrpMgmtcnt=0;
			String cgtmseGrpMgmt="";
			String strCoApp_Gua_ID="";
			String Coapp_GuaID="";
			strQuery = SQLParser.getSqlQuery("sel_CoAppGuaID^"+strAppId);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strCoApp_Gua_ID+=","+Helper.correctNull(rs.getString("COMAPP_CBSID"));
			}
			strCoApp_Gua_ID=strCoApp_Gua_ID.replaceFirst(",", "");
			
			rs = DBUtils.executeLAPSQuery("getcoappguarantor^" + strAppno);
			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
				if(!strCoApp_Gua_ID.contains(correctNull(rs.getString("perapp_cbsid"))))
					Coapp_GuaID+=","+correctNull(rs.getString("perapp_cbsid"))+"-"+correctNull(rs.getString(2));
				
				strRel=Helper.correctNull(rs.getString(4));
				if(!strRel.equalsIgnoreCase(""))
				{
					rs2 = DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^"+"32"+"^"+strRel);
					if(rs2.next())
					{
						strRelDesc=Helper.correctNull(rs2.getString("CBS_STATIC_DATA_DESC"));
					}
				}
				arrCol.add(strRelDesc);
				if (correctNull(rs.getString(5)) == "")
				{
					arrCol.add("1");
				}
				else
				{
					arrCol.add(correctNull(rs.getString(5)));
				}
				String strCreditAppid=correctNull(rs.getString("creditappid"));
				rs1 = DBUtils.executeLAPSQuery("creditreport_appidcheck^"+strAppno+"^"+strCreditAppid);
				if(rs1.next())
					arrCol.add("Y");	
				else
					arrCol.add("N");
				
				if(rs1!=null)
					rs1.close();
				arrCol.add(correctNull(rs.getString("DEMO_CBSRELATIONTYPE")));
				arrRow.add(arrCol);
				strattachavail="Y";
				
				String strCGTMSE_CONCERNTYPE="",PERAPP_CONSTITUTION="";
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("selcustomerdetails^"+strAppId);
				if(rs1.next())
				{
					strCGTMSE_CONCERNTYPE=Helper.correctNull(rs1.getString("CBS_STATIC_CGTMSE_CONCERNTYPE"));
					PERAPP_CONSTITUTION=Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION"));
				}
				
				String arrCGTMSE_CONCERNTYPE[]=null;
				String concernType="";
				if(!strCGTMSE_CONCERNTYPE.equals(""))
				{
					arrCGTMSE_CONCERNTYPE=strCGTMSE_CONCERNTYPE.split("@");
					
					for(int i=0;i<arrCGTMSE_CONCERNTYPE.length;i++)
					{
						concernType=concernType+",'"+arrCGTMSE_CONCERNTYPE[i]+"'";
						
					}
				}
				
				if(!concernType.equals(""))
					concernType=concernType.replaceFirst(",", "");
				else
					concernType="''";
				
				if(PERAPP_CONSTITUTION.equals("01"))
				{
					cgtmseGrpMgmt="Y";//group management people
					cgtmseGrpMgmtcnt++;
				}
				else
				{
//					if(rs1!=null)
//						rs1.close();
					
					String strQuery1 = SQLParser.getSqlQuery("sel_appl_grpManagement^"+strAppno+"^"+Helper.correctInt(Helper.correctNull(rs.getString("PERAPP_CBSID")))+"^"+concernType);
					rs1 = DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						cgtmseGrpMgmt="Y";//group management people
					}
					else
					{
						cgtmseGrpMgmt="N";//not group management people
						cgtmseGrpMgmtcnt++;
					} 
				}
			}
			
			if(cgtmseGrpMgmtcnt>0)
			{
				cgtmseGrpMgmt="N";
			}
			else
			{
				cgtmseGrpMgmt="Y";
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strAppNo",strAppno);
			hshRecord.put("strCoApp_Gua_ID",Coapp_GuaID.replaceFirst(",", ""));
			hshRecord.put("str_CGTMSEFlag",Helper.correctNull((String) hshRequestValues.get("PRD_CGTMSE")));
			if(rs!=null)rs.close();
			String strQuery1 = SQLParser.getSqlQuery("sel_includeincomecount^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				hshRecord.put("inccount", Helper.correctNull((String)rs.getString("inccount")));
			}
			if(rs!=null)rs.close();
			/*Commented by Arsath for Performance Tuning
			 * New Query has been created only for 2 columns
			 */
			//String strQuery2 = SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
			String strQuery2 = SQLParser.getSqlQuery("sel_specificeligible_new^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				hshRecord.put("PRD_NOOFAPPLICNTINC", Helper.correctNull((String)rs.getString("PRD_NOOFAPPLICNTINC")));
			}
			if(rs!=null)rs.close();
			strQuery2 = SQLParser.getSqlQuery("sel_productdesc^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery2);
			if(rs.next())
			{
				hshRecord.put("prd_purpose", Helper.correctNull(rs.getString("prd_purpose")));
				hshRecord.put("prd_loantype", Helper.correctNull(rs.getString("prd_loantype")));
			}
			if(rs!=null)rs.close();
			String strQuery3 = SQLParser.getSqlQuery("sel_incincmeofcoapps^"+strPrdCode);
			rs = DBUtils.executeQuery(strQuery3);
			if(rs.next())
			{
				hshRecord.put("PRD_JOINTAPPLICANT", Helper.correctNull(rs.getString("PRD_JOINTAPPLICANT")));
				hshRecord.put("PRD_COOBLIGANT", Helper.correctNull(rs.getString("PRD_COOBLIGANT")));
				hshRecord.put("PRD_GUARANTOR", Helper.correctNull(rs.getString("PRD_GUARANTOR")));
			}
			if(strPrdType.equalsIgnoreCase("pH")||(strPrdType.equalsIgnoreCase("pV"))||(strPrdType.equalsIgnoreCase("pM"))||(strPrdType.equalsIgnoreCase("pA")))
			{
				int intcoapp=0,intguar=0,intproperitier=0,intco_obligant=0;
				if(rs!=null)rs.close();
				strQuery3 = SQLParser.getSqlQuery("sel_specificeligible^"+strPrdCode);
				rs = DBUtils.executeQuery(strQuery3);
				if(rs.next())
				{
					hshRecord.put("prd_maxnoofjointapp", Helper.correctNull(rs.getString("prd_maxnoofjointapp")));
					hshRecord.put("prd_maxnoofguarantor", Helper.correctNull(rs.getString("prd_maxnoofguarantor")));
					hshRecord.put("prd_maxnoofproperitier", Helper.correctNull(rs.getString("prd_maxnoofproperitier")));
				}
				
				if(rs!=null)rs.close();
				strQuery3 = SQLParser.getSqlQuery("chkcoappguarcount^"+strAppno);
				rs = DBUtils.executeQuery(strQuery3);
				while(rs.next())
				{
					if(Helper.correctNull(rs.getString("demo_type")).equalsIgnoreCase("c"))
					{
						intcoapp=Integer.parseInt(Helper.correctInt((String)rs.getString("count")));
					}
					else if(Helper.correctNull(rs.getString("demo_type")).equalsIgnoreCase("g"))
					{
						intguar=Integer.parseInt(Helper.correctInt((String)rs.getString("count")));	
					}
					else if(Helper.correctNull(rs.getString("demo_type")).equalsIgnoreCase("p"))
					{
						intproperitier=Integer.parseInt(Helper.correctInt((String)rs.getString("count")));	
					}
					else if(Helper.correctNull(rs.getString("demo_type")).equalsIgnoreCase("o"))
					{
						intco_obligant=Integer.parseInt(Helper.correctInt((String)rs.getString("count")));	
					}
				}
				hshRecord.put("strCoappcnt",String.valueOf(intcoapp));
				hshRecord.put("strGuarcnt",String.valueOf(intguar));
				hshRecord.put("strProperitiercnt",String.valueOf(intproperitier));
				hshRecord.put("strCoobligantcnt",String.valueOf(intco_obligant));
				
			}
			hshRecord.put("strPrdType", strPrdType);
			String strFreeze="";
	  		if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if(rs.next()) 
			{
				strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
			}
			hshRecord.put("strFreeze",strFreeze);
			
			if(rs!=null) rs.close();
			int strFreezecount=0;
		   	String strFreezeflag="N";
		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt(rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			hshRecord.put("strSecFreezeflag",strFreezeflag);
			// for Guarantor details check
//			int a=0;
//			if(rs!=null)
//                rs.close();
//			rs=DBUtils.executeLAPSQuery("sel_guar_check^"+strAppno);
// 			while(rs.next())
//    		{
// 				if(!Helper.correctNull(rs.getString("DEMO_APPID")).equalsIgnoreCase(""))
// 				{
// 					if(rs1!=null)
// 						rs1.close();
// 					rs1=DBUtils.executeLAPSQuery("sel_guar_chklist^"+Helper.correctNull(rs.getString("DEMO_APPID")));
// 		 			if(rs1.next())
// 		    		{
// 		 				if(!Helper.correctNull(rs1.getString("perapp_profilestatus")).equalsIgnoreCase("Y")){a++;}
// 		    		}
// 		 		}
// 			}
// 			if(a>0){
// 				hshRecord.put("strGuarantor","N");
// 				}
// 			else{
// 				hshRecord.put("strGuarantor","Y");
// 				}
			
			if(rs!=null)
				rs.close();
			
			String strInCompleteID="";
			strQuery = SQLParser.getSqlQuery("incomplete_perappid_retail^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strInCompleteID.equalsIgnoreCase(""))
					strInCompleteID=Helper.correctNull(rs.getString("id"));
				else
					strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("check_coappdetails^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(!strInCompleteID.contains(Helper.correctNull(rs.getString("id"))))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
					{
						strQuery=SQLParser.getCBSSqlQuery("cbs_custdetails_select_newconnection^"+Helper.correctNull(rs.getString("id")));
						rs1=DBUtils.executeQueryCBSConnection(strQuery);
					}
					else
					{
						strQuery= SQLParser.getSqlQuery("cbs_custdetails_select^"+Helper.correctNull(rs.getString("id")));
						rs1=DBUtils.executeQuery(strQuery); 
					}
					if(!rs1.next())
					{
						if(strInCompleteID.equalsIgnoreCase(""))
							strInCompleteID=Helper.correctNull(rs.getString("id"));
						else
							strInCompleteID+=","+Helper.correctNull(rs.getString("id"));
					}
				}
			}
			hshRecord.put("strInCompleteID",strInCompleteID);
			if(rs1!=null)
			{
				rs1.close();
			}
			
			arrRow = new ArrayList();
			ArrayList arrRow1 = new ArrayList();
			int inthuntscore1=0,intHuntScore=0,intHuntScore1=0;;
	         String strAppHuntStatus="";
	         
	           strQuery1 = SQLParser.getSqlQuery("sel_hunterscore");
				rs=DBUtils.executeQuery(strQuery1); 

				if (rs.next()) {
					intHuntScore=Integer.parseInt(Helper.correctInt((String)rs.getString("LOAN_PARAMVAL")));
				}
				if (rs != null) {
					rs.close();
				}
	         
			strQuery1 = SQLParser.getSqlQuery("sel_retappdetails^" + strAppno);
			rs=DBUtils.executeQuery(strQuery1); 
			while(rs.next()) {
				 arrCol = new ArrayList();
				 
				arrCol.add(Helper.correctNull((String) rs
						.getString("DEMO_APPID")));
				arrCol.add(Helper.correctInt((String) rs
						.getString("DEF_HUNTER_SCORE")));
				arrCol.add(Helper.correctNull((String) rs
						.getString("PERAPP_FNAME")));
						arrCol.add(Helper.correctInt((String) rs
								.getString("DEMO_TYPE")));
						strDemoType1=Helper.correctNull((String) rs
								.getString("DEMO_TYPE"));
						if(strDemoType1.equalsIgnoreCase("a")){
							inthuntscore1=Integer.parseInt(Helper.correctInt((String) rs
									.getString("DEF_HUNTER_SCORE")));
							arrRow.add(arrCol);
						}
						else
						{
							arrRow1.add(arrCol);
						}
			}
			
			 ArrayList arrCol1 = new ArrayList();
		     ArrayList arrCol2 = new ArrayList();
		     ArrayList HSCorelist = new ArrayList();
			 ArrayList HSCorelist1 = new ArrayList();
         
           
		if(inthuntscore1<intHuntScore)
		{
			strAppHuntStatus="Y";
				
		}
		else
		{
			strAppHuntStatus="N";
		}
			for (int i = 0; i < arrRow.size(); i++) {
				
				arrCol1=(ArrayList)arrRow.get(i);
				intHuntScore1=Integer.parseInt(Helper.correctInt((String)arrCol1.get(1)));
					if(intHuntScore1<intHuntScore){
						arrCol2= new ArrayList();
						arrCol2.add(arrCol1.get(0));
						arrCol2.add(arrCol1.get(2));
						HSCorelist.add(arrCol2);
					}
				}
          for (int i = 0; i < arrRow1.size(); i++) {
				
				arrCol1=(ArrayList)arrRow1.get(i);
				intHuntScore1=Integer.parseInt(Helper.correctInt((String)arrCol1.get(1)));
					if(intHuntScore1<intHuntScore){
						arrCol2= new ArrayList();
						arrCol2.add(arrCol1.get(0));
						arrCol2.add(arrCol1.get(2));
						HSCorelist1.add(arrCol2);
					}
				}
			System.out.println("HSCorelist=======>>>"+HSCorelist);
			System.out.println("HSCorelist1=======>>>"+HSCorelist1);
			hshRecord.put("HSCorelist",HSCorelist);
			hshRecord.put("HSCorelist1",HSCorelist1);
			hshRecord.put("dblHuntScore",String.valueOf(intHuntScore));
			if (rs != null)
				rs.close();
			strQuery1=SQLParser.getSqlQuery("sel_app_perm_no^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				hshRecord.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
			}
			if(rs!=null){
				rs.close();
			}
			String strQuery8=null;
			ResultSet  rs4=null;
			   ArrayList arrCol4 = new ArrayList();
			strQuery1=SQLParser.getSqlQuery("sel_permissionmaster");
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next()){
				strQuery8=SQLParser.getSqlQuery("sel_huntercheck^"+strAppno+"^"+Helper.correctInt((String) rs.getString("PER_ID")));
				rs4 = DBUtils.executeQuery(strQuery8);
				while(rs4.next())
				{
					
					
					   arrCol4.add(correctNull(rs.getString(1)));
					   arrCol4.add(correctNull(rs.getString(2)));
					//hshRecord.put("DEV_DEVPARAM",Helper.correctNull(rs4.getString("DEV_DEVPARAM")));
				}
			 
		}
			
			String strcgtmseavail="N";
			strQuery1=SQLParser.getSqlQuery("getlreq^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("LOAN_CGTMSE_APPLICABLE")).equalsIgnoreCase("Y") )
				{
					if((strattachavail.equalsIgnoreCase("Y") && cgtmseGrpMgmt.equals("N")))
					{
						strcgtmseavail="Y";
						break;
					}
				}
			}
			String strappidApplicant="";
			strQuery = SQLParser.getSqlQuery("sel_CoappCheckFor_CGTMSEapplicant^"+strAppno);
    		rs4 = DBUtils.executeQuery(strQuery);
			if(rs4.next()) 
			{
				strappidApplicant=Helper.correctNull(rs4.getString("DEMO_APPID"));
			}
			String strappid="",strNOtRequiredAppid="",strNOtRequiredFlag="",strAPPNAMES="";
			strQuery1=SQLParser.getSqlQuery("sel_CoappCheckFor_CGTMSE^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				strappid=Helper.correctNull(rs.getString("DEMO_APPID"));
				
				if(!strappid.equalsIgnoreCase(""))
				{
					strQuery = SQLParser.getSqlQuery("sel_CoappCheckForAPPIDS_CGTMSE_appname^"+strappid);
		    		rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next()) 
					{
						strAPPNAMES=Helper.correctNull(rs4.getString("PERAPP_FNAME"));
					}					

					strQuery = SQLParser.getSqlQuery("sel_CoappCheckForAPPIDS_CGTMSE^"+strappid+"^"+strappidApplicant);
		    		rs4 = DBUtils.executeQuery(strQuery);
					if(rs4.next()) 
					{
					}
					else
					{
						strNOtRequiredAppid=strNOtRequiredAppid.concat(strAPPNAMES).concat(",");
						strNOtRequiredFlag="Y";
					}
				}
				
			}
			hshRecord.put("strNOtRequiredAppid",strNOtRequiredAppid);
			hshRecord.put("strNOtRequiredFlag",strNOtRequiredFlag);
			if(rs!=null)
				rs.close();
			hshRecord.put("strcgtmseavail",strcgtmseavail);
			String strcgtmseavailmsg="";
			if(strcgtmseavail.equalsIgnoreCase("Y"))
			{}
			//hshValues.put("strcgtmseavailmsg",strcgtmseavailmsg);
			
			hshRecord.put("arrCol4", arrCol4);
			
			hshRecord.put("strAppHuntStatus", strAppHuntStatus);
			
			if (rs != null)
				rs.close();
			ArrayList arrCol5 = new ArrayList();
			ArrayList arrCol6 = new ArrayList();
			strQuery1=SQLParser.getSqlQuery("sel_digidel_disable^"+strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			while(rs.next())
			{
				arrCol5 = new ArrayList();
				arrCol5.add(correctNull(rs.getString(1)));
				arrCol5.add(correctNull(rs.getString(2)));
				arrCol6.add(arrCol5);
			}
			hshRecord.put("arrColdigiflag", arrCol6);
			if(ModuleType.equalsIgnoreCase("RET"))
			{
				String syschk1="";
				String syschk2="";
				if (rs != null)
					rs.close();
				strQuery1=SQLParser.getSqlQuery("checkeducationloansyschk1^"+strAppno);
				rs = DBUtils.executeQuery(strQuery1);
			     if(rs.next())
				{
			    	 syschk1="Y";
				}
				if (rs != null)
					rs.close();
				strQuery1=SQLParser.getSqlQuery("checkeducationloansyschk2^"+strAppno);
				rs = DBUtils.executeQuery(strQuery1);
				if(rs.next())
				{
					syschk2="Y";
				}
				if(syschk1.equalsIgnoreCase("Y")||syschk2.equalsIgnoreCase("Y"))
				{
					hshRecord.put("syschkforedu","Y");
				}
				else
				{
					hshRecord.put("syschkforedu","N");
				}
				
				//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
				//checking limit amount 
				String sessionModuleType = correctNull((String) hshRequestValues.get("sessionModuleType"));
				 double dblchecklimit = 0.0;
				 double dblchecklimit3 = 0.0;
				 String strQuery11="";
				 String strQuery12="";
				 java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
					jtn.setMaximumFractionDigits(2);
					jtn.setMinimumFractionDigits(2);
					jtn.setGroupingUsed(false);
				 if (sessionModuleType.equalsIgnoreCase("AGR")) {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
					
				 }
				 else if (sessionModuleType.equalsIgnoreCase("CORP")) {
					 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^134");
						rs = DBUtils.executeQuery(strQuery11);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
					 }
				 else
				 {
					 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^135");
						rs = DBUtils.executeQuery(strQuery11);
						if (rs.next()) {
							dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
						}
				}
				//checking limit amount
				String strPanCheck="";
				String strPanCheckcount="";
				if (rs != null)
					rs.close();

				strQuery = SQLParser
						.getSqlQuery("sel_lapsapplicationparameters^132"); 
				rs = DBUtils.executeQuery(strQuery);		
				
				if (rs.next()) {
					strPanCheck = Helper.correctNull(rs.getString("LOAN_PARAMVAL"));
					hshRecord.put("strPanCheck", strPanCheck);
				}
				double dblExplimit = 0.0;
				if (!sessionModuleType.equalsIgnoreCase("AGR")) {
					
					dblExplimit = getExposureTotalLimit(strAppno, "R",sessionModuleType);

					hshRecord.put("strdblExplimit", jtn.format(dblExplimit));
					//if (dblExplimit >= 50000)
					if (dblExplimit>= dblchecklimit)
						hshRecord.put("strExplimitchk", "F");
					else
						hshRecord.put("strExplimitchk", "S");			
					
				}
				double dblExplimitagr = 0.0;
				
				hshRecord.put("strChecklimit", jtn.format(dblchecklimit));
				if (rs != null)
					rs.close();
				int pancount=0;
				strQuery = SQLParser.getSqlQuery("sel_for_pandetails^" + strAppno+ "^" + strAppno+ "^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while (rs.next()) {
					if ((correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("") || correctNull(rs.getString("PERAPP_PANNO")).equalsIgnoreCase("NOPAN")))
							{
								pancount++;
							}
					if(pancount>0)
					{
						hshRecord.put("Pancount", "N");
					}
					else
						hshRecord.put("Pancount", "Y");
					
				}
				
				//exposure limit check for PAN check Except Gold Loan, Depoist Loan, Agriculture, SHG/JLG Borrowers end 	
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
					rs.close();
				
				if (rs1 != null)
					rs1.close();
			}
			catch (Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}

//	public HashMap getPersonalLoandetails(HashMap hshRequestValues) 
//	{
//		ResultSet rs = null;
//		ResultSet rs1 = null;
//		String strGradeId = "", strGradeId2 = "";
//		HashMap hshRecord = new HashMap();
//		HashMap hshRequestvalues = new HashMap();
//		String strAppno = (String) hshRequestValues.get("appno");
//		strGradeId = "A";
//		strGradeId2 = "C";
//		hshRequestvalues.put("strGradeId", strGradeId);
//		hshRequestvalues.put("strGradeId2", strGradeId2);
//		String strQuery = null;
//
//		try
//		{
//			strQuery = SQLParser.getSqlQuery("getpersonalloandetails^" + strAppno + "^" + strGradeId);
//			rs = DBUtils.executeQuery(strQuery);
//
//			while (rs.next())
//			{
//				hshRecord.put("perapp_type", correctNull(rs.getString("perapp_type")));
//				hshRecord.put("perapp_ownhouse", correctNull(rs.getString("perapp_ownhouse")));
//				hshRecord.put("perapp_mortgage", correctNull(rs.getString("perapp_mortgage")));
//				hshRecord.put("perapp_houseval", correctNull(rs.getString("perapp_houseval")));
//				hshRecord.put("perapp_vehicletype", correctNull(rs.getString("perapp_vehicletype")));
//				hshRecord.put("perapp_twowheeler", correctNull(rs.getString("perapp_twowheeler")));
//				hshRecord.put("perapp_fourwheeler", correctNull(rs.getString("perapp_fourwheeler")));
//				hshRecord.put("perapp_vehmake", correctNull(rs.getString("perapp_vehmake")));
//				hshRecord.put("perapp_vehage", correctNull(rs.getString("perapp_vehage")));
//				hshRecord.put("perapp_comprovided", correctNull(rs.getString("perapp_comprovided")));
//				hshRecord.put("perapp_presentliab", correctNull(rs.getString("perapp_presentliab")));
//				hshRecord.put("perapp_purpose", correctNull(rs.getString("perapp_purpose")));
//				hshRecord.put("perapp_loanamt", correctNull(rs.getString("perapp_loanamt")));
//				hshRecord.put("perapp_repayment", correctNull(rs.getString("perapp_repayment")));
//				hshRecord.put("perapp_emi", correctNull(rs.getString("perapp_emi")));
//				hshRecord.put("perapp_ref1name", correctNull(rs.getString("perapp_ref1name")));
//				hshRecord.put("perapp_ref1add1", correctNull(rs.getString("perapp_ref1add1")));
//				hshRecord.put("perapp_ref1add2", correctNull(rs.getString("perapp_ref1add2")));
//				hshRecord.put("perapp_ref1city", correctNull(rs.getString("perapp_ref1city")));
//				hshRecord.put("perapp_ref1state", correctNull(rs.getString("perapp_ref1state")));
//				hshRecord.put("perapp_ref1pin", correctNull(rs.getString("perapp_ref1pin")));
//				hshRecord.put("perapp_ref1phone", correctNull(rs.getString("perapp_ref1phone")));
//				hshRecord.put("perapp_ref2name", correctNull(rs.getString("perapp_ref2name")));
//				hshRecord.put("perapp_ref2add1", correctNull(rs.getString("perapp_ref2add1")));
//				hshRecord.put("perapp_ref2add2", correctNull(rs.getString("perapp_ref2add2")));
//				hshRecord.put("perapp_ref2city", correctNull(rs.getString("perapp_ref2city")));
//				hshRecord.put("perapp_ref2state", correctNull(rs.getString("perapp_ref2state")));
//				hshRecord.put("perapp_ref2pin", correctNull(rs.getString("perapp_ref2pin")));
//				hshRecord.put("perapp_ref2phone", correctNull(rs.getString("perapp_ref2phone")));
//			}
//			if (rs != null)
//				rs.close();
//
//			strQuery = SQLParser.getSqlQuery("getpersonalloanspousedetails^" + strAppno + "^" + strGradeId2);
//			rs1 = DBUtils.executeQuery(strQuery);
//			while (rs1.next())
//			{
//				hshRecord.put("selspouseownhouse", correctNull(rs1.getString("perapp_ownhouse")));
//				hshRecord.put("selspousehousmortgage", correctNull(rs1.getString("perapp_mortgage")));
//				hshRecord.put("txtspouse_valhouse", correctNull(rs1.getString("perapp_houseval")));
//				hshRecord.put("selspousevehicletype", correctNull(rs1.getString("perapp_vehicletype")));
//				hshRecord.put("txtspouse_twowheeler", correctNull(rs1.getString("perapp_twowheeler")));
//				hshRecord.put("txtspouse_fourwheel", correctNull(rs1.getString("perapp_fourwheeler")));
//				hshRecord.put("txtspouse_make", correctNull(rs1.getString("perapp_vehmake")));
//				hshRecord.put("txtspouse_age", correctNull(rs1.getString("perapp_vehage")));
//				hshRecord.put("txtsp_comprovided", correctNull(rs1.getString("perapp_comprovided")));
//				hshRecord.put("txtsp_liability", correctNull(rs1.getString("perapp_presentliab")));
//			}
//		}
//		catch (Exception e)
//		{
//			throw new EJBException(e.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//				if (rs1 != null)
//				{
//					rs1.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				throw new EJBException(e1.getMessage());
//			}
//		}
//		return hshRecord;
//	}

//	public void updatePersonalLoanData(HashMap hshValues) 
//	{
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = null;
//		HashMap hshRequestvalues = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		String strAction = (String) hshValues.get("hidAction");
//		String strGradeId = "", strGradeId2 = "", strAppno = "";
//		strAppno = (String) hshValues.get("appno1");
//		ResultSet rs = null;
//		try
//		{
//			strGradeId = "A";
//			strGradeId2 = "C";
//			hshRequestvalues.put("strGradeId", strGradeId);
//			hshRequestvalues.put("strGradeId2", strGradeId2);
//
//			if (strAction.equals("update"))
//			{
//				hshQueryValues = new HashMap();
//				hshQuery = new HashMap();
//				hshQueryValues.put("size", "2");
//				arrValues = new ArrayList();
//				arrValues.add(Helper.correctNull((String) hshValues.get("selappownhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selapphousmortgage")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_valhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selappvehicletype")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_twowheeler")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_fourwheel")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_make")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_age")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_comprovided")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_liability")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_purposeloan")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_loanamt")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_repayperiod")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_monrepayment")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefname1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefname2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone2")));
//				arrValues.add(strAppno);
//				hshQuery.put("strQueryId", "loandetailsupdate");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//			}
//			else if (strAction.trim().equals("insert"))
//			{
//				hshQueryValues = new HashMap();
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				hshQueryValues.put("size", "3");
//				arrValues.add(strAppno);
//				hshQuery.put("strQueryId", "deletepersonaldetails");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("1", hshQuery);
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(strAppno);
//				arrValues.add(strGradeId);
//				arrValues.add(correctNull((String) hshValues.get("selappownhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selapphousmortgage")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_valhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selappvehicletype")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_twowheeler")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_fourwheel")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_make")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtperapp_age")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_comprovided")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_liability")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_purposeloan")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_repayperiod")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_monrepayment")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefname1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefname2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone2")));
//				hshQuery.put("strQueryId", "personaldetailsinsert");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("2", hshQuery);
//				hshQuery = new HashMap();
//				arrValues = new ArrayList();
//				arrValues.add(strAppno);
//				arrValues.add(strGradeId2);
//				arrValues.add(Helper.correctNull((String) hshValues.get("selspouseownhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selspousehousmortgage")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtspouse_valhouse")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("selspousevehicletype")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtspouse_twowheeler")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtspouse_fourwheel")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtspouse_make")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtspouse_age")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsp_comprovided")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsp_liability")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_purposeloan")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_repayperiod")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapp_monrepayment")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefname1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtapprefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefname2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd1")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtsporefadd2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencecity2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencestate2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencepin2")));
//				arrValues.add(Helper.correctNull((String) hshValues.get("txtreferencephone2")));
//				hshQuery.put("strQueryId", "personaldetailsinsert");
//				hshQuery.put("arrValues", arrValues);
//				hshQueryValues.put("3", hshQuery);
//				EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//			}
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("inside update" + ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception cf)
//			{
//				throw new EJBException("Error closing the connection " + cf.getMessage());
//			}
//		}
//	}

//	public HashMap renewRetail(HashMap hshValues) 
//	{
//		ResultSet rs = null;
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		HashMap hshformula = new HashMap();
//		HashMap hshResult = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		try
//		{
//			String compname = (String) hshValues.get("appname");
//			rs = DBUtils.executeLAPSQuery("renewretborrowerid^" + compname);
//			String newappid = "";
//			if (rs.next())
//			{
//				newappid = rs.getString(1);
//			}
//			String strOldAppno = (String) hshValues.get("appno");
//			hshformula.put("apptype", "P");
//			hshformula.put("comapp_id", newappid);
//			String strNewAppno = (String) EJBInvoker.executeStateLess("appeditlock", hshformula, "getAppno");
//
//			int querySize = 1;
//			// insert data in application table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretapplnins");
//			hshQueryValues.put("1", hshQuery);
//			querySize = querySize + 1;
//
//			// update per_demographics
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(newappid);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperdemonins");
//			hshQueryValues.put("2", hshQuery);
//			querySize = querySize + 1;
//
//			// insert data in to LOAN DETAILS table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretloanins");
//			hshQueryValues.put("3", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_propdet table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperpropins");
//			hshQueryValues.put("4", hshQuery);
//			querySize = querySize + 1;
//
//			// insert data in to per_stocks table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perinsfinancialinvren");
//			hshQueryValues.put("5", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_properties table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perinsfinancialpropren");
//			hshQueryValues.put("6", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in toper_overdrafts table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperoverdraftins");
//			hshQueryValues.put("7", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_other assests table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperotherassestsins");
//			hshQueryValues.put("8", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_lifestyle table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperlifestyleins");
//			hshQueryValues.put("9", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_liabilities table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perinsfinancialliabren");
//			hshQueryValues.put("10", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_insurance table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perinsfinancialpolren");
//			hshQueryValues.put("11", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_home table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perinscollateralhomeren");
//			hshQueryValues.put("12", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_bank table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperbankins");
//			hshQueryValues.put("13", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to per_auto table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretperautoins");
//			hshQueryValues.put("14", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to apptermsand cond table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewrettermsins");
//			hshQueryValues.put("15", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to app_disbursement table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretdisbursementins");
//			hshQueryValues.put("16", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to app_disbursement table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretsanctionins");
//			hshQueryValues.put("17", hshQuery);
//
//			querySize = querySize + 1;
//			// insert data in to appdocuments table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "renewretdocumentins");
//			hshQueryValues.put("18", hshQuery);
//			hshQueryValues.put("size", Integer.toString(querySize));
//			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//			HashMap hshformulas = new HashMap();
//			hshformulas.put("appno", strNewAppno);
//			hshformulas.put("page", "ep");
//			hshformulas.put("radLoan", "Y");
//			hshResult = (HashMap) EJBInvoker.executeStateLess("perapplicant", hshformulas, "getLoanProducts");
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in updateData " + ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				Logger.log("error occured" + e1.toString());
//			}
//		}
//		return hshResult;
//	}

//	public void renewTranction(HashMap hshValues) 
//	{
//		ResultSet rs = null;
//		HashMap hshQueryValues = new HashMap();
//		HashMap hshQuery = new HashMap();
//		HashMap hshformula = new HashMap();
//		ArrayList arrValues = new ArrayList();
//		try
//		{
//			String compname = (String) hshValues.get("appname");
//			rs = DBUtils.executeLAPSQuery("renewretborrowerid^" + compname);
//			String newappid = "";
//			if (rs.next())
//			{
//				newappid = rs.getString(1);
//			}
//			String strOldAppno = (String) hshValues.get("appno");
//			String appid = (String) hshValues.get("comappid");
//			hshformula.put("apptype", "P");
//			hshformula.put("comapp_id", newappid);
//			String strNewAppno = (String) EJBInvoker.executeStateLess("appeditlock", hshformula, "getAppno");
//
//			int querySize = 1;
//			// insert data in to app_disbursement table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strOldAppno);
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perrenewdel");
//			hshQueryValues.put("1", hshQuery);
//			hshQueryValues.put("size", Integer.toString(querySize));
//			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//			querySize = 1;
//			// insert data in application table
//			arrValues = new ArrayList();
//			hshQuery = new HashMap();
//			arrValues.add(strNewAppno);
//			arrValues.add(newappid);
//			arrValues.add(strOldAppno);
//			arrValues.add(appid);
//			if (correctNull((String) hshValues.get("cho_asset")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("cho_asset")));
//			if (correctNull((String) hshValues.get("txt_osamount")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_osamount")));
//
//			if (correctNull((String) hshValues.get("txt_overdue")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_overdue")));
//
//			if (correctNull((String) hshValues.get("txt_overdueint")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_overdueint")));
//
//			if (correctNull((String) hshValues.get("txt_interest")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_interest")));
//
//			if (correctNull((String) hshValues.get("txt_charges")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_charges")));
//
//			if (correctNull((String) hshValues.get("txt_maxbalance")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_maxbalance")));
//
//			if (correctNull((String) hshValues.get("txt_minbalance")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_minbalance")));
//			if (correctNull((String) hshValues.get("txt_credit")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_credit")));
//			if (correctNull((String) hshValues.get("txt_debit")).equals(""))
//				arrValues.add("0.00");
//			else
//				arrValues.add(correctNull((String) hshValues.get("txt_debit")));
//			arrValues.add(correctNull((String) hshValues.get("rd_terms")));
//			arrValues.add(correctNull((String) hshValues.get("rd_documents")));
//			arrValues.add(correctNull((String) hshValues.get("rd_loan")));
//			arrValues.add(correctNull((String) hshValues.get("txt_zicinspection")));
//			arrValues.add(correctNull((String) hshValues.get("txt_brcomments")));
//			arrValues.add(correctNull((String) hshValues.get("txt_loa")));
//			arrValues.add(correctNull((String) hshValues.get("txt_lastreview")));
//			arrValues.add(correctNull((String) hshValues.get("txt_secdoc")));
//			arrValues.add(correctNull((String) hshValues.get("txt_lad")));
//			arrValues.add(correctNull((String) hshValues.get("txt_observ")));
//			arrValues.add(correctNull((String) hshValues.get("txt_sanauth")));
//
//			hshQuery.put("arrValues", arrValues);
//			hshQuery.put("strQueryId", "perrenewins");
//			hshQueryValues.put("1", hshQuery);
//			hshQueryValues.put("size", Integer.toString(querySize));
//			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in updateData " + ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				Logger.log("error occured" + e1.toString());
//			}
//		}
//	}

//	public HashMap getRenewData(HashMap hsh) 
//	{
//		String strQuery = "";
//		ResultSet rs = null;
//		ResultSet rs1 = null;
//		HashMap hshValues = new HashMap();
//		ArrayList vecReport = new ArrayList();
//		ArrayList vecCoapp = null;
//		String strType = "";
//		String strbankbal = "";
//		String strshare = "";
//		String strinsurance = "";
//		String strpermovprop = "";
//		String strperimmovprop = "";
//		String strtotlia = "";
//		String TotalMoveable = "";
//		String TotalAssets = "";
//		String NetAssets = "";
//		String strName = "";
//		String strId = "";
//		String strQuery1 = "";
//		try
//		{
//			String strOldAppno = (String) hsh.get("appno");
//			rs = DBUtils.executeLAPSQuery("perrenewsel^" + strOldAppno);
//
//			if (rs.next())
//			{
//				hshValues.put("renew_appno", correctNull(rs.getString("renew_appno")));
//				hshValues.put("renew_borrowerid", correctNull(rs.getString("renew_borrowerid")));
//				hshValues.put("reold_appno", correctNull(rs.getString("reold_appno")));
//				hshValues.put("reold_borrowerid", correctNull(rs.getString("reold_borrowerid")));
//				hshValues.put("renew_date", correctNull(rs.getString("renew_date")));
//				hshValues.put("renew_asset", correctNull(rs.getString("renew_asset")));
//				hshValues.put("renew_outstanding", correctNull(rs.getString("renew_outstanding")));
//				hshValues.put("renew_overdueinstallment", correctNull(rs.getString("renew_overdueinstallment")));
//				hshValues.put("renew_overdueinterest", correctNull(rs.getString("renew_overdueinterest")));
//				hshValues.put("renew_intearned", correctNull(rs.getString("renew_intearned")));
//				hshValues.put("renew_charges", correctNull(rs.getString("renew_charges")));
//				hshValues.put("renew_maxbalance", correctNull(rs.getString("renew_maxbalance")));
//				hshValues.put("renew_minbalance", correctNull(rs.getString("renew_minbalance")));
//				hshValues.put("renew_creditturnover", correctNull(rs.getString("renew_creditturnover")));
//				hshValues.put("renew_debitturnover", correctNull(rs.getString("renew_debitturnover")));
//				hshValues.put("renew_sanction", correctNull(rs.getString("renew_sanction")));
//				hshValues.put("renew_documents", correctNull(rs.getString("renew_documents")));
//				hshValues.put("renew_payregular", correctNull(rs.getString("renew_payregular")));
//				hshValues.put("renew_adverse", correctNull(rs.getString("renew_adverse")));
//				hshValues.put("renew_comments", correctNull(rs.getString("renew_comments")));
//				hshValues.put("renew_lineofactivity", correctNull(rs.getString("renew_lineofactivity")));
//
//				if (correctNull(rs.getString("renew_lastreview")).trim().equals("01/01/1900"))
//				{
//					hshValues.put("renew_lastreview", "");
//				}
//				else
//				{
//					hshValues.put("renew_lastreview", correctNull(rs.getString("renew_lastreview")));
//				}
//				if (correctNull(rs.getString("renew_sedocdat")).trim().equals("01/01/1900"))
//				{
//					hshValues.put("renew_sedocdat", "");
//				}
//				else
//				{
//					hshValues.put("renew_sedocdat", correctNull(rs.getString("renew_sedocdat")));
//				}
//				if (correctNull(rs.getString("renew_LADdat")).trim().equals("01/01/1900"))
//				{
//					hshValues.put("renew_LADdat", "");
//				}
//				else
//				{
//					hshValues.put("renew_LADdat", correctNull(rs.getString("renew_LADdat")));
//				}
//				hshValues.put("renew_observ", correctNull(rs.getString("renew_observ")));
//				hshValues.put("renew_sanauth", correctNull(rs.getString("renew_sanauth")));
//			}
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("selappraisalsanc^" + strOldAppno);
//
//			if (rs.next())
//			{
//				hshValues.put("applname", correctNull(rs.getString("applname")));// applname
//				hshValues.put("perapp_address1", correctNull(rs.getString("perapp_address1")));// perapp_address1
//				hshValues.put("perapp_address2", correctNull(rs.getString("perapp_address2")));// perapp_address2
//				hshValues.put("perapp_city", correctNull(rs.getString("perapp_city")));// perapp_city
//				hshValues.put("perapp_state", correctNull(rs.getString("perapp_state")));// perapp_state,
//				hshValues.put("perapp_zip", correctNull(rs.getString("perapp_zip")));// perapp_zip
//				hshValues.put("loan_emi", correctNull(rs.getString("loan_emi")));// loan_emi
//				hshValues.put("loan_costloanprd", correctNull(rs.getString("loan_costloanprd")));// loan_costloanprd
//				hshValues.put("prd_desc", correctNull(rs.getString("prd_desc")));// loan_purposeofloan
//				hshValues.put("loan_recmdamt", correctNull(rs.getString("loan_recmdamt")));// loan_recmdamt
//				hshValues.put("loan_reqterms", correctNull(rs.getString("loan_reqterms")));// loan_reqterms
//				hshValues.put("app_processdate", correctNull(rs.getString("app_processdate")));// app_processdate
//				hshValues.put("app_approvedby", correctNull(rs.getString("app_approvedby")));// app_approvedby
//				hshValues.put("loan_reqterms", correctNull(rs.getString("loan_reqterms")));// loan_reqterms
//				hshValues.put("orgname", correctNull(rs.getString("org_name")));
//				hshValues.put("orgadd1", correctNull(rs.getString("org_add1")));
//				hshValues.put("orgadd2", correctNull(rs.getString("org_add2")));
//				hshValues.put("orgzip", correctNull(rs.getString("org_zip")));
//				hshValues.put("orgstate", correctNull(rs.getString("org_state")));
//			}
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("securesel^" + strOldAppno);
//			if (rs.next())
//			{
//				hshValues.put("loan_noofinstallment", correctNull(rs.getString("loan_noofinstallment")));// loan_noofinstallment
//			}
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("selappraisalnotes^" + strOldAppno);
//
//			if (rs.next())
//			{
//				hshValues.put("appsanc_facility", correctNull(rs.getString("appsanc_facility")));
//			}
//			ArrayList veccoapp = new ArrayList();
//			rs = null;
//			strQuery = SQLParser.getSqlQuery("selCorrespNamesRep^" + strOldAppno + "^" + "c");
//			rs = DBUtils.executeQuery(strQuery);
//
//			while (rs.next())
//			{
//				veccoapp.add(correctNull(rs.getString("name")));
//			}
//			hshValues.put("veccoapp", veccoapp);
//			ArrayList vecgar = new ArrayList();
//			rs = null;
//			strQuery = SQLParser.getSqlQuery("selCorrespNamesRep^" + strOldAppno + "^" + "g");
//			rs = DBUtils.executeQuery(strQuery);
//
//			while (rs.next())
//			{
//				vecgar.add(correctNull(rs.getString("name")));
//			}
//			hshValues.put("vecgar", vecgar);
//
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("apprep10^" + strOldAppno);
//			if (rs.next())
//			{
//				hshValues.put("loandef", correctNull(rs.getString("prd_type")));
//			}
//			rs = null;
//			ArrayList arrVal = new ArrayList();
//			ArrayList arrRec = new ArrayList();
//			rs = DBUtils.executeLAPSQuery("perotherassetselect^" + strOldAppno);
//			while (rs.next())
//			{
//				arrRec = new ArrayList();
//				arrRec.add(correctNull(rs.getString(1)));
//				arrVal.add(arrRec);
//			}
//			hshValues.put("arrVal", arrVal);
//			java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
//			nf.setGroupingUsed(false);
//			nf.setMaximumFractionDigits(2);
//			nf.setMinimumFractionDigits(2);
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("appreport_3^" + strOldAppno);
//			while (rs.next())
//			{
//				vecCoapp = new ArrayList();
//				strType = correctNull(rs.getString("demo_type"));
//				strId = strType + correctNull(rs.getString("demo_appid"));
//				if (strType.trim().equalsIgnoreCase("a"))
//				{
//					strType = "Applicant";
//				}
//				else if (strType.trim().equalsIgnoreCase("c"))
//				{
//					strType = "Co-Applicant";
//				}
//				else if (strType.trim().equalsIgnoreCase("g"))
//				{
//					strType = "Guarantor";
//				}
//				vecCoapp.add(strType);
//				strName = correctNull(rs.getString("coappname"));
//				vecCoapp.add(strName);
//				strQuery1 = SQLParser.getSqlQuery("appreport_2^" + strId + "^" + strOldAppno + "^" + strId + "^"
//						+ strOldAppno + "^" + strId + "^" + strOldAppno + "^" + strId + "^" + strOldAppno + "^" + strId
//						+ "^" + strOldAppno + "^" + strOldAppno + "^" + "^" + strOldAppno + strId);
//				rs1 = DBUtils.executeQuery(strQuery);
//
//				if (rs1.next())
//				{
//					strbankbal = Helper.correctDouble((String) rs1.getString("bankbal"));
//					strshare = Helper.correctDouble((String) rs1.getString("shares"));
//					strinsurance = Helper.correctDouble((String) rs1.getString("insurance"));
//					strpermovprop = Helper.correctDouble((String) rs1.getString("permovprop"));
//					strperimmovprop = Helper.correctDouble((String) rs1.getString("perimmovprop"));
//					strtotlia = Helper.correctDouble((String) rs1.getString("totlia"));
//					vecCoapp.add(strbankbal);
//					vecCoapp.add(strshare);
//					vecCoapp.add(strinsurance);
//					vecCoapp.add(strpermovprop);
//					vecCoapp.add(strperimmovprop);
//					vecCoapp.add(strtotlia);
//					TotalMoveable = nf.format(Double.parseDouble(Helper.correctDouble((String) strbankbal))
//							+ Double.parseDouble(Helper.correctDouble((String) strinsurance))
//							+ Double.parseDouble(Helper.correctDouble((String) strpermovprop))
//							+ Double.parseDouble(Helper.correctDouble((String) strshare)));
//					TotalAssets = nf.format(Double.parseDouble(Helper.correctDouble((String) TotalMoveable))
//							+ Double.parseDouble(Helper.correctDouble((String) strperimmovprop)));
//					NetAssets = nf.format(Double.parseDouble(Helper.correctDouble((String) TotalAssets))
//							- Double.parseDouble(Helper.correctDouble((String) strtotlia)));
//					vecCoapp.add(TotalMoveable);
//					vecCoapp.add(TotalAssets);
//					vecCoapp.add(NetAssets);
//				}
//				vecReport.add(vecCoapp);
//			}
//			hshValues.put("vecReport", vecReport);
//			ArrayList arrVal5 = new ArrayList();
//			ArrayList arrRec5 = new ArrayList();
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("appraisalprint6^" + strOldAppno);
//
//			while (rs.next())
//			{
//				arrRec5 = new ArrayList();
//				arrRec5.add(correctNull(rs.getString(1)));
//				arrRec5.add(correctNull(rs.getString(2)));
//				arrRec5.add(correctNull(rs.getString(3)));
//				arrRec5.add(correctNull(rs.getString(4)));
//				arrRec5.add(correctNull(rs.getString(5)));
//				arrRec5.add(correctNull(rs.getString(6)));
//				arrRec5.add(correctNull(rs.getString(7)));
//				arrVal5.add(arrRec5);
//			}
//			hshValues.put("propertyimmov", arrVal5);
//			rs = null;
//			ArrayList arrVal1 = new ArrayList();
//			ArrayList arrRec1 = new ArrayList();
//			rs = DBUtils.executeLAPSQuery("appraisalprint2^" + strOldAppno);
//
//			while (rs.next())
//			{
//				arrRec1 = new ArrayList();
//				arrRec1.add(correctNull(rs.getString(1)));
//				arrRec1.add(correctNull(rs.getString(2)));
//				arrRec1.add(correctNull(rs.getString(3)));
//				arrRec1.add(correctNull(rs.getString(4)));
//				arrRec1.add(correctNull(rs.getString(5)));
//				arrVal1.add(arrRec1);
//			}
//			hshValues.put("bankdetails", arrVal1);
//			rs = null;
//			ArrayList arrVal2 = new ArrayList();
//			ArrayList arrRec2 = new ArrayList();
//			rs = DBUtils.executeLAPSQuery("appraisalprint3^" + strOldAppno);
//
//			while (rs.next())
//			{
//				arrRec2 = new ArrayList();
//				arrRec2.add(correctNull(rs.getString(1)));
//				arrRec2.add(correctNull(rs.getString(2)));
//				arrRec2.add(correctNull(rs.getString(3)));
//				arrRec2.add(correctNull(rs.getString(4)));
//				arrVal2.add(arrRec2);
//			}
//			hshValues.put("investments", arrVal2);
//			rs = null;
//			ArrayList arrVal3 = new ArrayList();
//			ArrayList arrRec3 = new ArrayList();
//			rs = DBUtils.executeLAPSQuery("appraisalprint4^" + strOldAppno);
//
//			while (rs.next())
//			{
//				arrRec3 = new ArrayList();
//				arrRec3.add(correctNull(rs.getString(1)));
//				arrRec3.add(correctNull(rs.getString(2)));
//				arrRec3.add(correctNull(rs.getString(3)));
//				arrRec3.add(correctNull(rs.getString(4)));
//				arrVal3.add(arrRec3);
//			}
//			hshValues.put("insurance", arrVal3);
//
//			rs = null;
//			ArrayList arrVal4 = new ArrayList();
//			ArrayList arrRec4 = new ArrayList();
//			rs = DBUtils.executeLAPSQuery("appraisalprint5^" + strOldAppno);
//
//			while (rs.next())
//			{
//				arrRec4 = new ArrayList();
//				arrRec4.add(correctNull(rs.getString(1)));
//				arrRec4.add(correctNull(rs.getString(2)));
//				arrRec4.add(correctNull(rs.getString(3)));
//				arrRec4.add(correctNull(rs.getString(4)));
//				arrVal4.add(arrRec4);
//			}
//			hshValues.put("propertymov", arrVal4);
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("selpropertydetails^" + strOldAppno);
//			if (rs.next())
//			{
//				hshValues.put("prop_add1", (String) correctNull(rs.getString("prop_add1")));
//				hshValues.put("prop_add2", (String) correctNull(rs.getString("prop_add2")));
//				hshValues.put("prop_city", (String) correctNull(rs.getString("prop_city")));
//				hshValues.put("prop_state", (String) correctNull(rs.getString("prop_state")));
//				hshValues.put("prop_pin", (String) correctNull(rs.getString("prop_pin")));
//			}
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("appraisalprint^" + strOldAppno);
//			if (rs.next())
//			{
//				hshValues.put("prop_description", (String) correctNull(rs.getString("prop_description")));
//				hshValues.put("prop_phone", (String) correctNull(rs.getString("prop_phone")));
//				hshValues.put("prop_city", (String) correctNull(rs.getString("prop_city")));
//			}
//			rs = null;
//			rs = DBUtils.executeLAPSQuery("appraisalprint1^" + strOldAppno);
//			if (rs.next())
//			{
//				hshValues.put("auto_model", (String) correctNull(rs.getString("auto_model")));
//				hshValues.put("auto_make", (String) correctNull(rs.getString("auto_make")));
//				hshValues.put("auto_regno", (String) correctNull(rs.getString("auto_regno")));
//			}
//		}
//		catch (Exception e)
//		{
//			Logger.log("error occured" + e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//				if (rs1 != null)
//				{
//					rs1.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				Logger.log("error occured" + e1.toString());
//			}
//		}
//		return hshValues;
//	}

//	public HashMap getStepupData(HashMap hshRequestValues) 
//	{
//		HashMap hshValues = new HashMap();
//		ArrayList vecVal = new ArrayList();
//		ArrayList vecRec = new ArrayList();
//		ResultSet rs = null;
//		String val = "";
//		try
//		{
//			String strAppno = "";
//			strAppno = Helper.correctNull((String) hshRequestValues.get("appno"));
//			String slabs = "";
//			String state = "";
//			String[] strslno = null;
//			String loan_steptype = "", loan_inttype = "";
//			slabs = Helper.correctNull((String) hshRequestValues.get("txt_slab"));
//			strslno = (String[]) hshRequestValues.get("txt_serialno");
//			rs = DBUtils.executeLAPSQuery("sel_loandetailsstepup^" + strAppno);
//
//			if (rs.next())
//			{
//				hshValues.put("loan_modintrate", Helper.correctNull((String) rs.getString("loan_modintrate")));
//				hshValues.put("loan_recmdamt", Helper.correctNull((String) rs.getString("loan_recmdamt")));
//				hshValues.put("loan_reqterms", Helper.correctNull((String) rs.getString("loan_reqterms")));
//				hshValues.put("loan_emi", Helper.correctNull((String) rs.getString("loan_emi")));
//				loan_steptype = Helper.correctNull((String) rs.getString("loan_steptype"));
//				loan_inttype = Helper.correctNull((String) rs.getString("loan_inttype"));
//				if (loan_steptype.equalsIgnoreCase("2"))
//				{
//					loan_steptype = loan_inttype + " - Step Up";
//				}
//				else if (loan_steptype.equalsIgnoreCase("3"))
//				{
//					loan_steptype = loan_inttype + " - Step Down";
//				}
//				hshValues.put("loan_steptype", loan_steptype);
//				hshValues
//						.put("loan_noofinstallment", Helper.correctNull((String) rs.getString("loan_noofinstallment")));
//			}
//			if (rs != null)
//			{
//				rs.close();
//			}
//			if (strAppno != "")
//			{
//				rs = DBUtils.executeLAPSQuery("sel_per_step_updown1^" + strAppno);
//				while (rs.next())
//				{
//					state = "True";
//					vecRec = new ArrayList();
//					vecRec.add(Helper.correctNull((String) rs.getString(1)));
//					val = Helper.correctNull((String) rs.getString(2));
//					vecRec.add(Helper.correctNull((String) rs.getString(2)));
//					vecRec.add(Helper.correctNull((String) rs.getString(3)));
//					vecRec.add(Helper.correctNull((String) rs.getString(4)));
//					vecRec.add(Helper.correctNull((String) rs.getString(5)));
//					vecRec.add(Helper.correctNull((String) rs.getString(6)));
//					vecRec.add(Helper.correctNull((String) rs.getString(7)));
//					vecVal.add(vecRec);
//				}
//				hshValues.put("vecVal", vecVal);
//				hshValues.put("slabvalue", val);
//				hshValues.put("state", state);
//			}
//		}
//		catch (Exception e)
//		{
//			Logger.log("in bean" + e);
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception cf)
//			{
//				throw new EJBException("Error closing the connection " + cf.getMessage());
//			}
//		}
//		return hshValues;
//	}

//	public void updateStepupData(HashMap hshRequestValues) 
//	{
//		HashMap hshqueryval = new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs = null;
//		int intValue = 0;
//		try
//		{
//			String strAppno = "";
//			strAppno = Helper.correctNull((String) hshRequestValues.get("appno"));
//			String slabs = "";
//			String[] slabperiod = null;
//			String[] percenloanamount = null;
//			String[] loanamount = null;
//			String[] txt_emi = null;
//			String[] strslno = null;
//			int intUpdatesize = 0;
//			slabs = Helper.correctNull((String) hshRequestValues.get("txt_slab"));
//			slabperiod = (String[]) hshRequestValues.get("txt_slabperiod");
//			percenloanamount = (String[]) hshRequestValues.get("txt_percenloanamount");
//			loanamount = (String[]) hshRequestValues.get("txt_loanamount");
//			txt_emi = (String[]) hshRequestValues.get("txt_emi");
//			strslno = (String[]) hshRequestValues.get("txt_serialno");
//			if (!strAppno.equalsIgnoreCase(""))
//			{
//				arr = new ArrayList();
//				hshquery.put("strQueryId", "del_step_up_down");
//				arr.add(strAppno);
//				hshquery.put("arrValues", arr);
//				hshqueryval.put("size", "1");
//				hshqueryval.put("1", hshquery);
//				EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");
//			}
//			if (!strAppno.equalsIgnoreCase("") && !slabs.equalsIgnoreCase(""))
//			{
//				intValue = 0;
//
//				for (int k = 0; k < slabperiod.length; k++)
//				{
//					arr = new ArrayList();
//					intUpdatesize = intUpdatesize + 1;
//					intValue = intValue + 1;
//					hshquery.put("strQueryId", "ins_per_step_updown");
//					arr.add(strAppno);
//					arr.add(hshRequestValues.get("txt_slab"));
//					arr.add(Integer.toString(intValue));
//					if (slabperiod[k].equalsIgnoreCase(""))
//					{
//						slabperiod[k] = "0";
//					}
//					arr.add(slabperiod[k]);
//					if (percenloanamount[k].equalsIgnoreCase(""))
//					{
//						percenloanamount[k] = "0";
//					}
//					arr.add(percenloanamount[k]);
//					if (loanamount[k].equalsIgnoreCase(""))
//					{
//						loanamount[k] = "0";
//					}
//					arr.add(loanamount[k]);
//					if (txt_emi[k].equalsIgnoreCase(""))
//					{
//						txt_emi[k] = "0";
//					}
//					arr.add(txt_emi[k]);
//					hshquery.put("arrValues", arr);
//					hshqueryval.put("size", "1");
//					hshqueryval.put("1", hshquery);
//					EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");
//				}
//			}
//		}
//		catch (Exception e)
//		{
//			Logger.log("in bean" + e);
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception cf)
//			{
//				throw new EJBException("Error closing the connection " + cf.getMessage());
//			}
//		}
//	}

//	public HashMap calculateStepUpAmortization(HashMap hshValues) 
//	{
//
//		ResultSet rs = null;
//		HashMap hshResult = new HashMap();
//		ArrayList arryRow = new ArrayList();
//		ArrayList arryCol = new ArrayList();
//		ArrayList arryCol1 = new ArrayList();
//		ArrayList arryRow1 = new ArrayList();
//		int i = 1;
//		double dblInterest = 0.00;
//		double dblPrincipal = 0.00;
//		double dblloans = 0.00;
//		double dblEMI = 0.00;
//		double dblRate = 0.00;
//		double dblActualAmtDue = 0.00;
//		double dblTotalInterest = 0.00;
//		double dblTotalPrincipal = 0.00;
//		double dblModIntRate = 0.00;
//		int intTerms = 0;
//		double dblRecAmount = 0.00;
//		double TotalAmount = 0.00;
//		String strrepaymenttype = correctNull((String) hshValues.get("hidrepaymenttype"));
//		DecimalFormat dc = new DecimalFormat();
//		dc.setGroupingUsed(false);
//		dc.setMaximumFractionDigits(2);
//		dc.setMinimumFractionDigits(2);
//
//		try
//		{
//			if (strrepaymenttype.equals("amort"))
//			{
//				dblModIntRate = Double.parseDouble(Helper.correctDouble((String) hshValues.get("modIntRate")));
//				intTerms = Integer.parseInt(correctNull((String) hshValues.get("terms")));
//				dblRecAmount = Double.parseDouble(Helper.correctDouble((String) hshValues.get("recmdAmt")));
//				String txtmonPayamor = correctNull((String) hshValues.get("txtmonPay"));
//				String loan_emi2 = correctNull((String) hshValues.get("loan_emi2"));
//				String loan_emi3 = correctNull((String) hshValues.get("loan_emi3"));
//				String loan_emi4 = correctNull((String) hshValues.get("loan_emi4"));
//				String loan_emi5 = correctNull((String) hshValues.get("loan_emi5"));
//				String slabperiod1 = correctNull((String) hshValues.get("slabperiod1"));
//				String slabperiod2 = correctNull((String) hshValues.get("slabperiod2"));
//				String slabperiod3 = correctNull((String) hshValues.get("slabperiod3"));
//				String slabperiod4 = correctNull((String) hshValues.get("slabperiod4"));
//				String slabperiod5 = correctNull((String) hshValues.get("slabperiod5"));
//				String slabs = correctNull((String) hshValues.get("slab"));
//				hshResult.put("txtmonPayamor", txtmonPayamor);
//				hshResult.put("dblrequested_amount", Helper.formatDoubleValue(dblRecAmount));
//				hshResult.put("terms", Integer.toString(intTerms));
//				arryCol = new ArrayList();
//				arryCol1 = new ArrayList();
//				arryCol.add(new Integer(i));
//				arryCol1.add(new Integer(i));
//				dblRate = dblModIntRate / (12 * 100);
//				dblEMI = Math.ceil(Double.parseDouble(txtmonPayamor));
//				dblPrincipal = dblEMI - (dblRecAmount * dblRate);
//				dblPrincipal = Math.ceil(dblPrincipal);
//				dblInterest = dblRecAmount * dblRate;
//				dblInterest = Math.ceil(dblInterest);
//				dblPrincipal = (dblEMI - dblInterest);
//				dblPrincipal = Math.ceil(dblPrincipal);
//				dblActualAmtDue = dblRecAmount - dblEMI;
//				dblloans = dblActualAmtDue + dblInterest;
//				dblActualAmtDue = Math.round(dblActualAmtDue);
//				arryCol1.add(new Double(dc.format(dblEMI)));
//				arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//				arryCol.add(new Double(dc.format(dblInterest)));
//				arryCol.add(new Double(dc.format(dblPrincipal)));
//				arryCol.add(new Double(dc.format(dblloans)));
//				TotalAmount = dblloans;
//				arryRow.add(arryCol);
//				arryRow1.add(arryCol1);
//				i = i + 1;
//				if (!slabs.equalsIgnoreCase(""))
//				{
//					int SlabPeriod1 = 0;
//					int SlabPeriod = 0;
//					SlabPeriod = Integer.parseInt(slabperiod1);
//					if (SlabPeriod != 0 && !txtmonPayamor.equalsIgnoreCase(""))
//					{
//						dblRate = 0.00;
//						dblRate = dblModIntRate / (12 * 100);
//						SlabPeriod = Integer.parseInt(slabperiod1);
//						while (i <= SlabPeriod)
//						{
//							arryCol = new ArrayList();
//							arryCol1 = new ArrayList();
//							arryCol.add(new Integer(i));
//							arryCol1.add(new Integer(i));
//							i = i + 1;
//							dblActualAmtDue = dblloans - dblEMI;
//							dblInterest = dblloans * dblRate;
//							dblInterest = Math.ceil(dblInterest);
//							dblTotalInterest = dblTotalInterest + dblInterest;
//							dblPrincipal = (dblEMI - dblInterest);
//							dblPrincipal = Math.ceil(dblPrincipal);
//							dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
//							dblloans = dblActualAmtDue + dblInterest;
//							dblloans = Math.round(dblloans);
//							arryCol1.add(new Double(dc.format(dblEMI)));
//							arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//							arryCol.add(new Double(dc.format(dblInterest)));
//							arryCol.add(new Double(dc.format(dblPrincipal)));
//							arryCol.add(new Double(dc.format(dblloans)));
//							arryRow.add(arryCol);
//							arryRow1.add(arryCol1);
//							TotalAmount = dblloans;
//						}
//					}
//					if (SlabPeriod != 0 && !slabperiod1.equalsIgnoreCase("") && !loan_emi2.equalsIgnoreCase(""))
//					{
//						i = SlabPeriod + 1;
//						dblEMI = Double.parseDouble(loan_emi2);
//						SlabPeriod1 = Integer.parseInt(slabperiod1) + Integer.parseInt(slabperiod2);
//						while (i <= SlabPeriod1)
//						{
//							arryCol = new ArrayList();
//							arryCol1 = new ArrayList();
//							arryCol.add(new Integer(i));
//							arryCol1.add(new Integer(i));
//							i = i + 1;
//							dblActualAmtDue = dblloans - dblEMI;
//							dblInterest = dblloans * dblRate;
//							dblInterest = Math.ceil(dblInterest);
//							dblTotalInterest = dblTotalInterest + dblInterest;
//							dblPrincipal = (dblEMI - dblInterest);
//							dblPrincipal = Math.ceil(dblPrincipal);
//							dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
//							dblloans = dblActualAmtDue + dblInterest;
//							dblloans = Math.round(dblloans);
//							arryCol1.add(new Double(dc.format(dblEMI)));
//							arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//							arryCol.add(new Double(dc.format(dblInterest)));
//							arryCol.add(new Double(dc.format(dblPrincipal)));
//							arryCol.add(new Double(dc.format(dblloans)));
//							arryRow.add(arryCol);
//							arryRow1.add(arryCol1);
//							SlabPeriod = SlabPeriod1;
//							TotalAmount = dblloans;
//						}
//					}
//					if (SlabPeriod != 0 && !slabperiod2.equalsIgnoreCase("") && !loan_emi3.equalsIgnoreCase(""))
//					{
//						i = SlabPeriod + 1;
//						int SlabPeriod2 = 0;
//						dblEMI = Double.parseDouble(loan_emi3);
//						SlabPeriod2 = Integer.parseInt(slabperiod1) + Integer.parseInt(slabperiod2)
//								+ Integer.parseInt(slabperiod3);
//						while (i <= SlabPeriod2)
//						{
//							arryCol = new ArrayList();
//							arryCol1 = new ArrayList();
//							arryCol.add(new Integer(i));
//							arryCol1.add(new Integer(i));
//							i = i + 1;
//							dblActualAmtDue = dblloans - dblEMI;
//							dblInterest = dblloans * dblRate;
//							dblInterest = Math.ceil(dblInterest);
//							dblTotalInterest = dblTotalInterest + dblInterest;
//							dblPrincipal = (dblEMI - dblInterest);
//							dblPrincipal = Math.ceil(dblPrincipal);
//							dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
//							dblloans = dblActualAmtDue + dblInterest;
//							dblloans = Math.round(dblloans);
//							arryCol1.add(new Double(dc.format(dblEMI)));
//							arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//							arryCol.add(new Double(dc.format(dblInterest)));
//							arryCol.add(new Double(dc.format(dblPrincipal)));
//							arryCol.add(new Double(dc.format(dblloans)));
//
//							arryRow.add(arryCol);
//							arryRow1.add(arryCol1);
//							SlabPeriod = SlabPeriod2;
//							TotalAmount = dblloans;
//						}
//					}
//					if (SlabPeriod != 0 && !slabperiod3.equalsIgnoreCase("") && !loan_emi4.equalsIgnoreCase(""))
//					{
//						i = SlabPeriod + 1;
//						int SlabPeriod3 = 0;
//						dblEMI = Double.parseDouble(loan_emi4);
//						SlabPeriod3 = Integer.parseInt(slabperiod1) + Integer.parseInt(slabperiod2)
//								+ Integer.parseInt(slabperiod3) + Integer.parseInt(slabperiod4);
//						while (i <= SlabPeriod3)
//						{
//							arryCol = new ArrayList();
//							arryCol1 = new ArrayList();
//							arryCol.add(new Integer(i));
//							arryCol1.add(new Integer(i));
//							i = i + 1;
//							dblActualAmtDue = dblloans - dblEMI;
//							dblInterest = dblloans * dblRate;
//							dblInterest = Math.ceil(dblInterest);
//							dblTotalInterest = dblTotalInterest + dblInterest;
//							dblPrincipal = (dblEMI - dblInterest);
//							dblPrincipal = Math.ceil(dblPrincipal);
//							dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
//							dblloans = dblActualAmtDue + dblInterest;
//							dblloans = Math.round(dblloans);
//							arryCol1.add(new Double(dc.format(dblEMI)));
//							arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//							arryCol.add(new Double(dc.format(dblInterest)));
//							arryCol.add(new Double(dc.format(dblPrincipal)));
//							arryCol.add(new Double(dc.format(dblloans)));
//							arryRow.add(arryCol);
//							arryRow1.add(arryCol1);
//							TotalAmount = dblloans;
//							SlabPeriod = SlabPeriod3;
//						}
//					}
//					if (SlabPeriod != 0 && !slabperiod4.equalsIgnoreCase("") && !loan_emi5.equalsIgnoreCase(""))
//					{
//						i = SlabPeriod + 1;
//						int SlabPeriod4 = 0;
//						dblEMI = Double.parseDouble(loan_emi5);
//						SlabPeriod4 = Integer.parseInt(slabperiod1) + Integer.parseInt(slabperiod2)
//								+ Integer.parseInt(slabperiod3) + Integer.parseInt(slabperiod4)
//								+ Integer.parseInt(slabperiod5);
//						while (i <= SlabPeriod4)
//						{
//							arryCol = new ArrayList();
//							arryCol1 = new ArrayList();
//							arryCol.add(new Integer(i));
//							arryCol1.add(new Integer(i));
//							i = i + 1;
//							dblActualAmtDue = dblloans - dblEMI;
//							dblInterest = dblloans * dblRate;
//							dblInterest = Math.ceil(dblInterest);
//							dblTotalInterest = dblTotalInterest + dblInterest;
//							dblPrincipal = (dblEMI - dblInterest);
//							dblPrincipal = Math.ceil(dblPrincipal);
//							dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
//							dblloans = dblActualAmtDue + dblInterest;
//							dblloans = Math.round(dblloans);
//							arryCol1.add(new Double(dc.format(dblEMI)));
//							arryCol1.add(new Double(dc.format(dblActualAmtDue)));
//							arryCol.add(new Double(dc.format(dblInterest)));
//							arryCol.add(new Double(dc.format(dblPrincipal)));
//							arryCol.add(new Double(dc.format(dblloans)));
//
//							arryRow.add(arryCol);
//							arryRow1.add(arryCol1);
//							TotalAmount = dblloans;
//						}
//					}
//				}
//				hshResult.put("arryRow", arryRow);
//				hshResult.put("arryRow1", arryRow1);
//			}
//		}
//		catch (Exception e)
//		{
//			throw new EJBException("Error in closing calcAmortization" + e.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection " + e.getMessage());
//			}
//		}
//		return hshResult;
//	}

//	public void updateBranchQueriesData(HashMap hshRequestValues) 
//	{
//		HashMap hshqueryval = new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//
//		ResultSet rs = null;
//		String strOrgCode = "", strAppno = "", strBranchRefNo = "", strComments = "";
//		try
//		{
//
//			String strAction = Helper.correctNull((String) hshRequestValues.get("hidAction"));
//			strOrgCode = correctNull((String) hshRequestValues.get("strOrgCode"));
//			String strUserId = Helper.correctNull((String) hshRequestValues.get("hiduserid"));
//			strAppno = Helper.correctNull((String) hshRequestValues.get("hidappno"));
//			String comappid = Helper.correctNull((String) hshRequestValues.get("hidappid"));
//			strBranchRefNo = Helper.correctNull((String) hshRequestValues.get("hidbranchrefno"));
//			String strsno = correctNull((String) hshRequestValues.get("hidsno"));
//			strComments = Helper.correctNull((String) hshRequestValues.get("comments"));
//
//			if (!strBranchRefNo.equalsIgnoreCase("") && strAction.equalsIgnoreCase("Apply"))
//			{
//				hshquery = new HashMap();
//				arr = new ArrayList();
//				arr.add(strOrgCode);
//				arr.add(strAppno);
//				arr.add(strBranchRefNo);
//				arr.add(strComments);
//				arr.add(strUserId);
//				arr.add(Helper.getCurrentDateTime());
//				hshquery.put("arrValues", arr);
//				hshquery.put("strQueryId", "ins_branch_ref_comments");
//				hshqueryval.put("size", "1");
//				hshqueryval.put("1", hshquery);
//				EJBInvoker.executeStateLess("dataaccess", hshqueryval, "updateData");
//			}
//		}
//		catch (Exception e)
//		{
//			Logger.log("in bean" + e);
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//
//			}
//			catch (Exception cf)
//			{
//				throw new EJBException("Error closing the connection " + cf.getMessage());
//			}
//		}
//	}

//	public HashMap getBranchQueriesList(HashMap hshValues) 
//	{
//
//		String strQuery = "";
//		ResultSet rs = null;
//		HashMap hshRecord = new HashMap();
//		ArrayList vecCol = new ArrayList();
//		ArrayList vecRow = new ArrayList();
//		String strOrgCode = "", strAppno = "", strBranchRefNo = "";
//		strOrgCode = correctNull((String) hshValues.get("strOrgCode"));
//		strAppno = Helper.correctNull((String) hshValues.get("strAppno"));
//		if (strAppno.equalsIgnoreCase(""))
//		{
//			strAppno = Helper.correctNull((String) hshValues.get("hidappno"));
//		}
//		String comappid = Helper.correctNull((String) hshValues.get("hidappid"));
//		strBranchRefNo = Helper.correctNull((String) hshValues.get("hidbranchrefno"));
//		if (strBranchRefNo.equalsIgnoreCase(""))
//		{
//			strBranchRefNo = Helper.correctNull((String) hshValues.get("BranchRefno"));
//		}
//		try
//		{
//
//			strQuery = SQLParser.getSqlQuery("sel_branch_ref_comments1^" + strBranchRefNo + "^" + strOrgCode);
//			rs = DBUtils.executeQuery(strQuery);
//
//			while (rs.next())
//			{
//				vecCol = new ArrayList();
//				vecCol.add(correctNull(rs.getString("branch_ref_comments")));
//				vecCol.add(correctNull(rs.getString("branch_ref_userid")));
//				vecCol.add(correctNull(rs.getString("branch_ref_date")));
//				vecRow.add(vecCol);
//			}
//			hshRecord.put("vecRow", vecRow);
//			hshRecord.put("appid", comappid);
//			hshRecord.put("strAppno", strAppno);
//			hshRecord.put("BranchRefno", strBranchRefNo);
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in getBranchQueriesList " + ce.toString());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//
//			}
//			catch (Exception cf)
//			{
//				throw new EJBException("Error closing the connection " + cf.getMessage());
//			}
//		}
//		return hshRecord;
//	}

	public HashMap getCoAppGuarantorCheck(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrAppno1 = new ArrayList();
		ArrayList arrAppno2 = new ArrayList();
		ArrayList arrAppno = new ArrayList();
		try
		{
			String strid = Helper.correctNull((String) hshRequestValues.get("hidid"));
			if (!strid.equalsIgnoreCase(""))
			{
				rs = DBUtils.executeLAPSQuery("getcoappguarantorcheck^" + strid);
				while (rs.next())
				{
					if(rs.getString("demo_type").equals("a"))
						arrAppno.add(rs.getString("demo_appno"));
					else if(rs.getString("demo_type").equals("c"))
						arrAppno1.add(rs.getString("demo_appno"));
					else if(rs.getString("demo_type").equals("g"))
						arrAppno2.add(rs.getString("demo_appno"));
				}
				hshRecord.put("arrAppno1", arrAppno1);
				hshRecord.put("arrAppno2", arrAppno2);
				hshRecord.put("arrAppno", arrAppno);
				/*rs = DBUtils.executeLAPSQuery("getcoappguarantorcheck2^" + strid);

				while (rs.next())
				{
					arrAppno2.add(rs.getString(1));
				}
				hshRecord.put("arrAppno2", arrAppno2);*/
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

//	public HashMap getReviewDate(HashMap hsh) 
//	{
//		String strQuery = "";
//		ResultSet rs = null;
//		HashMap hshValues = new HashMap();
//		String sancdate = correctNull((String) hsh.get("sancdate"));
//		String strAction = Helper.correctNull((String) hsh.get("Action"));
//		String lastrepaydate = Helper.correctNull((String) hsh.get("lastrepaydate"));
//		String strAppno = Helper.correctNull((String) hsh.get("appno"));
//		String strterms = "";
//		try
//		{
//			if (strAction.equalsIgnoreCase("reviewdate"))
//			{
//				rs = DBUtils.executeLAPSQuery("sel_review_date^" + sancdate);
//				if (rs.next())
//				{
//					hshValues.put("review_Date", correctNull(rs.getString("review_Date")));
//				}
//			}
//			else if (strAction.equalsIgnoreCase("lastrepaymentdate"))
//			{
//				rs = DBUtils.executeLAPSQuery("sel_reqterms^" + strAppno);
//				if (rs.next())
//				{
//					strterms = Helper.correctNull((String) rs.getString("loan_reqterms"));
//				}
//				if (rs != null)
//				{
//					rs.close();
//				}
//				strQuery = SQLParser.getSqlQuery("sel_lastrepayment_date^" + strterms + "^" + lastrepaydate);
//				rs = DBUtils.executeQuery(strQuery);
//				if (rs.next())
//				{
//					hshValues.put("last_repayment_date", correctNull(rs.getString("last_repayment_date")));
//				}
//			}
//		}
//		catch (Exception ce)
//		{
//			throw new EJBException("Error in closing getReviewData" + ce.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if (rs != null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e)
//			{
//				throw new EJBException("Error in closing Connection " + e.getMessage());
//			}
//		}
//		return hshValues;
//	}

	public HashMap getCoAppGuarantorType(HashMap hshRequestValues) 
	{

		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strAppno = (String) hshRequestValues.get("appno");
		String strAppType = (String) hshRequestValues.get("applnt");
		String strQuery = null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = null;

		try
		{
			strQuery = SQLParser.getSqlQuery("getcoappguarantortype^" + strAppno + "^" + strAppType);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString(1)));
				arrCol.add(correctNull(rs.getString(2)));
				arrCol.add(correctNull(rs.getString(3)));
				arrCol.add(correctNull(rs.getString(4)));
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
	
	public HashMap checkEligibility(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strAppno = correctNull((String) hshRequestValues.get("appno"));
		
		String appid="";
		
		double dblRequestedAmount =0.0;
		String strSanctionAmount = "";
		double dblProjectCost = 0.0;
		double dblInterestRate =0.0;
		int intTerms = 0;
		
		String strStaffFlag = "";
		String strMetroFlag="";
		String strInterestcharged = "";
		String strInterestservised = "";
		String strProductType = "";
		String strPeriodicity="";
		
		double dblgrossincome=0.0;
		double dblothincome=0.0;
		double dblnetincome=0.0;
		
		double dblSalaryEligibility = 0.0;
		double dblMarginEligibility = 0.0;
		double dblMinimumRange = 0.0;
		double dblEmployedLimit = 0.0;
		double dblSelfEmployedLimit = 0.0;
		double dblnetbothempincome=0.0;
		double dblnetbothselfincome=0.0;
		double dblmetrolimit=0.0;
		double dblnonmetrolomit=0.0;
		double dblbothGrossIncome=0.0;
		double dblbothNetIncome=0.0;
		int intEmployment = 0;
		double dbleligiblemonths=0.0;
		double dblserviceeligibility=0.0;
		double dblRepaycapacityeligibility=0.0;
		double dblEMI = 0.0;
		double dblInterestEMI = 0.0;
		int intInterestRatio = 0;
		int intPrincipalRatio = 0;
		int intempretireage=0;
		int intselfempretireage=0;
		int intMoratorium=0;
		int intExservice=0;
		double dblService=0;
		double dblRepaycapacity=0.00;
		double dblGrossIncome=0.0;
		double dblNetIncome=0.0;
		double dblOthrIncome=0.0;
		double dblOthrDeduc=0.0;
		double dblDeduc=0.0;
		double dbltemp=0.0;
		double dblRate=0.0;
		double dblmarginrate=0.0;
		//double yrsservice=0.0;
		
		//for deviation 
		double dbldeviatedamount=0.0;
		double dbldeviatedint=0.0;
		double dbldeviatedtenor=0.0;
		double dbldeviatedmargin=0.0;
		int intdeviatedage=0;
		double dbldeviatedrepay=0.0;
		double dbldeviatedprocfees=0.0;
		double dbldeviateddocfee=0.0;
		
		
		String strQuery = null;
		ArrayList arrValues = new ArrayList();
		ArrayList arrEligicriteria=new ArrayList();
		
		ArrayList arrFrmTenor=new ArrayList();
		ArrayList arrToTenor=new ArrayList();
		ArrayList arrInterest=new ArrayList();
		ArrayList arrRemainTenor=new ArrayList();
		String apptype="";
		String strPrdcode="";
		String strincomeflag="";
		String strIntType="";
		String strGreater="<=";
		String strLesser=">=";
		String strappTitle="";
		
		String copsociety="";
		String strIsdeviated="";
		double copsocietyvalue=0.00;
			
		NumberFormat nf = NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		double Eligiamt=0.0;
		int cnt=1;
		int intapp_minage=0;
		double dbminagemonth=0.0;
		String strIntcalcmode = "";
		String strLoanAmtDevStatus="";
		String Staffproduct="";
		try
		{
			strSanctionAmount = Helper.correctNull((String)hshRequestValues.get("txt_sanction_amount"));
			double dblSanctionAmount = 0.0;
			dblSanctionAmount = (strSanctionAmount.trim().equals(""))?0.0:Double.parseDouble(strSanctionAmount);
			//Logger.log("New Sanction Amount : "+dblSanctionAmount);
			
			//Getting Existing Application/Loan Details
			if(rs !=null)
			{
				rs.close();
			}
			String strProdPurpose="",strVehicleType="";
			strQuery = SQLParser.getSqlQuery("selprodpurpose^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
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
				strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + strAppno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + strAppno);
			}
			
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				appid = Helper.correctNull((String)rs.getString("appid"));
				dblRequestedAmount = rs.getDouble("amtreqd");
				dblProjectCost = rs.getDouble("cloanprd");
				dblInterestRate = rs.getDouble("mintrate");
				dblmarginrate= rs.getDouble("margin_perct");
				intTerms = rs.getInt("lreqterms");  
				//dblMarginEligibility = rs.getDouble("raamount");
				strStaffFlag = correctNull((rs.getString("indinfo_is_staff")));
				dblMinimumRange = rs.getDouble("rfrom");
				strProductType = correctNull(rs.getString("prd_type")).toUpperCase();
				intEmployment = rs.getInt("perapp_employment");
				dblEmployedLimit = rs.getDouble("income_limit_employed");
				dblSelfEmployedLimit = rs.getDouble("income_limit_self_employed");
				intempretireage=rs.getInt("prd_empretireage");
				intselfempretireage=rs.getInt("prd_selfretireage");
				dblmetrolimit=Double.parseDouble(Helper.correctDouble(rs.getString("maxmetro")));
				dblnonmetrolomit=Double.parseDouble(Helper.correctDouble(rs.getString("maxnon_metro")));
				intExservice=rs.getInt("indinfo_service_years");
				strPrdcode=correctNull((String)rs.getString("prdcode"));
				strInterestcharged=correctNull((rs.getString("loan_interestcharged")));
				strIntType=correctNull((rs.getString("loan_inttype")));
				dblnetbothempincome=Double.parseDouble(Helper.correctDouble(rs.getString("prd_netemp")));
				dblnetbothselfincome=Double.parseDouble(Helper.correctDouble(rs.getString("prd_netselfemp")));
				intPrincipalRatio=rs.getInt("prd_principal");
				intInterestRatio=rs.getInt("prd_interest");
				strappTitle=correctNull(rs.getString("perapp_title"));
				intapp_minage = rs.getInt("prd_appminage");
				copsociety=correctNull(rs.getString("loan_copsociety"));
				strIntcalcmode= Helper.correctNull((String) rs.getString("loan_intcalcmode"));
				strIsdeviated=correctNull((String)rs.getString("app_isdeviated"));
				strincomeflag=correctNull((rs.getString("incomeflag")));
				dblRepaycapacity=rs.getDouble("loan_repaycapacity");
				dblEMI=Double.parseDouble(Helper.correctDouble(rs.getString("loan_emi")));
				Staffproduct=Helper.correctNull((String)rs.getString("prd_staffprd"));
			}
			
			
			if(strIsdeviated.equalsIgnoreCase("Y"))
			{
				strQuery = SQLParser.getSqlQuery("Sel_app_deviation^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);

				while (rs.next())
				{
					String strdeviationtype=correctNull((rs.getString("deviation_type")));
					String strdeviationstatus=correctNull((rs.getString("deviation_apprej")));
					
					if(strdeviationtype.equalsIgnoreCase("LA") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedamount=rs.getDouble("deviation_newvalue");
						strLoanAmtDevStatus=Helper.correctNull((String)rs.getString("deviation_req"));
					}
					
					if(strdeviationtype.equalsIgnoreCase("IR") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedint=rs.getDouble("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("TR") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedtenor=rs.getDouble("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("MN") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedmargin=rs.getDouble("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("RA") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						intdeviatedage=rs.getInt("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("RC") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedrepay=rs.getDouble("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("PF") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviatedprocfees=rs.getDouble("deviation_newvalue");
					}
					
					if(strdeviationtype.equalsIgnoreCase("DF") && strdeviationstatus.equalsIgnoreCase("A"))
					{
						dbldeviateddocfee=rs.getDouble("deviation_newvalue");
					}
				}
			}
			
			if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedmargin>0)
			{
				dblmarginrate=dbldeviatedmargin;
			}
			dblMarginEligibility=dblProjectCost-(dblProjectCost*dblmarginrate/100);
			
			strQuery = SQLParser.getSqlQuery("repaymoratorium^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);

			if (rs.next())
			{
				strInterestservised=correctNull((rs.getString("loan_servised")));
				intMoratorium=rs.getInt("loan_noofinstallment");
				strPeriodicity=correctNull((rs.getString("loan_periodicity")));
			}
			
			// To get service left of the applicant
			int ServiceYears=0;
			int ServiceMonths=0;
			
			if(!appid.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_serviceleft^" + appid);
				rs = DBUtils.executeQuery(strQuery);
	
				if (rs.next())
				{
					ServiceYears=rs.getInt("peremp_servleft");
					ServiceMonths=rs.getInt("peremp_servleftmon");
				}
			}
			if(ServiceYears!=0)
			{
				ServiceMonths = ServiceMonths + (ServiceYears * 12);
			}
			//To get income flag
//			if(rs!=null)
//				rs.close();
//			strQuery = SQLParser.getSqlQuery("sel_proincomeflag^" + strPrdcode);
//			rs = DBUtils.executeQuery(strQuery);
//			if (rs.next())
//			{
//				strincomeflag=correctNull((rs.getString("incomeflag")));
//				
//			}
			
			//Check customer and co-applicant's gross salary
			dblSalaryEligibility=0;
			dblnetincome=0;
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("get_salary_margin^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblgrossincome = rs.getDouble("maxlimit");	
			    dblothincome = rs.getDouble("maxlimit1");
			    dblSalaryEligibility=dblgrossincome+dblothincome;
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("get_salary_netmargin^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblnetincome = rs.getDouble("maxlimit");	
					   
			}
			arrEligicriteria.add("<b>Amount Requested : </b>"+nf.format(dblRequestedAmount));
			Eligiamt=dblRequestedAmount;
			double dblMPBFAmount=0.00;
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("selectmpbfeligibleamount^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblMPBFAmount = rs.getDouble("mpbf_eligibleamount");	
					   
			}
			String strExp="";	
			if(!Staffproduct.equalsIgnoreCase("Y"))
			{
			if(!strLoanAmtDevStatus.equalsIgnoreCase("Y"))
			{
				if(!(strProductType.equalsIgnoreCase("pP")|| strProductType.equalsIgnoreCase("pC")|| strProductType.equalsIgnoreCase("pJ") || strProductType.equalsIgnoreCase("pN")))
				{
					if(dblMPBFAmount<dblSanctionAmount)
					{
						arrValues.add("Sanction Amount should not exceed MPBF amount");					
						strExp="$";										
						strExp = strExp + "Sanction Amount should not exceed MPBF amount";
						throw new Exception(strExp);					
					}
				} //Employment status - 1 - Employee, 9 - pensioner, The following check can be done only for these 2 emp status
				else if(strProductType.equalsIgnoreCase("pP") && (intEmployment==1 || intEmployment==9))
				{
					if(dblMPBFAmount<dblSanctionAmount)
					{
						arrValues.add("Sanction Amount should not exceed MPBF amount");					
						strExp="$";										
						strExp = strExp + "Sanction Amount should not exceed MPBF amount";
						throw new Exception(strExp);					
					}
				}
				if(dblRequestedAmount < dblSanctionAmount)
				{
					arrValues.add("Sanction Amount should not be greater than Requested amount");
					strExp="$";					
					strExp = strExp + "Sanction Amount should not be greater than Requested amount";
					throw new Exception(strExp);					
				}
				if((dblProjectCost <dblSanctionAmount)&& !(strProductType.equalsIgnoreCase("pJ") || strProductType.equalsIgnoreCase("pC") || strProductType.equalsIgnoreCase("pN")))
				{
					arrValues.add("Sanction Amount should not be greater than Security Value");
					strExp="$";
					strExp = strExp + "Sanction Amount should not be greater than Security Value";
					throw new Exception(strExp);					
				}
			}
			if(dblSanctionAmount<dblMinimumRange)
			{
				arrValues.add("Sanction Amount should be within the Product range");
				strExp="$";
				strExp = strExp + "Sanction Amount should be within the Product range";
				throw new Exception(strExp);				
			}
			if(dblMarginEligibility < dblSanctionAmount && !(strProductType.equalsIgnoreCase("pR")|| strProductType.equalsIgnoreCase("pG")||strProductType.equalsIgnoreCase("pN")|| strProductType.equalsIgnoreCase("pC")|| strProductType.equalsIgnoreCase("pJ")))
			{
				if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedamount>0)
				{
					if(dblSanctionAmount > dbldeviatedamount)
					{
						arrValues.add("Maximum eligible amount based on margin is "+nf.format(dbldeviatedamount));
					}
				}
				else
				{
					arrValues.add("Maximum eligible amount based on margin is "+nf.format(dblMarginEligibility));
				}
			}
			if(dblmarginrate>0 && !(strProductType.equalsIgnoreCase("pR")|| strProductType.equalsIgnoreCase("pG")||strProductType.equalsIgnoreCase("pN")|| strProductType.equalsIgnoreCase("pC")|| strProductType.equalsIgnoreCase("pJ")))
			{
				arrEligicriteria.add("<b>Amount Based on Margin : </b>"+nf.format(dblMarginEligibility));
				if(dblMarginEligibility<Eligiamt)
				{
					Eligiamt=dblMarginEligibility;
					cnt++;
				}
				
			}
			}
			
			//Checking Salary Eligibility excluding Education, Health, Deposits, Gold Loan
			/*if(intEmployment==1 || intEmployment==9)
			{
				if(dblEmployedLimit>0)
				{
					if(strincomeflag.trim().equalsIgnoreCase("0"))
					{
						dblSalaryEligibility=dblSalaryEligibility*dblEmployedLimit;
					}
					else if(strincomeflag.trim().equalsIgnoreCase("1"))
					{
						dblSalaryEligibility=dblnetincome*dblEmployedLimit;
					}
					else if(strincomeflag.trim().equalsIgnoreCase("2"))
					{
						dblbothGrossIncome=dblSalaryEligibility*dblEmployedLimit;
						dblbothNetIncome=dblnetincome*dblnetbothempincome;
					
						if(dblbothGrossIncome <= dblbothNetIncome){
							dblSalaryEligibility=dblbothGrossIncome;
						}
						else{
							dblSalaryEligibility=dblbothNetIncome;
						}
					}
					if(strProductType.charAt(0)=='P' && dblSalaryEligibility < dblSanctionAmount && strProductType.charAt(1)!='E' && strProductType.charAt(1)!='I' && strProductType.charAt(1)!='R' && strProductType.charAt(1)!='G')
					{
						if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedamount>0)
						{
							if(dblSanctionAmount > dbldeviatedamount)
							{
								arrValues.add("Maximum eligible amount based on salary is "+nf.format(dbldeviatedamount));
							}
						}
						else
						{
							arrValues.add("Maximum eligible amount based on salary is "+nf.format(dblSalaryEligibility));
						}
					}
					if(strProductType.charAt(0)=='P' && strProductType.charAt(1)!='E' && strProductType.charAt(1)!='I' 
													 && strProductType.charAt(1)!='R' && strProductType.charAt(1)!='G')
					{
						arrEligicriteria.add("<b>Amount Based on Annual Income : </b>"+nf.format(dblSalaryEligibility));
						if(dblSalaryEligibility<Eligiamt)
						{
							Eligiamt=dblSalaryEligibility;
							cnt++;
						}
					}
				}
			}
			else
			{

				if (dblSelfEmployedLimit > 0) {
					if (strincomeflag.trim().equalsIgnoreCase("0")) {
						dblSalaryEligibility = dblSalaryEligibility * dblSelfEmployedLimit;
					} else if (strincomeflag.trim().equalsIgnoreCase("1")) {
						dblSalaryEligibility = dblnetincome * dblSelfEmployedLimit;
					} else if (strincomeflag.trim().equalsIgnoreCase("2")) {
						dblbothGrossIncome = dblSalaryEligibility * dblSelfEmployedLimit;
						dblbothNetIncome = dblnetincome * dblnetbothselfincome;
						if (dblbothGrossIncome <= dblbothNetIncome) {
							dblSalaryEligibility = dblbothGrossIncome;
						} else {
							dblSalaryEligibility = dblbothNetIncome;
						}
					}
					if (strProductType.charAt(0) == 'P'
							&& dblSalaryEligibility < dblSanctionAmount
							&& strProductType.charAt(1) != 'E'
							&& strProductType.charAt(1) != 'I'
							&& strProductType.charAt(1) != 'R'
							&& strProductType.charAt(1) != 'G') {
						if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedamount>0)
						{
							if(dblSanctionAmount > dbldeviatedamount)
							{
								arrValues.add("Maximum eligible amount based on salary is "+nf.format(dbldeviatedamount));
							}
						}
						else
						{
							arrValues.add("Maximum eligible amount based on salary is "+ nf.format(dblSalaryEligibility));
						}
					}
					if (strProductType.charAt(0) == 'P'
						&& strProductType.charAt(1) != 'E'
						&& strProductType.charAt(1) != 'I'
						&& strProductType.charAt(1) != 'R'
						&& strProductType.charAt(1) != 'G') {
						arrEligicriteria.add("<b>Amount Based on Annual Income : </b>"+nf.format(dblSalaryEligibility));
						if(dblSalaryEligibility<Eligiamt)
						{
							Eligiamt=dblSalaryEligibility;
							cnt++;
						}
					}
				}

			}
	
			
			
			//Checking Maximum Eligible Amount for Housing Loan Only
			if(strProductType.charAt(0)=='P' && strProductType.charAt(1)=='H'  )
			{
				if(rs!=null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("get_prop_location^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strMetroFlag = Helper.correctNull(rs.getString("prop_type"));
				}
				else
				{
					arrValues.add("Datas Not entered in Proposed/ Offered Assest House");
				}
				if(strMetroFlag.trim().equals("1"))
				{
					if(dblSanctionAmount>dblmetrolimit && dblmetrolimit>0)
					{
						if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedamount>0)
						{
							if(dblSanctionAmount > dbldeviatedamount)
							{
								arrValues.add("Maximum eligible amount based on Location of property "+nf.format(dbldeviatedamount));
							}
						}
						else
						{
							arrValues.add("Maximum eligible amount based on Location of property "+nf.format(dblmetrolimit));
						}
					}
				}
				else if(dblSanctionAmount>dblnonmetrolomit && dblnonmetrolomit>0)
				{
					if(strIsdeviated.equalsIgnoreCase("Y") && dbldeviatedamount>0)
					{
						if(dblSanctionAmount > dbldeviatedamount)
						{
							arrValues.add("Maximum eligible amount based on Location of property "+nf.format(dbldeviatedamount));
						}
					}
					else
					{
						arrValues.add("Maximum eligible amount based on Location of property "+nf.format(dblnonmetrolomit));
					}
				}
				
				if(strMetroFlag.trim().equals("1"))
				{
					if(dblmetrolimit>0)
					{
						arrEligicriteria.add("<b>Amount based on Location of property : </b>"+nf.format(dblmetrolimit));
						if(dblmetrolimit<Eligiamt)
						{
							Eligiamt=dblmetrolimit;
							cnt++;
						}
					}
				}
				else if(dblnonmetrolomit>0)
				{
					arrEligicriteria.add("<b>Amount based on Location of property : </b>"+nf.format(dblnonmetrolomit));
					if(dblnonmetrolomit<Eligiamt)
					{
						Eligiamt=dblnonmetrolomit;
						cnt++;
					}
				}
			}
			//Check whether retirement age is deviated.If so, take age from deviation table - Anitha.R
			if(strIsdeviated.equalsIgnoreCase("Y") && intdeviatedage>0)
			{
				intempretireage=intdeviatedage;
				intselfempretireage=intdeviatedage;
			}
			//checking maximum limit age
			if(intempretireage>0 || intselfempretireage>0 || intapp_minage>0)
			{
				dbleligiblemonths=0;
				dbminagemonth=intapp_minage*12;
				String strAge="";
				
				if(rs!=null)
					rs.close();
				
				strQuery=SQLParser.getSqlQuery("get_age^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					String strAppname=correctNull(rs.getString("appname"));
					String strTitle=correctNull(rs.getString("perapp_title"));
					dbleligiblemonths=0.0;
					dbltemp =Math.floor(rs.getDouble("agecompleted"));
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
					
					if(dbleligiblemonths<0 && !strTitle.equalsIgnoreCase("M/S"))
					{
						arrValues.add(strAppname+"  retirement age ("+ strAge +") exceeds the repayment period");
					
						arrEligicriteria.add("<b>"+strAppname+"  retirement age ("+ strAge +") exceeds the repayment period </b>");
					}
					
					if(intapp_minage>0 && !strTitle.equalsIgnoreCase("M/S"))
					{
						if(dbminagemonth > dbltemp)
						{
							arrValues.add(strAppname+"   not completed minimum age ("+ intapp_minage+") required");	
							//arrEligicriteria.add("<b>"+strAppname+" not completed minimum age ("+ intapp_minage+") required <b>");	
						}
					}
				}
			}*/
			
			//For Deposit Loans
			
			/*if(strProductType.equalsIgnoreCase("pR"))
			{
				if(rs!=null)
					rs.close();
				double dblreceiptos=0.0;
				double dblmarginperct=0.0;
				double dblrpteligibelamt=0.0;
				double dblmarginamt=0.0;
				
				strQuery=SQLParser.getSqlQuery("sel_loanagainstdeposit^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					dblreceiptos=rs.getDouble("loan_presentos");
					dblmarginperct=rs.getDouble("loan_margin");
					dblmarginamt=dblreceiptos*dblmarginperct/100.0;
					dblrpteligibelamt=dblrpteligibelamt+ (dblreceiptos-dblmarginamt);
				}
				arrEligicriteria.add("<b>Amount Based on Deposits : </b>"+nf.format(dblrpteligibelamt));
				if(dblrpteligibelamt<Eligiamt)
				{
					Eligiamt=dblrpteligibelamt;
					cnt++;
				}
				
				if(dblrpteligibelamt<dblSanctionAmount)
				{
					arrValues.add("Maximum eligible amount based on Deposits "+nf.format(dblrpteligibelamt));
				}
				
			}*/
			
			// For Gold loan
			
			/*if(strProductType.equalsIgnoreCase("pG"))
			{
				if(rs!=null)
					rs.close();
				
				double dblapprvalue=0.0;
				double dblbankvalue=0.0;
				double dblmargineligibleamt=0.0;
				double dblgoldvalue=0.0;
				
				strQuery=SQLParser.getSqlQuery("selgolddetailstotal^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblbankvalue=rs.getDouble("bankvalue");
					dblapprvalue=rs.getDouble("estimatevalue");
					dblmargineligibleamt=dblapprvalue-(dblapprvalue*dblmarginrate/100);
					
					dblgoldvalue=dblmargineligibleamt<dblbankvalue?dblmargineligibleamt:dblbankvalue;
				}
				arrEligicriteria.add("<b>Amount Based on Gold Oranaments : </b>"+nf.format(dblgoldvalue));
				if(dblgoldvalue<Eligiamt)
				{
					Eligiamt=dblgoldvalue;
					cnt++;
				}
				if(dblgoldvalue<dblSanctionAmount)
				{
					arrValues.add("Maximum eligible amount based on Gold Oranaments "+nf.format(dblgoldvalue));
				}
			}*/
			//For Staff loan eligibility
			/*if(strStaffFlag.equalsIgnoreCase("Y"))
			{
				
				if(rs!=null)
					rs.close();
				
				strQuery=SQLParser.getSqlQuery("get_employee_service^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				
				if(rs.next())
					dblService=Math.floor(rs.getDouble("service_completed"));
				
				dblService+=intExservice;
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("get_service_eligibility^" + strPrdcode+"^"+dblService);
				rs = DBUtils.executeQuery(strQuery);
				
				if(rs.next())
				{
					dblserviceeligibility=rs.getDouble("max_eligible_amount");
				}
				if(dblserviceeligibility>0)
				{
					arrEligicriteria.add("<b>Amount Based on service is : </b>"+nf.format(dblserviceeligibility));
					if(dblserviceeligibility<Eligiamt)
					{
						Eligiamt=dblserviceeligibility;
						cnt++;
					}
				}
				
				
				if(dblserviceeligibility>0 && dblSanctionAmount>dblserviceeligibility)
				{
					arrValues.add("Maximum eligible amount based on service is "+nf.format(dblserviceeligibility));
				}
								
			}
			
			//Checking Service Period Left with total Loan Repaymaent months
			if(!(strProductType.equalsIgnoreCase("pG") || (strProductType.equalsIgnoreCase("pR"))))
			{
				if(ServiceMonths!=0)
				{
					if(ServiceMonths < intTerms)
					{
						arrValues.add("Service Left for the Applicant is " +ServiceMonths+" Months which is Less than Loan Repayment Period "+intTerms+" Months");
					}
					arrEligicriteria.add("<b>Service Left for the Applicant is : </b>"+ServiceMonths +" months");
				}
			}
			
			
			//for staff loans
			int intTotalRatio=0;
			int intPrincipalTerms =0;
			int intInterestTerms=0;
			if(strStaffFlag.trim().equalsIgnoreCase("Y") && intInterestRatio>0 && intPrincipalRatio>0)
			{
			//	EMI for Staff
				intTotalRatio = intPrincipalRatio + intInterestRatio;
				intPrincipalTerms = intTerms*intPrincipalRatio/intTotalRatio;
				intInterestTerms = intTerms - intPrincipalTerms;
			}*/
			//For Getting Repayment Capacity Value 
			/***
			 * Changed By Sureshkumar Ganapathy
			 * Since 09 Dec 2009
			 * 
			 */
			strQuery=SQLParser.getSqlQuery("pergetIncome^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dblGrossIncome = Double.parseDouble(Helper.correctDouble(rs.getString("perinc_yearsalary")));
				dblNetIncome = Double.parseDouble(Helper.correctDouble(rs.getString("perinc_takehome")));
				dblOthrIncome=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_secincome")));
				dblOthrDeduc=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_yearotherdeduc")));
				dblDeduc=Double.parseDouble(Helper.correctDouble(rs.getString("perinc_yeardeduction")));
			}
			/*else if(!strPeriodicity.equalsIgnoreCase("n") && !strProductType.equalsIgnoreCase("pR") && !strProductType.equalsIgnoreCase("pG") && !strProductType.equalsIgnoreCase("pE"))
	        {
				arrValues.add("Gross income entered in Income & expenses page to Setup is not valid");
	        }

			if((dblGrossIncome+dblOthrIncome)==0.0 && !strPeriodicity.equalsIgnoreCase("n") && !strProductType.equalsIgnoreCase("pR") && !strProductType.equalsIgnoreCase("pG") && !strProductType.equalsIgnoreCase("pE"))
			{
				arrValues.add("Income & expenses Datas not filled");
			}*/
			
			//	checking Repayment capacity
			/*if(dblRepaycapacity>0)
			{
				if(rs!=null)
					rs.close();
				
				
				 * For staff with simple interest calculation
				 
				if(strStaffFlag.trim().equalsIgnoreCase("Y") && intInterestRatio>0 && intPrincipalRatio>0)
				{
					if(((dblNetIncome/12)-(dblSanctionAmount/intPrincipalTerms))>=(dblGrossIncome-(dblGrossIncome*dblRepaycapacity/100)))
					{
						dblRepaycapacityeligibility=dblSanctionAmount;
					}
					else if((dblGrossIncome-(dblGrossIncome*dblRepaycapacity/100))<(dblNetIncome))
					{
						
						dblRepaycapacityeligibility=((dblNetIncome-(dblGrossIncome-(dblGrossIncome*dblRepaycapacity/100)))*intPrincipalTerms)/12;
					}
					else
						dblRepaycapacityeligibility=0;
						
				}
				
				 * For General customers with compound interest calculation
				 
				else
				{
					if(strIntType.equalsIgnoreCase("Combo"))
					{
						int inttoterms=0;
						int intprd_toterms=0;
						int intprd_fromterms=0;
						
						strQuery=SQLParser.getSqlQuery("selcombointrate^"+strPrdcode+"^"+strGreater+"^"+dblSanctionAmount
								+"^"+strLesser+"^"+dblSanctionAmount+"^"+strGreater+"^"+intTerms);
						
						rs=DBUtils.executeQuery(strQuery);
						
						while(rs.next())
						{
							
							arrFrmTenor.add(correctNull(rs.getString("prd_termfrom")));
							arrToTenor.add(correctNull(rs.getString("prd_termto")));
							arrInterest.add(correctNull(rs.getString("prd_interest")));
							arrRemainTenor.add(""+(rs.getInt("prd_termto")-inttoterms));
							inttoterms=rs.getInt("prd_termto");
							
							arrFrmTenor.add(correctNull(rs.getString("prd_termfrom")));
							arrToTenor.add(correctNull(rs.getString("prd_termto")));
							arrInterest.add(correctNull(rs.getString("prd_interest")));
							
							intprd_fromterms=rs.getInt("prd_termfrom");
							intprd_toterms=rs.getInt("prd_termto");
							
							if((intprd_fromterms < intTerms) && (intTerms < intprd_toterms))
							{
								if(intTerms < intprd_toterms )
								{
									intprd_toterms=intTerms;
								}
							}
							arrRemainTenor.add(""+(intprd_toterms-inttoterms));
							inttoterms=rs.getInt("prd_termto");
						}
						
						double dblDeductions=0.0;
						double dblRepaysalary=0.0;
						if(strProductType.equalsIgnoreCase("pH") || strProductType.equalsIgnoreCase("pM"))
						{
							dblDeductions=dblOthrDeduc;
							dblRepaysalary=(dblRepaycapacity*(dblGrossIncome + dblOthrIncome-dblDeduc)/100);
						}
						else
						{
							dblDeductions=dblOthrDeduc+dblDeduc;
							dblRepaysalary=dblRepaycapacity*(dblGrossIncome + dblOthrIncome)/100;
						}
						dbltemp=Math.ceil((dblRepaysalary-dblDeductions)/12);
						double dblintrate=0.0;
						strQuery = SQLParser.getSqlQuery("selcombointerest^" + strPrdcode + "^" + strGreater + "^"
								+ Helper.formatDoubleValue(dblSanctionAmount) + "^" + strLesser + "^" + Helper.formatDoubleValue(dblSanctionAmount) +"^"+ strGreater + "^" + intTerms);
					
						rs = DBUtils.executeQuery(strQuery);
						int i=0;
						for(int j=arrRemainTenor.size()-1;j>=0;j--)
						{
							
							int inttmpterms=0;
							
							dblintrate=Double.parseDouble(Helper.correctDouble((String)arrInterest.get(j)));
							inttmpterms=Integer.parseInt(Helper.correctInt((String)arrRemainTenor.get(j)));
							
							int intfirstterm=Integer.parseInt(Helper.correctInt((String)arrRemainTenor.get(0)));
							
							double dblDenomi=0.0;
							double dblNumeri=0.0;
							double dblintpowterms=0.0;
							
							dblRate = dblintrate / (12 * 100);
							double dblinterestrate=dblRate+1;
							dblintpowterms=Math.pow(dblinterestrate, inttmpterms);
							if(i==0)
							{
								if(intMoratorium>0 && j==0)//if moratorium is there within the first slab
								{
									if(intMoratorium>=intfirstterm) //if moratorium equal to greater than first slab max term
									{
										dblRepaycapacityeligibility=0;
									}
									else if(strInterestcharged.equalsIgnoreCase("3"))//if interest to be accumulated and added to principal
									{
										
										dblNumeri= dblintpowterms-1;
										dblDenomi = dblRate * dblintpowterms;
										dblRepaycapacityeligibility=Math.round(dbltemp*dblNumeri/dblDenomi);
										
										
										dblRate = dblintrate / (12 * 100);
										dblinterestrate=dblRate+1;
										dblintpowterms=Math.pow(dblinterestrate, intMoratorium);
										
										dblNumeri=dbltemp*(dblintpowterms-1)-(dblRepaycapacityeligibility*dblRate*dblintpowterms);
										dblDenomi=dblRate;
										dblRepaycapacityeligibility=Math.round(Math.abs(dblNumeri/dblDenomi/dblintpowterms));
									}
									else//if interest is serviced for moratorium and only for remaining period eligible loan amount
									{
										dblRate = dblintrate / (12 * 100);
										dblinterestrate=dblRate+1;
										dblintpowterms=Math.pow(dblinterestrate, (inttmpterms-intMoratorium));
										
										
										dblNumeri= dblintpowterms-1;
										dblDenomi = dblRate * dblintpowterms;
										dblRepaycapacityeligibility=Math.round(dbltemp*dblNumeri/dblDenomi);
									}
								}
								else
								{
									dblNumeri= dblintpowterms-1;
									dblDenomi = dblRate * dblintpowterms;
									dblRepaycapacityeligibility=Math.round(dbltemp*dblNumeri/dblDenomi);
								}
							}
							else
							{
								if(intMoratorium>0 && j==0)
								{
//									int intterms=0;
//									int inttempmoratorium=0;
//									int intmorotium=0;
//									int k=0;
//									for(;j>0 && k<=j;k++)
//									{
//										intterms+=Integer.parseInt(Helper.correctInt((String)arrRemainTenor.get(k)));
//										if(intMoratorium>intterms)
//										{
//											intmorotium++;
//											break;
//										}
//									}
//									if(k>0 && intmorotium>0)
//									{
//										inttempmoratorium=intterms-intMoratorium;
//									}
//									if(j==0)
//									{
//										inttempmoratorium=	intMoratorium;
//									}
//									if(j==k || (k+1)==j)
									if(strInterestcharged.equalsIgnoreCase("3"))//if interest to be accumulated and added to principal
									{
										dblNumeri=(dblintpowterms-1)/dblRate;
										dblDenomi=dblintpowterms;
										dblRepaycapacityeligibility=Math.round((dblRepaycapacityeligibility+(dbltemp*dblNumeri))/dblDenomi);
										
										dblRate = dblintrate / (12 * 100);
										dblinterestrate=dblRate+1;
										dblintpowterms=Math.pow(dblinterestrate, intMoratorium);
										
										dblNumeri=dbltemp*(dblintpowterms-1)-(dblRepaycapacityeligibility*dblRate*dblintpowterms);
										dblDenomi=dblRate;
										dblRepaycapacityeligibility=Math.round(Math.abs(dblNumeri/dblDenomi/dblintpowterms));
									}
									else//if interest is serviced for moratorium and only for remaining period eligible loan amount
									{
										dblRate = dblintrate / (12 * 100);
										dblinterestrate=dblRate+1;
										dblintpowterms=Math.pow(dblinterestrate, (inttmpterms-intMoratorium));
										
										
										dblNumeri=(dblintpowterms-1)/dblRate;
										dblDenomi=dblintpowterms;
										dblRepaycapacityeligibility=Math.round((dblRepaycapacityeligibility+(dbltemp*dblNumeri))/dblDenomi);
									}
								}
								else
								{
									dblNumeri=(dblintpowterms-1)/dblRate;
									dblDenomi=dblintpowterms;
									dblRepaycapacityeligibility=Math.round((dblRepaycapacityeligibility+(dbltemp*dblNumeri))/dblDenomi);
								}
							}
							
							Logger.log(nf.format(dblRepaycapacityeligibility)+"\n");
							i++;
						}
						
						if(dblRepaycapacityeligibility<0.0)
							dblRepaycapacityeligibility=0.0;
						
					}
					else
					{
						double dblDenomi=0.0;
						double dblNumeri=0.0;
						double dblRepaysalary=0.0;
						int inttmpterms=0;
						inttmpterms=intTerms-intMoratorium;
						dblRate = dblInterestRate / (12 * 100);
						dblDenomi = Math.pow(dblRate + 1, inttmpterms) - 1;
						dblNumeri = dblRate * Math.pow(dblRate + 1, inttmpterms);
						
						double dblDeductions=0.0;
						if(strProductType.equalsIgnoreCase("pH") ||  strProductType.equalsIgnoreCase("pM"))
						{
							dblDeductions=dblOthrDeduc;
							dblRepaysalary=dblRepaycapacity*(dblGrossIncome + dblOthrIncome-dblDeduc)/100;
						}
						else
						{
							dblDeductions=dblOthrDeduc+dblDeduc;
							dblRepaysalary=dblRepaycapacity*(dblGrossIncome + dblOthrIncome)/100;
						}
						
						//dblRepaysalary=dblRepaycapacity*(dblGrossIncome + dblOthrIncome-dblDeduc)/100;
						dbltemp=(dblRepaysalary-dblDeductions)/12;
						dblRepaycapacityeligibility=(dbltemp*dblDenomi)/dblNumeri;
						if(dblRepaycapacityeligibility<0.0)
							dblRepaycapacityeligibility=0.0;
					}
				}
			}
			
			if(dblRepaycapacity>0 && dblRepaycapacityeligibility<dblSanctionAmount && !strPeriodicity.equalsIgnoreCase("n") && !strProductType.equalsIgnoreCase("pR") && !strProductType.equalsIgnoreCase("pG"))
			{
				if(strIsdeviated.equalsIgnoreCase("Y"))
				{
					if(dblRepaycapacityeligibility>dbldeviatedamount)
					{
						arrValues.add("Maximum eligible amount based on Repayment Capacity is "+nf.format(dbldeviatedamount));
					}
				}
				else
				{
					arrValues.add("Maximum eligible amount based on Repayment Capacity is "+nf.format(dblRepaycapacityeligibility));
				}
			}
			if(dblRepaycapacity>0 && !strPeriodicity.equalsIgnoreCase("n") && 
					!strProductType.equalsIgnoreCase("pR") && !strProductType.equalsIgnoreCase("pG"))
			{
				arrEligicriteria.add("<b>Amount Based on Repayment Capacity : </b>"+nf.format(dblRepaycapacityeligibility));
				if(dblRepaycapacityeligibility<Eligiamt)
				{
					Eligiamt=dblRepaycapacityeligibility;
					cnt++;
				}
			}
			if(cnt>1)
			{
				arrEligicriteria.add("<b>Eligible loan Amount : </b>"+nf.format(Math.floor(Eligiamt)) +" (Least of the above Amounts)");
			}
			else
			{
				arrEligicriteria.add("<b>Eligible loan Amount : </b>"+Math.floor(Eligiamt));
			}*/
			//result
			if(arrValues.size()>0)
			{
				hshRecord.put("Status","Failed");
			}
			else
			{
				hshRecord.put("Status","Success");
			//EMI Calculation
				/*if(strStaffFlag.trim().equalsIgnoreCase("Y") && intInterestRatio>0 && intPrincipalRatio>0)
				{
					// Calculating Principal payments
					dblEMI = dblSanctionAmount/intPrincipalTerms;
					double dblActualAmtDue = dblSanctionAmount;
					dblRate = dblInterestRate / (12 * 100);
					double dblInterest = 0.0;
					
					ArrayList arrRangeFrmAmount=new ArrayList();
					ArrayList arrRangeToAmount=new ArrayList();
					ArrayList arrRangeInterest=new ArrayList();
					
					strQuery = SQLParser.getSqlQuery("sel_calslabrateRange2^" + strPrdcode + "^" + dblSanctionAmount + "^" + dblSanctionAmount + "^" + dblSanctionAmount);
					rs = DBUtils.executeQuery(strQuery);
					while (rs.next())
					{
						arrRangeFrmAmount.add(correctNull(rs.getString("frmamt")));
						arrRangeToAmount.add(correctNull(rs.getString("toamt")));
						arrRangeInterest.add(correctNull(rs.getString("interest")));
					}
					
					int totSlabsize=arrRangeToAmount.size();
					double dbltmpslabloanos=0.0;
					double dbltmploanamt=0.0;
					double dblinterest=0.0;
					double dbltotint=0.0;
					double dblloanos=0.0;
					double dbltmpgrossint=0.0;
					
					dblloanos=dblSanctionAmount;
					dbltmploanamt=dblloanos;
					while(dblloanos>0)
					{
						dbltotint=0;
						for(int j=totSlabsize-1;j>0;j--)
						{
							dbltmpslabloanos=Double.parseDouble(Helper.correctDouble((String)arrRangeToAmount.get(j-1)));
							if(dbltmploanamt>dbltmpslabloanos)
							{
								dblinterest=(dbltmploanamt-dbltmpslabloanos)*Double.parseDouble(Helper.correctDouble((String)arrRangeInterest.get(j)))/1200;
								dbltotint=dbltotint+dblinterest;
								dbltmploanamt=dbltmpslabloanos;
							}
							
						}
						dblinterest=dbltmploanamt*Double.parseDouble(Helper.correctDouble((String)arrRangeInterest.get(0)))/1200;
						dbltotint=dbltotint+dblinterest;
						
							
						dblloanos=dblloanos-dblEMI;
						dbltmpgrossint=dbltmpgrossint+dbltotint;
						dbltmploanamt=dblloanos;
					}
					
					dblInterestEMI = dbltmpgrossint/intInterestTerms;
				}
				else
				{
					//Regular EMI
					if(strIntType.equalsIgnoreCase("Combo"))
					{
						int j=0;
						if(arrInterest!=null && arrInterest.size()>0)
							dblRate=Double.parseDouble(arrInterest.get(0).toString())/(1200);
						
						double dblDenomi=0.0;
						double dblNumeri=0.0;
						int intFirtterm=0;
						
						if(arrToTenor!=null && arrToTenor.size()>0)
							intFirtterm=Integer.parseInt(arrToTenor.get(0).toString());
						
						int intothrterm=0;
						
						*//**************************************************************************************************
						 * Checking whther the loan is applied with moratorium or not if applied with the moratorium then *
						 * the interest charged during the holiday period or not and then checking with how the interest  *
						 * will be charged from the borrower															  *
						 * ************************************************************************************************//*
						if(intMoratorium>0)
						{
							if(intMoratorium<=intFirtterm)
							{
								if(strInterestservised.equalsIgnoreCase("y") && strInterestcharged.equalsIgnoreCase("3"))
								{
									dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
									dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
									if(strIntcalcmode.equalsIgnoreCase("C"))
									{
										dblSanctionAmount=dblSanctionAmount* (Math.pow(1+dblRate,intMoratorium));
									}
									else if(strIntcalcmode.equalsIgnoreCase("S"))
									{
										dblSanctionAmount = dblSanctionAmount + (dblSanctionAmount*dblRate*intMoratorium);
									}
									if(dblDenomi!=0.0)
									{
										dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
									}
									else
									{
										dblEMI=0.0;
									}
								}
								else
								{
									dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
									dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
									if(dblDenomi!=0.0)
									{
										dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
									}
									else
									{
										dblEMI=0.0;
									}
								}
							}
							else
							{
								if(strInterestservised.equalsIgnoreCase("y") && strInterestcharged.equalsIgnoreCase("3"))
								{
									if(strIntcalcmode.equalsIgnoreCase("C"))
									{
										dblSanctionAmount=dblSanctionAmount* (Math.pow((1+dblRate),(intFirtterm)));
									}
									else if(strIntcalcmode.equalsIgnoreCase("S"))
									{
										dblSanctionAmount=dblSanctionAmount+(dblSanctionAmount*dblRate*intFirtterm);
									}
									intothrterm=intMoratorium-intFirtterm;
									if(intothrterm>0)
									{
										dblRate=Double.parseDouble(arrInterest.get(1).toString())/(1200);
										if(strIntcalcmode.equalsIgnoreCase("C"))
										{
											dblSanctionAmount=dblSanctionAmount* (Math.pow((1+dblRate),(intothrterm)));
										}
										else if(strIntcalcmode.equalsIgnoreCase("S"))
										{
											dblSanctionAmount= dblSanctionAmount +(dblSanctionAmount*dblRate*intothrterm);
										}
										dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
										dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
										if(dblDenomi!=0.0)
										{
											dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
										}
										else
										{
											dblEMI=0.0;
										}
									}
									else
									{
										dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
										dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
										if(dblDenomi!=0.0)
										{
											dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
										}
										else
										{
											dblEMI=0.0;
										}
									}
								}
								else
								{
									for(j=1;j<arrInterest.size() && (intMoratorium-1)<=Integer.parseInt(arrToTenor.get(j).toString());j++)
									{
										dblRate=Double.parseDouble(arrInterest.get(j).toString())/(1200);
										dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
										dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
										
										if(dblDenomi!=0.0)
										{
											dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
										}
										else
										{
											dblEMI=0.0;
										}
									}
								}
							}
						}
						else
						{
							dblDenomi=Math.pow(dblRate + 1, intTerms) - 1;
							dblNumeri=dblRate * Math.pow(dblRate + 1, intTerms);
							if(dblDenomi!=0.0)
							{
								dblEMI=(dblNumeri / dblDenomi) * dblSanctionAmount;
							}
							else
							{
								dblEMI=0.0;
							}
						}
					}
					else
					{*/
						/* if(intMoratorium > 0)
						{
							intTerms=intTerms-intMoratorium;	
						}
						if(strInterestservised.equalsIgnoreCase("y") && strInterestcharged.equals("3"))
						{
							if(strIntcalcmode.equalsIgnoreCase("C"))
							{
								double tmp =  (1+(dblInterestRate /1200));		
								dblSanctionAmount  = 	dblSanctionAmount *(Math.pow(tmp,intMoratorium));
							}
							else if(strIntcalcmode.equalsIgnoreCase("S"))
							{
								double tmp =  (dblInterestRate /1200);		
								dblSanctionAmount = dblSanctionAmount+ (dblSanctionAmount*tmp*intMoratorium);
							}
							
						}
						dblInterestRate = dblInterestRate / (12 * 100);
						double dbldenom = Math.pow(dblInterestRate + 1, intTerms) - 1;
						double dblnumer = dblInterestRate * Math.pow(dblInterestRate + 1, intTerms);
						dblEMI = (dblnumer / dbldenom) * dblSanctionAmount; */
					//}
				//}
			}
			hshRecord.put("Message",arrValues);
			hshRecord.put("StaffFlag", strStaffFlag);
			hshRecord.put("EMI", nf.format(dblEMI));
			hshRecord.put("repaycapacity", nf.format(dblRepaycapacity));
			hshRecord.put("arrEligicriteria", arrEligicriteria);
			hshRecord.put("strEligibleLoanAmt", nf.format(Math.floor(Eligiamt)));
			if(dblInterestEMI>0)
			{
				hshRecord.put("InterestEMI", nf.format(dblInterestEMI));
			}
			
			//	This Code is used for Organisation details
			
			if(rs!=null)
			{
				rs.close();
			}			
			rs=DBUtils.executeLAPSQuery("selBranchCityName^"+strAppno);
			while (rs.next())
			{ 
				hshRecord.put("orgname",correctNull(rs.getString("org_name")));
	           	hshRecord.put("orgadd1",correctNull(rs.getString("org_add1")));
	           	hshRecord.put("orgadd2",correctNull(rs.getString("org_add2")));
	           	hshRecord.put("orgcity",correctNull(rs.getString("city_name")));
	           	hshRecord.put("orgstate",correctNull(rs.getString("state_name")));
	           	hshRecord.put("orgzip",correctNull(rs.getString("org_zip")));
	           	hshRecord.put("orgphone",correctNull(rs.getString("org_phone")));
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
	
	public HashMap getEqualInstallments(HashMap hshValues) 
	{
		int intInstallments=0;
		double dblLoanamount=0.0;
		int intHoliday=0;
		String period="";
		 if(hshValues.get("installments")!=null)
		 {
			 intInstallments=Integer.parseInt((String) hshValues.get("installments"));
		 }
		 if(hshValues.get("loanamount")!=null)
		 {
			 dblLoanamount=Double.parseDouble((String) hshValues.get("loanamount"));
		 }
		 if(hshValues.get("holiday")!=null)
		 {
			 intHoliday=Integer.parseInt((String) hshValues.get("holiday"));
		 }
		 if(hshValues.get("period")!=null)
		 {
			 period=correctNull((String) hshValues.get("period"));
		 }
		 
		int tempInstallments=intInstallments-intHoliday;
		
		if(period.equalsIgnoreCase("M"))
		{
			tempInstallments=intInstallments-intHoliday;
			
		}
		else if(period.equalsIgnoreCase("Q"))
		{			
			tempInstallments=(intInstallments-intHoliday)/3;
			if((intInstallments-intHoliday)%3>0)
			{
				tempInstallments+=1;
			}
			
		}
		else if(period.equalsIgnoreCase("H"))
		{
			tempInstallments=(intInstallments-intHoliday)/6;
			if((intInstallments-intHoliday)%6>0)
			{
				tempInstallments+=1;
			}
			
		}
		else if(period.equalsIgnoreCase("Y"))
		{			
			tempInstallments=(intInstallments-intHoliday)/12;
			if((intInstallments-intHoliday)%12>0)
			{
				tempInstallments+=1;
			}
			
		}
		
		double dblEI=dblLoanamount/tempInstallments;
		ArrayList amountDue=new ArrayList();
		ArrayList arrayData=new ArrayList();
		double dblAmountDue=0.0;
		for(int i=0;i<=tempInstallments-1;i++)
		{
			amountDue=new ArrayList();	
			amountDue.add(new Integer(i+1).toString());
			amountDue.add(Helper.formatDoubleValue(dblLoanamount));
			dblAmountDue=dblLoanamount-dblEI;
			amountDue.add(Helper.formatDoubleValue(dblEI));
			amountDue.add(Helper.formatDoubleValue(dblAmountDue));
			dblLoanamount=dblAmountDue;		
			arrayData.add(amountDue);
		}		
		hshValues.put("equalInsData",arrayData);		
		return hshValues;
		 
	}
	public HashMap getStaffservice(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String prd_code=Helper.correctNull((String)hshValues.get("prd_code"));
		String totalyear=Helper.correctNull((String)hshValues.get("totalyear"));
		try
		{
		if (rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("selstaffloanservice^"+prd_code);
			while(rs.next())
			{
				
				
				hshRecord.put("minservice",correctNull((String)rs.getString("min_service")));
				hshRecord.put("maxservice",correctNull((String)rs.getString("max_service")));
				
				
			}
		
		if (rs != null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("selstaffloanserviceamount^"+prd_code+"^"+totalyear);
			while(rs.next())
			{
				
				
				hshRecord.put("MAX_ELIGIBLE_AMOUNT",correctNull((String)rs.getString("MAX_ELIGIBLE_AMOUNT")));
				
				
				
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
	

	public HashMap getSlabRateChart(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery = "", strPrdcode = "", strRecAmt = "", strTerms = "", strIntType = "";
		String stronlyGreat = "<", strLesser = ">=", strGreater = "<=";
		try
		{
			hshRecord = new HashMap();
			String chkStrPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			strPrdcode = chkStrPrdcode;
			if (strPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdcode"));
			}
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshRequestValues.get("prdid1"));
			}
			
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshRequestValues.get("hidProductID"));
			}
			//added by asha
			String terms2 = correctNull((String) hshRequestValues.get("terms2"));
			String txt_date = Helper.correctNull((String) hshRequestValues.get("pdate"));
			hshRecord.put("terms2", terms2);
			hshRecord.put("loan_noofinstallment", terms2);
			hshRecord.put("txt_date", txt_date);
			
			//end
			strRecAmt = correctNull((String) hshRequestValues.get("recamt"));
			strTerms = correctNull((String) hshRequestValues.get("terms"));
			strIntType = correctNull((String) hshRequestValues.get("inttype"));
	
			ArrayList arrRangeFrmAmount = new ArrayList();
			ArrayList arrRangeToAmount = new ArrayList();
			ArrayList arrRangeInterest = new ArrayList();
			
			strQuery = SQLParser.getSqlQuery("sel_calslabrateRange1^" + strPrdcode + "^" + stronlyGreat + "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);

			while (rs.next())
			{
				arrRangeFrmAmount.add(correctNull(rs.getString("frmamt")));
				arrRangeToAmount.add(correctNull(rs.getString("toamt")));
				arrRangeInterest.add(correctNull(rs.getString("interest")));
			}
			if (rs != null)
			{
				rs.close();
			}
			 
			strQuery = SQLParser.getSqlQuery("sel_calslabrateRange2^" + strPrdcode + "^" + strRecAmt + "^" + strRecAmt + "^" + strRecAmt);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				arrRangeFrmAmount.add(correctNull(rs.getString("frmamt")));
				arrRangeToAmount.add(correctNull(rs.getString("toamt")));
				arrRangeInterest.add(correctNull(rs.getString("interest")));
			}
			
			DecimalFormat dc=new DecimalFormat();
			dc.setGroupingUsed(false);
			dc.setMaximumFractionDigits(2);
			dc.setMinimumFractionDigits(2);
			int terms = Integer.parseInt(strTerms);
			String intrRatio = Helper.correctNull((String)hshRequestValues.get("intrRatio"));
			String prinRatio =  Helper.correctNull((String)hshRequestValues.get("prinRatio"));
			if(intrRatio.equalsIgnoreCase(""))
			{
				intrRatio = "1";
			}
			
			if(prinRatio.equalsIgnoreCase(""))
			{
				prinRatio = "1";
			}
			
			int totalterms=((Integer.parseInt(prinRatio)+Integer.parseInt(intrRatio)));
			int premiumRatio=0;
			int interestRatio=0;
			if(totalterms>0)
			{
				int ratioTerms = terms / totalterms;
				premiumRatio = ratioTerms * (Integer.parseInt(prinRatio));
				interestRatio = ratioTerms * Integer.parseInt(intrRatio);
			}
			else
			{
				premiumRatio=terms;
				interestRatio=0;
			}
			
			ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			
			double loanamt = Double.parseDouble(Helper.correctDouble((String)strRecAmt));
			double premium = loanamt/premiumRatio;
			
			int totSlabsize = arrRangeToAmount.size();
									
			double dblloanos=0.0 ;
			//double dblprincipal =0.0;
			double dblinterest=0.0;
			double dbltotint=0.0;
			double dblactdue=0.0;
			double dbltmploanamt=0.0;
			double dbltmpslabloanos=0.0;
			double dbltmpgrossint=0.0;
			
			
			dblloanos=loanamt;
			dbltmploanamt=dblloanos;
			while(dblloanos>0)
			{
				arrCol=new ArrayList();
				dbltotint=0;
				for(int j=totSlabsize-1;j>0;j--)
				{
					dbltmpslabloanos=Double.parseDouble(Helper.correctDouble((String)arrRangeToAmount.get(j-1)));
					if(dbltmploanamt>dbltmpslabloanos)
					{
						dblinterest=(dbltmploanamt-dbltmpslabloanos)*Double.parseDouble(Helper.correctDouble((String)arrRangeInterest.get(j)))/1200;
						dbltotint=dbltotint+dblinterest;
						dbltmploanamt=dbltmpslabloanos;
					}
					
				}
				dblinterest=dbltmploanamt*Double.parseDouble(Helper.correctDouble((String)arrRangeInterest.get(0)))/1200;
				dbltotint=dbltotint+dblinterest;
				
					
				dblactdue=dblloanos-premium;
				arrCol.add(Helper.formatDoubleValue(dblloanos));
				arrCol.add(Helper.formatDoubleValue(dbltotint));
				arrCol.add(Helper.formatDoubleValue(premium));
				arrCol.add(Helper.formatDoubleValue(dblactdue));
				dblloanos=dblactdue;
				dbltmpgrossint=dbltmpgrossint+dbltotint;
				dbltmploanamt=dblloanos;
				arrRow.add(arrCol);
			}
			dblloanos=dbltmpgrossint;
			premium=dblloanos/interestRatio;
			for(int i=interestRatio; i>0; i--)
			{
				arrCol=new ArrayList();
				
				arrCol.add(Helper.formatDoubleValue(dblloanos));
				arrCol.add("0");
				arrCol.add(dc.format(premium));
				dblloanos=dblloanos-premium;
				arrCol.add(dc.format(dblloanos));
				arrRow.add(arrCol);
			}
			
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("txt_date", Helper.correctNull((String)hshRequestValues.get("pdate")));
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in getStepupRate login" + ce.toString());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection getStepupRate " + cf.getMessage());
			}
		}
		
		return hshRecord;
	}
	
	public HashMap getGuarantorEligible(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		ResultSet rs = null;
		String strprdcode=Helper.correctNull((String)hshValues.get("prdcode"));
		String strguaid=Helper.correctNull((String)hshValues.get("guaid"));
		String strAge="";
		String strprdage="";
		try
		{
			rs=DBUtils.executeLAPSQuery("pergetemploy^"+strguaid);
			if(rs.next())
			{
				
				hshRecord.put("perapp_dob", correctNull((String) rs.getString("perapp_dob")));
				String birthdate = correctNull((String) rs.getString("perapp_dob"));
				String currentdate = Helper.getCurrentDateTime();
				currentdate = currentdate.substring(6, 10);
				birthdate = birthdate.substring(6, 10);
				strAge = Integer.toString(Integer.parseInt(currentdate) - Integer.parseInt(birthdate));
				hshRecord.put("perapp_age", strAge);
			}	
//			if(rs!=null)rs.close();
//			rs=DBUtils.executeLAPSQuery("sel_prdinterest^"+strprdcode);
//			if(rs.next())
//			{
//				hshRecord.put("prd_guaminage", correctNull((String) rs.getString("prd_guaminage")));
//			}
			
		}
		catch(Exception ae)
		{
			throw new EJBException("Error closing the connection getGuarantorEligible " + ae.getMessage());
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
			}
			catch (Exception cf)
			{
				throw new EJBException("Error closing the connection getGuarantorEligible " + cf.getMessage());
			}
		}
		return hshRecord;
	}
	
	
	public HashMap getNSCloancheck(HashMap hshValues) 
	{
			HashMap hshResult=new HashMap();
			ResultSet rs=null;
			ResultSet rs1=null;
			String strQuery="";
			String strappids="";
			String curdate=Helper.correctNull((String)hshValues.get("currdate"));
			
		try
		{
			
			String strappid=correctNull((String)hshValues.get("strApplicantid"));
		

			String strYear=curdate.substring(6,10);
			String strMonth=curdate.substring(3,5);
			if(Integer.parseInt(strMonth) >= 1 && Integer.parseInt(strMonth)<=3)
			{
				strYear=Integer.toString(Integer.parseInt(strYear)-1);
			}

			rs = DBUtils.executeLAPSQuery("UniqAppidList1^"+strappid);	
			while(rs.next())
			{
				strappids=Helper.correctNull((String)rs.getString("perapp_id"));
				
				if(strappids!="")
				{
					strQuery=SQLParser.getSqlQuery("selnscloanavailed^"+strappids+"^"+strYear);
					rs1 = DBUtils.executeQuery(strQuery);	
					boolean boolresult=rs1.next();
					if(boolresult)
					{	
						hshResult.put("Nsccheck","Not Eligible");
					}
					
				}
			}
			
		}catch(Exception e)
		{
			throw new EJBException("Error in getNSCloancheck-"+e.getMessage());
		}
			
			
	return 	hshResult;
		
	}
	
	public HashMap getComboRateChart(HashMap hshValues) 
	{
		ResultSet rs = null;
		
		HashMap hshRecord = new HashMap();
		
		String strQuery = "";
		String strPrdcode = "";
		String emdate="";
		String strIntType = "";
		String strIntCharged="";
		String strIntServised="";
		int intuptomths=0;
		String strLesser = ">=", strGreater = "<=";
		
		int intTerms = 0;
		int intMoratorium=0;
		
		double dblRecAmount=0.0;
		
		
		ArrayList arrFrmTenor=new ArrayList();
		ArrayList arrToTenor=new ArrayList();
		ArrayList arrInterest=new ArrayList();
		
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		
		ArrayList arrEmi=new ArrayList();
		ArrayList arrUptomonths=new ArrayList();
		try
		{
			hshRecord = new HashMap();
			strPrdcode = correctNull((String) hshValues.get("prdid1"));
			
			if (strPrdcode.equalsIgnoreCase(""))
			{
				strPrdcode = correctNull((String) hshValues.get("prdcode"));
			}
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshValues.get("prdid1"));
			}
			
			if(strPrdcode.equalsIgnoreCase("") )
			{
				strPrdcode = correctNull((String) hshValues.get("hidProductID"));
			}
			
			dblRecAmount = Double.parseDouble(Helper.correctDouble((String) hshValues.get("recamt")));
			intTerms = Integer.parseInt(Helper.correctInt((String) hshValues.get("terms")));
			strIntType = correctNull((String) hshValues.get("inttype"));
			strIntServised=correctNull((String) hshValues.get("servised"));
			strIntCharged=correctNull((String) hshValues.get("interestcharged"));
			intMoratorium=Integer.parseInt(Helper.correctInt((String)hshValues.get("moritorium")));
			emdate=correctNull((String)hshValues.get("pdate"));
			
			/************************************************************************************
			 * To get all the interest rates for the eligible or requested loan amount with the *
			 * tenor requested																	*
			 ************************************************************************************/
			
			strQuery=SQLParser.getSqlQuery("selcombointrate^"+strPrdcode+"^"+strGreater+"^"+dblRecAmount
					+"^"+strLesser+"^"+dblRecAmount+"^"+strGreater+"^"+intTerms);
			
			rs=DBUtils.executeQuery(strQuery);
			
			while(rs.next())
			{
				arrFrmTenor.add(correctNull(rs.getString("prd_termfrom")));
				arrToTenor.add(correctNull(rs.getString("prd_termto")));
				arrInterest.add(correctNull(rs.getString("prd_interest")));
			}
			
			hshRecord.put("arrFrmTenor",arrFrmTenor);
			hshRecord.put("arrToTenor",arrToTenor);
			hshRecord.put("arrInterest",arrInterest);
			
			int i=1,j=0;
			double dblEMI=0.0;
			double dblRate=Double.parseDouble(arrInterest.get(0).toString())/(1200);
			double dblActualAmtDue=dblRecAmount;
			double dblTotalInterest=0.0;
			double dblTotalPrincipal=0.0;
			double dblTotalEMI=0.0;
			
			double dblDenomi=0.0;
			double dblNumeri=0.0;
			int intFirtterm=Integer.parseInt(arrToTenor.get(0).toString());
			int intothrterm=0;
			
			/**************************************************************************************************
			 * Checking whther the loan is applied with moratorium or not if applied with the moratorium then *
			 * the interest charged during the holiday period or not and then checking with how the interest  *
			 * will be charged from the borrower															  *
			 * ************************************************************************************************/
			if(intMoratorium>0)
			{
				if(intMoratorium<intFirtterm)
				{
					if(strIntServised.equalsIgnoreCase("y") && strIntCharged.equalsIgnoreCase("3"))
					{
						dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
						dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
						dblActualAmtDue=dblActualAmtDue* (Math.pow(1+dblRate,intMoratorium));
						dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
						dblTotalEMI=dblEMI*(Integer.parseInt(arrToTenor.get(0).toString())-intMoratorium);
						i=intMoratorium+1;
					}
					else
					{
						dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
						dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
						dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
						dblTotalEMI=dblEMI*(Integer.parseInt(arrToTenor.get(0).toString())-intMoratorium);
						i=intMoratorium+1;
					}
				}
				else
				{
					if(strIntServised.equalsIgnoreCase("y") && strIntCharged.equalsIgnoreCase("3"))
					{
						dblActualAmtDue=dblActualAmtDue* (Math.pow((1+dblRate),(intFirtterm)));
						
						intothrterm=intMoratorium-intFirtterm;
						if(intothrterm>=0)
						{
							dblRate=Double.parseDouble(arrInterest.get(1).toString())/(1200);
							dblActualAmtDue=dblActualAmtDue* (Math.pow((1+dblRate),(intothrterm)));
							dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
							dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
							dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
						}
						else
						{
							dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
							dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
							dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
						}
						dblTotalEMI=dblEMI*(intTerms-intMoratorium);
						i=intMoratorium+1;
					}
					else
					{
						for(j=1;j<arrInterest.size() && (intMoratorium-1)<=Integer.parseInt(arrToTenor.get(j).toString());j++)
						{
							dblRate=Double.parseDouble(arrInterest.get(j).toString())/(1200);
							dblDenomi=Math.pow(dblRate + 1, (intTerms-intMoratorium)) - 1;
							dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-intMoratorium));
							
							dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
							dblTotalEMI=dblEMI*(Integer.parseInt(arrToTenor.get(j).toString())-intMoratorium);
						}
						i=intMoratorium+1;
					}
				}
			}
			else
			{
				dblDenomi=Math.pow(dblRate + 1, intTerms) - 1;
				dblNumeri=dblRate * Math.pow(dblRate + 1, intTerms);
				dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
				dblTotalEMI=dblEMI*Integer.parseInt(arrToTenor.get(0).toString());
			}
			if(strIntServised.equalsIgnoreCase("y") && strIntCharged.equalsIgnoreCase("3") && intMoratorium==intFirtterm)
			{
				dblTotalEMI=0;
			}
			else
			{
				arrEmi.add(new Double(Helper.formatDoubleValue(Math.floor(dblEMI))));
			}
			hshRecord.put("emi", ""+Math.floor(dblEMI));
			while (i <= intTerms)
			{
				double dblInterest=0.0;
				double dblPrincipal=0.0;
			
				if(j<arrInterest.size() &&  (i-1)==Integer.parseInt(arrToTenor.get(j).toString()))
				{
					arrUptomonths.add(new Integer(intuptomths));
					j++;
					dblRate=Double.parseDouble(arrInterest.get(j).toString())/(1200);
					dblDenomi=Math.pow(dblRate + 1, (intTerms-Integer.parseInt(arrToTenor.get(j-1).toString()))) - 1;
					dblNumeri=dblRate * Math.pow(dblRate + 1, (intTerms-Integer.parseInt(arrToTenor.get(j-1).toString())));
					
					dblEMI=(dblNumeri / dblDenomi) * dblActualAmtDue;
					dblTotalEMI=dblTotalEMI+(dblEMI*(Integer.parseInt(arrToTenor.get(j).toString())-Integer.parseInt(arrToTenor.get(j-1).toString())));
					arrEmi.add(new Double(Helper.formatDoubleValue(Math.floor(dblEMI))));
				}
				
				arryCol = new ArrayList();
				arryCol.add(new Integer(i));
				
				arryCol.add(new Double(Helper.formatDoubleValue(dblActualAmtDue)));
				
				dblInterest = dblActualAmtDue * dblRate;
				arryCol.add(new Double(Helper.formatDoubleValue(dblInterest)));
				
				dblTotalInterest = dblTotalInterest + dblInterest;
				
				dblPrincipal = (dblEMI - dblInterest);
				arryCol.add(new Double(Helper.formatDoubleValue(dblPrincipal)));
				
				dblTotalPrincipal = dblTotalPrincipal + dblPrincipal;
				arryCol.add(new Double(Helper.formatDoubleValue(dblEMI)));
				
				dblActualAmtDue = dblActualAmtDue - dblPrincipal;
				
				if(dblActualAmtDue<0)
					dblActualAmtDue=0.0;
				
				arryCol.add(new Double(Helper.formatDoubleValue(dblActualAmtDue)));
				
				arryRow.add(arryCol);
				
				i = i + 1;
				
				intuptomths++;
				
			}
			arrUptomonths.add(new Integer(intuptomths));
			arryCol = new ArrayList();
			arryCol.add(new String("Total"));
			arryCol.add(new Double(Helper.formatDoubleValue(dblTotalInterest)));
			arryCol.add(new Double(Helper.formatDoubleValue(dblTotalPrincipal)));
			arryCol.add(new Double(Helper.formatDoubleValue(dblTotalEMI)));
			arryRow.add(arryCol);
			
			hshRecord.put("arryRow", arryRow);
			hshRecord.put("txt_date", emdate);
			hshRecord.put("arrUptomonths",arrUptomonths);
			hshRecord.put("arrEmi",arrEmi);
			hshRecord.put("loan_terms", Integer.toString(intTerms));
			hshRecord.put("loan_noofinstallment",Integer.toString(intMoratorium) );
			
		}catch(Exception ex)
		{
			throw new EJBException("Error in getComboRateChart :: "+ex.toString());
		}finally
		{
			try{
				if(rs!=null)
					rs.close();
			}catch(Exception ex)
			{
				
			}
		}
		return hshRecord;
	}
	
	private void updAppNumforSARAL(String strAppno, String strInwardNo) 
	{
		HashMap hshQuery= new HashMap();
		ArrayList arrValues= new ArrayList();
		HashMap hshQueryValues= new HashMap();
		int intUpdatesize=0;
		
		try
		{
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updbrrecmdfacappno");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updbrrecmdsecappno");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			//1
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","upacctoperappno");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			//2
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","upBusOperappno");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
		    //3
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","upbrrecmdcommappno");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			/****
			 * For updating the datas of recomendatation 
			 * with the inward number
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","upbranchrecommendation");
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			/****
			 *  To update Inspection report of retail the inward number
			 */
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updatepreinspectionvisitbyinward");//Inspection report
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/**
			 * To update Due Diligence report of retail the inward number -Due Diligence Report - Salaried 
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updateduediligencereportinwardwise");//Due Diligence Report - Salaried 
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/**
			 * To update Due Diligence report of retail the inward number -Due Diligence Report - Others   
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updcomduediligencecertificatebyinward");//Due Diligence Report - Others 
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/**
			 * To update Due Diligence report of retail the inward number -Credit Limit sought  
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updcomcreditlimitsoughtbyinward");//Credit Limit sought 
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/**
			 * To update Due Diligence report of retail the inward number - Details of Property(ies) Offered as Security 
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updcomduediligenceinwardwise");//Details of Property(ies) Offered as Security 
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/****
			 *  To update Inspection report of Agricultue the inward number
			 */
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updagrpresanctionreportbyinwardno");//Inspection Report
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/****
			 *  To update Inspection report1 of Agricultue the inward number
			 */
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updagrpresanctionreport1byinwardno");//Inspection Report
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);
			
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			/**
			 * To update Due Diligence report of Agricultue the inward number
			 */
			
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			intUpdatesize++;
			hshQuery.put("strQueryId","updateduediligencereportinwardwise");//Due Diligence
			arrValues.add(strAppno);
			arrValues.add(strInwardNo);					
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
			
			hshQueryValues.put("size",""+intUpdatesize);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception Ex)
		{
			throw new EJBException("Error in ActionInward :: "+Ex.toString());
		}
	}
	public HashMap getApplicantIDHelp(HashMap hshRequestValues)  
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		ArrayList arrCol1=new ArrayList();
		ArrayList arrRow1 = new ArrayList();
		HashMap hshRecord=new HashMap();
		String strExp = "$";
		String strAppoldid="";
		boolean mutualguar=false;
		String strVal="";
		String strAppid=Helper.correctNull((String)hshRequestValues.get("hidapplicantid"));
		String strApplicantionNo=Helper.correctNull((String)hshRequestValues.get("strappno"));
		String strFacSno=Helper.correctInt((String)hshRequestValues.get("strfacno"));
		String strDemoStatus="";
		String strCBSStatus="";
		if(strAppid.trim().equals("")){
			strAppid=Helper.correctNull((String)hshRequestValues.get("appid"));	
		}
		if(strAppid.trim().equals("")){
			strAppid=Helper.correctNull((String)hshRequestValues.get("bowid"));	
		}
		if(strAppid.trim().equals("")){
			strAppid=Helper.correctNull((String)hshRequestValues.get("comapp_id"));	
		}
		if(strAppid.trim().equals("")){
			strAppid=Helper.correctNull((String)hshRequestValues.get("comappid"));	
		}
		if(strApplicantionNo.trim().equals(""))
		{
			strApplicantionNo=Helper.correctNull((String)hshRequestValues.get("appno"));
		}
		ArrayList arryCol = new ArrayList();
		ArrayList arryRow = new ArrayList();
		ArrayList arryRowId = new ArrayList();
		String strQuery="";
		String strQuery1="";
		boolean bState=false;
		String CbsStatus ="";
		String strCbsQuery ="";
		String strCustStatus = "";
		String strEmpStatus = "";
		String strIncStatus = "";
		String strSearchCategory=Helper.correctNull((String)hshRequestValues.get("radiobutton"));
		String strSearchText=Helper.correctNull((String)hshRequestValues.get("bow_name"));
		String democuststatus = "",nricuststatus ="",employcuststatus = "",incexpcuststatus = "",annualagriincstatus = null;
		String strTitle = "";
		String strAppType=Helper.correctNull((String)hshRequestValues.get("apptype"));
		String strCheckFlag="N";
		String strpageID=Helper.correctNull((String)hshRequestValues.get("pageID"));
		try
		{
			if(strAppid.trim().endsWith("")&&!strAppType.equalsIgnoreCase("promoter"))
			{
				rs=DBUtils.executeLAPSQuery("selectDemoApplicantId^"+strApplicantionNo);
				if(rs.next())
				{
					strAppid=Helper.correctNull((String)rs.getString("demo_appid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			else if(strAppType.equalsIgnoreCase("promoter"))
			{
				if(strSearchCategory.equalsIgnoreCase("LAPSID"))
				{
					strQuery1="perapp_id = \'"+strSearchText+"\'";
					strQuery= SQLParser.getSqlQuery("selperappoldid^"+strQuery1);
				}
				else if(strSearchCategory.equalsIgnoreCase("CBSID"))
				{
					strQuery1="perapp_cbsid = \'"+strSearchText+"\'";
					strQuery= SQLParser.getSqlQuery("selperappoldid^"+strQuery1);
				}
				else if(strSearchCategory.equalsIgnoreCase("NAME"))
				{
					strQuery1="and  upper(perapp_fname) like upper (\'%"+strSearchText+"%\')";
					strQuery= SQLParser.getSqlQuery("pergetcoappidhelpNEW^"+strAppid+"^"+strQuery1);
				}				
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppoldid=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				
				rs=DBUtils.executeLAPSQuery("chkpromotorchk^"+strAppoldid+"^"+strFacSno+"^"+strApplicantionNo);
				while(rs.next())
				{
					//strExp=strExp+"Applicant is already attached to this application";
					//throw new Exception(strExp);
					strCheckFlag="Y";

				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			if(rs!=null)
			{rs.close();}
			strQuery1="perapp_id = \'"+strAppid+"\'";
			strQuery= SQLParser.getSqlQuery("selperappoldid^"+strQuery1);
			rs =DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppid=Helper.correctNull((String)rs.getString("perapp_oldid"));
			}
			if(rs!=null)
			{rs.close();}
			if(strSearchCategory.equalsIgnoreCase("LAPSID"))
			{
				strQuery1="and perapp_id = \'"+strSearchText+"\'";
				strQuery= SQLParser.getSqlQuery("pergetOldAppidhelp^"+strAppid+"^"+strQuery1);
			}
			else if(strSearchCategory.equalsIgnoreCase("CBSID"))
			{
				strQuery1="and perapp_cbsid = \'"+strSearchText+"\'";
				strQuery= SQLParser.getSqlQuery("pergetOldAppidhelp^"+strAppid+"^"+strQuery1);
			}
			else if(strSearchCategory.equalsIgnoreCase("NAME"))
			{
				strQuery1="and  upper(perapp_fname) like upper (\'%"+strSearchText+"%\')";
				strQuery= SQLParser.getSqlQuery("pergetOldAppidhelp^"+strAppid+"^"+strQuery1);
			}
			rs =DBUtils.executeQuery(strQuery);
			bState=rs.next();
			if(!bState)
			{
				hshRecord.put("noData","noData");
			}
			while(bState)
			{
				arryCol=new ArrayList();
				String strCityCode=Helper.correctNull((String)rs.getString("con_comcity"));
				String strStateCode=Helper.correctNull((String)rs.getString("con_comstate"));
				String strCityDesc="";
				String strStateDesc="";
				String strGrpMgmt="";
				String strQuery2="";
				strQuery2=SQLParser.getSqlQuery("sel_citynamebycode^"+strCityCode);
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					strCityDesc=Helper.correctNull((String)rs1.getString("city_name"));
				}
				strQuery2=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					strStateDesc=Helper.correctNull((String)rs1.getString("state_name"));
				}
				
				String PERAPP_CONSTITUTIONNEW=Helper.correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW"));
				if(PERAPP_CONSTITUTIONNEW.equals("01"))
				{
					strGrpMgmt="N";//group management people
				}
				else
				{
					if(strAppType.equals("promoter"))
					{
						rs2=DBUtils.executeLAPSQuery("sel_corp_grpmnmt^"+strApplicantionNo+"^"+Helper.correctInt((String)rs.getString("perapp_cbsid"))+"^"+"''");
					}
					else 
					{
						rs2=DBUtils.executeLAPSQuery("sel_appl_grpManagement^"+strApplicantionNo+"^"+Helper.correctInt((String)rs.getString("perapp_cbsid"))+"^"+"''");
					}
					
					if(rs2.next())
					{
						strGrpMgmt="Y";//group management people
					}
					else
					{
						strGrpMgmt="N";//not group management people
					}
				}
				
				
				strVal=Helper.correctNull((String)rs.getString("perapp_id"))
						+"$"+Helper.correctNull((String)rs.getString("perapp_name"))
						+"$"+Helper.correctNull((String)rs.getString("perapp_lname"))
						+"$"+Helper.correctNull((String)rs.getString("perapp_dob"))
						+"$"+Helper.correctNull((String)rs.getString("perapp_sex"))
						+"$"+Helper.correctNull((String)rs.getString("con_comaddr1"))
						+"$"+Helper.correctNull((String)rs.getString("con_comaddr2"))
						+"$"+Helper.correctNull((String)rs.getString("con_comvillage"))
						+"$"+strCityDesc+"$"+strStateDesc
						+"$"+Helper.correctNull((String)rs.getString("con_comzip"))
						+"$"+Helper.correctNull((String)rs.getString("con_comphone"))
						+"$"+Helper.correctNull((String)rs.getString("con_comfax"))
						+"$"+Helper.correctNull((String)rs.getString("con_email"))
						+"$"+Helper.correctNull((String)rs.getString("perapp_oldid"))
						+"$"+strGrpMgmt
						+"$"+Helper.correctNull((String)rs.getString("con_permcity"))
						+"$"+Helper.correctNull((String)rs.getString("con_permstate"))
						+"$"+Helper.correctNull((String)rs.getString("INDINFO_RESIDENT_STATUS"));
				arryCol.add(rs.getString(1));
				arryCol.add(rs.getString(2));
				arryCol.add(strVal);
				arryCol.add(rs.getString("perapp_cbsid"));//added by gaensan
				arryCol.add(Helper.correctNull(rs.getString("perapp_oldid")));
				arryCol.add(strGrpMgmt);
				arryCol.add(Helper.correctNull((String)rs.getString("INDINFO_RESIDENT_STATUS")));
				arryCol.add(Helper.correctNull((String)rs.getString("con_permcity")));
				arryCol.add(Helper.correctNull((String)rs.getString("con_permstate")));

				if(rs1!=null)
				{
					rs1.close();
				}
				strQuery2=SQLParser.getSqlQuery("sel_processAppl_demoid^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID"))+"^"+Helper.correctNull(rs.getString("PERAPP_OLDID")));
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					arryCol.add("Y");
				}
				else
				{
					arryCol.add("N");
				}
				arryRow.add(arryCol);
				strDemoStatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				strCBSStatus=Helper.correctNull((String)rs.getString("perapp_cbsstatus"));
				bState=rs.next();
				
				
				
			}
			hshRecord.put("arryRow",arryRow);
			hshRecord.put("arryRowId",arryRowId);
			hshRecord.put("appno",strApplicantionNo);
			hshRecord.put("strCheckFlag",strCheckFlag);
			hshRecord.put("pageID",strpageID);
			
			if(bState)
			{
				if(strDemoStatus.equalsIgnoreCase("Y") && strCBSStatus.equalsIgnoreCase("Y"))
				{
				//No Function
				}
				else
				{
					strExp=strExp+"Customer Profile is not filled completely";
					throw new Exception(strExp);
				}
			}
		} 
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
			//e.printStackTrace();
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	public HashMap updateSourceOfMargin(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();		
		ArrayList arrValues = new ArrayList();
		HashMap hshQuery = new HashMap();
		ResultSet rs=null;
		HashMap hshQueryValues = new HashMap();
		String appno=correctNull((String)hshValues.get("appno"));
		String strhidAction=correctNull((String)hshValues.get("hidAction"));
		StringBuilder sbAuditTrial = new StringBuilder();
		StringBuilder sboldAudit = new StringBuilder();
		
		try
		{		
			/*** For Audit trial old data by Guhan.T on 15/10/2013 ***/
			if(!appno.equalsIgnoreCase(""))
			{
				String strQuery=SQLParser.getSqlQuery("persourceofmargin_sel^"+ appno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strreqamtoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_REQAMT"));
					String strcostincuredoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_COSTINCURED"));
					String strownsavingsoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OWNSAVINGS"));
					String strdesc1oldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_DESC1"));
					String strdesc1valoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_VALUE1"));
					String strdesc2oldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_DESC2"));
					String strdesc2valoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_VALUE2"));
					String strdesc3oldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_DESC3"));
					String strdesc3valoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_OTHERS_VALUE3"));
					String strtotalfundoldaudit=Helper.correctNull(rs.getString("PER_MARGIN_TOTAL_FUND"));
				
					sboldAudit.append("~Loans requested from the Bank =").append(strreqamtoldaudit)
					.append("~Cost already incurred =").append(strcostincuredoldaudit)
					.append("~Own Savings and Disposal of Investments(FD's,Shares,NSC,LICP,Provident Fund) =").append(strownsavingsoldaudit);
					if(!strdesc1oldaudit.equalsIgnoreCase(""))
						sboldAudit.append("~"+strdesc1oldaudit+" =").append(strdesc1valoldaudit);
					if(!strdesc2oldaudit.equalsIgnoreCase(""))
						sboldAudit.append("~"+strdesc2oldaudit+" =").append(strdesc2valoldaudit);
					if(!strdesc3oldaudit.equalsIgnoreCase(""))
						sboldAudit.append("~"+strdesc3oldaudit+" =").append(strdesc3valoldaudit);
					sboldAudit.append("~Total Fund =").append(strtotalfundoldaudit);
				}
			}
			
			/*** End of Audit trial old data ***/
			
			if(strhidAction.equalsIgnoreCase("delete"))
			{
				
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "persourceofmargin_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
			else
			{
				arrValues = new ArrayList();
				hshQueryValues.put("size","2");				
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "persourceofmargin_del");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(correctNull((String) hshValues.get("txt_amtrequested")));
				arrValues.add(correctNull((String) hshValues.get("txt_costincured")));
				arrValues.add(correctNull((String) hshValues.get("txt_ownsavings")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_desc1")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_value1")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_desc2")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_value2")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_desc3")));
				arrValues.add(correctNull((String) hshValues.get("txt_others_value3")));
				arrValues.add(correctNull((String) hshValues.get("txt_total_fund")));
				
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "persourceofmargin_ins");
				hshQueryValues.put("2", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			/*** For Audit trial New data by Guhan.T on 15/10/2013 ***/
			
			if(!appno.equalsIgnoreCase(""))
			{
				String stramtreqaudit=correctNull((String) hshValues.get("txt_amtrequested"));
				String strcostincuredaudit=correctNull((String) hshValues.get("txt_costincured"));
				String strownsavingsaudit=correctNull((String) hshValues.get("txt_ownsavings"));
				String strdesc1audit=correctNull((String) hshValues.get("txt_others_desc1"));
				String strvalue1audit=correctNull((String) hshValues.get("txt_others_value1"));
				String strdesc2audit=correctNull((String) hshValues.get("txt_others_desc2"));
				String strvalue2audit=correctNull((String) hshValues.get("txt_others_value2"));
				String strdesc3audit=correctNull((String) hshValues.get("txt_others_desc3"));
				String strvalue3audit=correctNull((String) hshValues.get("txt_others_value3"));
				String strtotalfundaudit=correctNull((String) hshValues.get("txt_total_fund"));
				sbAuditTrial.append("~Loans requested from the Bank =").append(stramtreqaudit)
				.append("~Cost already incurred =").append(strcostincuredaudit)
				.append("~Own Savings and Disposal of Investments(FD's,Shares,NSC,LICP,Provident Fund) =").append(strownsavingsaudit);
				if(!strdesc1audit.equalsIgnoreCase(""))	
					sbAuditTrial.append("~"+strdesc1audit+" =").append(strvalue1audit);
				if(!strdesc2audit.equalsIgnoreCase(""))
					sbAuditTrial.append("~"+strdesc2audit+" =").append(strvalue2audit);
				if(!strdesc3audit.equalsIgnoreCase(""))
					sbAuditTrial.append("~"+strdesc3audit+" =").append(strvalue3audit);
				sbAuditTrial.append("~Total Fund =").append(strtotalfundaudit);
				AuditTrial.auditNewLog(hshValues, "243", appno,sbAuditTrial.toString(),sboldAudit.toString());
			}
		}				
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		return hshRec;	
	}
	
	public HashMap getSourceOfMargin(HashMap hshValues) 
	{
		HashMap hshRec=new HashMap();
		ResultSet rs = null;
		ResultSet rs1 = null;
		String appno   = "", strappname="", strProductType="";
		strProductType=correctNull((String)hshValues.get("strProductType"));
		appno = correctNull((String) hshValues.get("appno"));
		strappname = correctNull((String) hshValues.get("appname"));
		if(strappname.equals(""))
		{
			strappname=correctNull((String)hshValues.get("app_name"));
		}
		boolean recordflag=false;  
	
		try
		{ 
			if(rs1 !=null)
				rs1.close();
			rs1=DBUtils.executeLAPSQuery("persourceofmargin_sel^"+ appno);			 
			if (rs1.next()) 
			{

				hshRec.put("PER_MARGIN_APPNO",correctNull(rs1.getString("PER_MARGIN_APPNO")));
				//hshRec.put("PER_MARGIN_REQAMT",correctNull(rs1.getString("PER_MARGIN_REQAMT")));
				hshRec.put("PER_MARGIN_COSTINCURED",correctNull(rs1.getString("PER_MARGIN_COSTINCURED")));
				hshRec.put("PER_MARGIN_OWNSAVINGS",correctNull(rs1.getString("PER_MARGIN_OWNSAVINGS")));
				hshRec.put("PER_MARGIN_OTHERS_DESC1",correctNull(rs1.getString("PER_MARGIN_OTHERS_DESC1")));
				hshRec.put("PER_MARGIN_OTHERS_VALUE1",correctNull(rs1.getString("PER_MARGIN_OTHERS_VALUE1")));
				hshRec.put("PER_MARGIN_OTHERS_DESC2",correctNull(rs1.getString("PER_MARGIN_OTHERS_DESC2")));
				hshRec.put("PER_MARGIN_OTHERS_VALUE2",correctNull(rs1.getString("PER_MARGIN_OTHERS_VALUE2")));
				hshRec.put("PER_MARGIN_OTHERS_DESC3",correctNull(rs1.getString("PER_MARGIN_OTHERS_DESC3")));
				hshRec.put("PER_MARGIN_OTHERS_VALUE3",correctNull(rs1.getString("PER_MARGIN_OTHERS_VALUE3")));
				hshRec.put("PER_MARGIN_TOTAL_FUND",correctNull(rs1.getString("PER_MARGIN_TOTAL_FUND")));
				recordflag=true;
			}
			// For Getting Requested Amount from loandetails.
			if(rs !=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("getloanreqamt_sel^"+ appno);			 
			if (rs.next()) 
			{
				hshRec.put("PER_MARGIN_REQAMT",correctNull(rs.getString("LOAN_AMTREQD")));
				hshRec.put("COST_LOAN",correctNull(rs.getString("LOAN_COSTLOANPRD")));
			}
			/** For the purpose of 'Audit Trial' */
			if(recordflag)
				hshRec.put("recordflag","Y");
			else
				hshRec.put("recordflag","N");
			
			hshRec.put("app_name",strappname);
			hshRec.put("strProductType",strProductType);
			
			//added for AHP loan.
			if(rs !=null)
			rs.close();
			
			rs = DBUtils.executeLAPSQuery("getlreq^" + appno);
			if (rs.next()) {
				
				hshRec.put("str_govt_scheme", Helper.correctNull((String) rs
						.getString("GOVT_SCHEME")));
			}
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_ahp_details^"+appno);
			String strAHPSavings="";
			if(rs.next()) 
			{
				strAHPSavings=Helper.correctNull(rs.getString("AHP_SAVINGS"));
				hshRec.put("AHP_SAVINGS", Helper.correctNull(rs.getString("AHP_SAVINGS")));
				
				
			}
			if(("pH").equalsIgnoreCase(strProductType)){
				if(("080").equalsIgnoreCase(strAHPSavings)||("081").equalsIgnoreCase(strAHPSavings)){
					hshRec.put("PER_MARGIN_OWNSAVINGS",strAHPSavings);
				}
				
			}
			
			
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		finally
		{
			try
			{
				if(rs1!= null)
				{
					rs1.close();
				} 
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
		return hshRec;		
	}
	public void updateRepaymentCapacityValue(HashMap hshValues) 
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
		ResultSet rs2=null;
		String strQuery="",strGreater=">=",strLesser="<=",strPrdcode="",strappTitle="",strPrdType="",strIsdeviated="";
		double dbl_prop_loan_commitment=0.00, dbldeviatedrepay=0.00, dbl_repay_capacity_defined=0.00, dbl_borr_income=0.00;
		int intApplicantOccupation=0;
		try
		{
			String appno=Helper.correctNull((String)hshValues.get("strappno"));
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("new"))
			{
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("new"))
			{
				appno=Helper.correctNull((String)hshValues.get("checkappno"));
			}
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("new"))
			{
				appno=Helper.correctNull((String)hshValues.get("strApplicationNo"));
			}
			if(!appno.equalsIgnoreCase(""))
			{
				if(rs !=null)
				{
					rs.close();
				}
				String strProdPurpose="",strVehicleType="";
				strQuery = SQLParser.getSqlQuery("selprodpurpose^" + appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){strProdPurpose=Helper.correctNull((String)rs.getString("prd_purpose"));
				strVehicleType=Helper.correctNull((String)rs.getString("prd_vehitype"));}
				/*
				 * 			For Purchase of Ready Built House and Used Vehicle loan, 
				 * 				Margin is based on age of the building / vehicle respectively
				 */
				if(strProdPurpose.equalsIgnoreCase("H") || strProdPurpose.equalsIgnoreCase("U")||strVehicleType.equalsIgnoreCase("2")) 
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProductbymargin^" + appno);
				}
				else
				{
					strQuery = SQLParser.getSqlQuery("pergetloanProduct^" + appno);
				}
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strPrdcode=Helper.correctNull((String)rs.getString("prdcode"));
					strappTitle=Helper.correctNull(rs.getString("perapp_title"));
					dbl_prop_loan_commitment=rs.getDouble("loan_emi");
					strPrdType=Helper.correctNull((String)rs.getString("prd_type"));
					strIsdeviated=Helper.correctNull((String)rs.getString("app_isdeviated"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs=DBUtils.executeLAPSQuery("sel_app_coapp_details^"+appno);
				while(rs.next())
				{
					String strappid="";
					int int_applicant_occupation=0;
					double dbl_income_salaried=0.00, dbl_exi_loan_commitment=0.00, dbl_total_annual_commitments=0.00,
					dbl_add_depreciation_year1=0.00, dbl_add_depreciation_year2=0.00,
					dbl_add_intonliab_year1=0.00, dbl_add_intonliab_year2=0.00, dbl_nonsal_inc_itr1=0.00, dbl_nonsal_inc_itr2=0.00,
					dbl_year1_nonsal_totalinc=0.00, dbl_year2_nonsal_totalinc=0.00, dbl_nonsal_totalinc=0.00, dbl_avg_nonsal_totalinc=0.00;
					strappid=Helper.correctNull((String)rs.getString("demo_appid"));
					int_applicant_occupation=rs.getInt("perapp_employment");
					if(rs.getString("demo_type").equalsIgnoreCase("a"))
					{
						intApplicantOccupation=rs.getInt("perapp_employment");
					}
					if(rs1!=null)
					rs1.close();
					if(strappid.equalsIgnoreCase(""))
					{
						strappid=Helper.correctNull((String)hshValues.get("hidDemoId"));
					}
					if(strappid.equalsIgnoreCase(""))
					{
						strappid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
					}
					if(!strappid.equalsIgnoreCase(""))
					{
						rs1=DBUtils.executeLAPSQuery("assesment_sel_borr_income_details_appid^"+strappid);
						if(rs1.next())
						{
							 dbl_income_salaried = rs1.getDouble("perinc_takehome");
							 dbl_nonsal_inc_itr1 = rs1.getDouble("nonsal_itry1");
							 dbl_nonsal_inc_itr2 = rs1.getDouble("nonsal_itry2");
							 dbl_add_depreciation_year1 = rs1.getDouble("depreciation1");
							 dbl_add_depreciation_year2 = rs1.getDouble("depreciation2");
							 dbl_add_intonliab_year1 = rs1.getDouble("intonliab1");
							 dbl_add_intonliab_year2 = rs1.getDouble("intonliab2");
						}
						dbl_year1_nonsal_totalinc=dbl_nonsal_inc_itr1+dbl_add_depreciation_year1+dbl_add_intonliab_year1;
						dbl_year2_nonsal_totalinc=dbl_nonsal_inc_itr2+dbl_add_depreciation_year2+dbl_add_intonliab_year2;
						dbl_nonsal_totalinc=dbl_year1_nonsal_totalinc+dbl_year2_nonsal_totalinc;
						dbl_avg_nonsal_totalinc=dbl_nonsal_totalinc/2;
						if(int_applicant_occupation==1 ||int_applicant_occupation==9)
						{
							dbl_borr_income=dbl_borr_income+dbl_income_salaried;
						} else {
							dbl_borr_income=dbl_borr_income+dbl_avg_nonsal_totalinc;
						}
					}
				}
				if(rs1!=null)
				{
					rs1.close();
				}
				if(strPrdcode.equalsIgnoreCase(""))
				{
					strPrdcode=Helper.correctNull((String)hshValues.get("hidProductID"));
				}
				if(strPrdcode.equalsIgnoreCase(""))
				{
					strPrdcode=Helper.correctNull((String)hshValues.get("prdcode"));
				}
				if(!strPrdcode.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("selrepaycapacity^" + strLesser +"^"+dbl_borr_income+"^"+ strGreater +"^"+dbl_borr_income+"^"+strPrdcode);
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						
						if(intApplicantOccupation==1 || intApplicantOccupation==9)
						{
							dbl_repay_capacity_defined=(100-rs1.getDouble("repay_salariedsustanece"));
						} 
						else 
						{
							dbl_repay_capacity_defined=(100-rs1.getDouble("repay_nonsalariedsustanece"));
						}
						
						if(strIsdeviated.equalsIgnoreCase("Y"))
						{
							if (rs2!=null)
							{
								rs2.close();
							}
							strQuery = SQLParser.getSqlQuery("Sel_app_deviation^" + appno);
							rs2 = DBUtils.executeQuery(strQuery);
							while (rs2.next())
							{
								String strdeviationtype=Helper.correctNull((rs2.getString("deviation_type")));
								String strdeviationstatus=Helper.correctNull((rs2.getString("deviation_apprej")));
								if(strdeviationtype.equalsIgnoreCase("RC") && strdeviationstatus.equalsIgnoreCase("A"))
								{
									dbldeviatedrepay=rs2.getDouble("deviation_newvalue");
									if(dbldeviatedrepay>0)
									{
										dbl_repay_capacity_defined=dbldeviatedrepay;
									}
								}
							}
						}
					}
				}
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "upd_repay_loandetails");
				arrValues.add(jtn.format(dbl_repay_capacity_defined));
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
		}
		catch(Exception e)
		{
			log.error("Exception"+ e);
		}
		finally
		{
			try
			{
				if(rs1!= null)
				{
					rs1.close();
				} 
			}
			catch (Exception e1)
			{
				log.error("error occured"+e1.toString());
			}
		}
	}
	public HashMap getGoldLoanCount(String strAppOldID) 
	{
		HashMap hshGLRecord=new HashMap();
		ResultSet rs=null;
		String strQuery="", strExp="$";
		int intMaxCount=0, intCount=0;
		try
		{
			strQuery=SQLParser.getSqlQuery("selgoldratemaster^Y");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intMaxCount=Integer.parseInt(Helper.correctInt((String)rs.getString("grm_maxgoldloans")));
			}
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_GoldLoansCount^"+strAppOldID);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intCount=Integer.parseInt(Helper.correctInt((String)rs.getString("goldloans")));
			}
			hshGLRecord.put("hshMaxCount", Integer.toString(intMaxCount));
			hshGLRecord.put("hshCount", Integer.toString(intCount));
		}
		catch(Exception e)
		{
			log.error("Exception in getGoldLoanCount "+ e);
		}
		return hshGLRecord;
	}
	//Application Serach Details For Deposit Loans
	public HashMap getApplicationSearchDetails(HashMap hshValues)
	{
		ResultSet rs = null;
		String strQuery=null;
		String strQuery1=null;
		ResultSet rs1=null;
		String strcustid="";
		String strAppStatus="";
		String strCBSID="";
		String strPageFrom="";
		String strPrdType="";
		HashMap hshResult = new HashMap();
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		String strUserId="",strOrgCode="",strOrgLevel="",usrOrgCode="",strOrgSCode="";
	//	strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
		strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));		
		
		strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
		strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		strPageFrom=Helper.correctNull((String)hshValues.get("hidPageFrom"));
		strPrdType=Helper.correctNull((String)hshValues.get("hidPrdType"));
		String strCategory=Helper.correctNull((String)hshValues.get("hidCategoryType"));
		String strAppCategory=Helper.correctNull((String)hshValues.get("hidAppCategory"));
		try {
			
			if(rs !=null){
				rs.close();
			}
	
				strcustid=Helper.correctNull((String)hshValues.get("hidapplicantoldid"));
			
			strQuery = SQLParser.getSqlQuery("sel_orglevel_usinguserid^"
					+ strUserId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
			
				strOrgLevel=Helper.correctNull((String)rs.getString("org_level"));
				
			}
			if(strOrgLevel.equalsIgnoreCase("A")){
				
				usrOrgCode=strOrgCode.substring(0,12)+"%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("D")){
				
				usrOrgCode=strOrgCode.substring(0,9)+"%%%%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("R")){
				
				usrOrgCode=strOrgCode.substring(0,6)+"%%%%%%%%%";
				
			}else{
				
				usrOrgCode=strOrgCode.substring(0,3)+"%%%%%%%%%%%%";
				
			}
			
			strOrgSCode=Helper.correctNull((String)hshValues.get("strOrgShortCode"));
			
			if (rs != null) {
				rs.close();
			}
			if(strPageFrom.equalsIgnoreCase("MIS"))
			{
				strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid1^"
						+ strcustid+"^ and prd_type='"+strPrdType+"'^"+usrOrgCode+"^"+usrOrgCode);
			}
			else
			{
				if(strCategory.equalsIgnoreCase("RET"))
				{
					if(strAppCategory.equalsIgnoreCase("S"))
						strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid3^"+ strcustid+"^ and prd_type not in ('pR','pG')  and app_renew_status is null^"+strOrgSCode+"^"+strOrgSCode);
					else if(strAppCategory.equalsIgnoreCase("P"))
						strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid2^"+ strcustid+"^ and prd_type not in ('pR','pG')  and app_renew_status is null^"+usrOrgCode+"^"+usrOrgCode);
					else
						strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid1^"+ strcustid+"^ and prd_type not in ('pR','pG') and prd_loantype='OD' and app_renew_status is null^"+usrOrgCode+"^"+usrOrgCode);	
				}
				else{
					strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid4^"+ strcustid+"^ and prd_type in ('pR','pG') and prd_loantype='OD' and app_renew_status is null^"+strOrgSCode+"^"+strOrgSCode);
				}
			}
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("app_no")));
				arrCol.add(Helper.correctNull(rs.getString("PRD_DESC")));
				arrCol.add(Helper.correctNull(rs.getString("LOAN_RECMDAMT")));
				arrCol.add(Helper.correctNull(rs.getString("SanctionedDate")));
				arrCol.add(Helper.correctNull(rs.getString("CBS_ACCOUNTNO")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"
					+ strcustid);
			if (rs.next()) {
				strCBSID = Helper.correctNull((String) rs
						.getString("perapp_cbsid"));
			}
			hshResult.put("appstatus", strAppStatus);
			hshResult.put("strCBSID", strCBSID);
			hshResult.put("applid", strcustid);
		}
	catch(Exception e){
		throw new EJBException("Error in getApplicationSearchDetails "+e.toString());
	}
		
		return hshResult;

	}
	
	//Retail Application Renewal for Gold and Deposite Loans by Venkat Prasad Chowdary.
	public  HashMap updateRetailApplicationRenew(HashMap hshValues) 
	{
	
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		String strQuery="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
		String strQuery4="";
		String strQuery5="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		HashMap hshRecord = new HashMap();		
		ArrayList vecData = new ArrayList();
		String strAppno="",strFacCategory="";
		ArrayList vecVal=null;
		StringTokenizer stk = null;
		HashMap hshformula =  new HashMap();//mck
		String  strSubInterest="";
		String strAction="",strFacType="",strSubHeadId="",strSubFacId="",strSubDesc="";
		String strBorrowDesc="",strBorrowId="";
		String strOrglevel="";
        String strissaral="";
        String strAppValuesin="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();
		String strUserId="",strOrgCode="",strOrgLevel="",usrOrgCode="",strcustid="",strAppStatus="";
		String strInwardno="",strExistInwardNo ="";
		String strPrdCode="",strPrdType="";
		try
		{
			
			strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
			strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));		
			if(strcustid.equalsIgnoreCase("")){
				strcustid=Helper.correctNull((String)hshValues.get("hidapplicantid"));
			}
			strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			/*String Id = correctNull((String)hshValues.get("comapp_id"));
			boolean recordflag=false;
			if(Id.equalsIgnoreCase(""))
			{
				Id = correctNull((String)hshValues.get("comappid"));
			}
			if(Id.equalsIgnoreCase(""))
			{
				Id=correctNull((String)hshValues.get("hidapplicantid"));
			}*/		
			strAppno = correctNull((String)hshValues.get("appno"));
			String strAppval = correctNull((String)hshValues.get("strAppval"));
			String strAppFlag = correctNull((String)hshValues.get("strAppFlag"));
			String strAppSecurity = correctNull((String)hshValues.get("strAppSecurity"));
			String strAppGroupflag = correctNull((String)hshValues.get("strAppGroupflag"));
			String strchkApp=correctNull((String)hshValues.get("strchkApp"));
			
			String strExecappno=correctNull((String)hshValues.get("txtSearch"));
			strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            strissaral=correctNull((String)hshValues.get("strIsSaral"));
            String strAppNumber = correctNull((String)hshValues.get("txtSearch"));
            String strCountcheck="",strCountcheck1="";
            String strSolid=correctNull((String)hshValues.get("strSolid"));
			//Application Number check

    		if(rs !=null){
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_orglevel_usinguserid^"
					+ strUserId);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
			
				strOrgLevel=Helper.correctNull((String)rs.getString("org_level"));
				
			}
			if(strOrgLevel.equalsIgnoreCase("A")){
				
				usrOrgCode=strOrgCode.substring(0,12)+"%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("D")){
				
				usrOrgCode=strOrgCode.substring(0,9)+"%%%%%%";
				
			}else if(strOrgLevel.equalsIgnoreCase("R")){
				
				usrOrgCode=strOrgCode.substring(0,6)+"%%%%%%%%%";
				
			}else{
				
				usrOrgCode=strOrgCode.substring(0,3)+"%%%%%%%%%%%%";
				
			}
			
			if (rs != null) {
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_applno_usingcustomerid^"
					+ strcustid+"^ and prd_type in ('pR','pG')^"+usrOrgCode);
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				String strcheckappno=correctNull((String)rs.getString("app_no"));
				
				if(strAppNumber .equalsIgnoreCase(strcheckappno))
				{
					strCountcheck="Yes";
					break;
				}
				
			}if(!strAppNumber.equalsIgnoreCase(""))
			{
				if(strCountcheck.equalsIgnoreCase(""))
				{
					strCountcheck1="Yes";
					hshRecord.put("strCountcheck",strCountcheck1);
				}
			}
        	
			
			
			if(!(strAppNumber.equalsIgnoreCase("")))
			{				
				if(!strCountcheck1.equalsIgnoreCase("Yes"))
				{
					if(strAppno.equalsIgnoreCase("new") && !strExecappno.equalsIgnoreCase(""))
					{
						String strType="P";
						hshformula.put("comapp_id",strcustid);
						hshformula.put("apptype",strType);
						hshformula.put("strSolid", strSolid);
						strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
						hshValues.put("appno",strAppno);			
					}
					if(!strExecappno.equalsIgnoreCase("") && !strAppno.equalsIgnoreCase(""))
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();	
						String demo_appid="";
						String demo_type="";
						String demo_relation="";
						String demo_includeincome="";
						String demo_oldid="";
						String demo_original_id="";
						
						
						int intUpdatesize=0;
						
						
						strQuery1 = SQLParser.getSqlQuery("sel_applications_renew^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						while(rs.next())
						{
							strPrdCode=Helper.correctNull((String)rs.getString("app_prdcode"));
							strAppValuesin=correctNull(rs.getString("app_valuesin"));
							strExistInwardNo=correctNull(rs.getString("app_inwardno"));
						}
						
						InwardRegisterBean irb=new InwardRegisterBean();
						strInwardno=irb.getMaxInwardno(strSolid);
					
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(strPrdCode);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
						arrValues.add("P");
						arrValues.add(strInwardno);
						arrValues.add(strAppValuesin);
						arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("Y");
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","insapplications_renew");
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						
						strQuery1 = SQLParser.getSqlQuery("get_perdemographics_renew^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						
						while(rs.next())
						{
							//demo_appid=correctNull((String)rs.getString("demo_appid"));
							demo_type=correctNull((String)rs.getString("demo_type"));
							demo_relation=correctNull((String)rs.getString("demo_relation"));
							demo_includeincome=correctNull((String)rs.getString("demo_includeincome"));
							strQuery4 = SQLParser.getSqlQuery("get_perdemographics_oldid_renew^" + correctNull((String)rs.getString("demo_appid")));
							rs4 = DBUtils.executeQuery(strQuery4);
							if(rs4.next()){
								
								//demo_oldid=correctNull((String)rs4.getString("perapp_oldid"));
								
								strQuery5 = SQLParser.getSqlQuery("get_perdemographics_newid_renew^" + correctNull((String)rs4.getString("perapp_oldid")));
								rs5 = DBUtils.executeQuery(strQuery5);
								if(rs5.next()){
									
									demo_original_id=correctNull((String)rs5.getString("perapp_id"));
							}
							
						}
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","ins_perdemographics_renew");
							arrValues.add(strAppno);
							arrValues.add(demo_original_id);							
							arrValues.add(demo_type);
							arrValues.add(demo_relation);
							arrValues.add(demo_includeincome);
							arrValues.add("");
							arrValues.add("");
							arrValues.add("");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}						
						// Inward no generation and copy into inward table
						if(rs!=null)
							rs=null;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","insinwardreg_renew");
						arrValues.add(strInwardno);
						
						strQuery = SQLParser.getSqlQuery("selinwardreg_renew^"+strExistInwardNo);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							arrValues.add(correctNull(rs.getString("inward_sector")));//0
							//arrValues.add(correctNull(rs.getString("inward_createdon")));//1
							//arrValues.add(correctNull(rs.getString("inward_appliedon")));//2
							arrValues.add(correctNull(rs.getString("inward_custname")));//3
							arrValues.add(correctNull(rs.getString("inward_add1")));//4
							arrValues.add(correctNull(rs.getString("inward_add2")));//5
							arrValues.add(correctNull(rs.getString("inward_city")));//6
							arrValues.add(correctNull(rs.getString("inward_state")));//7
							arrValues.add(correctNull(rs.getString("inward_zipcode")));//8
							arrValues.add(correctNull(rs.getString("inward_phone")));//9
							arrValues.add(correctNull(rs.getString("inward_mobile")));//10
							arrValues.add(correctNull(rs.getString("inward_email")));//11
							arrValues.add(correctNull(rs.getString("inward_dob")));//12
							arrValues.add(correctNull(rs.getString("inward_pantan")));//13
							arrValues.add(correctNull(rs.getString("inward_purpose")));//14
							arrValues.add(correctNull(rs.getString("inward_scheme")));//15
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("inward_termloanamt")))));//16
							arrValues.add(Helper.correctNull(rs.getString("inward_wcloanamt")));//17
							arrValues.add(Helper.correctNull(rs.getString("inward_nonwcloanamt")));//18
							arrValues.add(correctNull(rs.getString("inward_ADDITIONALDETAILS")));//19
							//arrValues.add(correctNull(rs.getString("inward_docreceivedon")));//20
							arrValues.add(correctNull(rs.getString("inward_docreceived")));//21							
							arrValues.add(correctNull(rs.getString("inward_appcreateat")));//22
							arrValues.add(correctNull(rs.getString("inward_orgscode")));//23
							arrValues.add(correctNull(rs.getString("inward_appatached")));//24
							arrValues.add(correctNull(rs.getString("inward_applnprocessat")));//25
							arrValues.add(correctNull(rs.getString("inward_brstatus")));//26
							arrValues.add(correctNull(rs.getString("inward_valuesin")));//27
							arrValues.add(correctNull(rs.getString("inward_usrid")));
							arrValues.add(correctNull(rs.getString("inward_assignusrid")));
							arrValues.add(correctNull(rs.getString("inward_modifiedby")));
							//arrValues.add(correctNull(rs.getString("inward_modifieddate")));
							//arrValues.add(correctNull(rs.getString("inward_assigndate")));							
							arrValues.add(correctNull(rs.getString("inward_borrowertype")));
							arrValues.add(correctNull(rs.getString("inward_cbscustid")));
							arrValues.add(correctNull(rs.getString("inward_appliedfor")));
							arrValues.add(correctNull(rs.getString("inward_proptype")));
							arrValues.add(correctNull(rs.getString("inward_cibilreport")));
							arrValues.add(correctNull(rs.getString("inward_passportnumber")));
							arrValues.add(correctNull(rs.getString("inward_voterid")));				
							arrValues.add(correctNull(rs.getString("inward_enquirypurpose")));
							arrValues.add(correctNull(rs.getString("inward_gender")));
							arrValues.add(correctNull(rs.getString("inward_internetapp")));
							arrValues.add(correctNull(rs.getString("inward_dist")));
							arrValues.add("1");
							arrValues.add(correctNull(rs.getString("inward_rejreason")));
							arrValues.add(correctNull(rs.getString("inward_schemedesc")));
							arrValues.add(correctNull(rs.getString("inward_bankscheme")));
							arrValues.add(correctNull(rs.getString("inward_subsamount")));
							arrValues.add(correctNull(rs.getString("inward_sponagency")));
							arrValues.add(correctNull(rs.getString("inward_govtspons")));
							arrValues.add(correctNull(rs.getString("inward_schmetype")));
							arrValues.add(correctNull(rs.getString("inward_subsdtype")));
							arrValues.add(correctNull(rs.getString("inward_otheragency")));
							arrValues.add(correctNull(rs.getString("inward_ssi")));
							arrValues.add(correctNull(rs.getString("inward_tiny")));
							arrValues.add(correctNull(rs.getString("inward_exceluploadflag")));
							arrValues.add(correctNull(rs.getString("inward_phone_stdcode")));
							arrValues.add(correctNull(rs.getString("inward_totalloanamt")));
							arrValues.add(correctNull(rs.getString("inward_drivinglic")));
							arrValues.add(correctNull(rs.getString("inward_aadhar")));
							arrValues.add(correctNull(rs.getString("inward_canvassedbystaff")));
							arrValues.add(correctNull(rs.getString("inward_borrowerstatus")));
							arrValues.add(correctNull(rs.getString("inward_staffid")));
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						
						// loandetails
						if(rs!=null)
							rs=null;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","insperloandetails_renew");
						arrValues.add(strAppno);
						
						strQuery = SQLParser.getSqlQuery("get_perloandetails_renew^"+strExecappno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							//arrValues.add(correctNull(rs.getString("loan_appno")));//0
							arrValues.add(correctNull(rs.getString("loan_modintrate")));//1
							arrValues.add(correctNull(rs.getString("loan_terms")));//2
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_amtreqd")))));//3
							arrValues.add(correctNull(rs.getString("loan_costloanprd")));//4
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_recmdamt")))));//5
							arrValues.add(correctNull(rs.getString("loan_downpay")));//6
							arrValues.add(correctNull(rs.getString("loan_tradein")));//7
							arrValues.add(correctNull(rs.getString("loan_loantrade")));//8
							arrValues.add(correctNull(rs.getString("loan_modusrid")));//9
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_appamt")))));//10
							arrValues.add(correctNull(rs.getString("loan_reqterms")));//11
							arrValues.add(correctNull(rs.getString("loan_termrange")));//12
							arrValues.add(correctNull(rs.getString("loan_inttype")));//13
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_emi")))));//14
							arrValues.add(Helper.CLOBToString(rs.getClob("loan_purposeofloan")));//15
							arrValues.add(correctNull(rs.getString("loan_filedon")));//
							arrValues.add(correctNull(rs.getString("loan_repaymenttype")));//
							arrValues.add(correctNull(rs.getString("loan_margin")));//
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_docfee")))));//
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_profee")))));//
							arrValues.add(correctNull(rs.getString("loan_bank_refno")));//
							arrValues.add(correctNull(rs.getString("loan_interestcharged")));//
							arrValues.add(correctNull(rs.getString("loan_repaycapacity")));//
							arrValues.add(correctNull(rs.getString("loan_steptype")));//
							arrValues.add(correctNull(rs.getString("loan_fileno")));
							arrValues.add(correctNull(rs.getString("loan_intrate")));
							arrValues.add(correctNull(rs.getString("loan_receivedate")));
							arrValues.add(correctNull(rs.getString("loan_deviationloanamount")));
							arrValues.add(correctNull(rs.getString("loan_furmargin")));
							arrValues.add(correctNull(rs.getString("loan_type")));
							arrValues.add(correctNull(rs.getString("loan_modeofpay")));
							arrValues.add(correctNull(rs.getString("loan_facility")));
							arrValues.add(correctNull(rs.getString("loan_govt")));
							arrValues.add(correctNull(rs.getString("loan_sub")));
							arrValues.add(correctNull(rs.getString("offeredmargin")));
							arrValues.add(correctNull(rs.getString("salarylimit")));
							arrValues.add(correctNull(rs.getString("land_measurement")));
							arrValues.add(correctNull(rs.getString("govt_scheme")));				
							arrValues.add(correctNull(rs.getString("loan_annualincome")));
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_interest_emi")))));//16
							arrValues.add(correctNull(rs.getString("loan_operativeaccno")));
							arrValues.add(correctNull(rs.getString("loan_sponseragency")));
							arrValues.add(correctNull(rs.getString("loan_subsidytype")));
							arrValues.add(correctNull(rs.getString("loan_copsociety")));
							arrValues.add(correctNull(rs.getString("loan_intcalcmode")));							
							arrValues.add(correctNull(rs.getString("loan_prepaycharge")));
							arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_upfrontfee")))));
							arrValues.add(correctNull(rs.getString("loan_cgtmse")));
							arrValues.add(correctNull(rs.getString("loan_docrecvd")));
							arrValues.add(correctNull(rs.getString("loan_docspecify")));
							arrValues.add(correctNull(rs.getString("loan_specialcust")));
							arrValues.add(correctNull(rs.getString("loan_interestid")));
							arrValues.add(correctNull(rs.getString("loan_baserate")));
							arrValues.add(correctNull(rs.getString("loan_ageofveh")));
							arrValues.add(correctNull(rs.getString("loan_schemedesc")));
							arrValues.add(correctNull(rs.getString("loan_bankscheme")));
							arrValues.add(correctNull(rs.getString("loan_takeover")));
							arrValues.add(correctNull(rs.getString("loan_creditrskval")));
							arrValues.add(correctNull(rs.getString("loan_busstatval")));
							arrValues.add(correctNull(rs.getString("loan_mclrtabcode")));
							arrValues.add(correctNull(rs.getString("loan_mclrtype")));
							arrValues.add(correctNull(rs.getString("loan_goldrate_masterid")));
							arrValues.add(correctNull(rs.getString("loan_lockperiod")));
							arrValues.add(correctNull(rs.getString("loan_dnw_revisions")));
							arrValues.add(correctNull(rs.getString("loan_metlifepremiumamt")));
							arrValues.add(correctNull(rs.getString("loan_duedate")));
							
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						//Workflow
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","insworkflow_renew");
						arrValues.add(strAppno);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("1");
						arrValues.add("1");
						arrValues.add("C");	
						
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						
						arrValues.add(correctNull((String)hshValues.get("strOrgShortCode")));
						if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
							arrValues.add(correctNull((String)hshValues.get("strUserDepartment")));
						else if(correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
							arrValues.add(correctNull((String)hshValues.get("strRLPFUser")));
						else
							arrValues.add("");
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

						if(rs !=null){
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("getproductstype_renew^"+strPrdCode);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()){
							strPrdType=Helper.correctNull((String)rs.getString("prd_type"));
						}
						if(strPrdType.equalsIgnoreCase("pG")){
						//Gold Ornaments
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","insgoldloan_renew");
						//arrValues.add(strAppno);
						if(rs!=null)
						{
							rs.close();
						}
						strQuery = SQLParser.getSqlQuery("getgolddetails_renew^"+strExecappno);
						rs = DBUtils.executeQuery(strQuery);
						while (rs.next())
						{
							arrValues.add(strAppno);
							arrValues.add(correctNull((String) rs.getString("AGR_ARTNO")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTDESC")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTGROSSWT")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTQTYTOUCH")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTMKTRATE")));
							arrValues.add(correctNull((String) rs.getString("AGR_ARTRATE")));
							arrValues.add(correctNull((String) rs.getString("AGR_ESTRATE")));
							arrValues.add(correctNull((String)rs.getString("agr_quantity")));
							arrValues.add(correctNull((String)rs.getString("AGR_BANKVALUE")));
							arrValues.add(correctNull((String)rs.getString("agr_grsno")));
							arrValues.add(correctNull((String)rs.getString("agr_secid")));
							arrValues.add(correctNull((String)rs.getString("agr_articletype")));
							arrValues.add(correctNull(rs.getString("agr_netvalue")));
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
						}
						if(strPrdType.equalsIgnoreCase("pR")){
							//Deposite Loan Details
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","insgoldloan_renew");
							//arrValues.add(strAppno);
							if(rs!=null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("getgolddetails_renew^"+strExecappno);
							rs = DBUtils.executeQuery(strQuery);
							while (rs.next())
							{
								arrValues.add(strAppno);
								arrValues.add(correctNull((String) rs.getString("AGR_ARTNO")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTDESC")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTGROSSWT")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTNETWT")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTQTYTOUCH")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTMKTRATE")));
								arrValues.add(correctNull((String) rs.getString("AGR_ARTRATE")));
								arrValues.add(correctNull((String) rs.getString("AGR_ESTRATE")));
								arrValues.add(correctNull((String)rs.getString("agr_quantity")));
								arrValues.add(correctNull((String)rs.getString("AGR_BANKVALUE")));
								arrValues.add(correctNull((String)rs.getString("agr_grsno")));
								arrValues.add(correctNull((String)rs.getString("agr_secid")));
								arrValues.add(correctNull((String)rs.getString("agr_articletype")));
								arrValues.add(correctNull(rs.getString("agr_netvalue")));
								
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							}
							}
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						
					
					}
								
				}
			}
			hshRecord.put("borrowid",strBorrowId);
			hshRecord.put("borrowdesc",strBorrowDesc);
			hshRecord.put("hidAction",strAction);
			hshRecord.put("appno",strAppno);
			hshRecord.put("vecData",vecData);
			hshRecord.put("comapp_id",correctNull((String)hshValues.get("comapp_id")));
			hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("cattype")));
			hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));
			hshRecord.put("strApplicationNo",strAppno);
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			
			if((!strAppval.equalsIgnoreCase("")) && (!strAppFlag.equalsIgnoreCase("on")))
			{
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","upd_facexeappno1");
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strAppval));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			}
			
			if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
			{					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","upd_fgroupexecappno1");
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strAppval));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("Error in updateRetailApplicationRenew "+ce.toString());
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
	
	public String getMaxInwardno(String strSolid)
	{
		String strQuery="";
		ResultSet rs = null;
		String strInwardno = "";
		String strFinancialYear="";
		try
		{	
			strQuery = SQLParser.getSqlQuery("selfinancialyear");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strFinancialYear=Helper.correctNull((String)rs.getString("FinancialYear"));
				strFinancialYear=strFinancialYear.substring(2,4);
			}
			if(rs !=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("getmaxinwardno");
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strInwardno = strSolid +strFinancialYear+ rs.getString(1) ;				
			}
			if(rs != null)rs.close();
		}
		catch(Exception ce)
		{
			
			throw new EJBException("Error in getMaxAckId "+ce.toString());
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
		return strInwardno;
	}
	
	public void getFreezeData(HashMap hshValues) 
    {
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
    	ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		Connection connectDB= null;
		CallableStatement callableStmt = null;
		String strExp="",strQuery="";
		HashMap hshResult=new HashMap();
    	ArrayList arrSecCol=new ArrayList();
    	ArrayList arrSecRow=new ArrayList();
    	
    	ArrayList arrAttachCol=new ArrayList();
    	ArrayList arrAttachRow=new ArrayList();
    	ResultSet rs1=null;
    	ResultSet rs2=null;
    	ResultSet rs3=null,rs4=null;
    	String strQuery1="",strQuery2="",strQuery3="";
    	String strAppno="",newLapsId="",oldLapsId="",strappId="",strfacsno="";
    	String strName="",str_sec_id="",strsecid="",str_sec_temp_id="";
    	String strSecurityId="";
    	String strLoanType="";
    	String strSecurityType="",appno="",str_facsno="";
    	String strFlag="";
    	int count =0;
    	HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		double dbl_residualfac=0,dbl_outstandingamt=0,dbl_outstandingtemp=0,dbl_outstandingtemp1=0,dbl_residualfinal=0;
		String strWhetherACOpening="",strPrefix="",strSuffix="",strCbsACno="",strDrawingpower="",strDueDate="",strValuesin="R";
		String strOutstanding="",strFacilitycode[]=null,strModuletype="",strRatingcheck="",strSchnonsche="";
		double dblTLExposure=0.00,dblOutstanding=0.00,dbl_Sancamount=0.00,dbl_disbamount=0.00;
		//For 100% cash margin products should not include for Rating based exposure 
	    ArrayList arrCashmargincode= new ArrayList();
	    arrCashmargincode.add("153");
	    arrCashmargincode.add("154");
	    arrCashmargincode.add("156");
	    arrCashmargincode.add("158");
    	try
    	{
    		
    		strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		
    		String desc="app_no = '"+strAppno+"'";
    		strQuery=SQLParser.getSqlQuery("sel_appnosearchbyappno^"+desc);
    		rs=DBUtils.executeQuery(strQuery);
    		if(rs.next())
    		{
    			oldLapsId=Helper.correctNull((String)rs.getString("perapp_oldid"));
    		}
    		connectDB= ConnectionFactory.getConnection();
			callableStmt=connectDB.prepareCall("call BORROWER_EXPOSURE(?,?)");
			callableStmt.setString(1,Helper.correctNull(oldLapsId));
			callableStmt.setString(2,Helper.correctNull(strAppno));
			callableStmt.execute();
			callableStmt.clearParameters();
			callableStmt.close();
			connectDB.close();
			
			
			int size=0;
			if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_banking^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			if(rs!=null)
    				rs.close();
    			
    			strQuery=SQLParser.getSqlQuery("sel_adhocfacilitydetails^"+Helper.correctNull(rs4.getString("combk_parentappno"))+"^"+Helper.correctNull(rs4.getString("combk_parentfacsno")));
        		rs=DBUtils.executeQuery(strQuery);
        		while(rs.next())
        		{
        			size = size+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_comfacility_details");								
					arrValues.add(strAppno);
					arrValues.add("");
					arrValues.add(Helper.correctNull(rs.getString("facility_appno")));
					arrValues.add(Helper.correctNull(rs.getString("facility_sno")));
					arrValues.add(Helper.correctNull(rs4.getString("combk_parentappno")));
					arrValues.add(Helper.correctNull(rs4.getString("combk_parentfacsno")));
					arrValues.add("E");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(size));
					hshQueryValues.put(Integer.toString(size),hshQuery);
        		}
    			
    		}
    		
    		if(size>0)
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			size=0;
			hshQueryValues=new HashMap();
			
			if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_combanking_existingfac^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strWhetherACOpening="";strCbsACno="";strPrefix="";strSuffix="";strRatingcheck="";strSchnonsche="";
    			strDrawingpower="";strDueDate="";strOutstanding="";strFlag="";strModuletype="";
				dbl_Sancamount=0.0;dbl_disbamount=0.0;dblOutstanding=0.0;dblTLExposure=0.0;
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("combk_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("combk_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("combk_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("combk_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("combk_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("combk_facility")).split("~");
    			
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
	    			if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
	    			}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
	    			}
    			}
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strDrawingpower =jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower"))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
        			if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("combk_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
    			}
    			if(rs!=null) rs.close();
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			
    			//For 100% cash margin products should not include for Rating based exposure 
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
    				
    				hshQuery = new HashMap();
       			 	arrValues = new ArrayList();
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble(strDrawingpower))));
       			    arrValues.add(strDueDate);
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
       			 	arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
       			 	arrValues.add(strFlag);
       			 	arrValues.add(strRatingcheck);
       			    arrValues.add(strAppno);
       			 	size+=1;
       			 	hshQueryValues.put("size",""+(size));
       			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
       			    {
       			    	arrValues.add(strCbsACno);
       			    	hshQuery.put("strQueryId","updcombankdirliab"); 
       			    }
       			    else
       			    {
       			    	arrValues.add(strPrefix);
       			    	arrValues.add(strSuffix);
       			    	hshQuery.put("strQueryId","updcombankindirliab"); 
       			    }
       			 	hshQuery.put("arrValues",arrValues);
       			 	hshQueryValues.put(""+(size),hshQuery);	
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		
    		
    		dbl_outstandingamt=0;dbl_outstandingtemp=0;dbl_outstandingtemp1=0;
    		strWhetherACOpening="";strDrawingpower="";strDueDate="";strValuesin="R";
    		strOutstanding="";strModuletype="";strRatingcheck="";strSchnonsche="";
    		dblTLExposure=0.00;dblOutstanding=0.00;dbl_Sancamount=0.00;dbl_disbamount=0.00;
    		
    		size=0;
    		if(rs4!=null) rs4.close();
			strQuery2 = SQLParser.getSqlQuery("sel_comgroupconcerns_existingfac^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			strWhetherACOpening="";strCbsACno="";strPrefix="";strSuffix="";strRatingcheck="";strSchnonsche="";
    			strDrawingpower="";strDueDate="";strOutstanding="";strFlag="";strModuletype="";
				dbl_Sancamount=0.0;dbl_disbamount=0.0;dblOutstanding=0.0;dblTLExposure=0.0;
    			strWhetherACOpening=Helper.correctNull((String)rs4.getString("comgc_accountopen"));
    			strCbsACno=Helper.correctNull((String)rs4.getString("comgc_cbsappno"));
    			strPrefix=Helper.correctNull((String)rs4.getString("comgc_prefix"));
    			strSuffix=Helper.correctNull((String)rs4.getString("comgc_suffix"));
    			strModuletype=Helper.correctNull((String)rs4.getString("comgc_modtype"));
    			strFacilitycode=Helper.correctNull((String)rs4.getString("comgc_facility")).split("~");
    			
    			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
				{
	    			if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strCbsACno);
	    			}
				}
    			else
    			{
    				if(strWhetherACOpening.equalsIgnoreCase("Y"))
	    			{
	    				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strCbsACno);
	    			}
	    			else
	    			{
	    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
	    				else
	    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strCbsACno);
	    			}
    			}
    			
    			if(rs!=null) rs.close();
    			rs = DBUtils.executeQueryCBSConnection(strQuery);
    			if(rs.next())
    			{
    				strDrawingpower =jtn.format((Double.parseDouble((String)Helper.correctDouble(rs.getString("drawingpower")))));    
    				strDueDate =Helper.correctNull((String)rs.getString("duedate"));
    				strOutstanding = jtn.format(Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding"))));
    				dbl_Sancamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("SANCT_LIMIT")));
    				dbl_disbamount=Double.parseDouble((String)Helper.correctDouble(rs.getString("Disb_amt")));
    				dblOutstanding=Double.parseDouble((String)Helper.correctDouble(rs.getString("outstanding")));
        	        			
        			if(dblOutstanding<0)
    				{
    					dblOutstanding=Double.parseDouble(strOutstanding.substring(1));//for converting negative value to positive
    					strFlag="DR";
    				}	
        			else
        			{
        				strFlag="CR";
        			}
        			
					if(Helper.correctNull((String)rs4.getString("comgc_type")).equalsIgnoreCase("1")||strWhetherACOpening.equalsIgnoreCase("N"))
					{
						if(strFlag.equalsIgnoreCase("CR"))
						{
							dblTLExposure=dbl_Sancamount;
						}
						else
						{
							if(dbl_Sancamount < dblOutstanding)
							{
								dblTLExposure=dblOutstanding;
							}
							else
							{
								dblTLExposure=dbl_Sancamount;
							}
						}
					}
					else
					{
						dblTLExposure=dblOutstanding+(dbl_Sancamount-dbl_disbamount);						
					}
    			}
    			if(rs!=null) rs.close();
    			if(strModuletype.equalsIgnoreCase("P") || strModuletype.equalsIgnoreCase("r"))
    			{
	    			strQuery = SQLParser.getSqlQuery("sel_retailBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}else
    			{
    				strQuery = SQLParser.getSqlQuery("sel_corpBankschemetype^1"+"^"+strFacilitycode[0]);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strSchnonsche=Helper.correctNull((String)rs.getString("MIS_SCHEMATIC"));
					}
    			}
    			
    			if(strSchnonsche.equalsIgnoreCase("Y"))
    			{
    				strRatingcheck="N";
    			}else if(strSchnonsche.equalsIgnoreCase("N"))
    			{
    				strRatingcheck="Y";
    			}
    			//For 100% cash margin products should not include for Rating based exposure
    			if(arrCashmargincode.contains(strFacilitycode[0]))
    			{
    				strRatingcheck="N";
    			}
    				
    				hshQuery = new HashMap();
       			 	arrValues = new ArrayList();
       			 	arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,Double.parseDouble(Helper.correctDouble(strDrawingpower))));
       			    arrValues.add(strDueDate);
       			    arrValues.add(Helper.convertSetupToApplicationValues(strValuesin,dblOutstanding));
       			    arrValues.add(Helper.correctDouble(String.valueOf(dblTLExposure)));
       			    arrValues.add(strFlag);
       			    arrValues.add(strRatingcheck);
       			    arrValues.add(strAppno);
       			 	size+=1;
       			 	hshQueryValues.put("size",""+(size));
       			    if(strWhetherACOpening.equalsIgnoreCase("Y"))
       			    {
       			    	arrValues.add(strCbsACno);
       			    	hshQuery.put("strQueryId","updcomgcbankdirliab"); 
       			    }
       			    else
       			    {
       			    	arrValues.add(strPrefix);
       			    	arrValues.add(strSuffix);
       			    	hshQuery.put("strQueryId","updcomgcbankindirliab"); 
       			    }
       			 	hshQuery.put("arrValues",arrValues);
       			 	hshQueryValues.put(""+(size),hshQuery);	
    		}
    		if(size>0){
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
			size=0;
			strQuery2 = SQLParser.getSqlQuery("sel_combanking_existingfac_sec^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			appno=Helper.correctNull((String) rs4.getString("combk_parentappno"));
    			str_facsno=Helper.correctNull((String) rs4.getString("combk_parentfacsno"));
    			if(!appno.equalsIgnoreCase("")){
    		strQuery2 = SQLParser.getSqlQuery("sel_appSecdetailsfacexisting^"+appno+"^"+str_facsno+"^P");
    		rs = DBUtils.executeQuery(strQuery2);
    		while(rs.next())
    		{
    			hshQueryValues=new HashMap();
    			hshQuery = new HashMap();
    			 arrValues = new ArrayList();
    			size+=1;
    			hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_securitydetailsrenew"); 
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECID")));
				arrValues.add(str_facsno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_CUSTOMERID")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_RESIDUALVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACNATURE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYTYPE")));
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_limit")));
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_os")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_UNSECPORTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_APPLICANT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_MARGIN")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACID")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_ISCOLLATERAL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				//arrValues.add(Helper.correctNull((String)rs.getString("app_sec_borrower_id")));
				arrValues.add(oldLapsId);//In the case of gurantor's loan main borrower id will be stored to avoid that Applican't id is stored here.
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_parentappno")));
				arrValues.add(Helper.correctNull((String) rs4.getString("combk_parentfacsno")));
				arrValues.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SHARECNT")));
				arrValues.add(Helper.correctNull(rs4.getString("combk_factype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		}
    		}
    		}
    		strQuery2 = SQLParser.getSqlQuery("sel_comgroupconcerns_existingfac_sec^"+strAppno);
			rs4 = DBUtils.executeQuery(strQuery2);
    		while(rs4.next())
    		{
    			appno=Helper.correctNull((String) rs4.getString("comgc_parentappno"));
    			str_facsno=Helper.correctNull((String) rs4.getString("comgc_parentfacsno"));
    			if(!appno.equalsIgnoreCase(""))
    			{
    		strQuery2 = SQLParser.getSqlQuery("sel_appSecdetailsfacexisting^"+appno+"^"+str_facsno+"^P");
    		rs = DBUtils.executeQuery(strQuery2);
    		while(rs.next())
    		{
    			hshQueryValues=new HashMap();
    			hshQuery = new HashMap();
    			 arrValues = new ArrayList();
    			size+=1;
    			hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_securitydetailsrenew"); 
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECID")));
				arrValues.add(str_facsno);
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_CUSTOMERID")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_RESIDUALVALUE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACTYPE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACNATURE")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SECURITYTYPE")));
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_limit")));
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_os")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_UNSECPORTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_APPLICANT")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_MARGIN")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_FACID")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_ISCOLLATERAL")));
				arrValues.add("");
				arrValues.add("A");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add(Helper.correctNull((String)rs.getString("app_sec_borrower_id")));
				arrValues.add("E");
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_parentappno")));
				arrValues.add(Helper.correctNull((String) rs4.getString("comgc_parentfacsno")));
				arrValues.add(Helper.CLOBToString(rs.getClob("APP_SEC_DESCRIPTION")));
				arrValues.add(Helper.correctNull((String) rs.getString("APP_SEC_SHARECNT")));
				arrValues.add(Helper.correctNull(rs4.getString("comgc_factype")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		
    		}
    		}
    		}
    		if(size>0){
    	//	strExp =strExp+"Existing Liabilities Has been Successfully pulled.";
			//throw new Exception(strExp);
    		}
    		
    		//for updating freeze status in applications table 
    		hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues=new HashMap();
			arrValues.add("Y");
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
	  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    	}
    	catch(final Exception ce)
		{
			throw new EJBException("Error in getFreezeData : "+ce.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null) rs.close();
				if(connectDB!=null) connectDB.close();
				if(callableStmt!=null)callableStmt.close();
			}
			catch(Exception ce)
			{
				throw new EJBException("Error in closing connection : "+ce.getMessage());
						
			}
		}
    
    }
	public void updatePerincomedetaildate(HashMap hshValues) 
	{
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		try
		{
			String appno=Helper.correctNull((String)hshValues.get("strappno"));
			String strhidAction=Helper.correctNull((String)hshValues.get("hidAction"));
			
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("new"))
			{
				appno=Helper.correctNull((String)hshValues.get("appno"));
			}
			
			if((strhidAction.equalsIgnoreCase("delete"))||((strhidAction.equalsIgnoreCase("update")))) 
			{
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "del_perincomedetails");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strhidAction.equalsIgnoreCase("update"))
			{
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "ins_perincomedetails");
				arrValues.add(appno);
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Basicsal")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_da")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_allowannuation")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_undrtkngletter")));
				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
			}
		
		
	}
		catch(Exception ce)
		{
			log.error( ce);
			throw new EJBException("Error in getFreezeData : "+ce.getMessage());
		}
	}
	
	public HashMap getdataPerincomedetaildate(HashMap hshValues)
	{
		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String strQuery1="";
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAppno=null;
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
    	try
    	{
    	 strAppno=Helper.correctNull((String)hshValues.get("appno"));
		 strQuery1 = SQLParser.getSqlQuery("sel_perincomedetails^"+strAppno);
		 rs = DBUtils.executeQuery(strQuery1);
		 if(rs.next())
		 {
			 hshRecord = new HashMap();
			 hshRecord.put("perinc_basicsalary",jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_basicsalary")))));
			 hshRecord.put("perinc_da",jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_da")))));
			 hshRecord.put("perinc_alloweligible",jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_alloweligible")))));
			 hshRecord.put("PERINC_UNDERTAKEN",Helper.correctNull((String)rs.getString("PERINC_UNDERTAKEN")));
			
			
		 }
		 
    	}
		 catch(Exception ce)
		 {
			 throw new EJBException("Error in getFreezeData : "+ce.getMessage()); 
			
		 }
		 finally
			{
				try
				{
					if(rs!=null) rs.close();
					
				}
				catch(Exception ce)
				{
					throw new EJBException("Error in closing connection : "+ce.getMessage());
							
				}
			}
		
		
		return hshRecord;
		
		
	}
	public void updateShgdetails(HashMap hshValues) 
	{

		//Added by rajesh for other bank details
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;		
		ArrayList arrValues=new ArrayList();
		ResultSet rs = null;
		String strQuery="",strOldid="";
		String strAction=correctNull((String)hshValues.get("hidAction"));
		String strGradeId = Helper.correctNull((String)hshValues.get("idno"));
		String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
	  	
		try
		{
			
			String strshgname =Helper.correctNull((String)hshValues.get("txt_shgname"));
			String strvillage =Helper.correctNull((String)hshValues.get("txt_village"));
			String strtaluk = Helper.correctNull((String)hshValues.get("txt_taluk"));
			String strdistrict =Helper.correctNull((String)hshValues.get("txt_district"));
			String strpinno =Helper.correctNull((String)hshValues.get("txt_pinno"));
			String strmember=Helper.correctNull((String)hshValues.get("txt_member"));
			String strrepresent1 =Helper.correctNull((String)hshValues.get("txt_represent1"));
			String strrepresent2= Helper.correctNull((String)hshValues.get("txt_represent2"));
			String strdatestablish=Helper.correctNull((String)hshValues.get("txt_datestablish"));
			String strtypeshg =Helper.correctNull((String)hshValues.get("type_shg"));
			String strplace= Helper.correctNull((String)hshValues.get("txt_place"));
			String strday= Helper.correctNull((String)hshValues.get("txt_day"));
			String strtime=Helper.correctNull((String)hshValues.get("txt_time"));
			String strtelno=Helper.correctNull((String)hshValues.get("txt_telno"));
			String strpersonname =Helper.correctNull((String)hshValues.get("txt_personname"));
			String strmembershg =Helper.correctNull((String)hshValues.get("sel_membershg"));
			String strpersonbook =Helper.correctNull((String)hshValues.get("txt_personbook"));
			String strsbaccno= Helper.correctNull((String)hshValues.get("txt_sbaccno"));
			String strsel_rotation= Helper.correctNull((String)hshValues.get("sel_rotation"));
			String strrotation_comments =Helper.correctNull((String)hshValues.get("rotation_comments"));
			String strminsavings= Helper.correctNull((String)hshValues.get("txt_minsavings"));
			String strtotsavings=Helper.correctNull((String)hshValues.get("txt_totsavings"));
			String strsreeshakti =Helper.correctNull((String)hshValues.get("sel_sreeshakti"));
			String strrevolving =Helper.correctNull((String)hshValues.get("sel_revolving"));
			String stramount =Helper.correctNull((String)hshValues.get("txt_amount"));
			String stractivitygroup =Helper.correctNull((String)hshValues.get("txt_activitygroup"));
			String strrecpercent =Helper.correctNull((String)hshValues.get("txt_recpercent"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_agrappshg");
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_agrappshg");
				arrValues.add(hidDemoId);//1
				arrValues.add(strshgname);//2
				arrValues.add(strvillage);//3
				arrValues.add(strtaluk);//4
				arrValues.add(strdistrict);//5
				arrValues.add(strpinno);//6
				arrValues.add(strmember);//7
				arrValues.add(strrepresent1);//8
				arrValues.add(strrepresent2);//9
				arrValues.add(strdatestablish);//10
				arrValues.add(strtypeshg);//11
				arrValues.add(strplace);//12
				arrValues.add(strday);//13
				arrValues.add(strtime);//14
				arrValues.add(strtelno);//15
				arrValues.add(strpersonname);//16
				arrValues.add(strmembershg);//17
				arrValues.add(strpersonbook);//18
				arrValues.add(strsbaccno);//19
				arrValues.add(strsel_rotation);//20
				arrValues.add(strrotation_comments);//21
				arrValues.add(strminsavings);//22
				arrValues.add(strtotsavings);
				arrValues.add(strsreeshakti);//23
				arrValues.add(strrevolving);//24
				arrValues.add(stramount);//25
				arrValues.add(stractivitygroup);//26
				arrValues.add(strrecpercent);//27
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_shgmember");
				arrValues.add(hidDemoId);
				arrValues.add(strmember);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "del_shgAddtnl_info1");
				arrValues.add(hidDemoId);
				arrValues.add(hidDemoId);
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId", "del_shgAddtnl_info2");
				arrValues.add(hidDemoId);
				arrValues.add(hidDemoId);
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_agrappshg");
				arrValues.add(hidDemoId);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
	}
	}
		
	public HashMap getShgdetails(HashMap hshValues) 
		{
			
			HashMap hshRecord = new HashMap();
			ArrayList vecData = new ArrayList();
			ArrayList vecVal=new ArrayList();
			ResultSet rs = null;
			ResultSet rs1 = null;
			String strAppStatus="";
			String strprd_type=correctNull((String)hshValues.get("strProductType"));
			String hidDemoId=correctNull((String)hshValues.get("hidDemoId"));
			String strcomappid= correctNull((String)hshValues.get("hidapplicantid"));
			String strProfilestatus="",strQuery="",strQuery1="";;
			
			try
			{
			
				strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
			
			strQuery = SQLParser.getSqlQuery("sel_agrappshg^"+hidDemoId);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord = new HashMap();
				hshRecord.put("perapp_shgname",Helper.correctNull((String)rs.getString("perapp_shgname"))); //0
				hshRecord.put("perapp_shgvillage",Helper.correctNull((String)rs.getString("perapp_shgvillage")));//1
				hshRecord.put("perapp_shgtaluk",Helper.correctNull((String)rs.getString("perapp_shgtaluk")));//2
				hshRecord.put("perapp_shgdistrict",Helper.correctNull((String)rs.getString("perapp_shgdistrict"))); //3
				hshRecord.put("perapp_shgpinno",Helper.correctNull((String)rs.getString("perapp_shgpinno")));//4
				hshRecord.put("perapp_shgmember",Helper.correctNull((String)rs.getString("perapp_shgmember")));//5
				hshRecord.put("perapp_shgrepresent1",Helper.correctNull((String)rs.getString("perapp_shgrepresent1")));//6
				hshRecord.put("perapp_shgrepresent2",Helper.correctNull((String)rs.getString("perapp_shgrepresent2")));//7
				hshRecord.put("perapp_shgdatestablish",Helper.correctNull((String)rs.getString("perapp_shgdatestablish")));//8
				hshRecord.put("perapp_shgtype",Helper.correctNull((String)rs.getString("perapp_shgtype")));//9
				hshRecord.put("perapp_shgplace",Helper.correctNull((String)rs.getString("perapp_shgplace")));//10
				hshRecord.put("perapp_shgday",Helper.correctNull((String)rs.getString("perapp_shgday")));//11
				hshRecord.put("perapp_shgtime",Helper.correctNull((String)rs.getString("perapp_shgtime")));//12
				hshRecord.put("perapp_shgtelno",Helper.correctNull((String)rs.getString("perapp_shgtelno")));//13
				hshRecord.put("perapp_shgpersoname",Helper.correctNull((String)rs.getString("perapp_shgpersoname")));//14
				hshRecord.put("perapp_shgselmember",Helper.correctNull((String)rs.getString("perapp_shgselmember")));//15
				hshRecord.put("perapp_shgpersonbook",Helper.correctNull((String)rs.getString("perapp_shgpersonbook")));//16
				hshRecord.put("perapp_shgsbaccno",Helper.correctNull((String)rs.getString("perapp_shgsbaccno")));//17
				hshRecord.put("perapp_shgrotation",Helper.correctNull((String)rs.getString("perapp_shgrotation")));//18
				hshRecord.put("perapp_shgrotcomment",Helper.correctNull(Helper.CLOBToString(rs.getClob("perapp_shgrotcomment"))));//19
				hshRecord.put("perapp_shgminsavings",Helper.correctNull((String)rs.getString("perapp_shgminsavings")));//20
				hshRecord.put("perapp_shgtotsavings",Helper.correctNull((String)rs.getString("perapp_shgtotsavings")));//21
				hshRecord.put("perapp_shgsreeshakti",Helper.correctNull((String)rs.getString("perapp_shgsreeshakti")));//22
				hshRecord.put("perapp_shgrevolving",Helper.correctNull((String)rs.getString("perapp_shgrevolving")));//23
				hshRecord.put("perapp_shgamount",Helper.correctNull((String)rs.getString("perapp_shgamount")));//24
				hshRecord.put("perapp_shgactygroup",Helper.correctNull((String)rs.getString("perapp_shgactygroup")));//25
				hshRecord.put("perapp_shgrecpercent",Helper.correctNull((String)rs.getString("perapp_shgrecpercent")));//26
			}
			
			MastApplicantBean mast=new MastApplicantBean();
			HashMap prof=new HashMap();
			HashMap profile=new HashMap();
			prof.put("profile_id",hidDemoId);
			profile=(HashMap)mast.getCustomerProfileStatus(prof);
			hshRecord.put("strIncompletepage", Helper.correctNull((String)profile.get("strIncompletepage")));
			if(rs!=null)
			{
				rs.close();
			}
			
			rs=DBUtils.executeLAPSQuery("getprofilestatusfromdemographic^"+hidDemoId);
			if(rs.next())
			{
				strProfilestatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				
			}	
			else
			{
				strProfilestatus="";
			}
			hshRecord.put("strProfilestatus",strProfilestatus);
			
			//details fetching from demographics for name and address fields.
			rs=DBUtils.executeLAPSQuery("get_perapplicant_details^"+hidDemoId);				 
			if(rs.next())
			{
				hshRecord.put("perapp_shgname",Helper.correctNull((String)rs.getString("perapplicant_name")));
            }
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_customerdetail^"+hidDemoId);
			
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  	
				hshRecord.put("perapp_shgvillage",correctNull(rs.getString("CON_COMVILLAGE")));
				hshRecord.put("perapp_shgtaluk",correctNull(rs.getString("CON_COMVILLAGE")));
				hshRecord.put("perapp_shgdistrict",correctNull(rs.getString("CON_COMDIST")));
				String strDistcode = Helper.correctNull(rs.getString("CON_COMDIST"));
				if(!strDistcode.equals(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_distnamebycode^"+strDistcode);
					if(rs1.next())
					{
						hshRecord.put("perapp_shgdistrict",correctNull(rs1.getString("district_desc")));
					}
				}
				
				hshRecord.put("perapp_shgpinno",correctNull(rs.getString("CON_COMZIP")));
			}
			
			if(rs != null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_noofmembersadded^"+hidDemoId);				 
			if(rs.next())
			{
				hshRecord.put("SHGMembers",Helper.correctNull((String)rs.getString(1)));
            }

			hshRecord.put("appstatus", strAppStatus);
	}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getBankDetails "+ce.toString());
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
	
	
	public void updateLeaseperiod(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=(String)hshValues.get("hidAction");
		String strLeaseid = Helper.correctNull((String)hshValues.get("hidSno"));
		String appno=correctNull((String)hshValues.get("appno"));
		String strQuery="";
		ResultSet rs=null;
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				strQuery = SQLParser.getSqlQuery("sel_leasedetailssno^"+appno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLeaseid=Helper.correctInt((String)rs.getString("PER_LEASEID"));
				}
				if(rs!=null)
				{
					rs.close();
				}
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","ins_leasedetails");
				arrValues.add(appno);
				arrValues.add(strLeaseid);
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_description")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_frmdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_todate")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_monthlyincome")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","upd_leasedetails");
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_description")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_frmdate")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_todate")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_monthlyincome")));
				arrValues.add(appno);
				arrValues.add(strLeaseid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_leasedetails");
				arrValues.add(appno);
				arrValues.add(strLeaseid);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("updateLeaseperiod"+ce.toString());
		}
		finally
		{
			try
			{
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	public  HashMap getLeaseperiod(HashMap hshValues) 
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		double dblMonthlyRent = Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_monthgrossrent")));
		double dblTotalMonthRent = 0.00;
		try
		{
			if(dblMonthlyRent==0.00)
			{
				dblMonthlyRent = Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidGrossRent")));
			}
			String appno=correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("sel_leasedetails^"+appno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctInt((String)rs.getString("PER_LEASEID")));
				arrCol.add(Helper.correctNull((String)rs.getString("PER_DESCRIPTION")));
				arrCol.add(Helper.correctNull((String)rs.getString("PER_FROMDATE")));
				arrCol.add(Helper.correctNull((String)rs.getString("PER_TODATE")));
				arrCol.add(Helper.correctDouble((String)rs.getString("PER_GROSSRENT")));
				dblTotalMonthRent = dblTotalMonthRent + Double.parseDouble(Helper.correctDouble((String)rs.getString("PER_GROSSRENT")));
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("appno",appno);
			if(dblTotalMonthRent!=0.00 && dblTotalMonthRent!=dblMonthlyRent)
			{
				hshRecord.put("strMonthlyFlag","TRUE");
			}
			else
			{
				hshRecord.put("strMonthlyFlag","FALSE");
			}
			hshRecord.put("dblTotalMonthRent",jtn.format(dblTotalMonthRent));
			hshRecord.put("dblMonthlyRent",jtn.format(dblMonthlyRent));
		}
		catch(Exception ce)
		{		
			throw new EJBException("Error in getLeaseperiod "+ce.toString());
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
	
	public HashMap getRetailrating(HashMap hshRequestValues)  {
		        ResultSet rs = null;
				ResultSet rs1=null;
				ResultSet rs2=null;
				HashMap hshRecord = null;
				String strProductCode = null;
				java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
				nf.setMinimumIntegerDigits(1);
				nf.setGroupingUsed(false);
				boolean recordflag=false;
				ArrayList arrRow=new ArrayList();
				ArrayList arrCol=new ArrayList();
				String strBusId="";
				String strLapsParams=null; 
				String strAppno="";	
				String strParaSeq="";
				String strQuery="";
				String strSysDate="";
				String strDob="";
				String strComappId="";
				String strEmpl="";
				String strReject="";
				String strCIBILavail="N";
				String strCIBILscore="";
				String strChild="";
				String strOther="";
				//String strErrors="";
				double strLoanReqAmnt=0.00,strEmi=0.00,dbExposureAmount=0.00;
				double strMarg=0.00;
				String strInterest="",strBakWith="",strReapTerms="",strSex="",strPin="",strConstution="",strSchemeCode="",strmarSta="";
				java.text.NumberFormat ntf=java.text.NumberFormat.getInstance();
				nf.setMaximumFractionDigits(2);
				nf.setMinimumFractionDigits(2);
				String strSendFlag="N",strVehType="";
				String strBankSchemeCode="",strModelCode="",strSchematic="",buss_ruleid="";
				String strEligSchemFlag="",strFinalFlag="",strActivityCode="0",strActiveFlag="",strFacSno="",strStaffFlag="",strExposurCheckFlag="N";
			    String strBusFacId="",strRatType="0",strDataFlag="N",strPrimeFlag="",strCollFlag="";
			    String repayType="";
			    String strRepayType="",struserid="",strStudiesIn="";
			    double dbLoanReComAmount=0.00,dbPrimarySecAmount=0.00,dbloanValuePer=0.00;
			    ArrayList arRatRow=new ArrayList();
			    ArrayList arRatCol=new ArrayList();
			    String strDemoType="",strMarginReq="N";	  
			    String strWsResponseFlag="";
			    String strDataSecFlag="N";
			    String strROIUpdateFlag="N";
			    String strBusRuleID="0",moduletype="";
			    int intHolidayPeriod=0,intTerms=0;
			    double dblTenor=0.00,dblModIntRate=0.00,dblRate=0.00,dblDenomi=0.00,dblNumeri=0.00,dblEMI=0.00;
				try {
					
					hshRecord=new HashMap();
					String strAction=correctNull((String)hshRequestValues.get("hidAction"));
					strAppno = correctNull((String)hshRequestValues.get("appno"));
					strSendFlag=correctNull((String)hshRequestValues.get("sendButtonFlag"));
					strSysDate=Helper.getCurrentDateTime();
					struserid=Helper.correctNull((String)hshRequestValues.get("strUserId"));
					moduletype=Helper.correctNull((String)hshRequestValues.get("sessionModuleType"));
					log.info("=======moduletype==========="+moduletype);
					
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("selmiscountdetails^"+strAppno);
					if(rs.next())
					{
						strDataFlag="Y";
					}
					hshRecord.put("strDataFlag", strDataFlag);
					
					//added by bhaskar for securities data check
					if(rs!=null)
					{
						rs.close();
					}
					rs=DBUtils.executeLAPSQuery("SEL_COUNTAPPLI^"+strAppno);
					if(rs.next())
					{
						strDataSecFlag="Y";
					}
					else
					{
						strDataSecFlag="N";
					}
					hshRecord.put("strDataSecFlag", strDataSecFlag);
					//END
					
					 if(rs!=null) rs.close();
		    		  rs=DBUtils.executeLAPSQuery("selcheckgurjointaccount^"+strAppno);
		    		  while(rs.next())
		    		  {
		    			strDemoType=strDemoType+Helper.correctNull((String)rs.getString("demo_type"))+"@"; 
		    		  }		    		  
		    		  if(!strDemoType.equalsIgnoreCase("") && strDemoType.contains("@"))
		    		  {
		    			  strDemoType=strDemoType.substring(0, strDemoType.length()-1);
		    		  }
		    		  
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
					{
					rs1=DBUtils.executeLAPSQuery("getselprdcode^"+strAppno);
					if(rs1.next())
					{
						strProductCode=Helper.correctNull((String)rs1.getString("app_prdcode"));
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					
					strRatType="0";
					
					//added by bhaskar for new rating
					rs1=DBUtils.executeLAPSQuery("setproductssel^"+strProductCode);
					if(rs1.next())
					{				
					  strBankSchemeCode=Helper.correctNull((String)rs1.getString("prd_bankscheme"));	
					}
					rs1 = DBUtils.executeLAPSQuery("getcomappid^" + strAppno);
					if(rs1.next())
					{
						strComappId=Helper.correctNull((String)rs1.getString("demo_appid"));
					}
					log.info("=======strProductCode==========="+strProductCode);
					log.info("=======strBankSchemeCode===Retail===="+strBankSchemeCode);
					log.info("=======strComappId==========="+strComappId);
					}
					else if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
					
						//aDDED BY BHASKAR TO SELECT  FACILITY
						rs1 = DBUtils.executeLAPSQuery("sel_facilitycodedesc_groupby^"+strAppno);
						if(rs1.next())
						{
							strFacSno=correctNull((String)rs1.getString("facility_sno"));
						}
						rs1=DBUtils.executeLAPSQuery("sel_facbankschem_code^"+strAppno+"^"+strFacSno);
						if(rs1.next())
						{
							strBankSchemeCode=Helper.correctNull((String)rs1.getString("COM_BANKSCHEME"));
						}
						if(rs1!=null)
						{
							rs1.close();
						}
						rs1=DBUtils.executeLAPSQuery("com_demographics_cma_sel^"+strAppno);
						if(rs1.next())
						{
							strComappId=Helper.correctNull((String)rs1.getString("DEMO_COMAPPNEWID"));
						}					
						log.info("=======strFacSno==========="+strFacSno);
						log.info("=======strBankSchemeCode======Corp/Agri===="+strBankSchemeCode);
						log.info("=======strComappId==========="+strComappId);
					}
					if(rs1!=null)
					{
						rs1.close();
					}					
					
					   //Added by bhaskar for first check for agri and corporate for polol check
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
					     double dbOtherParamLimitNFPool=0.00,dbOtherParamLimitFPool=0.00,dbNonFundExposureAmount=0.00,dbFundExposureAmount=0.00;
					     rs1=DBUtils.executeLAPSQuery("selotherparam_ratexpos^"+"8");
					     if(rs1.next())
						 {
					    	 dbOtherParamLimitNFPool=Double.parseDouble(Helper.correctDouble((String)rs1.getString("LOAN_PARAMVAL")));
						 }
					     if(rs1!=null)
							{rs1.close();}
					     rs1=DBUtils.executeLAPSQuery("selotherparam_ratexpos^"+"7");
					     if(rs1.next())
						 {
					    	 dbOtherParamLimitFPool=Double.parseDouble(Helper.correctDouble((String)rs1.getString("LOAN_PARAMVAL")));
						 }
						//added for borrower exposure calculation
						if(rs1!=null)
						{
							rs1.close();
						}
						rs1=DBUtils.executeLAPSQuery("sel_borrwoer_totalexposure^"+strAppno+"^"+strComappId);
						if(rs1.next())
						{
							dbNonFundExposureAmount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("app_total_nfexposure")));
							dbFundExposureAmount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("app_totalexposure")));
						}
						
						if((dbNonFundExposureAmount>=dbOtherParamLimitNFPool)||(dbFundExposureAmount>=dbOtherParamLimitFPool))
						{
							strFinalFlag="N";
							strExposurCheckFlag="N";
							
						}
						else
						{
							strFinalFlag="Y";
							strExposurCheckFlag="Y";
						}						
						if(strExposurCheckFlag.equalsIgnoreCase("Y"))
				    	{					    	
				    		
				    		rs1=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strFacSno);						    		
							if(rs1.next())
							{
								strActivityCode=Helper.correctInt((String)rs1.getString("app_activitycode"));
							}
							if(rs1!=null)
							{
								rs1.close();
							}
							String strActivity="and act_activitycode='"+strActivityCode+"'";
							log.info("=================="+strActivityCode);
						    strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
							rs1=DBUtils.executeQuery(strQuery);		
							if(rs1.next())
							{
								strBusRuleID=Helper.correctInt((String)rs1.getString("act_busruleid"));									
							}
				    		
				    	}
						log.info("=======dbOtherParamLimit Non Fund based Exposure==========="+dbOtherParamLimitNFPool);
						log.info("=======dbNonFundExposureAmount======Corp/Agri===="+dbNonFundExposureAmount);
						log.info("=======dbOtherParamLimit Fund based Exposure==========="+dbOtherParamLimitFPool);
						log.info("=======dbFundExposureAmount======Corp/Agri===="+dbFundExposureAmount);
						log.info("=======strFacSno==========="+strFacSno);
						log.info("=======strBusRuleID======"+strBusRuleID);
						log.info("=======Final======"+strFinalFlag);
						log.info("=======Exposure======"+strExposurCheckFlag);
						
					} 					
					//Added by bhaskar for mis details flag 
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
					{
					rs1 = DBUtils.executeLAPSQuery("sel_prdtbusruleid^"+strProductCode);
					if(rs1.next())
					{
						strBusRuleID=Helper.correctInt((String)rs1.getString("buss_ruleid"));
						strFinalFlag="Y";
						log.info("=======strBusRuleID==========="+strBusRuleID);
					}
					
					}
					else if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
					  if(strExposurCheckFlag.equalsIgnoreCase("N"))
					  {
						  rs1 = DBUtils.executeLAPSQuery("selmisschemflagdetails^"+"1"+"^"+strBankSchemeCode);
							if(rs1.next())
							{
								strSchematic=Helper.correctNull((String)rs1.getString("MIS_SCHEMATIC"));				
							}
							
							if(strSchematic.equalsIgnoreCase("y"))
							{
								strEligSchemFlag="Y";
								strFinalFlag="Y";
								
							}
							else
							{
								strEligSchemFlag="N";
								strFinalFlag="N";
							}
					  }
					  	log.info("=======strSchematic=========="+strEligSchemFlag);
					  	log.info("=======Final=========="+strFinalFlag);
						
					}
					//To check other conditions if not schematic
					if(strEligSchemFlag.equalsIgnoreCase("N"))
					{
					 if(rs1!=null)
					 {
						 rs1.close();
					 }
					 rs1=DBUtils.executeLAPSQuery("selindinfoflag^"+strComappId);
					 if(rs1.next())
					 {
						
						 if(Helper.correctNull((String)rs1.getString("INDINFO_IS_STAFF")).equalsIgnoreCase("02"))
						 {
							 strFinalFlag="Y"; 
							 strStaffFlag="Y";
						 }
						 else
						 {
							 strFinalFlag="N"; 
							 strStaffFlag="N"; 
						 }
									 
					 }
					 log.info("=======Staff=========="+strStaffFlag);
					 log.info("=======Final=========="+strFinalFlag);
					 
					 //Added by bhaskar for retail  staff loan changes
//					 if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
//					 {						 
//						 if(strStaffFlag.equalsIgnoreCase("Y"))
//						 {
//							 rs1=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+"1");
//							 if(rs1.next())
//							 {
//								 strActivityCode=Helper.correctInt((String)rs1.getString("app_activitycode"));
//							 }
//							 if(rs1!=null)
//								{
//									rs1.close();
//								}
//								String strActivity="and act_activitycode='"+strActivityCode+"'";
//							    strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
//								rs1=DBUtils.executeQuery(strQuery);		
//								if(rs1.next())
//								{
//									strBusRuleID=Helper.correctInt((String)rs1.getString("act_busruleid"));									
//								}
//							 							 
//						 }
//						 log.info("=======strActivityCode===Ret======="+strActivityCode);
//						 log.info("=======strBusRuleID=====Ret====="+strBusRuleID);
//					 }
					 //end
					 
					 //Changed as per banker for agri and corporate
					 if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					    {
					    	if(strStaffFlag.equalsIgnoreCase("N"))
					    	{
					    		if(rs!=null)
								{
									rs.close();
								}
					    		String strFinanreq="";
					    		strQuery = SQLParser.getSqlQuery("sel_facilityrequired^"+strAppno);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strFinanreq=Helper.correctNull(rs.getString("app_facilityrequired"));
								}
								if(strFinanreq.equalsIgnoreCase("Y"))
								{
									strFinalFlag="N";
									strRatType="1";
								}
								else
								{
									strFinalFlag="Y";
									strRatType="0";
								}
								if(rs!=null)
								{
									rs.close();
								}
								log.info("=======strFinanreq===Agri======="+strFinanreq);
								log.info("=======Final=====Agri====="+strFinalFlag);
					    	
					    	}
					    	if(strFinalFlag.equalsIgnoreCase("Y"))
					    	{					    	
					    		
					    		rs1=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strFacSno);						    		
								if(rs1.next())
								{
									strActivityCode=Helper.correctInt((String)rs1.getString("app_activitycode"));
								}
								if(rs1!=null)
								{
									rs1.close();
								}
								String strActivity="and act_activitycode='"+strActivityCode+"'";
							    strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
								rs1=DBUtils.executeQuery(strQuery);		
								if(rs1.next())
								{
									strBusRuleID=Helper.correctInt((String)rs1.getString("act_busruleid"));									
								}
					    		
					    	}
					    	log.info("=======strActivityCode===Agri======="+strActivityCode);
							log.info("=======strBusRuleID=====Agri====="+strBusRuleID);
					    }
					   else
					   {	   
						   
							 if(rs1!=null)
								{
									rs1.close();
								}
							    if(strStaffFlag.equalsIgnoreCase("N"))
							    {
							    	if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP"))
							    	{
							    		rs1=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strFacSno);
							    	}
								
								if(rs1.next())
								{
									strActivityCode=Helper.correctInt((String)rs1.getString("app_activitycode"));
								}
								if(!strActivityCode.equalsIgnoreCase(""))
								{
									
									String strActivity="and act_activitycode='"+strActivityCode+"'";
								    strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
									rs1=DBUtils.executeQuery(strQuery);							
									if(rs1.next())
									{					
										if(Helper.correctNull((String)rs1.getString("act_schematicflag")).equalsIgnoreCase("S"))
										{
											strActiveFlag="Y";
											strFinalFlag="Y";
											strRatType="0";
										}
										else
										{
											strActiveFlag="N";
											strFinalFlag="N";
											strRatType="1";
										}
									}
									log.info("=======Active========="+strActiveFlag);
									log.info("=======Final=========="+strFinalFlag);
								}
							    }
						   
					   }
												
					}					
					
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
					 if(strFinalFlag.equalsIgnoreCase("N"))
					 {
					if(rs1!=null)
					{
						rs1.close();
					}
					double dbOtherParamExposureLimit=0.00;						
					rs1=DBUtils.executeLAPSQuery("selotherparam_ratexpos^"+"7");
					if(rs1.next())
					{
						dbOtherParamExposureLimit=Double.parseDouble(Helper.correctDouble((String)rs1.getString("LOAN_PARAMVAL")));
					}
					//added for borrower exposure calculation
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("sel_borrwoer_totalexposure^"+strAppno+"^"+strComappId);
					if(rs1.next())
					{
						dbExposureAmount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("app_totalexposure")));
						
					}
					if(rs1!=null)
					{
						rs1.close();
					}			
					if(dbExposureAmount<dbOtherParamExposureLimit)
					{
						strRatType="0";
					}
					else
					{
						strRatType="1";							
					}
					log.info("=======dbExposureAmount========="+dbExposureAmount);
					log.info("=======dbOtherParamExposureLimit=========="+dbOtherParamExposureLimit);
					log.info("=======strRatType========="+strRatType);
					
				}
					 
					 
					}
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR")||Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP"))
					{
						if(rs1!=null)
						{rs1.close();}
							rs1 = DBUtils.executeLAPSQuery("selfac_cashmargin^"+strAppno);
							while(rs1.next())
							{
								if(Helper.correctNull(rs1.getString("com_cashmargin")).equalsIgnoreCase("Y"))
								{
									strFinalFlag="Y";
									strRatType="0";
								}
							}
							strQuery = SQLParser.getSqlQuery("chk_cgssdfacchkval^"+strAppno);
							if(rs1 != null)
								rs1.close();
							rs1 = DBUtils.executeQuery(strQuery);
							while(rs1.next())
							{
								if(Helper.correctNull(rs1.getString("com_bankscheme")).equalsIgnoreCase("065"))
								{
									strFinalFlag="Y";
									strRatType="0";
								}
							}
							if(strFinalFlag.equalsIgnoreCase("Y"))
					    	{					    	
					    		
					    		rs1=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strFacSno);						    		
								if(rs1.next())
								{
									strActivityCode=Helper.correctInt((String)rs1.getString("app_activitycode"));
								}
								if(rs1!=null)
								{
									rs1.close();
								}
								String strActivity="and act_activitycode='"+strActivityCode+"'";
							    strQuery=SQLParser.getSqlQuery("sel_Activity^"+strActivity);
								rs1=DBUtils.executeQuery(strQuery);		
								if(rs1.next())
								{
									strBusRuleID=Helper.correctInt((String)rs1.getString("act_busruleid"));									
								}
					    		
					    	}
					}
					 //hard coded//
					 // strFinalFlag="N";
					 //ENDED			
					if(rs1!=null)
					{
						rs1.close();
					}
					
					//By Guhan - To define the ratingtype flag based on the finalflag
					if(strFinalFlag.equalsIgnoreCase("Y"))
					{
						strRatType = "0"; 
					}
					else if(strFinalFlag.equalsIgnoreCase("N"))
					{
						strRatType = "1";
					}
					
					if(strFinalFlag.equalsIgnoreCase("Y"))
					{
						if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
						{
							if(strExposurCheckFlag.equalsIgnoreCase("Y"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusRuleID);								
							}
							else if(strEligSchemFlag.equalsIgnoreCase("N") && strStaffFlag.equalsIgnoreCase("N"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusRuleID);
							}
							else if(strEligSchemFlag.equalsIgnoreCase("Y"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2^"+ strBankSchemeCode);
							}
							else if(strEligSchemFlag.equalsIgnoreCase("N") && strStaffFlag.equalsIgnoreCase("Y"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusRuleID);
							}
						}
						else if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
						{
							 strQuery=SQLParser.getSqlQuery("selriskparamrule2New^"+strBusRuleID);
							 rs1=DBUtils.executeQuery(strQuery);	
							
						}
						else
						{
							if(strExposurCheckFlag.equalsIgnoreCase("Y"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusRuleID);
							}
							else if(strEligSchemFlag.equalsIgnoreCase("N") && strStaffFlag.equalsIgnoreCase("N"))
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusRuleID);
							}
							else
							{
								rs1 = DBUtils.executeLAPSQuery("selriskparamrule2^" + strBankSchemeCode);
							}
					      
						}
					if(rs1.next())
					{
					strLapsParams=Helper.correctNull((String)rs1.getString("rsk_rule_params"));	
					strModelCode=Helper.correctNull((String)rs1.getString("rsk_rule_ratcode"));	
					hshRecord.put("RSK_RULE_ID",Helper.correctNull((String)rs1.getString("RSK_RULE_ID")));
					for(int i=0;i<strLapsParams.length();i++)
					{
						if(strLapsParams.substring(i,i+1).equalsIgnoreCase("1"))
						{
							int j=i+1;
							strParaSeq=strParaSeq+j+",";
												
						}
										
					}
					log.info("=======strParaSeq========="+strParaSeq);
					}
					
					if(Helper.correctNull((String)hshRequestValues.get("strappstatus")).equalsIgnoreCase("pa")|Helper.correctNull((String)hshRequestValues.get("strappstatus")).equalsIgnoreCase("ca"))
					{
						boolean bflag=true;
						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("checkriskdatatemp^"+strAppno);
						while(rs1.next())
						{
							if(bflag)
								strParaSeq="";
							bflag=false;
							
							strParaSeq=strParaSeq+Helper.correctNull(rs1.getString("rat_seqno"))+",";
						}
						
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
			    	{
						  rs=DBUtils.executeLAPSQuery("selallriskparameters^"+strAppno+"^a");
				    	  if(rs.next())
			    		  {
			    			  strEmpl=Helper.correctNull((String)rs.getString("perapp_employment"));
			    			  strLoanReqAmnt=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_amtreqd")));
			    			  strInterest=Helper.correctNull((String)rs.getString("LOAN_MODINTRATE"));
			    			  strBakWith=Helper.correctNull((String)rs.getString("MONTHS"));
			    			  strEmi=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_emi")));
			    			  strReapTerms=Helper.correctNull((String)rs.getString("loan_reqterms"));
			    			  strSex=Helper.correctNull((String)rs.getString("perapp_sex"));
			    			  strMarg=Double.parseDouble(Helper.correctDouble((String)rs.getString("loan_margin")));
			    			  strPin=Helper.correctNull((String)rs.getString("con_comzip"));
			    			  strConstution=Helper.correctNull((String)rs.getString("perapp_constitution"));			    			
			    			  strmarSta=Helper.correctNull((String)rs.getString("perapp_marstat"));
			    			  strSchemeCode=Helper.correctNull((String)rs.getString("scheme_code"));
			    			  repayType=Helper.correctNull((String)rs.getString("LOAN_REPAYMENTTYPE"));					    			
			    			  dbLoanReComAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("LOAN_RECMDAMT")));
			    			  strChild=Helper.correctInt((String)rs.getString("indinfo_dependents_child"));
		    				  strOther=Helper.correctInt((String)rs.getString("indinfo_dependents_others"));
		    				  strDob=Helper.correctNull((String)rs.getString("perapp_dob"));
			    		  }
				    	  
				    	  if(rs!=null) rs.close();
				    	  rs=DBUtils.executeLAPSQuery("appraisalprint1^"+strAppno);
				    	  if(rs.next())
				    	  {
				    		  strVehType=Helper.correctNull((String)rs.getString("AUTO_VEHICLETYPE"));
				    	  }
				    	  
				    	  if(rs!=null) rs.close();
				    	  rs=DBUtils.executeLAPSQuery("sel_edutype^"+strAppno);
				    	  if(rs.next())
				    	  {
				    		  strStudiesIn=Helper.correctNull((String)rs.getString("edu_studies_in"));
				    	  }
			    	}
					else if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
						rs=DBUtils.executeLAPSQuery("selallriskparametersCorp^"+strAppno+"^"+strFacSno);
			    		  if(rs.next())
			    		  {
			    			  intHolidayPeriod = Integer.parseInt(Helper.correctInt((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
			    			  strEmpl=Helper.correctNull((String)rs.getString("perapp_employment"));
			    			  strLoanReqAmnt=Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_sancamt")));
			    			  strInterest=Helper.correctDouble((String)rs.getString("facility_sancinterest"));
			    			  strBakWith=Helper.correctNull((String)rs.getString("MONTHS"));
			    			  strEmi=Double.parseDouble(Helper.correctDouble("0"));
			    			  strReapTerms=Helper.correctInt((String)rs.getString("FACILITY_MONTHS"));
			    			  strSex=Helper.correctNull((String)rs.getString("perapp_sex"));
			    			  strMarg=Double.parseDouble(Helper.correctDouble("0"));
			    			  strPin=Helper.correctNull((String)rs.getString("con_comzip"));
			    			  strConstution=Helper.correctNull((String)rs.getString("perapp_constitution"));			    			 
			    			  strmarSta=Helper.correctNull((String)rs.getString("perapp_marstat"));
			    			  strRepayType=Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE"));
			    		  }
			    		  strVehType = "3";
					}
					String strSeqNo = "",strCollAvail="N";
					boolean strIndividual=false;
					
					if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
		    		{
						strIndividual=true;
		    		}
					if(!strParaSeq.equalsIgnoreCase("") && strParaSeq.contains(","))
					{
						strParaSeq=strParaSeq.substring(0,strParaSeq.length()-1);			
					
					   // rs1 = DBUtils.executeLAPSQuery("sel_riskparam_Setup^" + strParaSeq);
						strQuery = SQLParser.getSqlQuery("sel_riskparam_Setup^"+strParaSeq);
						rs1 = DBUtils.executeQuery(strQuery);
					    
					    while(rs1.next())
					    {
					    	arrCol=new ArrayList();
					    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_seqno")));//0
					    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_paramvalue")));//1
					    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_columnflag")));//2
					    	strSeqNo=Helper.correctNull((String)rs1.getString("RSK_PARAMCODE"));
					    	//added by bhaskar for rating parameters
					    	if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
					    	{
					    	if(Helper.correctNull((String)rs1.getString("RSK_PARAFOR")).equalsIgnoreCase("R") || Helper.correctNull((String)rs1.getString("RSK_PARAFOR")).equalsIgnoreCase("C"))
					    	{
					    	if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("C"))
					    	{
					    	  if(strSeqNo.trim().equalsIgnoreCase("RE01_Applicants_Age") || strSeqNo.trim().equalsIgnoreCase("DEPENDAN-01"))
					    	  {					    		  
					    			  if(strIndividual && strSeqNo.trim().equalsIgnoreCase("RE01_Applicants_Age"))
					    			  {
					    			  String s1=strDob.substring(6, 10);
					    			  String s2=strSysDate.substring(6, 10);
					    			  int doby=Integer.parseInt(s1);
					    			  int cury=Integer.parseInt(s2);
					    			  //String agYear=String.valueOf((cury-doby));
					    			  int agYear=cury-doby;
					    			  String s3=strDob.substring(3,5);
					    			  String s4=strSysDate.substring(3,5);
					    			  int dobm=Integer.parseInt(s3);
					    			  int curm=Integer.parseInt(s4);
					    			  String s5=strDob.substring(0,2);
					    			  String s6=strSysDate.substring(0,2);
					    			  int dobd=Integer.parseInt(s5);
					    			  int curd=Integer.parseInt(s6);
					    			  
					    			  if(curm<dobm)
					    			  {
					    				  agYear=agYear-1; 
					    			  }
					    			  else if(curm==dobm)
					    			  {
					    				  if(curd<dobd)
					    				  {
					    					  agYear=agYear-1;  
					    				  }
					    			  }
					    			   			  
					    			  arrCol.add(String.valueOf(agYear));//5
					    			 }			    			  
					    			  else if(strSeqNo.trim().equalsIgnoreCase("DEPENDAN-01"))
					    			  {	    				  
					    				  int strTotal=Integer.parseInt(strChild)+Integer.parseInt(strOther);
					    				  arrCol.add(String.valueOf(strTotal));//5    				  
					    			  }

					    	  }
					    			 
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE12_Availability_of_Guarantor") || strSeqNo.trim().equalsIgnoreCase("JOINTACC-01") 
					    			  || strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01") || strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account")
					    		  || strSeqNo.trim().equalsIgnoreCase("RE83_Availability_of_Guarantor"))
					    	  {
					    		  
					    			  if(strSeqNo.trim().equalsIgnoreCase("RE12_Availability_of_Guarantor") || strSeqNo.trim().equalsIgnoreCase("RE83_Availability_of_Guarantor"))
					    			  {
					    				  if(strDemoType.contains("g"))
					    				  {
					    					 // arrCol.add("Y");//5
					    					  arrCol.add("1");//5
					    				  }
					    				  else
					    				  {
					    					 // arrCol.add("N");//5
					    					  arrCol.add("0");//5
					    				  }
					    				  
					    			  }
					    			  else if(strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account") || strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01"))
					    			  {
					    				  if(strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account"))
					    				  {
					    				  if(strDemoType.contains("c"))
					    				  {
					    					 // arrCol.add("Y");//5
					    					  arrCol.add("1");//5
					    				  }
					    				  else
					    				  {
					    					 // arrCol.add("N");//5
					    					  arrCol.add("0");//5
					    					  
					    				  }	 
					    				  }
					    				  else if(strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01"))
					    				  {
					    					  if(strDemoType.contains("c"))
						    				  {
						    					  arrCol.add("1");//5
						    				  }
						    				  else
						    				  {
						    					  arrCol.add("0");//5
						    				  }	 	    					  
					    					  
					    				  }
					    				  
					    			  }			    			  
					    			  
					    		  		  
					    		  
					    	  }
					    	  else if(strIndividual && (strSeqNo.trim().equalsIgnoreCase("RE25_Occupation_Grps_Individual") || strSeqNo.trim().equalsIgnoreCase("RE58_Occupation_Groups")))
					    	  {					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+strComappId);
					    		  if(rs.next())
					    		  {
					    			  
					    			  arrCol.add(Helper.correctNull((String)rs.getString("kyc_occupationcode")));//5
					    			  //Helper.correctNull((String)rs.getString("occupationcodedesc"));
					    			  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("");//5
					    		  }			    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("BRANCHSE-01"))
					    	  {
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selorgnameforapp^"+strAppno);
					    		  if(rs.next())
					    		  {
					    			
					    			  arrCol.add(Helper.correctNull((String)rs.getString("org_scode")));//5
					    			 // Helper.correctNull((String)rs.getString("org_name")));
					    			  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("");//5
					    		  }			    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE60_AnnualIncome"))
					    	  {
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("pergetIncome1^"+strComappId);
					    		  if(rs.next())
					    		  {
					    			  if(strEmpl.equalsIgnoreCase("1") || strEmpl.equalsIgnoreCase("9"))  
						    		  {
					    				  arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_takehome")))));//5 
						    		  }
					    			  else
					    			  {
					    				arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_year1_income")))));//5 
					    				  
					    			  }			    			  
					    			  
					    		  }
					    		  else
					    		  {
					    			 
					    			  arrCol.add("0");//5
					    			  
					    		  }
					    		
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE88_Location_of_study"))
					    	  {			    
					    		 if(strStudiesIn.equalsIgnoreCase("I"))
					    			 arrCol.add("India");//5
					    		 else if(strStudiesIn.equalsIgnoreCase("A"))
					    			 arrCol.add("Abroad");//5
					    		 else
					    			 arrCol.add("");//5
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE86_Whether_Margin_required_edu"))
					    	  {
					    		  if(dbLoanReComAmount > 400000)
					    		  {
					    			  arrCol.add("1");
					    			  strMarginReq="Y";
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("0");
					    			  strMarginReq = "N";
					    		  }
					    	  }
					    	  else if(strStudiesIn.equalsIgnoreCase("I") && (strSeqNo.trim().equalsIgnoreCase("RE53_Margin(India)loan_upto_10lacs")
					    			  || strSeqNo.trim().equalsIgnoreCase("RE54_Margin(India)loan_more_than_10lacs")))
					    	  {			    		  
					    			  if(strMarginReq.equalsIgnoreCase("Y") && dbLoanReComAmount <= 1000000 && strSeqNo.trim().equalsIgnoreCase("RE53_Margin(India)loan_upto_10lacs"))
					    			  {
					    				  arrCol.add(""+Helper.formatDoubleValue(strMarg));
					    			  }
					    			  else if(strMarginReq.equalsIgnoreCase("Y") && dbLoanReComAmount > 1000000 && strSeqNo.trim().equalsIgnoreCase("RE54_Margin(India)loan_more_than_10lacs"))
					    			  {
					    				  arrCol.add(""+Helper.formatDoubleValue(strMarg));
					    			  }
					    			  else if(strMarginReq.equalsIgnoreCase("N"))
					    			  {
					    				  arrCol.add("0.00");
					    			  }
					    	  }
					    	  else if(strStudiesIn.equalsIgnoreCase("A") && (strSeqNo.trim().equalsIgnoreCase("RE55_Margin(Abroad)loan_upto_20lacs")
					    			  || strSeqNo.trim().equalsIgnoreCase("RE56_Margin(Abroad)loan_more_than_20 lacs")))
					    		{
						    		  if(strMarginReq.equalsIgnoreCase("Y") && dbLoanReComAmount <= 2000000 && strSeqNo.trim().equalsIgnoreCase("RE55_Margin(Abroad)loan_upto_20lacs"))
					    			  {
					    				  arrCol.add(""+Helper.formatDoubleValue(strMarg));
					    			  }
					    			  else if(strMarginReq.equalsIgnoreCase("Y") && dbLoanReComAmount > 2000000 && strSeqNo.trim().equalsIgnoreCase("RE56_Margin(Abroad)loan_more_than_20 lacs"))
					    			  {
					    				  arrCol.add(""+Helper.formatDoubleValue(strMarg));
					    			  }
					    			  else if(strMarginReq.equalsIgnoreCase("N"))
					    			  {
					    				  arrCol.add("0.00");
					    			  }
						      }

					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE89_Loan_amount") || strSeqNo.trim().equalsIgnoreCase("RE91_Loan_amount"))
					    	  {			    		  
					    		 arrCol.add(""+Helper.formatDoubleValue(dbLoanReComAmount));//5   			    		
					    	  }
					    	  
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RATEOFIN-01"))
					    	  {			    		  
					    		  
					    		 arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strInterest))));//5   			    		
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE27_Tenure_of_Relationship_with_Bank") || 
					    			  strSeqNo.trim().equalsIgnoreCase("RE07_Relationship_with_Bank"))
					    	  {			    		  
					    		
					    		     int dbbankWith=Integer.parseInt(Helper.correctInt(strBakWith));
					    		     int dbWith=dbbankWith/12;
					    		     arrCol.add(String.valueOf(dbWith));//5  
					    	
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("EMIINRS-01"))
					    	  {			    		  
					    		  
					    		 if(repayType.equalsIgnoreCase("1"))
					    		 {
					    		 arrCol.add(""+Helper.formatDoubleValue(strEmi));//5 
					    		 }
					    		 else
					    		 {
					    			 double dbTerms=Double.parseDouble(Helper.correctDouble(strReapTerms));
					    			 double dbEmiAount=dbLoanReComAmount/dbTerms;
					    			 arrCol.add(""+Helper.formatDoubleValue(dbEmiAount));//5 					    			 
					    		 }
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE10_Tenure_of_Loan") || strSeqNo.trim().equalsIgnoreCase("RE28_Loan_Tenor"))
					    	  {
					    		  arrCol.add(strReapTerms);//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("1") && strSeqNo.trim().equalsIgnoreCase("RE29_Loan_Tenor_For_2_wheelers"))
					    	  {
					    		  arrCol.add(strReapTerms);//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("3") && strSeqNo.trim().equalsIgnoreCase("RE28_Loan_Tenor_For_4_wheelers"))
					    	  {
					    		  arrCol.add(strReapTerms);//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("1") && strSeqNo.trim().equalsIgnoreCase("RE84_Type_of_Auto_Loan"))
					    	  {
					    		  arrCol.add("Two Wheeler");//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("3") && strSeqNo.trim().equalsIgnoreCase("RE84_Type_of_Auto_Loan"))
					    	  {
					    		  arrCol.add("Four Wheeler");//5   
					    	  }
					    	  else if(dbLoanReComAmount <= 750000 && strSeqNo.trim().equalsIgnoreCase("RE43_Loan_Tenor_yrs_For_upto_7.5_lacs"))
					    	  {
					    		  arrCol.add(nf.format(Double.parseDouble(strReapTerms)/12));//5   
					    	  }
					    	  else if(dbLoanReComAmount > 750000 && strSeqNo.trim().equalsIgnoreCase("RE44_Loan_Tenor_yrs_For_more_than_7.5lacs"))
					    	  {
					    		  arrCol.add(nf.format(Double.parseDouble(strReapTerms)/12));//5   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("GENDER-01"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
					    		  if(strSex.equalsIgnoreCase("M"))
					    		  {
					    			  arrCol.add("Male");//5  
					    		  }
					    		  else if(strSex.equalsIgnoreCase("F"))
					    		  {
					    			  arrCol.add("Female");//5  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("Others");//5  
					    		  }
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("NA");//5    
					    		  }
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("MARGIN-01"))
					    	  {
					             
					    		  arrCol.add(""+Helper.formatDoubleValue(strMarg));//5  
					    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("MARGINY/-01"))
					    	  {
					             
					    		  if(strMarg!=0.00 || strMarg!=0)
					    		  {
					    			  
					    			 // arrCol.add("Y");//5 
					    			  arrCol.add("1");//5 
					    		  }
					    		  else
					    		  {
					    			 // arrCol.add("N");//5  
					    			  arrCol.add("0");//5 
					    		  }
					    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("PINCODE-01"))
					    	  {	             		
					    		  
					    		 arrCol.add(strPin);//5    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE81_Type_of_Loan"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
					    			  //arrCol.add("Yes");//5
					    			  arrCol.add("Individual");
					    		  }
					    		  else
					    		  {
					    			  //arrCol.add("No");//5  
					    			  arrCol.add("Nonindividual");
					    		  }
					    		  
					    	  }			    	 
					    	  else if((!strIndividual && strSeqNo.equalsIgnoreCase("RE26_Constitution_of_company_non-indi")) || strSeqNo.trim().equalsIgnoreCase("RE67_Business_Constitution_Type"))
					    	  {
					    			  arrCol.add(strConstution);
					    	  }			    	 
					    	  else if(strIndividual && strSeqNo.trim().equalsIgnoreCase("RE21_Marital_Status_Individual"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
						    		  if(rs!=null) rs.close();
						    		  rs=DBUtils.executeLAPSQuery("selcbsiddatadesc^"+"3"+"^"+strmarSta);
						    		  if(rs.next())
						    		  {
						    			  arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_desc")));//5  
						    		  }
						    		  else
						    		  {
						    			  arrCol.add("0");//5   
						    		  }			    		  
					    		  }
//					    		  else
//					    		  {
//					    			  arrCol.add("NA");//5  
//					    		  }
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("SECURITY-05"))
					    	  {
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  if(rs.next())
					    		  {
					    			  strPrimeFlag="Y"; 
					    		  }
					    		  else
					    		  {
					    			  strPrimeFlag="N"; 
					    		  }
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"2");
					    		  if(rs.next())
					    		  {
					    			  strCollFlag="Y"; 
					    		  }
					    		  else
					    		  {
					    			  strCollFlag="N"; 
					    		  }
					    		  if(strPrimeFlag.equalsIgnoreCase("Y") && strCollFlag.equalsIgnoreCase("N"))
					    		  {
					    			  arrCol.add("Prime");
					    		  }
					    		  else if(strPrimeFlag.equalsIgnoreCase("N") && strCollFlag.equalsIgnoreCase("Y"))
					    		  {
					    			  arrCol.add("Collateral");  
					    		  }
					    		  else if(strPrimeFlag.equalsIgnoreCase("Y") && strCollFlag.equalsIgnoreCase("Y"))
					    		  {
					    			  arrCol.add("Prime/Collateral");
					    		  }
					    		  else
					    		  {
					    		     arrCol.add("");
					    		  }
					    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("COLLATER-01"))
					    	  {
					    		 
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"2");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  arrCol.add(""+Helper.formatDoubleValue(dbPrimarySecAmount));			    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE30_LTV_(Both)"))
					    	  {
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  if(dbLoanReComAmount!=0.00 && dbPrimarySecAmount!=0.00)
					    		  {					    		
					    		  dbloanValuePer=(dbLoanReComAmount/dbPrimarySecAmount)*100; 
					    		  arrCol.add(""+Helper.formatDoubleValue(dbloanValuePer));	
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("0.00");  
					    		  }					    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE42_Collateral_coverage_Ratio"))
					    	  {
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"2");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  if(dbLoanReComAmount!=0.00 && dbPrimarySecAmount!=0.00)
					    		  {					    		
					    			  dbloanValuePer=(dbPrimarySecAmount/dbLoanReComAmount)*100; 
					    			  arrCol.add(""+Helper.formatDoubleValue(dbloanValuePer));	
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("0.00");  
					    		  }					    		  
					    		  
					    	  }
					    	  else if(strSeqNo.equalsIgnoreCase("EXISTING-01"))
						    	{
						    		
						    		arrCol.add("");//3
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Nature of Current Ratio_LCM"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Type of Loan_LCM_V2.0"))
						    	{
						    		    arrCol.add("");//3	
						    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("INDUSTRY-01"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("NBFC_INDU"))
						    	{
						    		  arrCol.add("NBFC");
						    	}
					    	  
					    // New parameters added for pool based rating by Guhan T on 30112015
						    	else if(strIndividual && strSeqNo.equalsIgnoreCase("RE22_Monthly_Income_Per_Dependnt"))
						    	{
						    		double dblincome=0,dblDependCount=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_perdependent_monthlyInc_ret^"+strAppno+"^"+strAppno);
						    		while(rs.next())
						    		{
						    			dblincome=dblincome+Double.parseDouble(Helper.correctDouble(rs.getString("tot_inc")));
						    			dblDependCount=dblDependCount+Double.parseDouble(Helper.correctDouble(rs.getString("dep_count")));
						    		}
					    			arrCol.add(""+nf.format((dblincome/dblDependCount)/12));
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE08_Yearly_Income_per_(dependent)"))
						    	{
						    		double dblincome=0,dblDependCount=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_perdependent_monthlyInc_ret^"+strAppno+"^"+strAppno);
						    		while(rs.next())
						    		{
						    			dblincome=dblincome+Double.parseDouble(Helper.correctDouble(rs.getString("tot_inc")));
						    			dblDependCount=dblDependCount+Double.parseDouble(Helper.correctDouble(rs.getString("dep_count")));
						    		}
						    		arrCol.add(""+nf.format(dblincome/dblDependCount));
						    	}

						    	else if(strSeqNo.equalsIgnoreCase("RE24_Guarantor_Net_worth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_guarantor_networth_ret^g^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    			arrCol.add(""+nf.format((dblnetworth/dbLoanReComAmount)));
						    		}	
						    		else
						    		{
//						    			arrCol.add("No Guarantor");
						    			arrCol.add("0");
						    		}
						    	}
					    	  
						    	else if(strSeqNo.equalsIgnoreCase("RE33_Borrower_Net_worth/Loan_Amount")
						    			|| strSeqNo.equalsIgnoreCase("RE09_Borrower_Net_Worth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_guarantor_networth_ret^a^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    		}	
						    		arrCol.add(""+nf.format((dblnetworth/dbLoanReComAmount)));
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE48_Co-borrower_Networth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_guarantor_networth_ret^c^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    		}	
						    		arrCol.add(""+nf.format((dblnetworth/dbLoanReComAmount)));
						    	}
					   
						    	else if(strSeqNo.equalsIgnoreCase("RE80_Counterparty_with_Credit History"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_CIBIL_score_ret^"+strAppno);
						    		if(rs.next())
						    		{
						    			strCIBILavail=Helper.correctNull(rs.getString("CIBIL_RAT_STATUS"));
						    			strCIBILscore=Helper.correctInt(rs.getString("CIBIL_SCORE"));
						    		}
						    		if(strCIBILavail.equalsIgnoreCase("Y"))
						    			arrCol.add("1");
						    		else
						    			arrCol.add("0");
						    	}
					    	  
						    	else if(strCIBILavail.equalsIgnoreCase("Y") && (strSeqNo.equalsIgnoreCase("RE34_CIBIL_Score") || strSeqNo.contains("RE05_CIBIL_Transunion_Score")))
						    	{
						    		arrCol.add(strCIBILscore);
						    	}
					    	  	
						    	else if(strSeqNo.equalsIgnoreCase("RE39_Yrs_ in_current_employment/Business"))
						    	{
						    		if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
						    		{
							    		if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_rat_experience_ret^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("PEREMP_EXPINYRS")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    		else
						    		{
						    			if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_expinbusiness_retail^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("businessyrs")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE02_Othr_Sources_of_Income"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_experience_ret^"+strAppno);
						    		if(rs.next())
						    		{
						    			if(Double.parseDouble(Helper.correctDouble(rs.getString("PERINC_OTHERINCOME")))>0)
						    			{
						    				arrCol.add("1");
						    			}
						    			else
						    			{
						    				arrCol.add("0");
						    			}
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE03_Land_Holding_in_Hectares"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_land_holding_hectare^"+strAppno);
						    		if(rs.next())
						    		{
						    			arrCol.add(Helper.correctNull(rs.getString("land_hectare")));
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE82_Existing _Loan_ Account_ with_ Bank"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_banking^"+strAppno);
						    		if(rs.next())
						    		{
						    			arrCol.add("1");
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}//doubt
						    	else if(strSeqNo.equalsIgnoreCase("RE87_collateral_required"))
						    	{
//						    		if(rs!=null) rs.close();
//						    		rs=DBUtils.executeLAPSQuery("^"+strAppno);
//						    		if(rs.next())
//						    		{
//						    			arrCol.add("Yes");
//						    			strCollAvail = "Y";
//						    		}
//						    		else
//						    		{
//						    			arrCol.add("No");
//						    		}
						    		arrCol.add("0");
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE13_Assets_Coverage_Ratio"))
						    	{
						    		if(strCollAvail.equalsIgnoreCase("N"))
						    		{
							    		if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_collateral_coverage^"+strAppno+"^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("sec_coverage")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    		else
						    		{
						    			arrCol.add("Not applicable (collateral not required)");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE49_Length_of_Relationship_of_Co-borrower_Bank"))
						    	{
						    	  if(rs!=null) rs.close();
						    	  rs=DBUtils.executeLAPSQuery("selallriskparameters^"+strAppno+"^c");
						    	  if(rs.next())
					    		  {
						    		  arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("MONTHS")))/12));
					    		  }
						    	  else
						    	  {
						    		  arrCol.add("0");
						    	  }
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE47_Academic_Track_record"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("eduparticularssel^"+strAppno);
						    		if(rs.next())
						    		{
						    			arrCol.add(Helper.correctInt((String)rs.getString("EDU_QUALIFYINGEXA")));
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}
					    	  
					    	  	
					    	  
					   // New parameters end by Guhan T
//						    	else
//						    	{
//						    		arrCol.add("");//3	
//						    	}
					    		
					    	}
					    	else if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("E"))
					    	{
					    		if(strSeqNo.equalsIgnoreCase("RE36_FOIR_individual") || strSeqNo.equalsIgnoreCase("RE50_FOIR_co-borrower")
					    				|| strSeqNo.equalsIgnoreCase("RE90_Net_Surplus_Ratio_(non_individual)") || strSeqNo.equalsIgnoreCase("RE23_NPM_Nonindividual")
					    				|| strSeqNo.equalsIgnoreCase("RE37_DSCR") || strSeqNo.equalsIgnoreCase("RE66_Current_Ratio"))
					    		{
					    			if(strIndividual && (strSeqNo.equalsIgnoreCase("RE36_FOIR_individual") || strSeqNo.equalsIgnoreCase("RE50_FOIR_co-borrower")))
					    			{
					    				arrCol.add("");//3
					    			}
					    			else if(!strIndividual && (strSeqNo.equalsIgnoreCase("RE37_DSCR") || strSeqNo.equalsIgnoreCase("RE66_Current_Ratio") || strSeqNo.equalsIgnoreCase("RE90_Net_Surplus_Ratio_(non_individual)") || strSeqNo.equalsIgnoreCase("RE23_NPM_Nonindividual")))
					    			{
					    				arrCol.add("");//3
					    			}
					    		}
					    		else
					    		{
					    			arrCol.add("");//5
					    		}	    		
					    	}
					    	else if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("S"))
					    	{
					    	  if(strSeqNo.equalsIgnoreCase("RE51_College_Ranking_(India)") || strSeqNo.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
				    		  {
				    			if(strStudiesIn.equalsIgnoreCase("A") && strSeqNo.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
				    			{
				    				arrCol.add("");//3
				    			}
				    			else if(strStudiesIn.equalsIgnoreCase("I") && strSeqNo.equalsIgnoreCase("RE51_College_Ranking_(India)"))
				    			{
				    				arrCol.add("");//3
				    			}
				    		  }
					    	  else if(strSeqNo.equalsIgnoreCase("RE04_Literacy_Level") || strSeqNo.equalsIgnoreCase("RE65_Stability_of_Income")
					    			  || strSeqNo.equalsIgnoreCase("RE31_Stability_of_income_indiv") || strSeqNo.equalsIgnoreCase("RE40_Edu_qualification")
					    			  || strSeqNo.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual") || strSeqNo.equalsIgnoreCase("RE35_Track_Record_non-indiv"))
					    		{
					    		  if(strIndividual && (strSeqNo.equalsIgnoreCase("RE04_Literacy_Level") || strSeqNo.equalsIgnoreCase("RE65_Stability_of_Income")
						    			  || strSeqNo.equalsIgnoreCase("RE31_Stability_of_income_indiv") || strSeqNo.equalsIgnoreCase("RE40_Edu_qualification")))
					    			{
					    				arrCol.add("");//3
					    			}
					    		  else if(!strIndividual && (strSeqNo.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual") || strSeqNo.equalsIgnoreCase("RE35_Track_Record_non-indiv")))
					    			{
					    				arrCol.add("");//3
					    			}
					    		}
						    	else
						    	{
						    		arrCol.add("");//3
						    	}
					    	}
					    }
					    	
					    	//ENDE
					    	arrCol.add(Helper.correctNull((String)rs1.getString("RSK_PARAMCODE")));//4
					    	
					    	if(arrCol != null && arrCol.size()>4)
					    	{
					    		arrRow.add(arrCol);
					    	}
					    	
					    }			   
					    else if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					    {		   

					    	if(Helper.correctNull((String)rs1.getString("RSK_PARAFOR")).equalsIgnoreCase("R") || Helper.correctNull((String)rs1.getString("RSK_PARAFOR")).equalsIgnoreCase("C"))
					    	{
					    	if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("C"))
					    	{
					    	  if(strSeqNo.trim().equalsIgnoreCase("RE01_Applicants_Age") || strSeqNo.trim().equalsIgnoreCase("DEPENDAN-01"))
					    	  {
					    			  if(strRepayType.equalsIgnoreCase("E"))
					    			  {
					    				  intTerms=Integer.parseInt(strReapTerms);
					    				  dblTenor=intTerms-intHolidayPeriod;
					    				  dblModIntRate=Double.parseDouble(strInterest);
					    				  dblRate=dblModIntRate/(12*100);
					    				  dblDenomi=Math.pow(dblRate+1,(dblTenor))-1;	
					    				  dblNumeri=dblRate*Math.pow(dblRate+1,(dblTenor));
					    				  dblEMI=0.00;
					    				  if(dblNumeri!=0.0 && dblDenomi!=0.0)
					    				  {
											dblEMI=Math.ceil((dblNumeri/dblDenomi)*strLoanReqAmnt);
					    				  }
					    			  }
					    			  if(strIndividual && strSeqNo.trim().equalsIgnoreCase("RE01_Applicants_Age"))
					    			  {
					    			  strDob=Helper.correctNull((String)rs.getString("perapp_dob"));
					    			  if(strDob.length()>0)
					    			  {
					    			  String s1=strDob.substring(6, 10);
					    			  String s2=strSysDate.substring(6, 10);
					    			  int doby=Integer.parseInt(s1);
					    			  int cury=Integer.parseInt(s2);
					    			  //String agYear=String.valueOf((cury-doby));
					    			  int agYear=cury-doby;
					    			  String s3=strDob.substring(3,5);
					    			  String s4=strSysDate.substring(3,5);
					    			  int dobm=Integer.parseInt(s3);
					    			  int curm=Integer.parseInt(s4);
					    			  String s5=strDob.substring(0,2);
					    			  String s6=strSysDate.substring(0,2);
					    			  int dobd=Integer.parseInt(s5);
					    			  int curd=Integer.parseInt(s6);
					    			  
					    			  if(curm<dobm)
					    			  {
					    				  agYear=agYear-1; 
					    			  }
					    			  else if(curm==dobm)
					    			  {
					    				  if(curd<dobd)
					    				  {
					    					  agYear=agYear-1;  
					    				  }
					    			  }
					    			   			  
					    			  arrCol.add(String.valueOf(agYear));//5
					    			  }
					    			 }			    			  
					    			  else if(strSeqNo.trim().equalsIgnoreCase("DEPENDAN-01"))
					    			  {
					    				  int strTotal=Integer.parseInt(strChild)+Integer.parseInt(strOther);
					    				  arrCol.add(String.valueOf(strTotal));//5    				  
					    			  }

					    		  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE12_Availability_of_Guarantor") || strSeqNo.trim().equalsIgnoreCase("JOINTACC-01") 
					    			  || strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01") || strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account")
					    		  || strSeqNo.trim().equalsIgnoreCase("RE83_Availability_of_Guarantor"))
					    	  {
					    		  boolean boolPromoter = true;
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckgurjointaccountCorp^"+strAppno);
					    		  while(rs.next())
					    		  {
					    			  boolPromoter = false;
					    			  strDemoType=Helper.correctNull((String)rs.getString("COM_COMPDTTYPE")); 
					    			  if(strSeqNo.trim().equalsIgnoreCase("RE12_Availability_of_Guarantor") || strSeqNo.trim().equalsIgnoreCase("RE83_Availability_of_Guarantor"))
					    			  {
					    				  if(strDemoType.contains("G"))
					    				  {
					    					 // arrCol.add("Y");//5
					    					  arrCol.add("1");//5
					    				  }
					    				  else
					    				  {
					    					 // arrCol.add("N");//5
					    					  arrCol.add("0");//5
					    				  }
					    				  
					    			  }
					    			  else if(strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account") || strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01"))
					    			  {
					    				  if(strSeqNo.trim().equalsIgnoreCase("RE57_Joint_Account"))
					    				  {
					    				  if(strDemoType.contains("C"))
					    				  {
					    					 // arrCol.add("Y");//5
					    					  arrCol.add("1");//5
					    				  }
					    				  else
					    				  {
					    					 // arrCol.add("N");//5
					    					  arrCol.add("0");//5
					    					  
					    				  }	 
					    				  }
					    				  else if(strSeqNo.trim().equalsIgnoreCase("CO-APPLI-01"))
					    				  {
					    					  if(strDemoType.contains("C"))
						    				  {
						    					  arrCol.add("1");//5
						    				  }
						    				  else
						    				  {
						    					  arrCol.add("0");//5
						    				  }	 	    					  
					    					  
					    				  }
					    				  
					    			  }			    			  
					    			  
					    		  }  
					    		  if(boolPromoter)
					    		  {
					    			  arrCol.add("0");//5
					    		  }
					    	  }	
					    	  else if(strIndividual && (strSeqNo.trim().equalsIgnoreCase("RE25_Occupation_Grps_Individual") || strSeqNo.trim().equalsIgnoreCase("RE58_Occupation_Groups")))
					    	  {
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("sel_applKYCNorms^"+strComappId);
					    		  if(rs.next())
					    		  {
					    			  
					    			  arrCol.add(Helper.correctNull((String)rs.getString("kyc_occupationcode")));//5
					    			  //Helper.correctNull((String)rs.getString("occupationcodedesc"));
					    			  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("");//5
					    		  }			    		  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("BRANCHSE-01"))
					    	  {
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selorgnameforapp^"+strAppno);
					    		  if(rs.next())
					    		  {
					    			
					    			  arrCol.add(Helper.correctNull((String)rs.getString("org_scode")));//5
					    			 // Helper.correctNull((String)rs.getString("org_name")));
					    			  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("");//5
					    		  }			    		  
					    		  
					    	  }	
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE60_AnnualIncome"))
					    	  {
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("pergetIncome1^"+strComappId);
					    		  if(rs.next())
					    		  {
					    			  if(strEmpl.equalsIgnoreCase("1") || strEmpl.equalsIgnoreCase("9"))  
						    		  {
					    				  arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_takehome")))));//5 
						    		  }
					    			  else
					    			  {
					    				arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)rs.getString("perinc_year1_income")))));//5 
					    				  
					    			  }			    			  
					    			  
					    		  }
					    		  else
					    		  {
					    			 
					    			  arrCol.add("0");//5
					    			  
					    		  }		    		
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE89_Loan_amount"))
					    	  {			    		  
					    		  
					    		 arrCol.add(""+Helper.formatDoubleValue(strLoanReqAmnt));//5   			    		
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RATEOFIN-01"))
					    	  {			    		  
					    		  
					    		 arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strInterest))));//5   			    		
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE27_Tenure_of_Relationship_with_Bank") || 
					    			  strSeqNo.trim().equalsIgnoreCase("RE07_Relationship_with_Bank"))
					    	  {			    		  
					    		
					    			 //arrCol.add(strBakWith);//5  	
					    		     int dbbankWith=Integer.parseInt(Helper.correctInt(strBakWith));
					    		     int dbWith=dbbankWith/12;					    		   
					    		     arrCol.add(String.valueOf(dbWith));//5  
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("EMIINRS-01"))
					    	  {			    		  
					    		
					    		 if(strRepayType.equalsIgnoreCase("E"))
					    		 {
					    		  arrCol.add(""+Helper.formatDoubleValue(dblEMI));//5  
					    		 }
					    		 else
					    		 {
					    			 double dbreqTerms=Double.parseDouble(Helper.correctDouble(strReapTerms));
					    			 double dbEmi=strLoanReqAmnt/dbreqTerms;
					    			 arrCol.add(""+Helper.formatDoubleValue(dbEmi));//5 					    			 
					    		 }
					    		  
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE10_Tenure_of_Loan") || strSeqNo.trim().equalsIgnoreCase("RE28_Loan_Tenor"))
					    	  {
					    		  arrCol.add(strReapTerms);//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("3") && strSeqNo.trim().equalsIgnoreCase("RE28_Loan_Tenor_For_4_wheelers"))
					    	  {
					    		  arrCol.add(strReapTerms);//5   
					    	  }
					    	  else if(strVehType.equalsIgnoreCase("3") && strSeqNo.trim().equalsIgnoreCase("RE84_Type_of_Auto_Loan"))
					    	  {
					    		  arrCol.add("Four Wheeler");//5   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("GENDER-01"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
					    		  if(strSex.equalsIgnoreCase("M"))
					    		  {
					    			  arrCol.add("Male");//5  
					    		  }
					    		  else if(strSex.equalsIgnoreCase("F"))
					    		  {
					    			  arrCol.add("Female");//5  
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("Others");//5  
					    		  }
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("NA");//5 
					    		  }
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("MARGIN-01"))
					    	  {
					             
					    		  arrCol.add(""+Helper.formatDoubleValue(strMarg));//5  
					    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("MARGINY/-01"))
					    	  {
					             
					    		  if(strMarg!=0.00 || strMarg!=0)
					    		  {
					    			  
					    			 // arrCol.add("Y");//5 
					    			  arrCol.add("1");//5 
					    		  }
					    		  else
					    		  {
					    			 // arrCol.add("N");//5  
					    			  arrCol.add("0");//5 
					    		  }
					    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("PINCODE-01"))
					    	  {	             		
					    		  
					    		 arrCol.add(strPin);//5    		  
					    		   
					    	  }
					    	  else if(strSeqNo.trim().equalsIgnoreCase("RE81_Type_of_Loan"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
					    			  //arrCol.add("Yes");//5
					    			  arrCol.add("Individual");
					    		  }
					    		  else
					    		  {
					    			  //arrCol.add("No");//5  
					    			  arrCol.add("Nonindividual");
					    		  }
					    		  
					    	  }
					    	  else if(strSeqNo.equalsIgnoreCase("RE26_Constitution_of_company_non-indi") || strSeqNo.trim().equalsIgnoreCase("RE67_Business_Constitution_Type"))
					    	  {
					    			  arrCol.add(strConstution);
					    	  }
					    	  else if(strIndividual && strSeqNo.trim().equalsIgnoreCase("RE21_Marital_Status_Individual"))
					    	  {
					    		  if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
					    		  {
						    		  if(rs!=null) rs.close();
						    		  rs=DBUtils.executeLAPSQuery("selcbsiddatadesc^"+"3"+"^"+strmarSta);
						    		  if(rs.next())
						    		  {
						    			  arrCol.add(Helper.correctNull((String)rs.getString("cbs_static_data_desc")));//5  
						    		  }
						    		  else
						    		  {
						    			  arrCol.add("0");//5   
						    		  }			    		  
					    		  }
//					    		  else
//					    		  {
//					    			  arrCol.add("NA");//5  
//					    		  }
					    	  }	
					    	  
					    	  else if(strSeqNo.trim().equalsIgnoreCase("SECURITY-05"))
					    	  {
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  if(rs.next())
					    		  {
					    			  strPrimeFlag="Y"; 
					    		  }
					    		  else
					    		  {
					    			  strPrimeFlag="N"; 
					    		  }
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"2");
					    		  if(rs.next())
					    		  {
					    			  strCollFlag="Y"; 
					    		  }
					    		  else
					    		  {
					    			  strCollFlag="N"; 
					    		  }
					    		  if(strPrimeFlag.equalsIgnoreCase("Y") && strCollFlag.equalsIgnoreCase("N"))
					    		  {
					    			  arrCol.add("Prime");
					    		  }
					    		  else if(strPrimeFlag.equalsIgnoreCase("N") && strCollFlag.equalsIgnoreCase("Y"))
					    		  {
					    			  arrCol.add("Collateral");  
					    		  }
					    		  else if(strPrimeFlag.equalsIgnoreCase("Y") && strCollFlag.equalsIgnoreCase("Y"))
					    		  {
					    			  arrCol.add("Prime/Collateral");
					    		  }
					    		  else
					    		  {
					    		     arrCol.add("");
					    		  }					    		  
					    		  
					    	  }
					    	  
					    	  else if(strSeqNo.trim().equalsIgnoreCase("COLLATER-01"))
					    	  {
					    		 
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"1");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  if(rs!=null) rs.close();
					    		  rs=DBUtils.executeLAPSQuery("selcheckprimecolrating^"+strAppno+"^"+"2");
					    		  while(rs.next())
					    		  {
					    			  dbPrimarySecAmount=dbPrimarySecAmount+Double.parseDouble(Helper.correctDouble(rs.getString("CUS_SEC_NETSECURITY")));
					    		  }	
					    		  
					    		  arrCol.add(""+Helper.formatDoubleValue(dbPrimarySecAmount));			    		  
					    		  
					    	  }
					    	  
					    	  else if(strSeqNo.trim().equalsIgnoreCase("LOANTOVA-01"))
					    	  {
					    		  if(strLoanReqAmnt!=0.00 && dbPrimarySecAmount!=0.00)
					    		  {
					    		  dbloanValuePer=(strLoanReqAmnt/dbPrimarySecAmount)*100; 
					    		  arrCol.add(""+Helper.formatDoubleValue(dbloanValuePer));	
					    		  }
					    		  else
					    		  {
					    			  arrCol.add("0.00");  
					    		  }
					    		  
					    	  }
					    	  
					    	  else if(strSeqNo.equalsIgnoreCase("EXISTING-01"))
						    	{
						    		
						    		arrCol.add("");//3
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Nature of Current Ratio_LCM"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Type of Loan_LCM_V2.0"))
						    	{
						    		    arrCol.add("");//3	
						    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("INDUSTRY-01"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("NBFC_INDU"))
						    	{
						    		  arrCol.add("NBFC");
						    	}
					    	  
						    	// New parameters added for pool based rating by Guhan T on 30112015
						    	else if(strIndividual && strSeqNo.equalsIgnoreCase("RE22_Monthly_Income_Per_Dependnt")) 
						    	{
						    		double dblincome=0,dblDependCount=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_perdependent_monthlyInc_corp^"+strAppno+"^"+strAppno);
						    		while(rs.next())
						    		{
						    			dblincome=dblincome+Double.parseDouble(Helper.correctDouble(rs.getString("tot_inc")));
						    			dblDependCount=dblDependCount+Double.parseDouble(Helper.correctDouble(rs.getString("dep_count")));
						    		}	
					    			arrCol.add(""+nf.format((dblincome/dblDependCount)/12));
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE08_Yearly_Income_per_(dependent)"))
						    	{
						    		double dblincome=0,dblDependCount=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_perdependent_monthlyInc_corp^"+strAppno+"^"+strAppno);
						    		while(rs.next())
						    		{
						    			dblincome=dblincome+Double.parseDouble(Helper.correctDouble(rs.getString("tot_inc")));
						    			dblDependCount=dblDependCount+Double.parseDouble(Helper.correctDouble(rs.getString("dep_count")));
						    		}	
						    		arrCol.add(""+nf.format(dblincome/dblDependCount));
						    	}

						    	else if(strSeqNo.equalsIgnoreCase("RE24_Guarantor_Net_worth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_guarantor_networth_corp^G^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    			arrCol.add(""+nf.format((dblnetworth/strLoanReqAmnt)));
						    		}	
						    		else
						    		{
//						    			arrCol.add("No Guarantor");
						    			arrCol.add("0");
						    		}
						    	}
					    	  
						    	else if(strSeqNo.equalsIgnoreCase("RE33_Borrower_Net_worth/Loan_Amount")
						    			|| strSeqNo.equalsIgnoreCase("RE09_Borrower_Net_Worth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_borrower_networth_corp^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    		}	
						    		arrCol.add(""+nf.format((dblnetworth/strLoanReqAmnt)));
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE48_Co-borrower_Networth_to_Loan_Amt"))
						    	{
						    		double dblnetworth=0;
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_guarantor_networth_ret^C^"+strAppno);
						    		if(rs.next())
						    		{
						    			dblnetworth=Double.parseDouble(Helper.correctDouble(rs.getString("networth")));
						    		}	
						    		arrCol.add(""+nf.format((dblnetworth/strLoanReqAmnt)));
						    	}
					   
						    	else if(strSeqNo.equalsIgnoreCase("RE80_Counterparty_with_Credit History"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_CIBIL_score_corp^"+strAppno);
						    		if(rs.next())
						    		{
						    			strCIBILavail=Helper.correctNull(rs.getString("CIBIL_RAT_STATUS"));
						    			strCIBILscore=Helper.correctInt(rs.getString("CIBIL_SCORE"));
						    		}
						    		if(strCIBILavail.equalsIgnoreCase("Y"))
						    			arrCol.add("1");
						    		else
						    			arrCol.add("0");
						    	}
					    	  
						    	else if(strCIBILavail.equalsIgnoreCase("Y") && (strSeqNo.equalsIgnoreCase("RE34_CIBIL_Score") || strSeqNo.contains("RE05_CIBIL_Transunion_Score")))
						    	{
						    		arrCol.add(strCIBILscore);
						    	}
						    	
					    	  	
						    	else if(strSeqNo.equalsIgnoreCase("RE39_Yrs_ in_current_employment/Business"))
						    	{
						    		if(strConstution.equalsIgnoreCase("01") || strConstution.equalsIgnoreCase("1") || strConstution.equalsIgnoreCase("001"))
						    		{
							    		if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_rat_experience_corp^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("PEREMP_EXPINYRS")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    		else
						    		{
						    			if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_expinbusiness^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("businessyrs")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE02_Othr_Sources_of_Income"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_rat_experience_corp^"+strAppno);
						    		if(rs.next())
						    		{
						    			if(Double.parseDouble(Helper.correctDouble(rs.getString("PERINC_OTHERINCOME")))>0)
						    			{
						    				arrCol.add("1");
						    			}
						    			else
						    			{
						    				arrCol.add("0");
						    			}
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE03_Land_Holding_in_Hectares"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_land_holding_hectare_Corp^"+strAppno);
						    		if(rs.next())
						    		{
						    			arrCol.add(Helper.correctNull(rs.getString("land_hectare")));
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE82_Existing _Loan_ Account_ with_ Bank"))
						    	{
						    		if(rs!=null) rs.close();
						    		rs=DBUtils.executeLAPSQuery("sel_banking^"+strAppno);
						    		if(rs.next())
						    		{
						    			arrCol.add("1");
						    		}
						    		else
						    		{
						    			arrCol.add("0");
						    		}
						    	}//doubt
						    	else if(strSeqNo.equalsIgnoreCase("RE87_collateral_required"))
						    	{
//						    		if(rs!=null) rs.close();
//						    		rs=DBUtils.executeLAPSQuery("^"+strAppno);
//						    		if(rs.next())
//						    		{
//						    			arrCol.add("Yes");
//						    			strCollAvail = "Y";
//						    		}
//						    		else
//						    		{
//						    			arrCol.add("No");
//						    		}
						    		arrCol.add("0");
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE13_Assets_Coverage_Ratio"))
						    	{
						    		if(strCollAvail.equalsIgnoreCase("N"))
						    		{
							    		if(rs!=null) rs.close();
							    		rs=DBUtils.executeLAPSQuery("sel_collateral_coverage^"+strAppno+"^"+strAppno);
							    		if(rs.next())
							    		{
							    			arrCol.add(Helper.correctNull(rs.getString("sec_coverage")));
							    		}
							    		else
							    		{
							    			arrCol.add("0");
							    		}
						    		}
						    		else
						    		{
						    			arrCol.add("Not applicable (collateral not required)");
						    		}
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("RE49_Length_of_Relationship_of_Co-borrower_Bank"))
						    	{
						    	  if(rs!=null) rs.close();
						    	  rs=DBUtils.executeLAPSQuery("selallriskparameters^"+strAppno+"^c");
						    	  if(rs.next())
					    		  {
						    		  arrCol.add(String.valueOf(Double.parseDouble(Helper.correctDouble((String)rs.getString("MONTHS")))/12));
					    		  }
						    	  else
						    	  {
						    		  arrCol.add("0");
						    	  }
						    	}
					    	  
					    	  	
					    	  
					   // New parameters end by Guhan T
//						    	else
//						    	{
//						    		arrCol.add("");//3	
//						    	}
					    		
					    	}
					    	else if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("E"))
					    	{
					    		if(strSeqNo.equalsIgnoreCase("RE36_FOIR_individual") || strSeqNo.equalsIgnoreCase("RE50_FOIR_co-borrower")
					    				|| strSeqNo.equalsIgnoreCase("RE90_Net_Surplus_Ratio_(non_individual)") || strSeqNo.equalsIgnoreCase("RE23_NPM_Nonindividual")
					    				|| strSeqNo.equalsIgnoreCase("RE37_DSCR") || strSeqNo.equalsIgnoreCase("RE66_Current_Ratio"))
					    		{
					    			if(strIndividual && (strSeqNo.equalsIgnoreCase("RE36_FOIR_individual") || strSeqNo.equalsIgnoreCase("RE50_FOIR_co-borrower")))
					    			{
					    				arrCol.add("");//3
					    			}
					    			else if(!strIndividual && (strSeqNo.equalsIgnoreCase("RE37_DSCR") || strSeqNo.equalsIgnoreCase("RE66_Current_Ratio") || strSeqNo.equalsIgnoreCase("RE90_Net_Surplus_Ratio_(non_individual)") || strSeqNo.equalsIgnoreCase("RE23_NPM_Nonindividual")))
					    			{
					    				arrCol.add("");//3
					    			}
					    		}
					    		else
					    		{
					    			arrCol.add("");//5
					    		}	    		
					    	}
					    	else if(Helper.correctNull((String)rs1.getString("rsk_columnflag")).equalsIgnoreCase("S"))
					    	{
						    	  if(strSeqNo.equalsIgnoreCase("RE51_College_Ranking_(India)") || strSeqNo.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
					    		  {
					    			if(strStudiesIn.equalsIgnoreCase("A") && strSeqNo.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
					    			{
					    				arrCol.add("");//3
					    			}
					    			else if(strStudiesIn.equalsIgnoreCase("I") && strSeqNo.equalsIgnoreCase("RE51_College_Ranking_(India)"))
					    			{
					    				arrCol.add("");//3
					    			}
					    		  }
						    	  else if(strSeqNo.equalsIgnoreCase("RE04_Literacy_Level") || strSeqNo.equalsIgnoreCase("RE65_Stability_of_Income")
						    			  || strSeqNo.equalsIgnoreCase("RE31_Stability_of_income_indiv") || strSeqNo.equalsIgnoreCase("RE40_Edu_qualification")
						    			  || strSeqNo.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual") || strSeqNo.equalsIgnoreCase("RE35_Track_Record_non-indiv"))
						    		{
						    		  if(strIndividual && (strSeqNo.equalsIgnoreCase("RE04_Literacy_Level") || strSeqNo.equalsIgnoreCase("RE65_Stability_of_Income")
							    			  || strSeqNo.equalsIgnoreCase("RE31_Stability_of_income_indiv") || strSeqNo.equalsIgnoreCase("RE40_Edu_qualification")))
						    			{
						    				arrCol.add("");//3
						    			}
						    		  else if(!strIndividual && (strSeqNo.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual") || strSeqNo.equalsIgnoreCase("RE35_Track_Record_non-indiv")))
						    			{
						    				arrCol.add("");//3
						    			}
						    		}
							    	else
							    	{
							    		arrCol.add("");//3
							    	}
						    	}
					    }
					    	//ENDE
					    	arrCol.add(Helper.correctNull((String)rs1.getString("RSK_PARAMCODE")));//4
					    	
					    	if(arrCol != null && arrCol.size()>4)
					    	{
					    		arrRow.add(arrCol);
					    	}
					    	
					    }
					    }
					}
					
					hshRecord.put("arrRow", arrRow);
					}
					else if(strFinalFlag.equalsIgnoreCase("N"))
					{
						log.info("=======Final========="+strFinalFlag);
						strBusFacId=Helper.correctInt((String)hshRequestValues.get("hbusid"));
						if(strBusFacId.equalsIgnoreCase("") || strBusFacId.equalsIgnoreCase("0"))
						{
							strBusFacId=Helper.correctInt((String)hshRequestValues.get("sel_corpbusinessid"));
							log.info("=======strBusFacId========="+strBusFacId);
						}
												
						if(Helper.correctNull((String)hshRequestValues.get("strFromN")).equalsIgnoreCase("T"))	
						{
							if(rs!=null)
							{
								rs.close();
							}	
						rs=DBUtils.executeLAPSQuery("checkriskdatatemp^"+strAppno);
						if(rs.next())
						{
							strBusId=Helper.correctNull((String)rs.getString("RAT_BUSID"));
							strBusFacId=Helper.correctNull((String)rs.getString("RAT_BUSID"));
							log.info("=======strBusId========="+strBusId);
						}
						}
					if(!strBusFacId.equalsIgnoreCase(""))
					{
					rs1 = DBUtils.executeLAPSQuery("selriskparamrule2New^"+strBusFacId);
					if(rs1.next())
					{
							strLapsParams=Helper.correctNull((String)rs1.getString("rsk_rule_params"));	
							strModelCode=Helper.correctNull((String)rs1.getString("rsk_rule_ratcode"));	
					
					for(int i=0;i<strLapsParams.length();i++)
					{
						if(strLapsParams.substring(i,i+1).equalsIgnoreCase("1"))
						{
							int j=i+1;
							strParaSeq=strParaSeq+j+",";
												
						}
										
					}
					log.info("=======strParaSeq========="+strParaSeq);
					}
					if(rs1!=null)
					{
						rs1.close();
					}
					
					if(!strParaSeq.equalsIgnoreCase("") && strParaSeq.contains(","))
					{
						strParaSeq=strParaSeq.substring(0,strParaSeq.length()-1);		
						strQuery = SQLParser.getSqlQuery("sel_riskparam_Setup^"+strParaSeq);
						rs1 = DBUtils.executeQuery(strQuery);
						arrRow=new ArrayList();
					    while(rs1.next())
						 {
						    	arrCol=new ArrayList();
						    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_seqno")));//0
						    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_paramvalue")));//1
						    	arrCol.add(Helper.correctNull((String)rs1.getString("rsk_columnflag")));//2
						    	String strSeqNo=Helper.correctNull((String)rs1.getString("RSK_PARAMCODE"));
						    	String strTL="",strWc="",strTlWc="";						    	
						    	
						    	if(strSeqNo.equalsIgnoreCase("EXISTING-01"))
						    	{
						    		
						    		arrCol.add("");//3
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Nature of Current Ratio_LCM"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("Type of Loan_LCM_V2.0"))
						    	{
						    		
						    		if(rs!=null)
									{
										rs.close();
									}	
							    	rs=DBUtils.executeLAPSQuery("selfactypecheckrating^"+strAppno);
							    	while(rs.next())
							    	{						    		
							    		strTlWc=strTlWc+Helper.correctNull((String)rs.getString("COM_FACCODE"))+",";						    							    		
							    	}
							    	if(!strTlWc.equalsIgnoreCase("") && strTlWc.contains(","))
							    	{
							    		strTlWc=strTlWc.substring(0, strTlWc.length()-1);
							    	}
							    	
							    	if(strTlWc.trim().contains("TL"))
							    	{
							    		strTL="Only Term Loan";
							    	}
							    	if(strTlWc.trim().contains("WC"))
							    	{
							    		
							    		strTL="Only Working Capital";
							    	}
							    	if(strTlWc.trim().contains("WC") && strTlWc.trim().contains("TL"))
							    	{
							    		strTL="Both (W/C and T/L)";
							    	}
							    	
						    		 arrCol.add(strTL);//3	
						    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("INDUSTRY-01"))
						    	{
						    		arrCol.add("");//3		    		
						    	}
						    	else if(strSeqNo.equalsIgnoreCase("NBFC_INDU"))
						    	{
						    		  arrCol.add("NBFC");
						    	}
						    	else
						    	{
						    		arrCol.add("");//3	
						    	}
						    	arrCol.add(Helper.correctNull((String)rs1.getString("RSK_PARAMCODE")));//4
						    	arrRow.add(arrCol);				    	
						  }				    		
						
					 }
					 hshRecord.put("arrRow", arrRow);
					}		 
					}
					hshRecord.put("strFacSno", strFacSno);
					hshRecord.put("strFinalFlag", strFinalFlag);					
					//for risk table
					
					if(rs!=null)
					{
						rs.close();
					}
					String strNewFacSno="0";
					
					strBusId=Helper.correctInt((String)hshRequestValues.get("sel_corpbusinessid"));
					if(strBusId.equalsIgnoreCase("") || strBusId.equalsIgnoreCase("0"))
					{
						strBusId=Helper.correctInt((String)hshRequestValues.get("hidBusiId"));
					}
					if(strBusId.equalsIgnoreCase("") || strBusId.equalsIgnoreCase("0"))
					{
						strBusId=Helper.correctInt((String)hshRecord.get("RSK_RULE_ID"));
					}					
					
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{
						strNewFacSno=strFacSno;
					}
					
					if(Helper.correctNull((String)hshRequestValues.get("strFromN")).equalsIgnoreCase("T"))
					{
						if(rs!=null)
						{
							rs.close();
						}	
					rs=DBUtils.executeLAPSQuery("checkriskdatatemp^"+strAppno);
					if(rs.next())
					{
						strNewFacSno=Helper.correctNull((String)rs.getString("RAT_FACSNO"));
						strBusId=Helper.correctNull((String)rs.getString("RAT_BUSID"));
						strBusFacId=Helper.correctNull((String)rs.getString("RAT_BUSID"));						
					}
					}
					if(rs!=null)
					{
						rs.close();
					}
					log.info("=======strBusId========="+strBusId);
					log.info("=======strNewFacSno========="+strNewFacSno);
					log.info("=======strBusFacId========="+strBusFacId);
					
					rs=DBUtils.executeLAPSQuery("selriskdata^"+strAppno+"^"+strNewFacSno+"^"+strBusId);
					String strFlag="N";
					while(rs.next())
					{
						int j=0;
						j=Integer.parseInt(Helper.correctInt((String)rs.getString("RAT_SEQNO")));
						if(j==6)
						{
							String strScode=Helper.correctNull((String)rs.getString("RAT_VALUE"));
							rs1=DBUtils.executeLAPSQuery("selbranhcnamebycode^"+strScode);
							if(rs1.next())
							{
								
								//hshRecord.put("rskvalue"+j, strScode+"-"+Helper.correctNull((String)rs1.getString("org_name")));
								hshRecord.put("rskvalue"+j, strScode);
							}
							else
							{
								hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs.getString("RAT_VALUE")));
							}
						}
						else if(j==19)
						{
							String strScode=Helper.correctNull((String)rs.getString("RAT_VALUE"));
							rs1=DBUtils.executeLAPSQuery("selcbsiddatadesc^"+"3"+"^"+strScode);
							if(rs1.next())
							{
								
								hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));
							}
							else
							{
								hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs.getString("RAT_VALUE")));
							}
							
						}
						else if(j==26)
						{
							String strScode=Helper.correctNull((String)rs.getString("RAT_VALUE"));
							rs1=DBUtils.executeLAPSQuery("selcbsiddatadesc^"+"2"+"^"+strScode);
							if(rs1.next())
							{
								
								hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs1.getString("cbs_static_data_desc")));
							}
							else
							{
								hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs.getString("RAT_VALUE")));
							}
							
						}
						else
						{
						hshRecord.put("rskvalue"+j, Helper.correctNull((String)rs.getString("RAT_VALUE")));	
						}
						strFlag="Y";
						
						
					}
					log.info("=======strFlag========="+strFlag);
					
					String strRMDUser="";
					if (rs != null) {
						rs.close();
					}
					rs = DBUtils.executeLAPSQuery("setuserssel^"+struserid);
					if(rs.next())
					{
						if(correctNull((String)rs.getString("usr_rmdflag")).equalsIgnoreCase("1"))
						{
							strRMDUser="Y";
						}
					}
					
					
					//for Kalypto webservice call
					if(strAction.equalsIgnoreCase("send"))
					{
						//String strRatingSoapAddress=Helper.correctNull(ApplicationParams.getRatingSoapAddress());
						//retailEvaluation
						ArrayList arrValues= new ArrayList();
						HashMap hshQuery=new HashMap();
						HashMap hshQueryValues=new HashMap();
						if((Helper.correctNull((String)hshRequestValues.get("hidFinalFlag")).equalsIgnoreCase("Y")) )
						{
							if(ApplicationParams.getKalyptowebservice().equalsIgnoreCase("TRUE"))
							{
								log.info("=========starting of webservice========");
								RatingSoapProxy ratingsoapproxy=new RatingSoapProxy(ApplicationParams.getRatingSoapAddress());	
							String strResponse = ratingsoapproxy.retailEvaluation(strAppno);
							//String strResponse ="Success";
							log.info("strResponse========="+strResponse);
							log.info("strAppno========="+strAppno);
							if(strResponse.startsWith("Success"))
							{
								strWsResponseFlag="Y";
								if(rs!=null)
								{
									rs.close();
								}
								log.info("=========SUCCESS=========");
								if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
								{
									String strQuery1=SQLParser.getCBSSqlQuery("sel_upl_request_result_newconnection^"+strAppno);
									rs=DBUtils.executeQueryKalyptoConnection(strQuery1);
								}
								else
								{
									String strQuery1= SQLParser.getSqlQuery("sel_upl_request_result^"+strAppno);
									rs=DBUtils.executeQuery(strQuery1); 
								}
								String strRATING_SCORE="",strRATING_LABEL="",strRatUserId="",strDateAson="",strratingyear="",stryeartype="";
								int r=1;
								if(rs.next())
								{
								strRATING_SCORE=Helper.correctNull((String)rs.getString("rating_score"));
								strRATING_LABEL=Helper.correctNull((String)rs.getString("rating_label"));
								strRatUserId=Helper.correctNull((String)rs.getString("user_login_id"));
								strDateAson=Helper.correctNull((String)rs.getString("ason_date"));
								strratingyear=Helper.correctNull((String)rs.getString("date_end"));
								stryeartype=Helper.correctNull((String)rs.getString("period_type"));
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								hshQueryValues.put("size", "1");
					 			hshQuery.put("strQueryId", "creditratinsu");
					   			arrValues.add(strAppno);
					   			arrValues.add(String.valueOf(r));
					   			arrValues.add(strRATING_SCORE);
					   			arrValues.add("Y");
					   			arrValues.add(strRATING_LABEL);
					   			arrValues.add(strRatUserId);
					   			//arrValues.add(strDateAson);
					   			arrValues.add(strratingyear);
					   			arrValues.add(stryeartype);	
					   			arrValues.add("");
					   			arrValues.add(strRMDUser);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);	
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								
								//tO dELETE IN UPL_REQUEST_RESULT DATA
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								hshQueryValues.put("size", "1");
								if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
								{
									hshQuery.put("strQueryId", "deluplratresultdata_newconn");
								}
								else
								{
									hshQuery.put("strQueryId", "deluplratresultdata");
								}
					 			arrValues.add(strAppno);	
					 			arrValues.add(struserid);
					 			hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);	
								//log.info("===undodeluplresult==="+arrValues);
								if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
								{
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
								}
								else
								{
									EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								}
								//END			
								
								
								}
								
								//If Success only we need to give 
							}
							else
							{
								//Failure for Pool based we need to delete the entry from these 4 tables
								strWsResponseFlag="N";
								log.info("=========FAILURE=========");
							}
							
							
							
							}
							
							
						}
						else
						{
							//Non Pool based Webservice need to call
                            
							log.info("=========starting of webservice non pool based========");

							RatingSoapProxy ratingsoapproxy=new RatingSoapProxy(ApplicationParams.getRatingSoapAddress());	
							String strResponse = ratingsoapproxy.corporateRating(strAppno);
							//String strResponse="Success";
							log.info("strAppno========="+strAppno);
							log.info("strResponse========="+strResponse);
							if(strResponse.startsWith("Success"))
							{
								strWsResponseFlag="Y";
								if(rs!=null)
								{
									rs.close();
								}
								log.info("=========SUCCESS=========");
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								hshQueryValues.put("size", "1");
					 			hshQuery.put("strQueryId", "creditratdelete_userid");
					   			arrValues.add(strAppno);
					   			arrValues.add(struserid);	
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);	
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues = new HashMap();
								hshQueryValues.put("size", "1");
					 			hshQuery.put("strQueryId", "inscreditscoring_nonpoolflag");
					   			arrValues.add(strAppno);
					   			arrValues.add("1");
					   			arrValues.add("Y");
					   			arrValues.add("Y");
					   			arrValues.add(struserid);	
					   			arrValues.add("");
					   			arrValues.add(strRMDUser);
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("1", hshQuery);	
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
							}
							else
							{
								//Failure
								strWsResponseFlag="N";
								log.info("=========FAILURE=========");
							}
						}						
					}
					
					//Checking for the errors and the rejection of rating request
					
					//Check for rejection of Non pool based rating request
					if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						String strQuery1=SQLParser.getCBSSqlQuery("sel_upl_request_result_newconnection_user^"+strAppno+"^"+struserid+"^1");
						ResultSet rsReject=DBUtils.executeQueryKalyptoConnection(strQuery1);
						if(rsReject.next())
						{
							strWsResponseFlag="N";
						}
					}
					//selcredfreez						
					if(strWsResponseFlag.equalsIgnoreCase("Y"))
					{
						//Do nothing
					}
					else if(strWsResponseFlag.equalsIgnoreCase("N"))
					{
					//sel_upl_request_errors
					if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						String Errormsg="";
						String strQuery1=SQLParser.getCBSSqlQuery("selgetrejectreason_rat_newconn^"+strAppno);
						ResultSet rssend=DBUtils.executeQueryKalyptoConnection(strQuery1);
						if(rssend.next())
						{
							Errormsg=Helper.correctNull((String)rssend.getString("REJECTED_REASON"));
							strReject="Y";
						}
						else
						{	
							String strQuerysend=SQLParser.getCBSSqlQuery("sel_upl_request_errors_newconnection^"+strAppno+"^"+strAppno);
							rssend=DBUtils.executeQueryKalyptoConnection(strQuerysend);
							if(rssend.next())
							{
							 Errormsg=Helper.correctNull((String)rssend.getString("ERRORS"));
							 //strErrors="Y";
							}
							else
							{
								Errormsg="No Proposal Found"; //Probably there might be a pending request in kalypto for this proposal
							}
						}
							hshRecord.put("WebserviceErrorMessage",Errormsg);
							
						if(strReject.equalsIgnoreCase("Y"))
						{	
							ArrayList arrValues= new ArrayList();
							HashMap hshQuery=new HashMap();
							HashMap hshQueryValues=new HashMap();
							hshQueryValues.put("size", "2");
							hshQuery.put("strQueryId", "creditratdelete_userid");
							arrValues.add(strAppno);
				   			arrValues.add(struserid);
				   			hshQuery.put("arrValues", arrValues);
				   			hshQueryValues.put("1", hshQuery);	
				   			
							arrValues = new ArrayList();
							hshQuery = new HashMap();
				 			hshQuery.put("strQueryId", "inscreditscoring_nonpoolflag");
				   			arrValues.add(strAppno);
				   			arrValues.add("1");
				   			arrValues.add("Y");
				   			arrValues.add("N");
				   			arrValues.add(struserid);
				   			arrValues.add(Errormsg);
				   			arrValues.add(strRMDUser);
				   			hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("2", hshQuery);	
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
							if(rssend!=null)
							{
								rssend.close();
							}
						
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQueryValues = new HashMap();
							hshQueryValues.put("size", "1");
							if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								hshQuery.put("strQueryId", "deluplratresultdata_newconn");
							}
							else
							{
								hshQuery.put("strQueryId", "deluplratresultdata");
							}
				 			arrValues.add(strAppno);	
				 			arrValues.add(struserid);
				 			hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);	
							log.info("===deleterejectedreqest==="+arrValues);
							if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
							}
							else
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
						}
						
					}
					else
					{
						String strQuerysend=SQLParser.getSqlQuery("sel_upl_request_errors^"+strAppno+"^"+strAppno);
						ResultSet rssend=DBUtils.executeQuery(strQuerysend);
						if(rssend.next())
						{
							hshRecord.put("WebserviceErrorMessage", Helper.correctNull((String)rssend.getString("ERRORS")));
						}
						if(rssend!=null)
						{
							rssend.close();
						}
					}
					}
					
					if(rs1!=null) rs1.close();
					String strTempFreezFlag="";
					String strsend="";
					String strPromotersFreeze="";
					//for pool based
					rs1=DBUtils.executeLAPSQuery("selcredfreezuserwise^"+strAppno+"^"+struserid);
					if(rs1.next())
					{						
							hshRecord.put("strSendFlag", Helper.correctNull(rs1.getString("cre_freeze")));
							strsend="Y";
							if(Helper.correctNull(rs1.getString("CRE_RATING")).equalsIgnoreCase("") && Helper.correctNull(rs1.getString("CRE_WEIGHT")).equalsIgnoreCase(""))
								{
									hshRecord.put("strNonPoolEMptyRatingFlag","Y");		
								}
							strTempFreezFlag=Helper.correctNull((String)rs1.getString("cre_freeze"));
					}
					else
					{
						hshRecord.put("strSendFlag", "N");
						strsend="N";
					}
					
						log.info("=========strTempFreezFlag========="+strTempFreezFlag);
						log.info("=========strsend========="+strsend);
					
				 
					if(rs1!=null) rs1.close();
					
					log.info("=========Final========="+strFinalFlag);
					
					if(strFinalFlag.equalsIgnoreCase("Y"))
					{
					rs1=DBUtils.executeLAPSQuery("selcredfreez^"+strAppno);
					while(rs1.next())
					{
						strROIUpdateFlag="Y";				
						arRatCol=new ArrayList();
						arRatCol.add(Helper.correctNull((String)rs1.getString("cre_rating")));//0
						arRatCol.add(Helper.correctNull((String)rs1.getString("cre_weight")));//1
						if(Helper.correctNull(rs1.getString("cre_rmdflag")).equalsIgnoreCase("Y"))
							arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid"))+"  - RMD User");//2	
						else
							arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid")));//2
						arRatCol.add(Helper.correctNull(rs1.getString("cre_freeze")));//3						
						arRatCol.add(Helper.correctNull(rs1.getString("cre_asondate")));//4						
						arRatCol.add(Helper.correctNull(rs1.getString("cre_ratingerror")));//5						
						arRatRow.add(arRatCol);
					}
					log.info("=========strROIUpdateFlag========="+strROIUpdateFlag);
					}
					
					else if(strFinalFlag.equalsIgnoreCase("N"))
					{
						rs1=DBUtils.executeLAPSQuery("selcrezflag_nonpoolbor^"+strAppno);
						while(rs1.next())
						{
								strROIUpdateFlag="Y";	
							    String strRat=Helper.correctNull((String)rs1.getString("cre_rating"));
							    String strRatWeight=Helper.correctNull((String)rs1.getString("cre_weight"));
							   
							    //Hided by Guhan - Since the rejection of rating is handled separately
							    
							    /*if(strRat.equalsIgnoreCase("") && strRatWeight.equalsIgnoreCase(""))
							    {							    	
							    	//added by bhaskar for rejection reasons showing to borrower
							    	if(rs2!=null)
							    	{
							    		rs2.close();
							    	}
							    	if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
									{
										String strQuery1=SQLParser.getCBSSqlQuery("selgetrejectreason_rat_newconn^"+strAppno);
										rs2=DBUtils.executeQueryKalyptoConnection(strQuery1);
									}
									else
									{
										rs2=DBUtils.executeLAPSQuery("selgetrejectreason_rat^"+strAppno);
									}
							    	if(rs2.next())
							    	{
							    	
							    		if(Helper.correctNull((String)rs2.getString("STATUS")).equalsIgnoreCase("1"))
							    		{							    			
							    		 hshRecord.put("WebserviceErrorMessage", Helper.correctNull((String)rs2.getString("REJECTED_REASON")));							    			
							    		}
							    		
							    	}
							    	
							    }
							    else
							    {*/
									arRatCol=new ArrayList();
									arRatCol.add(Helper.correctNull((String)rs1.getString("cre_rating")));//0
									arRatCol.add(Helper.correctNull((String)rs1.getString("cre_weight")));//1
									if(Helper.correctNull(rs1.getString("cre_rmdflag")).equalsIgnoreCase("Y"))
										arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid"))+"  - RMD User");//2	
									else
										arRatCol.add(Helper.correctNull((String)rs1.getString("cre_userid")));//2	
									arRatCol.add(Helper.correctNull(rs1.getString("cre_freeze")));//3	
									arRatCol.add(Helper.correctNull(rs1.getString("cre_asondate")));//4
									arRatCol.add(Helper.correctNull(rs1.getString("cre_ratingerror")));//5
									arRatRow.add(arRatCol);
							    //}
							    
						}								
												
					}
					if(rs1!=null) rs1.close();
					hshRecord.put("strFlag", strFlag);
					hshRecord.put("strModelCode",strModelCode);
					hshRecord.put("strRatType",strRatType);
					hshRecord.put("strBusId",strBusFacId);
					hshRecord.put("arRatRow", arRatRow);				 	
					hshRecord.put("ROIUpdateFlag", strROIUpdateFlag);
					hshRecord.put("strRMDUserFlag", strRMDUser);
					/*if(strAction.equalsIgnoreCase("check"))
					{
						//selcredfreez
						String strQueryNew=SQLParser.getSqlQuery("selcredfreez^"+strAppno);
						ResultSet rsnew=DBUtils.executeQuery(strQueryNew);
						if(rsnew.next())
						{
							//Do nothing
						}
						else
						{
						//sel_upl_request_errors
						if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
						{
							String strQuerysend=SQLParser.getCBSSqlQuery("sel_upl_request_errors_newconnection^"+strAppno+"^"+strAppno);
							ResultSet rssend=DBUtils.executeQueryCBSConnection(strQuerysend);
							if(rssend.next())
							{
								hshRecord.put("WebserviceErrorMessage", Helper.correctNull((String)rssend.getString("ERRORS")));
							}
							if(rssend!=null)
							{
								rssend.close();
							}
						}
						else
						{
							String strQuerysend=SQLParser.getSqlQuery("sel_upl_request_errors^"+strAppno+"^"+strAppno);
							ResultSet rssend=DBUtils.executeQuery(strQuerysend);
							if(rssend.next())
							{
								hshRecord.put("WebserviceErrorMessage", Helper.correctNull((String)rssend.getString("ERRORS")));
							}
							if(rssend!=null)
							{
								rssend.close();
							}
						}
						}
					}*/
					if(strAction.equalsIgnoreCase("check")||strAction.equalsIgnoreCase("send"))
					{
						hshRecord.put("strupdateROIFlag","Y");
					}
			  		if(rs!=null) rs.close();
			  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
		    		rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						strPromotersFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
					}
					hshRecord.put("strPromoFreezeflag",strPromotersFreeze);
						int strFreezecount=0;
		    		   	String strSecFreezeflag="N";
		    		   	strQuery = SQLParser.getSqlQuery("sel_freezecount^" + strAppno);
		    			rs = DBUtils.executeQuery(strQuery);
		    			if(rs.next())
		    			{	
		    				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
		    				if(strFreezecount!=0 )
		    				{
		    					strSecFreezeflag="Y";
		    				}
		    			}
		    			hshRecord.put("strSecFreezeflag",strSecFreezeflag);
					
		    	//For Current year fetching
	    			if(rs!=null) rs.close();
			  		strQuery = SQLParser.getSqlQuery("select_curryear_rating^"+strAppno);
		    		rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						hshRecord.put("strCurrYear", Helper.correctNull((String)rs.getString("FINRATEYEAR_SELSNO")));
					}
					
					//For FInacial Tally check
					if(rs!=null) rs.close();
					strQuery = SQLParser.getSqlQuery("sel_financial_tally_chk^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						hshRecord.put("FIN_TALLY", Helper.correctNull((String)rs.getString("FIN_TALLY")));
					}
					
					//MCLR ROI Check
					int intfaccnt=0,intmclrcnt=0;
					{
						if(rs!=null) rs.close();
						strQuery = SQLParser.getSqlQuery("sel_facilityrating^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							if(rs1!=null)
								rs1.close();
							intfaccnt+=1;
							strQuery = SQLParser.getSqlQuery("sel_facility_mclrspread^"+Helper.correctInt(rs.getString("facility_sno"))+"^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								intmclrcnt+=1;	
							}
							
						}
					}
					
					if(intfaccnt!=intmclrcnt)
						hshRecord.put("strMCLRTally","N");
					
					hshRecord.put("strRatingROI",String.valueOf(intmclrcnt));
					
					if(Helper.correctNull((String)hshRequestValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
					{
						if(rs!=null) rs.close();
						strQuery = SQLParser.getSqlQuery("getappamt^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if (rs.next()) 
						{
							if(Helper.correctNull(rs.getString("loan_roitype")).equalsIgnoreCase("RATING"))
								hshRecord.put("strRatingROI","1");
						}
					}
					
					
					
					if(rs!=null) rs.close();
					String prdType="";
					strQuery = SQLParser.getSqlQuery("seldigiprd_appl^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) 
					{
						prdType=Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI"));	
					}
					hshRecord.put("prdType",prdType);
					

				} catch (Exception e) {
					log.info("exception in getData... " + e);
					throw new EJBException(e.getMessage());
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

	public void updateRetailRating(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strPrdCode = null;
		String strKeyId = "";
		String strAppno="";
		String strRiskSeqNo="";
		String strRiskValue="";
		int as=0;
		String arrSize="";
		String strAction="";
		String strCBSId="",strSolid="",strRmd="",strperapp_constitution="";		
		ResultSet rs=null,rs1=null;
		String struserid="",strNameofBor="",strCountryCode="";
		String strDateofBirth="",strbankSince="";
		String strBranchCode="";
		String strParmType="",strFac_Sno="",strBusId="",strCheckFlag="";
		String strExp="$",strRatType="",strInwRecDate="",strMatuDate="";
		String strSecId="",strSecValue="",strSecStartDate="",strSecEndDate="",strSecDesc="",strSec_masId="";
		String strComAppId="",strSecCusId="",strCurryear="",strSecInsureAmt="";
		try {
		
			//strPrdCode = (String) hshValues.get("prdCode");			
			strAppno = correctNull((String)hshValues.get("appno"));
			arrSize  =correctNull((String)hshValues.get("hidrowsize"));
			as=Integer.parseInt(Helper.correctInt(arrSize));
			strAction=correctNull((String)hshValues.get("hidAction"));
			struserid=Helper.correctNull((String)hshValues.get("strUserId"));	
			strRatType=correctNull((String)hshValues.get("hidstrRatType"));
			
			rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_groupby^"+strAppno);
			if(rs.next())
			{
				strFac_Sno=correctNull((String)rs.getString("facility_sno"));
			}
			strBusId=Helper.correctNull((String)hshValues.get("sel_corpbusinessid"));
			strCurryear=Helper.correctNull((String)hshValues.get("sel_curryear"));
			strCheckFlag=Helper.correctNull((String)hshValues.get("hdCheckFlag"));
			if(strBusId.equalsIgnoreCase(""))
			{
				strBusId=Helper.correctNull((String)hshValues.get("hidBusiId"));	
			}
			if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
			{
				strFac_Sno="0";
			}
			String strRMDUser="";
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("setuserssel^"+struserid);
			if(rs.next())
			{
				if(correctNull((String)rs.getString("usr_rmdflag")).equalsIgnoreCase("1"))
				{
					strRMDUser="Y";
				}
			}
			if(strAction.equalsIgnoreCase("insert"))
			{
				 
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "delriskdata");
	   			arrValues.add(strAppno);	   				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				for(int i=1;i<=as;i++)
			    {					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					hshQueryValues.put("size", "1");
		 			hshQuery.put("strQueryId", "insertriskdata");
		   			arrValues.add(strAppno);
		   			arrValues.add(Helper.correctNull((String)hshValues.get("hid_riskparam"+i)));
		   			if(Helper.correctNull((String)hshValues.get("hid_riskparam"+i)).equalsIgnoreCase("19"))
		   			{
		   				String strMar=Helper.correctNull((String)hshValues.get("txt_riskparam"+i));
		   				rs=DBUtils.executeLAPSQuery("selcbsiddatacode^"+"3"+"^"+strMar);
		   				if(rs.next())
		   				{
		   					arrValues.add(Helper.correctNull((String)rs.getString("cbs_static_data_code")));
		   				}
		   				else
		   				{
		   					arrValues.add("NA");
		   				}   				
		   			}
		   			else
		   			{
		   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_riskparam"+i)));
		   			}
		   			arrValues.add(strFac_Sno);
		   			arrValues.add(strBusId);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);	
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");				
		     	}			
				// For current year update
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "update_curryear_null");
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "update_curryear");
	 			arrValues.add(strCurryear);	   			
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "delriskdata");
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "update_curryear_null");
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("send"))
			{
				//added by bhaskar to insert data to four table UPL_PROPOSAL_DATA
				if(rs!=null)
				{
					rs.close();
				}
				int i=0;
				if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("RET"))
				{
				rs = DBUtils.executeLAPSQuery("selalldeatilsforinserrat^" + strAppno);
				}
				else
				{
				rs = DBUtils.executeLAPSQuery("selalldeatilsforinserrat_corp^" + strAppno);	
				}
				if(rs.next())
				{
					strCBSId=Helper.correctNull((String)rs.getString("PERAPP_CBSID"));	
					strNameofBor=Helper.correctNull((String)rs.getString("perapp_fname"));
					strCountryCode=Helper.correctNull((String)rs.getString("CON_COMCOUNTRY"));
					strDateofBirth=Helper.correctNull((String)rs.getString("perapp_dob"));
					strbankSince=Helper.correctNull((String)rs.getString("perapp_banksince"));
					strBranchCode=Helper.correctNull((String)rs.getString("perapp_branchcode"));
					strperapp_constitution=Helper.correctNull((String)rs.getString("perapp_constitution"));
					strComAppId=Helper.correctNull((String)rs.getString("PERAPP_ID"));
					
					log.info("===strCBSId==="+strCBSId);
					log.info("===strNameofBor==="+strNameofBor);
					log.info("===strCountryCode==="+strCountryCode);
					log.info("===strDateofBirth==="+strDateofBirth);
					log.info("===strbankSince==="+strbankSince);
					log.info("===strBranchCode==="+strBranchCode);
					log.info("===strperapp_constitution==="+strperapp_constitution);
					log.info("===strComAppId==="+strComAppId);
				}
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("seluserrmd^"+struserid);
				if(rs.next())
				{
					strSolid=Helper.correctNull((String)rs.getString("SOLID"));	
					strRmd=Helper.correctNull((String)rs.getString("USR_RMDFLAG"));	
					log.info("===strSolid==="+strSolid);
					log.info("===strRmd==="+strRmd);
					
				}
				if(rs!=null)
				{
					rs.close();
				}	
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "insuplproposaldata_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "insuplproposaldata");
				}
	 			arrValues.add(strAppno);	
	   			arrValues.add(strCBSId);
	   			arrValues.add(struserid);
	   			arrValues.add(strSolid);
	   			arrValues.add(strRmd.trim());	   			
				hshQuery.put("arrValues", arrValues);
				log.info("===ProposalData==="+arrValues);
				
				hshQueryValues.put("1", hshQuery);	
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				//second table data deleteing and inserting--UPL_REQUEST_DATA
				if(strRatType.equalsIgnoreCase("0") || strRatType.equalsIgnoreCase("1"))
				{
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				log.info("===deluplrequestdata_newconn===");
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "deluplrequestdata_newconn");
	   			arrValues.add(strAppno);	   				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "insuplrequestdata_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "insuplrequestdata");
				}
	   			arrValues.add(strAppno);	
	   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
	   			arrValues.add(Helper.correctNull((String)hshValues.get("hidModelCode")));
	   			arrValues.add(strRatType);
	   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
	   			arrValues.add("0");   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===RequestData==="+arrValues);
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}
				if(strRatType.equalsIgnoreCase("1"))
				{
					if(rs!=null)
					{
						rs.close();					
					}
					rs = DBUtils.executeLAPSQuery("sel_facilitycodedesc_groupby^"+strAppno);
					while(rs.next())
					{
					 String strFacSno=correctNull((String)rs.getString("facility_sno"));
					 String strFacProposedLimit=Helper.correctDouble((String)rs.getString("FACILITY_PROPOSED"));
					 String strPrdCodeScheme=correctNull((String)rs.getString("COM_FACILITY_EMISCHEME"));
					 String strfacMonths=Helper.correctInt((String)rs.getString("FACILITY_MONTHS"));
					 
					 // TO INSERT INTO UPL_REQUEST_DATA
				 	arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues = new HashMap();
					log.info("===deluplrequestdata_newconn===");
					hshQueryValues.put("size", "1");
		 			hshQuery.put("strQueryId", "deluplrequestdata_newconn");
		   			arrValues.add(strAppno);	   				
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);	
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					 
					 arrValues = new ArrayList();
					 hshQuery = new HashMap();
					 hshQueryValues = new HashMap();
					 hshQueryValues.put("size", "1");
					 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						hshQuery.put("strQueryId", "insuplrequestdata_newconn");
					}
					else
					{
						hshQuery.put("strQueryId", "insuplrequestdata");
					}
			   		 arrValues.add(strAppno);	
			   		 arrValues.add(strAppno+""+strFacSno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
			   		 arrValues.add("51");
			   		 arrValues.add(strRatType);
			   		 arrValues.add(strAppno+""+strFacSno);
			   		 arrValues.add("0");   			
					 hshQuery.put("arrValues", arrValues);
					 hshQueryValues.put("1", hshQuery);	
					 log.info("===Rattype1==="+arrValues);
					 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
					{
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
					}
					else
					{
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					}
					 //end
					 
					 
					 //To Insert Data into UPL_TRANSACTION_DATA TABLE
					 if(rs1!=null)
					 {
						 rs1.close();
					 }
					
				 
					 rs1=DBUtils.executeLAPSQuery("selapprecdate^"+strAppno);
					 if(rs1.next())
					 {
						 strInwRecDate=Helper.correctNull((String)rs1.getString("inward_appliedon"));
					 }
					
					 int repayMonths=Integer.parseInt(strfacMonths);
					 Date currDate=new Date();
					 strMatuDate=Helper.addMonthWithDate(currDate, repayMonths);					 
					 arrValues = new ArrayList();
					 hshQuery = new HashMap();
					 hshQueryValues = new HashMap();
					 hshQueryValues.put("size", "1");
					 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							hshQuery.put("strQueryId", "instransactiondata_newconn");
						}
						else
						{
							hshQuery.put("strQueryId", "instransactiondata");
						}
			 		  arrValues.add(strAppno);	
			   		 arrValues.add(strAppno+""+strFacSno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));			   		 
			   		 arrValues.add(strAppno+""+strFacSno);
			   		 arrValues.add(strInwRecDate);
			   		 arrValues.add(strMatuDate);
			   		 arrValues.add(strFacProposedLimit);
			   		 arrValues.add("INR");
			   		 arrValues.add("65");
			   		 arrValues.add(strPrdCodeScheme);
			   		 arrValues.add(strCBSId);
			   		 arrValues.add(strBranchCode);	
			   		 arrValues.add("0");
			   		 hshQuery.put("arrValues", arrValues);
					 hshQueryValues.put("1", hshQuery);	
					 log.info("===Transactiondata==="+arrValues);
					 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
						}
						else
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
					 //END						 
					 
					 //To insert into UPL_COLLETRAL_DATA					 
					 if(rs1!=null)
					 {
						 rs1.close();
					 }
					 rs1=DBUtils.executeLAPSQuery("sel_fac_colletralrating_data^"+strAppno+"^"+strFacSno);
					 while(rs1.next())
					 {						  
						 
						 strSecId=Helper.correctNull((String)rs1.getString("APP_SEC_SECID"));
						 strSecValue=Helper.correctNull((String)rs1.getString("CUS_SEC_NETSECURITY"));
						 strSecStartDate=Helper.correctNull((String)rs1.getString("CUS_SEC_COLLATERAL_START_DATE"));
						 strSecEndDate=Helper.correctNull((String)rs1.getString("CUS_SEC_COLLATERAL_END_DATE"));
						 strSecDesc=Helper.correctNull((String)rs1.getString("SEC_NAME"));	
						 strSec_masId=Helper.correctNull((String)rs1.getString("CUS_SEC_TYPE"));
						 strSecCusId=Helper.correctNull((String)rs1.getString("APP_SEC_CUSTOMERID"));
						 strSecInsureAmt=Helper.correctDouble((String)rs1.getString("CUS_SEC_INSURED_AMOUNT"));
						 
						 //To add UPL_COLLATERAL_DATA INSERT
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						log.info("===delcolleteraldata_newconnection===");
						hshQueryValues.put("size", "1");
			 			hshQuery.put("strQueryId", "delcolleteraldata_newconnection");
			   			arrValues.add(strAppno);	   				
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);	
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						
						 
						 arrValues = new ArrayList();
						 hshQuery = new HashMap();
						 hshQueryValues = new HashMap();
						 hshQueryValues.put("size", "1");
						 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								hshQuery.put("strQueryId", "inscolletraldata_newconn");
							}
							else
							{
								hshQuery.put("strQueryId", "inscolletraldata");
							}
				   		 arrValues.add(strAppno);	
				   		 arrValues.add(strAppno+""+strFacSno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode"))); 
				   		 arrValues.add(strSecId);
				   		 arrValues.add(strCBSId);
				   		 arrValues.add(strSecDesc);
				   		 arrValues.add(strSec_masId);
				   		// arrValues.add("NULL");
				   		 arrValues.add("");
				   		 arrValues.add(strSecValue);
				   		 arrValues.add("");
				   		 arrValues.add("INR");
				   		 arrValues.add(strSecStartDate);
				   		 arrValues.add(strSecEndDate);
				   		 arrValues.add(strSecStartDate);
				   		 if(strSecCusId.equalsIgnoreCase(strComAppId))
				   		 {
				   			arrValues.add("0"); 
				   		 }
				   		 else
				   		 {
				   			arrValues.add("1");  
				   		 }
				   		 arrValues.add("");
				   	     arrValues.add("0");
				   		 arrValues.add("");
				   		 arrValues.add(Helper.getCurrentDateTime());
				   		 arrValues.add(strBranchCode);
				   		 arrValues.add("");
				   		 arrValues.add(strSecInsureAmt);
				   		 hshQuery.put("arrValues", arrValues);
						 hshQueryValues.put("1", hshQuery);	
						 log.info("===colletraldata==="+arrValues);
						 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
							}
							else
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
						 //END	
						 
						 //TO INSERT INTO UPL_COLLATERAL_LINK
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						log.info("===delcolleterallink_newconnection===");
						hshQueryValues.put("size", "1");
			 			hshQuery.put("strQueryId", "delcolleterallink_newconnection");
			   			arrValues.add(strAppno);	   				
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);	
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
						 
						 arrValues = new ArrayList();
						 hshQuery = new HashMap();
						 hshQueryValues = new HashMap();
						 hshQueryValues.put("size", "1");
						 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								hshQuery.put("strQueryId", "inscolletrallinkdata_newconn");
							}
							else
							{
								hshQuery.put("strQueryId", "inscolletrallinkdata");
							}
				   		 arrValues.add(strAppno);
				   		 arrValues.add(strSecId);
				   		 arrValues.add(strAppno+""+strFacSno+"_"+strSecId);
				   		 arrValues.add("0");
				   		 arrValues.add(strAppno+""+strFacSno);
				   		 arrValues.add(strCBSId);
				   		 arrValues.add(strPrdCodeScheme);				   		
				   		 arrValues.add("0");
				   		 arrValues.add(strSecValue);
				   		 arrValues.add("");
				   		 arrValues.add("1");	
				   		 arrValues.add(strAppno+""+strFacSno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
				   		 hshQuery.put("arrValues", arrValues);
						 hshQueryValues.put("1", hshQuery);	
						 log.info("===colletrallinkdata==="+arrValues);
						 if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
							}
							else
							{
								EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							}
						 //END
						 
					  }	
					 //end
					 	 
					}	
				}
				//end
				
				//added by bhaskar for third table insert UPL_COUNTERPARTY_DATA
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				log.info("===delcounterparty_newconnection===");
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "delcounterparty_newconnection");
	   			arrValues.add(strAppno);	   				
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
							
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "insuplconutrypardata_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "insuplconutrypardata");
				}
	   			arrValues.add(strAppno);	
	   			arrValues.add(strCBSId);
	   			arrValues.add(strNameofBor);  
	   			arrValues.add(strperapp_constitution); // need to pass the customer constitution
	   			arrValues.add(" "); 
	   			arrValues.add("14");	   		
	   			arrValues.add("INDIA");
	   			arrValues.add(strbankSince);
	   			arrValues.add(strBranchCode);	   			
	   			arrValues.add(strDateofBirth);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===conutrypardata==="+arrValues);
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				//end		
				
				//added by bhaskar for third table insert UPL_RATING_REQUEST_PARAMETER	
				String strRatingparamCode="";
				for(i=1;i<=as;i++)
				{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "insuplratingreqparams_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "insuplratingreqparams");
				}
	   			arrValues.add(strAppno);
	   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
	   			String strSnoParm=Helper.correctNull((String)hshValues.get("hid_riskparam"+i));
	   			if(rs!=null)
	   				rs.close();
	   			rs=DBUtils.executeLAPSQuery("selriskparamcodetype^"+strSnoParm);
	   			if(rs.next())
	   			{	   				
	   				arrValues.add(Helper.correctNull((String)rs.getString("rsk_paramcode")));//1
	   				strRatingparamCode=Helper.correctNull((String)rs.getString("rsk_paramcode"));
	   				strParmType=Helper.correctNull((String)rs.getString("RSK_PARMDATATYPE"));
	   			}
	   			if(strParmType.equalsIgnoreCase("N"))
	   			{
		   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_riskparam"+i)));		   			
	   				arrValues.add("");
	   			}	
	   			else if(strParmType.equalsIgnoreCase("T"))
	   			{
	   				arrValues.add("");	   			
		   			arrValues.add(Helper.correctNull((String)hshValues.get("txt_riskparam"+i)));
	   			}
	   			
	   			//To append start date and end date to rating page val
	   			if(strRatingparamCode.equalsIgnoreCase("Nature of Current Ratio_LCM") || strRatingparamCode.equalsIgnoreCase("Type of Loan_LCM_V2.0") || 
	   					strRatingparamCode.equalsIgnoreCase("Type of Business") || strRatingparamCode.equalsIgnoreCase("INDUSTRY-01") 
	   					|| strRatingparamCode.equalsIgnoreCase("EXISTING-01")|| strRatingparamCode.equalsIgnoreCase("NBFC_INDU"))
	   			{
		   			rs=DBUtils.executeLAPSQuery("selrating_currentyear^"+strAppno);
		   			if(rs.next())
		   			{	   				
		   				arrValues.add(Helper.correctNull((String)rs.getString("COM_FINYEAR_START")));
			   			arrValues.add(Helper.correctNull((String)rs.getString("COM_FINYEAR")));
		   			}
		   			else
		   			{
		   				arrValues.add("");
			   			arrValues.add("");
		   			}
	   			}
	   			else
	   			{
	   				arrValues.add("");
		   			arrValues.add("");
	   			}
	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				log.info("===ratingreqparams==="+arrValues);
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				}//end	
				
				if(strRatType.equalsIgnoreCase("1"))
				{
					if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("CORP") || Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("AGR"))
					{				
						//Added by Guhan for Kalypto table entry 
						 //* Calculate Kalypto ratio and Save the details in Kalpto Table
						 
						FinancialBean fOb	= new FinancialBean();
						int h=0,j=0,k=0;
						int intUpdatesize = 0;
						HashMap hshReqValues	= new HashMap();
						HashMap hshResult		= new HashMap();
						ArrayList vecyear			= new ArrayList();
						ArrayList yearvalue		= new ArrayList();
						ArrayList yearvalueStrt	= new ArrayList();
						
						hshReqValues.put("appno",strAppno);
						hshReqValues.put("pagefrom","RA3");
						hshReqValues.put("from", "1");
						hshReqValues.put("pagename", "FI");
						hshReqValues.put("rating", "Y");
						hshResult	= fOb.getDataRatio(hshReqValues);
	
						String  totalyear	= correctNull((String)hshResult.get("totalyear"));
						int totyr			= Integer.parseInt(totalyear);
	
						yearvalue			= (ArrayList)hshResult.get("yearvalue");
						yearvalueStrt			= (ArrayList)hshResult.get("yearvalueStrt");
	
						String[] Dates		= new String[totyr];//Date
						String[] DatesStrt	= new String[totyr];//Date strt
						String[] finType	= new String[totyr];
						ArrayList[] vecyears	= new ArrayList[totyr];
						ArrayList vecid1		= new ArrayList();
						
						log.info("===totalyear==="+totyr);
						
						for(h=0;h<(totyr);h++)
						{
							k=h+1;
							vecyears[h]=(ArrayList)hshResult.get("year"+k);
						}
						k=0;
						int m=0;
						
						for(h=0;h<totyr;h++)
						{
							DatesStrt[m]=(String)yearvalueStrt.get(h);
							m++;
						}
						
						for(h=0;h<2*totyr;h++)
						{
							if(h%2==0)
							{
								Dates[j]=(String)yearvalue.get(h);
								j++;							
							}
							else
							{
								finType[k]=(String)yearvalue.get(h);
								k++;
							}
						}
						vecid1=(ArrayList)hshResult.get("vecid1");
	
						hshQueryValues 	= new HashMap();
						hshQuery 		= new HashMap();
						arrValues		= new ArrayList();	
						String strKALYPTOcode="";
						
						for(int NoOfYears=0;NoOfYears<totyr;NoOfYears++)
						{
							for(h=0;h<vecid1.size();h++)
							{
								String strQuery = SQLParser.getSqlQuery("sel_kalyptocode_byrowid^"+vecid1.get(h));
					   			ResultSet rsKal = DBUtils.executeQuery(strQuery);
					   			if(rsKal.next())
					   			{
					   				strKALYPTOcode = Helper.correctNull((String)rsKal.getString("FIN_KALYPTO_CODE")); //KALYPTO PARAMETER CODE
					   			}
					   			
					   			if(!strKALYPTOcode.equalsIgnoreCase(""))
					   			{
									hshQueryValues 	= new HashMap();
									hshQuery 	= new HashMap();
									arrValues	= new ArrayList();	
									if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
									{
										hshQuery.put("strQueryId", "insuplratingreqparams_newconn");
									}
									else
									{
										hshQuery.put("strQueryId", "insuplratingreqparams");
									}
						   			arrValues.add(strAppno);
						   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
						   			arrValues.add(strKALYPTOcode);//KALYPTO code
									arrValues.add(vecyears[NoOfYears].get(h));//value
									arrValues.add("");//text value entry
									arrValues.add(DatesStrt[NoOfYears]);//Date
									arrValues.add(Dates[NoOfYears]);//Date
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("1",hshQuery);								
									hshQueryValues.put("size","1");
									
									if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
									{
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
									}
									else
									{
										EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
									}
					   			}
							}
						}
						//End by Guhan				
					}
							
					
					//By Guhan for Kalypto ratio passing to UPL_REQUEST_PERIODS table
					String strQuery5 = SQLParser.getSqlQuery("sel_ratingyears_kalypto^"+strAppno);
					ResultSet rs5 = DBUtils.executeQuery(strQuery5);
					while(rs5.next())
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQueryValues = new HashMap();
						hshQueryValues.put("size", "1");
						if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							hshQuery.put("strQueryId", "insuplreqperiod_newconn");
						}
						else
						{
							hshQuery.put("strQueryId", "insuplreqperiod");
						}
						arrValues.add(strAppno);
			   			arrValues.add(strAppno+"_"+Helper.correctNull((String)hshValues.get("hidModelCode")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINYEAR_START")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINYEAR")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("COM_FINTYPE")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("FINRATEYEAR_CURRENTYEAR")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("audit_name")));
			   			arrValues.add(Helper.correctNull((String)rs5.getString("is_compute")));
						hshQuery.put("arrValues", arrValues);
						log.info("===ProposalData==="+arrValues);
						
						hshQueryValues.put("1", hshQuery);	
						if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
						}
						else
						{
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						}
					}
					//webservice call
					//Moved to get method 
				}
			}
			else if(strAction.equalsIgnoreCase("undo"))
			{
				//Deleted in RAT_DATA
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "delriskdata");
	 			arrValues.add(strAppno);	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				log.info("===undoRiskdata==="+arrValues);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				//tO dELETE IN UPL_REQUEST_RESULT DATA
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "deluplratresultdata_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "deluplratresultdata");
				}
	 			arrValues.add(strAppno);	
	 			arrValues.add(struserid);
	 			hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===undodeluplresult==="+arrValues);
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				//END			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "creditratdelete_userid");	 			
	   			arrValues.add(strAppno);
	   			arrValues.add(struserid);	   			
	   			hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				log.info("===undocreditrat==="+arrValues);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");				
			}
			else if(strAction.equalsIgnoreCase("check"))
			{
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					String strQuery=SQLParser.getCBSSqlQuery("sel_upl_request_result_newconnection_user^"+strAppno+"^"+struserid+"^0");
					rs=DBUtils.executeQueryKalyptoConnection(strQuery);
				}
				else
				{
					String strQuery= SQLParser.getSqlQuery("sel_upl_request_result_user^"+strAppno+"^"+struserid);
					rs=DBUtils.executeQuery(strQuery); 
				}
				String strRATING_SCORE="",strRATING_LABEL="",strRatUserId="",strDateAson="",strratingyear="",stryeartype="";
				int b=1;
				if(rs.next())
				{				
				strRATING_SCORE=Helper.correctNull((String)rs.getString("rating_score"));
				strRATING_LABEL=Helper.correctNull((String)rs.getString("rating_label"));
				strRatUserId=Helper.correctNull((String)rs.getString("user_login_id"));
				strDateAson=Helper.correctNull((String)rs.getString("ason_date"));	
				strratingyear=Helper.correctNull((String)rs.getString("date_end"));
				stryeartype=Helper.correctNull((String)rs.getString("period_type"));	
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "creditratdelete_nonpool");
	   			arrValues.add(strAppno);
	   			arrValues.add(strRatUserId);	   			
	   			arrValues.add("Y");	   			
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===checkcreditratdelete==="+arrValues);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "creditratinsu");
	   			arrValues.add(strAppno);
	   			arrValues.add(String.valueOf(b));
	   			arrValues.add(strRATING_SCORE);
	   			arrValues.add("Y");
	   			arrValues.add(strRATING_LABEL);
	   			arrValues.add(strRatUserId);
	   			//arrValues.add(strDateAson);	
	   			arrValues.add(strratingyear);
	   			arrValues.add(stryeartype);	
	   			arrValues.add("Y");
	   			arrValues.add(strRMDUser);
	   			hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===checkcreditratinsu==="+arrValues);
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					hshQuery.put("strQueryId", "deluplratresultdata_newconn");
				}
				else
				{
					hshQuery.put("strQueryId", "deluplratresultdata");
				}
	 			arrValues.add(strAppno);	
	 			arrValues.add(struserid);
	 			hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				log.info("===undodeluplresult==="+arrValues);
				if(ApplicationParams.getKalyptoConnection().equalsIgnoreCase("TRUE"))
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateKalyptoData");	
				}
				else
				{
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				}
			}
			else if(strAction.equalsIgnoreCase("updateRoi"))
			{
				FacilitiesBean obj=new FacilitiesBean();
				obj.UpdateRoiBasedOnrating(hshValues);
				
			}
		    
		    
	
		} catch (Exception ce) {
			log.info("in bean... " + ce);
			throw new EJBException(ce.toString());
		}
	}
	public void updateinstacash(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction="";
		ResultSet rs=null;
		String strAppno="";
		int sno=0;
		try
		{
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				rs=DBUtils.executeLAPSQuery("sel_instasno^"+strAppno);
				if(rs.next()){
					sno=Integer.parseInt((String)Helper.correctInt(rs.getString("sno")));
				}
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId","ins_instacash");
				arrValues.add(strAppno);
				arrValues.add(Integer.toString(sno));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sectype")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_maturitydate")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_margin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_marginamt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_eligibleamt")));
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("update"))
			{
				sno=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidSno")));
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "1");
				hshQuery.put("strQueryId","del_instacash");
				arrValues.add(strAppno);
				arrValues.add(Integer.toString(sno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				rs=DBUtils.executeLAPSQuery("sel_instasno^"+strAppno);
				if(rs.next()){
					sno=Integer.parseInt((String)Helper.correctInt(rs.getString("sno")));
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size", "2");
				hshQuery.put("strQueryId","ins_instacash");
				arrValues.add(strAppno);
				arrValues.add(Integer.toString(sno));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_sectype")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_maturitydate")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_margin")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_marginamt")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_eligibleamt")));
				hshQuery.put("arrValues",arrValues);	
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				sno=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidSno")));
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				
				hshQuery.put("strQueryId","del_instacash");
				arrValues.add(strAppno);
				arrValues.add(Integer.toString(sno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size", "1");
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

			}
			
			String strAmtsum="";
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_instaamt_sum^"+strAppno);
			if(rs.next()){
				strAmtsum=Helper.correctDouble(rs.getString("amtsum"));
			}
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			
			hshQuery.put("strQueryId","upd_costofloan_loandetails_pI");
			arrValues.add(strAmtsum);
			arrValues.add(strAppno);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQueryValues.put("size", "1");
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}catch(Exception e)
		 {
			throw new EJBException(LAlerts.EXCEPTION+"Exception caught");
	     }
		
	}
	public void updateAgricultureGold(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction="";
		ResultSet rs=null;
		String strAppno="";
		int size=0;
		int intUpdatesize=0;
		try
		{
			
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			int strRow1=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidrow1")));
			int strRow2=Integer.parseInt(Helper.correctInt((String)hshValues.get("hidrow2")));
			strRow1=strRow1-2;
			strRow2=strRow2-2;
			strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				
				String[] strArea= null;
				String[] strDesc= null;
				String[] strUnitCost= null;
				String[] strAmount= null;
				
				hshQueryValues = new HashMap();
				//agr_goldloan_assessment table Insert
				intUpdatesize=intUpdatesize+1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delagriassessment");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				//agr_goldloan_assessmentvalues table delete
				intUpdatesize=intUpdatesize+1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delagriassessmentvalues");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","insagriassessment");
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_agrtype")));
				arrValues.add(Helper.correctNull((String)hshValues.get("sel_typeofloan")));
				if(Helper.correctNull((String)hshValues.get("sel_agrtype")).equalsIgnoreCase("D"))
				{
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_totalcost1")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_pertotalcost1")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_eligibleamt1")));
				}else{
					if(Helper.correctNull((String)hshValues.get("sel_typeofloan")).equalsIgnoreCase("C"))
					{
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_harvestexp")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_postharvestexp")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_scaleamt")));
					}
					else if(Helper.correctNull((String)hshValues.get("sel_typeofloan")).equalsIgnoreCase("A"))
					{
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_recurramt")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_recurrexp")));
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_eligibleamt")));
					}
					else{
						arrValues.add(Helper.correctNull((String)hshValues.get("")));
						arrValues.add(Helper.correctNull((String)hshValues.get("")));
						arrValues.add(Helper.correctNull((String)hshValues.get("")));
					}
				}
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				hshQueryValues.put("size", ""+intUpdatesize);
				
				//agr_goldloan_assessmentvalues table insert
				if((Helper.correctNull((String)hshValues.get("sel_typeofloan")).equalsIgnoreCase("C"))||(Helper.correctNull((String)hshValues.get("sel_agrtype")).equalsIgnoreCase("D")))
				{
					if(Helper.correctNull((String)hshValues.get("sel_agrtype")).equalsIgnoreCase("D"))
					{
						size=strRow1;
						if(hshValues.get("txt_unitcost") instanceof java.lang.String)
						 {
							strArea= new String[1];
							strArea[0]=(String)hshValues.get("txt_unitcost");
						 }else{
							 strArea=(String [])hshValues.get("txt_unitcost");
						 }
						if(hshValues.get("txt_activity") instanceof java.lang.String)
						 {
							strDesc= new String[1];
							strDesc[0]=(String)hshValues.get("txt_activity");
						 }else{
							 strDesc=(String [])hshValues.get("txt_activity");
						 }
						if(hshValues.get("txt_noofunits") instanceof java.lang.String)
						 {
							strUnitCost= new String[1];
							strUnitCost[0]=(String)hshValues.get("txt_noofunits");
						 }else{
							 strUnitCost=(String [])hshValues.get("txt_noofunits");
						 }
						if(hshValues.get("txt_totalcost") instanceof java.lang.String)
						 {
							strAmount= new String[1];
							strAmount[0]=(String)hshValues.get("txt_totalcost");
						 }else{
							 strAmount=(String [])hshValues.get("txt_totalcost");
						 }
						
					}
					else
					{
						size=strRow2;
						if(hshValues.get("txt_area") instanceof java.lang.String)
						 {
							strArea= new String[1];
							strArea[0]=(String)hshValues.get("txt_area");
						 }else{
							 strArea=(String [])hshValues.get("txt_area");
						 }
						if(hshValues.get("txt_natureofcrops") instanceof java.lang.String)
						 {
							strDesc= new String[1];
							strDesc[0]=(String)hshValues.get("txt_natureofcrops");
						 }else{
							 strDesc=(String [])hshValues.get("txt_natureofcrops");
						 }
						if(hshValues.get("txt_scaleoffinance") instanceof java.lang.String)
						 {
							strUnitCost= new String[1];
							strUnitCost[0]=(String)hshValues.get("txt_scaleoffinance");
						 }else{
							 strUnitCost=(String [])hshValues.get("txt_scaleoffinance");
						 }
						if(hshValues.get("txt_amt") instanceof java.lang.String)
						 {
							strAmount= new String[1];
							strAmount[0]=(String)hshValues.get("txt_amt");
						 }else{
							 strAmount=(String [])hshValues.get("txt_amt");
						 }
					}
				
				
					for(int i=0;i<size;i++)
					{
						intUpdatesize=intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insagriassessmentvalues");
						arrValues.add(strAppno);
						arrValues.add((i+1)+"");
						arrValues.add(strArea[i]);
						arrValues.add(strDesc[i]);
						arrValues.add(strUnitCost[i]);
						arrValues.add(strAmount[i]);
						arrValues.add(Helper.correctNull((String)hshValues.get("sel_agrtype")));
						arrValues.add(Helper.correctNull((String)hshValues.get("sel_typeofloan")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize,hshQuery);
						hshQueryValues.put("size", ""+intUpdatesize);
					}
				
				}
				
			}else if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				//agr_goldloan_assessment table delete
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delagriassessment");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				//agr_goldloan_assessmentvalues table delete
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delagriassessmentvalues");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				hshQueryValues.put("size", "2");
				
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			hshQueryValues=new HashMap();
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQuery.put("strQueryId", "del_date");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("size","1");
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
		}catch(Exception e)
		 {
			throw new EJBException(LAlerts.EXCEPTION+"Exception caught");
	     }
		
	}
	public  HashMap getinstacash(HashMap hshValues) 
	{
		try {
			HashMap hshQueryValues = new HashMap();
			HashMap hshQuery = null;
			ArrayList arrValues=new ArrayList();
			ArrayList arrCol=new ArrayList();
			ResultSet rs=null;
			String strAppno="";
			String securitytype="",securitytype1="";
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			rs=DBUtils.executeLAPSQuery("sel_instacash^"+strAppno);
			while(rs.next()){
				arrCol=new ArrayList();
				arrCol.add(rs.getString("insta_sno"));//1
				securitytype=rs.getString("insta_sectype");
				if(securitytype.equalsIgnoreCase("fv")){
					securitytype1="Face Value of NSC/KVP";
				}else if(securitytype.equalsIgnoreCase("sv")){
					securitytype1="Surrender Value of Life Policies / Post Office TD";
				}else{
					securitytype1="";
				}
				arrCol.add(securitytype1);//2
				arrCol.add(rs.getString("insta_amount"));//3/
				arrCol.add(rs.getString("insta_maturitydate"));//4
				arrCol.add(rs.getString("insta_margin"));//5
				arrCol.add(rs.getString("insta_marginamt"));//6
				arrCol.add(rs.getString("insta_eligibleamt"));//7
				arrCol.add(securitytype);//8
				arrValues.add(arrCol);
			}
			hshValues.put("ArrRow",arrValues);
			
			if(rs!=null) rs.close();
			rs = DBUtils.executeLAPSQuery("sel_pageid_PSapp^"+strAppno);
			if(rs.next())
			{
				hshValues.put("strModifyterms", "@"+Helper.correctNull(rs.getString("ps_modify_terms")));
			}
		}
		catch (Exception ce) {
			log.error("in bean... " + ce);
			throw new EJBException(ce.toString());
		}
		return hshValues;
	
	}
	
	public void updateotherratingParameters(HashMap hshValues)  {
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		ArrayList arr=new ArrayList();
		
		String strAppno="",strSno="0";
		String strAction="";
		ResultSet rs=null,rs1=null;
		try {
		
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno = correctNull((String)hshValues.get("appno"));
			//strSno=Helper.correctInt((String)hshValues.get("hidsno"));
			if(strAction.equalsIgnoreCase("insert"))
			{
				// added by Ram Prasad for rating other details
				if(strSno.equalsIgnoreCase("0")){
				if(rs !=null)
				{rs.close();}
				rs=DBUtils.executeLAPSQuery("sel_ratingsno^"+strAppno);
				if(rs.next())
				{
					strSno=Helper.correctInt(rs.getString("ratsno"));
				}
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arr=new ArrayList();
				
				hshQuery.put("strQueryId","ins_rating_year");
				hshQueryValues.put("size", "1");
				arr.add(Helper.correctNull((String)hshValues.get("txt_yrrating")));
				arr.add(Helper.correctNull((String)hshValues.get("sel_financial")));
				arr.add(Helper.correctNull((String)hshValues.get("sel_yrdating")));
				arr.add(strAppno);
				arr.add(strSno);
				arr.add("");
				hshQuery.put("arrValues", arr);
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
		    }
			else if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arr=new ArrayList();
				
				hshQuery.put("strQueryId","upd_rating_year");
				hshQueryValues.put("size", "1");
				arr.add(Helper.correctNull((String)hshValues.get("txt_yrrating")));
				arr.add(Helper.correctNull((String)hshValues.get("sel_financial")));
				arr.add(Helper.correctNull((String)hshValues.get("sel_yrdating")));
				arr.add(strAppno);
				arr.add(strSno);
				hshQuery.put("arrValues", arr);
				hshQueryValues.put("1", hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");	
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues = new HashMap();
				hshQueryValues.put("size", "1");
	 			hshQuery.put("strQueryId", "del_rating_year");
	   			arrValues.add(strAppno);
//	   			arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);	
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				 
				
			}
			else if(strAction.equalsIgnoreCase("print"))
			{
				
				String strTermSno[]=null,strPrint[]=null;
				if(hshValues.get("hidsno") instanceof java.lang.String)
				{
					strTermSno= new String[1];
					strPrint= new String[1];
					strTermSno[0]=(String)hshValues.get("hidsno");
					strPrint[0]=(String)hshValues.get("hid_print");
				}
				else
				{
					strTermSno=(String[])hshValues.get("hidsno");
					strPrint=(String[])hshValues.get("hid_print");
				}
				
				hshQueryValues=new HashMap();
				
				int intsize=0;
				for(int i=0;i<strTermSno.length;i++)
				{
					intsize++;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size", String.valueOf(intsize));
		 			hshQuery.put("strQueryId", "upd_ratdatarating");
		   			arrValues.add(strPrint[i]);
		   			arrValues.add(strAppno);
		   			arrValues.add(strTermSno[i]);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put(String.valueOf(intsize), hshQuery);	
				}
				if(intsize>0)
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			}


		
			
		   } catch (Exception ce) {
			log.info("in bean... " + ce);
			throw new EJBException(ce.toString());
		}

	
}
	public  HashMap getotherratingParameters(HashMap hshValues) 
	{
		HashMap hshRecord =new HashMap();
		ArrayList arrcol=new ArrayList();
    	ArrayList arrRow=new ArrayList();
    	HashMap hshQueryValues = new HashMap();
    	HashMap hshQuery = new HashMap();
		ArrayList arr=new ArrayList();
		int intsize=0;
		try {
			ResultSet rs=null,rs1=null;
			String strAppno=Helper.correctNull((String)hshValues.get("appno"));
			String strFinancialType="";
			//added by Ramprasad
			
			if(Helper.correctNull((String)hshValues.get("strappstatus")).equalsIgnoreCase("op"))
			{
				String strFinID="",strFinYear="",strFinType="";
				rs=DBUtils.executeLAPSQuery("sel_rating_year^"+strAppno);
				if(!rs.next())
				{
					hshQueryValues = new HashMap();
					rs1=DBUtils.executeLAPSQuery("sel_previousRMDRating^"+Helper.correctNull((String)hshValues.get("hidapplicantid"))+"^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
					while(rs1.next())
					{
						if(!((Helper.correctNull(rs1.getString("RATING_YEAR")).equalsIgnoreCase(strFinYear))&& (Helper.correctNull(rs1.getString("RATING_YEARTYPE")).equalsIgnoreCase(strFinType))
								&& (Helper.correctNull(rs1.getString("DEMO_FINSTANDARD")).equalsIgnoreCase(strFinID))))
						{
							
							intsize++;
							hshQuery = new HashMap();
							arr=new ArrayList();
							
							hshQuery.put("strQueryId","ins_rating_year");
							hshQueryValues.put("size", String.valueOf(intsize));
							arr.add(Helper.correctNull(rs1.getString("RATING_YEAR")));
							arr.add(Helper.correctNull(rs1.getString("RATING_YEARTYPE")));
							arr.add(Helper.correctNull(rs1.getString("CRE_WEIGHT")));
							arr.add(strAppno);
							arr.add(String.valueOf(intsize));
							arr.add(Helper.correctNull(rs1.getString("cre_appno")));
							hshQuery.put("arrValues", arr);
							hshQueryValues.put(String.valueOf(intsize), hshQuery);
							
							
							strFinID=Helper.correctNull(rs1.getString("DEMO_FINSTANDARD"));
							strFinYear=Helper.correctNull(rs1.getString("RATING_YEAR"));
							strFinType=Helper.correctNull(rs1.getString("RATING_YEARTYPE"));
						}
					}
					
					if(intsize>0)
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
			
			if(rs!=null)
			{
				rs.close();
			}					
			rs=DBUtils.executeLAPSQuery("sel_rating_year^"+strAppno);
			while(rs.next())
			{
				arrcol=new ArrayList();
				arrcol.add(Helper.correctNull((String)rs.getString("RDR_YEAR")));
				strFinancialType=Helper.correctNull((String)rs.getString("RDR_FINANCIAL"));
				if(strFinancialType.equalsIgnoreCase("a")){
					
					strFinancialType="Audited";
				}
				else if(strFinancialType.equalsIgnoreCase("e")){
					strFinancialType="Estimated";
				}
				else if(strFinancialType.equalsIgnoreCase("u")){
					strFinancialType="Unaudited";
				}
				else if(strFinancialType.equalsIgnoreCase("p")){
					strFinancialType="Projection";
				}
				else {
					strFinancialType="";
				}
				arrcol.add(Helper.correctNull((String)rs.getString("RDR_FINANCIAL")));
				arrcol.add(Helper.correctNull((String)rs.getString("RDR_RATING")));
				arrcol.add(Helper.correctNull((String)rs.getString("rdr_sno")));
				arrcol.add(strFinancialType);
				arrcol.add(Helper.correctNull((String)rs.getString("rat_rmdprint")));
				arrcol.add(Helper.correctNull((String)rs.getString("rdr_parentappno")));				
				arrRow.add(arrcol);
		    }
			
			hshRecord.put("arrRowRating", arrRow);
		
			rs=DBUtils.executeLAPSQuery("seldigiprd_appl^"+strAppno);
			if (rs.next()) 
			{
				hshRecord.put("APP_LOANSUBTYPE_DIGI", correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
				
			}
		
		
		}
		catch (Exception ce) {
			log.info("in bean... " + ce);
			throw new EJBException(ce.toString());
		}
		return hshRecord;
	
	}
	
	public HashMap getAgricultureGold(HashMap hshValues) 
	{
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);	
		
		ResultSet rs = null;
		String strAppno="";
		ArrayList arryRow=new ArrayList();
		ArrayList arryCol=new ArrayList();
		String strAgriType="",strLoanType="",strQuery="";
		try
		{
			strAppno=Helper.correctNull((String)hshValues.get("appno"));
			strAgriType=Helper.correctNull((String)hshValues.get("sel_agrtype"));
			strLoanType=Helper.correctNull((String)hshValues.get("sel_typeofloan"));
			
			if(rs!=null){rs.close();}
			if((strAgriType.equalsIgnoreCase("")||strAgriType.equalsIgnoreCase("S"))&&(strLoanType.equalsIgnoreCase("")||strLoanType.equalsIgnoreCase("S")))
			{
				rs=DBUtils.executeLAPSQuery("selectagriassessment^"+strAppno);		 
				if(rs.next())
				{
					strAgriType=Helper.correctNull(rs.getString("agr_typeofagri"));
					strLoanType=Helper.correctNull(rs.getString("agr_typeofloan"));
				}
			}
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("selagriassessment^"+strAppno+"^"+strAgriType+"^"+strLoanType);		 
			if(rs.next())
			{
				hshValues.put("agr_totalamt", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_totalamt")))));
				hshValues.put("agr_margin_amt", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_margin_amt")))));
				hshValues.put("agr_eligible_amt", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_eligible_amt")))));
			}
			hshValues.put("agr_typeofagri",strAgriType);
			hshValues.put("agr_typeofloan", strLoanType);
			
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("selagriassessmentvalues^"+strAppno+"^"+strAgriType+"^"+strLoanType);			 
			while(rs.next())
			{
				arryCol=new ArrayList();
				arryCol.add(Helper.correctNull(rs.getString("agr_sno")));
				arryCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_area")))));
				arryCol.add(Helper.correctNull(rs.getString("agr_activity")));
				arryCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_unitcost")))));
				arryCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("agr_totalamt")))));
				arryRow.add(arryCol);
			}
			hshValues.put("arryRow", arryRow);
			
			double dblRecurrexpMargin=0.00,dblAgridevelopMargin=0.00;
			
			String strFlag="Y";
			if(rs!=null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("selloanagainstparams^118");
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				if(!Helper.correctNull((String)rs.getString("LOAN_PARAMVAL")).equalsIgnoreCase(""))
				{
					if((Helper.dateDiff(Helper.correctNull((String)rs.getString("LOAN_PARAMVAL")), Helper.correctNull((String)hshValues.get("strAppCreateDate"))))>=0)
						strFlag="N";	
				}
			}
			
			if(strFlag.equalsIgnoreCase("Y"))
			{
				if(rs!=null){rs.close();}
				strQuery = SQLParser.getSqlQuery("selgoldratemaster^Y");
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					dblRecurrexpMargin=100-rs.getDouble("grm_recurrexpmargin");
					dblAgridevelopMargin=100-rs.getDouble("grm_agridevelopmargin");
					hshValues.put("dblRecurrexpMargin", jtn.format(dblRecurrexpMargin));
					hshValues.put("dblAgridevelopMargin",  jtn.format(dblAgridevelopMargin));
				}
			}
			else
			{
				String strRecAmt="";
				String strLesser = ">=";
				String strGreater = "<=";
				strQuery=SQLParser.getSqlQuery("sel_loandetails^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strRecAmt=Helper.correctDouble(rs.getString("loan_amtreqd"));
				}
				
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("selmarginrate^" + Helper.correctNull((String)hshValues.get("prdcode")) + "^" + strGreater + "^" + strRecAmt + "^"
						+ strLesser + "^" + strRecAmt);

				rs = DBUtils.executeQuery(strQuery);

				if (rs.next())
				{
					dblRecurrexpMargin=100-rs.getDouble("margin_perct_recurring");
					dblAgridevelopMargin=100-rs.getDouble("margin_perct_allied");
					hshValues.put("dblRecurrexpMargin", jtn.format(dblRecurrexpMargin));
					hshValues.put("dblAgridevelopMargin",  jtn.format(dblAgridevelopMargin));
						
				}
			}
			
			
			if(rs!=null){rs.close();}
			rs=DBUtils.executeLAPSQuery("sel_land_holding_landvalue^"+strAppno);			 
			if(rs.next())
			{
				hshValues.put("dblLandValue", jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("land_hectare")))));
			}
		}
		catch (Exception ce)
		{
			throw new EJBException("Error in closing getAgricultureGold" + ce.getMessage());
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
		return hshValues;
	}
	public HashMap getCusGroupApplicantIDHelp(HashMap hshRequestValues)  
	{
		ResultSet rs=null;
		ResultSet rs1=null;
		HashMap hshRecord=new HashMap();
		String strExp = "$";
		String strVal="";
		String strDemoStatus="";
		String strCBSStatus="";
		ArrayList arryCol = new ArrayList();
		ArrayList arryRow = new ArrayList();
		String strQuery="";
		String strQuery1="";
		boolean bState=false;
		String strSearchCategory=Helper.correctNull((String)hshRequestValues.get("radiobutton"));
		String strSearchText=Helper.correctNull((String)hshRequestValues.get("bow_name"));
		try
		{
			if(rs!=null)
			{rs.close();}
			if(strSearchCategory.equalsIgnoreCase("LAPSID"))
			{
				strQuery1="and perapp_id = \'"+strSearchText+"\'";
				strQuery= SQLParser.getSqlQuery("pergetgroupmembersAppidhelp^"+strQuery1);
			}
			else if(strSearchCategory.equalsIgnoreCase("CBSID"))
			{
				strQuery1="and perapp_cbsid = \'"+strSearchText+"\'";
				strQuery= SQLParser.getSqlQuery("pergetgroupmembersAppidhelp^"+strQuery1);
			}
			else if(strSearchCategory.equalsIgnoreCase("NAME"))
			{
				strQuery1="and  upper(perapp_fname) like upper (\'%"+strSearchText+"%\')";
				strQuery= SQLParser.getSqlQuery("pergetgroupmembersAppidhelp^"+strQuery1);
			}
			rs =DBUtils.executeQuery(strQuery);
			bState=rs.next();
			if(!bState)
			{
				hshRecord.put("noData","noData");
			}
			while(bState)
			{
				arryCol=new ArrayList();
				String strCityCode=Helper.correctNull((String)rs.getString("con_comcity"));
				String strStateCode=Helper.correctNull((String)rs.getString("con_comstate"));
				String strCityDesc="";
				String strStateDesc="";
				String strQuery2="";
				strQuery2=SQLParser.getSqlQuery("sel_citynamebycode^"+strCityCode);
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					strCityDesc=Helper.correctNull((String)rs1.getString("city_name"));
				}
				strQuery2=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					strStateDesc=Helper.correctNull((String)rs1.getString("state_name"));
				}
				arryCol.add(rs.getString(1));
				arryCol.add(rs.getString(2));
				arryCol.add(rs.getString("perapp_cbsid"));
				arryCol.add(rs.getString("perapp_oldid"));
				
				
				strQuery2=SQLParser.getSqlQuery("selcusgroupmemberschk^"+Helper.correctNull((String)rs.getString("perapp_id")));
				rs1=DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					arryCol.add(Helper.correctNull(rs1.getString("cgm_groupname")));
					arryCol.add(Helper.correctNull(rs1.getString("cgm_groupid")));
					arryCol.add("Y");
				}
				else
				{
					arryCol.add("");
					arryCol.add("");
					arryCol.add("N");
				}
				
				arryRow.add(arryCol);
				strDemoStatus=Helper.correctNull((String)rs.getString("perapp_profilestatus"));
				strCBSStatus=Helper.correctNull((String)rs.getString("perapp_cbsstatus"));
				bState=rs.next();
			}
			hshRecord.put("arryRow",arryRow);
			
			if(bState)
			{
				if(strDemoStatus.equalsIgnoreCase("Y") && strCBSStatus.equalsIgnoreCase("Y"))
				{
				//No Function
				}
				else
				{
					strExp=strExp+"Customer Profile is not filled completely";
					throw new Exception(strExp);
				}
			}
		} 
		catch(Exception e)
		{
			throw new EJBException(e.getMessage());
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
			catch(Exception e1)
			{
				throw new EJBException(e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getCIBILReport(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		ResultSet rs1 =null;
		HashMap hshRecord = new HashMap();
		HashMap hshResultProcCall = new HashMap();
		String strAppno = (String) hshRequestValues.get("appno");
		List arrRow = new ArrayList();
		List arrCol = null;
		String strQuery="",strQuery1 = "",strGenAppID="",strGeneratedFlag="", strCIBILDayDiff="";	
		String strAppId = "",strReqStatus = "",strOverAllStatus = "",strStatus="",strReqID="",strActionFlag="";
		boolean flag = false;
		try
		{	
			String sessionModuleType=Helper.correctNull((String) hshRequestValues.get("sessionModuleType"));
			if(sessionModuleType.equals(""))
			{
				sessionModuleType=Helper.correctNull((String) hshRequestValues.get("hidCategoryType"));
			}
			hshRecord.put("appholder", Helper.correctNull((String) hshRequestValues.get("appholder")));
			
			String hidPageId=Helper.correctNull((String) hshRequestValues.get("hidPageId"));
			if(hidPageId.equals("BureauReport"))
			{
				strAppno=Helper.correctNull((String) hshRequestValues.get("hidBRappno"));
				strQuery=SQLParser.getSqlQuery("getapp_BureauLink^"+strAppno);
			}
			else
			{
				if(sessionModuleType.equals("RET"))
				{
					strQuery=SQLParser.getSqlQuery("getappcoappguarantor^"+strAppno);
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("getappcoappguarantor_corp"+"^"+strAppno+"^"+strAppno+"^"+strAppno+"^"+strAppno);
				}
			}
			rs=DBUtils.executeQuery(strQuery);
			while (rs.next())
			{
				strAppId = strReqStatus = strOverAllStatus = strStatus = strGeneratedFlag = strCIBILDayDiff = strReqID = "";
				
				arrCol = new ArrayList();
				arrCol.add(correctNull(rs.getString("demo_appid"))); //0
				arrCol.add(correctNull(rs.getString("appname"))); //1
				arrCol.add(correctNull(rs.getString("demo_type"))); //2
				arrCol.add(""); //3
				arrCol.add(""); //4
				arrCol.add(correctNull(rs.getString("creditappid"))); //5
				arrCol.add(correctNull(rs.getString("PERAPP_STATUS"))); //6
				arrCol.add(""); //7
				arrCol.add(correctNull(rs.getString("perapp_employment"))); //8
				strAppId = correctNull(rs.getString(1));
				/*strQuery1=SQLParser.getSqlQuery("check_proc_call^"+strAppno+"^"+strAppId);
				rs1=DBUtils.executeQuery(strQuery1);
				if (rs1.next())
				{
					flag = true;
					strReqID = correctNull(rs1.getString("REQUEST_ID"));
					strReqStatus = correctNull(rs1.getString("REQUEST_STATUS"));
					strOverAllStatus = correctNull(rs1.getString("HM_STATUS"));
				}	
				if(rs1!=null) rs1.close();*/
				
				hshRequestValues.put("hidAppIdVal", strAppId);
				hshResultProcCall = (HashMap)EJBInvoker.executeStateLess("perfinancial", hshRequestValues, "cibilReportCheckProcCall");
				strReqStatus = Helper.correctNull((String) hshResultProcCall.get("strReqStatus"));
				strOverAllStatus = Helper.correctNull((String) hshResultProcCall.get("strOverAllStatus"));
				strReqID = Helper.correctNull((String) hshResultProcCall.get("strReqID"));
				strActionFlag = Helper.correctNull((String) hshResultProcCall.get("strCIBILAction"));
				if("Y".equalsIgnoreCase(Helper.correctNull((String) hshResultProcCall.get("strResultFlag"))))
				{
					flag = true;
				}
				
				/*strQuery1=SQLParser.getSqlQuery("check_proc_call^"+strAppno+"^"+strAppId);
				rs1=DBUtils.executeQuery(strQuery1);
				if (rs1.next()){					
					strOverAllStatus = correctNull(rs1.getString("HM_STATUS"));
				}	
				if(rs1!=null) rs1.close();*/
				
				if(strReqStatus.equalsIgnoreCase("1")){
					strStatus = "I";
				}
				if(strReqStatus.equalsIgnoreCase("5")){
					strStatus = "P";
				}				
				else if(strReqStatus.equalsIgnoreCase("9") && strOverAllStatus.equalsIgnoreCase("FINISH")){
					strStatus = "S";
				}
				else if(strReqStatus.equalsIgnoreCase("9")){
					strStatus = "PS";
				}
				arrCol.add(strStatus); //9
				
				if(strStatus.equalsIgnoreCase("S")){
					strQuery1=SQLParser.getSqlQuery("select_refno_blobdata^"+strAppno+"^"+strAppId+"^"+strReqID);
					rs1=DBUtils.executeQuery(strQuery1);
					if (rs1.next()){					
						arrCol.add(correctNull(rs1.getString("hwc_refno"))); //10
						strCIBILDayDiff = correctNull(rs1.getString("dayDiff"));
						strGeneratedFlag = "Y";
					}else{
						arrCol.add(""); //10
						strGeneratedFlag = "";
					}
					if(rs1!=null) rs1.close();
				}else{
					arrCol.add("");	//10
					strGeneratedFlag = "";	
				}
				arrCol.add(strOverAllStatus); //11
				arrCol.add(strGeneratedFlag); //12
				
				if(!"".equals(strCIBILDayDiff))
				{
					if(strCIBILDayDiff.indexOf(" ") != -1)
					{
						strCIBILDayDiff = strCIBILDayDiff.substring(0, strCIBILDayDiff.indexOf(" "));
					}
					if (Integer.parseInt(Helper.correctInt(strCIBILDayDiff)) >= Integer.parseInt(strCIBILRenew)) {
						strCIBILDayDiff = "Y";
					}
					else
						strCIBILDayDiff = "N";
				}
				else
				{
					strCIBILDayDiff="N";
				}
				
				arrCol.add("N"); //13
				arrCol.add(correctNull(rs.getString("demo_cibil"))); //14
				arrCol.add(strActionFlag); //15
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
			if(flag){
			  hshRecord.put("initStatus","Comp");
			}else{
			  hshRecord.put("initStatus","NoComp");
			}
			//column not available -- --harish check
			/*
				strQuery=SQLParser.getSqlQuery("get_Appstatus^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					hshRecord.put("app_liabfreeze", Helper.correctNull(rs.getString("app_liabfreeze")));
				}
			*/
			if(rs!=null){
				rs.close();
			}
			strGenAppID = Helper.correctNull((String) hshRequestValues.get("hidAppIdVal"));
			if(!"".equals(strGenAppID))
			{
				/*strQuery=SQLParser.getSqlQuery("check_proc_call^"+strAppno+"^"+strGenAppID);
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strReqStatus = correctNull(rs.getString("REQUEST_STATUS"));
					strOverAllStatus = correctNull(rs.getString("HM_STATUS"));
					if("9".equals(strReqStatus) && !"".equals(strOverAllStatus))
					{
						if("FINISH".equalsIgnoreCase(strOverAllStatus))
						{
							hshRecord.put("gen_appstatus", "Generated Successfully!!");
						}
						else
						{
							hshRecord.put("gen_appstatus", strOverAllStatus);
						}
					}
				}*/
				hshResultProcCall =  new HashMap();
				hshResultProcCall = (HashMap)EJBInvoker.executeStateLess("perfinancial", hshRequestValues, "cibilReportCheckProcCall");
				strReqStatus = Helper.correctNull((String) hshResultProcCall.get("strReqStatus"));
				strOverAllStatus = Helper.correctNull((String) hshResultProcCall.get("strOverAllStatus"));
				strReqID = Helper.correctNull((String) hshResultProcCall.get("strReqID"));
				if("9".equals(strReqStatus) && !"".equals(strOverAllStatus))
				{
					if("FINISH".equalsIgnoreCase(strOverAllStatus))
					{
						hshRecord.put("gen_appstatus", "Generated Successfully!!");
					}
					else
					{
						hshRecord.put("gen_appstatus", strOverAllStatus);
					}
				}
			}
			
			hshRecord.put("strappstatus", Helper.correctNull((String) hshRequestValues.get("strappstatus")));
			hshRecord.put("hidBRappno", Helper.correctNull((String) hshRequestValues.get("hidBRappno")));
			
			if(hidPageId.equals("BureauReport"))
			{
				if (rs != null)
					rs.close();
				strQuery = SQLParser.getSqlQuery("getBureaudetails^"+strAppno);
				rs =DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("app_createdusr",correctNull(rs.getString("created_usrid")));
				}
			}
		}
		catch (Exception e)
		{
			log.error("Error occurred in getCIBILReport:: " + e.getMessage());
			throw new EJBException(e);
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
				
				if (rs1 != null)
					rs1.close();
			}
			catch (Exception e1)
			{
				log.error("Error in closing connection: " + e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap getCIBILRegenerate(HashMap hshRequestValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshData = new HashMap();
		List arrValues=new ArrayList();
		String strAppno = (String) hshRequestValues.get("appno");
		String strQuery = "",strGenAppID="",strRefNo="";
		try
		{	
			strGenAppID = Helper.correctNull((String) hshRequestValues.get("hidAppIdVal"));
			strQuery = SQLParser.getSqlQuery("sel_hw_cibil_details^"+strAppno+"^"+strGenAppID);
			rs=DBUtils.executeQuery(strQuery); 				
			 if(rs.next()){
				 strRefNo = Helper.correctNull(rs.getString("hwc_refno"));
			 }
			 if (rs != null)
				rs.close();
			 
			//Delete HW_CIBIL_DETAILS table record
			 hshRequestValues.put("size","1");
			hshData = new HashMap();
			arrValues = new ArrayList();
			hshData.put("strQueryId", "del_hw_cibil_details");
			arrValues.add(strAppno);
			arrValues.add(strGenAppID);
			hshData.put("arrValues", arrValues);			
			hshRequestValues.put("1", hshData);			 
			
			//Delete HW_CIBIL_BLOBDATA table record
			hshData = new HashMap();
			arrValues = new ArrayList();
			hshData.put("strQueryId", "del_hw_cibil_blobdata");
			arrValues.add(strRefNo);
			hshData.put("arrValues", arrValues);
			hshRequestValues.put("2", hshData);
				
			hshRequestValues.put("size","2");
			EJBInvoker.executeStateLess("dataaccess", hshRequestValues, "updateData");
			 
			 // Generate button Function
			hshRecord =(HashMap)	EJBInvoker.executeStateLess("perfinancial",(HashMap) hshRequestValues,"invokeProcedureCIBIL");
			//hshRecord.put("pr_cheque_no", hshData.get("pr_cheque_no"));
			
			
		}
		catch (Exception e)
		{
			log.error("Error occurred in getCIBILRegenerate:: " + e.getMessage());
			throw new EJBException(e);
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
				
			}
			catch (Exception e1)
			{
				log.error("Error in closing connection: " + e1.getMessage());
			}
		}
		return hshRecord;
	}
	
	public HashMap updateDigiLoanProducts(HashMap hshValues) 
	{
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		HashMap hshData = new HashMap();
		List arrValues=new ArrayList();
		String strAppno = (String) hshValues.get("appno");
		String strQuery = "",strGenAppID="",strRefNo="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		try
		{	
			
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();
			hshQuery.put("strQueryId", "upd_digi_mlssgovtdata");
			arrValues = new ArrayList();
			arrValues.add(Helper.correctNull((String) hshValues.get("sel_Processed_Type"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_metloanpremium"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_premium_tenor"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_premium_loan_amt"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_premium_Account_no"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("sel_Funded_Comp_Name"))); 
			//arrValues.add(Helper.correctNull((String) hshValues.get("selectgovt"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("sub"))); 
			//arrValues.add(Helper.correctNull((String) hshValues.get("schemetype"))); 
			//arrValues.add(Helper.correctNull((String) hshValues.get("sel_sponser_agency"))); 
			//arrValues.add(Helper.correctNull((String) hshValues.get("sel_subsidytype"))); 
			//arrValues.add(Helper.correctNull((String) hshValues.get("txt_agency"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_amtreqd"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_amtreqd"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_reqterms"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtmonPay"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_fileNo"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_costloanprd"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("selmodepayment"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_operativeaccno"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_SecValue"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSBankName"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSaccnttype"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSoperaccno"))); 
			arrValues.add(Helper.correctNull((String) hshValues.get("sel_ECSauthmode")));
			arrValues.add(Helper.correctNull((String) hshValues.get("txt_ECSifsccode")));
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_SecValueformort")));
			arrValues.add(Helper.correctNull((String) hshValues.get("hidtxtduedate")));
			arrValues.add(Helper.correctNull((String) hshValues.get("txtloan_procfee")));     //added LOAN_PROFEE
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQueryValues.put("1", hshQuery);
			hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			
			hshQueryValues = new HashMap();
			arrValues = new ArrayList();
			hshQuery = new HashMap();
			hshQueryValues.put("size", "1");
			arrValues.add(strAppno);
			hshQuery.put("arrValues", arrValues);
			hshQuery.put("strQueryId", "del_date");
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
			
			boolean bankingentry = true;
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_Bankingval^"+strAppno+"^ and combk_credittype='P'");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				bankingentry = false;
			}
			
			String strPrdCode="",strAppOldID="",strmodintrate="",strpurposeofloan="",strrepaytype="",strinttype="",strmclrtype="";
			
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_roiUpdate_mclrdate^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPrdCode=Helper.correctNull(rs.getString("APP_PRDCODE"));
				strmodintrate=Helper.correctNull(rs.getString("LOAN_MODINTRATE"));
				strpurposeofloan=Helper.correctNull(rs.getString("LOAN_PURPOSEOFLO"));
				strrepaytype=Helper.correctNull(rs.getString("LOAN_REPAYMENTTYPE"));
				strinttype=Helper.correctNull(rs.getString("LOAN_INTTYPE"));
				strmclrtype=Helper.correctNull(rs.getString("loan_mclrtype"));
			}
			
			if(rs!=null)rs.close();
			String strProcessdate="",strSancRefno="",strCBSAccoutno="";
			strQuery = SQLParser.getSqlQuery("sel_renewalproposaldetails^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strProcessdate=Helper.correctNull(rs.getString("app_processdate"));
				strSancRefno=Helper.correctNull(rs.getString("sanctionrefno"));
				strCBSAccoutno=Helper.correctNull(rs.getString("cbs_accountno"));
			}
			
			String strApplicantid = (String) hshValues.get("hidapplicantnewid");
			if(strApplicantid.equalsIgnoreCase(""))
			{
				strApplicantid = (String) hshValues.get("hidapplicantid");
			}
			if(!strApplicantid.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("seloldrefidforapp^"+strApplicantid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppOldID=Helper.correctNull((String)rs.getString("perapp_oldid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("getcomappid^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strAppOldID=Helper.correctNull(rs.getString("demo_appid"));
					strApplicantid=Helper.correctNull(rs.getString("demo_oldappid"));
				}
				if(rs!=null)
				{
					rs.close();
				}
			}
			
			if(bankingentry)
			{
				String strLoanType="";
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","combankinginsertNEW");
				arrValues.add(strAppno);
				arrValues.add("1");
				if(Helper.correctNull((String)hshValues.get("hidODFlag")).equalsIgnoreCase("OD"))
					strLoanType = "1";
				else
					strLoanType = "2";
				arrValues.add(strLoanType);
				arrValues.add(strPrdCode+"~"+strLoanType);
				arrValues.add("S");
				if(strinttype.equalsIgnoreCase("Fixed"))
				{
					arrValues.add("NOTAP");
				}
				else
				{
					if(strmclrtype.contains("ST@"))
						arrValues.add("ST");
					else if(strmclrtype.contains("TG@"))
						arrValues.add("GS");
					else
						arrValues.add("MCLR");
				}
				arrValues.add("P");
				arrValues.add(strSancRefno);//refno
				arrValues.add(strProcessdate);//date
				arrValues.add("");
				arrValues.add("");
				arrValues.add(strAppOldID);
				arrValues.add("Our");
				arrValues.add("Karnataka Bank");
				arrValues.add("F");
				arrValues.add(correctNull((String) hshValues.get("txtloan_amtreqd")));
				arrValues.add("");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("1");
				arrValues.add("p");
				arrValues.add("");
				arrValues.add(strCBSAccoutno);
				arrValues.add(strmodintrate);
				arrValues.add(strrepaytype);
				arrValues.add("");
				arrValues.add(strpurposeofloan);
				arrValues.add("");
				arrValues.add("M");
				arrValues.add("0");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("Y");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("R");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
			}
			else
			{
				arrValues = new ArrayList();
				hshQueryValues = new HashMap();
		  		hshQuery=new HashMap();
				hshQueryValues.put("size","1");
				arrValues.add(strPrdCode);
				arrValues.add(strinttype);
				arrValues.add(correctNull((String) hshValues.get("txtloan_amtreqd")));
				arrValues.add(strmodintrate);
				arrValues.add(strrepaytype);
				arrValues.add(strpurposeofloan);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","combankingupdateNEW_retail");
				hshQueryValues.put("1",hshQuery);	
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

		}
		catch (Exception e)
		{
			log.error("Error occurred in updateDigiLoanProducts:: " + e.getMessage());
			throw new EJBException(e);
		}
		finally
		{
			try
			{
				if (rs != null)
					rs.close();
				
			}
			catch (Exception e1)
			{
				log.error("Error in closing connection: " + e1.getMessage());
			}
		}
		return hshValues;
	}
	public HashMap roiUpdateServices(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String applicantIn="",Resp="",applicantBQLIn="",strproposalnumber="",strloanamount="",strtenure="",strholidayperiod="",line="",strProductType="",strsecamount="",strmortnetsecamount=""
			,strschemeCode="",strInwardNum="",appRefNo="",data="";
		strproposalnumber=Helper.correctNull((String)hshValues.get("appno"));
		strProductType = Helper.correctNull((String) hshValues.get("strProductType"));
		int intUpdatesize=0;
		
	try
	{
		

		strQuery = SQLParser.getSqlQuery("roiupdate^"+strproposalnumber);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strloanamount=Helper.correctNull((String)rs.getString("loan_amtreqd"));	
			strtenure=Helper.correctNull((String)rs.getString("loan_reqterms"));	
			strholidayperiod=Helper.correctNull((String)rs.getString("loan_noofinstallment"));	
			strsecamount=Helper.correctNull((String)rs.getString("loan_secvalue"));	
			strmortnetsecamount=Helper.correctNull((String)rs.getString("LOAN_COSTLOANPRD"));	
		}
		
		if(rs!=null)
		{	  rs.close(); 	}
		
		strQuery = SQLParser.getSqlQuery("sel_AppRefNo^"+strproposalnumber);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			appRefNo=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));	
		}
		
		if(strloanamount.equals(""))
		{
			strloanamount="0";
		}
		else if(strtenure.equals(""))
		{
			strtenure="0";
		}
		else if(strholidayperiod.equals(""))
		{
			strholidayperiod="0";
		}
		else if(strsecamount.equals(""))
		{
			strsecamount="0";
		}
		
		try{
		if(strProductType.equals("pH") || strProductType.equals("pA") || strProductType.equals("pM")){
		
			if(strProductType.equals("pM"))
			{
			applicantIn="{" +
			"\"proposalnumber\":\""+strproposalnumber+"\"," +
					"\"loanamount\":"+strloanamount+"," +
							"\"tenure\":"+strtenure+"," +
								"\"residualValue\":"+strmortnetsecamount+"," +
									"\"holidayperiod\":"+strholidayperiod+"}";
	
			System.out.print(applicantIn);
			log.info("################@@@@@@@@@@@@@ ROI MORTGAGE UPDATE REQUEST @@@@@@@@@@@@@################ "+applicantIn);
			}else{
			applicantIn="{" +
				"\"proposalnumber\":\""+strproposalnumber+"\"," +
						"\"loanamount\":"+strloanamount+"," +
								"\"tenure\":"+strtenure+"," +
										"\"holidayperiod\":"+strholidayperiod+"}";
		
			System.out.print(applicantIn);
			log.info("################@@@@@@@@@@@@@ ROI UPDATE REQUEST @@@@@@@@@@@@@################ "+applicantIn);
			}
		if(strProductType.equals("pH") || strProductType.equals("pM"))
			{
				URL roiupd_url = new URL(ApplicationParams.getStrroiupdurl());
				log.info("ROI UPDATE URL=========== "+roiupd_url);
				HttpURLConnection roiupd_urlcon = (HttpURLConnection) roiupd_url.openConnection();
				roiupd_urlcon.setRequestProperty("User-Agent", "");
				roiupd_urlcon.setDoInput(true);
				roiupd_urlcon.setDoOutput(true);
				roiupd_urlcon.setRequestMethod("POST");
				roiupd_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
				roiupd_urlcon.setRequestProperty("Authorization", "Basic");
				
				OutputStream roiupd_outputStream = roiupd_urlcon.getOutputStream();
				OutputStreamWriter roi_osw = new OutputStreamWriter(roiupd_outputStream, "UTF8");
				
				BufferedWriter roi_bWriter = new BufferedWriter(roi_osw);
				roi_bWriter.write(applicantIn);
				roi_bWriter.close();
		
				/**************************Response********************************************/
				
				InputStream roi_inputStream = roiupd_urlcon.getInputStream();
				InputStreamReader roi_isreader = new InputStreamReader(roi_inputStream,"UTF-8");
				
				BufferedReader roi_rd = new BufferedReader(roi_isreader);
		
				if (roi_rd != null) {
					StringBuffer roi_result = new StringBuffer();
					while ((line = roi_rd.readLine()) != null) {
						roi_result.append(line);
					}
				log.info("################@@@@@@@@@@@@@ ROI UPDATE Response @@@@@@@@@@@@@################"
							+ roi_result.toString());
				Resp = roi_result.toString();
				JSONObject json= new  JSONObject(roi_result.toString());
				
			    String STRRATEOFINTERESTVALUE=String.valueOf(json.get("interesttype"));
			    
			    String STRBASERATEVALUE=String.valueOf(json.get("benchmarkrate"));
			    
			    String STRFIXEDRATEVALUE=String.valueOf(json.get("fixedrate"));
			    
			    String STRCREDITRSKVALVALUE=String.valueOf(json.get("creditriskpremium"));
			    
			    String STRPENALINTERESTVALUE=String.valueOf(json.get("penalinterest"));
			    
			    String STRTOTALINTERESTVALUE=String.valueOf(json.get("totalintrate"));
			    
			    String STRMINMARGINVALUE=String.valueOf(json.get("minimummargin"));
			    
			    String STRCONCESSIONVALUE=String.valueOf(json.get("concession"));
				
			    String mclrtype="",mclrtabcode="",mclrbaserate="",strpenaltyinterest="";
			    double deviationPenalInterest=0.00;
				
				strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+STRRATEOFINTERESTVALUE);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
					mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
				}
				
				
				if(rs!=null)
					rs.close();
				String penalValue="";
				double roipenalValue=0;
				double roiCspValueforpenal=0;
				double roitotValueforpenal=0;
				strQuery=SQLParser.getSqlQuery("sel_loandetails_digi_extra^"+strproposalnumber);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					penalValue =  Helper.correctNull(rs.getString("DIGI_DEVIATION_ROI_PENALTY"));
				}
			  if(penalValue.equals("") || penalValue.equals("0"))
			   {
				   penalValue="0";
				   STRPENALINTERESTVALUE=STRPENALINTERESTVALUE;
			   }else{
				   if(strProductType.equals("pH")){
				   STRPENALINTERESTVALUE=penalValue;}
			   }
			   roipenalValue = Double.parseDouble(penalValue);
			   roiCspValueforpenal = Double.parseDouble(STRCREDITRSKVALVALUE);
			   double finalcspandpenal = roiCspValueforpenal + roipenalValue;
			   String strfinalcspandpenal =  String.format("%.2f", finalcspandpenal);
			   
			   roitotValueforpenal = Double.parseDouble(STRTOTALINTERESTVALUE);
			   double finaltotintpenal = roitotValueforpenal + roipenalValue;
			   String strfinaltotint =  String.format("%.2f", finaltotintpenal);
				
				/*strQuery = SQLParser.getSqlQuery("sel_loan_details^"+strproposalnumber);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strpenaltyinterest=Helper.correctNull((String)rs.getString("DIGI_DEVIATION_ROI_PENALTY"));
					deviationPenalInterest = Double.parseDouble(strpenaltyinterest);
				}
					double DBLTOTALINTERESTVALUE=0.00,DBLCREDITRSKVALVALUE=0.00;
					DBLTOTALINTERESTVALUE=Double.parseDouble(STRTOTALINTERESTVALUE);
					DBLCREDITRSKVALVALUE=Double.parseDouble(STRCREDITRSKVALVALUE);
					DBLTOTALINTERESTVALUE=DBLTOTALINTERESTVALUE+deviationPenalInterest;//loan_intrate/*loan_modintrate
					DBLCREDITRSKVALVALUE=DBLCREDITRSKVALVALUE+deviationPenalInterest;//loan_creditrskval/*
					STRTOTALINTERESTVALUE=String.valueOf(DBLCREDITRSKVALVALUE);//loan_intrate/*loan_modintrate
					STRCREDITRSKVALVALUE=String.valueOf(DBLCREDITRSKVALVALUE);//loan_creditrskval/*
					STRPENALINTERESTVALUE=String.valueOf(deviationPenalInterest);//digi_deviation_roi_penalty
*/				
			    hshQueryValues=new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_roi_loandetails");
				arrValues.add(strfinaltotint);//loan_intrate
				arrValues.add(strfinaltotint);//loan_modintrate
				arrValues.add(STRBASERATEVALUE);//loan_baserate
				arrValues.add(strfinalcspandpenal);//loan_creditrskval/*
				arrValues.add(STRFIXEDRATEVALUE);//loan_busstatval
				arrValues.add(mclrtabcode);//LOAN_MCLRTABCODE
				arrValues.add(mclrtype);//LOAN_MCLRTYPE
				arrValues.add("Y");//LOAN_UPDROI_FLAG
				arrValues.add(STRMINMARGINVALUE);//Loan_margin
				arrValues.add(STRPENALINTERESTVALUE);//digi_deviation_roi_penalty
				arrValues.add(STRCONCESSIONVALUE);//DIGI_DEVIATION_ROI_CONC
				arrValues.add(strproposalnumber);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
				else if(strProductType.equals("pA"))
				{
					URL roiupdpa_url = new URL(ApplicationParams.getStrroipaupdurl());
					log.info("ROI UPDATE URL=========== "+roiupdpa_url);
					HttpURLConnection roiupd_urlcon = (HttpURLConnection) roiupdpa_url.openConnection();
					roiupd_urlcon.setRequestProperty("User-Agent", "");
					roiupd_urlcon.setDoInput(true);
					roiupd_urlcon.setDoOutput(true);
					roiupd_urlcon.setRequestMethod("POST");
					roiupd_urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
					roiupd_urlcon.setRequestProperty("Authorization", "Basic");
					
					OutputStream roiupd_outputStream = roiupd_urlcon.getOutputStream();
					OutputStreamWriter roi_osw = new OutputStreamWriter(roiupd_outputStream, "UTF8");
					
					BufferedWriter roi_bWriter = new BufferedWriter(roi_osw);
					roi_bWriter.write(applicantIn);
					roi_bWriter.close();
			
					/**************************Response********************************************/
					
					InputStream roi_inputStream = roiupd_urlcon.getInputStream();
					InputStreamReader roi_isreader = new InputStreamReader(roi_inputStream,"UTF-8");
					
					BufferedReader roi_rd = new BufferedReader(roi_isreader);
			
					if (roi_rd != null) {
						StringBuffer roi_result = new StringBuffer();
						while ((line = roi_rd.readLine()) != null) {
							roi_result.append(line);
						}
					log.info("################@@@@@@@@@@@@@ ROI UPDATE Response @@@@@@@@@@@@@################"
								+ roi_result.toString());
					Resp = roi_result.toString();
					JSONObject json= new  JSONObject(roi_result.toString());
					
				    String STRRATEOFINTERESTVALUE=String.valueOf(json.get("interesttype"));
				    
				    String STRBASERATEVALUE=String.valueOf(json.get("benchmarkrate"));
				    
				    String STRFIXEDRATEVALUE=String.valueOf(json.get("fixedrate"));
				    
				    String STRCREDITRSKVALVALUE=String.valueOf(json.get("creditriskpremium"));
				    
				    String STRPENALINTERESTVALUE=String.valueOf(json.get("penalinterest"));
				    
				    String STRTOTALINTERESTVALUE=String.valueOf(json.get("totalintrate"));
				    
				    String STRMINMARGINVALUE=String.valueOf(json.get("minimummargin"));
				    
				    String STRCONCESSIONVALUE=String.valueOf(json.get("concession"));
					
				    String mclrtype="",mclrtabcode="",mclrbaserate="",strpenaltyinterest="";
				    double deviationPenalInterest=0.00;
					
					strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+STRRATEOFINTERESTVALUE);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
						mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
					}
					
					 
				    hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","update_roi_loandetails");
					arrValues.add(STRTOTALINTERESTVALUE);//loan_intrate
					arrValues.add(STRTOTALINTERESTVALUE);//loan_modintrate
					arrValues.add(STRBASERATEVALUE);//loan_baserate
					arrValues.add(STRCREDITRSKVALVALUE);//loan_creditrskval/*
					arrValues.add(STRFIXEDRATEVALUE);//loan_busstatval
					arrValues.add(mclrtabcode);//LOAN_MCLRTABCODE
					arrValues.add(mclrtype);//LOAN_MCLRTYPE
					arrValues.add("Y");//LOAN_UPDROI_FLAG
					arrValues.add(STRMINMARGINVALUE);//Loan_margin
					arrValues.add(STRPENALINTERESTVALUE);//digi_deviation_roi_penalty
					arrValues.add(STRCONCESSIONVALUE);//DIGI_DEVIATION_ROI_CONC
					arrValues.add(strproposalnumber);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
			}
				}else if(strProductType.equals("pB")){
		
					
					ArrayList arrFacilities= new ArrayList();
					String facilitySno = "1",strcgtmseav="",strkbRating="";
					strschemeCode = Helper.correctNull((String) hshValues.get("schemeCode"));
					if(strschemeCode.equals(""))
					{
						strschemeCode="0";
					}
					
					if(rs!=null)
					{	  rs.close(); 	}
					
					strQuery = SQLParser.getSqlQuery("sel_miscgtmse_roi^"+strproposalnumber);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						strcgtmseav=Helper.correctNull((String)rs.getString("APPGUARANTEE"));
					}
					if(strcgtmseav.equalsIgnoreCase("")){
						strcgtmseav="NO";
					}
					
				
				data="{\"facilitySno\": "+facilitySno+", " +
				"\"facilityName\": \""+strschemeCode+"\"," +
					"\"loanAmount\": "+strloanamount+"," +
						"\"CollartralAmount\":"+strsecamount+"}";
				
		
				arrFacilities.add(data);
				applicantBQLIn="{" +
				"\"applicationRefNum\":\""+appRefNo+"\"," +
				"\"productType\": \""+strschemeCode+"\" ," +
				"\"cgtmseFlag\": \""+strcgtmseav+"\" ," +
							"\"data\":"+arrFacilities+"}";
			
				System.out.print(applicantBQLIn);
				log.info("################@@@@@@@@@@@@@ ROI BQL UPDATE REQUEST @@@@@@@@@@@@@################ "+applicantBQLIn);
		
				URL roiupdpB_url = new URL(ApplicationParams.getStrroiBQLupdurl());
				log.info("ROI BQL UPDATE URL=========== "+roiupdpB_url);
				HttpURLConnection urlcon = (HttpURLConnection) roiupdpB_url.openConnection();
				urlcon.setRequestProperty("User-Agent", "");
				urlcon.setDoInput(true);
				urlcon.setDoOutput(true);
				urlcon.setRequestMethod("POST");
				urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
				urlcon.setRequestProperty("Authorization",ApplicationParams.getStrBQLAuthValue() );
				OutputStream outputStream = urlcon.getOutputStream();
				OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
		
				BufferedWriter bWriter = new BufferedWriter(osw);
				bWriter.write(applicantBQLIn);
				bWriter.close();
		
				InputStream inputStream = urlcon.getInputStream();
				InputStreamReader isreader = new InputStreamReader(inputStream,
					"UTF-8");
		
				BufferedReader rd = new BufferedReader(isreader);
		
					if (rd != null) {
					StringBuffer result = new StringBuffer();
					while ((line = rd.readLine()) != null) {
						result.append(line);
					}
					//**************************Response********************************************//
					log.info("################@@@@@@@@@@@@@ ROI BQL UPDATE Response @@@@@@@@@@@@@################"
								+ result.toString());
					Resp = result.toString();
					JSONObject json1= new  JSONObject(result.toString());
					JSONObject json = json1.getJSONObject("data");
					
					String strbandRating=String.valueOf(json.get("bandRating"));
					String strbandPath=String.valueOf(json.get("bandPath"));
					
					JSONArray jsonResArray1 = json.getJSONArray("data");
					int doclistlength=jsonResArray1.length();
					if(doclistlength>0)
					{
							//shiva
						ArrayList arrtemp=new ArrayList();
						for(int i=0;i<doclistlength;i++)
						{
							
							JSONObject jsonObjectForValues = jsonResArray1.getJSONObject(i);
							
							String STRRATEOFINTERESTVALUE = String.valueOf(jsonObjectForValues.get("interesttype"));
							String STRBASERATEVALUE = String.valueOf(jsonObjectForValues.get("benchmarkrate"));
							String STRFIXEDRATEVALUE= String.valueOf(jsonObjectForValues.get("fixedrate"));
							String STRCREDITRSKVALVALUE = String.valueOf(jsonObjectForValues.get("creditriskpremium"));
							String STRPENALINTERESTVALUE= String.valueOf(jsonObjectForValues.get("penalinterest"));
							String STRTOTALINTERESTVALUE= String.valueOf(jsonObjectForValues.get("totalintrate"));
							String STRCONCESSIONVALUE= String.valueOf(jsonObjectForValues.get("concession"));
							String STRCONDESC= String.valueOf(jsonObjectForValues.get("concession description"));
							
						    String mclrtype="",mclrtabcode="",mclrbaserate="",strpenaltyinterest="";
						    double deviationPenalInterest=0.00;
							strQuery = SQLParser.getSqlQuery("sel_mclrmaster_type^"+STRRATEOFINTERESTVALUE);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODE"));
								mclrtype=Helper.correctNull((String)rs.getString("MCLR_TYPE"))+"@"+jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD"))))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODE"))+"@"+Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
							    if(strschemeCode.equalsIgnoreCase("OD"))
							    {
							    	mclrtabcode = Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));
							    }
							}
							
							
							if(strbandRating.equalsIgnoreCase("Band 1")||strbandRating.equalsIgnoreCase("Band1")||
									strbandRating.equalsIgnoreCase("Band 2")||strbandRating.equalsIgnoreCase("Band2"))
									strkbRating="KB1";		
									
									if(strbandRating.equalsIgnoreCase("Band 3")||strbandRating.equalsIgnoreCase("Band3"))
										strkbRating="KB2";
									
									if(strbandRating.equalsIgnoreCase("Band 4")||strbandRating.equalsIgnoreCase("Band4")||
										strbandRating.equalsIgnoreCase("Band 5")||strbandRating.equalsIgnoreCase("Band5"))
										strkbRating="KB3";
									
									if(strbandRating.equalsIgnoreCase("Band 6")||strbandRating.equalsIgnoreCase("Band6")||
										strbandRating.equalsIgnoreCase("Band 7")||strbandRating.equalsIgnoreCase("Band7"))
										strkbRating="KB4";
									
									if(strbandRating.equalsIgnoreCase("Band 8")||strbandRating.equalsIgnoreCase("Band8"))
										strkbRating="KB5";
									
									if(strbandRating.equalsIgnoreCase("Band 9")||strbandRating.equalsIgnoreCase("Band9"))
										strkbRating="KB7";
									
									//shiva
							    hshQueryValues=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","update_roi_loandetails_bql");
								arrValues.add(STRTOTALINTERESTVALUE);//loan_intrate
								arrValues.add(STRTOTALINTERESTVALUE);//loan_modintrate
								arrValues.add(STRBASERATEVALUE);//loan_baserate
								arrValues.add(STRCREDITRSKVALVALUE);//loan_creditrskval/*
								arrValues.add(STRFIXEDRATEVALUE);//loan_busstatval
								arrValues.add(mclrtabcode);//LOAN_MCLRTABCODE
								arrValues.add(mclrtype);//LOAN_MCLRTYPE
								arrValues.add("Y");//LOAN_UPDROI_FLAG
								arrValues.add(STRPENALINTERESTVALUE);//digi_deviation_roi_penalty
								arrValues.add(STRCONCESSIONVALUE);//DIGI_DEVIATION_ROI_CONC
								arrValues.add(STRCONDESC);//DIGI_DEVIATION_ROI_CONDESC
								arrValues.add(strproposalnumber);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
								
								//RATING						
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize++;
								hshQuery.put("strQueryId","upd_rating_roi");
								arrValues.add(strbandRating);//BAND_RATING
								arrValues.add(strkbRating);//KB_RATING
								arrValues.add(strbandPath);//KB_RATING
								arrValues.add(strproposalnumber);//DIGI_SCORE_APPNO
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(""+intUpdatesize, hshQuery);
								
								
								String strParameter="",strexistinVal="",strnewVal="",strexistkbrat="",strexistbdpath="";
								String strUserId = Helper.correctNull((String) hshValues.get("strUserId"));
								if(rs!=null)
								{	  rs.close(); 	}
								
								strQuery = SQLParser.getSqlQuery("sel_digi_rate_score^"+strproposalnumber);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									strexistinVal=Helper.correctNull((String)rs.getString("BAND_RATING"));
									strexistkbrat=Helper.correctNull((String)rs.getString("KB_RATING"));
									strexistbdpath=Helper.correctNull((String)rs.getString("BAND_PATH"));
								}else{
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									arrValues.add(strproposalnumber);//HIS_APPNO
									arrValues.add(strexistinVal);//HIS_EXISTINGVAL
									arrValues.add(strbandRating);//HIS_NEWVAL
									arrValues.add(strUserId);//HIS_USRID
									arrValues.add(strParameter);//HIS_PARAMETER
									hshQuery.put("strQueryId","ins_rating_his");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(""+intUpdatesize, hshQuery);
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									arrValues.add(strproposalnumber);//HIS_APPNO
									arrValues.add(strexistinVal);//HIS_EXISTINGVAL
									arrValues.add(strkbRating);//HIS_NEWVAL
									arrValues.add(strUserId);//HIS_USRID
									arrValues.add(strParameter);//HIS_PARAMETER
									hshQuery.put("strQueryId","ins_rating_his");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(""+intUpdatesize, hshQuery);
									
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									arrValues.add(strproposalnumber);//HIS_APPNO
									arrValues.add(strexistinVal);//HIS_EXISTINGVAL
									arrValues.add(strbandPath);//HIS_NEWVAL
									arrValues.add(strUserId);//HIS_USRID
									arrValues.add(strParameter);//HIS_PARAMETER
									hshQuery.put("strQueryId","ins_rating_his");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(""+intUpdatesize, hshQuery);
									
									hshQueryValues.put("size",String.valueOf(intUpdatesize));
									EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
								}
								if(!strexistinVal.equalsIgnoreCase(strbandRating))
								{
								strnewVal=strbandRating;
								//RATING HISTORY
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize++;
								arrValues.add(strproposalnumber);//HIS_APPNO
								arrValues.add(strexistinVal);//HIS_EXISTINGVAL
								arrValues.add(strnewVal);//HIS_NEWVAL
								arrValues.add(strUserId);//HIS_USRID
								arrValues.add(strParameter);//HIS_PARAMETER
								hshQuery.put("strQueryId","ins_rating_his");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(""+intUpdatesize, hshQuery);
								}
								
								if(!strexistbdpath.equalsIgnoreCase(strbandPath))
								{
								strnewVal=strbandPath;
								//RATING HISTORY
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize++;
								arrValues.add(strproposalnumber);//HIS_APPNO
								arrValues.add(strexistinVal);//HIS_EXISTINGVAL
								arrValues.add(strnewVal);//HIS_NEWVAL
								arrValues.add(strUserId);//HIS_USRID
								arrValues.add(strParameter);//HIS_PARAMETER
								hshQuery.put("strQueryId","ins_rating_his");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(""+intUpdatesize, hshQuery);
								}
								
								if(!strexistkbrat.equalsIgnoreCase(strkbRating))
								{
								strnewVal=strkbRating;
								//RATING HISTORY
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								intUpdatesize++;
								arrValues.add(strproposalnumber);//HIS_APPNO
								arrValues.add(strexistinVal);//HIS_EXISTINGVAL
								arrValues.add(strnewVal);//HIS_NEWVAL
								arrValues.add(strUserId);//HIS_USRID
								arrValues.add(strParameter);//HIS_PARAMETER
								hshQuery.put("strQueryId","ins_rating_his");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(""+intUpdatesize, hshQuery);
								}
				            
						}
					
					}
				}
			}
		
		hshQueryValues=new HashMap();
		hshQuery=new HashMap();
		arrValues=new ArrayList();   
		hshQuery.put("strQueryId","ins_apistatus");
		arrValues.add("");
		if(strProductType.equals("pB"))
		{
		arrValues.add(applicantBQLIn);
		}else{
			arrValues.add(applicantIn);
		}
		arrValues.add("SUCESS"); 
		arrValues.add("Retail-"+strProductType); 
		arrValues.add("ROIUPDATE");
		arrValues.add(Resp);
		arrValues.add(strproposalnumber); 
		hshQuery.put("arrValues",arrValues);
		hshQueryValues.put("1",hshQuery);	
		hshQueryValues.put("size","1");
		EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		
		}catch(Exception f) {

			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();   
			hshQuery.put("strQueryId","ins_apistatus");
			arrValues.add(String.valueOf(f));
			if(strProductType.equals("pB"))
			{
			arrValues.add(applicantBQLIn);
			}else{
				arrValues.add(applicantIn);
			}
			arrValues.add("FAILURE"); 
			arrValues.add("Retail-"+strProductType); 
			arrValues.add("ROIUPDATE");
			arrValues.add(Resp);
			arrValues.add(strproposalnumber); 
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);	
			hshQueryValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");	
		}
	}
	catch(Exception e) {
		throw new EJBException("Error in roiUpdateServices "+e.getMessage());
		}
	return hshValues;		
	}	
	
	public HashMap enachcheckService(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery="",strproposalnumber="",line="",strAction="",strECSAuthMode="",strparmval="",strEnachnotAvai="";

	try
	{
		strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		strproposalnumber=Helper.correctNull((String)hshValues.get("appno"));
		if(strproposalnumber.equalsIgnoreCase(""))
		{
			strproposalnumber=Helper.correctNull((String)hshValues.get("txtapplicationno"));
		}
		
		if(strAction.equalsIgnoreCase("CALLINGIFRAME"))
		{
			strQuery=SQLParser.getSqlQuery("sel_cbsaccno^"+strproposalnumber);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{				
				hshValues.put("app_enchflag",correctNull((String)rs.getString("app_enchflag")));	
				
				strQuery=SQLParser.getSqlQuery("getstatdatavalue^266^1");
				rs2=DBUtils.executeQuery(strQuery);
				if(rs2.next())
				{
				strparmval = correctNull((String)rs2.getString("stat_data_desc1"));
				
					strQuery=SQLParser.getSqlQuery("sel_enachremain^"+strparmval+"^"+strproposalnumber);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshValues.put("Timestramp","Y");	
					}
				}	
			}
		}
		if(strAction.equalsIgnoreCase("CALLINGAPI"))
		{
		String appRefNo="",conmobile="",conEmail="",ECSACCOUNTTYPE="",ECSBANKNAME="",ECSIFSCCODE="",ECSATHUNMODE="",flowstartdate="",ECSOPERACCOUNTNUM="",
		foracid="",limexpdate="",sanctlim="",lrfreqtype="",appfname="";
		
		if(rs!=null)
		{
			rs.close();
		}

		strQuery=SQLParser.getCBSSqlQuery("sel_enach_finacle^"+strproposalnumber);
		rs=DBUtils.executeQueryCBSConnection(strQuery);
		if(rs.next())
		{
			flowstartdate=Helper.correctNull((String)rs.getString("FLOW_START_DATE"));	
			foracid=Helper.correctNull((String)rs.getString("FORACID"));	
			limexpdate=Helper.correctNull((String)rs.getString("LIM_EXP_DATE"));	
			sanctlim=Helper.correctNull((String)rs.getString("FLOW_AMT"));	
			lrfreqtype=Helper.correctNull((String)rs.getString("LR_FREQ_TYPE"));	

		}
		
		//perapplicant
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("sel_enach^"+strproposalnumber);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			appfname=Helper.correctNull((String)rs.getString("PERAPP_FNAME"));	
			conmobile=Helper.correctNull((String)rs.getString("CON_MOBILE"));	
			conEmail=Helper.correctNull((String)rs.getString("CON_EMAIL"));	
			ECSACCOUNTTYPE=Helper.correctNull((String)rs.getString("LOAN_ECSACCOUNTTYPE"));	
			if(!ECSACCOUNTTYPE.equalsIgnoreCase(""))
			{
				if(ECSACCOUNTTYPE.equalsIgnoreCase("1"))
				{
					ECSACCOUNTTYPE="SB";
				}else if(ECSACCOUNTTYPE.equalsIgnoreCase("2"))
				{
					ECSACCOUNTTYPE="CA";
				}else if(ECSACCOUNTTYPE.equalsIgnoreCase("3")){
					ECSACCOUNTTYPE="OD";

				}
			}
			ECSOPERACCOUNTNUM=Helper.correctNull((String)rs.getString("LOAN_ECSOPERACCNUM"));	
			ECSBANKNAME=Helper.correctNull((String)rs.getString("LOAN_ECSBANKNAME"));
			strQuery = SQLParser.getSqlQuery("sel_enach_bankname^"+ECSBANKNAME);
			rs1 = DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				ECSBANKNAME=Helper.correctNull((String)rs1.getString("stat_data_desc1"));	
			}
			ECSIFSCCODE=Helper.correctNull((String)rs.getString("LOAN_ECSIFSCCODE"));	
			ECSATHUNMODE=Helper.correctNull((String)rs.getString("LOAN_ECSATHUNMODE"));	
			if(!ECSATHUNMODE.equalsIgnoreCase(""))
			{
				if(ECSATHUNMODE.equalsIgnoreCase("1"))
				{
					ECSATHUNMODE="IB";
				}else if(ECSATHUNMODE.equalsIgnoreCase("2"))
				{
					ECSATHUNMODE="Debit Card";
				}
			}
			
		}
		
		//appinwardreg
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("sel_AppRefNo^"+strproposalnumber);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			appRefNo=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));	
		}
		
		if(!foracid.equalsIgnoreCase(""))
		{
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("sel_enach_check^"+strproposalnumber);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
				  
		String applicantIn="{" +
		"\"applicationrefnumber\":\""+appRefNo+"\"," +
			"\"name\":\""+appfname+"\"," +
				"\"email\":\""+conEmail+"\"," +
					"\"mobilenum\":\""+conmobile+"\"," +
						"\"accounttype\":\""+ECSACCOUNTTYPE+"\"," +
							"\"emidate\":\""+flowstartdate+"\"," +
								"\"loanaccountnum\":\""+foracid+"\"," +
									"\"accountnumber\":\""+ECSOPERACCOUNTNUM+"\"," +
										"\"proposalnum\":\""+strproposalnumber+"\"," +
											"\"enddate\":\""+limexpdate+"\"," +
												"\"bankname\":\""+ECSBANKNAME+"\"," +
													"\"ifsccode\":\""+ECSIFSCCODE+"\"," +
														"\"authenticationmode\":\""+ECSATHUNMODE+"\"," +
															"\"amount\":\""+sanctlim+"\"," +
																"\"frequency\":\""+lrfreqtype+"\"}" ;
															

		System.out.print(applicantIn);
		log.info("################@@@@@@@@@@@@@ ENACH REQUEST @@@@@@@@@@@@@################ "+applicantIn);

		
		URL url = new URL(ApplicationParams.getStrENACHURL());
		log.info("ENACH Url=========== "+url);

		HttpURLConnection urlcon = (HttpURLConnection) url.openConnection();
		urlcon.setRequestProperty("User-Agent", "");
		urlcon.setDoInput(true);
		urlcon.setDoOutput(true);
		urlcon.setRequestMethod("POST");
		urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
		urlcon.setRequestProperty("Authorization","Basic");
		
		OutputStream outputStream = urlcon.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");

		BufferedWriter bWriter = new BufferedWriter(osw);
		bWriter.write(applicantIn);
		bWriter.close();

		
		InputStream inputStream = urlcon.getInputStream();
		InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");

		BufferedReader rd = new BufferedReader(isreader);
			if (rd != null) {
			StringBuffer result = new StringBuffer();
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
	
			log.info("################@@@@@@@@@@@@@ ENACH Response @@@@@@@@@@@@@################ "+ result.toString());
			
				
				
				JSONObject json = new JSONObject(result.toString());
				String resultStatus=String.valueOf(json.get("status"));
				String resultStatusmsg=String.valueOf(json.get("status_msg"));
				log.info("################@@@@@@@@@@@@@ ENACH RESULT Status @@@@@@@@@@@@@################ "+ resultStatus);
				log.info("################@@@@@@@@@@@@@ ENACH RESULT MESSAGE @@@@@@@@@@@@@################ "+ resultStatusmsg);
				if(resultStatus.equalsIgnoreCase("200") || resultStatus.equalsIgnoreCase("201")){
					
					log.info("################@@@@@@@@@@@@@ ENACH RESULT Status @@@@@@@@@@@@@################ "+ resultStatus);
					log.info("################@@@@@@@@@@@@@ ENACH RESULT MESSAGE @@@@@@@@@@@@@################ "+ resultStatusmsg);
					hshValues.put("resultStatusmsg",resultStatusmsg);
					
					SimpleDateFormat dateFormat= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss"); 
		            Calendar calendar = Calendar.getInstance();
		            String strDay = dateFormat.format(calendar.getTime());
		             
					hshQueryValues=new HashMap();
					hshQuery=new HashMap();
					arrValues=new ArrayList();   
					hshQuery.put("strQueryId","upd_appEnach");
					arrValues.add("Y");
					arrValues.add(strDay);
					arrValues.add(strproposalnumber);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);	
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					strEnachnotAvai="Y";
				}
			}	
		 }
		}
		if(!strEnachnotAvai.equalsIgnoreCase("Y")){
				hshValues.put("EnachnotAvai","Y");
		 }
		}else if(strAction.equalsIgnoreCase("updateENACH")){
			
				try{	
					
						hshQuery=new HashMap();
						hshQuery.put("strQueryId", "upd_laps_enach");
						arrValues = new ArrayList();
						arrValues.add("MC");
						arrValues.add(strproposalnumber);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
						log.info("################@@@@@@@@@@@@@ ENACH TABLE UPDATED @@@@@@@@@@@@@################ "+ strproposalnumber);
	
				}catch(Exception e){
					throw new EJBException("Error in enachcheckService update ENACH Table "+e.getMessage());
				}
				hshValues.put("EnachUpdate","Y");
			
		}
	}

	catch(Exception e) {
		throw new EJBException("Error in enachcheckService "+e.getMessage());

		}
	return hshValues;	
	}	
	
	public double getExposureTotalLimit(String strAppID, String strValuesin ,String strSessionModuleType)
	 {
		ResultSet rs = null;
		String strQuery = "";
		String strExposureTotalLimit = "";
		String strAppOldID = "";
		double dblExposuretotallimit = 0.00;
		
		try {
			
				 strQuery = SQLParser.getSqlQuery("sel_exposurelimit_ret^" +strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID+"^"+strAppID);
					rs = DBUtils.executeQuery(strQuery);
					if (rs.next()) {
						dblExposuretotallimit = Double.parseDouble((String) Helper
								.correctDouble(rs.getString("totexp")));
					}
			 
			strExposureTotalLimit = Helper.convertSetupToApplicationValues(strValuesin,
					dblExposuretotallimit);
		} catch (Exception ce) {
			throw new EJBException("Error in getExposureTotalLimit "
					+ ce.toString());
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
	return Double.parseDouble(strExposureTotalLimit);
}
	
}

