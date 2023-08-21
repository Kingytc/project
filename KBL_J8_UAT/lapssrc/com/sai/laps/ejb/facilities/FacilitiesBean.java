package com.sai.laps.ejb.facilities;

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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.Remote;
import javax.ejb.Stateless;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.sai.laps.ejb.apistatushandle.ApistatushandleBean;
import com.sai.laps.ejb.bankapp.BankAppBean;
import com.sai.laps.ejb.financial.FinancialBean;
import com.sai.laps.ejb.inwardRegister.InwardRegisterBean;
import com.sai.laps.ejb.perapplicant.PerApplicantBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.ConnectionFactory;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.MISLogger;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.securitymaster.SecurityMasterBean;
import com.sai.laps.taglib.AdhocFacilityTag;
import com.sun.webkit.ThemeClient;

import net.lingala.zip4j.model.EndCentralDirRecord;

import com.sai.laps.ejb.facilities.FacilitiesRemote;

@Stateless(name = "FacilitiesBean", mappedName = "FacilitiesHome")
@Remote (FacilitiesRemote.class)
public class FacilitiesBean extends BeanAdapter
{  
	//static Logger log=Logger.getLogger(FacilitiesBean.class);
	/**
	 * 
	 */
	private static final long serialVersionUID = 2710469160195513442L;
	static Logger log=Logger.getLogger(FacilitiesBean.class);
	/**
	 * 
	 */

	public HashMap updateData(HashMap hshValues) 
	{
		
		String strQuery="";
		//String strQuery1="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;

		String strAppno="";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshRecord=  new HashMap();
		String strFacHead="",strSubFacHead = "",strFinStd="0",strIndType="",strIndRating="",strInterestType="",strSubInterestType="";
		String strFacility="",strSubFacility = "",strApp="",strFacCategory="",strFacSubCategory="",strInterestTypeOld="",strSubInterestTypeOld="";
		String strFacType="",strSubProposed="0",strSubProposed_old="0";
		String strBorrowId="";
		String strExist="",strSubExist=""; 
		String strSno="0",strSubsno="0";
		String strProposed="",strProposed_old="",strDesc="",strSubDesc="",strFACILITYTYPEFOR="",strrenewaljustif="",strrenewaljustifsub="";
		String strDiff="",strAction="",strGroup="0";
		String strMargin="",strSubMargin="0",strLoanAmt="0";
		//String strRows="";
		String strLimitId="",strMsg="";
		String strOrglevel="",strissaral="";
		String strBPLR="",strSubBPLR="";
		String strDP="",strSubDP="";
		String strSecurity="",strSubSecurity="";
		String strOutstanding="";
		String strSubOutstanding="";
		String strOSDate="",strSubOSDate="";
		String strExistbnktype="",strExistSubbnktype="";
		String strPropbnktype="",strPropSubbnktype="";
		String strPurpose="",strSubPurpose="";
		//String strDocConst="";
		String strBranchName="";
		HashMap hshformula =  new HashMap();//mck
		String strInterest="", strSubInterest="";
		String strIntadjust="",strSubIntadjust="";
		String strcbsaccno="",strSubcbsaccno="";
		String strfacilityintremarks="", strsubfacilityintremarks="";
		String strProposalin="";
		String strSolid="",strAdhocFac="",strSubAdhocFac="",strECSBankName="",strECSaccnttype=""
			,strECSoperaccno="",strECSauthmode="",strECSifsccode="";
		int intfacMonths=0;
		int intsubfacMonths=0;
		
		String strLflag="N";
	
		String strIntType="",strSubIntType="";		
		String strRepayType="",strSubRepaytype="";
		String strGovtsponsschem="",strGovtSubSponScheme="";
		String strSchemeType="",strSubSchemeType="";
		String strSponsAgency="",strSubSponsAgency="";
		String strSubsidyType="",strSubSubsidyType="";
		String strsubsidyAmunt="",strSubsubsidyamount="";
		String stragrSchemeType="",strsubagrSchemeType="";
		
		String strfacSubIntType="",strfacnature="",strfacTuf="";
		String strSubFacSubIntType="",strSubfacnature="";
		
		String strIntFacId="";
		String strIntSubFacId="";
		
		String strIntBaseRateFac="";
		String strIntBaseRateSubFac="";
		
		String strCBSAccountNo="",strSubCBSAccountNo="";
		String strFreshLimitMain="";
		String strFreshLimitSub="";
		
		String strHolidayPeriod="",strInterstRecieved="",strInterestCharged="",strMarginTerms="",strModeOfPay="",strOperativeAccountNo="";
		String strHolidayPeriodSub="",strInterstRecievedSub="",strInterestChargedSub="",strMarginTermsSub="",strModeOfPaySub="",strOperativeAccountNoSub="",sel_fac_desc ="",sel_subfac_desc="";
		
		
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		String strFacCode="",strSubFacCode="";
		
		String strFacDetails="",strFacSubDetails="";
		
		String strRemarks="",strRemarksSub="";
		
		String strPerInstall="",strPerInstallSub="";
		String stragency="",strsubagency="";
 		int intUpdatesize=0;
		//int j=0;
		boolean booProcess = false,updflag=true;
		StringTokenizer stk = null;
		ResultSet resulSet=null;
		String strModType="",strAgrSchemeType="";
		String strDuedate="",strdisplaydesc="",strsubDuedate="",strsubdisplaydesc="";
		String strFinancialReq = "";
		String strBorrow_newId="",strRenew_flag="",strFacilityOldId="";
		String strFacRestructedAcc="",strSubFacRestructedAcc="",strFacFITLAcc="",strSubFacFITLAcc="",strFacRestrFrom="",strSubFacRestrFrom="";
		String strFacConversionfac="",strFacAdditionFunding="",strFacSubConversionfac="",strFacSubAdditionFunding="",strLeaderbank="",strSubLeaderbank="";
		String strRestrScheme="",strSubRestrScheme="",strtAdhocChk="",strReattach="",strReattachsub="",strMetLifeInsurance="",strMetLifeInsurancesub="";
		//added
		String strCgtmseApp="",strCgFee="",strCgIntRate="",strCgtmseAppsub="",strCgFeesub="",strCgIntRatesub="",strCompanyName="",strCompanyNameSub="";
		
		String strPremiumAmount="",strPremiumAmountSub="",strPremiumTenor="",strPremiumTenorSub="",strPremiumLoanAmount="",strPremiumLoanAmountSub="",
		 strInsAccountNo="",strInsAccountNoSub="",strInsFundedCompanyName="",strInsFundedCompanyNameSub="",strAdhocAddFacility="",strMarginRelaxtion="",strActualMargin="",
		 strRelaxedMargin="",strSubMarginRelaxtion="",strSubActualMargin="",strSubRelaxedMargin="",strIntDeferment="",strIntDefermentSub="";
		//added By Nikesha for review date
		String strReviewDate="",strReviewDateSub="";
		
		//String fbil_date="",fbil_tenor="",fbil_sub_date="",fbil_sub_tenor="";
		HashMap hshQueryValues2 = new HashMap();
		HashMap hshQuery2 = new HashMap();
		try
		{
			
			
			
			
			String strAppType=correctNull((String)hshValues.get("strAppType"));
			strBorrowId = correctNull((String)hshValues.get("comapp_id"));
			if(strBorrowId.equalsIgnoreCase(""))
			{
				strBorrowId = correctNull((String)hshValues.get("hidapplicantid"));
			}
			strBorrow_newId = correctNull((String)hshValues.get("comapp_newid"));
			if(strBorrow_newId.equals(""))
			{
				strBorrow_newId = correctNull((String)hshValues.get("comapp_new_id"));
			}
			
			strAppno = correctNull((String)hshValues.get("appno"));
			strSno = correctNull((String)hshValues.get("selsno"));
			strSubsno = correctNull((String)hshValues.get("selsubsno"));
			strLoanAmt = correctNull((String)hshValues.get("txt_line_credit"));		
			
			strAction = correctNull((String)hshValues.get("hidAction"));
			
			strFacType = correctNull((String)hshValues.get("factype"));
			//strFacCategory = correctNull((String)hshValues.get("faccategory"));
			//strAdhocMonths = correctNull((String)hshValues.get("txt_adhocmonths"));
            strBranchName=correctNull((String)hshValues.get("txt_branchname"));
            strProposalin=correctNull((String)hshValues.get("sel_proposalvaluesin"));
            strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            strissaral=correctNull((String)hshValues.get("strIsSaral"));
            strSolid=correctNull((String)hshValues.get("strSolid"));
            strModType=correctNull((String)hshValues.get("sessionModuleType"));
			if(strModType.equalsIgnoreCase("CORP")){
				strModType="C";
				strFinancialReq="";
			}else if(strModType.equalsIgnoreCase("AGR")){
				
				strModType="A";
				strFinancialReq=correctNull((String)hshValues.get("sel_facilityrequired"));
			}else{
				strModType="";
				strFinancialReq="";
			}
			//since this values are made by default as Rs
			if(strProposalin.equalsIgnoreCase(""))
			{
				strProposalin="R";	
			}
			strAgrSchemeType=correctNull((String)hshValues.get("sel_schemetype"));
            //kamal added
            //ack_no = correctNull((String)hshValues.get("txtcomapp_ack"));

			/*if(!strAdhocMonths.trim().equals(""))
			{
				intAdhocMonths = Integer.parseInt(strAdhocMonths);
			}*/
            
			strQuery = SQLParser.getSqlQuery("sel_RenewFlg^"+strAppno);
			if(rs != null)
			{rs.close();}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strRenew_flag=correctNull((String)rs.getString("app_renew_flag"));
			}
			
            //added by bhaskar
            
            if(!strAppno.equalsIgnoreCase("new") && !strAppno.equalsIgnoreCase(""))
            {
            
            String strExisLimitMain="",strProposedLimitMain="";
            String strExisLimitSub="",strProposedLimitSub="";
            
            String strExisLimitSub1="",strProposedLimitSub1="";
            
            strExisLimitMain=correctNull((String) hshValues.get("txt_exist_limit"));
            strProposedLimitMain=correctNull((String) hshValues.get("txt_proposed_limit"));
            
            strExisLimitSub1=correctNull((String) hshValues.get("txt_subexist_limit"));
            strProposedLimitSub1=correctNull((String) hshValues.get("txt_subproposed_limit"));
            double dbSubExistingLimit=0.00;
            double dbSubProposedLimit=0.00;
            double dbtotalExistLimitSub=0.00;
            double dbtotalProposedLimitSub=0.00;
            
            dbSubExistingLimit=Double.parseDouble(Helper.correctDouble((String)strExisLimitSub1));
            dbSubProposedLimit=Double.parseDouble(Helper.correctDouble((String)strProposedLimitSub1));
            if( !strSno.equalsIgnoreCase(""))
            {
            if((strFacType.equalsIgnoreCase("sublimit") && strAction.equalsIgnoreCase("insert")) || (strFacType.equalsIgnoreCase("facility") && strAction.equalsIgnoreCase("insert"))
            		|| (strFacType.equalsIgnoreCase("facility") && strAction.equalsIgnoreCase("update")))
            {
            
            strQuery = SQLParser.getSqlQuery("selfacilitylist^" + strAppno +"^"+strSno);
			
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strExisLimitSub=Helper.correctNull((String)rs.getString("facility_existing"));
				dbtotalExistLimitSub=dbtotalExistLimitSub+Double.parseDouble(Helper.correctDouble(strExisLimitSub));
				strProposedLimitSub=Helper.correctNull((String)rs.getString("facility_proposed"));
				dbtotalProposedLimitSub=dbtotalProposedLimitSub+Double.parseDouble(Helper.correctDouble(strProposedLimitSub));
			}
            }
            }
			
			if(strFacType.equalsIgnoreCase("sublimit") && strAction.equalsIgnoreCase("insert"))
			{			
			dbtotalExistLimitSub=dbtotalExistLimitSub+Double.parseDouble(Helper.correctDouble(strExisLimitSub1));
			dbtotalProposedLimitSub=dbtotalProposedLimitSub+Double.parseDouble(Helper.correctDouble(strProposedLimitSub1));
			}
			//Prakash Need to Check
			if(strFacType.equalsIgnoreCase("sublimit") && strAction.equalsIgnoreCase("update"))
			{			
			//dbtotalExistLimitSub=dbtotalExistLimitSub+Double.parseDouble(Helper.correctDouble(strExisLimitSub1));
			//dbtotalProposedLimitSub=dbtotalProposedLimitSub+Double.parseDouble(Helper.correctDouble(strProposedLimitSub1));
				strQuery = SQLParser.getSqlQuery("selfacilitylist_subupd^" + strAppno +"^"+strSubsno+"^"+strSno);
				
				if(rs != null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					strExisLimitSub=Helper.correctNull((String)rs.getString("facility_existing"));
					dbtotalExistLimitSub=dbtotalExistLimitSub+Double.parseDouble(Helper.correctDouble(strExisLimitSub));
					strProposedLimitSub=Helper.correctNull((String)rs.getString("facility_proposed"));
					dbtotalProposedLimitSub=dbtotalProposedLimitSub+Double.parseDouble(Helper.correctDouble(strProposedLimitSub));
				}

				dbtotalExistLimitSub=dbtotalExistLimitSub+Double.parseDouble(Helper.correctDouble(strExisLimitSub1));
				dbtotalProposedLimitSub=dbtotalProposedLimitSub+Double.parseDouble(Helper.correctDouble(strProposedLimitSub1));
				
			}
			
				if(correctNull((String)hshValues.get("selsubadhoclimit")).equalsIgnoreCase("R"))
				{
					 if(Double.parseDouble(Helper.correctDouble(strProposedLimitMain))<dbSubProposedLimit)
					 {
						 
						    //String strExp="$" + "Existing Limit is less than Sub limit"; 
							//throw new Exception(strExp);
						    strLflag="Y";
						    
						 
					 }
				}
            }
            
            strQuery = SQLParser.getSqlQuery("getFacilityData^" + strAppno +"^"+Helper.correctInt(strSno));
			
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strtAdhocChk=Helper.correctNull(rs.getString("facility_category"));
				strAdhocAddFacility=Helper.correctNull(rs.getString("FACILITY_ADHOCFAC"));
			}
			
			//ended
            if(strLflag.equalsIgnoreCase("N"))
            {
            strLoanAmt=Helper.convertApplicationToSetup(strProposalin, Double.parseDouble(Helper.correctDouble(strLoanAmt)));
            strLoanAmt=jtn.format(Double.parseDouble(Helper.correctDouble(strLoanAmt)));
			strAction = strAction.trim();
			strApp = strAppno.trim();
		
			if(strApp.equals("new"))
			{
				String strType="C";//mck
				hshformula.put("comapp_id",strBorrowId);//mck
				hshformula.put("apptype",strType);//mck
				hshformula.put("strSolid",strSolid);//mck
				strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
				hshValues.put("appno",strAppno);				
				
			}
			else
			{
				hshValues.put("selsno",strSno);		
				hshValues.put("selsubsno",strSubsno);		
			}
			if(strAppno.trim().equalsIgnoreCase("new"))
			{
				throw new Exception("$ Cannot Create Proposal. Application Number Not found.");
			}
			if(strAction.trim().equals("delete"))
			{
				double dblFacAmt=0,dblLoanAmount =0;
				String strFacAmt = correctNull((String)hshValues.get("txt_proposed_limit"));
				strFacAmt=Helper.convertApplicationToSetup(strProposalin,Double.parseDouble(Helper.correctDouble(strFacAmt)));
				if(!strFacAmt.trim().equals(""))
				{
					dblFacAmt = Double.parseDouble(Helper.correctDouble(strFacAmt));
				}
				if(!strLoanAmt.trim().equals(""))
				{
					dblLoanAmount = Double.parseDouble(Helper.correctDouble(strLoanAmt));
				}
				if(strSubsno.equalsIgnoreCase("0"))
				{
					strLoanAmt = Helper.formatDoubleValue(dblLoanAmount-dblFacAmt);
				}
				else
				{
					strLoanAmt=Helper.formatDoubleValue(dblLoanAmount);
				}
				booProcess = true;
			}
//			if(!strAction.trim().equals("delete"))
//			{
				if(!strLoanAmt.trim().equals(""))
				{
					
					String strLoanamtinlacs="";
					if(strProposalin.equalsIgnoreCase("C"))
					{
						strLoanamtinlacs=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strLoanAmt))*100.0);
					}
					else
					{
						strLoanamtinlacs=strLoanAmt;
					}
					rs=DBUtils.executeLAPSQuery("selautolimitid^C^"+strLoanamtinlacs);
					if(rs.next())
					{
						strLimitId =rs.getString(1);
						booProcess = true;
					}
				}
				else
				{
					strLoanAmt="0";
				}
				if(booProcess==true)
				{
					// Starts Updation for applications table
					
					if(strApp.trim().equals("new"))
					{
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","insapplications");
						arrValues.add(strAppno);
						arrValues.add(strLimitId);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
						if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("SRE"))
						{
							arrValues.add("E");
						}
						else if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL"))
						{
							arrValues.add("U");
						}
						else if(Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC"))
						{
							arrValues.add("H");
						}
						else
						{
							if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("CORP"))
							{
								arrValues.add("C");
							}
							else
							{
								arrValues.add("A");
							}
						}
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						arrValues.add(strProposalin);
						arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("Y");
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(strFinancialReq);
						
					}
					else
					{
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updapplications");
						arrValues.add(strLimitId);
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						arrValues.add(strProposalin);
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add(strFinancialReq);
						arrValues.add(strAppno);
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					if(strApp.trim().equals("new")){
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updatefacilityrenewflag");
						arrValues.add(Helper.correctNull((String)hshValues.get("selfacilitytype")));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					if(strApp.trim().equals("new")){						
						//General Terms & Condition for Facilities by its Module Type -->Venkata Prasad Chowdary					
						
						String strTermsType="P",strParentid="";
						String strTermsDel="N",strTerms="",strTermsno="",strMode="",strPrePost="";
						if(strModType.equalsIgnoreCase("C")){
							rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"C"+"^"+"G"+"^"+"pre");							
							while(rs2.next())
							{
								strTermsno = rs2.getString("fac_sno");
								strTerms = rs2.getString("fac_terms");
								strMode= rs2.getString("fac_mode");
								strPrePost=rs2.getString("fac_prepost");
								strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacCode));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull(strModType));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

							}
							if(rs2 !=null){
							rs2.close();
						}
							rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"C"+"^"+"G"+"^"+"post");			
							while(rs2.next())
							{
								strTermsno = rs2.getString("fac_sno");
								strTerms = rs2.getString("fac_terms");
								strMode= rs2.getString("fac_mode");
								strPrePost=rs2.getString("fac_prepost");
								strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
								intUpdatesize = intUpdatesize+1;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacCode));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull(strModType));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

							}
							
							if(rs2 !=null){
								rs2.close();
							}
							//Instructions to Branch terms&Conditions -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"B");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
								//Specific Conditions -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"P");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
								
								//Other conditions -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"O");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
						}if(strModType.equalsIgnoreCase("A")){						

							rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"A"+"^"+"G"+"^"+"pre");							
							while(rs2.next())
							{
								strTermsno = rs2.getString("fac_sno");
								strTerms = rs2.getString("fac_terms");
								strMode= rs2.getString("fac_mode");
								strPrePost=rs2.getString("fac_prepost");
								strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacCode));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull(strModType));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);						

							}
							if(rs2 !=null){
							rs2.close();
						}
							rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"A"+"^"+"G"+"^"+"post");			
							while(rs2.next())
							{
								strTermsno = rs2.getString("fac_sno");
								strTerms = rs2.getString("fac_terms");
								strMode= rs2.getString("fac_mode");
								strPrePost=rs2.getString("fac_prepost");
								strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacCode));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull(strModType));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

							}
							
							if(rs2 !=null){
								rs2.close();
							}
							//Instructions to Branch terms&Conditions for Agri -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"B");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
								//Specific Conditions -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"P");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
								
								//Other conditions -->Archunan
								rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"O");			
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","insfacterms");								
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
									//arrValues.add(correctNull(strFacCode));
									arrValues.add(correctNull(""));
									arrValues.add(correctNull(strModType));
									arrValues.add(strTermsno);
									arrValues.add(correctNull(strTerms));
									arrValues.add(correctNull(strTermsType));
									arrValues.add(correctNull(strTermsDel));
									arrValues.add(" ");
									arrValues.add("N");
									arrValues.add(strPrePost);
									arrValues.add(strMode);
									arrValues.add(strParentid);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

								}
								if(rs2 !=null){
									rs2.close();
								}
						}
					}
					

					
					//Ends Updation for applications table
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					if(strApp.trim().equals("new"))
					{
						if(rs!=null)rs.close();
						rs=DBUtils.executeLAPSQuery("selcmabycomappid^"+strBorrowId);
						if(rs.next())
						{
							strFinStd =rs.getString("cma_no");
						}
						
						// Starts updation for com_demographics table
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commapplicantloanins2");
						arrValues.add(strAppno);

						if(strBorrowId.trim().equals(""))
						{
							strBorrowId="0";
						}
						arrValues.add(strBorrowId);
						arrValues.add(strFinStd);
						arrValues.add(strIndType);
						arrValues.add(strIndRating);
						arrValues.add("N");
						arrValues.add(strBorrow_newId);//for inserting customer new renewal id added by tharani for solving modify probelm
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					// Ends updation for com_demographics table		

					hshQuery=new HashMap();
					arrValues=new ArrayList();
					if(strApp.trim().equals("new"))
					{
						
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commworkflowins");
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
						
						/*intUpdatesize = intUpdatesize+1;
						arrValues.add(strAppno);
						hshQuery.put("strQueryId","inscomproposal");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
						
					}
					/****
					 * For Updating in inward register
					 */
					if(strApp.trim().equals("new"))
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updinwardappatached");
						arrValues.add("Y");
						arrValues.add("op");
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
					}
					else
					{
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
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","updinwardappatached");
							arrValues.add("Y");
							arrValues.add("op");
							arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
						}
					}
					
					
					

			//		hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}	
				else
				{
					String strExp="$" + "Proposed Limit not defined in Setup"; 
					throw new Exception(strExp);
				}

					// Starts updation for loandetails table		
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					if(strApp.trim().equals("new"))
					{
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commapplicantloanins3");
						arrValues.add(strAppno);
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add("0");
						arrValues.add("0");
					}
					else
					{
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updloandetails");
						String strCollpercent="";
						PerApplicantBean perapp = new PerApplicantBean();
						strCollpercent = perapp.getCollateralpercent(strAppno, strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strCollpercent);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strAppno);
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
			//}
					
	// Ends updation for loandetails table	
	
					/*strFacHead = correctNull((String) hshValues.get("facility_head"));
					stk = new StringTokenizer(strFacHead,"-");
					if(stk.hasMoreTokens())
					{
						strFacHead = (String)stk.nextToken();
					}*/
					strFacHead = correctNull((String) hshValues.get("facility_head_id_code"));

					/*strFacility =correctNull((String) hshValues.get("facility"));
					stk = new StringTokenizer(strFacility,"-");
					if(stk.hasMoreTokens())
					{
						strFacility = (String)stk.nextToken();
					}*/
					strFacility=correctNull((String) hshValues.get("facility_id_code"));


					strSubFacHead = correctNull((String) hshValues.get("facilitysub_head_id_code"));
					/*stk = new StringTokenizer(strSubFacHead,"-");
					if(stk.hasMoreTokens())
					{
						strSubFacHead = (String)stk.nextToken();
					}*/

					strSubFacility =correctNull((String) hshValues.get("facilitysub_id_code"));
					/*stk = new StringTokenizer(strSubFacility,"-");
					if(stk.hasMoreTokens())
					{
						strSubFacility = (String)stk.nextToken();
					}*/
					
					//added by bhaskar			
					
					strFacDetails=correctNull((String) hshValues.get("facilitydesc"));
					strFacSubDetails=correctNull((String) hshValues.get("facilitydescsub"));
					
					String s1[]=strFacDetails.split("-");
					String s2[]=strFacSubDetails.split("-");
					strFacCode=correctNull(s1[0]);
					strSubFacCode=correctNull(s2[0]);
					
					
					//ended
					
					strDesc = correctNull((String) hshValues.get("txt_desc"));
					strSubDesc  = correctNull((String) hshValues.get("txt_subdesc"));
					strExist = correctNull((String) hshValues.get("txt_exist_limit"));
					strSubExist = correctNull((String) hshValues.get("txt_subexist_limit"));
					strProposed = correctNull((String) hshValues.get("txt_proposed_limit"));
					strrenewaljustif = correctNull((String) hshValues.get("txt_renewaljustif"));
					
					strProposed_old = correctNull((String) hshValues.get("txt_proposed_limit_old"));
					strfacnature = Helper.correctNull((String) hshValues.get("facility_nature"));
					strfacTuf= Helper.correctNull((String) hshValues.get("sel_Tuf"));
					strSubfacnature = Helper.correctNull((String) hshValues.get("facilitysub_nature"));
					
					strSubProposed = correctNull((String) hshValues.get("txt_subproposed_limit"));
					strSubProposed_old = correctNull((String) hshValues.get("txt_subproposed_limit_old"));
					strrenewaljustifsub = correctNull((String) hshValues.get("txt_renewaljustif_sub"));

					
					//strIntadjust = correctNull((String) hshValues.get("txt_margin"));	
					//strSubIntadjust = correctNull((String) hshValues.get("txt_submargin"));
					strMargin = correctNull((String) hshValues.get("txt_margin1"));				
					strSubMargin = correctNull((String) hshValues.get("txt_margin2"));   
					//strInterest= correctNull((String) hshValues.get("txt_interest"));//mck					
					//strSubInterest= correctNull((String) hshValues.get("txt_subinterest"));//mck
                    //strapplication= 
                    //strsubapplication=                  
                    strBPLR=correctNull((String) hshValues.get("prd_intrate")); 
                    strSubBPLR=correctNull((String) hshValues.get("prd_subintrate"));                     
                   // strDP=correctNull((String) hshValues.get("txt_dp"));
                   // strSubDP=correctNull((String) hshValues.get("txt_sub_dp"));                    
            		//strSecurity=correctNull((String) hshValues.get("txt_security"));
            		//strSubSecurity=correctNull((String) hshValues.get("txt_sub_security"));            		
            		//strOutstanding=correctNull((String) hshValues.get("txt_outstanding"));
            		//strSubOutstanding=correctNull((String) hshValues.get("txt_sub_outstanding")); 
            		//strcbsaccno=correctNull((String) hshValues.get("txt_cbsaccno"));
            		//strSubcbsaccno=correctNull((String) hshValues.get("txt_subcbsaccno"));
            		//strfacilityintremarks=correctNull((String) hshValues.get("txt_intremarks"));
            		//strsubfacilityintremarks=correctNull((String) hshValues.get("txt_subintremarks"));
            		intfacMonths=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_facmonths")));
            		intsubfacMonths=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_subfacmonths")));
            		
            		
            		strOSDate=correctNull((String) hshValues.get("txt_osdate"));
            		//strSubOSDate=correctNull((String) hshValues.get("txt_sub_osdate"));
            		
            		//strExistbnktype=correctNull((String) hshValues.get("sel_existbanktype"));
            		//strExistSubbnktype=correctNull((String) hshValues.get("sel_sub_existbanktype"));
            		
            		strPropbnktype=correctNull((String) hshValues.get("sel_propbanktype"));
            		strPropSubbnktype=correctNull((String) hshValues.get("sel_sub_propbanktype"));
            		
            		strPurpose=correctNull((String) hshValues.get("txt_purpose"));
            		strSubPurpose=correctNull((String) hshValues.get("txt_subpurpose"));
            		
            		
            		strIntType=correctNull((String) hshValues.get("sel_inttype"));
                   	strSubIntType=correctNull((String) hshValues.get("sel_sub_inttype"));
            		
            		strRepayType=correctNull((String) hshValues.get("sel_repaytype"));
                   	strSubRepaytype=correctNull((String) hshValues.get("sel_sub_repaytype"));
            		
            		strGovtsponsschem=correctNull((String) hshValues.get("selectgovtmain"));
                   	strGovtSubSponScheme=correctNull((String) hshValues.get("selectgovt"));
                   	
                   	strFreshLimitMain=correctNull((String) hshValues.get("txt_freshlimitmain"));
                   	strFreshLimitSub=correctNull((String) hshValues.get("txt_freshlimitsub"));
            		
            		strSchemeType=correctNull((String) hshValues.get("schemetypemain"));
                   	strSubSchemeType=correctNull((String) hshValues.get("schemetype"));
            		
            		strSponsAgency=correctNull((String) hshValues.get("sel_sponser_agencymain"));
                   	strSubSponsAgency=correctNull((String) hshValues.get("sel_sponser_agency"));
            		
            		strSubsidyType=correctNull((String) hshValues.get("sel_subsidytypemain"));
                   	strSubSubsidyType=correctNull((String) hshValues.get("sel_subsidytype"));
            		
            		strsubsidyAmunt=correctNull((String) hshValues.get("submainamnt"));
                   	strSubsubsidyamount=correctNull((String) hshValues.get("subamt"));
                   	
                   	stragrSchemeType=correctNull((String) hshValues.get("sel_schemetype"));
                   	strsubagrSchemeType=correctNull((String) hshValues.get("sel_subschemetype"));                   	
                   	
                   	strHolidayPeriod=correctNull((String) hshValues.get("txt_installments"));
                   	strHolidayPeriodSub=correctNull((String) hshValues.get("txt_installments_sub"));
                   	
                   	strInterstRecieved=correctNull((String) hshValues.get("interestservised"));
                   	strInterstRecievedSub=correctNull((String) hshValues.get("interestservised_sub"));
                   	
                   	strInterestCharged=correctNull((String) hshValues.get("sel_interestcharge"));
                   	strInterestChargedSub=correctNull((String) hshValues.get("sel_interestcharge_sub"));
                   	
                   	strMarginTerms=correctNull((String) hshValues.get("txt_margin"));
                   	strMarginTermsSub=correctNull((String) hshValues.get("txt_margin_sub"));
                   	
                   	strModeOfPay=correctNull((String) hshValues.get("selmodepayment"));
                   	strModeOfPaySub=correctNull((String) hshValues.get("selmodepayment_sub"));
                   	
                   	strOperativeAccountNo=correctNull((String) hshValues.get("txt_operativeaccno"));
                   	strOperativeAccountNoSub=correctNull((String) hshValues.get("txt_operativeaccno_sub"));
                   	
                	strECSBankName=correctNull((String) hshValues.get("sel_ECSBankName"));
                   	strECSaccnttype=correctNull((String) hshValues.get("sel_ECSaccnttype"));
                   	strECSoperaccno=correctNull((String) hshValues.get("txt_ECSoperaccno"));
                   	strECSauthmode=correctNull((String) hshValues.get("sel_ECSauthmode"));
                   	strECSifsccode=correctNull((String) hshValues.get("txt_ECSifsccode"));
                   	
                   	//strRemarks=correctNull((String) hshValues.get("txt_remarks"));
                   	strRemarks="";
                   	//strRemarksSub=correctNull((String) hshValues.get("txt_remarks_sub"));
                   	strRemarksSub="";
                   	
                   	strPerInstall=correctNull((String) hshValues.get("sel_peridicityfac"));
                   	strPerInstallSub=correctNull((String) hshValues.get("sel_peridicityfacsub"));
                   	
                   	strfacSubIntType=correctNull((String) hshValues.get("sel_intsutype"));
                   	strSubFacSubIntType=correctNull((String) hshValues.get("sel_intsufacsubtype"));
                   	
                   	strIntFacId=correctNull((String) hshValues.get("hidIntIdFac"));
                   	strIntSubFacId=correctNull((String) hshValues.get("hidIntIdFacSub"));
                   	
                   	strIntBaseRateFac=correctNull((String) hshValues.get("hidBaseRateFac"));
                   	strIntBaseRateSubFac=correctNull((String) hshValues.get("hidBaseRateFacSub"));
                   	
                   	strCBSAccountNo=Helper.correctNull((String)hshValues.get("txtcbsaccno"));
                   	strSubCBSAccountNo=Helper.correctNull((String)hshValues.get("txtsubcbsaccno"));
                   	strFACILITYTYPEFOR=Helper.correctNull((String)hshValues.get("hidstrType"));
                   	sel_fac_desc = correctNull((String)hshValues.get("sel_fac_desc"));
        			
                	sel_subfac_desc = correctNull((String)hshValues.get("sel_subfac_desc"));
        			
                	stragency  = correctNull((String)hshValues.get("txt_agency")); 
                	
                	strsubagency  = correctNull((String)hshValues.get("txt_subagency"));  
                	strDuedate=correctNull((String) hshValues.get("txt_duedate"));
                	strdisplaydesc=correctNull((String) hshValues.get("sel_displaydesc"));
                	strsubdisplaydesc=correctNull((String) hshValues.get("sel_subdisplaydesc"));
                	strsubDuedate=correctNull((String) hshValues.get("txt_subduedate"));
                	strFacRestructedAcc=correctNull((String) hshValues.get("selfac_restr_acc"));
                	strSubFacRestructedAcc=correctNull((String) hshValues.get("selsubfac_restr_acc"));
                	strFacFITLAcc=correctNull((String) hshValues.get("selfac_fitl_acc"));
                	strSubFacFITLAcc=correctNull((String) hshValues.get("selsubfac_fitl_acc"));
                	strFacRestrFrom=correctNull((String) hshValues.get("hid_str_rsAcc"));
                	strSubFacRestrFrom=correctNull((String) hshValues.get("hid_str_rsAcc_sub"));
                	strFacConversionfac=correctNull((String) hshValues.get("sel_restr_conversionfac"));
                	strFacSubConversionfac=correctNull((String) hshValues.get("sel_restr_conversionfac_sub"));
                	strFacAdditionFunding=correctNull((String) hshValues.get("sel_restr_addfunding"));
                	strFacSubAdditionFunding=correctNull((String) hshValues.get("sel_restr_addfunding_sub"));
                	strLeaderbank=correctNull((String) hshValues.get("hid_Bankcode"));
                	strSubLeaderbank=correctNull((String) hshValues.get("hid_sub_Bankcode"));
                	strRestrScheme=correctNull((String)hshValues.get("sel_restr_scheme"));
                	strSubRestrScheme=correctNull((String)hshValues.get("sel_restr_scheme_sub"));
                	strFacCategory = correctNull((String)hshValues.get("seladhoclimit"));
                	strFacSubCategory = correctNull((String)hshValues.get("selsubadhoclimit"));
                	strAdhocFac = correctNull((String)hshValues.get("seladhocof"));
                	strSubAdhocFac = correctNull((String)hshValues.get("selsubadhocof"));
                	
                	strReattach=correctNull((String)hshValues.get("hidfacreattach"));
                	strReattachsub=correctNull((String)hshValues.get("hidfacreattachsub"));
                	
                	strMetLifeInsurance=correctNull((String)hshValues.get("txt_metlifeinsurance"));
                	strMetLifeInsurancesub=correctNull((String)hshValues.get("txt_submetlifeinsurance"));
                	
                	//added
                	strCgtmseApp=correctNull((String)hshValues.get("cgtmse_app"));
                	strCgtmseAppsub=correctNull((String)hshValues.get("cgtmse_appsub"));
                
                	
                	strCgFee=correctNull((String)hshValues.get("sel_cg_fee"));
                	strCgFeesub=correctNull((String)hshValues.get("sel_cg_feesub"));
                	
                	
                	strCgIntRate=correctNull((String)hshValues.get("txt_cg_int_rate"));
                	strCgIntRatesub=correctNull((String)hshValues.get("txt_cg_int_ratesub"));
                	
                	strInterestType=correctNull((String)hshValues.get("sel_interesttype"));
                	strSubInterestType=correctNull((String)hshValues.get("sel_sub_interesttype"));
                	
                	strInterestTypeOld=correctNull((String)hshValues.get("hidROI"));
                	strSubInterestTypeOld=correctNull((String)hshValues.get("hidROISub"));
                	
                	strCompanyName=correctNull((String) hshValues.get("sel_Processed_Type"));
                	strCompanyNameSub=correctNull((String) hshValues.get("sel_Processed_Type_sub"));
                
                	strPremiumTenor=correctNull((String) hshValues.get("txt_premium_tenor"));
                	strPremiumTenorSub=correctNull((String) hshValues.get("txt_premium_tenor_sub"));
                	strPremiumAmount=correctNull((String) hshValues.get("txt_premium_amt"));
                	strPremiumAmountSub=correctNull((String) hshValues.get("txt_premium_amt_sub"));
                	strInsAccountNo=correctNull((String) hshValues.get("txt_premium_Account_no"));
                	strInsAccountNoSub=correctNull((String) hshValues.get("txt_premium_Account_no_sub"));
                	strPremiumLoanAmount=correctNull((String) hshValues.get("txt_premium_loan_amt"));
                	strPremiumLoanAmountSub=correctNull((String) hshValues.get("txt_premium_loan_amt_sub"));
                	strInsFundedCompanyName=correctNull((String) hshValues.get("sel_Funded_Comp_Name"));
                	strInsFundedCompanyNameSub=correctNull((String) hshValues.get("sel_Funded_Sub_Comp_Name"));
                	strMarginRelaxtion=correctNull((String) hshValues.get("sel_margin"));
                	strActualMargin=correctNull((String) hshValues.get("sel_definedmargin"));
                	strRelaxedMargin=correctNull((String) hshValues.get("sel_relaxedmargin"));
                	strSubMarginRelaxtion=correctNull((String) hshValues.get("sel_marginsub"));
                	strSubActualMargin=correctNull((String) hshValues.get("sel_definedmarginsub"));
                	strSubRelaxedMargin=correctNull((String) hshValues.get("sel_relaxedmarginsub"));
                	strIntDeferment=correctNull((String) hshValues.get("hidintdefer_acc"));
                	strIntDefermentSub=correctNull((String) hshValues.get("hidintdefer_accsub"));
                	
                	//added By Nikesha B for Review date
                	strReviewDate=correctNull((String) hshValues.get("txt_reviewdate"));
                	strReviewDateSub=correctNull((String) hshValues.get("txt_subreviewdate"));
                	
                	/*fbil_date= correctNull((String) hshValues.get("txtmianDate"));
                	fbil_tenor= correctNull((String) hshValues.get("Tenormibormain"));
                	fbil_sub_date= correctNull((String) hshValues.get("txtsubDate"));
                	fbil_sub_tenor= correctNull((String) hshValues.get("Tenormiborsub"));*/
                	
                	                           	
					if(strFacHead.trim().equals(""))
					{
						strFacHead = "0";
					}
					if(strFacility.trim().equals(""))
					{
						strFacility ="0";
					}
					if(strExist.trim().equals(""))
					{
						strExist ="0";
					}

					if(strProposed.trim().equals(""))
					{
						strProposed ="0";
					}
					
					if(strsubsidyAmunt.trim().equals(""))
					{
						strsubsidyAmunt ="0";
					}
					
					/*if(strIntadjust.trim().equals(""))
					{
						strIntadjust ="0";
					}*/
					if(strBPLR.trim().equals(""))
					{
						strBPLR="0";
					}
					/*if(strDP.trim().equals(""))
					{
						strDP="0";
					}*/
					/*if(strSecurity.trim().equals(""))
					{
						strSecurity="0";
					}*/
					/*if(strOutstanding.trim().equals(""))
					{
						strOutstanding="0";
					}*/

					if(strFacType.equals("sublimit"))
					{

						if(strGroup.trim().equals(""))
						{
							strGroup="0";
						}
						if(strSubFacHead.trim().equals(""))
						{
							strFacHead = "0";
						}
						else
						{
							strFacHead = strSubFacHead;
						}
						if(strSubFacility.trim().equals(""))
						{
							strFacility ="0";
						}
						else
						{
							strFacility = strSubFacility;
						}
						
					 	if(strSubFacCode.trim().equals(""))
						{
	                   		strFacCode ="0";
						}
						else
						{
							strFacCode = strSubFacCode;
						}
					 	
					 	if(strFacSubDetails.trim().equals(""))
						{
					 		strFacDetails ="0";
						}
						else
						{
							strFacDetails = strFacSubDetails;
						}
					 	
						if(strSubExist.trim().equals(""))
						{
							strExist ="0";
						}
						else
						{
							strExist = strSubExist;
						}

						if(strSubDesc.trim().equals(""))
						{
							strDesc ="";
						}
						else
						{
							strDesc = strSubDesc;
						}
						if(strSubProposed.trim().equals(""))
						{
							strProposed ="0";
						}
						else
						{
							strProposed =strSubProposed;
						}
						if(strSubProposed_old.trim().equals(""))
						{
							strProposed_old ="0";
						}
						else
						{
							strProposed_old =strSubProposed_old;
						}
						/*if(strSubIntadjust.trim().equals(""))
						{
							strIntadjust ="0";
						}
						else
						{
							strIntadjust =strSubIntadjust;
						}*/
						/*if(strSubInterest.trim().equals(""))
						{
							strInterest ="0";
						}
						else
						{
							strInterest =strSubInterest;
						}*/
						if(strSubBPLR.trim().equals(""))
						{
							strBPLR="0";
						}
						else
						{
							strBPLR =strSubBPLR;
						}
						
						if(strSubMargin.trim().equals(""))
						{
							strMargin="0.00";
						}
						else
						{
							strMargin =strSubMargin;
						}
						
						/*if(strSubDP.trim().equals(""))
						{
							strDP="0.00";							
						}
						else
						{
							strDP =strSubDP;
						}*/
						
						/*if(strSubSecurity.trim().equals(""))
						{
							strSecurity="0.00";							
						}
						else
						{
							strSecurity =strSubSecurity;
						}*/
						
						
						/*if(strSubOSDate.trim().equals(""))
						{
							strOSDate="";							
						}
						else
						{
							strOSDate =strSubOSDate;
						}*/
						
						/*if(strExistSubbnktype.trim().equals(""))
						{
							//strExistbnktype="";							
						}
						else
						{
							//strExistbnktype =strExistSubbnktype;
						}*/
						
						if(strPropSubbnktype.trim().equals(""))
						{
							strPropbnktype="";							
						}
						else
						{
							strPropbnktype =strPropSubbnktype;
						}
						
						if(strSubIntType.trim().equals(""))
						{
							strIntType="";							
						}
						else
						{
							strIntType =strSubIntType;
						}
						
						if(strSubRepaytype.trim().equals(""))
						{
							strRepayType="";							
						}
						else
						{
							strRepayType=strSubRepaytype;
						}
						
						if(strGovtSubSponScheme.trim().equals(""))
						{
							strGovtsponsschem="";							
						}
						else
						{
							strGovtsponsschem=strGovtSubSponScheme;
						}
						if(strFreshLimitSub.trim().equals(""))
						{
							strFreshLimitMain="";
						}
						else
						{
							strFreshLimitMain=strFreshLimitSub;
						}

						if(strSubSchemeType.trim().equals(""))
						{
							strSchemeType="";							
						}
						else
						{
							strSchemeType=strSubSchemeType;
						}
						
						if(strSubSponsAgency.trim().equals(""))
						{
							strSponsAgency="";							
						}
						else
						{
							strSponsAgency=strSubSponsAgency;
						}
						
						if(strSubSubsidyType.trim().equals(""))
						{
							strSubsidyType="";							
						}
						else
						{
							strSubsidyType=strSubSubsidyType;
						}
						
						if(strSubsubsidyamount.trim().equals(""))
						{
							strsubsidyAmunt ="";
						}
						else
						{
							strsubsidyAmunt =strSubsubsidyamount;
						}
						if(strsubagrSchemeType.trim().equals(""))
						{
							stragrSchemeType ="";
						}
						else
						{
							stragrSchemeType =strsubagrSchemeType;
						}	
						
						//added by bhaskar
						if(strHolidayPeriodSub.equalsIgnoreCase(""))
						{
							strHolidayPeriod="0.00";
						}
						else
						{
							strHolidayPeriod=strHolidayPeriodSub;
							
						}
						
						if(strInterstRecievedSub.equalsIgnoreCase(""))
						{
							strInterstRecieved="";
						}
						else
						{
							strInterstRecieved=strInterstRecievedSub;
							
						}
						
						if(strInterestChargedSub.equalsIgnoreCase(""))
						{
							strInterestCharged="";
						}
						else
						{
							strInterestCharged=strInterestChargedSub;
							
						}
						
						if(strMarginTermsSub.equalsIgnoreCase(""))
						{
							strMarginTerms="";
						}
						else
						{
							strMarginTerms=strMarginTermsSub;
							
						}
						
						if(strModeOfPaySub.equalsIgnoreCase(""))
						{
							strModeOfPaySub="";
						}
						else
						{
							strModeOfPay=strModeOfPaySub;
							
						}
						
						if(strOperativeAccountNoSub.equalsIgnoreCase(""))
						{
							strOperativeAccountNo="0";
						}
						else
						{
							strOperativeAccountNo=strOperativeAccountNoSub;
							
						}
						if(strRemarksSub.equalsIgnoreCase(""))
						{
							
							strRemarks="";
						}
						else
						{
							strRemarks=strRemarksSub;
							
						}
						if(strPerInstallSub.trim().equalsIgnoreCase(""))
						{
							strPerInstall="";
						}
						else
						{
							strPerInstall=strPerInstallSub;
						}
						if(strSubFacSubIntType.trim().equalsIgnoreCase(""))
						{
							strfacSubIntType="";
						}
						else
						{
							strfacSubIntType=strSubFacSubIntType;
						}
						if(strIntSubFacId.trim().equalsIgnoreCase(""))
						{
							strIntFacId="";
						}
						else
						{
							strIntFacId=strIntSubFacId;
						}
						if(strIntBaseRateSubFac.trim().equalsIgnoreCase(""))
						{
							strIntBaseRateFac="";
						}
						else
						{
							strIntBaseRateFac=strIntBaseRateSubFac;
						}
						
						if(strSubfacnature.trim().equalsIgnoreCase(""))
						{
							strSubfacnature="";
						}
						else
						{
							strfacnature=strSubfacnature;
						}
						
						
						if(sel_fac_desc.trim().equalsIgnoreCase(""))
						{
							sel_fac_desc="";
						}
						else
						{
							sel_fac_desc=sel_subfac_desc;
						}
						if(strsubagency.equalsIgnoreCase(""))
						{
							strsubagency="";
						}
						else
						{
							stragency=strsubagency;
						}
						if(strsubDuedate.equalsIgnoreCase(""))
						{
							strDuedate="";
						}
						else
						{
							strDuedate=strsubDuedate;
						}
						if(strsubdisplaydesc.equalsIgnoreCase(""))
						{
							strsubdisplaydesc="";
						}
						else
						{
							strdisplaydesc=strsubdisplaydesc;
						}
						if(strSubFacRestructedAcc.equalsIgnoreCase(""))
						{
							strFacRestructedAcc="";
						}
						else
						{
							strFacRestructedAcc=strSubFacRestructedAcc;
						}
						if(strSubFacFITLAcc.equalsIgnoreCase(""))
						{
							strFacFITLAcc="";
						}
						else
						{
							strFacFITLAcc=strSubFacFITLAcc;
						}
						if(strSubFacRestrFrom.equalsIgnoreCase(""))
						{
							strFacRestrFrom="";
						}
						else
						{
							strFacRestrFrom=strSubFacRestrFrom;
						}
						if(strFacSubConversionfac.equalsIgnoreCase(""))
						{
							strFacConversionfac="";
						}
						else
						{
							strFacConversionfac=strFacSubConversionfac;
						}
						if(strFacSubAdditionFunding.equalsIgnoreCase(""))
						{
							strFacAdditionFunding="";
						}
						else
						{
							strFacAdditionFunding=strFacSubAdditionFunding;
						}
						if(strSubLeaderbank.equalsIgnoreCase(""))
						{
							strLeaderbank="";
						}
						else
						{
							strLeaderbank=strSubLeaderbank;
						}
						if(strSubCBSAccountNo.equalsIgnoreCase(""))
						{
							strCBSAccountNo="";
						}
						else
						{
							strCBSAccountNo=strSubCBSAccountNo;
						}
						
						//ended		
						
						
					///	gfcxgfxgfx
						
						strPurpose=strSubPurpose.trim().equals("")?"":strSubPurpose;
						
						//strOutstanding=strSubOutstanding.trim().equals("")?"0.00":strSubOutstanding;
						
						//strcbsaccno=(strcbsaccno.trim().equals("")?"":strSubcbsaccno);
						//strfacilityintremarks=(strsubfacilityintremarks.trim().equals("")?"":strsubfacilityintremarks);
						intfacMonths=intsubfacMonths;
						
						if(strSubRestrScheme.trim().equals(""))
						{
							strRestrScheme ="";
						}
						else
						{
							strRestrScheme =strSubRestrScheme;
						}
						if(strFacSubCategory.trim().equals(""))
						{
							strFacCategory ="";
						}
						else
						{
							strFacCategory =strFacSubCategory;
						}
						if(strSubAdhocFac.trim().equals(""))
						{
							strAdhocFac ="";
						}
						else
						{
							strAdhocFac =strSubAdhocFac;
						}
						if(strReattachsub.trim().equals(""))
						{
							strReattach ="";
						}
						else
						{
							strReattach =strReattachsub;
						}
						if(strMetLifeInsurancesub.trim().equals(""))
						{
							strMetLifeInsurance ="";
						}
						else
						{
							strMetLifeInsurance =strMetLifeInsurancesub;
						}
						
						if(strCgtmseAppsub.trim().equals(""))
						{
							strCgtmseApp ="";
						}
						else
						{
							strCgtmseApp =strCgtmseAppsub;
						}
						if(strCgFeesub.trim().equals(""))
						{
							strCgFee ="";
						}
						else
						{
							strCgFee =strCgFeesub;
						}
						
						
						if(strCgIntRatesub.trim().equals(""))
						{
							strCgIntRate ="";
						}
						else
						{
							strCgIntRate =strCgIntRatesub;
						}
						if(strSubInterestType.trim().equals(""))
						{
							strInterestType ="";
						}
						else
						{
							strInterestType =strSubInterestType;
						}
						if(strInterestTypeOld.trim().equals(""))
						{
							strInterestTypeOld ="";
						}
						else
						{
							strInterestTypeOld =strSubInterestTypeOld;
						}
						if(strCompanyNameSub.trim().equals(""))
						{
							strCompanyName ="";
						}
						else
						{
							strCompanyName =strCompanyNameSub;
						}
						
						
	                	if(strPremiumTenorSub.trim().equals(""))
						{
	                		strPremiumTenor ="";
						}
						else
						{
							strPremiumTenor =strPremiumTenorSub;
						}
						
						if(strPremiumAmountSub.trim().equals(""))
						{
							strPremiumAmount ="";
						}
						else
						{
							strPremiumAmount =strPremiumAmountSub;
						}
							
						if(strInsAccountNoSub.trim().equals(""))
							{
							strInsAccountNo ="";
							}
						else
							{
							strInsAccountNo =strInsAccountNoSub;
							}
						
						if(strPremiumLoanAmountSub.trim().equals(""))
						{
							strPremiumLoanAmount ="";
						}
					else
						{
						strPremiumLoanAmount =strPremiumLoanAmountSub;
						}
						
						if(strInsFundedCompanyNameSub.trim().equals(""))
						{
							strInsFundedCompanyName ="";
						}
					else
						{
						strInsFundedCompanyName =strInsFundedCompanyNameSub;
						}
						if(strSubMarginRelaxtion.trim().equals(""))
						{
							strMarginRelaxtion ="";
						}
					else
						{
						strMarginRelaxtion =strSubMarginRelaxtion;
						}
						if(strSubActualMargin.trim().equals(""))
						{
							strActualMargin ="";
						}
					else
						{
						strActualMargin =strSubActualMargin;
						}
						if(strSubRelaxedMargin.trim().equals(""))
						{
							strRelaxedMargin ="";
						}
					else
						{
						strRelaxedMargin =strSubRelaxedMargin;
						}
						if(strIntDefermentSub.trim().equals(""))
						{
							strIntDeferment ="";
						}
					else
						{
							strIntDeferment =strIntDefermentSub;
						}
						if(strReviewDateSub.trim().equals(""))
						{
							strReviewDate ="";
						}
					else
						{
							strReviewDate =strReviewDateSub;
						}
						if(strrenewaljustifsub.trim().equals(""))
						{
							strrenewaljustif ="";
						}
					else
						{
						strrenewaljustif =strrenewaljustifsub;
						}
						
						/*if(fbil_sub_date.trim().equals(""))
						{
							fbil_date ="";
						}
					else
						{
						fbil_date =fbil_sub_date;
						}
						
						if(fbil_sub_tenor.trim().equals(""))
						{
							fbil_tenor ="";
						}
					else
						{
						fbil_tenor =fbil_sub_tenor;
						}*/
					
					}	
					
					double dblFacValue=0.00,dblSelFacValue=0.00,dblSubLimitTot=0.00,dblCurProposed=0.00;

				if(strFacType.trim().equals("sublimit"))
				{
					if(strAction.equals("insert"))
					{
						strGroup = strSno;
					}
					else if(strAction.equals("update"))
					{
						strGroup = strSubsno;
					}
				}
				else if((strFacType.trim().equals("facility")) && (strAction.equals("update")) )
				{
					strGroup = strSno;
				}

				if(!strGroup.trim().equals(""))
				{
					strQuery = SQLParser.getSqlQuery("selfacilityval^"+strAppno +"^"+strGroup);
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblFacValue = rs.getDouble("facility_proposed");
					}
				}

				if(strAction.equals("update"))
				{	
					strQuery = SQLParser.getSqlQuery("selfacilityval^"+strAppno +"^"+strSno);
					
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblSelFacValue = rs.getDouble("facility_proposed");
					}
				}
				else if(strAction.equals("insert"))
				{
			//		dblSelFacValue = Double.parseDouble(strProposed);
				}
				if(!strGroup.trim().equals(""))
				{
					strQuery = SQLParser.getSqlQuery("seltotpropmainlimit^"+strAppno +"^"+strGroup);
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblSubLimitTot = rs.getDouble(1);
					}
				}
				dblCurProposed = Double.parseDouble(Helper.correctDouble(strProposed));

				double dblSublimit = 0.00;

		if(strFacType.equals("sublimit")) 
		{
			dblSublimit = ((dblSubLimitTot-dblSelFacValue)+dblCurProposed);
			if( (dblFacValue<dblSublimit) && (!strAction.equals("delete"))  )
			{
		//	strMsg  = "Sum of the sub-limits should not exceed facility limit ";
		//	updflag=false;
			}	 				
		}	 
		else if( (strFacType.equals("facility")) && (strAction.equals("update")))
		{
			if( dblSubLimitTot > dblCurProposed )
			{
	//	strMsg  = "Sum of the sub-limits should not exceed facility limit ";
	//	updflag=false;
			}

		}
				if((strFacType.equals("facility")) && (strAction.equals("update")) )
				{
					strGroup ="0";
				}
		
					if(strBorrowId.trim().equals(""))
					{
						strBorrowId ="0";
					}
							String strBorrowerType="";
							String strIndustrytype="";
							strQuery = SQLParser.getSqlQuery("findborrowergroup^"+strBorrowId);
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strBorrowerType =correctNull((String)rs.getString("comapp_group"));
								strIndustrytype=correctNull((String)rs.getString("scale"));
							}
						
							double dblBanknetfunds=0.00;
							double dblSingleborrower=0.00;
							double dblSingleborrowerinfra=0.00;
							double dblGroupborrower=0.00;
							double dblGroupborrowerinfra=0.00;
							double dblExposureLimit=0.00;
							strQuery = SQLParser.getSqlQuery("selbanknetfunds");
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								dblBanknetfunds=rs.getDouble("net_bankfunds");
								dblSingleborrower=rs.getDouble("net_singleborrexp");
								dblGroupborrower=rs.getDouble("net_groupborrexp");
								dblSingleborrowerinfra=rs.getDouble("net_singleborrinfra");
								dblGroupborrowerinfra=rs.getDouble("net_groupborrinfra");
								
								if(strBorrowerType.trim().equals(""))
								{
									if(strIndustrytype.equals("4"))
									{
										dblExposureLimit = (dblBanknetfunds * (dblSingleborrowerinfra/100));
									}
									else
									{
										dblExposureLimit = (dblBanknetfunds * (dblSingleborrower/100));
									}
								}
								else
								{
									if(strIndustrytype.equals("4"))
									{
										dblExposureLimit = (dblBanknetfunds * (dblGroupborrowerinfra/100));
									}
									else
									{
										dblExposureLimit = (dblBanknetfunds * (dblGroupborrower/100));
									}
								}
								if(!(strProposalin.equalsIgnoreCase("C")))
								{
									dblExposureLimit=dblExposureLimit*100;
								}
							}

							double dblLoanAmt = Double.parseDouble(Helper.correctDouble(strLoanAmt));

							boolean boollimitchanged = false;
						if(!strProposed.equals(strProposed_old))
						{
							boollimitchanged = true;
						}
						boolean boolROIchanged = false;
						if(!strInterestType.equals(strInterestTypeOld))
						{
							boolROIchanged = true;
						}
						
						if(strAction.equals("update"))
						{
							
							if(rs != null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("select_facilityCode^"+strAppno+"^"+strSno);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								if(!Helper.correctNull(rs.getString("facility_intsubtype")).equalsIgnoreCase(strfacSubIntType))
								{
									if(boolROIchanged==false)
									boolROIchanged = true;
								}
								
								if(strRepayType.equalsIgnoreCase("NE")&& !Helper.correctNull(rs.getString("FACILITY_PERINSTALL")).equalsIgnoreCase(strPerInstall))
								{
									intUpdatesize = intUpdatesize+1;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId", "delete_repayschedule_corp");
									arrValues.add(strAppno);
									arrValues.add(strSno);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								}

								
							}
							
							
						}

						strDiff ="0";
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						if(strAction.equals("update"))
						{
							
							
							hshQuery.put("strQueryId","updfacilities_undostatus");
							arrValues.add("");
							arrValues.add("op");
							arrValues.add("");
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							/* *************************************************************  */
							if(rs != null)
							{
								rs.close();
							}
							String strCGTMSEFlag="";
							strQuery = SQLParser.getSqlQuery("applications_CGTMSEFlag_corp^"+strAppno+"^"+strSno);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strCGTMSEFlag=Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
							}
							/* ************Added to update Limits Sanctioned/ Declined*************** */
							if(rs != null)
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("checkuniquefacility^"+strAppno +"^"+strFacHead+"^"+strFacility+"^"+strFacCategory);
							if(rs != null)
							{
								rs.close();
							}
							
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								int intExistSno= rs.getInt(1);
								int intSno = Integer.parseInt(strSno);
								if(intSno!=intExistSno)
								{
									//updflag=false;
									/*if(strFacCategory.trim().equals("R"))
									{
										strMsg="Duplication of Main facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("A"))
									{
										strMsg="Duplication of adhoc facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("I"))
									{
										strMsg="Duplication of Inner facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("O"))
									{
										strMsg="Duplication of Outer facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("C"))
									{
										strMsg="Duplication of Inter changeable facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("P"))
									{
										strMsg="Duplication of Apportion facility will not be allowed";
									}	*/						
									
								}
							}
								//strFacCode
							ResultSet rsFacCode = null;
							String strAccountOpenFlag="";
							if(!strFacCode.equalsIgnoreCase("")){
							String strQuery2 = SQLParser.getSqlQuery("sel_otherdetails^"+strFacCode);
							rsFacCode = DBUtils.executeQuery(strQuery2);
							if(rsFacCode.next())
							{
								if(Helper.correctNull((String)rsFacCode.getString("COM_LOANACC")).equalsIgnoreCase("Y"))
								{
									strAccountOpenFlag="Y";
								}
								else
								{
									strAccountOpenFlag="N";
								}
							}
							else
							{
								strAccountOpenFlag="N";
							}
							}
							
							String cgtmseappl="",strcgtmseFacGrp="";
							strQuery=SQLParser.getSqlQuery("sel_proposedLimit^"+strAppno+"^"+strSno);
							rs=DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								cgtmseappl=Helper.correctNull((String)rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
								strcgtmseFacGrp=Helper.correctNull((String)rs.getString("facility_group"));
							}
							
							if(rsFacCode!=null)
								rsFacCode.close();
							
								strGroup = strSubsno;	
								intUpdatesize = intUpdatesize+1;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								
								hshQuery.put("strQueryId","updfacility");
								arrValues.add(correctNull(strFacHead));//1
								arrValues.add(correctNull(strFacility));//2
								arrValues.add(correctNull(strBorrowId));//3
								arrValues.add(correctNull(strExist));//4
								arrValues.add(correctNull(strProposed));//5
								arrValues.add(correctNull(strDiff));//6
								//arrValues.add(correctNull(strIntadjust));
								arrValues.add(correctNull(strGroup));//7
								arrValues.add(correctNull(strDesc));//8
								arrValues.add(correctNull(strFacCategory));//9
								arrValues.add(correctNull(Integer.toString(intfacMonths)));//10
								//arrValues.add(correctNull(strInterest));//mck
								arrValues.add(correctNull(strBranchName));//11
								//arrValues.add(correctNull(strMargin));
								arrValues.add(correctNull(strBPLR));//added by suresh for inserting BPLR 12
								//arrValues.add(correctNull(strDP));
								//arrValues.add(correctNull(strOutstanding));
								//arrValues.add(correctNull(strSecurity));
								//arrValues.add(correctNull(strcbsaccno));
								//arrValues.add(correctNull(strfacilityintremarks));
								arrValues.add(correctNull(strOSDate));// ADDED BY PASHANTH FOR OUT STANDING DATE 13
								//arrValues.add(correctNull(strExistbnktype));//ADDED BY PASHANTH FOR BANK TYPE
								arrValues.add(correctNull(strPropbnktype));//ADDED BY PASHANTH FOR BANK TYPE 14
								arrValues.add(strPurpose);//15
								//added by bhaskar								
								arrValues.add(correctNull(strIntType));//16								
								arrValues.add(correctNull(strGovtsponsschem));//17
								arrValues.add(correctNull(strSchemeType));//18
								arrValues.add(correctNull(strSponsAgency));//19
								arrValues.add(correctNull(strSubsidyType));	//20
								arrValues.add(correctNull(strsubsidyAmunt));//21
								arrValues.add(correctNull(strRepayType));//22
								arrValues.add(correctNull(strFacCode));//23
								arrValues.add(correctNull(strFacDetails));	//24							
								arrValues.add(correctNull(stragrSchemeType));//25
								//added by bhaskar
								arrValues.add(correctNull(strHolidayPeriod));//26	
								arrValues.add(correctNull(strInterstRecieved));//27
								arrValues.add(correctNull(strInterestCharged));//28
								arrValues.add(correctNull(strMarginTerms));//29
								arrValues.add(correctNull(strModeOfPay));//30								
								arrValues.add(correctNull(strOperativeAccountNo));//31
								arrValues.add(correctNull(strRemarks));	//32
								arrValues.add(correctNull(strPerInstall));//33
								arrValues.add(correctNull(strfacSubIntType));//34
								if(strIntType.equalsIgnoreCase("Flo"))
									arrValues.add("");
								else
									arrValues.add(correctNull(strIntFacId));//35
								arrValues.add(correctNull(strIntBaseRateFac));//36
								if(strFacFITLAcc.equalsIgnoreCase("Y") && sel_fac_desc.equalsIgnoreCase("2"))
									arrValues.add(correctNull(strFacRestrFrom.replaceAll("@","")));//37
								else
									arrValues.add(correctNull(strCBSAccountNo));//37
								arrValues.add(correctNull(strProposed));//38
								arrValues.add(correctNull(strfacTuf));//39
								arrValues.add(correctNull(strBPLR));
								arrValues.add(correctNull(stragency));
     							arrValues.add(correctNull(sel_fac_desc));
     							arrValues.add(correctNull(strFreshLimitMain)); 
     							arrValues.add(correctNull(strAccountOpenFlag)); 
     							arrValues.add(correctNull(strDuedate)); 
     							arrValues.add(correctNull(strdisplaydesc));
     							arrValues.add(correctNull(strFacRestructedAcc));
    							arrValues.add(correctNull(strFacFITLAcc));
    							arrValues.add(correctNull(strFacRestrFrom));//49
    							if(sel_fac_desc.equalsIgnoreCase("3"))
    								arrValues.add("S");
    							else if(sel_fac_desc.equalsIgnoreCase("2"))
    								arrValues.add("R");
    							else if(sel_fac_desc.equalsIgnoreCase("4"))
    								arrValues.add("P");
    							else
    								arrValues.add("F");		
    							
    							if(sel_fac_desc.equalsIgnoreCase("3"))
    								arrValues.add("S");
    							else if(sel_fac_desc.equalsIgnoreCase("2"))
    								arrValues.add("Y");
    							else if(sel_fac_desc.equalsIgnoreCase("4"))
    								arrValues.add("P");
    							else
    								arrValues.add("");	
    							
    							arrValues.add(correctNull(strFacConversionfac));//52
    							arrValues.add(correctNull(strFacAdditionFunding));
    							arrValues.add(correctNull(strLeaderbank));
    							arrValues.add(correctNull(strRestrScheme));
    							if(sel_fac_desc.equalsIgnoreCase("4"))
    							{
    								String strTemp1="";
    								String strTemp = "and PS_APP_SNO='"+strSno+"'";
    								String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strTemp);
    								ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
    								if(rsPS.next())
    								{
    									boolean bflag=false;
    									int count=0;
    									strTemp1=Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS"));
    									String arrTerms[]=strTemp1.split("@");
    									for(int i=0;i<arrTerms.length;i++)
    									{
    										if(arrTerms[i].equalsIgnoreCase("LAD") || arrTerms[i].equalsIgnoreCase("SUBLIMIT"))
    										{
    											count++;
    										}
    									}
    									
    									if(count==arrTerms.length)
    									{
    										bflag=true;
    									}
    									if(bflag)
    										arrValues.add("A");
    									else
    										arrValues.add("");	
    								}
    								else
    								{
    									arrValues.add("");
    								}
    							}
    							else
    							{
    								arrValues.add("");
    							}
     							//ended
     							arrValues.add(correctNull(strAdhocFac));//57
     							arrValues.add(correctNull(strBPLR));
     							arrValues.add(strReattach);
     							arrValues.add(strMetLifeInsurance);//60
     							
     							//ADDED
     							arrValues.add(correctNull(strCgtmseApp));
     							arrValues.add(correctNull(strCgFee));
     							arrValues.add(correctNull(strCgIntRate));
     							arrValues.add(correctNull(strInterestType));
                                arrValues.add(correctNull(strCompanyName));
                                arrValues.add(correctNull(strPremiumTenor));
                                arrValues.add(correctNull(strPremiumLoanAmount));
                                arrValues.add(correctNull(strInsAccountNo)); 
                                arrValues.add(correctNull(strPremiumAmount));
                                arrValues.add(correctNull(strInsFundedCompanyName));
                                arrValues.add(correctNull(strMarginRelaxtion));
     							arrValues.add(correctNull(strActualMargin));
     							arrValues.add(correctNull(strRelaxedMargin));
     							arrValues.add(correctNull(strIntDeferment));//74
     							
     							//ADDED by Nikesha B
     							arrValues.add(correctNull(strReviewDate));
     							arrValues.add(correctNull(strrenewaljustif));
     							arrValues.add(correctNull(strECSBankName));
     							arrValues.add(correctNull(strECSaccnttype));
     							arrValues.add(correctNull(strECSoperaccno));
     							arrValues.add(correctNull(strECSauthmode));
     							arrValues.add(correctNull(strECSifsccode));
     							//arrValues.add(correctNull(fbil_date));
     							//arrValues.add(correctNull(fbil_tenor));
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));//78
								
								
								
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
							if(dblExposureLimit<=dblLoanAmt)
							{
								updflag=false;
								strMsg="Line of credit is more than exposure limit";
							}
						/* *************************** */	
							
							if(!sel_fac_desc.equalsIgnoreCase("4") && (strIntType.equalsIgnoreCase("Fix") || strBPLR.equalsIgnoreCase("0")|| strBPLR.equalsIgnoreCase("0.00") || boollimitchanged || boolROIchanged))
							{
								intUpdatesize++;
					    		hshQuery = new HashMap();
					    		arrValues=new ArrayList();
					    		arrValues.add(strSno);
					    		arrValues.add(strAppno);
					    		hshQuery.put("strQueryId", "del_facility_mclrspread");
					    		hshQuery.put("arrValues", arrValues);
					    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
					    		
					    		intUpdatesize++;
					    		hshQuery = new HashMap();
					    		arrValues=new ArrayList();
					    		arrValues.add(strSno);
					    		arrValues.add(strAppno);
					    		hshQuery.put("strQueryId", "del_facilitysno_mclrspreadvalue");
					    		hshQuery.put("arrValues", arrValues);
					    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
					    		
					    		if(strBPLR.equalsIgnoreCase("0") || boollimitchanged|| boolROIchanged)
					    		{
						    		intUpdatesize++;
						    		hshQuery = new HashMap();
						    		arrValues=new ArrayList();
						    		arrValues.add("0.0");
						    		arrValues.add("0.0");
						    		arrValues.add("0.0");
						    		arrValues.add("0.0");
						    		arrValues.add("");
						    		arrValues.add("");
						    		arrValues.add("");
						    		arrValues.add(strSno);
						    		arrValues.add(strAppno);
						    		hshQuery.put("strQueryId", "upd_facility_interest");
						    		hshQuery.put("arrValues", arrValues);
						    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
						    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
					    		}
							}
							if(!sel_fac_desc.equalsIgnoreCase("4"))
							{
								if(strfacSubIntType.equalsIgnoreCase("MCLR")||strfacSubIntType.equalsIgnoreCase("BR")||strfacSubIntType.equalsIgnoreCase("SMTB")||strfacSubIntType.equalsIgnoreCase("TYGS"))
								{
									intUpdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId", "del_commentsoninterestrate");
									arrValues.add(strAppno);
									arrValues.add("commentsonintrestrate");
									arrValues.add(strSno);
									hshQuery.put("arrValues", arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								}
							}
							
							intUpdatesize++;
				    		hshQuery = new HashMap();
				    		arrValues=new ArrayList();
				    		arrValues.add(strAppno);
				    		arrValues.add(strSno);
				    		arrValues.add("F");
				    		hshQuery.put("strQueryId", "del_facility_additionaldetails");
				    		hshQuery.put("arrValues", arrValues);
				    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
				    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
				    		
							if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
							{
					    		String[] strArr=strAdhocFac.split("~");
					    		intUpdatesize++;
					    		hshQuery = new HashMap();
					    		arrValues=new ArrayList();
					    		arrValues.add(strAppno);
					    		arrValues.add(strSno);
					    		arrValues.add(strArr[0]);
					    		arrValues.add(strArr[1]);
					    		arrValues.add(strFacCategory);
					    		arrValues.add("F");
					    		arrValues.add("");
					    		arrValues.add("");
					    		hshQuery.put("strQueryId", "ins_facility_additionaldetails");
					    		hshQuery.put("arrValues", arrValues);
					    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
							}
							
							
							String propCgtmseAppl="";
							if(strcgtmseFacGrp.equals("0"))
							{
								propCgtmseAppl=Helper.correctNull((String)hshValues.get("cgtmse_app"));
							}
							else
							{
								propCgtmseAppl=Helper.correctNull((String)hshValues.get("cgtmse_appsub"));
							}
							if(!cgtmseappl.equals(propCgtmseAppl))
							{
								intUpdatesize++;
								arrValues = new ArrayList();
								hshQuery = new HashMap();
								hshQueryValues.put("size", "1");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues", arrValues);
								hshQuery.put("strQueryId", "update_mis_appdetailssno");
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
							}
							if(!Helper.correctNull((String)hshValues.get("cgtmse_app")).equalsIgnoreCase(strCGTMSEFlag))
							{
								intUpdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_misappdetails");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
					    		
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_misappdisplayscreen");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_misappclassification");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
							//	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							}
							
						}
						else if(strAction.equals("insert")||strAction.equals(""))
						{
							strQuery = SQLParser.getSqlQuery("checkuniquefacility^"+strAppno +"^"+strFacHead+"^"+strFacility+"^"+strFacCategory);
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								updflag=true;
								if(strFacCategory.trim().equals("R"))
								{
									//strMsg="Duplication of regular facility will not be allowed";
									strMsg="";
								}
								else if(strFacCategory.trim().equals("A"))
								{
									//strMsg="Duplication of adhoc facility will not be allowed";
								}

							}
							if(dblExposureLimit<=dblLoanAmt)
							{
								updflag=false;
								strMsg="Line of credit is more than exposure limit";
							}

 							strGroup = strSno;
							if (strGroup.equals(""))
								strGroup="0";
							strQuery = SQLParser.getSqlQuery("maxfacilitysno^"+strAppno);
							
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strSno =rs.getString(1);
							}
							
							ResultSet rsFacCode = null;
							String strAccountOpenFlag="";
							String strQuery2 = SQLParser.getSqlQuery("sel_otherdetails^"+strFacCode);
							rsFacCode = DBUtils.executeQuery(strQuery2);
							if(rsFacCode.next())
							{
								if(Helper.correctNull((String)rsFacCode.getString("COM_LOANACC")).equalsIgnoreCase("Y"))
								{
									strAccountOpenFlag="Y";
								}
								else
								{
									strAccountOpenFlag="N";
								}
							}
							else
							{
								strAccountOpenFlag="N";
							}
							if(rsFacCode!=null)
								rsFacCode.close();

							hshQuery.put("strQueryId","insfacility_new");								
							arrValues.add(correctNull(strAppno));//1
							arrValues.add(correctNull(strFacHead));//2
							arrValues.add(correctNull(strFacility));//3
							arrValues.add(correctNull(strBorrowId));//4
							arrValues.add(correctNull(strExist));//5
							arrValues.add(correctNull(strProposed));//6
							arrValues.add(correctNull(strDiff));//7
							//arrValues.add(correctNull(strIntadjust));
							arrValues.add(correctNull(strSno));//8
							arrValues.add(correctNull(strGroup));//9
							arrValues.add(correctNull(strDesc));//10
							arrValues.add(correctNull(strFacCategory));//1
							arrValues.add(correctNull(Integer.toString(intfacMonths)));//12	
							//arrValues.add(correctNull(strInterest));//mck
							arrValues.add(correctNull(strBranchName));//13
							//arrValues.add(correctNull(strMargin));
							arrValues.add(correctNull(strBPLR));//added by suresh for inserting BPLR 14
							//arrValues.add(correctNull(strDP));
							//arrValues.add(correctNull(strOutstanding));
							//arrValues.add(correctNull(strSecurity));
							//arrValues.add(correctNull(strcbsaccno));
							//arrValues.add(correctNull(strfacilityintremarks));
							arrValues.add(correctNull(strOSDate));//15
							//arrValues.add(correctNull(strExistbnktype));
							arrValues.add(correctNull(strPropbnktype));//16
							arrValues.add(strPurpose);//17
							//added by bhaskar								
							arrValues.add(correctNull(strIntType));//18							
							arrValues.add(correctNull(strGovtsponsschem));//19
							arrValues.add(correctNull(strSchemeType));//20
							arrValues.add(correctNull(strSponsAgency));//21
							arrValues.add(correctNull(strSubsidyType));	//22
							arrValues.add(correctNull(strsubsidyAmunt));//23
							arrValues.add(correctNull(strRepayType));//24
							arrValues.add(correctNull(strFacCode));//25
							arrValues.add(correctNull(strFacDetails));//26
							arrValues.add(correctNull(stragrSchemeType));//27
							arrValues.add(correctNull(strHolidayPeriod));//28	
							arrValues.add(correctNull(strInterstRecieved));//29
							arrValues.add(correctNull(strInterestCharged));//30
							arrValues.add(correctNull(strMarginTerms));//31
							arrValues.add(correctNull(strModeOfPay));//32								
							arrValues.add(correctNull(strOperativeAccountNo));//33
							arrValues.add(correctNull(strRemarks));	//34
							arrValues.add(correctNull(strPerInstall));//35
							arrValues.add(correctNull(strfacSubIntType));//36
							if(strIntType.equalsIgnoreCase("Flo"))
								arrValues.add("");
							else
								arrValues.add(correctNull(strIntFacId));//37
							arrValues.add(correctNull(strIntBaseRateFac));//38
							if(strFacFITLAcc.equalsIgnoreCase("Y") && sel_fac_desc.equalsIgnoreCase("2"))
								arrValues.add(correctNull(strFacRestrFrom.replaceAll("@","")));//37
							else
								arrValues.add(correctNull(strCBSAccountNo));//39
							arrValues.add(correctNull(strBPLR));//40
							arrValues.add(correctNull(strProposed));//41
							arrValues.add(correctNull(strfacnature));//42
							arrValues.add(correctNull(strfacTuf));//43
							arrValues.add(correctNull(strBPLR));//44
							arrValues.add(correctNull(stragency));//45
							arrValues.add(correctNull(sel_fac_desc));
							arrValues.add(correctNull(strFreshLimitMain));
							arrValues.add(correctNull(strAccountOpenFlag));
							if(sel_fac_desc.equalsIgnoreCase("3"))
								arrValues.add("S");
							else if(sel_fac_desc.equalsIgnoreCase("2"))
								arrValues.add("R");
							else if(sel_fac_desc.equalsIgnoreCase("4"))
								arrValues.add("P");
							else
								arrValues.add("F");	
							arrValues.add(correctNull(strDuedate));
							arrValues.add(correctNull(strdisplaydesc));
							arrValues.add(correctNull(strFacRestructedAcc));
							arrValues.add(correctNull(strFacFITLAcc));
							if(sel_fac_desc.equalsIgnoreCase("3"))
								arrValues.add("S");
							else if(sel_fac_desc.equalsIgnoreCase("2"))
								arrValues.add("R");
							else if(sel_fac_desc.equalsIgnoreCase("4"))
								arrValues.add("P");
							else
								arrValues.add("F");	
							arrValues.add(correctNull(strFacConversionfac));
							arrValues.add(correctNull(strFacAdditionFunding));
							arrValues.add(correctNull(strLeaderbank));
							arrValues.add(correctNull(strFacRestrFrom));
							arrValues.add(correctNull(strRestrScheme));
							arrValues.add(correctNull(strAdhocFac));
							arrValues.add(strReattach);
							arrValues.add(strMetLifeInsurance);
							
							arrValues.add(correctNull(strCgtmseApp));
 							arrValues.add(correctNull(strCgFee));
 							arrValues.add(correctNull(strCgIntRate));
 							arrValues.add(correctNull(strInterestType));
 							arrValues.add(correctNull(strCompanyName));
 							arrValues.add(correctNull(strPremiumTenor));
 							arrValues.add(correctNull(strPremiumLoanAmount));
 							arrValues.add(correctNull(strInsAccountNo));
 							arrValues.add(correctNull(strPremiumAmount));
 							arrValues.add(correctNull(strInsFundedCompanyName));
 							arrValues.add(correctNull(strMarginRelaxtion));
 							arrValues.add(correctNull(strActualMargin));
 							arrValues.add(correctNull(strRelaxedMargin));
 							arrValues.add(correctNull(strIntDeferment));
 							
 							// added By Nikesha B for review Date
 							arrValues.add(correctNull(strReviewDate));
 							arrValues.add(correctNull(strrenewaljustif));
 							arrValues.add(correctNull(strECSBankName));
 							arrValues.add(correctNull(strECSaccnttype));
 							arrValues.add(correctNull(strECSoperaccno));
 							arrValues.add(correctNull(strECSauthmode));
 							arrValues.add(correctNull(strECSifsccode));
 							//arrValues.add(correctNull(fbil_date));
 							//arrValues.add(correctNull(fbil_tenor));
							//ended
							if(rs != null)
							{
								rs.close();
							}	
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
							{
								String[] strArr=strAdhocFac.split("~");
					    		intUpdatesize++;
					    		hshQuery = new HashMap();
					    		arrValues=new ArrayList();
					    		arrValues.add(strAppno);
					    		arrValues.add(strSno);
					    		arrValues.add(strArr[0]);
					    		arrValues.add(strArr[1]);
					    		arrValues.add(strFacCategory);
					    		arrValues.add("F");
					    		arrValues.add("");
					    		arrValues.add("");
					    		hshQuery.put("strQueryId", "ins_facility_additionaldetails");
					    		hshQuery.put("arrValues", arrValues);
					    		hshQueryValues.put(String.valueOf(intUpdatesize), hshQuery);
					    		hshQueryValues.put("size", String.valueOf(intUpdatesize));
							}
							
						}
						else if(strAction.equals("delete"))
						{
							if(strtAdhocChk.equalsIgnoreCase("R"))
							{
								String StrSubQuery=strAppno+"~"+strSno+"~";
								strQuery = SQLParser.getSqlQuery("sel_regularlimit^"+strAppno+"^"+StrSubQuery);
								if(rs != null)
								{rs.close();}
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									throw new Exception("$ Before deleting the regular limit kindly delete the Additional/Adhoc limit.");
								}
								
							}
						
							String stroldAppno="",stroldSno="",strfacSno="";
							if(strRenew_flag.equalsIgnoreCase("R") || strRenew_flag.equalsIgnoreCase("P"))
							{
								strQuery = SQLParser.getSqlQuery("getfacdetforsanction^"+strAppno +"^"+strSno);
								if(rs != null)
								{rs.close();}
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","update_renewFacility");
									arrValues.add(null);
									arrValues.add("0");
									arrValues.add(correctNull((String)rs.getString("facility_oldappno")));
									arrValues.add(correctNull((String)rs.getString("facility_oldappsno")));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									intUpdatesize++;
								}								
								
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","delfacility");
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								HashMap hshQueryValues1=new HashMap();
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_apppostsanction");
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues1.put("size","1");
								hshQueryValues1.put("1",hshQuery);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
								
								strQuery = SQLParser.getSqlQuery("delfacilitysno^"+strAppno +"^"+strSno);
								if(rs1!= null)
								{rs1.close();}
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next()){
									strfacSno=correctNull((String)rs1.getString("facility_sno"));
									stroldAppno=correctNull((String)rs1.getString("facility_oldappno"));
									stroldSno=correctNull((String)rs1.getString("facility_oldappsno"));
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","del_apppostsanction");
									arrValues.add(strAppno);
									arrValues.add(strfacSno);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","update_renewFacility");
									arrValues.add(null);
									arrValues.add("0");
									arrValues.add(stroldAppno);
									arrValues.add(stroldSno);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","delfacility");
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strfacSno));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									{
										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","del_misappdetails");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										
										MISLogger.UpdateLogger("MISappdetails table delete ==="+hshQuery);
										
										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","del_misappdisplayscreen");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										
										MISLogger.UpdateLogger("misappdisplayscreen table delete ==="+hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","del_misappclassification");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										
										MISLogger.UpdateLogger("misappclassification table delete ==="+hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "setcbsdetailsdel");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_proposedsecuritydetails");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);	
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "delete_repayschedule_corp");
										arrValues.add(strAppno);
										arrValues.add(strfacSno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
													

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_facility_mclrspread");
										arrValues.add(strfacSno);
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_facilitysno_mclrspreadvalue");
										arrValues.add(strfacSno);
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
                                        
										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_com_companydetails_ps");
										arrValues.add(strfacSno);
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_commentsoninterestrate");
										arrValues.add(strAppno);
										arrValues.add("commentsonintrestrate");
										arrValues.add(strfacSno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
										
										/*intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_BankingArrangment");
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
                                        
										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_revBAConsortium_tl");
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

										intUpdatesize++;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId", "del_revBAConsortium");
										arrValues.add(strAppno);
										hshQuery.put("arrValues", arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
										
									}

								}
								
								
								strQuery = SQLParser.getSqlQuery("sel_facility_additionaldetails^"+strAppno +"^"+strSno);
								if(rs1!= null)
								{rs1.close();}
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","del_facility_additionaldetails");
									arrValues.add(strAppno);
									arrValues.add(strSno);
									arrValues.add(strRenew_flag);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","del_facility_additionaldetails");
									arrValues.add(strAppno);
									arrValues.add(strSno);
									arrValues.add("F");
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","update_renewFacility");
									arrValues.add(null);
									arrValues.add("0");
									arrValues.add(Helper.correctNull(rs1.getString("Fac_Addappno")));
									arrValues.add(Helper.correctNull(rs1.getString("Fac_Addappsno")));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								}
								
								strQuery = SQLParser.getSqlQuery("sel_comfacility_details^"+strAppno +"^"+strSno+"^P");
								if(rs1!= null)
								{rs1.close();}
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","del_comfacility_details");
									arrValues.add(strAppno);
									arrValues.add("P");
									arrValues.add(strSno);
									hshQuery.put("arrValues",arrValues);
									hshQuery.put("strAppendString"," and fac_appsno=?");
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									
									intUpdatesize++;
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","update_renewFacility");
									arrValues.add(null);
									arrValues.add("0");
									arrValues.add(Helper.correctNull(rs1.getString("fac_exappno")));
									arrValues.add(Helper.correctNull(rs1.getString("fac_exappsno")));
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								}
								
							}else{
								strQuery = SQLParser.getSqlQuery("delfacilitysno^"+strAppno +"^"+strSno);
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								if(rs != null)
								{
								rs.close();
								}
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									updflag=false;
									strMsg="You can't delete the facility, sub-limit exists";
								}
								else
								{
									hshQuery.put("strQueryId","delfacility");
									arrValues.add(correctNull(strAppno));
									arrValues.add(correctNull(strSno));
								}
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								intUpdatesize++;
								hshQuery = new HashMap();
								arrValues = new ArrayList();
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("strQueryId", "delExt_CropCgtmse");
								hshQuery.put("arrValues", arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								intUpdatesize++;
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","del_facility_additionaldetails");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								arrValues.add("F");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								intUpdatesize++;
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","delete_corp_ncgtc");
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							}

							String strCOM_BANKSCHEME="";
							strQuery = SQLParser.getSqlQuery("selCOM_BANKSCHEME^"+"065^"+strAppno);
							rs = DBUtils.executeQuery(strQuery);

							if(rs.next()){
								strCOM_BANKSCHEME=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
							}
							if(strCOM_BANKSCHEME.equalsIgnoreCase("065")){
								
								strQuery = SQLParser.getSqlQuery("sel_cgssd_asses^"+strAppno);
								rs = DBUtils.executeQuery(strQuery);
								if(rs.next())
								{
									hshQuery = new HashMap();		
									arrValues=new ArrayList();
									hshQuery.put("strQueryId","del_cgssd_asses");
									arrValues.add(strAppno);
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put("size",Integer.toString(intUpdatesize));
									hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);		
								}
							}														
							strQuery = SQLParser.getSqlQuery("selCOM_BANKSCHEME^"+"061^"+strAppno);

							rs = DBUtils.executeQuery(strQuery);
							if(rs.next()){
								strCOM_BANKSCHEME=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
							}

							if(strCOM_BANKSCHEME.equalsIgnoreCase("061")){
							if(rs !=null)					
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_com_assesmentdetails^"+strAppno+"^GECL");
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshQueryValues2=new HashMap();
								hshQuery2 = new HashMap();
								arrValues=new ArrayList();
								hshQuery2.put("strQueryId", "del_com_assesmentdetails");
								arrValues.add(strAppno);
								arrValues.add("GECL");
								hshQuery2.put("arrValues", arrValues);
								hshQueryValues2.put("1", hshQuery2);
								hshQueryValues2.put("size", "1");
					    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues2,"updateData");
							}
							
							if(rs !=null)					
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_com_ksaeassessment^"+strAppno);
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								hshQueryValues2=new HashMap();
								hshQuery2= new HashMap();
								arrValues=new ArrayList();
								hshQuery2.put("strQueryId", "del_com_ksaeassessment");
								arrValues.add(strAppno);
								hshQuery2.put("arrValues", arrValues);
								hshQueryValues2.put("1", hshQuery2);
								hshQueryValues2.put("size", "1");
					    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues2,"updateData");
							}
							
							if(rs !=null)					
							{
								rs.close();
							}
							strQuery = SQLParser.getSqlQuery("sel_com_assesmentdetails^"+strAppno+"^GECL-Restructure");
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								hshQueryValues2=new HashMap();
								hshQuery2 = new HashMap();
								arrValues=new ArrayList();
								hshQuery2.put("strQueryId", "del_com_assesmentdetails");
								arrValues.add(strAppno);
								arrValues.add("GECL-Restructure");
								hshQuery2.put("arrValues", arrValues);
								hshQueryValues2.put("1", hshQuery2);
								hshQueryValues2.put("size", "1");
					    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues2,"updateData");
							}
							
						}
							updateMISCBSDetails(hshValues);
							
						}
						
						String strParentid="";
						if(strAction.equals("insert")||strAction.equals(""))
						{
							//Terms & Condition for Facilities by its Module Type -->Venkata Prasad Chowdary								
								if(rs2 !=null){
									rs2.close();
								}
								rs2=DBUtils.executeLAPSQuery("seltermsmaster^"+strFacCode);
								String strTermsType="P";
								String strTermsDel="N",strTerms="",strTermsno="",strMode="",strPrePost="";
								
								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();								
									if(strModType.equalsIgnoreCase("C")){
											hshQuery.put("strQueryId","insfacterms");								
											arrValues.add(correctNull(strAppno));
											arrValues.add(correctNull(strSno));
											arrValues.add(correctNull(strFacCode));
											arrValues.add(correctNull(strModType));
											arrValues.add(strTermsno);
											arrValues.add(correctNull(strTerms));
											arrValues.add(correctNull(strTermsType));
											arrValues.add(correctNull(strTermsDel));
											arrValues.add(" ");
											arrValues.add("N");	
											arrValues.add(strPrePost);
											arrValues.add(strMode);	
											arrValues.add(strParentid);
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put("size",Integer.toString(intUpdatesize));
											hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}if(strModType.equalsIgnoreCase("A")){
										
										hshQuery.put("strQueryId","insfacterms");								
										arrValues.add(correctNull(strAppno));
										arrValues.add(correctNull(strSno));
										arrValues.add(correctNull(strFacCode));
										arrValues.add(correctNull(strModType));
										arrValues.add(strTermsno);
										arrValues.add(correctNull(strTerms));
										arrValues.add(correctNull(strTermsType));
										arrValues.add(correctNull(strTermsDel));
										arrValues.add(" ");
										arrValues.add("N");	
										arrValues.add(strPrePost);
										arrValues.add(strMode);
										arrValues.add(strParentid);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}									
								}
							
						}
						//Deleting the Facility Terms & Conditions						
						if(strAction.equals("delete"))
						{
								intUpdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","delfacilitytermsandconditions");
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
						}
						//While Edit and apply the facility (When existing facility code and new facility code both are different) then Deleting and Insert the Facility Terms & Conditions
						String	strFacilityCodeTermsCond="",strAgrSchemeTypeExisting="";
						if(strAction.equals("update"))
						{
							strQuery = SQLParser.getSqlQuery("select_facilityCode^"+strAppno +"^"+strSno);
							
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
							strFacilityCodeTermsCond=Helper.correctNull((String)rs.getString("facility_code"));
							strAgrSchemeTypeExisting=Helper.correctNull((String)rs.getString("facility_agrschemetype"));
							}
							if(!strFacilityCodeTermsCond.equalsIgnoreCase(strFacCode)){
								
								intUpdatesize++;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","delfacilitytermsandconditions");
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
							
								if(rs2 !=null){
									rs2.close();
								}
								rs2=DBUtils.executeLAPSQuery("seltermsmaster^"+strFacCode);
								String strTermsType="P";
								String strTermsDel="N",strTerms="",strTermsno="",strMode="",strPrePost="";

								while(rs2.next())
								{
									strTermsno = rs2.getString("fac_sno");
									strTerms = rs2.getString("fac_terms");
									strMode= rs2.getString("fac_mode");
									strPrePost=rs2.getString("fac_prepost");
									strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
									intUpdatesize++;
									hshQuery = new HashMap();
									arrValues=new ArrayList();								
									if(strModType.equalsIgnoreCase("C")){
											hshQuery.put("strQueryId","insfacterms");								
											arrValues.add(correctNull(strAppno));
											arrValues.add(correctNull(strSno));
											arrValues.add(correctNull(strFacCode));
											arrValues.add(correctNull(strModType));
											arrValues.add(strTermsno);
											arrValues.add(correctNull(strTerms));
											arrValues.add(correctNull(strTermsType));
											arrValues.add(correctNull(strTermsDel));
											arrValues.add(" ");
											arrValues.add("N");	
											arrValues.add(strPrePost);
											arrValues.add(strMode);		
											arrValues.add(strParentid);
											hshQuery.put("arrValues",arrValues);
											hshQueryValues.put("size",Integer.toString(intUpdatesize));
											hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}if(strModType.equalsIgnoreCase("A")){
										
										hshQuery.put("strQueryId","insfacterms");								
										arrValues.add(correctNull(strAppno));
										arrValues.add(correctNull(strSno));
										arrValues.add(correctNull(strFacCode));
										arrValues.add(correctNull(strModType));
										arrValues.add(strTermsno);
										arrValues.add(correctNull(strTerms));
										arrValues.add(correctNull(strTermsType));
										arrValues.add(correctNull(strTermsDel));
										arrValues.add(" ");
										arrValues.add("N");	
										arrValues.add(strPrePost);
										arrValues.add(strMode);
										arrValues.add(strParentid);
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}									
								}
							}
							//Deleting Agriculture details when Scheme type is changed by Venkata Prasad Chowdary
							if(!strAgrSchemeTypeExisting.equalsIgnoreCase(strAgrSchemeType)){
								hshValues.put("strAgrSchemeTypeExisting", strAgrSchemeTypeExisting);
								deleteAgricultureTabDetails(hshValues);
							}
					}	
						
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
					
				hshQuery.put("strQueryId","delprosalvaluesin");
				arrValues.add(correctNull(strAppno));
				hshQuery.put("arrValues",arrValues);
				
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQuery.put("strQueryId","insprosalvaluesin");
				arrValues.add(correctNull(strAppno));
				arrValues.add(strProposalin);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				if(updflag==true)
				{
					if(!strAction.equals("delete"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","upd_facasondate");
						arrValues.add(correctNull(strOSDate));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					
					//To insert into app_restructure table for Account selection
					
					HashMap hshQuery1=new HashMap();
					HashMap hshQueryValues1 = new HashMap();
					ArrayList arrValues1=new ArrayList();
					hshQuery1.put("strQueryId","update_restracc_replace");
					arrValues1.add("@"+strSno);
					arrValues1.add(strAppno);
					hshQuery1.put("arrValues",arrValues1);
					hshQueryValues1.put("size","1");
					hshQueryValues1.put("1",hshQuery1);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");					
					
					String strAccSno = "";
					String strRestrAcc[] = strFacRestrFrom.split("@");
					if(!strAction.equalsIgnoreCase(""))
					{
						for(int i=0;i<strRestrAcc.length;i++)
						{	
							strQuery = SQLParser.getSqlQuery("sel_restrAccSno^"+strAppno+"^"+strRestrAcc[i]);
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strAccSno = Helper.correctNull((String)rs.getString("APP_SNO"));
							}
							
							if(strAccSno.contains(strSno))
							{
								//Do nothing
							}
							else
							{
								hshQuery1=new HashMap();
								hshQueryValues1 = new HashMap();
								arrValues1=new ArrayList();
								hshQuery1.put("strQueryId","update_restracc");
								arrValues1.add(strAccSno+"@"+strSno);
								arrValues1.add(strAppno);
								arrValues1.add(strRestrAcc[i]);
								hshQuery1.put("arrValues",arrValues1);
								hshQueryValues1.put("size","1");
								hshQueryValues1.put("1",hshQuery1);
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
							}
						}
					}
					
					
					hshQuery=new HashMap();
					hshQuery.put("appno",strAppno);
					hshQuery.put("strSno",strSno);	
					hshQuery.put("strBorrowId",strBorrowId);				
					hshQuery.put("strSessionMod",Helper.correctNull((String)hshValues.get("sessionModuleType")));
					
					if(!Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
					&&	!Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC"))
					{
						UpdateBankingdata(hshQuery);
						//UpdateBankingDetails.calBankSharePercent(hshQuery);
					}
				}
				
				if((Helper.correctNull((String)hshValues.get("hidparam1"))).equalsIgnoreCase("MISDEL"))
				{
					
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("select_facilityCode^"+strAppno+"^"+strSno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strRenew_flag=Helper.correctNull(rs1.getString("FACILITY_TYPEFOR"));
					}
					if(strRenew_flag.equalsIgnoreCase("P"))
					{
						if(rs1!=null)
							rs1.close();
						strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^"+strSno);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							if(Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strProposed);
								arrValues.add(strAppno);
								arrValues.add(strSno);
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
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("arrValues",arrValues); 
						hshQuery.put("strQueryId","update_mis_appdetailssno"); 
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");
						
						if(rs1!=null)
							rs1.close();
						strQuery=SQLParser.getSqlQuery("sel_corpcbsdetails^"+strAppno+"^"+strSno);
						rs1=DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{
							if(Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("D")||Helper.correctNull(rs1.getString("DRAWING_PWR_IND")).equalsIgnoreCase("E"))
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strProposed);
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","updcbsdetails"); 
								hshQueryValues.put("2",hshQuery);
								hshQueryValues.put("size","2");
							}
							else
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								arrValues.add(strAppno);
								arrValues.add(strSno);
								hshQuery.put("arrValues",arrValues); 
								hshQuery.put("strQueryId","setcbsdetailsdel"); 
								hshQueryValues.put("2",hshQuery);
								hshQueryValues.put("size","2");
							}
						}
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
			
					
				}
				
				/**
				 * Added by venu for getting financial information
				 
				  setLoanDetails(hshValues);
				*
				 * end
				 */
            }
				
				hshRecord = getFacilityData(hshValues);
				hshRecord.put("msg",strMsg);
				hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));
				hshRecord.put("strLflag",strLflag);				
				
				String strAppval = correctNull((String)hshValues.get("appval"));
				String strAppFlag = correctNull((String)hshValues.get("appflag"));
				//String strAppMangflag = correctNull((String)hshValues.get("appMangflag"));
				String strAppGroupflag = correctNull((String)hshValues.get("appGroupflag"));
//				-----This Below Coding is Fetch Check Whether to Fetch Details from Financial , Group Company
				//----- or Organisation from Previous Application
				
				if(strAppno.trim().equalsIgnoreCase("new"))
				{
					throw new Exception("$ Cannot Create Proposal. Application Number Not found.");
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				if((!strAppval.equalsIgnoreCase("")) && (!strAppFlag.equalsIgnoreCase("on")))
				{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");	
						hshQuery.put("strQueryId","updfacexeappno");
						arrValues.add(correctNull(strAppval));
						arrValues.add(correctNull(strAppFlag));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

						hshRecord.put("appval",strAppval);
				}
				// deleting cgtmse data if CGTMSE is NO by raja
				if(strCgtmseApp.equalsIgnoreCase("N")&& strAction.equals("update")){
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId", "delExt_CropCgtmse");
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
				}
											
				if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
				{					
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");	
						hshQuery.put("strQueryId","updfgroupexecappno");
						arrValues.add(correctNull(strAppval));
						arrValues.add(correctNull(strAppGroupflag));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				ResultSet rsfreeze = null;
				String strFreeze = "";			
				if(!strAppno.equalsIgnoreCase(""))
				{
					if(rsfreeze !=null)
					{
						rsfreeze.close();
					}
					
					strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
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
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","upd_PERAPPLICANT_freeze");//added by ganesan
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
		  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		  		
				//MIS & CBS page details cleared while changing the facility
				strFacilityOldId=correctNull((String) hshValues.get("hidfacilityCode1"));
				String strSubFacilityCode=correctNull((String) hshValues.get("hidsubfacilityCode1"));
				if(!strSubFacilityCode.equalsIgnoreCase(""))
					strFacilityOldId=strSubFacilityCode;
				
				if(strAction.equals("update") && !strFacilityOldId.equalsIgnoreCase("") && !strFacilityOldId.equalsIgnoreCase(strFacCode))
				{
					updateMISCBSDetails(hshValues);
				}
				
				if((strAction.equals("insert"))|| (strAction.equals("")) ||(strAction.equals("update") && !strFacilityOldId.equalsIgnoreCase("") && !strFacilityOldId.equalsIgnoreCase(strFacCode))||
						(strAction.equals("update") && strtAdhocChk.equalsIgnoreCase("R")&& (strFacCategory.equalsIgnoreCase("A") ||strFacCategory.equalsIgnoreCase("D")) ))
				{
					if((strFacCategory.equalsIgnoreCase("A") || strFacCategory.equalsIgnoreCase("D")) && strGroup.equalsIgnoreCase("0"))
					{
						
						String[] strAdhocArr=strAdhocFac.split("~");
						if(strAdhocArr.length>1)
						{
							
							hshQueryValues=new HashMap();
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId", "del_copypropsecdetails_adhoc");
							arrValues.add(strAppno);
							arrValues.add(strSno);
							arrValues.add(strAdhocArr[0]);	
							arrValues.add(strAdhocArr[1]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							
				    		hshQuery = new HashMap();
				    		arrValues=new ArrayList();
				    		arrValues.add(strAppno);
				    		arrValues.add(strSno);
				    		arrValues.add(strProposed);
				    		arrValues.add(strProposed);
				    		arrValues.add(strFacCode);
				    		arrValues.add(strAdhocArr[1]);
				    		arrValues.add(strAdhocArr[0]);
				    		hshQuery.put("strQueryId", "app_securitydetails_copy");
				    		hshQuery.put("arrValues", arrValues);
				    		hshQueryValues.put("2", hshQuery);
				    		hshQueryValues.put("size", "2");
				    		
				    		
				    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							
						}
					}
				}
				//Co-Applicant Copy for Adhoc and additional Facilities
				if((strAction.equals("insert") || strAction.equals("update")) && 
						(strFacCategory.equalsIgnoreCase("A") ||strFacCategory.equalsIgnoreCase("D")))
				{
					String[] strAdhocArr=strAdhocFac.split("~");
					if(strAdhocArr.length>1)
					{
							hshQueryValues=new HashMap(); 
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "del_companydetail_other");
							arrValues.add(strAppno);
							arrValues.add(strSno);
							arrValues.add(strAdhocArr[0]);
							arrValues.add(strAdhocArr[1]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);	
						
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId","updcom_companydetails_ps");
							arrValues.add(strAdhocArr[0]);
							arrValues.add(strSno);	
							arrValues.add(strAdhocArr[1]);
							arrValues.add(strAdhocArr[0]);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("2",hshQuery);	
							hshQueryValues.put("size","2");
							
				    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				
				if(strAction.equals("update")&& (strtAdhocChk.equalsIgnoreCase("A")||
						strtAdhocChk.equalsIgnoreCase("D")) &&(strFacCategory.equalsIgnoreCase("R")||strFacCategory.equalsIgnoreCase("O")))
				{
					if(!strAdhocAddFacility.equalsIgnoreCase(""))
					{
						String[] strAdhocArr=strAdhocAddFacility.split("~");
						if(strAdhocArr.length>1)
						{
							hshQueryValues=new HashMap(); 
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "del_companydetail_other");
							arrValues.add(strAppno);
							arrValues.add(strSno);
							arrValues.add(strAdhocArr[0]);
							arrValues.add(strAdhocArr[1]);
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1",hshQuery);		
							hshQueryValues.put("size","1");
							
				    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
					
				}
				if(strAction.equals("update") && strtAdhocChk.equalsIgnoreCase("A")&& strFacCategory.equalsIgnoreCase("R"))
				{
					hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_proposedsecuritydetails");
					arrValues.add(strAppno);
					arrValues.add(strSno);	
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				if(strAction.equals("insert") && strFacType.equalsIgnoreCase("sublimit") && (strFacCategory.equalsIgnoreCase("O")|| strFacCategory.equalsIgnoreCase("R")))
				{
					hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "updcom_companydetails_ps");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					arrValues.add(strGroup);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");
		    		
		    		hshQuery = new HashMap();
		    		arrValues=new ArrayList();
		    		arrValues.add(strAppno);
		    		arrValues.add(strSno);
		    		arrValues.add(strProposed);
		    		arrValues.add(strProposed);
		    		arrValues.add(strFacCode);
		    		arrValues.add(strGroup);
		    		arrValues.add(strAppno);
		    		hshQuery.put("strQueryId", "app_securitydetails_copy1");
		    		hshQuery.put("arrValues", arrValues);
		    		hshQueryValues.put("2", hshQuery);
		    		hshQueryValues.put("size", "2");
		    		
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
				if(strAction.equals("update") && !strFacilityOldId.equalsIgnoreCase("") && !strFacilityOldId.equalsIgnoreCase(strFacCode)){
					if(rs !=null)					
					{
						rs.close();
					}

					String strCOM_BANKSCHEME="";
					strQuery = SQLParser.getSqlQuery("selCOM_BANKSCHEME^"+"063^"+strAppno);

					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						strCOM_BANKSCHEME=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					}

					if(strCOM_BANKSCHEME.equalsIgnoreCase("063")){
					if(rs !=null)					
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_com_assesmentdetails^"+strAppno+"^MMithra");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
					hshQueryValues=new HashMap();
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add("MMithra");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");		    		
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
					strQuery = SQLParser.getSqlQuery("selCOM_BANKSCHEME^"+"065^"+strAppno);

					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						strCOM_BANKSCHEME=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					}
					if(strCOM_BANKSCHEME.equalsIgnoreCase("065")){
						
						strQuery = SQLParser.getSqlQuery("sel_cgssd_asses^"+strAppno);
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							hshQueryValues = new HashMap();
							hshQuery = new HashMap();		
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","del_cgssd_asses");
							arrValues.add(strAppno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");	    		
			    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
					}
					
					if(rs !=null)					
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("selCOM_BANKSCHEME^"+"061^"+strAppno);

					rs = DBUtils.executeQuery(strQuery);
					if(rs.next()){
						strCOM_BANKSCHEME=Helper.correctNull((String)rs.getString("COM_BANKSCHEME"));
					}

					if(strCOM_BANKSCHEME.equalsIgnoreCase("061")){
					if(rs !=null)					
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_com_assesmentdetails^"+strAppno+"^GECL");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
					hshQueryValues=new HashMap();
						hshQuery = new HashMap();		
						arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_assesmentdetails");
						arrValues.add(strAppno);
					arrValues.add("GECL");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");		    		
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
					if(rs !=null)					
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_com_ksaeassessment^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
					hshQueryValues=new HashMap();
						hshQuery = new HashMap();		
						arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_ksaeassessment");
						arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");		    		
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					
					if(rs !=null)					
					{
						rs.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_com_assesmentdetails^"+strAppno+"^GECL-Restructure");
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						hshQueryValues=new HashMap();
						hshQuery = new HashMap();		
						arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_assesmentdetails");
						arrValues.add(strAppno);
					arrValues.add("GECL-Restructure");
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
		    		hshQueryValues.put("size", "1");		    		
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
					}
			}
				//============================  delete bannking arrangement details =============================//
				if(rs1!=null){
					rs1.close();
				}if(rs!=null){
					rs.close();
				}
				String strbankingarrangement="N";
				strQuery=SQLParser.getSqlQuery("sel_facilitycheckforbank^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next()){
					strbankingarrangement="Y";
				}
				if(strbankingarrangement.equalsIgnoreCase("N")){
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_BankingArrangment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
                    
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_revBAConsortium_tl");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_revBAConsortium");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);

					intUpdatesize++;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_BAConsortiumLeadpropdelete_tl");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
		    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

				}
				//Delete SvanidhiAssess 2.0 and 3.0
				
				

			if (rs != null) {
				rs.close();
			}
			String StrSvanidhi3 = "N";
			rs = DBUtils.executeQuery(SQLParser
					.getSqlQuery("sel_SvanidhiStatus^" + strAppno + "^3"));
			if (rs.next()) {
				hshValues.put("StrSvanidhi3", "Y");
			}

			
			if (StrSvanidhi3.equalsIgnoreCase("N")) {
				if (rs != null) {
					rs.close();
				}
				rs = DBUtils.executeLAPSQuery("com_assessmentselection_select^"
						+ strAppno);
				boolean PMSFlag = false;
				if (rs.next()) {

					String strassesttype = correctNull((String) rs
							.getString("COM_ASSESSMENTTYPE"));
					StringTokenizer strassesttypesplit = new StringTokenizer(
							strassesttype, "@");
					while (strassesttypesplit.hasMoreTokens()) {
						String strfinalassesttype = (String) strassesttypesplit
								.nextToken();

						if (strfinalassesttype.equalsIgnoreCase("PMS3")) {
							PMSFlag = true;

						}
					}
				}
				if (PMSFlag) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery
							.put("strQueryId", "com_assessmentselection_delete");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					hshQueryValues.put("size", "1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
							"updateData");
				}

				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_SvanidhiAssess_details");
				arrValues.add(strAppno);
				arrValues.add("3");
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,
						"updateData");
			}
			
					
				
				
				if(rs1!=null){
					rs1.close();
				}if(rs!=null){
					rs.close();
				}
				
				String corprestructureval="N";
				strQuery = SQLParser.getSqlQuery("sel_rest_assess_selection^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next()){
					corprestructureval="Y";
					
				}
				if(corprestructureval.equalsIgnoreCase("N")){
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQueryValues=new HashMap();
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQuery.put("strQueryId","del_rest_Assesment");//added by ganesan
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
			  		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

					}
				if(rs!=null){
					rs.close();
				}
				if(rs1!=null){
					rs1.close();
				}
                 strQuery=SQLParser.getSqlQuery("sel_facility_audit^"+strAppno+"^"+strSno);
				
				
				rs1=DBUtils.executeQuery(strQuery);
				StringBuilder sbOldAudit = new StringBuilder();
				if(rs1.next()){

						String strCategory=correctNull((String)rs1.getString("FACILITY_CATEGORY"));
						String strExistBankFac=correctNull((String)rs1.getString("FACILITY_EXISTBANKTYPE"));
						String strPropBankFac=correctNull((String)rs1.getString("FACILITY_PROPBANKTYPE"));
						String strfactype=correctNull((String)rs1.getString("FACILITY_TYPEFOR"));
						String strnatureoflimit=correctNull((String)rs1.getString("facility_category"));
						String strinsurancecover=correctNull((String)rs1.getString("FAC_INS_COMPANY_NAME"));
						String strintrsttype=correctNull((String)rs1.getString("FACILITY_INTTYPE"));
						String strroitype=correctNull((String)rs1.getString("FAC_ROITYPE"));
						if(strroitype.equalsIgnoreCase("CIBIL"))strroitype="CIBIL";
						if(strroitype.equalsIgnoreCase("CRIF"))strroitype="CRIF";
						
						if(strintrsttype.equalsIgnoreCase("Fix"))strintrsttype="Fixed";
						if(strintrsttype.equalsIgnoreCase("Flo"))strintrsttype="Floating";
						
						if(strinsurancecover.equalsIgnoreCase("B"))strinsurancecover="BLSS";
						if(strinsurancecover.equalsIgnoreCase("METLIFE"))strinsurancecover="MLSS";
						if(strinsurancecover.equalsIgnoreCase("NC"))strinsurancecover="Not Covered";
						
						if(strExistBankFac.equals("S"))strExistBankFac="Sole";
						if(strExistBankFac.equals("C"))strExistBankFac="Consortium";
						if(strExistBankFac.equals("M"))strExistBankFac="Multiple Banking";
						
						if(strPropBankFac.equals("S"))strPropBankFac="Sole";
						if(strPropBankFac.equals("C"))strPropBankFac="Consortium";
						if(strPropBankFac.equals("M"))strPropBankFac="Multiple Banking";
						
						String strSubExistBankFac=correctNull((String)rs1.getString("FACILITY_EXISTBANKTYPE"));
						String strSubPropBankFac=correctNull((String)rs1.getString("FACILITY_PROPBANKTYPE"));
						if(strSubExistBankFac.equals("S"))strSubExistBankFac="Sole";
						if(strSubExistBankFac.equals("C"))strSubExistBankFac="Consortium";
						if(strSubExistBankFac.equals("M"))strSubExistBankFac="Multiple Banking";
						
						if(strSubPropBankFac.equals("S"))strSubPropBankFac="Sole";
						if(strSubPropBankFac.equals("C"))strSubPropBankFac="Consortium";
						if(strSubPropBankFac.equals("M"))strSubPropBankFac="Multiple Banking";
						
						if(strCategory.equals("R"))strCategory="Main Limit";
						if(strCategory.equals("I"))strCategory="Inner Limit";
						if(strCategory.equals("O"))strCategory="Outer Limit";
						if(strCategory.equals("C"))strCategory="Inter Changeable Limit";
						if(strCategory.equals("P"))strCategory="Apportion Limit";
						if(strCategory.equals("A"))strCategory="Adhoc";
						
						if(strfactype.equalsIgnoreCase("1"))strfactype="Fresh";
						if(strfactype.equalsIgnoreCase("2"))strfactype="Renewal";
						if(strfactype.equalsIgnoreCase("3"))strfactype="Restructuring";
						if(strfactype.equalsIgnoreCase("4"))strfactype="post Sanction";
						
						if(strnatureoflimit.equalsIgnoreCase("A"))strnatureoflimit="Adhoc";
						if(strnatureoflimit.equalsIgnoreCase("R"))strnatureoflimit="Regular Limit";
						if(strnatureoflimit.equalsIgnoreCase("D"))strnatureoflimit="Additional Limit";
						if(strnatureoflimit.equalsIgnoreCase("O"))strnatureoflimit="One Time Limit";
						sbOldAudit.append("Limit =").append(correctNull((String)rs1.getString("facility_type")));
						
						//sbOldAudit.append("~ No of Months =").append(correctNull((String)rs1.getString("txt_adhocmonths")));
						//sbOldAudit.append(" ~ Facility Head =").append(correctNull((String)rs1.getString("facility_catdesc")));
						sbOldAudit.append(" ~Facility  =").append(correctNull((String)rs1.getString("facility_catdesc")));
						sbOldAudit.append(" ~Existing Limit  =").append(correctNull((String)rs1.getString("FACILITY_EXISTING")));
						sbOldAudit.append(" ~Proposed Limit  =").append(correctNull((String)rs1.getString("FACILITY_PROPOSED")));
						sbOldAudit.append(" ~Existing Banking Arrangement  =").append(strExistBankFac);
						sbOldAudit.append(" ~Proposed Banking Arrangement  =").append(strPropBankFac);
						sbOldAudit.append(" ~Interest/ Discount/ Commission (%)  =").append(correctNull((String)rs1.getString("FACILITY_INTEREST")));
						sbOldAudit.append(" ~D.P =").append(correctNull((String)rs1.getString("FACILITY_DP")));
						sbOldAudit.append(" ~Outstanding =").append(correctNull((String)rs1.getString("FACILITY_OUTSTANDING")));
						sbOldAudit.append(" ~Value of Securities =").append(correctNull((String)rs1.getString("SECURITY_VALUE")));
						//sbOldAudit.append(" ~Margin (%) =").append(correctNull((String)rs1.getString("FACILITY_MARGIN")));
						sbOldAudit.append(" ~Purpose =").append(correctNull((String)rs1.getString("FACILITY_PURPOSE")));
						sbOldAudit.append(" ~CBS Account Number =").append(correctNull((String)rs1.getString("CBS_ACCOUNTNO")));
						sbOldAudit.append(" ~Tenor (in Months) =").append(correctNull((String)rs1.getString("FACILITY_TENOR")));
						sbOldAudit.append(" ~Details as on =").append(correctNull((String)rs1.getString("FACILITY_OSASON")));
						//sbOldAudit.append(" ~Scheme Code=").append(correctNull((String)rs1.getString("txt_schemecode")));
						sbOldAudit.append(" ~Facility Type=").append(strfactype);
						sbOldAudit.append(" ~Nature of limit=").append(strnatureoflimit);
						sbOldAudit.append(" ~Insurance Covered Under =").append(strinsurancecover);
						sbOldAudit.append(" ~Insurance Amount=").append(correctNull((String)rs1.getString("FAC_METLIFEPREMIUMAMT")));
						sbOldAudit.append(" ~Interest Type=").append(strintrsttype);
						sbOldAudit.append(" ~Interest Sub Type=").append(correctNull((String)rs1.getString("FACILITY_INTSUBTYPE")));
						sbOldAudit.append(" ~ROI TYPE=").append(strroitype);
						
						sbOldAudit.append(" ~Initial Holiday/Gestation/Moratorium Period (in Months)=").append(correctNull((String)rs1.getString("FACILITY_HOLIDAYPERIOD")));
						String strmodeofpayment="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^217^"+ correctNull((String)rs1.getString("FACILITY_MODEOFREPAY")));
						if (rs4.next()) {
							strmodeofpayment=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}
						sbOldAudit.append(" ~Mode of Payment=").append(strmodeofpayment);
						sbOldAudit.append(" ~Operative Account Number=").append(correctNull((String)rs1.getString("FACILITY_OPERATIONACCNO")));
						String strinstallment=correctNull((String)rs1.getString("FACILITY_PERINSTALL"));
						if(strinstallment.equalsIgnoreCase("m"))strinstallment="Monthly";
						if(strinstallment.equalsIgnoreCase("q"))strinstallment="Quarterly";
						if(strinstallment.equalsIgnoreCase("h"))strinstallment="Half-Yearly";
						if(strinstallment.equalsIgnoreCase("y"))strinstallment="Yearly";
						if(strinstallment.equalsIgnoreCase("n"))strinstallment="Not Applicable";
						String strduringholiday=correctNull((String)rs1.getString("FACILITY_INTERESTREC"));
						if(strduringholiday.equalsIgnoreCase("n"))strduringholiday="No";
						if(strduringholiday.equalsIgnoreCase("y"))strduringholiday="Yes";
						String strintrstcharged=correctNull((String)rs1.getString("FACILITY_INTERESTCHARGED"));
						if(strintrstcharged.equalsIgnoreCase("1"))strintrstcharged="To be paid as and when debited";
						if(strintrstcharged.equalsIgnoreCase("2"))strintrstcharged="To be accumulated and added to the principal to calculate EMI";
						String strmargin=correctNull((String)rs1.getString("FAC_MARGINRELAX"));
						if(strmargin.equalsIgnoreCase("N"))strmargin="No";
						if(strmargin.equalsIgnoreCase("Y"))strmargin="Yes";
						sbOldAudit.append(" ~Periodicity of Installments=").append(strinstallment);
						sbOldAudit.append(" ~Interest to be collected during Holiday=").append(strduringholiday);
						sbOldAudit.append(" ~Interest charged=").append(strintrstcharged);
						sbOldAudit.append(" ~Margin=").append(correctNull((String)rs1.getString("facility_margin")));
						sbOldAudit.append(" ~Purpose=").append(correctNull((String)rs1.getString("FACILITY_PURPOSE")));
						sbOldAudit.append(" ~Relaxation in margin as per RBI COVID relief Package Policy=").append(strmargin);
						String strpredefinedmargin="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ correctNull((String)rs1.getString("FAC_ACTUALMARGIN")));
						if (rs4.next()) {
							strpredefinedmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}sbOldAudit.append(" ~Predefined Margin(%)=").append(strpredefinedmargin);
						String strrelaxeddmargin="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ correctNull((String)rs1.getString("FAC_MARGINRELAX")));
						if (rs4.next()) {
							strrelaxeddmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}sbOldAudit.append(" ~Relaxed Margin(%)=").append(strrelaxeddmargin);
						sbOldAudit.append(" ~Due Date=").append(correctNull((String)rs1.getString("FACILITY_DUEDATE")));
						sbOldAudit.append(" ~irregularites or overdues if any=").append(correctNull((String)rs1.getString("FACILITY_DUEDATE")));
						sbOldAudit.append(" ~Reviewed Due Date =").append(correctNull((String)rs1.getString("FACILITY_REVIEWDATE")));
						String strtufscheme=correctNull((String)rs1.getString("FACILITY_TUF"));
						if(strtufscheme.equalsIgnoreCase("N"))strtufscheme="No";
						if(strtufscheme.equalsIgnoreCase("Y"))strtufscheme="Yes";
						sbOldAudit.append(" ~Whether under TUF scheme=").append(strtufscheme);
						sbOldAudit.append(" ~Existing Facility CBS Account No=").append(correctNull((String)rs1.getString("CBS_ACCOUNTNO")));
						sbOldAudit.append(" ~Additional / Fresh Limit sought by Borrower =").append(correctNull((String)rs1.getString("facility_freshlimit")));
						
						String strgovscheme=correctNull((String)rs1.getString("FACILITY_GOVTSPONSCHEM"));
						if(strgovscheme.equalsIgnoreCase("2"))strgovscheme="No";
						if(strgovscheme.equalsIgnoreCase("1"))strgovscheme="Yes";
						sbOldAudit.append(" ~Govt. Sponsor Scheme=").append(strgovscheme);
						sbOldAudit.append(" ~Process note Description =").append(correctNull((String)rs1.getString("FACILITY_DESC")));
						String strschemetype="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^11^"+ correctNull((String)rs1.getString("FACILITY_SCHEMETYPE")));
						if (rs4.next()) {
							strschemetype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}sbOldAudit.append(" ~Scheme Type=").append(strschemetype);
						sbOldAudit.append(" ~Subsidy Amount=").append(correctNull((String)rs1.getString("FACILITY_SUBSIDYAMUNT")));
						String strsponseragency="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^3^"+ correctNull((String)rs1.getString("FACILITY_SPONSAGENCY")));
						if (rs4.next()) {
							strsponseragency=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}sbOldAudit.append(" ~Sponser Agency=").append(strsponseragency);
						
						String strsubsidytype="";
						if(rs4!=null){
							rs4.close();
						}
						rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^5^"+ correctNull((String)rs1.getString("FACILITY_SUBSIDYTYPE")));
						if (rs4.next()) {
							strsubsidytype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
						}sbOldAudit.append(" ~Subsidy Type=").append(strsubsidytype);
						sbOldAudit.append(" ~Name of Agency=").append(correctNull((String)rs1.getString("FACILITY_AGENCY")));
						}
				//Audit Trial Block starts...1.2.3..
				StringBuilder sbAt = new StringBuilder();
				if(updflag==true)
				{
					
					String strCategory=correctNull((String)hshValues.get("faccategory"));
					String strExistBankFac=correctNull((String)hshValues.get("sel_existbanktype"));
					String strPropBankFac=correctNull((String)hshValues.get("sel_propbanktype"));
					String strfactype=correctNull((String)hshValues.get("sel_fac_desc"));
					String strnatureoflimit=correctNull((String)hshValues.get("seladhoclimit"));
					String strinsurancecover=correctNull((String)hshValues.get("sel_Processed_Type"));
					String strintrsttype=correctNull((String)hshValues.get("sel_inttype"));
					String strroitype=correctNull((String)hshValues.get("sel_interesttype"));
					if(strroitype.equalsIgnoreCase("CIBIL"))strroitype="CIBIL";
					if(strroitype.equalsIgnoreCase("CRIF"))strroitype="CRIF"; 
					
					if(strintrsttype.equalsIgnoreCase("Fix"))strintrsttype="Fixed";
					if(strintrsttype.equalsIgnoreCase("Flo"))strintrsttype="Floating";
					
					if(strinsurancecover.equalsIgnoreCase("B"))strinsurancecover="BLSS";
					if(strinsurancecover.equalsIgnoreCase("METLIFE"))strinsurancecover="MLSS";
					if(strinsurancecover.equalsIgnoreCase("NC"))strinsurancecover="Not Covered";
					
					if(strExistBankFac.equals("S"))strExistBankFac="Sole";
					if(strExistBankFac.equals("C"))strExistBankFac="Consortium";
					if(strExistBankFac.equals("M"))strExistBankFac="Multiple Banking";
					
					if(strPropBankFac.equals("S"))strPropBankFac="Sole";
					if(strPropBankFac.equals("C"))strPropBankFac="Consortium";
					if(strPropBankFac.equals("M"))strPropBankFac="Multiple Banking";
					
					String strSubExistBankFac=correctNull((String)hshValues.get("sel_sub_existbanktype"));
					String strSubPropBankFac=correctNull((String)hshValues.get("sel_sub_propbanktype"));
					if(strSubExistBankFac.equals("S"))strSubExistBankFac="Sole";
					if(strSubExistBankFac.equals("C"))strSubExistBankFac="Consortium";
					if(strSubExistBankFac.equals("M"))strSubExistBankFac="Multiple Banking";
					
					if(strSubPropBankFac.equals("S"))strSubPropBankFac="Sole";
					if(strSubPropBankFac.equals("C"))strSubPropBankFac="Consortium";
					if(strSubPropBankFac.equals("M"))strSubPropBankFac="Multiple Banking";
					
					if(strCategory.equals("R"))strCategory="Main Limit";
					if(strCategory.equals("I"))strCategory="Inner Limit";
					if(strCategory.equals("O"))strCategory="Outer Limit";
					if(strCategory.equals("C"))strCategory="Inter Changeable Limit";
					if(strCategory.equals("P"))strCategory="Apportion Limit";
					if(strCategory.equals("A"))strCategory="Adhoc";
					
					if(strfactype.equalsIgnoreCase("1"))strfactype="Fresh";
					if(strfactype.equalsIgnoreCase("2"))strfactype="Renewal";
					if(strfactype.equalsIgnoreCase("3"))strfactype="Restructuring";
					if(strfactype.equalsIgnoreCase("4"))strfactype="post Sanction";
					
					if(strnatureoflimit.equalsIgnoreCase("A"))strnatureoflimit="Adhoc";
					if(strnatureoflimit.equalsIgnoreCase("R"))strnatureoflimit="Regular Limit";
					if(strnatureoflimit.equalsIgnoreCase("D"))strnatureoflimit="Additional Limit";
					if(strnatureoflimit.equalsIgnoreCase("O"))strnatureoflimit="One Time Limit";
					sbAt.append("Limit =").append(strCategory);
					if(strCategory.equals("Adhoc"))
					//sbAt.append("~ No of Months =").append(correctNull((String)hshValues.get("txt_adhocmonths")));
					sbAt.append(" ~ Facility Head =").append(correctNull((String)hshValues.get("hid_facility_head")));
					sbAt.append(" ~Facility  =").append(correctNull((String)hshValues.get("hid_facility")));
					sbAt.append(" ~Existing Limit  =").append(correctNull((String)hshValues.get("txt_exist_limit")));
					sbAt.append(" ~Proposed Limit  =").append(correctNull((String)hshValues.get("txt_proposed_limit")));
					sbAt.append(" ~Existing Banking Arrangement  =").append(strExistBankFac);
					sbAt.append(" ~Proposed Banking Arrangement  =").append(strPropBankFac);
					sbAt.append(" ~Interest/ Discount/ Commission (%)  =").append(correctNull((String)hshValues.get("prd_intrate"))).append("-").append(correctNull((String)hshValues.get("txt_margin"))).append("-").append(correctNull((String)hshValues.get("txt_interest")));
					if(correctNull((String)hshValues.get("cattype")).equalsIgnoreCase("STL") || correctNull((String)hshValues.get("cattype")).equalsIgnoreCase("ADC"))
					{
						sbAt.append(" ~Overdues, if any  =").append(correctNull((String)hshValues.get("txt_desc")));
					}
					sbAt.append(" ~D.P =").append(correctNull((String)hshValues.get("txt_dp")));
					sbAt.append(" ~Outstanding =").append(correctNull((String)hshValues.get("txt_outstanding")));
					sbAt.append(" ~Value of Securities =").append(correctNull((String)hshValues.get("txt_security")));
					//sbAt.append(" ~Margin (%) =").append(correctNull((String)hshValues.get("txt_margin1")));
					sbAt.append(" ~Purpose =").append(correctNull((String)hshValues.get("txt_purpose")));
					sbAt.append(" ~CBS Account Number =").append(correctNull((String)hshValues.get("txt_cbsaccno")));
					sbAt.append(" ~Tenor (in Months) =").append(correctNull((String)hshValues.get("txt_facmonths")));
					sbAt.append(" ~Details as on =").append(correctNull((String)hshValues.get("txt_osdate")));
					sbAt.append(" ~Scheme Code=").append(correctNull((String)hshValues.get("txt_schemecode")));
					sbAt.append(" ~Facility Type=").append(strfactype);
					sbAt.append(" ~Nature of limit=").append(strnatureoflimit);
					sbAt.append(" ~Insurance Covered Under =").append(strinsurancecover);
					sbAt.append(" ~Insurance Amount=").append(correctNull((String)hshValues.get("txt_metlifeinsurance")));
					sbAt.append(" ~Interest Type=").append(strintrsttype);
					sbAt.append(" ~Interest Sub Type=").append(correctNull((String)hshValues.get("sel_intsutype")));
					sbAt.append(" ~ROI TYPE=").append(strroitype);
					
					sbAt.append(" ~Initial Holiday/Gestation/Moratorium Period (in Months)=").append(correctNull((String)hshValues.get("txt_installments")));
					String strmodeofpayment="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^217^"+ correctNull((String)hshValues.get("selmodepayment")));
					if (rs4.next()) {
						strmodeofpayment=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}
					sbAt.append(" ~Mode of Payment=").append(strmodeofpayment);
					sbAt.append(" ~Operative Account Number=").append(correctNull((String)hshValues.get("txt_operativeaccno")));
					String strinstallment=correctNull((String)hshValues.get("sel_peridicityfac"));
					if(strinstallment.equalsIgnoreCase("m"))strinstallment="Monthly";
					if(strinstallment.equalsIgnoreCase("q"))strinstallment="Quarterly";
					if(strinstallment.equalsIgnoreCase("h"))strinstallment="Half-Yearly";
					if(strinstallment.equalsIgnoreCase("y"))strinstallment="Yearly";
					if(strinstallment.equalsIgnoreCase("n"))strinstallment="Not Applicable";
					String strduringholiday=correctNull((String)hshValues.get("interestservised"));
					if(strduringholiday.equalsIgnoreCase("n"))strduringholiday="No";
					if(strduringholiday.equalsIgnoreCase("y"))strduringholiday="Yes";
					String strintrstcharged=correctNull((String)hshValues.get("interestservised"));
					if(strintrstcharged.equalsIgnoreCase("1"))strintrstcharged="To be paid as and when debited";
					if(strintrstcharged.equalsIgnoreCase("2"))strintrstcharged="To be accumulated and added to the principal to calculate EMI";
					String strmargin=correctNull((String)hshValues.get("sel_margin"));
					if(strmargin.equalsIgnoreCase("N"))strmargin="No";
					if(strmargin.equalsIgnoreCase("Y"))strmargin="Yes";
					sbAt.append(" ~Periodicity of Installments=").append(strinstallment);
					sbAt.append(" ~Interest to be collected during Holiday=").append(strduringholiday);
					sbAt.append(" ~Interest charged=").append(strintrstcharged);
					sbAt.append(" ~Margin=").append(correctNull((String)hshValues.get("txt_margin")));
					sbAt.append(" ~Purpose=").append(correctNull((String)hshValues.get("txt_purpose")));
					sbAt.append(" ~Relaxation in margin as per RBI COVID relief Package Policy=").append(strmargin);
					String strpredefinedmargin="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ correctNull((String)hshValues.get("sel_definedmargin")));
					if (rs4.next()) {
						strpredefinedmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Predefined Margin(%)=").append(strpredefinedmargin);
					String strrelaxeddmargin="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ correctNull((String)hshValues.get("sel_relaxedmargin")));
					if (rs4.next()) {
						strrelaxeddmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Relaxed Margin(%)=").append(strrelaxeddmargin);
					sbAt.append(" ~Due Date=").append(correctNull((String)hshValues.get("txt_duedate")));
					sbAt.append(" ~irregularites or overdues if any=").append(correctNull((String)hshValues.get("txt_desc")));
					sbAt.append(" ~Reviewed Due Date =").append(correctNull((String)hshValues.get("txt_reviewdate")));
					String strtufscheme=correctNull((String)hshValues.get("sel_Tuf"));
					if(strtufscheme.equalsIgnoreCase("N"))strtufscheme="No";
					if(strtufscheme.equalsIgnoreCase("Y"))strtufscheme="Yes";
					sbAt.append(" ~Whether under TUF scheme=").append(strtufscheme);
					sbAt.append(" ~Existing Facility CBS Account No=").append(correctNull((String)hshValues.get("txtcbsaccno")));
					sbAt.append(" ~Additional / Fresh Limit sought by Borrower =").append(correctNull((String)hshValues.get("txt_freshlimitmain")));
					
					String strgovscheme=correctNull((String)hshValues.get("selectgovtmain"));
					if(strgovscheme.equalsIgnoreCase("2"))strgovscheme="No";
					if(strgovscheme.equalsIgnoreCase("1"))strgovscheme="Yes";
					sbAt.append(" ~Govt. Sponsor Scheme=").append(strgovscheme);
					sbAt.append(" ~Process note Description =").append(correctNull((String)hshValues.get("sel_displaydesc")));
					String strschemetype="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^11^"+ correctNull((String)hshValues.get("schemetypemain")));
					if (rs4.next()) {
						strschemetype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Scheme Type=").append(strschemetype);
					sbAt.append(" ~Subsidy Amount=").append(correctNull((String)hshValues.get("submainamnt")));
					String strsponseragency="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^3^"+ correctNull((String)hshValues.get("sel_sponser_agencymain")));
					if (rs4.next()) {
						strsponseragency=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Sponser Agency=").append(strsponseragency);
					
					String strsubsidytype="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^5^"+ correctNull((String)hshValues.get("sel_subsidytypemain")));
					if (rs4.next()) {
						strsubsidytype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Subsidy Type=").append(strsubsidytype);
					sbAt.append(" ~Name of Agency=").append(correctNull((String)hshValues.get("txt_agency")));
					
					if((correctNull((String)hshValues.get("checkbox")).equals("checkbox")? "Y":"N").equals("Y"))
					{
						 strCategory=correctNull((String)hshValues.get("faccategory"));
						strExistBankFac=correctNull((String)hshValues.get("sel_existbanktype"));
						 strPropBankFac=correctNull((String)hshValues.get("sel_propbanktype"));
						 String strsubfactype=correctNull((String)hshValues.get("sel_subfac_desc"));
						String  strsubnatureoflimit=correctNull((String)hshValues.get("selsubadhoclimit"));
						 String strsubinsurancecover=correctNull((String)hshValues.get("sel_Processed_Type_sub"));
						String strsubintrsttype=correctNull((String)hshValues.get("sel_sub_inttype"));
						 String strsubroitype=correctNull((String)hshValues.get("sel_sub_interesttype"));
						 if(strExistBankFac.equals("S"))strExistBankFac="Sole";
							if(strExistBankFac.equals("C"))strExistBankFac="Consortium";
							if(strExistBankFac.equals("M"))strExistBankFac="Multiple Banking";
							
							if(strPropBankFac.equals("S"))strPropBankFac="Sole";
							if(strPropBankFac.equals("C"))strPropBankFac="Consortium";
							if(strPropBankFac.equals("M"))strPropBankFac="Multiple Banking";
							
							 strSubExistBankFac=correctNull((String)hshValues.get("sel_sub_existbanktype"));
							strSubPropBankFac=correctNull((String)hshValues.get("sel_sub_propbanktype"));
							if(strSubExistBankFac.equals("S"))strSubExistBankFac="Sole";
							if(strSubExistBankFac.equals("C"))strSubExistBankFac="Consortium";
							if(strSubExistBankFac.equals("M"))strSubExistBankFac="Multiple Banking";
							
							if(strSubPropBankFac.equals("S"))strSubPropBankFac="Sole";
							if(strSubPropBankFac.equals("C"))strSubPropBankFac="Consortium";
							if(strSubPropBankFac.equals("M"))strSubPropBankFac="Multiple Banking";
							
							if(strCategory.equals("R"))strCategory="Main Limit";
							if(strCategory.equals("I"))strCategory="Inner Limit";
							if(strCategory.equals("O"))strCategory="Outer Limit";
							if(strCategory.equals("C"))strCategory="Inter Changeable Limit";
							if(strCategory.equals("P"))strCategory="Apportion Limit";
							if(strCategory.equals("A"))strCategory="Adhoc";
							
							if(strsubfactype.equalsIgnoreCase("1"))strsubfactype="Fresh";
							if(strsubfactype.equalsIgnoreCase("2"))strsubfactype="Renewal";
							if(strsubfactype.equalsIgnoreCase("3"))strsubfactype="Restructuring";
							if(strsubfactype.equalsIgnoreCase("4"))strsubfactype="post Sanction";
							
							if(strsubnatureoflimit.equalsIgnoreCase("A"))strsubnatureoflimit="Adhoc";
							if(strsubnatureoflimit.equalsIgnoreCase("R"))strsubnatureoflimit="Regular Limit";
							if(strsubnatureoflimit.equalsIgnoreCase("D"))strsubnatureoflimit="Additional Limit";
							if(strsubnatureoflimit.equalsIgnoreCase("O"))strsubnatureoflimit="One Time Limit";
						if(strsubroitype.equalsIgnoreCase("CIBIL"))strsubroitype="CIBIL";
						if(strsubroitype.equalsIgnoreCase("CRIF"))strsubroitype="CRIF";
						
						if(strsubintrsttype.equalsIgnoreCase("Fix"))strsubintrsttype="Fixed";
						if(strsubintrsttype.equalsIgnoreCase("Flo"))strsubintrsttype="Floating";
						
						if(strsubinsurancecover.equalsIgnoreCase("B"))strsubinsurancecover="BLSS";
						if(strsubinsurancecover.equalsIgnoreCase("METLIFE"))strsubinsurancecover="MLSS";
						if(strsubinsurancecover.equalsIgnoreCase("NC"))strsubinsurancecover="Not Covered";
						
					sbAt.append(" ~Sub - Limits=").append(correctNull((String)hshValues.get("checkbox")).equals("checkbox")? "Y":"N");
					sbAt.append(" ~ Sub-Limit Head=").append(correctNull((String)hshValues.get("hid_subfacility_head")));
					sbAt.append(" ~ Sub-Limit =").append(correctNull((String)hshValues.get("hid_subfacility")));
					sbAt.append(" ~Existing Limit  =").append(correctNull((String)hshValues.get("txt_subexist_limit")));
					sbAt.append(" ~Proposed Limit  =").append(correctNull((String)hshValues.get("txt_subproposed_limit")));
					sbAt.append(" ~Existing Banking Arrangement  =").append(strSubExistBankFac);
					sbAt.append(" ~Proposed Banking Arrangement  =").append(strSubPropBankFac);
					sbAt.append(" ~Interest/ Discount/ Commission (%)  =").append(correctNull((String)hshValues.get("prd_subintrate"))).append("-").append(correctNull((String)hshValues.get("txt_submargin"))).append("-").append(correctNull((String)hshValues.get("txt_subinterest")));
					if(correctNull((String)hshValues.get("cattype")).equalsIgnoreCase("STL") || correctNull((String)hshValues.get("cattype")).equalsIgnoreCase("ADC"))
					{
						sbAt.append(" ~Overdues, if any  =").append(correctNull((String)hshValues.get("txt_subdesc")));
					}
				    sbAt.append(" ~D.P. =").append(correctNull((String)hshValues.get("txt_sub_dp")));
					sbAt.append(" ~Outstanding =").append(correctNull((String)hshValues.get("txt_sub_outstanding")));
					sbAt.append(" ~Value of Securities =").append(correctNull((String)hshValues.get("txt_sub_security")));
					sbAt.append(" ~Purpose =").append(correctNull((String)hshValues.get("txt_subpurpose")));
					//sbAt.append(" ~Margin (%) =").append(correctNull((String)hshValues.get("txt_margin2")));
					sbAt.append(" ~CBS Account Number =").append(correctNull((String)hshValues.get("txt_subcbsaccno")));
					sbAt.append(" ~Tenor (in Months) =").append(correctNull((String)hshValues.get("txt_subfacmonths")));
					
					
					//===============newly added columns===============//
					sbAt.append(" ~Scheme Code=").append(correctNull((String)hshValues.get("txt_subschemecode")));
					sbAt.append(" ~Facility Type=").append(strsubfactype);
					sbAt.append(" ~Nature of limit=").append(strsubnatureoflimit);
					sbAt.append(" ~Insurance Covered Under =").append(strsubinsurancecover);
					sbAt.append(" ~Insurance Amount=").append(correctNull((String)hshValues.get("txt_submetlifeinsurance")));
					sbAt.append(" ~Interest Type=").append(strsubintrsttype);
					sbAt.append(" ~Interest Sub Type=").append(correctNull((String)hshValues.get("sel_intsufacsubtype")));
					sbAt.append(" ~ROI TYPE=").append(strsubroitype);
					
					sbAt.append(" ~Initial Holiday/Gestation/Moratorium Period (in Months)=").append(correctNull((String)hshValues.get("txt_installments_sub")));
					 String strsubmodeofpayment="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^217^"+ correctNull((String)hshValues.get("selmodepayment_sub")));
					if (rs4.next()) {
						strsubmodeofpayment=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}
					sbAt.append(" ~Mode of Payment=").append(strsubmodeofpayment);
					sbAt.append(" ~Operative Account Number=").append(correctNull((String)hshValues.get("opnovalue_sub")));
				String  strsubinstallment=correctNull((String)hshValues.get("sel_peridicityfacsub"));
					if(strsubinstallment.equalsIgnoreCase("m"))strsubinstallment="Monthly";
					if(strsubinstallment.equalsIgnoreCase("q"))strsubinstallment="Quarterly";
					if(strsubinstallment.equalsIgnoreCase("h"))strsubinstallment="Half-Yearly";
					if(strsubinstallment.equalsIgnoreCase("y"))strsubinstallment="Yearly";
					if(strsubinstallment.equalsIgnoreCase("n"))strsubinstallment="Not Applicable";
					String  strsubduringholiday=correctNull((String)hshValues.get("interestservised_sub"));
					if(strsubduringholiday.equalsIgnoreCase("n"))strsubduringholiday="No";
					if(strsubduringholiday.equalsIgnoreCase("y"))strsubduringholiday="Yes";
					String  strsubintrstcharged=correctNull((String)hshValues.get("sel_interestcharge_sub"));
					if(strsubintrstcharged.equalsIgnoreCase("1"))strsubintrstcharged="To be paid as and when debited";
					if(strsubintrstcharged.equalsIgnoreCase("2"))strsubintrstcharged="To be accumulated and added to the principal to calculate EMI";
					 String strsubmargin=correctNull((String)hshValues.get("sel_marginsub"));
					if(strsubmargin.equalsIgnoreCase("N"))strsubmargin="No";
					if(strsubmargin.equalsIgnoreCase("Y"))strsubmargin="Yes";
					sbAt.append(" ~Periodicity of Installments=").append(strsubinstallment);
					sbAt.append(" ~Interest to be collected during Holiday=").append(strsubduringholiday);
					sbAt.append(" ~Interest charged=").append(strsubintrstcharged);
					sbAt.append(" ~Margin=").append(correctNull((String)hshValues.get("txt_margin_sub")));
					sbAt.append(" ~Purpose=").append(correctNull((String)hshValues.get("txt_subpurpose")));
					sbAt.append(" ~Relaxation in margin as per RBI COVID relief Package Policy=").append(strsubmargin);
					 String strsubpredefinedmargin="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^235^"+ correctNull((String)hshValues.get("sel_definedmarginsub")));
					if (rs4.next()) {
						strsubpredefinedmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Predefined Margin(%)=").append(strsubpredefinedmargin);
					 String strsubrelaxeddmargin="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^236^"+ correctNull((String)hshValues.get("sel_relaxedmarginsub")));
					if (rs4.next()) {
						strsubrelaxeddmargin=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Relaxed Margin(%)=").append(strsubrelaxeddmargin);
					sbAt.append(" ~Due Date=").append(correctNull((String)hshValues.get("txt_subduedate")));
					sbAt.append(" ~irregularites or overdues if any=").append(correctNull((String)hshValues.get("txt_subdesc")));
					sbAt.append(" ~Reviewed Due Date =").append(correctNull((String)hshValues.get("txt_subreviewdate")));
					 
					sbAt.append(" ~Existing Facility CBS Account No=").append(correctNull((String)hshValues.get("txtsubcbsaccno")));
					sbAt.append(" ~Additional / Fresh Limit sought by Borrower =").append(correctNull((String)hshValues.get("txt_freshlimitsub")));
					
					String  strsubgovscheme=correctNull((String)hshValues.get("selectgovt"));
					if(strsubgovscheme.equalsIgnoreCase("2"))strsubgovscheme="No";
					if(strsubgovscheme.equalsIgnoreCase("1"))strsubgovscheme="Yes";
					sbAt.append(" ~Govt. Sponsor Scheme=").append(strsubgovscheme);
					sbAt.append(" ~Process note Description =").append(correctNull((String)hshValues.get("sel_subdisplaydesc")));
					String  strsubschemetype="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^11^"+ correctNull((String)hshValues.get("schemetype")));
					if (rs4.next()) {
						strsubschemetype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Scheme Type=").append(strsubschemetype);
					sbAt.append(" ~Subsidy Amount=").append(correctNull((String)hshValues.get("subamt")));
					 String strsubsponseragency="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^3^"+ correctNull((String)hshValues.get("sel_sponser_agency")));
					if (rs4.next()) {
						strsubsponseragency=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Sponser Agency=").append(strsubsponseragency);
					
					strsubsidytype="";
					if(rs4!=null){
						rs4.close();
					}
					rs4 = DBUtils.executeLAPSQuery("selstatdatabyiddesc^5^"+ correctNull((String)hshValues.get("sel_subsidytype")));
					if (rs4.next()) {
						strsubsidytype=Helper.correctNull(rs4.getString("STAT_DATA_DESC1"));
					}sbAt.append(" ~Subsidy Type=").append(strsubsidytype);
					sbAt.append(" ~Name of Agency=").append(correctNull((String)hshValues.get("txt_subagency")));
					
					}
					if(correctNull((String)hshValues.get("hidAction")).equals(""))hshValues.put("hidAction","insert");
					sbAt.append("~Facility Sno=").append(strSno);
					//AuditTrial.auditNewLog(hshValues, "232", strAppNo, sbActionData.toString(), sbOldAudit.toString());
					
					
					//AuditTrial.auditLog(hshValues,"142",strAppno,sbAt.toString());
				}
				AuditTrial.auditNewLog1(hshValues,"142",strAppno,sbAt.toString(),sbOldAudit.toString(),strSno);	
          				
				//----------------End of New Commerical
				
				
//				if(rs!=null)
//				{rs.close();}
//				intUpdatesize=0;
//				String strCBSID=correctNull((String)hshRecord.get("strCBSID"));
//				hshQueryValues=new HashMap();
//				if(strApp.equalsIgnoreCase("new") && !strCBSID.equalsIgnoreCase(""))
//				{
//					strQuery=SQLParser.getSqlQuery("sel_op_ratingproposal^"+strCBSID);
//					rs=DBUtils.executeQuery(strQuery);
//					while(rs.next())
//					{
//						if(rs1!=null)
//						{rs1.close();}
//						String strRatAppNo=correctNull(rs.getString("fin_ratappno"));
//						strQuery=SQLParser.getSqlQuery("selcrefreezeflag^"+strRatAppNo);
//						rs1=DBUtils.executeQuery(strQuery);
//						if(rs1.next())
//						{
//							if(correctNull(rs1.getString("cre_rating")).equalsIgnoreCase("") && correctNull(rs1.getString("cre_weight")).equalsIgnoreCase(""))
//							{
//								intUpdatesize++;
//								hshQuery = new HashMap();
//								arrValues=new ArrayList();
//								hshQuery.put("strQueryId","updfinrating");
//								arrValues.add(strRatAppNo);
//								hshQuery.put("arrValues",arrValues);
//								hshQueryValues.put(""+intUpdatesize,hshQuery);
//								
//							}
//							
//						}
//						else
//						{
//							intUpdatesize++;
//							hshQuery = new HashMap();
//							arrValues=new ArrayList();
//							hshQuery.put("strQueryId","updfinrating");
//							arrValues.add(strRatAppNo);
//							hshQuery.put("arrValues",arrValues);
//							hshQueryValues.put(""+intUpdatesize,hshQuery);
//						}
//					}
//					hshQueryValues.put("size", ""+intUpdatesize);
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				}
				return hshRecord;
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("inside update"+ce.toString());
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
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4!= null)
				{
					rs4.close();
				}
				if(rs5 != null)
				{
					rs5.close();
				}


				
			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	}
	public void updateMISCBSDetails(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="",strSno="",strProductCode="",strModuleType="";
		String strQuery="";
		ResultSet rs=null;
		try
		{
			
			strAppno = correctNull((String)hshValues.get("appno"));
			strSno = correctNull((String)hshValues.get("selsno"));
			strProductCode=Helper.correctInt((String)hshValues.get("strProductCode"));
			strModuleType=correctNull((String)hshValues.get("strModuleType"));
			
			if(strModuleType.equalsIgnoreCase(""))
			{
				strModuleType=correctNull((String)hshValues.get("sessionModuleType"));
			}
			
			if(strModuleType.equalsIgnoreCase("RET"))
			{
				strQuery=SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ and PS_APP_SNO='1'");
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ and PS_APP_SNO='"+strSno+"'");
			}
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
			}
			else
			{
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","7");
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdetails");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				MISLogger.UpdateLogger("MISappdetails table delete ==="+hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappdisplayscreen");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				MISLogger.UpdateLogger("misappdisplayscreen table delete ==="+hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_misappclassification");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("3",hshQuery);
				
				MISLogger.UpdateLogger("misappclassification table delete ==="+hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "setcbsdetailsdel");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("4", hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "delriskdata");
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("5", hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId", "del_proposedsecuritydetails");
				arrValues.add(strAppno);
				if(strModuleType.equalsIgnoreCase("P"))
				arrValues.add(strProductCode);
				else
				arrValues.add(strSno);	
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("6", hshQuery);
				if(strModuleType.equalsIgnoreCase("RET")||strModuleType.equalsIgnoreCase("P"))
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_retail_repayschedule");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("7", hshQuery);
				}
				else
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_repayschedule_corp");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("7", hshQuery);
				}
				
				if(!(strModuleType.equalsIgnoreCase("RET")||strModuleType.equalsIgnoreCase("P")))
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_facility_mclrspread");
					arrValues.add(strSno);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("8", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_facilitysno_mclrspreadvalue");
					arrValues.add(strSno);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("9", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_companydetails_ps");
					arrValues.add(strSno);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("10", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_com_copmof_margin");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("11", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_com_copmof");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("12", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_comcomments");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("13", hshQuery);
					
					hshQueryValues.put("size","13");
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_facilitychklist");
					arrValues.add(strAppno);
					arrValues.add(strSno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("14", hshQuery);
					
					hshQueryValues.put("size","14");
					
					if(strModuleType.equalsIgnoreCase("AGR"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "del_agr_finprogramme_sno");
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("15", hshQuery);
						
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId", "delagrcropassessment");
						arrValues.add(strAppno);
						arrValues.add(strSno);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("16", hshQuery);
						
						hshQueryValues.put("size","16");
					}
				}
				else
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_depositdet");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("8", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "deletegolddetails");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("9", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_per_house_proposed_asset1");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("10", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "deleteautocollateral");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("11", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_farmmechparticulars");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("12", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "deleteedudetails");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("13", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_perincomedetails");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("14", hshQuery); 
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_leasedetails");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("15", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "delete_instacash");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("16", hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId", "del_appraisalQuest");
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("17", hshQuery);
					
					hshQueryValues.put("size","17");
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception cf)
		{
			cf.printStackTrace();
			throw new EJBException("inside updateMISCBSDetails"+cf.toString());
					
		}
		
	}
	
	public HashMap updateUnusedAccounts(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="",strAcctNo="",strOldAppNo="",strOldFacSno="";
		String strQuery="";
		ResultSet rs=null;
		try
		{			
			strAppno = correctNull((String)hshValues.get("appno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("hidappno"));
			}
			strAcctNo = correctNull((String)hshValues.get("sel_unusedaccounts"));
			
			if(!strAppno.equalsIgnoreCase("") && !strAcctNo.equalsIgnoreCase(""))
			{
				strQuery = SQLParser.getSqlQuery("sel_oldprop_det^"+strAppno+"^"+strAcctNo);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strOldAppNo = Helper.correctNull((String)rs.getString("APP_EXAPPNO"));
					strOldFacSno = Helper.correctNull((String)rs.getString("APP_EXAPPSNO"));
				}
				
				hshQueryValues = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery = new HashMap();
				arrValues= new ArrayList();
				hshQuery.put("strQueryId","update_renewFacility");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add(strOldAppNo);
				arrValues.add(strOldFacSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQuery = new HashMap();
				arrValues= new ArrayList();
				hshQuery.put("strQueryId","del_app_restructure");
				arrValues.add(strAppno);
				arrValues.add(strAcctNo);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				
				//Additional & adhoc facility deletion
				
				int intUpdatesize=2;
				strQuery = SQLParser.getSqlQuery("sel_facility_additionaldetails1^"+strAppno+"^"+strOldAppNo +"^"+strOldFacSno);
				if(rs!= null)
				{rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intUpdatesize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","del_facility_additionaldetails1");
					arrValues.add(strAppno);
					arrValues.add(Helper.correctNull(rs.getString("Fac_Addappno")));
					arrValues.add(Helper.correctNull(rs.getString("Fac_Addappsno")));
					arrValues.add("S");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","update_renewFacility");
					arrValues.add(null);
					arrValues.add("0");
					arrValues.add(Helper.correctNull(rs.getString("Fac_Addappno")));
					arrValues.add(Helper.correctNull(rs.getString("Fac_Addappsno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
				
				strQuery = SQLParser.getSqlQuery("sel_comfacility_details1^"+strAppno+"^"+strOldAppNo +"^"+strOldFacSno+"^P");
				if(rs!= null)
				{rs.close();}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					intUpdatesize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","del_comfacility_details1");
					arrValues.add(Helper.correctNull(rs.getString("fac_exappno")));
					arrValues.add(Helper.correctNull(rs.getString("fac_exappsno")));
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					intUpdatesize++;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","update_renewFacility");
					arrValues.add(null);
					arrValues.add("0");
					arrValues.add(Helper.correctNull(rs.getString("fac_exappno")));
					arrValues.add(Helper.correctNull(rs.getString("fac_exappsno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
							
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshValues.put("strappno", strAppno);
		}
		catch(Exception cf)
		{
			cf.printStackTrace();
			throw new EJBException("inside updateMISCBSDetails"+cf.toString());
					
		}
		return hshValues;
	}


	public  HashMap getFacilityData(HashMap hshValues) 
	{
	
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);		
		String strQuery="",strCashMargin="N",strgecltype="";
		String strQuery1="";
		String strQuery2="";
		String strQuery3="";
	    String strQuery4="";
		String strQuery5="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		HashMap hshRecord = new HashMap();
	///	PageContext pageContext=null;
		
		//ServletRequest request = null;
		//request = pageContext.getRequest();
		
		String strAppId=correctNull((String)hshValues.get("hidapplicantid"));
		String hidType1=correctNull((String)hshValues.get("hidType1"));
		String strpageFrom=correctNull((String)hshValues.get("pageFrom"));
		
		String strJoint="", strBankSchemecode="";
		boolean recordflag=false;
		if(strAppId.equalsIgnoreCase(""))
		{
			strAppId = correctNull((String)hshValues.get("comappid"));
		}
		if(strAppId.equalsIgnoreCase(""))
		{
			strAppId = correctNull((String)hshValues.get("comapp_id"));
		}
		if(strAppId.equalsIgnoreCase(""))
		{
			strAppId = correctNull((String)hshValues.get("hidBorrowerType"));
		}
		
		ArrayList vecData = new ArrayList();
		String strAppno="",strFacCategory="";
		ArrayList vecVal=null;
		StringTokenizer stk = null;
		HashMap hshformula =  new HashMap();//mck
		String  strSubInterest="";
		String strAction="",strFacType="",strSubHeadId="",strSubFacId="",strSubDesc="";
		double dblLC =0.00,dblMargin=0.00,dblSubExist=0.00,dblTotalLimit=0.0;
		double dblExist=0.00,dblProposed=0.00,dblDiff=0.00,dblTotDiff=0.00,dblTotExist=0.00,dblSubProposed=0.00,dblSubmargin=0.00;
		String strBorrowDesc="",strBorrowId="",strSelsno="",strSelsubsno="";//, strbranchname="";
		String strOrglevel="";
        String strissaral="";
        String strFlag="";
        String strExistInwardNo="";
        String strAppValuesin="";
        String strPSparams="",strPageIdPS="",strPageIdPSApp="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();
		String strFacDescnew="";
		double dbMinAmount=0.00,dbMaxAmount=0.00;
		String strMinAmount="",strMaxAmount="";
		String strfacilityDesc="",strrenewFac="",strNewappno="";
		String strFacilityTypefor="";
		int intUpdatesize1=0;
		String strFacdetails[]=new String[2];
		StringBuffer strExAppno=new StringBuffer();
		StringBuffer strExAppSno=new StringBuffer();
		StringBuffer strExAppAmt=new StringBuffer();
		StringBuffer strExAccNo=new StringBuffer();
		StringBuffer strExLimitType=new StringBuffer();
		String strcode="";
		String stractiveflag="Y";
		String strappstatus="";
		try
		{
			strAction=correctNull((String)hshValues.get("hidAction"));
			String	strFacilitySno=correctNull((String)hshValues.get("hidParameters")); 
			strAppno = correctNull((String)hshValues.get("appno"));
			strFacilityTypefor=Helper.correctNull((String)hshValues.get("hidstrType"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("hidNewappno"));
				strNewappno = correctNull((String)hshValues.get("hidNewappno"));
			}
			strrenewFac = correctNull((String)hshValues.get("hidrenewFac"));
			hshQueryValues=new HashMap();
			if(strAction.equalsIgnoreCase("postsanction"))
			{
				String strFacsno[]=strFacilitySno.split("~");
					for(int i=0;i<strFacsno.length; i++)
					{
	
						String facilitydetails=strFacsno[i];
						strFacdetails=facilitydetails.split("\\^");
	
						if(strFacdetails.length>1)
						{
							if(strFacdetails[1].contains("BRTOMCLR"))
							{
					    		
								++intUpdatesize1;
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","update_facility_interest");
								arrValues.add("0.0");
					    		arrValues.add("0.0");
					    		arrValues.add("0.0");
					    		arrValues.add("0.0");
					    		arrValues.add("");
								arrValues.add(Helper.correctNull(strFacdetails[0]));
								arrValues.add(strAppno);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(Integer.toString(intUpdatesize1),hshQuery);
								hshQueryValues.put("size",Integer.toString(intUpdatesize1));
							}
							
							++intUpdatesize1;
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							
							hshQuery.put("strQueryId","upd_apppostsanction");
							arrValues.add(Helper.correctNull(strFacdetails[1]));
							
							strPSparams="";
							StringTokenizer st = new StringTokenizer(strFacdetails[1],"@");
							while(st.hasMoreElements())
							{
								if(strPSparams.equalsIgnoreCase(""))
									strPSparams = "'"+(String)st.nextElement()+"'";
								else
									strPSparams = strPSparams+",'"+(String)st.nextElement()+"'";
							}
							if(!strPSparams.equalsIgnoreCase(""))
							{
								strQuery = SQLParser.getSqlQuery("sel_pageid_PS^"+strPSparams);
								rs = DBUtils.executeQuery(strQuery);
								strPageIdPS = "";
								while(rs.next())
								{
									if(strPageIdPS.equalsIgnoreCase(""))
										strPageIdPS = Helper.correctNull((String)rs.getString("ps_pageid"));
									else
										strPageIdPS = strPageIdPS+Helper.correctNull((String)rs.getString("ps_pageid"));
								}
							}
							arrValues.add(strPageIdPS);
							arrValues.add(strAppno);
							arrValues.add(Helper.correctNull(strFacdetails[0]));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize1),hshQuery);
							hshQueryValues.put("size",Integer.toString(intUpdatesize1));
							
							if(strPageIdPSApp.equalsIgnoreCase(""))
								strPageIdPSApp = "@"+strPageIdPS;
							else
								strPageIdPSApp = strPageIdPSApp+strPageIdPS;
						}
					}
					if(intUpdatesize1>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(rs!=null) rs.close();
			strQuery = SQLParser.getSqlQuery("sel_pageid_PSapp^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(strPageIdPSApp.equalsIgnoreCase(""))
					strPageIdPSApp = "@"+Helper.correctNull((String)rs.getString("ps_modify_pageid"));
				else
					strPageIdPSApp = strPageIdPSApp+Helper.correctNull((String)rs.getString("ps_modify_pageid"));
			}
			if(strPageIdPSApp.equalsIgnoreCase(""))
				strPageIdPSApp="@1@";
			hshRecord.put("Page_Id_PS", strPageIdPSApp);
			
			if(rs!=null) rs.close();
			strSelsno = correctNull((String)hshValues.get("selsno"));
			strSelsubsno = correctNull((String)hshValues.get("selsubsno"));
			strFacCategory = correctNull((String)hshValues.get("faccategory"));
			String strAppval = correctNull((String)hshValues.get("strAppval"));
			String strAppFlag = correctNull((String)hshValues.get("strAppFlag"));
			String strAppSecurity = correctNull((String)hshValues.get("strAppSecurity"));
			String strAppGroupflag = correctNull((String)hshValues.get("strAppGroupflag"));
			String strchkApp=correctNull((String)hshValues.get("strchkApp"));
			String strchkFinancial=correctNull((String)hshValues.get("chkFin"));
			String strInwardno=correctNull((String)hshValues.get("txt_appinwardno"));
			String strExecappno=correctNull((String)hshValues.get("txtSearch"));
			String strOldid=correctNull((String)hshValues.get("comapp_oldid"));
			String strNewid=correctNull((String)hshValues.get("comapp_newid"));
			if(strNewid.equals(""))
			{
				strNewid=correctNull((String)hshValues.get("comapp_new_id"));	
			}
			if(strNewid.equals(""))
			{
				strNewid=correctNull((String)hshValues.get("hidapplicantnewid"));	
			}
				
				
			strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            strissaral=correctNull((String)hshValues.get("strIsSaral"));
        	String strchkCoApp=correctNull((String)hshValues.get("chkCoApp"));
        	String strhidprop=correctNull((String)hshValues.get("hidPropType"));
        	
			//Application Number check
        	
			String strAppNumber = correctNull((String)hshValues.get("txtSearch"));
			String strSolid=Helper.correctNull((String)hshValues.get("strSolid"));
			String strModType=correctNull((String)hshValues.get("sessionModuleType"));
			String strFinancialReq="";
			if(strModType.equalsIgnoreCase("AGR")){
				strFinancialReq=correctNull((String)hshValues.get("sel_facilityrequired"));
			}else{
				strFinancialReq="";
			}
			if(hidType1.equalsIgnoreCase("R")||hidType1.equalsIgnoreCase("S")||hidType1.equalsIgnoreCase("P"))
			{
				getApplicationRenew(hshValues);
				
			}
			if(!(strAppNumber.equalsIgnoreCase("")))
			{
				strQuery1 = SQLParser.getSqlQuery("selcomappid^" + strOldid);
				if(rs1 != null)
				{
					rs1.close();
				}
				// count=0;
				String  strCountcheck="";
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					String strcheckappno=correctNull((String)rs1.getString("facility_appno"));
					if(strAppNumber .equalsIgnoreCase(strcheckappno))
					{
						strCountcheck="Yes";
						break;
					}
				}
				String strCountcheck6="";
				if(!strAppNumber.equalsIgnoreCase(""))
				{
					if(strCountcheck.equalsIgnoreCase(""))
					{
						strCountcheck6="Yes";
						hshRecord.put("strCountcheck",strCountcheck6);
					}
				}
				//For Renewal (28/11/2013)
				if(!strCountcheck6.equalsIgnoreCase("Yes"))
				{
					if(strAppno.equalsIgnoreCase("new") && !strExecappno.equalsIgnoreCase(""))
					{
						String strType="C";//mck
						hshformula.put("comapp_id",strAppId);//mck
						hshformula.put("apptype",strType);//mck
						hshformula.put("strSolid",strSolid);//mck
						strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
						hshValues.put("appno",strAppno);			
					}
					if(!strExecappno.equalsIgnoreCase("") && !strAppno.equalsIgnoreCase(""))
					{
						if(strAppno.trim().equalsIgnoreCase("new"))
						{
							throw new Exception("$ Cannot Create Proposal. Application Number Not found.");
						}
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						hshQueryValues=new HashMap();	
						String demo_comappid="0";
						String demo_finstandard="0";
						String demo_industrycode="0";
						String demo_indrating="0";
						String demo_finmodel="0";
						int intUpdatesize=0;
						
						//added by bhaskar
						InwardRegisterBean irb=new InwardRegisterBean();
					    strInwardno=irb.getMaxInwardno(strSolid);
					    //ended
						
						strQuery1 = SQLParser.getSqlQuery("sel_applications^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						String strPrdCode="";
							
						while(rs.next())
						{
							strPrdCode=Helper.correctNull((String)rs.getString("app_prdcode"));
							strAppValuesin=correctNull(rs.getString("app_valuesin"));
							strExistInwardNo=correctNull(rs.getString("app_inwardno"));
						}			
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						arrValues.add(strAppno);
						arrValues.add(strPrdCode);
						arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));
						arrValues.add(Helper.correctNull((String)hshValues.get("strOrgCode")));
						arrValues.add("C");
						arrValues.add(strInwardno);
						arrValues.add(strAppValuesin);
						arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("Y");
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(strFinancialReq);
						hshQuery.put("arrValues",arrValues);
						hshQuery.put("strQueryId","insapplications");
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						
						strQuery1 = SQLParser.getSqlQuery("get_comdemographics^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						
						while(rs.next())
						{
							demo_comappid=correctNull((String)rs.getString("demo_comappid"));
							demo_finstandard=Helper.correctInt((String)rs.getString("demo_finstandard"));
							demo_industrycode=correctNull((String)rs.getString("demo_industrycode"));
							demo_indrating=correctNull((String)rs.getString("demo_indrating"));
							demo_finmodel=correctNull((String)rs.getString("demo_finmodel"));
						}
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","ins_comdemographics");
						arrValues.add(strAppno);
						arrValues.add(strAppId);
						
						arrValues.add(demo_industrycode);
						arrValues.add(demo_indrating);
						arrValues.add(demo_finstandard);
						arrValues.add("N");
						arrValues.add(demo_finmodel);
						arrValues.add(strNewid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						strQuery1 = SQLParser.getSqlQuery("sel_loandetails^" + strExecappno);
						rs = DBUtils.executeQuery(strQuery1);
						String loan_modintrate="0", loan_terms="0",loan_amtreqd="0", loan_costloanprd="0", loan_recmdamt="0",loan_downpay="0",loan_appamt="";
						while(rs.next())
						{
							loan_modintrate=Helper.correctNull(rs.getString("loan_modintrate"));
							loan_terms=Helper.correctNull(rs.getString("loan_terms"));
							loan_amtreqd=Helper.correctNull(rs.getString("loan_amtreqd"));
							loan_costloanprd=Helper.correctNull(rs.getString("loan_costloanprd")); 
							loan_recmdamt=Helper.correctNull(rs.getString("loan_recmdamt"));
							loan_downpay=Helper.correctNull(rs.getString("loan_downpay"));
							loan_appamt=Helper.correctNull(rs.getString("loan_appamt"));
						}
						hshQuery.put("strQueryId","commapplicantloanins3");
						arrValues.add(strAppno);
						arrValues.add(loan_modintrate);
						arrValues.add(loan_terms);
						arrValues.add(loan_amtreqd);
						arrValues.add(loan_costloanprd);
						arrValues.add(loan_recmdamt);
						arrValues.add(loan_downpay);
						arrValues.add(loan_appamt);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commworkflowins");
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
						
						/*hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						intUpdatesize = intUpdatesize+1;
						arrValues.add(strAppno);
						hshQuery.put("strQueryId","inscomproposal");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
						
						//added by bhaskar
						
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
						
						
						/*hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updinwardappatached");
						arrValues.add("Y");
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
						
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
						if((!strAppval.equalsIgnoreCase("")) && (!strchkApp.equalsIgnoreCase("on")))
						{
							strQuery1 = SQLParser.getSqlQuery("get_FacilityData^" + strExecappno);
							rs = DBUtils.executeQuery(strQuery1);
							while(rs.next())
							{					
								hshQuery=new HashMap();
								arrValues=new ArrayList();
								hshQueryValues=new HashMap();					
								
								hshQuery.put("strQueryId","ins_FacilityData");
							
								arrValues.add(strAppno);
								arrValues.add(Helper.correctNull((String)rs.getString("facility_headid")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_id")));
								arrValues.add(strAppId);
								arrValues.add(Helper.correctNull((String)rs.getString("facility_date")));
								if(strAppValuesin.equalsIgnoreCase("R"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(2);
									jtn.setMinimumFractionDigits(2);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_existing")))));
								}
								else if(strAppValuesin.equalsIgnoreCase("L"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(3);
									jtn.setMinimumFractionDigits(3);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_existing")))));
									
								}
								else if(strAppValuesin.equalsIgnoreCase("C"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(4);
									jtn.setMinimumFractionDigits(4);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_existing")))));
									
								}
								if(strAppValuesin.equalsIgnoreCase("R"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(2);
									jtn.setMinimumFractionDigits(2);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")))));
								}
								else if(strAppValuesin.equalsIgnoreCase("L"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(3);
									jtn.setMinimumFractionDigits(3);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")))));
									
								}
								else if(strAppValuesin.equalsIgnoreCase("C"))
								{
									jtn= java.text.NumberFormat.getInstance();
									jtn.setMaximumFractionDigits(4);
									jtn.setMinimumFractionDigits(4);
									jtn.setGroupingUsed(false);
									arrValues.add(jtn.format(Double.parseDouble(Helper.correctDouble((String)rs.getString("facility_proposed")))));
									
								}
								//arrValues.add(Helper.correctNull((String)rs.getString("facility_existing")));
								//arrValues.add(Helper.correctNull((String)rs.getString("facility_proposed")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_difference")));
								arrValues.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_margin"))));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_sno")));						
								arrValues.add(Helper.correctNull((String)rs.getString("facility_group")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_sanctioned")));
								arrValues.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_desc"))));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_branchname")));
								arrValues.add("0.00");
								arrValues.add(Helper.correctNull((String)rs.getString("facility_category")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_months")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_interest")));					
								arrValues.add(correctNull((String)rs.getString("facility_intadjustment")));
								arrValues.add(Helper.correctNull((String)rs.getString("bplr")));									
								arrValues.add(Helper.correctNull((String)rs.getString("facility_dp")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_outstanding")));
								arrValues.add(Helper.correctNull((String)rs.getString("security_value")));
								arrValues.add(Helper.correctNull((String)rs.getString("cbs_accountno")));
								arrValues.add("");
								arrValues.add(Helper.correctNull((String)rs.getString("facility_osason")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_existbanktype")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_propbanktype")));
								arrValues.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_purpose"))));								
								//added by bhaskar								
								arrValues.add(correctNull((String)rs.getString("facility_inttype")));
								arrValues.add(correctNull((String)rs.getString("facility_repaytype")));
								arrValues.add(correctNull((String)rs.getString("facility_govtsponschem")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_schemetype")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_sponsagency")));	
								arrValues.add(correctNull((String)rs.getString("facility_subsidytype")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_subsidyamunt")));	
								arrValues.add(Helper.correctNull((String)rs.getString("facility_code")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_details")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_agrschemetype")));	
								arrValues.add(correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_INTERESTREC")));	
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_INTERESTCHARGED")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_MODEOFREPAY")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_OPERATIONACCNO")));
								arrValues.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_remarks"))));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_INTSUBTYPE")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_INTINDEXID")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_BASERATE")));
								arrValues.add(Helper.correctNull((String)rs.getString("FACILITY_BASERATE")));
								arrValues.add(Helper.correctNull((String)rs.getString("facility_accountopen")));
								//ended									
								hshQuery.put("arrValues",arrValues);					
								hshQueryValues.put("1",hshQuery);
								hshQueryValues.put("size","1");
								EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");								
								
								//added by bhaskar
								String strSno="";
								strSno=Helper.correctNull((String)rs.getString("facility_sno"));
								HashMap hshQueryNew=new HashMap();
								hshQueryNew.put("appno",strAppno);
								hshQueryNew.put("strSno",strSno);
								hshQueryNew.put("strBorrowId",strAppId);
								hshQueryNew.put("strSessionMod",Helper.correctNull((String)hshValues.get("sessionModuleType")));
								if(!Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("STL")
								&&	!Helper.correctNull((String)hshValues.get("hidCategoryType")).equalsIgnoreCase("ADC"))
								{
									UpdateBankingdata(hshQueryNew);						
								}
								//ended
								
							}
						}
						
						//commented for temp by bhaskar
						
						/*if((!strAppval.equalsIgnoreCase("")) && (!strAppSecurity.equalsIgnoreCase("on")))
						{
							hshQuery = new HashMap();
							hshQuery.put("appno",strAppno);
							hshQuery.put("execappno",strExecappno);
							setSecurityDetails(hshQuery);
						}*/
											
						if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
						{
							hshQuery = new HashMap();
							hshQuery.put("appno",strAppno);
							hshQuery.put("execappno",strExecappno);
							setCorporatePromoterDetails(hshQuery);
						}							
						
					}
					    hshQuery = new HashMap();
						arrValues=new ArrayList();
						if((!strAppval.equalsIgnoreCase("")) && (!strAppFlag.equalsIgnoreCase("on")))
						{
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");	
							hshQuery.put("strQueryId","updfacexeappno");
							arrValues.add(correctNull(strAppval));
							arrValues.add(correctNull(strAppFlag));
							arrValues.add(correctNull(strAppno));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

							hshRecord.put("appval",strAppval);
						}
									
						if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
						{					
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQueryValues.put("size","1");	
							hshQuery.put("strQueryId","updfgroupexecappno");
							arrValues.add(correctNull(strAppval));
							arrValues.add(correctNull(strAppGroupflag));
							arrValues.add(correctNull(strAppno));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						}
						/*
						 * Added by suresh & venu for copying the finnancial 
						 * while copying the facility detail itself
						 */
						if((!strAppval.equalsIgnoreCase("")) && (strchkFinancial.equalsIgnoreCase("Y")))
						{
							hshQuery = new HashMap();
							hshQuery.put("appno",strAppno);
							 setLoanDetails(hshQuery);
						}
						/*
						 * End of Financial copy
						 */
								
						}
				//End
			}
			
			if(strSelsubsno.trim().equals(""))
			{
				strSelsubsno="0";
			}
			strFacType = correctNull((String)hshValues.get("factype"));
	
 			if(!strAppno.trim().equals("new")) 
			{

 			if(strAction.trim().equals("update"))
			{
				strQuery = SQLParser.getSqlQuery("selfacilityval^" + strAppno+"^"+strSelsno);					
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					dblExist = rs.getDouble("facility_existing");
					dblProposed =rs.getDouble("facility_proposed");
					dblMargin =rs.getDouble("facility_margin");

					if(strFacType.trim().equals("facility"))
					{
						hshRecord.put("headid",correctNull(rs.getString("facility_headid")));
						hshRecord.put("facdid",correctNull(rs.getString("facility_id")));
						hshRecord.put("facdesc",correctNull(rs.getString("facility_desc")));
						hshRecord.put("facexist",jtn.format(dblExist));
						hshRecord.put("facproposed",jtn.format(dblProposed));
						hshRecord.put("facmargin",jtn.format(dblMargin));
						hshRecord.put("facinterest",correctNull(rs.getString("facility_interest")));
						hshRecord.put("facapplication",correctNull(rs.getString("facility_application")));
					}
					else if(strFacType.trim().equals("sublimit"))
					{
						hshRecord.put("subheadid",correctNull(rs.getString("facility_headid")));
						hshRecord.put("subfacdid",correctNull(rs.getString("facility_id")));
						hshRecord.put("subdesc",correctNull(rs.getString("facility_desc")));
						hshRecord.put("subexist",jtn.format(dblExist));
						hshRecord.put("subproposed",jtn.format(dblProposed));
						hshRecord.put("submargin",jtn.format(dblMargin));
						hshRecord.put("subfacinterest",correctNull(rs.getString("facility_interest")));//mck
					}
					hshRecord.put("borrowid",correctNull(rs.getString("borrower_id")));
					hshRecord.put("borrowdesc",correctNull(rs.getString("comapp_companyname")));
					hshRecord.put("facdate",correctNull(rs.getString("facility_date")));

					strQuery2 = SQLParser.getSqlQuery("selfacilityval^" + strAppno+"^"+strSelsubsno);
												
					rs2 = DBUtils.executeQuery(strQuery2);
					if(rs2.next())
					{
						strSubHeadId = correctNull(rs2.getString("facility_headid"));
						strSubFacId = correctNull(rs2.getString("facility_id"));
						strSubDesc = correctNull(rs2.getString("facility_desc"));
						dblSubExist =rs2.getDouble("facility_existing");
						dblSubProposed =rs2.getDouble("facility_proposed");
						dblSubmargin =rs2.getDouble("facility_margin");
						strSubInterest=correctNull(rs2.getString("facility_interest"));//mck
					}
					if(strFacType.trim().equals("sublimit"))
					{
						hshRecord.put("headid",strSubHeadId);
						hshRecord.put("facdid",strSubFacId);
						hshRecord.put("facdesc",strSubDesc);
						hshRecord.put("facexist",jtn.format(dblSubExist));
						hshRecord.put("facproposed",jtn.format(dblSubProposed));
						hshRecord.put("facmargin",jtn.format(dblSubmargin));
						//hshRecord.put("strSubInterest",strSubInterest);//mck 							
						hshRecord.put("facinterest",strSubInterest);//modified by balaji
					}
					else if(strFacType.trim().equals("facility"))
					{
						hshRecord.put("subheadid","");
						hshRecord.put("subfacdid","");
						hshRecord.put("subdesc","");
						hshRecord.put("subexist","");
						hshRecord.put("subproposed","");
						hshRecord.put("submargin","");
						hshRecord.put("strSubInterest","");//mck
					} 
				}
			
			}
			else
			{
			//	strSelsno="";
				String strFacHead = correctNull((String) hshValues.get("facility_head_id_code"));
				/*stk = new StringTokenizer(strFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strFacHead = (String)stk.nextToken();
				}*/
				String strFacility =correctNull((String) hshValues.get("facility_id_code"));
				/*stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}*/

				String strSubFacHead = correctNull((String) hshValues.get("subfacility_head"));
				stk = new StringTokenizer(strSubFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strSubFacHead = (String)stk.nextToken();
				}
				String strSubFacility =correctNull((String) hshValues.get("subfacility"));
				stk = new StringTokenizer(strSubFacility,"-");
				if(stk.hasMoreTokens())
				{
					strSubFacility = (String)stk.nextToken();
				}
				
			}
 			
            String strValuesIn="";
			strQuery = SQLParser.getSqlQuery("selprosalvaluesin^"+strAppno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("proposalvaluesin",correctNull(rs.getString("prop_valuesin")));
				strValuesIn=correctNull(rs.getString("prop_valuesin"));
			}
			strQuery = SQLParser.getSqlQuery("sel_facilityrequired^"+strAppno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_financialrequired",correctNull(rs.getString("app_facilityrequired")));
			}

			int	intGroup =0;
			
			if(strrenewFac.equalsIgnoreCase("Y"))
			{
				strQuery = SQLParser.getSqlQuery("sel_renewedFacility^" + strAppno);
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("selfacilitylist^" + strAppno +"^"+intGroup);
			}
				
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			dblExist=0.00;
			dblProposed=0.00;
			dblDiff=0.00;
			int lngGrpSize = 0;
			int count=0;
			//double dblPreExist=0.00,dblPreProposed=0.00;
			ArrayList arrSubGrp = new ArrayList();
			String strExist="",strProposed="";
			hshRecord.put("NCGTCCOUNT", Integer.toString(count));
			while(rs.next())
			{	
				if(correctNull(rs.getString("com_bankscheme")).equals("069"))
				{
					count=1;
					hshRecord.put("NCGTCCOUNT", Integer.toString(count));
				}
				
				
				strFlag="Y";
				intGroup = rs.getInt("facility_sno");
				vecVal = new ArrayList();
				
				vecVal.add(correctNull(rs.getString("facility_headid")));
				vecVal.add(correctNull(rs.getString("facheaddesc")));
				vecVal.add(correctNull(rs.getString("facility_id")));
				vecVal.add(correctNull(rs.getString("facdesc")));
				strBorrowId = correctNull(rs.getString("borrower_id"));
				vecVal.add(strBorrowId);
				vecVal.add(correctNull(rs.getString("facility_date")));
				dblExist =rs.getDouble("facility_existing");
				dblProposed =rs.getDouble("facility_proposed");
				dblTotExist  = dblTotExist + dblExist;
				dblDiff = dblProposed - dblExist;
				dblTotDiff  = dblTotDiff + dblDiff;
				if(strValuesIn.equalsIgnoreCase("L"))
				{
				    jtn= java.text.NumberFormat.getInstance();
				    jtn.setGroupingUsed(false);
					jtn.setMaximumFractionDigits(3);
					jtn.setMinimumFractionDigits(3);
				}
				if(strValuesIn.equalsIgnoreCase("C"))
				{
				    jtn= java.text.NumberFormat.getInstance();
				    jtn.setGroupingUsed(false);
					jtn.setMaximumFractionDigits(4);
					jtn.setMinimumFractionDigits(4);
				}
				strExist = jtn.format(dblExist);
				strProposed = jtn.format(dblProposed);
				String strDiff = jtn.format(dblDiff);
				String strMargin =correctNull(Helper.CLOBToString(rs.getClob("facility_margin")));
				String strSno =correctNull(rs.getString("facility_sno"));
//by Gokulakrishnan.C
				lngGrpSize = 0;
				arrSubGrp = new ArrayList();
				rs3 = DBUtils.executeQuery(SQLParser.getSqlQuery("selFacilityListSize^"+strAppno+"^"+intGroup));
				while(rs3.next())
				{
					lngGrpSize = lngGrpSize+1;
					arrSubGrp.add(Helper.correctNull((String)rs3.getString("facility_sno")));
				}
				if(rs3!=null)
					rs3.close();
//end-gk				

					//raman
				String strFacInterest=correctNull(rs.getString("facility_interest")); 
				String strIntadjust=correctNull(rs.getString("facility_intadjustment")); 
				vecVal.add(strExist);
				vecVal.add(strProposed);
				vecVal.add(strDiff);
				vecVal.add(strIntadjust);				
				vecVal.add(strSno);
				vecVal.add(correctNull((String)rs.getString("facility_group")));
				//vecVal.add(correctNull((String)rs.getString("facility_desc")));
				vecVal.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_desc"))));
				vecVal.add(correctNull((String)rs.getString("facility_category")));
				vecVal.add(correctNull((String)rs.getString("facility_months")));
				vecVal.add(correctNull((String)rs.getString("facility_branchname")));
				vecVal.add(strFacInterest);  
				vecVal.add(strMargin);
				vecVal.add(correctNull((String)rs.getString("BPLR")));					
				vecVal.add(correctNull((String)rs.getString("facility_dp")));
				vecVal.add(correctNull((String)rs.getString("facility_outstanding")));
				vecVal.add(correctNull((String)rs.getString("security_value")));	
				vecVal.add(correctNull((String)rs.getString("cbs_accountno")));
//by Gokulakrishnan.C - Here in this condition we wll have the size as '0' as this is the main group;
				vecVal.add(Integer.toString(lngGrpSize));
				vecVal.add(arrSubGrp);
//end-gk			
				vecVal.add(correctNull((String)rs.getString("facility_intremarks")));
				vecVal.add(correctNull((String)rs.getString("facility_osason")));
				vecVal.add(correctNull((String)rs.getString("facility_existbanktype")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_propbanktype")));
				//vecVal.add(Helper.correctNull((String)rs.getString("facility_purpose")));
				vecVal.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_purpose"))));
				
				//added by bhaskar
				
				vecVal.add(correctNull((String)rs.getString("facility_inttype")));
				vecVal.add(correctNull((String)rs.getString("facility_repaytype")));
				vecVal.add(correctNull((String)rs.getString("facility_govtsponschem")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_schemetype")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_sponsagency")));	
				vecVal.add(correctNull((String)rs.getString("facility_subsidytype")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_subsidyamunt")));	
				//Added for description getting
				String strFacHeadId=correctNull(rs.getString("facility_headid"));
				String strFacId=correctNull(rs.getString("facility_id"));
				String strFaccode=Helper.correctNull((String)rs.getString("facility_code"));			
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
				if(rs1.next())
				{
					dbMinAmount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_rangefrom")));
					dbMinAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesIn,dbMinAmount)));
					strBankSchemecode=Helper.correctNull((String)rs1.getString("com_bankscheme"));
					
					if(strValuesIn.equalsIgnoreCase("R"))
					{
						jtn.setMaximumFractionDigits(2);
						jtn.setMinimumFractionDigits(2);
						jtn.setGroupingUsed(false);
						strMinAmount=jtn.format(dbMinAmount);
					   
					}
					else if(strValuesIn.equalsIgnoreCase("L"))
					{
						jtn.setMaximumFractionDigits(5);
						jtn.setMinimumFractionDigits(5);
						jtn.setGroupingUsed(false);
						strMinAmount=jtn.format(dbMinAmount);
						
					}
					else if(strValuesIn.equalsIgnoreCase("C"))
					{
						jtn.setMaximumFractionDigits(7);
						jtn.setMinimumFractionDigits(7);
						jtn.setGroupingUsed(false);
						strMinAmount=jtn.format(dbMinAmount);
						
						
					}
					dbMaxAmount=Double.parseDouble(Helper.correctDouble((String)rs1.getString("com_rangeto")));
					dbMaxAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesIn,dbMaxAmount)));
					if(strValuesIn.equalsIgnoreCase("R"))
					{
						jtn.setMaximumFractionDigits(2);
						jtn.setMinimumFractionDigits(2);
						jtn.setGroupingUsed(false);
						strMaxAmount=jtn.format(dbMaxAmount);
					 
					}
					else if(strValuesIn.equalsIgnoreCase("L"))
					{
						jtn.setMaximumFractionDigits(5);
						jtn.setMinimumFractionDigits(5);
						jtn.setGroupingUsed(false);
						strMaxAmount=jtn.format(dbMaxAmount);
					
					}
					else if(strValuesIn.equalsIgnoreCase("C"))
					{
						jtn.setMaximumFractionDigits(7);
						jtn.setMinimumFractionDigits(7);
						jtn.setGroupingUsed(false);	
						strMaxAmount=jtn.format(dbMaxAmount);
						
					}
					strfacilityDesc=Helper.correctNull((String)rs1.getString("com_facdesc"));
					
					//Commented by Arsath as per the new requirement - Only Description is enough
					 vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc")));
					 // vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc"))+"-"+strMinAmount+"-"+strMaxAmount+"-"+
							//Helper.correctNull((String)rs1.getString("COM_FACILITY_EMISCHEME"))+"-"+Helper.correctNull((String)rs1.getString("COM_MINREPAYPERIOD"))+"-"+
							//Helper.correctNull((String)rs1.getString("COM_MAXREPAYPERIOD")));
					
				}
				else
				{
					vecVal.add("-");//37
				}
				
				//vecVal.add(Helper.correctNull((String)rs.getString("facility_code")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_details")));
				vecVal.add(Helper.correctNull((String)rs.getString("facility_agrschemetype")));
				
				vecVal.add(correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_INTERESTREC")));	
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_INTERESTCHARGED")));
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_MODEOFREPAY")));
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_OPERATIONACCNO")));
				vecVal.add(Helper.correctNull(Helper.CLOBToString(rs.getClob("facility_remarks"))));//45
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL")));//46
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_INTSUBTYPE")));//47
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_INTINDEXID")));//48
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_BASERATE")));//49
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_FACNATURE")));//50
				vecVal.add(strfacilityDesc);//51
				vecVal.add(Helper.correctNull((String)rs.getString("facility_TUF"))); //52
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_AGENCY"))); //53
				vecVal.add(Helper.correctNull((String)rs.getString("facility_sel_type"))); //54
				vecVal.add(Helper.correctNull((String)rs.getString("facility_freshlimit")));//55
				if(strFacilityTypefor.equalsIgnoreCase(""))
				{
					strFacilityTypefor=Helper.correctNull((String)rs.getString("FACILITY_TYPEFOR"));
				}
				if(strFacilityTypefor.equalsIgnoreCase("R"))
				{
					strFacilityTypefor="F";
				}else if(strFacilityTypefor.equalsIgnoreCase("C"))
				{
					strFacilityTypefor="C";
				}
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_DUEDATE")));//56
				vecVal.add(Helper.correctNull((String)rs.getString("facility_displaydesc")));//57
				vecVal.add(Helper.correctNull((String)rs.getString("facility_renew_flag")));//58
				vecVal.add(Helper.correctNull((String)rs.getString("Facility_restr_flag")));//59
				if(Helper.correctInt((String) hshValues.get("strappstatus")).equalsIgnoreCase("pa")){
					strcode="154";
					rs1=DBUtils.executeLAPSQuery("sel_staticcredit_desc^"+strcode+"^"+Helper.correctNull(rs.getString("fac_restr_scheme")));
					if (rs1.next()) {
						stractiveflag = Helper.correctNull(rs1.getString("STAT_DATA_ACTIVE"));
						
					}
					}
				
				vecVal.add(Helper.correctNull((String)rs.getString("Facility_fitl_acc")));//60
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_RESTR_FROM")));//61  --Added by Guhan
				vecVal.add(Helper.correctNull((String)rs.getString("facility_code")));//62
				vecVal.add(Helper.correctNull((String)rs.getString("facility_conversion_fac")));//63
				vecVal.add(Helper.correctNull((String)rs.getString("facility_additional_funding")));//64
				vecVal.add(Helper.correctNull((String)rs.getString("FACILITY_LEADERBANK")));//65
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+Helper.correctNull((String)rs.getString("FACILITY_LEADERBANK")));
				if(rs1.next())
				{
					vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//66
				}
				else
				{
					vecVal.add("");//66					
				}
				
				//To select the post sanction parameters
				strJoint = "and PS_APP_SNO='"+strSno+"'";
				String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strJoint);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					vecVal.add(Helper.correctNull((String)rsPS.getString("PS_MODIFY_TERMS")));//67
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_facbasedonsnogrp^"+Helper.correctNull((String)rsPS.getString("PS_OLD_APP_NO"))+"^"+Helper.correctNull((String)rsPS.getString("PS_OLD_APP_SNO")));
					if(rs1.next())
					{
						vecVal.add(Helper.correctNull(rs1.getString("facility_proposed")));//68
						vecVal.add(Helper.correctNull(rs1.getString("facility_months")));//69
					}
					else
					{
						vecVal.add("");//68
						vecVal.add("");//69
					}
				}
				else
				{
					vecVal.add("");//67
					vecVal.add("");//68
					vecVal.add("");//69
				}
				if(rsPS != null){rsPS.close();}
				//End
				vecVal.add(Helper.correctNull((String)rs.getString("com_facility_loantype")));//70
				vecVal.add(Helper.correctNull(rs.getString("fac_restr_scheme")));//71
				vecVal.add(Helper.correctNull(rs.getString("facility_adhocfac")));//72
				if(rs1!=null)
					rs1.close();
				String StrSubQuery=strAppno+"~"+Helper.correctNull(rs.getString("facility_sno"))+"~";
				rs1=DBUtils.executeLAPSQuery("sel_adhocfacchk^"+StrSubQuery);
				if(rs1.next())
				{
					vecVal.add("Y");//73
					vecVal.add(Helper.correctNull(rs1.getString("com_facdesc")));//74
					vecVal.add(Helper.correctNull(rs1.getString("facility_sno")));//75
				}
				else
				{
					vecVal.add("N");//73
					vecVal.add("");
					vecVal.add("");
				}
				
				vecVal.add(Helper.correctNull(rs.getString("facility_reattachflag")));//76
				vecVal.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("fac_metlifepremiumamt")))));//77
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ACCOUNTOPEN")));//78
				vecVal.add(Helper.correctNull(rs.getString("COM_FACILITY_EMISCHEME")));//79
				
				strExAppno=new StringBuffer();
				strExAppSno=new StringBuffer();
				strExAppAmt=new StringBuffer();
				strExAccNo=new StringBuffer();
				strExLimitType=new StringBuffer();
				
				strExAppno.append(Helper.correctNull(rs.getString("facility_oldappno"))).append("~");
				strExAppSno.append(Helper.correctNull(rs.getString("facility_oldappsno"))).append("~");
				
				
				
				// Existing Facility CBS Account No
				
				if(Helper.correctNull(rs.getString("facility_sel_type")).equalsIgnoreCase("2"))
				{
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_facility_mclrreldate^"+Helper.correctInt(rs.getString("facility_oldappno"))+"^"+Helper.correctInt(rs.getString("facility_oldappsno")));
					if(rs2.next())
					{
						strExAccNo.append(Helper.correctNull(rs2.getString("CBS_ACCOUNTNO")));
						strExAppAmt.append(Helper.correctNull(rs2.getString("FACILITY_SANCAMT"))).append("~");
						String templimit=Helper.correctNull(rs2.getString("FACILITY_CATEGORY"));
						if(templimit.equals("A"))
							templimit="Adhoc Limit";
						else if(templimit.equals("R"))
							templimit="Regular Limit";
						else if(templimit.equals("D"))
							templimit="Additional Limit";
						else if(templimit.equals("O"))
							templimit="One Time Limit";
						strExLimitType.append(templimit);
					}
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_facadditionaldetails1^"+strAppno+"^"+Helper.correctInt(rs.getString("facility_sno")));
					while(rs2.next())
					{
						strExAppno.append(Helper.correctNull(rs2.getString("FAC_ADDAPPNO"))).append("~");
						strExAppSno.append(Helper.correctNull(rs2.getString("FAC_ADDAPPSNO"))).append("~");
						strExAppAmt.append(Helper.correctNull(rs2.getString("FACILITY_SANCAMT"))).append("~");
					}
				}
				
				vecVal.add(strExAppno.toString());//80
				vecVal.add(strExAppSno.toString());//81
				vecVal.add(strExAccNo.toString());
				vecVal.add(strExAppAmt.toString());
				
				vecVal.add("");
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")));//85
				if(Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y")&&Helper.correctNull(rs.getString("facility_renew_flag")).equalsIgnoreCase("Y"))
				{
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_cgtmse_txndet^"+Helper.correctInt(rs.getString("facility_oldappno"))+"^"+Helper.correctInt(rs.getString("facility_oldappsno")));
					if(rs2.next())
					{
						vecVal.add(Helper.correctNull(rs2.getString("TXNDET_GUA_ENDDATE")));//86
					}
					else
					{
						vecVal.add("");//86
					}
				}
				else
				{
					vecVal.add("");//86
				}
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_CG_SPLIT_INT_RATE")));//87
				vecVal.add("");//88
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_CG_TOT_INT_RATE")));//89
				vecVal.add(Helper.correctNull(rs.getString("com_sharetype")));//90
				
				if(rs2!=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strSno);
				if(rs2.next())
				{
					vecVal.add("Y");
				}
				else
				{
					vecVal.add("N");
				}
				vecVal.add(Helper.correctNull(rs.getString("fac_roitype")));//92
				vecVal.add(Helper.correctNull(rs.getString("FAC_INS_COMPANY_NAME")));//93
				vecVal.add(Helper.correctNull(rs.getString("FAC_PREMIUM_TENOR")));//94
				vecVal.add(Helper.correctNull(rs.getString("FAC_PREMIUM_LOAN_AMOUNT")));//95
				vecVal.add(Helper.correctNull(rs.getString("FAC_INS_ACCOUNT_NO")));//96
				vecVal.add(Helper.correctNull(rs.getString("FAC_PREMIUM_AMOUNT")));//97
				vecVal.add(Helper.correctNull(rs.getString("FAC_INS_FUNDED_COMPANY_NAME")));//98
				vecVal.add(Helper.correctNull(rs.getString("fac_marginrelax")));//99
				vecVal.add(Helper.correctNull(rs.getString("fac_actualmargin")));//100
				vecVal.add(Helper.correctNull(rs.getString("fac_actualrelaxed")));//101
				vecVal.add(Helper.correctNull(rs.getString("fac_intdefermentdetails")));//102
				
				//Added By Nikesha B for Review Date
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_REVIEWDATE")));//103
				
				vecVal.add(strExLimitType.toString());//104
				vecVal.add(Helper.correctNull((rs.getString("facility_renewaljustif"))));//105
				vecVal.add(stractiveflag);//106

				
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ECSBANKNAME")));//107
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ECSACCOUNTTYPE")));//108
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ECSIFSCCODE")));//109
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ECSOPERACCNUM")));//110
				vecVal.add(Helper.correctNull(rs.getString("FACILITY_ECSATHUNMODE")));//111
				vecVal.add(strBankSchemecode);
				if(rs2!=null)
				{
					rs2.close();
				}
				rs2=DBUtils.executeLAPSQuery("sel_RenewalCheckCGPAN^"+strAppno+"^"+strSno);
				if(rs2.next())
				{
					vecVal.add("Y");//113
				}
				else
				{
					vecVal.add("N");//113
				}
				//vecVal.add(Helper.correctNull(rs.getString("FACILITY_FBIL_DATE")));//114
				//vecVal.add(Helper.correctNull(rs.getString("FACILITY_FBIL_TENOR")));//115
				vecData.add(vecVal);
				if(correctNull(rs.getString("faccashmargin")).equalsIgnoreCase("Y"))
				{
					strCashMargin="Y";
				}
				//ended by bhaskar
				hshRecord.put("asondate",correctNull((String)rs.getString("facility_osason")));
				strBorrowDesc =correctNull(rs.getString("comapp_companyname"));
				if(!strProposed.trim().equals(""))
				{
					dblLC =  dblLC + dblProposed;
				}
				
				dblTotalLimit =  dblTotalLimit + dblProposed;
				
				strQuery1 = SQLParser.getSqlQuery("selfacilitylist^" + strAppno+"^"+intGroup);
				if(rs1 != null)
				{
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery1);
				while(rs1.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs1.getString("facility_headid")));//0
					vecVal.add(correctNull(rs1.getString("facheaddesc")));//1
					vecVal.add(correctNull(rs1.getString("facility_id")));//2
					vecVal.add(correctNull(rs1.getString("facdesc")));//3
					strBorrowId = correctNull(rs1.getString("borrower_id"));
					vecVal.add(strBorrowId);//4
					vecVal.add(correctNull(rs1.getString("facility_date")));//5
					dblExist =rs1.getDouble("facility_existing");
					dblProposed =rs1.getDouble("facility_proposed");
					strExist = jtn.format(dblExist);
					dblDiff = dblProposed - dblExist;
					strProposed = jtn.format(dblProposed);
					dblTotalLimit =  dblTotalLimit + dblProposed;
					strDiff = jtn.format(dblDiff);
					strMargin =correctNull(Helper.CLOBToString(rs1.getClob("facility_margin")));
					strFacInterest=correctNull(rs1.getString("facility_interest")); //raman
					strIntadjust=correctNull(rs1.getString("facility_intadjustment"));
					strSno =correctNull(rs1.getString("facility_sno"));
					vecVal.add(strExist);//6
					vecVal.add(strProposed);//7
					vecVal.add(strDiff);//8
					vecVal.add(strIntadjust);//9
					vecVal.add(strSno);//10
					vecVal.add(correctNull((String)rs1.getString("facility_group")));//11
					//vecVal.add(correctNull((String)rs1.getString("facility_desc")));//12
					vecVal.add(Helper.correctNull(Helper.CLOBToString(rs1.getClob("facility_desc"))));//12
					vecVal.add(correctNull((String)rs1.getString("facility_category")));//13
					vecVal.add(correctNull((String)rs1.getString("facility_months")));//14					
					vecVal.add(correctNull((String)rs1.getString("facility_branchname")));//15 
					vecVal.add(strFacInterest);  //16
					vecVal.add(correctNull(strMargin));//17
					vecVal.add(correctNull((String)rs1.getString("BPLR")));//18
					vecVal.add(correctNull((String)rs1.getString("facility_dp")));//19
					vecVal.add(correctNull((String)rs1.getString("facility_outstanding")));//20
					vecVal.add(correctNull((String)rs1.getString("security_value")));//21
					vecVal.add(correctNull((String)rs1.getString("cbs_accountno")));//22
//by Gokulakrishnan.C
					vecVal.add(Integer.toString(lngGrpSize));//23
					vecVal.add(arrSubGrp);//24
//end-gk				
					vecVal.add(correctNull((String)rs1.getString("facility_intremarks")));//25
					vecVal.add(correctNull((String)rs1.getString("facility_osason")));//26
					vecVal.add(correctNull((String)rs1.getString("facility_existbanktype")));//27
					vecVal.add(correctNull((String)rs1.getString("facility_propbanktype")));//28
					//vecVal.add(Helper.correctNull((String)rs1.getString("facility_purpose")));//29
					vecVal.add(Helper.correctNull(Helper.CLOBToString(rs1.getClob("facility_purpose"))));
					
					vecVal.add(correctNull((String)rs1.getString("facility_inttype")));//30
					vecVal.add(correctNull((String)rs1.getString("facility_repaytype")));
					vecVal.add(correctNull((String)rs1.getString("facility_govtsponschem")));
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_schemetype")));
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_sponsagency")));	
					vecVal.add(correctNull((String)rs1.getString("facility_subsidytype")));
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_subsidyamunt")));//36
					
					//Added for description getting
				    strFacHeadId=correctNull(rs1.getString("facility_headid"));
				    strFacId=correctNull(rs1.getString("facility_id"));
				    strFaccode=Helper.correctNull((String)rs1.getString("facility_code"));			
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
					if(rs2.next())
					{
						dbMinAmount=Double.parseDouble(Helper.correctDouble((String)rs2.getString("com_rangefrom")));
						dbMinAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesIn,dbMinAmount)));
						strBankSchemecode=Helper.correctNull((String)rs2.getString("com_bankscheme"));
						if(strValuesIn.equalsIgnoreCase("R"))
						{
							jtn.setMaximumFractionDigits(2);
							jtn.setMinimumFractionDigits(2);
							jtn.setGroupingUsed(false);
							strMinAmount=jtn.format(dbMinAmount);
						   
						}
						else if(strValuesIn.equalsIgnoreCase("L"))
						{
							jtn.setMaximumFractionDigits(5);
							jtn.setMinimumFractionDigits(5);
							jtn.setGroupingUsed(false);
							strMinAmount=jtn.format(dbMinAmount);
							
						}
						else if(strValuesIn.equalsIgnoreCase("C"))
						{
							jtn.setMaximumFractionDigits(7);
							jtn.setMinimumFractionDigits(7);
							jtn.setGroupingUsed(false);
							strMinAmount=jtn.format(dbMinAmount);
							
							
						}
						dbMaxAmount=Double.parseDouble(Helper.correctDouble((String)rs2.getString("com_rangeto")));
						dbMaxAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesIn,dbMaxAmount)));
						if(strValuesIn.equalsIgnoreCase("R"))
						{
							jtn.setMaximumFractionDigits(2);
							jtn.setMinimumFractionDigits(2);
							jtn.setGroupingUsed(false);
							strMaxAmount=jtn.format(dbMaxAmount);
						 
						}
						else if(strValuesIn.equalsIgnoreCase("L"))
						{
							jtn.setMaximumFractionDigits(5);
							jtn.setMinimumFractionDigits(5);
							jtn.setGroupingUsed(false);
							strMaxAmount=jtn.format(dbMaxAmount);
						
						}
						else if(strValuesIn.equalsIgnoreCase("C"))
						{
							jtn.setMaximumFractionDigits(7);
							jtn.setMinimumFractionDigits(7);
							jtn.setGroupingUsed(false);	
							strMaxAmount=jtn.format(dbMaxAmount);
							
						}
						strfacilityDesc=Helper.correctNull((String)rs2.getString("com_facdesc"));
						//Commented by Arsath as per the new requirement - Only Description is enough
						 vecVal.add(Helper.correctNull((String)rs2.getString("com_facdesc")));
						// vecVal.add(Helper.correctNull((String)rs2.getString("com_facdesc"))+"-"+strMinAmount+"-"+strMaxAmount+"-"+
						//		Helper.correctNull((String)rs2.getString("COM_FACILITY_EMISCHEME"))+"-"+Helper.correctNull((String)rs2.getString("COM_MINREPAYPERIOD"))+"-"+
						//		Helper.correctNull((String)rs2.getString("COM_MAXREPAYPERIOD")));
						
					}
					else
					{
						vecVal.add("-");//37
					}
					
					
					//vecVal.add(Helper.correctNull((String)rs1.getString("facility_code")));//37
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_details")));//38
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_agrschemetype")));//39
					
					vecVal.add(correctNull((String)rs1.getString("FACILITY_HOLIDAYPERIOD")));//40
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_INTERESTREC")));	//41
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_INTERESTCHARGED"))); //42
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_MODEOFREPAY")));//43
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_OPERATIONACCNO")));//44				
					vecVal.add(Helper.correctNull(Helper.CLOBToString(rs1.getClob("facility_remarks"))));//45
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_PERINSTALL")));//46
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_INTSUBTYPE")));//47
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_INTINDEXID")));//48
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_BASERATE")));//49
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_FACNATURE")));//50
					vecVal.add(strfacilityDesc); //51
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_TUF"))); //52
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_agency")));//53
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_sel_type"))); //54
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_freshlimit")));//55
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_duedate")));//56
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_displaydesc")));//58
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_renew_flag")));//59
					vecVal.add(Helper.correctNull((String)rs1.getString("Facility_restr_flag")));//60
					vecVal.add(Helper.correctNull((String)rs1.getString("Facility_fitl_acc")));//61
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_RESTR_FROM")));//62   --Added by Guhan
					vecVal.add(Helper.correctNull((String)rs1.getString("facility_code")));
					vecVal.add(Helper.correctNull(rs1.getString("facility_conversion_fac")));
					vecVal.add(Helper.correctNull(rs1.getString("facility_additional_funding")));
					vecVal.add(Helper.correctNull((String)rs1.getString("FACILITY_LEADERBANK")));
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+Helper.correctNull((String)rs1.getString("FACILITY_LEADERBANK")));
					if(rs2.next())
					{
						vecVal.add(Helper.correctNull(rs2.getString("STAT_DATA_DESC1")));
					}
					else
					{
						vecVal.add("");
						
					}
					
					//To select the post sanction parameters
					strJoint = "and PS_APP_SNO='"+correctNull(rs1.getString("facility_sno"))+"'";
					strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strJoint);
					rsPS = DBUtils.executeQuery(strQueryPS);
					if(rsPS.next())
					{
						vecVal.add(Helper.correctNull((String)rsPS.getString("PS_MODIFY_TERMS")));
						if(rs2!=null)
						{
							rs2.close();
						}
						rs2=DBUtils.executeLAPSQuery("sel_facbasedonsnogrp^"+Helper.correctNull((String)rsPS.getString("PS_OLD_APP_NO"))+"^"+Helper.correctNull((String)rsPS.getString("PS_OLD_APP_SNO")));
						if(rs2.next())
						{
							vecVal.add(Helper.correctNull(rs2.getString("facility_sancamt")));//68
							vecVal.add(Helper.correctNull(rs2.getString("facility_months")));//69
						}
						else
						{
							vecVal.add("");//68
							vecVal.add("");//69
						}
					}
					else
					{
						vecVal.add("");
						vecVal.add("");//68
						vecVal.add("");//69
					}
					if(rsPS != null){rsPS.close();}
					//End
					
					vecVal.add(Helper.correctNull((String)rs1.getString("com_facility_loantype")));//70
					vecVal.add(Helper.correctNull(rs1.getString("fac_restr_scheme")));//71
					vecVal.add(Helper.correctNull(rs1.getString("facility_adhocfac")));//72
					if(rs2!=null)
						rs2.close();
					StrSubQuery=strAppno+"~"+Helper.correctNull(rs.getString("facility_sno"))+"~";
					rs2=DBUtils.executeLAPSQuery("sel_adhocfacchk^"+StrSubQuery);
					if(rs2.next())
					{
						vecVal.add("Y");//73
						vecVal.add(Helper.correctNull(rs2.getString("com_facdesc")));//74
						vecVal.add(Helper.correctNull(rs2.getString("facility_sno")));//75
					}
					else
					{
						vecVal.add("N");//73
						vecVal.add("");
						vecVal.add("");
					}
					vecVal.add(Helper.correctNull(rs1.getString("facility_reattachflag")));//76
					vecVal.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("fac_metlifepremiumamt")))));//77
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ACCOUNTOPEN")));//78
					vecVal.add(Helper.correctNull(rs1.getString("COM_FACILITY_EMISCHEME")));
					
					strExAppno=new StringBuffer();
					strExAppSno=new StringBuffer();
					strExAppAmt=new StringBuffer();
					strExAccNo=new StringBuffer();
					strExLimitType=new StringBuffer();

					strExAppno.append(Helper.correctNull(rs1.getString("facility_oldappno"))).append("~");
					strExAppSno.append(Helper.correctNull(rs1.getString("facility_oldappsno"))).append("~");
					
					// Existing Facility CBS Account No
					
					if(Helper.correctNull(rs1.getString("facility_sel_type")).equalsIgnoreCase("2"))
					{
						if(rs2!=null)
						{
							rs2.close();
						}
						rs2=DBUtils.executeLAPSQuery("sel_facility_mclrreldate^"+Helper.correctInt(rs1.getString("facility_oldappno"))+"^"+Helper.correctInt(rs1.getString("facility_oldappsno")));
						if(rs2.next())
						{
							strExAccNo.append(Helper.correctNull(rs2.getString("CBS_ACCOUNTNO")));
							strExAppAmt.append(Helper.correctNull(rs2.getString("FACILITY_SANCAMT"))).append("~");
							String templimit=Helper.correctNull(rs2.getString("FACILITY_CATEGORY"));
							if(templimit.equals("A"))
								templimit="Adhoc Limit";
							else if(templimit.equals("R"))
								templimit="Regular Limit";
							else if(templimit.equals("D"))
								templimit="Additional Limit";
							else if(templimit.equals("O"))
								templimit="One Time Limit";
							strExLimitType.append(templimit);
						}
						if(rs2!=null)
						{
							rs2.close();
						}
						rs2=DBUtils.executeLAPSQuery("sel_facadditionaldetails1^"+strAppno+"^"+Helper.correctInt(rs1.getString("facility_sno")));
						while(rs2.next())
						{
							strExAppno.append(Helper.correctNull(rs2.getString("FAC_ADDAPPNO"))).append("~");
							strExAppSno.append(Helper.correctNull(rs2.getString("FAC_ADDAPPSNO"))).append("~");
							strExAppAmt.append(Helper.correctNull(rs2.getString("FACILITY_SANCAMT"))).append("~");
						}
					}
					
					vecVal.add(strExAppno.toString());//80
					vecVal.add(strExAppSno.toString());//81
					vecVal.add(strExAccNo.toString());
					vecVal.add(strExAppAmt.toString());
					
					
					if(rs2!=null)
					{
						rs2.close();
					}				
					vecVal.add("");
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_WHT_CGTMSEAPPLY")));//85
					if(Helper.correctNull(rs1.getString("FACILITY_WHT_CGTMSEAPPLY")).equalsIgnoreCase("Y")&&Helper.correctNull(rs1.getString("facility_renew_flag")).equalsIgnoreCase("Y"))
					{
						if(rs2!=null)
						{
							rs2.close();
						}
						rs2=DBUtils.executeLAPSQuery("sel_cgtmse_txndet^"+Helper.correctInt(rs1.getString("facility_oldappno"))+"^"+Helper.correctInt(rs1.getString("facility_oldappsno")));
						if(rs2.next())
						{
							vecVal.add(Helper.correctNull(rs2.getString("TXNDET_GUA_ENDDATE")));//86
						}
						else
						{
							vecVal.add("");//86
						}
					}
					else
					{
						vecVal.add("");//86
					}
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_CG_SPLIT_INT_RATE")));//87
					vecVal.add("");//88
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_CG_TOT_INT_RATE")));//89
					vecVal.add(Helper.correctNull(rs1.getString("com_sharetype")));//90
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_misappdetails^"+strAppno+"^"+strSno);
					if(rs2.next())
					{
						vecVal.add("Y");
					}
					else
					{
						vecVal.add("N");
					}
					vecVal.add(Helper.correctNull(rs1.getString("fac_roitype")));//92
					vecVal.add(Helper.correctNull(rs1.getString("FAC_INS_COMPANY_NAME")));//93
					vecVal.add(Helper.correctNull(rs1.getString("FAC_PREMIUM_TENOR")));//94
					vecVal.add(Helper.correctNull(rs1.getString("FAC_PREMIUM_LOAN_AMOUNT")));//95
					vecVal.add(Helper.correctNull(rs1.getString("FAC_INS_ACCOUNT_NO")));//96
					vecVal.add(Helper.correctNull(rs1.getString("FAC_PREMIUM_AMOUNT")));//97
					vecVal.add(Helper.correctNull(rs1.getString("FAC_INS_FUNDED_COMPANY_NAME")));//98
					vecVal.add(Helper.correctNull(rs1.getString("fac_marginrelax")));//99
					vecVal.add(Helper.correctNull(rs1.getString("fac_actualmargin")));//100
					vecVal.add(Helper.correctNull(rs1.getString("fac_actualrelaxed")));//101
					vecVal.add(Helper.correctNull(rs1.getString("fac_intdefermentdetails")));//102
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_REVIEWDATE")));
					vecVal.add(strExLimitType.toString());//104
					vecVal.add(Helper.correctNull((rs1.getString("facility_renewaljustif"))));//105
					if(Helper.correctInt((String) hshValues.get("strappstatus")).equalsIgnoreCase("pa")){
						strcode="154";
						rs2=DBUtils.executeLAPSQuery("sel_staticcredit_desc^"+strcode+"^"+Helper.correctNull(rs1.getString("fac_restr_scheme")));
						if (rs2.next()) {
							stractiveflag = Helper.correctNull(rs2.getString("STAT_DATA_ACTIVE"));
							
						}
						}
					vecVal.add(stractiveflag);//106

					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ECSBANKNAME")));//107
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ECSACCOUNTTYPE")));//108
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ECSIFSCCODE")));//109
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ECSOPERACCNUM")));//110
					vecVal.add(Helper.correctNull(rs1.getString("FACILITY_ECSATHUNMODE")));//111
					vecVal.add(strBankSchemecode);//112
					
					if(rs2!=null)
					{
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_RenewalCheckCGPAN^"+strAppno+"^"+strSno);
					if(rs2.next())
					{
						vecVal.add("Y");//113
					}
					else
					{
						vecVal.add("N");//113
					}
					//vecVal.add(Helper.correctNull(rs1.getString("FACILITY_FBIL_DATE")));//114
					//vecVal.add(Helper.correctNull(rs1.getString("FACILITY_FBIL_TENOR")));//115
					vecData.add(vecVal);			
					if(correctNull(rs1.getString("faccashmargin")).equalsIgnoreCase("Y"))
					{
						strCashMargin="Y";
					}
					hshRecord.put("asondate",correctNull((String)rs1.getString("facility_osason")));
					strBorrowDesc =correctNull(rs1.getString("comapp_companyname"));
				}
				}			
				HashMap hshAppData = new HashMap();
				
				if(strrenewFac.equalsIgnoreCase("Y"))
				{
					hshAppData.put("appno", strNewappno);
				}
				else
				{
					hshAppData.put("appno", strAppno);	
				}
				hshAppData = (HashMap) EJBInvoker.executeStateLess("appeditlock", hshAppData, "getAppData");
				hshRecord.put("hshAppData", hshAppData);	
				
				
				if(rs!=null)
					rs.close();
				
				strQuery = SQLParser.getSqlQuery("selinwardnorequired^"+strAppno+"^<");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("inwardnorequired",correctNull(rs.getString("output")));
				}
			}
 			if(strhidprop!="")
 			{
 				hshRecord.put("app_proptype",strhidprop);
 			}
 			
			hshRecord.put("borrowid",strBorrowId);
			hshRecord.put("borrowdesc",strBorrowDesc);
			hshRecord.put("hidAction",strAction);
			hshRecord.put("appno",strAppno);
			hshRecord.put("selsno",strSelsno);
			hshRecord.put("selsubsno",strSelsubsno);
			hshRecord.put("factype",strFacType);
 			hshRecord.put("faccategory",strFacCategory);
 			//hshRecord.put("facadhocmonths",strAdhocMonths);	
 			hshRecord.put("lc",jtn.format(dblLC));
 			hshRecord.put("dblTotalLimit",jtn.format(dblTotalLimit));
			hshRecord.put("totexist",jtn.format(dblTotExist));
			hshRecord.put("totdiff",jtn.format(dblTotDiff));
			//hshRecord.put("facbranchname",strbranchname);	
			hshRecord.put("vecData",vecData);

			
			hshRecord.put("comapp_id",strAppId);
			hshRecord.put("app_newid",strNewid);
			hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("cattype")));
			hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));	
			
			
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
			
			/*if((!strAppval.equalsIgnoreCase("")) && (!strAppMangflag.equalsIgnoreCase("on")))
			{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","upd_fmangexecappno1");
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strAppval));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			
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
			//HashMap ramrate=new HashMap();
			//HashMap cgramrate=new HashMap();
			//ramrate.put("Exappno",strExecappno);
			//ramrate.put("presentAppno",strAppno);
			
			//cgramrate=(HashMap)updatePreviousYearRating(ramrate);
			String strFacilityAgr="";
			if(!strAppno.equalsIgnoreCase("new") && !strAppno.equalsIgnoreCase(""))
			{
			rs=DBUtils.executeLAPSQuery("sel_agr_facilities^"+strAppno);
			while(rs.next())
			{
				String strFacility="",strfacilitySno="",strfacilisplit="";
				strFacility=Helper.correctNull((String)rs.getString("facscheme"));
				strfacilitySno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
				strfacilisplit=strfacilitySno+"-"+strFacility;
				strFacilityAgr=strFacilityAgr+strfacilisplit+"@";
			}
			}
			hshRecord.put("strFacilityAgr",strFacilityAgr);
			
			hshRecord.put("strFlag", strFlag);
			
			// done for credit scoring by rajesh on  22/12/2013
			String strFreezeFacSno="";
			rs=DBUtils.executeLAPSQuery("sel_agr_facilities^"+strAppno);
			while(rs.next())
			{
			 strFreezeFacSno=Helper.correctNull((String)rs.getString("FACILITY_SNO"));
			}
			String strQry="where CRE_APPNO='"+strAppno+"' and CRE_SNO='"+strFreezeFacSno+"'";
			strQuery = SQLParser.getSqlQuery("selcreditscoring^"+strQry);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshRecord.put("cre_freeze", Helper.correctNull((String)rs.getString("cre_freeze")));
							
			}
			
			if (rs != null)
			{
				rs.close();
			}
			
			String strCBSID="";
			if(rs!=null) rs.close();
			String strQuery21 = SQLParser.getSqlQuery("getprofilestatusfromdemographic^"+strNewid);
			rs = DBUtils.executeQuery(strQuery21);
			if(rs.next())
			{
				hshRecord.put("inward_cbsid", Helper.correctNull((String)rs.getString("perapp_cbsid")));
				hshRecord.put("strCBSID",Helper.correctNull(rs.getString("perapp_cbsid")));
			}
			
			hshRecord.put("hidstrType",strFacilityTypefor);
			
			if(rs!=null) rs.close();
			strQuery21 = SQLParser.getSqlQuery("sel_RenewFlg^"+strAppno);
			rs = DBUtils.executeQuery(strQuery21);
			if(rs.next())
			{
				hshRecord.put("app_renew_flag", Helper.correctNull((String)rs.getString("app_renew_flag")));
				hshRecord.put("app_onlineupload", Helper.correctNull(rs.getString("app_onlineupload")));
			}

			if(rs!=null) rs.close();
			strQuery21 = SQLParser.getSqlQuery("selfinanceappno_appid^"+strAppno);
			rs = DBUtils.executeQuery(strQuery21);
			if(rs.next())
			{
				hshRecord.put("app_newid", Helper.correctNull((String)rs.getString("demo_comappnewid")));
			}
			
			
			//ADDED BY  BHASKAR FOR RATING YES/NO CHECKING
			String strRatFlag="";
			String strRatingTabHide="Y";
			rs=DBUtils.executeLAPSQuery("selfacratingflagmain^"+strAppno);
			while(rs.next())
			{
				strRatFlag=strRatFlag+Helper.correctNull(rs.getString("COM_FACRATING"))+"@";
			}			
			if(!strRatFlag.equalsIgnoreCase("") && strRatFlag.contains("@"))
			{
				strRatFlag=strRatFlag.substring(0,strRatFlag.length()-1);
			}
			if(strRatFlag.contains("Y"))
			{
				strRatingTabHide="N";
			}
			hshRecord.put("strRatingTabHide",strRatingTabHide);
			hshRecord.put("strCashMargin", strCashMargin);
			//ENDED
			
			
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
			
			//PS terms proposal wise
			String strPSterms = "";
			String strQueryPS = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ ");
			ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
			while(rsPS.next())
			{
				strPSterms = strPSterms + Helper.correctNull((String)rsPS.getString("PS_MODIFY_TERMS"));
			}
			hshRecord.put("PSterms_Proposal", strPSterms);
			
			
			if(strAction.trim().equals("deleteapplication"))
			{
				strQuery = SQLParser.getSqlQuery("seldistinctappno^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					HashMap hsh=new HashMap();
					hsh.put("hidapplicantid",strAppId);
					hsh.put("hidAction","freeze");
					hsh.put("appno",Helper.correctNull(rs.getString("appno")));
					SecurityMasterBean sm=new SecurityMasterBean();
					sm.getSecCollateralCoverage(hsh);
				}
			}
			
			if(strpageFrom.equalsIgnoreCase("postsanc") && hidType1.equalsIgnoreCase("P"))
			{
				BankAppBean bpb=new BankAppBean();
				hshRecord=bpb.getPostSanctionParameters(hshValues);
			}
			if(rs!=null)rs.close(); 
			int intDateDiff=0;
			strQuery = SQLParser.getSqlQuery("sel_facilitycreationchk^"+Helper.getCurrentDateTime());
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				intDateDiff=Integer.parseInt(Helper.correctInt((String)rs.getString("datediff")));
			}
			hshRecord.put("daydiff", String.valueOf(intDateDiff));
			
			if(rs!=null)
				rs.close();
			if (!strAppno.equalsIgnoreCase("") && !strAppno.equalsIgnoreCase("new"))
			{
				rs = DBUtils.executeLAPSQuery("selinwardappdata^" + strAppno);
				if (rs.next()){
					
					hshRecord.put("strInwardReqAmt",String.valueOf(Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt")))+
							Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt")))+
							Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt")))));
					
						
				}
			}
			
			//To get the freeze flag
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_freeze_flag",Helper.correctNull((String)rs.getString("app_freeze_flag")));
			}
			
			
			//To get the rating pending flag
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("selratingpendingapp_proposal^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshRecord.put("app_rating_pending","Y");
			}
			
			//To get the constitution value
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("get_perapplicant_details^"+strNewid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				if(Integer.parseInt(Helper.correctInt((String)rs.getString("perapp_constitutionnew")))>=183 &&
						Integer.parseInt(Helper.correctInt((String)rs.getString("perapp_constitutionnew")))<=191)
				{
					hshRecord.put("SHGcustomer", "Y");
				}
				
				hshRecord.put("strConst", Helper.correctInt((String)rs.getString("perapp_constitutionnew")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("sel_restype^"+strNewid);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				hshRecord.put("strMobileNo", Helper.correctInt((String)rs.getString("con_mobile")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery3 = SQLParser.getSqlQuery("sel_cg_paramval");
			rs = DBUtils.executeQuery(strQuery3);
			if(rs.next())
			{
			
				hshRecord.put("loan_paramval_cgtmse",Helper.correctNull((String)rs.getString("loan_paramval")));
			}
			if(rs!=null)
				rs.close();
			
			strQuery3 = SQLParser.getSqlQuery("sel_cg_app_status^"+strAppId);
			rs = DBUtils.executeQuery(strQuery3);
			if(rs.next())
			{
				hshRecord.put("AS_PERAPP_CONSTITUTION_CGTMSE",Helper.correctNull((String)rs.getString("AS_PERAPP_CONSTITUTION_CGTMSE")));
			}
			if(rs!=null)
				rs.close();
			int CGTMSEcount=0;
			strQuery3 = SQLParser.getSqlQuery("get_FacilityData^"+strAppno);
			rs = DBUtils.executeQuery(strQuery3);
			while(rs.next())
			{
				String temp =Helper.correctNull((String)rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
				if(temp.equals("Y"))
					CGTMSEcount++;
			}
			if(CGTMSEcount>0)
				hshRecord.put("FACILITY_WHT_CGTMSEAPPLY","Y");
			else
				hshRecord.put("FACILITY_WHT_CGTMSEAPPLY","N");

		// ===================added for cgtmse check	
			
			if(rs!=null)
				rs.close();
			int flagcount=0;
			String strfacno="";
			String strncgtccount="";
			strQuery=SQLParser.getSqlQuery("get_FacilityData^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{ 
				 strfacno=Helper.correctNull(rs.getString("facility_sno"));
				String wht_cgtsme_appl=Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
				if(wht_cgtsme_appl.equals("Y"))
				{
					if(rs1!=null)
						rs1.close();
					strQuery=SQLParser.getSqlQuery("sel_applicationExstng_fac^"+strAppno+"^"+strfacno);
					rs1=DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						hshRecord.put("strCGTMSE_CORP", "Y");
					}
					else
					{
						//hshRecord.put("strCGTMSE_CORP", "N");
						flagcount++;
					}
				}
			}
			if(flagcount>0)
			{
				hshRecord.put("strCGTMSE_CORP", "N");
			}
			hshRecord.put("strncgtcflag","N");
			if(rs!=null)rs.close();
			int rowval= 0, rowcount=0;
			strQuery=SQLParser.getSqlQuery("get_facilities_schemecount^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if (rs.last()) {
				rowval = rs.getRow();
				  // not rs.first() because the rs.next() below will move on, missing the first element
				rs.beforeFirst();
			}
			if(rs!=null)rs.close();
			String strBankscheme="";
			strQuery=SQLParser.getSqlQuery("get_FacilityData^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{ 
				strfacno=Helper.correctNull(rs.getString("facility_sno"));
				strBankscheme=Helper.correctNull(rs.getString("COM_BANKSCHEME"));
				if(Helper.correctNull(rs.getString("COM_BANKSCHEME")).equals("069") || Helper.correctNull(rs.getString("COM_BANKSCHEME")).equals("69"))
				{
					hshRecord.put("strBankscheme", strBankscheme);
					if(rs2!=null)rs2.close();
					strQuery=SQLParser.getSqlQuery("select_corp_ncgtc^"+strAppno+"^"+strfacno);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						if(rowcount==0)
						{
							rowcount=1;
						}
						else
						{
							rowcount=rowcount+1;
						}
					}
				}
			}
			if(rowcount==rowval)
			{
				hshRecord.put("strncgtcflag", "Y");
			}
			//Loan against share check
			{
				
				double dblDematAmt=0.0,dblPhysicalShareAmt=0.0;
				
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_facility_details_interface^"+strAppno);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("COM_LOANAGAINSTSHARES")).equalsIgnoreCase("Y"))
					{
						if(Helper.correctNull(rs.getString("COM_SHARETYPE")).equalsIgnoreCase("P"))
							dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_SANCAMT")));
						if(Helper.correctNull(rs.getString("COM_SHARETYPE")).equalsIgnoreCase("D"))
							dblDematAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_SANCAMT")));
					}
				}
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sel_otherbanksharelimit^"+strAppId);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("PERBANK_LOANPURPOSE")).equalsIgnoreCase("4"))
						dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
					else if(Helper.correctNull(rs.getString("PERBANK_LOANPURPOSE")).equalsIgnoreCase("5"))
						dblDematAmt +=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
				}
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sum_retailloanagainstshare^"+strAppId);
				while (rs.next()) 
				{
					if(Helper.correctNull(rs.getString("PRD_SHARETYPE")).equalsIgnoreCase("P"))
						dblPhysicalShareAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
					else if(Helper.correctNull(rs.getString("PRD_SHARETYPE")).equalsIgnoreCase("D"))
						dblDematAmt+=Double.parseDouble(Helper.correctDouble(rs.getString("amt")));	
				}
				if(rs!=null)
					rs.close();
				rs = DBUtils.executeLAPSQuery("sum_corpagriloanagainstshare^"+strAppId);
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
					hshRecord.put("strPhyLimitExceeds","Y");
				}
				if(dblDematAmt>dblDematshareLimit)
				{
					hshRecord.put("strDematLimitExceeds","Y");
				}
				
				hshRecord.put("strDematLimitAvailed",jtn.format(dblDematAmt));
				hshRecord.put("strPhyLimitAvailed",jtn.format(dblPhysicalShareAmt));
				hshRecord.put("strDematLimit",jtn.format(dblDematshareLimit));
				hshRecord.put("strPhyLimit",jtn.format(dblPhysicalShareLimit));
			}
			// checking data in db for checklist
			int a=0,b=0;
			if(rs!=null)
                rs.close();
				rs=DBUtils.executeLAPSQuery("select_facility_details^"+strAppno);
 			while(rs.next())
    		{
 				if(Helper.correctNull(rs.getString("COM_BANKSCHEME")).equalsIgnoreCase("052"))
 				{
 					a++;
 					if(rs1!=null)
 						rs1.close();
 					rs1=DBUtils.executeLAPSQuery("select_facility_chklist^"+strAppno+"^"+Helper.correctNull(rs.getString("FACILITY_SNO")));
 		 			if(rs1.next())
 		    		{
 		 				b++;
 		    		}
 				}
 				
    		}
 			if(a==b)
 				hshRecord.put("strCheckList_Check","Y");
 			else
 				hshRecord.put("strCheckList_Check","N");
 			
 			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_querystatus^"+strAppno);
			if(rs.next())
			{
				if(Integer.parseInt(Helper.correctInt(rs.getString("cnt")))>0)
					hshRecord.put("Query_Status", "No");
			}
			String strFreeze="";
	  		if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
    		rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				strFreeze = Helper.correctNull((String)rs.getString("app_freeze_flag"));
			}
			hshRecord.put("strFreeze",strFreeze);
			
			//digi application type
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_app_perm_no^"+ strAppno);			 
			if(rs.next()) 
			{
				hshRecord.put("StrDigiLoanType", Helper.correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI")));
			}
			
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("sel_cbsaccno^"+ strAppno);
			if(rs.next())
			{
				hshRecord.put("strCreatedDate",correctNull(rs.getString("APP_CREATEDATE")));
			}
			//To get the GECL facility
			strQuery = SQLParser.getSqlQuery("chk_geclfacchk^"+strAppno);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
				{
					hshRecord.put("strgeclavailable","Y");
					strgecltype= Helper.correctNull((rs.getString("com_gecltype")));
					if( Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL1")){
						hshRecord.put("strgecl1flag","Y");
					}
				}
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("065"))
					hshRecord.put("strCGSSD","Y");
			}
			hshRecord.put("strgecltype",strgecltype);

			strQuery = SQLParser.getSqlQuery("sel_wcdpnfac^"+strAppno);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_ID")).equalsIgnoreCase("98"))
					hshRecord.put("strDPN2020","Y");	
			}
			
			//GECL Facilities
			if(rs != null)
				rs.close();
			int intcountgecl1=0,intcountgecl2=0,intfaccountgecl2=0,intfaccountgecl3=0,intcountgecl3=0,intcountgecl1ext=0,intfaccountgeclext1=0,intcountgecl2ext=0,intfaccountgeclext2=0,intcountgecl3ext=0,intfaccountgeclext3=0;
			rs = DBUtils.executeLAPSQuery("sel_geclfacilities^"+strAppId);
			while(rs.next())
			{
				
				if(!Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase(strAppno))
				{
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL1")){
						intcountgecl1++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL2")){
						intcountgecl2++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL3")){
						intcountgecl3++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -1 extension")){
						intcountgecl1ext++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -2 extension")){
						intcountgecl2ext++;
					}
					
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -3 extension")){
						intcountgecl3ext++;
					}
					
					
					hshRecord.put("strgeclavailable1","Y");
					hshRecord.put("strGECLType", Helper.correctNull((rs.getString("com_gecltype"))));
				}
				else{
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL1")){
						intfaccountgecl2++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL3")){
						intfaccountgecl3++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -1 extension")){
						intfaccountgeclext1++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -2 extension")){
						intfaccountgeclext2++;
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -3 extension")){
						intfaccountgeclext3++;
					}
				}
			}
			
			if(rs!=null){
				rs.close();
			}
			
			
			
			hshRecord.put("intcountgecl1",String.valueOf(intcountgecl1));
			hshRecord.put("intcountgecl2",String.valueOf(intcountgecl2));
			hshRecord.put("intfaccountgecl2",String.valueOf(intfaccountgecl2));
			hshRecord.put("intfaccountgecl3",String.valueOf(intfaccountgecl3));
			hshRecord.put("intcountgecl3",String.valueOf(intcountgecl3));
			
			hshRecord.put("intcountgecl1ext",String.valueOf(intcountgecl1ext));
			hshRecord.put("intfaccountgeclext1",String.valueOf(intfaccountgeclext1));
			
			hshRecord.put("intcountgecl2ext",String.valueOf(intcountgecl2ext));
			hshRecord.put("intfaccountgeclext2",String.valueOf(intfaccountgeclext2));
			
			
			
			hshRecord.put("intcountgecl3ext",String.valueOf(intcountgecl3ext));
			hshRecord.put("intfaccountgeclext3",String.valueOf(intfaccountgeclext3));
			
			
			
			
			
			log.info("<<<<<<<<<<<<================intcountgecl3=============>>>>>>>>>>"+intcountgecl3);
            log.info("<<<<<<<<<<<<================intfaccountgecl3=============>>>>>>>>>>"+intfaccountgecl3);
			log.info("<<<<<<<<<<<<================intfaccountgecl3=============>>>>>>>>>>"+intfaccountgecl3);
			if(rs != null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_nongeclfacchk^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strnongeclfacchk","Y");
			}
			if(rs != null)
				rs.close();
			rs = DBUtils.executeLAPSQuery("selborrowerdet_company^"+strAppId);
			if(rs.next())
			{
				hshRecord.put("cominfo_total_employees", Helper.correctInt(rs.getString("cominfo_total_employees")));	
			}
			if(rs1!=null)
			{	  rs1.close(); 
			}
			
			
			int intcountparayatan=0,intfaccountparayatan=0;
			rs = DBUtils.executeLAPSQuery("sel_parayatanfacilities^"+strAppId);
			while(rs.next())
			{
				
				hshRecord.put("parayatanFlag","Y");
				if(!Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase(strAppno))
				{
					
						intcountparayatan++;
					
				}
				else
				{
					
						intfaccountparayatan++;
					
				}
				}
			
			if(rs!=null){
				rs.close();
			}
			
			hshRecord.put("intcountparayatan",String.valueOf(intcountparayatan));
			hshRecord.put("intfaccountparayatan",String.valueOf(intfaccountparayatan));
			
			rs = DBUtils.executeLAPSQuery("sel_parayatanbankdet^"+strAppId);
			while(rs.next())
			{
				//hshRecord.put("perapp_facility_othbank", Helper.correctNull(rs.getString("perapp_facility_othbank")));	
				if(Helper.correctNull(rs.getString("perapp_facility_othbank")).equalsIgnoreCase("P"))
				{
					hshRecord.put("perapp_facility_othbankP","P");
				}
				if(Helper.correctNull(rs.getString("perapp_facility_othbank")).equalsIgnoreCase("G"))
				{
					hshRecord.put("perapp_facility_othbankG","G");
				}
			}
			
			if(rs1!=null)
			{	  rs1.close(); 
			}
			
			
			int intcountgeclgp1=0,intcountgeclgp2=0,intfaccountgeclgp2=0,intfaccountgeclgp3=0,intcountgeclgp3=0,intfaccountgeclgpext1=0;
			int intcountgeclgp2ext=0,intfaccountgeclgpext2=0,intcountgeclgp3ext=0,intfaccountgeclgpext3=0,intcountgeclgp1ext=0;
			rs = DBUtils.executeLAPSQuery("sel_geclfacilities13^"+strAppId);
			while(rs.next())
			{
				
				if(!Helper.correctNull(rs.getString("app_no")).equalsIgnoreCase(strAppno))
				{
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL1")){
						intcountgeclgp1++;
						hshRecord.put("GECLFLAG","Y");
					}
					
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL3")){
						intcountgeclgp3++;
						hshRecord.put("GECLFLAG","Y");
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -1 extension")){
						intcountgeclgp1ext++;
						hshRecord.put("GECLFLAG","Y");
					}
					
					
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -3 extension")){
						intcountgeclgp3ext++;
						hshRecord.put("GECLFLAG","Y");
					}
					
					
					
				}
				else{
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL1")){
						intfaccountgeclgp2++;
						hshRecord.put("GECLFLAG","Y");
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL3")){
						intfaccountgeclgp3++;
						hshRecord.put("GECLFLAG","Y");
					}
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -1 extension")){
						intfaccountgeclgpext1++;
						hshRecord.put("GECLFLAG","Y");
					}
					
					if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL -3 extension")){
						intfaccountgeclgpext3++;
						hshRecord.put("GECLFLAG","Y");
					}
				}
			}
			
			
			hshRecord.put("intcountgeclgp1",String.valueOf(intcountgeclgp1));
			hshRecord.put("intcountgeclgp2",String.valueOf(intcountgeclgp2));
			hshRecord.put("intfaccountgeclgp2",String.valueOf(intfaccountgeclgp2));
			hshRecord.put("intfaccountgeclgp3",String.valueOf(intfaccountgeclgp3));
			hshRecord.put("intcountgeclgp3",String.valueOf(intcountgeclgp3));
			
			hshRecord.put("intcountgeclgp1ext",String.valueOf(intcountgeclgp1ext));
			hshRecord.put("intfaccountgeclgpext1",String.valueOf(intfaccountgeclgpext1));
			
			hshRecord.put("intcountgeclgp2ext",String.valueOf(intcountgeclgp2ext));
			hshRecord.put("intfaccountgeclgpext2",String.valueOf(intfaccountgeclgpext2));
			
			
			
			hshRecord.put("intcountgeclgp3ext",String.valueOf(intcountgeclgp3ext));
			hshRecord.put("intfaccountgeclgpext3",String.valueOf(intfaccountgeclgpext3));
			
			
			if(rs!=null){
				rs.close();
			}
			
			
			
			rs1=DBUtils.executeLAPSQuery("queryforpromoters^"+strAppno);
 			if(rs1.next())
    		{
 				String strRestructureInvoDate=Helper.correctNull(rs1.getString("PERAPP_INVOCDATE"));
 				hshRecord.put("strRestructureInvoDate",strRestructureInvoDate);
    		}
 			
 			if(rs!=null)
				rs.close();
			strQuery1 = SQLParser.getSqlQuery("sel_inward_proposed_values^" + strAppno);
			rs = DBUtils.executeQuery(strQuery1);
			
			if(rs.next())
			{
				hshRecord.put("digiappno",Helper.correctNull(rs.getString("INWARD_DIGIAPPNO")));
			}
			if(rs3 != null)
			{
				rs3.close();
			}
			 strQuery1 = SQLParser.getSqlQuery("checkforblockprocesscharges^"+strAppno);
		       rs3= DBUtils.executeQuery(strQuery1);
				if (rs3.next())
				{
					hshRecord.put("SHG","Y");	
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("getsecuritysumofvalue^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
    		if(rs.next())
			{
    			hshRecord.put("FACILITY_PROPOSEDValue",Helper.correctNull((String)rs.getString("FACILITY_PROPOSED")));
			}
				}
				else
				{
					hshRecord.put("SHG","N");		
				}
				
				Helper.correctNull((String)hshValues.get("strSolid"));
				if(rs1 != null)
				{
					rs1.close();
				}
				strQuery2=SQLParser.getSqlQuery("getscodebasedon_sel_mibore^" + Helper.correctNull((String)hshValues.get("strSolid")) );		
				rs1 = DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					hshRecord.put("miborchk",Helper.correctNull((String)rs1.getString("ORG_MIBOR_SEL")));
				}
				else
				{
					hshRecord.put("miborchk","N");
				}
				/*if(rs1 != null)
				{
					rs1.close();
				}
				strQuery2=SQLParser.getSqlQuery("getinwardcreateddate^" + strAppno );		
				rs1 = DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					hshRecord.put("miboinward_created",Helper.correctNull((String)rs1.getString("inward_created")));
				}*/
				
				if(rs1 != null)
				{
					rs1.close();
				}
				 strInwardno=correctNull((String)hshValues.get("inwardno"));
				strQuery2=SQLParser.getSqlQuery("getvalidlarandsysdate^" + strInwardno );		
				rs1 = DBUtils.executeQuery(strQuery2);
				if(rs1.next())
				{
					hshRecord.put("inwardcreatedate",Helper.correctNull((String)rs1.getString("INWARD_CREATEDON")));
					hshRecord.put("afterthreemonthdate",Helper.correctNull((String)rs1.getString("ENDDATE")));
				}
				int strenwrcount=0;
				if(rs!=null)
	                rs.close();
					rs=DBUtils.executeLAPSQuery("select_facility_details^"+strAppno);
	 			while(rs.next())
	    		{
	 				if(Helper.correctNull(rs.getString("COM_BANKSCHEME")).equalsIgnoreCase("074"))
	 				{
	 					
	 					if(rs1!=null)
	 						rs1.close();
	 					//rs1=DBUtils.executeLAPSQuery("selagreNWRdetails^"+strAppno+"^"+Helper.correctNull(rs.getString("FACILITY_SNO")));
	 					rs1=DBUtils.executeLAPSQuery("selagreNWRdetails^"+Helper.correctNull(rs.getString("FACILITY_SNO"))+"^"+strAppno);
	 		 			if(rs1.next())
	 		    		{
	 		 				hshRecord.put("strenwr_check", "Y");
	 		    		}
	 		 			else
						{
	 		 				strenwrcount++;
						}
	 				}
	 				
	    		}
	 			if(strenwrcount>0)
				{
					hshRecord.put("strenwr_check", "N");
				}
	 			//krishik bhandar begin
				String inward_cbsid="";
				if(rs!=null) rs.close();
				String strQuery24 = SQLParser.getSqlQuery("getprofilestatusfromdemographic^"+strNewid);
				rs = DBUtils.executeQuery(strQuery24);
				if(rs.next())
				{
					inward_cbsid=Helper.correctNull((String)rs.getString("perapp_cbsid"));
					if(rs!=null) rs.close();
					String strQuery25 = SQLParser.getSqlQuery("checksanctionlimitagr^"+inward_cbsid+"^"+strAppno);
					rs = DBUtils.executeQuery(strQuery25);
					if(rs.next())
					{
						hshRecord.put("totalsanctionlimit", Helper.correctNull((String)rs.getString("FACILITY_SANCAMT")));					
					}
					if(rs1!=null) rs1.close();
					String strQuery26 = SQLParser.getSqlQuery("checkproposedamtsum^"+inward_cbsid+"^"+strAppno);
					rs1 = DBUtils.executeQuery(strQuery26);
					if(rs1.next())
					{
						hshRecord.put("totalproposedamt", Helper.correctNull((String)rs1.getString("facility_proposed")));					
					}
					
				}
				
				//krishik bhandar end	
				//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
				
				 double dblchecklimit = 0.0;
				 double dblchecklimit3 = 0.0;
				 String strQuery11="";
				 String strQuery12="";
				 
				 if (strModType.equalsIgnoreCase("AGR")) {
				 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^133");
					rs = DBUtils.executeQuery(strQuery11);
					if (rs.next()) {
						dblchecklimit = Double.parseDouble((String) Helper.correctDouble(rs.getString("LOAN_PARAMVAL")));
					}
					
				 }
				 else if (strModType.equalsIgnoreCase("CORP")) {
					 strQuery11 = SQLParser.getSqlQuery("sel_lapsapplicationparameters^134");
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
				hshRecord.put("strChecklimit", jtn.format(dblchecklimit));
				
				if (rs != null)
					rs.close();
				int pancount=0;
				strQuery = SQLParser.getSqlQuery("getapplicantPAN^" + strAppno+"^"+strAppno);
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
				//exposure limit check for PAN check Except Gold Loan, Deposit Loan, Agriculture, SHG/JLG Borrowers begin 
				
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
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
				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
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
	
	public HashMap getSHGmembershare(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null;
		ResultSet rs1 = null;
		String strAppno="";
		String strFacSno ="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		boolean boolAvail=true;
		String sessionModuleType;
		
		try
		{
			strAppno = correctNull((String)hshValues.get("appno"));
			strFacSno = Helper.correctInt((String)hshValues.get("sel_facilitysno"));
			sessionModuleType = Helper.correctInt((String)hshValues.get("sessionModuleType"));
			
			if(sessionModuleType.equalsIgnoreCase("RET"))
				strQuery = SQLParser.getSqlQuery("sel_loanshare_retail^"+strAppno);
			else
				strQuery = SQLParser.getSqlQuery("sel_loanshare_shg1^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			strQuery = SQLParser.getSqlQuery("sel_loanshare_shg2^"+strAppno+"^"+strFacSno);
			rs1 = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_SNO")));
				arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_CBSID")));
				arrCol.add(Helper.correctNull((String)rs.getString("SHG_MEM_NAME")));
				if(boolAvail && rs1.next())
				{
					arrCol.add(Helper.correctNull((String)rs1.getString("FAC_MEM_SHARE")));
					arrCol.add(Helper.correctNull((String)rs1.getString("FAC_LOAN_TAKEN")));
					arrCol.add(Helper.correctNull((String)rs1.getString("FAC_LOAN_AMT")));
					arrCol.add(Helper.correctNull((String)rs1.getString("FAC_LOAN_BANK")));
				}
				else
				{
					arrCol.add("");
					arrCol.add("s");
					arrCol.add("");
					arrCol.add("s");
					boolAvail = false;
				}
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strFacSno", strFacSno);
			
			if(sessionModuleType.equalsIgnoreCase("RET"))
			{
				if(rs != null)rs.close();
				strQuery = SQLParser.getSqlQuery("selperprdmargin^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("proposedamt", Helper.correctDouble((String)rs.getString("loan_recmdamt")));
				}
				if(rs != null)rs.close();
			}
			else
			{
				if(rs != null)rs.close();
				strQuery = SQLParser.getSqlQuery("sel_proposed_loan_total^"+strAppno+"^"+strFacSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("proposedamt", Helper.correctDouble((String)rs.getString("total_amt")));
				}
				if(rs != null)rs.close();
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getSHGmembershare==>"+e.toString());
		}
		return hshRecord;
	}
	
	public void updateSHGmembershare(HashMap hshValues) 
	{
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String[] strSno = (String[])hshValues.get("txt_sno");
		String[] strLoanShare = (String[])hshValues.get("txt_share");
		String[] strCapacity = (String[])hshValues.get("sel_capacity");
		String[] strLoanAmt = (String[])hshValues.get("txt_loanamt");
		String[] strLoanBank = (String[])hshValues.get("sel_lendingbank");
		
		String strAppno = correctNull((String)hshValues.get("appno"));
		String strFacSno = correctNull((String)hshValues.get("sel_facilitysno"));
		String strAction = correctNull((String)hshValues.get("hidAction"));
		
		int size=0;
		try
		{
			hshQueryValues = new HashMap();
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				size++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_shgmembershare");
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(size), hshQuery);
				
				if(strSno instanceof String[])
				{
					for(int i=0;i<strSno.length;i++)
					{
						size++;
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_shgmembershare");
						arrValues.add(strAppno);
						arrValues.add(strFacSno);
						arrValues.add(strSno[i]);
						arrValues.add(strLoanShare[i]);
						arrValues.add(strCapacity[i]);
						arrValues.add(strLoanAmt[i]);
						arrValues.add(strLoanBank[i]);
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put(String.valueOf(size), hshQuery);
					}
				}
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				size++;
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_shgmembershare");
				arrValues.add(strAppno);
				arrValues.add(strFacSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put(String.valueOf(size), hshQuery);
			}
			
			hshQueryValues.put("size", String.valueOf(size));
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateSHGmembershare==>"+e.toString());
		}
	}
	
	public HashMap updateOPSData(HashMap hshValues)
	{
		
		String strQuery="";
		//String strQuery1="";
		ResultSet rs = null;
		//ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;

		String strAppno="";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		HashMap hshRecord =  new HashMap();
		String strFacHead = "",strSubFacHead = "",strFinStd="0",strIndType="",strIndRating="";
		String strFacility = "",strSubFacility = "",strApp="",strFacCategory="";
		String strFacType ="",strSubProposed="0";
		String strBorrowId = "";
		String strExist = "",strSubExist="",strSno="0",strSubsno="0";
		String strProposed = "",strDesc="",strSubDesc="";
		String	strDiff = "",strAction="",strGroup="0";
		String	strMargin = "",strSubMargin="0",strLoanAmt="0";
		String strLimitId="",strMsg="";
		String strBPLR="",strSubBPLR="";
		String strOutstanding="",strSubOutstanding="";
		String strBranchName="";
		HashMap hshformula =  new HashMap();//mck
		String strInterest="", strSubInterest="";
		String strIntadjust="", strSubIntadjust="";
		String strcbsaccno="",strSubcbsaccno="";
		String strfacilityintremarks="", strsubfacilityintremarks="";
		String strOrglevel="";
        String strissaral="";
        String strOSDate="";
        String strPurpose="",strSubpurpose="";
        String strSolid="";
        int intfacMonths=0;
		int intsubfacMonths=0;
 		int intUpdatesize=0;
		//int j=0;
		boolean booProcess = false,updflag=true;
		StringTokenizer stk = null;
		try
		{
			strBorrowId = correctNull((String)hshValues.get("comapp_id"));
			strAppno = correctNull((String)hshValues.get("appno"));
			strSno = correctNull((String)hshValues.get("selsno"));
			strSubsno = correctNull((String)hshValues.get("selsubsno"));
			strLoanAmt = correctNull((String)hshValues.get("txt_line_credit"));
			strAction = correctNull((String)hshValues.get("hidAction"));
			
			strFacType = correctNull((String)hshValues.get("factype"));
			strFacCategory = correctNull((String)hshValues.get("faccategory"));
			//strAdhocMonths = correctNull((String)hshValues.get("txt_adhocmonths"));
            strBranchName=correctNull((String)hshValues.get("txt_branchname"));
            strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            strissaral=correctNull((String)hshValues.get("strIsSaral"));
            strSolid=correctNull((String)hshValues.get("strSolid"));


            String strModType=correctNull((String)hshValues.get("sessionModuleType"));
			String strFinancialReq="";
			if(strModType.equalsIgnoreCase("AGR")){
				strFinancialReq=correctNull((String)hshValues.get("sel_facilityrequired"));
			}else{
				strFinancialReq="";
			}
			/*if(!strAdhocMonths.trim().equals(""))
			{
				intAdhocMonths = Integer.parseInt(strAdhocMonths);
			}*/
			strAction = strAction.trim();
			strApp = strAppno.trim();
		
			if(strApp.equals("new"))
			{
				String strType="T";
				hshformula.put("comapp_id",strBorrowId);
				hshformula.put("apptype",strType);
				hshformula.put("strSolid",strSolid);
				strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
				hshValues.put("appno",strAppno);			
			}
			else
			{
				hshValues.put("selsno",strSno);		
				hshValues.put("selsubsno",strSubsno);		
			}

			if(strAction.trim().equals("delete"))
			{
				double dblFacAmt=0,dblLoanAmount =0;
				String strFacAmt = correctNull((String)hshValues.get("txt_proposed_limit"));
				if(!strFacAmt.trim().equals(""))
				{
					dblFacAmt = Double.parseDouble(strFacAmt);
				}
				if(!strLoanAmt.trim().equals(""))
				{
					dblLoanAmount = Double.parseDouble(strLoanAmt);
				}
				strLoanAmt = Helper.formatDoubleValue(dblLoanAmount-dblFacAmt);
				booProcess = true;
			}
//			if(!strAction.trim().equals("delete"))
//			{
				if(!strLoanAmt.trim().equals(""))
				{
					rs=DBUtils.executeLAPSQuery("selautolimitid^T^"+strLoanAmt);
					if(rs.next())
					{
						strLimitId =rs.getString(1);
						booProcess = true;
					}
				}
				else
				{
					strLoanAmt="0";
				}
				if(booProcess==true)
				{
					// Starts Updation for applications table
					
					if(strApp.trim().equals("new"))
					{
						hshQuery.put("strQueryId","insapplications");
						intUpdatesize = intUpdatesize+1;
						arrValues.add(strAppno);
						arrValues.add(strLimitId);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
						arrValues.add("T");
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						arrValues.add("A");
						arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add("Y");
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(null);
						arrValues.add(strFinancialReq);
					}
					else
					{
						hshQuery.put("strQueryId","updapplications");
						intUpdatesize = intUpdatesize+1;
						arrValues.add(strLimitId);
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						arrValues.add("A");
						arrValues.add("");
						arrValues.add("");
						arrValues.add("");
						arrValues.add(strFinancialReq);
						arrValues.add(strAppno);
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
					
					//Ends Updation for applications table
					
					if(strApp.trim().equals("new"))
					{
						double dblwoadvamt=0.0;
					// Starts updation for com_demographics table
						if(rs!=null)
							rs.close();
						strQuery=SQLParser.getSqlQuery("selothrparambycode^" + "'WOADV'");
						rs = DBUtils.executeQuery(strQuery);
						if(rs.next()) {
							dblwoadvamt=rs.getDouble("loan_paramval");
						}
						
						if(dblwoadvamt>=Double.parseDouble(strLoanAmt))
							strFinStd=ApplicationParams.getTerCMAWOADV();
						else
							strFinStd=ApplicationParams.getTertiaryCMA();
						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commapplicantloanins2");
						arrValues.add(strAppno);

						if(strBorrowId.trim().equals(""))
						{
							strBorrowId="0";
						}
						arrValues.add(strBorrowId);
						arrValues.add(strFinStd);
						arrValues.add(strIndType);
						arrValues.add(strIndRating);
						arrValues.add("N");
						arrValues.add("");
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					else
					{
//						 Starts updation for com_demographics table
							double dblwoadvamt=0.0;
							if(rs!=null)
								rs.close();
							strQuery=SQLParser.getSqlQuery("selothrparambycode^" + "'WOADV'");
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next()) {
								dblwoadvamt=rs.getDouble("loan_paramval");
							}
							
							if(dblwoadvamt>=Double.parseDouble(strLoanAmt))
								strFinStd=ApplicationParams.getTerCMAWOADV();
							else
								strFinStd=ApplicationParams.getTertiaryCMA();
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							
							hshQuery.put("strQueryId","commapplicantloanupd2");
							
							
							arrValues.add(strFinStd);
							arrValues.add(strAppno);
							arrValues.add("N");
							
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
					}
					// Ends updation for com_demographics table		

					
					/****
					 * For Updating in inward register
					 */
					if(strApp.trim().equals("new"))
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","updinwardappatached");
						arrValues.add("Y");
						arrValues.add("op");
						arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
					}
					else
					{
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
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize = intUpdatesize+1;
							hshQuery.put("strQueryId","updinwardappatached");
							arrValues.add("Y");
							arrValues.add("op");
							arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
						}
					}
				}	
				else
				{
					String strExp="$" + "Proposed Limit not defined in Setup"; 
					throw new Exception(strExp);
				}

					// Starts updation for loandetails table		
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					if(strApp.trim().equals("new"))
					{
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commapplicantloanins3");
						arrValues.add(strAppno);
						arrValues.add("0");
						arrValues.add("0");
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add("0");
						arrValues.add("0");
					}
					else
					{
						hshQuery.put("strQueryId","updloandetails");
						intUpdatesize = intUpdatesize+1;
						String strCollpercent="";
						PerApplicantBean perapp = new PerApplicantBean();
						strCollpercent = perapp.getCollateralpercent(strAppno, strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strLoanAmt);
						arrValues.add(strCollpercent);
						arrValues.add(correctNull((String)hshValues.get("strUserId")));
						arrValues.add(strAppno);
					}
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					if(strApp.trim().equals("new"))
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize = intUpdatesize+1;
						hshQuery.put("strQueryId","commworkflowins");
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
					}
					
			//}
					
	// Ends updation for loandetails table	
	
					strFacHead = correctNull((String) hshValues.get("facility_head"));
					stk = new StringTokenizer(strFacHead,"-");
					if(stk.hasMoreTokens())
					{
						strFacHead = (String)stk.nextToken();
					}

					strFacility =correctNull((String) hshValues.get("facility"));
					stk = new StringTokenizer(strFacility,"-");
					if(stk.hasMoreTokens())
					{
						strFacility = (String)stk.nextToken();
					}


					strSubFacHead = correctNull((String) hshValues.get("subfacility_head"));
					stk = new StringTokenizer(strSubFacHead,"-");
					if(stk.hasMoreTokens())
					{
						strSubFacHead = (String)stk.nextToken();
					}

					strSubFacility =correctNull((String) hshValues.get("subfacility"));
					stk = new StringTokenizer(strSubFacility,"-");
					if(stk.hasMoreTokens())
					{
						strSubFacility = (String)stk.nextToken();
					}
					strDesc = correctNull((String) hshValues.get("txt_desc"));
					strSubDesc  = correctNull((String) hshValues.get("txt_subdesc"));
					strExist = correctNull((String) hshValues.get("txt_exist_limit"));
					strSubExist = correctNull((String) hshValues.get("txt_subexist_limit"));
					strProposed = correctNull((String) hshValues.get("txt_proposed_limit"));
					strSubProposed = correctNull((String) hshValues.get("txt_subproposed_limit"));
					//strIntadjust=correctNull((String) hshValues.get("txt_intadjust"));					
					//strSubIntadjust = correctNull((String) hshValues.get("txt_subintadjust"));
					//strInterest= correctNull((String) hshValues.get("txt_interest"));//mck					
					//strSubInterest= correctNull((String) hshValues.get("txt_subinterest"));//mck
					strMargin= correctNull((String) hshValues.get("txt_margin1"));
					strSubMargin= correctNull((String) hshValues.get("txt_margin2"));                    
                    strBPLR=correctNull((String) hshValues.get("prd_intrate")); 
                    strSubBPLR=correctNull((String) hshValues.get("prd_subintrate"));                     
            		//strOutstanding=correctNull((String) hshValues.get("txt_outstanding"));
            		//strSubOutstanding=correctNull((String) hshValues.get("txt_sub_outstanding")); 
            		//strcbsaccno=correctNull((String) hshValues.get("txt_cbsaccno"));
            		//strSubcbsaccno=correctNull((String) hshValues.get("txt_subcbsaccno"));
            		//strfacilityintremarks=correctNull((String)hshValues.get("txt_intremarks"));
            		//strsubfacilityintremarks=correctNull((String)hshValues.get("txt_subintremarks"));
            		intfacMonths=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_tenor")));
            		intsubfacMonths=Integer.parseInt(Helper.correctInt((String)hshValues.get("txt_subtenor")));
            		strPurpose=correctNull((String)hshValues.get("txt_purpose"));
            		strSubpurpose=correctNull((String)hshValues.get("txt_subpurpose"));
            		strOSDate=correctNull((String) hshValues.get("txt_osdate"));
            		
					if(strFacHead.trim().equals(""))
					{
						strFacHead = "0";
					}
					if(strFacility.trim().equals(""))
					{
						strFacility ="0";
					}
					if(strExist.trim().equals(""))
					{
						strExist ="0";
					}

					if(strProposed.trim().equals(""))
					{
						strProposed ="0";
					}
					/*if(strIntadjust.trim().equals(""))
					{
						strIntadjust ="0";
					}*/
					if(strBPLR.trim().equals(""))
					{
						strBPLR="0";
					}
					/*if(strOutstanding.trim().equals(""))
					{
						strOutstanding="0";
					}*/
					

					if(strFacType.equals("sublimit"))
					{

						if(strGroup.trim().equals(""))
						{
							strGroup="0";
						}
						if(strSubFacHead.trim().equals(""))
						{
							strFacHead = "0";
						}
						else
						{
							strFacHead = strSubFacHead;
						}
						if(strSubFacility.trim().equals(""))
						{
							strFacility ="0";
						}
						else
						{
							strFacility = strSubFacility;
						}
						if(strSubExist.trim().equals(""))
						{
							strExist ="0";
						}
						else
						{
							strExist = strSubExist;
						}

						if(strSubDesc.trim().equals(""))
						{
							strDesc ="";
						}
						else
						{
							strDesc = strSubDesc;
						}
						if(strSubProposed.trim().equals(""))
						{
							strProposed ="0";
						}
						else
						{
							strProposed =strSubProposed;
						}
						/*if(strSubIntadjust.trim().equals(""))
						{
							strIntadjust ="0";
						}
						else
						{
							strIntadjust =strSubIntadjust;
						}*/
						/*if(strSubInterest.trim().equals(""))
						{
							strInterest ="0";
						}
						else
						{
							strInterest =strSubInterest;
						}*/
						if(strSubBPLR.trim().equals(""))
						{
							strBPLR="0";
						}
						else
						{
							strBPLR =strSubBPLR;
						}
						
						if(strSubMargin.trim().equals(""))
						{
							strMargin="0.00";
						}
						else
						{
							strMargin =strSubMargin;
						}
						/*if(strSubOutstanding.trim().equals(""))
						{
							strOutstanding="0.00";
						}
						else
						{
							strOutstanding =strSubOutstanding;
						}*/
						//strcbsaccno=(strcbsaccno.trim().equals("")?"":strSubcbsaccno);
						//strfacilityintremarks=(strsubfacilityintremarks.trim().equals("")?"":strsubfacilityintremarks);
						intfacMonths=intsubfacMonths;
						strPurpose=strSubpurpose;
					}	
					
					double dblFacValue=0.00,dblSelFacValue=0.00,dblSubLimitTot=0.00,dblCurProposed=0.00;

				if(strFacType.trim().equals("sublimit"))
				{
					if(strAction.equals("insert"))
					{
						strGroup = strSno;
					}
					else if(strAction.equals("update"))
					{
						strGroup = strSubsno;
					}
				}
				else if((strFacType.trim().equals("facility")) && (strAction.equals("update")) )
				{
					strGroup = strSno;
				}

				if(!strGroup.trim().equals(""))
				{
					strQuery = SQLParser.getSqlQuery("selfacilityval^"+strAppno +"^"+strGroup);
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblFacValue = rs.getDouble("facility_proposed");
					}
				}

				if(strAction.equals("update"))
				{	
					strQuery = SQLParser.getSqlQuery("selfacilityval^"+strAppno +"^"+strSno);
					
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblSelFacValue = rs.getDouble("facility_proposed");
					}
				}
				else if(strAction.equals("insert"))
				{
			//		dblSelFacValue = Double.parseDouble(strProposed);
				}
				if(!strGroup.trim().equals(""))
				{
					strQuery = SQLParser.getSqlQuery("seltotpropmainlimit^"+strAppno +"^"+strGroup);
					if(rs != null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						dblSubLimitTot = rs.getDouble(1);
					}
				}
				dblCurProposed = Double.parseDouble(strProposed);

				double dblSublimit = 0.00;

		if(strFacType.equals("sublimit")) 
		{
			dblSublimit = ((dblSubLimitTot-dblSelFacValue)+dblCurProposed);
			if( (dblFacValue<dblSublimit) && (!strAction.equals("delete"))  )
			{
		//	strMsg  = "Sum of the sub-limits should not exceed facility limit ";
		//	updflag=false;
			}	 				
		}	 
		else if( (strFacType.equals("facility")) && (strAction.equals("update")))
		{
			if( dblSubLimitTot > dblCurProposed )
			{
	//	strMsg  = "Sum of the sub-limits should not exceed facility limit ";
	//	updflag=false;
			}

		}
				if((strFacType.equals("facility")) && (strAction.equals("update")) )
				{
					strGroup ="0";
				}
		
					if(strBorrowId.trim().equals(""))
					{
						strBorrowId ="0";
					}
							String strBorrowerType="";
							/*strQuery = SQLParser.getSqlQuery("findborrowergroup^"+strBorrowId);
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strBorrowerType =correctNull((String)rs.getString("comapp_group"));
							}*/
						
							double dblBanknetfunds=0.00,dblSingleborrower=0.00,dblGroupborrower=0.00,dblExposureLimit=0.00;
							strQuery = SQLParser.getSqlQuery("selbanknetfunds");
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								dblBanknetfunds = rs.getDouble("net_bankfunds");
								dblSingleborrower = rs.getDouble("net_singleborrexp");
								dblGroupborrower = rs.getDouble("net_groupborrexp");
								if(strBorrowerType.trim().equals(""))
								{
									dblExposureLimit = (dblBanknetfunds * (dblSingleborrower/100));
								}
								else
								{
									dblExposureLimit = (dblBanknetfunds * (dblGroupborrower/100));
								}
								
								dblExposureLimit=dblExposureLimit*10000000.0;
							}

							double dblLoanAmt = Double.parseDouble(strLoanAmt);


						strDiff ="0";
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						if(strAction.equals("update"))
						{
							strQuery = SQLParser.getSqlQuery("checkuniquefacility^"+strAppno +"^"+strFacHead+"^"+strFacility+"^"+strFacCategory);
							if(rs != null)
							{
								rs.close();
							}
							
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								int intExistSno= rs.getInt(1);
								int intSno = Integer.parseInt(strSno);
								if(intSno!=intExistSno)
								{
									updflag=false;
									if(strFacCategory.trim().equals("R"))
									{
										strMsg="Duplication of Main facility will not be allowed";
									}
									else if(strFacCategory.trim().equals("A"))
									{
										strMsg="Duplication of adhoc facility will not be allowed";
									}
								}
							}
								strGroup = strSubsno;								
								hshQuery.put("strQueryId","updfacility");
								arrValues.add(correctNull(strFacHead));
								arrValues.add(correctNull(strFacility));
								arrValues.add(correctNull(strBorrowId));
								arrValues.add(correctNull(strExist));
								arrValues.add(correctNull(strProposed));
								arrValues.add(correctNull(strDiff));
								//arrValues.add(correctNull(strIntadjust));
								arrValues.add(correctNull(strGroup));
								arrValues.add(correctNull(strDesc));
								arrValues.add(correctNull(strFacCategory));
								arrValues.add(correctNull(Integer.toString(intfacMonths)));
								//arrValues.add(correctNull(strInterest));//mck
								arrValues.add(correctNull(strBranchName));
								arrValues.add(correctNull(strMargin));
								arrValues.add(correctNull(strBPLR));//added by suresh for inserting BPLR
								arrValues.add("");
								//arrValues.add(correctNull(strOutstanding));
								arrValues.add("");
								//arrValues.add(correctNull(strcbsaccno));
								//arrValues.add(correctNull(strfacilityintremarks));
								arrValues.add("");
								arrValues.add("");
								arrValues.add("");
								arrValues.add(strPurpose);
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								
							
							if(dblExposureLimit<=dblLoanAmt)
							{
								updflag=false;
								strMsg="Line of credit is more than exposure limit";
							}
							/*********** Added to update Limits Sanctioned/ Declined ***************/
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","updfacilities_undostatus");
							arrValues.add("");
							arrValues.add("op");
							arrValues.add("");
							arrValues.add(strAppno);
							/**************************/
						}
						else if(strAction.equals("insert")||strAction.equals(""))
						{
							strQuery = SQLParser.getSqlQuery("checkuniquefacility^"+strAppno +"^"+strFacHead+"^"+strFacility+"^"+strFacCategory);
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								updflag=true;
								if(strFacCategory.trim().equals("R"))
								{
									//strMsg="Duplication of regular facility will not be allowed";
									strMsg="";
								}
								else if(strFacCategory.trim().equals("A"))
								{
									strMsg="Duplication of adhoc facility will not be allowed";
								}

							}
							if(dblExposureLimit<=dblLoanAmt)
							{
								updflag=false;
								strMsg="Line of credit is more than exposure limit";
							}

 							strGroup = strSno;
							if (strGroup.equals(""))
								strGroup="0";
							strQuery = SQLParser.getSqlQuery("maxfacilitysno^"+strAppno);
							
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								strSno =rs.getString(1);
							}

							hshQuery.put("strQueryId","insfacility");								
							arrValues.add(correctNull(strAppno));
							arrValues.add(correctNull(strFacHead));
							arrValues.add(correctNull(strFacility));
							arrValues.add(correctNull(strBorrowId));
							arrValues.add(correctNull(strExist));
							arrValues.add(correctNull(strProposed));
							arrValues.add(correctNull(strDiff));
							//arrValues.add(correctNull(strIntadjust));
							arrValues.add(correctNull(strSno));
							arrValues.add(correctNull(strGroup));
							arrValues.add(correctNull(strDesc));
							arrValues.add(correctNull(strFacCategory));
							arrValues.add(correctNull(Integer.toString(intfacMonths)));	
							//arrValues.add(correctNull(strInterest));
							arrValues.add(correctNull(strBranchName));
							arrValues.add(correctNull(strMargin));
							arrValues.add(correctNull(strBPLR));
							arrValues.add(correctNull(""));
							//arrValues.add(correctNull(strOutstanding));
							arrValues.add(correctNull(""));
							//arrValues.add(correctNull(strcbsaccno));
							//arrValues.add(correctNull(strfacilityintremarks));
							
							arrValues.add(correctNull(""));
							arrValues.add(correctNull(""));
							arrValues.add((""));
							arrValues.add(strPurpose);
							
						}
						else if(strAction.equals("delete"))
						{
	
							strQuery = SQLParser.getSqlQuery("delfacilitysno^"+strAppno +"^"+strSno);
							
							if(rs != null)
							{
								rs.close();
							}
							rs = DBUtils.executeQuery(strQuery);
							if(rs.next())
							{
								
								updflag=false;
								strMsg="You can't delete the facility, sub-limit exists";
							}
							else
							{
								
								hshQuery.put("strQueryId","delfacility");
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
							}
						}
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						
						/*
						 * Added for updating the interest and margin amount in the facility table
						 * since it will differ according to total proposed amount. 
						 */
						/*if(!strLimitId.equalsIgnoreCase(""))
						{
							if(rs2!=null)
								rs2.close();
							strQuery=SQLParser.getSqlQuery("selIntdata^"+strLimitId+"^fixed");
							rs2=DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								strInterest=correctNull(rs2.getString("prd_interest"));
							}
							
							if(rs2!=null)
								rs2.close();
							strQuery=SQLParser.getSqlQuery("selMarginlist^"+strLimitId+"^1");
							rs2=DBUtils.executeQuery(strQuery);
							if(rs2.next())
							{
								strMargin=correctNull(rs2.getString("margin_perct"));
							}
							//hshQueryValues=new HashMap();
							arrValues=new ArrayList();
							hshQuery=new HashMap();
							
							hshQuery.put("strQueryId","updFacIntMargin");
							intUpdatesize++;
							arrValues.add(correctNull(strMargin));
							arrValues.add(correctNull(strInterest));
							arrValues.add(correctNull(strAppno));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}	*/
						//End of Margin & Interest Updation
						
						if(rs2!=null)
							rs2.close();
						rs2=DBUtils.executeLAPSQuery("seltermsmaster^"+strFacHead +"^"+strFacility);
						String strTermsType="P",strParentid="",strMode="",strPrePost="";
						String strTermsDel="N",strTerms="",strTermsno="";

						while(rs2.next())
						{
							strTermsno = rs2.getString("fac_sno");
							strTerms = rs2.getString("fac_terms");
							strMode= rs2.getString("fac_mode");
							strPrePost=rs2.getString("fac_prepost");
							strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
							strQuery = SQLParser.getSqlQuery("checkfacterms^"+strAppno+"^"+strSno+"^"+strTermsno);
							
							if(rs3 != null)
							{
								rs3.close();
							}
							rs3 = DBUtils.executeQuery(strQuery);
							intUpdatesize = intUpdatesize+1;
							hshQuery = new HashMap();
							arrValues=new ArrayList();

							if(rs3.next())
							{

								hshQuery.put("strQueryId","updfacterms");
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(correctNull(strAppno));
								//arrValues.add(correctNull(strFacHead));
								//arrValues.add(correctNull(strFacility));
								arrValues.add(correctNull(strSno));
								arrValues.add(strTermsno);
							}
							else
							{
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								intUpdatesize = intUpdatesize+1;
								hshQuery.put("strQueryId","insfacterms");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacHead));
								//arrValues.add(correctNull(strFacility));
								arrValues.add(correctNull(""));
								arrValues.add(correctNull("strModType"));
								arrValues.add(strTermsno);
								arrValues.add(correctNull(strTerms));
								arrValues.add(correctNull(strTermsType));
								arrValues.add(correctNull(strTermsDel));
								arrValues.add(" ");
								arrValues.add("N");
								arrValues.add(strPrePost);
								arrValues.add(strMode);
								arrValues.add(strParentid);
								
							}
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							

						}


						/*strQuery = SQLParser.getSqlQuery("seldocmaster^"+strFacHead +"^"+strFacility+"^"+strBorrowId);//mck
						
						rs4 = DBUtils.executeQuery(strQuery);
						String strDocType="";
						String strDocDel="N",strDocNature="P",strDocsno="";

						while(rs4.next())
						{
							
							strDocsno = rs4.getString("fac_doccode");							
							strDocType = rs4.getString("fac_doctype");						
							strDocConst=rs4.getString("fac_constitution");//mck

							strQuery1 = SQLParser.getSqlQuery("checkfacdoc^"+strAppno+"^"+strSno+"^"+strDocsno+"^"+strDocConst);//mck
							
							if(rs5 != null)
							{
								rs5.close();
							}
							rs5 = DBUtils.executeQuery(strQuery1);

							intUpdatesize = intUpdatesize+1;
							hshQuery = new HashMap();
							arrValues=new ArrayList();

							if(rs5.next())
							{
								hshQuery.put("strQueryId","updfacdocs");
								arrValues.add(correctNull(strDocType));
								arrValues.add(correctNull(strDocNature));
								arrValues.add(correctNull(strDocDel));
								arrValues.add(" ");
								arrValues.add(correctNull(strAppno));
								//arrValues.add(correctNull(strFacHead));
								//arrValues.add(correctNull(strFacility));
								arrValues.add(correctNull(strSno));
								arrValues.add(strDocsno);
								arrValues.add(strDocConst);//mck
							}
							else
							{
								hshQuery.put("strQueryId","insfacdocs");								
								arrValues.add(correctNull(strAppno));
								arrValues.add(correctNull(strSno));
								//arrValues.add(correctNull(strFacHead));
								//arrValues.add(correctNull(strFacility));
								arrValues.add(strDocsno);
								arrValues.add(correctNull(strDocType));
								arrValues.add(correctNull(strDocNature));
								arrValues.add(correctNull(strDocDel));
								arrValues.add(" ");
								arrValues.add(strDocConst);//mck
							}
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
						}*/

				if(updflag==true)
				{
					if(!strAction.equals("delete"))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","upd_facasondate");
						arrValues.add(correctNull(strOSDate));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				/**
				 * Added by venu for getting financial information
				 
				  setLoanDetails(hshValues);
				*
				 * end
				 */
				
				hshRecord = getOPSFacilityData(hshValues);
				hshRecord.put("msg",strMsg);
				hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));	
				
				String strAppval = correctNull((String)hshValues.get("appval"));
				String strAppFlag = correctNull((String)hshValues.get("appflag"));
				//String strAppMangflag = correctNull((String)hshValues.get("appMangflag"));
				String strAppGroupflag = correctNull((String)hshValues.get("appGroupflag"));
//				-----This Below Coding is Fetch Check Whether to Fetch Details from Financial , Group Company
				//----- or Organisation from Previous Application
				
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				if((!strAppval.equalsIgnoreCase("")) && (!strAppFlag.equalsIgnoreCase("on")))
				{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");	
						hshQuery.put("strQueryId","updfacexeappno");
						arrValues.add(correctNull(strAppval));
						arrValues.add(correctNull(strAppFlag));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

						hshRecord.put("appval",strAppval);
				}
				
				/*if((!strAppval.equalsIgnoreCase("")) && (!strAppMangflag.equalsIgnoreCase("on")))
				{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");	
						hshQuery.put("strQueryId","updfmangexecappno");
						arrValues.add(correctNull(strAppval));
						arrValues.add(correctNull(strAppMangflag));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}*/
				
				if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
				{					
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");	
						hshQuery.put("strQueryId","updfgroupexecappno");
						arrValues.add(correctNull(strAppval));
						arrValues.add(correctNull(strAppGroupflag));
						arrValues.add(correctNull(strAppno));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				

				
				
				StringBuilder sbAt = new StringBuilder();
				if(!strAction.equals("delete")){
				String strCategory=correctNull((String)hshValues.get("faccategory"));
				if(strCategory.equals("R"))strCategory="Main Limit";
				if(strCategory.equals("A"))strCategory="Adhoc";
				sbAt.append("Limit =").append(strCategory);
				if(strCategory.equals("Adhoc"))
				sbAt.append("~ No of Months =").append(correctNull((String)hshValues.get("txt_adhocmonths")));
				sbAt.append(" ~ Facility Head =").append(correctNull((String)hshValues.get("hid_facility_head")));
				sbAt.append(" ~Facility  =").append(correctNull((String)hshValues.get("hid_facility")));
				sbAt.append(" ~Existing Limit  =").append(correctNull((String)hshValues.get("txt_exist_limit")));
				sbAt.append(" ~Proposed Limit  =").append(correctNull((String)hshValues.get("txt_proposed_limit")));
				sbAt.append(" ~Interest/ Discount/ Commission (%)  =").append(correctNull((String)hshValues.get("txt_interest")));
				sbAt.append(" ~Outstanding =").append(correctNull((String)hshValues.get("txt_outstanding")));
				//sbAt.append(" ~Margin (%) =").append(correctNull((String)hshValues.get("txt_margin1")));
				sbAt.append(" ~ Purpose =").append(Helper.correctNull((String)hshValues.get("txt_purpose")));
				sbAt.append(" ~ Tenor(in Months) =").append(Helper.correctNull((String)hshValues.get("txt_tenor")));
				//sbAt.append(" ~CBS Account Number =").append(correctNull((String)hshValues.get("txt_cbsaccno")));
				if((correctNull((String)hshValues.get("checkbox")).equals("checkbox")? "Y":"N").equals("Y"))
				{
				sbAt.append(" ~Sub - Limits=").append(correctNull((String)hshValues.get("checkbox")).equals("checkbox")? "Y":"N");
				sbAt.append(" ~ Sub-Limit Head=").append(correctNull((String)hshValues.get("hid_subfacility_head")));
				sbAt.append(" ~ Sub-Limit =").append(correctNull((String)hshValues.get("hid_subfacility")));
				sbAt.append(" ~Existing Limit  =").append(correctNull((String)hshValues.get("txt_subexist_limit")));
				sbAt.append(" ~Proposed Limit  =").append(correctNull((String)hshValues.get("txt_subproposed_limit")));
				sbAt.append(" ~Interest/ Discount/ Commission (%)  =").append(correctNull((String)hshValues.get("txt_subinterest")));
			    sbAt.append(" ~Outstanding =").append(correctNull((String)hshValues.get("txt_sub_outstanding")));
				//sbAt.append(" ~Margin (%) =").append(correctNull((String)hshValues.get("txt_margin2")));
				sbAt.append(" ~ Purpose =").append(Helper.correctNull((String)hshValues.get("txt_subpurpose")));
				sbAt.append(" ~ Tenor(in Months) =").append(Helper.correctNull((String)hshValues.get("txt_subtenor")));
				//sbAt.append(" ~CBS Account Number =").append(correctNull((String)hshValues.get("txt_subcbsaccno")));
				}
				}
				if(correctNull((String)hshValues.get("hidAction")).equals(""))hshValues.put("hidAction","insert");
				if(correctNull((String)hshValues.get("hidAction")).equals("delete"))
				{
				if(updflag==true)
				{
				AuditTrial.auditLog(hshValues,"167",strAppno,sbAt.toString());
				}
				}
				else
				{
					AuditTrial.auditLog(hshValues,"167",strAppno,sbAt.toString());
				}
				
				
				//----------------End of New Commerical
				

				return hshRecord;
		}
		catch(Exception ce)
		{
			ce.printStackTrace();
			throw new EJBException("inside update"+ce.toString());
		}
		
		finally
		{
			try
			{

				if(rs != null)
				{
					rs.close();
				}
				/*if(rs1 != null)
				{
					rs1.close();
				}*/
			

				if(rs2 != null)
				{
					rs2.close();
				}
				if(rs3 != null)
				{
					rs3.close();
				}
				if(rs4!= null)
				{
					rs4.close();
				}
				if(rs5 != null)
				{
					rs5.close();
				}


			}
			catch(Exception cf)
			{
				cf.printStackTrace();
				throw new EJBException("Error closing the connection "+cf.getMessage());
						
			}
		}
	}
	
	public HashMap getOPSFacilityData(HashMap hshValues)
	{
		String strQuery="";
		String strQuery1="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		
		HashMap hshRecord = new HashMap();
		String Id = correctNull((String)hshValues.get("comapp_id"));
		if(Id.equalsIgnoreCase(""))
		{
			Id = correctNull((String)hshValues.get("comappid"));
		}
		if(Id.equalsIgnoreCase(""))
		{
			Id=correctNull((String)hshValues.get("hidapplicantid"));
		}
		String strOldID = "";
		ArrayList vecData = new ArrayList();
		String strAppno="",strFacCategory="";
		ArrayList vecVal=null;
		StringTokenizer stk = null;
		HashMap hshformula =  new HashMap();//mck
		String strAction="",strFacType="";
		double dblLC =0.00;
		double dblExist=0.00,dblProposed=0.00,dblDiff=0.00,dblTotDiff=0.00,dblTotExist=0.00;
		String strBorrowDesc="",strBorrowId="",strSelsno="",strSelsubsno="",strAdhocMonths="";		//, strbranchname="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();	
		try
		{
			
			strAppno = correctNull((String)hshValues.get("appno"));
			strSelsno = correctNull((String)hshValues.get("selsno"));
			strSelsubsno = correctNull((String)hshValues.get("selsubsno"));
			strFacCategory = correctNull((String)hshValues.get("faccategory"));
			strAdhocMonths = correctNull((String)hshValues.get("txt_adhocmonths"));
					
			String strAppval = correctNull((String)hshValues.get("strAppval"));
			String strchkFinancial=correctNull((String)hshValues.get("chkFin"));
			String strAppFlag = correctNull((String)hshValues.get("strAppFlag"));
			String strAppSecurity = correctNull((String)hshValues.get("strAppSecurity"));
			String strAppGroupflag = correctNull((String)hshValues.get("strAppGroupflag"));
			String strchkApp=correctNull((String)hshValues.get("strchkApp"));
			String strchkCoApp=correctNull((String)hshValues.get("chkCoApp"));
			
			String strExecappno=correctNull((String)hshValues.get("txtSearch"));
			String strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
            String strissaral=correctNull((String)hshValues.get("strIsSaral"));
            String strInwardno=correctNull((String)hshValues.get("txt_appinwardno"));
            String strSolid=correctNull((String)hshValues.get("strSolid"));
            String strModType=correctNull((String)hshValues.get("sessionModuleType"));
			String strFinancialReq="";
			if(strModType.equalsIgnoreCase("AGR")){
				strFinancialReq=correctNull((String)hshValues.get("sel_facilityrequired"));
			}else{
				strFinancialReq="";
			}
            
            //Get Old applicant id
            strQuery1 = SQLParser.getSqlQuery("sel_oldappid^" + Id);
            rs1 = DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				strOldID = correctNull((String)rs1.getString("perapp_oldid"));
			}
            //Application Number check
			
			String strAppNumber = correctNull((String)hshValues.get("txtSearch"));
			strQuery1 = SQLParser.getSqlQuery("selopsappid^" + strOldID);
			if(rs1!=null)
			rs1.close();
				
			// count=0;
			String  strCountcheck="";
			rs1 = DBUtils.executeQuery(strQuery1);
			while(rs1.next())
			{
				String strcheckappno=correctNull((String)rs1.getString("facility_appno"));
				if(strAppNumber .equalsIgnoreCase(strcheckappno))
				{
					strCountcheck="Yes";
				}
			}
			String strCountcheck6="";
			if(!strAppNumber.equalsIgnoreCase(""))
			{
			   if(strCountcheck.equalsIgnoreCase(""))
			    {
					strCountcheck6="Yes";
					hshRecord.put("strCountcheck",strCountcheck6);
			    }
			}
			
			if(!strCountcheck6.equalsIgnoreCase("Yes"))
			{
				if(strAppno.equalsIgnoreCase("new") && !strExecappno.equalsIgnoreCase(""))
				{
					String strType="T";//mck
					hshformula.put("comapp_id",Id);//mck
					hshformula.put("apptype",strType);//mck
					hshformula.put("strSolid",strSolid);//mck
					strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshformula,"getAppno");
					hshValues.put("appno",strAppno);			
				}
				if(!strExecappno.equalsIgnoreCase("") && !strAppno.equalsIgnoreCase(""))
				{
					
					hshQueryValues=new HashMap();	
					String demo_comappid="0";
					String demo_finstandard="0";
					String demo_industrycode="0";
					String demo_indrating="0";
					
					int intUpdatesize=0;
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
							
					strQuery1 = SQLParser.getSqlQuery("sel_applications^" + strExecappno);
					rs = DBUtils.executeQuery(strQuery1);
					String strPrdCode="";
					
					while(rs.next())
					{
						strPrdCode=correctNull((String)rs.getString("app_prdcode"));
					}
					
					intUpdatesize = intUpdatesize+1;
					
					arrValues.add(strAppno);
					arrValues.add(strPrdCode);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
					arrValues.add("T");
					arrValues.add(strInwardno);
					arrValues.add("A");
					arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
					arrValues.add(correctNull((String)hshValues.get("strUserId")));
					arrValues.add("Y");
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(null);
					arrValues.add(strFinancialReq);
					hshQuery.put("strQueryId","insapplications");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					strQuery1 = SQLParser.getSqlQuery("get_comdemographics^" + strExecappno);
					rs = DBUtils.executeQuery(strQuery1);
					while(rs.next())
					{
						demo_comappid=correctNull((String)rs.getString("demo_comappid"));
						demo_finstandard=Helper.correctInt((String)rs.getString("demo_finstandard"));
						demo_industrycode=correctNull((String)rs.getString("demo_industrycode"));
						demo_indrating=correctNull((String)rs.getString("demo_indrating"));
					}
					hshQuery.put("strQueryId","commapplicantloanins2");
					arrValues.add(strAppno);
					arrValues.add(demo_comappid);
					arrValues.add(demo_finstandard);
					arrValues.add(demo_industrycode);
					arrValues.add(demo_indrating);
					arrValues.add("N");
					arrValues.add("");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					strQuery1 = SQLParser.getSqlQuery("sel_loandetails^" + strExecappno);
					rs = DBUtils.executeQuery(strQuery1);
					String loan_modintrate="0", loan_terms="0",loan_amtreqd="0", loan_costloanprd="0", loan_recmdamt="0",loan_downpay="0",loan_appamt="";
					while(rs.next())
					{
						loan_modintrate=correctNull(rs.getString("loan_modintrate"));
						loan_terms=correctNull(rs.getString("loan_terms"));
						loan_amtreqd=correctNull(rs.getString("loan_amtreqd"));
						loan_costloanprd=correctNull(rs.getString("loan_costloanprd")); 
						loan_recmdamt=correctNull(rs.getString("loan_recmdamt"));
						loan_downpay=correctNull(rs.getString("loan_downpay"));
						loan_appamt=correctNull(rs.getString("loan_appamt"));
					}
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","commapplicantloanins3");
					arrValues.add(strAppno);
					arrValues.add(loan_modintrate);
					arrValues.add(loan_terms);
					arrValues.add(loan_amtreqd);
					arrValues.add(loan_costloanprd);
					arrValues.add(loan_recmdamt);
					arrValues.add(loan_downpay);
					arrValues.add(loan_appamt);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","commworkflowins");
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
					
					
					
					
					/*hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					arrValues.add(strAppno);
					hshQuery.put("strQueryId","inscomproposal");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);*/
					
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","updinwardappatached");
					arrValues.add("Y");
					arrValues.add("op");
					arrValues.add(correctNull((String) hshValues.get("txt_appinwardno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					if((!strAppval.equalsIgnoreCase("")) && (!strchkApp.equalsIgnoreCase("on")))
					{
						hshQuery = new HashMap();
						hshQuery.put("appno",strAppno);
						hshQuery.put("execappno",strExecappno);
						setFacilityDetails(hshQuery);
					}
					if((!strAppval.equalsIgnoreCase("")) && (!strAppSecurity.equalsIgnoreCase("on")))
					{
						hshQuery = new HashMap();
						hshQuery.put("appno",strAppno);
						hshQuery.put("execappno",strExecappno);
						setSecurityDetails(hshQuery);
					}
					
					if((!strAppval.equalsIgnoreCase("")) && (strchkCoApp.equalsIgnoreCase("Y")))
					{
						hshQuery = new HashMap();
						hshQuery.put("appno",strAppno);
						hshQuery.put("execappno",strExecappno);
						setTertiaryPromoterDetails(hshQuery);
					}
					
					
				}
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				/*
				 * For getting the values of old financials to new application financials
				 */
				if((!strAppval.equalsIgnoreCase("")) && (!strAppFlag.equalsIgnoreCase("on")))
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","updfacexeappno");
					arrValues.add(correctNull(strAppval));
					arrValues.add(correctNull(strAppFlag));
					arrValues.add(correctNull(strAppno));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					
					hshRecord.put("appval",strAppval);
				}
				if((!strAppval.equalsIgnoreCase("")) && (!strAppGroupflag.equalsIgnoreCase("on")))
				{					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");	
					hshQuery.put("strQueryId","updfgroupexecappno");
					arrValues.add(correctNull(strAppval));
					arrValues.add(correctNull(strAppGroupflag));
					arrValues.add(correctNull(strAppno));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				/*
				 * Added by suresh & venu for copying the finnancial while copying the facility detai itself
				 */
				if((!strAppval.equalsIgnoreCase("")) && (strchkFinancial.equalsIgnoreCase("Y")))
				{
					hshQuery = new HashMap();
					hshQuery.put("appno",strAppno);
					setLoanDetails(hshQuery);
				}
				/*
				 * End of Financial copy
				 */
			}
			if(strSelsubsno.trim().equals(""))
			{
				strSelsubsno="0";
			}
			strFacType = correctNull((String)hshValues.get("factype"));
	
 			if(!strAppno.trim().equals("new")) 
			{

 			if(strAction.trim().equals("update"))
			{
 			}
			else
			{
			//	strSelsno="";

				String strFacHead = correctNull((String) hshValues.get("facility_head_id_code"));
				/*stk = new StringTokenizer(strFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strFacHead = (String)stk.nextToken();
				}*/
				String strFacility =correctNull((String) hshValues.get("facility_id_code"));
				/*stk = new StringTokenizer(strFacility,"-");
				if(stk.hasMoreTokens())
				{
					strFacility = (String)stk.nextToken();
				}*/

				String strSubFacHead = correctNull((String) hshValues.get("subfacility_head"));
				stk = new StringTokenizer(strSubFacHead,"-");
				if(stk.hasMoreTokens())
				{
					strSubFacHead = (String)stk.nextToken();
				}

				String strSubFacility =correctNull((String) hshValues.get("subfacility"));
				stk = new StringTokenizer(strSubFacility,"-");
				if(stk.hasMoreTokens())
				{
					strSubFacility = (String)stk.nextToken();
				}
			}

			int	intGroup =0;
				
			strQuery = SQLParser.getSqlQuery("selopsfacilitylist^" + strAppno +"^"+intGroup);
					
			if(rs != null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			dblExist=0.00;
			dblProposed=0.00;
			dblDiff=0.00;
			int lngGrpSize = 0;
			//double dblPreExist=0.00,dblPreProposed=0.00;
			//ArrayList arrSubGrp = new ArrayList();
			String strExist="",strProposed="";
			while(rs.next())
			{	
				intGroup = rs.getInt("facility_sno");
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("facility_headid")));
				vecVal.add(correctNull(rs.getString("facheaddesc")));
				vecVal.add(correctNull(rs.getString("facility_id")));
				vecVal.add(correctNull(rs.getString("facdesc")));
				strBorrowId = correctNull(rs.getString("borrower_id"));
				vecVal.add(strBorrowId);
				vecVal.add(correctNull(rs.getString("facility_date")));
				
				dblExist =rs.getDouble("facility_existing");
				dblProposed =rs.getDouble("facility_proposed");
				dblTotExist  = dblTotExist + dblExist;
				dblDiff = dblProposed - dblExist;
				dblTotDiff  = dblTotDiff + dblDiff;
				strExist = Helper.formatDoubleValue(dblExist);
				strProposed = Helper.formatDoubleValue(dblProposed);
				String strDiff = Helper.formatDoubleValue(dblDiff);
				
				vecVal.add(strExist);
				vecVal.add(strProposed);
				vecVal.add(strDiff);
				vecVal.add(correctNull(rs.getString("facility_intadjustment")));				
				vecVal.add(correctNull(rs.getString("facility_sno")));
				vecVal.add(correctNull((String)rs.getString("facility_group")));
				vecVal.add(correctNull((String)rs.getString("facility_category")));
				vecVal.add(correctNull((String)rs.getString("facility_months")));
				vecVal.add(correctNull(rs.getString("facility_interest")));  
				vecVal.add(correctNull(rs.getString("facility_margin")));
				vecVal.add(correctNull((String)rs.getString("BPLR")));					
				vecVal.add(correctNull((String)rs.getString("facility_outstanding")));
				vecVal.add(correctNull((String)rs.getString("cbs_accountno")));
				//vecVal.add(Integer.toString(lngGrpSize));==
				//vecVal.add(arrSubGrp);
				vecVal.add(correctNull((String)rs.getString("facility_purpose")));
				vecData.add(vecVal);			
				strBorrowDesc =correctNull(rs.getString("perapp_fname"));
				hshRecord.put("asondate",correctNull((String)rs.getString("facility_osason")));
				if(!strProposed.trim().equals(""))
				{
					dblLC =  dblLC + Double.parseDouble(strProposed);
				}
				strQuery1 = SQLParser.getSqlQuery("selopsfacilitylist^" + strAppno+"^"+intGroup);
			
				if(rs1 != null)
				{
					rs1.close();
				}
				rs1 = DBUtils.executeQuery(strQuery1);
				
				while(rs1.next())
				{
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs1.getString("facility_headid")));
					vecVal.add(correctNull(rs1.getString("facheaddesc")));
					vecVal.add(correctNull(rs1.getString("facility_id")));
					vecVal.add(correctNull(rs1.getString("facdesc")));
					strBorrowId = correctNull(rs1.getString("borrower_id"));
					vecVal.add(strBorrowId);
					vecVal.add(correctNull(rs1.getString("facility_date")));
					dblExist =rs1.getDouble("facility_existing");
					dblProposed =rs1.getDouble("facility_proposed");
					strExist = Helper.formatDoubleValue(dblExist);
					dblDiff = dblProposed - dblExist;
					strProposed = Helper.formatDoubleValue(dblProposed);
					strDiff = Helper.formatDoubleValue(dblDiff);
					vecVal.add(strExist);
					vecVal.add(strProposed);
					vecVal.add(strDiff);
					vecVal.add(correctNull(rs1.getString("facility_intadjustment")));
					vecVal.add(correctNull(rs1.getString("facility_sno")));
					vecVal.add(correctNull((String)rs1.getString("facility_group")));
					vecVal.add(correctNull((String)rs1.getString("facility_category")));
					vecVal.add(correctNull((String)rs1.getString("facility_months")));					
					vecVal.add(correctNull(rs1.getString("facility_interest")));
					vecVal.add(correctNull(rs1.getString("facility_margin")));
					vecVal.add(correctNull((String)rs1.getString("BPLR")));
					vecVal.add(correctNull((String)rs1.getString("facility_outstanding")));
					vecVal.add(correctNull((String)rs1.getString("cbs_accountno")));
					//vecVal.add(Integer.toString(lngGrpSize));
					//vecVal.add(arrSubGrp);
					vecVal.add(correctNull((String)rs1.getString("facility_purpose")));
					vecData.add(vecVal);			
					strBorrowDesc =correctNull(rs1.getString("perapp_fname"));
				}
			}
			
			HashMap hshAppData = new HashMap();
			hshAppData.put("appno", strAppno);
			hshAppData = (HashMap) EJBInvoker.executeStateLess("appeditlock", hshAppData, "getAppData");
			hshRecord.put("hshAppData", hshAppData);	
			
			if(rs!=null)
				rs.close();
			
			strQuery = SQLParser.getSqlQuery("selinwardnorequired^"+strAppno+"^<");
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("inwardnorequired",correctNull(rs.getString("output")));
			}
		}
		hshRecord.put("borrowid",strBorrowId);
		hshRecord.put("borrowdesc",strBorrowDesc);
		hshRecord.put("hidAction",strAction);
		hshRecord.put("appno",strAppno);
		hshRecord.put("selsno",strSelsno);
		hshRecord.put("selsubsno",strSelsubsno);
		hshRecord.put("factype",strFacType);
		hshRecord.put("faccategory",strFacCategory);
		hshRecord.put("lc",Helper.formatDoubleValue(dblLC));
		hshRecord.put("totexist",Helper.formatDoubleValue(dblTotExist));
		hshRecord.put("totdiff",Helper.formatDoubleValue(dblTotDiff));
		//hshRecord.put("facbranchname",strbranchname);	
		hshRecord.put("vecData",vecData);

			
		hshRecord.put("comapp_id",correctNull((String)hshValues.get("comapp_id")));
		hshRecord.put("hidCategoryType",correctNull((String)hshValues.get("cattype")));
		hshRecord.put("hidSSIType",correctNull((String)hshValues.get("hidSSIType")));	
		
			
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
	return hshRecord;
}
	
	private HashMap updatePreviousYearRating(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		String Exappno=correctNull((String)hshValues.get("Exappno"));
		String Presentappno=correctNull((String)hshValues.get("presentAppno"));
		String previousrate="";
		String previousdate="";
		ResultSet rs=null;
		try
		{
		if(rs!=null)
		{
			rs.close();
		}
		rs=DBUtils.executeLAPSQuery("ramtolaps_newreport106^"+Exappno);
		if(rs.next())
		{
			previousrate=correctNull((String)rs.getString("CreditRatingbyRatingPool"));
			previousdate=correctNull((String)rs.getString("RatingPoolDate"));
		}
		if(!Exappno.equals(""))
		{
			HashMap hshPreviousValues=new HashMap();
			HashMap hshPreviousQuery=new HashMap();
			ArrayList arrPrevious=new ArrayList();
			hshPreviousQuery.put("strQueryId","inspreviouscreditrating");
			arrPrevious.add(Presentappno);
			arrPrevious.add("1322");//Here I have given temp no. resolving not null problem in db
			arrPrevious.add(previousdate);
			arrPrevious.add(previousrate);
			arrPrevious.add(Exappno);
			hshPreviousQuery.put("arrValues",arrPrevious);
			hshPreviousValues.put("1",hshPreviousQuery);
			hshPreviousValues.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshPreviousValues,"updateData");
		}
		}catch(Exception e)
		{
			throw new EJBException("Error in updatePreviousYearRating:--"+e.getMessage());
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
				throw new EJBException("Error while Closing Connection in updatePreviousYearRating:--"+e.getMessage());
			}
		}
		
		return hshResult;
		
	}
	
	private void setLoanDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intUpdatesize=0;
		String strAppno=correctNull((String)hshValues.get("appno"));
		//String strCopyingAppno=correctNull((String)hshValues.get("txtSearch"));
		String strExeappno="";
		String strFincheck="";
		String strQuery3="";
		
		try
		{
			
			rs=null;		
			strQuery3 = SQLParser.getSqlQuery("selfacexeappno^"+strAppno);
			rs = DBUtils.executeQuery(strQuery3);
				if(rs.next())
				{
					strExeappno=correctNull((String)rs.getString("exeappno"));
					strFincheck=correctNull((String)rs.getString("fincheck"));
				if((!strExeappno.equalsIgnoreCase(""))&&(!strFincheck.equalsIgnoreCase("")) )
				{
					
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				arrValues.add(strAppno);
				arrValues.add(strExeappno);
				hshQuery.put("strQueryId","com_copyFinancial1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				arrValues.add(strAppno);
				arrValues.add(strExeappno);
				hshQuery.put("strQueryId","com_copyFinancial2");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
			}
										
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in setLoanDetails..."+e.toString());
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
	private void setTertiaryPromoterDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		try{
			
			String strExecappno=correctNull((String)hshValues.get("execappno"));
			String strAppno=correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("copyexisting_promoters_tertiary^" + strExecappno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)rs.getString("demo_comappid")));
				arrValues.add(correctNull((String)rs.getString("demo_finstandard")));
				arrValues.add(correctNull((String)rs.getString("demo_industrycode")));
				arrValues.add(correctNull((String)rs.getString("demo_indrating")));
				arrValues.add(correctNull((String)rs.getString("demo_apptype")));
				arrValues.add(correctNull((String)rs.getString("demo_finmodel")));
				hshQuery.put("strQueryId","insertexisting_promoters_tertiary");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in setTertiaryPromoterDetails..."+e.toString());
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
	private void setSecurityDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		
		try{
			String strExecappno=correctNull((String)hshValues.get("execappno"));
			String strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery = SQLParser.getSqlQuery("fac_security_details_copy^" + strExecappno);
			rs = DBUtils.executeQuery(strQuery);
	
			while(rs.next())
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
		
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)rs.getString("sec_srlno")));
				arrValues.add(correctNull((String)rs.getString("sec_no")));
				arrValues.add(correctNull((String)rs.getString("sec_desc_id")));
				arrValues.add(correctNull((String)rs.getString("sec_desc_details")));
				arrValues.add(correctNull((String)rs.getString("sec_desc_value")));
				arrValues.add(correctNull((String)rs.getString("sec_desc_as_on_date")));
				arrValues.add(correctNull((String)rs.getString("sec_tenor")));
				arrValues.add(correctNull((String)rs.getString("sec_type")));
				arrValues.add(correctNull((String)rs.getString("sec_valuersname")));
				arrValues.add(correctNull((String)rs.getString("sec_insuranceamt")));
				arrValues.add(correctNull((String)rs.getString("sec_insexpirydate")));
				arrValues.add(correctNull((String)rs.getString("sec_remarks")));
				arrValues.add(correctNull((String)rs.getString("sec_facsno")));
				arrValues.add(correctNull((String)rs.getString("sec_margin")));
				arrValues.add(correctNull((String)rs.getString("sec_charge")));
				arrValues.add(correctNull((String)rs.getString("sec_ownedby")));
				arrValues.add(correctNull((String)rs.getString("sec_legalopinion")));
				
				hshQuery.put("strQueryId","inssecuritydetails");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
			
			
				
		}
		catch(Exception e)
		{
			throw new EJBException("Error in setSecurityDetails..."+e.toString());
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
	private void setCorporatePromoterDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		try{
			
			String strExecappno=correctNull((String)hshValues.get("execappno"));
			String strAppno=correctNull((String)hshValues.get("appno"));
			strQuery = SQLParser.getSqlQuery("compromoterselectionpromoters^" + strExecappno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)rs.getString("com_compdtid")));
				arrValues.add(correctNull((String)rs.getString("com_compdttype")));
				arrValues.add(correctNull((String)rs.getString("com_compdtfname")));
				arrValues.add(correctNull((String)rs.getString("com_compdtlname")));
				arrValues.add(correctNull((String)rs.getString("com_compdtmname")));
				arrValues.add(correctNull((String)rs.getString("com_compdtdob")));
				
				arrValues.add(correctNull((String)rs.getString("com_compdtaddress1")));
				arrValues.add(correctNull((String)rs.getString("com_compdtaddress2")));
				arrValues.add(correctNull((String)rs.getString("com_compdtcity")));
				arrValues.add(correctNull((String)rs.getString("com_compdtstate")));
				arrValues.add(correctNull((String)rs.getString("com_compdtpin")));
				arrValues.add(correctNull((String)rs.getString("com_compdtphone")));
				
				arrValues.add(correctNull((String)rs.getString("com_compdtfax")));
				arrValues.add(correctNull((String)rs.getString("com_compdtemail")));
				arrValues.add(correctNull((String)rs.getString("com_comdtpershare")));
				arrValues.add(correctNull((String)rs.getString("com_compdtshareheld")));
				arrValues.add(correctNull((String)rs.getString("com_compdtnetworth")));
				arrValues.add(correctNull((String)rs.getString("com_compdate")));
				arrValues.add(correctNull((String)rs.getString("CapContribution")));
				arrValues.add(correctNull((String)rs.getString("com_percent")));
				arrValues.add(correctNull((String)rs.getString("COM_COMPDSEX")));
				arrValues.add(correctNull((String)rs.getString("COM_COMPDACA")));
				arrValues.add(correctNull((String)rs.getString("COM_COMPDEXP")));
				arrValues.add(correctNull((String)rs.getString("COM_COMPDSTKHOLDER")));
				arrValues.add(correctNull((String)rs.getString("com_background")));
				arrValues.add(correctNull((String)rs.getString("com_facevalue")));
				arrValues.add(correctNull((String)rs.getString("com_compdtdesignation")));
				arrValues.add(correctNull((String)rs.getString("COM_COMPDTDIN")));
				arrValues.add(correctNull((String)rs.getString("com_compdtappid"))); 
				arrValues.add(correctNull((String)rs.getString("com_compdtappid")));
				
				arrValues.add(correctNull((String)rs.getString("com_comprelationship")));
				arrValues.add(correctNull((String)rs.getString("com_compratinggrade1")));
				arrValues.add(correctNull((String)rs.getString("com_compratingason1")));
				arrValues.add(correctNull((String)rs.getString("com_compratingtype1")));
				arrValues.add(correctNull((String)rs.getString("com_compratinggrade2")));
				arrValues.add(correctNull((String)rs.getString("com_compratingason2")));
				arrValues.add(correctNull((String)rs.getString("com_compratingtype2")));
				arrValues.add(correctNull((String)rs.getString("com_compborrname")));
				arrValues.add("");
				arrValues.add("");
				
				
				
				hshQuery.put("strQueryId","compromoterins");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in setTertiaryPromoterDetails..."+e.toString());
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
	private void setFacilityDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();	
		
		try{
			String strExecappno=correctNull((String)hshValues.get("execappno"));
			String strAppno=correctNull((String)hshValues.get("appno"));
			
			strQuery = SQLParser.getSqlQuery("get_FacilityData^" + strExecappno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{					
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQueryValues=new HashMap();					
				
				hshQuery.put("strQueryId","insfacility");
			
				arrValues.add(strAppno);
				arrValues.add(correctNull((String)rs.getString("facility_headid")));
				arrValues.add(correctNull((String)rs.getString("facility_id")));
				arrValues.add(correctNull((String)rs.getString("borrower_id")));
				//arrValues.add(correctNull((String)rs.getString("facility_date")));
				arrValues.add(correctNull((String)rs.getString("facility_proposed")));
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add("0.00");
				arrValues.add(correctNull((String)rs.getString("facility_sno")));
				arrValues.add(correctNull((String)rs.getString("facility_group")));
				arrValues.add(correctNull((String)rs.getString("facility_desc")));
				arrValues.add(correctNull((String)rs.getString("facility_category")));
				arrValues.add(correctNull((String)rs.getString("facility_months")));
				arrValues.add(correctNull((String)rs.getString("facility_interest")));	
				arrValues.add(correctNull((String)rs.getString("facility_branchname")));
				arrValues.add(correctNull((String)rs.getString("facility_margin")));
				arrValues.add(correctNull((String)rs.getString("bplr")));									
				arrValues.add(correctNull((String)rs.getString("facility_dp")));
				arrValues.add(correctNull((String)rs.getString("facility_outstanding")));
				arrValues.add(correctNull((String)rs.getString("security_value")));
				arrValues.add(correctNull((String)rs.getString("cbs_accountno")));
				arrValues.add(correctNull((String)rs.getString("facility_intremarks")));
				arrValues.add(correctNull((String)rs.getString("facility_osason")));//FACILTY_ASONDATE
				arrValues.add(correctNull((String)rs.getString("facility_existbanktype")));//FACILTY_EXISTINGBANKTYPE
				arrValues.add(correctNull((String)rs.getString("facility_propbanktype")));//FACILTY_PROPBANKTYPE
				arrValues.add(correctNull((String)rs.getString("facility_purpose")));
				hshQuery.put("arrValues",arrValues);					
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in setFacilityDetails..."+e.toString());
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
	
	public void updateFreezeData(HashMap hshValues) 
	{
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();	
		try
		{
			String strAppno=correctNull((String)hshValues.get("appno"));
			
			if(Helper.correctNull((String)hshValues.get("hidAction")).equals("FREEZE"))
			{	
				hshQuery.put("strQueryId","commworkflowundostatus");
				arrValues.add("fr");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
			}
			else
			{	
				hshQuery.put("strQueryId","commworkflowundostatus");
				arrValues.add("op");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				 hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 hshQuery.put("strQueryId","delreport105");
				 arrValues.add(strAppno);
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("2",hshQuery);	
				 hshQueryValues.put("size","2");
				 
				 /*hshQuery=new HashMap();
				 arrValues=new ArrayList();
				 hshQuery.put("strQueryId","delreport106");
				 arrValues.add(strAppno);
				 hshQuery.put("arrValues",arrValues);
				 hshQueryValues.put("3",hshQuery);	
				 hshQueryValues.put("size","3");*/
				
			}	
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateFreezeData..."+e.toString());
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
	
	public HashMap getFreezeData(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord = new HashMap();
		String strQuery="";
		try
		{
			String strAppno=correctNull((String)hshValues.get("appno"));
			String checkData ="";
			
			strQuery = SQLParser.getSqlQuery("commworkflowsel2^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				hshRecord.put("checkAppstatus",Helper.correctNull((String)rs.getString("app_status")));
			}
				
			/*strQuery = SQLParser.getSqlQuery("ramtolaps_report106^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(!rs.next())
			{
				checkData ="YES";
				hshRecord.put("checkData","YES");
			}*/
			
			if(checkData.equals(""))
			{
				strQuery = SQLParser.getSqlQuery("getramrating105details^" + strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(!rs.next())
				{
					checkData ="YES";
					hshRecord.put("checkData","YES");
				}
			}
			
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateFreezeData..."+e.toString());
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
	
	
	public HashMap updateFinancialtype(HashMap hshValues) 
	{
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		HashMap hshQueryValues=new HashMap();	
		String strQuery="";
		ResultSet rs =null;
		String fincount="";
		String strExp="$";
		int cmano=0;
		int finance_id=0;
		
		try
		{	
			FinancialBean fOb = new FinancialBean();
			String strAppno=correctNull((String)hshValues.get("hidappid"));
			if(strAppno.equals(""))
			{
				
				strAppno=correctNull((String)hshValues.get("hid_appid"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("appno"));
			}
			String strAction=correctNull((String)hshValues.get("hidAction"));
			String strCMA="";
			strCMA=correctNull((String)hshValues.get("selfintype"));
			
			//EJBInvoker.executeStateLess("financial",hshValues,"deleteData");
			
			strQuery=SQLParser.getSqlQuery("executive_finselect1^"+strAppno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				fincount=correctNull(rs.getString("cnt"));
			}
			
			/*if(Integer.parseInt(Helper.correctInt(fincount))>0)
			{
				strExp = strExp + " Financial Data's Entered so financial type cannot be changed. ";
				throw new Exception(strExp);
			}*/
			//else
			//{
				if(strAction.equalsIgnoreCase("edit"))
				{	
					
					/*hshQuery.put("strQueryId","upd_fintype_appid");
					arrValues.add(correctNull((String)hshValues.get("selfintype")));
					arrValues.add(correctNull((String)hshValues.get("selfintype")));
					arrValues.add(strAppno);
					arrValues.add("N");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");*/
					//For inserting in com_finnace table
					/*strQuery=SQLParser.getSqlQuery("comfinance_appid^"+strAppno);
					if(rs != null)rs.close();
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						cmano=Integer.parseInt(Helper.correctInt(rs.getString("fin_cmano")));
						finance_id=Integer.parseInt(Helper.correctInt(rs.getString("fin_financeid")));
					}*/
				
					
					
					//if(cmano==0)
					//{
					//to check whether cma already exist
					strQuery=SQLParser.getSqlQuery("duplicatecmasno^"+strAppno+"^"+strCMA);
					if(rs != null)rs.close();
					rs=DBUtils.executeQuery(strQuery);
					
					
					if(rs.next())
					{
						
						finance_id=Integer.parseInt(Helper.correctInt(rs.getString("fin_financeid")));
						hshValues.put("Finaceid_exists", "Y");
					}
					
					else
					{
						
						strQuery=SQLParser.getSqlQuery("maxfinanceid^"+strAppno);
						if(rs != null)rs.close();
						rs=DBUtils.executeQuery(strQuery);
						if(rs.next())
						{
							finance_id=Integer.parseInt(Helper.correctInt(rs.getString("fin_financeid")));
						}
						
					hshQuery.put("strQueryId","comfinance_appid_insert");
					
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hshValues.get("selfintype")));
					
					arrValues.add("0");//sel_divid
					
					arrValues.add("N");//Freeze
		
					arrValues.add(String.valueOf(finance_id));
					arrValues.add("N");//Renew Flag
					arrValues.add("");//Freeze date
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					hshValues.put("Finaceid_exists", "N");
					}
					
				}
				
					/*else
					{
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						
						
						
						
						hshQuery.put("strQueryId","comfinance_appid_update");
						arrValues.add(correctNull((String)hshValues.get("selfintype")));
						
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(finance_id));
						
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);	
						hshQueryValues.put("size","1");
						
					}*/
			
				
				
				HashMap hshResult	= new HashMap();
				String financeid=String.valueOf(finance_id);
				if(!(strAppno.equals("") && financeid.equals("")))
				{
					hshResult.put("appidnew", strAppno);
					
					hshResult.put("hidfinanceid", financeid);
					
					hshResult.put("hidcmasno", correctNull((String)hshValues.get("selfintype")));
					/*hshResult.put("strFreeze", hidFreeze);
					hshResult.put("hidUpload", hidUpload);
					hshResult.put("hidAction", strAction);
					hshResult.put("pageval", page);
					hshResult.put("printchk1", chk1);
					hshResult.put("printchk2", chk2);
					hshResult.put("printchk3", chk3);
					hshResult.put("printchk4", chk4);
					hshResult.put("printchk5", chk5);*/
					
					hshResult	= fOb.getData(hshResult);
				}
		
				Set enu=null;
				Iterator iterator=null;
				enu = hshResult.keySet();
				iterator=enu.iterator();
				while(iterator.hasNext())
				{
					String strId=(String)iterator.next();
					hshValues.put(strId, hshResult.get(strId));
				}
				
			StringBuilder sbAt = new StringBuilder();
			if(correctNull((String)hshValues.get("hidRecordflag")).equalsIgnoreCase("Y"))
			{
				hshValues.put("strAction", "Update");
			}
			else
			{
				hshValues.put("strAction", "Insert");
			}
			hshValues.put("appidnew", strAppno);
	
			//sbAt.append("Financial Type=").append(SetupParams.getSetupParams("fintype", correctNull((String)hshValues.get("selfintype"))));
			//AuditTrial.auditLog(hshValues,"210",strAppno,sbAt.toString());
			//}//
		}
		catch(Exception e)
		{
			throw new EJBException("Error in updateFinancialtype..."+e.toString());
		}
		return hshValues;
	}
	
	public HashMap getFinancialtype(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord = new HashMap();
		ArrayList arraycmacol = new ArrayList();
		ArrayList arraycmarow = new ArrayList();
		String strQuery="";
		String str_appno="";
		String finance_id="";
		String finaceid_flag="false";
		try
		{
			String attachapp_flag="false";
			
			hshRecord.put("recordFlag", "N");
			
			FinancialBean fOb = new FinancialBean();
			String strAppno=correctNull((String)hshValues.get("hidappid"));
			
			String pagetype=correctNull((String)hshValues.get("pagetype"));
			
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("hidapplicantnewid"));
			}
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("appid"));
				
		   }
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=correctNull((String)hshValues.get("comappid"));
				
		   }
			String strLapsOldId="",strLapsCustId="";
			//to get the latest id of Applicant
			if(!strAppno.equalsIgnoreCase(""))
			{
				strQuery= SQLParser.getSqlQuery("seloldrefidforapp^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLapsOldId=Helper.correctNull(rs.getString("perapp_oldid")); 
				}
				strQuery= SQLParser.getSqlQuery("selrenewappid^"+strLapsOldId);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strLapsCustId=Helper.correctNull(rs.getString("perapp_id")); 
					strAppno=Helper.correctNull(rs.getString("perapp_id")); 
				}
			}
			
			if(!strAppno.equalsIgnoreCase(""))
			{
				if (rs != null) 
					rs.close();
				strQuery=SQLParser.getSqlQuery("select_latestappid^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					
					strAppno=Helper.correctNull(((String) rs.getString("perapp_id")));
				}
			}
			str_appno=correctNull((String)hshValues.get("appno"));
			
			if(!str_appno.equalsIgnoreCase(""))
			{
				if (rs != null) 
					rs.close();
				
					
					strQuery=SQLParser.getSqlQuery("comfintrendsel1^"+str_appno);
					rs=DBUtils.executeQuery(strQuery);
					int row_count=0;

					if (rs.next()) {
						
						finance_id=Helper.correctNull(((String) rs.getString("demo_finstandard")));
					}
					if(!finance_id.equals(""))
					{
						if (rs != null) 
							rs.close();
						//to get the cma format of particular finance appid
						strQuery=SQLParser.getSqlQuery("fin_cmano_select^"+finance_id);
						rs=DBUtils.executeQuery(strQuery);
						int cma=0;

						if (rs.next()) {
							
							cma=Integer.parseInt(Helper.correctInt((String) rs.getString("fin_cmano")));
						}
						
						
						HashMap hshResult	= new HashMap();
						hshResult.put("appidnew", strAppno);
						
						hshResult.put("hidfinanceid", finance_id);
						
						hshResult.put("hidcmasno", cma+"");
						hshResult	= fOb.getData(hshResult);
						Set enu=null;
						Iterator iterator=null;
						enu = hshResult.keySet();
						iterator=enu.iterator();
						while(iterator.hasNext())
						{
							String strId=(String)iterator.next();
							hshRecord.put(strId, hshResult.get(strId));
						}
						attachapp_flag="true";
						finaceid_flag="true";
						
					}
					else
					{
						
						ResultSet rs1=null;
						if (rs != null) 
							rs.close();
						
							
							strQuery=SQLParser.getSqlQuery("finselect_cma_appid^"+strAppno);
							rs=DBUtils.executeQuery(strQuery);
						 row_count=0;

							while (rs.next()) {
								hshRecord.put("recordFlag", "Y");
								attachapp_flag="true";
								
							}
						
							HashMap hshResult	= new HashMap();
							hshResult.put("appidnew", strAppno);
							
							hshResult.put("hidfinanceid", "0");
							
							hshResult.put("hidcmasno", "0");
							hshResult	= fOb.getData(hshResult);
							Set enu=null;
							Iterator iterator=null;
							enu = hshResult.keySet();
							iterator=enu.iterator();
							while(iterator.hasNext())
							{
								String strId=(String)iterator.next();
								hshRecord.put(strId, hshResult.get(strId));
							}
						
						
					}
					
					hshRecord.put("appattach_flag",attachapp_flag);
					hshRecord.put("finaceid_flag",finaceid_flag);
			}
			else
			{
			
		
	      String cma=correctNull((String)hshValues.get("hidcmasno"));
	
		
	      finance_id=correctNull((String)hshValues.get("hidfinanceid"));
			
			
		
			ArrayList arrcmavalcma=new ArrayList();
			ArrayList arrcmavalRowdesc=new ArrayList();
			ArrayList arrcmavalRowdate=new ArrayList();
			ArrayList arrcmavalfinanceid=new ArrayList();
			ResultSet rs1=null;
			if (rs != null) 
				rs.close();
			
				
				strQuery=SQLParser.getSqlQuery("fin_cma_select^"+strAppno);
				rs=DBUtils.executeQuery(strQuery);
				int row_count=0;

				while (rs.next()) {
					hshRecord.put("recordFlag", "Y");
					row_count=row_count+1;
					
					arrcmavalcma.add(Helper.correctNull(((String) rs.getString("fin_cmano"))));//1
					String cmano=Helper.correctNull(((String) rs.getString("fin_cmano")));
					if(!cmano.equals(""))
					{
						
					
					String strQuery1 = SQLParser.getSqlQuery("com_cma_master^"+cmano);
					if (rs1 != null) {
						rs1.close();
					}
					rs1 = DBUtils.executeQuery(strQuery1);
					if(rs1.next())
							{
						arrcmavalRowdesc.add(Helper.correctNull((String) rs1.getString("cma_format_desc")));//2
						
							}}
					
					arrcmavalRowdate.add(Helper.correctNull(((String) rs.getString("fin_freezedate"))));//3
					arrcmavalfinanceid.add(Helper.correctNull(((String) rs.getString("fin_financeid"))));//4
					
				}
			
			
			hshRecord.put("arrcmavalcma",arrcmavalcma);
			hshRecord.put("arrcmavalRowdesc",arrcmavalRowdesc);
			hshRecord.put("arrcmavalRowdate",arrcmavalRowdate);
			hshRecord.put("arrcmavalfinanceid",arrcmavalfinanceid);
			hshRecord.put("appidnew",strAppno);
			
			if(pagetype.equalsIgnoreCase("FINANCIAL"))
			{
			HashMap hshResult	= new HashMap();
			
			if(!strAppno.equals("") && !finance_id.equals(""))
			{
				hshResult.put("appidnew", strAppno);
				
				hshResult.put("hidfinanceid", finance_id);
				
				hshResult.put("hidcmasno", cma);
				/*hshResult.put("strFreeze", hidFreeze);
				hshResult.put("hidUpload", hidUpload);
				hshResult.put("hidAction", strAction);
				hshResult.put("pageval", page);
				hshResult.put("printchk1", chk1);
				hshResult.put("printchk2", chk2);
				hshResult.put("printchk3", chk3);
				hshResult.put("printchk4", chk4);
				hshResult.put("printchk5", chk5);*/
				
				hshResult	= fOb.getData(hshResult);
				Set enu=null;
				Iterator iterator=null;
				enu = hshResult.keySet();
				iterator=enu.iterator();
				while(iterator.hasNext())
				{
					String strId=(String)iterator.next();
					hshRecord.put(strId, hshResult.get(strId));
				}
			}
			}
			
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getFinancialtype..."+e.toString());
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
	
	private void UpdateBankingdata(HashMap hshValues)
	{
		java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs=null,rs1=null;
		ArrayList arrValues=new ArrayList();
		
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		double wc_funded_existing_cons=0.0;
		double wc_funded_proposed_cons=0.0;
		double wc_funded_existing_noncons=0.0;
		double wc_funded_proposed_noncons=0.0;
		
		double wc_nonfunded_existing_cons=0.0;
		double wc_nonfunded_proposed_cons=0.0;
		double wc_nonfunded_existing_noncons=0.0;
		double wc_nonfunded_proposed_noncons=0.0;
		
		double tl_funded_existing_cons=0.0;
		double tl_funded_proposed_cons=0.0;
		double tl_funded_existing_noncons=0.0;
		double tl_funded_proposed_noncons=0.0;
		
		double tl_nonfunded_existing_cons=0.0;
		double tl_nonfunded_proposed_cons=0.0;
		double tl_nonfunded_existing_noncons=0.0;
		double tl_nonfunded_proposed_noncons=0.0;
		
		String strAppno="";
		String strSno="";
		String strId="";
		String checkid="";
		String strOverdue="";
		String strExcess="";
		//String strSecurity="";
		String strQuery="";
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		int intUpdatesize=0;
		String strcbsappno="";
		String strBorrowId="";
		try
		{
			strAppno=correctNull((String)hshValues.get("appno"));
			strSno=correctNull((String)hshValues.get("strSno"));
			strBorrowId=correctNull((String)hshValues.get("strBorrowId"));
			
			strQuery=SQLParser.getSqlQuery("selfacilitylimits^"+strAppno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(correctNull(rs.getString("facility_headid")).equals("1"))
				{
					if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
						tl_funded_existing_cons=tl_funded_existing_cons+rs.getDouble("existinglimit");
					else
						tl_funded_existing_noncons=tl_funded_existing_noncons+rs.getDouble("existinglimit");
					if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
						tl_funded_proposed_cons=tl_funded_proposed_cons+rs.getDouble("proposedlimit");
					else
						tl_funded_proposed_noncons=tl_funded_proposed_noncons+rs.getDouble("proposedlimit");
				}
				else if(correctNull(rs.getString("facility_headid")).equals("2"))
				{
					if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
						tl_nonfunded_existing_cons=tl_nonfunded_existing_cons+rs.getDouble("existinglimit");
					else
						tl_nonfunded_existing_noncons=tl_nonfunded_existing_noncons+rs.getDouble("existinglimit");
					if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
						tl_nonfunded_proposed_cons=tl_nonfunded_proposed_cons+rs.getDouble("proposedlimit");
					else
						tl_nonfunded_proposed_noncons=tl_nonfunded_proposed_noncons+rs.getDouble("proposedlimit");
				}
				else if(correctNull(rs.getString("facility_headid")).equals("3"))
				{
					if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
						wc_funded_existing_cons=wc_funded_existing_cons+rs.getDouble("existinglimit");
					else
						wc_funded_existing_noncons=wc_funded_existing_noncons+rs.getDouble("existinglimit");
					if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
						wc_funded_proposed_cons=wc_funded_proposed_cons+rs.getDouble("proposedlimit");
					else
						wc_funded_proposed_noncons=wc_funded_proposed_noncons+rs.getDouble("proposedlimit");
				}
				else if(correctNull(rs.getString("facility_headid")).equals("4"))
				{
					if(correctNull(rs.getString("facility_existbanktype")).equals("C"))
						wc_nonfunded_existing_cons=wc_nonfunded_existing_cons+rs.getDouble("existinglimit");
					else
						wc_nonfunded_existing_noncons=rs.getDouble("existinglimit");
					if(correctNull(rs.getString("facility_propbanktype")).equals("C"))
						wc_nonfunded_proposed_cons=wc_nonfunded_proposed_cons+rs.getDouble("proposedlimit");
					else
						wc_nonfunded_proposed_noncons=wc_nonfunded_proposed_noncons+rs.getDouble("proposedlimit");
				}
			}
				
			/*if(!(wc_funded_existing_cons==0.0 && wc_funded_proposed_cons==0.0) || 
						!(wc_nonfunded_existing_cons==0.0 && wc_nonfunded_proposed_cons==0.0))
			{
				strQuery=SQLParser.getSqlQuery("sel_combanking_ourbank^"+strAppno+"^Y");
				rs=DBUtils.executeQuery(strQuery);
				if (rs.next())
				{
					strId=correctNull((String )rs.getString("combk_id"));
					strOverdue=correctNull((String )rs.getString("combk_overdue"));
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);					
					hshQuery.put("strQueryId","combankingdelete");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String )strId));
					arrValues.add("W");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();							
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);
					hshQuery.put("strQueryId","combankinginsert1");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+wc_funded_existing_cons);
					arrValues.add(""+wc_funded_proposed_cons);
					arrValues.add(""+wc_nonfunded_existing_cons);
					arrValues.add(""+wc_nonfunded_proposed_cons);
					arrValues.add(correctNull((String )strOverdue));					
					arrValues.add("W");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
				else
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"W"));
					checkid=strId;
					hshQuery = new HashMap();
					intUpdatesize++;
					arrValues=new ArrayList();
					
					hshQueryValues.put("size",""+intUpdatesize);
					hshQuery.put("strQueryId","combankinginsert1");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+wc_funded_existing_cons);
					arrValues.add(""+wc_funded_proposed_cons);
					arrValues.add(""+wc_nonfunded_existing_cons);
					arrValues.add(""+wc_nonfunded_proposed_cons);
					arrValues.add("");						
					arrValues.add("W");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
				}
			}
			else
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
						
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","delcombankingbyourbank");
				arrValues.add(strAppno);
				arrValues.add("Our");
				arrValues.add("W");
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
			
		if(!(wc_funded_existing_noncons==0.0 && wc_funded_proposed_noncons==0.0) || 
					!(wc_nonfunded_existing_noncons==0.0 && wc_nonfunded_proposed_noncons==0.0))
		{
			strQuery=SQLParser.getSqlQuery("sel_combanking_ourbank^"+strAppno+"^N");
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				strId=correctNull((String )rs.getString("combk_id"));
				strOverdue=correctNull((String )rs.getString("combk_overdue"));
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","combankingdelete");
				arrValues.add(strAppno);
				arrValues.add(correctNull((String )strId));
				arrValues.add("W");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();	
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","combankinginsert1");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+wc_funded_existing_noncons);
				arrValues.add(""+wc_funded_proposed_noncons);
				arrValues.add(""+wc_nonfunded_existing_noncons);
				arrValues.add(""+wc_nonfunded_proposed_noncons);
				arrValues.add(correctNull((String )strOverdue));					
				arrValues.add("W");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
			}
			else
			{
				if(checkid.equals(""))
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"W"));
				}
				else
				{
					strId=""+(Integer.parseInt(checkid)+1);
				}
			
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);
				hshQuery.put("strQueryId","combankinginsert1");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+wc_funded_existing_noncons);
				arrValues.add(""+wc_funded_proposed_noncons);
				arrValues.add(""+wc_nonfunded_existing_noncons);
				arrValues.add(""+wc_nonfunded_proposed_noncons);
				arrValues.add("");						
				arrValues.add("W");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		}
		else
		{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
					
			hshQueryValues.put("size",""+intUpdatesize);					
			hshQuery.put("strQueryId","delcombankingbyourbank");
			arrValues.add(strAppno);
			arrValues.add("Our");
			arrValues.add("W");
			arrValues.add("N");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
		}
		checkid="";	
		if(!(tl_funded_existing_cons==0.0 && tl_funded_proposed_cons==0.0) ||
					!(tl_nonfunded_existing_cons==0.0 && tl_nonfunded_proposed_cons==0.0))
			{
				rs=DBUtils.executeLAPSQuery("sel_combanking_ourbank2^"+strAppno+"^Y");
				if (rs.next())
				{
					strId=correctNull((String )rs.getString("combk_id"));
					strOverdue=correctNull((String )rs.getString("combk_overdue"));
					strExcess=correctNull((String )rs.getString("combk_excess"));
					//strSecurity=correctNull((String )rs.getString("combk_security"));
					
					//1
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
									
					hshQueryValues.put("size","1");				
					hshQuery.put("strQueryId","combankingdelete");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("T");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					//2
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankinginsert");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+tl_funded_existing_cons);
					arrValues.add(""+tl_funded_proposed_cons);
					arrValues.add(""+tl_nonfunded_existing_cons);
					arrValues.add(""+tl_nonfunded_proposed_cons);
					arrValues.add(correctNull((String )strOverdue));
					arrValues.add("T");
					arrValues.add(correctNull((String )strExcess));
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);	
					
					//3
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankingupd");				
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);	
						
				}
				else
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"T"));
					checkid=strId;
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					intUpdatesize++;
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankinginsert");
					arrValues.add(strAppno);
					arrValues.add(strId);
					arrValues.add("KBL");
					arrValues.add(""+tl_funded_existing_cons);
					arrValues.add(""+tl_funded_proposed_cons);
					arrValues.add(""+tl_nonfunded_existing_cons);
					arrValues.add(""+tl_nonfunded_proposed_cons);
					arrValues.add("");
					arrValues.add("T");
					arrValues.add("");
					arrValues.add("0");
					arrValues.add("Our");
					arrValues.add("Y");
					
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					hshQueryValues.put("size",""+intUpdatesize);						
					hshQuery.put("strQueryId","combankingupd");				
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(""+intUpdatesize,hshQuery);	
				}
			}
			else
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
				hshQueryValues.put("size",""+intUpdatesize);					
				hshQuery.put("strQueryId","delcombankingbyourbank");
				arrValues.add(strAppno);
				arrValues.add("Our");
				arrValues.add("T");
				arrValues.add("Y");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		
		if(!(tl_funded_existing_noncons==0.0 && tl_funded_proposed_noncons==0.0) ||
				!(tl_nonfunded_existing_noncons==0.0 && tl_nonfunded_proposed_noncons==0.0))
		{
			rs=DBUtils.executeLAPSQuery("sel_combanking_ourbank2^"+strAppno+"^N");
			if (rs.next())
			{
				strId=correctNull((String )rs.getString("combk_id"));
				strOverdue=correctNull((String )rs.getString("combk_overdue"));
				strExcess=correctNull((String )rs.getString("combk_excess"));
				//strSecurity=correctNull((String )rs.getString("combk_security"));
				
				//1
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
								
						
				hshQuery.put("strQueryId","combankingdelete");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("T");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);		
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				//2
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize++;
				
									
				hshQuery.put("strQueryId","combankinginsert");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+tl_funded_existing_noncons);
				arrValues.add(""+tl_funded_proposed_noncons);
				arrValues.add(""+tl_nonfunded_existing_noncons);
				arrValues.add(""+tl_nonfunded_proposed_noncons);
				arrValues.add(correctNull((String )strOverdue));
				arrValues.add("T");
				arrValues.add(correctNull((String )strExcess));
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);	
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
			}
			else
			{
				if(checkid.equals(""))
				{
					strId = Integer.toString(getMaxGradeId(strAppno,"T"));
				}
				else
				{
					strId=""+(Integer.parseInt(checkid)+1);
				}
			
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				intUpdatesize++;
				
								
				hshQuery.put("strQueryId","combankinginsert");
				arrValues.add(strAppno);
				arrValues.add(strId);
				arrValues.add("KBL");
				arrValues.add(""+tl_funded_existing_noncons);
				arrValues.add(""+tl_funded_proposed_noncons);
				arrValues.add(""+tl_nonfunded_existing_noncons);
				arrValues.add(""+tl_nonfunded_proposed_noncons);
				arrValues.add("");
				arrValues.add("T");
				arrValues.add("");
				arrValues.add("0");
				arrValues.add("Our");
				arrValues.add("N");
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",""+intUpdatesize);		
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			}
		}
		else
		{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			
			hshQuery.put("strQueryId","delcombankingbyourbank");
			arrValues.add(strAppno);
			arrValues.add("Our");
			arrValues.add("T");
			arrValues.add("N");
			
			hshQueryValues.put("size",""+intUpdatesize);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put(""+intUpdatesize,hshQuery);
		}*/
		String strFacId="";
		String strFacNature="";
		String strCombkFacNature="";
		String strcom_factype="",strWhetherACOpening="",strDrawingpower="",strDueDate="",strOutstanding="";
		String strFlag="",strGroup="";
		String strRepayType="",strInterestType="",strBankingType="",strInterestRate="",strPurpose="",strParentAppno="",strParentsno="",strProcessDate="",strSancRefno="";
		String strPrefix="",strSuffix="",strFacCategory="";
		double dblTLExposure=0.00,dblOutstanding=0.00,dbl_Sancamount=0.00,dbl_disbamount=0.00;
		double dblLimit=0.00;
		strQuery=SQLParser.getSqlQuery("sel_FacilityIdLimit^"+strAppno+"^"+strSno);
		rs=DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			strFacId=Helper.correctNull((String)rs.getString("facility_code"));
			dblLimit=Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT")));
			strFacNature=Helper.correctNull((String)rs.getString("facility_nature"));
			strcbsappno=Helper.correctNull((String)rs.getString("cbs_accountno"));
			strWhetherACOpening=Helper.correctNull(rs.getString("facility_accountopen"));
			strGroup=Helper.correctNull(rs.getString("facility_group"));
			strDueDate=Helper.correctNull(rs.getString("facility_duedate"));
			strPurpose=Helper.CLOBToString(rs.getClob("facility_purpose"));
			strRepayType=Helper.correctInt(rs.getString("facility_repaytype"));
			strInterestType=Helper.correctNull(rs.getString("facility_intsubtype"));
			strBankingType=Helper.correctNull(rs.getString("facility_propbanktype"));
			strInterestRate=Helper.correctInt(rs.getString("facility_sancinterest"));
			strPrefix=Helper.correctNull(rs.getString("facility_prefix"));
			strSuffix=Helper.correctNull(rs.getString("facility_suffix"));
			strParentAppno=Helper.correctNull(rs.getString("facility_oldappno"));
			strParentsno=Helper.correctNull(rs.getString("facility_oldappsno"));
			strFacCategory=Helper.correctNull(rs.getString("facility_category"));
			
			if(!strParentAppno.equalsIgnoreCase("")&&!strParentsno.equalsIgnoreCase(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_facsanctionstatus1^"+strParentAppno+"^"+strParentsno);
				rs1=DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					strProcessDate=Helper.correctNull(rs1.getString("FAC_PROCESSDATE"));
					strDueDate=Helper.correctNull(rs1.getString("facility_duedate"));
					strInterestRate=Helper.correctNull(rs1.getString("facility_sancinterest"));
				}
				if(rs1!=null)
					rs1.close();
				strQuery=SQLParser.getSqlQuery("sel_SancRefNo^"+strParentAppno);
				rs1=DBUtils.executeQuery(strQuery);
				if (rs1.next())
				{
					strSancRefno=Helper.correctNull(rs1.getString("sanctionrefno"));
				}
				if(rs1!=null)
					rs1.close();
			}
			
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("sel_com_factype_value^"+strAppno+"^"+strSno);
		rs=DBUtils.executeQuery(strQuery);
		if (rs.next())
		{
			strcom_factype=Helper.correctNull((String)rs.getString("com_factype"));
		}
		{
			if(ApplicationParams.getCbsIntegration().equalsIgnoreCase("TRUE"))
			{
				if(strWhetherACOpening.equalsIgnoreCase("Y"))
				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening^"+strcbsappno);
				else
    			{
    				if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening^"+strPrefix+"^"+strSuffix);
    				else
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg^"+strcbsappno);
    			}
			}
			else
			{
				if(strWhetherACOpening.equalsIgnoreCase("Y"))
				strQuery = SQLParser.getCBSSqlQuery("selliabpullingdirectacopening1^"+strcbsappno);
				else
				{
					if(!strPrefix.equalsIgnoreCase("")&& !strSuffix.equalsIgnoreCase(""))
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopening1^"+strPrefix+"^"+strSuffix);
    				else
    					strQuery = SQLParser.getCBSSqlQuery("selliabpullingindirectacopeningbg1^"+strcbsappno);
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
				
				if(strFacNature.equalsIgnoreCase("1"))
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
		}
		/*if(strFacNature.equalsIgnoreCase("1"))
		{
			strFacNature="W";
		}
		else if(strFacNature.equalsIgnoreCase("2"))
		{
			strFacNature="T";
		}*/
		if(rs!=null)
		{
			rs.close();
		}
		strQuery=SQLParser.getSqlQuery("sel_Combk_Type^"+strAppno+"^"+strSno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			strCombkFacNature=Helper.correctNull((String)rs.getString("combk_type"));
			if(!strCombkFacNature.equalsIgnoreCase(strFacNature))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","combankingdeletebasedonsno");
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String)strSno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		if(dblLimit>0.00)
		{
			strQuery=SQLParser.getSqlQuery("combankingselectNEW^"+strAppno+"^and combk_facility_sno='"+strSno+"'and combk_credittype='P'");
			rs=DBUtils.executeQuery(strQuery);
			if (rs.next())
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","combankingupdateFacilities");
				arrValues.add("Our");
				arrValues.add("Karnataka Bank");
				arrValues.add(strFacId+"~"+strFacNature);
				arrValues.add(Helper.formatDoubleValue(dblLimit));
				arrValues.add("P");
				arrValues.add(strDueDate);
				arrValues.add(strBankingType);
				if(strInterestType.equalsIgnoreCase("SMTB"))
					arrValues.add("ST");//7
				else if(strInterestType.equalsIgnoreCase("TYGS"))
					arrValues.add("GS");//7
				else
					arrValues.add(strInterestType);//7
				arrValues.add(strRepayType);
				arrValues.add(strInterestRate);
				arrValues.add(strWhetherACOpening);
				arrValues.add(strPrefix);
				arrValues.add(strSuffix);
				arrValues.add(strPurpose);
				if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
				{
					arrValues.add(Helper.formatDoubleValue(dblLimit));
					arrValues.add(Helper.formatDoubleValue(dblLimit));
				}
				else
				{
				arrValues.add(Helper.formatDoubleValue(dblOutstanding));
				arrValues.add(Helper.formatDoubleValue(dblTLExposure));
				}
				arrValues.add(strFacCategory);
				arrValues.add(strAppno);
				arrValues.add(Helper.correctNull((String)strSno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			else
			{
				strId = Integer.toString(getMaxGradeId(strAppno));
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");					
				hshQuery.put("strQueryId","combankinginsertNEW");
				arrValues.add(strAppno);//1
				arrValues.add(strId);//2
				arrValues.add(strFacNature);//3
				arrValues.add(strFacId+"~"+strFacNature);//4
				//arrValues.add("");//5
				arrValues.add(strBankingType);//6
				if(strInterestType.equalsIgnoreCase("SMTB"))
					arrValues.add("ST");//7
				else if(strInterestType.equalsIgnoreCase("TYGS"))
					arrValues.add("GS");//7
				else
					arrValues.add(strInterestType);//7
				arrValues.add("P");//8
				arrValues.add(strSancRefno);//9
				arrValues.add(strProcessDate);//10
				arrValues.add(strDueDate);//11
				arrValues.add("");//12
				arrValues.add(strBorrowId);//13
				arrValues.add("Our");//14
				arrValues.add("Karnataka Bank");//15
				if(strcom_factype.equalsIgnoreCase("F"))
				{
					arrValues.add("F");//16
				}else
				{
					arrValues.add("N");//16
				}
				arrValues.add(Helper.formatDoubleValue(dblLimit));//17
				if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
					arrValues.add(Helper.formatDoubleValue(dblLimit));//18
				else
				arrValues.add(Helper.formatDoubleValue(dblOutstanding));//18
				arrValues.add("");//19
				arrValues.add("");//20
				arrValues.add(strSno);//21
				String strSessionMod=(Helper.correctNull((String)hshValues.get("strSessionMod")));
				if(strSessionMod.equalsIgnoreCase("CORP"))
				{
					strSessionMod="c";
				}
				else if(strSessionMod.equalsIgnoreCase("AGR"))
				{
					strSessionMod="a";
					
				}
				else
				{
					strSessionMod="";
				}
				arrValues.add(strSessionMod);//22
				arrValues.add("0");//23
				arrValues.add(strcbsappno);//24
				arrValues.add(strInterestRate);//25
				arrValues.add(strRepayType);//26
				arrValues.add(strDrawingpower);//27
				arrValues.add(strPurpose);	//	28		
				arrValues.add("0");//29
				if(strGroup.equalsIgnoreCase("0"))
					arrValues.add("M");//30
				else
					arrValues.add("S");//30
				arrValues.add(strGroup);//31	
				if(strFacCategory.equalsIgnoreCase("A")||strFacCategory.equalsIgnoreCase("D"))
					arrValues.add(Helper.formatDoubleValue(dblLimit));//32
				else
				arrValues.add(Helper.formatDoubleValue(dblTLExposure));//32
				arrValues.add(strFlag);//33
				arrValues.add(strWhetherACOpening);//34
				arrValues.add(strPrefix);
				arrValues.add(strSuffix);
				arrValues.add(strFacCategory);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
		}
		else
		{
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");					
			hshQuery.put("strQueryId","combankingdeletebasedonsno");
			arrValues.add(strAppno);
			arrValues.add(Helper.correctNull((String)strSno));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
		}
		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
		}catch(Exception ex)
		{
			throw new EJBException("Error in UpdateBankData :: "+ex.toString());
		}
	}
	
	
	private int getMaxGradeId(String appno)
	{
		ResultSet rs = null;
		int termId = 0;
		try
		{	
			rs=DBUtils.executeLAPSQuery("combankingmax^"+appno);
			
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
	
	public void updateCompanyData(HashMap hsh) 
	{
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQry = new HashMap();
		//ArrayList arr = new ArrayList();
		ArrayList arrVal = new ArrayList();
		ResultSet rs=null,rs2=null;
		String strQuery="";
		String val="";
		String strAppno="";
		String strInwardno="";
		
		try
		{
			val=(String)hsh.get("hidAction");
			strAppno=correctNull((String)hsh.get("appno"));
			strInwardno=correctNull((String)hsh.get("inwardno"));
			int intUpdatesize=0;
			String App_renew="";
			/*intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery.put("strQueryId","notecompanydel");
			arr.add(appno);
			hshquery.put("arrValues",arr);
			
			hshqueryval.put("1",hshquery);*/				
			if (val.equals("deleteapplication"))
			{
				/*String strApporghead="";
				String strExp="$";
				if(strInwardno.equals(""))
				{
					strQuery=SQLParser.getSqlQuery("selBranchCityName^"+correctNull((String)hsh.get("appno")));
					rs=DBUtils.executeQuery(strQuery);
				}
				else
				{
					strQuery=SQLParser.getSqlQuery("orgnamebyinward^"+strInwardno);
					rs=DBUtils.executeQuery(strQuery);
				}
				
				if(rs.next())
				{
					if(correctNull((String)hsh.get("applevel")).equalsIgnoreCase("s"))
					{
						strApporghead=correctNull(rs.getString("saralhead"));
						strExp=strExp+" Only Saral Head can delete the application";
					}
					else
					{
						strApporghead=correctNull(rs.getString("orghead"));
						strExp=strExp+" Only organisation head can delete the application";
					}
				}
				
				if(!strApporghead.equals("") && !strApporghead.equals(correctNull((String)hsh.get("strUserId"))))
				{
					throw new Exception(strExp);
				}
				*/
				arrVal = new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshquery.put("strQueryId","delapplications");
				arrVal.add(correctNull((String)hsh.get("strUserId")));//by balaji
				arrVal.add(strAppno);
				hshquery.put("arrValues",arrVal);
				hshqueryval.put(""+intUpdatesize,hshquery);
				hshqueryval.put("size",""+intUpdatesize);
				
				String strInwardNo="";
				rs=DBUtils.executeLAPSQuery("selinwardappdata^"+strAppno);
				if(rs.next())
				{
					strInwardNo=Helper.correctNull(rs.getString("inward_no"));
				}
				
//				arrVal = new ArrayList();
//				intUpdatesize=intUpdatesize+1;
//				hshquery=new HashMap();
//				hshquery.put("strQueryId","updinwardappatached");
//				arrVal.add("N");//by balaji
//				arrVal.add("");
//				arrVal.add(strInwardNo);
//				hshquery.put("arrValues",arrVal);
//				hshqueryval.put(""+intUpdatesize,hshquery);
//				hshqueryval.put("size",""+intUpdatesize);
				
				if(!strAppno.equals(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_RenewFlg^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					if(rs.next()){
						App_renew=Helper.correctNull((String)rs.getString("app_renew_flag"));
					}
				}
				if(App_renew.equalsIgnoreCase("R"))
				{
					strQuery=SQLParser.getSqlQuery("selrenewfac_details^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next()){
						intUpdatesize=intUpdatesize+1;
						hshQry=new HashMap();
						arrVal= new ArrayList();
						hshQry.put("strQueryId","updcorpfinacleaccno");
						arrVal.add(null);
						arrVal.add(strAppno);
						arrVal.add(correctNull((String)rs.getString("facility_sno")));
						hshQry.put("arrValues",arrVal);
						hshqueryval.put(""+intUpdatesize,hshQry);
						hshqueryval.put("size",""+intUpdatesize);
						
						intUpdatesize=intUpdatesize+1;
						hshQry=new HashMap();
						arrVal= new ArrayList();
						hshQry.put("strQueryId","update_renewFacility");
						arrVal.add(null);
						arrVal.add("0");
						arrVal.add(correctNull((String)rs.getString("facility_oldappno")));
						arrVal.add(correctNull((String)rs.getString("facility_oldappsno")));
						hshQry.put("arrValues",arrVal);
						hshqueryval.put(""+intUpdatesize,hshQry);
						hshqueryval.put("size",""+intUpdatesize);
					}
				}
				else if(App_renew.equalsIgnoreCase("S"))
				{
					strQuery=SQLParser.getSqlQuery("sel_restracc^"+strAppno);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						intUpdatesize=intUpdatesize+1;
						hshQry=new HashMap();
						arrVal= new ArrayList();
						hshQry.put("strQueryId","update_renewFacility");
						arrVal.add(null);
						arrVal.add("0");
						arrVal.add(correctNull((String)rs.getString("APP_EXAPPNO")));
						arrVal.add(correctNull((String)rs.getString("APP_EXAPPSNO")));
						hshQry.put("arrValues",arrVal);
						hshqueryval.put(""+intUpdatesize,hshQry);
						hshqueryval.put("size",""+intUpdatesize);
					}
				}
				else if(App_renew.equalsIgnoreCase("P"))
				{
					String strParameters="";
					strQuery=SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^ ");
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						
						intUpdatesize=intUpdatesize+1;
						hshQry=new HashMap();
						arrVal= new ArrayList();
						hshQry.put("strQueryId","update_renewFacility");
						arrVal.add(null);
						arrVal.add("0");
						arrVal.add(Helper.correctNull(rs.getString("PS_OLD_APP_NO")));
						arrVal.add(Helper.correctNull(rs.getString("PS_OLD_APP_SNO")));
						hshQry.put("arrValues",arrVal);
						hshqueryval.put(""+intUpdatesize,hshQry);
						hshqueryval.put("size",""+intUpdatesize);
					}
				}
				
			}
			
 			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
 			
 			if (val.equals("deleteapplication"))
 			{
 				StringBuilder sbAt = new StringBuilder();
 				sbAt.append("Application Has Been Deleted");
 				if(correctNull((String)hsh.get("cattype")).equalsIgnoreCase("corp"))
 				AuditTrial.auditLog(hsh,"142",correctNull((String)hsh.get("appno")),sbAt.toString());
 				if(correctNull((String)hsh.get("cattype")).equalsIgnoreCase("ops"))
 	 			AuditTrial.auditLog(hsh,"167",correctNull((String)hsh.get("appno")),sbAt.toString());
 			}
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
			throw new EJBException("Error in updateCompanyData of NotetodirBean :: "+ e.toString());
		}
 	}
	
	
	public HashMap getFacilityInterest(HashMap hshValues) 
	{
		ResultSet rs = null;
		int termId = 0;
		HashMap hshRecord=new HashMap();
		String strIntType="",strProposedAmnt="",strTenor="",strFacId="";
		
		String strSubFlag="",strValuesIn="";

		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		try
		{	
			
			strIntType=Helper.correctNull((String)hshValues.get("strIntType"));
			strProposedAmnt=Helper.correctNull((String)hshValues.get("strProposedLimit"));
			strTenor=Helper.correctNull((String)hshValues.get("strTenor"));
			strFacId=Helper.correctNull((String)hshValues.get("strFacCode"));
			strSubFlag=Helper.correctNull((String)hshValues.get("strSubFlag"));
			strValuesIn=Helper.correctNull((String)hshValues.get("strValuesIn"));			
			strProposedAmnt=Helper.convertApplicationToSetup(strValuesIn, Double.parseDouble(Helper.correctDouble(strProposedAmnt)));
			strProposedAmnt=nf.format(Double.parseDouble(Helper.correctDouble(strProposedAmnt)));
			if(strIntType.equalsIgnoreCase("Fix"))
			{
				strIntType="fixed";
			}
			if(strIntType.equalsIgnoreCase("Flo"))
			{
				strIntType="floating";
			}
			rs=DBUtils.executeLAPSQuery("getFacilityInt^"+strFacId+"^"+strIntType+"^"+strProposedAmnt+"^"+strTenor+"^O");			
			if(rs.next())
			{
				hshRecord.put("strInterest", ""+Double.parseDouble(Helper.correctDouble((String)rs.getString("corpprd_interest"))));
				hshRecord.put("strInterestIndexId", Helper.correctNull((String)rs.getString("CORPPRD_INTERESTID")));
				hshRecord.put("strInterestBaseRate", ""+Double.parseDouble(Helper.correctDouble((String)rs.getString("CORPPRD_BASERATE"))));
			}
			rs.close();
			
			hshRecord.put("strSubFlag",strSubFlag);
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
		
		return hshRecord;
		
	}
	
	public HashMap getSetupFacility(HashMap hshValues) 
	{
		ResultSet rs = null;
		ResultSet rsDiv = null;
		ResultSet rsDiv1 = null;
		int termId = 0;
		HashMap hshRecord=new HashMap();
		String strFacParent="",strFacSubCOde="";
		ArrayList vecRow=new ArrayList();
		ArrayList vecCol=new ArrayList();
		
		String strFacParent1="",strFacSubCOde1="";		
		String s1[]=null;
		String s2[]=null;
		
		String subFacFlag="",strValuesInForm="",strModuletype="";
		
		String strFromPage="";
		
		String strConsit="",strLending="",strDigiStatus="";
		
		String strprdType="";
		ArrayList arrRow=new ArrayList();
		
		String strOrgUsedby[]=null;
		String strOrgLevel=null;
		String strOrgCode=null;
		String strQuery="";
		boolean boolFacAllow = false;
		
		try
		{	
			strFromPage=Helper.correctNull((String)hshValues.get("hidfromlink"));	
			strFacParent1=Helper.correctNull((String)hshValues.get("strFacParent"));
			strFacSubCOde1=Helper.correctNull((String)hshValues.get("strFacSub"));
			strprdType=Helper.correctNull((String)hshValues.get("prd_type"));
			s1=strFacParent1.split("-");
			s2=strFacSubCOde1.split("-");
			strConsit=Helper.correctNull((String)hshValues.get("hidconstituiton"));
			strLending=Helper.correctNull((String)hshValues.get("hidlending"));
			strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
			String strAppNo=correctNull((String)hshValues.get("appno"));
			String comappid=correctNull((String)hshValues.get("Str_ApplicantId"));
			if(!comappid.equals(""))
			{
				strQuery= SQLParser.getSqlQuery("sel_ncgtcfacility_constitution^"+comappid);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("strconstitution", Helper.correctNull((String)rs.getString("PERAPP_CONSTITUTIONNEW")));
				}
			}
			
			java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();			
			
			strFacParent=s1[0];
			strFacSubCOde=s2[0];
			
			subFacFlag=Helper.correctNull((String)hshValues.get("subFacFlag"));	
			
			strValuesInForm=Helper.correctNull((String)hshValues.get("strValuesIn"));	
			strModuletype=Helper.correctNull((String)hshValues.get("moduletype"));	
			if(strValuesInForm.equalsIgnoreCase(""))
			{
				strValuesInForm="R";
			}
			
			double dbMaxAmount=0.00,dbMinAmount=0.00;
			
			
			//strTenor=Helper.correctNull((String)hshValues.get("strTenor"));
			if(!strAppNo.equalsIgnoreCase("new"))
			{
				strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strAppNo);
				rs=DBUtils.executeQuery(strQuery);	
				if(rs.next())
				{
					strDigiStatus=correctNull((String)rs.getString("APP_LOANSUBTYPE_DIGI"));
				}
			}
			else
			{
				strDigiStatus="PR";
			}
			if(strModuletype.equalsIgnoreCase("r"))
			{				
				
				strQuery=SQLParser.getSqlQuery("selperprdspecfic"+"^<="+"^"+strprdType);
				rs=DBUtils.executeQuery(strQuery);	
				while(rs.next())
				{
					ArrayList arrCol = new ArrayList();
					String strProductDesc="";
					strProductDesc	=correctNull((String)rs.getString("category"))+"-"+correctNull((String)rs.getString("subcategory"))+"-"+correctNull((String)rs.getString("prd_desc"));
					String strPrdLoanType=Helper.correctNull((String)rs.getString("prd_loantype"));
					if(strPrdLoanType.equalsIgnoreCase("TL")||strPrdLoanType.equalsIgnoreCase("DL"))
					{
						strPrdLoanType="2";
					}
					else if(strPrdLoanType.equalsIgnoreCase("OD"))
					{
						strPrdLoanType="1";
					}
					arrCol.add(correctNull((String)rs.getString("prdcode")));//0
					arrCol.add(strProductDesc);//1
					arrCol.add(strPrdLoanType);//2
					arrRow.add(arrCol);
				}
			}
			else
			{
				if(strDigiStatus.equalsIgnoreCase("PC"))
				{
					rs=DBUtils.executeLAPSQuery("getsetupFacilities^"+strFacParent+"^"+strFacSubCOde+"^"+strModuletype+"^Y");
				}
				else{
					rs=DBUtils.executeLAPSQuery("getsetupFacilities^"+strFacParent+"^"+strFacSubCOde+"^"+strModuletype+"^N");
				}
				while(rs.next())
					{
						boolFacAllow = false;
						rsDiv=DBUtils.executeLAPSQuery("facility_usedby_select^"+Helper.correctNull((String)rs.getString("com_facid")));
						if(rsDiv.next())
						{
							strOrgUsedby = Helper.correctNull((String)rsDiv.getString("fac_org_scode")).split(";");
							strOrgLevel = Helper.correctNull((String)rsDiv.getString("fac_org_level"));
							
							for(int i=0;i<strOrgUsedby.length;i++)
							{
								rsDiv=DBUtils.executeLAPSQuery("selectorgname^"+strOrgUsedby[i]);
								if(rsDiv.next())
								{
									if(strOrgLevel.equalsIgnoreCase("C"))
									{
										boolFacAllow = true;
										break;
									}
									if(strOrgLevel.equalsIgnoreCase("R") && strOrgCode.substring(0,6).equalsIgnoreCase(Helper.correctNull((String)rsDiv.getString("org_code")).substring(0,6)))
									{
										boolFacAllow = true;
										break;
									}
									if(strOrgLevel.equalsIgnoreCase("D") && strOrgCode.substring(0,9).equalsIgnoreCase(Helper.correctNull((String)rsDiv.getString("org_code")).substring(0,9)))
									{
										boolFacAllow = true;
										break;
									}
									if(strOrgLevel.equalsIgnoreCase("A") && strOrgCode.equalsIgnoreCase(Helper.correctNull((String)rsDiv.getString("org_code"))))
									{
										boolFacAllow = true;
										break;
									}
								}
							}
						}
						
						if(boolFacAllow)
						{
							vecCol=new ArrayList();
							vecCol.add(Helper.correctNull((String)rs.getString("com_facid")));//0
							vecCol.add(Helper.correctNull((String)rs.getString("com_facdesc")));//1
							dbMinAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("com_rangefrom")));
							dbMinAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesInForm,dbMinAmount)));
							if(strValuesInForm.equalsIgnoreCase("R"))
							{
								jtn.setMaximumFractionDigits(2);
								jtn.setMinimumFractionDigits(2);
								jtn.setGroupingUsed(false);
							    vecCol.add(""+jtn.format(dbMinAmount));//2
							}
							else if(strValuesInForm.equalsIgnoreCase("L"))
							{
								jtn.setMaximumFractionDigits(5);
								jtn.setMinimumFractionDigits(5);
								jtn.setGroupingUsed(false);
								vecCol.add(""+jtn.format(dbMinAmount));//2	
							}
							else if(strValuesInForm.equalsIgnoreCase("C"))
							{
								jtn.setMaximumFractionDigits(7);
								jtn.setMinimumFractionDigits(7);
								jtn.setGroupingUsed(false);
								vecCol.add(""+jtn.format(dbMinAmount));//2
								
							}
							dbMaxAmount=Double.parseDouble(Helper.correctDouble((String)rs.getString("com_rangeto")));
							dbMaxAmount=Double.parseDouble(Helper.correctDouble(Helper.convertSetupToApplicationValues(strValuesInForm,dbMaxAmount)));
							if(strValuesInForm.equalsIgnoreCase("R"))
							{
								jtn.setMaximumFractionDigits(2);
								jtn.setMinimumFractionDigits(2);
								jtn.setGroupingUsed(false);
							    vecCol.add(""+jtn.format(dbMaxAmount));//3
							}
							else if(strValuesInForm.equalsIgnoreCase("L"))
							{
								jtn.setMaximumFractionDigits(5);
								jtn.setMinimumFractionDigits(5);
								jtn.setGroupingUsed(false);
								vecCol.add(""+jtn.format(dbMaxAmount));//3	
							}
							else if(strValuesInForm.equalsIgnoreCase("C"))
							{
								jtn.setMaximumFractionDigits(7);
								jtn.setMinimumFractionDigits(7);
								jtn.setGroupingUsed(false);
								vecCol.add(""+jtn.format(dbMaxAmount));//3
								
							}					
							vecCol.add(Helper.correctNull((String)rs.getString("com_facility_emischeme")));//4
							if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("S")){
							vecCol.add(Helper.correctNull((String)rs.getString("COM_MINREPAYPERIOD_REST")));//5
							vecCol.add(Helper.correctNull((String)rs.getString("com_maxrepayperiod_restructure")));//6
							}else{
								vecCol.add(Helper.correctNull((String)rs.getString("com_minrepayperiod")));//5
								vecCol.add(Helper.correctNull((String)rs.getString("com_maxrepayperiod")));//6
							}
							vecCol.add(Helper.correctNull((String)rs.getString("FACILITY_NATURE")));//7	
							vecCol.add(Helper.correctNull((String)rs.getString("COM_AGRSCHEMETYPE")));//8	
							vecCol.add(Helper.correctNull((String)rs.getString("COM_FACNATURE")));//9	
							vecCol.add(Helper.correctNull(rs.getString("com_cashmargin")));//10	
							vecCol.add(Helper.correctNull(rs.getString("fac_repaytype")));//11	
							vecCol.add(Helper.correctNull(rs.getString("com_facility_loantype")));//12	
							vecCol.add(Helper.correctNull(rs.getString("com_loanagainstshares")));//13	
							vecCol.add(Helper.correctNull(rs.getString("com_sharetype")));//14	
							
							String strGECLType="";
							if(rsDiv!=null)
								rsDiv.close();
							String strQuery2 = SQLParser.getSqlQuery("sel_otherdetails^"+Helper.correctNull(rs.getString("com_facid")));
							rsDiv = DBUtils.executeQuery(strQuery2);
							if(rsDiv.next())
							{
								vecCol.add(Helper.correctNull(rsDiv.getString("COM_LOANACC")));//15
								strGECLType=Helper.correctNull(rsDiv.getString("COM_GECLTYPE"));
							}
							else
							{
								vecCol.add("N");
							}
							vecCol.add(Helper.correctNull(rs.getString("com_bankscheme")));//16
							vecCol.add(strGECLType);//17
							//added for Svanidhi..
							String strSvanidhiType="";
							String bank_scheme=Helper.correctNull(rs.getString("com_bankscheme"));
							if(rsDiv!=null)
								rsDiv.close();
							String strQuery3 = SQLParser.getSqlQuery("sel_otherdetails^"+Helper.correctNull(rs.getString("com_facid")));
							rsDiv = DBUtils.executeQuery(strQuery3);
							if(rsDiv.next())
							{
								
								strSvanidhiType=Helper.correctNull(rsDiv.getString("COM_SVANIDHITYPE"));
							}
							vecCol.add(strSvanidhiType);//18
							
							String strAppId=correctNull((String)hshValues.get("strappid"));
							if(("").equalsIgnoreCase(strAppId)){
								
								strAppId=correctNull((String)hshValues.get("Str_ApplicantId"));
							}
							if(bank_scheme.equalsIgnoreCase("064") ){
								
								if(("1").equals(strSvanidhiType)){
									if(rsDiv!=null)
										rsDiv.close();									
									rsDiv = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^"+strSvanidhiType));
									if(rsDiv.next())
									{
									  vecCol.add("N");	
										
									}
									else{
										vecCol.add("Y");
									}
								}
								else if(("2").equals(strSvanidhiType)){
									if(rsDiv!=null)
										rsDiv.close();
									String svanidhiStatus="";
									rsDiv = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^1"));
									if(rsDiv.next())
									{
										svanidhiStatus=rsDiv.getString("FACILITY_STATUS");
										if(rsDiv1!=null)
											rsDiv1.close();
										String svanidhi2="";
										rsDiv1 = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^2"));
										if(rsDiv1.next())
										{
											svanidhi2="Y";
										}else{
											svanidhi2="N";
										}
										if(("ca").equalsIgnoreCase(svanidhiStatus)&&svanidhi2.equalsIgnoreCase("N")){
											vecCol.add("Y");	
										}else{
											vecCol.add("N");
										}
										
									}
									else{
										vecCol.add("N");
									}
								}else if(("3").equals(strSvanidhiType)){
									if(rsDiv!=null)
										rsDiv.close();
									String svanidhiStatus1="";
									rsDiv = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^1"));
									if(rsDiv.next())
									{
										svanidhiStatus1=rsDiv.getString("FACILITY_STATUS");
									}
									if(rsDiv!=null)
										rsDiv.close();
									String svanidhiStatus2="";
									rsDiv = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^2"));
									if(rsDiv.next())
									{
										svanidhiStatus2=rsDiv.getString("FACILITY_STATUS");
									}
									
										if(rsDiv1!=null)
											rsDiv1.close();
										String svanidhi3="";
										rsDiv1 = DBUtils.executeQuery(SQLParser.getSqlQuery("sel_Svanidhifacilities^"+strAppId+"^3"));
										if(rsDiv1.next())
										{
											svanidhi3="Y";
										}else{
											svanidhi3="N";
										}
										if(("ca").equalsIgnoreCase(svanidhiStatus1)&&("ca").equalsIgnoreCase(svanidhiStatus2)&&svanidhi3.equalsIgnoreCase("N")){
											vecCol.add("Y");	
										}else{
											vecCol.add("N");
										}
								}else{
									vecCol.add("");
								}
							
								
							}else{
								vecCol.add("Y");//19
								
							}
							vecCol.add(Helper.correctNull(rs.getString("COM_CGTMSEFLAG")));//20	
							vecRow.add(vecCol);	
							
						}
					}
			}
			rs.close();	
			hshRecord.put("vecRow", vecRow);
			hshRecord.put("subFacFlag", subFacFlag);
			hshRecord.put("strFacSelCode",Helper.correctNull((String)hshValues.get("strFacCode")));
			hshRecord.put("strFromLink", strFromPage);
			hshRecord.put("strFacParent1", strFacParent1);
			hshRecord.put("strFacSubCOde1", strFacSubCOde1);
			hshRecord.put("strHidModuleType",strModuletype);
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("strprdType",strprdType);
			hshRecord.put("PERAPP_CONSTITUTIONNEW",strConsit);
			hshRecord.put("PERAPP_LENDING",strLending);
			
			
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
		
		return hshRecord;
		
	}
	public void updateComments(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String) hshValues.get("hidAppNo"));
		}
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String) hshValues.get("hidappno"));
		}
		String APP_LOANSUBTYPE_DIGI = correctNull((String) hshValues.get("APP_LOANSUBTYPE_DIGI"));
		String strsno = correctNull((String) hshValues.get("com_sno"));
		String strPage = correctNull((String) hshValues.get("hidPage"));
		if(strPage.equalsIgnoreCase(""))
			strPage = correctNull((String) hshValues.get("hidPage1"));
		ResultSet rs=null;
		try {
			int ij=1;
			String strValue="txt_comments";
			String strValue1=strValue;
			String strPage1=strPage;
			if(strPage.equals("secoverage")) 
			{
				ij=4; //loop can be controlled by the value given here.
			}
			else if(strPage.equals("otherparams")) 
			{
				ij=6; //loop can be controlled by the value given here.
			}else if(strPage.equals("brief")) 
			{
				ij=3; //loop can be controlled by the value given here.
			}
			if(!(strPage.equals("secoveragecmts")||strPage.equals("existingsecurity")||strPage.equals("existingfacility")))
			{
				for (int loop=0;loop<ij;loop++)
				{
					if(APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PC") && strAction.trim().equals("delete") && loop==0)
					{
						loop=loop+1;
					}
				arrValues=new ArrayList();
				if(loop>0)
				{
					strPage=strPage1+loop;
					strValue=strValue1+loop;
				}
				if (strAction.trim().equals("update")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_comments");
					arrValues.add(appno);
					arrValues.add(strPage);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comments");
		
					arrValues.add(appno);
					arrValues.add(Integer.toString(loop+1));
					if(!correctNull((String) hshValues.get(strValue)).equalsIgnoreCase(""))
					{
						arrValues.add(correctNull((String) hshValues.get(strValue)));
					}
					else
					{
						arrValues.add(correctNull((String) hshValues.get("txtarea_comments")));
					}
					arrValues.add(strPage);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				
				else if (strAction.trim().equals("delete")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_comments");
					arrValues.add(appno);
					arrValues.add(strPage);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
				}
				}
			}else if(strPage.equals("secoveragecmts")){
				if (strAction.trim().equals("update")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_seccomments");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_seccomments");
		
					arrValues.add(appno);
					arrValues.add(correctNull((String) hshValues.get("sel_seccoverageApp")));
					arrValues.add(correctNull((String) hshValues.get("txt_comments")));
					arrValues.add(correctNull((String) hshValues.get("sel_seccoverageGroup")));
					arrValues.add(correctNull((String) hshValues.get("txt_comments1")));
					arrValues.add(correctNull((String) hshValues.get("sel_proposedsec")));
					arrValues.add(correctNull((String) hshValues.get("txt_comments2")));
					arrValues.add(correctNull((String) hshValues.get("sel_sectype")));
					arrValues.add(correctNull((String) hshValues.get("sel_Additionalgroupsec")));
					arrValues.add(correctNull((String) hshValues.get("txt_comments3")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else if (strAction.trim().equals("delete")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_seccomments");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
				}
			}else if(strPage.equals("existingsecurity")||strPage.equals("existingfacility")){
				
				if (strAction.trim().equals("update")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_secforgroupconcerns");
					arrValues.add(appno);
					arrValues.add(strPage);
					arrValues.add(correctNull((String) hshValues.get("sel_groupname")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_secforgroupconcerns");
					arrValues.add(appno);
					arrValues.add(correctNull((String) hshValues.get("sel_groupname")));
					arrValues.add(correctNull((String) hshValues.get("sel_Additionalsec")));
					arrValues.add(strPage);
					arrValues.add(correctNull((String) hshValues.get("txt_comments2")));
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else if (strAction.trim().equals("delete")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_secforgroupconcerns");
					arrValues.add(appno);
					arrValues.add(strPage);
					arrValues.add(correctNull((String) hshValues.get("sel_groupname")));
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
					
				}
			}
			
	}

	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	}
	
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
		String strUserId="",strOrgCode="",strOrgLevel="",usrOrgCode="";
	//	strcustid=Helper.correctNull((String)hshValues.get("hidDemoId"));			
		strAppStatus=Helper.correctNull((String)hshValues.get("hidappstatus"));
		strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
		strOrgCode=Helper.correctNull((String)hshValues.get("strOrgCode"));
		strPageFrom=Helper.correctNull((String)hshValues.get("hidPageFrom"));
		strPrdType=Helper.correctNull((String)hshValues.get("hidPrdType"));
		
		Connection connectDB= null;
		CallableStatement callableStmt = null;
		
		String strmodType = Helper.correctNull((String)hshValues.get("sessionModuleType"));
		
		try {
			
			if(strmodType.equalsIgnoreCase("CORP"))
			{
				strmodType = "C";
			}
			else
			{
				strmodType = "A";
			}
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
			
			if (rs != null) {
				rs.close();
			}			
			
			strQuery = SQLParser.getSqlQuery("selApp_SearchResults^"+strcustid+"^"+strmodType);
			
			rs = DBUtils.executeQuery(strQuery);
			while (rs.next()) {
				arrCol = new ArrayList();
			//	arrCol.add(Helper.correctNull(rs.getString("app_no")));//0
			//	arrCol.add(Helper.correctNull(rs.getString("com_facdesc")));//1
			//	arrCol.add(Helper.correctNull(rs.getString("com_faccode")));//2
			//	arrCol.add(Helper.correctNull(rs.getString("com_factype")));//3
			//	arrCol.add(Helper.correctNull(rs.getString("CBS_ACCOUNTNO")));//4
			//	arrCol.add(Helper.correctNull(rs.getString("SanctionedDate")));//5
				
				arrCol.add(Helper.correctNull(rs.getString("app_no")));//0
				arrCol.add(Helper.correctNull(rs.getString("app_applnholder")));//1
				arrCol.add(Helper.correctNull(rs.getString("app_processdate")));//2
				arrCol.add("");//3
				arrCol.add("");//4
				arrCol.add("");//5
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow", arrRow);
	
			hshResult.put("strcustid",strcustid);
		}
	catch(Exception e){
		throw new EJBException("Error in getApplicationSearchDetails "+e.toString());
	}
		
		return hshResult;
		
	}

	public HashMap getComments(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		String strPage = "",strgroupid="";
		String strAppholder="",strUserID="";

		try {
			strUserID=Helper.correctNull((String)hshValues.get("strUserId"));
			String StrDigiLoanType = correctNull((String) hshValues.get("StrDigiLoanType"));
			if(StrDigiLoanType.equalsIgnoreCase("")){
				StrDigiLoanType = correctNull((String) hshValues.get("APP_LOANSUBTYPE_DIGI"));
			}
			hshRecord.put("StrDigiLoanType",StrDigiLoanType);

			appno = correctNull((String) hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidAppNo"));
			}
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidappno"));
			}
			strPage = correctNull((String) hshValues.get("hidPageVal"));	
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidPage"));	
			}
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidPage1"));
			}
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hpage"));	
			}
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidCommentPage"));	
			}
			strgroupid=Helper.correctInt((String) hshValues.get("sel_groupname"));
			
			int ji=1;
			if(strPage.equals("brief"))
			{
				ji=3; //Loop can be controlled by the value given here.
			}
			else if(strPage.equals("otherparams"))
			{
				ji=6;
			}
			else if(strPage.equals("secoverage"))
			{
				ji=4;
			}
			String hshName="COM_COMMENTS";
			String hshName1=hshName;
			String strPage1=strPage;
			if(!(strPage.equals("secoveragecmts")||strPage.equals("existingsecurity")||strPage.equals("existingfacility")))
			{
				for (int loop=0;loop<ji;loop++)
				{
					if(loop>0)
					{
						hshName=hshName1+loop;
						strPage=strPage1+loop;
					}
				strQuery = SQLParser.getSqlQuery("sel_comments^"+strPage+"^"+ appno);
	
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					if(strPage.equalsIgnoreCase("swot")||strPage.equalsIgnoreCase("swotind")||strPage.equalsIgnoreCase("Method1")||strPage.equalsIgnoreCase("Method2")||strPage.equalsIgnoreCase("Assessmentofwc")||strPage.equalsIgnoreCase("agrifarmbudget")||strPage.equalsIgnoreCase("ExposuretoIndustry"))
					{	
						hshRecord.put("cmt_comments", correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
					}
					else
					{
						hshRecord.put(hshName, correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
					}
					hshRecord.put("hidPage", strPage);				
				}
				else
				{
					hshRecord.put("hidPage", strPage);
				}
				}
			}else if(strPage.equals("secoveragecmts")){
				strQuery = SQLParser.getSqlQuery("sel_seccomments^" + appno);
				
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("COMSEC_APPCOVERAGE", Helper.correctNull(rs.getString("COMSEC_APPCOVERAGE")));
					hshRecord.put("COMSEC_APPCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_APPCOMMENTS"))));
					hshRecord.put("COMSEC_GROUPCOVERAGE", Helper.correctNull(rs.getString("COMSEC_GROUPCOVERAGE")));
					hshRecord.put("COMSEC_GROUPCOMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_GROUPCOMMENTS"))));
					hshRecord.put("COMSEC_SECTYPE", Helper.correctNull(rs.getString("COMSEC_SECTYPE")));
					hshRecord.put("strProposedSecurity", Helper.correctNull(rs.getString("COMSEC_ADDITIONALSECCOVERAGE")));
					hshRecord.put("strProposedSecurityComments", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_ADDITIONALSECCOMMENTS"))));
				}
				hshRecord.put("hidPage", strPage);
			}else if(strPage.equals("existingsecurity")||strPage.equals("existingfacility"))
			{
				strQuery = SQLParser.getSqlQuery("sel_secforgroupconcerns^" + appno+"^"+strgroupid+"^"+strPage);
				
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("COMSEC_GROUPSTATUS", Helper.correctNull(rs.getString("COMSEC_STATUS")));
					hshRecord.put("COMSEC_COMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COMSEC_COMMENTS"))));
				}
				hshRecord.put("COMSEC_GROUPAPPID", strgroupid);
			}
			hshRecord.put("appno",appno);
			hshRecord.put("strPage",strPage);
			int strFreezecount=0;
    		String strFreezeflag="N",strPrioityflag="N";
    		strQuery = SQLParser.getSqlQuery("sel_freezecount^" + appno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{	
				strFreezecount=Integer.parseInt(Helper.correctInt((String)rs.getString("freezecount")));
				if(strFreezecount!=0 )
				{
					strFreezeflag="Y";
				}
			}
			hshRecord.put("Freezeflag",strFreezeflag);
			hshRecord.put("strProductType",Helper.correctNull((String)hshValues.get("strProductType")));
			
			if (rs != null) {
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_prdDesc^"+appno);
			if(rs.next())
			{
				hshRecord.put("prd_applicablefor", Helper.correctNull((String)rs.getString("PRD_APPLICABLEFOR")));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_cbsaccno^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strAppholder=Helper.correctNull(rs.getString("app_applnholder")); //Helper.correctNull((String)rs.getString("cre_nonpoolflag"));
			}
			if(!strAppholder.equalsIgnoreCase(strUserID))
				hshRecord.put("btnenable","N");
			
			//for proposed assets check 
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_valuation^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("EDIT_APPLY_FLAG")).equalsIgnoreCase("N")){
					hshRecord.put("valuationFlag","N");
				}
			}
    			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_house^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("PHPA_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("HouseEdit_Flag","N");
				}
			}
			
			if(rs!=null) rs.close();
	  		strQuery = SQLParser.getSqlQuery("sel_editApply_vehicle^"+ appno);
    		rs = DBUtils.executeQuery(strQuery);
			while(rs.next()) 
			{
				if(Helper.correctNull((String)rs.getString("AUTO_EDIT_APPLYFLAG")).equalsIgnoreCase("N")){
					hshRecord.put("VehicleEdit_Flag","N");
				}
			}
			
		} catch (Exception ce) {
			throw new EJBException("Error in getComments " + ce.toString());
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
	
	
	
	
	//Deleting Agriculture details when Scheme type is changed by Venkata Prasad Chowdary	
	public void deleteAgricultureTabDetails(HashMap hsh) 
	{		
		ResultSet rs = null;
		String strQuery="";
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		int intUpdatesize =0;		
		String strAppno="",strSno="",strAgrSchemeTypeExisting="";		
		ResultSet rs1=null;
		try
		{				
			strAppno = correctNull((String)hsh.get("appno"));
			strSno = correctNull((String)hsh.get("selsno"));
			strAgrSchemeTypeExisting=correctNull((String )hsh.get("strAgrSchemeTypeExisting"));
			
			if(strAgrSchemeTypeExisting.equalsIgnoreCase("aQ")){
				//Kisan Credit Card Scheme
				//Crop Assessment				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agrcropassessment_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aV")){
				//Farm Development Scheme
				
				//Land Development Details
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_landdevelop_assessparam_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_onfarmdevelopment_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_sandcasting_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_sandcastingparticulars_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_soilreclamation_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Land Levelling
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_onfarmdevelopment_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Sand Casting
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_sandcasting_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_sandcastingparticulars_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Soil Reclamation
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_soilreclamation_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Drying Yard
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_dryingyard_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aO")){
				//Minor Irrigation Scheme
				
				//Minor Irrigation
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_minorirrigation_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Supplier Details
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "perassetdelete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aM")){
				//Farm Mechanisation Scheme
				//Farm Mechanisation Implements
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrfarmmachinery_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Income From Custom Hire Service
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrincomehireserv_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aT")){
				//Financing of Bullock Cart Scheme
				
				//Technical Data
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "bullockdatadel");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Loan Particulars
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_bullockparticulars");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Financial Data
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "bullockfinancialdatadel");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aI")){
				//Sericulture Scheme
				
				//Project Cost				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_del_seri_projectdetails");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_del_seri_otherprojectdetails");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Income And Expenses
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_seriincexpmeasure");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_seriincexp");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aB")){
				//Tobacco Financing Scheme
				
				//Tobacco Details
				intUpdatesize = intUpdatesize+1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","agr_tobacco_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aH")){
				//Plantation & Horticulture Scheme
				
				//Plant Details
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_horti_plantdetail_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_horticostofdevelopment_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_hortifindripirrigation_deleteBySno_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_horticostofcultivation_deletebysno_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_hortiyearcultivationcost_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Cost of Cultivation
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_hortifinancialprogramme_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Repayment
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_plantationrepayment_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Projected Income
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_hortiprojectedincome_delete_facility");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aY")){
				//Farm Forestry Scheme
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aD")){
				//Diary Farming Scheme
				
				//Cost of Investment
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_dairycostofinvestment_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Financial Data
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_dairyfinancialdata_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Herd Production Chart
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_dairyherdproduction_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Income Statement
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_dairyincomestatement_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aE")){
				//Poultry Development Scheme
				
				//Tech Data
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","per_del_poultrytechdata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","per_del_poultrybroifindata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_del_poultryfinperdata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_poultry_expenses");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_poultry_non_recurring");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Non Recurring Expense
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_poultry_broinonrecurring");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Recurring Expense
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_poultry_broirecurring");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Flock Replacement
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_broidelflockrep");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//State of Expense
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","del_poultry_expenditure");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aR")){
				//Allied Activity Scheme
				
				//Cost of Project
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_sheepfixedcost_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_sheeprecurringexp_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Herd Projection Chart
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_sheepherdprojchart_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_lambsproducedpercentage_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Income
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_sheepincome_delete");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aN")){
				//Gobar Gas plant Scheme
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_del_gobartechdata");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_gobar_income_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);	
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aJ")){
				//Financing Fisheries Scheme
				
				//Proposed Development
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize = intUpdatesize+1;
				hshQuery.put("strQueryId","agr_fishery_particulars_delete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Fisheries Investment
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delagrfishinvest");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delagrfishother");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Particulars
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agrcommonrequirementdelete");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Other Details
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "delagrfishinvestmarketing");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Income
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_agrMachSurplus");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				//Expenditure
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_agrMachEcoValues_facilities");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "del_agrMachOPExp");
				arrValues.add(strAppno);
				arrValues.add(strSno);
				arrValues.add(strAgrSchemeTypeExisting);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
			}else if(strAgrSchemeTypeExisting.equalsIgnoreCase("aS")){
				//Self Help Group Scheme
			}else if (strAgrSchemeTypeExisting.equalsIgnoreCase("aK")){
				//Advance Against Warehouse Receipt
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "per_del_capldata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_del_capldata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				intUpdatesize = intUpdatesize+1;
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "agr_del_caplinsdata");
				arrValues.add(strAppno);
				arrValues.add(strAgrSchemeTypeExisting);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}else{
				//
			}
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		
			
		}
		catch (Exception e)
		{
			log.error("in bean"+e);
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
		
		
	}//end
	
	public HashMap getCommentsonInterestRate(HashMap hshValues)  {
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		String strPage = "";
		String strfacsno = "";

		try {
			appno = correctNull((String) hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidAppNo"));
			}
			strPage = correctNull((String) hshValues.get("hidPage"));		
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidPage1"));
			}
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hpage"));	
			}
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidCommentPage"));	
			}
			strfacsno = correctNull((String) hshValues.get("sel_facility"));
			
			if( strfacsno.equalsIgnoreCase("") || strfacsno.equalsIgnoreCase("0") || strfacsno.equalsIgnoreCase("s"))
			{}else{
				strQuery = SQLParser.getSqlQuery("sel_commentsoninterestrate^" +strPage+"^"+strfacsno+"^"+appno);
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					hshRecord.put("COM_COMMENTS", correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
					hshRecord.put("hidPage", strPage);	
				}
				else
				{
					hshRecord.put("hidPage", strPage);
				}
			}
			hshRecord.put("appno",appno);
			hshRecord.put("com_sno", strfacsno);
		} catch (Exception ce) {
			throw new EJBException("Error in getCommentsonInterestRate " + ce.toString());
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
	
	public void updateCommentsonInterestRate(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase(""))
		{
			appno = correctNull((String) hshValues.get("hidAppNo"));
		}
		String strfacsno = correctNull((String) hshValues.get("sel_facility"));
		String strPage = correctNull((String) hshValues.get("hidPage"));
		if(strPage.equalsIgnoreCase(""))
			strPage = correctNull((String) hshValues.get("hidPage1"));
		ResultSet rs=null;
		try {
			int ij=1;
			String strValue="txt_comments";
			String strValue1=strValue;
			String strPage1=strPage;
			if(strPage.equals("secoverage")|| strPage.equals("brief"))
			{
				ij=2; //loop can be controlled by the value given here.
			}
			for (int loop=0;loop<ij;loop++)
			{
				arrValues=new ArrayList();
				if(loop>0)
				{
					strPage=strPage1+loop;
					strValue=strValue1+loop;
				}
				if (strAction.trim().equals("update")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_commentsoninterestrate");
					arrValues.add(appno);
					arrValues.add(strPage);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_commentsoninterestrate");
		
					arrValues.add(appno);
					arrValues.add(strfacsno);
					if(!correctNull((String) hshValues.get(strValue)).equalsIgnoreCase(""))
					{
						arrValues.add(correctNull((String) hshValues.get(strValue)));
					}
					else
					{
						arrValues.add(correctNull((String) hshValues.get("txtarea_comments")));
					}
					arrValues.add(strPage);
					
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
				else if (strAction.trim().equals("delete")) {
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					hshQuery.put("strQueryId", "del_commentsoninterestrate");
					arrValues.add(appno);
					arrValues.add(strPage);
					arrValues.add(strfacsno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				}
			}
	}

	catch (Exception ce) {
		throw new EJBException("inside update" + ce.toString());
	}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
	}
	
	public void UpdateRoiBasedOnrating(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		ResultSet rs1=null;
		ResultSet rs2=null;
		String strIntType="",strProposedAmnt="",strTenor="",strFacId="",strFacSno="",strROIType="";
		String strsector="",strsensitiveSector="";
		
		String strQuery1="";
        String strappno=Helper.correctNull((String)hshValues.get("appno"));
        java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		String Rating="";
		HashMap hshQuery=new HashMap();
		HashMap hshqueryval=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strModuleType=correctNull((String)hshValues.get("sessionModuleType"));
		double dblCreditRisk=0.0,dblBusinessRisk=0.0,dblMCLR=0.0;
		try
		{
			
			//select RATING
			if(rs!=null)
			{
				rs.close();
			}
			strQuery1 = SQLParser.getSqlQuery("sel_creditRatingType^" + strappno);
			rs = DBUtils.executeQuery(strQuery1);
			if(rs.next())
			{
				Rating=Helper.correctNull((String)rs.getString("cre_weight"));
			}
			//end
			if(rs!=null)
			{
				rs.close();
			}
			if(!Rating.equals(""))
			{
				if(strModuleType.equalsIgnoreCase("CORP")||strModuleType.equalsIgnoreCase("AGR"))
				{
				strQuery1 = SQLParser.getSqlQuery("get_FacilityData^" + strappno);
				rs = DBUtils.executeQuery(strQuery1);
				while(rs.next())
						{
							strIntType=Helper.correctNull((String)rs.getString("FACILITY_INTTYPE"));
							strTenor=Helper.correctNull((String)rs.getString("FACILITY_MONTHS"));
							strFacId=Helper.correctNull((String)rs.getString("facility_code"));
							strProposedAmnt=nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_PROPOSED"))));
							strFacSno=Helper.correctInt((String)rs.getString("FACILITY_SNO"));
							strROIType=Helper.correctNull((String)rs.getString("FAC_ROITYPE"));
							dblMCLR=rs.getDouble("FACILITY_BASERATE");
							if(strIntType.equalsIgnoreCase("Fix"))
							{
								strIntType="fixed";
							}
							if(strIntType.equalsIgnoreCase("Flo"))
							{
								strIntType="floating";
							}
							
							//select sector
							rs2=DBUtils.executeLAPSQuery("sel_misappclassification^"+strappno+"^"+strFacSno);			
							if(rs2.next())
							{
								strsector=Helper.correctNull((String)rs2.getString("app_sector"));  //01 ,02
								strsensitiveSector=Helper.correctNull((String)rs2.getString("app_sensitivesector")); //11
							}
							if(rs2!=null) {rs2.close();}
							//end
							
							if(strROIType.equalsIgnoreCase("RATING")) {
								
								String strMCLRType="",strRefType="O";
								{
									if(rs1!=null)
										rs1.close();
									rs1=DBUtils.executeLAPSQuery("sel_facility_mclrspread^"+strFacSno+"^"+strappno);
					 				if(rs1.next())
					 					strMCLRType=Helper.correctNull(rs1.getString("facility_mclrtype"));
								}
								if(!strMCLRType.equalsIgnoreCase(""))
				 				{
				 					String strArr[]=strMCLRType.split("@");
				 					if(strArr!=null && strArr.length>0)
				 					{
				 						if(rs1!=null)
											rs1.close();
										rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
										if(rs1.next())
										{
											if(strROIType.equalsIgnoreCase("O"))
												strROIType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
											else
												strRefType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
											
										}
				 					}
				 				}
								
									rs1=DBUtils.executeLAPSQuery("getFacilityInt1^"+strFacId+"^"+strIntType+"^"+strProposedAmnt+"^"+strTenor+"^"+strRefType+"^O");			
									if(rs1.next())
									{
										if(strsensitiveSector.equalsIgnoreCase("11")) {
										strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^"+Rating+"^"+Helper.correctNull((String)rs1.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs1.getString("CORPPRD_SNO"))
												+"^"+strsensitiveSector);
										rs2 = DBUtils.executeQuery(strQuery1);
										}
										else if(strsector.equalsIgnoreCase("01") || strsector.equalsIgnoreCase("02"))
										{
											strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^" +Rating+"^"+Helper.correctNull((String)rs1.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs1.getString("CORPPRD_SNO"))
													+"^"+strsector);
											rs2 = DBUtils.executeQuery(strQuery1);
										}
										else
										{
											strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^KB4^"+Helper.correctNull((String)rs1.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs1.getString("CORPPRD_SNO"))
													+"^01");
											rs2 = DBUtils.executeQuery(strQuery1);
										}
										if(rs2.next())
										{
											
											dblMCLR+=rs2.getDouble("ROI_CRP")+rs2.getDouble("ROI_BSP");
											
								    		hshQuery = new HashMap();
								    		arrValues=new ArrayList();
								    		arrValues.add(Helper.correctDouble(rs2.getString("ROI_CRP")));
								    		arrValues.add(strappno);
								    		arrValues.add(strFacSno);
								    		arrValues.add("Credit Risk Premium");
								    		hshQuery.put("strQueryId", "upd_facilitymclrspreadval");
								    		hshQuery.put("arrValues", arrValues);
								    		hshqueryval.put("1", hshQuery);
								    		
								    		hshQuery = new HashMap();
								    		arrValues=new ArrayList();
								    		arrValues.add(Helper.correctDouble(rs2.getString("ROI_BSP")));
								    		arrValues.add(strappno);
								    		arrValues.add(strFacSno);
								    		if(strRefType.equalsIgnoreCase("O"))
								    			arrValues.add("Business strategic Premium");
								    		else
								    			arrValues.add("Fixed Spread");	
								    		hshQuery.put("strQueryId", "upd_facilitymclrspreadval");
								    		hshQuery.put("arrValues", arrValues);
								    		hshqueryval.put("2", hshQuery);
								    		
								    		hshQuery = new HashMap();
								    		arrValues=new ArrayList();
								    		arrValues.add(Helper.correctDouble(rs2.getString("ROI_CRP")));
								    		arrValues.add(Helper.correctDouble(rs2.getString("ROI_BSP")));
								    		arrValues.add(strappno);
								    		arrValues.add(strFacSno);
								    		hshQuery.put("strQueryId", "upd_facilitymclrspread");
								    		hshQuery.put("arrValues", arrValues);
								    		hshqueryval.put("3", hshQuery);
								    		
								    		hshQuery=new HashMap();
											arrValues=new ArrayList();
											hshQuery.put("strQueryId", "upd_updatefacilityROI");
											arrValues.add(Helper.formatDoubleValue(dblMCLR));
											arrValues.add(Helper.formatDoubleValue(dblMCLR));
											arrValues.add(Helper.formatDoubleValue(dblMCLR));
											arrValues.add(Rating);
											arrValues.add(strappno);
											arrValues.add(strFacSno);
											hshQuery.put("arrValues", arrValues);
											hshqueryval.put("size", "4");
											hshqueryval.put("4", hshQuery);
											EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
								    		
										}
										
										
										
									}			
							}
					//end
					}
				}
				else
				{

					strQuery1 = SQLParser.getSqlQuery("select_loanaccdetails_retail^" + strappno);
					rs = DBUtils.executeQuery(strQuery1);
					if(rs.next())
							{
								strIntType=Helper.correctNull((String)rs.getString("loan_inttype"));
								strTenor=Helper.correctNull((String)rs.getString("loan_reqterms"));
								strFacId=Helper.correctNull((String)rs.getString("app_prdcode"));
									
								strProposedAmnt=nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("loan_recmdamt"))));
								strFacSno="1";
								strROIType=Helper.correctNull((String)rs.getString("loan_roitype"));
								dblMCLR=rs.getDouble("loan_baserate");
								if(strIntType.equalsIgnoreCase("Fixed"))
								{
									strIntType="fixed";
								}
								if(strIntType.equalsIgnoreCase("Floating"))
								{
									strIntType="floating";
								}
								
								//select sector
								rs2=DBUtils.executeLAPSQuery("sel_misappclassification^"+strappno+"^"+strFacSno);			
								if(rs2.next())
								{
									strsector=Helper.correctNull((String)rs2.getString("app_sector"));  //01 ,02
									strsensitiveSector=Helper.correctNull((String)rs2.getString("app_sensitivesector")); //11
								}
								if(rs2!=null) {rs2.close();}
								//end
								
								if(strROIType.equalsIgnoreCase("RATING")) {
									
									String strMCLRType="",strRefType="O";
						 			strMCLRType=Helper.correctNull(rs.getString("LOAN_MCLRTYPE"));
									if(!strMCLRType.equalsIgnoreCase(""))
					 				{
					 					String strArr[]=strMCLRType.split("@");
					 					if(strArr!=null && strArr.length>0)
					 					{
					 						if(rs1!=null)
												rs1.close();
											rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
											if(rs1.next())
											{
												if(strROIType.equalsIgnoreCase("O"))
													strROIType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
												else
												strRefType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
												
											}
					 					}
					 				}
									
									strQuery1 = SQLParser.getSqlQuery("selinttypefloatingrate^" + strIntType + "^" + strFacId + "^<=^"
											+ strProposedAmnt + "^>=^" + strProposedAmnt + "^"+strRefType+"^O^<=^" + strTenor + "^>=^" + strTenor );
										rs1=DBUtils.executeQuery(strQuery1);			
										if(rs1.next())
										{
											if(strsensitiveSector.equalsIgnoreCase("11")) {
											strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^"+Rating+"^"+Helper.correctNull((String)rs1.getString("prd_intid"))+"^"+Helper.correctNull((String)rs1.getString("prd_sno"))
													+"^"+strsensitiveSector);
											rs2 = DBUtils.executeQuery(strQuery1);
											}
											else if(strsector.equalsIgnoreCase("01") || strsector.equalsIgnoreCase("02"))
											{
												strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^" +Rating+"^"+Helper.correctNull((String)rs1.getString("prd_intid"))+"^"+Helper.correctNull((String)rs1.getString("prd_sno"))
														+"^"+strsector);
												rs2 = DBUtils.executeQuery(strQuery1);
											}
											else
											{
												strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd_retail^KB4^"+Helper.correctNull((String)rs1.getString("prd_intid"))+"^"+Helper.correctNull((String)rs1.getString("prd_sno"))
														+"^01");
												rs2 = DBUtils.executeQuery(strQuery1);
											}
											if(rs2.next())
											{
												dblMCLR+=rs2.getDouble("ROI_CRP")+rs2.getDouble("ROI_BSP");
												
												hshQuery=new HashMap();
												hshqueryval=new HashMap();
												arrValues=new ArrayList();
												hshQuery.put("strQueryId", "upd_updateLoandetROI");
												arrValues.add(Helper.formatDoubleValue(dblMCLR));
												arrValues.add(Helper.formatDoubleValue(dblMCLR));
												arrValues.add(Helper.correctDouble(rs2.getString("ROI_CRP")));
												arrValues.add(Helper.correctDouble(rs2.getString("ROI_BSP")));
												arrValues.add(Rating);
												arrValues.add(strappno);
												hshQuery.put("arrValues", arrValues);
												hshqueryval.put("size", "1");
												hshqueryval.put("1", hshQuery);
												EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
												
											}
											
											
									
										}			
								}
						}
			}
					
			}
			
			
		}
		catch (Exception ce) {
			throw new EJBException("Exception in UpdateRoiBasedOnrating====" + ce.toString());
		}
		finally
		{
			try
			{
				if(rs != null)
				{
					rs.close();
				}
			} catch (Exception cf) {
			throw new EJBException("Error closing the connection "
					+ cf.getMessage());

		}
	}
		//return hshResult;
	}
	
	public HashMap getApplicationRenew(HashMap hshValues)
	{
		
		
		java.text.NumberFormat jtn= java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null,rs2=null,rs1=null;
		HashMap hshResult = new HashMap();
		HashMap hshAppNew =  new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		PerApplicantBean perapp=new PerApplicantBean();
		
		String strOldAppno=Helper.correctNull((String)hshValues.get("hidApplicationno"));
		String strSolid=correctNull((String)hshValues.get("strSolid")); 
		String	strComappId=correctNull((String)hshValues.get("comapp_oldid")); 
		String	strFacilitySno=correctNull((String)hshValues.get("hidFacsno")); 
		if(strFacilitySno.equalsIgnoreCase("")){
			strFacilitySno=correctNull((String)hshValues.get("hidFacSno"));
		}
		String strAppno = "",strFinStd="0",strIndType="",strIndRating="",strLoanAmt="0";
		int intUpdatesize=0;
		String strLimitId="",strProposalin="R",strOrglevel="",strissaral="";
		strOrglevel=correctNull((String)hshValues.get("strOrgLevel"));
        strissaral=correctNull((String)hshValues.get("strIsSaral"));
        int iFacilitySno=0;
        String strModType="",strSno="",strQuery="";
        String strTermsType="P",strParentid="";
		String strTermsDel="N",strTerms="",strTermsno="",strMode="",strPrePost="",strhidType="",strCBSID="";
		String strInward="";
		if(Helper.correctNull((String)hshValues.get("sessionModuleType")).equalsIgnoreCase("CORP"))
		{
			strModType="C";
		}
		else
		{
			strModType="A";
		}
		try
		{
			String strFacdetails[]=new String[5];
			String strExistInwardNo="",strExistingAppno="";
			String strInwardno=Helper.correctNull((String)hshValues.get("txt_appinwardno"));
			strhidType=Helper.correctNull((String)hshValues.get("hidType"));
			if(strhidType.equalsIgnoreCase(""))
				strhidType=Helper.correctNull((String)hshValues.get("hidType1"));
			strAppno=Helper.correctNull((String)hshValues.get("hidAppno"));
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno=Helper.correctNull((String)hshValues.get("appno"));
			}
			String strFacsno[]=strFacilitySno.split("~");
			String strNewid=correctNull((String)hshValues.get("comapp_newid"));
			if(strNewid.equals(""))
			{
				strNewid=correctNull((String)hshValues.get("comapp_new_id"));	
			}
			strInward=Helper.correctNull((String)hshValues.get("strInward"));
			if(strhidType.equalsIgnoreCase("P") && !strInward.equalsIgnoreCase("Y"))
			{
				
				if(rs!=null)
					rs=null;
				
				for(int i=0;i<strFacsno.length; i++)
				{
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
					strExistingAppno=Helper.correctNull(strFacdetails[1]);
				}
				strQuery= SQLParser.getSqlQuery("sel_applications_renew^" + strExistingAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strExistInwardNo=correctNull(rs.getString("app_inwardno"));
				}
				
				strInwardno=perapp.getMaxInwardno(strSolid);
				
				if(rs!=null)
					rs=null;
					hshQuery=new HashMap();
					hshQueryValues=new HashMap();
					arrValues=new ArrayList();
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
					if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("A"))
					arrValues.add("1");//25
					else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("D"))
						arrValues.add("6");//25
					else if(Helper.correctNull((String)hshValues.get("strOrgLevel")).equalsIgnoreCase("C"))
						arrValues.add("5");//25
					else
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
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(rs2!=null){rs2.close();}
			if(!strComappId.equalsIgnoreCase(""))
			{
				rs2=DBUtils.executeLAPSQuery("Applicantname_sel^"+strComappId);							
				while(rs2.next())
				{
					strCBSID=correctNull(rs2.getString("perapp_cbsid"));
				}
			}
			if(strAppno.equalsIgnoreCase("")||strAppno.equalsIgnoreCase("new")){
//			if(true)
			{
//				if(!strCBSID.equalsIgnoreCase(""))
//				{
//					if(rs!=null)
//					{rs.close();}
//					intUpdatesize=0;
//					hshQueryValues=new HashMap();
//					strQuery=SQLParser.getSqlQuery("sel_op_ratingproposal^"+strCBSID);
//					rs=DBUtils.executeQuery(strQuery);
//					while(rs.next())
//					{
//						if(rs1!=null)
//						{rs1.close();}
//						String strRatAppNo=correctNull(rs.getString("fin_ratappno"));
//						strQuery=SQLParser.getSqlQuery("selcrefreezeflag^"+strRatAppNo);
//						rs1=DBUtils.executeQuery(strQuery);
//						if(rs1.next())
//						{
//							if(correctNull(rs1.getString("cre_rating")).equalsIgnoreCase("") && correctNull(rs1.getString("cre_weight")).equalsIgnoreCase(""))
//							{
//								intUpdatesize++;
//								hshQuery = new HashMap();
//								arrValues=new ArrayList();
//								hshQuery.put("strQueryId","updfinrating");
//								arrValues.add(strRatAppNo);
//								hshQuery.put("arrValues",arrValues);
//								hshQueryValues.put(""+intUpdatesize,hshQuery);
//								
//							}
//							
//						}
//						else
//						{
//							intUpdatesize++;
//							hshQuery = new HashMap();
//							arrValues=new ArrayList();
//							hshQuery.put("strQueryId","updfinrating");
//							arrValues.add(strRatAppNo);
//							hshQuery.put("arrValues",arrValues);
//							hshQueryValues.put(""+intUpdatesize,hshQuery);
//						}
//					}
//					hshQueryValues.put("size", ""+intUpdatesize);
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				}
				
				String strType="C";
				hshAppNew.put("comapp_id",strComappId);
				hshAppNew.put("apptype",strType);
				hshAppNew.put("strSolid",strSolid);
				strAppno=(String)EJBInvoker.executeStateLess("appeditlock",hshAppNew,"getAppno");
				hshResult.put("appno",strAppno);			
			}
			hshQueryValues=new HashMap();
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","insapplications");
			arrValues.add(strAppno);
			arrValues.add("4");
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add(correctNull((String)hshValues.get("strOrgCode")));
			arrValues.add(strModType);
			arrValues.add(strInwardno);
			arrValues.add(strProposalin);
			arrValues.add((strOrglevel.equalsIgnoreCase("D") && strissaral.equalsIgnoreCase("Y"))?"S":strOrglevel);
			arrValues.add(correctNull((String)hshValues.get("strUserId")));
			arrValues.add("Y");
			arrValues.add(null);
			arrValues.add(null);
			arrValues.add(null);
			arrValues.add("S");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","updatefacilityrenewflag");
			
			if(strhidType.equalsIgnoreCase("S"))
				arrValues.add("S");
			else if(strhidType.equalsIgnoreCase("P"))
				arrValues.add("P");
			else
				arrValues.add("R");
			
			arrValues.add(correctNull(strAppno));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","commapplicantloanins2");
			arrValues.add(strAppno);

			if(strComappId.trim().equals(""))
			{
				strComappId="0";
			}
			arrValues.add(strComappId);
			arrValues.add(strFinStd);
			arrValues.add(strIndType);
			arrValues.add(strIndRating);
			arrValues.add("N");
			arrValues.add(strNewid);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","commworkflowins");
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
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize = intUpdatesize+1;
			hshQuery.put("strQueryId","commapplicantloanins3");
			arrValues.add(strAppno);
			arrValues.add("0");
			arrValues.add("0");
			arrValues.add(strLoanAmt);
			arrValues.add(strLoanAmt);
			arrValues.add(strLoanAmt);
			arrValues.add("0");
			arrValues.add("0");
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("size",Integer.toString(intUpdatesize));
			hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			intUpdatesize++;
			
			hshQuery.put("strQueryId","insprosalvaluesin");
			arrValues.add(correctNull(strAppno));
			arrValues.add(strProposalin);
			hshQuery.put("arrValues",arrValues);
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
			
			
			//Terms and Condidtions
			
			if(strModType.equalsIgnoreCase("C")){
				if(!strhidType.equalsIgnoreCase("P"))
				{
				rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"C"+"^"+"G"+"^"+"pre");							
				while(rs2.next())
				{
					strTermsno = rs2.getString("fac_sno");
					strTerms = rs2.getString("fac_terms");
					strMode= rs2.getString("fac_mode");
					strPrePost=rs2.getString("fac_prepost");
					strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","insfacterms");								
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(strSno));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strModType));
					arrValues.add(strTermsno);
					arrValues.add(correctNull(strTerms));
					arrValues.add(correctNull(strTermsType));
					arrValues.add(correctNull(strTermsDel));
					arrValues.add(" ");
					arrValues.add("N");
					arrValues.add(strPrePost);
					arrValues.add(strMode);
					arrValues.add(strParentid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

				}
				if(rs2 !=null){
				rs2.close();
			}
				rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"C"+"^"+"G"+"^"+"post");			
				while(rs2.next())
				{
					strTermsno = rs2.getString("fac_sno");
					strTerms = rs2.getString("fac_terms");
					strMode= rs2.getString("fac_mode");
					strPrePost=rs2.getString("fac_prepost");
					strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
					intUpdatesize = intUpdatesize+1;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","insfacterms");								
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(strSno));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strModType));
					arrValues.add(strTermsno);
					arrValues.add(correctNull(strTerms));
					arrValues.add(correctNull(strTermsType));
					arrValues.add(correctNull(strTermsDel));
					arrValues.add(" ");
					arrValues.add("N");
					arrValues.add(strPrePost);
					arrValues.add(strMode);
					arrValues.add(strParentid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

				}
				}
				if(rs2 !=null){
					rs2.close();
				}
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"B");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"P");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
					
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"C"+"^"+"O");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
			}else if(strModType.equalsIgnoreCase("A")){	
				if(!strhidType.equalsIgnoreCase("P"))
				{

				rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"A"+"^"+"G"+"^"+"pre");							
				while(rs2.next())
				{
					strTermsno = rs2.getString("fac_sno");
					strTerms = rs2.getString("fac_terms");
					strMode= rs2.getString("fac_mode");
					strPrePost=rs2.getString("fac_prepost");
					strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","insfacterms");								
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(strSno));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strModType));
					arrValues.add(strTermsno);
					arrValues.add(correctNull(strTerms));
					arrValues.add(correctNull(strTermsType));
					arrValues.add(correctNull(strTermsDel));
					arrValues.add(" ");
					arrValues.add("N");
					arrValues.add(strPrePost);
					arrValues.add(strMode);
					arrValues.add(strParentid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);						

				}
				if(rs2 !=null){
				rs2.close();
			}
				rs2=DBUtils.executeLAPSQuery("select_generaltermsconditions^"+"A"+"^"+"G"+"^"+"post");			
				while(rs2.next())
				{
					strTermsno = rs2.getString("fac_sno");
					strTerms = rs2.getString("fac_terms");
					strMode= rs2.getString("fac_mode");
					strPrePost=rs2.getString("fac_prepost");
					strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					intUpdatesize = intUpdatesize+1;
					hshQuery.put("strQueryId","insfacterms");								
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(strSno));
					arrValues.add(correctNull(""));
					arrValues.add(correctNull(strModType));
					arrValues.add(strTermsno);
					arrValues.add(correctNull(strTerms));
					arrValues.add(correctNull(strTermsType));
					arrValues.add(correctNull(strTermsDel));
					arrValues.add(" ");
					arrValues.add("N");
					arrValues.add(strPrePost);
					arrValues.add(strMode);
					arrValues.add(strParentid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

				}
				}
				
				if(rs2 !=null){
					rs2.close();
				}
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"B");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"P");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
					
					rs2=DBUtils.executeLAPSQuery("sel_Specifidtermsconditions^"+"A"+"^"+"O");			
					while(rs2.next())
					{
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
						intUpdatesize = intUpdatesize+1;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(strSno));
						arrValues.add(correctNull(""));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");
						arrValues.add(strPrePost);
						arrValues.add(strMode);
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);							

					}
					if(rs2 !=null){
						rs2.close();
					}
			}
		
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}else{
				if(rs2 !=null)
				{rs2.close();}
				if(!strAppno.equalsIgnoreCase(""))
				{
					rs2=DBUtils.executeLAPSQuery("maxfacilitysno^"+strAppno);
					if(rs2.next())
					{
						iFacilitySno=rs2.getInt(1);
						--iFacilitySno;
					}
				}
			}
			HashMap hsh=new HashMap();
			hshQueryValues=new HashMap();
			if(strhidType.equalsIgnoreCase("R"))
			{
				Connection connectDB2 = ConnectionFactory.getConnection();
				for(int i=0;i<strFacsno.length; i++)
				{
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
					if(strFacdetails[3].equalsIgnoreCase("R")||strFacdetails[3].equalsIgnoreCase("O"))
					{
						++iFacilitySno;
						hsh.put(strFacdetails[1]+"@"+strFacdetails[0], String.valueOf(iFacilitySno));
						CallableStatement callableStmt2 = connectDB2.prepareCall("call RENEW_APPLICATION_FACSNONEW(?,?,?,?)");
						callableStmt2.setString(1,Helper.correctNull(strFacdetails[1]));
						callableStmt2.setString(2,Helper.correctNull(strAppno));
						callableStmt2.setString(3,Helper.correctNull(strFacdetails[0]));
						callableStmt2.setString(4,iFacilitySno+"");
						callableStmt2.execute();
						callableStmt2.clearParameters();
						callableStmt2.close();
					}
				}
				connectDB2.close();
			}
			
			if(strhidType.equalsIgnoreCase("R")||strhidType.equalsIgnoreCase("S"))
			{
				intUpdatesize=0;
				for(int i=0;i<strFacsno.length; i++)
				{
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
					if(strFacdetails[3].equalsIgnoreCase("R"))
					{
						ArrayList arrSecDet=new ArrayList();
						ArrayList arrPromoterDet=new ArrayList();
						
						if(rs2!=null)
							rs2.close();
						strQuery=SQLParser.getSqlQuery("select_securityid_primary^"+strFacdetails[1]+"^ app_sec_facsno='"+strFacdetails[0]+"'^P");
						rs2=DBUtils.executeQuery(strQuery);			
						while(rs2.next())
						{
							arrSecDet.add(Helper.correctNull(rs2.getString("app_sec_secid")));
						}
						
						if(rs2!=null)
							rs2.close();
						rs2=DBUtils.executeLAPSQuery("selguarantorappid^"+strFacdetails[0]+"^"+strFacdetails[1]);			
						while(rs2.next())
						{
							arrPromoterDet.add(Helper.correctNull(rs2.getString("appid")));
						}
						
						double dblAmt=0;
						for(int j=0;j<strFacsno.length; j++)
						{
							String facilitydetails1=strFacsno[j];
							String[] strFacdetails1=facilitydetails1.split("@"); 
							if(facilitydetails1.contains("@"+strFacdetails[1]+"@"+strFacdetails[0]) &&(strFacdetails1[3].equalsIgnoreCase("D")||strFacdetails1[3].equalsIgnoreCase("A")))
							{
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("select_facilityCode^"+strFacdetails1[1]+"^"+strFacdetails1[0]);			
								if(rs2.next())
								{
									dblAmt+=rs2.getDouble("facility_sancamt");
								}
								
								intUpdatesize = intUpdatesize+1;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","ins_facility_additionaldetails");	
								arrValues.add(strAppno);
								arrValues.add(Helper.correctNull((String)hsh.get(strFacdetails[1]+"@"+strFacdetails[0])));
								arrValues.add(strFacdetails1[1]);
								arrValues.add(strFacdetails1[0]);
								arrValues.add(strFacdetails1[3]);
								arrValues.add(strhidType);
								arrValues.add(strFacdetails[1]);
								arrValues.add(strFacdetails[0]);
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
								
								
								if(rs2!=null)
									rs2.close();
								strQuery=SQLParser.getSqlQuery("select_securityid_primary^"+strFacdetails[1]+"^ app_sec_facsno='"+strFacdetails[0]+"'^P");
								rs2=DBUtils.executeQuery(strQuery);	
								while(rs2.next())
								{
									if(!arrSecDet.contains(Helper.correctNull(rs2.getString("app_sec_secid"))))
									{
										intUpdatesize = intUpdatesize+1;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","insappsecuritydetailsrenew");	
										arrValues.add(strAppno);
										arrValues.add(Helper.correctNull((String)hsh.get(strFacdetails[1]+"@"+strFacdetails[0])));
										arrValues.add(strFacdetails[1]);
										arrValues.add(strFacdetails[0]);
										arrValues.add(Helper.correctNull(rs2.getString("app_sec_secid")));
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}
								}
								
								if(rs2!=null)
									rs2.close();
								rs2=DBUtils.executeLAPSQuery("selguarantorappid^"+strFacdetails[0]+"^"+strFacdetails[1]);			
								while(rs2.next())
								{
									
									if(!arrPromoterDet.contains(Helper.correctNull(rs2.getString("appid"))))
									{
										intUpdatesize = intUpdatesize+1;
										hshQuery = new HashMap();
										arrValues=new ArrayList();
										hshQuery.put("strQueryId","inscom_companydetailsrenew");	
										arrValues.add(strAppno);
										arrValues.add(Helper.correctNull((String)hsh.get(strFacdetails[1]+"@"+strFacdetails[0])));
										arrValues.add(strFacdetails[1]);
										arrValues.add(strFacdetails[0]);
										arrValues.add(Helper.correctNull(rs2.getString("appid")));
										hshQuery.put("arrValues",arrValues);
										hshQueryValues.put("size",Integer.toString(intUpdatesize));
										hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
									}
								}
								
								
								
							}
						}
						if(strhidType.equalsIgnoreCase("R") && dblAmt>0)
						{
							intUpdatesize = intUpdatesize+1;
							hshQuery = new HashMap();
							arrValues=new ArrayList();
							hshQuery.put("strQueryId","upd_facility_sancamt");								
							arrValues.add(Helper.formatDoubleValue(dblAmt));
							arrValues.add(strAppno);
							arrValues.add(Helper.correctNull((String)hsh.get(strFacdetails[1]+"@"+strFacdetails[0])));
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("size",Integer.toString(intUpdatesize));
							hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
						}
					}
				}
				
				if(intUpdatesize>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				hshQueryValues=new HashMap();
				intUpdatesize=0;
				
				for(int i=0;i<strFacsno.length; i++)
				{
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
					if(strFacdetails[3].equalsIgnoreCase("R"))
					{
						if(rs2!=null)
							rs2.close();
						strQuery = SQLParser.getSqlQuery("sel_adhocFacility^" + strFacdetails[1]+"^"+strFacdetails[0]);
						rs2 = DBUtils.executeQuery(strQuery);
						while(rs2.next())
						{
							if(rs!=null)
								rs.close();
							strQuery = SQLParser.getSqlQuery("chk_facility_additionaldetails^" + strAppno+"^"+Helper.correctNull(rs2.getString("facility_appno"))+"^"+Helper.correctNull(rs2.getString("facility_sno"))+"^"+strhidType);
							rs = DBUtils.executeQuery(strQuery);
							if(!rs.next())
							{
								intUpdatesize = intUpdatesize+1;
								hshQuery = new HashMap();
								arrValues=new ArrayList();
								hshQuery.put("strQueryId","ins_comfacility_details");								
								arrValues.add(strAppno);
								arrValues.add(Helper.correctNull((String)hsh.get(strFacdetails[1]+"@"+strFacdetails[0])));
								arrValues.add(Helper.correctNull(rs2.getString("facility_appno")));
								arrValues.add(Helper.correctNull(rs2.getString("facility_sno")));
								arrValues.add(strFacdetails[1]);
								arrValues.add(strFacdetails[0]);
								arrValues.add("P");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put("size",Integer.toString(intUpdatesize));
								hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
							}
						}
					}
				}
				
				if(intUpdatesize>0)
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strhidType.equalsIgnoreCase("P"))
			{
				Connection connectDB2 = ConnectionFactory.getConnection();
				for(int i=0;i<strFacsno.length; i++)
				{
					++iFacilitySno;
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
					CallableStatement callableStmt2 = connectDB2.prepareCall("call POST_SANCTION_PROPOSAL_COPY(?,?,?,?)");
					callableStmt2.setString(1,Helper.correctNull(strFacdetails[1]));
					callableStmt2.setString(2,Helper.correctNull(strAppno));
					callableStmt2.setString(3,Helper.correctNull(strFacdetails[0]));
					callableStmt2.setString(4,iFacilitySno+"");
					callableStmt2.execute();
					callableStmt2.clearParameters();
					callableStmt2.close();
				}
				connectDB2.close();
			}
			/*
			 * For Inserting Data in app_renewal table 
			 */
			hshQueryValues=new HashMap();
			intUpdatesize=0;
			for(int i=0;i<strFacsno.length; i++)
			{
					++intUpdatesize;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
				
					String facilitydetails=strFacsno[i];
					strFacdetails=facilitydetails.split("@");
				
					hshQuery.put("strQueryId","updaterenewfacility");
					if(strhidType.equalsIgnoreCase("S"))
					arrValues.add("S");
					else if(strhidType.equalsIgnoreCase("P"))
					arrValues.add("P");
					else
					arrValues.add("Y");
					arrValues.add(Helper.correctNull(strFacdetails[1]));
					arrValues.add(Helper.correctNull(strFacdetails[0]));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
				
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					
				
				if(strhidType.equalsIgnoreCase("S"))
				{
					String strCount="";
					String strQueryCount = SQLParser.getSqlQuery("sel_restraccountcount^"+strFacdetails[2]);
					ResultSet rsCount = DBUtils.executeQuery(strQueryCount);
					if(rsCount.next())
					{
						strCount = Helper.correctInt((String)rsCount.getString("countval"));
					}
					if(strFacdetails[3].equalsIgnoreCase("R")||strFacdetails[3].equalsIgnoreCase("O"))
					{
						++intUpdatesize;
						hshQuery=new HashMap();
						arrValues=new ArrayList();
					
						hshQuery.put("strQueryId","insapprestructure");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull(strFacdetails[1]));
						arrValues.add(Helper.correctNull(strFacdetails[0]));
						arrValues.add(Helper.correctNull(strFacdetails[2]));
						arrValues.add(strModType);
						arrValues.add("");
						arrValues.add(strCount);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
					
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
				}
				if(strhidType.equalsIgnoreCase("P"))
				{
					++intUpdatesize;
					hshQuery=new HashMap();
					arrValues=new ArrayList();
					
					hshQuery.put("strQueryId","insapppostsanction");
					arrValues.add(strAppno);
					rs2=DBUtils.executeLAPSQuery("selfacilitysno^"+strAppno+"^"+strFacdetails[1]+"^"+strFacdetails[0]);
					if(rs2.next())
					{
						arrValues.add(Helper.correctInt(rs2.getString("facility_sno")));	
					}
					arrValues.add(Helper.correctNull(strFacdetails[1]));
					arrValues.add(Helper.correctNull(strFacdetails[0]));
					arrValues.add("");
					arrValues.add("");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
			}
			
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			if(strhidType.equalsIgnoreCase("R"))
			{
			String Facility_code="",Facility_sno="";
			strQuery = SQLParser.getSqlQuery("per_applicationsmargin_select^" + strAppno);
			
			if(rs != null)
			{
				rs.close();
			}
			intUpdatesize=0;
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQueryValues=new HashMap();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				Facility_code=Helper.correctNull((String)rs.getString("facility_code"));
				Facility_sno=Helper.correctNull((String)rs.getString("facility_sno"));
				strQuery=SQLParser.getSqlQuery("seltermsandcondition^"+strAppno+"^"+strModType+"^P"+"^"+Facility_code);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next()){}
				else{
					rs2=DBUtils.executeLAPSQuery("seltermsmaster^"+Facility_code);
					strTermsType="P";
					strTermsDel="N";
					while(rs2.next())
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						strTermsno = rs2.getString("fac_sno");
						strTerms = rs2.getString("fac_terms");
						strMode= rs2.getString("fac_mode");
						strPrePost=rs2.getString("fac_prepost");
						strParentid=Helper.correctInt((String)rs2.getString("FAC_PARENT_ID"));
					if(strModType.equalsIgnoreCase("C")){
						++intUpdatesize;
						hshQuery.put("strQueryId","insfacterms");								
						arrValues.add(correctNull(strAppno));
						arrValues.add(correctNull(Facility_sno));
						arrValues.add(correctNull(Facility_code));
						arrValues.add(correctNull(strModType));
						arrValues.add(strTermsno);
						arrValues.add(correctNull(strTerms));
						arrValues.add(correctNull(strTermsType));
						arrValues.add(correctNull(strTermsDel));
						arrValues.add(" ");
						arrValues.add("N");	
						arrValues.add(strPrePost);
						arrValues.add(strMode);	
						arrValues.add(strParentid);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}if(strModType.equalsIgnoreCase("A")){
					++intUpdatesize;
					hshQuery.put("strQueryId","insfacterms");								
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(Facility_sno));
					arrValues.add(correctNull(Facility_code));
					arrValues.add(correctNull(strModType));
					arrValues.add(strTermsno);
					arrValues.add(correctNull(strTerms));
					arrValues.add(correctNull(strTermsType));
					arrValues.add(correctNull(strTermsDel));
					arrValues.add(" ");
					arrValues.add("N");	
					arrValues.add(strPrePost);
					arrValues.add(strMode);
					arrValues.add(strParentid);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size",Integer.toString(intUpdatesize));
					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				}
					
				}
				}
				
				if(rs1!=null)
					rs1.close();
				
				strQuery=SQLParser.getSqlQuery("sel_facility_availability^"+Facility_code);
				rs1=DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					if(Helper.correctNull(rs1.getString("com_facility_stop")).equalsIgnoreCase("1"))
					{
						++intUpdatesize;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_facilityreattach");								
						arrValues.add("Y");
						arrValues.add(strAppno);
						arrValues.add(Facility_sno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
					else
					{
						++intUpdatesize;
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","upd_facilityreattach");								
						arrValues.add("N");
						arrValues.add(strAppno);
						arrValues.add(Facility_sno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("size",Integer.toString(intUpdatesize));
						hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
					}
				}
				
				
				
			}
			if(rs!=null)
			{rs.close();
			}
			
			
			{
				++intUpdatesize;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_mis_appdetails");								
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			if(strModType.equalsIgnoreCase("A"))
			{
				++intUpdatesize;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updfacilitygovtschemforagri");								
				arrValues.add("2");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add("0");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
			}
			
			if(intUpdatesize>0)
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			}
			else if(strhidType.equalsIgnoreCase("P"))
			{
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","upd_facilityreattachall");
				arrValues.add("N");
				arrValues.add(correctNull(strAppno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("select_latestsancprop^"+strAppno);
				if(rs.next())
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","ins_ratingdet_postsanction");
					arrValues.add(strAppno);
					arrValues.add(correctNull(rs.getString("app_no")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","2");
					hshQueryValues.put("2",hshQuery);
					
				}
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			
			if(strhidType.equalsIgnoreCase("R"))
			{
				hshQueryValues=new HashMap();
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","delete_comcomments1");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","1");
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","com_shareholdpatterndel1");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size","2");
				hshQueryValues.put("2",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("select_latestsancprop^"+strAppno);
				if(rs.next())
				{
					hshQueryValues=new HashMap();
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","renew_comcomments");
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(rs.getString("app_no")));
					arrValues.add("brief");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","renew_comcomments");
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(rs.getString("app_no")));
					arrValues.add("brief1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","2");
					hshQueryValues.put("2",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","renew_comcomments");
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(rs.getString("app_no")));
					arrValues.add("MangementInfo");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","3");
					hshQueryValues.put("3",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","renew_com_shareholdpattern");
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(rs.getString("app_no")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","4");
					hshQueryValues.put("4",hshQuery);
					
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					hshQuery.put("strQueryId","renew_managementinfo");
					arrValues.add(correctNull(strAppno));
					arrValues.add(correctNull(rs.getString("app_no")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("size","5");
					hshQueryValues.put("5",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				
//				if(rs!=null)
//					rs.close();
//				rs=DBUtils.executeLAPSQuery("selgovtsceme^"+strAppno);
//				while(rs.next())
//				{
//					hshQueryValues = new HashMap();
//					
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					hshQuery.put("strQueryId","renew_com_companydetails");
//					arrValues.add(correctNull(strAppno));
//					arrValues.add(correctNull(rs.getString("facility_sno")));
//					arrValues.add(correctNull(rs.getString("facility_oldappno")));
//					arrValues.add(correctNull(rs.getString("facility_oldappsno")));
//					hshQuery.put("arrValues",arrValues);
//					hshQueryValues.put("size","1");
//					hshQueryValues.put("1",hshQuery);
//					
//					
//					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
//				}
				
				
				
			}
			
			
			
			
			
			/*if(strhidType.equalsIgnoreCase("S"))
			{
				intUpdatesize=1;
				hshQueryValues=new HashMap();
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","updfacilityrenewflag");
				arrValues.add("S");
				arrValues.add(correctNull(strAppno));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("size",Integer.toString(intUpdatesize));
				hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}*/
			/*
			 * End
			 */
			
			hshResult.put("strhidType", strhidType);
			hshResult.put("appno", strAppno);
			hshResult.put("comappid", strComappId);
		
		}
		catch (Exception ce) 
		{
			throw new EJBException("inside getApplicationRenew" + ce.toString());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection " + cf.getMessage());
			}
		}
		
		return hshResult;
	}
	
	public HashMap getPSOldSanctionedData(HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strQuery = "",strQuery1 = "";
		ResultSet rs = null,rs1 = null;
		
		ArrayList arrayCol = new ArrayList();
		
		ArrayList arrSecRow = new ArrayList();
		ArrayList arrSecCol = new ArrayList();
		double dblTotal=0.00;
		
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
		
		String strCityCode="";
		String strStateCode="";
		String strDistCode="";
		String strDistrict="";
		String strCity="";
		String strState="";
		String strOrgCode="";
		String strOrgName="";
		
		String strAppno="",strSno="";
		String strOldAppno="",strOldSno="";
		String strCBSaccno="",strModuleType="";
		String strIntSubtype = "",strBankArrgmt="",strInsFreq="",strRepayType="";
		
		try
		{
			strAppno = Helper.correctNull((String)hshValues.get("appno"));
			strSno = Helper.correctNull((String)hshValues.get("sel_facilitysno"));
			strModuleType = Helper.correctNull((String)hshValues.get("apploantype"));
			
			if(strModuleType.equalsIgnoreCase("P"))
			{
				strSno = "1";
			}
			if(strSno.equalsIgnoreCase(""))
			{
				strSno = "0";
			}
			String strJoint = "and PS_APP_SNO='"+strSno+"'";
			strQuery = SQLParser.getSqlQuery("sel_PS_oldaccnum^"+strAppno+"^"+strJoint);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strOldAppno = Helper.correctNull((String)rs.getString("PS_OLD_APP_NO"));
				strOldSno = Helper.correctNull((String)rs.getString("PS_OLD_APP_SNO"));
			}
			hshRecord.put("strOldAppno", strOldAppno);
			hshRecord.put("strOldSno", strOldSno);
			//For Application basic details
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_PS_oldaccsancdetails^"+strOldAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("strOldAppno", strOldAppno);
				hshRecord.put("orgname", Helper.correctNull((String)rs.getString("branch")));
				hshRecord.put("create_date", Helper.correctNull((String)rs.getString("create_date")));
				hshRecord.put("sanc_date", Helper.correctNull((String)rs.getString("sanc_date")));
				hshRecord.put("sanc_user", Helper.correctNull((String)rs.getString("sanc_user")));
				hshRecord.put("sanc_refno", Helper.correctNull((String)rs.getString("SANCTIONREFNO")));
				hshRecord.put("inward_num", Helper.correctNull((String)rs.getString("INWARD_NO")));
				hshRecord.put("inward_createdon", Helper.correctNull((String)rs.getString("inward_createdon")));
				hshRecord.put("APP_PRDCODE", Helper.correctNull((String)rs.getString("APP_PRDCODE")));
				
				strModuleType = Helper.correctNull((String)rs.getString("APP_LOANTYPE"));
			}
			
			//For facility details
			if(rs!=null)rs.close();
			if(strModuleType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("sel_PS_oldfacilities_ret^"+strOldAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("fac_nature", Helper.correctNull((String)rs.getString("fac_nature")));
					hshRecord.put("fac_desc", Helper.correctNull((String)rs.getString("PRD_DESC")));
					hshRecord.put("fac_proposed", Helper.correctNull((String)rs.getString("LOAN_AMTREQD")));
					hshRecord.put("fac_sanctioned", Helper.correctNull((String)rs.getString("LOAN_RECMDAMT")));
					hshRecord.put("int_type", Helper.correctNull((String)rs.getString("LOAN_INTTYPE")));
					hshRecord.put("fac_intrate", Helper.correctNull((String)rs.getString("LOAN_INTRATE")));
					hshRecord.put("fac_sancintrate", Helper.correctNull((String)rs.getString("LOAN_MODINTRATE")));
					hshRecord.put("govt_scheme", Helper.correctNull((String)rs.getString("govt_scheme")));
					hshRecord.put("scheme_type", Helper.correctNull((String)rs.getString("GOVT_SCHEME")));
					hshRecord.put("subsidy_type", Helper.correctNull((String)rs.getString("LOAN_SUB")));
					hshRecord.put("spons_agency", Helper.correctNull((String)rs.getString("LOAN_SPONSERAGENCY")));
					hshRecord.put("subs_type", Helper.correctNull((String)rs.getString("LOAN_SUBSIDYTYPE")));
					hshRecord.put("BANKSCHEME", Helper.correctNull((String)rs.getString("PRD_BANKSCHEME")));
					hshRecord.put("holiday_period", Helper.correctNull((String)rs.getString("LOAN_NOOFINSTALLMENT")));
					hshRecord.put("loan_period", Helper.correctNull((String)rs.getString("LOAN_REQTERMS")));
					strCBSaccno = Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
					
					strInsFreq = Helper.correctNull((String)rs.getString("LOAN_PERIODICITY"));
					if(strInsFreq.equalsIgnoreCase("m"))
						strInsFreq = "Monthly";
					else if(strInsFreq.equalsIgnoreCase("q"))
						strInsFreq ="Quartely";
					else if(strInsFreq.equalsIgnoreCase("h"))
						strInsFreq ="Half yearly";
					else if(strInsFreq.equalsIgnoreCase("y"))
						strInsFreq ="Yearly";
					else if(strInsFreq.equalsIgnoreCase("n"))
						strInsFreq ="Not Applicable";
					
					hshRecord.put("strInsFreq", strInsFreq);
					
					strRepayType = Helper.correctNull((String)rs.getString("LOAN_REPAYMENTTYPE"));
					if(strRepayType.equalsIgnoreCase("13"))
						strRepayType = "Equal Monthly Installments";
					else if(strRepayType.equalsIgnoreCase("1"))
						strRepayType = "EMI";
					else if(strRepayType.equalsIgnoreCase("2"))
						strRepayType = "Non EMI";
					else if(strRepayType.equalsIgnoreCase("8"))
						strRepayType = "Bullet";
					else if(strRepayType.equalsIgnoreCase("12"))
						strRepayType = "On Demand";
					
					hshRecord.put("strRepayType", strRepayType);
				}
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_PS_oldfacilities_corp^"+strOldAppno+"^"+strOldSno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("fac_nature", Helper.correctNull((String)rs.getString("fac_nature")));
					hshRecord.put("fac_desc", Helper.correctNull((String)rs.getString("COM_FACDESC")));
					hshRecord.put("fac_proposed", Helper.correctNull((String)rs.getString("FACILITY_PROPOSED")));
					hshRecord.put("fac_sanctioned", Helper.correctNull((String)rs.getString("FACILITY_SANCAMT")));
					hshRecord.put("int_type", Helper.correctNull((String)rs.getString("int_type")));
					hshRecord.put("fac_intrate", Helper.correctNull((String)rs.getString("BPLR")));
					hshRecord.put("fac_sancintrate", Helper.correctNull((String)rs.getString("FACILITY_SANCINTEREST")));
					hshRecord.put("leader_bank", Helper.correctNull((String)rs.getString("leader_bank")));
					hshRecord.put("govt_scheme", Helper.correctNull((String)rs.getString("govt_scheme")));
					hshRecord.put("due_date", Helper.correctNull((String)rs.getString("due_date")));
					hshRecord.put("scheme_type", Helper.correctNull((String)rs.getString("FACILITY_SCHEMETYPE")));
					hshRecord.put("subsidy_amount", Helper.correctNull((String)rs.getString("FACILITY_SUBSIDYAMUNT")));
					hshRecord.put("spons_agency", Helper.correctNull((String)rs.getString("FACILITY_SPONSAGENCY")));
					hshRecord.put("subs_type", Helper.correctNull((String)rs.getString("FACILITY_SUBSIDYTYPE")));
					hshRecord.put("BANKSCHEME", Helper.correctNull((String)rs.getString("COM_BANKSCHEME")));
					hshRecord.put("holiday_period", Helper.correctNull((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
					hshRecord.put("loan_period", Helper.correctNull((String)rs.getString("FACILITY_MONTHS")));
					strCBSaccno = Helper.correctNull((String)rs.getString("CBS_ACCOUNTNO"));
					
					if(Helper.correctNull((String)rs.getString("FACILITY_GROUP")).equalsIgnoreCase("0"))
						hshRecord.put("limit_type", "Main Limit");
					else
						hshRecord.put("limit_type", "Sub Limit");
					
					strIntSubtype = Helper.correctNull((String)rs.getString("FACILITY_INTSUBTYPE"));
					if(strIntSubtype.equalsIgnoreCase("BR"))
						strIntSubtype = "Base Rate";
					else if(strIntSubtype.equalsIgnoreCase("BRLEC"))
						strIntSubtype = "BR linked Export Credit";
					else if(strIntSubtype.equalsIgnoreCase("BPLR"))
						strIntSubtype = "BPLR";
					else if(strIntSubtype.equalsIgnoreCase("LIBOR"))
						strIntSubtype = "LIBOR";
					else if(strIntSubtype.equalsIgnoreCase("EURIBOR"))
						strIntSubtype = "EURIBOR";
					else if(strIntSubtype.equalsIgnoreCase("EUROLIBOR"))
						strIntSubtype = "EUROLIBOR";
					else if(strIntSubtype.equalsIgnoreCase("COMMI"))
						strIntSubtype = "Commission";
					else if(strIntSubtype.equalsIgnoreCase("SMTB"))
						strIntSubtype = "6 MONTHS TREASURY BILL";
					else if(strIntSubtype.equalsIgnoreCase("TYGS"))
						strIntSubtype = "10 YEAR GOVT SECURITY";
					else if(strIntSubtype.equalsIgnoreCase("NOTAP"))
						strIntSubtype = "Not Applicable";
					else if(strIntSubtype.equalsIgnoreCase("MCLR"))
						strIntSubtype = "MCLR";
					else if(strIntSubtype.equalsIgnoreCase("MCLEC"))
						strIntSubtype = "MCLR linked Export Credit";
					
					hshRecord.put("strIntSubtype", strIntSubtype);

					strBankArrgmt = Helper.correctNull((String)rs.getString("FACILITY_PROPBANKTYPE"));
					if(strBankArrgmt.equalsIgnoreCase("S"))
						strBankArrgmt = "Sole";
					else if(strBankArrgmt.equalsIgnoreCase("C"))
						strBankArrgmt ="Consortium";
					else if(strBankArrgmt.equalsIgnoreCase("M"))
						strBankArrgmt ="Multiple";
					
					hshRecord.put("strBankArrgmt", strBankArrgmt);
					
					strInsFreq = Helper.correctNull((String)rs.getString("FACILITY_PERINSTALL"));
					if(strInsFreq.equalsIgnoreCase("m"))
						strInsFreq = "Monthly";
					else if(strInsFreq.equalsIgnoreCase("q"))
						strInsFreq ="Quartely";
					else if(strInsFreq.equalsIgnoreCase("h"))
						strInsFreq ="Half yearly";
					else if(strInsFreq.equalsIgnoreCase("y"))
						strInsFreq ="Yearly";
					else if(strInsFreq.equalsIgnoreCase("n"))
						strInsFreq ="Not Applicable";
					
					hshRecord.put("strInsFreq", strInsFreq);
					
					strRepayType = Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE"));
					if(strRepayType.equalsIgnoreCase("E"))
						strRepayType = "EMI";
					else if(strRepayType.equalsIgnoreCase("NE"))
						strRepayType = "Non-EMI";
					else if(strRepayType.equalsIgnoreCase("OD"))
						strRepayType = "On Demand";
					else if(strRepayType.equalsIgnoreCase("LC"))
						strRepayType = "As Per LC Terms";
					else if(strRepayType.equalsIgnoreCase("CO"))
						strRepayType = "As Per Contract Terms";
					else if(strRepayType.equalsIgnoreCase("BG"))
						strRepayType = "As Per BG Rules";
					else if(strRepayType.equalsIgnoreCase("DD"))
						strRepayType = "On Due Date";
					else if(strRepayType.equalsIgnoreCase("PC"))
						strRepayType = "PC: From the proceeds of PSC / by realization of bill";
					else if(strRepayType.equalsIgnoreCase("PS"))
						strRepayType = "PSC by Realization of Export Bills";
					else if(strRepayType.equalsIgnoreCase("PR"))
						strRepayType = "By Realization of Respective Bills";
					else if(strRepayType.equalsIgnoreCase("TG"))
						strRepayType = "As per TCBG Rules";
					
					hshRecord.put("strRepayType", strRepayType);
				}
			}
			hshRecord.put("strCBSaccno", strCBSaccno);
			
			//For Security attachments
			if(rs!=null)rs.close();
			if(strModuleType.equalsIgnoreCase("P"))
			{
				strQuery = SQLParser.getSqlQuery("sel_security_details_PS^"+strOldAppno+"^"+Helper.correctNull((String)hshRecord.get("APP_PRDCODE")));
			}
			else
			{
				strQuery = SQLParser.getSqlQuery("sel_security_details_PS^"+strOldAppno+"^"+strOldSno);
			}
			rs= DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrSecCol = new ArrayList();
				arrSecCol.add(Helper.correctNull((String)rs.getString("APP_SEC_SECID")));//0
				arrSecCol.add(Helper.correctNull((String)rs.getString("sec_classi")));//1
				arrSecCol.add(Helper.correctNull((String)rs.getString("sec_type")));//2
				arrSecCol.add(Helper.correctNull((String)rs.getString("APP_SEC_SECURITYVALUE")));//3
				arrSecCol.add(Helper.correctNull((String)rs.getString("APP_SEC_MARGIN")));//4
				arrSecRow.add(arrSecCol);
			}
			hshRecord.put("arrSecRow", arrSecRow);
			
			
			// For repayment schedule
			if(rs!=null)rs.close();
			strQuery = SQLParser.getSqlQuery("sel_tl_repayschedule^"+strOldAppno+"^"+strOldSno);
			rs=DBUtils.executeQuery(strQuery);  						
			ArrayList arrRepaySchedule=new ArrayList();     
			while(rs.next())
			{
				arrayCol = new ArrayList();
				arrayCol.add(correctNull(rs.getString("TL_FEQUENCY")));
				arrayCol.add(correctNull(rs.getString("TL_NOOFINST")));
				arrayCol.add(correctNull(rs.getString("TL_TOTALAMT")));
				arrayCol.add(correctNull(rs.getString("TL_INSTAMT")));
				dblTotal = dblTotal + Double.parseDouble(Helper.correctDouble((String)rs.getString("TL_TOTALAMT")));
				arrRepaySchedule.add(arrayCol);
			}    
			hshRecord.put("arrRepayScheduleRow", arrRepaySchedule);
			hshRecord.put("RepaySheduleTotal",nf.format(dblTotal));
			
			
			//For MIS Details
			if(rs!=null)rs.close();
			strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strOldAppno+"^"+strOldSno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_totlim",Helper.correctDouble((String)rs.getString("app_totlim")));
				hshRecord.put("app_totlimser",Helper.correctDouble((String)rs.getString("app_totlimser")));
				hshRecord.put("app_totlimagri",Helper.correctDouble((String)rs.getString("app_totlimagri")));
				hshRecord.put("app_whetherrestructure",Helper.correctNull((String)rs.getString("app_whetherrestructure")));
				hshRecord.put("app_whetherservice",Helper.correctNull((String)rs.getString("app_whetherservice")));
				hshRecord.put("app_resunder",Helper.correctNull((String)rs.getString("app_resunder")));
				hshRecord.put("app_settlementno",Helper.correctNull((String)rs.getString("app_settlementno")));
				hshRecord.put("app_settlementdate",Helper.correctNull((String)rs.getString("app_settlementdate")));
				hshRecord.put("app_oldfacid",Helper.correctNull((String)rs.getString("app_oldfacid")));
				hshRecord.put("app_resreason",Helper.correctNull((String)rs.getString("app_resreason")));
				strCityCode=Helper.correctNull((String)rs.getString("app_city"));
				strDistCode=Helper.correctNull((String)rs.getString("app_district"));
				strStateCode=Helper.correctNull((String)rs.getString("app_state"));
				hshRecord.put("app_city",strCityCode);
				hshRecord.put("app_district",strDistCode);
				hshRecord.put("app_state",strStateCode);
				hshRecord.put("app_place",Helper.correctNull((String)rs.getString("app_place")));
				hshRecord.put("app_repayment",Helper.correctNull((String)rs.getString("app_repayment")));
				hshRecord.put("app_sourceofrepay",Helper.correctNull((String)rs.getString("app_sourceofrepay")));
				hshRecord.put("app_guarantee",Helper.correctNull((String)rs.getString("app_guarantee")));
				hshRecord.put("app_guaranteeamt",Helper.correctDouble((String)rs.getString("app_guaranteeamt")));
				hshRecord.put("app_whethernewfac",Helper.correctNull((String)rs.getString("app_whethernewfac")));
				hshRecord.put("app_commencementdate",Helper.correctNull((String)rs.getString("app_commencementdate")));
				hshRecord.put("app_activitycode",Helper.correctNull((String)rs.getString("app_activitycode")));
				hshRecord.put("app_activitysno",Helper.correctNull((String)rs.getString("app_activitysno")));
				hshRecord.put("app_mainactivity",Helper.correctNull((String)rs.getString("app_mainactivity")));
				hshRecord.put("app_subactivity",Helper.correctNull((String)rs.getString("app_subactivity")));
				hshRecord.put("app_purpose",Helper.correctNull((String)rs.getString("app_purpose")));
				hshRecord.put("app_bsrcode",Helper.correctNull((String)rs.getString("app_bsrcode")));
				hshRecord.put("app_bsr1code",Helper.correctNull((String)rs.getString("app_bsr1code")));
				hshRecord.put("app_industrytype",Helper.correctNull((String)rs.getString("app_industrytype")));
				hshRecord.put("app_assetclassifcation",Helper.correctNull((String)rs.getString("app_assetclassifcation")));
				hshRecord.put("app_dispscreen",Helper.correctNull((String)rs.getString("app_dispscreen")));
				hshRecord.put("app_facility_sno",Helper.correctNull((String)rs.getString("app_facility_sno")));
				hshRecord.put("app_sharebroker",Helper.correctNull((String)rs.getString("app_sharebroker")));
				
				if(!strCityCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selcitycode^"+strCityCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strCity=Helper.correctNull((String)rs1.getString("city_name"));
					}
				}
				if(!strDistCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_districtmaster^"+strDistCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strDistrict=Helper.correctNull((String)rs1.getString("district_desc"));
					}
				}
				if(!strStateCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("sel_statenamebycode^"+strStateCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strState=Helper.correctNull((String)rs1.getString("state_name"));
					}
				}
				hshRecord.put("strCity", strCity);
				hshRecord.put("strState", strState);
				hshRecord.put("strDistrict", strDistrict);
			}
			
			
			if(rs!=null)
			{
				rs.close();
			}
			
			
			strQuery=SQLParser.getSqlQuery("sel_misappdisplayscreen^"+strOldAppno+"^"+strOldSno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("app_totland",Helper.correctNull((String)rs.getString("app_totland")));
				hshRecord.put("app_totirrigatedland",Helper.correctDouble((String)rs.getString("app_totirrigatedland")));
				hshRecord.put("app_totnonirrigatedland",Helper.correctDouble((String)rs.getString("app_totnonirrigatedland")));
				hshRecord.put("app_totcultivatedland",Helper.correctDouble((String)rs.getString("app_totcultivatedland")));
				hshRecord.put("app_totnoncultivatedland",Helper.correctDouble((String)rs.getString("app_totnoncultivatedland")));
				hshRecord.put("app_farmercategory",Helper.correctNull((String)rs.getString("app_farmercategory")));
				hshRecord.put("app_whethercropins",Helper.correctNull((String)rs.getString("app_whethercropins")));
				hshRecord.put("app_whetherkrishicard",Helper.correctNull((String)rs.getString("app_whetherkrishicard")));
				hshRecord.put("app_krishicardno",Helper.correctNull((String)rs.getString("app_krishicardno")));
				hshRecord.put("app_whetherpais",Helper.correctNull((String)rs.getString("app_whetherpais")));
				hshRecord.put("app_premiumamt",Helper.correctDouble((String)rs.getString("app_premiumamt")));
				hshRecord.put("app_nomineename",Helper.correctNull((String)rs.getString("app_nomineename")));
				hshRecord.put("app_nomineeage",Helper.correctInt((String)rs.getString("app_nomineeage")));
				hshRecord.put("app_nomineerelation",Helper.correctNull((String)rs.getString("app_nomineerelation")));
				hshRecord.put("app_claimdet",Helper.correctDouble((String)rs.getString("app_claimdet")));
				hshRecord.put("app_totfinancialoutlays",Helper.correctDouble((String)rs.getString("app_totfinancialoutlays")));
				hshRecord.put("app_individualgrp",Helper.correctNull((String)rs.getString("app_individualgrp")));
				hshRecord.put("app_margin",Helper.correctDouble((String)rs.getString("app_margin")));
				hshRecord.put("app_plantval",Helper.correctDouble((String)rs.getString("app_plantval")));
				hshRecord.put("app_indname",Helper.correctNull((String)rs.getString("app_indname")));
				hshRecord.put("app_whetheraccdep",Helper.correctNull((String)rs.getString("app_whetheraccdep")));
				hshRecord.put("app_noofunits",Helper.correctInt((String)rs.getString("app_noofunits")));
				hshRecord.put("app_equipval",Helper.correctDouble((String)rs.getString("app_equipval")));
				hshRecord.put("app_borrowerlending",Helper.correctDouble((String)rs.getString("app_borrowerlending")));
				hshRecord.put("APP_CRE_PERCNT",Helper.correctDouble((String)rs.getString("APP_CRE_PERCNT")));
				hshRecord.put("app_meritorious_status",Helper.correctNull((String)rs.getString("app_meritorious_status")));
				hshRecord.put("app_socialinfra",Helper.correctNull((String)rs.getString("APP_SOCIALINFRA")));
				hshRecord.put("app_agri_anci",Helper.correctNull((String)rs.getString("APP_AGRIANCIACTIVITY")));
				hshRecord.put("app_renewenergy",Helper.correctNull((String)rs.getString("APP_RENEWENERGY")));
				hshRecord.put("app_renewenergy_indv",Helper.correctNull((String)rs.getString("APP_RENEWENERGY_INDV")));
				hshRecord.put("app_agri_infra",Helper.correctNull((String)rs.getString("APP_AGRIINFRA")));
			}
			
			if(rs!=null)	{rs.close();}
			if(rs1!=null)	{rs1.close();}
			strQuery=SQLParser.getSqlQuery("sel_mispagedetailscorp^"+strOldAppno+"^"+strOldSno);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				hshRecord.put("strPriorityType", Helper.correctNull((String)rs1.getString("app_sector")));
				hshRecord.put("strPrioritySubsector", Helper.correctNull((String)rs1.getString("app_subsector")));
				hshRecord.put("strWeakerSectionSubSector", Helper.correctNull((String)rs1.getString("app_weakersec")));
				hshRecord.put("strAgriIndConfig", Helper.correctNull((String)rs1.getString("app_agriculture")));
				hshRecord.put("strTwentyPointPgm", Helper.correctNull((String)rs1.getString("app_twentypointpgm")));
				hshRecord.put("strSensitiveSector", Helper.correctNull((String)rs1.getString("app_sensitivesector")));
				hshRecord.put("strInfracode", Helper.correctNull((String)rs1.getString("app_infrastrcode")));
				hshRecord.put("strgovtannouncescheme", Helper.correctNull((String)rs1.getString("app_govtannouncescheme")));
				hshRecord.put("strstandupindia", Helper.correctNull((String)rs1.getString("app_standup_india")));
			}
			
			//For CBS Details
			if(rs!=null)	{rs.close();}
			strQuery =SQLParser.getSqlQuery("sel_cbsdetails^" +strOldAppno+"^"+strOldSno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("freecode6",Helper.correctNull(rs.getString("FREECODE6")));
				hshRecord.put("freecode7",Helper.correctNull(rs.getString("FREECODE7")));
				hshRecord.put("freecode8",Helper.correctNull(rs.getString("FREECODE8")));
				hshRecord.put("modeofoper",Helper.correctNull(rs.getString("MODE_OF_OPERATION")));
				hshRecord.put("drwingpwrind",Helper.correctNull(rs.getString("DRAWING_PWR_IND")));
				hshRecord.put("drwingpwr",Helper.correctNull(rs.getString("DRAWING_PWR")));
				hshRecord.put("handoffflg",Helper.correctNull(rs.getString("ACCT_HANDOFF_COMPLETE_FLAG")));
				hshRecord.put("strAdvanceNature",Helper.correctNull(rs.getString("NATUREOFADV")));
				hshRecord.put("strAdvanceType",Helper.correctNull(rs.getString("TYPEOFADV")));
				hshRecord.put("strAdvanceMode",Helper.correctNull(rs.getString("MODEOFADV")));
				hshRecord.put("strAdvancePurpose",Helper.correctNull(rs.getString("PURPOSEOFADV")));
				hshRecord.put("strFreeCode3",Helper.correctNull(rs.getString("FREECODE3")));
				hshRecord.put("strSecurityCode",Helper.correctNull(rs.getString("SECURITYCODE")));
				hshRecord.put("strFreecode7Fincode",Helper.correctNull(rs.getString("FREECODE7FINCODE")));
				hshRecord.put("strFreecode8Fincode",Helper.correctNull(rs.getString("FREECODE8FINCODE")));
				hshRecord.put("CER_GISTOFSECURITUES",Helper.correctNull(rs.getString("CER_GISTOFSECURITUES")));
				hshRecord.put("facility_schemecode",Helper.correctNull(rs.getString("facility_schemecode")));
				hshRecord.put("facility_glsubheadcode",Helper.correctNull(rs.getString("facility_glsubheadcode")));
				hshRecord.put("INTRATEFREQ",Helper.correctNull((String)rs.getString("INTRATEFREQ")));
				hshRecord.put("LBRCODE",Helper.correctNull((String)rs.getString("LBRCODE")));
				hshRecord.put("LAPSCODE1",Helper.correctNull((String)rs.getString("LAPS_CODE_1")));
				hshRecord.put("LAPSCODE2",Helper.correctNull((String)rs.getString("LAPS_CODE_2")));
				hshRecord.put("LAPSCODE3",Helper.correctNull((String)rs.getString("LAPS_CODE_3")));
				
				strOrgCode=Helper.correctNull(rs.getString("LOANDISBBRANCH"));
				strOrgName="";
				if(!strOrgCode.equalsIgnoreCase(""))
				{
					if(rs1!=null)
					{
						rs1.close();
					}
					strQuery1=SQLParser.getSqlQuery("selectorgname^"+strOrgCode);
					rs1=DBUtils.executeQuery(strQuery1);
					if(rs1.next())
					{
						strOrgName=Helper.correctNull((String)rs1.getString("org_name"));
					}
				}
				hshRecord.put("strOrgCode",strOrgCode);
				hshRecord.put("strOrgName",strOrgName);
			}
			hshRecord.put("strSno", strSno);
			hshRecord.put("strModuleType", strModuleType);
			if(rs!=null){
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strOldAppno);
		
		rs= DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("com_processingfee",Helper.correctNull(rs.getString("com_processingfee")));

		}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPSOldSanctionedData== "+e.toString());
		}
		
		return hshRecord;
	}
	
	
	public HashMap getPostSanctiondata(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null,rs1 = null,rs2=null,rsPS=null;
		ArrayList arrFacRow = new ArrayList();
		ArrayList arrFacCol = new ArrayList();
		ArrayList arrValues = new ArrayList();
		HashMap hshQueryValues=new HashMap();
		HashMap hshQuery=new HashMap();
		
		String strAppno = Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_post_sanction_applications^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strQuery = SQLParser.getSqlQuery("sel_fac_details_PS^"+Helper.correctNull((String)rs.getString("PS_OLD_APP_NO"))+"^"+Helper.correctNull((String)rs.getString("PS_OLD_APP_SNO")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					arrFacCol = new ArrayList();
					arrFacCol.add(Helper.correctNull(rs1.getString("CBS_ACCOUNTNO")));//0
					arrFacCol.add(Helper.correctNull(rs1.getString("FACILITY_APPNO")));//1
					arrFacCol.add(Helper.correctNull(rs1.getString("main_cat")));//2
					arrFacCol.add(Helper.correctNull(rs1.getString("sub_cat")));//3
					arrFacCol.add(Helper.correctNull(rs1.getString("FACILITY_SANCAMT")));//4
					arrFacCol.add(Helper.correctNull(rs1.getString("limit_type")));//5
					arrFacCol.add(Helper.correctNull(rs.getString("PS_APP_SNO")));//6
					arrFacCol.add(strAppno);//7
					if(rs2 !=null){
						rs2.close();
					}
					strQuery = SQLParser.getSqlQuery("chk_subfacility^"+Helper.correctNull((String)rs.getString("PS_OLD_APP_SNO"))+"^"+Helper.correctNull((String)rs.getString("PS_OLD_APP_NO")));
					rs2 = DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						arrFacCol.add("N");//8
					}
					else
					{
						if(Helper.correctNull(rs1.getString("facility_group")).equalsIgnoreCase("0"))
							arrFacCol.add("Y");//8
						else
							arrFacCol.add("N");//8
					}
					
					//To get the Migration required flag in Interest rate  
					if(rsPS!=null) rsPS.close();
					strQuery = SQLParser.getSqlQuery("sel_oldfac_processdate_PS^" + Helper.correctNull((String)rs.getString("PS_APP_NO")) + "^" + Helper.correctNull((String)rs.getString("PS_APP_SNO")));
					rsPS = DBUtils.executeQuery(strQuery);
					if(rsPS.next())
					{
						if(Integer.parseInt(Helper.correctInt((String)rsPS.getString("dayval")))<0)
						{
							if(Helper.correctNull(rs1.getString("FACILITY_INTTYPE")).equalsIgnoreCase("Fix"))
								arrFacCol.add(""); 
							else
								arrFacCol.add("Y"); 
						}
						else
						{
							arrFacCol.add("");//9
						}
					}
					else
					{
						arrFacCol.add("");//9
					}
					
					if(Helper.correctNull(rs1.getString("COM_FACNATURE")).equalsIgnoreCase("2")&&(Helper.correctNull(rs1.getString("COM_FACILITY_LOANTYPE")).equalsIgnoreCase("TL")||Helper.correctNull(rs1.getString("COM_FACILITY_LOANTYPE")).equalsIgnoreCase("DL"))
							&&Helper.correctNull(rs1.getString("FACILITY_ACCOUNTOPEN")).equalsIgnoreCase("Y"))
					{
						arrFacCol.add("Y");//10
					}
					else
					{
						arrFacCol.add("N");//10
					}
					if(Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("DGDQ")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODGEN")||
							Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODPSA")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODPS")
							||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODAG")||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODSEC")
							||Helper.correctNull(rs1.getString("com_facility_emischeme")).equalsIgnoreCase("ODSECPS"))
						arrFacCol.add("Y");//11
					else
						arrFacCol.add("N");//11
					
					arrFacRow.add(arrFacCol);
				}
			}
			hshValues.put("arrFacRow", arrFacRow);
			hshValues.put("strAppno", strAppno);
			
			
			hshQueryValues=new HashMap();
			int intUpdatesize=0;
			if(rs2 !=null){
				rs2.close();
			}
			/*rs2=DBUtils.executeLAPSQuery("compromoterins_postsanc^"+strAppno);			
			while(rs2.next())
			{
				
				if(rs1 !=null){
					rs1.close();
				}
				strQuery= SQLParser.getSqlQuery("selapplicantdetails^"+Helper.correctInt(rs2.getString("appid")));
				rs1=DBUtils.executeQuery(strQuery);			
				if(rs1.next())
				{*/
					
//					++intUpdatesize;
//					hshQuery=new HashMap();
//					arrValues=new ArrayList();
//				
//					hshQuery.put("strQueryId","compromoterins_postsanc");
					//intValue=intValue+1;
					/*String i=Integer.toString(intUpdatesize);*/
//					arrValues.add(strAppno);
					/*arrValues.add(i);
					arrValues.add("S");
					arrValues.add(correctNull(rs1.getString("perapp_name")));	//fname						
					arrValues.add(correctNull(rs1.getString("perapp_lname")));  //lname
					arrValues.add(" ");  //mname
					arrValues.add(correctNull(rs1.getString("perapp_dob")));  //dob
					arrValues.add(correctNull(rs1.getString("con_comaddr1")));//address1
					arrValues.add(correctNull(rs1.getString("con_comaddr2")));//address2
					arrValues.add(correctNull(rs1.getString("con_comcity")));//city
					arrValues.add(correctNull(rs1.getString("con_comstate")));//state
					arrValues.add(correctNull(rs1.getString("con_comzip")));//pin
					arrValues.add(correctNull(rs1.getString("con_comphone")));//phone
					arrValues.add(correctNull(rs1.getString("con_comfax")));//fax
					arrValues.add(correctNull(rs1.getString("con_email")));//email
					arrValues.add("");
					arrValues.add("");
					arrValues.add(correctNull(rs1.getString("perapp_networth")));//networth
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
					arrValues.add(correctNull(rs1.getString("perapp_id")));//new ID
					arrValues.add(correctNull(rs1.getString("perapp_oldid")));//old ID
					
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");
					arrValues.add("");*/
//					hshQuery.put("arrValues",arrValues);
//					hshQueryValues.put("size",Integer.toString(intUpdatesize));
//					
//					hshQueryValues.put(Integer.toString(intUpdatesize),hshQuery);
				/*}
			}*/
			if(intUpdatesize>0)
			{
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}

			return hshValues;
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getPostSanctiondata==="+e.toString());
		}
	}
	
	public HashMap getRenewedFacility(HashMap hshValues)
	{
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		ResultSet rs = null,rs2 = null,rs1 = null,rs3 = null,rs4=null;
		HashMap hshRecord = new HashMap();
		HashMap hshAppNew =  new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		
		String strQuery="",strFlag="",strBorrowId="",strNewappno="",strrenewFac="",StrGroup="0",strCashmargin="N";
		String strmodType = Helper.correctNull((String)hshValues.get("sessionModuleType"));
		if(strmodType.equalsIgnoreCase("CORP"))
		{
			strmodType = "C";
		}
		else
		{
			strmodType = "A";
		}
		String strAppId=correctNull((String)hshValues.get("hidapplicantoldid"));
		boolean recordflag=false;
		if(strAppId.equalsIgnoreCase(""))
		{
			strAppId = correctNull((String)hshValues.get("comappid"));
		}
		if(strAppId.equalsIgnoreCase(""))
		{
			strAppId = correctNull((String)hshValues.get("comapp_id"));
		}
		
		ArrayList vecData = new ArrayList();
		String strAppno="",strFacCategory="";
		ArrayList vecVal=null;
		double dblExist=0.00,dblProposed=0.00;
		String strTemp=" ";
		
		try
		{
			strAppno = correctNull((String)hshValues.get("appno"));
			
			if(strAppno.equalsIgnoreCase(""))
			{
				strAppno = correctNull((String)hshValues.get("hidNewappno"));
				strNewappno = correctNull((String)hshValues.get("hidNewappno"));
			}
			strrenewFac = correctNull((String)hshValues.get("hidrenewFac"));
			if(rs2 != null)
			{
				rs2.close();
			}
			strQuery = SQLParser.getSqlQuery("selApp_SearchResults^"+strAppId+"^"+strmodType);
			rs2 = DBUtils.executeQuery(strQuery);
			while(rs2.next()){
			
			strAppno=correctNull(rs2.getString("app_no"));
			if(rs != null)
			{
				rs.close();
			}
			StrGroup="0";
			if(strrenewFac.equalsIgnoreCase("Y"))
				strTemp="and a.fac_processdate  in (select  fac_processdate from facilities where cbs_accountno=a.cbs_accountno and cbs_accountno not in (select cbs_accountno from facilities where facility_appno in (select app_no from applications where app_status='op'and app_delflag='N') and cbs_accountno=a.cbs_accountno)) and cbs_accountno is not null and (facility_facnature not in '2' or (facility_facnature='2' and FACILITY_ACCOUNTOPEN='N')) and facility_category in ('R','O')";
			else if(strrenewFac.equalsIgnoreCase("S"))
				strTemp="and a.fac_processdate  in (select  fac_processdate from facilities where cbs_accountno=a.cbs_accountno and cbs_accountno not in (select cbs_accountno from facilities where facility_appno in (select app_no from applications where app_status='op'and app_delflag='N') and cbs_accountno=a.cbs_accountno)) and cbs_accountno is not null and facility_category in ('R','O')";
			else if(strrenewFac.equalsIgnoreCase("P"))
				strTemp="and (FAC_REVALIDATIONFLAG is null or (FAC_REVALIDATIONFLAG='Y' and FAC_REVALIDATIONSTATUS<>'op'))";
			strQuery = SQLParser.getSqlQuery("sel_renewedFacility^" + strAppno+"^"+StrGroup+"^"+strTemp);
			rs = DBUtils.executeQuery(strQuery);
			
			String strExist="",strProposed="",strfacilityDesc="";			
			while(rs.next())
			{	
				vecVal = new ArrayList();
				vecVal.add(correctNull(rs.getString("facility_headid")));	//0
				vecVal.add(correctNull(rs.getString("facheaddesc")));	//1	
				vecVal.add(correctNull(rs.getString("facility_id")));	//2
				vecVal.add(correctNull(rs.getString("facdesc")));	//3
				strBorrowId = correctNull(rs.getString("borrower_id"));		
				vecVal.add(strBorrowId);		//4
				vecVal.add(correctNull(rs.getString("facility_date")));	//5
				
				String strFacHeadId=correctNull(rs.getString("facility_headid"));
				String strFacId=correctNull(rs.getString("facility_id"));
				String strFaccode=Helper.correctNull((String)rs.getString("facility_code"));	
				String strSno =correctNull(rs.getString("facility_sno"));
				StrGroup=strSno;
				if(rs1!=null)
				{
					rs1.close();
				}
				rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
				if(rs1.next())
				{
					strfacilityDesc=Helper.correctNull((String)rs1.getString("com_facdesc"));
					strCashmargin=Helper.correctNull((String)rs1.getString("com_cashmargin"));
					vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc")));	//6
				}
				else{
					vecVal.add("");
				}
				dblExist =rs.getDouble("facility_existing");
				dblProposed =rs.getDouble("facility_proposed");
				strExist = jtn.format(dblExist);
				strProposed = jtn.format(dblProposed);
				
				vecVal.add(strExist);	//7
				vecVal.add(strProposed);	//8
				vecVal.add(Helper.correctNull((String)rs.getString("facility_facnature")));	//9
				vecVal.add(strSno);	//10
				vecVal.add(strAppno);//11
				vecVal.add(Helper.correctNull((String)rs.getString("facility_group")));//12  
				vecVal.add(Helper.correctNull((String)rs.getString("facility_category"))); //13
				vecVal.add(Helper.correctNull((String)rs.getString("fac_processdate"))); //14
				vecVal.add(Helper.correctNull((String)rs.getString("cbs_accountno"))); //15
				vecVal.add(strCashmargin);//16
				if(rs3 != null)
				{
					rs3.close();
				}
				
				String strRenew="N";
				strQuery = SQLParser.getSqlQuery("selfaccbsaccountnonull^" + strAppno+"^"+StrGroup);
				rs3 = DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					if(strrenewFac.equalsIgnoreCase("P"))
						strRenew="N";
					else
						strRenew="Y";
				}
				
				if(rs3!=null)
					rs3.close();
				
				strQuery = SQLParser.getSqlQuery("chk_pendingadhoclimits^" + strAppno+"^"+strSno);
				rs3 = DBUtils.executeQuery(strQuery);
				if(rs3.next())
				{
					if(strrenewFac.equalsIgnoreCase("P"))
						strRenew="N";
					else
						strRenew="Y";
				}
				
				vecVal.add(strRenew);//17
				
				if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("A")||Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("D"))
				{
					if(rs3!=null)
						rs3.close();
					strQuery = SQLParser.getSqlQuery("sel_adhocfacdesc^" + strAppno+"^"+strSno);
					rs3 = DBUtils.executeQuery(strQuery);
					if(rs3.next())
					{
						vecVal.add(Helper.correctNull(rs3.getString("com_facdesc")));//18
					}
					else
					{
						vecVal.add("");//18
					}
				}
				else
				{
					vecVal.add("");//18
				}
				vecVal.add("");//19
				vecVal.add("");//20
				vecData.add(vecVal);
				
				if(strrenewFac.equalsIgnoreCase("Y")||strrenewFac.equalsIgnoreCase("S"))
				{
					if(rs4 != null)
					{
						rs4.close();
					}
					strQuery = SQLParser.getSqlQuery("sel_adhocFacility^" + strAppno+"^"+strSno);
					rs4 = DBUtils.executeQuery(strQuery);
					while(rs4.next())
					{	
						vecVal = new ArrayList();
						vecVal.add(correctNull(rs4.getString("facility_headid")));	//0
						vecVal.add(correctNull(rs4.getString("facheaddesc")));	//1	
						vecVal.add(correctNull(rs4.getString("facility_id")));	//2
						vecVal.add(correctNull(rs4.getString("facdesc")));	//3
						strBorrowId = correctNull(rs4.getString("borrower_id"));		
						vecVal.add(strBorrowId);		//4
						vecVal.add(correctNull(rs4.getString("facility_date")));	//5
						
						strFacHeadId=correctNull(rs4.getString("facility_headid"));
						strFacId=correctNull(rs4.getString("facility_id"));
						strFaccode=Helper.correctNull((String)rs4.getString("facility_code"));	
						
						if(rs1!=null)
						{
							rs1.close();
						}
						rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
						if(rs1.next())
						{
							
							vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc")));	//6
							strCashmargin=Helper.correctNull((String)rs1.getString("com_cashmargin"));
						}
						else{
							vecVal.add("");
						}
						dblExist =rs4.getDouble("facility_existing");
						dblProposed =rs4.getDouble("facility_proposed");
						strExist = jtn.format(dblExist);
						strProposed = jtn.format(dblProposed);
						
						vecVal.add(strExist);	//7
						vecVal.add(strProposed);	//8
						vecVal.add(Helper.correctNull((String)rs4.getString("facility_facnature")));	//9
						vecVal.add(correctNull(rs4.getString("facility_sno")));	//10
						vecVal.add(correctNull(rs4.getString("facility_appno")));//11
						vecVal.add(Helper.correctNull((String)rs4.getString("facility_group")));//12  
						vecVal.add(Helper.correctNull((String)rs4.getString("facility_category"))); //13
						vecVal.add(Helper.correctNull((String)rs4.getString("fac_processdate"))); //14
						vecVal.add(Helper.correctNull((String)rs4.getString("cbs_accountno"))); //15
						vecVal.add(strCashmargin);//16
						vecVal.add("N");//17
						vecVal.add(strfacilityDesc);//18
						vecVal.add(strAppno);//19
						vecVal.add(strSno);//20
						vecData.add(vecVal);
					}
				}
				
				if(rs3 != null)
				{
					rs3.close();
				}
				strQuery = SQLParser.getSqlQuery("sel_renewedFacility^" + strAppno+"^"+StrGroup+"^"+strTemp);
				rs3 = DBUtils.executeQuery(strQuery);
				while(rs3.next())
				{	
					vecVal = new ArrayList();
					vecVal.add(correctNull(rs3.getString("facility_headid")));	//0
					vecVal.add(correctNull(rs3.getString("facheaddesc")));	//1	
					vecVal.add(correctNull(rs3.getString("facility_id")));	//2
					vecVal.add(correctNull(rs3.getString("facdesc")));	//3
					strBorrowId = correctNull(rs3.getString("borrower_id"));		
					vecVal.add(strBorrowId);		//4
					vecVal.add(correctNull(rs3.getString("facility_date")));	//5
					
					strFacHeadId=correctNull(rs3.getString("facility_headid"));
					strFacId=correctNull(rs3.getString("facility_id"));
					strFaccode=Helper.correctNull((String)rs3.getString("facility_code"));	
					strSno =correctNull(rs3.getString("facility_sno"));
					
					if(rs1!=null)
					{
						rs1.close();
					}
					rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
					if(rs1.next())
					{
						strfacilityDesc=Helper.correctNull((String)rs1.getString("com_facdesc"));
						
						vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc")));	//6
						strCashmargin=Helper.correctNull((String)rs1.getString("com_cashmargin"));
					}
					else{
						vecVal.add("");
					}
					dblExist =rs3.getDouble("facility_existing");
					dblProposed =rs3.getDouble("facility_proposed");
					strExist = jtn.format(dblExist);
					strProposed = jtn.format(dblProposed);
					
					vecVal.add(strExist);	//7
					vecVal.add(strProposed);	//8
					vecVal.add(Helper.correctNull((String)rs3.getString("facility_facnature")));	//9
					vecVal.add(strSno);	//10
					vecVal.add(strAppno);//11
					vecVal.add(Helper.correctNull((String)rs3.getString("facility_group")));//12  
					vecVal.add(Helper.correctNull((String)rs3.getString("facility_category"))); //13
					vecVal.add(Helper.correctNull((String)rs3.getString("fac_processdate"))); //14
					vecVal.add(Helper.correctNull((String)rs3.getString("cbs_accountno"))); //15
					vecVal.add(strCashmargin);//16
					vecVal.add("N");//17
					vecVal.add("");//18
					vecVal.add("");//19
					vecVal.add("");//20
					vecData.add(vecVal);
					
					
					if(strrenewFac.equalsIgnoreCase("Y"))
					{
						if(rs4 != null)
						{
							rs4.close();
						}
						strQuery = SQLParser.getSqlQuery("sel_adhocFacility^" + strAppno+"^"+strSno);
						rs4 = DBUtils.executeQuery(strQuery);
						while(rs4.next())
						{	
							vecVal = new ArrayList();
							vecVal.add(correctNull(rs4.getString("facility_headid")));	//0
							vecVal.add(correctNull(rs4.getString("facheaddesc")));	//1	
							vecVal.add(correctNull(rs4.getString("facility_id")));	//2
							vecVal.add(correctNull(rs4.getString("facdesc")));	//3
							strBorrowId = correctNull(rs4.getString("borrower_id"));		
							vecVal.add(strBorrowId);		//4
							vecVal.add(correctNull(rs4.getString("facility_date")));	//5
							
							strFacHeadId=correctNull(rs4.getString("facility_headid"));
							strFacId=correctNull(rs4.getString("facility_id"));
							strFaccode=Helper.correctNull((String)rs4.getString("facility_code"));	
							
							if(rs1!=null)
							{
								rs1.close();
							}
							rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
							if(rs1.next())
							{
								
								vecVal.add(Helper.correctNull((String)rs1.getString("com_facdesc")));	//6
								strCashmargin=Helper.correctNull((String)rs1.getString("com_cashmargin"));
							}
							else{
								vecVal.add("");
							}
							dblExist =rs4.getDouble("facility_existing");
							dblProposed =rs4.getDouble("facility_proposed");
							strExist = jtn.format(dblExist);
							strProposed = jtn.format(dblProposed);
							
							vecVal.add(strExist);	//7
							vecVal.add(strProposed);	//8
							vecVal.add(Helper.correctNull((String)rs4.getString("facility_facnature")));	//9
							vecVal.add(correctNull(rs4.getString("facility_sno")));	//10
							vecVal.add(correctNull(rs4.getString("facility_appno")));//11
							vecVal.add(Helper.correctNull((String)rs4.getString("facility_group")));//12  
							vecVal.add(Helper.correctNull((String)rs4.getString("facility_category"))); //13
							vecVal.add(Helper.correctNull((String)rs4.getString("fac_processdate"))); //14
							vecVal.add(Helper.correctNull((String)rs4.getString("cbs_accountno"))); //15
							vecVal.add(strCashmargin);//16
							
							if(rs1!=null)
								rs1.close();
							
							strQuery = SQLParser.getSqlQuery("chk_pendingadhoclimits^" + correctNull(rs4.getString("facility_appno"))+"^"+correctNull(rs4.getString("facility_sno")));
							rs1= DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								if(strrenewFac.equalsIgnoreCase("P"))
									vecVal.add("N");
								else
									vecVal.add("Y");
							}
							else
							{
								vecVal.add("N");
							}
							vecVal.add(strfacilityDesc);//18
							vecVal.add(strAppno);//19
							vecVal.add(strSno);//20
							vecData.add(vecVal);
						}
					}
				}
			}
			}
			
			HashMap hshAppData = new HashMap();
			
			if(strrenewFac.equalsIgnoreCase("Y"))
			{
				hshAppData.put("appno", strNewappno);
			}
			else
			{
				hshAppData.put("appno", strAppno);	
			}
			hshAppData = (HashMap) EJBInvoker.executeStateLess("appeditlock", hshAppData, "getAppData");
			hshRecord.put("hshAppData", hshAppData);	
			
			hshRecord.put("vecData",vecData);
			hshRecord.put("strRestuctureFlag",strrenewFac);
		}
		catch (Exception ce) 
		{
			throw new EJBException("inside getApplicationRenew" + ce.toString());
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
			catch (Exception cf) 
			{
				throw new EJBException("Error closing the connection " + cf.getMessage());
			}
		}
		
		return hshRecord;
	}

	public HashMap getLoadAdhocFacilities(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		String strQuery = "";
		ResultSet rs = null,rs1=null;
		HashMap hshRecord = new HashMap();
		String appid = Helper.correctNull((String) hshValues.get("appid"));
		String facGroup = correctNull((String) hshValues.get("facGroup"));
		String apptype = correctNull((String) hshValues.get("apptype"));
		String appno = correctNull((String) hshValues.get("appno"));
		String sno = correctNull((String) hshValues.get("sno"));
		String subsno = correctNull((String) hshValues.get("subsno"));
		hshRecord = new HashMap();
		String strTemp=" ",strModule="",strTemp2=" ",strHeadId="0",strSubHeadId="0";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try {
			
			strHeadId=Helper.correctNull((String)hshValues.get("strHeadId"));
			strSubHeadId=Helper.correctNull((String)hshValues.get("strSubHeadId"));
			
			if(Helper.correctNull((String)hshValues.get("strLimitType")).equalsIgnoreCase("A")||Helper.correctNull((String)hshValues.get("strLimitType")).equalsIgnoreCase("D"))
			{
				if(facGroup.equalsIgnoreCase("M"))
				{
					strTemp=" facility_group='0' and";
				}
				else if(facGroup.equalsIgnoreCase("S"))
				{
					strTemp="facility_group!='0' and";
				}
				if(apptype.equalsIgnoreCase("CORP"))
				{
					strModule="C";
				}
				else if(apptype.equalsIgnoreCase("AGR"))
				{
					strModule="A";
				}
				if(!(sno.equalsIgnoreCase("")||sno.equalsIgnoreCase("0")))
				{
					strTemp2="and facility_sno!='"+sno+"'";
				}
				if(strHeadId.equalsIgnoreCase(""))
				{
					strHeadId="0";
				}
				if(strSubHeadId.equalsIgnoreCase(""))
				{
					strSubHeadId="0";
				}
				if(!appid.equalsIgnoreCase("")&& !appid.equalsIgnoreCase("0"))
				{
					strQuery = SQLParser.getSqlQuery("sel_facilityforadhoclimits^"+strSubHeadId+"^"+strHeadId+"^"+strTemp+"^"+appid+"^"+strModule+"^"+strSubHeadId+"^"+strHeadId+"^"+strTemp+"^"+appno+"^"+strTemp2);
					if (rs != null) {
						rs.close();
					}
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("facility_appno")));
						arrCol.add(Helper.correctNull(rs.getString("facility_sno")));
						arrCol.add(Helper.correctNull(rs.getString("facility_displaydesc")));
						arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")))));
						arrCol.add(Helper.correctNull(rs.getString("facmonths")));
						if(Double.parseDouble(Helper.correctDouble(rs.getString("facmonths")))<0)
							arrCol.add("Y");
						else
							arrCol.add("N");
						arrCol.add(Helper.correctNull(rs.getString("facility_duedate")));
						arrRow.add(arrCol);
					}
				}
					
				hshRecord.put("arrRow",arrRow);
			}
			else if(Helper.correctNull((String)hshValues.get("strLimitType")).equalsIgnoreCase("R"))
			{
				
				if(facGroup.equalsIgnoreCase("M"))
				{
					sno=Helper.correctInt(sno);
				}
				else if(facGroup.equalsIgnoreCase("S"))
				{
					sno=Helper.correctInt(subsno);
				}
				
				strQuery = SQLParser.getSqlQuery("sel_regularlimitchk^"+appid+"^"+strHeadId+"^"+strSubHeadId);
				if (rs != null) {
					rs.close();
				}
				rs=DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					if(!(appno.equalsIgnoreCase(Helper.correctNull(rs.getString("facility_appno"))) && sno.equalsIgnoreCase(Helper.correctInt(rs.getString("facility_sno")))))
					{
						strQuery = SQLParser.getSqlQuery("selfacilitysno^"+appno+"^"+Helper.correctNull(rs.getString("facility_appno"))+"^"+Helper.correctInt(rs.getString("facility_sno")));
						if (rs1 != null) {rs1.close();}
						rs1=DBUtils.executeQuery(strQuery);
						if(!rs1.next())
						hshRecord.put("strAvailability","Y");
					}
				}
			}
			
			hshRecord.put("strLimitType", Helper.correctNull((String)hshValues.get("strLimitType")));
			hshRecord.put("strGroup",facGroup);
			hshRecord.put("sno",sno);
			hshRecord.put("subsno",subsno);
			hshRecord.put("appno",appno);
		}
			
		 catch (Exception ce) {
			throw new EJBException("Error in getLoadAdhocFacilities " + ce.toString());
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
	public HashMap getClosureFacilities(HashMap hshValues) 
	{
		java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		nf.setGroupingUsed(false);
		
		String strQuery = "";
		ResultSet rs = null,rs1=null,rs2=null;
		HashMap hshRecord = new HashMap();
		String strCBSID ="",strAppID="",strAppno="";
		hshRecord = new HashMap();
		String strTemp=" ",strModule="",strTemp2=" ";
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		try {
			
			strCBSID = Helper.correctNull((String) hshValues.get("hidcbsid"));
			strAppID = Helper.correctNull((String) hshValues.get("appoldid"));
			
			if(!"".equalsIgnoreCase(strCBSID))
			{
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("sel_lapsidfromcbsid^"+strCBSID);
				if(rs.next())
				{
					strAppID=Helper.correctNull(rs.getString("perapp_oldid"));	
					hshRecord.put("strAppname",Helper.correctNull(rs.getString("perapp_fname")));	
				}
			}
			
			if(rs1!=null)
				rs1.close();
			rs1=DBUtils.executeLAPSQuery("selretail_closurefacilities^"+strAppID);
			while(rs1.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs1.getString("app_loantype")));//0
				arrCol.add(Helper.correctNull(rs1.getString("app_no")));//1
				arrCol.add(Helper.correctNull(rs1.getString("sno")));//2
				arrCol.add(Helper.correctNull(rs1.getString("PRD_DESC")));//3
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("LOAN_RECMDAMT")))));//4
				arrCol.add(Helper.correctNull(rs1.getString("cbs_accountno")));//5
				arrCol.add(Helper.correctNull(rs1.getString("processdate")));//6
				arrCol.add("");//7
				arrCol.add("0");//8
				arrCol.add("N");//9
				arrCol.add(Helper.correctNull(rs1.getString("type")));//10
				arrCol.add(Helper.correctNull(rs1.getString("appcount")));//11
				arrCol.add("N");//12
				arrRow.add(arrCol);
				
			}
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_closurefacilities^0^"+strAppID);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("app_loantype")));
				arrCol.add(Helper.correctNull(rs.getString("facility_appno")));
				arrCol.add(Helper.correctNull(rs.getString("facility_sno")));
				arrCol.add(Helper.correctNull(rs.getString("com_facdesc")));
				arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")))));
				arrCol.add(Helper.correctNull(rs.getString("cbs_accountno")));
				arrCol.add(Helper.correctNull(rs.getString("fac_processdate")));
				if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("R"))
					arrCol.add("Regular-Limit");
				else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("A"))
					arrCol.add("Adhoc-Limit");
				else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("O"))
					arrCol.add("One Time Limit");
				else if(Helper.correctNull(rs.getString("facility_category")).equalsIgnoreCase("D"))
					arrCol.add("Additional-Limit");
				else
					arrCol.add("");
				arrCol.add("0");
				
				strTemp=Helper.correctNull(rs.getString("facility_sno"));
				strAppno=Helper.correctNull(rs.getString("facility_appno"));
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_closurefacilitiessub^"+strTemp+"^"+strAppno);
				if(rs1.next())
				{
					arrCol.add("Y");
				}
				else
				{
					arrCol.add("N");
				}
				arrCol.add(Helper.correctNull(rs.getString("type")));
				arrCol.add(Helper.correctNull(rs.getString("appcount")));
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_additionaladhochk^"+Helper.correctNull(rs.getString("facility_sno"))+"^"+strAppno);
				if(rs1.next())
				{
					arrCol.add("Y");
				}
				else
				{
					arrCol.add("N");
				}
				arrRow.add(arrCol);
				
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_closurefacilitiessub^"+strTemp+"^"+strAppno);
				while(rs1.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull(rs.getString("app_loantype")));
					arrCol.add(Helper.correctNull(rs1.getString("facility_appno")));
					arrCol.add(Helper.correctNull(rs1.getString("facility_sno")));
					arrCol.add(Helper.correctNull(rs1.getString("com_facdesc")));
					arrCol.add(nf.format(Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancamt")))));
					arrCol.add(Helper.correctNull(rs1.getString("cbs_accountno")));
					arrCol.add(Helper.correctNull(rs1.getString("fac_processdate")));
					if(Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("R"))
						arrCol.add("Regular-Limit");
					else if(Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("A"))
						arrCol.add("Adhoc-Limit");
					else if(Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("O"))
						arrCol.add("One Time Limit");
					else if(Helper.correctNull(rs1.getString("facility_category")).equalsIgnoreCase("D"))
						arrCol.add("Additional-Limit");
					else
						arrCol.add("");
					arrCol.add("1");
					arrCol.add("N");
					arrCol.add(Helper.correctNull(rs.getString("type")));
					arrCol.add(Helper.correctNull(rs.getString("appcount")));
					if(rs2!=null)
						rs2.close();
					rs2=DBUtils.executeLAPSQuery("sel_additionaladhochk^"+Helper.correctNull(rs1.getString("facility_sno"))+"^"+strAppno);
					if(rs2.next())
					{
						arrCol.add("Y");
					}
					else
					{
						arrCol.add("N");
					}
					arrRow.add(arrCol);
					
				}
			}
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("sel_permprop_closure^"+strCBSID);
			while(rs.next())
			{
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_cbsid_check^"+Helper.correctNull(rs.getString("DEV_APPNO")));
				if(rs1.next()){
				
				}
				else
				{
					arrCol=new ArrayList();
					arrCol.add("D");//0
					arrCol.add(Helper.correctNull(rs.getString("DEV_APPNO")));//1
					arrCol.add(Helper.correctNull(rs.getString("sno")));//2
					arrCol.add("");//3
					arrCol.add("");//4
					arrCol.add("");//5
					arrCol.add(Helper.correctNull(rs.getString("processdate")));//6
					arrCol.add("");//7
					arrCol.add("0");//8
					arrCol.add("N");//9
					arrCol.add("Permission");//10
					arrCol.add("0");//11
				    arrCol.add("N");//12
					arrRow.add(arrCol);
				}
				
			}
			
			
			
			hshRecord.put("arrRow", arrRow);
			hshRecord.put("strcbsid", strCBSID);
			hshRecord.put("strAppID", strAppID);
		}
			
		 catch (Exception ce) {
			throw new EJBException("Error in getClosureFacilities " + ce.toString());
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
	public void UpdateClosureFacilities(HashMap hshValues)
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues=new ArrayList();
		String strAppno="",strLoanType="",strSno="";
		String strQuery="";
		ResultSet rs=null;
		try
		{			
			strAppno = correctNull((String)hshValues.get("hidAppno"));
			strLoanType = correctNull((String)hshValues.get("hidloantype"));
			strSno = correctNull((String)hshValues.get("hidsno"));
			
			if(strLoanType.equalsIgnoreCase("P"))
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add("ca");
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("txtremarks")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "update_closureoffacility_retail");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				rs=DBUtils.executeLAPSQuery("sel_facilityrequired^"+strAppno);
				if(rs.next())
				{
					if(Helper.correctNull(rs.getString("app_renew_flag")).equalsIgnoreCase("R") && Helper.correctNull(rs.getString("cbs_accountno")).equalsIgnoreCase(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","renew_applicationflag");
						arrValues.add(null);
						arrValues.add(Helper.correctNull(rs.getString("app_parent_appno")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);
						hshQueryValues.put("size", "2");
					}
				}
			}
			else if(strLoanType.equalsIgnoreCase("D"))	
			{

				hshQuery = new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_permprop_status");
				arrValues.add("ca");
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("txtremarks")));
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
			
				
			}
			else
			{
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add("ca");
				arrValues.add(correctNull((String) hshValues.get("strUserId")));
				arrValues.add(correctNull((String) hshValues.get("txtremarks")));
				arrValues.add(strSno);
				arrValues.add(strAppno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId", "update_closureoffacility_corpagri");
				hshQueryValues.put("1", hshQuery);
				hshQueryValues.put("size", "1");
				
				rs=DBUtils.executeLAPSQuery("getFacilityData^"+strAppno+"^"+strSno);
				if(rs.next())
				{
					if(Helper.correctNull(rs.getString("FACILITY_TYPEFOR")).equalsIgnoreCase("R") && Helper.correctNull(rs.getString("cbs_accountno")).equalsIgnoreCase(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						hshQuery.put("strQueryId","update_renewFacility");
						arrValues.add(null);
						arrValues.add("0");
						arrValues.add(Helper.correctNull(rs.getString("facility_oldappno")));
						arrValues.add(Helper.correctNull(rs.getString("facility_oldappsno")));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("2", hshQuery);
						hshQueryValues.put("size", "2");
					}
				}
				
				if(rs!=null)
					rs.close();
				
				
			}
			
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
			
		}
		catch(Exception cf)
		{
			cf.printStackTrace();
			throw new EJBException("inside UpdateClosureFacilities"+cf.toString());
					
		}
	}
	 public void UpdateFacilityMCLRDetails(HashMap hshValues) 
 	{	
 		HashMap hshQueryValues = new HashMap();
 		HashMap hshQuery = new HashMap();;
 		ArrayList arrValues=new ArrayList();
 		String strAction="",strQuery="",strSpread1="1",strSpread2="2";
 		ResultSet rs=null;
 		int intQsize=0;
 		try
 		{	
 			strAction=Helper.correctNull((String)hshValues.get("hidAction")); 
 			String strAppno=Helper.correctNull((String)hshValues.get("appno")); 
 			String strFacsno=Helper.correctNull((String)hshValues.get("sel_facilitysno")); 
 			
 			if(strAction.equalsIgnoreCase("update"))
 			{
 				
 				intQsize++;
	    		hshQueryValues = new HashMap();
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "del_facilitysno_mclrspreadvalue");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		if(!Helper.correctNull((String)hshValues.get("sel_mclrtype")).equalsIgnoreCase(""))
				{
					String strArr[]=Helper.correctNull((String)hshValues.get("sel_mclrtype")).split("@");
					if(strArr!=null && strArr.length>1)
					{
						if(rs!=null)
							rs.close();
						rs=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
						if(rs.next())
						{
							strSpread1=Helper.correctNull(rs.getString("CBS_STATIC_SANC_REFNO"));
							strSpread2=Helper.correctNull(rs.getString("CBS_STATIC_CGTMSE"));
						}
					}
				}
	    		
	    		
	    		
	    		String[] strMCLRcaption= null;
				String[] strMCLRoption= null;
				String[] strMCLRCaptionVal= null;
				String[] strSpreadVal= null;
				
				if(hshValues.get("hidcrpcaption") instanceof java.lang.String)
				 {
					strMCLRcaption= new String[1];
					strMCLRcaption[0]=(String)hshValues.get("hidcrpcaption");
				 }else{
					 strMCLRcaption=(String[])hshValues.get("hidcrpcaption");
				 }
				 if(hshValues.get("sel_crpspreadoption") instanceof java.lang.String)
				 {
					 strMCLRoption= new String[1];
					 strMCLRoption[0]=(String)hshValues.get("sel_crpspreadoption");
				 }else{
					 strMCLRoption=(String[])hshValues.get("sel_crpspreadoption");
				 }
				 if(hshValues.get("hidcaptionval") instanceof java.lang.String)
				 {
					 strMCLRCaptionVal= new String[1];
					 strMCLRCaptionVal[0]=(String)hshValues.get("hidcaptionval");
				 }else{
					 strMCLRCaptionVal=(String[])hshValues.get("hidcaptionval");
				 }
				 if(hshValues.get("txt_crpspreadval") instanceof java.lang.String)
				 {
					 strSpreadVal= new String[1];
					 strSpreadVal[0]=(String)hshValues.get("txt_crpspreadval");
				 }else{
					 strSpreadVal=(String[])hshValues.get("txt_crpspreadval");
				 }
				
				 for(int i=0;i<strMCLRcaption.length;i++)
				 {
					 	intQsize++;
			    		hshQuery = new HashMap();
			    		arrValues=new ArrayList();
			    		arrValues.add(strAppno);
			    		arrValues.add(strFacsno);
			    		arrValues.add(strSpread1);
			    		arrValues.add(strMCLRcaption[i]);
			    		arrValues.add(strMCLRoption[i]);
			    		arrValues.add(strSpreadVal[i]);
			    		arrValues.add(strMCLRCaptionVal[i]);
			    		hshQuery.put("strQueryId", "ins_facility_mclrspreadvalue");
			    		hshQuery.put("arrValues", arrValues);
			    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
			    		hshQueryValues.put("size", String.valueOf(intQsize));
				 }
				 
				strMCLRcaption= null;
				strMCLRoption= null;
				strMCLRCaptionVal= null;
				strSpreadVal= null;
				 
				 if(hshValues.get("hidbspcaption") instanceof java.lang.String)
				 {
					strMCLRcaption= new String[1];
					strMCLRcaption[0]=(String)hshValues.get("hidbspcaption");
				 }else{
					 strMCLRcaption=(String[])hshValues.get("hidbspcaption");
				 }
				 if(hshValues.get("sel_bspspreadoption") instanceof java.lang.String)
				 {
					 strMCLRoption= new String[1];
					 strMCLRoption[0]=(String)hshValues.get("sel_bspspreadoption");
				 }else{
					 strMCLRoption=(String[])hshValues.get("sel_bspspreadoption");
				 }
				 if(hshValues.get("hidbspcaptionval") instanceof java.lang.String)
				 {
					 strMCLRCaptionVal= new String[1];
					 strMCLRCaptionVal[0]=(String)hshValues.get("hidbspcaptionval");
				 }else{
					 strMCLRCaptionVal=(String[])hshValues.get("hidbspcaptionval");
				 }
				 if(hshValues.get("txt_bspspreadval") instanceof java.lang.String)
				 {
					 strSpreadVal= new String[1];
					 strSpreadVal[0]=(String)hshValues.get("txt_bspspreadval");
				 }else{
					 strSpreadVal=(String[])hshValues.get("txt_bspspreadval");
				 }
				 
				 
				 for(int i=0;i<strMCLRcaption.length;i++)
				 {
					 	intQsize++;
			    		hshQuery = new HashMap();
			    		arrValues=new ArrayList();
			    		arrValues.add(strAppno);
			    		arrValues.add(strFacsno);
			    		arrValues.add(strSpread2);
			    		arrValues.add(strMCLRcaption[i]);
			    		arrValues.add(strMCLRoption[i]);
			    		arrValues.add(strSpreadVal[i]);
			    		arrValues.add(strMCLRCaptionVal[i]);
			    		hshQuery.put("strQueryId", "ins_facility_mclrspreadvalue");
			    		hshQuery.put("arrValues", arrValues);
			    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
			    		hshQueryValues.put("size", String.valueOf(intQsize));
				 }
 				
 				intQsize++;
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "del_facility_mclrspread");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		
	    		intQsize++;
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(strAppno);
	    		arrValues.add(strFacsno);
	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_mclrtype")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidMCLRTableCode")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidcrptotal")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidbsptotal")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidMCLRSpread")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidMSMEpercnt")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_subduedate")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("sel_fbill_fre")));
	    		hshQuery.put("strQueryId", "ins_facility_mclrspread");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		double dblInterestRate=Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidMCLRSpread")))+
	    		Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidcrptotal")))+Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidbsptotal")))+
	    		+Double.parseDouble(Helper.correctDouble((String)hshValues.get("hidMSMEpercnt")));
	    		intQsize++;
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(Helper.correctDouble((String)hshValues.get("hidMCLRSpread")));
	    		arrValues.add(String.valueOf(dblInterestRate));
	    		arrValues.add(String.valueOf(dblInterestRate));
	    		arrValues.add(String.valueOf(dblInterestRate));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("txt_migrationdate")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("hidScore")));
	    		arrValues.add(Helper.correctNull((String)hshValues.get("txtloan_SecValue")));
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "upd_facility_interest");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		intQsize++;
	    		hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","update_facilitystatus");
				arrValues.add("");
				arrValues.add("");
				arrValues.add("op");
				arrValues.add("");
				arrValues.add(strFacsno);
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
 			}
 			else if(strAction.equalsIgnoreCase("delete"))
 			{
 				intQsize++;
 				hshQueryValues = new HashMap();
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "del_facility_mclrspread");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		intQsize++;
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "del_facilitysno_mclrspreadvalue");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
	    		intQsize++;
	    		hshQuery = new HashMap();
	    		arrValues=new ArrayList();
	    		arrValues.add("0.0");
	    		arrValues.add("0.0");
	    		arrValues.add("0.0");
	    		arrValues.add("0.0");
	    		arrValues.add("");
	    		arrValues.add("");
	    		arrValues.add("");
	    		arrValues.add(strFacsno);
	    		arrValues.add(strAppno);
	    		hshQuery.put("strQueryId", "upd_facility_interest");
	    		hshQuery.put("arrValues", arrValues);
	    		hshQueryValues.put(String.valueOf(intQsize), hshQuery);
	    		hshQueryValues.put("size", String.valueOf(intQsize));
	    		
 			}
 			if(intQsize>0)
 			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
 			
 			// for CGTMSE interest total
 			Double CGTMSEint=0.00;
 			Double BPRL=0.00;
 			Double total=0.00;
 			String CGTMSEAPPLY="";
 			String sno=strFacsno;
 			strQuery= SQLParser.getSqlQuery("sel_cgtmse_int^"+strAppno+"^"+sno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				CGTMSEAPPLY	=Helper.correctNull(rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
				CGTMSEint=Double.parseDouble(Helper.correctDouble(rs.getString("FACILITY_CG_SPLIT_INT_RATE")));
				BPRL=Double.parseDouble(Helper.correctDouble(rs.getString("BPLR")));
				total=(CGTMSEint+BPRL);
				
				if(CGTMSEAPPLY.equals("Y"))
				{
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					
					arrValues.add(String.valueOf(total));
					arrValues.add(strAppno);
					arrValues.add(strFacsno);
					
					hshQuery.put("arrValues",arrValues); 
					hshQuery.put("strQueryId","upd_Cgtmsetotal_MCLR"); 
					hshQueryValues.put("size","1");
					hshQueryValues.put("1",hshQuery);
				   	EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
				}
			
			}
		//end
 		}
 		catch(Exception ce)
 		{
 			throw new EJBException("Error in UpdateFacilityMCLRetails " + ce.toString());
 		}
 		finally{
 			
 			try{
 				
 				hshQueryValues=null;
 	 			arrValues=null;
 	 			hshQuery=null;
 	 			
        		if(rs!=null)
        			rs.close();
        	}
        	catch (Exception e)
			{
				throw new EJBException("Error in closing Connection " + e.getMessage());
			}
 		}
 	}
  
     public HashMap getFacilityMCLRDetails(HashMap hshValues)  
     {
     	
    	 java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
 		jtn.setMaximumFractionDigits(2);
 		jtn.setMinimumFractionDigits(2);
 		jtn.setGroupingUsed(false);
    	 
     	HashMap hshRecord=new HashMap();
     	ResultSet rs = null,rs1=null;
     	String strAppno="",strFacsno="",strQuery="",strIntDefinition="",strAppid="",strROIType="",strCIBILScore="",strCRIFScore="",strScore="0",strRefType="O",Strroiupddate="";
     	boolean boolCRPFlag=true,boolBSPFalg=true,boolMCLRspread=true;
     	ArrayList arrRow=new ArrayList();
     	ArrayList arrCol=new ArrayList();
     	String strFacAmount="0",strFacTenor="0",strFacCode="0",strappstatus="",strTemp=" ",strFacHeadId="",strFacSubHeadId="",strWCDPNFac="N",strWCDPNint="0.00";
     	String strWeight="KB4",strsector="01",strSubsector="",strQuery1="",strSpread1="",strSpread2="",strMCLRType="",strMCLRtypeDesc="",strRoiEnableFlag="";
     	String fbilreffdate="",fbilfrq="";
 		try
	        {
 			
 			strAppno=Helper.correctNull((String)hshValues.get("appno"));
 			strFacsno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
 			strappstatus=Helper.correctNull((String)hshValues.get("strappstatus"));
 			strAppid=Helper.correctInt((String)hshValues.get("hidapplicantnewid"));
 			//Helper.correctInt((String)hshValues.get(txt_subduedate));
 			
 			//CIBIL&CRIF Details
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("select_cuscibildetails^"+strAppid);
			if(rs.next())
			{
				hshRecord.put("strCIBILDetails", Helper.correctInt(rs.getString("cibil_rat_status")).trim()+"~"+Helper.correctInt(rs.getString("cibil_score")).trim());	
				hshRecord.put("strCRIFDetails", Helper.correctInt(rs.getString("CRIF_REFERED")).trim()+"~"+Helper.correctInt(rs.getString("CRIF_SCORE")).trim());
				strCIBILScore=Helper.correctInt(rs.getString("cibil_score"));
				strCRIFScore=Helper.correctInt(rs.getString("CRIF_SCORE"));
			}
			
			if(rs!=null)
				rs.close();
			rs=DBUtils.executeLAPSQuery("select_facilitydetails^"+strAppno);
			while(rs.next())
			{
				if(Helper.correctInt(rs.getString("FAC_ROITYPE")).equalsIgnoreCase("CRIF"))
				{
					hshRecord.put("strCRIFFlag","Y");
				}
				if(Helper.correctInt(rs.getString("FAC_ROITYPE")).equalsIgnoreCase("CIBIL"))
				{
					hshRecord.put("strCIBILFlag","Y");
				}
			}
			
			
 			
 			if(!(strFacsno.equalsIgnoreCase("")||strFacsno.equalsIgnoreCase("0")))
 			{
 				strQuery=SQLParser.getSqlQuery("sel_com_facility_intfreq^"+strFacsno+"^"+strAppno);
 				rs=DBUtils.executeQuery(strQuery);
 				if(rs.next())
 				{
 					strIntDefinition=Helper.correctNull(rs.getString("com_facintdef"));
 					strFacAmount=Helper.correctNull(rs.getString("facility_sancamt"));
 					strFacTenor=Helper.correctNull(rs.getString("facility_months"));
 					strFacCode=Helper.correctNull(rs.getString("facility_code"));
 					strFacHeadId=Helper.correctNull(rs.getString("FACILITY_HEADID"));
 					strFacSubHeadId=Helper.correctNull(rs.getString("FACILITY_ID"));
 					strROIType=Helper.correctNull(rs.getString("FAC_ROITYPE"));
 					
 					if(strROIType.equalsIgnoreCase("CIBIL"))
 					strScore=strCIBILScore;
 					else if(strROIType.equalsIgnoreCase("CRIF"))
 					strScore=strCRIFScore;
 					
 					hshRecord.put("strIntDefinition",strIntDefinition);
 					hshRecord.put("strMigrationDate",Helper.correctNull(rs.getString("fac_mclr_migration_date")));
 					hshRecord.put("strFACILITYSECAMOUNT",Helper.correctNull(rs.getString("FACILITY_SECAMOUNT")));

 					hshRecord.put("strScore", Helper.correctNull(rs.getString("fac_roiscore")));
 					
 					hshRecord.put("COM_FACILITY_LOANTYPE", Helper.correctNull(rs.getString("COM_FACILITY_LOANTYPE")));
 					hshRecord.put("facility_intsubtype", Helper.correctNull(rs.getString("facility_intsubtype")));
 					hshRecord.put("FACILITYUPDROIFLAG", Helper.correctNull(rs.getString("FACILITY_UPDROI_FLAG")));
 					/*if(Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 					{
 					if(("FTBR").equalsIgnoreCase(Helper.correctNull(rs.getString("facility_intsubtype"))))
 					{
 						if(!Helper.correctInt((String)hshValues.get("txt_subduedate")).equalsIgnoreCase(""))
 						{
 					fbilreffdate=Helper.correctInt((String)hshValues.get("txt_subduedate"));
 					hshRecord.put("fbilreffdate", fbilreffdate);
 						}
 					}
 					}*/
 					
 				}
 				
 				if(strFacHeadId.equalsIgnoreCase("5") && strFacSubHeadId.equalsIgnoreCase("48"))
				{
					strWCDPNFac="Y";
				}
 				
 				if(strWCDPNFac.equalsIgnoreCase("Y"))
 				{
	 				if(rs!=null)
	 					rs.close();
	 				rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^106");
	 				if(rs.next())
	 				{
	 					strWCDPNint =  jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("LOAN_PARAMVAL"))));
	 					hshRecord.put("strWCDPNint", strWCDPNint);
	 					hshRecord.put("strWCDPNFac", strWCDPNFac);
	 				}
	 				
	 				if(rs!=null)
	 				{
	 					rs.close();
	 				}
	 				rs=DBUtils.executeLAPSQuery("sel_wcdpn_authority^"+strAppno);
	 				if(rs.next())
	 				{
	 					hshRecord.put("strWCDPNauthority", "Y");
	 				}
 				}
 				
 				if(rs!=null)
 					rs.close();
 				
 				double dblTotal=0.0;
 				strQuery=SQLParser.getSqlQuery("sel_facility_mclrspread^"+strFacsno+"^"+strAppno);
 				rs=DBUtils.executeQuery(strQuery);
 				if(rs.next())
 				{
 					strMCLRType=Helper.correctNull(rs.getString("facility_mclrtype"));
 					hshRecord.put("strMCLRType",Helper.correctNull(rs.getString("facility_mclrtype")));
 					hshRecord.put("mclr_tablecode",Helper.correctNull(rs.getString("mclr_tablecode")));
 					hshRecord.put("mclr_spread",Helper.correctNull(rs.getString("mclr_spread")));
 					hshRecord.put("mclr_crp_total",Helper.correctNull(rs.getString("mclr_crp_total")));
 					hshRecord.put("mclr_bsp_total",Helper.correctNull(rs.getString("mclr_bsp_total")));
 					fbilreffdate=Helper.correctNull(rs.getString("FBILL_DATE"));
 					hshRecord.put("fbilreffdate", fbilreffdate);
 					fbilfrq=Helper.correctNull(rs.getString("FBILL_FRQ"));
 					hshRecord.put("FBILL_FRQ",fbilfrq);
 					
 					dblTotal=Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spread")))+
 					Double.parseDouble(Helper.correctDouble(rs.getString("mclr_crp_total")))+
 					Double.parseDouble(Helper.correctDouble(rs.getString("mclr_bsp_total")));
 					
 					hshRecord.put("dblTotalIntRate",String.valueOf(dblTotal));
 					
 					boolMCLRspread = false;
 					
 					if(Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 					{
 						hshRecord.put("strEditFlag",Helper.correctNull((String)hshValues.get("hidEditFlag")));
 						strMCLRType=Helper.correctNull((String)hshValues.get("sel_mclrtype"));
	 					hshRecord.put("strMCLRType",strMCLRType);
	 					fbilreffdate=Helper.correctInt((String)hshValues.get("txt_subduedate"));
	 					hshRecord.put("fbilreffdate", fbilreffdate);
	 					fbilfrq=Helper.correctInt((String)hshValues.get("sel_fbill_fre"));
	 					hshRecord.put("FBILL_FRQ",fbilfrq);
 					}
 					hshRecord.put("strRoiEnableFlag","Y");
 				}
 				else
 				{
 					if(!Helper.correctNull((String)hshValues.get("hidAction")).equalsIgnoreCase("Delete"))
 					{
	 					strMCLRType=Helper.correctNull((String)hshValues.get("sel_mclrtype"));
	 					hshRecord.put("strMCLRType",strMCLRType);
	 					fbilreffdate=Helper.correctInt((String)hshValues.get("txt_subduedate"));
	 					hshRecord.put("fbilreffdate", fbilreffdate);
	 					fbilfrq=Helper.correctInt((String)hshValues.get("sel_fbill_fre"));
	 					hshRecord.put("FBILL_FRQ",fbilfrq);
 					}
 					hshRecord.put("strEditFlag",Helper.correctNull((String)hshValues.get("hidEditFlag")));
 					
 				}
 				
 				if(!strMCLRType.equalsIgnoreCase(""))
 				{
 					String strArr[]=strMCLRType.split("@");
 					if(strArr!=null && strArr.length>0)
 					{
 						if(rs1!=null)
							rs1.close();
						rs1=DBUtils.executeLAPSQuery("sel_CBSStaticDataPassingCode^34^"+strArr[0]);			
						if(rs1.next())
						{
							if(strROIType.equalsIgnoreCase("O"))
								strROIType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
							else
								strRefType=Helper.correctNull(rs1.getString("cbs_static_data_passing_code")); 
							
							strMCLRtypeDesc=Helper.correctNull(rs1.getString("cbs_static_data_desc"));
							hshRecord.put("strMCLRtypeDesc",strMCLRtypeDesc);
							hshRecord.put("strRefType",strRefType);

							strSpread1=Helper.correctNull(rs1.getString("cbs_static_sanc_refno"));  
							strSpread2=Helper.correctNull(rs1.getString("cbs_static_cgtmse"));  
						}
 					}
 				if(rs!=null)
 					rs.close();
 				arrRow=new ArrayList();
 				arrCol=new ArrayList();
 				strQuery=SQLParser.getSqlQuery("sel_facilitymclr^"+strSpread1+"^"+strFacsno+"^"+strAppno);
 				rs=DBUtils.executeQuery(strQuery);
 				while(rs.next())
 				{
 					arrCol=new ArrayList();
 					arrCol.add(Helper.correctNull(rs.getString("mclr_spreadtype")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_captionval")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_caption")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_option")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_spreadval")));
 					arrRow.add(arrCol);
 					if(!Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 					boolCRPFlag=false;
 				}
 				if(Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 				{
 					arrRow=null;
 					hshRecord.put("strDataFlag","N");
 				}
 				
 				if(arrRow!=null && arrRow.size()>0)
 					hshRecord.put("arrRowCRP",arrRow);

 				arrRow=new ArrayList();
 				arrCol=new ArrayList();
 				if(rs!=null)
 					rs.close();
 				strQuery=SQLParser.getSqlQuery("sel_facilitymclr^"+strSpread2+"^"+strFacsno+"^"+strAppno);
 				rs=DBUtils.executeQuery(strQuery);
 				while(rs.next())
 				{
 					arrCol=new ArrayList();
 					arrCol.add(Helper.correctNull(rs.getString("mclr_spreadtype")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_captionval")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_caption")));
 					arrCol.add(Helper.correctNull(rs.getString("mclr_option")));
 					arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("mclr_spreadval")))));
 					arrRow.add(arrCol);
 					if(!Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 					boolBSPFalg=false;
 				}
 				
 				if(Helper.correctNull((String)hshValues.get("hidEditFlag")).equalsIgnoreCase("Y"))
 					arrRow=null;
 				
 				if(strIntDefinition.equalsIgnoreCase("S"))
 				{
 					if(arrRow!=null && arrRow.size()>0)
 					{
 						if(arrRow.size()==1)
 						{
	 						arrCol=new ArrayList();
							arrCol.add(strSpread2);
							arrCol.add("");
							arrCol.add("Market Competition Rebate (Threat of losing the Account) (HO)");
							arrCol.add("-");
							arrCol.add("0.00");
							arrRow.add(arrCol);

							if(strFacHeadId.equalsIgnoreCase("5") && strFacSubHeadId.equalsIgnoreCase("48"))
	 						{
		 						arrCol=new ArrayList();
		 						arrCol.add(strSpread2);
		 						arrCol.add("");
		 						arrCol.add("Additional Premium for Adhoc Facilities(WCDPN)");
		 						arrCol.add("-");
		 						arrCol.add(strWCDPNint);
		 						arrRow.add(arrCol);
	 						}
 						}
 					}
 				}
 				if(arrRow!=null && arrRow.size()>0)
 					hshRecord.put("arrRowBSP",arrRow);

 				if(strIntDefinition.equalsIgnoreCase("M"))
 				{
 					if(strappstatus.equalsIgnoreCase("op"))
 					{
 						strTemp=" and mclr_activeflag='Y'";
 					}

	 				if(boolCRPFlag==true)
	 				{
	 					arrRow=new ArrayList();
	 					arrCol=new ArrayList();
	 					if(rs!=null)
	 						rs.close();
	
	 					strQuery=SQLParser.getSqlQuery("sel_facilitymclrmaster^"+strSpread1+"^"+strTemp);
	 					rs=DBUtils.executeQuery(strQuery);
	 					while(rs.next())
	 					{
	 						arrCol=new ArrayList();
	 						arrCol.add(strSpread1);
	 						arrCol.add(Helper.correctNull(rs.getString("mclr_id"))+"-"+Helper.correctNull(rs.getString("mclr_parent")));
	 						arrCol.add(Helper.correctNull(rs.getString("mclr_desc")));
	 						arrCol.add("-");
	 						arrCol.add("0.00");
	 						arrRow.add(arrCol);
	 					}
	
	 					if(arrRow!=null && arrRow.size()>0)
	 						hshRecord.put("arrRowCRP",arrRow);
	 				}
	 				if(boolBSPFalg==true)
	 				{
	 					arrRow=new ArrayList();
	 					arrCol=new ArrayList();
	 					if(rs!=null)
	 						rs.close();
	
	 					strQuery=SQLParser.getSqlQuery("sel_facilitymclrmaster^"+strSpread2+"^"+strTemp);
	 					rs=DBUtils.executeQuery(strQuery);
	 					while(rs.next())
	 					{
	 						arrCol=new ArrayList();
	 						arrCol.add(strSpread2);
	 						arrCol.add(Helper.correctNull(rs.getString("mclr_id"))+"-"+Helper.correctNull(rs.getString("mclr_parent")));
	 						arrCol.add(Helper.correctNull(rs.getString("mclr_desc")));
	 						arrCol.add("-");
	 						arrCol.add("0.00");
	 						arrRow.add(arrCol);
	 					}
	 					
	 					arrCol=new ArrayList();
 						arrCol.add(strSpread2);
 						arrCol.add("");
 						arrCol.add("Market Competition Rebate (Threat of losing the Account) (HO)");
 						arrCol.add("-");
 						arrCol.add("0.00");
 						arrRow.add(arrCol);
	
 						if(strFacHeadId.equalsIgnoreCase("5") && strFacSubHeadId.equalsIgnoreCase("48"))
 						{
	 						arrCol=new ArrayList();
	 						arrCol.add(strSpread2);
	 						arrCol.add("");
	 						arrCol.add("Additional Premium for Adhoc Facilities(WCDPN)");
	 						arrCol.add("-");
	 						arrCol.add(strWCDPNint);
	 						arrRow.add(arrCol);
 						}
 						
	 					if(arrRow!=null && arrRow.size()>0)
	 						hshRecord.put("arrRowBSP",arrRow);
	 				}
 				}
 				else if(strIntDefinition.equalsIgnoreCase("F"))
 				{
 					
 				}
 				else
 				{
 					strQuery=SQLParser.getSqlQuery("getFacilityInt1^"+strFacCode+"^floating^"+strFacAmount+"^"+strFacTenor+"^"+strROIType+"^"+strRefType);
 					
 					if(!strROIType.equalsIgnoreCase("") && !strScore.equalsIgnoreCase("0") && !strROIType.equalsIgnoreCase("O")&& !strROIType.equalsIgnoreCase("RATING"))
 					{
 						strQuery=SQLParser.getSqlQuery("getFacilityIntOthers^"+strFacCode+"^floating^"+strFacAmount+"^"+strFacTenor+"^"+strROIType+"^"+strScore+"^"+strRefType);
 					}
 					else if(strROIType.equalsIgnoreCase("RATING"))
 					{
 						//select sector
 						rs1=DBUtils.executeLAPSQuery("sel_misappclassification^"+strAppno+"^"+strFacsno);			
 						if(rs1.next())
 						{
 							strsector=Helper.correctNull(rs1.getString("app_sector"));  //01 ,02
 							strSubsector=Helper.correctNull(rs1.getString("app_sensitivesector"));
 						}
 						
 						if(rs1!=null)
 							rs1.close();
 						rs1=DBUtils.executeLAPSQuery("sel_creditRatingType^"+strAppno);			
 						if(rs1.next())
 						{
 							strWeight=Helper.correctNull(rs1.getString("CRE_WEIGHT"));
 						}
 						
 						strQuery=SQLParser.getSqlQuery("getFacilityInt1^"+strFacCode+"^floating^"+strFacAmount+"^"+strFacTenor+"^"+strRefType+"^O");
 					}
 					rs=DBUtils.executeQuery(strQuery);
 					
 					if(rs.next())
 					{
 						
 						String strCRP=Helper.correctDouble(rs.getString("corpprd_creditrskpremium"));
 						String strBSP=jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("corpprd_busstrategicpremium"))));
 						
 						if(strROIType.equalsIgnoreCase("RATING"))
 						{
	 						if(strSubsector.equalsIgnoreCase("11")) {
	 							strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^"+strWeight+"^"+Helper.correctNull((String)rs.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs.getString("CORPPRD_SNO"))
	 									+"^"+strSubsector);
	 							rs1 = DBUtils.executeQuery(strQuery1);
	 							}
	 							else if(strsector.equalsIgnoreCase("01") || strsector.equalsIgnoreCase("02"))
	 							{
	 								strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^" +strWeight+"^"+Helper.correctNull((String)rs.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs.getString("CORPPRD_SNO"))
	 										+"^"+strsector);
	 								rs1 = DBUtils.executeQuery(strQuery1);
	 							}
	 							else
	 							{
	 								strQuery1 = SQLParser.getSqlQuery("sel_ratingROIforUpd^KB4^"+Helper.correctNull((String)rs.getString("CORPPRD_INTID"))+"^"+Helper.correctNull((String)rs.getString("CORPPRD_SNO"))
	 										+"^01");
	 								rs1 = DBUtils.executeQuery(strQuery1);
	 							}
	 							if(rs1.next())
	 							{
	 								strCRP=Helper.correctDouble(rs1.getString("ROI_CRP"));
	 		 						strBSP=jtn.format(Double.parseDouble(Helper.correctDouble(rs1.getString("ROI_BSP"))));
	 							}
	 							else
	 							{
	 								strCRP="0.00";
	 								strBSP="0.00";
	 							}
 						}
 						
 						if(boolCRPFlag==true)
 		 				{
	 						arrRow=new ArrayList();
	 						arrCol=new ArrayList();
							arrCol.add(strSpread1);
							arrCol.add("");
							arrCol.add("Credit Risk Premium");
							arrCol.add("");
							arrCol.add(strCRP);
							arrRow.add(arrCol);
							hshRecord.put("arrRowCRP",arrRow);
 		 				}
						
 						if(boolBSPFalg==true)
 		 				{
							arrRow=new ArrayList();
							arrCol=new ArrayList();
							arrCol.add(strSpread2);
							arrCol.add("");
							if(!(strROIType.equalsIgnoreCase("ST")||strROIType.equalsIgnoreCase("TG")) && strRefType.equalsIgnoreCase("O"))
								arrCol.add("Business strategic Premium");
							else
								arrCol.add("Fixed Spread");
							arrCol.add("-");
							arrCol.add(strBSP);
							arrRow.add(arrCol);
							
							arrCol=new ArrayList();
	 						arrCol.add(strSpread2);
	 						arrCol.add("");
	 						arrCol.add("Market Competition Rebate (Threat of losing the Account) (HO)");
	 						arrCol.add("-");
	 						arrCol.add("0.00");
	 						arrRow.add(arrCol);
	 						
	 						if(strFacHeadId.equalsIgnoreCase("5") && strFacSubHeadId.equalsIgnoreCase("48"))
	 						{
		 						arrCol=new ArrayList();
		 						arrCol.add(strSpread2);
		 						arrCol.add("");
		 						arrCol.add("Additional Premium for Adhoc Facilities(WCDPN)");
		 						arrCol.add("-");
		 						arrCol.add(strWCDPNint);
		 						arrRow.add(arrCol);
	 						}
	 						
							hshRecord.put("arrRowBSP",arrRow);
 		 				}
 					}
 					else
 					{
 						if(boolCRPFlag==true)
 		 				{
	 						arrRow=new ArrayList();
	 						arrCol=new ArrayList();
							arrCol.add(strSpread1);
							arrCol.add("");
							arrCol.add("Credit Risk Premium");
							arrCol.add("");
							arrCol.add("0.00");
							arrRow.add(arrCol);
							hshRecord.put("arrRowCRP",arrRow);
 		 				}
						
 						if(boolBSPFalg==true)
 		 				{
							arrRow=new ArrayList();
							arrCol=new ArrayList();
							arrCol.add(strSpread2);
							arrCol.add("");
							if(!(strROIType.equalsIgnoreCase("ST")||strROIType.equalsIgnoreCase("TG")) && strRefType.equalsIgnoreCase("O"))
								arrCol.add("Business strategic Premium");
							else
								arrCol.add("Fixed Spread");
							arrCol.add("-");
							arrCol.add("0.00");
							arrRow.add(arrCol);
							
							arrCol=new ArrayList();
	 						arrCol.add(strSpread2);
	 						arrCol.add("");
	 						arrCol.add("Market Competition Rebate (Threat of losing the Account) (HO)");
	 						arrCol.add("-");
	 						arrCol.add("0.00");
	 						arrRow.add(arrCol);
	 						
	 						if(strFacHeadId.equalsIgnoreCase("5") && strFacSubHeadId.equalsIgnoreCase("48"))
	 						{
		 						arrCol=new ArrayList();
		 						arrCol.add(strSpread2);
		 						arrCol.add("");
		 						arrCol.add("Additional Premium for Adhoc Facilities(WCDPN)");
		 						arrCol.add("-");
		 						arrCol.add(strWCDPNint);
		 						arrRow.add(arrCol);
	 						}
	 						
							hshRecord.put("arrRowBSP",arrRow);
 		 				}
 					}
 					
 					if(boolCRPFlag==true && boolBSPFalg==true)
 					{
	 					if(strROIType.equalsIgnoreCase("RATING"))
	 					{
	 						strScore=strWeight;
	 					}
	 					hshRecord.put("strScore", strScore);
 					}
 				}
 				hshRecord.put("strFacIntDef",strIntDefinition);
 				
 				
 				if(rs!=null)
 					rs.close();
 				strQuery=SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strAppno);
 				rs=DBUtils.executeQuery(strQuery);
 				if(rs.next())
 				{
 					if(Helper.correctNull(rs.getString("com_sancdept")).equalsIgnoreCase("008")||
 							Helper.correctNull(rs.getString("com_sancdept")).equalsIgnoreCase("010"))
 					{
 						hshRecord.put("strHOFlag","Y");
 					}
 					
 					if(!correctNull(rs.getString("com_interest_refno")).equalsIgnoreCase(""))
 					{
 						hshRecord.put("strIntRefNoFlag", "Y");
 					}
 				}

 				
 				//To get the post sanction parameters
 				String strQueryPS = SQLParser.getSqlQuery("sel_postsanctiondet^"+strFacsno+"^"+strAppno);
				ResultSet rsPS = DBUtils.executeQuery(strQueryPS);
				if(rsPS.next())
				{
					hshRecord.put("strPostSancParam", Helper.correctNull(rsPS.getString("PS_MODIFY_TERMS")));
				}

 				if(rs!=null)
 				{
 					rs.close();
 				}
 				rs=DBUtils.executeLAPSQuery("selotherparam_ratexpos^104");
 				if(rs.next())
 				{
 					hshRecord.put("strIntDevLimit", Helper.correctNull(rs.getString("LOAN_PARAMVAL")));
 				}
 				
 				if(rs!=null)
				{
					rs.close();
				}
 				String strMCLRFlag="Y";
 				if(rsPS!=null) rsPS.close();
				strQuery = SQLParser.getSqlQuery("sel_oldfac_processdate_PS^" + strAppno + "^" + strFacsno);
				rsPS = DBUtils.executeQuery(strQuery);
				if(rsPS.next())
				{
					if(Integer.parseInt(Helper.correctInt(rsPS.getString("dayval")))<0)
					{
						strMCLRFlag="N";
					}
					
				}
				hshRecord.put("strMCLRFlag",strMCLRFlag);
 				}
 				hshRecord.put("strfacsno",strFacsno);
 				
 				if(rs!=null)
 	 				rs.close();	
 				
 				strQuery = SQLParser.getSqlQuery("sel_msme_roiup^"+strAppno+"^"+strFacsno);
 	    		rs = DBUtils.executeQuery(strQuery);
 				if(rs.next()) 
 				{
 					Strroiupddate = Helper.correctNull(rs.getString("FACILITY_UPDROI_DATE"));//LOAN_UPDROI_DATE
 					
 					
 					String NOwCalender = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());

 					if(Strroiupddate.equalsIgnoreCase(NOwCalender))
 					{
 						hshRecord.put("ROIDATECHECK","Y");
 					}
 				}
 			}
 			
 			
 			if(rs!=null)
 				rs.close();	
 				strQuery=SQLParser.getSqlQuery("commworkflowsel2^"+strAppno);
 	     		rs=DBUtils.executeQuery(strQuery);
 				if(rs.next())
 				{
 					hshRecord.put("APP_LOANSUBTYPE_DIGI",correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
 				}
 			

	 			String APP_GUARANTEE="";
 	 			if(!(strFacsno.equalsIgnoreCase("")||strFacsno.equalsIgnoreCase("0")))
 	 			{
 	 				if(rs!=null)
 	 	 				rs.close();
 	 				strQuery=SQLParser.getSqlQuery("sel_misappdetails^"+strAppno+"^"+strFacsno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{ 
 	 					hshRecord.put("misdetails","Y");
 	 					APP_GUARANTEE = correctNull(rs.getString("APP_GUARANTEE"));
 	 				}
 	 				if(APP_GUARANTEE.equalsIgnoreCase(""))
	 					{
	 						APP_GUARANTEE="S";
	 					}
	 					hshRecord.put("APP_GUARANTEE",APP_GUARANTEE);

 	 			}
 	 			if(APP_GUARANTEE.equalsIgnoreCase(""))
					{
						APP_GUARANTEE="S";
					}
					hshRecord.put("APP_GUARANTEE",APP_GUARANTEE);
 	 			
 	 				if(rs!=null)
 	 	 				rs.close();
 	 				strQuery=SQLParser.getSqlQuery("sel_digi_rate_score^"+strAppno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{ 
 	 					hshRecord.put("KB_RATING",correctNull(rs.getString("KB_RATING")));
 	 					hshRecord.put("BAND_RATING",correctNull(rs.getString("BAND_RATING")));
 	 				}
 	 				if(rs1 != null)
 					{
 						rs1.close();
 					}
 					strQuery=SQLParser.getSqlQuery("getinwardcreateddate^" + strAppno );		
 					rs1 = DBUtils.executeQuery(strQuery);
 					if(rs1.next())
 					{
 						hshRecord.put("miboinward_created",Helper.correctNull((String)rs1.getString("inward_created")));
 					}
 					
 					
 					//ALERT ROI Details FOR DIGI
 	 				if(rs!=null)
 	 				{ rs.close(); }
 	 				strQuery=SQLParser.getSqlQuery("sel_proposedLimit^"+strAppno+"^"+strFacsno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{
 	 					hshRecord.put("FACILITY_BASERATE",correctNull(rs.getString("FACILITY_BASERATE")));
 	 				}
 	 				
 	 				// CRP,BSP,SPREAD
 	 				if(rs!=null)
 	 				{	rs.close();}
 	 				
 	 				double dblTotal=0.0;
 	 				strQuery=SQLParser.getSqlQuery("Sel_alert_Roidetails^"+strAppno+"^"+strFacsno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{ 
 	 					
 	 					hshRecord.put("MCLR_CRP_TOTAL",correctNull(rs.getString("MCLR_CRP_TOTAL")));
 	 					hshRecord.put("MCLR_BSP_TOTAL",correctNull(rs.getString("MCLR_BSP_TOTAL")));
 	 					hshRecord.put("MCLR_SPREAD",correctNull(rs.getString("MCLR_SPREAD")));
 	 					
 	 					
 	 					// total Rate of interest
 	 					dblTotal=Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_CRP_TOTAL")))+
 	 					Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BSP_TOTAL")))+
 	 					Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_SPREAD")));
 	 				//	Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_MSME")));
 	 					
 	 					hshRecord.put("TotalBaseRate",jtn.format(dblTotal));
 	 				}
 	 				
 	 				
 	 				//varConcession
 	 				if(rs!=null)
 	 				{	rs.close();}
 	 				strQuery=SQLParser.getSqlQuery("Sel_CONCESSION^"+strAppno+"^"+strFacsno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{
 	 					hshRecord.put("FACILITY_CONCESSION",correctNull(rs.getString("FACILITY_CONCESSION")));
 	 				}
 					
 	 				//varConcessionDescription
 	 				if(rs!=null)
 	 				{ rs.close(); }
 	 				strQuery=SQLParser.getSqlQuery("Sel_CONCESSION_CONDESC^"+strAppno+"^"+strFacsno);
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{
 	 					hshRecord.put("FACILITY_CONDESC",correctNull(rs.getString("FACILITY_CONDESC")));
 	 				}
 			
 			
	        }
	        catch(Exception exception)
	        {
	            throw new EJBException("Error in getFacilityMCLRDetails " + exception.toString());
	        }
	        finally
	        {
	        	try{
	        		if(rs!=null)
	        			rs.close();
	        		if(rs1!=null)
	        			rs1.close();
	        	}
	        	catch (Exception e)
				{
					throw new EJBException("Error in closing Connection " + e.getMessage());
				}
	        }
         return hshRecord;
     }
     

     public HashMap getMCLRSpreadValue(HashMap hshValues)  
     {
     	
     	ResultSet rs = null;
     	String strQuery="",strTemp="";
 		try
	        {
 				strTemp=Helper.correctNull((String)hshValues.get("strValue"));
 				String[] strArr=strTemp.split("-");
 				
 				if(strArr.length>1)
 				{
 					strTemp=strArr[0];
 					
 					strQuery=SQLParser.getSqlQuery("sel_mclrspreadmasterval^"+strTemp+"^ ");
 	 				rs=DBUtils.executeQuery(strQuery);
 	 				if(rs.next())
 	 				{
 	 					hshValues.put("strmclrspread",Helper.correctNull(rs.getString("mclr_desc")));
 	 				}
 				}
 			
	        }
	        catch(Exception exception)
	        {
	            throw new EJBException("Error in getMCLRSpreadValue " + exception.toString());
	        }
	        finally
	        {
	        	try{
	        		if(rs!=null)
	        			rs.close();
	        	}
	        	catch (Exception e)
				{
					throw new EJBException("Error in closing Connection " + e.getMessage());
				}
	        }
         return hshValues;
     }
     
     public HashMap getCheckListValue(HashMap hshValues) 
     {
    	 ResultSet rs = null, rs2=null,rs3=null;
 		HashMap hshRecord = new HashMap();
 		ArrayList arrRow=new ArrayList();
 		ArrayList arrCol=new ArrayList();
 		ArrayList arrCol2=new ArrayList();
 		String strfacsno="";
 		String appno="";
 		String strbankscheme="";
 		boolean bflag=true;
 		ArrayList arrRow1=new ArrayList();
 		ArrayList arrCol1=new ArrayList();
 		
 		try
 		{
 			appno=Helper.correctNull((String)hshValues.get("appno"));
 			strfacsno=Helper.correctNull((String)hshValues.get("sel_facility"));
 			if(!strfacsno.equalsIgnoreCase(""))
 			{
 				rs=DBUtils.executeLAPSQuery("select_facility_chklist^"+appno+"^"+strfacsno);
	 			while(rs.next())
	    		{
	 				bflag=false;
	 				arrCol2=new ArrayList();
					arrCol2.add(Helper.correctNull(rs.getString("fac_bankscheme")));
					arrCol2.add(Helper.correctNull(rs.getString("SCHEME_RULENO")));
					arrCol2.add(Helper.correctNull(rs.getString("Document_CONTENT")));
					arrCol2.add(Helper.correctNull(rs.getString("DOC_MANDATORY")));
					arrCol2.add(Helper.correctNull(rs.getString("DOC_REASON")));
					arrCol2.add(Helper.correctNull(rs.getString("DOC_EXPECTED_DD")));
					arrRow.add(arrCol2);
	 			}
 			
 				
	 			if(bflag)
	 			{
	 				if(rs!=null)
                        rs.close();
	 				rs=DBUtils.executeLAPSQuery("sel_chck_lst_doc^"+appno+"^"+strfacsno);
		 			if(rs.next())
		    		{
		 				strbankscheme= Helper.correctNull(rs.getString("COM_BANKSCHEME"));
		 				
		    		}
					rs2=DBUtils.executeLAPSQuery("select_schemedoc^"+strbankscheme);
					while(rs2.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs2.getString("Scheme_ID")));
						arrCol.add( Helper.correctNull(rs2.getString("Scheme_RULENO")));
						arrCol.add( Helper.correctNull(rs2.getString("Document_CONTENT")));
						arrCol.add("");
						arrCol.add("");
						arrCol.add("");
						arrRow.add(arrCol);
					}
	 			}
	 			hshValues.put("arrRow", arrRow);
	 			hshValues.put("FACILITY_SNO", strfacsno);
 			}
 		// checking data in db for checklist
			int a=0,b=0;
			if(rs!=null)
                rs.close();
				rs=DBUtils.executeLAPSQuery("select_facility_details^"+appno);
 			while(rs.next())
    		{
 				if(Helper.correctNull(rs.getString("COM_BANKSCHEME")).equalsIgnoreCase("052"))
 				{
 					a++;
 					if(rs3!=null)
 						rs3.close();
 					rs3=DBUtils.executeLAPSQuery("select_facility_chklist^"+appno+"^"+Helper.correctNull(rs.getString("FACILITY_SNO")));
 		 			if(rs3.next())
 		    		{
 		 				b++;
 		    		}
 				}
 				
    		}
 			if(a==b)
 				hshValues.put("strCheckList_Check","Y");
 			else
 				hshValues.put("strCheckList_Check","N");
			
 		}catch(Exception ce)
		{
			throw new EJBException("Error "+ce.toString()+""+ce.getCause()+""+ce.getStackTrace());
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
     	
     	
    	 
    	 return hshValues;
    	 
     }
     
     public HashMap getFacilityArrangement(HashMap hshValues) 
     {
    	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
 		jtn.setMaximumFractionDigits(2);
 		jtn.setMinimumFractionDigits(2);
 		jtn.setGroupingUsed(false);

    	 ResultSet rs = null,rs1=null;
    	 ArrayList arrRow=new ArrayList();
    	 ArrayList arrCol=new ArrayList();
    	 String strQuery="",strAppno="",strfacno="",strQuery1="";
    	 try
    	 {
    		 strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		 strfacno=Helper.correctNull((String)hshValues.get("sno"));
    		 String StrSubQuery=" ";
    		 strQuery = SQLParser.getSqlQuery("select_facilitydetails1^" +strAppno);

    		 if(rs != null)
    		 {
    			 rs.close();
    		 }

    		 rs = DBUtils.executeQuery(strQuery);
    		 while(rs.next())
    		 {	
    			 arrCol = new ArrayList();
    			 arrCol.add(correctNull(rs.getString("facility_sno")));//0
    			 arrCol.add(correctNull(rs.getString("facility_group")));//1
    			 arrCol.add("");//2
    			 arrCol.add(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancamt")))));//3
    			 arrCol.add(correctNull(rs.getString("facility_catdesc")));//4
    			 String strFacHeadId=correctNull(rs.getString("facility_headid"));
 				String strFacId=correctNull(rs.getString("facility_id"));
 				String strFaccode=Helper.correctNull((String)rs.getString("facility_code"));			
 				if(rs1!=null)
 				{
 					rs1.close();
 				}
 				String strfacilityDesc="";
 				rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
 				if(rs1.next())
 				{
					strfacilityDesc=Helper.correctNull((String)rs1.getString("com_facdesc"));

 				}
 				 arrCol.add(strfacilityDesc);//5
    			 arrCol.add(correctNull(rs.getString("FACILITY_CATEGORY")));//6
    			 arrCol.add(strFacHeadId);//7
    			 arrCol.add(strFacId);//8
 				 
    			 arrRow.add(arrCol);

    		 }
    		 
    		 hshValues.put("arrRow",arrRow);
    		 
 			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_applications_freeze_flag^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				hshValues.put("app_freeze_flag",Helper.correctNull(rs.getString("app_freeze_flag")));
			}
			if(rs!=null)
				rs.close();
			double dblloanapplied  =0.00;
			strQuery = SQLParser.getSqlQuery("selinwardappdata^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) 
			{
				double dblWorkingCapital  =Double.parseDouble(Helper.correctDouble(rs.getString("inward_wcloanamt")));
				double dblTermloan  	  =Double.parseDouble(Helper.correctDouble(rs.getString("inward_termloanamt")));
				double dblNonFundBased    =Double.parseDouble(Helper.correctDouble(rs.getString("inward_nonwcloanamt")));
				dblloanapplied=dblWorkingCapital+dblTermloan+dblNonFundBased;
			}
			hshValues.put("Strloanapplied",jtn.format(dblloanapplied));
 			
		 }catch(Exception ce)
		 {
			 throw new EJBException("Error "+ce.toString()+""+ce.getCause()+""+ce.getStackTrace());
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



    		 return hshValues;

     }
     
     public void updateCheckListValue(HashMap hshValues) 
     {
    	 String strQuery="";
    	 ResultSet rs = null;


    	 HashMap hshQueryValues = new HashMap();
    	 HashMap hshQuery = new HashMap();
    	 ArrayList arrValues = new ArrayList();
    	 HashMap hshRecord=  new HashMap();
    	 ArrayList arrvalues=new ArrayList();
    	 String strAppno="";
    	 String strFacSno="",strAction="";

    	 String[] select=null;
    	 String[] strreason=null;
    	 String[] strdate=null;
    	 String[] strRuleNo=null;
    	 String[] strSchemeID=null;

    	 try{
    		 strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		 strFacSno=Helper.correctInt((String)hshValues.get("sel_facility"));
    		 strAction=Helper.correctInt((String)hshValues.get("hidAction"));

    		 if(strAction.equalsIgnoreCase("update"))
    		 {

    			 hshQuery=new HashMap();
    			 arrValues = new ArrayList();

    			 arrValues.add(strAppno);
    			 arrValues.add(strFacSno);
    			 hshQuery.put("arrValues", arrValues);
    			 hshQuery.put("strQueryId","del_facilitychklist");
    			 hshQueryValues.put("size","1");					
    			 hshQueryValues.put("1",hshQuery);

    			 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

    			 hshQueryValues=new HashMap();
    			 hshQuery=new HashMap();
    			 arrValues = new ArrayList();
    			 
    			 if(hshValues.get("selAction") instanceof String[])
    			 {
    				 int intsize=0;
    				 select=(String[])hshValues.get("selAction");
    				 strreason=(String[])hshValues.get("txt_reason");
    				 strdate=(String[])hshValues.get("txt_expdate");
    				 strRuleNo=(String[])hshValues.get("hid_ruleno");
    				 strSchemeID=(String[])hshValues.get("hid_schemeid");


    				 for(int i=0;i<select.length;i++)
    				 {
    					 ++intsize;
    					 hshQuery=new HashMap();
    					 arrValues = new ArrayList();
    					 arrValues.add(strAppno);
    					 arrValues.add(strFacSno);
    					 arrValues.add(strRuleNo[i]);
    					 arrValues.add(select[i]);
    					 arrValues.add(strreason[i]);
    					 arrValues.add(strdate[i]);
    					 arrValues.add(strSchemeID[i]);
    					 hshQuery.put("arrValues", arrValues);
    					 hshQuery.put("strQueryId","ins_chck_lst_doc");
    					 hshQueryValues.put("size",String.valueOf(intsize));					
    					 hshQueryValues.put(String.valueOf(intsize),hshQuery);

    				 }

    				 if(intsize>0){
    					 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    				 }

    			 }else
    			 {
    				 String select1=(String)hshValues.get("selAction");
    				 String strreason1=(String)hshValues.get("txt_reason");
    				 String strdate1=(String)hshValues.get("txt_expdate");
    				 String strRuleNo1=(String)hshValues.get("hid_ruleno");
    				 String strSchemeID1=(String)hshValues.get("hid_schemeid");

    				 hshQuery=new HashMap();
    				 arrValues = new ArrayList();

    				 arrValues.add(strAppno);
    				 arrValues.add(strFacSno);
    				 arrValues.add(strRuleNo1);
    				 arrValues.add(select1);
    				 arrValues.add(strreason1);
    				 arrValues.add(strdate1);
    				 arrValues.add(strSchemeID1);
    				 hshQuery.put("arrValues", arrValues);
    				 hshQuery.put("strQueryId","ins_chck_lst_doc");
    				 hshQueryValues.put("size","1");					
    				 hshQueryValues.put("1",hshQuery);

    				 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");

    			 }
    		 }
    		 else if(strAction.equalsIgnoreCase("delete"))
    		 {
    			 hshQuery=new HashMap();
    			 arrValues = new ArrayList();

    			 arrValues.add(strAppno);
    			 arrValues.add(strFacSno);
    			 hshQuery.put("arrValues", arrValues);
    			 hshQuery.put("strQueryId","del_facilitychklist");
    			 hshQueryValues.put("size","1");					
    			 hshQueryValues.put("1",hshQuery);

    			 EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		 }


    	 }catch(Exception ce){
    		 log.error(ce.toString());
    		 throw new EJBException("Error in updateCheckListValue "+ce.toString());
    	 }
     }
     public HashMap getStatMasterValues(HashMap hshValues) 
     {
    	 ResultSet rs = null;
 		ArrayList arrRow=new ArrayList();
 		ArrayList arrCol=new ArrayList();
 		String strMasterId="",strMasterVal="";
 		int intActive=0;
 		try
 		{
 			strMasterId=Helper.correctNull((String)hshValues.get("strMastID"));
 			strMasterVal=Helper.correctNull((String)hshValues.get("strMastVal"));
 			if(Helper.correctNull((String)hshValues.get("strFlag")).equalsIgnoreCase("Y"))
 			{
 				String strDesc="";
 				if(rs!=null)
 					rs.close();
 				rs=DBUtils.executeLAPSQuery("selectFacilityHeadFacandSubFac_facilitycorp^"+Helper.correctNull((String)hshValues.get("strFacCode")));
 				if(rs.next())
 	    		{
 					strDesc="@"+Helper.correctNull(rs.getString("com_facdispdesc"));
 	    		}
 				
 				rs=DBUtils.executeLAPSQuery("selstaticdata^"+strMasterId);
 				while(rs.next())
 	    		{
 					if(strDesc.contains("@"+Helper.correctNull(rs.getString("stat_data_desc"))+"@"))
 					{
	 	 				arrCol=new ArrayList();
	 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
	 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
	 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_active")));
	 	 				if(correctNull(rs.getString("stat_data_active")).equalsIgnoreCase("Y"))
	 	 					intActive++;
	 					arrRow.add(arrCol);
 					}
 	 			}
 			}
 			else
 			{
 				rs=DBUtils.executeLAPSQuery("sel_mastervalues^"+strMasterId+"^"+strMasterVal);
 				while(rs.next())
 	    		{
 	 				arrCol=new ArrayList();
 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
 	 				arrCol.add(Helper.correctNull(rs.getString("stat_data_active")));
 	 				if(correctNull(rs.getString("stat_data_active")).equalsIgnoreCase("Y"))
 	 					intActive++;
 					arrRow.add(arrCol);
 	 			}
 			}
 			
 			hshValues.put("arrRow", arrRow);
 			hshValues.put("strActiveCnt", String.valueOf(intActive));
			
 		}catch(Exception ce)
		{
			throw new EJBException("Exception in getStatMasterValues Method======="+ce.toString());
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
    	 return hshValues;
    	 
     }
     public HashMap getInterestType(HashMap hshValues)  {
 		String strQuery = "",strSessionModule="",strProdCode="",strInterestType="";
 		ResultSet rs = null;
 		ArrayList arrRow=new ArrayList();
 		ArrayList arrCol=new ArrayList();

 		try {
 			
 			strSessionModule=Helper.correctNull((String)hshValues.get("sessionModuleType"));
 			strProdCode=Helper.correctNull((String)hshValues.get("strPrdcode"));
 			
 			if(strSessionModule.equalsIgnoreCase("CORP")||strSessionModule.equalsIgnoreCase("AGR"))
 			{
 				rs=DBUtils.executeLAPSQuery("sel_facilityCorp^"+strProdCode);
				if(rs.next())
				{
					strInterestType=Helper.correctNull(rs.getString("fac_interesttype"));
					if(!strInterestType.equalsIgnoreCase(""))
					{
						strInterestType=strInterestType.substring(0, strInterestType.length()-1);
						strInterestType=strInterestType.replaceAll("@", "','");
					}
				}
				
				if(rs!=null)
					rs.close();
				
				if(!strInterestType.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_staticdatavalues^219^"+strInterestType);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
						arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
						arrRow.add(arrCol);
					}
				}
				
 			}
 			else
 			{
 				rs=DBUtils.executeLAPSQuery("setproductstypebyprdcode^"+strProdCode);
				if(rs.next())
				{
					strInterestType=Helper.correctNull(rs.getString("prd_interesttype"));
					if(!strInterestType.equalsIgnoreCase(""))
					{
						strInterestType=strInterestType.substring(0, strInterestType.length()-1);
						strInterestType=strInterestType.replaceAll("@", "','");
					}
				}
				
				if(rs!=null)
					rs.close();
				
				if(!strInterestType.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_staticdatavalues^219^"+strInterestType);
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull(rs.getString("stat_data_desc")));
						arrCol.add(Helper.correctNull(rs.getString("stat_data_desc1")));
						arrRow.add(arrCol);
					}
				}
 			}
 			
 			hshValues.put("arrRow",arrRow);
 			
 		} catch (Exception ce) {
 			throw new EJBException("Error in getInterestType " + ce.toString());
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
 		return hshValues;
 	}
     public void UpdateFacilityArrangement(HashMap hshValues) 
     {
    	 String strQuery="";
    	 ResultSet rs = null,rs1=null;


    	 HashMap hshQueryValues = new HashMap();
    	 HashMap hshQuery = new HashMap();
    	 ArrayList arrValues = new ArrayList();
    	 String strAppno="",strCategory="";
    	 String[] strFacSno= null;
    	 String[] strFacGroup= null;
    	 String[] strFacheadid= null;
    	 String[] strFac= null;
    	 String[] strFacamt= null;
    	 String [] strFaclimittype=null;
    	 int intSize=0;
    	 StringBuilder sbActionData=new StringBuilder();
 		StringBuilder sbOldAudit=new StringBuilder();

    	 try{
    		 strAppno=Helper.correctNull((String)hshValues.get("appno"));
    		 
    		 if(hshValues.get("txtfac_sno") instanceof java.lang.String)
    		 {
    			 strFacSno= new String[1];
    			 strFacSno[0]=(String)hshValues.get("txtfac_sno");
    		 }else{
    			 strFacSno=(String[])hshValues.get("txtfac_sno");
    		 }
    		 if(hshValues.get("sel_MainLimit") instanceof java.lang.String)
    		 {
    			 strFacGroup= new String[1];
    			 strFacGroup[0]=(String)hshValues.get("sel_MainLimit");
    		 }else{
    			 strFacGroup=(String[])hshValues.get("sel_MainLimit");
    		 }
    		 
    		 if(hshValues.get("txtfac_headid") instanceof java.lang.String)
    		 {
    			 strFacheadid= new String[1];
    			 strFacheadid[0]=(String)hshValues.get("txtfac_headid");
    		 }else{
    			 strFacheadid=(String[])hshValues.get("txtfac_headid");
    		 }
    		 if(hshValues.get("txtfac_desc") instanceof java.lang.String)
    		 {
    			 strFac= new String[1];
    			 strFac[0]=(String)hshValues.get("txtfac_desc");
    		 }else{
    			 strFac=(String[])hshValues.get("txtfac_desc");
    		 }
    		 if(hshValues.get("txtfac_amt") instanceof java.lang.String)
    		 {
    			 strFacamt= new String[1];
    			 strFacamt=(String[])hshValues.get("txtfac_amt");
    		 }else{
    			 strFacamt=(String[])hshValues.get("txtfac_amt");
    		 }
    		 if(hshValues.get("sellimitType") instanceof java.lang.String)
    		 {
    			 strFaclimittype= new String[1];
    			 strFaclimittype[0]=(String)hshValues.get("sellimitType");
    		 }else{
    			 strFaclimittype=(String[])hshValues.get("sellimitType");
    		 }
    		 
    		 strQuery = SQLParser.getSqlQuery("select_facilitydetails1^" +strAppno);

    		 if(rs != null)
    		 {
    			 rs.close();
    		 }

    		 rs = DBUtils.executeQuery(strQuery);
    		 String strfachead="";
    		 while(rs.next())
    		 {	
    			
    			 String strFacHeadId=correctNull(rs.getString("facility_headid"));
 				String strFacId=correctNull(rs.getString("facility_id"));
 				String strFaccode=Helper.correctNull((String)rs.getString("facility_code"));
 				String strgroup=Helper.correctNull((String)rs.getString("facility_group"));	
 				strfachead=Helper.correctNull((String)rs.getString("facility_catdesc"));	
 				if(strgroup.equalsIgnoreCase("0")){
 					strgroup="Main Limit";
 				}else{
 					strgroup="Sub Limit";
 				}

 				if(rs1!=null)
 				{
 					rs1.close();
 				}
 				String strfacilityDesc="";
 				rs1=DBUtils.executeLAPSQuery("selperfacilitydesc^"+strFacHeadId+"^"+strFacId+"^"+strFaccode);
 				if(rs1.next())
 				{
					strfacilityDesc=Helper.correctNull((String)rs1.getString("com_facdesc"));

 				}
 				sbOldAudit
				.append("~facility sno=").append(Helper.correctDouble((String)rs.getString("facility_sno")))
				.append("~facility headid=").append(Helper.correctNull((String)rs.getString("facility_catdesc"))).append("~facility=").
		        append(strfacilityDesc)
				.append("~Amount=").append(Helper.correctNull((String)rs.getString("facility_sancamt")))
				.append("~Limit type=").append(strgroup);}
 				
    		for (int i = 0 ; i < strFacSno.length; i++)
			{
    			intSize++;
				hshQuery=new HashMap();
				arrValues = new ArrayList();
				arrValues.add(strFacGroup[i]);
				arrValues.add(strAppno);
				arrValues.add(strFacSno[i]);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId","updfacilitygroup");
				hshQueryValues.put("size",String.valueOf(intSize));					
				hshQueryValues.put(String.valueOf(intSize),hshQuery);
				
				intSize++;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				arrValues.add(strAppno);
				arrValues.add(strFacSno[i]);
				hshQuery.put("arrValues",arrValues); 
				hshQuery.put("strQueryId","update_mis_appdetailssno"); 
				hshQueryValues.put("size",String.valueOf(intSize));					
				hshQueryValues.put(String.valueOf(intSize),hshQuery);
				
				if(!strFacGroup[i].equalsIgnoreCase("0"))
				{
					intSize++;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strFacSno[i]);
					arrValues.add(strAppno);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId","del_com_companydetails_ps");
					hshQueryValues.put("size",String.valueOf(intSize));					
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					
					intSize++;
					hshQuery=new HashMap();
					arrValues = new ArrayList();
					arrValues.add(strAppno);
					arrValues.add(strFacSno[i]);
					hshQuery.put("arrValues", arrValues);
					hshQuery.put("strQueryId","del_proposedsecuritydetails");
					hshQueryValues.put("size",String.valueOf(intSize));					
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
				}
				strCategory=Helper.correctNull((String)hshValues.get("sellimitType[i]"));
				if(strCategory.equals("M"))strCategory="Main Limit";
				if(strCategory.equals("S"))strCategory="sub Limit";
				if(!sbOldAudit.toString().equalsIgnoreCase(""))
				{
					String strlimiType=strFaclimittype[i];
					if(strlimiType.equalsIgnoreCase("M")){
						strlimiType="Main Limit";
					}else{
						strlimiType="Sub Limit";
					}
				sbActionData
				.append("~facility sno=").append(strFacSno[i])
				.append("~facility headid=").append(strFacheadid[i]).append("~facility=").
		        append(strFac[i])
				.append("~Amount=").append(strFacamt[i])
				.append("~Limit type=").append(strlimiType).append("~Sub Limit of=")
				.append(strFacGroup[i]);
				}
	    		 }
	    		 
				
			
    		
    		if(intSize>0)
    			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
    		
    		//co-applicant/security copying
    		if(rs!=null)
    			rs.close();
    		rs=DBUtils.executeLAPSQuery("selsublimfacilities^"+strAppno+"^0");
    		while(rs.next())
    		{
    				if(rs1!=null)
					   rs1.close();
				   	strQuery = SQLParser.getSqlQuery("selsublimfacilities^"+strAppno+"^"+Helper.correctNull(rs.getString("facility_sno")));
					rs1 =DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						hshQueryValues = new HashMap();
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","updcom_companydetails_ps");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull(rs1.getString("facility_sno")));	
						arrValues.add(Helper.correctNull(rs.getString("facility_sno")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);	
						hshQueryValues.put("size","1");
						
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId","copy_collateral_securitydetails");
						arrValues.add(strAppno);
						arrValues.add(Helper.correctNull(rs1.getString("facility_sno")));
						arrValues.add(Helper.correctNull(rs1.getString("facility_sancamt")));
						arrValues.add(Helper.correctNull(rs1.getString("facility_sancamt")));
						arrValues.add(Helper.correctNull(rs1.getString("facility_code")));
						arrValues.add(Helper.correctNull(rs.getString("facility_sno")));
						arrValues.add(strAppno);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("2",hshQuery);	
						hshQueryValues.put("size","2");
						
						
			    		EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
    		}
			AuditTrial.auditNewLog(hshValues,"557",strAppno,sbActionData.toString(),sbOldAudit.toString());	
			log.info("Audit Table:::::::::::::::::::::::PAGE ID=557:::::::::::: Application No:"+strAppno+" Action ="+Helper.correctNull((String)hshValues.get("hidAction"))+" Old Values==="
					+sbOldAudit.toString()+"===New Values ===="+sbActionData.toString());

    		

    	 }catch(Exception ce){
    		 log.error(ce.toString());
    		 throw new EJBException("Error in UpdateFacilityArrangement "+ce.toString());
    	 }
     }
     public HashMap msmeRoiUpdateServices(HashMap hshValues)
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
  		
  	try {
  				
  		String applicantMSMEIn="",Resp="aaaaaa",facilityName="",strproposalnumber="";
  		ApistatushandleBean apiStatus = new ApistatushandleBean();
  		
  	try
  	{
  		String facilitySno="",data="",strschemeCode="",strloanamount="",strsecamount="",line="",appRefNo="",strcgtmseav="";
  		
  		int intUpdatesize=0;
  		strproposalnumber=Helper.correctNull((String)hshValues.get("appno"));
  		facilitySno=Helper.correctInt((String)hshValues.get("strFacId"));
  		strschemeCode = Helper.correctNull((String) hshValues.get("hidLoanType"));
		if(strschemeCode.equals(""))
		{
			strschemeCode="0";
		}else if(strschemeCode.equals("DL"))
		{
			strschemeCode="TL";
		}
		
		
		if(!(facilitySno.equalsIgnoreCase("") || facilitySno.equals("0")))
		{
				strQuery = SQLParser.getSqlQuery("sel_AppRefNo^"+strproposalnumber);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					appRefNo=Helper.correctNull((String)rs.getString("INWARD_DIGIAPPNO"));	
				}
				if(appRefNo.equals(""))
				{
					appRefNo="0";
				}
				
				if(rs!=null)
				{	  rs.close(); 	}
				
				strQuery = SQLParser.getSqlQuery("sel_msme_roiup^"+strproposalnumber+"^"+facilitySno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strloanamount=Helper.correctNull((String)rs.getString("FACILITY_SANCAMT"));	
					strsecamount=Helper.correctNull((String)rs.getString("FACILITY_SECAMOUNT"));
				}
				if(strloanamount.equals(""))
				{
					strloanamount="0";
				}
				if(strsecamount.equals(""))
				{
					strsecamount="0";
				}
			//	facilityName for OD should be like this : 'od'  'wcdpn' 
			  //     and for TL product ucan pass as tl,cv,noncv
				if(strschemeCode.equals("OD")){
					facilityName = "od";
				}else if(strschemeCode.equals("TL")){
					facilityName = "tl";
				}else if(strschemeCode.equals("DL")){
					facilityName = "tl";
				}else{
					facilityName = "0";
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
				
				ArrayList arrFacilities= new ArrayList();
				
		  		data="{\"facilitySno\": "+facilitySno+", " +
				"\"facilityName\": \""+facilityName+"\"," +
					"\"loanAmount\": "+strloanamount+"," +
						"\"CollartralAmount\":"+strsecamount+"}";
		
				
				arrFacilities.add(data);
				applicantMSMEIn="{" +
				"\"applicationRefNum\":\""+appRefNo+"\"," +
				"\"productType\": \""+strschemeCode+"\" ," +
				"\"cgtmseFlag\": \""+strcgtmseav+"\" ," +
							"\"data\":"+arrFacilities+"}";
				
				System.out.print(applicantMSMEIn);
				log.info("################@@@@@@@@@@@@@ ROI MSME UPDATE REQUEST @@@@@@@@@@@@@################ "+applicantMSMEIn);
		
				URL roiupdMSME_url = new URL(ApplicationParams.getStrroiMSMEupdurl());
				log.info("ROI MSME UPDATE URL=========== "+roiupdMSME_url);
				HttpURLConnection urlcon = (HttpURLConnection) roiupdMSME_url.openConnection();
				urlcon.setRequestProperty("User-Agent", "");
				urlcon.setDoInput(true);
				urlcon.setDoOutput(true);
				urlcon.setRequestMethod("POST");
				urlcon.setRequestProperty("Content-Type","application/json;charset=UTF-8");
				urlcon.setRequestProperty("Authorization","Basic" );
				OutputStream outputStream = urlcon.getOutputStream();
				OutputStreamWriter osw = new OutputStreamWriter(outputStream, "UTF8");
		
				BufferedWriter bWriter = new BufferedWriter(osw);
				bWriter.write(applicantMSMEIn);
				bWriter.close();
		
				InputStream inputStream = urlcon.getInputStream();
				InputStreamReader isreader = new InputStreamReader(inputStream,"UTF-8");
		
				BufferedReader rd = new BufferedReader(isreader);
		
				if (rd != null) {
				StringBuffer result = new StringBuffer();
				while ((line = rd.readLine()) != null) {
					result.append(line);
				}
				//****************************************************** Below is Response ************************************************************//
				log.info("################@@@@@@@@@@@@@ ROI MSME UPDATE Response @@@@@@@@@@@@@################"+ result.toString());
				// Newly added	
				Resp = result.toString();
				JSONObject json1= new  JSONObject(result.toString());
				JSONObject json = json1.getJSONObject("data");
				String strbandRating=String.valueOf(json.get("bandRating"));
				String strbandPath=String.valueOf(json.get("bandPath"));
				JSONArray jsonResArray1 = json.getJSONArray("data");
				int MSMElistlength=jsonResArray1.length();
				if(MSMElistlength>0)
				{
		
					ArrayList arrtemp=new ArrayList();
					for(int i=0;i<MSMElistlength;i++)
					{
						
						JSONObject jsonObjectForValues = jsonResArray1.getJSONObject(i);
						String STRRATEOFINTERESTVALUE = String.valueOf(jsonObjectForValues.get("interesttype")); //FACILITY_INTEREST
						String STRBASERATEVALUE = String.valueOf(jsonObjectForValues.get("benchmarkrate")); //FACILITY_BASERATE
						String STRFIXEDRATEVALUE= String.valueOf(jsonObjectForValues.get("fixedrate"));
						String STRCREDITRSKVALVALUE = String.valueOf(jsonObjectForValues.get("creditriskpremium"));
						String STRPENALINTERESTVALUE= String.valueOf(jsonObjectForValues.get("penalinterest"));//BPLR
						String STRTOTALINTERESTVALUE= String.valueOf(jsonObjectForValues.get("totalintrate"));//FACILITY_SANCINTEREST
						String STRCONCESSIONVALUE= String.valueOf(jsonObjectForValues.get("concession")); //FACILITY_CONCESSION
						String strkbRating="";
						String STRCONCESSIONDESCRIPTION= String.valueOf(jsonObjectForValues.get("concessionDescription"));  //FACILITY_CONDESCS
						if(!STRTOTALINTERESTVALUE.equals("") || !STRTOTALINTERESTVALUE.equals("0") || !STRCREDITRSKVALVALUE.equals("") || !STRCREDITRSKVALVALUE.equals("0") ){
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
								mclrtabcode=Helper.correctNull((String)rs.getString("MCLR_TABLECODEOVERDRAFTS"));

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
								
						 	//FACILITY_MCLRSPREAD						
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","msme_fac_mclrsprd");
							arrValues.add(mclrtype);//FACILITY_MCLRTYPE
							arrValues.add(STRCREDITRSKVALVALUE);//MCLR_CRP_TOTAL
							arrValues.add(STRFIXEDRATEVALUE);//MCLR_BSP_TOTAL
							arrValues.add(STRBASERATEVALUE);//MCLR_SPREAD
							arrValues.add(strproposalnumber);//FACILITY_APPNO
							arrValues.add(facilitySno);//FACILITY_SNO
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize, hshQuery);
							
							System.out.print(strproposalnumber);
							log.info("################@@@@@@@@@@@@@ ROI MSME UPDATED IN FACILITY_MCLRSPREAD @@@@@@@@@@@@@################ "+strproposalnumber);
							
							
							if(rs!=null)
							{	  rs.close(); 	}
							
							strQuery = SQLParser.getSqlQuery("sel_msme_roiup_sprdval^"+strproposalnumber+"^"+facilitySno);
							rs = DBUtils.executeQuery(strQuery);
							while(rs.next())
							{
								String strmclrCaption=Helper.correctNull((String)rs.getString("MCLR_CAPTION"));	
							
								if(strmclrCaption.equals("Credit Risk Premium"))
								{
									//FACILITY_MCLRSPREADVALUE
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","msme_fac_mclrsprdval");
									arrValues.add(STRCREDITRSKVALVALUE);//MCLR_SPREADVAL
									arrValues.add(strproposalnumber);//FACILITY_APPNO
									arrValues.add(facilitySno);//FACILITY_SNO
									arrValues.add(strmclrCaption);//MCLR_CAPTION
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(""+intUpdatesize, hshQuery);	
									
									System.out.print(strproposalnumber);
									log.info("################@@@@@@@@@@@@@ ROI MSME UPDATED IN FACILITY_MCLRSPREADVALUE @@@@@@@@@@@@@################ "+strproposalnumber);
									
								}else if(strmclrCaption.equals("Fixed Spread")){
									//FACILITY_MCLRSPREADVALUE
									hshQuery=new HashMap();
									arrValues=new ArrayList();
									intUpdatesize++;
									hshQuery.put("strQueryId","msme_fac_mclrsprdval");
									arrValues.add(STRFIXEDRATEVALUE);//MCLR_SPREADVAL
									arrValues.add(strproposalnumber);//FACILITY_APPNO
									arrValues.add(facilitySno);//FACILITY_SNO
									arrValues.add(strmclrCaption);//MCLR_CAPTION
									hshQuery.put("arrValues",arrValues);
									hshQueryValues.put(""+intUpdatesize, hshQuery);	
									
									System.out.print(strproposalnumber);
									log.info("################@@@@@@@@@@@@@ ROI MSME UPDATED IN FACILITY_MCLRSPREADVALUE @@@@@@@@@@@@@################ "+strproposalnumber);
								}
								
							}
							
							//FACILITIES						
							hshQuery=new HashMap();
							arrValues=new ArrayList();
							intUpdatesize++;
							hshQuery.put("strQueryId","upd_msme_roiflag");
							arrValues.add(STRTOTALINTERESTVALUE);//FACILITY_INTEREST			
							arrValues.add(STRTOTALINTERESTVALUE);//BPLR							
							arrValues.add(STRTOTALINTERESTVALUE);//FACILITY_SANCINTEREST		
							arrValues.add(STRBASERATEVALUE);//FACILITY_BASERATE					
							arrValues.add("Y");//FACILITY_ROIFLAG								
							arrValues.add(STRCONCESSIONVALUE); //FACILITY_CONCESSION
							arrValues.add(STRCONCESSIONDESCRIPTION); //FACILITY_CONDESC
							arrValues.add(strproposalnumber);//FACILITY_APPNO
							arrValues.add(facilitySno);//FACILITY_SNO
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize, hshQuery);
							
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
								arrValues.add("Band Rating");//HIS_PARAMETER
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
								arrValues.add("KB Rating");//HIS_PARAMETER
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
								arrValues.add("BAND PATH");//HIS_PARAMETER
								hshQuery.put("strQueryId","ins_rating_his");
								hshQuery.put("arrValues",arrValues);
								hshQueryValues.put(""+intUpdatesize, hshQuery);
								
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
							arrValues.add("Band Rating");//HIS_PARAMETER
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
							arrValues.add(strexistbdpath);//HIS_EXISTINGVAL
							arrValues.add(strnewVal);//HIS_NEWVAL
							arrValues.add(strUserId);//HIS_USRID
							arrValues.add("BAND PATH");//HIS_PARAMETER
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
							arrValues.add(strexistkbrat);//HIS_EXISTINGVAL
							arrValues.add(strnewVal);//HIS_NEWVAL
							arrValues.add(strUserId);//HIS_USRID
							arrValues.add("KB Rating");//HIS_PARAMETER
							hshQuery.put("strQueryId","ins_rating_his");
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put(""+intUpdatesize, hshQuery);
							}
							
							System.out.print(strproposalnumber);
							log.info("################@@@@@@@@@@@@@ ROI MSME UPDATED IN FACILITIES FLAG @@@@@@@@@@@@@################ "+strproposalnumber);
							
							hshQueryValues.put("size",String.valueOf(intUpdatesize));
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");
					}else{
						//FACILITIES						
						hshQuery=new HashMap();
						arrValues=new ArrayList();
						intUpdatesize++;
						hshQuery.put("strQueryId","upd_msme_roiflag_rateofint");
						arrValues.add("O");//FACILITY_ROIFLAG
						arrValues.add(strproposalnumber);//FACILITY_APPNO
						arrValues.add(facilitySno);//FACILITY_SNO
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(""+intUpdatesize, hshQuery);
						
						System.out.print(strproposalnumber);
						log.info("################@@@@@@@@@@@@@ ROI MSME RESPONSE creditriskpremium OR  totalintrate IS 0 @@@@@@@@@@@@@################ "+strproposalnumber);
						
						hshQueryValues.put("size",String.valueOf(intUpdatesize));
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues, "updateData");

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
		arrValues.add(applicantMSMEIn);
		arrValues.add("SUCESS"); 
		arrValues.add("MSME"); 
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
		arrValues.add(applicantMSMEIn);
		arrValues.add("FAILURE"); 
		arrValues.add("MSME"); 
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
  				throw new EJBException("Error in msmRoiUpdateServices "+e.getMessage());
  	  		}
  		
  		
  	return hshValues;	
  	}
     
     
     
  public HashMap chkMCLRTable(HashMap hshValues) throws EJBException
 	{
 		String strQuery	= "",strLmsCheck="";
 		ResultSet rs 	= null;
 		boolean bflag=true;
 		ArrayList arrParam=new ArrayList();
 		HashMap hshRecord = new HashMap();
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
    	jtn.setMaximumFractionDigits(2);
    	jtn.setMinimumFractionDigits(2);
    	jtn.setGroupingUsed(false);
    	int lng=0;
    	
 		try
 		{
 			
 			
 			String fbilldateval=correctNull((String)hshValues.get("fbilldatavalue"));
			strQuery = SQLParser.getSqlQuery("selonlyfbill^"+fbilldateval);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TYPE")));
				arrCol.add(Helper.correctNull(rs.getString("description")));
				arrCol.add(jtn.format(Double.parseDouble(Helper.correctDouble(rs.getString("MCLR_BASERATESPREAD")))));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODE")));
				arrCol.add(Helper.correctNull(rs.getString("MCLR_TABLECODEOVERDRAFTS")));
				lng++;
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow", arrRow);
		
	
			
 		}
 		
 		
 		catch(Exception ce)
 		{
 			throw new EJBException("Error in getkslnumberfromlms: "+ce.toString());
 		}
 		finally
 		{
 			try
 			{
 				if(rs != null){rs.close();}
 			}
 			catch(Exception cf)
 			{
 				throw new EJBException("Error closing the connection "+cf.getMessage());
 			}
 		}
 		
 		return hshRecord;
 	}
 
  public HashMap getvalid_eNWRDOI(HashMap hshRequestValues)  {
	  ResultSet rs=null;
	  HashMap hshRecord = new HashMap();
		String strinwardno=Helper.correctNull((String)hshRequestValues.get("inwardno"));
		String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
		String strSno=Helper.correctInt((String)hshRequestValues.get("sel_facilitysno"));
		String strdate=Helper.correctNull((String)hshRequestValues.get("txt_issueofeNWR_date"));
		//String strCondition = Helper.correctNull((String)hshRequestValues.get("hidCondtion"));
		String strcount="";
		String strQuery="";
		
		try
		{
				if (rs != null)
					rs.close();
				//strQuery = SQLParser.getSqlQuery("sel_RenewFlg^"+strAppno);
				strQuery = SQLParser.getSqlQuery("getvalidenwrdate^"+strdate+"^"+strAppno);
			if(rs != null)
			{rs.close();}
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strcount=correctNull((String)rs.getString("COUNT"));
				hshRecord.put("strcount",strcount);
			}
		}
		catch (Exception ce) {
			throw new EJBException("Error in getvalid_eNWRDOI "
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
  public HashMap getagr_eNWR(HashMap hshRequestValues)  {
		ResultSet rs1=null;
		ResultSet rs2=null;
		
		HashMap hshRecord = new HashMap();
		String strinwardno=Helper.correctNull((String)hshRequestValues.get("inwardno"));
		String strAppno=Helper.correctNull((String)hshRequestValues.get("appno"));
		String strSno=Helper.correctInt((String)hshRequestValues.get("sel_facilitysno"));
		//String strCondition = Helper.correctNull((String)hshRequestValues.get("hidCondtion"));
	
		String strQuery="";
		String strQuery1="";
		
		try
		{
			hshRecord.put("facility",strSno);
		
			strQuery = SQLParser.getSqlQuery("selagreNWRdetails^"+strSno+"^"+strAppno);			
		if(rs1 != null)
		{rs1.close();}
		rs1 = DBUtils.executeQuery(strQuery);
		if(rs1.next())			
			{
			hshRecord.put("Sno",correctNull((String)rs1.getString("ENWR_SNO")));
			hshRecord.put("eNWR_date",correctNull((String)rs1.getString("ENWR_DOI")));
			hshRecord.put("receiptnumber",correctNull((String)rs1.getString("ENWR_RECEIPT_NO")));
			hshRecord.put("eNWRvalidupto_date",correctNull((String)rs1.getString("ENWR_VALIDUPTO")));
			hshRecord.put("croporcommodity",correctNull((String)rs1.getString("ENWR_CROPNAME")));
	
			hshRecord.put("godownno",correctNull((String)rs1.getString("ENWR_GODOWNNUM")));
			hshRecord.put("noofpackages",correctNull((String)rs1.getString("ENWR_NOOFPACKAGES")));
			hshRecord.put("netquantity",correctNull((String)rs1.getString("ENWR_NET_QTY")));
			hshRecord.put("estimatedvalue",correctNull((String)rs1.getString("ENWR_ESTIMATEVALUE")));
			hshRecord.put("totalvalue",correctNull((String)rs1.getString("ENWR_TOTALVALUE")));
			hshRecord.put("godownname",correctNull((String)rs1.getString("ENWR_GODOWNNAME")));
			hshRecord.put("godownreg_no",correctNull((String)rs1.getString("ENWR_GODOWN_REGNO")));
			hshRecord.put("godownregvalidupto_date",correctNull((String)rs1.getString("ENWR_GODOWN_REG_DATE")));	
			hshRecord.put("totalcapacity",correctNull((String)rs1.getString("ENWR_TOTALCAPACITY")));
			
			hshRecord.put("capacityutilason_date",correctNull((String)rs1.getString("ENWR_CAPACITY_UTILDT")));
			hshRecord.put("city",correctNull((String)rs1.getString("ENWR_CITY")));
			hshRecord.put("District",correctNull((String)rs1.getString("ENWR_DISTRICT")));
			hshRecord.put("State",correctNull((String)rs1.getString("ENWR_STATE")));
			hshRecord.put("Place",correctNull((String)rs1.getString("ENWR_PLACE")));
			hshRecord.put("Godowndistance",correctNull((String)rs1.getString("ENWR_GODOWN_DISTANCE")));
			hshRecord.put("InsuranceName",correctNull((String)rs1.getString("ENWR_INSURANCENAME")));
			hshRecord.put("PolicyNo",correctNull((String)rs1.getString("ENWR_POLICY_NO")));
			hshRecord.put("PolicyDate",correctNull((String)rs1.getString("ENWR_POLICYDT")));
			hshRecord.put("Amount",correctNull((String)rs1.getString("ENWR_AMT")));
			hshRecord.put("DueDate",correctNull((String)rs1.getString("ENWR_DUEDT")));
			hshRecord.put("CreatedDate",correctNull((String)rs1.getString("ENWR_CREATED_DATE")));
			hshRecord.put("CreatedBy",correctNull((String)rs1.getString("ENWR_CREATED_BY")));
			hshRecord.put("ModifiedBy",correctNull((String)rs1.getString("ENWR_MODIFIED_BY")));
			hshRecord.put("ModifiedDate",correctNull((String)rs1.getString("ENWR_MODIFIED_DT")));
			}
		
			strQuery1 = SQLParser.getSqlQuery("getvalidenwrdate1^"+strinwardno);			
			if(rs1 != null)
			{rs1.close();}
			rs1 = DBUtils.executeQuery(strQuery1);
			if(rs1.next())			
				{
				hshRecord.put("inwarddate",correctNull((String)rs1.getString("INWARD_CREATEDON")));
				hshRecord.put("enddate",correctNull((String)rs1.getString("ENDDATE")));
				}
			String strQuery3="";
			strQuery3= SQLParser.getSqlQuery("selfacilityproposedmt^" + strAppno+"^"+strSno);					
			rs2 = DBUtils.executeQuery(strQuery3);
			if(rs2.next())
			{
				hshRecord.put("facdate",correctNull(rs2.getString("facility_date")));			
			}
		
		}
		catch (Exception ce) {
			throw new EJBException("Error in getagr_eNWR "
					+ ce.toString());
		} finally {
			try {
				if (rs1 != null)
					rs1.close();

			} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());
			}
		}
		return hshRecord;
		
	}

	
	public void updateagreNWR(HashMap hshValues)  
	{

		HashMap hshQuery=new HashMap();
		HashMap hshRecord = new HashMap();
		HashMap hshQueryValues = null;
		String strQuery = "";
		ResultSet rs = null;
		ArrayList arr= new ArrayList() ;
		
		HashMap hshQuery1=new HashMap();
		HashMap hshRecord1 = new HashMap();
		HashMap hshQueryValues1 = null;
		String strQuery1 = "";
	
		ArrayList arr1= new ArrayList();
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strFacilitySno=Helper.correctNull((String)hshValues.get("hidfacility"));
		String strinwardno=Helper.correctNull((String)hshValues.get("inwardno"));
		ArrayList arrValues = new ArrayList();
		ArrayList arrValues1 = new ArrayList();
		try
		{
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delagreNWRdetails");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
			}
			else if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery1 = new HashMap();
				arrValues1 = new ArrayList();
				hshQueryValues1=new HashMap();
				arrValues1.add(strAppno);
				arrValues1.add(strFacilitySno);
				hshQuery1.put("strQueryId", "delagreNWRdetails");
				hshQuery1.put("arrValues", arrValues1);
				hshQueryValues1.put("size","1");
				hshQueryValues1.put("1",hshQuery1);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues1,"updateData");
				

		 		arrValues = new ArrayList();
			    hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues.add(strFacilitySno);				
				arrValues.add(Helper.correctNull((String)hshValues.get("appno")));	
				arrValues.add(strinwardno);	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_issueofeNWR_date")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_receiptnumber")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_eNWRvalidupto_date")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_croporcommodity")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_godownno")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_nopackages")));	
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_netquantity")));			
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_estimatedvalue")));//9
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totalvalue")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_warehouse")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_godownreg_no")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_godownregvalidupto_date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_totalcapacity")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_capacityutilason_date")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_City")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_District")));	
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_State")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_place")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("sel_godown_distance")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_insurance")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_policyno")));			
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_date")));		
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_amount")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_duedate")));				
				arrValues.add(Helper.correctNull((String)hshValues.get("strUserId")));				
					
				hshQuery.put("arrValues",arrValues);
				hshQuery.put("strQueryId","agreNWR_insert");			
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}
			
			
		}			
		catch (Exception ce) {
			throw new EJBException("inside update" + ce.toString());
		}
			finally
			{
				try
				{
					if(rs != null)
					{
						rs.close();
					}
				} catch (Exception cf) {
				throw new EJBException("Error closing the connection "
						+ cf.getMessage());

			}
		}
	
	}
  
}    
