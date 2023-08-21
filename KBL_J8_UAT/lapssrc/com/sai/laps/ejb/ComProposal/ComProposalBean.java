package com.sai.laps.ejb.ComProposal;
//import java.rmi.RemoteException;
import java.io.ByteArrayOutputStream;
import java.sql.Blob;
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

import com.sai.laps.ejb.agriculture.AgriMechanisedBoatBean;
import com.sai.laps.ejb.agrloanassessment.AgriLoanAssessmentBean;
import com.sai.laps.ejb.comrepayschedule.ComRepayScheduleBean;
import com.sai.laps.ejb.rules.AgrFarmMachineryBO;
import com.sai.laps.ejb.rules.AgrNurseryLoanBO;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.AuditTrial;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SetupParams;

@Stateless(name = "ComProposalBean", mappedName = "ComProposalHome")
@Remote (ComProposalRemote.class)
public class ComProposalBean extends BeanAdapter
{	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6664302505940162746L;
	


	static Logger log=Logger.getLogger(ComProposalBean.class);	

	
	
	/**
	 * 
	 */
	public HashMap getData(HashMap hshRequestValues) 
	{	
		ResultSet rs = null;
		ResultSet rs1 = null,rs5=null;
		HashMap hshValues=new HashMap();
		String strQuery="",strValue="",comapp_id="",strorgcode="",strOrgLevel="";
		String strRatHideAppl="",ApprUserid="";
		try
		{	
			strValue=correctNull((String)hshRequestValues.get("appno"));
			comapp_id=correctNull((String)hshRequestValues.get("comappid"));
			strorgcode=correctNull((String)hshRequestValues.get("strOrgCode"));
			strOrgLevel=correctNull((String)hshRequestValues.get("strOrgLevel"));
			strRatHideAppl=correctNull((String)hshRequestValues.get("hidratingTabHideAppl"));
			hshValues = new HashMap();

			if(strorgcode.equalsIgnoreCase("001000000000000") || strOrgLevel.equalsIgnoreCase("R")|| strOrgLevel.equalsIgnoreCase("D"))
			{
				hshValues.put("headoffice","H");	// Access for both HO and RO (Just using the same flag)
			}
			else
			{
				hshValues.put("","A");	
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("selapprecdate^"+strValue);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("inward_appliedon",Helper.correctNull((String)rs.getString("inward_appliedon")));
			}
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+strValue);
			rs=DBUtils.executeQuery(strQuery);
			
			if(rs.next())
			{
				comapp_id=correctNull(rs.getString("demo_appid"));
				hshValues.put("comid",correctNull((String)rs.getString("demo_appid")));
				hshValues.put("app_status",correctNull((String)rs.getString("app_status")));
				hshValues.put("app_renew_flag",correctNull(rs.getString("app_renew_flag")));
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("compropform_1^"+strValue);
			
			rs = DBUtils.executeQuery(strQuery);
			//String code="";
			String companyiddesc = "";	 
			while(rs.next())
			{  
				hshValues.put("companyname",correctNull(rs.getString("comapp_companyname")));
				hshValues.put("regoffaddress",correctNull(rs.getString("regoffaddress")));
				hshValues.put("companycity",correctNull(rs.getString("comapp_regcity")));
				hshValues.put("companystate",correctNull(rs.getString("comapp_regstate")));
				hshValues.put("companypin",correctNull(rs.getString("comapp_regpin")));
				hshValues.put("companyfax",correctNull(rs.getString("comapp_regfax")));
				hshValues.put("companyphone",correctNull(rs.getString("comapp_regphone")));					
				hshValues.put("corpoffaddress",correctNull(rs.getString("corpoffaddress")));
				hshValues.put("regoffcity",correctNull(rs.getString("comapp_crptcity")));
				hshValues.put("regoffstate",correctNull(rs.getString("comapp_crptstate")));
				hshValues.put("regoffpin",correctNull(rs.getString("comapp_crptpin")));
				hshValues.put("regoffphone",correctNull(rs.getString("comapp_crptphone")));
				//hshValues.put("factoffaddress",correctNull(rs.getString("factoffaddress")));
				//hshValues.put("factoffcity",correctNull(rs.getString("comapp_factcity")));
				//hshValues.put("factoffstate",correctNull(rs.getString("comapp_factstate")));
				//hshValues.put("factoffpin",correctNull(rs.getString("comapp_factpin")));
				//hshValues.put("factoffphone",correctNull(rs.getString("comapp_factphone")));
				hshValues.put("dateofincorp",correctNull(rs.getString("comapp_yrsinbusiness")));
				hshValues.put("constitution",correctNull(rs.getString("comapp_ownership")));
				hshValues.put("group",correctNull(rs.getString("groupcomp")));
				hshValues.put("activitynature",correctNull(rs.getString("comapp_businessnature")));
				hshValues.put("dealings",correctNull(rs.getString("comapp_bankdealing")));
				companyiddesc = correctNull(rs.getString("comapp_companyid"));
				hshValues.put("companyiddesc",companyiddesc);
			}
			/*if(comapp_id!="")
			{
				String StrQuery1=SQLParser.getSqlQuery("selallfactorydetails^"+comapp_id);
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeQuery(StrQuery1);
				ArrayList vecCol=new ArrayList();
				ArrayList vecRow=new ArrayList();
				while(rs.next())
				{
					vecCol = new ArrayList();
					vecCol.add(correctNull((String)rs.getString("comapp_id")));
					vecCol.add(correctNull((String)rs.getString("comapp_sno")));
					vecCol.add(correctNull((String)rs.getString("comapp_detailtype")));
					vecCol.add(correctNull((String)rs.getString("comapp_name")));
					vecCol.add(correctNull((String)rs.getString("comapp_add")));
					vecCol.add(correctNull((String)rs.getString("comapp_city")));
					vecCol.add(correctNull((String)rs.getString("comapp_state")));
					vecCol.add(correctNull((String)rs.getString("comapp_pincode")));
					vecCol.add(correctNull((String)rs.getString("comapp_phoneno")));
					vecCol.add(correctNull((String)rs.getString("comapp_fax")));
					vecRow.add(vecCol);
				}			
				hshValues.put("vecRow",vecRow);
			}
			*/
			String strbrnhsolid="",strbranchname="";
			strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				strbrnhsolid=Helper.correctNull(rs.getString("com_npabranch"));
				strQuery = SQLParser.getSqlQuery("checkDuplicateSolid^"+strbrnhsolid);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strbranchname=Helper.correctNull(rs1.getString("org_name"));
				}
				hshValues.put("com_appno",correctNull(rs.getString("com_appno")));
				hshValues.put("com_partyfileno",correctNull(rs.getString("com_partyfileno")));
				hshValues.put("com_branchrcvddate",correctNull(rs.getString("com_branchrcvddate")));
				hshValues.put("com_branchcompletedate",correctNull(rs.getString("com_branchcompletedate")));
				hshValues.put("com_meeting",correctNull(rs.getString("com_meeting")));
				hshValues.put("com_meetingdate",correctNull(rs.getString("com_meetingdate")));
				hshValues.put("com_submittedto",correctNull(rs.getString("com_submittedto")));					
				hshValues.put("com_format",correctNull(rs.getString("com_format")));
				hshValues.put("com_advanceason",correctNull(rs.getString("com_advanceason")));
				hshValues.put("com_advanceamt",correctNull(rs.getString("com_advanceamt")));
				hshValues.put("com_depositason",correctNull(rs.getString("com_depositason")));
				hshValues.put("com_depositamt",correctNull(rs.getString("com_depositamt")));
				hshValues.put("com_npaason",correctNull(rs.getString("com_npaason")));
				hshValues.put("com_npaamt",correctNull(rs.getString("com_npaamt")));
				hshValues.put("com_npabranch",strbranchname);
				hshValues.put("com_sancauthority",correctNull(rs.getString("com_sancauthority")));
				hshValues.put("com_sancdept",correctNull(rs.getString("com_sancdept")));
				hshValues.put("com_sanclevel",correctNull(rs.getString("com_sanclevel")));
				hshValues.put("com_sancrefno",correctNull(rs.getString("com_sancrefno")));
				hshValues.put("com_inspectiondate",correctNull(rs.getString("com_inspectiondate")));
				hshValues.put("com_inspectionamount",correctNull(rs.getString("com_inspectionamount")));
				hshValues.put("com_processnotedate",correctNull(rs.getString("com_processnotedate")));
				hshValues.put("com_sector",correctNull(rs.getString("com_sector")));
				hshValues.put("com_roho",correctNull(rs.getString("com_roho")));
				hshValues.put("com_individual",correctNull(rs.getString("com_individual")));
				hshValues.put("com_group",correctNull(rs.getString("com_group")));
				hshValues.put("com_comments",Helper.CLOBToString(rs.getClob("com_comments")));
				hshValues.put("com_sancbranch",correctNull(rs.getString("com_sancbranch")));
                hshValues.put("com_amountvalue",correctNull(rs.getString("com_amountvalue")));
                hshValues.put("com_proposalsanctype",correctNull(rs.getString("com_proposalsanctype")));
                hshValues.put("com_griddate",correctNull(rs.getString("com_griddate")));
                hshValues.put("com_interest_refno",correctNull(rs.getString("com_interest_refno")));
                hshValues.put("com_processingfee",Helper.correctNull(rs.getString("com_processingfee")));
                hshValues.put("COM_SANREF_SANCDATE",Helper.correctNull(rs.getString("COM_SANREF_SANCDATE")));
                hshValues.put("COM_CFR_VERIFIED",Helper.correctNull(rs.getString("COM_CFR_VERIFIED")));
                hshValues.put("COM_CFR_BORNAME",Helper.correctNull(rs.getString("COM_CFR_BORNAME")));
                hshValues.put("COM_CFR_DEV_RENFO",Helper.correctNull(rs.getString("COM_CFR_DEV_RENFO")));
                
                hshValues.put("status_verified1",Helper.correctNull(rs.getString("STATUS_VERIFIED")));
                hshValues.put("loan_appr_userid1",Helper.correctNull(rs.getString("COM_USERID2")));
                hshValues.put("loan_Appr_date",Helper.correctNull(rs.getString("COM_APPR_DATE")));
                hshValues.put("COM_CERSAI_VERIFIED",Helper.correctNull(rs.getString("COM_CERSAI_VERIFIED")));
                
                if(rs1!=null)
				{rs1.close();}
                strQuery = SQLParser.getSqlQuery("getorgcode^"+correctNull(rs.getString("COM_PERTAINS_BRANCH")));
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					hshValues.put("strBranchName", Helper.correctNull(rs1.getString("org_name")));
					hshValues.put("strBranchCode", Helper.correctNull(rs.getString("COM_PERTAINS_BRANCH")));
					hshValues.put("strBranchOrgCode", Helper.correctNull(rs1.getString("org_code")));
				}
                //hshValues.put("COM_PERTAINS_BRANCH",Helper.correctNull(rs.getString("COM_PERTAINS_BRANCH")));
                ApprUserid = Helper.correctNull((String)rs.getString("COM_USERID2"));
				
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
						hshValues.put("appuserid",correctNull((String)rs1.getString("name")));
					}
				}
				 hshValues.put("COM_CSLMSNO",correctNull(rs.getString("COM_CSLMSNO")));
			}
//			if(rs!=null)
//				rs.close();
//			
//			strQuery = SQLParser.getSqlQuery("selexternalrating^"+strValue);				
//			rs = DBUtils.executeQuery(strQuery);
//				 
//			while(rs.next())
//			{  
//				if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extagency"))
//				{
//					hshValues.put("extagency",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
//				}
//				else if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extlastrate"))
//				{
//					hshValues.put("extlastrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
//				}
//				else if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extcurrate"))
//				{
//					hshValues.put("extcurrate",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));
//				}
//			}
//			
//			SME - end
//			vecVal = new ArrayList();
//			type = "M";
//			strQuery = SQLParser.getSqlQuery("compropform4^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString("com_actdesc")));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("manfactureactivity",vecVal);
//			vecVal = new ArrayList();
//			type = "T";
//			strQuery = SQLParser.getSqlQuery("compropform4^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString("com_actdesc")));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("tradingactivity",vecVal);
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("compropform5^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString("com_grpcompname")));
//				vecRec.add(correctNull(rs.getString("com_grpcompactivity")));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("companyactivity",vecVal);
//			vecVal = new ArrayList();
//			
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("compropfacility4^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(3)));
//				vecRec.add(correctNull(rs.getString(4)));
//				vecRec.add(correctNull(rs.getString(5)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("othertable",vecVal);
			
			strQuery = SQLParser.getSqlQuery("compropform11^"+strValue);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("companydesc",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));	
			}
			
//			strQuery = SQLParser.getSqlQuery("comactivity2^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("activcomment",correctNull(Helper.CLOBToString(rs.getClob("com_propcomdesc"))));	
//			}	
//			
//			//Added by Mercy to get sister concerns
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("seldivisiondetails^"+comapp_id);
//			if(rs != null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString("comapp_div_name")));
//				vecRec.add(correctNull(rs.getString("comapp_div_bsrcode")));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("vecSisterConcerns",vecVal);
			
			//ADDED BY  BHASKAR FOR RATING YES/NO CHECKING
			
			String strRatFlag="",strWHTDIGIPRDRAT="";
			String strRatingTabHide="Y";
			rs=DBUtils.executeLAPSQuery("selfacratingflagmain^"+strValue);
			while(rs.next())
			{
				strRatFlag=strRatFlag+Helper.correctNull(rs.getString("COM_FACRATING"))+"@";
				strWHTDIGIPRDRAT = Helper.correctNull(rs.getString("COM_WHTDIGIPRDRAT"));
			}			
			if(!strRatFlag.equalsIgnoreCase("") && strRatFlag.contains("@"))
			{
				strRatFlag=strRatFlag.substring(0,strRatFlag.length()-1);
			}
			if(strRatFlag.contains("Y"))
			{
				strRatingTabHide="N";
			}
			hshValues.put("strRatingTabHide",strRatingTabHide);
			hshValues.put("strWHTDIGIPRDRAT",strWHTDIGIPRDRAT);
		
			//ENDED
			
			//To get the WCDPN facility
			strQuery = SQLParser.getSqlQuery("sel_wcdpnfac^"+strValue);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("FACILITY_ID")).equalsIgnoreCase("48"))
					hshValues.put("wcdpn_available","Y");
				else if(Helper.correctNull(rs.getString("FACILITY_ID")).equalsIgnoreCase("98"))
					hshValues.put("strDPN2020","Y");	
			}
			
			//To get the GECL facility
			strQuery = SQLParser.getSqlQuery("chk_geclfacchk^"+strValue);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("061"))
					hshValues.put("strgeclavailable","Y");	
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("063"))
					hshValues.put("strMMithra","Y");
				if(Helper.correctNull(rs.getString("com_bankscheme")).equalsIgnoreCase("065"))
					hshValues.put("strcgssdavailable","Y");
				
			}
			
			if(rs!=null)
				rs.close();
			int CGTMSEcount=0;
			strQuery = SQLParser.getSqlQuery("get_FacilityData^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				String temp =Helper.correctNull((String)rs.getString("FACILITY_WHT_CGTMSEAPPLY"));
				if(temp.equals("Y"))
					CGTMSEcount++;
			}
			if(CGTMSEcount>0)
				hshValues.put("PRD_CGTMSE","Y");
			else
				hshValues.put("PRD_CGTMSE","N");
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_app_perm_no^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshValues.put("APP_PERM_NO",Helper.correctNull(rs.getString("APP_PERM_NO")));
				hshValues.put("strAppCreatedOrg",Helper.correctNull(rs.getString("APP_ORGLEVEL")));
				hshValues.put("APP_LOANSUBTYPE_DIGI",Helper.correctNull(rs.getString("APP_LOANSUBTYPE_DIGI")));
			}
			if(rs!=null){
				rs.close();
			}
			int countval=0;
			String strrestructuregecl3="";
			rs=DBUtils.executeLAPSQuery("sel_gecl_restassementmand^"+strValue);	
			String strwhetherrest="";
			String stradditionalfunding="";
			String strcatageory="";
			String strFITLaccnt="";
			while(rs.next())
			{
				strwhetherrest=Helper.correctNull(rs.getString("Facility_restr_flag"));
				stradditionalfunding=Helper.correctNull(rs.getString("facility_additional_funding"));
				strcatageory=Helper.correctNull(rs.getString("FACILITY_CATEGORY"));
				strFITLaccnt=Helper.correctNull(rs.getString("Facility_fitl_acc"));
				if(strcatageory.equalsIgnoreCase("F")&& stradditionalfunding.equalsIgnoreCase("Y")&& strFITLaccnt.equalsIgnoreCase("N") && strwhetherrest.equalsIgnoreCase("Y")){
					countval++;
				}
				
			}
			log.info("strgeclrestasseschk======>>>>>>"+countval);
			if(countval>0){
				hshValues.put("strgeclrestasseschk","Y");

			}else{
				hshValues.put("strgecl3restpropstatus","N");

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
			
				strQuery = SQLParser.getSqlQuery("getcreatedate^"+strValue);
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
						hshValues.put("clphchk","Y");	
					}
		       }
		       if(rs!=null){
					rs.close();
				}
		       strQuery = SQLParser.getSqlQuery("checkforblockprocesscharges^"+strValue);
		       rs= DBUtils.executeQuery(strQuery);
				if (rs.next()){
					hshValues.put("checkprocesscharges","Y");
					
				}
				else
				{
					hshValues.put("checkprocesscharges","N");
				}
		} 
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}

		return hshValues; 
	}

	/*public HashMap getDataTerms(HashMap hsh) 
	{
		ResultSet rs = null;
		HashMap hshValues=new HashMap();
		String strQuery="",strValue="",type = "";
		try
		{	
			strValue=correctNull((String)hsh.get("appno"));
			type="existingterms";
			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);

			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("exist",correctNull(rs.getString(1)));	
			}

			type="proposedmod";
			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("pmod",correctNull(rs.getString(1)));	
			}

			type="justification";
			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("justify",correctNull(rs.getString(1)));	
			}
			type="termcomment";
			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("termcomment",correctNull(rs.getString(1)));	
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getDataTerms login  "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}*/

	/*public void updateTerm(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue="";
				
		try
		{
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","comterms1");
			arr.add(strValue);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			
			intUpdatesize=2;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add("existingterms");
			arr.add(Helper.correctNull((String)hsh.get("exist_comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("2",hshquery);

			intUpdatesize=3;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add("proposedmod");
			arr.add(Helper.correctNull((String)hsh.get("prop_comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("3",hshquery);

			intUpdatesize=4;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add("justification");
			arr.add(Helper.correctNull((String)hsh.get("just_comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("4",hshquery);

			intUpdatesize=5;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add("termcomment");
			arr.add(Helper.correctNull((String)hsh.get("term_comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("5",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
	}*/

	public HashMap getDataOper(HashMap hsh) 
	{
		ResultSet rs = null;
		HashMap hshValues= new HashMap();
		String strQuery="",strValue="";
		boolean recordflag=false;
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		
		try
		{	
			strValue=correctNull((String)hsh.get("appno"));
			strQuery = SQLParser.getSqlQuery("comoperationaldata1^"+strValue);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshValues.put("leadbank",correctNull(rs.getString("com_propleadbank")));	
				hshValues.put("mulbank",correctNull(rs.getString("com_propmulbank")));
				hshValues.put("lastreviewdate",correctNull(rs.getString("com_proplastrevdate")));	
				hshValues.put("lastreviewperiod",correctNull(rs.getString("com_proprevperiod")));
				hshValues.put("lastreviewdue",correctNull(rs.getString("com_propdevrevdate")));	
				hshValues.put("WC_SHARE_FE",correctNull(rs.getString("com_propexistfb")));
				hshValues.put("WC_SHARE_FP",correctNull(rs.getString("com_propproposedfb")));
				hshValues.put("WC_SHARE_NFE",correctNull(rs.getString("com_propexistnfb")));
				hshValues.put("WC_SHARE_NFP",correctNull(rs.getString("com_propproposednfb")));
				hshValues.put("TL_SHARE_FE",correctNull(rs.getString("com_tl_existfb")));
				hshValues.put("TL_SHARE_FP",correctNull(rs.getString("com_tl_proposedfb")));
				hshValues.put("TL_SHARE_NFE",correctNull(rs.getString("com_tl_existnfb")));
				hshValues.put("TL_SHARE_NFP",correctNull(rs.getString("com_tl_pproposednfb")));
				hshValues.put("bankingremarks",Helper.CLOBToString(rs.getClob("com_bankingremarks")));
				hshValues.put("asset",correctNull(rs.getString("com_propassettype")));
				hshValues.put("npa",correctNull(rs.getString("com_propnpasince")));
				hshValues.put("preyear_agency",correctNull(rs.getString("com_preyear_agency")));
				hshValues.put("curyear_agency",correctNull(rs.getString("com_curyear_agency")));
				hshValues.put("preyear_short",correctNull(rs.getString("com_preyear_short")));
				hshValues.put("preyear_long",correctNull(rs.getString("com_preyear_long")));
				hshValues.put("curyear_short",correctNull(rs.getString("com_curyear_short")));
				hshValues.put("curyear_long",correctNull(rs.getString("com_curyear_long")));
				recordflag=true;
					
			}
			if(recordflag)
				hshValues.put("recordflag","Y");
			else
				hshValues.put("recordflag","N");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	
	public void updateOper(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ArrayList arrValues=new ArrayList();
		String strValue="";
		String strAction="";
		try
		{
			StringBuilder sbAt = new StringBuilder();
			strAction=correctNull((String)hsh.get("hidAction"));
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;

			if(strAction.equalsIgnoreCase("insert"))
			{
				hshquery=new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				arrValues.add(strValue);
				hshquery.put("arrValues",arrValues);
				hshquery.put("strQueryId","comoperationaldel");
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				intUpdatesize++;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshquery = new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","com_bankingdetails_insert1");
				arr.add(strValue);
				arr.add(Helper.correctNull((String)hsh.get("select_asset")));
				arr.add(Helper.correctNull((String)hsh.get("txt_npa")));
				arr.add(Helper.correctNull((String)hsh.get("mulbank")));
				arr.add(Helper.correctNull((String)hsh.get("leadbank")));
				arr.add(Helper.correctDouble((String)hsh.get("wc_existfb")));
				arr.add(Helper.correctDouble((String)hsh.get("wc_existnfb")));
				arr.add(Helper.correctDouble((String)hsh.get("wc_propfb")));
				arr.add(Helper.correctDouble((String)hsh.get("wc_propnfb")));
				arr.add(Helper.correctNull((String)hsh.get("rev_date")));
				arr.add(Helper.correctNull((String)hsh.get("rev_period")));
				arr.add(Helper.correctNull((String)hsh.get("rev_due")));
				arr.add(Helper.correctNull((String)hsh.get("banking_remarks")));
				arr.add(Helper.correctNull((String)hsh.get("txt_pre_agency")));
				arr.add(Helper.correctNull((String)hsh.get("txt_cur_agency")));
				arr.add(Helper.correctNull((String)hsh.get("txt_pre_shortsymbol")));
				arr.add(Helper.correctNull((String)hsh.get("txt_pre_longsymbol")));
				arr.add(Helper.correctNull((String)hsh.get("txt_cur_shortsymbol")));
				arr.add(Helper.correctNull((String)hsh.get("txt_cur_longsymbol")));
			
				hshquery.put("arrValues",arr);
				hshqueryval.put(Integer.toString(intUpdatesize),hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{		
				hshquery=new HashMap();
				arrValues=new ArrayList();
				hshqueryval=new HashMap();
				arrValues.add(strValue);
				hshquery.put("arrValues",arrValues);
				hshquery.put("strQueryId","comoperationaldel");
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}	
			
			//-------------------------------------AuditTrial-----------------------------------
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(correctNull((String)hsh.get("select_asset")).equalsIgnoreCase("Standard"))
				{
					sbAt.append("~Asset Classification = ").append("Standard");
				}
				else if (correctNull((String)hsh.get("select_asset")).equalsIgnoreCase("SubStandard"))
				{
					sbAt.append("~Asset Classification = ").append("SubStandard");
					
				}
				else if (correctNull((String)hsh.get("select_asset")).equalsIgnoreCase("Doubtful"))
				{
					sbAt.append("~Asset Classification = ").append("Doubtful");
					
				}
				else if (correctNull((String)hsh.get("select_asset")).equalsIgnoreCase("Loss"))	
				{
					sbAt.append("~Asset Classification = ").append("Loss");
					
				}
				else if (correctNull((String)hsh.get("select_asset")).equalsIgnoreCase("N.A."))
				{
					sbAt.append("~Asset Classification = ").append("Not Applicable");
				}
				sbAt.append("~Banking Arrangement Sole/Consortium/Multiple Banking = ");
				
				sbAt.append(SetupParams.getSetupParams("mulbank", correctNull((String)hsh.get("mulbank"))));
				sbAt.append("~NPA Since = ").append(Helper.correctNull((String)hsh.get("txt_npa")));
				//if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("1")){
					//sbAt.append("Sole");
				//}else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("2")){
					sbAt.append("~Lead Bank = ").append(Helper.correctNull((String)hsh.get("leadbank")))
					.append("~Our Share (%) Fund Based (WC + TL) Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existfb"))))
					.append("~Our Share (%) Fund Based (WC + TL) Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propfb"))))
					.append("~Our Share (%) Non Fund Based Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existnfb"))))
					.append("~Our Share (%) Non Fund Based Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propnfb"))));
				//}else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("3")){
				//	sbAt.append("Multiple");
				//}else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("4")){
				//	sbAt.append("Sole/Consortium");
				//}	
					
				//sbAt.append("~Lead Bank = ").append(Helper.correctNull((String)hsh.get("leadbank")));
					/*.append("~Our Share (%) Fund Based (WC + TL) Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existfb"))))
					.append("~Our Share (%) Fund Based (WC + TL) Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propfb"))))
					.append("~Our Share (%) Non Fund Based Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existnfb"))))
					.append("~Our Share (%) Non Fund Based Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propnfb"))));*/
				
				// else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("5")){
				//	sbAt.append("Sole/Multiple");
				//}else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("6")){
				//	sbAt.append("Consortium/Multiple")
				//}	
					
				/*	sbAt.append("~Lead Bank = ").append(Helper.correctNull((String)hsh.get("leadbank")))
					.append("~Our Share (%) Fund Based (WC + TL) Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existfb"))))
					.append("~Our Share (%) Fund Based (WC + TL) Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propfb"))))
					.append("~Our Share (%) Non Fund Based Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existnfb"))))
					.append("~Our Share (%) Non Fund Based Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propnfb"))));
			    // else if(correctNull((String)hsh.get("mulbank")).trim().equalsIgnoreCase("7")){
					sbAt.append("Sole/Consortium/Multiple").append("~Lead Bank = ").append(Helper.correctNull((String)hsh.get("leadbank")))
					.append("~Our Share (%) Fund Based (WC + TL) Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existfb"))))
					.append("~Our Share (%) Fund Based (WC + TL) Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propfb"))))
					.append("~Our Share (%) Non Fund Based Existing =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_existnfb"))))
					.append("~Our Share (%) Non Fund Based Proposed =").append(Helper.formatDoubleValue(Double.parseDouble((String)hsh.get("wc_propnfb"))));*/
				//}
				sbAt.append("~Date of Last Review = ").append(correctNull((String)hsh.get("rev_date"))).append(
				"~Period for which reviewed = ").append(correctNull((String)hsh.get("rev_period"))).append(
				"~Due date of Review = ").append(correctNull((String)hsh.get("rev_due")));
				sbAt.append("~External Credit Rating Agency Name Previous Year =").append(correctNull((String)hsh.get("txt_pre_agency")))
				.append("~External Credit Rating Agency Name Current Year =").append(correctNull((String)hsh.get("txt_cur_agency")))
				.append("~External Credit Rating Short Term Instruments Year =").append(correctNull((String)hsh.get("txt_pre_shortsymbol")))
				.append("~External Credit Rating Short Term Instruments Year =").append(correctNull((String)hsh.get("txt_cur_shortsymbol")))
				.append("~External Credit Rating Long Term Instruments Previous Year =").append(correctNull((String)hsh.get("txt_pre_longsymbol")))
				.append("~External Credit Rating Long Term Instruments Current Year =").append(correctNull((String)hsh.get("txt_cur_longsymbol")));
				
				if(correctNull((String)hsh.get("hidRecordflag")).equals("Y"))
					hsh.put("hidAction", "update");
			}
			AuditTrial.auditLog(hsh,"206",strValue,sbAt.toString());		
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
	}

//	public HashMap getDataConfirm(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			type="confirmcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("confirmcomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			strQuery = SQLParser.getSqlQuery("comconfirmdata^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecRec.add(correctNull(rs.getString(3)));
//				vecRec.add(correctNull(rs.getString(4)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("value1",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshValues; 
//	}

//	public HashMap getDataMarketUtil(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//				
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			strQuery = SQLParser.getSqlQuery("commarketingutill^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecRec.add(correctNull(rs.getString(3)));
//				vecRec.add(correctNull(rs.getString(4)));
//				vecRec.add(correctNull(rs.getString(5)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("insdata",vecVal);
//
//			vecVal= new ArrayList();
//			strQuery = SQLParser.getSqlQuery("commarketingutil2^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecRec.add(correctNull(rs.getString(3)));
//				vecRec.add(correctNull(rs.getString(4)));
//				vecRec.add(correctNull(rs.getString(5)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("utildata",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}		
//		return hshValues; 
//	}

//	public void updateConfirm(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;
//		HashMap hshQuery= new HashMap();
//		ArrayList arrValues  = new ArrayList();		
//		String strValue="";
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//			String []straction = null;
//			String []strdate = null;
//			String []strauth = null;
//			String []strjust = null;
//			
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comconfirmdel1");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comconfirmdel2");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("confirmcomment");
//			arr.add(Helper.correctNull((String)hsh.get("confirm_comment")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);
//			
//			hshquery = new HashMap();
//			straction= (String [])hsh.get("txtaction");
//			strdate = (String [])hsh.get("date1");
//			strauth = (String [])hsh.get("auth");
//			strjust = (String [])hsh.get("just");
//			hshQuery = new HashMap();
//			arrValues=new ArrayList();
//			int num=0;
//			for(int k=4;k<straction.length+4;k++)
//			{				
//				if(!straction[k-4].equals(""))
//				{
//					num=num+1;	
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize=intUpdatesize+1;
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshQuery.put("strQueryId","comconfirminsert");
//					arrValues.add(strValue);
//					arrValues.add(Integer.toString(num));
//					arrValues.add(correctNull(straction[k-4]));
//					arrValues.add(correctNull(strdate[k-4]));
//					arrValues.add(correctNull(strauth[k-4]));
//					arrValues.add(correctNull(strjust[k-4]));
//					hshQuery.put("arrValues",arrValues);
//					hshqueryval.put(Integer.toString(k),hshQuery);	
//				}
//			}
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//			//Start of Audit Trial hari 
//		
//			intUpdatesize=0;
//			hshquery = new HashMap();
//			hshqueryval = new HashMap();
//			arr=new ArrayList();
//			hshQuery=new HashMap();
//			arrValues=new ArrayList();
//			String strActionData="";
//			num=0;
//	
//			//for Entering the values into auditrial
//
//			for(int k=0;k<straction.length;k++)
//			{				
//				if(!straction[k].equals(""))
//				{	
//					num=num+1;	
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize=intUpdatesize+1;
//					hshqueryval.put("size",Integer.toString(intUpdatesize));					
//					strActionData ="S.NO = "+Integer.toString(num)+"~Action ="+correctNull(straction[k])+"~Date ="+correctNull(strdate[k])+"~Authority ="+correctNull(strauth[k])+"~Remarks ="+correctNull(strjust[k]);	
//					hshQuery.put("strQueryId","audittrial");
//					arrValues.add("83");
//					arrValues.add(correctNull((String)hsh.get("strUserId")));
//					arrValues.add(correctNull((String)hsh.get("strClientIP")));
//					arrValues.add(strValue);
//					arrValues.add(strActionData);			
//					arrValues.add("Insert");			
//					hshQuery.put("arrValues",arrValues);
//					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
//				}
//			}
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch (Exception e)
//		{
//			throw new EJBException("Error Occured  "+e.getMessage());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				throw new EJBException("Error Occured  "+e1.getMessage());
//			}
//		}
//	}

//	public HashMap getDataProcess(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//				
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			type="processcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("processcomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			
//			strQuery = SQLParser.getSqlQuery("comproccessdata1^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(3)));
//				vecRec.add(correctNull(rs.getString(4)));
//				vecRec.add(correctNull(rs.getString(5)));
//				vecRec.add(correctNull(rs.getString(6)));
//				vecRec.add(correctNull(rs.getString(7)));
//				vecRec.add(correctNull(rs.getString(8)));
//				vecRec.add(correctNull(rs.getString(9)));
//				vecRec.add(correctNull(rs.getString(10)));
//				vecRec.add(correctNull(rs.getString(11)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("prdmanufacture",vecVal);
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata2^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("prdrawmaterial",vecVal);
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("comproccessdata3^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("prdfinished",vecVal);
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata4^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("prdsuppliers",vecVal);
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("comproccessdata5^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("prdcustomers",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshValues; 
//	}

//	public void updateProcess(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;		
//		String strValue="";
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//						
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comproccessdel");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("processcomment");
//			arr.add(Helper.correctNull((String)hsh.get("process_comment")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//
//			//Start of Audit Trial hari 
//		
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery=new HashMap();
//			arr=new ArrayList();
//	
//			//for Entering the values into auditrial
//
//			String strActionData ="Comments = "+correctNull((String)hsh.get("process_comment"));
//			
//			hshquery.put("strQueryId","audittrial");
//			arr.add("76");
//			arr.add(correctNull((String)hsh.get("strUserId")));
//			arr.add(correctNull((String)hsh.get("strClientIP")));
//			arr.add(strValue);
//			arr.add(strActionData);			
//			arr.add("Insert");			
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch (Exception e)
//		{
//			log.error("error occured"+e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				log.error("error occured"+e1.toString());
//			}
//		}
//	}

//	public HashMap getDataAuditorComment(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//		
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			type="A";
//			strQuery = SQLParser.getSqlQuery("comauditordata^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("auditorcomments",vecVal);
//			vecVal = new ArrayList();
//			type="U";
//			strQuery = SQLParser.getSqlQuery("comauditordata^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("usercomments",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshValues; 
//	}
	
//	public void updateAuditorComment(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;
//		HashMap hshQuery=new HashMap();
//		ArrayList arrValues =new ArrayList();
//		String strValue="";
//		
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//			String []strcomment = null;
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comauditordelete");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//			
//			hshquery = new HashMap();
//			strcomment= (String [])hsh.get("comment_auditor");
//			hshQuery = new HashMap();
//			arrValues=new ArrayList();
//			int num=0,k=0;
//			for( k=0;k<strcomment.length;k++)
//			{				
//				if(!strcomment[k].equals(""))
//				{
//					num=num+1;	
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize=intUpdatesize+1;
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshQuery.put("strQueryId","comauditorinsert");
//					arrValues.add(strValue);
//					arrValues.add(Integer.toString(num));
//					arrValues.add("A");
//					arrValues.add(correctNull(strcomment[k]));
//					hshQuery.put("arrValues",arrValues);
//					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
//				}
//			}
//			strcomment = (String [])hsh.get("comment_user");
//			hshQuery = new HashMap();
//			arrValues=new ArrayList();
//			num=0;
//			for(int m=0;m<strcomment.length;m++)
//			{				
//				if(!strcomment[m].equals(""))
//				{
//					num=num+1;	
//					hshQuery = new HashMap();
//					arrValues=new ArrayList();
//					intUpdatesize=intUpdatesize+1;
//					hshqueryval.put("size",Integer.toString(intUpdatesize));
//					hshQuery.put("strQueryId","comauditorinsert");
//					arrValues.add(strValue);
//					arrValues.add(Integer.toString(num));
//					arrValues.add("U");
//					arrValues.add(correctNull(strcomment[m]));
//					hshQuery.put("arrValues",arrValues);
//					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
//				}
//			}
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch (Exception e)
//		{
//			log.error("error occured"+e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				log.error("error occured"+e1.toString());
//			}
//		}
//	}

//	public HashMap getDataMarketing(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//		
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			type="Distribution setup";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("DistributionSetup",correctNull(rs.getString(1)));	
//			}
//
//			type="Technology used";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("Technology",correctNull(rs.getString(1)));	
//			}
//			type="Marketingcomments";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("Marketingcomments",correctNull(rs.getString(1)));	
//			}
//			
//			type="Technologysophistication";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("Technologysophistication",correctNull(rs.getString(1)));	
//			}
//
//			type="GestationPeriod";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("GestationPeriod",correctNull(rs.getString(1)));	
//			}
//
//			type="DistributionNetwork";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("DistributionNetwork",correctNull(rs.getString(1)));	
//			}
//
//			type="MarketingBrandName";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("MarketingBrandName",correctNull(rs.getString(1)));	
//			}
//
//			type="Marketingstartupcost";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("Marketingstartupcost",correctNull(rs.getString(1)));	
//			}
//			strQuery = SQLParser.getSqlQuery("commarketingdata1^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("competitors",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshValues; 
//	}

//	public void updateMarketing(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;
//		String strValue="";
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//			
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","commarketingdel");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("Technologysophistication");
//			arr.add(Helper.correctNull((String)hsh.get("techsoph")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("GestationPeriod");
//			arr.add(Helper.correctNull((String)hsh.get("gestation")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);
//
//			intUpdatesize=4;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("DistributionNetwork");
//			arr.add(Helper.correctNull((String)hsh.get("distribution")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("4",hshquery);
//
//			intUpdatesize=5;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("MarketingBrandName");
//			arr.add(Helper.correctNull((String)hsh.get("brandname")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("5",hshquery);
//
//			intUpdatesize=6;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("Marketingstartupcost");
//			arr.add(Helper.correctNull((String)hsh.get("startupcost")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("6",hshquery);
//
//			intUpdatesize=7;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("Marketingcomments");
//			arr.add(Helper.correctNull((String)hsh.get("market_comment")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("7",hshquery);
//
//			//Start of Audit Trial hari 
//		
//			intUpdatesize=8;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery=new HashMap();
//			arr=new ArrayList();
//	
//			//for Entering the values into auditrial
//			String strActionData ="Technological sophistication  = "+correctNull((String)hsh.get("techsoph"))+"~Gestation Period   = "+correctNull((String)hsh.get("gestation"))+"~Details of distribution   = "+correctNull((String)hsh.get("distribution"))+"~Brand Name   = "+correctNull((String)hsh.get("brandname"))+"Start-up Cost   = "+correctNull((String)hsh.get("startupcost"));
//			
//			hshquery.put("strQueryId","audittrial");
//			arr.add("77");
//			arr.add(correctNull((String)hsh.get("strUserId")));
//			arr.add(correctNull((String)hsh.get("strClientIP")));
//			arr.add(strValue);
//			arr.add(strActionData);			
//			arr.add("Insert");			
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("8",hshquery);
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch (Exception e)
//		{
//			log.error("error occured"+e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//				
//			}
//			catch (Exception e1)
//			{
//				log.error("error occured"+e1.toString());
//			}
//		}
//	}

//	public HashMap getDataMgmt(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		ArrayList vecRec = new ArrayList();
//		ArrayList vecVal = new ArrayList();
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//					
//			type="Succession plan";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("successplan",correctNull(rs.getString(1)));	
//			}
//			type="Strategic initiatives";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("strategic",correctNull(rs.getString(1)));	
//			}
//			type="Initiative of the Mgmt on QC";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("iso",correctNull(rs.getString(1)));	
//			}
//			type="Reporting Control";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("reptctrl",correctNull(rs.getString(1)));	
//			}
//
//			type="Long Term Supply";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("termsupply",correctNull(rs.getString(1)));	
//			}
//
//			type="Experience";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("experience",correctNull(rs.getString(1)));	
//			}
//
//			type="Mgmt Skills";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("MgmtSkills",correctNull(rs.getString(1)));	
//			}
//
//			type="RBI Defaulters";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("RBIDefaulters",correctNull(rs.getString(1)));	
//			}
//
//			type="ECGC SAL";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("ECGCSAL",correctNull(rs.getString(1)));	
//			}
//
//			type="magmtdivwithcon";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("magmtdivwithcon",correctNull(rs.getString(1)));	
//			}
//
//			type="magmtdivwithoutcon";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("magmtdivwithoutcon",correctNull(rs.getString(1)));	
//			}
//
//			type="magmtnodiv";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("magmtnodiv",correctNull(rs.getString(1)));	
//			}
//			
//			type="magmtcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("magmtcomment",correctNull(rs.getString(1)));	
//			}
//			strQuery = SQLParser.getSqlQuery("commgmtdata1^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecRec.add(correctNull(rs.getString(3)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("expertise",vecVal);
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}				
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}		
//		return hshValues; 
//	}
	
//	public void updateMgmt(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;		
//		String strValue="";
//		
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//			
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","commgmtdel");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//		
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("Mgmt Skills");
//			arr.add(Helper.correctNull((String)hsh.get("mgmtskill")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//		
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("RBI Defaulters");
//			arr.add(Helper.correctNull((String)hsh.get("rbidefaulters")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);
//		
//			intUpdatesize=4;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("ECGC SAL");
//			arr.add(Helper.correctNull((String)hsh.get("ecgcsal")));
//			arr.add("0");
//			arr.add(" ");	
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("4",hshquery);	
//			
//			intUpdatesize=5;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("magmtdivwithcon");
//			arr.add(Helper.correctNull((String)hsh.get("withconsent")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("5",hshquery);
//		
//			intUpdatesize=6;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("magmtdivwithoutcon");
//			arr.add(Helper.correctNull((String)hsh.get("withoutconcern")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("6",hshquery);
//		
//			intUpdatesize=7;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("magmtnodiv");
//			arr.add(Helper.correctNull((String)hsh.get("nodiv")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("7",hshquery);
//		
//			intUpdatesize=8;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("magmtcomment");
//			arr.add(Helper.correctNull((String)hsh.get("mgmt_comment")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("8",hshquery);
//		
//			//Start of Audit Trial hari 
//					
//			intUpdatesize=9;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery=new HashMap();
//			arr=new ArrayList();
//	
//			//for Entering the values into auditrial
//
//			String strActionData = "Management Skills  ="+correctNull((String)hsh.get("mgmtskill"))+"~Whether Director  Partner RBI Defaulters   ="+correctNull((String)hsh.get("rbidefaulters"))+"~Whether any Director  Partner  ECGC SAL ="+correctNull((String)hsh.get("ecgcsal"))+"~With Consent  ="+correctNull((String)hsh.get("withconsent"))+"~Without Consent ="+correctNull((String)hsh.get("withoutconcern"))+"~No Diversion  ="+correctNull((String)hsh.get("nodiv"))+"~Comments ="+correctNull((String)hsh.get("mgmt_comment"));
//			
//			hshquery.put("strQueryId","audittrial");
//			arr.add("78");
//			arr.add(correctNull((String)hsh.get("strUserId")));
//			arr.add(correctNull((String)hsh.get("strClientIP")));
//			arr.add(strValue);
//			arr.add(strActionData);			
//			arr.add("Insert");			
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("9",hshquery);
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}		
//		catch (Exception e)
//		{
//			log.error("error occured"+e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//				
//			}
//			catch (Exception e1)
//			{
//				log.error("error occured"+e1.toString());
//			}
//		}
//	}

	public void updateCompany(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue="",strQuery ="";
		ResultSet rs = null,rs1 = null;
		String  strAction="",strinwardno="",inwardbranchname="",strorglevel="",strMCLRdelete="",strMCLRdeleteWCDPN="";
		StringBuilder sbOldAudit = new StringBuilder();
		StringBuilder sbAuditTrial=new StringBuilder();
		try
		{
			
			strValue=correctNull((String)hsh.get("appno"));
			strAction=correctNull((String)hsh.get("hidAction"));
			strinwardno=correctNull((String)hsh.get("inwardno"));
			strMCLRdelete=correctNull((String)hsh.get("hidDeptChange"));
			strMCLRdeleteWCDPN=correctNull((String)hsh.get("hidSancAuthChange"));
			int intUpdatesize=0;
			strorglevel=correctNull((String)hsh.get("strOrgLevel"));
			/* Audit trial start for old data */
			String strbrnhsolid="",strbranchname="";
			strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				strbrnhsolid=Helper.correctNull(rs.getString("com_npabranch"));
				strQuery = SQLParser.getSqlQuery("checkDuplicateSolid^"+strbrnhsolid);
				rs1 = DBUtils.executeQuery(strQuery);
				if(rs1.next())
				{
					strbranchname=Helper.correctNull(rs1.getString("org_name"));
				}
				sbOldAudit
				.append("~For the meeting =").append(Helper.correctNull((String)rs.getString("com_meeting")))
				.append("~Meeting Date =").append(Helper.correctNull((String)rs.getString("com_meetingdate")))
				.append("~Proposal Submitted To =").append(Helper.correctNull((String)rs.getString("com_submittedto")))
				.append("~Proposal Format =").append(Helper.correctNull((String)rs.getString("com_format")))
				.append("~Branch Party File No. =").append(Helper.correctNull((String)rs.getString("com_partyfileno")))
				.append("~RO / HO Party File No. =").append(Helper.correctNull((String)rs.getString("Com_Roho")))
				
				.append("~Sanctioning Department =").append(Helper.correctNull((String)rs.getString("com_sancdept")))
				.append("~Sanction intimation Mode  =").append(Helper.correctNull((String)rs.getString("com_sanclevel")))
				.append("~Advances as on =").append(Helper.correctNull((String)rs.getString("com_advanceason"))+"-"+Helper.correctNull((String)rs.getString("com_advanceamt")))
				.append("~Deposits as on =").append(Helper.correctNull((String)rs.getString("com_depositason"))+"-"+Helper.correctNull((String)rs.getString("com_depositamt")))
				.append("~NPA at the BHOPAL as on =").append(Helper.correctNull((String)rs.getString("com_npaason"))+"-"+Helper.correctNull((String)rs.getString("com_npaamt")))
				
				.append("~Sector - Priority/Non-Priority =").append(Helper.correctNull((String)rs.getString("com_sector")))
				.append("~Inspection Rating as on =").append(Helper.correctNull((String)rs.getString("com_inspectiondate"))+"-"+Helper.correctNull((String)rs.getString("com_inspectionamount")))
				.append("~Sanctioning Authority =").append(Helper.correctNull((String)rs.getString("com_sancauthority")))
				.append("~Date of the process note =").append(Helper.correctNull((String)rs.getString("com_processnotedate")))
				
				.append("~Permitted Exposure for Individual  =").append(Helper.correctNull((String)rs.getString("Com_Individual")))
				.append("~Basis for Selection of above Sanctioning Authority =").append(Helper.correctNull((String)rs.getString("Com_Comments")))
				.append("~Permitted Exposure for Group  =").append(Helper.correctNull((String)rs.getString("Com_Group")))
				.append("~Processing Charges  =").append(Helper.correctNull((String)rs.getString("com_processingfee")))
				.append("~Whether verfied with Central Fraud Registry ?   =").append(Helper.correctNull((String)rs.getString("COM_CFR_VERIFIED")))  
				.append("~Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ?  =").append(Helper.correctNull((String)rs.getString("COM_CFR_BORNAME")))
				.append("~CFR Deviation Reference number  =").append(Helper.correctNull((String)rs.getString("COM_CFR_DEV_RENFO")))
				.append("~Deviation approval Status   =").append(Helper.correctNull((String)rs.getString("STATUS_VERIFIED")))
				.append("~CFR Deviation Approved By  =").append(Helper.correctNull((String)rs.getString("COM_USERID2")))
				.append("~Approved Date  =").append(Helper.correctNull((String)rs.getString("COM_APPR_DATE")))
				.append("~Sanctioning Branch =").append(correctNull(rs.getString("com_sancbranch")));
				
			}
			
			strQuery = SQLParser.getSqlQuery("comfunsel3^"+strValue);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				inwardbranchname=correctNull(rs.getString("inward_orgscode"));
				
			}
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_corporate_breifbackground");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				hshquery=new HashMap();
				arr=new ArrayList();
				hshquery.put("strQueryId","ins_corporate_breifbackground");
				arr.add(strValue);
				arr.add(Helper.correctNull((String)hsh.get("txt_partyno")));
				if(strorglevel.equalsIgnoreCase("C") || strorglevel.equalsIgnoreCase("R")|| strorglevel.equalsIgnoreCase("D"))
				{
					arr.add(Helper.correctDate((String)hsh.get("txt_branchrecmmd_date")));
					arr.add(Helper.correctDate((String)hsh.get("txt_information_date")));
				}
				else
				{
				arr.add("");
				arr.add("");
				}
				arr.add(Helper.correctNull((String)hsh.get("meeting")));
				arr.add(Helper.correctDate((String)hsh.get("txt_meeting_date")));
				arr.add(Helper.correctNull((String)hsh.get("sel_proposalsubmit")));
				arr.add(Helper.correctNull((String)hsh.get("sel_proposalformat")));
				arr.add(Helper.correctDate((String)hsh.get("txt_advances_date")));
				arr.add(Helper.correctDouble((String)hsh.get("txt_advamount")));
				arr.add(Helper.correctDate((String)hsh.get("txt_deposits_date")));
				arr.add(Helper.correctDouble((String)hsh.get("txt_depositamount")));
				arr.add(Helper.correctDate((String)hsh.get("txt_npadate")));
				arr.add(Helper.correctDouble((String)hsh.get("txt_npaamount")));
				arr.add(Helper.correctNull(inwardbranchname));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancAuth")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancDept")));
				arr.add(Helper.correctNull((String)hsh.get("sel_assetclassification")));
				arr.add(Helper.correctNull((String)hsh.get("sel_SancLevel")));
				arr.add(Helper.correctNull((String)hsh.get("txt_sancrefno")));
				arr.add(Helper.correctNull((String)hsh.get("txt_inspectiondate")));
				arr.add(Helper.correctNull((String)hsh.get("txt_inspectionamount")));
				arr.add(Helper.correctNull((String)hsh.get("txt_sector")));
				arr.add(Helper.correctNull((String)hsh.get("txt_processnotedate")));
				arr.add(Helper.correctNull((String)hsh.get("txt_hopartyno")));
				arr.add(Helper.correctNull((String)hsh.get("txt_individual")));
				arr.add(Helper.correctNull((String)hsh.get("txt_group")));
				arr.add(Helper.correctNull((String)hsh.get("ta_comments")));
				String sel_SancDept = Helper.correctNull((String)hsh.get("sel_SancDept"));
				if(sel_SancDept.equalsIgnoreCase("017")){
				arr.add("CLPSC");
				}else{
					arr.add(Helper.correctNull((String)hsh.get("sel_SancBranch")));
				}
                arr.add(Helper.correctNull((String)hsh.get("sel_amount")));
                arr.add(Helper.correctNull((String)hsh.get("sel_sanctiontype")));
                arr.add(Helper.correctNull((String)hsh.get("txt_griddate")));
                arr.add(Helper.correctNull((String)hsh.get("txt_intrefno")));
                arr.add(Helper.correctNull((String)hsh.get("txt_procfee")));
                arr.add(Helper.correctNull((String)hsh.get("sanctiondate")));
                arr.add(Helper.correctNull((String)hsh.get("CFR_verified")));
                arr.add(Helper.correctNull((String)hsh.get("Namein_CFR")));
                arr.add(Helper.correctNull((String)hsh.get("txt_CFRdev_refno")));

                arr.add(Helper.correctNull((String)hsh.get("status_verified")));
                arr.add(Helper.correctNull((String)hsh.get("hid_userid2")));
                arr.add(Helper.correctNull((String)hsh.get("appref_Appr_date")));
                arr.add(Helper.correctNull((String)hsh.get("CERSAI_verified")));
                arr.add(Helper.correctNull((String)hsh.get("hid_perbranch")));
                arr.add(Helper.correctNull((String)hsh.get("txt_CSLMSNO")));
                hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_corporate_breifbackground");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(Helper.correctNull((String)hsh.get("hidSancAuth")).equalsIgnoreCase("Y"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","delete_delegation");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			
			/* audit trial for new data*/
			sbAuditTrial .append("~Meeting =").append(Helper.correctNull((String)hsh.get("meeting")))
			  	.append("~Meeting Date =").append(Helper.correctNull((String)hsh.get("txt_meeting_date")))
				.append("~Proposal Submitted To =").append(Helper.correctNull((String)hsh.get("sel_proposalsubmit")))
				.append("~Proposal Format =").append(Helper.correctNull((String)hsh.get("sel_proposalformat")))
				.append("~Branch Party File No. =").append(Helper.correctNull((String)hsh.get("txt_partyno")))
				.append("~RO / HO Party File No. =").append(Helper.correctNull((String)hsh.get("txt_hopartyno")))
				
				.append("~Sanctioning Department =").append(Helper.correctNull((String)hsh.get("sel_SancDept")))
				//.append("~Sanction intimation Mode  =").append(Helper.correctNull((String)hsh.get("sel_SancLevel")))
				.append("~Advances as on =").append(Helper.correctNull((String)hsh.get("txt_advances_date"))+"-"+Helper.correctNull((String)hsh.get("txt_advamount")))
				.append("~Deposits as on =").append(Helper.correctNull((String)hsh.get("txt_deposits_date"))+"-"+Helper.correctNull((String)hsh.get("txt_depositamount")))
				.append("~NPA at the BHOPAL as on =").append(Helper.correctNull((String)hsh.get("txt_npadate"))+"-"+Helper.correctNull((String)hsh.get("txt_npaamount")))
				
				.append("~Sector - Priority/Non-Priority =").append(Helper.correctNull((String)hsh.get("txt_sector")))
				.append("~Inspection Rating as on =").append(Helper.correctNull((String)hsh.get("txt_inspectiondate"))+"-"+Helper.correctNull((String)hsh.get("txt_inspectionamount")))
				.append("~Sanctioning Authority =").append(Helper.correctNull((String)hsh.get("sel_SancAuth")))
				.append("~Date of the process note =").append(Helper.correctNull((String)hsh.get("txt_processnotedate")))
				
				.append("~Permitted Exposure for Individual  =").append(Helper.correctNull((String)hsh.get("txt_individual")))
				.append("~Basis for Selection of above Sanctioning Authority =").append(Helper.correctNull((String)hsh.get("ta_comments")))
				.append("~Permitted Exposure for Group  =").append(Helper.correctNull((String)hsh.get("txt_group")))
				.append("~Processing Charges  =").append(Helper.correctNull((String)hsh.get("txt_procfee")))
				.append("~Whether verfied with Central Fraud Registry ?   =").append(Helper.correctNull((String)hsh.get("CFR_verified")))  
				.append("~Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ?  =").append(Helper.correctNull((String)hsh.get("Namein_CFR")))
				.append("~CFR Deviation Reference number  =").append(Helper.correctNull((String)hsh.get("txt_CFRdev_refno")))
				.append("~Deviation approval Status   =").append(Helper.correctNull((String)hsh.get("status_verified")))
				.append("~CFR Deviation Approved By  =").append(Helper.correctNull((String)hsh.get("hid_userid2")))
				.append("~Approved Date  =").append(Helper.correctNull((String)hsh.get("appref_Appr_date")))
				.append("~Sanctioning Branch =").append(Helper.correctNull((String)hsh.get("sel_SancBranch")));
			
			
			
			//Delete the MCLR entries for dept change
			if(strMCLRdelete.equalsIgnoreCase("Y"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_MCLR_deptchange");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_MCLRSPREAD_deptchange");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","upd_interest_deptchange");
				arr.add("0.00");
				arr.add("0.00");
				arr.add("0.00");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}

			//Delete the MCLR entries for Sanc Authority change
			if(strMCLRdeleteWCDPN.equalsIgnoreCase("Y"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_MCLR_deptchange_WCDPN");
				arr.add(strValue);
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_MCLRSPREAD_deptchange_WCDPN");
				arr.add(strValue);
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");

				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","upd_interest_deptchange_WCDPN");
				arr.add("0.00");
				arr.add("0.00");
				arr.add("0.00");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			//if(!(correctNull((String)hsh.get("dev_prop_no")).equalsIgnoreCase("")))
			{
				
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","upd_permprop_no");
				arr.add(correctNull((String) hsh.get("dev_prop_no")));
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
			}
			
			AuditTrial.auditNewLog(hsh, "229", strValue, sbAuditTrial.toString(), sbOldAudit.toString());

		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateCompany "+ exp.toString()); 
			}
		}
	}

//	public void updatePromoter(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();		
//		String strValue="";
//		
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));		
//			int intUpdatesize=0;
//						
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comprom1");
//			arr.add(strValue);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("promoters");
//			arr.add(Helper.correctNull((String)hsh.get("prom_comment")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery=new HashMap();
//			arr=new ArrayList();
//	
//			//for Entering the values into auditrial
//			String strActionData = "Comments ="+correctNull((String)hsh.get("prom_comment"));
//			
//			hshquery.put("strQueryId","audittrial");
//			arr.add("74");
//			arr.add(correctNull((String)hsh.get("strUserId")));
//			arr.add(correctNull((String)hsh.get("strClientIP")));
//			arr.add(strValue);
//			arr.add(strActionData);			
//			arr.add("Insert");			
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);	
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}		
//	}

	public void updateActivity(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue="";
		
		try
		{
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","comactivity1");
			arr.add(strValue);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);

			intUpdatesize=2;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add("activity");
			arr.add(Helper.correctNull((String)hsh.get("activity_comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("2",hshquery);

			//Start of Audit Trial hari 
		
			intUpdatesize=3;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery=new HashMap();
			arr=new ArrayList();
	
			//for Entering the values into auditrial

				String strActionData = "Comments ="+correctNull((String)hsh.get("activity_comment"));
			
			hshquery.put("strQueryId","audittrial");
			arr.add("75");
			arr.add(correctNull((String)hsh.get("strUserId")));
			arr.add(correctNull((String)hsh.get("strClientIP")));
			arr.add(strValue);
			arr.add(strActionData);			
			arr.add("Insert");			
			hshquery.put("arrValues",arr);
			hshqueryval.put("3",hshquery);
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
	}

	/*public void updateFacility(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery=new HashMap();
		ArrayList arrValues=new ArrayList();
		String strValue=""; 
		String strSecno="";
		String strNatCharge="";
		String strModuleType="";
		try
		{
			
			strModuleType=correctNull((String)hsh.get("hidCategoryType"));
			if(strModuleType.equalsIgnoreCase("") || strModuleType.equalsIgnoreCase("null"))
				strModuleType=correctNull((String)hsh.get("cattype"));
			
			StringBuilder sbAt = new StringBuilder();
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;
			String strseldata = Helper.correctNull((String)hsh.get("seltermid"));
			String strFacheadid="";
			String strFacid	  ="";
			if(!strseldata.equals(""))
			{
				StringTokenizer st = new StringTokenizer(strseldata,"^");
				strFacheadid = st.nextToken();
				strFacid = st.nextToken();
			}
			String strCharge=correctNull((String)hsh.get("charge"));
			String strSecureMode=correctNull((String)hsh.get("securemode"));
			String strsecpurpose=correctNull((String)hsh.get("txt_secpurpose"));
			String strsecperiod=correctNull((String)hsh.get("txt_secperiod"));
			String strsecmargin=correctNull((String)hsh.get("txt_secfacmargin"));
			String strsecrepayperiod=correctNull((String)hsh.get("txt_secrepayperiod"));
			String strFacType=correctNull((String)hsh.get("hid_fac_type"));
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("1"))
				strNatCharge="Exclusive First Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("2"))
				strNatCharge="Second Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("3"))
				strNatCharge="First Pari-Pasu Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("4"))
				strNatCharge="Others";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("5"))
				strNatCharge="Second Pari-Pasu Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("6"))
				strNatCharge="Second Charge on Current Assets";
            sbAt.append("~Facility=").append(strFacType).append(
            "~Nature of Charge=").append(strNatCharge);	
			String []secdesc=null;
			String []secdetails =  null;
			String []secvalue =  null;
			String []secdate =  null;
			String []sectype =  null;	
			String []statsecdesc=null;
			secdetails=(String [])hsh.get("txt_secdetails");			
			secvalue=(String [])hsh.get("txt_secvalue");
			secdate=(String [])hsh.get("txt_secdate");
			secdesc=(String [])hsh.get("txt_secdesc");
			sectype=(String [])hsh.get("sel_type");
			statsecdesc=(String [])hsh.get("txt_statsecdesc");
			strQuery = SQLParser.getSqlQuery("propfacseccheck^"+strValue+"^"+strFacheadid+"^"+strFacid+"^"+strCharge);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);				 
			if(rs.next())
			{ 
				strSecno=correctNull(rs.getString("sec_no"));
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=1;
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshQuery.put("strQueryId","propfacsecmasups");
				arrValues.add(strSecureMode);
				arrValues.add(strSecno);
				arrValues.add(strValue);
				arrValues.add(strFacheadid);
				arrValues.add(strFacid);
				arrValues.add(strCharge);
			
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int lens=secdetails.length;
				for(int ks=0;ks<lens;ks++)
				{				
					if(!secdesc[ks].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","propfacsecdetups");
						arrValues.add(correctNull(secdetails[ks]));
						arrValues.add(Helper.correctDouble((String)secvalue[ks]));
						arrValues.add(correctNull(secdate[ks]));
						arrValues.add(Helper.correctNull((String)sectype[ks]));//mck
						arrValues.add(strSecno);
						arrValues.add(correctNull(secdesc[ks]));
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						
						//----------------------AuditTrial-------------------------
						sbAt.append("~Security Description=").append(correctNull(statsecdesc[ks])).append(
						"~Type=").append(Helper.correctNull((String)sectype[ks])).append(
						"~Details=").append(correctNull(secdetails[ks])).append(
						"~Value=").append(Helper.correctDouble((String)secvalue[ks])).append(
						"~as on Date=").append(correctNull(secdate[ks]));		
						//-------------------------End-----------------------------
					}
				}
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else  //insert
			{
				int maxid=0;
				strQuery = SQLParser.getSqlQuery("propfacsecmax");
				if(rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				 
				if(rs.next())
				{
					maxid=rs.getInt(1);
				}
				maxid=maxid+1;
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				intUpdatesize=1;
				hshQuery.put("strQueryId","propfacsecmasins");
				arrValues.add(Integer.toString(maxid));
				arrValues.add(strValue);
				arrValues.add(strFacheadid);
				arrValues.add(strFacid);
				arrValues.add(strCharge);
				arrValues.add(strSecureMode);
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				int len=secdetails.length;
				for(int k=0;k<len;k++)
				{				
					if(!secdesc[k].equals(""))
					{
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","propfacsecdetins");
						arrValues.add(Integer.toString(maxid));
						if (!correctNull(secdesc[k]).equals(""))
						{
							arrValues.add(correctNull(secdesc[k]));
						}
						else
						{
							arrValues.add("");
						}
						if (!correctNull(secdetails[k]).equals(""))
						{
							arrValues.add(correctNull(secdetails[k]));
						}
						else
						{
							arrValues.add("");
						}
						if (!correctNull(secvalue[k]).equals(""))
						{
							arrValues.add(correctNull(secvalue[k]));
						}
						else
						{
							arrValues.add("");
						}
						if (correctNull(secdate[k]).equals(""))
						{
							arrValues.add("01/01/1900");
						}
						else
						{
							arrValues.add(correctNull(secdate[k]));
						}												
						if (!correctNull(sectype[k]).equals(""))
						{
							arrValues.add(correctNull(sectype[k]));
						}
						else
						{
							arrValues.add("");
						}											
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
						
                        //----------------------AuditTrial-------------------------
						sbAt.append("~Security Description=").append(correctNull(statsecdesc[k])).append(
						"~Type=").append(Helper.correctNull((String)sectype[k])).append(
						"~Details=").append(correctNull(secdetails[k])).append(
						"~Value=").append(Helper.correctDouble((String)secvalue[k])).append(
						"~as on Date=").append(correctNull(secdate[k]));		
						//-------------------------End-----------------------------
					}
				}				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			hshQuery = new HashMap();
			hshqueryval =new HashMap();		    
			arrValues=new ArrayList();
			intUpdatesize=1;	
			rs = null;
			strQuery = SQLParser.getSqlQuery("selfacsecpurpose^"+strValue+"^"+strFacheadid+"^"+strFacid);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);				 
			if(rs.next())
			{ 
				hshQuery.put("strQueryId","facsecpurposeupd");
				arrValues.add(strsecpurpose);
				arrValues.add(strsecperiod);
				arrValues.add(strsecmargin);
				arrValues.add(strsecrepayperiod);	
				arrValues.add(strValue);
				arrValues.add(strFacheadid);
				arrValues.add(strFacid);
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				  //----------------------AuditTrial-------------------------
				if(correctNull((String)hsh.get("securemode")).trim().equalsIgnoreCase("S"))
					strSecureMode="Secured";
				else if(correctNull((String)hsh.get("securemode")).trim().equalsIgnoreCase("U"))
					strSecureMode="UnSecured";
				 sbAt.append("~Secure Mode=").append(strSecureMode).append(
				 "~Purpose=").append(strsecpurpose).append(
				 "~Period=").append(strsecperiod).append(
				 "~Facility Margin=").append(strsecmargin).append(
				 "~Repayment Period =").append(strsecrepayperiod);	
				 //-------------------------End-----------------------------
			}
			else
			{
				hshQuery.put("strQueryId","facsecpurposeins");
				arrValues.add(strValue);
				arrValues.add(strFacheadid);
				arrValues.add(strFacid);
				arrValues.add(strsecpurpose);
				arrValues.add(strsecperiod);
				arrValues.add(strsecmargin);
				arrValues.add(strsecrepayperiod);	
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
				
				 //----------------------AuditTrial-------------------------
				if(correctNull((String)hsh.get("securemode")).trim().equalsIgnoreCase("S"))
					strSecureMode="Secured";
				else if(correctNull((String)hsh.get("securemode")).trim().equalsIgnoreCase("U"))
					strSecureMode="UnSecured";
				 sbAt.append("~Secure Mode=").append(strSecureMode).append(
				 "~Purpose=").append(strsecpurpose).append(
				 "~Period=").append(strsecperiod).append(
				 "~Facility Margin=").append(strsecmargin).append(
				 "~Repayment Period =").append(strsecrepayperiod);	
				 //-------------------------End-----------------------------
			}
			
			//-----------------------------------AuditTrial-----------------------------------
			hsh.put("hidAction","update");
			String strCode="";
			if(strModuleType.trim().equalsIgnoreCase("OPS"))
				strCode="187";
			else
				strCode="160";
			AuditTrial.auditLog(hsh,strCode,strValue,sbAt.toString());
			//--------------------------------------End---------------------------------------
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
	}*/
	
	
	/*public void deleteFacility(HashMap hsh) 
	{
		HashMap hshQueryValues =new HashMap();
		HashMap hshValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		String strQuery="";
		HashMap hshQuery = new HashMap();;
		String strValue="";
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strNatCharge="";
		String strModuleType="";
		
		try
		{
			
			strModuleType=correctNull((String)hsh.get("hidCategoryType"));
			if(strModuleType.equalsIgnoreCase("") || strModuleType.equalsIgnoreCase("null"))
				strModuleType=correctNull((String)hsh.get("cattype"));
			StringBuilder sbAt = new StringBuilder();
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;
			String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
			strAction="delete";
			String strseldata = Helper.correctNull((String)hsh.get("seltermid"));
			String strFacheadid="";
			String strFacid	  ="";
			if(!strseldata.equals(""))
			{
				StringTokenizer st = new StringTokenizer(strseldata,"^");
				strFacheadid = st.nextToken();
				strFacid = st.nextToken();
			}
			String strCharge=correctNull((String)hsh.get("charge"));
			strQuery = SQLParser.getSqlQuery("propfacseccheck^"+strValue+"^"+strFacheadid+"^"+strFacid+"^"+strCharge);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);	
			String strSecno="";
			if(rs.next())
			{ 
				 strSecno=correctNull(rs.getString("sec_no"));
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;				
				hshQuery.put("strQueryId","delsecuritymaster");
				arrValues.add(strSecno);
				arrValues.add(strValue);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery = new HashMap();					
				arrValues=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","delsecuritycharges");
				arrValues.add(strSecno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
			}	
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			//-----------------------------AuditTrial----------------------------
			String strFacType=correctNull((String)hsh.get("hid_fac_type"));
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("1"))
				strNatCharge="Exclusive First Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("2"))
				strNatCharge="Second Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("3"))
				strNatCharge="First Pari-Pasu Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("4"))
				strNatCharge="Others";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("5"))
				strNatCharge="Second Pari-Pasu Charge";
			if(correctNull((String)hsh.get("charge")).trim().equalsIgnoreCase("6"))
				strNatCharge="Second Charge on Current Assets";
           	sbAt.append("~Security Deleted for the facility=").append(strFacType).append(
		    "~Nature of Charge=").append(strNatCharge);
           	
        	String strCode="";
			if(strModuleType.trim().equalsIgnoreCase("OPS"))
				strCode="187";
			else
				strCode="160";
			AuditTrial.auditLog(hsh,strCode,strValue,sbAt.toString());
			//---------------------------------End-------------------------------
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
	}*/

	public void updateGeneralComment(HashMap hsh) 
	{
		String type="";
		String strSelType="";
		
		try
		{
			//strValue=correctNull((String)hsh.get("appno"));
			type = correctNull((String)hsh.get("type"));
			strSelType=correctNull((String)hsh.get("sel_type"));
			if(strSelType.equalsIgnoreCase(""))
			{
				strSelType="0";
			}
			if(type.equalsIgnoreCase("1"))
			{
				UpdateAssessmentoflimit(hsh);
			}
			if(type.equalsIgnoreCase("2"))
			{
				UpdateProjectedSales(hsh);
			}
			
			if(type.equalsIgnoreCase("4"))
			{
				UpdateNonFundAssessment(hsh);
			}
			if(type.equalsIgnoreCase("5"))
			{
				UpdateHoldingLevel(hsh);
			}
			if(type.equalsIgnoreCase("6") || type.equalsIgnoreCase("20")|| type.equalsIgnoreCase("37"))
			{
				UpdateAssessment(hsh);
			}
			if(type.trim().equalsIgnoreCase("8"))
			{
				UpdateSREResonsComments(hsh);
			}
			if(type.trim().equalsIgnoreCase("9"))
			{
				updateShortTermComments(hsh);
			}
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
		}
	}

	private void UpdateAssessmentoflimit(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_assessmentoflimit"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessmentoflimit");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_assessmentoflimit");
				
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessmentoflimit");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	private void UpdateAssessment(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_assessment"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strFlowtype = Helper.correctNull((String)hshValues.get("type"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessment");
				arrValues.add(strAppno);
				arrValues.add(strFlowtype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_assessment");
				
				arrValues.add(strAppno);
				arrValues.add(strFlowtype);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_assessment");
				arrValues.add(strAppno);
				arrValues.add(strFlowtype);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	private void UpdateProjectedSales(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_projectedsales"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_projectedsales");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_projectedsales");
				
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_projectedsales");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}

	private void UpdateHoldingLevel(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=null;
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=null;
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_holdinglevel"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String []strHoldlevel= null;
		String strdate=correctNull((String)hshValues.get("txt_date"));
		int introw=3;
		
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQuery = new HashMap();	
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_holdinglevel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_holdinglevel");
				
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				if(hshValues.get("txt_holdlevel")==null)
				{
					strHoldlevel = new String[0];
				}
				else if(hshValues.get("txt_holdlevel") instanceof String)
				{
					strHoldlevel = new String[1];
					strHoldlevel[0]= correctNull((String)hshValues.get("txt_holdlevel"));
				}
				else
				{
					strHoldlevel=(String[])hshValues.get("txt_holdlevel");
				}
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","updfinhoidingvalues");
				arrValues.add(strdate);
				arrValues.add(strAppno);
				arrValues.add("0");
				arrValues.add("1");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				for(int i=0;i<strHoldlevel.length;i++)
				{	
					
					
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","updfinhoidingvalues");
						arrValues.add(strHoldlevel[i]);
						arrValues.add(strAppno);
						arrValues.add("0");
						arrValues.add(""+introw);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						introw++;
				
				}
				
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQuery = new HashMap();	
				arrValues = new ArrayList();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","del_holdinglevel");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				hshQuery = new HashMap();	
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","delfinhoidingvalues");
				arrValues.add(strAppno);
				arrValues.add("0");
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	private void UpdateNonFundAssessment(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_workassess"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_nonfundassessment");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQueryValues.put("size","2");
				hshQuery.put("strQueryId","ins_nonfundassessment");
				
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);	
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","del_nonfundassessment");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateAssessmentoflimit" + e.getMessage());
		} 
	}
	public HashMap getDataComment(HashMap hsh) 
	{
		HashMap hshValues = new HashMap();
		ResultSet rs = null;
		String strValue="",type="",strSelType="";
		
		try
		{
			strValue=correctNull((String)hsh.get("appno"));
			type=correctNull((String)hsh.get("type"));
			if(type.equalsIgnoreCase(""))
			{
				type=correctNull((String)hsh.get("flowtype"));
			}
			strSelType=correctNull((String)hsh.get("sel_type"));
			if(strSelType.equalsIgnoreCase(""))
			{
				strSelType="0";
			}
			
			if(type.equalsIgnoreCase("1"))
			{
				hshValues=getAssessmentofLimit(hsh);
			}
			else if(type.equalsIgnoreCase("2"))
			{
				hshValues=getProjectedLevelofSales(hsh);
			}
			
			else if(type.equalsIgnoreCase("4"))
			{
				hshValues=getAssessmentofNonFundLimit(hsh);
			}
			else if(type.equalsIgnoreCase("5"))
			{
				hshValues=getHoldinglevels(hsh);
				
			}
			else if(type.equalsIgnoreCase("6") || type.equalsIgnoreCase("20")|| type.equalsIgnoreCase("37"))
			{
				hshValues=getAssessment(hsh);
			}
			else if(type.trim().equalsIgnoreCase("8"))
			{
				hshValues = getSREResonsComments(hsh);
			}
			else if(type.trim().equalsIgnoreCase("9"))
			{
				hshValues = getShortTermCommentsComments(hsh);
			}
			else if(type.trim().equalsIgnoreCase("35"))
			{
				hshValues = getBGassessment(hsh);
			}
			else
			{
				hshValues.put("appno",strValue);
				hshValues.put("type",type);
				hshValues.put("seltype",strSelType);
			}
			
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
		return hshValues;
	}
	
//	Added by gokulakrishnan.c
	public void updateAuditorObser(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAppno="";
		String strSelAuditType="";
		String strAction="";
		String strSno="";
		String strInwardno="";
		String strSaral="";
		ResultSet rs=null;
		
		try
		{
			strSelAuditType=correctNull((String)hsh.get("sel_audittype"));
			strAction=correctNull((String)hsh.get("hidAction"));
			strSno=correctNull((String)hsh.get("hidsno"));
			strAppno=correctNull((String)hsh.get("appno"));
			
			strInwardno=correctNull((String)hsh.get("inwardno"));
			strSaral = correctNull((String)hsh.get("hidsaral"));	
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				arrValues = new ArrayList();
				hshquery = new HashMap();
				hshqueryval = new HashMap();
				String strQuery="";
				
				if(strSaral.equals("saral"))
				{
			    strQuery=SQLParser.getSqlQuery("selmaxauditobservationbyinward^"+strInwardno+"^"+strSelAuditType);
				}
				else
				{
			     strQuery=SQLParser.getSqlQuery("selmaxauditobservation^"+strAppno+"^"+strSelAuditType);
				}
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					strSno=correctNull(rs.getString("maxcnt"));
				}
				
				arrValues.add(strAppno);
				arrValues.add(strSelAuditType);
				arrValues.add(correctNull((String)hsh.get("txt_auditorsobservations")));
				arrValues.add(correctNull((String)hsh.get("txt_branchcomments")));
				arrValues.add(correctNull((String)hsh.get("txt_replies")));
				arrValues.add(correctNull((String)hsh.get("auditdate")));
				arrValues.add(strSno);
				arrValues.add(strInwardno);
				
				hshqueryval.put("1",hshquery);
				hshquery.put("arrValues",arrValues);			
				hshquery.put("strQueryId","insauditobservation");
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
				arrValues.add(correctNull((String)hsh.get("txt_replies")));
				arrValues.add(correctNull((String)hsh.get("auditdate")));
				
				arrValues.add(strSno);
				arrValues.add(strSelAuditType);
				if(strSaral.equals("saral"))
				{
					arrValues.add(strInwardno);
					hshquery.put("strQueryId","updauditobservationbyiwardno");
				}
				else
				{
					arrValues.add(strAppno);
					hshquery.put("strQueryId","updauditobservation");
				}
				
				hshqueryval.put("1",hshquery);
				hshquery.put("arrValues",arrValues);			
				
				hshqueryval.put("size","1");			
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			else if(strAction.equalsIgnoreCase("delete"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();	
				arrValues = new ArrayList();
			
				
				if(strSaral.equals("saral"))
				{
				arrValues.add(strInwardno);					
				}
				else
				{
					arrValues.add(strAppno);
				}
				arrValues.add(strSelAuditType);
				arrValues.add(strSno);
				
				hshqueryval.put("size","1");
				if(strSaral.equals("saral"))
				{
					hshquery.put("strQueryId","delauditobservationbyinwardno");				
				}
				else
				{
					hshquery.put("strQueryId","delauditobservation");
				}
										
				hshquery.put("arrValues",arrValues);
				hshqueryval.put("1",hshquery);
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}

		//EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}catch(Exception e)
		{
			throw new EJBException("Exception in updateAuditorObser of ComProposalBean "+e.getMessage());
		}
	}
	
//Added by gokulakrishnan.c
	public HashMap getAuditorComments(HashMap hsh) 
	{
		HashMap hshValues = new HashMap();
		String strSelType = "";
		String strAppno = "";
		String strSaral="";
		String strInwardno="";
		ResultSet rs =null;
		ArrayList arrCol=new ArrayList();
		ArrayList arrRow=new ArrayList();
		
		try
		{
			strAppno = Helper.correctNull((String)hsh.get("appno"));
			strSelType=correctNull((String)hsh.get("sel_audittype"));
			strSaral= correctNull((String)hsh.get("hidsaral"));
			strInwardno= correctNull((String)hsh.get("inwardno"));
			
			String strQuery="";
			
			if(strSaral.equals("saral"))
			{
				strQuery=SQLParser.getSqlQuery("selauditobservationbyinwardno^"+strInwardno+"^"+strSelType);
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("selauditobservation^"+strAppno+"^"+strSelType);
			}
			
			
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("adv_auditorsobservations")));
				arrCol.add(correctNull(rs.getString("adv_branchcomments")));
				arrCol.add(correctNull(rs.getString("adv_replies")));
				arrCol.add(correctNull(rs.getString("adv_auditsno")));
				hshValues.put("auditdate",correctNull(rs.getString("adv_dateaudited")));
				arrRow.add(arrCol);
			}
			hshValues.put("arrRow",arrRow);
			hshValues.put("seltype",strSelType);
									
		}catch(Exception e)
		{
			throw new EJBException("Exception in getAuditorComments of ComProposalBean"+e.getMessage());
		}
		return hshValues;
	}
	
	private HashMap getAssessmentofNonFundLimit(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_nonfundassessment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshResult.put("com_limitassessmnent_comments",correctNull((String)rs.getString("com_limitassessmnent_comments")));
				hshResult.put("com_nonfund_comments",correctNull(Helper.CLOBToString(rs.getClob("com_nonfund_comments"))));
			}
		}
		catch(Exception e)
		{
			log.error("error occured in getAssessmentofNonFundLimit"+e.toString());
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
				log.error("error occured in getAssessmentofNonFundLimit"+e1.toString());
			}
		}
		
		return hshResult;
		
	}
	private HashMap getAssessmentofLimit(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		ArrayList arrRow=new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			
			strQuery=SQLParser.getSqlQuery("selfinassessvalues^"+strAppno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("finassess_rowdesc")));
				arrCol.add(correctNull(rs.getString("finassess_year1")));
				arrCol.add(correctNull(rs.getString("finassess_year2")));
				arrCol.add(correctNull(rs.getString("finassess_year3")));
				arrCol.add(correctNull(rs.getString("finassess_year4")));
				arrCol.add(correctNull(rs.getString("finassess_year5")));
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
			strQuery=SQLParser.getSqlQuery("sel_assessmentoflimit^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshResult.put("com_limitassessmnent_comments",correctNull((String)rs.getString("com_limitassessmnent_comments")));
				hshResult.put("com_limitassessmnent_comments",correctNull(Helper.CLOBToString(rs.getClob("com_limitassessmnent_comments"))));
			}
		}
		catch(Exception e)
		{
			log.error("error occured in getAssessmentofLimit"+e.toString());
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
				log.error("error occured in getAssessmentofLimit"+e1.toString());
			}
		}
		
		return hshResult;
		
	}

	private HashMap getHoldinglevels(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		ArrayList arrRow = new ArrayList();
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("selfinholdingvalues^"+strAppno+"^0");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				ArrayList arrCol=new ArrayList();
				arrCol.add("");//0
				arrCol.add(correctNull(rs.getString("finholding_rowdesc")));//1
				arrCol.add(correctNull(rs.getString("finholding_rowtype")));//2
				arrCol.add(correctNull(rs.getString("finholding_year1")));//3
				arrCol.add(correctNull(rs.getString("finholding_year2")));//4
				arrCol.add(correctNull(rs.getString("finholding_year3")));//5
				arrCol.add(correctNull(rs.getString("finholding_year4")));//6
				arrCol.add(correctNull(rs.getString("finholding_year5")));//7
				arrCol.add(correctNull(rs.getString("finholding_actual")));//8
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
			if(rs != null)
				rs.close();
			strQuery=SQLParser.getSqlQuery("sel_holdinglevel^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("com_holdinglevel_comments",correctNull(Helper.CLOBToString(rs.getClob("com_holdinglevel_comments"))));
			}
		}
		catch(Exception e)
		{
			log.error("error occured in getcom_holdinglevel_comments"+e.toString());
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
				log.error("error occured in getTermLoanAssessment"+e1.toString());
			}
		}
		
		return hshResult;
		
	}
	private HashMap getAssessment(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strFlowType=Helper.correctNull((String)hshValues.get("flowtype"));
		if(strFlowType.equalsIgnoreCase(""))
		{
			strFlowType=Helper.correctNull((String)hshValues.get("hidpagevalTL"));
		}
		if(strFlowType.equalsIgnoreCase(""))
		{
			strFlowType=Helper.correctNull((String)hshValues.get("hidpagevalWC"));
		}
		if(strFlowType.equalsIgnoreCase(""))
		{
			strFlowType=Helper.correctNull((String)hshValues.get("hidpageval"));
		}
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_assessment_tl^"+strAppno+"^"+strFlowType);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshResult.put("com_limitassessmnent_comments",correctNull((String)rs.getString("com_limitassessmnent_comments")));
				hshResult.put("com_assessment_comments",correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))));
			}
			hshResult.put("strFlowType",strFlowType);
			
			if(strFlowType.equalsIgnoreCase("37"))
			{
				if(rs!=null)
					rs.close();
				
				rs=DBUtils.executeLAPSQuery("chkadhocfacility^"+strAppno);
				if(rs.next())
				{
					hshResult.put("strAdhoFacFlag","Y");
				}
			}
		}
		catch(Exception e)
		{
			log.error("error occured in com_assessment_comments"+e.toString());
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
				log.error("error occured in getTermLoanAssessment"+e1.toString());
			}
		}
		
		return hshResult;
		
	}
	
	private HashMap getProjectedLevelofSales(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_projectedsales^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				//hshResult.put("com_limitassessmnent_comments",correctNull((String)rs.getString("com_limitassessmnent_comments")));
				hshResult.put("com_projectedsales_comments",correctNull(Helper.CLOBToString(rs.getClob("com_projectedsales_comments"))));
			}
		}
		catch(Exception e)
		{
			log.error("error occured in getProjectedLevelofSales"+e.toString());
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
				log.error("error occured in getProjectedLevelofSales"+e1.toString());
			}
		}
		
		return hshResult;
		
	}
	/*public void updateBusiness(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		ResultSet rs=null;
		HashMap hshQuery = new HashMap();
		ArrayList arrValues= new ArrayList();
		String val="",strValue="",strQuery ="",para="",type="";
		
		String []strcol1 = null;
		String []strcol2 = null;
		String []strcol3 = null;
		String []strcol4 = null;
		String []strlabel = null;
		String []strdesc = null;
		int currval = 0,id=0,i=0;
		
		try
		{
			val=correctNull((String)hsh.get("type"));
			strValue=correctNull((String)hsh.get("appno"));
			int intUpdatesize=0;
			
			if (val.trim().equals("1"))
			{
				type="LoanBusinessTurnOver";
			}
			else if(val.trim().equals("2"))
			{
				type="BillTurnOver";
			}
			else if(val.trim().equals("3"))
			{
				type="TermLoansDeferred ";
			}
			else if(val.trim().equals("4"))
			{
				type="TermLoanLetterOfCredit";
			}
			else if(val.trim().equals("5"))
			{
				type="TermLoanGurantees";
			}
			intUpdatesize=1;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","comturnoverdel");
			arr.add(strValue);
			arr.add(type);
			hshquery.put("arrValues",arr);
			hshqueryval.put("1",hshquery);
			currval = currval + 1;

			intUpdatesize=2;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","comdel");
			arr.add(strValue);
			arr.add(type);
			arr.add("0");
			hshquery.put("arrValues",arr);
			hshqueryval.put("2",hshquery);
			currval = currval + 1;

			intUpdatesize=3;
			hshqueryval.put("size",Integer.toString(intUpdatesize));
			hshquery = new HashMap();
			arr=new ArrayList();
			hshquery.put("strQueryId","compropform10");
			arr.add(strValue);
			arr.add(type);
			arr.add(Helper.correctNull((String)hsh.get("comment")));
			arr.add("0");
			arr.add(" ");
			arr.add(null);
			hshquery.put("arrValues",arr);
			hshqueryval.put("3",hshquery);
			currval = intUpdatesize;
			currval = currval + 1;
			strcol1= (String [])hsh.get("col1");
			strcol2= (String [])hsh.get("col2");
			strcol3= (String [])hsh.get("col3");
			strcol4= (String [])hsh.get("col4");
			//strcol5= (String [])hsh.get("col5"); 
			strlabel= (String [])hsh.get("label");
			strdesc= (String [])hsh.get("desc");
			strQuery = SQLParser.getSqlQuery("comturnovermax^"+strValue+"^"+type);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				id=rs.getInt(1);
			}
			else
			{
				id = 0;
			}
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			while(i<strlabel.length)
			{
				if (!strlabel[i].trim().equals(""))
				{
					para= strlabel[i];
					for(int k=0;k<strdesc.length;k++)
					{				
						id=id+1;	
						hshQuery = new HashMap();
						arrValues=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshqueryval.put("size",Integer.toString(currval));
						hshQuery.put("strQueryId","comturnoverins");
						arrValues.add(strValue);
						arrValues.add(type);
						arrValues.add(Integer.toString(id));
						arrValues.add(correctNull(strdesc[k]));
						arrValues.add(para);
						if (i==0)
						{
							arrValues.add(correctNull(strcol1[k]));
						}
						else if (i==1)
						{
							arrValues.add(correctNull(strcol2[k]));
						}
						else if (i==2)
						{
							arrValues.add(correctNull(strcol3[k]));
						}
						else if (i==3 )
						{
							arrValues.add(correctNull(strcol4[k]));
						}
						
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put(Integer.toString(currval),hshQuery);	
						currval = currval + 1;
					}
				}
				i = i + 1;
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
 	}*/

	/*public HashMap getDataBusiness(HashMap hsh) 
	{
		HashMap hshValues = new HashMap();
		ResultSet rs = null;
		String val="",strValue="",strQuery ="",type="";
		int i = 0,newid=0;
		String []label = new String[4];
		try
		{
			strValue=correctNull((String)hsh.get("appno"));
			val=correctNull((String)hsh.get("type"));
			if (val.trim().equals("1"))
			{
				type="LoanBusinessTurnOver";
			}
			else if(val.trim().equals("2"))
			{
				type="BillTurnOver";
			}
			else if(val.trim().equals("3"))
			{
				type="TermLoansDeferred ";
			}
			else if(val.trim().equals("4"))
			{
				type="TermLoanLetterOfCredit";
			}
			else if(val.trim().equals("5"))
			{
				type="TermLoanGurantees";
			}
			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{  
				label[newid] = correctNull(rs.getString(1));
				hshValues.put("label"+newid,correctNull(rs.getString(1)));
				newid = newid + 1;
			}
			for (int p=0;p<newid ;p++ )
			{
				i = 0;
				strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
				if(rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{  
					i = i + 1;
					if (p == 0)
					{
						hshValues.put("colval1"+i,correctNull(rs.getString(1)));
					}
					else if (p == 1)
					{
						hshValues.put("colval2"+i,correctNull(rs.getString(1)));
					}
					else if (p == 2)
					{
						hshValues.put("colval3"+i,correctNull(rs.getString(1)));
					}
					else if (p == 3)
					{
						hshValues.put("colval4"+i,correctNull(rs.getString(1)));
					}
				}
			}
			String strseltype="0";
			strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type+"^"+strseltype);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				hshValues.put("comment",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
			}
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
		return hshValues;
	}*/

//	public void updateYield(HashMap hsh) 
//	{
//		HashMap hshqueryval =new HashMap();
//		HashMap hshquery = new HashMap();
//		ArrayList arr = new ArrayList();
//		ResultSet rs=null;
//		String strValue="";
//		
//		try
//		{
//			strValue=correctNull((String)hsh.get("appno"));
//			int intUpdatesize=0;
//			intUpdatesize=1;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comdel");
//			arr.add(strValue);
//			arr.add("LowYieldReason");
//			arr.add("");
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("1",hshquery);
//
//			intUpdatesize=2;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","comdel");
//			arr.add(strValue);
//			arr.add("DepositRelationship");
//			arr.add("");
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("2",hshquery);
//
//			intUpdatesize=3;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("LowYieldReason");
//			arr.add(Helper.correctNull((String)hsh.get("txt_lowyield")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("3",hshquery);
//
//			intUpdatesize=4;
//			hshqueryval.put("size",Integer.toString(intUpdatesize));
//			hshquery = new HashMap();
//			arr=new ArrayList();
//			hshquery.put("strQueryId","compropform10");
//			arr.add(strValue);
//			arr.add("DepositRelationship");
//			arr.add(Helper.correctNull((String)hsh.get("txt_deprel")));
//			arr.add("0");
//			arr.add(" ");
//			arr.add(null);
//			hshquery.put("arrValues",arr);
//			hshqueryval.put("4",hshquery);
//			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
//		}
//		catch (Exception e)
//		{
//			log.error("error occured"+e.toString());
//		}
//		finally
//		{
//			try
//			{
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch (Exception e1)
//			{
//				log.error("error occured"+e1.toString());
//			}
//		}
//	}
	
//	public HashMap getDataYield(HashMap hsh) 
//	{
//		ResultSet rs = null;
//		HashMap hshValues= new HashMap();
//		String strQuery="",strValue="",type = "";
//		
//		try
//		{	
//			strValue=correctNull((String)hsh.get("appno"));
//			type="LowYieldReason";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("txt_lowyield",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			type="DepositRelationship";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				hshValues.put("txt_deprel",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			String strSpacer="";
//			strQuery = SQLParser.getSqlQuery("comoperationaldata1^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				String strY=correctNull(rs.getString(1));
//				if (strY.trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldfrom",strSpacer);
//				}
//				else
//				{
//					hshValues.put("yieldfrom",strY);
//				}
//				String strT=correctNull(rs.getString(2));
//				if (strT.trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldto",strSpacer);
//				}
//				else
//				{
//					hshValues.put("yieldto",strT);
//				}
//				hshValues.put("yieldvalue",correctNull(rs.getString(3)));	
//				hshValues.put("yieldpercent",correctNull(rs.getString(4)));	
//				String strY2=correctNull(rs.getString(14));
//				if (strY2.trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldfrom2",strSpacer);	
//				}
//				else
//				{
//					hshValues.put("yieldfrom2",strY2);	
//				}
//				String strT2=correctNull(rs.getString(15));
//				if (strT2.trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldto2",strSpacer);	
//				}
//				else
//				{
//					hshValues.put("yieldto2",strT2);	
//				}
//				hshValues.put("yieldvalue2",correctNull(rs.getString(16)));	
//				hshValues.put("yieldpercent2",correctNull(rs.getString(17)));	
//			}
//					
//			strQuery = SQLParser.getSqlQuery("selpropyield^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			int i=2;
//			while(rs.next())
//			{
//				i=i+1;
//				if (correctNull(rs.getString(3)).trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldfrom"+i,strSpacer);
//				}
//				else
//			    {
//				  hshValues.put("yieldfrom"+i,correctNull(rs.getString(3)));	
//			    }
//				if (correctNull(rs.getString(4)).trim().equals("01/01/1900"))
//				{
//					hshValues.put("yieldto"+i,strSpacer);	
//				}
//				else
//				{
//					hshValues.put("yieldto"+i,correctNull(rs.getString(4)));	
//				}
//				hshValues.put("yieldvalue"+i,correctNull(rs.getString(5)));	
//				hshValues.put("yieldpercent"+i,correctNull(rs.getString(6)));	
//			}
//		}
//		catch(Exception ce)
//		{
//			throw new EJBException("Error in getData login  "+ce.toString());
//		}
//		finally
//		{
//			try
//			{	
//				if(rs!= null)
//				{
//					rs.close();
//				}
//			}
//			catch(Exception cf)
//			{
//				throw new EJBException("Error closing the connection "+cf.getMessage());
//			}
//		}
//		return hshValues; 
//
//	}

	/*private HashMap getHashIns(String strquery,String strvalue,String val,String txtval) 
	{
		HashMap hshquery = new HashMap();
		ArrayList	arr=new ArrayList();
		hshquery.put("strQueryId",strquery);
		arr.add(strvalue);
		arr.add(val);
		arr.add(txtval);
		hshquery.put("arrValues",arr);
		return hshquery;
	}*/

	/*private HashMap getHashDel(String strquery,String strvalue,String val,String txtval) 
	{
		HashMap hshquery = new HashMap();
		ArrayList	arr=new ArrayList();
		hshquery.put("strQueryId",strquery);
		arr.add(strvalue);
		arr.add(val);
		arr.add(txtval);
		hshquery.put("arrValues",arr);
		return hshquery;
	}*/

	/*private void forproposalcom(String appno,String IRdate,String IRname )
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	
		ArrayList arrValues=new ArrayList();
		String IndustryReportName="IndustryReportName";
		String IndustryReportDated="IndustryReportDated";
		try
		{
			hshQueryValues.put("size","3");	
			hshQuery.put("strQueryId","comproposalcomdel");				
			arrValues.add(appno);
			arrValues.add(IndustryReportName);
			arrValues.add(IndustryReportDated);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);				
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","comproposalcomins");
			arrValues.add(appno);
			arrValues.add(IndustryReportName);				
			arrValues.add(IRname);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","comproposalcomins");
			arrValues.add(appno);
			arrValues.add(IndustryReportDated);
			arrValues.add(IRdate);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
		}
		catch(Exception ce)
		{
			throw new EJBException("forproposalcomments"+ce.toString());
		}
	}*/
	
/*	public HashMap UpdateDemandSupplyData(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();	
		ArrayList arrValues=new ArrayList();
		String strDemandId = "1";
		String strSupplyId = "2";	
		String appno= correctNull((String)hshValues.get("appno"));
		String IRdate= correctNull((String)hshValues.get("IRdate"));
		String IRname= correctNull((String)hshValues.get("IRname"));	
		
		try
		{
			forproposalcom(appno,IRdate,IRname);				
			hshQueryValues.put("size","3");					
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","comdemandsupyrdel");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","comdemandorsupplyins");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			arrValues.add(strDemandId);
			arrValues.add(correctNull((String )hshValues.get("y1date")));
			arrValues.add(correctNull((String )hshValues.get("y1demand")));
			arrValues.add(correctNull((String )hshValues.get("y2date")));
			arrValues.add(correctNull((String )hshValues.get("y2demand")));
			arrValues.add(correctNull((String )hshValues.get("y3date")));
			arrValues.add(correctNull((String )hshValues.get("y3demand")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("2",hshQuery);
			hshQuery = new HashMap();
			arrValues=new ArrayList();
			hshQuery.put("strQueryId","comdemandorsupplyins");
			arrValues.add(correctNull((String )hshValues.get("appno")));
			arrValues.add(strSupplyId);
			arrValues.add(correctNull((String )hshValues.get("y1date")));
			arrValues.add(correctNull((String )hshValues.get("y1supply")));
			arrValues.add(correctNull((String )hshValues.get("y2date")));
			arrValues.add(correctNull((String )hshValues.get("y2supply")));
			arrValues.add(correctNull((String )hshValues.get("y3date")));
			arrValues.add(correctNull((String )hshValues.get("y3supply")));
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("3",hshQuery);				
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}
		HashMap hshRecord = getDemandSupplyData(hshValues);
		return hshRecord;
	}*/

/*	public  HashMap getDemandSupplyData(HashMap hshValues) 
	{
		String strQuery="";
		ResultSet rs = null;
		String strDemandId = "1";
		String strSupplyId = "2";
		HashMap hshRecord = new HashMap();			
		String appno = correctNull((String)hshValues.get("appno"));
		String IndustryReportName="IndustryReportName";
		String IndustryReportDated="IndustryReportDated";
		String y1date="";
		String y2date="";
		String y3date="";		
		try
		{
			strQuery = SQLParser.getSqlQuery("selproposalcom^"+appno+"^"+IndustryReportName);			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{				
				hshRecord.put("IRname",correctNull(rs.getString("com_propcomdesc")));
			}	
			strQuery = SQLParser.getSqlQuery("selproposalcom^"+appno+"^"+IndustryReportDated);			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{			
				hshRecord.put("IRdate",correctNull(rs.getString("com_propcomdesc")));
			}	
			strQuery = SQLParser.getSqlQuery("seldemandorsupply^"+appno+"^"+strDemandId);			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);

			while(rs.next())
			{	
				y1date=correctNull(rs.getString("dem_yr1"));
				if(y1date.equals("01/01/1900"))
				{
					y1date="";								
					hshRecord.put("y1date",y1date);
				}
				else
				{
					hshRecord.put("y1date",correctNull(rs.getString("dem_yr1")));
				}
				y2date=correctNull(rs.getString("dem_yr2"));
				if(y2date.equals("01/01/1900"))
				{
					y2date="";							
					hshRecord.put("y2date",y2date);
				}
				else
				{
					hshRecord.put("y2date",correctNull(rs.getString("dem_yr2")));
				}
				y3date=correctNull(rs.getString("dem_yr3"));
				if(y3date.equals("01/01/1900"))
				{
					y3date="";
					hshRecord.put("y3date",y3date);
				}
				else
				{
					hshRecord.put("y3date",correctNull(rs.getString("dem_yr3")));
				}
				hshRecord.put("y1demand",correctNull(rs.getString("dem_yr1value")));				
				hshRecord.put("y2demand",correctNull(rs.getString("dem_yr2value")));				
				hshRecord.put("y3demand",correctNull(rs.getString("dem_yr3value")));
			}	
			strQuery = SQLParser.getSqlQuery("seldemandorsupply^"+appno+"^"+strSupplyId);			
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("y1supply",correctNull(rs.getString("dem_yr1value")));				
				hshRecord.put("y2supply",correctNull(rs.getString("dem_yr2value")));				
				hshRecord.put("y3supply",correctNull(rs.getString("dem_yr3value")));
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getExpData "+ce.toString());
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
	}*/	
	
/*	public  HashMap getSanctionData(HashMap hshValues) 
	{
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);
		String strQuery="";
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs4 = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecterm = new ArrayList();
		String strAppno="";		
		ArrayList vecVal=new ArrayList();
		double dblLC =0.00;
		double dblExist=0.00,dblProposed=0.00,dblDiff=0.00,dblTotDiff=0.00,dblTotExist=0.00;
		String strBorrowId="";
		try
		{
			strAppno = correctNull((String)hshValues.get("appno"));
			int	intGroup =0;
			strQuery = SQLParser.getSqlQuery("selfacilitylist^" + strAppno +"^"+intGroup);
			if(rs!=null)
				rs.close();
			rs = DBUtils.executeQuery(strQuery);
			dblExist=0.00;
			dblProposed=0.00;
			dblDiff=0.00;
			String strExist="",strProposed="";
			String headid="",facilityid="";
			while(rs.next())
			{	
				intGroup = rs.getInt("facility_sno");
				vecVal = new ArrayList();
				vecterm = new ArrayList();
				vecVal.add(correctNull(rs.getString("facility_group")));
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
				strExist = jtn.format(dblExist);
				strProposed = jtn.format(dblProposed);
				headid = correctNull(rs.getString("facility_headid"));
				facilityid = correctNull(rs.getString("facility_id"));
				strQuery = SQLParser.getSqlQuery("comsanction^"+headid +"^"+facilityid+"^"+strAppno);
				if(rs!=null)
					rs.close();
				rs4 = DBUtils.executeQuery(strQuery);
				while (rs4.next())
				{
					vecterm.add(rs4.getString(1));
				}
				String strDiff = jtn.format(dblDiff);
				String strMargin =correctNull(rs.getString("facility_margin"));
				String strSno =correctNull(rs.getString("facility_sno"));
				vecVal.add(strExist);
				vecVal.add(strProposed);
				vecVal.add(strDiff);
				vecVal.add(strMargin);
				vecVal.add(strSno);
				vecVal.add(correctNull((String)rs.getString("facility_group")));
				vecVal.add(vecterm);	
				vecData.add(vecVal);			
				if(!strProposed.trim().equals(""))
				{
					dblLC =  dblLC + Double.parseDouble(strProposed);
				}
				strQuery = SQLParser.getSqlQuery("selfacilitylist^" + strAppno+"^"+intGroup);
				if(rs1!=null)
					rs1.close();
				rs1 = DBUtils.executeQuery(strQuery);
				while(rs1.next())
				{
					vecVal = new ArrayList();
					vecterm = new ArrayList();
					vecVal.add(correctNull(rs1.getString("facility_group")));
					vecVal.add(correctNull(rs1.getString("facheaddesc")));
					vecVal.add(correctNull(rs1.getString("facility_id")));
					vecVal.add(correctNull(rs1.getString("facdesc")));
					strBorrowId = correctNull(rs1.getString("borrower_id"));
					vecVal.add(strBorrowId);
					vecVal.add(correctNull(rs1.getString("facility_date")));
					dblExist =rs1.getDouble("facility_existing");
					dblProposed =rs1.getDouble("facility_proposed");
					strExist = jtn.format(dblExist);
					dblDiff = dblProposed - dblExist;
					strProposed = jtn.format(dblProposed);
					headid = correctNull(rs1.getString("facility_headid"));
					facilityid = correctNull(rs1.getString("facility_id"));
					strQuery = SQLParser.getSqlQuery("comsanction^"+ headid +"^"+facilityid+"^"+strAppno);
					if(rs4!=null)
						rs4.close();
					rs4 = DBUtils.executeQuery(strQuery);
					while (rs4.next())
					{
						vecterm.add(rs4.getString(1));
					}
					strDiff = jtn.format(dblDiff);
					strMargin =correctNull(rs1.getString("facility_margin"));
					strSno =correctNull(rs1.getString("facility_sno"));
					vecVal.add(strExist);
					vecVal.add(strProposed);
					vecVal.add(strDiff);
					vecVal.add(strMargin);
					vecVal.add(strSno);
					vecVal.add(correctNull((String)rs1.getString("facility_group")));
					vecVal.add(vecterm);	
					vecData.add(vecVal);	
					hshRecord.put("strSno",strSno);
				}
			}
			
			hshRecord.put("vecData",vecData);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
		}
		finally
		{
			try
			{
				if(rs!= null)
				{
					rs.close();
				}
				if(rs2!= null)
				{
					rs2.close();
				}
				if(rs1!= null)
				{
					rs1.close();
				}
				if(rs4!= null)
				{
					rs4.close();
				}
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}*/
	
/*	public  HashMap getSecurityCharges(HashMap hshValues) 
	{
		java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
		jtn.setMaximumFractionDigits(2);
		jtn.setMinimumFractionDigits(2);
		jtn.setGroupingUsed(false);			
		String strQuery="";		
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		ArrayList vecData = new ArrayList();
		ArrayList vecVal = new ArrayList();	
		String strAppno="";
		String securemode="s";
		String charge="sel";
		String strsecpurpose="";
		String strsecperiod="";
		String strsecmargin="";
		String strsecrepayperiod="";
	
		try
		{
			strAppno = correctNull((String)hshValues.get("appno"));
			String getval=correctNull((String)hshValues.get("hidAction"));
			String strseldata = Helper.correctNull((String)hshValues.get("seltermid"));
			String strNature = Helper.correctNull((String)hshValues.get("charge"));
			String strFacheadid="";
			String strFacid	  ="";
			if(!strseldata.equals(""))
			{
				StringTokenizer st = new StringTokenizer(strseldata,"^");
				strFacheadid = st.nextToken();
				strFacid = st.nextToken();
			}
			if (!strFacheadid.trim().equals(""))
			{
				rs = null;
				strQuery = SQLParser.getSqlQuery("selfacsecmargin^"+strAppno+"^"+strFacheadid+"^"+strFacid);
				if(rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);				 
				if(rs.next())
				{ 
					strsecmargin=correctNull(rs.getString(1));
				}
				
				
				rs = null;
				strQuery = SQLParser.getSqlQuery("selfacsecpurpose^"+strAppno+"^"+strFacheadid+"^"+strFacid);
				if(rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);				 
				if(rs.next())
				{ 
					strsecpurpose = correctNull(rs.getString(1));
					strsecperiod=correctNull(rs.getString(2));
					//strsecmargin=correctNull(rs.getString(3));
					strsecrepayperiod=correctNull(rs.getString(4));
				}
			}
			if (strFacheadid.trim().equals(""))
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
			else
			{
				strQuery = SQLParser.getSqlQuery("propfacsecsel^"+strAppno+"^"+strFacheadid+"^"+strFacid+"^"+strNature);
				if(rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					String strVal=correctNull(rs.getString(1));
					securemode=correctNull(rs.getString(5));
					charge=correctNull(rs.getString(6));					
					strQuery = SQLParser.getSqlQuery("propfacmastersel1^"+strVal);
					if(rs != null)
						rs.close();
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						vecVal=new ArrayList();
						vecVal.add(correctNull(rs.getString(1)));
						vecVal.add(correctNull(rs.getString(2)));
						vecVal.add(correctNull(rs.getString(3)));
						vecVal.add(correctNull(rs.getString(4)));
						if (correctNull(rs.getString(5)).equals("01/01/1900"))
						{
							vecVal.add("");
						}
						else
						{
							vecVal.add(correctNull(rs.getString(5)));
						}
						vecVal.add(correctNull(rs.getString(6)));
						vecVal.add(correctNull(rs.getString(7)));
						vecData.add(vecVal);
					}					
					hshRecord.put("vecData",vecData);
				}
				else
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
			}			
			hshRecord.put("selid",strseldata);
			hshRecord.put("securemode",securemode);
			hshRecord.put("strsecpurpose",strsecpurpose);
			hshRecord.put("strsecperiod",strsecperiod);
			hshRecord.put("strsecmargin",strsecmargin);
			hshRecord.put("strsecrepayperiod",strsecrepayperiod);
			hshRecord.put("charge",charge);
			hshRecord.put("hidAction",getval);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getData "+ce.toString());
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshRecord;
	}*/
	
/*HashMap printTermAndCondition(HashMap hshRequestValues)  
{
		
		
		ResultSet rs = null;
		ResultSet rs_sub = null;		
		String strQuery="";
		ResultSet rs1 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		HashMap hshValues = new HashMap();

		ArrayList vecData = new ArrayList();
		ArrayList vecVal=new ArrayList();
		ArrayList vecTerms = new ArrayList();
		ArrayList vecTmp = new ArrayList();
		
		int tmp_sub = 0;
		String margin = "",strlimit="",strsublimit="";
		String strFacheadid="";
		String strFacid="";
		String strFacname="";
		String strsubFacname="";
		String strpurpose="";
		String strcommision ="";
		String strperiod ="";
		String reypayperiod = "";
		String appno ="";
		String tmpSubHead ="";
		String factyp ="";
	 try
	 {
		
		
		appno = correctNull((String)hshRequestValues.get("appno"));
		factyp = correctNull((String)hshRequestValues.get("factyp"));
		
		strQuery = SQLParser.getSqlQuery("selfacilitylistfortc^"+appno+"^"+"0"+"^"+factyp);
		if(rs!=null)
			rs.close();
		rs = DBUtils.executeQuery(strQuery);		
		while (rs.next())
		{  
					tmpSubHead ="";
					margin = "";
					strFacheadid="";
					strFacid="";
					strFacname="";
					strsubFacname="";
					strpurpose="";
					strcommision ="";
					strperiod ="";
					reypayperiod = "";
					strlimit = "";
					vecData = new ArrayList();

					strFacheadid=correctNull(rs.getString(1));
					strFacid=correctNull(rs.getString(3));					
					tmpSubHead = correctNull((String)rs.getString(4));
					strFacname=correctNull((String)rs.getString(2));
					strsubFacname= correctNull((String)rs.getString(4));
					strcommision = correctNull((String)rs.getString(16));
					strlimit = correctNull((String)rs.getString(8));
					vecData.add(strFacname);
					vecData.add(strsubFacname);					
				
					rs1 = null;
					
					strQuery = SQLParser.getSqlQuery("selfacsecpurpose^"+appno+"^"+strFacheadid+"^"+strFacid);
					if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					if(rs1.next())
					{
						strpurpose = correctNull((String)rs1.getString(1));
						strperiod =correctNull((String)rs1.getString(2));
						margin = correctNull((String)rs1.getString(3));
						reypayperiod =correctNull((String)rs1.getString(4));
					}
					vecData.add(strpurpose);
					vecData.add(strperiod);
					vecData.add(margin);
					vecData.add(reypayperiod);

					vecTmp = new ArrayList();
					strQuery = SQLParser.getSqlQuery("termsandcondition^"+appno+"^"+strFacid+"^"+"P");				
					
					if(rs6!=null)
						rs6.close();
					rs6 = DBUtils.executeQuery(strQuery);
					while(rs6.next())
					{
						vecVal=new ArrayList();
						vecVal.add(correctNull(rs6.getString(1)));
						vecTmp.add(vecVal);
					}
					vecData.add(vecTmp);

					vecTmp = new ArrayList();
					strQuery = SQLParser.getSqlQuery("termsandcondition^"+appno+"^"+strFacid+"^"+"A");
					
					if(rs7!=null)
						rs7.close();
					rs7 = DBUtils.executeQuery(strQuery);
					while(rs7.next())
					{
						vecVal=new ArrayList();
						vecVal.add(correctNull(rs7.getString(1)));
						vecTmp.add(vecVal);
					}
					vecData.add(vecTmp);
					vecData.add(strcommision);
					vecData.add(""); //Dummy field to avoid the Head label
					vecData.add(strlimit);
					
					ArrayList	vecsecrow = new ArrayList();	
					ArrayList  vecsecdata = new ArrayList();
					for(int i=1;i<7;i++)
					{										
						strQuery = SQLParser.getSqlQuery("propfacsecsel^"+appno+"^"+strFacheadid+"^"+strFacid+"^"+i);
						if(rs1!=null)
							rs1.close();
						rs1 = DBUtils.executeQuery(strQuery);
						if(rs1.next())
						{	
							if(!(correctNull((String)rs1.getString("sec_no")).trim().equals("")))
							{															
														
								strQuery = SQLParser.getSqlQuery("propfacmastersel^"+correctNull((String)rs1.getString("sec_no")));
								if(rs7!=null)
									rs7.close();
								rs7 = DBUtils.executeQuery(strQuery);
								while(rs7.next())
								{
									vecsecrow = new ArrayList();
									String tmptoken="";

										String strT=correctNull((String)rs7.getString("sec_desc_details"));
										
										StringTokenizer typToken=new StringTokenizer(strT,",");
										
										while(typToken.hasMoreElements())
										{
											String strtypToken=typToken.nextToken();
											tmptoken = tmptoken + " " +strtypToken;
										}
									vecsecrow.add(tmptoken);
									vecsecrow.add(correctNull((String)rs7.getString("sec_type")));
									vecsecrow.add(Integer.toString(i));
									vecsecdata.add(vecsecrow);
								}
							}	
						}
					}
					
					vecData.add(vecsecdata);

					
					vecsecrow = new ArrayList();
					
					strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments^"+strFacheadid+"^"+strFacid+"^"+"i"+"^"+appno);
			 		if(rs1!=null)
						rs1.close();
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						vecsecrow.add(correctNull((String)rs1.getString(1)));
					}
					vecData.add(vecsecrow);
					vecTerms.add(vecData);
					

						//for sublimit
						
						tmp_sub =  rs.getInt("facility_sno");
						
						strQuery = SQLParser.getSqlQuery("selfacilitylist^"+appno+"^"+tmp_sub);
						rs_sub = DBUtils.executeQuery(strQuery);
						
						while (rs_sub.next())
						{  									
							strFacheadid="";
							margin = "";
							strFacid="";
							strFacname="";
							strsubFacname="";
							strpurpose="";
							strcommision ="";
							strperiod ="";
							reypayperiod = "";
							strsublimit = "";
							vecData = new ArrayList();
							tmpSubHead = correctNull((String)rs.getString(4)); //getting the parent limit litle

							strFacheadid=correctNull(rs_sub.getString(1));
							strFacid=correctNull(rs_sub.getString(3));
							strFacname=correctNull((String)rs_sub.getString(2));
							strsubFacname= correctNull((String)rs_sub.getString(4));
							strcommision = correctNull((String)rs_sub.getString(18)); //interest
							strsublimit = correctNull((String)rs_sub.getString(8));
							vecData.add(strFacname);
							vecData.add(strsubFacname);					
						
							rs1 = null;
							
							strQuery = SQLParser.getSqlQuery("selfacsecpurpose^"+appno+"^"+strFacheadid+"^"+strFacid);
							if(rs1!=null)
								rs1.close();
							rs1 = DBUtils.executeQuery(strQuery);
							if(rs1.next())
							{
								strpurpose = correctNull((String)rs1.getString(1));
								strperiod =correctNull((String)rs1.getString(2));
								margin = correctNull((String)rs1.getString(3));
								reypayperiod =correctNull((String)rs1.getString(4));
							}
							vecData.add(strpurpose);
							vecData.add(strperiod);
							vecData.add(margin);
							vecData.add(reypayperiod);

								vecTmp = new ArrayList();
								strQuery = SQLParser.getSqlQuery("termsandcondition^"+appno+"^"+strFacid+"^"+"P");				
								
								if(rs6!=null)
									rs6.close();
								rs6 = DBUtils.executeQuery(strQuery);
								while(rs6.next())
								{
									vecVal=new ArrayList();
									vecVal.add(correctNull(rs6.getString(1)));
									vecTmp.add(vecVal);
								}
								vecData.add(vecTmp);

								vecTmp = new ArrayList();
								strQuery = SQLParser.getSqlQuery("termsandcondition^"+appno+"^"+strFacid+"^"+"A");
								
								if(rs7!=null)
									rs7.close();
								rs7 = DBUtils.executeQuery(strQuery);
								while(rs7.next())
								{
									vecVal=new ArrayList();
									vecVal.add(correctNull(rs7.getString(1)));
									vecTmp.add(vecVal);
								}
								vecData.add(vecTmp);
								vecData.add(strcommision);									
								vecData.add(tmpSubHead); //to  sub limit head label
								vecData.add(strsublimit);
								ArrayList  vecsecsubrow = new ArrayList();
								ArrayList  vecsecsubdata = new ArrayList();
								for(int i=1;i<7;i++)
								{
									rs1 = null;
									
									strQuery = SQLParser.getSqlQuery("propfacsecsel^"+appno+"^"+strFacheadid+"^"+strFacid+"^"+i);
									if(rs1!=null)
										rs1.close();
									rs1 = DBUtils.executeQuery(strQuery);
									if(rs1.next())
									{	
										if(!(correctNull((String)rs1.getString("sec_no")).trim().equals("")))
										{															
											rs7 = null;
											
											strQuery = SQLParser.getSqlQuery("propfacmastersel^"+correctNull((String)rs1.getString("sec_no")));
											if(rs7!=null)
												rs7.close();
											rs7 = DBUtils.executeQuery(strQuery);
											while(rs7.next())
											{
												vecsecsubrow = new ArrayList();
												String tmptoken="";

													String strT=correctNull((String)rs7.getString("sec_desc_details"));
													
													StringTokenizer typToken=new StringTokenizer(strT,",");
													
													while(typToken.hasMoreElements())
													{
														String strtypToken=typToken.nextToken();
														tmptoken = tmptoken + " " +strtypToken;
													}
												vecsecsubrow.add(tmptoken);
												vecsecsubrow.add(correctNull((String)rs7.getString("sec_type")));
												vecsecsubrow.add(Integer.toString(i));
												vecsecsubdata.add(vecsecsubrow);
											}
										}	
									}
								}
								
								vecData.add(vecsecsubdata);
								rs1 = null;
								vecsecsubrow = new ArrayList();
								
								strQuery = SQLParser.getSqlQuery("selcomfacilitydocuments^"+strFacheadid+"^"+strFacid+"^"+"i"+"^"+appno);
								if(rs1!=null)
									rs1.close();
								rs1 = DBUtils.executeQuery(strQuery);
								while(rs1.next())
								{
									vecsecsubrow.add(correctNull((String)rs1.getString(1)));
								}
								vecData.add(vecsecsubrow);
								vecTerms.add(vecData);
						}	
						if(rs_sub != null)
							rs_sub.close();
								
			}
			
			hshValues.put("vecTerms",vecTerms);		

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
					rs.close();
				if(rs1 != null)
					rs1.close();
				if(rs3!= null)
					rs3.close();
				if(rs4 != null)
					rs4.close();
				if(rs5 != null)
					rs5.close();
				if(rs6 != null)
					rs6.close();
				if(rs7 != null)
					rs7.close();
				if(rs_sub != null)
					rs_sub.close();
				
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues;
}*/
/*public void updateTermloan(HashMap hshValues) 
{
	HashMap hshqueryval =new HashMap();
	HashMap hshquery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strValue=correctNull((String)hshValues.get("appno"));
	try
	{
	hshquery = new HashMap();
	arrValues=new ArrayList();
	hshquery.put("strQueryId","com_deltermloan"); 
	arrValues.add(strValue);
	hshquery.put("arrValues",arrValues);
	hshqueryval.put("1",hshquery);
	hshqueryval.put("size","1");	
	EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
	 
	 hshquery = new HashMap();
	 arrValues=new ArrayList();
	 hshqueryval =new HashMap();
	
	 
		arrValues.add(strValue);
		if(correctNull((String)hshValues.get("txt_balance")).equals(""))
		{
			arrValues.add("0.00");	
		}else
		{
		arrValues.add(correctNull((String)hshValues.get("txt_balance")));
		}
		if(correctNull((String)hshValues.get("txt_interest")).equals(""))
		{
			arrValues.add("0.00");		
		}else
		{
		arrValues.add(correctNull((String)hshValues.get("txt_interest")));
		}
		if(correctNull((String)hshValues.get("txt_overinstalment")).equals(""))
		{
			arrValues.add("0.00");	
		}else
		{
		arrValues.add(correctNull((String)hshValues.get("txt_overinstalment")));
		}
		if(correctNull((String)hshValues.get("txt_overinterest")).equals(""))
		{
			arrValues.add("0.00");	
		}else
		{
		arrValues.add(correctNull((String)hshValues.get("txt_overinterest")));
		}
		if(correctNull((String)hshValues.get("txt_reschedule")).equals(""))
		{
			arrValues.add("0.00");		
		}else
		{
		arrValues.add(correctNull((String)hshValues.get("txt_reschedule")));
		}
		
		if(correctNull((String)hshValues.get("txt_comment")).equals(""))
		{
			arrValues.add("0");
		}
		else
		
			arrValues.add(correctNull((String)hshValues.get("txt_comment")));
		hshquery.put("arrValues",arrValues);
		hshquery.put("strQueryId","com_instermloan");
		hshqueryval.put("1",hshquery);
	 	hshqueryval.put("size","1");	
	 
	EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
	}catch(Exception ce)
	{
		throw new EJBException("Error in getData login  "+ce.toString());
	}
}*/ 
/*public  HashMap getTermloan(HashMap hshValues)  
{
	 HashMap hshRecord=new HashMap();
	 String strValue=correctNull((String)hshValues.get("appno"));
	 String strQuery="";
	 ResultSet rs=null;
	 
	 try{
	    strQuery = SQLParser.getSqlQuery("com_seltermloan^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
		 hshRecord.put("COM_APPNO",correctNull((String)rs.getString("COM_APPNO")));
		 hshRecord.put("COM_BALANCE",correctNull((String)rs.getString("COM_BALANCE")));
		 hshRecord.put("COM_INTEREST",correctNull((String)rs.getString("COM_INTEREST")));
		 hshRecord.put("COM_OVERDUEINSTALMENT",correctNull((String)rs.getString("COM_OVERDUEINSTALMENT")));
		 hshRecord.put("COM_OVERDUEINTEREST",correctNull((String)rs.getString("COM_OVERDUEINTEREST")));
		 hshRecord.put("COM_RESCHEDULING",correctNull((String)rs.getString("COM_RESCHEDULING")));
		 hshRecord.put("COM_COMMENTS",correctNull((String)rs.getString("COM_COMMENTS")));
		}
		log.info("Chandraaaaaaaaaaaaaaaa");
	 }catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
	 finally
	 {
		 try
		 {
			 if(rs!=null)
			 {
				 rs.close();
			 }
		 }catch(Exception ce)
			{
				throw new EJBException("Error in getData login  "+ce.toString());
		 	}
	 }
	 
	 return hshRecord;	
}*/ 

/*public void updateTermloandpg(HashMap hshValues) 
{
	HashMap hshqueryval =new HashMap();
	HashMap hshquery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strValue=correctNull((String)hshValues.get("appno"));
	try
	{	
		//for delete
		hshquery = new HashMap();
		arrValues=new ArrayList();
		hshquery.put("strQueryId","com_deltermloandpg");
		arrValues.add(strValue);
		hshquery.put("arrValues",arrValues);
		hshqueryval.put("1",hshquery);
		hshqueryval.put("size","1");	
		EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		
		//for insert		
		hshqueryval =new HashMap();
		hshquery = new HashMap();
		arrValues=new ArrayList();
		hshquery.put("strQueryId","com_instermloandpg");
		arrValues.add(strValue);
		if(correctNull((String)hshValues.get("txt_balance")).equals(""))
		{
			arrValues.add("0.00");	
		}
		else
		{
			arrValues.add(correctNull((String)hshValues.get("txt_balance")));
		}
		if(correctNull((String)hshValues.get("txt_interest")).equals(""))
		{
			arrValues.add("0.00");	
		}
		else
		{
			arrValues.add(correctNull((String)hshValues.get("txt_interest")));
		}
		if(correctNull((String)hshValues.get("txt_overinstalment")).equals(""))
		{
			arrValues.add("0.00");		
		}
		else
		{
			arrValues.add(correctNull((String)hshValues.get("txt_overinstalment")));
		}
		if(correctNull((String)hshValues.get("txt_overinterest")).equals(""))
		{
			arrValues.add("0.00");			
		}
		else
		{
			arrValues.add(correctNull((String)hshValues.get("txt_overinterest")));
		}
		if(correctNull((String)hshValues.get("txt_reschedule")).equals(""))
		{
			arrValues.add("0.00");	
		}
		else
		{
			arrValues.add(correctNull((String)hshValues.get("txt_reschedule")));
		}
		arrValues.add(correctNull((String)hshValues.get("txt_comment")));
		hshquery.put("arrValues",arrValues);		
		hshqueryval.put("1",hshquery);
	 	hshqueryval.put("size","1");	
	 	EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
	
	
	}catch(Exception ce)
	{
		throw new EJBException("Error in getData login  "+ce.toString());
	}
}*/ 
/*public  HashMap getTermloandpg(HashMap hshValues)  
{
	 HashMap hshRecord=new HashMap();
	 String strValue=correctNull((String)hshValues.get("appno"));
	 String strQuery="";
	 ResultSet rs=null;
	 
	 try{
	    strQuery = SQLParser.getSqlQuery("com_seltermloandpg^"+strValue);
	    if(rs!=null)
	    {
	    	rs.close();
	    }
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
		{
		 hshRecord.put("COMAPPNO",correctNull((String)rs.getString("COM_APPNO")));
		 hshRecord.put("COMBALANCE",correctNull((String)rs.getString("COM_BALANCE")));
		 hshRecord.put("COMINTEREST",correctNull((String)rs.getString("COM_INTEREST")));
		 hshRecord.put("COMOVERDUEINSTALMENT",correctNull((String)rs.getString("COM_OVERDUEINSTALMENT")));
		 hshRecord.put("COMOVERDUEINTEREST",correctNull((String)rs.getString("COM_OVERDUEINTEREST")));
		 hshRecord.put("COMRESCHEDULING",correctNull((String)rs.getString("COM_RESCHEDULING")));
		 hshRecord.put("COMCOMMENTS",correctNull((String)rs.getString("COM_COMMENTS")));
		}
		log.info("Chandraaaaaaaaaaaaaaaa");
	 }catch(Exception ce)
		{
			throw new EJBException("Error in getData login  "+ce.toString());
		}
	 finally
	 {
		 try
		 {
			 if(rs!=null)
			 {
				 rs.close();
			 }
		 }catch(Exception ce)
			{
				throw new EJBException("Error in getData login  "+ce.toString());
		 	}
	 }
	 
	 return hshRecord;	
}*/

//Added by Raja for TakeOverNorms
//******MODIFIED BY MOHAN******////

	public void updatetakeoverterm(HashMap hsh) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hsh.get("hidAction"));
		String appno="";
		String[] strSlno=null; 
		String[] strNorms=null; 
		String[] strSelreason=null; 
		String[] strreason=null; 
	
		
		appno=correctNull((String)hsh.get("ano"));
		if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
		{
			 appno=correctNull((String)hsh.get("ano"));
		}
		try
		{
			if(hsh.get("hidslno") instanceof String)
			{
				strSlno=new String[1];
				strSlno[0]=Helper.correctNull((String)hsh.get("hidslno"));
			}
			else
			{
				strSlno=(String[])hsh.get("hidslno");
			}
			
			if(hsh.get("hidnorms") instanceof String)
			{
				strNorms=new String[1];
				strNorms[0]=Helper.correctNull((String)hsh.get("hidnorms"));
			}
			else
			{
				strNorms=(String[])hsh.get("hidnorms");
			}
			
			if(hsh.get("sel_reasons") instanceof String)
			{
				strSelreason=new String[1];
				strSelreason[0]=Helper.correctNull((String)hsh.get("sel_reasons"));
			}
			else
			{
				strSelreason=(String[])hsh.get("sel_reasons");
			}
			
			if(hsh.get("txt_reasons") instanceof String)
			{
				strreason=new String[1];
				strreason[0]=Helper.correctNull((String)hsh.get("txt_reasons"));
			}
			else
			{
				strreason=(String[])hsh.get("txt_reasons");
			}
			
			
			
			if(strAction.trim().equals("edit"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","takeovertermdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for(int i=0;i<strNorms.length;i++)
				{
					if(strNorms[i]!="")
					{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","takeovertermins");
						arrValues.add(appno);
						arrValues.add(strSlno[i]);
						arrValues.add(strNorms[i]);	
						arrValues.add(strSelreason[i]);	
						arrValues.add(strreason[i]);	
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			else if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","takeovertermdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}			
	}

//******MODIFIED BY MOHAN******////
	public HashMap gettakeoverterm(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		String appno="";
		boolean flag=false;
		try
		{
			appno=correctNull((String)hsh.get("ano"));
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("ano"));
			}	
			//String strBorrowerID = correctNull((String)hsh.get("comappid"));
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("takeovertermsel^"+appno);
			rs=DBUtils.executeQuery(strQuery);
			flag=rs.next();	
			
			if(flag==true)
			{
				do
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("term_slno")));
					arrCol.add(Helper.correctNull((String)rs.getString("TERM_NORMS")));
					arrCol.add(Helper.correctNull((String)rs.getString("TERM_STATUS")));
					arrCol.add(Helper.correctNull((String)rs.getString("TERM_REASON")));
					arrRow.add(arrCol);
				}while(rs.next());
			}
			else
			{
				if(rs!=null)
				{
					rs.close();
				}
				/*rs=DBUtils.executeLAPSQuery("gettakeoverworkingstatmaster^"+"41");
				while(rs.next())
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc")));
					arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc1")));
					arrCol.add("S");
					arrCol.add("");
					arrRow.add(arrCol);
				}*/
				String strModuleType=Helper.correctNull((String)hsh.get("sessionModuleType"));
				if(strModuleType.equalsIgnoreCase("CORP"))
				{
					strModuleType="C";
				}
				else if(strModuleType.equalsIgnoreCase("AGR"))
				{
					strModuleType="A";
				}
				
					rs=DBUtils.executeLAPSQuery("sel_TakeOverNorms_Active^"+strModuleType);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("ston_sno")));
						arrCol.add(Helper.correctNull((String)rs.getString("ston_takeovernorm")));
						arrCol.add("S");
						arrCol.add("");
						arrRow.add(arrCol);
					}
					
				}
				
					
					
				
				
			
			hshValues.put("arrRow",arrRow);
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
			catch(Exception ce)
			{
				throw new EJBException("Error in getData login  "+ce.toString());
		 	}
		}
		return hshValues;
	}
	
//******MODIFIED BY MOHAN******////
public void updatetakeoverworking(HashMap hsh) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=correctNull((String)hsh.get("hidAction"));
	String appno="";
	String[] strSlno=null;
	String[] strNorms=null; 
	String[] strSelreason=null; 
	String[] strreason=null; 
	strSlno=(String[])hsh.get("hidslno");
	strNorms=(String[])hsh.get("hidnorms");
	strSelreason=(String[])hsh.get("sel_reasons");
	strreason=(String[])hsh.get("txt_reasons");
	
	 appno=correctNull((String)hsh.get("ano"));
	if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
	{
		 appno=correctNull((String)hsh.get("ano"));
		
	}
	//String strBorrowerID = correctNull((String)hsh.get("comappid"));
	try
	{
		
		
		if(strAction.trim().equals("edit"))
		{
			
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","takeoverworkingdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				for(int i=0;i<strNorms.length;i++)
				{
				if(strNorms[i]!="")
				{
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();	
					arrValues=new ArrayList();
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","takeoverworkingins");
				
					arrValues.add(appno);
					arrValues.add(strSlno[i]);
					arrValues.add(strNorms[i]);	
					arrValues.add(strSelreason[i]);	
					arrValues.add(strreason[i]);	
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				
		}
		else if(strAction.trim().equals("delete"))
		{
			hshQueryValues = new HashMap();
			hshQuery = new HashMap();					
			hshQueryValues.put("size","1");				
			hshQuery.put("strQueryId","takeoverworkingdel");			
			arrValues.add(appno);
			hshQuery.put("arrValues",arrValues);			
			hshQueryValues.put("1",hshQuery);			
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
		}
	}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}			
}



//******MODIFIED BY MOHAN******////
public HashMap gettakeoverworking(HashMap hsh) 
{
	String strQuery="";
	ResultSet rs=null;
	HashMap hshValues = new HashMap();
	ArrayList arrCol=null;
	ArrayList arrRow=new ArrayList();
	String appno="";
	int count=0;
	try
	{
		 appno=correctNull((String)hsh.get("ano"));
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("ano"));
				
			}	
		//String strBorrowerID = correctNull((String)hsh.get("comappid"));
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("takeoverworkingcount^"+appno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			count=rs.getInt("workcount");
		}
		if(rs!=null)
		{
			rs.close();
		}
		strQuery = SQLParser.getSqlQuery("takeoverworkingsel^"+appno);
		rs=DBUtils.executeQuery(strQuery);
			
		
		if(count>0)
		{
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("working_slno")));
				arrCol.add(Helper.correctNull((String)rs.getString("WORKING_NORMS")));
				arrCol.add(Helper.correctNull((String)rs.getString("WORKING_NORMSAVAIL")));
				arrCol.add(Helper.correctNull((String)rs.getString("WORKING_REASONS")));
				arrRow.add(arrCol);
			}
		}
		else
		{
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("gettakeoverworkingstatmaster^"+"42");
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc")));
				arrCol.add(Helper.correctNull((String)rs.getString("stat_data_desc1")));
				arrCol.add("S");
				arrCol.add("");
				arrRow.add(arrCol);
			}
		}
		hshValues.put("arrRow",arrRow);
		
	}		
	catch (Exception e)
	{
		log.error("error occured"+e.toString());
	}
	finally
	 {
		 try
		 {
			 if(rs!=null)
			 {
				 rs.close();
			 }
		 }catch(Exception ce)
			{
				throw new EJBException("Error in getData login  "+ce.toString());
		 	}
	 }
	
	return hshValues;

}

public void updatetakeover(HashMap hsh) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=(String)hsh.get("hidAction");
	//String strGradeId = "";
	String appno="",strSno=Helper.correctNull((String)hsh.get("hidsno"));
	String strIsTakeOver =Helper.correctNull((String) hsh.get("istakeover"));
	StringBuilder sbAuditTrial=new StringBuilder();
	ResultSet rs=null;
	appno=correctNull((String)hsh.get("ano"));
	if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
	{
		 appno=correctNull((String)hsh.get("ano"));		
	}
	String strBorrowerID = correctNull((String)hsh.get("comappid"));
	
	try
	{	if(strIsTakeOver.equalsIgnoreCase("1"))
		{
			if(strAction.equalsIgnoreCase("insert"))
			{	
				rs=DBUtils.executeLAPSQuery("selmaxtakeover^"+appno);
				if(rs.next())
				{
					strSno=Helper.correctNull((String)rs.getString("TERM_COMID"));
				}
				
				hshQueryValues = new HashMap();
				hshQuery=new HashMap();
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","pro_takeoverins");
				arrValues.add(appno);	
				arrValues.add(strSno);
				arrValues.add(Helper.correctNull((String )hsh.get("txt_bankname")));//added by gaensan for Bank Name
				arrValues.add(Helper.correctNull((String )hsh.get("sel_Natureloan")));
				arrValues.add(Helper.correctDouble((String )hsh.get("txt_mainlimit")));
				arrValues.add(Helper.correctDouble((String )hsh.get("txt_Outstanding")));
				arrValues.add(Helper.correctDouble((String )hsh.get("hid_LeadBankcode")));
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_takeover_details");
				arrValues.add(appno);				
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("2", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String )hsh.get("istakeover")));
				arrValues.add(Helper.correctNull((String )hsh.get("hidReasontakover")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "ins_takeover_details");
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			else if(strAction.trim().equals("edit"))
			{			
				hshQuery=new HashMap();
				arrValues=new ArrayList();
						
				arrValues.add(Helper.correctNull((String )hsh.get("txt_bankname")));//added by gaensan for Bank Name
				arrValues.add(Helper.correctNull((String )hsh.get("sel_Natureloan")));
				arrValues.add(Helper.correctDouble((String )hsh.get("txt_mainlimit")));
				arrValues.add(Helper.correctDouble((String )hsh.get("txt_Outstanding")));
				arrValues.add(Helper.correctDouble((String )hsh.get("hid_LeadBankcode")));
				arrValues.add(appno);
				arrValues.add(strSno);
				hshQuery.put("arrValues", arrValues);
				hshQuery.put("strQueryId","com_takeoverallupd");
				hshQueryValues.put("1",hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_takeover_details");
				arrValues.add(appno);				
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("2", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String )hsh.get("istakeover")));
				arrValues.add(Helper.correctNull((String )hsh.get("hidReasontakover")));
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "ins_takeover_details");
				hshQueryValues.put("3", hshQuery);
				hshQueryValues.put("size","3");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");	
			}
			else if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","pro_istakeoverdel");			
				arrValues.add(appno);
				arrValues.add(strSno);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("1",hshQuery);
				
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_takeover_details");
				arrValues.add(appno);				
				hshQuery.put("arrValues", arrValues);	
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");	
				

				arrValues = new ArrayList();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","3");				
				hshQuery.put("strQueryId","takeovertermdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("3",hshQuery);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
			}		
		}
	  	else if(strIsTakeOver.equalsIgnoreCase("2"))
		{
	  		if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);				
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_takeover_details");
				hshQueryValues.put("1", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_com_takeover");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				hshQueryValues.put("size","2");
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","3");				
				hshQuery.put("strQueryId","takeovertermdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("3",hshQuery);	
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
	  		if(strAction.trim().equals("insert")||strAction.trim().equals("edit"))
	  		{
	  			hshQueryValues = new HashMap();
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				arrValues.add(appno);				
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "del_takeover_details");
				hshQueryValues.put("1", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "del_com_takeover");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshQueryValues.put("2", hshQuery);
				
				arrValues = new ArrayList();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","3");				
				hshQuery.put("strQueryId","takeovertermdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("3",hshQuery);	
				
				arrValues = new ArrayList(); 
				hshQuery = new HashMap();
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String )hsh.get("istakeover")));
				arrValues.add("");
				hshQuery.put("arrValues", arrValues);				
				hshQuery.put("strQueryId", "ins_takeover_details");
				hshQueryValues.put("4", hshQuery);
				hshQueryValues.put("size","4");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
	  		}
		}
		
		sbAuditTrial.append("Is Take Over = ").append(SetupParams.getSetupParams("Education",Helper.correctNull((String)hsh.get("istakeover"))));
		if(strAction.equalsIgnoreCase("edit"))
		{
			hsh.put("hidAction","Update");
		}
		if(Helper.correctNull((String)hsh.get("hidCategoryType")).equalsIgnoreCase("OPS"))
		{
			AuditTrial.auditLog(hsh,"186",appno,sbAuditTrial.toString());
		}
		else
		{	
		AuditTrial.auditLog(hsh,"158",appno,sbAuditTrial.toString());
		}
		
	}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}			
}

public HashMap gettakeover(HashMap hsh){
	
	String strQuery="";
	ResultSet rs=null,rs1=null;
	HashMap hshValues = new HashMap();
	ArrayList vecData = new ArrayList();
	ArrayList vecVal=new ArrayList();
	String istakeover="",nature="",reason="",reasondesc="";
	try
	{
		String strappno= correctNull((String)hsh.get("ano"));
		if(strappno.equalsIgnoreCase(""))
		{
			strappno= correctNull((String)hsh.get("appno"));
		}
		strQuery = SQLParser.getSqlQuery("pro_takeoversel^"+strappno);
		rs=DBUtils.executeQuery(strQuery);
			
		while(rs.next())
		{
			vecVal=new ArrayList();
			vecVal.add(Helper.correctNull(rs.getString("TERM_COMID")));//0		
			vecVal.add(Helper.correctNull(rs.getString("term_appno")));//1	
			vecVal.add(Helper.correctNull(rs.getString("comtak_bankname")));//2
			nature=Helper.correctNull(rs.getString("comtak_NatureLoan"));
			if(!nature.equalsIgnoreCase(""))
			{			
			 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"144"+"^"+nature);
			 if(rs1.next())
			 {
				 vecVal.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//3
			 }
			 else
			 {
				 vecVal.add("");
			 }
			}
			else
			{
				 vecVal.add("");
			}	
			vecVal.add(Helper.correctNull(rs.getString("comtak_mainlimit")));//4
			vecVal.add(Helper.correctNull(rs.getString("comtak_Outstanding")));//5
			vecVal.add(nature);//6
			vecVal.add(Helper.correctNull(rs.getString("comtak_bankid")));//7
			vecData.add(vecVal);
		}
		hshValues.put("vecData",vecData);
		
		strQuery = SQLParser.getSqlQuery("sel_takeover_details^"+strappno);
		rs=DBUtils.executeQuery(strQuery);
			
		while(rs.next())
		{
			istakeover=Helper.correctNull(rs.getString("comtak_istakeover"));//0
			reason=Helper.correctNull(rs.getString("comtak_reason"));
			if(!reason.equalsIgnoreCase(""))
			{			
			 rs1=DBUtils.executeLAPSQuery("getstaticdescription^"+"145"+"^"+reason);
			 if(rs1.next())
			 {
				 reasondesc=Helper.correctNull(rs1.getString("STAT_DATA_DESC1"));//1
			 }
			 else
			 {
				 reasondesc="";//1
			 }
			}
			else
			{
				reasondesc="";//1
			}					
		}		
		hshValues.put("istakeover",istakeover);
		hshValues.put("reason",reason);
		hshValues.put("reasondesc",reasondesc);
	}		
	catch (Exception e)
	{
		log.error("error occured"+e.toString());
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

	return hshValues;
	
}

public void updateCashBudget(HashMap hsh)
{
 	//String strQuery="";
	ResultSet rs=null;
	//HashMap hshValues = new HashMap();
	HashMap hshQuery=new HashMap();
	HashMap hshQueryValues1=new HashMap();
	HashMap hshQueryValues = new HashMap();
	ArrayList arrValues = new ArrayList();
	//String[] strdesc=null;
	String[] stropenbal=null;
	String[] strmainprd=null;
	String[] strsubprd=null;
	String[] strnonoper=null;
	String[] strothers1=null;
	String[] strtothers2=null;
	String[] strtotinflow=null;
	
	String[] strpurchase=null;
	String[] strfreight=null;
	String[] strtravel=null;
	String[] strsal=null;
	String[] strmisc=null;
	String[] strint=null;
	String[] strothers=null;
	String[] strtotoutflow=null;
	
	String[] strnetflow=null;
	String[] strclosflow=null;
	String[] strYear=null;
	String appno=Helper.correctNull((String)hsh.get("appno"));
	String strAction=Helper.correctNull((String)hsh.get("hidAction"));
	int j=0;
	String[] strDesc={"Openbal","Main-prd","Sub-Prd","Non-oper","others1","others2","totinflow","Purchase","Freight",
			"Travelling","Salary","MiscExpenses","Interest","Others","totoutflow","netflow","Closbal","Year"};
	try
	{
		stropenbal = (String[]) hsh.get("txt_openbal");
		strmainprd= (String[]) hsh.get("txt_mainprd");
		strsubprd= (String[]) hsh.get("txt_subprd");
		strnonoper= (String[]) hsh.get("txt_nonoperinc");
		strothers1=(String[]) hsh.get("txt_others1");
		strtothers2=(String[]) hsh.get("txt_others2");
		strtotinflow=(String[]) hsh.get("txt_totcashinflow");
		
		strpurchase=(String[]) hsh.get("txt_purchase");
		strfreight=(String[]) hsh.get("txt_freight");
		strtravel=(String[]) hsh.get("txt_travel");
		strsal=(String[]) hsh.get("txt_sal");
		strmisc=(String[]) hsh.get("txt_miscexpenses");
		strint=(String[]) hsh.get("txt_interest");
		strothers=(String[]) hsh.get("txt_others");
		strtotoutflow=(String[]) hsh.get("txt_totoutflow");
		
		strnetflow=(String[]) hsh.get("txt_netflow");
		strclosflow=(String[]) hsh.get("txt_closbal");
		strYear=(String[]) hsh.get("txt_year");
		
		if(strAction.equalsIgnoreCase("insert"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_cashbudget");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
			
			//To insert first row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[0]);			
			for (int i = 0; i < 12; i++)
			{
				if(stropenbal[i].equalsIgnoreCase(""))
				{
					stropenbal[i] = "0.00";
				}
			arrValues.add(stropenbal[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			//hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			//To insert second row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[1]);			
			
			for (int i = 0; i < 12; i++)
			{
				if(strmainprd[i].equalsIgnoreCase(""))
				{
					strmainprd[i] = "0.00";
				}
				arrValues.add(strmainprd[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			//hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			//To insert third row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[2]);
			for (int i = 0; i < 12; i++)
			{	
				if(strsubprd[i].equalsIgnoreCase(""))
				{
					strsubprd[i] = "0.00";
				}
				arrValues.add(strsubprd[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			//To insert fourth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[3]);
			for (int i = 0; i < 12; i++)
			{	
				if(strnonoper[i].equalsIgnoreCase(""))
				{
					strnonoper[i] = "0.00";
				}
				arrValues.add(strnonoper[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			//To insert fifth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[4]);
			for (int i = 0; i < 12; i++)
			{
				
				if(strothers1[i].equalsIgnoreCase(""))
				{
					strothers1[i] = "0.00";
				}
				arrValues.add(strothers1[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			//To insert sixth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[5]);
			for (int i = 0; i < 12; i++)
			{
				if(strtothers2[i].equalsIgnoreCase(""))
				{
					strtothers2[i] = "0.00";
				}
				arrValues.add(strtothers2[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");

			//To insert seventh row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[6]);
			for (int i = 0; i < 12; i++)
			{
				if(strtotinflow[i].equalsIgnoreCase(""))
				{
					strtotinflow[i] = "0.00";
				}
				arrValues.add(strtotinflow[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
			//To insert eigth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[7]);
			for (int i = 0; i < 12; i++)
			{
				if(strpurchase[i].equalsIgnoreCase(""))
				{
					strpurchase[i] = "0.00";
				}
				arrValues.add(strpurchase[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			//To insert nineth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[8]);
			for (int i = 0; i < 12; i++)
			{
				if(strfreight[i].equalsIgnoreCase(""))
				{
					strfreight[i] = "0.00";
				}
				arrValues.add(strfreight[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert tenth row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[9]);
			for (int i = 0; i < 12; i++)
			{
				if(strtravel[i].equalsIgnoreCase(""))
				{
					strtravel[i] = "0.00";
				}
				arrValues.add(strtravel[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			//To insert 11th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[10]);
			for (int i = 0; i < 12; i++)
			{
				if(strsal[i].equalsIgnoreCase(""))
				{
					strsal[i] = "0.00";
				}
				arrValues.add(strsal[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert 12th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[11]);
			for (int i = 0; i < 12; i++)
			{
				if(strmisc[i].equalsIgnoreCase(""))
				{
					strmisc[i] = "0.00";
				}
				arrValues.add(strmisc[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert 13th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[12]);
			for (int i = 0; i < 12; i++)
			{
				if(strint[i].equalsIgnoreCase(""))
				{
					strint[i] = "0.00";
				}
				arrValues.add(strint[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert 14th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[13]);
			for (int i = 0; i < 12; i++)
			{
				if(strothers[i].equalsIgnoreCase(""))
				{
					strothers[i] = "0.00";
				}
				arrValues.add(strothers[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert 15th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[14]);
			for (int i = 0; i < 12; i++)
			{
				if(strtotoutflow[i].equalsIgnoreCase(""))
				{
					strtotoutflow[i] = "0.00";
				}
				arrValues.add(strtotoutflow[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
				
//				To insert 16th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[15]);
			for (int i = 0; i < 12; i++)
			{
				if(strnetflow[i].equalsIgnoreCase(""))
				{
					strnetflow[i] = "0.00";
				}
				arrValues.add(strnetflow[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			//	To insert 17th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[16]);
			for (int i = 0; i < 12; i++)
			{
				if(strclosflow[i].equalsIgnoreCase(""))
				{
					strclosflow[i] = "0.00";
				}
				arrValues.add(strclosflow[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			//hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
			
			
//			To insert 18th row
			hshQuery = new HashMap();
			arrValues = new ArrayList();
			hshQueryValues.put("size", "1");
			hshQuery.put("strQueryId", "ins_cashbudget");
			arrValues.add(appno);
			arrValues.add(Integer.toString(++j));
			arrValues.add(strDesc[17]);
			for (int i = 0; i < 12; i++)
			{
				if(strYear[i].equalsIgnoreCase(""))
				{
					strYear[i] = "0.00";
				}
				arrValues.add(strYear[i]);
			}
			hshQuery.put("arrValues", arrValues);	
			hshQueryValues.put("1", hshQuery);
			//hshQueryValues.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		}
		if(strAction.equalsIgnoreCase("delete"))
		{
			HashMap hshQuery3 = new HashMap();
			ArrayList arrValues3 = new ArrayList();
			hshQuery3.put("size", "1");
			hshQuery3.put("strQueryId", "del_cashbudget");
			arrValues3.add(appno);
			hshQuery3.put("arrValues", arrValues3);
			hshQueryValues1.put("1", hshQuery3);
			hshQueryValues1.put("size", "1");
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues1,"updateData");
		}
	}
	catch(Exception ae)
	{
		throw new EJBException("Error in inserting cashBudget"+ae.toString());
	}finally
	{
		try
		{
			if(rs!=null)
				rs.close();
		}catch(Exception exp)
		{
			throw new EJBException("Error in closing the connection in updateCashBudget "+ exp.toString()); 
		}
	}
}
public HashMap getCashBudget(HashMap hsh)
{
	ResultSet rs = null;
	//ResultSet rs1 = null;
	String strQuery = "";
	HashMap hshRecord = new HashMap();
	/*HashMap hshRecord1 = new HashMap();
	HashMap hshRecordtmp = new HashMap();
	ArrayList arrCshBudgetdesc=new ArrayList();
	ArrayList arrCshBudgetApr=new ArrayList();
	ArrayList arrCshBudgetMay=new ArrayList();
	ArrayList arrCshBudgetJun=new ArrayList();
	ArrayList arrCshBudgetJul=new ArrayList();
	
	ArrayList arrCshBudgetAug=new ArrayList();
	ArrayList arrCshBudgetSep=new ArrayList();
	ArrayList arrCshBudgetOct=new ArrayList();
	ArrayList arrCshBudgetNov=new ArrayList();
	ArrayList arrCshBudgetDec=new ArrayList();
	ArrayList arrCshBudgetJan=new ArrayList();
	ArrayList arrCshBudgetFeb=new ArrayList();
	ArrayList arrCshBudgetMar=new ArrayList();*/
	
	ArrayList vecRow = new ArrayList();
	//ArrayList vecData = new ArrayList();
	ArrayList vecCol=null;
	//boolean bstate =true;
	String appno	= correctNull((String )hsh.get("appno"));	
	try
	{
		strQuery = SQLParser.getSqlQuery("sel_cashbudget^" + appno);
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
			{
				vecCol=new ArrayList();
				//vecCol.add(correctNull((String)rs.getString("comcbm_appno")));
				//vecCol.add(correctNull((String)rs.getString("comcbm_desc")));
				vecCol.add(correctNull((String)rs.getString("comcbm_apr")));
				vecCol.add(correctNull((String)rs.getString("comcbm_may")));
				vecCol.add(correctNull((String)rs.getString("comcbm_jun")));
				vecCol.add(correctNull((String)rs.getString("comcbm_jul")));
				vecCol.add(correctNull((String)rs.getString("comcbm_aug")));
				vecCol.add(correctNull((String)rs.getString("comcbm_sep")));
				vecCol.add(correctNull((String)rs.getString("comcbm_oct")));
				vecCol.add(correctNull((String)rs.getString("comcbm_nov")));
				vecCol.add(correctNull((String)rs.getString("comcbm_dec")));
				vecCol.add(correctNull((String)rs.getString("comcbm_jan")));
				vecCol.add(correctNull((String)rs.getString("comcbm_feb")));
				vecCol.add(correctNull((String)rs.getString("comcbm_mar")));
				vecRow.add(vecCol);
			}
				
				
				hshRecord.put("vecData", vecRow);
	}
	catch(Exception ae)
	{
		throw new EJBException("Error in inserting cashBudget"+ae.toString());
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
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
		return hshRecord;
	}

public void updatempbf(HashMap hsh) 
{
	HashMap hshQueryValues = new HashMap();
	HashMap hshQuery = null;
	ArrayList arrValues=new ArrayList();
	String strAction=(String)hsh.get("hidAction");
	//String strGradeId = "";
	String appno="";
	 
	
	 appno=correctNull((String)hsh.get("appno"));
	if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
	{
		 appno=correctNull((String)hsh.get("comm_appno"));
		
	}
	
	try
	{
		if(strAction.trim().equals("insert"))
		{
	
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","com_mpbfdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");				
				
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				arrValues=new ArrayList();
				hshQueryValues.put("size","1");
				hshQuery.put("strQueryId","com_mpbfins");
				
				arrValues.add(appno);
				arrValues.add(Helper.correctNull((String )hsh.get("txt_cshdeficit")));		
				arrValues.add(Helper.correctNull((String )hsh.get("txt_cshdeficitof")));	
				arrValues.add(Helper.correctNull((String )hsh.get("selstockmonth")));
				arrValues.add(Helper.correctNull((String )hsh.get("selmonthfrom")));
				arrValues.add(Helper.correctNull((String )hsh.get("selmonthto")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_mpbfyear")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_tottonnes")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_tonnesvalue")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_pertonn")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_sundry")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_marginper")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_marginvalue")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_drawpower")));
				arrValues.add(Helper.correctNull((String )hsh.get("txt_workcap")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
		}
			if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","com_mpbfdel");			
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");		
					
			}
			UpdateAssessmentoflimit(hsh);
	}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}			
}
public HashMap getmpbf(HashMap hsh){
	
	String strQuery="";
	ResultSet rs=null;
	HashMap hshValues = new HashMap();
	ArrayList vecRow = new ArrayList();
	//ArrayList vecData = new ArrayList();
	ArrayList vecCol=null;
	try
	{
		String strappno= correctNull((String)hsh.get("appno"));
		if(rs!=null)rs.close();
		strQuery = SQLParser.getSqlQuery("com_mpbfsel^"+strappno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
			{
				hshValues.put("com_mbpfcshdeficit",Helper.correctNull(rs.getString("com_mbpfcshdeficit")));	
				hshValues.put("com_mbpfcshdeficitof",Helper.correctNull(rs.getString("com_mbpfcshdeficitof")));	
				hshValues.put("com_mbpfstockmonth",Helper.correctNull(rs.getString("com_mbpfstockmonth")));
				
				hshValues.put("com_mbpfseasonfrom",Helper.correctNull(rs.getString("com_mbpfseasonfrom")));
				hshValues.put("com_mbpfseasonto",Helper.correctNull(rs.getString("com_mbpfseasonto")));
				hshValues.put("com_mbpfseasonyear",Helper.correctNull(rs.getString("com_mbpfseasonyear")));
				hshValues.put("com_mbpftotaltonnes",Helper.correctNull(rs.getString("com_mbpftotaltonnes")));
				hshValues.put("com_mbpftonnesrupees",Helper.correctNull(rs.getString("com_mbpftonnesrupees")));
				hshValues.put("com_mbpfpertonn",Helper.correctNull(rs.getString("com_mbpfpertonn")));
				hshValues.put("com_mbpfsundry",Helper.correctNull(rs.getString("com_mbpfsundry")));
				hshValues.put("com_mbpfmarginper",Helper.correctNull(rs.getString("com_mbpfmarginper")));
				hshValues.put("com_mbpfmarginvalue",Helper.correctNull(rs.getString("com_mbpfmarginvalue")));
				hshValues.put("com_mbpfdp",Helper.correctNull(rs.getString("com_mbpfdp")));
				hshValues.put("com_mbpfwc",Helper.correctNull(rs.getString("com_mbpfwc")));
				
			
			}
		if(rs!=null)rs.close();
		strQuery = SQLParser.getSqlQuery("sel_cashbudgetbydesc^" + strappno +"^Closbal");
		rs = DBUtils.executeQuery(strQuery);
		while(rs.next())
			{
				vecCol=new ArrayList();
				//vecCol.add(Helper.correctNull((String)rs.getString("comcbm_appno")));
				//vecCol.add(Helper.correctNull((String)rs.getString("comcbm_desc")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_apr")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_may")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_jun")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_jul")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_aug")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_sep")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_oct")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_nov")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_dec")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_jan")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_feb")));
				vecCol.add(Helper.correctNull((String)rs.getString("comcbm_mar")));
				
				
			}
				vecRow.add(vecCol);	
				hshValues.put("vecData", vecRow);
				hshValues.putAll(getAssessmentofLimit(hsh));
		
		
		
	}		
	catch (Exception e)
	{
		log.error("error occured"+e.toString());
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
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	return hshValues;
	
}
public HashMap getRiskAnalysis(HashMap hshValues)
{
	HashMap hshRecord=new HashMap();
	String strQuery="";
	ResultSet rs=null;
	try
	{
		String strappno=correctNull((String)hshValues.get("appno"));
		strQuery=SQLParser.getSqlQuery("finselect8^"+strappno);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("cma_index",correctNull(rs.getString("cma_no")));
		}
	}
	catch(Exception ae)
	{
		log.error("Error Occured:"+ae.toString());
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
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	return hshRecord;
}


public void updateAssessmentType(HashMap hshValues) 
{
	HashMap hshqueryval =new HashMap();
	HashMap hshquery = new HashMap();
	ArrayList arrValues = new ArrayList();
	String strappno=correctNull((String)hshValues.get("appno"));
	String strcomid=correctNull((String)hshValues.get("comid"));
	if(strcomid.equalsIgnoreCase(""))
	{
		strcomid=correctNull((String)hshValues.get("hidapplicantid"));
	}
	try
	{
			hshquery = new HashMap();
			arrValues=new ArrayList();
			hshquery.put("strQueryId","del_assessmenttype"); 
			arrValues.add(strappno);
			hshquery.put("arrValues",arrValues);
			hshqueryval.put("1",hshquery);
			hshqueryval.put("size","1");	
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			 
			 hshquery = new HashMap();
			 arrValues=new ArrayList();
			 hshqueryval =new HashMap();
			 
			arrValues.add(strappno);
			arrValues.add("0");
			arrValues.add(correctNull((String)hshValues.get("sel_assessment")));
			hshquery.put("arrValues",arrValues);
			hshquery.put("strQueryId","ins_assessmenttype");
			hshqueryval.put("1",hshquery);
		 	hshqueryval.put("size","1");	
	 
		 	EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
	}
	catch(Exception ce)
	{
		throw new EJBException("Error in getupdateAssessmentType  "+ce.toString());
	}
} 
public  HashMap getAssessmentType(HashMap hshValues)  
{
	 HashMap hshRecord=new HashMap();
	 String strValue=correctNull((String)hshValues.get("appno"));
	 String strQuery="";
	 ResultSet rs=null;
	 
	 try
	 {
	    strQuery = SQLParser.getSqlQuery("sel_assessmenttype^"+strValue);
		rs = DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("assmenttypeappno",correctNull((String)rs.getString("com_assmenttypeappno")));
			hshRecord.put("assmenttypecomdivid",correctNull((String)rs.getString("com_assmenttypecomdivid")));
			hshRecord.put("assessmenttype",correctNull((String)rs.getString("com_assessmenttype")));
		}
		
		strQuery=SQLParser.getSqlQuery("selfinassessvalues^"+strValue+"^0");
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("finassessavailable","Y");
		}
		strQuery=SQLParser.getSqlQuery("sel_assessmentoflimit^"+strValue);
		rs=DBUtils.executeQuery(strQuery);
		if(rs.next())
		{
			hshRecord.put("commentsavailable","Y");
		}
	 }
	 catch(Exception ce)
		{
			throw new EJBException("Error in getAssessmentType  "+ce.toString());
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
		 catch(Exception ce)
			{
				throw new EJBException("Error in getAssessmentType  "+ce.toString());
		 	}
	 }
	 
	 return hshRecord;	
} 

	private HashMap getSREResonsComments(HashMap hshValues)
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_srecomment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("comsre_comments",correctNull(Helper.CLOBToString(rs.getClob("comsre_comments"))));
			}
		}
		catch(Exception e)
		{
			log.error("error occured in getSREResonsComments"+e.toString());
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
				log.error("error occured in getSREResonsComments"+e1.toString());
			}
		}
		
		return hshResult;
		
	}
	
	private void UpdateSREResonsComments(HashMap hshValues)throws Exception
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		
		int intUpdatesize=0;
		
		String strComments=Helper.correctNull((String)hshValues.get("txt_srecomments"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		try
		{
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				intUpdatesize++;
				hshQuery.put("strQueryId","del_srecomment");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
			
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				intUpdatesize++;
				hshQuery.put("strQueryId","ins_srecomment");
				arrValues.add(strAppno);
				arrValues.add(strComments);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);	
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();	
				intUpdatesize++;
				hshQuery.put("strQueryId","del_srecomment");
				arrValues.add(strAppno);
				
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put(""+intUpdatesize,hshQuery);
				
				hshQueryValues.put("size",""+intUpdatesize);
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in UpdateSREResonsComments" + e.getMessage());
		} 
	}
	
	private void updateShortTermComments(HashMap hsh) 
	{
 		HashMap hshqueryval = new HashMap();
		HashMap hshQuery ;
		ArrayList arr = new ArrayList();
		ResultSet rs=null;
		String val="";
		String appno="";
		String strdesc=null;
		String[] strpagedesc=null;
		try
		{
			val=(String)hsh.get("hidAction");
			appno=(String)hsh.get("appno");

			
			strdesc= (String)hsh.get("hidpagedesc");
			strdesc=strdesc.replace("'","");
		    strpagedesc=strdesc.split(",");
		
			int intUpdatesize=0;
			
			if (val.equals("update"))
			{
				hshqueryval = new HashMap();
				for(int k=0;k<2;k++)
				{
					hshQuery = new HashMap();
					hshQuery = new HashMap();
					arr=new ArrayList();
					intUpdatesize=intUpdatesize+1;
					hshQuery.put("strQueryId","del_stlcomments");
					
					arr.add(appno);
					arr.add(strpagedesc[k]);
					
					hshQuery.put("arrValues",arr);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				}
				
				for(int k=0;k<2;k++)
				{				
						hshQuery = new HashMap();
						arr=new ArrayList();
						intUpdatesize=intUpdatesize+1;
						hshQuery.put("strQueryId","ins_stlcomments");
						
						arr.add(appno);
						arr.add(strpagedesc[k]);
						arr.add((String)hsh.get("txt_comments["+k+"]"));
						
						hshQuery.put("arrValues",arr);						
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);	
				}	
			}
			else if(val.equals("delete"))
			{
				hshqueryval = new HashMap();
				for(int k=0;k<2;k++)
				{
				hshQuery = new HashMap();
				arr=new ArrayList();
				intUpdatesize=intUpdatesize+1;
				hshQuery.put("strQueryId","del_stlcomments");
				arr.add(appno);
				arr.add(strpagedesc[k]);
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size",Integer.toString(intUpdatesize));
				hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
						
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
	}
	
	private HashMap getShortTermCommentsComments(HashMap hsh) 
	{
		ResultSet rs=null;		
		HashMap hshValues = new HashMap();
		String appno="";
		String desc="";
		String strQuery="";
		try
		{
			appno=(String)hsh.get("appno");
			desc=correctNull((String)hsh.get("hidpage"));
			if(desc.equalsIgnoreCase(""))
			{
				desc=correctNull((String)hsh.get("hidpagedesc"));
			}
			desc=desc.replaceAll("~","','");
			
				strQuery = SQLParser.getSqlQuery("sel_stlcomments^"+appno+"^'"+desc+"'");
				
				rs = DBUtils.executeQuery(strQuery);	
				
				while(rs.next())
				{
					if(correctNull((String)rs.getString("comstl_type")).equalsIgnoreCase("norms"))
					{
					hshValues.put("comstl_norms",Helper.CLOBToString(rs.getClob("comstl_comments")));
					}
					else if(correctNull((String)rs.getString("comstl_type")).equalsIgnoreCase("bplr"))
					{
						hshValues.put("comstl_bplr",Helper.CLOBToString(rs.getClob("comstl_comments")));
					}
				}
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
		return hshValues;		
	}
	
	
	
	
	public HashMap getBreakUpofNoncurrent(HashMap hsh)
	 {
		HashMap hashRecord=new HashMap();
		HashMap hashResult=new HashMap();
		
		String strAppno=null;
		String strQuery="";
		ResultSet rs=null;
		
		ArrayList arrValues=null;
		ArrayList arrcolms=null;
		
	    
		try
		{
			strAppno=Helper.correctNull((String)hsh.get("appno"));
			strQuery=SQLParser.getSqlQuery("sel_breakupofnoncurrentasset^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			arrValues=new ArrayList();
			
			while(rs.next())
			{
				arrcolms=new ArrayList();
				
				arrcolms.add(Integer.toString(rs.getInt("break_slno")));  //0
				arrcolms.add(Helper.correctNull((String)rs.getString("break_field1"))); //1
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year2")));   //2
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year3")));  //3
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year4")));   //4
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year5")));  //5
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year6")));   //6
				arrcolms.add(Helper.correctNull((String)rs.getString("break_year7")));   //7
				arrValues.add(arrcolms);
			}
					
				hashRecord.put("arrValues",arrValues);
				
				hashResult=(HashMap)getHoldinglevels(hsh);
				
				hashRecord.put("hshresult", hashResult);
				
				
			
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
	 
		
		
		return hashRecord;
	 }
	public void updateBreakUpofNoncurrent(HashMap hsh)
	{
	 HashMap hshQuery=null;
	 ArrayList arr=null;
	 HashMap hshqueryval=null;
	 
	 ResultSet rs=null;
	 String strAppno="";
	 String strAction="";
	 String strQuery="";
	 String strslno="";
	 try
	 {
		 strAction=Helper.correctNull((String)hsh.get("hidAction"));
		 strAppno=Helper.correctNull((String)hsh.get("appno"));
		 if(strAction.equals("insert"))
		 {
			  
			 hshqueryval=new HashMap();
			   
			 strQuery=SQLParser.getSqlQuery("sel_maxslnoofbreakupofnoncurrent^"+strAppno);
			 rs=DBUtils.executeQuery(strQuery);
			 
			 if(rs.next())
		     strslno=Helper.correctNull((String)rs.getString("slno"));
			     if(rs!=null)
				 rs.close();
			 
				hshQuery = new HashMap();
				arr=new ArrayList();
				
				
				hshQuery.put("strQueryId","com_insbreakupofnoncurrent");
				
				arr.add(strAppno);
				arr.add(strslno);
				arr.add(correctNull((String)hsh.get("textfield1")));
				arr.add(correctNull((String)hsh.get("textfield2")));
				arr.add(correctNull((String)hsh.get("textfield3")));
				arr.add(correctNull((String)hsh.get("textfield4")));
				arr.add(correctNull((String)hsh.get("textfield5")));
				arr.add(correctNull((String)hsh.get("textfield6")));
				arr.add(correctNull((String)hsh.get("textfield7")));
			
				
				hshQuery.put("arrValues",arr);
				hshqueryval.put("size","1");
				hshqueryval.put("1",hshQuery);
			 
			 
		 }
		 else if(strAction.equals("update"))
		 {
			 strslno=Helper.correctNull((String)hsh.get("hidslno"));
			 
			    hshqueryval=new HashMap(); 
			   
			    hshQuery = new HashMap();
				arr=new ArrayList();
				
				hshQuery.put("strQueryId","com_del_breakupofnoncurrentbyno");
				arr.add(strAppno);
				arr.add(strslno);
				
				hshQuery.put("arrValues",arr);				
				hshqueryval.put("1",hshQuery);
				hshqueryval.put("size","1");				
				
                
                hshQuery = new HashMap();
				arr=new ArrayList();
				
				hshQuery.put("strQueryId","com_insbreakupofnoncurrent");
				arr.add(strAppno);
				arr.add(strslno);
				arr.add(correctNull((String)hsh.get("textfield1")));
				arr.add(correctNull((String)hsh.get("textfield2")));
				arr.add(correctNull((String)hsh.get("textfield3")));
				arr.add(correctNull((String)hsh.get("textfield4")));
				arr.add(correctNull((String)hsh.get("textfield5")));
				arr.add(correctNull((String)hsh.get("textfield6")));
				arr.add(correctNull((String)hsh.get("textfield7")));
			
				hshQuery.put("arrValues",arr);				
				hshqueryval.put("2",hshQuery);
				hshqueryval.put("size","2");			 
		 }
		 else if(strAction.equals("delete"))
		 {
			 strslno=Helper.correctNull((String)hsh.get("hidslno"));
			 
			    hshqueryval=new HashMap(); 
			   
			    hshQuery = new HashMap();
				arr=new ArrayList();
				
				hshQuery.put("strQueryId","com_del_breakupofnoncurrentbyno");
				arr.add(strAppno);
				arr.add(strslno);
				
				hshQuery.put("arrValues",arr);				
				hshqueryval.put("1",hshQuery);
				hshqueryval.put("size","1");
		 }
		 
		 EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
		 
	 }
	 catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
	
	
	
	public HashMap getbreifbackground(HashMap hsh){
		
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		try
		{
			String strappno= correctNull((String)hsh.get("ano"));
			if(strappno.equalsIgnoreCase(""))
			{
				strappno= correctNull((String)hsh.get("appno"));
			}
			//com_appno,com_partyfileno,com_branchrcvddate,com_branchcompletedate,
			//com_meeting,com_meetingdate,com_submittedto,com_format,com_advanceason,com_advanceamt,
			//com_depositason,com_depositamt,
	        //com_npaason,com_npaamt,com_npabranch,com_sancauthority,com_sancdept,com_asset
			strQuery = SQLParser.getSqlQuery("sel_corporate_breifbackground"+strappno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{  
				hshValues.put("com_appno",correctNull(rs.getString("com_appno")));
				hshValues.put("com_partyfileno",correctNull(rs.getString("com_partyfileno")));
				hshValues.put("com_branchrcvddate",correctNull(rs.getString("com_branchrcvddate")));
				hshValues.put("com_branchcompletedate",correctNull(rs.getString("com_branchcompletedate")));
				hshValues.put("com_meeting",correctNull(rs.getString("com_meeting")));
				hshValues.put("com_meetingdate",correctNull(rs.getString("com_meetingdate")));
				hshValues.put("com_submittedto",correctNull(rs.getString("com_submittedto")));					
				hshValues.put("com_format",correctNull(rs.getString("com_format")));
				hshValues.put("com_advanceason",correctNull(rs.getString("com_advanceason")));
				hshValues.put("com_advanceamt",correctNull(rs.getString("com_advanceamt")));
				hshValues.put("com_depositason",correctNull(rs.getString("com_depositason")));
				hshValues.put("com_depositamt",correctNull(rs.getString("com_depositamt")));
				hshValues.put("com_npaason",correctNull(rs.getString("com_npaason")));
				hshValues.put("com_npaamt",correctNull(rs.getString("com_npaamt")));
				hshValues.put("com_npabranch",correctNull(rs.getString("com_npabranch")));
				hshValues.put("com_sancauthority",correctNull(rs.getString("com_sancauthority")));
				hshValues.put("com_sancdept",correctNull(rs.getString("com_sancdept")));
				hshValues.put("com_asset",correctNull(rs.getString("com_asset")));
				hshValues.put("com_sanclevel",correctNull(rs.getString("com_sanclevel")));
				hshValues.put("com_sancbranch",correctNull(rs.getString("com_sancbranch")));
				
				
			
		}	
		}
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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

		return hshValues;
		
	}
	
	public void updateourBankcreditDetails(HashMap hshValues) 
	{
		ResultSet rs=null;
		HashMap hshRecord= new HashMap();
		HashMap hshQuery= new HashMap();
		HashMap hshQueryValues= new HashMap();
		ArrayList arrValues = new ArrayList();
		String StrAction = Helper.correctNull((String)hshValues.get("hidAction"));
		String strappno = Helper.correctNull((String)hshValues.get("strAppno"));
		String strsno = Helper.correctNull((String)hshValues.get("hidsno"));
		String strgensno = Helper.correctNull((String)hshValues.get("hidgen_sno"));
		String strourother = Helper.correctNull((String)hshValues.get("hidourother"));
		int maxsno=0;
		
		try
		{
			rs = DBUtils.executeLAPSQuery("sel_maxsno_consortmultiple^"+strappno);
			if(rs.next()){
				maxsno = rs.getInt("com_sno");
			}
			if(StrAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues= new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","ins_otherbankcredits");
				arrValues.add(strappno);
				arrValues.add(""+maxsno);
				arrValues.add(Helper.correctNull((String)hshValues.get("hidmembnamecode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Exishare")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existnonfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposalfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposalnonfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstanding")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstandingason")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidbanking")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcredit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidourother")));
				arrValues.add(Helper.correctNull((String)hshValues.get("facilityname")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Propshare")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			
			if(StrAction.equalsIgnoreCase("update"))
			{
				hshQueryValues= new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_otherbankcredits");
				arrValues.add(strsno);
				arrValues.add(Helper.correctNull((String)hshValues.get("hidmembnamecode")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_Exishare")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share1")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share2")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_existnonfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share3")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposalfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_share4")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposalnonfund")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_limit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstanding")));
				arrValues.add(Helper.correctNull((String)hshValues.get("txt_outstandingason")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidbanking")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidcredit")));
				arrValues.add(Helper.correctNull((String)hshValues.get("hidourother")));
				arrValues.add(Helper.correctNull((String)hshValues.get("facilityname")));
				arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Propshare")));
				arrValues.add(strappno);
				arrValues.add(strgensno);
				arrValues.add(Helper.correctNull((String)hshValues.get("hidourother")));
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			
			if(StrAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues= new HashMap();
				hshQueryValues.put("size", "1");
				hshQuery= new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_otherbankcredits");
				arrValues.add(strappno);
				arrValues.add(strsno);
				arrValues.add(strourother);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
			}
			EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updatedata");
			
			if(rs!=null)
			{
				rs.close();
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("Exception in updateourBankcreditDetails==> "+ce.toString());
		}
	}
	
	public HashMap getourBankcreditDetails (HashMap hshValues) 
	{
		HashMap hshRecord = new HashMap();
		String strQuery = "";
		ResultSet rs = null,rs1=null;
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();		
		String strappno = Helper.correctNull((String)hshValues.get("strAppno"));
		String banktype = Helper.correctNull((String)hshValues.get("bank"));
		String strMemberBankcode="";
		 if(banktype.equalsIgnoreCase(""))
		 {
			 banktype = Helper.correctNull((String)hshValues.get("hidourother"));
		 }
		try
		{
			strQuery=SQLParser.getSqlQuery("sel_otherbankcredits^"+strappno+"^"+banktype);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				arrCol.add(Helper.correctNull((String)rs.getString("COM_APPNO")));//0
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SNO")));//1
				arrCol.add(Helper.correctNull((String)rs.getString("COM_FACSNO")));//2
				Helper.correctNull((String)rs.getString("COM_MEMBERBANK"));
				strMemberBankcode=Helper.correctNull(rs.getString("COM_MEMBERBANK"));
				rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+strMemberBankcode);
				if(rs1.next())
				{
					arrCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));//3
				}
				arrCol.add(Helper.correctNull((String)rs.getString("COM_TOTALSHARE")));//4
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SHARE1")));//5
				arrCol.add(Helper.correctNull((String)rs.getString("COM_EXISTFUND")));//6
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SHARE2")));//7
				arrCol.add(Helper.correctNull((String)rs.getString("COM_EXISTNONFUND")));//8
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SHARE3")));//9
				arrCol.add(Helper.correctNull((String)rs.getString("COM_PROPOSEDFUND")));//10
				arrCol.add(Helper.correctNull((String)rs.getString("COM_SHARE4")));//11
				arrCol.add(Helper.correctNull((String)rs.getString("COM_PROPOSEDNONFUND")));//12
				arrCol.add(Helper.correctNull((String)rs.getString("COM_LIMIT")));//13
				arrCol.add(Helper.correctNull((String)rs.getString("COM_OUTSTANDING")));//14
				arrCol.add(Helper.correctNull((String)rs.getString("COM_OSASON")));//15
				arrCol.add(Helper.correctNull((String)rs.getString("COM_BANKTYPE")));//16
				arrCol.add(Helper.correctNull((String)rs.getString("COM_CREDITTYPE")));//17
				arrCol.add(Helper.correctNull((String)rs.getString("COM_OUROTHER")));//18
				arrCol.add(Helper.correctNull((String)rs.getString("COM_FACVALUE")));//19
				arrCol.add(Helper.correctNull((String)rs.getString("COM_TOTALPROPSHARE")));//20
				arrCol.add(strMemberBankcode);//21
				arrRow.add(arrCol);
			}
			hshRecord.put("arrRow",arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getourBankcreditDetails===> "+ce.toString());
		}		
		return hshRecord;
	}
	
	
	public HashMap getBankingDetails(HashMap hsh) 
	{
		ResultSet rs = null , rs1=null;
		HashMap hshValues= new HashMap();
		String strQuery="",strValue="";
		ArrayList arrCol	= new ArrayList();
		ArrayList arrRow	= new ArrayList();
		String strAppno		= "",strFacType="",strFacCreditType="", strBankingArrangement="";
		String strLeadBankcode="";
		try
		{	
			strAppno	= correctNull((String)hsh.get("appno"));
			
			//from Banking Details
			rs = DBUtils.executeLAPSQuery("sel_BankingDetails^"+strAppno);
			
			if(rs.next())
			{
				rs.beforeFirst();
				
				while(rs.next())
				{
					arrCol	= new ArrayList();
					
					arrCol.add(correctNull(rs.getString("com_bank_factype")));//0
					
					if(correctNull(rs.getString("com_bank_factype")).equals("1")||correctNull(rs.getString("com_bank_factype")).equals("W"))
					{
						strFacType			= "Working Capital";
					}
					else if(correctNull(rs.getString("com_bank_factype")).equals("2")||correctNull(rs.getString("com_bank_factype")).equals("T"))
					{
						strFacType	= "Term Loan";
					}
					
					arrCol.add(strFacType);//1
					arrCol.add(Helper.correctInt(rs.getString("com_bank_facility")));//2
					arrCol.add(Helper.correctInt(rs.getString("com_bank_facsno")));//3
					arrCol.add(correctNull(rs.getString("com_bank_facility_desc")));//4
					arrCol.add(correctNull(rs.getString("com_bank_faccrtype")));//5
					
					if(correctNull(rs.getString("com_bank_faccrtype")).equals("E")){strFacCreditType		= "Existing";}
					else if(correctNull(rs.getString("com_bank_faccrtype")).equals("P")){strFacCreditType	= "Proposed";}
					
					arrCol.add(strFacCreditType);//6
					arrCol.add(correctNull(rs.getString("com_bank_name")));//7
					arrCol.add(correctNull(rs.getString("com_bank_arr")));//8
					
					if(correctNull(rs.getString("com_bank_arr")).equals("C")){strBankingArrangement		= "Consortium";}
					else if(correctNull(rs.getString("com_bank_arr")).equals("M")){strBankingArrangement	= "Multiple";}
					
					arrCol.add(strBankingArrangement);//9
					strLeadBankcode=Helper.correctNull(rs.getString("com_bank_lead"));
					rs1 = DBUtils.executeLAPSQuery("getstaticdescription^"+"147"+"^"+strLeadBankcode);
					if(rs1.next())
					{
						arrCol.add(Helper.correctNull(rs1.getString("STAT_DATA_DESC1")));
					}
					arrCol.add(strLeadBankcode);//11
					arrRow.add(arrCol);
					
					hshValues.put("com_Exiconsortiummul",Helper.correctNull((String)rs.getString("com_Exiconsortiummul")));
					hshValues.put("com_proconsortiummul",Helper.correctNull((String)rs.getString("com_proconsortiummul")));
					
					
				}
			}
			else
			{
				//From WC and TL - Our  Bank
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAFacilityNameOur^"+strAppno);
				
				while(rs.next())
				{
					
					String strFacility=Helper.correctNull((String)rs.getString("combk_facility"));
					String strFacilityCode[]=strFacility.split("~");
					String strFacilityId=strFacilityCode[1];
					String strFacilityFor=Helper.correctNull((String)rs.getString("combk_modtype"));
					String strFacilityDesc="";
					if(strFacilityFor.equalsIgnoreCase("r"))
					{
						rs1	= DBUtils.executeLAPSQuery("selLoanPurpose^"+strFacilityId);
					}
					else
					{
						rs1	= DBUtils.executeLAPSQuery("sel_facilitycorp^"+strFacilityId);
					}
					if(rs1.next())
					{
						strFacilityDesc=Helper.correctNull((String)rs1.getString("prddesc"));
					}
					
					arrCol	= new ArrayList();
					
					arrCol.add(correctNull(rs.getString("combk_type")));//0
					
					if(correctNull(rs.getString("combk_type")).equals("1")){strFacType		= "Working Capital";}
					else if(correctNull(rs.getString("combk_type")).equals("2")){strFacType	= "Term Loan";}
					
					arrCol.add(strFacType);//1
					arrCol.add(Helper.correctInt(rs.getString("combk_facility")));//2
					arrCol.add(Helper.correctInt(rs.getString("combk_id")));//3
					arrCol.add(strFacilityDesc);//4
					arrCol.add("E");//5
					arrCol.add("Existing");//6
					arrCol.add("Karnataka Bank");//7
					arrCol.add(correctNull(rs.getString("combk_bnktype")));//8
					
					if(correctNull(rs.getString("combk_bnktype")).equals("C")){strBankingArrangement		= "Consortium";}
					else if(correctNull(rs.getString("combk_bnktype")).equals("M")){strBankingArrangement	= "Multiple";}
					
					arrCol.add(strBankingArrangement);//9
					arrCol.add("");//10
					arrCol.add("");
					arrRow.add(arrCol);
				}
				
				//From Facilities
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAFacilityName^"+strAppno);
				
				while(rs.next())
				{
					arrCol	= new ArrayList();
					
					arrCol.add(correctNull(rs.getString("facility_nature")));//0
					
					if(correctNull(rs.getString("facility_nature")).equals("1")){strFacType			= "Working Capital";}
					else if(correctNull(rs.getString("facility_nature")).equals("2")){strFacType	= "Term Loan";}
					
					arrCol.add(strFacType);//1
					arrCol.add(Helper.correctInt(rs.getString("facility_id")));//2
					arrCol.add(Helper.correctInt(rs.getString("facility_sno")));//3
					arrCol.add(correctNull(rs.getString("com_facdesc")));//4
					arrCol.add("P");//5
					arrCol.add("Proposed");//6
					arrCol.add("Karnataka Bank");//7
					arrCol.add(correctNull(rs.getString("facility_propbanktype")));//8
					
					if(correctNull(rs.getString("facility_propbanktype")).equals("C")){strBankingArrangement		= "Consortium";}
					else if(correctNull(rs.getString("facility_propbanktype")).equals("M")){strBankingArrangement	= "Multiple";}
					
					arrCol.add(strBankingArrangement);//9
					arrCol.add("");//10
					arrCol.add("");
					arrRow.add(arrCol);
				}
				
				//From WC and TL - Other  Bank
				if(rs!=null){rs.close();}
				rs = DBUtils.executeLAPSQuery("sel_BAFacilityNameOther^"+strAppno);
				
				while(rs.next())
				{
					arrCol	= new ArrayList();
					
					arrCol.add(correctNull(rs.getString("combk_type")));//0
					
					if(correctNull(rs.getString("combk_type")).equals("W")){strFacType		= "Working Capital";}
					else if(correctNull(rs.getString("combk_type")).equals("T")){strFacType	= "Term Loan";}
					
					arrCol.add(strFacType);//1
					arrCol.add("0");//2
					arrCol.add(Helper.correctInt(rs.getString("combk_id")));//3
					arrCol.add(correctNull(rs.getString("combk_facility")));//4
					arrCol.add("E");//5
					arrCol.add("Existing");//6
					arrCol.add(correctNull(rs.getString("combk_bnkname")));//7
					arrCol.add(correctNull(rs.getString("combk_bnktype")));//8
					
					if(correctNull(rs.getString("combk_bnktype")).equals("C")){strBankingArrangement		= "Consortium";}
					else if(correctNull(rs.getString("combk_bnktype")).equals("M")){strBankingArrangement	= "Multiple";}
					
					arrCol.add(strBankingArrangement);//9
					arrCol.add("");//10
					arrCol.add("");
					arrRow.add(arrCol);
				}
			}
			hshValues.put("arrRow", arrRow);
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in getBankingDetails login  "+ce.toString());
		}
		finally
		{
			try
			{	
				if(rs!= null){rs.close();}
				if(rs1!= null){rs1.close();}

			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
		}
		return hshValues; 
	}
	
	public void updateBankingDetails(HashMap hsh) 
	{
		HashMap hshValuse = new HashMap();
		HashMap hshQuery	= new HashMap();
		HashMap hshqueryval	= new HashMap();
		ArrayList arrValues	= new ArrayList();
		int intUpdatesize	= 0, intLen=0;
		String strAppno = "", strAction = "";
		
		String strFacType[]			= null;
		String strFacId[] 			= null;
		String strFacSno[] 			= null; 
		String strFacDesc[] 		= null; 
		String strFacCreditType[] 	= null;
		String strBankName[] 		= null;
		String strBankingArrangement[] 	= null;
		String strLeadBank[] 		= null;
		try
		{
			strAppno	= correctNull((String)hsh.get("appno"));
			strAction	= correctNull((String)hsh.get("hidAction"));
			
			intLen		= Integer.parseInt(Helper.correctInt((String)hsh.get("hid_RowSize")));
			
			//Delete
			if(strAction.equalsIgnoreCase("insert")||strAction.equalsIgnoreCase("delete"))
			{
				hshQuery 	= new HashMap();
				arrValues	= new ArrayList();
				
				hshQuery.put("strQueryId","del_BankingDetails");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshqueryval.put("size",Integer.toString(1));
				hshqueryval.put(Integer.toString(1),hshQuery);
				
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			
			//Insert
			if(strAction.equalsIgnoreCase("insert"))
			{
				if(hsh.get("hid_FacilityType") instanceof String)
				{
					hshQuery 	= new HashMap();
					arrValues	= new ArrayList();
					
					intUpdatesize	= intUpdatesize+1;
					
					hshQuery.put("strQueryId","ins_BankingDetails");
					arrValues.add(strAppno);
					arrValues.add(correctNull((String)hsh.get("hid_FacilityType")));
					arrValues.add(correctNull((String)hsh.get("hid_FacilityId")));
					arrValues.add(correctNull((String)hsh.get("hid_FacilitySno")));
					arrValues.add(correctNull((String)hsh.get("txt_Facilitydesc")));
					arrValues.add(correctNull((String)hsh.get("hid_FacilityCreditType")));
					arrValues.add(correctNull((String)hsh.get("txt_BankName")));
					arrValues.add(correctNull((String)hsh.get("hid_BankingArrangement")));
					arrValues.add(correctNull((String)hsh.get("hid_LeadBankcode")));
					arrValues.add(correctNull((String)hsh.get("sel_Exewhetherconmul")));
					arrValues.add(correctNull((String)hsh.get("sel_Prowhetherconmul")));
					
					hshQuery.put("arrValues",arrValues);
					hshqueryval.put("size",Integer.toString(intUpdatesize));
					hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
				}
				else if(hsh.get("hid_FacilityType") instanceof String[])
				{
					 strFacType			= (String [])hsh.get("hid_FacilityType");
					 strFacId 			= (String [])hsh.get("hid_FacilityId");
					 strFacSno 			= (String [])hsh.get("hid_FacilitySno");
					 strFacDesc 		= (String [])hsh.get("txt_Facilitydesc"); 
					 strFacCreditType 	= (String [])hsh.get("hid_FacilityCreditType");
					 strBankName 		= (String [])hsh.get("txt_BankName");
					 strBankingArrangement 	= (String [])hsh.get("hid_BankingArrangement");
					 strLeadBank		= (String [])hsh.get("hid_LeadBankcode");
						
					for(int i=0;i<intLen;i++)
					{
						hshQuery 	= new HashMap();
						arrValues	= new ArrayList();
						
						intUpdatesize	= intUpdatesize+1;
						
						hshQuery.put("strQueryId","ins_BankingDetails");
						arrValues.add(strAppno);
						arrValues.add(strFacType[i]);
						arrValues.add(strFacId[i]);
						arrValues.add(strFacSno[i]);
						arrValues.add(strFacDesc[i]);
						arrValues.add(strFacCreditType[i]);
						arrValues.add(strBankName[i]);
						arrValues.add(strBankingArrangement[i]);
						arrValues.add(strLeadBank[i]);
						arrValues.add(correctNull((String)hsh.get("sel_Exewhetherconmul")));
						arrValues.add(correctNull((String)hsh.get("sel_Prowhetherconmul")));
						
						hshQuery.put("arrValues",arrValues);
						hshqueryval.put("size",Integer.toString(intUpdatesize));
						hshqueryval.put(Integer.toString(intUpdatesize),hshQuery);
					}
				}
			}
			EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			
			/*hid_FacilityType
			hid_FacilityId
			hid_FacilitySno
			txt_Facilitydesc
			hid_FacilityCreditType
			txt_BankName
			hid_BankingArrangement
			txt_LeadBankName*/
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateBankingDetails login  "+ce.toString());
		}
	}
	
	public void updturnoverMethod (HashMap hshValues) 
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno="";
		
		try
		{
			appno = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
						
			String[] Year = null;
			String[] ProjSales = null;
			String[] AccptProjSales = null;
			String[] PercAccptSales = null;
			String[] MinMargin = null;
			String[] EligibleFin = null;
			String[] ActualMargin = null;
			String[] EligiblebankFin = null;
			String[] PermisibleBankFin = null;
			String[] LimitSought = null;
			String[] LimitProposed = null;
			String[] Surplus = null;
			String[] Requiredmargin = null;
			String[] strCombo=null;
				
			Year = (String[])hshValues.get("txt_year");
			ProjSales = (String[]) hshValues.get("txt_projSales");
			AccptProjSales = (String[]) hshValues.get("txt_accptprojSales");
			PercAccptSales = (String[]) hshValues.get("txt_percentaccptSales");
			MinMargin = (String[]) hshValues.get("txt_minMargin");
			EligibleFin = (String[])hshValues.get("txt_eligibleFin");
			ActualMargin = (String[]) hshValues.get("txt_actualMargin");
			EligiblebankFin = (String[])hshValues.get("txt_eligibleBankfin");
			PermisibleBankFin = (String[]) hshValues.get("txt_permisibleBankfin");
			LimitSought = (String[]) hshValues.get("txt_limitSought");
			LimitProposed = (String[]) hshValues.get("txt_limitProposed");
			Surplus = (String[])hshValues.get("txt_surplus");
			Requiredmargin = (String[]) hshValues.get("txt_Requiredmargin");
			strCombo=(String[]) hshValues.get("combo");
			
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_turnoverMethod");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
				
				int j=0;
				for(int i=0;i<5;i++)
			 	{
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","ins_turnoverMethod");
					arrValues.add(appno);
					arrValues.add(Integer.toString(j+1));
					arrValues.add(Year[i]);
					arrValues.add(ProjSales[i]);
					arrValues.add(AccptProjSales[i]);
					arrValues.add(PercAccptSales[i]);
					arrValues.add(MinMargin[i]);
					arrValues.add(EligibleFin[i]);
					arrValues.add(ActualMargin[i]);
					arrValues.add(EligiblebankFin[i]);
					arrValues.add(PermisibleBankFin[i]);
					arrValues.add(LimitSought[i]);
					arrValues.add(LimitProposed[i]);
					arrValues.add(Surplus[i]);
					arrValues.add(Requiredmargin[i]);
					arrValues.add(strCombo[i]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					j++;
				} 
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_turnoverMethod");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
			}	
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing updturnoverMethod" + ce.getMessage()); 
		}
		finally
		{

			try {
				if (rs != null) {
					rs.close();
				}
				arrValues=null;
				hshQueryValues = null;
				hshQuery = null;
			} 
			catch (Exception cf) {
				throw new EJBException("Error closing in updturnoverMethod connection "+ cf.getMessage());
			}
		} 
	}
	
	public HashMap getturnoverMethod(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		ArrayList arrColyr = new ArrayList();
		ArrayList arrRowyr = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		int i=0;
		String strFinID="",strValuesin="";
		try
		{
			String strAppno =correctNull((String) hshValues.get("appno"));

			strQuery=SQLParser.getSqlQuery("sel_turnoverMethod^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				if(Helper.correctNull(rs.getString("COM_TO_PROJSALES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PROJSALES")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_ACPTPROJSALES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ACPTPROJSALES")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_PERCENTACPTPROJSALES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PERCENTACPTPROJSALES")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_MINMARGIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_MINMARGIN")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEFIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEFIN")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_ACTUALMARGIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ACTUALMARGIN")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEBANKFIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_ELIGIBLEBANKFIN")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_PERMISIBLEFIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_PERMISIBLEFIN")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_LIMITSOUGHT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_LIMITSOUGHT")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_LIMITPROPOSED")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_LIMITPROPOSED")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_SURPLUS")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_SURPLUS")));
				}
				if(Helper.correctNull(rs.getString("COM_TO_REQMARGIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_TO_REQMARGIN")));
				}
				
				arrRow.add(arrCol);
			}
			
			strQuery=SQLParser.getSqlQuery("sel_turnoverMethod^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrColyr = new ArrayList();
				arrColyr.add(Helper.correctNull(rs.getString("COM_TO_YEAR")));
				hshRecord.put("COM_TO_combo"+i,Helper.correctNull(rs.getString("COM_TO_combo")));
				i++;
				arrRowyr.add(arrColyr);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrRowyr",arrRowyr);
			
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
			}
			if (!strFinID.equals("0")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strValuesin = Helper.correctNull((String) rs
							.getString("fin_valuesarein"));
				}
			}
			if(strValuesin.equalsIgnoreCase("C"))
			{
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
		}
		catch (Exception ce)
		{	
			throw new EJBException("Error in closing getturnoverMethod" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null)
			    {
					 rs1.close();
			    }
			}
			catch (Exception e)
			{	
				throw new EJBException("Error in closing getturnoverMethod Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}
	
	public void updexpenditureMethod (HashMap hshValues) 
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno="";
		
		try
		{
			appno = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String Year1 = correctNull((String)hshValues.get("txt_yr1"));
			String Year2 = correctNull((String)hshValues.get("txt_yr2"));
			String Year3 = correctNull((String)hshValues.get("txt_yr3"));
			String Year4 = correctNull((String)hshValues.get("txt_yr4"));
			String Year5 = correctNull((String)hshValues.get("txt_yr5"));
			
			String[] Year = null;
			String[] ProjExp = null;
			String[] AccptProjExp = null;
			String[] OperationCycle = null;
			String[] EligibleExpnd = null;
			String[] PermisibleFin = null;
			String[] LimitSought = null;
			String[] LimitProposed = null;
			String[] strcombo=null;							
			Year = (String[])hshValues.get("txt_year");
			ProjExp = (String[]) hshValues.get("txt_projExp");
			AccptProjExp = (String[]) hshValues.get("txt_accptprojExp");
			OperationCycle = (String[]) hshValues.get("txt_operationCycle");
			EligibleExpnd = (String[]) hshValues.get("txt_eligibleExpnd");
			PermisibleFin = (String[])hshValues.get("txt_permisibleFin");
			LimitSought = (String[]) hshValues.get("txt_limitSought");
			LimitProposed = (String[]) hshValues.get("txt_limitProposed");
			strcombo=(String[]) hshValues.get("combo");
			
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_expenditureMethod");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
				
				int j=0;
				 for(int i=0;i<5;i++)
			 	{
					 
					arrValues = new ArrayList();
					hshQueryValues = new HashMap();
					hshQuery=new HashMap();
					hshQuery.put("strQueryId","ins_expenditureMethod");
					arrValues.add(appno);
					arrValues.add(Integer.toString(j+1));
					arrValues.add(Year[i]);
					arrValues.add(ProjExp[i]);
					arrValues.add(AccptProjExp[i]);
					arrValues.add(OperationCycle[i]);
					arrValues.add(EligibleExpnd[i]);
					arrValues.add(PermisibleFin[i]);
					arrValues.add(LimitSought[i]);
					arrValues.add(LimitProposed[i]);
					arrValues.add(strcombo[i]);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					j++;
				} 
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_expenditureMethod");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
			}	
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing updexpenditureMethod" + ce.getMessage()); 
		}
		finally
		{

			try {
				if (rs != null) {
					rs.close();
				}
				arrValues=null;
				hshQueryValues = null;
				hshQuery = null;
			} 
			catch (Exception cf) {
				throw new EJBException("Error closing in updexpenditureMethod connection "+ cf.getMessage());
			}
		} 
	}
	
	public HashMap getexpenditureMethod(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		ArrayList arrColyr = new ArrayList();
		ArrayList arrRowyr = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		int i=0;
		String strFinID="",strValuesin="";
		try
		{
			String strAppno =correctNull((String) hshValues.get("appno"));

			strQuery=SQLParser.getSqlQuery("sel_expenditureMethod^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				if(Helper.correctNull(rs.getString("COM_EXP_PROJEXPND")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_PROJEXPND")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_ACPTPROJEXPND")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_ACPTPROJEXPND")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_OPERATIONCYCLE")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_OPERATIONCYCLE")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_ELIGIBLEEXPND")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_ELIGIBLEEXPND")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_PERMISIBLEFIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_PERMISIBLEFIN")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_LIMITSOUGHT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_LIMITSOUGHT")));
				}
				if(Helper.correctNull(rs.getString("COM_EXP_LIMITPROPOSED")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_EXP_LIMITPROPOSED")));
				}
				arrRow.add(arrCol);
			}
			
			strQuery=SQLParser.getSqlQuery("sel_expenditureMethod^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrColyr = new ArrayList();
				arrColyr.add(Helper.correctNull(rs.getString("COM_EXP_YEAR")));
				hshRecord.put("COM_EXP_Combo"+i,Helper.correctNull(rs.getString("COM_EXP_Combo")));
				arrRowyr.add(arrColyr);
				i++;
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrRowyr",arrRowyr);
			
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
			}
			if (!strFinID.equals("0")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strValuesin = Helper.correctNull((String) rs
							.getString("fin_valuesarein"));
				}
			}
			if(strValuesin.equalsIgnoreCase("C"))
			{
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing getexpenditureMethod" + ce.getMessage()); 
		}
		finally
		{
			try{
				if (rs != null) {
					rs.close();
				}
				arrRow=null;
				arrCol=null;
			}
			catch(Exception cf){
				throw  new EJBException("Error in closing getexpenditureMethod Connection" + cf.getMessage()); 
			}
		}
		return hshRecord;
	}
	
	
	public void updateCashFlow (HashMap hshValues) 
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno="";
		int maxsno=0,intUnitno=0;
		
		try
		{
			appno = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
			String selectfinYear =  Helper.correctNull((String)hshValues.get("sel_finYear1"));
			if(selectfinYear.trim().equalsIgnoreCase(""))
			{
				selectfinYear=Helper.correctNull((String)hshValues.get("sel_finYear"));
			}
			String strfinYear = correctNull((String)hshValues.get("txt_finYear"));			
			String[] Year = null;
			String[] OpeningBal = null;
			String[] PromoterEquity = null;
			String[] BankFinance = null;
			String[] UnsecLoan = null;
			String[] SaleProceeds = null;
			String[] SourceFinTotal = null;
			String[] CostofLand = null;
			String[] PremiumFSI = null;
			String[] ConstrCost = null;
			String[] MarketExpn = null;
			String[] AdminExpn = null;
			String[] Interest = null;
			String[] Repayment = null;
			String[] ProvisionTax = null;
			String[] ApplFinTotal = null;
			String[] ClosingBal = null;
			String[] other=null;
			String[] otherfin=null;
			
			Year = (String[])hshValues.get("txt_year");
			OpeningBal = (String[]) hshValues.get("txt_openingBal");
			PromoterEquity = (String[]) hshValues.get("txt_promoterEquity");
			BankFinance = (String[]) hshValues.get("txt_bankFinance");
			UnsecLoan = (String[]) hshValues.get("txt_unsecLoan");
			SaleProceeds = (String[])hshValues.get("txt_saleProceeds");
			SourceFinTotal = (String[]) hshValues.get("txt_sourceoffinTot");
			CostofLand = (String[])hshValues.get("txt_costofLand");
			PremiumFSI = (String[]) hshValues.get("txt_premiumFSI");
			ConstrCost = (String[]) hshValues.get("txt_constrCost");
			MarketExpn = (String[]) hshValues.get("txt_marketExpn");
			AdminExpn = (String[])hshValues.get("txt_adminExpn");
			Interest = (String[])hshValues.get("txt_interest");
			Repayment = (String[])hshValues.get("txt_repayment");
			ProvisionTax = (String[])hshValues.get("txt_provisionofTax");
			ApplFinTotal = (String[])hshValues.get("txt_apploffinTot");
			ClosingBal = (String[])hshValues.get("txt_closingBal");
			other = (String[])hshValues.get("txt_others");
			otherfin = (String[])hshValues.get("txt_finothers");
			
			rs = DBUtils.executeLAPSQuery("sel_unitno_Cashflow^"+appno+"^"+selectfinYear);
			if(rs.next()){
				intUnitno = rs.getInt("sel_unitno");
			}
			
			rs = DBUtils.executeLAPSQuery("sel_maxsno_cashflow^"+appno);
			if(rs.next()){
				maxsno = rs.getInt("com_cf_unitno");
			}
			
			if(strAction.equalsIgnoreCase("update"))
			{
				if(selectfinYear.equalsIgnoreCase("new"))
				{
					int j=0;
					for(int i=0;i<6;i++)
				 	{
						if(Year[i]!=null && !Year[i].equalsIgnoreCase(""))
						{
							arrValues = new ArrayList();
							hshQueryValues = new HashMap();
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","ins_cashflowMethod");
							arrValues.add(appno);
							arrValues.add(Integer.toString(j+1));
							arrValues.add(Year[i]);
							arrValues.add(OpeningBal[i]);
							arrValues.add(PromoterEquity[i]);
							arrValues.add(BankFinance[i]);
							arrValues.add(UnsecLoan[i]);
							arrValues.add(SaleProceeds[i]);
							arrValues.add(SourceFinTotal[i]);
							arrValues.add(CostofLand[i]);
							arrValues.add(PremiumFSI[i]);
							arrValues.add(ConstrCost[i]);
							arrValues.add(MarketExpn[i]);
							arrValues.add(AdminExpn[i]);
							arrValues.add(Interest[i]);
							arrValues.add(Repayment[i]);
							arrValues.add(ProvisionTax[i]);
							arrValues.add(ApplFinTotal[i]);
							arrValues.add(ClosingBal[i]);
							arrValues.add(other[i]);
							arrValues.add(otherfin[i]);
							arrValues.add(strfinYear);
							arrValues.add(""+maxsno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");	
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							j++;
						}
					} 
				}
				
				else
				{	
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					arrValues = new ArrayList();
					hshQuery.put("strQueryId","del_cashflowMethod");
					arrValues.add(appno);
					arrValues.add(selectfinYear);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					hshQueryValues.put("size","1");
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
					
					int j=0,k=0;
					for(int i=0;i<6;i++)
				 	{
						if(Year[i]!=null && !Year[i].equalsIgnoreCase(""))
						{
							arrValues = new ArrayList();
							hshQueryValues = new HashMap();
							hshQuery=new HashMap();
							hshQuery.put("strQueryId","ins_cashflowMethod");
							arrValues.add(appno);
							arrValues.add(Integer.toString(j+1));
							arrValues.add(Year[i]);
							arrValues.add(OpeningBal[i]);
							arrValues.add(PromoterEquity[i]);
							arrValues.add(BankFinance[i]);
							arrValues.add(UnsecLoan[i]);
							arrValues.add(SaleProceeds[i]);
							arrValues.add(SourceFinTotal[i]);
							arrValues.add(CostofLand[i]);
							arrValues.add(PremiumFSI[i]);
							arrValues.add(ConstrCost[i]);
							arrValues.add(MarketExpn[i]);
							arrValues.add(AdminExpn[i]);
							arrValues.add(Interest[i]);
							arrValues.add(Repayment[i]);
							arrValues.add(ProvisionTax[i]);
							arrValues.add(ApplFinTotal[i]);
							arrValues.add(ClosingBal[i]);
							arrValues.add(other[i]);
							arrValues.add(otherfin[i]);
							arrValues.add(selectfinYear);
							arrValues.add(""+intUnitno);
							hshQuery.put("arrValues",arrValues);
							hshQueryValues.put("1",hshQuery);
							hshQueryValues.put("size","1");	
							EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
							j++;
						}
					}
				}
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_cashflowMethod");
				arrValues.add(appno);
				arrValues.add(selectfinYear);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","upd_comCashflow");
				arrValues.add("1");
				arrValues.add(appno);
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("2",hshQuery);
				hshQueryValues.put("size","2");
				
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
			}	
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing updateCashFlow" + ce.getMessage()); 
		}
		finally
		{

			try {
				if (rs != null) {
					rs.close();
				}
				arrValues=null;
				hshQueryValues = null;
				hshQuery = null;
			} 
			catch (Exception cf) {
				throw new EJBException("Error closing in updateCashFlow connection "+ cf.getMessage());
			}
		} 
	}
	
	public HashMap getCashFlow(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		ArrayList arrColyr = new ArrayList();
		ArrayList arrRowyr = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		int i=0,k=0,m=0,RowCount=0;
		
		double dbl_allopnBal=0.00 ,dbl_opnBal=0.00 ,dbl_allproEqt=0.00 ,dbl_proEqt=0.00 ,dbl_bnkFin=0.00 ,dbl_allbnkFin=0.00 ,dbl_unsec=0.00 ,dbl_allunsec=0.00;
		double dbl_allsaleProc=0.00 ,dbl_saleProc=0.00 ,dbl_other=0.00 ,dbl_allother=0.00 ,dbl_allsofTot=0.00 ,dbl_sofTot=0.00 ,dbl_costLand=0.00 ,dbl_allcostLand=0.00;
		double dbl_adminexp=0.00 ,dbl_alladminexp=0.00 ,dbl_marketexp=0.00 ,dbl_allmarketexp=0.00 ,dbl_constcost=0.00 ,dbl_allconstcost=0.00 ,dbl_premiumfsi=0.00;
		double dbl_allpremiumfsi=0.00 ,dbl_provTax=0.00 ,dbl_allprovTax=0.00 ,dbl_allrepayment=0.00 ,dbl_repayment=0.00 ,dbl_allinterest=0.00 ,dbl_interest=0.00;
		double dbl_allotherFin=0.00 ,dbl_otherFin=0.00 ,dbl_allappfinTot=0.00 ,dbl_appfinTot=0.00 ,dbl_closingBal=0.00 ,dbl_allclosingBal=0.00;
		
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		
		String maxsno="",unitno="",strclosingBal="";
		
		try
		{
			String strAppno =correctNull((String) hshValues.get("appno"));
			
			String selectfinYear =  Helper.correctNull((String)hshValues.get("sel_finYear1"));
			if(selectfinYear.trim().equalsIgnoreCase(""))
			{
				selectfinYear=Helper.correctNull((String)hshValues.get("sel_finYear"));
			}

			strQuery=SQLParser.getSqlQuery("sel_countCashflow^"+strAppno+"^"+selectfinYear);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				RowCount = rs.getInt("rowcount");
			}
			strQuery=SQLParser.getSqlQuery("sel_cashflowMethod^"+strAppno+"^"+selectfinYear);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				
				if(Helper.correctNull(rs.getString("COM_CF_OPENINGBAL")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OPENINGBAL")));
				}
				
				if(Helper.correctNull(rs.getString("COM_CF_PROMOTEREQUITY")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PROMOTEREQUITY")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_BANKFINANCE")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_BANKFINANCE")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_UNSECLOAN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_UNSECLOAN")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_SALEPROCEEDS")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_SALEPROCEEDS")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_SOF_TOTAL")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_SOF_TOTAL")));
				}
				
				
				if(Helper.correctNull(rs.getString("COM_CF_COSTOFLAND")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_COSTOFLAND")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_PREMIUMFSI")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PREMIUMFSI")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_CONSTRUCTCOST")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_CONSTRUCTCOST")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_MARKETEXPENSES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_MARKETEXPENSES")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_ADMINEXPENSES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_ADMINEXPENSES")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_INTEREST")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_INTEREST")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_REPAYMENT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_REPAYMENT")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_PROVISIONTAX")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_PROVISIONTAX")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_APPFIN_TOTAL")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_APPFIN_TOTAL")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_CLOSINGBALANCE")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_CLOSINGBALANCE")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_OTHER")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OTHER")));
				}
				if(Helper.correctNull(rs.getString("COM_CF_OTHERFIN")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_CF_OTHERFIN")));
				}
				arrRow.add(arrCol);
			}
			
			k=7-RowCount;
			for(i=0;i<=k;i++)
			{
				arrCol = new ArrayList();
				
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");
				arrCol.add("0.00");
				
				arrRow.add(arrCol);
			}
		
			strQuery=SQLParser.getSqlQuery("sel_cashflowMethod^"+strAppno+"^"+selectfinYear);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrColyr = new ArrayList();
				arrColyr.add(Helper.correctNull(rs.getString("COM_CF_YEAR")));
				arrRowyr.add(arrColyr);
				hshRecord.put("COM_CF_FINYEAR",Helper.correctNull(rs.getString("COM_CF_FINYEAR")));
			}
			
			m=5-RowCount;
			for(i=0;i<=m;i++)
			{
				arrColyr = new ArrayList();
				arrColyr.add("");	
				arrRowyr.add(arrColyr);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrRowyr",arrRowyr);
			
			if (rs != null) {
				rs.close();
			}
			
			strQuery=SQLParser.getSqlQuery("sel_year_cashflow^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("yr_count",Helper.correctNull(rs.getString("yr_count")));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_cashflow_projTot^"+strAppno+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				dbl_opnBal=Double.parseDouble((String)rs.getString("COM_CF_OPENINGBAL"));
				dbl_allopnBal=dbl_allopnBal+dbl_opnBal;
				
				dbl_proEqt=Double.parseDouble((String)rs.getString("COM_CF_PROMOTEREQUITY"));
				dbl_allproEqt=dbl_allproEqt+dbl_proEqt;
				
				dbl_bnkFin=Double.parseDouble((String)rs.getString("COM_CF_BANKFINANCE"));
				dbl_allbnkFin=dbl_allbnkFin+dbl_bnkFin;
				
				dbl_unsec=Double.parseDouble((String)rs.getString("COM_CF_UNSECLOAN"));
				dbl_allunsec=dbl_allunsec+dbl_unsec;
				
				dbl_saleProc=Double.parseDouble((String)rs.getString("COM_CF_SALEPROCEEDS"));
				dbl_allsaleProc=dbl_allsaleProc+dbl_saleProc;
				
				dbl_other=Double.parseDouble((String)rs.getString("COM_CF_OTHER"));
				dbl_allother=dbl_allother+dbl_other;
				
				dbl_sofTot=Double.parseDouble((String)rs.getString("COM_CF_SOF_TOTAL"));
				dbl_allsofTot=dbl_allsofTot+dbl_sofTot;
				
				dbl_costLand=Double.parseDouble((String)rs.getString("COM_CF_COSTOFLAND"));
				dbl_allcostLand=dbl_allcostLand+dbl_costLand;
				
				dbl_premiumfsi=Double.parseDouble((String)rs.getString("COM_CF_PREMIUMFSI"));
				dbl_allpremiumfsi=dbl_allpremiumfsi+dbl_premiumfsi;
				
				dbl_constcost=Double.parseDouble((String)rs.getString("COM_CF_CONSTRUCTCOST"));
				dbl_allconstcost=dbl_allconstcost+dbl_constcost;
				
				dbl_marketexp=Double.parseDouble((String)rs.getString("COM_CF_MARKETEXPENSES"));
				dbl_allmarketexp=dbl_allmarketexp+dbl_marketexp;
				
				dbl_adminexp=Double.parseDouble((String)rs.getString("COM_CF_ADMINEXPENSES"));
				dbl_alladminexp=dbl_alladminexp+dbl_adminexp;
				
				dbl_interest=Double.parseDouble((String)rs.getString("COM_CF_INTEREST"));
				dbl_allinterest=dbl_allinterest+dbl_interest;
				
				dbl_repayment=Double.parseDouble((String)rs.getString("COM_CF_REPAYMENT"));
				dbl_allrepayment=dbl_allrepayment+dbl_repayment;
				
				dbl_provTax=Double.parseDouble((String)rs.getString("COM_CF_PROVISIONTAX"));
				dbl_allprovTax=dbl_allprovTax+dbl_provTax;
				
				dbl_otherFin=Double.parseDouble((String)rs.getString("COM_CF_OTHERFIN"));
				dbl_allotherFin=dbl_allotherFin+dbl_otherFin;
				
				dbl_appfinTot=Double.parseDouble((String)rs.getString("COM_CF_APPFIN_TOTAL"));
				dbl_allappfinTot=dbl_allappfinTot+dbl_appfinTot;
				
				dbl_closingBal=Double.parseDouble((String)rs.getString("COM_CF_CLOSINGBALANCE"));
				dbl_allclosingBal=dbl_allclosingBal+dbl_closingBal;
				
			}
			
			hshRecord.put("Tot_opnBal",""+dc.format(dbl_allopnBal));
			hshRecord.put("Tot_proEqt",""+dc.format(dbl_allproEqt));
			hshRecord.put("Tot_bnkFin",""+dc.format(dbl_allbnkFin));
			hshRecord.put("Tot_unsec",""+dc.format(dbl_allunsec));
			hshRecord.put("Tot_saleProc",""+dc.format(dbl_allsaleProc));
			hshRecord.put("Tot_other",""+dc.format(dbl_allother));
			hshRecord.put("Tot_sofTot",""+dc.format(dbl_allsofTot));
			hshRecord.put("Tot_costLand",""+dc.format(dbl_allcostLand));
			hshRecord.put("Tot_premiumfsi",""+dc.format(dbl_allpremiumfsi));
			hshRecord.put("Tot_constcost",""+dc.format(dbl_allconstcost));
			hshRecord.put("Tot_marketexp",""+dc.format(dbl_allmarketexp));
			hshRecord.put("Tot_adminexp",""+dc.format(dbl_alladminexp));
			hshRecord.put("Tot_interest",""+dc.format(dbl_allinterest));
			hshRecord.put("Tot_repayment",""+dc.format(dbl_allrepayment));
			hshRecord.put("Tot_provTax",""+dc.format(dbl_allprovTax));
			hshRecord.put("Tot_otherFin",""+dc.format(dbl_allotherFin));
			hshRecord.put("Tot_appfinTot",""+dc.format(dbl_allappfinTot));
			hshRecord.put("Tot_closingBal",""+dc.format(dbl_allclosingBal));
			
			strQuery=SQLParser.getSqlQuery("sel_cashflow_unitno^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				unitno = Helper.correctNull(rs.getString("unitno"));
			}
			
			strQuery=SQLParser.getSqlQuery("sel_cashflow_maxsno^"+strAppno+"^"+unitno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				maxsno = Helper.correctNull(rs.getString("maxsno"));
			}
			
			if(!unitno.equals("") && !maxsno.equals(""))
			{
				strQuery=SQLParser.getSqlQuery("sel_cashflow_closingbal^"+strAppno+"^"+maxsno+"^"+unitno);
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshRecord.put("com_cf_closingbalance",Helper.correctNull(rs.getString("com_cf_closingbalance")));
				}
			}
			else
			{
				hshRecord.put("com_cf_closingbalance","0.00");
			}
			
			int l=1;
			strQuery=SQLParser.getSqlQuery("sel_unitno_cashflow^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				hshRecord.put("unit_no"+l,Helper.correctNull(rs.getString("unit_no")));
				l++;
			}
			String strFinID="0",strValuesin="";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
			}
			if (!strFinID.equals("0")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strValuesin = Helper.correctNull((String) rs
							.getString("fin_valuesarein"));
				}
			}
			if(strValuesin.equalsIgnoreCase("C"))
			{
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
			
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing getCashFlow" + ce.getMessage()); 
		}
		finally
		{
			try{
				if (rs != null) {
					rs.close();
				}
				arrRow=null;
				arrCol=null;
				arrRowyr=null;
				arrColyr=null;
			}
			catch(Exception cf){
				throw  new EJBException("Error in closing getCashFlow Connection" + cf.getMessage()); 
			}
		}
		return hshRecord;
	}
	
	public HashMap getFinYear(HashMap hshRequestValues) 
	{

		String strQuery="";
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		int forid=1;
		ArrayList arr = new ArrayList();
		ArrayList arr1 = new ArrayList();
		ArrayList arr2 = new ArrayList();
		ArrayList arr3 = new ArrayList();
		String appno =  Helper.correctNull((String)hshRequestValues.get("appno"));
				
		
		try
		{
			strQuery = SQLParser.getSqlQuery("sel_finYear^"+appno);
			rs = DBUtils.executeQuery(strQuery);
						
			while(rs.next())
			{
				arr.add(Helper.correctNull(rs.getString("com_cf_finyear")));
										
			}
			hshRecord.put("arrFinYear",arr);
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
			catch(Exception cf)
			{
				throw new EJBException("Error closing the getFinYear connection "+cf.getMessage());
						
			}

		}
		return hshRecord;
	}
	
	public HashMap getFarmBudget(HashMap hshRequestValues) 
	{
		HashMap hshResult = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshQueryValues = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strQuery="",strQuery1="";
		ResultSet rs=null,rs1=null,rs2=null;
		ResultSet rs21=null;
		ArrayList arrRow= new ArrayList();
		ArrayList arrCol= null;
		ArrayList arrRowP= new ArrayList();
		ArrayList arrColP= null;
		ArrayList arrRowTot= new ArrayList();
		ArrayList arrColTot= null;
		ArrayList arrRowInc= new ArrayList();
		ArrayList arrColInc= null;
		ArrayList arrRowFac= new ArrayList();
		ArrayList arrColFac= null;
		ArrayList IncYear=new ArrayList();
		ArrayList EXPyear=new ArrayList();
		
		ArrayList arrPHRow = new ArrayList();
		
		ArrayList arrPHCol = new ArrayList();
		ArrayList arrDFCol = new ArrayList();
		ArrayList arrPDCol = new ArrayList();
		ArrayList arrFishCol = new ArrayList();
		ArrayList arrAlliedCol = new ArrayList();
		ArrayList arrFFCol = new ArrayList();
		ArrayList arrSeriCol = new ArrayList();
		ArrayList arrFMCol = new ArrayList();
		ArrayList arrGobarCol = new ArrayList();
		ArrayList arrExtraCol = new ArrayList();
		
		String strAppno="",strfacYear="",strType="",strFlag="";
		String strSchemeType="",strCallfrom="";
		int intYearSno=0,intfacTenor=0;
		double dblNetInc =0.00,dblGrsInc=0.00,dblExpens=0.00,dbfacTenor=0.00;
		double dblExiSur=0.00,dblPropSur=0.00,dblOtherInc=0.00,dblTotNetInc=0.00;
		DecimalFormat dc = new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		
		java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
		nf.setGroupingUsed(false);
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);
		
		try
		{
			strAppno = Helper.correctNull((String)hshRequestValues.get("appno"));
			
			/** DINESH on 12/02/2014 **/
			strCallfrom = Helper.correctNull((String)hshRequestValues.get("callform"));
			strQuery=SQLParser.getSqlQuery("sel_tenorforfinyear^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				dbfacTenor = Double.parseDouble(Helper.correctInt((String)rs.getString("facility_months")));
				
				dbfacTenor = Math.ceil(dbfacTenor/12);
				
				intfacTenor = (int)Math.round(dbfacTenor);
			}
			if(intfacTenor!=0)
			{
				for(int i=1;i<=intfacTenor;i++)
				{
					
					dblOtherInc=0.00;
					// For Existing Crops Net Income
					strType="1";strFlag="";dblExiSur=0.00;
					strQuery=SQLParser.getSqlQuery("sel_agrcropPattern_finyr^"+strAppno+"^"+i+"^"+strType);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrCol = new ArrayList();
						
						if(!Helper.correctNull((String)rs1.getString("agr_crp_surplus")).equalsIgnoreCase(""))
						{
							dblExiSur = dblExiSur + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_crp_surplus")));
							
							arrCol.add(dc.format(dblExiSur));
						}
						else
						{
							arrCol.add("0.00");
						}
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrCol = new ArrayList();
						arrCol.add("0.00");
					}
					arrRow.add(arrCol);
		
					// For Proposed Crops Net Income
					strType="2";strFlag="";dblPropSur=0.00;
					strQuery=SQLParser.getSqlQuery("sel_agrcropPattern_finyr^"+strAppno+"^"+i+"^"+strType);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrColP = new ArrayList();
						if(!Helper.correctNull((String)rs1.getString("agr_crp_surplus")).equalsIgnoreCase(""))
						{
							dblPropSur = dblPropSur + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_crp_surplus")));
							
							arrColP.add(dc.format(dblPropSur));
						}
						else
						{
							arrColP.add("0.00");
						}
						
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrColP = new ArrayList();
						arrColP.add("0.00");
					}
					arrRowP.add(arrColP);
					
					//For Other Net Income
					strFlag="";
					strQuery=SQLParser.getSqlQuery("sel_agr_existingincexp^"+strAppno+"^"+i);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrColInc = new ArrayList();
						if(!Helper.correctNull((String)rs1.getString("agr_incexptot")).equalsIgnoreCase(""))
						{
							dblOtherInc = dblOtherInc + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_incexptot")));
							//dblOtherInc = Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_incexptot")));							
							arrColInc.add(dc.format(dblOtherInc));
						}
						else
						{
							arrColInc.add("0.00");
						}
						
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrColInc = new ArrayList();
						arrColInc.add("0.00");
					}
					arrRowInc.add(arrColInc);
					
					/*For Total Net Income
					dblTotNetInc = 0.00;
					dblTotNetInc = dblTotNetInc + dblPropSur + dblExiSur + dblOtherInc;
					arrColTot = new ArrayList();
					arrColTot.add(dc.format(dblTotNetInc));
					arrRowTot.add(arrColTot);
				
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "agr_dssassessment_delete_snofac");
						arrValues.add(strAppno);
						arrValues.add(Integer.toString(i));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_agr_dssAssessment");
						arrValues.add(strAppno);
						arrValues.add(jtn.format(dblTotNetInc));
						arrValues.add(Integer.toString(i));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
					
										
				}
			}
			else{
				for(int i=1;i<=5;i++)
				{
					
					dblOtherInc=0.00;
					// For Existing Crops Net Income
					strType="1";strFlag="";dblExiSur=0.00;
					strQuery=SQLParser.getSqlQuery("sel_agrcropPattern_finyr^"+strAppno+"^"+i+"^"+strType);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrCol = new ArrayList();
						
						if(!Helper.correctNull((String)rs1.getString("agr_crp_surplus")).equalsIgnoreCase(""))
						{
							dblExiSur = dblExiSur + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_crp_surplus")));
							
							arrCol.add(dc.format(dblExiSur));
						}
						else
						{
							arrCol.add("0.00");
						}
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrCol = new ArrayList();
						arrCol.add("0.00");
					}
					arrRow.add(arrCol);
		
					// For Proposed Crops Net Income
					strType="2";strFlag="";dblPropSur=0.00;
					strQuery=SQLParser.getSqlQuery("sel_agrcropPattern_finyr^"+strAppno+"^"+i+"^"+strType);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrColP = new ArrayList();
						if(!Helper.correctNull((String)rs1.getString("agr_crp_surplus")).equalsIgnoreCase(""))
						{
							dblPropSur = dblPropSur + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_crp_surplus")));
							
							arrColP.add(dc.format(dblPropSur));
						}
						else
						{
							arrColP.add("0.00");
						}
						
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrColP = new ArrayList();
						arrColP.add("0.00");
					}
					arrRowP.add(arrColP);
					
					//For Other Net Income
					strFlag="";
					strQuery=SQLParser.getSqlQuery("sel_agr_existingincexp^"+strAppno+"^"+i);
					rs1 = DBUtils.executeQuery(strQuery);
					while(rs1.next())
					{
						strFlag="Y";
						arrColInc = new ArrayList();
						if(!Helper.correctNull((String)rs1.getString("agr_incexptot")).equalsIgnoreCase(""))
						{
							dblOtherInc = dblOtherInc + Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_incexptot")));
							//dblOtherInc = Double.parseDouble(Helper.correctDouble((String)rs1.getString("agr_incexptot")));							
							arrColInc.add(dc.format(dblOtherInc));
						}
						else
						{
							arrColInc.add("0.00");
						}
						
					}
					if(!strFlag.equalsIgnoreCase("Y"))
					{
						arrColInc = new ArrayList();
						arrColInc.add("0.00");
					}
					arrRowInc.add(arrColInc);
					
					//For Total Net Income
					dblTotNetInc = 0.00;
					dblTotNetInc = dblTotNetInc + dblPropSur + dblExiSur + dblOtherInc;
					arrColTot = new ArrayList();
					arrColTot.add(dc.format(dblTotNetInc));
					arrRowTot.add(arrColTot);
				
					/*	hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "agr_dssassessment_delete_snofac");
						arrValues.add(strAppno);
						arrValues.add(Integer.toString(i));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
					
						hshQuery = new HashMap();
						arrValues = new ArrayList();
						hshQuery.put("strQueryId", "ins_agr_dssAssessment");
						arrValues.add(strAppno);
						arrValues.add(jtn.format(dblTotNetInc));
						arrValues.add(Integer.toString(i));
						hshQuery.put("arrValues", arrValues);
						hshQueryValues.put("1", hshQuery);
						hshQueryValues.put("size", "1");
						EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");*/
					
										
				}
			}
			
			String strFacSno="";
			String strFacQuery = SQLParser.getSqlQuery("sel_agriculture_facilities^"+strAppno);
			rs1 = DBUtils.executeQuery(strFacQuery);
			while(rs1.next())
			{
				strFacSno="";
				strSchemeType=Helper.correctNull(rs1.getString("facility_agrschemetype"));
				strFacSno=Helper.correctNull(rs1.getString("facility_sno"));
				String strSchemeName="";
				if(strSchemeType.equalsIgnoreCase("aQ"))
				{
					strSchemeName="Kisan Credit Card Scheme";
				}
				else if(strSchemeType.equalsIgnoreCase("aO"))
				{
					strSchemeName="Minor Irrigation";
				}
				else if(strSchemeType.equalsIgnoreCase("aP"))
				{
					strSchemeName="Federal Agri Mobile";
				}
				else if(strSchemeType.equalsIgnoreCase("aL"))
				{
					strSchemeName="Purchase of Agriculture Land";
				}
				else if(strSchemeType.equalsIgnoreCase("aM"))
				{
					strSchemeName="Farm Mechanisation";
				}
				else if(strSchemeType.equalsIgnoreCase("aK"))
				{
					strSchemeName="Advance Against Warehouse Receipt";
				}
				else if(strSchemeType.equalsIgnoreCase("aH"))
				{
					strSchemeName="Plantation & Horticulture";
				}
				else if(strSchemeType.equalsIgnoreCase("aV"))
				{
					strSchemeName="Farm Development";
				}
				else if(strSchemeType.equalsIgnoreCase("aG"))
				{
					strSchemeName="Rural Godown";
				}
				else if(strSchemeType.equalsIgnoreCase("aS"))
				{
					strSchemeName="Self Help Group";
				}
				else if(strSchemeType.equalsIgnoreCase("aF"))
				{
					strSchemeName="Federal Farm Hospitality";
				}
				else if(strSchemeType.equalsIgnoreCase("aR"))
				{
					strSchemeName="Allied Activity";
				}
				else if(strSchemeType.equalsIgnoreCase("aC"))
				{
					strSchemeName="KCC (Restructure)";
				}
				else if(strSchemeType.equalsIgnoreCase("aU"))
				{
					strSchemeName="ACC";
				}
				else if(strSchemeType.equalsIgnoreCase("aD"))
				{
					strSchemeName="Diary Farming";
				}
				else if(strSchemeType.equalsIgnoreCase("aE"))
				{
					strSchemeName="Poultry Development";
				}
				else if(strSchemeType.equalsIgnoreCase("aJ"))
				{
					strSchemeName="Financing Fisheries";
				}
				else if(strSchemeType.equalsIgnoreCase("aI"))
				{
					strSchemeName="Sericulture";
				}
				else if(strSchemeType.equalsIgnoreCase("aB"))
				{
					strSchemeName="Tobacco Financing";
				}
				else if(strSchemeType.equalsIgnoreCase("aN"))
				{
					strSchemeName="Gobar Gas plant";
				}
				else if(strSchemeType.equalsIgnoreCase("aT"))
				{
					strSchemeName="Financing of Bullock Cart";
				}
				else if(strSchemeType.equalsIgnoreCase("aY"))
				{
					strSchemeName="Farm Forestry";
				}
				else
				{
					strSchemeName="";
				}
				
				arrColFac = new ArrayList();
				
				if(strSchemeType.equalsIgnoreCase("aH"))
				{
					double Netincome=0.00;
					ResultSet rsINC = null;
					String strQuery12 = "";
					ResultSet rsEXP = null;
					String strQuery13 = "";
					
					//For Net Income
					for(int inc=1;inc<=15;inc++)
					{
						strQuery12 = SQLParser.getSqlQuery("sel_netincforfarmbudgetbyappno^"+strAppno+"^"+inc);
						rsINC = DBUtils.executeQuery(strQuery12);
						while(rsINC.next())
						{
							IncYear.add(Helper.correctDouble((String)rsINC.getString("incsum")));	
						}
					}
					//For Expenditure 
					ArrayList PlantEXP = new ArrayList();
					double[] intAddValue = new double[20];
					String strQuery30 = SQLParser.getSqlQuery("agr_horti_plantdetail_select^"+strAppno+"^"+strSchemeType+"^"+strFacSno);
					ResultSet rs30 = DBUtils.executeQuery(strQuery30);
					while(rs30.next())
					{
						String strplantid = Helper.correctNull((String)rs30.getString("AGR_HORTI_ID"));
						strQuery13 = SQLParser.getSqlQuery("agr_horticostofdevelopment_selectbyappno^"+strAppno+"^"+strFacSno+"^"+strplantid);
						rsEXP = DBUtils.executeQuery(strQuery13);
						if(rsEXP.next())
						{							
							for(int exp=1;exp<=15;exp++)
							{
								intAddValue[exp] = intAddValue[exp] + Double.parseDouble(Helper.correctDouble((String)rsEXP.getString("sum"+exp)));
							}
						}
					}
					for(int exp=1;exp<=15;exp++)
					{
						EXPyear.add(String.valueOf(intAddValue[exp]));
					}
					//For Net income
					arrPHCol = new ArrayList();
					arrPHCol.add(strSchemeName);
					for(int net=0;net<15;net++)
					{
						Netincome = Double.parseDouble(Helper.correctDouble((String)IncYear.get(net))) - Double.parseDouble(Helper.correctDouble((String)EXPyear.get(net)));
						arrPHCol.add(String.valueOf(Netincome));
					}
					if(arrPHCol.size()>14)
						arrPHRow.add(arrPHCol);
					else
					{
						arrPHCol = new ArrayList();
						arrPHCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrPHCol.add("0");
						}
						arrPHRow.add(arrPHCol);
					}
				}
				
				else if(strSchemeType.equalsIgnoreCase("aD"))
				{
					HashMap hshDFres = new HashMap();
					ArrayList arrCol1 = new ArrayList();
					AgrNurseryLoanBO agrDF = new AgrNurseryLoanBO();
					hshDFres = agrDF.getDairyTotIncomeExpByAppno(strAppno, strSchemeType, strFacSno);
					arrDFCol = new ArrayList();
					arrCol1 = new ArrayList();
					arrCol1 = (ArrayList)hshDFres.get("arrNetBenefit");
					arrDFCol = new ArrayList();
					arrDFCol.add(strSchemeName);
					int i=0;
					for(i=0;i<arrCol1.size();i++)
					{
						arrDFCol.add(""+Helper.correctNull((String)arrCol1.get(i)));
					}
					for(int j=arrCol1.size();j<15;j++)
					{
						arrDFCol.add(""+Helper.correctNull((String)arrCol1.get(i-1)));
					}
					if(arrDFCol.size()>14)
						arrPHRow.add(arrDFCol);
					else
					{
						arrDFCol = new ArrayList();
						arrDFCol.add(strSchemeName);
						for(int m=0;m<15;m++)
						{
							arrDFCol.add("0");
						}
						arrPHRow.add(arrDFCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aE"))
				{
					HashMap hshDFres = new HashMap();
					AgriLoanAssessmentBean agrPD = new AgriLoanAssessmentBean();
					hshRequestValues.put("strpagefrom", "FarmBudget");
					hshRequestValues.put("strschemetype", strSchemeType);
					hshRequestValues.put("strschemesno", strFacSno);	
					hshDFres = agrPD.getpoultrybroiincomeflowData(hshRequestValues);
					arrPDCol = new ArrayList();
					arrPDCol.add(strSchemeName);
					arrPDCol.add(Helper.correctNull((String)hshDFres.get("surplus1")));
					arrPDCol.add(Helper.correctNull((String)hshDFres.get("surplus2")));
					arrPDCol.add(Helper.correctNull((String)hshDFres.get("surplus3")));
					for(int i=0;i<12;i++)
					{
						arrPDCol.add(Helper.correctNull((String)hshDFres.get("surplus3")));
					}
					if(arrPDCol.size()>14)
						arrPHRow.add(arrPDCol);
					else
					{
						arrPDCol = new ArrayList();
						arrPDCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrPDCol.add("0");
						}
						arrPHRow.add(arrPDCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aJ"))
				{
					HashMap hshFish = new HashMap();
					AgriMechanisedBoatBean agrFish = new AgriMechanisedBoatBean();
					hshRequestValues.put("strpagefrom", "FarmBudget");
					hshRequestValues.put("strSchemeType", strSchemeType);
					hshRequestValues.put("strFacSno", strFacSno);
					hshFish = agrFish.getNetincome(hshRequestValues);
					arrFishCol = new ArrayList();
					arrFishCol.add(strSchemeName);
					arrFishCol.add(Helper.correctNull((String)hshFish.get("netyear1")));
					arrFishCol.add(Helper.correctNull((String)hshFish.get("netyear2")));
					arrFishCol.add(Helper.correctNull((String)hshFish.get("netyear3")));
					arrFishCol.add(Helper.correctNull((String)hshFish.get("netyear4")));
					for(int i=0;i<11;i++)
					{
						arrFishCol.add(Helper.correctNull((String)hshFish.get("netyear4")));
					}
					if(arrFishCol.size()>14)
						arrPHRow.add(arrFishCol);
					else
					{
						arrFishCol = new ArrayList();
						arrFishCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrFishCol.add("0");
						}
						arrPHRow.add(arrFishCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aR"))
				{
					HashMap hshAllied = new HashMap();
					ArrayList arrCol1 = new ArrayList();
					AgrFarmMachineryBO agrallied = new AgrFarmMachineryBO();
					//hshRequestValues.put("strpagefrom", "FarmBudget");
					hshAllied = agrallied.calculateSheepFinancialAnalysis(strAppno, strFacSno, strSchemeType);
					arrCol1 = new ArrayList();
					arrCol1 = (ArrayList)hshAllied.get("arrFBcol");
					arrAlliedCol = new ArrayList();
					arrAlliedCol.add(strSchemeName);
					int i=0;
					if(arrCol1.size()>0)
					{
						for(i=0;i<arrCol1.size();i++)
						{
							arrAlliedCol.add(""+Helper.correctNull((String)arrCol1.get(i)));
						}
						for(int j=arrCol1.size();j<15;j++)
						{
							arrAlliedCol.add(""+Helper.correctNull((String)arrCol1.get(i-1)));
						}
					}
					if(arrAlliedCol.size()>14)
						arrPHRow.add(arrAlliedCol);
					else
					{
						arrAlliedCol = new ArrayList();
						arrAlliedCol.add(strSchemeName);
						for(int m=0;m<15;m++)
						{
							arrAlliedCol.add("0");
						}
						arrPHRow.add(arrAlliedCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aY"))
				{
					int NetInc = 0;
					if(rs2!=null)rs2.close();
					strQuery = SQLParser.getSqlQuery("sel_forestrydetbyappno^"+strAppno+"^"+strSchemeType);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						NetInc = (int)Math.round(Double.parseDouble(Helper.correctDouble((String)rs2.getString("ff_totnetinc"))));
					}
					arrFFCol = new ArrayList();
					arrFFCol.add(strSchemeName);
					for(int i=0;i<15;i++)
					{
						arrFFCol.add(String.valueOf(NetInc));
					}
					if(arrFFCol.size()>14)
						arrPHRow.add(arrFFCol);
					else
					{
						arrFFCol = new ArrayList();
						arrFFCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrFFCol.add("0");
						}
						arrPHRow.add(arrFFCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aI"))
				{
					int NetInc = 0;
					if(rs2!=null)rs2.close();
					strQuery = SQLParser.getSqlQuery("agr_serincomeselect^"+strAppno);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						NetInc = (int)Math.round(Double.parseDouble(Helper.correctDouble((String)rs2.getString("SERI_NETINC"))));
					}
					arrSeriCol = new ArrayList();
					arrSeriCol.add(strSchemeName);
					for(int i=0;i<15;i++)
					{
						arrSeriCol.add(String.valueOf(NetInc));
					}
					if(arrSeriCol.size()>14)
						arrPHRow.add(arrSeriCol);
					else
					{
						arrSeriCol = new ArrayList();
						arrSeriCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrSeriCol.add("0");
						}
						arrPHRow.add(arrSeriCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aM"))
				{
					int NetInc = 0;
					if(rs2!=null)rs2.close();
					strQuery = SQLParser.getSqlQuery("agrincomehireserv_netincome_select^"+strAppno);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						NetInc = (int) Math.round(Double.parseDouble(Helper.correctDouble((String)rs2.getString("agr_ihs_netincome"))));
					}
					arrFMCol = new ArrayList();
					arrFMCol.add(strSchemeName);
					for(int i=0;i<15;i++)
					{
						arrFMCol.add(String.valueOf(NetInc));
					}
					if(arrFMCol.size()>14)
						arrPHRow.add(arrFMCol);
					else
					{
						arrFMCol = new ArrayList();
						arrFMCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrFMCol.add("0");
						}
						arrPHRow.add(arrFMCol);
					}
				}
				else if(strSchemeType.equalsIgnoreCase("aN"))
				{
					int NetInc = 0;
					if(rs2!=null)rs2.close();
					strQuery = SQLParser.getSqlQuery("sel_gobar_netincome^"+strAppno);
					rs2 = DBUtils.executeQuery(strQuery);
					while(rs2.next())
					{
						//NetInc = Integer.parseInt(Helper.correctInt((String)rs2.getString("gg_netannualincome")));
						
						NetInc = (int)Math.round(Double.parseDouble(Helper.correctDouble(rs2.getString("gg_netannualincome"))));
					}
					arrGobarCol = new ArrayList();
					arrGobarCol.add(strSchemeName);
					for(int i=0;i<15;i++)
					{
						arrGobarCol.add(String.valueOf(NetInc));
					}
					if(arrGobarCol.size()>14)
						arrPHRow.add(arrGobarCol);
					else
					{
						arrGobarCol = new ArrayList();
						arrGobarCol.add(strSchemeName);
						for(int i=0;i<15;i++)
						{
							arrGobarCol.add("0");
						}
						arrPHRow.add(arrGobarCol);
					}
				}
			}
			
			hshResult.put("arrPHRow", arrPHRow); //Total Income sending to page 
			
			//To find Net income of Farm Budget
			ArrayList arrFBtotRow = new ArrayList();
			ArrayList arrFBtotCol = new ArrayList();

			if(!strSchemeType.equalsIgnoreCase(""))
			{
				double FBtotvalue=0.00;
				ArrayList arrEcol =new ArrayList();
				ArrayList arrPcol =new ArrayList();
				ArrayList arrOcol =new ArrayList();
				for(int FBtot=0;FBtot<intfacTenor;FBtot++)
				{
					arrEcol = (ArrayList)arrRow.get(FBtot);
					arrPcol = (ArrayList)arrRowP.get(FBtot);
					arrOcol = (ArrayList)arrRowInc.get(FBtot);
					arrFBtotCol = new ArrayList();
					FBtotvalue=0.00;
					if(arrPHCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrPHCol.get(FBtot+1)));
					if(arrDFCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrDFCol.get(FBtot+1)));
					if(arrPDCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrPDCol.get(FBtot+1)));
					if(arrFishCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrFishCol.get(FBtot+1)));
					if(arrAlliedCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrAlliedCol.get(FBtot+1)));
					if(arrFFCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrFFCol.get(FBtot+1)));
					if(arrSeriCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrSeriCol.get(FBtot+1)));
					if(arrFMCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrFMCol.get(FBtot+1)));
					if(arrGobarCol.size()>0)
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrGobarCol.get(FBtot+1)));
					FBtotvalue= FBtotvalue + Double.parseDouble(Helper.correctDouble((String)arrEcol.get(0)))+
												Double.parseDouble(Helper.correctDouble((String)arrPcol.get(0)))+
												Double.parseDouble(Helper.correctDouble((String)arrOcol.get(0)));
					String strTotvalue="";
					strTotvalue = nf.format(FBtotvalue);
					arrFBtotCol.add(strTotvalue);
					arrFBtotRow.add(arrFBtotCol);
				}
				hshResult.put("arrFBtotRow", arrFBtotRow); // Net income of farm budget (to the page)
			}
			
			
			//Update data into the AGR_DSS_ASSESSMENT
			if(!(strCallfrom.equalsIgnoreCase("Processnote")))
			{
				if(arrFBtotRow.size()>0)
				{
					for(int DSS=1;DSS<=intfacTenor;DSS++)
					{
						String strQuery21 = SQLParser.getSqlQuery("sel_dssavailable^"+strAppno+"^"+DSS);
						rs21 = DBUtils.executeQuery(strQuery21);
						if(rs21.next())
						{
							hshQueryValues = new HashMap();
							arrFBtotCol = new ArrayList();
							arrFBtotCol = (ArrayList)arrFBtotRow.get(DSS-1);
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "update_farmbudgetDSS");
							arrValues.add(Helper.correctNull((String)arrFBtotCol.get(0)));
							arrValues.add(strAppno);
							arrValues.add(String.valueOf(DSS));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
						else
						{
							hshQueryValues = new HashMap();
							arrFBtotCol = new ArrayList();
							arrFBtotCol = (ArrayList)arrFBtotRow.get(DSS-1);
							hshQuery = new HashMap();
							arrValues = new ArrayList();
							hshQuery.put("strQueryId", "ins_agr_dssAssessment");
							arrValues.add(strAppno);
							arrValues.add(Helper.correctNull((String)arrFBtotCol.get(0)));
							arrValues.add(String.valueOf(DSS));
							hshQuery.put("arrValues", arrValues);
							hshQueryValues.put("1", hshQuery);
							hshQueryValues.put("size", "1");
							EJBInvoker.executeStateLess("dataaccess", hshQueryValues, "updateData");
						}
					}
				}
			}
				
			
			/** END **/
			
	/*		strQuery1 = SQLParser.getSqlQuery("sel_maxfarmbudget^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				intYearSno = Integer.parseInt(Helper.correctInt((String)rs1.getString("noofyrs")));
			}
			if(intYearSno!=0)
			{
				for(int i=1;i<=intYearSno;i++)
				{
					strQuery=SQLParser.getSqlQuery("sel_farmbudgetdata^"+strAppno+"^"+i);
					rs = DBUtils.executeQuery(strQuery);
					if(rs.next())
					{
						arrCol = new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("FIN_APPNO")));//0
						arrCol.add(Helper.correctNull((String)rs.getString("FIN_FROMDATE"))+" to "+Helper.correctNull((String)rs.getString("FIN_TODATE")));//1
						dblGrsInc = Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_TOTALINC")));
						dblExpens = Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_TOTCOSTOFCULT")));
						dblNetInc = dblNetInc + Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_SURPLUS")));
						while(rs.next())
						{
							dblGrsInc = dblGrsInc + Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_TOTALINC")));
							dblExpens = dblExpens + Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_TOTCOSTOFCULT")));
							dblNetInc = dblNetInc + Double.parseDouble(Helper.correctDouble((String)rs.getString("AGR_CRP_SURPLUS")));
						}
						arrCol.add(String.valueOf(dblGrsInc));//2
						arrCol.add(String.valueOf(dblExpens));//3
						arrRow.add(arrCol);
					}
				}
			}
		*/
			hshResult.put("arrRow",arrRow);
			hshResult.put("arrRowP",arrRowP);
			hshResult.put("arrRowTot",arrRowTot);
			hshResult.put("arrRowInc",arrRowInc);
			hshResult.put("arrRowFac",arrRowFac);
			hshResult.put("facTenor",Integer.toString((int) dbfacTenor));
			
			if(rs!=null)
			{
				rs.close();
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			if(rs21!=null)
			{
				rs21.close();
			}
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getFarmBudget==>"+e.toString());
		}
		return hshResult;
	}
	
	public HashMap getCropLoan(HashMap hshRequestValues) 
	{
		String strQuery=null;
		ResultSet rs=null;
		ResultSet rs1=null;
		ArrayList arrRow = null;
		ArrayList arrData= new ArrayList();
		String serialNo=null;
		String strMeastype="";
		HashMap hshRecord=new HashMap();
		String strtenor="",strAssessmentType="";
		double total=0.00;
		try
		{
			 String appno=Helper.correctNull((String)hshRequestValues.get("appno"));
			 strQuery = SQLParser.getSqlQuery("agrcropassessment_select_display^"+appno+"^"+"aQ");
			 rs = DBUtils.executeQuery(strQuery);
		     while(rs.next())
		     {	 
				 strMeastype=Helper.correctNull(rs.getString("agr_measurementtype"));
				 arrRow = new ArrayList();
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sno")));//0
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_season")));//1 
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_crop")));//2
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_sowmon")));//3
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_harvmon")));//4
				 if(strMeastype.equals("2"))
				 {
				   arrRow.add(Helper.correctDouble(rs.getString("agr_cas_areacul")));//5
				 }else
				 {
				   arrRow.add("0");
				 }
				 total+=Double.parseDouble(Helper.correctDouble(rs.getString("agr_cas_eligibility")));
				 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_amount")));//6
				 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_eligibility")));//7
				 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limapplied")));//8
				 arrRow.add(Helper.correctDouble(rs.getString("agr_cas_limitrecom")));//9
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_duedate")));//10
				 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_COSTOFCULTIVATION")));//11
				 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_STATE")));//12
				 arrRow.add(Helper.correctNull(rs.getString("AGR_CAS_DISTRICT")));//13
				 arrRow.add(Helper.correctNull(rs.getString("agr_cas_plantname")));//14		
				 if(strMeastype.equals("1")||!Helper.correctNull(rs.getString("agr_cas_assessmenttype")).equalsIgnoreCase("130"))
				 {
				   arrRow.add(Helper.correctNull(rs.getString("agr_noofplants")));//15
				 }else{
				   arrRow.add("0");
				 }
				 arrRow.add(strMeastype);//16
				 arrRow.add(Helper.correctNull(rs.getString("AGR_SCLOFFIN")));//17
				 strAssessmentType=Helper.correctNull(rs.getString("agr_cas_assessmenttype"));
				 serialNo=Helper.correctNull(rs.getString("agr_cas_plantname"));//
				 if(rs1!=null){rs1.close();}
				 arrData.add(arrRow);	
		     }
		     if(rs!=null){rs.close();}
		     strQuery = SQLParser.getSqlQuery("sel_appstatus^"+appno);
	         rs = DBUtils.executeQuery(strQuery);
		     String app_status="";
		     if(rs.next())
		     {
			     app_status=Helper.correctNull(rs.getString("app_status"));
		     }
			 ArrayList arrCropMasterValue=new ArrayList();
			 ArrayList arrCropCapsule=new ArrayList();
			 ArrayList arrMasterValues=new ArrayList();
		     int entry_list=0;
		     if(app_status.equals("op"))
		     {
				 strQuery = SQLParser.getSqlQuery("sel_corploanMaster");
				 rs = DBUtils.executeQuery(strQuery);
				 while(rs.next())
				 {
					entry_list=1;
				 	arrCropMasterValue=new ArrayList();
					arrCropMasterValue.add(Helper.correctNull(rs.getString("corploan_id")));
					arrCropMasterValue.add(Helper.correctNull(rs.getString("corploan_percentage")));
					arrMasterValues.add(Helper.correctNull(rs.getString("corploan_percentage")));
					arrCropCapsule.add(arrCropMasterValue);
				 }
		     }
		     else
		     {
				 strQuery = SQLParser.getSqlQuery("sel_comcropLoan^"+appno);
				 rs = DBUtils.executeQuery(strQuery);			
				 while(rs.next())
				 {
					entry_list=1;				
					arrMasterValues.add(Helper.correctNull(rs.getString("PERCENTAGE")));				
				 }
			 }
			 hshRecord.put("MastEntryList", Integer.toString(entry_list));
			 hshRecord.put("arrMaster", arrCropCapsule);
			 hshRecord.put("arrMasterValues", arrMasterValues);
			 hshRecord.put("strAssessType", strAssessmentType);
			 hshRecord.put("cropassestotal", String.valueOf(total));
			 strQuery = SQLParser.getSqlQuery("sel_KCCmaxtenor^"+appno);
			 rs = DBUtils.executeQuery(strQuery);
			 if(rs.next())
			 {
				  strtenor=Helper.correctNull((String)rs.getString("FACILITY_MONTHS"));
			 }
			 hshRecord.put("strtenor", strtenor);			
			 if(rs!=null){rs.close();}
			 strQuery = SQLParser.getSqlQuery("sel_KCCmaxtenor^"+appno);
			 rs = DBUtils.executeQuery(strQuery);
			 if(rs.next())
			 {
				strtenor=Helper.correctNull((String)rs.getString("FACILITY_MONTHS"));
			 }	
			 
			 if(rs!=null){rs.close();}
			 strQuery = SQLParser.getSqlQuery("select_croploan_details^"+appno);
			 rs = DBUtils.executeQuery(strQuery);
			 while(rs.next())
			 {
				 String flagVal = Helper.correctNull((String)rs.getString("CL_FLAG"));
				 hshRecord.put("recommval"+flagVal, Helper.correctDouble((String)rs.getString("CL_RECOM_AMT")));
				 hshRecord.put("sancval"+flagVal, Helper.correctDouble((String)rs.getString("CL_SANC_AMT")));				
				 hshRecord.put("pcsval"+flagVal, Helper.correctDouble((String)rs.getString("CL_PCS_AMT")));
				 hshRecord.put("jgsud"+flagVal, Helper.correctDouble((String)rs.getString("CL_JGSUD_AMT")));
			 }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		hshRecord.put("arrData", arrData);
		return hshRecord;
	}
	
	
	public HashMap getDSS(HashMap hshRequestValues) 
	{
		HashMap hshResult = new HashMap();
		String strQuery="",strQuery1="",strQuery2="";
		ResultSet rs=null,rs1=null,rs2=null,rs3=null;
		ArrayList arrRow= new ArrayList();
		ArrayList arrCol= null;
		String strAppno="",strScheme="",strApplicantid="",strPerappid="0";
		int intYearSno=0;
		ArrayList arrBankRow=new ArrayList();
		ArrayList arrBankCol=new ArrayList();
		ArrayList arrOthBankRow=new ArrayList();
		ArrayList arrOthBankCol=new ArrayList();
		ArrayList arrBankPropRow=new ArrayList();
		ArrayList arrBankPropCol=new ArrayList();
		ArrayList arrBankPropEmiDataRow=new ArrayList();
		ArrayList arrBankPropEmiDataCol=new ArrayList();
		ArrayList arrBankExisEmiDataRow=new ArrayList();
		ArrayList arrBankExisEmiDataCol=new ArrayList();
		ArrayList arrOthBankExisDataRow=new ArrayList();
		ArrayList arrOthBankExisDataCol=new ArrayList();
		java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
    	nft= java.text.NumberFormat.getInstance();
    	nft.setMaximumFractionDigits(2);
    	nft.setMinimumFractionDigits(2);
		ComRepayScheduleBean FacRepayment=new ComRepayScheduleBean();
		String strValuesin="";
		double dblNetInc =0.00,dblGrsInc=0.00,dblExpens=0.00,dblSancLimit=0.00,dblIntRate=0.00,dblDrwPow=0.00,dblCropLimit=0.00;
		double	dblOtherincome=0.00,dblNetincome=0.00,dblExtinstalment=0.00,dblExtintrest =0.00,dblProinstalment=0.00,dblProintrest=0.0,dblTotcommitment=0.00;
		String ModuleType=Helper.correctNull((String)hshRequestValues.get("sessionModuleType"));
		double tenor=0.00,dblPreviousVal=0.00;
		String strPrintPage=Helper.correctNull((String)hshRequestValues.get("strPrintFlag"));
		try
		{
			strAppno = Helper.correctNull((String)hshRequestValues.get("appno"));
			strApplicantid=Helper.correctNull((String)hshRequestValues.get("hidapplicantid"));
			strValuesin=Helper.correctNull((String)hshRequestValues.get("valuesin"));
			
			if(strApplicantid.equalsIgnoreCase(""))
			{
				strApplicantid=Helper.correctNull((String)hshRequestValues.get("hidBorrowerType"));
			}
			strQuery1 = SQLParser.getSqlQuery("sel_tenorforfinyear^"+strAppno);
			rs1 = DBUtils.executeQuery(strQuery1);
			if(rs1.next())
			{
				tenor = Double.parseDouble(Helper.correctInt((String)rs1.getString("facility_months")));
				tenor = Math.ceil(tenor/12);
				intYearSno = (int)Math.round(tenor);
			}
			if(ModuleType.equalsIgnoreCase("RET")){
				String StrQuery11 = SQLParser.getSqlQuery("selloanrecmtamntloanddet^"+strAppno);
				ResultSet rs11 = DBUtils.executeQuery(StrQuery11);
				if(rs11.next()){
					tenor = Double.parseDouble(Helper.correctDouble((String)rs11.getString("loan_reqterms")));
					tenor = Math.ceil(tenor/12);
					intYearSno = (int)Math.round(tenor);
			}
			}
			/** Added by : vinoth kumar.D
			 *  Date     : 16/08/2014
			 *  Reason   : Delete the agr_dssassessment table values if the repayment tenors in loan details changed.			 
			 */
			
			if(rs3!=null) rs3.close();
			String StrQuery11 = SQLParser.getSqlQuery("selectMaxPeriod_DSS^"+strAppno);
			rs3 = DBUtils.executeQuery(StrQuery11);
			if(rs3.next())
			{
				dblPreviousVal = Double.parseDouble(Helper.correctDouble((String)rs3.getString("PreviousValue")));
			}
			if(rs3!=null) rs3.close();
			
			if(dblPreviousVal!=0 && dblPreviousVal<tenor)
			{
				HashMap hshQueryValues = new HashMap();
				HashMap hshQuery       = new HashMap();				
				ArrayList arrValues    = new ArrayList();															
				hshQuery.put("strQueryId","delete_DSS_values");
				arrValues.add(strAppno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);	
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");					
			}
			boolean bflag=true;
			/** End Here ... */
			if(intYearSno!=0)
			{
				for(int i=1;i<=intYearSno;i++)
				{
					if(bflag)
					{
						if(rs3 !=null){
							rs3.close();
						}
						strQuery2=SQLParser.getSqlQuery("agr_dssassessment_select^"+strAppno+"^"+i);
						rs3 = DBUtils.executeQuery(strQuery2);
						if(!rs3.next())
						{
							bflag=false;
							getFarmBudget(hshRequestValues);
						}
					}
						arrCol = new ArrayList();
						arrCol.add(strAppno);//0
						arrCol.add("");//1			
						arrCol.add("0.00");//2
						arrCol.add("0.00");//3
						arrCol.add(String.valueOf(i));//4
						if(rs3 !=null){
							rs3.close();
						}
						strQuery2=SQLParser.getSqlQuery("agr_dssassessment_select^"+strAppno+"^"+i);
						rs3 = DBUtils.executeQuery(strQuery2);
						if(rs3.next())
						{
						dblOtherincome =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_otherincome")));
						dblNetincome =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_netincome")));
						dblExtinstalment =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_extinstalment")));
						dblExtintrest =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_extintrest")));
						dblProinstalment =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_proinstalment")));
						dblProintrest =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_prointrest")));
						dblTotcommitment =Double.parseDouble(Helper.correctDouble((String)rs3.getString("agr_dss_totcommitment")));						
							
						}
						arrCol.add(String.valueOf(dblOtherincome));//5
						arrCol.add(String.valueOf(dblNetincome));//6
						arrCol.add(String.valueOf(dblExtinstalment));//7
						arrCol.add(String.valueOf(dblExtintrest));//8
						arrCol.add(String.valueOf(dblProinstalment));//9
						arrCol.add(String.valueOf(dblProintrest));//10
						arrCol.add(String.valueOf(dblTotcommitment));//11
						arrRow.add(arrCol);
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("selExisLoanAssesmentDss^"+strAppno+"^"+i);
					while(rs.next())
					{
						int infacSno=Integer.parseInt(Helper.correctInt((String)rs.getString("AGR_DSS_FACSNO")));
						hshResult.put("txt_existinginstallment"+i+""+infacSno, Helper.correctNull((String)rs.getString("agr_dss_extinstalment")));
						hshResult.put("txt_existinginterest"+i+""+infacSno, Helper.correctNull((String)rs.getString("agr_dss_extintrest")));						
						
					}
					if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("selPropLoanAssesmentDss^"+strAppno+"^"+i);
					while(rs.next())
					{
						int infacSno=Integer.parseInt(Helper.correctInt((String)rs.getString("AGR_DSS_FACSNO")));
						hshResult.put("txt_proposedinstallment"+i+""+infacSno, Helper.correctNull((String)rs.getString("agr_dss_proinstalment")));
						hshResult.put("txt_proposedinterest"+i+""+infacSno, Helper.correctNull((String)rs.getString("agr_dss_prointrest")));						
					}
									
				}
			}
			hshResult.put("arrRow",arrRow);
			hshResult.put("netincome",String.valueOf(dblNetInc));
			hshResult.put("strintYearSno",String.valueOf(intYearSno));
			
			
			strQuery1 = SQLParser.getSqlQuery("agr_dssaveragenetsurplus_select^"+strAppno);
			rs2 = DBUtils.executeQuery(strQuery1);
			if(rs2.next())
			{
				double dblavgNetSurplus = Double.parseDouble(Helper.correctDouble((String)rs2.getString("AGR_AVG_NETSURPLUS")));
				hshResult.put("dblavgNetSurplus",String.valueOf(dblavgNetSurplus));
			}
			if(rs!=null)
			{
				rs.close();
			}
			if(rs1!=null)
			{
				rs1.close();
			}
			//Existing loan description alone
			ArrayList ArrExiLoantype=new ArrayList();
			int Count=0;
			String strLoantype="",strRepaytype="";
			strQuery = SQLParser.getSqlQuery("sel_combankingDSSdata^"+strAppno);
			if(rs!=null)
			{
				rs.close();
			}
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
			arrBankCol=new ArrayList();
			strRepaytype=Helper.correctNull((String)rs.getString("COMBK_REPAYMENTTYPE"));
			String strFacility=Helper.correctNull((String)rs.getString("combk_facility"));
			String strcombk_modtype="",str_Loantype="";
			strcombk_modtype=Helper.correctNull((String)rs.getString("combk_modtype"));
			String[] strFacilityArr=strFacility.split("~");
			
			if(strFacilityArr.length>0)
				{
					if(strcombk_modtype.equalsIgnoreCase("p") || strcombk_modtype.equalsIgnoreCase("r"))
					{
						strQuery1=SQLParser.getSqlQuery("sel_retProductDesc1^"+strFacilityArr[0]);
						rs1 = DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							strLoantype=Helper.correctNull(rs1.getString("PRD_LOANTYPE"));
							if(strLoantype.equalsIgnoreCase("TL") || strLoantype.equalsIgnoreCase("DL") || strLoantype.equalsIgnoreCase("OD"))
							{
								if(strLoantype.equalsIgnoreCase("DL"))
								{
									strLoantype="TL";
								}
								arrBankCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
								arrBankCol.add(strRepaytype);
								arrBankCol.add(strLoantype);
								arrBankCol.add(Helper.correctNull(rs1.getString("PRD_TYPE")));
								ArrExiLoantype.add(strLoantype);
								ArrExiLoantype.add(Helper.correctNull(rs1.getString("PRD_TYPE")));
								arrBankRow.add(arrBankCol);
								Count++;
							}
						}
					}
					else if(strcombk_modtype.equalsIgnoreCase("c"))
					{
						strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^c");
						rs1 = DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							str_Loantype=Helper.correctNull(rs1.getString("com_facility_loantype"));
							if(str_Loantype.equalsIgnoreCase("DL"))
							{
								str_Loantype="TL";
							}
							if(str_Loantype.equalsIgnoreCase("TL") || str_Loantype.equalsIgnoreCase("OD"))
							{
								arrBankCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
								arrBankCol.add(strRepaytype);
								arrBankCol.add(str_Loantype);
								arrBankCol.add(Helper.correctNull(rs1.getString("COM_AGRSCHEMETYPE")));
								ArrExiLoantype.add(str_Loantype);
								ArrExiLoantype.add(Helper.correctNull(rs1.getString("COM_AGRSCHEMETYPE")));
								arrBankRow.add(arrBankCol);
								Count++;
							}
						}
					}
					else if(strcombk_modtype.equalsIgnoreCase("a"))
					{
						strQuery1=SQLParser.getSqlQuery("sel_FacilityCorpDesc^"+strFacilityArr[0]+"^a");
						rs1 = DBUtils.executeQuery(strQuery1);
						if(rs1.next())
						{
							str_Loantype=Helper.correctNull(rs1.getString("com_facility_loantype"));
							if(str_Loantype.equalsIgnoreCase("DL"))
							{
								str_Loantype="TL";
							}
							if(str_Loantype.equalsIgnoreCase("TL") || str_Loantype.equalsIgnoreCase("OD"))
							{
								arrBankCol.add(Helper.correctNull(rs1.getString("com_facdesc")));//18
								arrBankCol.add(strRepaytype);
								arrBankCol.add(str_Loantype);
								arrBankCol.add(Helper.correctNull(rs1.getString("COM_AGRSCHEMETYPE")));
								ArrExiLoantype.add(str_Loantype);
								ArrExiLoantype.add(Helper.correctNull(rs1.getString("COM_AGRSCHEMETYPE")));
								arrBankRow.add(arrBankCol);
								Count++;
							}
						}
					}				
				}
			}
			hshResult.put("arrBankRow", arrBankRow);
			//End
			//Selecting Existing loan data for all
			strLoantype="";
			strRepaytype="";
			double dblEMI=0.00,dblFacilityamt=0.00,dblInterestrate=0.00,dblTemp=0.00,dblEMI1=0.00;
			int k=0,hshCount=0,intDuedays=0,intYear=0;
			double intTenor=0.00;
			String strFacility_sno="";
			Count=0;
			boolean bolFlag=true; 

			for(int i=0;i<=intYearSno;i++)
			{	
				
				strQuery = SQLParser.getSqlQuery("sel_agrExiassesmentdetails^"+strAppno+"^"+"E"+"^"+(i+1));
				if(rs!=null)
				{
					rs.close();
				}
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrBankExisEmiDataRow=new ArrayList();
					arrBankExisEmiDataCol=new ArrayList();
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_EXTINSTALMENT")));
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("agr_dss_extintrest")));
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_LOANTYPE")));
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_EMITYPE")));
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INTAMT"))); 
					arrBankExisEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INITINT")));
					arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
					hshResult.put("arrBankExisEmiDataRow"+i+hshCount, arrBankExisEmiDataRow);
					hshCount++;
					bolFlag=false;
				}
				if(bolFlag)
				{
					strQuery = SQLParser.getSqlQuery("sel_combankingDSSdata^"+strAppno);
					if(rs!=null)
					{
						rs.close();
					}
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strRepaytype=Helper.correctNull((String)rs.getString("COMBK_REPAYMENTTYPE"));
						dblInterestrate=Double.parseDouble(Helper.correctDouble((String)rs.getString("COMBK_INTERESTRATE")));
						strRepaytype=Helper.correctNull((String)rs.getString("COMBK_REPAYMENTTYPE"));
						dblSancLimit = Double.parseDouble(Helper.correctDouble((String)rs.getString("COMBK_LIMIT")));
						dblDrwPow = Double.parseDouble(Helper.correctDouble((String)rs.getString("COMBK_DRAWINGPOWER")));
						
						intDuedays=Integer.parseInt(Helper.correctInt((String)rs.getString("Days")));
						if(intDuedays<=365)
						{
							intYear=1;
						}else
						{
							intTenor=Math.ceil(intDuedays/365);
							intYear=(int)Math.round(intTenor);
						}
						strLoantype=Helper.correctNull((String)ArrExiLoantype.get(Count));
						Count++;
						strScheme=Helper.correctNull((String)ArrExiLoantype.get(Count));
						Count++;
						if(strLoantype.equalsIgnoreCase("TL") && strRepaytype.equalsIgnoreCase("E"))
						{
							if(intYear>=(i+1))
							{
									dblEMI1=Double.parseDouble(Helper.correctDouble((String)rs.getString("COMBK_MONTHLY_INS")));
									dblEMI=dblEMI1*12;
									arrBankExisEmiDataRow=new ArrayList();
									arrBankExisEmiDataCol=new ArrayList();
									arrBankExisEmiDataCol.add(String.valueOf(dblEMI));
									arrBankExisEmiDataCol.add(dblInterestrate);
									arrBankExisEmiDataCol.add(strLoantype);
									arrBankExisEmiDataCol.add(strRepaytype);
									arrBankExisEmiDataCol.add("0.00");
									arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}
							else
							{
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add(strLoantype);
								arrBankExisEmiDataCol.add(strRepaytype);
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}
									hshResult.put("arrBankExisEmiDataRow"+i+hshCount, arrBankExisEmiDataRow);
									hshCount++;
									
						}else if(strLoantype.equalsIgnoreCase("TL") && (!strRepaytype.equalsIgnoreCase("E")) && (!strRepaytype.equalsIgnoreCase("")))
						{
							dblFacilityamt=Double.parseDouble(Helper.correctDouble((String)rs.getString("COMBK_OS")));
							if(intYear>=(i+1))
							{
								
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add("0.00");//0
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add(strLoantype);//2
								arrBankExisEmiDataCol.add(strRepaytype);
								arrBankExisEmiDataCol.add(dblFacilityamt);//5
								arrBankExisEmiDataCol.add(dblInterestrate);
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}else
							{
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add(strLoantype);
								arrBankExisEmiDataCol.add(strRepaytype);
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}	
								hshResult.put("arrBankExisEmiDataRow"+i+hshCount, arrBankExisEmiDataRow);
								hshCount++;
						}
						else if(strLoantype.equalsIgnoreCase("OD") && (!strScheme.equalsIgnoreCase("aQ")))
						{
							if(intYear>=(i+1))
							{	
								dblSancLimit=(dblSancLimit*dblInterestrate)/100;
								
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add(String.valueOf(dblSancLimit));//0
								arrBankExisEmiDataCol.add(String.valueOf(dblSancLimit));
								arrBankExisEmiDataCol.add(strLoantype);//2
								arrBankExisEmiDataCol.add(strScheme);
								arrBankExisEmiDataCol.add("0.00");//5
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}else
							{
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add("0.00");//0
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add(strLoantype);//2
								arrBankExisEmiDataCol.add(strScheme);
								arrBankExisEmiDataCol.add("0.00");//5
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}
							hshResult.put("arrBankExisEmiDataRow"+i+hshCount, arrBankExisEmiDataRow);
							hshCount++;
						}
						else if(strLoantype.equalsIgnoreCase("OD") && strScheme.equalsIgnoreCase("aQ"))
						{
							if(intYear>=(i+1))
							{
								dblEMI=0.00;
								if(k==0)
								{
									dblEMI=(dblDrwPow*dblInterestrate)/100;
									dblTemp=dblDrwPow;
									k++;
								}
								else
								{
									dblTemp=dblTemp+(dblTemp*0.10);
									dblEMI=(dblTemp*dblInterestrate)/100;
								}
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add(String.valueOf(dblEMI));//0
								arrBankExisEmiDataCol.add(String.valueOf(dblEMI));
								arrBankExisEmiDataCol.add(strLoantype);//2
								arrBankExisEmiDataCol.add(strScheme);
								arrBankExisEmiDataCol.add("0.00");//5
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);
							}
							else
							{
								arrBankExisEmiDataRow=new ArrayList();
								arrBankExisEmiDataCol=new ArrayList();
								arrBankExisEmiDataCol.add("0.00");//0
								arrBankExisEmiDataCol.add("0.00");
								arrBankExisEmiDataCol.add(strLoantype);//2
								arrBankExisEmiDataCol.add(strScheme);
								arrBankExisEmiDataCol.add("0.00");//5
								arrBankExisEmiDataRow.add(arrBankExisEmiDataCol);	
							}
							hshResult.put("arrBankExisEmiDataRow"+i+hshCount, arrBankExisEmiDataRow);
							hshCount++;
						}
					}
					Count=0;
				}
				hshCount=0;
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			//Proposed loan description
			int intPropsize=0;
			strQuery = SQLParser.getSqlQuery("selproposedfacdesc^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strLoantype=Helper.correctNull((String)rs.getString("COM_FACILITY_LOANTYPE"));
				strScheme=Helper.correctNull((String)rs.getString("COM_AGRSCHEMETYPE"));
				strRepaytype=Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE"));
				//for termloan
				if(strLoantype.equalsIgnoreCase("TL") && strRepaytype.equalsIgnoreCase("E"))
				{
					arrBankPropCol=new ArrayList();
					if(strPrintPage.equalsIgnoreCase("Y"))
						arrBankPropCol.add(Helper.correctNull(rs.getString("facdisplaydesc")));
					else
						arrBankPropCol.add(Helper.correctNull(rs.getString("com_facdesc")));
						arrBankPropCol.add(strLoantype);
						arrBankPropCol.add(strRepaytype);
						arrBankPropRow.add(arrBankPropCol);
					intPropsize++;
				}
				if(strLoantype.equalsIgnoreCase("TL") && (!strRepaytype.equalsIgnoreCase("E")) && (!strRepaytype.equalsIgnoreCase("")))
				{
					arrBankPropCol=new ArrayList();
					if(strPrintPage.equalsIgnoreCase("Y"))
					arrBankPropCol.add(Helper.correctNull(rs.getString("facdisplaydesc")));
					else
					arrBankPropCol.add(Helper.correctNull(rs.getString("com_facdesc")));
					arrBankPropCol.add(strLoantype);
					arrBankPropCol.add(strRepaytype);
					arrBankPropRow.add(arrBankPropCol);
					intPropsize++;
				}
				if(strLoantype.equalsIgnoreCase("OD") && !strScheme.equalsIgnoreCase("aQ"))
				{
					arrBankPropCol=new ArrayList();
					if(strPrintPage.equalsIgnoreCase("Y"))
					arrBankPropCol.add(Helper.correctNull(rs.getString("facdisplaydesc")));
					else
					arrBankPropCol.add(Helper.correctNull(rs.getString("com_facdesc")));
					arrBankPropCol.add(strLoantype);
					arrBankPropCol.add(strScheme);
					arrBankPropRow.add(arrBankPropCol);
					intPropsize++;
				}
				if(strLoantype.equalsIgnoreCase("OD") && strScheme.equalsIgnoreCase("aQ"))
				{
					arrBankPropCol=new ArrayList();
					if(strPrintPage.equalsIgnoreCase("Y"))
					arrBankPropCol.add(Helper.correctNull(rs.getString("facdisplaydesc")));
					else
					arrBankPropCol.add(Helper.correctNull(rs.getString("com_facdesc")));
					arrBankPropCol.add(strLoantype);
					arrBankPropCol.add(strScheme);
					arrBankPropRow.add(arrBankPropCol);
					intPropsize++;
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			hshResult.put("arrBankPropRow", arrBankPropRow);
			//End
			int strHoildayperiod=0;
			String strInterest="";
			 strLoantype="";
			 strRepaytype="";
			 dblEMI=0.00;
			 dblFacilityamt=0.00;
			 dblInterestrate=0.00;
			 dblTemp=0.00;
			 dblEMI1=0.00;
			 k=0;
			 hshCount=0;
			 intTenor=0.00;
			 strFacility_sno="";
			 bolFlag=true;
			//For Proposed termloan both EMI & NON EMI
			for(int i=0;i<=intYearSno;i++)
			{	
				
				strQuery = SQLParser.getSqlQuery("sel_agrExiassesmentdetails^"+strAppno+"^"+"P"+"^"+(i+1));
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrBankPropEmiDataRow=new ArrayList();
					arrBankPropEmiDataCol=new ArrayList();
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_PROINSTALMENT")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_PROINTREST")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_LOANTYPE")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_EMITYPE")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INTAMT")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INITINT")));
					arrBankPropEmiDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INTERESTTYPE")));
					arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
					hshResult.put("arrBankPropEmiDataRow"+i+hshCount, arrBankPropEmiDataRow);
					hshCount++;
					bolFlag=false;
				}
				if(bolFlag)
				{
				
					strQuery = SQLParser.getSqlQuery("selproposedfacdesc^"+strAppno);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strRepaytype=Helper.correctNull((String)rs.getString("FACILITY_REPAYTYPE"));
						dblFacilityamt=Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCAMT")));
						dblInterestrate=Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_SANCINTEREST")));
						intTenor=Integer.parseInt(Helper.correctInt((String)rs.getString("FACILITY_MONTHS")));
						intTenor=Math.ceil(intTenor/12);
						intTenor=(int)Math.round(intTenor);
						strFacility_sno=Helper.correctInt((String)rs.getString("FACILITY_SNO"));
						strLoantype=Helper.correctNull((String)rs.getString("COM_FACILITY_LOANTYPE"));
						strScheme=Helper.correctNull((String)rs.getString("COM_AGRSCHEMETYPE")); 
						dblSancLimit = Double.parseDouble(Helper.correctDouble((String)rs.getString("FACILITY_PROPOSED")));
						strHoildayperiod=Integer.parseInt(Helper.correctInt((String)rs.getString("FACILITY_HOLIDAYPERIOD")));
						strInterest=Helper.correctNull((String)rs.getString("FACILITY_INTERESTREC"));
						if(strLoantype.equalsIgnoreCase("TL") && strRepaytype.equalsIgnoreCase("E"))
						{
							if(intTenor>=(i+1))
							{
									/*strQuery1 = SQLParser.getSqlQuery("sel_repayprinciple^"+strAppno+"^"+strFacility_sno);
									if(rs1!=null)
									{
										rs1.close();
									}
									dblEMI1=0.00;
									rs1 = DBUtils.executeQuery(strQuery1);
									if(rs1.next())
									{
										dblEMI1=Double.parseDouble(Helper.correctDouble((String)rs1.getString("REPAY_PRINCIPLE")));
									}*/
								
								//For Taking Priciple value in repayment schedule page
									//hshRequestValues=new HashMap();
									hshRequestValues.put("appno", strAppno);
									hshRequestValues.put("selfacility", strFacility_sno);
									hshRequestValues.put("valuesin", strValuesin);
									hshRequestValues=	FacRepayment.getFacRepayment(hshRequestValues);
									dblEMI1=Double.parseDouble(Helper.correctDouble((String)hshRequestValues.get("prin")));
									dblEMI1=Double.parseDouble(Helper.convertSetupToApplicationValues(strValuesin,dblEMI1));
									
									dblEMI=dblEMI1*12;
									arrBankPropEmiDataRow=new ArrayList();
									arrBankPropEmiDataCol=new ArrayList();
									arrBankPropEmiDataCol.add(String.valueOf(dblEMI));
									arrBankPropEmiDataCol.add("0.00");
									arrBankPropEmiDataCol.add(strLoantype);
									arrBankPropEmiDataCol.add(strRepaytype);
									arrBankPropEmiDataCol.add("0.00");
									arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
							}
							else
							{
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strRepaytype);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
							}
									hshResult.put("arrBankPropEmiDataRow"+i+hshCount, arrBankPropEmiDataRow);
									hshCount++;
									
						}else if(strLoantype.equalsIgnoreCase("TL") && (!strRepaytype.equalsIgnoreCase("E")) && (!strRepaytype.equalsIgnoreCase("")))
						{
							if(intTenor>=(i+1))
							{
								int holidayyear=0;
								double EInterest=0.00;
								if(strInterest.equalsIgnoreCase("Y"))
								{
									holidayyear=(int)(Math.ceil(strHoildayperiod/12));
									holidayyear=(int)Math.round(holidayyear);
									EInterest = (dblFacilityamt*dblInterestrate)/100;
									if(holidayyear>=(i+1))
									{
										arrBankPropEmiDataCol=new ArrayList();
										arrBankPropEmiDataRow=new ArrayList();
										arrBankPropEmiDataCol.add("0.00");
										arrBankPropEmiDataCol.add(String.valueOf(EInterest));
										arrBankPropEmiDataCol.add(strLoantype);
										arrBankPropEmiDataCol.add(strRepaytype);
										arrBankPropEmiDataCol.add(dblFacilityamt);
										arrBankPropEmiDataCol.add(dblInterestrate);
										arrBankPropEmiDataCol.add("H");
										arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
									}
									else
									{
										arrBankPropEmiDataCol=new ArrayList();
										arrBankPropEmiDataRow=new ArrayList();
										arrBankPropEmiDataCol.add("0.00");
										arrBankPropEmiDataCol.add("0.00");
										arrBankPropEmiDataCol.add(strLoantype);
										arrBankPropEmiDataCol.add(strRepaytype);
										arrBankPropEmiDataCol.add(dblFacilityamt);
										arrBankPropEmiDataCol.add(dblInterestrate);
										arrBankPropEmiDataCol.add("I");
										arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);	
									}
								}
								else
								{
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strRepaytype);
								arrBankPropEmiDataCol.add(dblFacilityamt);
								arrBankPropEmiDataCol.add(dblInterestrate);
								arrBankPropEmiDataCol.add("I");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
								}
							}else
							{
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strRepaytype);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(dblInterestrate);
								arrBankPropEmiDataCol.add("I");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
							}	
								hshResult.put("arrBankPropEmiDataRow"+i+hshCount, arrBankPropEmiDataRow);
								hshCount++;
						}
						else if( (strLoantype.equalsIgnoreCase("OD")) && (!strScheme.equalsIgnoreCase("aQ")))
						{
							if(intTenor>=(i+1))
							{
								dblSancLimit=(dblSancLimit*dblInterestrate)/100;
								
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add(String.valueOf(dblSancLimit));
								arrBankPropEmiDataCol.add(String.valueOf(dblSancLimit));
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strScheme);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
							}else
							{
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strScheme);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);	
							}
							
								hshResult.put("arrBankPropEmiDataRow"+i+hshCount, arrBankPropEmiDataRow);
								hshCount++;
						}
						else if(strLoantype.equalsIgnoreCase("OD") && strScheme.equalsIgnoreCase("aQ"))
						{
							if(intTenor>=(i+1))
							{
								String strCropFlag="N";
								double dblEligibleAmt=0;
								
								//Other than crop Subvention
								if(rs2!=null)
									rs2.close();
								strQuery=SQLParser.getSqlQuery("agrcropassessment_select_display^"+strAppno+"^aQ");
								rs2=DBUtils.executeQuery(strQuery);
								while(rs2.next())
								{
									if(Helper.correctNull(rs2.getString("agr_cas_assessmenttype")).equalsIgnoreCase("130"))
										strCropFlag="Y";
									dblEligibleAmt+=Double.parseDouble(rs2.getString("agr_cas_limitrecom"));
								}
								
								dblEMI=0.00;
								if(strCropFlag.equalsIgnoreCase("Y"))
								{
									if(rs2!=null)
										rs2.close();
									 strQuery1 = SQLParser.getSqlQuery("select_croploan_details^"+strAppno);
									 rs2 = DBUtils.executeQuery(strQuery1);
									 while(rs2.next())
									 {
										 String flagVal = Helper.correctNull((String)rs2.getString("CL_FLAG"));
										 hshResult.put("CL_SANC"+flagVal,Helper.correctDouble((String)rs2.getString("CL_SANC_AMT")));				
									 }
									double total_value=0.0;
									double sec_year_value=0.0;
									double thrd_year_value=0.0;
									double fourth_year_value=0.0;
									double fifth_year_value=0.0;
									if(i==0)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+i)));
									}
									if(i==1)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+i)));
									}
									if(i==2)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+i)));
									}
									if(i==3)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+i)));
									}
									if(i==4)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+i)));
									}
									if(i>5)
									{
										dblCropLimit=Double.parseDouble(Helper.correctDouble((String)hshResult.get("CL_SANC"+4)));
									}
								}
								else
								{
									dblCropLimit=dblEligibleAmt;
								}
															
								
								
								dblEMI=(dblCropLimit*dblInterestrate)/100;
								k++;
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add(String.valueOf(dblEMI));
								arrBankPropEmiDataCol.add(String.valueOf(dblEMI));
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strScheme);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);
							}
							else
							{
								arrBankPropEmiDataCol=new ArrayList();
								arrBankPropEmiDataRow=new ArrayList();
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataCol.add(strLoantype);
								arrBankPropEmiDataCol.add(strScheme);
								arrBankPropEmiDataCol.add("0.00");
								arrBankPropEmiDataRow.add(arrBankPropEmiDataCol);	
							}
								hshResult.put("arrBankPropEmiDataRow"+i+hshCount, arrBankPropEmiDataRow);
								hshCount++;
						}
					}
				}
					hshCount=0;
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			strQuery = SQLParser.getSqlQuery("sel_secownername^"+strApplicantid);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				strPerappid=Helper.correctInt((String)rs.getString("PERAPP_ID"));
			}
			if(rs!=null)
			{
				rs.close();
			}
			
			if(ModuleType.equalsIgnoreCase("RET"))
				strPerappid=strApplicantid;
			//Other Bank loan Description 
			strQuery = SQLParser.getSqlQuery("perbankingselectNEW^"+strApplicantid);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				strLoantype=Helper.correctNull((String)rs.getString("perbank_type"));
				strRepaytype=Helper.correctNull((String)rs.getString("per_repaymenttype"));
				if(strLoantype.equalsIgnoreCase("2"))
				{
						arrOthBankCol=new ArrayList();
						arrOthBankCol.add(Helper.correctNull(rs.getString("PERBANK_FACILITY")));//0
						arrOthBankCol.add(strRepaytype);
						arrOthBankCol.add("TL");
						arrOthBankCol.add("");
						arrOthBankRow.add(arrOthBankCol);
				}
				if(strLoantype.equalsIgnoreCase("1"))
				{
						arrOthBankCol=new ArrayList();
						arrOthBankCol.add(Helper.correctNull(rs.getString("PERBANK_FACILITY")));//0
						arrOthBankCol.add(strRepaytype);
						arrOthBankCol.add("OD");
						arrOthBankCol.add("");
						arrOthBankRow.add(arrOthBankCol);
				}
			}
			if(rs!=null)
			{
				rs.close();
			}
			hshResult.put("arrOthBankRow",arrOthBankRow);
			//Existing facilities from other banks
			
			 strLoantype="";
			 strRepaytype="";
			 dblEMI=0.00;
			 dblFacilityamt=0.00;
			 dblInterestrate=0.00;
			 dblEMI1=0.00;
			 hshCount=0;
			 bolFlag=true;
			for(int i=0;i<=intYearSno;i++)
			{	
				strQuery = SQLParser.getSqlQuery("sel_agrExiassesmentdetails^"+strAppno+"^"+"OB"+"^"+(i+1));
				rs = DBUtils.executeQuery(strQuery);
				while(rs.next())
				{
					arrOthBankExisDataRow=new ArrayList();
					arrOthBankExisDataCol=new ArrayList();
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_EXTINSTALMENT")));
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("agr_dss_extintrest")));
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_LOANTYPE")));
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_EMITYPE")));
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INTAMT"))); 
					arrOthBankExisDataCol.add(Helper.correctDouble((String)rs.getString("AGR_DSS_INITINT")));
					arrOthBankExisDataRow.add(arrOthBankExisDataCol);
					hshResult.put("arrOthBankExisDataRow"+i+hshCount, arrOthBankExisDataRow);
					hshCount++;
					bolFlag=false;
				}
				if(bolFlag)
				{
					strQuery = SQLParser.getSqlQuery("perbankingselectNEW^"+strApplicantid);
					rs = DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
						strLoantype=Helper.correctNull((String)rs.getString("perbank_type"));
						dblInterestrate=Double.parseDouble(Helper.correctDouble((String)rs.getString("PERBANK_INTRATE")));
						strRepaytype=Helper.correctNull((String)rs.getString("per_repaymenttype"));
						strScheme="";
						if(strLoantype.equalsIgnoreCase("2"))
						{
							strLoantype="TL";
						}
						if(strLoantype.equalsIgnoreCase("1"))
						{
							strLoantype="OD";
						}
							intDuedays=Integer.parseInt(Helper.correctInt((String)rs.getString("Days")));
							if(intDuedays<=365)
							{
								intYear=1;
							}else
							{
								intTenor=Math.ceil(intDuedays/365);
								intYear=(int)Math.round(intTenor);
							}
							if(strLoantype.equalsIgnoreCase("TL") && strRepaytype.equalsIgnoreCase("E"))
							{
								if(intYear>=(i+1))
								{
										dblEMI1=Double.parseDouble(Helper.correctDouble((String)rs.getString("PERBANK_MONTHLY_INS")));
										dblEMI=dblEMI1*12;
										arrOthBankExisDataRow=new ArrayList();
										arrOthBankExisDataCol=new ArrayList();
										arrOthBankExisDataCol.add(String.valueOf(dblEMI));
										arrOthBankExisDataCol.add(dblInterestrate);
										arrOthBankExisDataCol.add("TL");
										arrOthBankExisDataCol.add(strRepaytype);
										arrOthBankExisDataCol.add("0.00");
										arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}
								else
								{
									arrOthBankExisDataRow=new ArrayList();
									arrOthBankExisDataCol=new ArrayList();
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("TL");
									arrOthBankExisDataCol.add(strRepaytype);
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}
										hshResult.put("arrOthBankExisDataRow"+i+hshCount, arrOthBankExisDataRow);
										hshCount++;
										
							}else if( strLoantype.equalsIgnoreCase("TL") && (!strRepaytype.equalsIgnoreCase("E")) && (!strRepaytype.equalsIgnoreCase("")))
							{
								dblFacilityamt=Double.parseDouble(Helper.correctDouble((String)rs.getString("PERBANK_OS")));
								if(intYear>=(i+1))
								{
									
									arrOthBankExisDataRow=new ArrayList();
									arrOthBankExisDataCol=new ArrayList();
									arrOthBankExisDataCol.add("0.00");//0
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("TL");//2
									arrOthBankExisDataCol.add(strRepaytype);
									arrOthBankExisDataCol.add(dblFacilityamt);//5
									arrOthBankExisDataCol.add(dblInterestrate);
									arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}else
								{
									arrOthBankExisDataRow=new ArrayList();
									arrOthBankExisDataCol=new ArrayList();
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("TL");
									arrOthBankExisDataCol.add(strRepaytype);
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}	
									hshResult.put("arrOthBankExisDataRow"+i+hshCount, arrOthBankExisDataRow);
									hshCount++;
							}
							else if(strLoantype.equalsIgnoreCase("OD"))
							{
								if(intYear>=(i+1))
								{
									dblEMI1=Double.parseDouble(Helper.correctDouble((String)rs.getString("PERBANK_LIMIT")));
									dblEMI=(dblEMI1*dblInterestrate)/100;
									arrOthBankExisDataRow=new ArrayList();
									arrOthBankExisDataCol=new ArrayList();
									arrOthBankExisDataCol.add(String.valueOf(dblEMI));
									arrOthBankExisDataCol.add(String.valueOf(dblEMI));
									arrOthBankExisDataCol.add(strLoantype);
									arrOthBankExisDataCol.add(strScheme);
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}else
								{
									arrOthBankExisDataRow=new ArrayList();
									arrOthBankExisDataCol=new ArrayList();
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataCol.add(strLoantype);
									arrOthBankExisDataCol.add(strScheme);
									arrOthBankExisDataCol.add("0.00");
									arrOthBankExisDataRow.add(arrOthBankExisDataCol);
								}
								hshResult.put("arrOthBankExisDataRow"+i+hshCount, arrOthBankExisDataRow);
								hshCount++;
							}
					}
					
				}
				hshCount=0;
			}
			
			if(rs!=null)
				rs.close();
			strQuery = SQLParser.getSqlQuery("sel_facsanctionstatus^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				if(Double.parseDouble(Helper.correctDouble(rs.getString("facility_sancinterest")))==0.00)
				{
					hshResult.put("strInterestFlag", "Y");
				}
			}
			
			
			hshResult.put("intPropsize", String.valueOf(intPropsize-1));
		}
		catch(Exception e)
		{
			throw new EJBException("Error in getDSS==>"+e.toString());
		}
		return hshResult;
	}
	
	
	public void updateDSS(HashMap hshValues) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=null;
		String strAppNo=null;
		int bankExisSize=0;
		int bankPropoSize=0;
		int bankOthExiSize=0;
		String strLoantype="",strEMIType="";
		try
		{			
			strAction=correctNull((String)hshValues.get("hidAction"));
			int iUpdatesize=0;
			strAppNo=correctNull((String)hshValues.get("strAppno"));
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("appno"));
			}
			if(strAppNo.trim().equalsIgnoreCase(""))
			{
				strAppNo = correctNull((String)hshValues.get("strAppno"));
			}
			String strIncomeCropLoan[]=(String [])hshValues.get("txt_incomecroploan");
			String strOtherIncome[]=(String [])hshValues.get("txt_otherincome");
			String strNetIncome[]=(String [])hshValues.get("txt_netincome");
			String strExistingInstallment[]=(String [])hshValues.get("txt_existinginstallment");
			String strExistingInterest[]=(String [])hshValues.get("txt_existinginterest");
			String strProposedInstallment[]=(String [])hshValues.get("txt_proposedinstallment");
			String strProposedInterest[]=(String [])hshValues.get("txt_proposedinterest");
			String strTotCommitment[]=(String [])hshValues.get("txt_totcommitment");
			String strFinyearSno[]=(String [])hshValues.get("hid_finyearsno");
			String stravgPecentageNetSurplus=Helper.correctNull((String)hshValues.get("txt_avg_pecentagesurplus"));
			bankExisSize=Integer.parseInt(correctNull((String)hshValues.get("hidBankExisLoanSize")));
			bankPropoSize=Integer.parseInt(correctNull((String)hshValues.get("hidBankProposedLoanSize")));
			bankOthExiSize=Integer.parseInt(correctNull((String)hshValues.get("hidOthBankLoanSize")));
			
			hshQuery=new HashMap();
			//int size=strIncomeCropLoan.length;
			int size=Integer.parseInt(correctNull((String)hshValues.get("hidBankLoanSize")));			
			hshQueryValues=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","agr_dssassessment_delete");
			arrValues.add(strAppNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			hshQuery=new HashMap();
			arrValues=new ArrayList();
			hshQueryValues.put("size","1");
			hshQuery.put("strQueryId","agr_dssaveragenetsurplus_delete");
			arrValues.add(strAppNo);
			hshQuery.put("arrValues",arrValues);
			hshQueryValues.put("1",hshQuery);
			EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			
			
			if(strAction.trim().equalsIgnoreCase("insert"))
			{
				
				for(int k=0;k<size;k++)
				{				
					hshQueryValues=new HashMap();
					iUpdatesize=0;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					hshQuery.put("strQueryId","agr_dssassessment_insert");
					arrValues.add(strAppNo);	//1
					arrValues.add(String.valueOf(k+1));//serial no 2
					arrValues.add(Helper.correctInt((String)hshValues.get("txt_otherincome"+k)));//4
					arrValues.add(Helper.correctInt((String)hshValues.get("txt_netincome"+k)));//5				
					arrValues.add(Helper.correctInt((String)hshValues.get("txt_totcommitment"+k)));//10
					arrValues.add(Helper.correctInt(strFinyearSno[k]));//10
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				}
				//Exisitng insert
				
				
				for(int k=0;k<size;k++)
				{				
					
					
					for(int l=0;l<bankExisSize;l++)
					{	
					hshQueryValues=new HashMap();
					iUpdatesize=0;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					strLoantype=Helper.correctNull((String)hshValues.get("hid_existingLoanType"+k+""+l));
					strEMIType=Helper.correctNull((String)hshValues.get("hid_existingEmiType"+k+""+l));
					if(strLoantype.equalsIgnoreCase("TL") && (!strEMIType.equalsIgnoreCase("E")) && (!strEMIType.equalsIgnoreCase("")))
					{
						hshQuery.put("strQueryId","agr_dssassessmentExis_insert_NE");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_existinginstallment"+k+""+l)));//3	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_existinginterest"+k+""+l)));//4					
						arrValues.add("E");//5	
						arrValues.add(String.valueOf(l+1));//6
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_existingLoanType"+k+""+l)));//7
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_existingEmiType"+k+""+l)));//8
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_ExisLoanAMT"+k+""+l)));//9
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_ExisEmiInt"+k+""+l)));//10
					}
					else
					{
						hshQuery.put("strQueryId","agr_dssassessmentExis_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_existinginstallment"+k+""+l)));//4	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_existinginterest"+k+""+l)));//4					
						arrValues.add("E");//10	
						arrValues.add(String.valueOf(l+1));//10
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_existingLoanType"+k+""+l)));
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_existingEmiType"+k+""+l)));
					}
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				
				//end
				
				//Other Bank loan
				
				for(int k=0;k<size;k++)
				{				
					
					
					for(int l=0;l<bankOthExiSize;l++)
					{	
					hshQueryValues=new HashMap();
					iUpdatesize=0;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					strLoantype=Helper.correctNull((String)hshValues.get("hid_OthexistingLoanType"+k+""+l));
					strEMIType=Helper.correctNull((String)hshValues.get("hid_OthexistingEmiType"+k+""+l));
					if(strLoantype.equalsIgnoreCase("TL") && (!strEMIType.equalsIgnoreCase("E")) && (!strEMIType.equalsIgnoreCase("")))
					{
						hshQuery.put("strQueryId","agr_dssassessmentExis_insert_NE");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_Othexistinginstallment"+k+""+l)));//3	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_Othexistinginterest"+k+""+l)));//4					
						arrValues.add("OB");//5	
						arrValues.add(String.valueOf(l+1));//6
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthexistingLoanType"+k+""+l)));//7
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthexistingEmiType"+k+""+l)));//8
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthLoanAMT"+k+""+l)));//9
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthEmiInt"+k+""+l)));//10
					}
					else
					{
						hshQuery.put("strQueryId","agr_dssassessmentExis_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_Othexistinginstallment"+k+""+l)));//3	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_Othexistinginterest"+k+""+l)));//4					
						arrValues.add("OB");//5	
						arrValues.add(String.valueOf(l+1));//6
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthexistingLoanType"+k+""+l)));//7
						arrValues.add(Helper.correctNull((String)hshValues.get("hid_OthexistingEmiType"+k+""+l)));//8
					}
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
				
				//Proposed loan	
				
				for(int k=0;k<size;k++)
				{				
					
					for(int l=0;l<bankPropoSize;l++)
					{
					hshQueryValues=new HashMap();
					iUpdatesize=0;
					hshQuery = new HashMap();
					arrValues=new ArrayList();
					iUpdatesize++;
					strLoantype=Helper.correctNull((String)hshValues.get("hid_PropLoanType"+k+""+l));
					strEMIType=Helper.correctNull((String)hshValues.get("hid_PropEmiType"+k+""+l));
					if(strLoantype.equalsIgnoreCase("TL") && (!strEMIType.equalsIgnoreCase("E")) && (!strEMIType.equalsIgnoreCase("")))
					{
						hshQuery.put("strQueryId","agr_dssassessmentProp_insert_NE");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2					
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposedinstallment"+k+""+l)));//3	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposedinterest"+k+""+l)));//4	
						arrValues.add("P");//5	
						arrValues.add(String.valueOf(l+1));//6
						arrValues.add(strLoantype);//7	
						arrValues.add(strEMIType);//8
						arrValues.add(Helper.correctDouble((String)hshValues.get("hid_PropLoanAMT"+k+""+l)));//9	
						arrValues.add(Helper.correctDouble((String)hshValues.get("hid_PropEmiInt"+k+""+l)));//10
						arrValues.add(Helper.correctDouble((String)hshValues.get("hid_PropHolidaytype"+k+""+l)));//11
					}
					else
					{
						hshQuery.put("strQueryId","agr_dssassessmentProp_insert");
						arrValues.add(strAppNo);	//1
						arrValues.add(String.valueOf(k+1));//serial no 2					
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposedinstallment"+k+""+l)));//3	
						arrValues.add(Helper.correctNull((String)hshValues.get("txt_proposedinterest"+k+""+l)));//4	
						arrValues.add("P");//5	
						arrValues.add(String.valueOf(l+1));//6
						arrValues.add(strLoantype);//7	
						arrValues.add(strEMIType);//8
					}
					hshQuery.put("arrValues",arrValues);						
					hshQueryValues.put("size",Integer.toString(iUpdatesize));
					hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);	
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}		
				
				
				//end
				iUpdatesize=0;
				hshQueryValues=new HashMap();				
				hshQuery = new HashMap();
				arrValues=new ArrayList();
				iUpdatesize++;
				hshQuery.put("strQueryId","agr_averagenetsurplus_insert");
				arrValues.add(strAppNo);
				arrValues.add(Helper.correctInt((String)stravgPecentageNetSurplus));
				hshQuery.put("arrValues",arrValues);						
				hshQueryValues.put("size",Integer.toString(iUpdatesize));
				hshQueryValues.put(Integer.toString(iUpdatesize),hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			hshQueryValues= new HashMap();
			StringBuilder strActionData = new StringBuilder();
			ArrayList arrAuditBatchData = new ArrayList();
			for(int k=0;k<size;k++)
			{	
				strActionData=new StringBuilder();
				strActionData.append(" ;~  Income From Crop =").
				append(Helper.correctInt("0.00")).
				append(";~ Other Income =").
				append(Helper.correctInt("0.00")).
				append(";~ Net Income =").
				append(Helper.correctInt((String)hshValues.get("txt_netincome"+k))).
				append(";~ Existing Loans Installments =").
				/*append(Helper.correctInt(strExistingInstallment[k])).
				append(";~ Existing Loans Interest =").
				append(Helper.correctInt(strExistingInterest[k])).
				append(";~ Proposed Loans Installments =").
				append(Helper.correctInt(strProposedInstallment[k])).
				append(";~ Proposed Loans Interest =").
				append(Helper.correctInt(strProposedInterest[k])).
				append(";~ Total Commitment =").*/
				append(Helper.correctInt((String)hshValues.get("txt_totcommitment"+k)));
				arrValues.add(strActionData.toString());
				arrAuditBatchData.add(strActionData);
			}
			if(arrAuditBatchData.size()>0)
			{
				//AuditTrial.auditLogBatch(hshValues,"304",strAppNo,arrAuditBatchData);
			}
		}
		catch(Exception e)
		{
			log.error("Error in updateDSS "+e.getMessage());
			throw new EJBException("Error in updateDSS === "+e.toString());
		}
	}
	
	public void updInlandAssessment (HashMap hshValues) 
	{
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery = "";
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();
		String appno="";
		String year1 = "", year2 = "", year3 = "", year4 = "", year5 = "", year6 = "", year7 = "", year8 = "", year9 = "", year10 = "";
		
		try
		{
			appno = correctNull((String)hshValues.get("appno"));
			String strAction = correctNull((String)hshValues.get("hidAction"));
						
		//	String[] Year = null;
			String[] Sales = null;
			String[] Purchases = null;
			String[] ProjPurchases = null;
			String[] AvgMonPurchases = null;
			String[] CreditPeriod = null;
			String[] TransitPeriod = null;
			String[] LCreq = null;
			String[] AppliedLimit = null;
			String[] RecomdLimit = null;
				
		//	Year = (String[])hshValues.get("txt_year");
			Sales = (String[]) hshValues.get("txt_sales");
			Purchases = (String[]) hshValues.get("txt_purchases");
			ProjPurchases = (String[]) hshValues.get("txt_projPurchases");
			AvgMonPurchases = (String[]) hshValues.get("txt_avgmonPurchases");
			CreditPeriod = (String[])hshValues.get("txt_creditPeriod");
			TransitPeriod = (String[]) hshValues.get("txt_transitPeriod");
			LCreq = (String[])hshValues.get("txt_LCrequirement");
			AppliedLimit = (String[]) hshValues.get("txt_appliedLimit");
			RecomdLimit = (String[]) hshValues.get("txt_recomdLimit");
			
			year1 = correctNull((String) hshValues.get("txt_year1"));
			year2 = correctNull((String) hshValues.get("txt_year2"));
			year3 = correctNull((String) hshValues.get("txt_year3"));
			year4 = correctNull((String) hshValues.get("txt_year4"));
			year5 = correctNull((String) hshValues.get("txt_year5"));
			
			year6 = correctNull((String) hshValues.get("txt_year6"));
			year7 = correctNull((String) hshValues.get("txt_year7"));
			year8 = correctNull((String) hshValues.get("txt_year8"));
			year9 = correctNull((String) hshValues.get("txt_year9"));
			year10 = correctNull((String) hshValues.get("txt_year10"));
			
			String Year[]= new String[]{year1,year2,year3,year4,year5,year6,year7,year8,year9,year10};
			
			
			if(strAction.equalsIgnoreCase("update"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_inlandAssessment");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
				
				int j=0;
				for(int i=0;i<5;i++)
			 	{
					if(Year[i]!=null && !Year[i].equalsIgnoreCase(""))
					{
						arrValues = new ArrayList();
						hshQueryValues = new HashMap();
						hshQuery=new HashMap();
						hshQuery.put("strQueryId","ins_inlandAssessment");
						arrValues.add(appno);
						arrValues.add(Integer.toString(j+1));
						arrValues.add(Year[i]);
						arrValues.add(Sales[i]);
						arrValues.add(Purchases[i]);
						arrValues.add(ProjPurchases[i]);
						arrValues.add(AvgMonPurchases[i]);
						arrValues.add(CreditPeriod[i]);
						arrValues.add(TransitPeriod[i]);
						arrValues.add(LCreq[i]);
						arrValues.add(AppliedLimit[i]);
						arrValues.add(RecomdLimit[i]);
	
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						hshQueryValues.put("size","1");	
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
						j++;
					}
				} 
			}
			
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId","del_inlandAssessment");
				arrValues.add(appno);
				hshQuery.put("arrValues",arrValues);
				hshQueryValues.put("1",hshQuery);
				hshQueryValues.put("size","1");
				EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");		
			}	
		}
		catch(Exception ce)
		{
			throw  new EJBException("Error in closing updInlandAssessment" + ce.getMessage()); 
		}
		finally
		{

			try {
				if (rs != null) {
					rs.close();
				}
				arrValues=null;
				hshQueryValues = null;
				hshQuery = null;
			} 
			catch (Exception cf) {
				throw new EJBException("Error closing in updInlandAssessment connection "+ cf.getMessage());
			}
		} 
	}
	
	public HashMap getInlandAssessment(HashMap hshValues)
	{
		HashMap hshRecord=new HashMap();
		String strQuery="";
		ArrayList arrCol = new ArrayList();
		ArrayList arrRow = new ArrayList();
		
		ArrayList arrColyr = new ArrayList();
		ArrayList arrRowyr = new ArrayList();
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		try
		{
			String strAppno =correctNull((String) hshValues.get("appno"));

			strQuery=SQLParser.getSqlQuery("sel_inlandAssessment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol = new ArrayList();
				if(Helper.correctNull(rs.getString("COM_IA_SALES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_SALES")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_PURCHASES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_PURCHASES")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_PROJPURCHASES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_PROJPURCHASES")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_AVGMONPURCHASES")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_AVGMONPURCHASES")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_CREDITPERIOD")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_CREDITPERIOD")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_TRANSITPERIOD")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_TRANSITPERIOD")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_LCREQUIRED")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_LCREQUIRED")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_APPLIEDLIMIT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_APPLIEDLIMIT")));
				}
				if(Helper.correctNull(rs.getString("COM_IA_RECOMMLIMIT")).equalsIgnoreCase(""))
				{
					arrCol.add("0.00");	
				}
				else
				{
					arrCol.add(Helper.correctNull(rs.getString("COM_IA_RECOMMLIMIT")));
				}
				
				arrRow.add(arrCol);
			}
			int RowCount = arrRow.size();
			int k=5-RowCount;
			for(int i=0;i<k;i++)
			{
				arrCol = new ArrayList();
				
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				arrCol.add("0.00");	
				
				arrRow.add(arrCol);
			}
			
			strQuery=SQLParser.getSqlQuery("sel_inlandAssessment^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrColyr = new ArrayList();
				arrColyr.add(Helper.correctNull(rs.getString("COM_IA_YEAR")));
				arrRowyr.add(arrColyr);
			}
			hshRecord.put("arrRow",arrRow);
			hshRecord.put("arrRowyr",arrRowyr);
			
			String strFinID="0",strValuesin="";
			strQuery = SQLParser.getSqlQuery("sel_financeid^" + strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if (rs.next()) {
				strFinID = Helper.correctInt((String) rs
						.getString("DEMO_FINSTANDARD"));
			}
			if (!strFinID.equals("0")) {
				strQuery = SQLParser
						.getSqlQuery("fin_cmano_select^" + strFinID);
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) {
					strValuesin = Helper.correctNull((String) rs
							.getString("fin_valuesarein"));
				}
			}
			if(strValuesin.equalsIgnoreCase("C"))
			{
				hshRecord.put("strValuesin", "Crore");
			}
			else if(strValuesin.equalsIgnoreCase("L"))
			{
				hshRecord.put("strValuesin", "Lacs");
			}else{
				hshRecord.put("strValuesin", "Rupees");
			}
		}
		catch (Exception ce)
		{	
			throw new EJBException("Error in closing getInlandAssessment" + ce.getMessage());
		}
		finally 
		{
			try
			{
				if (rs != null) 
				{
					rs.close();
					rs = null;
				}
				if (rs1 != null)
			    {
					 rs1.close();
			    }
			}
			catch (Exception e)
			{	
				throw new EJBException("Error in closing getInlandAssessment Connection "+ e.getMessage());
			}
		}
		return hshRecord;
	}

	
	/** Added by DINESH for Common Comments page in Assessment on 19/02/2014 **/
	
	public HashMap getDataComments(HashMap hshValues)  {
		ResultSet rs = null;
		ResultSet rs2 = null;
		HashMap hshRecord = null;
		// String strQuery = "";
		hshRecord = new HashMap();
		ArrayList vecVal = new ArrayList();
		ArrayList vecRec = new ArrayList();
		Blob b = null;
		byte[] aBlob = null;
		String Freeze_status = "";
		ByteArrayOutputStream bios = new ByteArrayOutputStream();
		String strAppNo = Helper.correctNull((String) hshValues.get("strAppno"));
		if(strAppNo.equalsIgnoreCase(""))
		{
			strAppNo = Helper.correctNull((String) hshValues.get("appno"));
		}
		String strpage = Helper.correctNull((String) hshValues.get("pagetype"));
		
		String strpage2 = Helper.correctNull((String) hshValues.get("pagetype2"));
		String str_select_facility = Helper.correctNull((String) hshValues.get("select_facility"));
		if(str_select_facility.equals(""))
		{
			str_select_facility="1";
		}
		
		if(strpage.equalsIgnoreCase(""))
		{
			strpage = Helper.correctNull((String) hshValues.get("pagetype1"));
		}
		String strDescSno = Helper.correctNull((String) hshValues.get("sel_description")); 
		ArrayList arrRow = new ArrayList();
		ArrayList arrCol = new ArrayList();
		
		String strSessionModuleType = Helper.correctNull((String)hshValues.get("sessionModuleType"));

		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) 
		{
			strAppNo = Helper.correctNull((String) hshValues.get("appno"));
		}
		
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) 
		{
			strAppNo = Helper.correctNull((String) hshValues.get("hidappno"));
		}
		try {
			
			/*rs = DBUtils.executeLAPSQuery("select_otherdeviationclassValues^"+"27");
			if (rs.next()) {
				hshRecord.put("undoclassValue",Integer.toString(rs.getInt("set_classvalue")));
			}
			if (rs != null) {
				rs.close();
			}
			rs = DBUtils.executeLAPSQuery("select_otherdeviationclassValues^"+"28");
			if (rs.next()) {
				hshRecord.put("updateclassValue",Integer.toString(rs.getInt("set_classvalue")));
			}
			if (rs != null) {
				rs.close();
			}*/
			String strhidFacilityCode_COPMOF = Helper.correctInt((String) hshValues.get("hidFacilityCode_COPMOF"));

			if( (strpage.equalsIgnoreCase("cop_mof"))||(strpage.equalsIgnoreCase("tleligibility")) ) 
			{
				if(strpage.equalsIgnoreCase("tleligibility")) 
					strDescSno="0";
			
				if(!strDescSno.equalsIgnoreCase(""))
				{
					rs = DBUtils.executeLAPSQuery("com_copmof_comments_sel^"+ strAppNo + "^" + strDescSno + "^" + strpage+"^"+strhidFacilityCode_COPMOF);
					if (rs.next()) 
					{
						hshRecord.put("fin_comments", Helper.CLOBToString(rs
								.getClob("COM_COMMENTS")));
					}
					hshRecord.put("strDescSno", strDescSno);
				}
				else
				{
					hshRecord.put("fin_comments", "");
					hshRecord.put("strDescSno", strDescSno);

				}
			}else if((strpage2.equalsIgnoreCase("repaycomment") || strpage.equalsIgnoreCase("repaycomment")))
			{
				if(strpage2.equals(""))
					strpage2=strpage;
				
				rs = DBUtils.executeLAPSQuery("sel_allcomments1^" + strAppNo + "^"+ strpage2+"^"+str_select_facility);
				if (rs.next()) 
				{
					hshRecord.put("fin_facility",Helper.correctNull((String) rs.getString("FIN_FACILITY")));
					
					hshRecord.put("fin_comments", Helper.CLOBToString(rs.getClob("fin_comments")));
					
					hshRecord.put("fin_comments1", Helper.CLOBToString(rs.getClob("fin_comments1")));
					hshRecord.put("FIN_STAGEWISE_RELEASE",Helper.correctNull((String) rs.getString("FIN_STAGEWISE_RELEASE")));
				}
				else
				{
					hshRecord.put("fin_facility",str_select_facility);	
				}
				if(rs!=null)
					rs.close();
				
				if(strSessionModuleType.equalsIgnoreCase("CORP")||strSessionModuleType.equalsIgnoreCase("AGR"))
				{
					rs=DBUtils.executeLAPSQuery("sel_chck_lst_doc^"+strAppNo+"^"+str_select_facility);
					if(rs.next())
					{
						hshRecord.put("strPrdLoanType",Helper.correctNull(rs.getString("com_facility_loantype")));
					}
				}
				else
				{
					rs=DBUtils.executeLAPSQuery("findapptype^"+strAppNo);
					if(rs.next())
					{
						hshRecord.put("strPrdLoanType",Helper.correctNull(rs.getString("PRD_LOANTYPE")));
					}
				}
			
			}
			else
			{
				rs = DBUtils.executeLAPSQuery("sel_allcomments^" + strAppNo + "^"+ strpage);
	
				if (rs.next()) 
				{
					/*
					 * b=null; aBlob = null; bios=new ByteArrayOutputStream(); b =
					 * rs.getBlob("fin_comments"); aBlob = b.getBytes(0, (int)
					 * b.length()); bios.write(aBlob); bios.flush(); bios.close();
					 * 
					 * hshRecord.put("fin_comments", bios.toString());
					 */
					hshRecord.put("fin_comments", Helper.CLOBToString(rs
							.getClob("fin_comments")));
					
					hshRecord.put("fin_comments1", Helper.CLOBToString(rs
							.getClob("fin_comments1")));
				}
			}
			if (rs != null) 
			{
				rs.close();
			}
			if (strpage.equalsIgnoreCase("DORecommend")) 
			{
				rs2 = DBUtils.executeLAPSQuery("sel_freezeapp_status^"+ strAppNo + "^" + "R");
				if (rs2.next()) 
				{
					// hshRecord.put("Applicationfreeze_status",Helper.correctNull((String)rs2.getString("freeze_status")));
					Freeze_status = Helper.correctNull((String) rs2.getString("freeze_status"));

				}
			}
			if (rs != null) 
			{
				rs.close();
			}
		
			hshRecord.put("Applicationfreeze_status", Freeze_status);
			hshRecord.put("pagetype", strpage);
			hshRecord.put("appno", strAppNo);
			if(rs != null)
				rs.close();
			rs = DBUtils.executeQuery(SQLParser.getSqlQuery("selfactypecheckrating^"+strAppNo));
			while(rs.next())
			{
				if(Helper.correctNull((String)rs.getString("COM_BANKSCHEME")).equalsIgnoreCase("052")){
					
				
				hshRecord.put("COM_BANKSCHEME", Helper.correctNull((String)rs.getString("COM_BANKSCHEME")));
				}
			}
			if(rs != null)
				rs.close();
		} 
		catch (Exception e) 
		{
			log.error("error occured" + e.toString());
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
				log.error("error occured" + e1.toString());
			}
		}

		return hshRecord;
	}
	
	public void updateDataComments(HashMap hshValues)  {
		HashMap hshqueryval = new HashMap();
		HashMap hshquery = new HashMap();
		HashMap hshQuery;
		ArrayList arrValues = new ArrayList();
		int intlength=0;
		try {
			String val = (String) hshValues.get("hidAction");
			//String appno = (String) hshValues.get("hidappno");
			
			String appno = Helper.correctNull((String) hshValues.get("strAppno"));
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("appno"));
			}
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("hidappno"));
			}	
			
			String strhidFacilitySno_COPMOF = Helper.correctInt((String) hshValues.get("hidFacilityCode_COPMOF"));
	
			String strpage = correctNull((String) hshValues.get("pagetype"));
			
			String strpage2 = correctNull((String) hshValues.get("pagetype2"));
			String strfacility = Helper.correctNull((String) hshValues.get("select_facility")); 

			
			String strDescSno = Helper.correctNull((String) hshValues.get("sel_description")); 
			
			String strindustryanalysis = correctNull((String) hshValues.get("txt_industryanalysis"));	
			String strindustryanalysis1 = correctNull((String) hshValues.get("txt_industryanalysis1"));
			

			if(strindustryanalysis.startsWith("<P>"))
			{
				strindustryanalysis=strindustryanalysis.replaceFirst("<P>", "");
			}
			if(strindustryanalysis.endsWith("</P>"))
			{
				intlength = strindustryanalysis.length();
				strindustryanalysis=(String) strindustryanalysis.subSequence(0, intlength-4);
			}			
			if(strindustryanalysis.equalsIgnoreCase("<P>&nbsp;</P>"))
			{
				strindustryanalysis="";
			}
			
			if(strindustryanalysis1.startsWith("<P>"))
			{
				strindustryanalysis1=strindustryanalysis1.replaceFirst("<P>", "");
			}
			if(strindustryanalysis1.endsWith("</P>"))
			{
				intlength = strindustryanalysis1.length();
				strindustryanalysis1=(String) strindustryanalysis1.subSequence(0, intlength-4);
			}			
			if(strindustryanalysis1.equalsIgnoreCase("<P>&nbsp;</P>"))
			{
				strindustryanalysis1="";
			}
			
			if (!val.equalsIgnoreCase("delete")) 
			{
				if( (strpage.equalsIgnoreCase("cop_mof"))||(strpage.equalsIgnoreCase("tleligibility")) ) 
				{
					if(strpage.equalsIgnoreCase("tleligibility")) 
						strDescSno="0";
					if(strDescSno.equalsIgnoreCase(""))
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "com_copmof_comments_ins");
						arrValues.add(appno);
						arrValues.add(strDescSno);
						arrValues.add(strindustryanalysis);	
						arrValues.add(strpage);
						arrValues.add(strhidFacilitySno_COPMOF);
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "1");
						hshqueryval.put("1", hshQuery);
						
						EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");	
						
					}
					else
					{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "com_copmof_comments_del");
					arrValues.add(appno);
					arrValues.add(strDescSno);
					arrValues.add(strpage);
					arrValues.add(strhidFacilitySno_COPMOF);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);

					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "com_copmof_comments_ins");
					arrValues.add(appno);
					arrValues.add(strDescSno);
					arrValues.add(strindustryanalysis);	
					arrValues.add(strpage);
					arrValues.add(strhidFacilitySno_COPMOF);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "2");
					hshqueryval.put("2", hshQuery);

					EJBInvoker.executeStateLess("dataaccess", hshqueryval,
							"updateData");	
					}
				}
				else
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "del_allcomments");
					arrValues.add(appno);
					arrValues.add(strpage);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);
					
					if(strpage.equalsIgnoreCase("turnover")||strpage.equalsIgnoreCase("mpbf")||strpage.equalsIgnoreCase("abf")||strpage.equalsIgnoreCase("cashinflow")||strpage.equalsIgnoreCase("cashoutflow")||strpage.equalsIgnoreCase("cashsummary")||strpage.equalsIgnoreCase("workingcapital")||strpage.equalsIgnoreCase("bgassessment")||strpage.equalsIgnoreCase("lcassessment")||strpage.equalsIgnoreCase("exportfacilities")||strpage.equalsIgnoreCase("bgstock")||strpage.equalsIgnoreCase("dscrcom")||strpage.equalsIgnoreCase("tlrentsecurecomments")||strpage.equalsIgnoreCase("mpbfagr") || strpage.equalsIgnoreCase("homestead") || strpage.equalsIgnoreCase("FKCC"))
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_financial_comments1");
						arrValues.add(appno);
						arrValues.add("");
						arrValues.add(strpage);
						arrValues.add(strindustryanalysis);
						arrValues.add("");
						arrValues.add(strindustryanalysis1);
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "2");
						hshqueryval.put("2", hshQuery);
					}
					else if(strpage.equalsIgnoreCase("PI") ||  strpage.equalsIgnoreCase("cashflow")|| strpage.equalsIgnoreCase("dscr") || strpage.equalsIgnoreCase("sensitivity") ||strpage.equalsIgnoreCase("benchmark") || strpage.equalsIgnoreCase("finposition") )
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_financial_comments1");
						arrValues.add(appno);
						arrValues.add("1");
						arrValues.add(strpage);
						arrValues.add(strindustryanalysis);
						arrValues.add("");
						arrValues.add(strindustryanalysis1);
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "2");
						hshqueryval.put("2", hshQuery);
					}
					else if(strpage.equalsIgnoreCase("turnover") || strpage.equalsIgnoreCase("expenditure")|| strpage.equalsIgnoreCase("souremargin")|| strpage.equalsIgnoreCase("assothers") || strpage.equalsIgnoreCase("assdscr") || strpage.equalsIgnoreCase("cashbudget") || strpage.equalsIgnoreCase("assnonfund") || strpage.equalsIgnoreCase("assement") || strpage.equalsIgnoreCase("assdss") || strpage.equalsIgnoreCase("croploan"))
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_financial_comments1");
						arrValues.add(appno);
						arrValues.add("1");
						arrValues.add(strpage);
						arrValues.add(strindustryanalysis);
						arrValues.add("");
						arrValues.add(strindustryanalysis1);
						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "2");
						hshqueryval.put("2", hshQuery);
					}
					else if(strpage2.equalsIgnoreCase("repaycomment"))
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "del_allcomments_fac");
						arrValues.add(appno);
						arrValues.add(strpage2);
						arrValues.add(strfacility);
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "1");
						hshqueryval.put("1", hshQuery);
						
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_financial_comments2");
						arrValues.add(appno);
						arrValues.add("");
						arrValues.add(strpage2);
//						arrValues.add(strindustryanalysis); //FIN_COMMENTS
						arrValues.add(correctNull((String)hshValues.get("strrepaymentterms")));
  						arrValues.add("");
  						arrValues.add(strindustryanalysis1);  //FIN_COMMENTS1
  						arrValues.add(strfacility);
  						arrValues.add(Helper.correctNull((String) hshValues.get("sel_stagewise_release")));
						hshQuery.put("arrValues", arrValues);
           				hshqueryval.put("size", "2");
    					hshqueryval.put("2", hshQuery);
					}
					else
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "ins_financial_comments1");
						arrValues.add(appno);
						arrValues.add("");
						arrValues.add(strpage);
						arrValues.add(strindustryanalysis);
  						arrValues.add("");
  						arrValues.add(strindustryanalysis1);
  						arrValues.add("");
						hshQuery.put("arrValues", arrValues);
           						hshqueryval.put("size", "2");
    						hshqueryval.put("2", hshQuery);
					}
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");
				}
			}
			if (val.equalsIgnoreCase("delete")) 
			{
				if( (strpage.equalsIgnoreCase("cop_mof"))||(strpage.equalsIgnoreCase("tleligibility")) ) 
				{
					if(strpage.equalsIgnoreCase("tleligibility")) 
						strDescSno="0";
					if(!strDescSno.equalsIgnoreCase(""))
					{
						if((strpage.equalsIgnoreCase("cop_mof")))
						{
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "com_copmof_comments_del");
							arrValues.add(appno);
							arrValues.add(strDescSno);
							arrValues.add(strpage);
							arrValues.add(strhidFacilitySno_COPMOF);
							hshQuery.put("arrValues", arrValues);
							hshqueryval.put("size", "1");
							hshqueryval.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshqueryval,
							"updateData");	
						}
						else
						{
							arrValues = new ArrayList();
							hshQuery = new HashMap();
							hshQuery.put("strQueryId", "com_financialposition_del");
							arrValues.add(appno);
							arrValues.add(strDescSno);
							arrValues.add(strpage);
							hshQuery.put("arrValues", arrValues);
							hshqueryval.put("size", "1");
							hshqueryval.put("1", hshQuery);
							EJBInvoker.executeStateLess("dataaccess", hshqueryval,
							"updateData");
						}
					}
				}
				else if(strpage2.equalsIgnoreCase("repaycomment"))
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "del_allcomments_fac");
					arrValues.add(appno);
					arrValues.add(strpage2);
					arrValues.add(strfacility);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
				}
				else
				{
					int intUpdatesize = 0;
					intUpdatesize = 1;
					hshqueryval.put("size", Integer.toString(intUpdatesize));
					hshquery.put("strQueryId", "del_allcomments");
					arrValues.add(appno);
					arrValues.add(strpage);
					hshquery.put("arrValues", arrValues);
					hshqueryval.put("1", hshquery);
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,
						"updateData");
				}
			}
			if (strpage.equalsIgnoreCase("DORecommend")) 
			{
				if (val.equalsIgnoreCase("Freeze")) 
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "ins_freezeapp_status");
					arrValues.add(appno);
					arrValues.add("R");
					arrValues.add("Y");
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);

					EJBInvoker.executeStateLess("dataaccess", hshqueryval,
							"updateData");
				}
				if (val.equalsIgnoreCase("Undo")) 
				{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "upd_freezeapp_status");
					arrValues.add("N");
					arrValues.add("R");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);

					EJBInvoker.executeStateLess("dataaccess", hshqueryval,
							"updateData");
				}
			}

		} catch (Exception ce) {
			throw new EJBException(ce);
		} finally {

		}

		// return hsh;
	}
	
	
	public HashMap getExposureIndustry(HashMap hshValues)  {
		ResultSet rs = null;
		HashMap hshRecord = null;
		hshRecord = new HashMap();
		String strQuery="";
		String Freeze_status = "";
		String strAppNo = Helper.correctNull((String) hshValues.get("strAppno"));
		String custId = Helper.correctNull((String) hshValues.get("hidapplicantid"));
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) 
		{
			strAppNo = Helper.correctNull((String) hshValues.get("appno"));
		}
		
		if (strAppNo.equalsIgnoreCase("") || strAppNo.equalsIgnoreCase("null")) 
		{
			strAppNo = Helper.correctNull((String) hshValues.get("hidappno"));
		}
		try {
			
			rs = DBUtils.executeLAPSQuery("SEL_EXPOSURETOINDUSTRY^"+ strAppNo);
			if (rs.next()) 
			{
				hshRecord.put("COM_ACTIVITY", Helper.correctNull((String)rs.getString("COM_ACTIVITY")));
				hshRecord.put("COM_ADVANCEDATE", Helper.correctNull((String)rs.getString("COM_ADVANCEDATE")));
				hshRecord.put("COM_PERCENTAGEGBCDATE", Helper.correctNull((String)rs.getString("COM_PERCENTAGEGBCDATE")));
				hshRecord.put("COM_ADVANCEAMOUNT", Helper.correctDouble((String)rs.getString("COM_ADVANCEAMOUNT")));
				hshRecord.put("COM_GBCPERCENTAGE", Helper.correctDouble((String)rs.getString("COM_GBCPERCENTAGE")));
				hshRecord.put("COM_NPAAMOUNT", Helper.correctDouble((String)rs.getString("COM_NPAAMOUNT")));
				hshRecord.put("COM_NPAGBCPERCENTAGE", Helper.correctDouble((String)rs.getString("COM_NPAGBCPERCENTAGE")));
				hshRecord.put("COM_GBCDATE", Helper.correctNull((String)rs.getString("COM_GBCDATE")));
				hshRecord.put("COM_GBCAMOUNT", Helper.correctDouble((String)rs.getString("COM_GBCAMOUNT")));
				hshRecord.put("COM_CALBASE", Helper.correctDouble((String)rs.getString("COM_CALBASE")));
			}
			hshRecord.put("appno", strAppNo);
			
			//Get Nature of Activity
			if(rs !=null) rs=null;
			strQuery=SQLParser.getSqlQuery("sel_applKYCNorms^"+custId);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshRecord.put("activitycode",correctNull(rs.getString("kyc_activity")));
				hshRecord.put("activitydesc",correctNull(rs.getString("activitydesc")));
			}
		} 
		catch (Exception e) 
		{
			log.error("error occured" + e.toString());
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
				log.error("error occured" + e1.toString());
			}
		}

		return hshRecord;
	}
	
	
	public void updateExposureIndustry(HashMap hshValues)  
	{
		HashMap hshQuery = new HashMap();
		HashMap hshqueryval = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = Helper.correctNull((String) hshValues.get("strAppno"));
		try
		{
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("appno"));
			}
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("hidappno"));
			}	
			if (strAction.equalsIgnoreCase("insert")) 
			{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "DEL_EXPOSURETOINDUSTRY");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);

					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "INS_EXPOSURETOINDUSTRY");
					arrValues.add(appno);
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_activity")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_Advancedate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_GBCperdate")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Advanceamount")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_PercentageofGBC")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_Npaamount")));
					arrValues.add(Helper.correctDouble((String)hshValues.get("txt_NPAtoGBC")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_GBCdate")));
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_GBCamount")));
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_CalBase")));
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "2");
					hshqueryval.put("2", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");	
			}
			if(strAction.equalsIgnoreCase("delete")) 
			{
					hshqueryval.put("size","1");
					hshQuery.put("strQueryId", "DEL_EXPOSURETOINDUSTRY");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");
			}
		} catch (Exception ce) {
			throw new EJBException(ce);
		} 
	}
	
	public HashMap updateCropLoan(HashMap hshValues)  
	{
		HashMap hshRecord = new HashMap();
		HashMap hshQuery = new HashMap();
		HashMap hshqueryval = new HashMap();
		ArrayList arrValues = new ArrayList();
		String strAction = (String) hshValues.get("hidAction");
		String appno = Helper.correctNull((String) hshValues.get("strAppno"));
		String strElig[] = null; 
		String strsanc[] = null;
		String strFlag[] = null;
		String strEligVal = null;
		String strsancVal = null;
		String strFlagVal = null;
		String strpcsamt[]=null;
		String strpcsamtval=null;
		String strjgsudamt[]=null;
		String strjgsudamtval=null;
		
		try
		{
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("appno"));
			}
			if (appno.equalsIgnoreCase("") || appno.equalsIgnoreCase("null")) 
			{
				appno = Helper.correctNull((String) hshValues.get("hidappno"));
			}
			
			if (strAction.equalsIgnoreCase("update")) 
			{
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId", "delete_croploan_details");
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshqueryval.put("size", "1");
					hshqueryval.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");	
                    
					if(hshValues.get("txt_elig_recomm") instanceof String[])
					{
						strElig = (String[])hshValues.get("txt_elig_recomm");
						strsanc = (String[])hshValues.get("txt_elig_sanc");
						strFlag = (String[])hshValues.get("txt_elig_flag");	
						strpcsamt = (String[])hshValues.get("txt_loan_pcs");
						strjgsudamt = (String[])hshValues.get("txt_loan_jgsuds");
						for(int i=0;i<strElig.length;i++)
						{
						hshqueryval = new HashMap();
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "insert_croploan_details");
						arrValues.add(appno);
						arrValues.add(Helper.correctNull(strFlag[i]));
						arrValues.add(Helper.correctDouble(strElig[i]));
						arrValues.add(Helper.correctDouble(strsanc[i]));
						arrValues.add(Helper.correctDouble(strpcsamt[i]));
						arrValues.add(Helper.correctDouble(strjgsudamt[i]));
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "1");
						hshqueryval.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");				
						}
					}
					else
					{
						strEligVal = (String)hshValues.get("txt_elig_recomm");
						strsancVal = (String)hshValues.get("txt_elig_sanc");
						strFlagVal = (String)hshValues.get("txt_elig_flag");
						strpcsamtval = (String)hshValues.get("txt_loan_pcs");	
						strjgsudamtval = (String)hshValues.get("txt_loan_jgsuds");
						hshqueryval = new HashMap();
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId", "insert_croploan_details");
						arrValues.add(appno);
						arrValues.add(Helper.correctNull(strFlagVal));
						arrValues.add(Helper.correctDouble(strEligVal));
						arrValues.add(Helper.correctDouble(strsancVal));
						arrValues.add(Helper.correctDouble(strpcsamtval));
						arrValues.add(Helper.correctDouble(strjgsudamtval));
						hshQuery.put("arrValues", arrValues);
						hshqueryval.put("size", "1");
						hshqueryval.put("1", hshQuery);
						EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");				
						}
						
		     }
			if(strAction.equalsIgnoreCase("delete")) 
			{
				arrValues = new ArrayList();
				hshQuery = new HashMap();
				hshQuery.put("strQueryId", "delete_croploan_details");
				arrValues.add(appno);
				hshQuery.put("arrValues", arrValues);
				hshqueryval.put("size", "1");
				hshqueryval.put("1", hshQuery);
				EJBInvoker.executeStateLess("dataaccess", hshqueryval,"updateData");	
			}
			
			hshRecord = getCropLoan(hshValues);
		} catch (Exception ce) {
			throw new EJBException(ce);
		}
		return hshRecord;
	}
	
	public void updateFinGroupComments(HashMap hshValues)  
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues = new ArrayList();
		ResultSet rs=null;
		
		String strAction = (String) hshValues.get("hidAction");
		String appno = correctNull((String) hshValues.get("appno"));
		if(appno.equalsIgnoreCase("")) {
			appno = correctNull((String) hshValues.get("hidAppNo"));
		}
		String strPage = correctNull((String) hshValues.get("hidPage"));					
		if(strPage.equalsIgnoreCase("")) {
			strPage = correctNull((String) hshValues.get("hidCommentPage"));	
		}
		String strSno = correctNull((String) hshValues.get("hidCompanyName"));					
		
		try {
			int ij=1;
			String strValue="txt_comments";
			String strValue1=strValue;
			String strPage1=strPage;
		
			ij=2; 
			
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
					hshQuery.put("strQueryId", "del_comcomments");
					arrValues.add(strPage);
					arrValues.add(strSno);
					arrValues.add(appno);
					hshQuery.put("arrValues", arrValues);
					hshQueryValues.put("1", hshQuery);
					EJBInvoker.executeStateLess("dataaccess", hshQueryValues,"updateData");
		
					hshQueryValues = new HashMap();
					hshQuery = new HashMap();
					hshQueryValues.put("size", "1");
					arrValues = new ArrayList();
					hshQuery.put("strQueryId", "ins_comments");		
					arrValues.add(appno);
					arrValues.add(strSno);
					if(!correctNull((String) hshValues.get(strValue)).equalsIgnoreCase(""))
					{
						arrValues.add(correctNull((String) hshValues.get(strValue)));
					}
					else
					{
					arrValues.add("");
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
					hshQuery.put("strQueryId", "del_comcomments");
					arrValues.add(strPage);
					arrValues.add(strSno);
					arrValues.add(appno);
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
	
	public HashMap getFinGroupComments(HashMap hshValues) 
	{
		String strQuery = "";
		ResultSet rs = null;
		HashMap hshRecord = new HashMap();
		String appno = "";
		String strPage = "",strSno = "";
		try {
			appno = correctNull((String) hshValues.get("appno"));
			if(appno.equalsIgnoreCase(""))
			{
				appno = correctNull((String) hshValues.get("hidAppNo"));
			}
			strPage = correctNull((String) hshValues.get("hidPage"));					
			if(strPage.equalsIgnoreCase(""))
			{
				strPage = correctNull((String) hshValues.get("hidCommentPage"));	
			}
			strSno = Helper.correctInt((String) hshValues.get("hidCompanyName"));
			
			int ji=2;			
			String hshName="COM_COMMENTS";
			String hshName1=hshName;
			String strPage1=strPage;
			for (int loop=0;loop<ji;loop++)
			{
				if(loop>0)  {
						hshName=hshName1+loop;
						strPage=strPage1+loop;
				}
				strQuery = SQLParser.getSqlQuery("sel_comcomments^" +strPage+"^"+strSno+"^"+appno);	
				if (rs != null)
					rs.close();
				rs = DBUtils.executeQuery(strQuery);
				if (rs.next()) 
				{					
				hshRecord.put(hshName, correctNull(Helper.CLOBToString(rs.getClob("COM_COMMENTS"))));
				hshRecord.put("hidPage", strPage);					
				}
				else {
					hshRecord.put("hidPage", strPage);
				}
			}
			hshRecord.put("appno",appno);	
			hshRecord.put("hidCompanyName",strSno);				
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
	
	public void updateBGassessment(HashMap hshValues)
	{
		HashMap hshQuery=new HashMap();
		HashMap hshQueryValues=new HashMap();
		ArrayList arrValues=new ArrayList();
		ResultSet rs1=null;
		String strComments=Helper.correctNull((String)hshValues.get("txt_comments"));
		String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
		String strAppno=correctNull((String)hshValues.get("appno"));
		String strhidPage = Helper.correctNull((String)hshValues.get("hidPage"));
		String strPageVal=Helper.correctNull((String)hshValues.get("flowtype"));
		if(strPageVal.equalsIgnoreCase(""))
			strPageVal=Helper.correctNull((String)hshValues.get("flowtype1"));
		String strAppType =Helper.correctNull((String)hshValues.get("strAppType"));
		try
		{
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryValues = new HashMap();
				
				if(strPageVal.equalsIgnoreCase("KSAE")||strPageVal.equalsIgnoreCase("KSAE-Restructure"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_ksaeassessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					String[] strCmts=null;
					String[] strAns=null;
					String[] strElig=null;
					String[] strID=null;
					String[] strAns1=null;
					int intSize=1;
					
					if (hshValues.get("hid_cmts") instanceof java.lang.String) 
					{
						strCmts = new String[1];
						strCmts[0]=(String)hshValues.get("hid_cmts");
						
					}else
					{
						strCmts=(String[])hshValues.get("hid_cmts");
					}
					if (hshValues.get("txt_cmtans") instanceof java.lang.String) 
					{
						strAns = new String[1];
						strAns[0]=(String)hshValues.get("txt_cmtans");
						
					}else
					{
						strAns=(String[])hshValues.get("txt_cmtans");
					}
					if (hshValues.get("sel_eligible") instanceof java.lang.String) 
					{
						strElig = new String[1];
						strElig[0]=(String)hshValues.get("sel_eligible");
						
					}else
					{
						strElig=(String[])hshValues.get("sel_eligible");
					}
					if (hshValues.get("hidassid") instanceof java.lang.String) 
					{
						strID = new String[1];
						strID[0]=(String)hshValues.get("hidassid");
						
					}else
					{
						strID=(String[])hshValues.get("hidassid");
					}
					if (hshValues.get("txt_cmtans1") instanceof java.lang.String) 
					{
						strAns1 = new String[1];
						strAns1[0]=(String)hshValues.get("txt_cmtans1");
						
					}else
					{
						strAns1=(String[])hshValues.get("txt_cmtans1");
					}
					
					for(int i=0;i<strCmts.length;i++)
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId","ins_com_ksaeassessment");
						arrValues.add(strAppno);
						arrValues.add(String.valueOf(intSize++));
						arrValues.add(strCmts[i]);
						arrValues.add(strAns[i]);
						arrValues.add(strElig[i]);
						arrValues.add(Helper.correctNull((String)hshValues.get("sel_eligibility")));
						arrValues.add(strID[i]);
						arrValues.add(strAns1[i]);
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				else if(strPageVal.equalsIgnoreCase("FIDPN"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_dpn_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					String[] strCmts=null;
					String[] strAmount=null;
					int intSize=1;
					
					if (hshValues.get("hid_dpncmts") instanceof java.lang.String) 
					{
						strCmts = new String[1];
						strCmts[0]=(String)hshValues.get("hid_dpncmts");
						
					}else
					{
						strCmts=(String[])hshValues.get("hid_dpncmts");
					}
					if (hshValues.get("txtAmount") instanceof java.lang.String) 
					{
						strAmount = new String[1];
						strAmount[0]=(String)hshValues.get("txtAmount");
						
					}else
					{
						strAmount=(String[])hshValues.get("txtAmount");
					}
					
					for(int i=0;i<strCmts.length;i++)
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId","ins_com_assesmentdetails");
						arrValues.add(strAppno);
						arrValues.add(strPageVal);
						arrValues.add(String.valueOf(intSize++));
						arrValues.add(strCmts[i]);
						arrValues.add(strAmount[i]);
						arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				else if(strPageVal.equalsIgnoreCase("MMithra"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					String[] strCmts=null;
					String[] strAmount=null;
					int intSize=1;
					
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					arrValues.add(String.valueOf(intSize++));
					arrValues.add("Details as on Date");
					arrValues.add(Helper.correctNull((String)hshValues.get("txt_mithraason")));
					arrValues.add("");
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					
					if (hshValues.get("hid_desc") instanceof java.lang.String) 
					{
						strCmts = new String[1];
						strCmts[0]=(String)hshValues.get("hid_desc");
						
					}else
					{
						strCmts=(String[])hshValues.get("hid_desc");
					}
					if (hshValues.get("txtAmount1") instanceof java.lang.String) 
					{
						strAmount = new String[1];
						strAmount[0]=(String)hshValues.get("txtAmount1");
						
					}else
					{
						strAmount=(String[])hshValues.get("txtAmount1");
					}
					
					for(int i=0;i<strCmts.length;i++)
					{
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId","ins_com_assesmentdetails");
						arrValues.add(strAppno);
						arrValues.add(strPageVal);
						arrValues.add(String.valueOf(intSize++));
						arrValues.add(strCmts[i]);
						arrValues.add(strAmount[i]);
						arrValues.add("");
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
				}
				else if(strPageVal.equalsIgnoreCase("GECL")||strPageVal.equalsIgnoreCase("GECL-Restructure"))
				{
					String strgecltype="";
					rs1=DBUtils.executeLAPSQuery("sel_geclidentchk^"+strAppno);
			        if(rs1.next()){
			        	strgecltype= Helper.correctNull((rs1.getString("COM_GECLTYPE")));
			        	if(strAppType.equalsIgnoreCase("S")){
			           		if(strgecltype.equals("GECL1")){
			           			strgecltype="GECL1-Restructure";
			           	 }
			           	 }else{
			           		strgecltype= Helper.correctNull((rs1.getString("COM_GECLTYPE")));
			     
			           	 }
			        }
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					String[] strCmts=null;
					String[] strAmount=null;
					int intSize=1;
					int intSize1=1;
					int intSize2=1;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					
	            	if (hshValues.get("hid_desc1") instanceof java.lang.String) 
					{
						strCmts = new String[1];
						strCmts[0]=(String)hshValues.get("hid_desc1");
						
					}else
					{
						strCmts=(String[])hshValues.get("hid_desc1");
					}
	            	if(strgecltype.equalsIgnoreCase("GECL1")){
					if (hshValues.get("txtAmount3") instanceof java.lang.String) 
					{
						strAmount = new String[1];
						strAmount[0]=(String)hshValues.get("txtAmount3");
						
					}else
					{
						strAmount=(String[])hshValues.get("txtAmount3");
					}
	            	}else if(strgecltype.equalsIgnoreCase("GECL2")){
	            		if (hshValues.get("txtAmount5") instanceof java.lang.String) 
						{
							strAmount = new String[1];
							strAmount[0]=(String)hshValues.get("txtAmount5");
							
						}else
						{
							strAmount=(String[])hshValues.get("txtAmount5");
						}
	            	}
	            	else if(strgecltype.equalsIgnoreCase("GECL3")){
	            		if (hshValues.get("txtAmount6") instanceof java.lang.String) 
						{
							strAmount = new String[1];
							strAmount[0]=(String)hshValues.get("txtAmount6");
							
						}else
						{
							strAmount=(String[])hshValues.get("txtAmount6");
						}
	            	}
	            	else if(strgecltype.equalsIgnoreCase("GECL4")){
	            		if (hshValues.get("txtAmount7") instanceof java.lang.String) 
						{
							strAmount = new String[1];
							strAmount[0]=(String)hshValues.get("txtAmount7");
							
						}else
						{
							strAmount=(String[])hshValues.get("txtAmount7");
						}
	            	}
	            		else if(strgecltype.equalsIgnoreCase("GECL1-Restructure")){
		            		if (hshValues.get("txtAmount8") instanceof java.lang.String) 
							{
								strAmount = new String[1];
								strAmount[0]=(String)hshValues.get("txtAmount8");
								
							}else
							{
								strAmount=(String[])hshValues.get("txtAmount8");
							}
	            	}
	            		else if(strgecltype.equalsIgnoreCase("GECL -1 extension")){
		            		if (hshValues.get("txtAmount9") instanceof java.lang.String) 
							{
								strAmount = new String[1];
								strAmount[0]=(String)hshValues.get("txtAmount9");
								
							}else
							{
								strAmount=(String[])hshValues.get("txtAmount9");
							}
		            	}
	            	
	            		else if(strgecltype.equalsIgnoreCase("GECL -3 extension")){
		            		if (hshValues.get("txtAmount10") instanceof java.lang.String) 
							{
								strAmount = new String[1];
								strAmount[0]=(String)hshValues.get("txtAmount10");
								
							}else
							{
								strAmount=(String[])hshValues.get("txtAmount10");
							}
		            	}
	            	
	            		else if(strgecltype.equalsIgnoreCase("GECL -2 extension")){
		            		if (hshValues.get("txtAmount11") instanceof java.lang.String) 
							{
								strAmount = new String[1];
								strAmount[0]=(String)hshValues.get("txtAmount11");
								
							}else
							{
								strAmount=(String[])hshValues.get("txtAmount11");
							}
		            	}
	            	
	            	String[] strAmount1=null,strAmount2=null,strAmount3=null;
					HashMap hshResult = new HashMap();	
					String strQuery="";
					ResultSet rs=null;
					boolean gecl1flag=false,gecl2flag=false,gecl3flag=false;
	            	
					
					if(strgecltype.equalsIgnoreCase("GECL -1 extension"))
					{	
					
	            		if (hshValues.get("txtAmount9") instanceof java.lang.String) 
						{
							strAmount1 = new String[1];
							strAmount1[0]=(String)hshValues.get("txtAmount9");							
						}else
						{
							strAmount1=(String[])hshValues.get("txtAmount9");
						}
	            	}
					
					
					if(strgecltype.equalsIgnoreCase("GECL -2 extension"))
					{	
					
	            		if (hshValues.get("txtAmount11") instanceof java.lang.String) 
						{
							strAmount2 = new String[1];
							strAmount2[0]=(String)hshValues.get("txtAmount11");							
						}else
						{
							strAmount2=(String[])hshValues.get("txtAmount11");
						}
	            	}
					
					
					if(strgecltype.equalsIgnoreCase("GECL -3 extension"))
					{	
					
	            		if (hshValues.get("txtAmount10") instanceof java.lang.String) 
						{
							strAmount3 = new String[1];
							strAmount3[0]=(String)hshValues.get("txtAmount10");							
						}else
						{
							strAmount3=(String[])hshValues.get("txtAmount10");
						}
	            	}
	            	
	            	if(strgecltype.equalsIgnoreCase("GECL -1 extension") || strgecltype.equalsIgnoreCase("GECL -2 extension") || strgecltype.equalsIgnoreCase("GECL -3 extension"))
	            	{
	            	
	            		if(strgecltype.equalsIgnoreCase("GECL -1 extension"))
	            				{
	    			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"1");
	    			rs=DBUtils.executeQuery(strQuery);
	    			if(rs.next())
	    			{
	    				
	    				hshResult.put("gecl1ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				
	    			
	    			}
	    			
	    			
	    			
	    			if(correctNull((String)hshResult.get("gecl1ext1")).equalsIgnoreCase(""))
	    			{
	    				 rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    					if(rs.next()){
	    						hshResult.put("gecl1ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}         }
	    			
	    			
	    			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"2");
	    			rs=DBUtils.executeQuery(strQuery);
	    			if(rs.next())
	    			{
	    				
	    				hshResult.put("gecl1ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			}
	    			
	    			
	    			if(correctNull((String)hshResult.get("gecl1ext2")).equalsIgnoreCase(""))
	    			{
	    				rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    				if(rs.next()){
	    					
	    					hshResult.put("gecl1ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			}
	    			}
	    			
	    			
	    			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"4");
	    			rs=DBUtils.executeQuery(strQuery);
	    			if(rs.next())
	    			{
	    				
	    				hshResult.put("gecl1ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    		
	    			}
	    			
	    			if(correctNull((String)hshResult.get("gecl1ext4")).equalsIgnoreCase(""))
	    			{
	    				rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    				if(rs.next()){
	    					
	    					hshResult.put("gecl1ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			}
	    			
	    			}
	    			
	    			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"5");
	    			rs=DBUtils.executeQuery(strQuery);
	    			if(rs.next())
	    			{
	    				
	    				hshResult.put("gecl1ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			
	    			}
	    			
	    			if(correctNull((String)hshResult.get("gecl1ext5")).equalsIgnoreCase(""))
	    			{
	    				rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    				if(rs.next()){
	    					
	    					hshResult.put("gecl1ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			}
	            	}
	            				}
	            	if(strgecltype.equalsIgnoreCase("GECL -2 extension"))
	            	{
	            		
	            		strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"1");
	        			rs=DBUtils.executeQuery(strQuery);
	        			if(rs.next())
	        			{
	        				
	        				hshResult.put("gecl2ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}
	        			
	        			
	        			if(correctNull((String)hshResult.get("gecl2ext1")).equalsIgnoreCase(""))
		    			{
	        			rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	        			if(rs.next()){
	        				
	        				hshResult.put("gecl2ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        		                 }
		    			}
	        			
	        			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"2");
	        			rs=DBUtils.executeQuery(strQuery);
	        			if(rs.next())
	        			{
	        				hshResult.put("gecl2ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}
	        			
	        			if(correctNull((String)hshResult.get("gecl2ext2")).equalsIgnoreCase(""))
		    			{
	        				rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	        				if(rs.next()){
	        					
	        					hshResult.put("gecl2ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}	
		    			}
	        			
	        			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"4");
	        			rs=DBUtils.executeQuery(strQuery);
	        			if(rs.next())
	        			{
	        				hshResult.put("gecl2ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}
	        			
	        			if(correctNull((String)hshResult.get("gecl2ext4")).equalsIgnoreCase(""))
		    			{
	        				rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	        				if(rs.next()){
	        					
	        					hshResult.put("gecl2ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}	
		    			}
	        			
	        			
	        			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"5");
	        			rs=DBUtils.executeQuery(strQuery);
	        			if(rs.next())
	        			{
	        				hshResult.put("gecl2ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}
	        			
	        			if(correctNull((String)hshResult.get("gecl2ext5")).equalsIgnoreCase(""))
		    			{
	        				rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	        				if(rs.next()){
	        					hshResult.put("gecl2ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	        			}
		    			}
	        			
	            	}
	            	
	            	if(strgecltype.equalsIgnoreCase("GECL -3 extension"))
	            	{
	            		
	                    strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"1");
	    				rs=DBUtils.executeQuery(strQuery);
	    				if(rs.next())
	    				{
	    					
	    					hshResult.put("gecl3ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}

	    				if(correctNull((String)hshResult.get("gecl3ext1")).equalsIgnoreCase(""))
		    			{
	    				rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    				if(rs.next()){
	    					
	    					hshResult.put("gecl3ext1",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    			}
		    			}
	    				
	    				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"2");
	    				rs=DBUtils.executeQuery(strQuery);
	    				if(rs.next())
	    				{
	    					
	    					hshResult.put("gecl3ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
	    				
	    				
	    				if(correctNull((String)hshResult.get("gecl3ext2")).equalsIgnoreCase(""))
		    			{
	    					rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    					if(rs.next()){
	    						
	    						hshResult.put("gecl3ext2",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
		    			}

	    				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"4");
	    				rs=DBUtils.executeQuery(strQuery);
	    				if(rs.next())
	    				{
	    					
	    					hshResult.put("gecl3ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
	    				
	    				if(correctNull((String)hshResult.get("gecl3ext4")).equalsIgnoreCase(""))
		    			{
	    					
	    					rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    					if(rs.next()){
	    						
	    						hshResult.put("gecl3ext4",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
	    					
		    			}
	    				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"5");
	    				rs=DBUtils.executeQuery(strQuery);
	    				if(rs.next())
	    				{
	    					
	    					hshResult.put("gecl3ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
	    				
	    				if(correctNull((String)hshResult.get("gecl3ext5")).equalsIgnoreCase(""))
		    			{
	    					rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	    					if(rs.next()){
	    						
	    						hshResult.put("gecl3ext5",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")))));
	    				}
		    			}
	            	}
	            		
	            		
	            	
	            	}
	            	
	            	for(int i=0;i<=5;i++)
					{
	            	if(strgecltype.equalsIgnoreCase("GECL -1 extension"))
					{
						boolean flag1=false;
						/*if(i==0 || i==1 || i==3 || i==4)
						{
							if(!strAmount1[0].equalsIgnoreCase((String)hshResult.get("gecl1ext1")) || !strAmount1[1].equalsIgnoreCase((String)hshResult.get("gecl1ext2"))
									||!strAmount1[3].equalsIgnoreCase((String)hshResult.get("gecl1ext4"))||!strAmount1[4].equalsIgnoreCase((String)hshResult.get("gecl1ext5")))
							{*/
	            		
	            		if(i==0)
	            		{
	            			if(!strAmount1[0].equalsIgnoreCase((String)hshResult.get("gecl1ext1")))
	            			{
	            				flag1=true;
	            			}
	            		}
	            		
	            		if(i==1)
	            		{
	            			if(!strAmount1[1].equalsIgnoreCase((String)hshResult.get("gecl1ext2")))
	            			{
	            				flag1=true;
	            			}
	            		}
	            		
	            		if(i==3)
	            		{
	            			if(!strAmount1[3].equalsIgnoreCase((String)hshResult.get("gecl1ext4")))
	            			{
	            				flag1=true;
	            			}
	            		}
	            		
	            		if(i==4)
	            		{
	            			if(!!strAmount1[4].equalsIgnoreCase((String)hshResult.get("gecl1ext5")))
	            			{
	            				flag1=true;
	            			}
	            		}
	            		if(flag1)
	            		{
								intSize++;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_com_assesmentdetails_history");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);					
					arrValues.add(String.valueOf(intSize1++));
					if(i==0)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl1ext1"))));
					}
					if(i==1)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl1ext2"))));
					}
					if(i==3)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl1ext4"))));
					}
					if(i==4)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl1ext5"))));
					}
					arrValues.add("");
					arrValues.add((String)hshValues.get("strUserId"));
					arrValues.add((String)hshValues.get("strOrgShortCode"));
					arrValues.add((String)hshValues.get("strUserDepartment"));
					/*hshQueryValues.put("size","1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
					
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
					//}
					}
	            	
	            	
	            	if(strgecltype.equalsIgnoreCase("GECL -2 extension"))
					{
						
						if(i==0 || i==1 || i==3 || i==4)
						{
							if(!strAmount2[0].equalsIgnoreCase((String)hshResult.get("gecl2ext1")) || !strAmount2[1].equalsIgnoreCase((String)hshResult.get("gecl2ext2"))
									||!strAmount2[3].equalsIgnoreCase((String)hshResult.get("gecl2ext4"))||!strAmount2[4].equalsIgnoreCase((String)hshResult.get("gecl2ext5")))
							{
								intSize++;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_com_assesmentdetails_history");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);					
					arrValues.add(String.valueOf(intSize1++));
					if(i==0)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl2ext1"))));
					}
					if(i==1)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl2ext2"))));
					}
					if(i==3)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl2ext4"))));
					}
					if(i==4)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl2ext5"))));
					}
					arrValues.add("");
					arrValues.add((String)hshValues.get("strUserId"));
					arrValues.add((String)hshValues.get("strOrgShortCode"));
					arrValues.add((String)hshValues.get("strUserDepartment"));
					/*hshQueryValues.put("size","1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
					
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
					}
					}
	            	
	            	
	            	
	            	if(strgecltype.equalsIgnoreCase("GECL -3 extension"))
					{
						
						if(i==0 || i==1 || i==3 || i==4)
						{
							if(!strAmount3[0].equalsIgnoreCase((String)hshResult.get("gecl3ext1")) || !strAmount3[1].equalsIgnoreCase((String)hshResult.get("gecl3ext2"))
									||!strAmount3[3].equalsIgnoreCase((String)hshResult.get("gecl3ext4"))||!strAmount3[4].equalsIgnoreCase((String)hshResult.get("gecl3ext5")))
							{
								intSize++;
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQuery.put("strQueryId","ins_com_assesmentdetails_history");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);					
					arrValues.add(String.valueOf(intSize1++));
					if(i==0)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl3ext1"))));
					}
					if(i==1)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl3ext2"))));
					}
					if(i==3)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl3ext4"))));
					}
					if(i==4)
					{
					arrValues.add(strCmts[i]);					
						arrValues.add((Helper.correctNull((String)hshResult.get("gecl3ext5"))));
					}
					arrValues.add("");
					arrValues.add((String)hshValues.get("strUserId"));
					arrValues.add((String)hshValues.get("strOrgShortCode"));
					arrValues.add((String)hshValues.get("strUserDepartment"));
					/*hshQueryValues.put("size","1");
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
					EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");*/
					
					hshQueryValues.put("size",String.valueOf(intSize));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
					}
					}
					}
					for(int i=0;i<strCmts.length;i++)
					{
						
						
						intSize++;
						arrValues = new ArrayList();
						hshQuery = new HashMap();
						hshQuery.put("strQueryId","ins_com_assesmentdetails");
						arrValues.add(strAppno);
						arrValues.add(strPageVal);
						arrValues.add(String.valueOf(intSize2++));
						arrValues.add(strCmts[i]);
						arrValues.add(strAmount[i]);
						arrValues.add("");
						hshQueryValues.put("size",String.valueOf(intSize));
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put(String.valueOf(intSize),hshQuery);
					}
					
									
				}
				else
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add(strhidPage);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				
					arrValues = new ArrayList();
					hshQuery = new HashMap();
					hshQueryValues.put("size","2");
					hshQuery.put("strQueryId","ins_assessment");
					
					arrValues.add(strAppno);
					arrValues.add(strhidPage);
					arrValues.add(strComments);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("2",hshQuery);	
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryValues = new HashMap();
				if(strPageVal.equalsIgnoreCase("KSAE")||strPageVal.equalsIgnoreCase("KSAE-Restructure"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_ksaeassessment");
					arrValues.add(strAppno);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				else if(strPageVal.equalsIgnoreCase("FIDPN"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_dpn_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					arrValues.add(Helper.correctNull((String)hshValues.get("sel_facilitysno")));
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				else if(strPageVal.equalsIgnoreCase("MMithra"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				else if(strPageVal.equalsIgnoreCase("GECL")||strPageVal.equalsIgnoreCase("GECL-Restructure"))
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_com_assesmentdetails");
					arrValues.add(strAppno);
					arrValues.add(strPageVal);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				else
				{
					hshQuery = new HashMap();					
					hshQueryValues.put("size","1");
					hshQuery.put("strQueryId","del_assessment");
					arrValues.add(strAppno);
					arrValues.add(strhidPage);
					hshQuery.put("arrValues",arrValues);
					hshQueryValues.put("1",hshQuery);
				}
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch (Exception e)
		{
			throw new EJBException("Error in updateBGassessment" + e.getMessage());
		} 
	}
	
	public HashMap getBGassessment(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null,rs2=null;
		String strQuery="";
		ArrayList listRow=new ArrayList();
		ArrayList listCol=new ArrayList();
		boolean bflag=true;
		String strAppno=Helper.correctNull((String)hshValues.get("appno"));
		String strPageVal=Helper.correctNull((String)hshValues.get("flowtype"));
		if(strPageVal.equalsIgnoreCase(""))
			strPageVal=Helper.correctNull((String)hshValues.get("flowtype1"));
		String strgeclident="",strledcode="",strgstnchk="",strinputval="";
		String strgstnumber="",strgstnfalg="";
		double dblgecl1TotAmount=0.00,dblgecl2TotAmount=0.00;
		double dblgeclproposedamt=0.00;
		String strAppType =Helper.correctNull((String)hshValues.get("strAppType"));
		String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
	try
		{
		
		
		String usr_class="";
		rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
        if(rs1.next()){
		 usr_class=Helper.correctNull(rs1.getString("usr_class"));				
        }
        if(rs1!=null){
			rs1.close();
		}
        
		rs1=DBUtils.executeLAPSQuery("sel_geclidentchk^"+strAppno);
        if(rs1.next()){
       	 strgeclident= Helper.correctNull((rs1.getString("COM_GECLTYPE")));
       	 if(strAppType.equalsIgnoreCase("S")){
       		if(strgeclident.equals("GECL1")){
       		strgeclident="GECL1-Restructure";
       	 }
       	 }else{
           	 strgeclident= Helper.correctNull((rs1.getString("COM_GECLTYPE")));
 
       	 }
       	hshResult.put("COM_GECL1_MAXLIMITNOC",Helper.correctNull(rs1.getString("COM_GECL1_MAXLIMITNOC")));
    	hshResult.put("COM_GECL1_MAXLIMITBORRO",Helper.correctNull(rs1.getString("COM_GECL1_MAXLIMITBORRO")));
    	hshResult.put("COM_GECL2_ELGLIMITMLIS",Helper.correctNull(rs1.getString("COM_GECL2_ELGLIMITMLIS")));
    	hshResult.put("COM_GECL2_ELIGLIMITBANK",Helper.correctNull(rs1.getString("COM_GECL2_ELIGLIMITBANK")));
    	hshResult.put("COM_GECL3_MAXLIMITBORROMLIS",Helper.correctNull(rs1.getString("COM_GECL3_MAXLIMITBORROMLIS")));
    	hshResult.put("COM_GECL3_MAXLIMITBANK",Helper.correctNull(rs1.getString("COM_GECL3_MAXLIMITBANK")));
    	
    	
    	
    	 
        }
   	 hshResult.put("strgeclident",strgeclident);

			if(strPageVal.equalsIgnoreCase("KSAE")||strPageVal.equalsIgnoreCase("KSAE-Restructure"))
			{
				rs=DBUtils.executeLAPSQuery("sel_com_ksaeassessment^"+strAppno);
				while(rs.next())
				{
					bflag=false;
					listCol=new ArrayList();
					listCol.add(Helper.correctNull(rs.getString("question")));//0
					listCol.add(Helper.correctNull(rs.getString("com_comments")));//1
					listCol.add(Helper.correctNull(rs.getString("com_eligible")));//2
					listCol.add(Helper.correctNull(rs.getString("com_ksaeeligibleid")));//3
					listCol.add(Helper.correctNull(rs.getString("stat_data_descvalue1")));//4
					listCol.add(Helper.correctNull(rs.getString("STAT_DATA_VALUEDESC")));//5
					listCol.add(Helper.correctNull(rs.getString("STATIC_DATA_MAXVAL")));//6
					listCol.add(Helper.correctNull(rs.getString("STATIC_DATA_SECTOR")));//7
					rs1=DBUtils.executeLAPSQuery("sel_geclcusdetails^"+Helper.correctNull((String)hshValues.get("hidapplicantnewid")));
					if(rs1.next()){
						listCol.add(Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")));//8
						listCol.add(Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")));//9
						
						hshResult.put("PERAPP_LEGAL_ENTITYID",Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")));
						hshResult.put("PERAPP_LEGAL_EXPIRYDATE",Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")));
						listCol.add(Helper.correctNull(rs1.getString("COMINFO_GSTIN")));//10
						listCol.add(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")));//11
						listCol.add(Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));//12
						listCol.add(Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")));//13
						
						hshResult.put("PERAPP_CONSTITUTION",Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")));
				        }else{
				        	listCol.add("");//8
							listCol.add("");//9
							listCol.add("");//10
							listCol.add("");//11
							listCol.add("");//12
							listCol.add("");//13
				        }
					strQuery=SQLParser.getSqlQuery("sel_amtgeclchk^"+strAppno);
					rs2=DBUtils.executeQuery(strQuery);
					if(rs2.next())
					{
						listCol.add(Helper.correctNull(rs2.getString("com_details")));
					}else{
						listCol.add("");//8
					}
					listRow.add(listCol);
					strinputval=Helper.correctNull(rs.getString("STAT_DATA_VALUEDESC"));
					strgstnchk=Helper.correctNull(rs1.getString("COMINFO_GSTINREG"));
					if(strinputval.equalsIgnoreCase("LC")){
						if(!Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")).equalsIgnoreCase("01")&&(Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")).equalsIgnoreCase("")||Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")).equalsIgnoreCase(""))){
							hshResult.put("strlegalchk","Y");
						}
					}else if(strinputval.equalsIgnoreCase("NS")){
						hshResult.put("strnameofsector",Helper.correctNull(rs.getString("com_comments")));

					}else if(strinputval.equalsIgnoreCase("GRN")){
						if(!(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")).equalsIgnoreCase("Y" )||(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")).equalsIgnoreCase("N") && Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED")).equalsIgnoreCase("Y"))))
						{
							hshResult.put("strgstnfalg","Y");

						}
						
						
						if(strgstnchk.equalsIgnoreCase("Y")){
							String[] strArr=Helper.correctNull(rs1.getString("COMINFO_GSTIN")).split("@");
							for(int a=0;a<strArr.length;a++)
							{
								if (a == 0) {
									strgstnumber = strArr[a];
								} else {
									strgstnumber = strgstnumber+" , "+strArr[a];

								}
							}							
						}else if(strgstnchk.equalsIgnoreCase("N")){
							strgstnumber=Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
							strgstnumber="exempted";
						}

						hshResult.put("strgstnumber",strgstnumber);

					}
					hshResult.put("strEligBasedon",Helper.correctNull(rs.getString("com_eligiblebasedon")));
					hshResult.put("strgecltype",Helper.correctNull(rs.getString("STATIC_DATA_GECLDESC")));

				}
				
				if(!Helper.correctNull((String)hshValues.get("sel_eligibility")).equalsIgnoreCase("") && bflag) 
				{
					listRow=new ArrayList();
										if(rs!=null)
						rs.close();
					rs=DBUtils.executeLAPSQuery("sel_com_ksaeassessment1^"+strAppno+"^"+(String)hshValues.get("sel_eligibility")+"^"+strgeclident);
					while(rs.next())
					{
						listCol=new ArrayList();
						listCol.add(Helper.correctNull(rs.getString("question")));
						listCol.add(Helper.correctNull(rs.getString("com_comments")));
						listCol.add(Helper.correctNull(rs.getString("com_eligible")));
						listCol.add(Helper.correctNull(rs.getString("com_ksaeeligibleid")));
						listCol.add(Helper.correctNull(rs.getString("stat_data_descvalue1")));
						listCol.add(Helper.correctNull(rs.getString("STAT_DATA_VALUEDESC")));
						listCol.add(Helper.correctNull(rs.getString("STATIC_DATA_MAXVAL")));//6
						listCol.add(Helper.correctNull(rs.getString("STATIC_DATA_SECTOR")));//7
						rs1 = DBUtils.executeLAPSQuery("sel_geclcusdetails^"
								+ Helper.correctNull((String) hshValues
										.get("hidapplicantnewid")));
						if(rs1.next()){
							listCol.add(Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")));//8
							listCol.add(Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")));//9
							listCol.add(Helper.correctNull(rs1.getString("COMINFO_GSTIN")));//10
							listCol.add(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")));//11
							listCol.add(Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED")));//12
							listCol.add(Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")));//13
							
							hshResult.put("PERAPP_CONSTITUTION",Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")));
							hshResult.put("PERAPP_LEGAL_ENTITYID",Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")));
							hshResult.put("PERAPP_LEGAL_EXPIRYDATE",Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")));
							
					        }
						else{
				        	listCol.add("");//8
							listCol.add("");//9
							listCol.add("");//10
							listCol.add("");//11
							listCol.add("");//10
							listCol.add("");//11
				        }
						strQuery=SQLParser.getSqlQuery("sel_amtgeclchk^"+strAppno);
						rs2=DBUtils.executeQuery(strQuery);
						if(rs2.next())
						{
							listCol.add(Helper.correctNull(rs2.getString("com_details")));
						}else{
							listCol.add("");//8
						}
						listRow.add(listCol);
						strinputval=Helper.correctNull(rs.getString("STAT_DATA_VALUEDESC"));
						strgstnchk=Helper.correctNull(rs1.getString("COMINFO_GSTINREG"));
						if(strinputval.equalsIgnoreCase("LC")){
							if(!Helper.correctNull(rs1.getString("PERAPP_CONSTITUTION")).equalsIgnoreCase("01")&&(Helper.correctNull(rs1.getString("PERAPP_LEGAL_ENTITYID")).equalsIgnoreCase("")||Helper.correctNull(rs1.getString("PERAPP_LEGAL_EXPIRYDATE")).equalsIgnoreCase(""))){
								hshResult.put("strlegalchk","Y");
							}
						}else if(strinputval.equalsIgnoreCase("NS")){
							hshResult.put("strnameofsector",Helper.correctNull(rs.getString("com_comments")));

						}else if(strinputval.equalsIgnoreCase("GRN")){
							if(!(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")).equalsIgnoreCase("Y" )||(Helper.correctNull(rs1.getString("COMINFO_GSTINREG")).equalsIgnoreCase("N") && Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED")).equalsIgnoreCase("Y"))))
							{
								hshResult.put("strgstnfalg","Y");

							}
							if(strgstnchk.equalsIgnoreCase("Y")){
								String[] strArr=Helper.correctNull(rs1.getString("COMINFO_GSTIN")).split("@");
								for(int a=0;a<strArr.length;a++)
								{
									if (a == 0) {
										strgstnumber = strArr[a];
									} else {
										strgstnumber = strgstnumber+" , "+strArr[a];

									}
								}							
							}else if(strgstnchk.equalsIgnoreCase("N")){
								strgstnumber=Helper.correctNull(rs1.getString("COMINFO_GST_EXEMPTED"));
								strgstnumber="Yes";
							}

							hshResult.put("strgstnumber",strgstnumber);

						}
						hshResult.put("strEligBasedon",Helper.correctNull(rs.getString("com_eligiblebasedon")));
						hshResult.put("strgecltype",Helper.correctNull(rs.getString("STATIC_DATA_GECLDESC")));
					}
					
				}
				
				hshResult.put("listRow",listRow);
				hshResult.put("flowtype1",Helper.correctNull((String)hshValues.get("flowtype1")));
			}
			else if(strPageVal.equalsIgnoreCase("FIDPN"))
			{
				String strFacSno=Helper.correctInt((String)hshValues.get("sel_facilitysno"));
				listRow=new ArrayList();
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_dpn_assesmentdetails^"+strAppno+"^"+strPageVal+"^"+strFacSno);
				while(rs.next())
				{
					listCol=new ArrayList();
					listCol.add(Helper.correctNull(rs.getString("com_description")));
					listCol.add(Helper.correctNull(rs.getString("com_details")));
					listRow.add(listCol);
				}
				hshResult.put("listDPN",listRow);
				hshResult.put("flowtype1",Helper.correctNull((String)hshValues.get("flowtype1")));
				
				ArrayList listAcc=new ArrayList();
				ArrayList listAccRow=new ArrayList();
				ArrayList listAccCol=new ArrayList();
				double dblValue=0.0;
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_intdefaccountno^"+strAppno+"^"+strFacSno);
				if(rs.next())
				{
					hshResult.put("strDPNAccno",Helper.correctNull(rs.getString("fac_intdefermentdetails")));
					hshResult.put("strFacProposed",Helper.correctNull(rs.getString("facility_proposed")));
					if(rs1!=null)
						rs1.close();
					rs1=DBUtils.executeLAPSQuery("sel_facilitysancDetails^"+Helper.correctNull(rs.getString("fac_intdefermentdetails"))+"^"+Helper.correctNull(rs.getString("fac_intdefermentdetails")));
					if(rs1.next())
					{
						hshResult.put("strExistingLim",Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(rs1.getString("facility_sancamt")))));
					}
				}
				hshResult.put("strFacilitysno", strFacSno);
				
			}
			else if(strPageVal.equalsIgnoreCase("MMithra"))
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_com_assesmentdetails^"+strAppno+"^"+strPageVal);
				while(rs.next())
				{
					hshResult.put("strAmount"+Helper.correctNull(rs.getString("com_sno")),Helper.correctNull(rs.getString("com_details")));
				}
				hshResult.put("flowtype1",Helper.correctNull((String)hshValues.get("flowtype1")));
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selloanagainstparams^127");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strMithraMargin",correctNull(rs.getString("LOAN_PARAMVAL")));
				}
				
				if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("sum_mmithrafacamt^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strMithraFacTot",correctNull(rs.getString("total")));
				}
				
				
			}
			else if(strPageVal.equalsIgnoreCase("GECL")||strPageVal.equalsIgnoreCase("GECL-Restructure"))
			{
				if(rs!=null)
					rs.close();
				rs=DBUtils.executeLAPSQuery("sel_com_assesmentdetails^"+strAppno+"^"+strPageVal);
				while(rs.next())
				{
					hshResult.put("strAmount"+Helper.correctNull(rs.getString("com_sno")),Helper.correctNull(rs.getString("com_details")));
				}
				hshResult.put("flowtype1",Helper.correctNull((String)hshValues.get("flowtype1")));
				if(rs!=null)
					rs.close();
				/*strQuery=SQLParser.getSqlQuery("selloanagainstparams^129");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strGECL1",correctNull(rs.getString("LOAN_PARAMVAL")));
				}
				strQuery=SQLParser.getSqlQuery("selloanagainstparams^130");
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strGECL2",correctNull(rs.getString("LOAN_PARAMVAL")));
				}*/
								if(rs!=null)
					rs.close();
				strQuery=SQLParser.getSqlQuery("selsumproposed^"+strAppno);
				rs = DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("strFacProposed",correctNull(rs.getString("facility_proposed")));
				}
				rs=DBUtils.executeLAPSQuery("sel_com_ksaeassessment^"+strAppno);
				String strassgecl="",stramt="",strgecl3amt="";
				double dblamt=0.0;
				while(rs.next())
				{
					strassgecl=correctNull(rs.getString("STAT_DATA_VALUEDESC"));
					if(strassgecl.equalsIgnoreCase("OCC")){
						stramt=correctNull(rs.getString("com_comments"));

					}
					if(strassgecl.equalsIgnoreCase("AO")){
						strgecl3amt=correctNull(rs.getString("com_comments"));

					}

				}
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
				rs1=DBUtils.executeLAPSQuery("sel_gecl1exissancamt^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
				if(rs1.next()){
					dblgecl1TotAmount=Double.parseDouble((String)Helper.correctDouble(rs1.getString("totallimit")));

				}
				rs=DBUtils.executeLAPSQuery("sel_gecl2exissancamt^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
				if(rs.next()){
					dblgecl2TotAmount=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));

				}
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
				hshResult.put("dblgecl1TotAmount",String.valueOf(dblgecl1TotAmount));
				hshResult.put("dblgecl2TotAmount",String.valueOf(dblgecl2TotAmount));

				hshResult.put("stramt",stramt);
				hshResult.put("strgecl3amt",strgecl3amt);

				log.info("<<<<<<<<<<<<<<<==============stramt===========>>>>>>>>>>>>>>"+stramt);
			}
			
			double gecl1sno1=0.00,gecl1sno2=0.00,gecl1sno3=0.00,gecl1sno4=0.00,gecl1sno5=0.00;
			double gecl1sno6=0.00,gecl1sno7=0.00,gecl1sno8=0.00,gecl1sno9=0.00,gecl1sno10=0.00;
			double gecl1sno11=0.00,gecl1sno12=0.00,gecl1sno13=0.00,gecl1sno14=0.00,gecl1sno15=0.00,gecl1sno23=0.00,COM_GECL1EXT_MAXELGFINANCE=0.00,gecl1sno24=0.00;
			boolean eglflag=false;
			if(strgeclident.equalsIgnoreCase("GECL -1 extension"))
			{
				
        rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eglflag=true;
				gecl1sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eglflag=true;
				gecl1sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			//gecl1sno3=gecl1sno1+gecl1sno2;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eglflag=true;
				gecl1sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eglflag=true;
				gecl1sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
//			gecl1sno6=gecl1sno4+gecl1sno5;
//			gecl1sno7=gecl1sno1+gecl1sno4;
//			gecl1sno8=gecl1sno2+gecl1sno5;
//			gecl1sno9=gecl1sno7+gecl1sno8;
			
			
			rs=DBUtils.executeLAPSQuery("sel_geclidentchkgecl1^"+strAppno);//COM_GECL1EXT_MAXLIMITBORRO,COM_GECL1EXT_MAXELGFINANCE,COM_GECL1EXT_ELGFINANCE
			if(rs.next()){
				gecl1sno10=Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_GECL1EXT_MAXELGFINANCE")));
				gecl1sno23=Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_GECL1EXT_ELGFINANCE")));
				COM_GECL1EXT_MAXELGFINANCE=Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_GECL1EXT_MAXELGFINANCE")));
		}
			//gecl1sno10=gecl1sno10*30/100;
			
			
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1exissancamtsumofext1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl1sno11=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1exissancamtsumofext1geclrestr^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl1sno12=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			
			
			//gecl1sno13=gecl1sno12+gecl1sno11;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1exissancamtsumofext1facility_proposed^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl1sno24=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			boolean g1flag=false;
			if(String.valueOf(gecl1sno1).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g1flag=true;
				gecl1sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl1sno2).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"2");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g1flag=true;
				gecl1sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl1sno4).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"4");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g1flag=true;
				gecl1sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl1sno5).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"5");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g1flag=true;
				gecl1sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			
			if(!eglflag && !g1flag)
			{
				eglflag=true;
			}
	        
			if(eglflag)
			{	
			if(!g1flag && Integer.parseInt(usr_class)>=130 )
			{
				strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl1sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			
			if(!g1flag && Integer.parseInt(usr_class)>=130)
			{
				strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"2");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl1sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			
			if(!g1flag && Integer.parseInt(usr_class)>=130)
			{
				strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"4");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl1sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			
			if(!g1flag && Integer.parseInt(usr_class)>=130)
			{
				strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessment^"+strAppno+"^"+"5");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl1sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
			}
			
			}
			
			strQuery=SQLParser.getSqlQuery("sel_gecl1ext1snocomassessmentval^"+strAppno+"^"+"23");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("gecl1sno23sanques",(String)Helper.correctNull(rs.getString("COM_DESCRIPTION")));
				hshResult.put("gecl1sno23san " ,String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("com_details")))));
			}
			
			
			
			
			hshResult.put("gecl1sno1",String.valueOf(gecl1sno1));
			hshResult.put("gecl1sno2",String.valueOf(gecl1sno2));
			hshResult.put("gecl1sno3",String.valueOf(gecl1sno3));
			hshResult.put("gecl1sno4",String.valueOf(gecl1sno4));
			hshResult.put("gecl1sno5",String.valueOf(gecl1sno5));
			hshResult.put("gecl1sno6",String.valueOf(gecl1sno6));
			hshResult.put("gecl1sno7",String.valueOf(gecl1sno7));
			hshResult.put("gecl1sno8",String.valueOf(gecl1sno8));
			hshResult.put("gecl1sno9",String.valueOf(gecl1sno9));
			
			
		//	double gecl1snoh=(gecl1sno7*gecl1sno10)/100;
			
			
			hshResult.put("gecl1sno10",String.valueOf(gecl1sno10));
			
			hshResult.put("gecl1sno11",String.valueOf(gecl1sno11));
			//gecl1sno12=gecl1sno12*10/100;
			hshResult.put("gecl1sno12",String.valueOf(gecl1sno12));
			//hshResult.put("gecl1sno13",String.valueOf(gecl1sno13));
			hshResult.put("gecl1sno23",String.valueOf(gecl1sno23));
			hshResult.put("gecl1sno24",String.valueOf(gecl1sno24));
			
			
			hshResult.put("dbl_proptotval",String.valueOf(gecl1sno24));
			
			strQuery=SQLParser.getSqlQuery("sel_geclextmaxrange^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("gecl1maxamount",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_RANGETO")))));
			}
			
			
			
			
			}
			
			
			
			double gecl2sno1=0.00,gecl2sno2=0.00,gecl2sno3=0.00,gecl2sno4=0.00,gecl2sno5=0.00;
			double gecl2sno6=0.00,gecl2sno7=0.00,gecl2sno8=0.00,gecl2sno9=0.00,gecl2sno10=0.00;
			double gecl2sno11=0.00,gecl2sno12=0.00,gecl2sno13=0.00,gecl2sno14=0.00,gecl2sno15=0.00,gecl2sno23=0.00,gecl2sno24=0.00;
			double COM_GECL2EXT_MAXELGFINANCE=0.00,COM_GECL2EXT_ELGFINANCE=0.00,COM_GECL3EXT_MAXELGFINANCE=0.00,COM_GECL3EXT_ELGFINANCE=0.00;
			boolean eg2flag=false;
			if(strgeclident.equalsIgnoreCase("GECL -2 extension"))
			{
        rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg2flag=true;
				gecl2sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg2flag=true;
				gecl2sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			//gecl1sno3=gecl1sno1+gecl1sno2;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg2flag=true;
				gecl2sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl2extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg2flag=true;
				gecl2sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
//			gecl1sno6=gecl1sno4+gecl1sno5;
//			gecl1sno7=gecl1sno1+gecl1sno4;
//			gecl1sno8=gecl1sno2+gecl1sno5;
//			gecl1sno9=gecl1sno7+gecl1sno8;
			
			
			rs=DBUtils.executeLAPSQuery("sel_geclidentchkgecl1^"+strAppno);//COM_GECL1EXT_MAXLIMITBORRO,COM_GECL1EXT_MAXELGFINANCE,COM_GECL1EXT_ELGFINANCE
			if(rs.next()){
				hshResult.put("COM_GECL2EXT_MAXELGFINANCE",Helper.correctNull(rs.getString("COM_GECL2EXT_MAXELGFINANCE")));
		    	hshResult.put("COM_GECL2EXT_ELGFINANCE",Helper.correctNull(rs.getString("COM_GECL2EXT_ELGFINANCE")));
		    	
				
		}
			
			
	    	
			//gecl1sno10=gecl1sno10*30/100;
			
			
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1ext2oanalreadyavail^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl2sno11=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
//			rs=DBUtils.executeLAPSQuery("sel_gecl1exissancamtsumofext1geclrestr^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
//			if(rs.next()){
//				gecl1sno12=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
//		}
			
			
			
			//gecl1sno13=gecl1sno12+gecl1sno11;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1ext2_proposed^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl2sno24=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			boolean g2flag=false;
			if(String.valueOf(gecl2sno1).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g2flag=true;
				gecl2sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl2sno2).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"2");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g2flag=true;
				gecl2sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl2sno4).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"4");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g2flag=true;
				gecl2sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl2sno5).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"5");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g2flag=true;
				gecl2sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(!eg2flag && !g2flag)
			{
				eg2flag=true;
			}
	        
			if(eg2flag)
			{	
			if(!g2flag && Integer.parseInt(usr_class)>=130 )
			{
			
			
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				
				gecl2sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(!g2flag && Integer.parseInt(usr_class)>=130 )
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"2");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				gecl2sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(!g2flag && Integer.parseInt(usr_class)>=130 )
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"4");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				gecl2sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(!g2flag && Integer.parseInt(usr_class)>=130 )
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl2ext1snocomassessment^"+strAppno+"^"+"5");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				gecl2sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			}
			
			
			hshResult.put("gecl2sno1",String.valueOf(gecl2sno1));
			hshResult.put("gecl2sno2",String.valueOf(gecl2sno2));
			hshResult.put("gecl2sno3",String.valueOf(gecl2sno3));
			hshResult.put("gecl2sno4",String.valueOf(gecl2sno4));
			hshResult.put("gecl2sno5",String.valueOf(gecl2sno5));
			hshResult.put("gecl2sno6",String.valueOf(gecl2sno6));
			hshResult.put("gecl2sno7",String.valueOf(gecl2sno7));
			hshResult.put("gecl2sno8",String.valueOf(gecl2sno8));
			hshResult.put("gecl2sno9",String.valueOf(gecl2sno9));
			
			
		//	double gecl1snoh=(gecl1sno7*gecl1sno10)/100;
			
			
			hshResult.put("gecl2sno10",String.valueOf(gecl2sno10));
			
			hshResult.put("gecl2sno11",String.valueOf(gecl2sno11));
			//gecl1sno12=gecl1sno12*10/100;
			hshResult.put("gecl2sno12",String.valueOf(gecl2sno12));
			//hshResult.put("gecl1sno13",String.valueOf(gecl1sno13));
			hshResult.put("gecl2sno23",String.valueOf(gecl2sno23));
			hshResult.put("gecl2sno24",String.valueOf(gecl2sno24));
			
			hshResult.put("dbl_proptotval",String.valueOf(gecl2sno24));
			
			
			
			strQuery=SQLParser.getSqlQuery("sel_geclextmaxrange2^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("gecl2maxamount",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_RANGETO")))));
			}
			
			
			
			
			}
			
			
			
			double gecl3sno1=0.00,gecl3sno2=0.00,gecl3sno3=0.00,gecl3sno4=0.00,gecl3sno5=0.00;
			double gecl3sno6=0.00,gecl3sno7=0.00,gecl3sno8=0.00,gecl3sno9=0.00,gecl3sno10=0.00;
			double gecl3sno11=0.00,gecl3sno12=0.00,gecl3sno13=0.00,gecl3sno14=0.00,gecl3sno15=0.00,gecl3sno23=0.00,gecl3sno24=0.00;
			boolean eg3flag=false;
			if(strgeclident.equalsIgnoreCase("GECL -3 extension"))
			{
        rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg3flag=true;
				gecl3sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg3flag=true;
				gecl3sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			//gecl1sno3=gecl1sno1+gecl1sno2;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt4^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg3flag=true;
				gecl3sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexissancamt5^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				eg3flag=true;
				gecl3sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
//			gecl1sno6=gecl1sno4+gecl1sno5;
//			gecl1sno7=gecl1sno1+gecl1sno4;
//			gecl1sno8=gecl1sno2+gecl1sno5;
//			gecl1sno9=gecl1sno7+gecl1sno8;
			
			
			rs=DBUtils.executeLAPSQuery("sel_geclidentchkgecl1^"+strAppno);//COM_GECL1EXT_MAXLIMITBORRO,COM_GECL1EXT_MAXELGFINANCE,COM_GECL1EXT_ELGFINANCE
			if(rs.next()){
				hshResult.put("COM_GECL3EXT_MAXELGFINANCE",Helper.correctNull(rs.getString("COM_GECL3EXT_MAXELGFINANCE")));
		    	hshResult.put("COM_GECL3EXT_ELGFINANCE",Helper.correctNull(rs.getString("COM_GECL3EXT_ELGFINANCE")));
		    	
		}
			//gecl1sno10=gecl1sno10*30/100;
			
			double gecl3sno101=0.00,gecl3sno102=0.00,gecl3sno103=0.00,gecl3sno121=0.00,gecl3sno122=0.00;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl1^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno101=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl1restr^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno102=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl1ext^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno103=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			gecl3sno10=gecl3sno101+gecl3sno102+gecl3sno103;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl2^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno121=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl2ext^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno122=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			gecl3sno12=gecl3sno121+gecl3sno122;
		
			rs=DBUtils.executeLAPSQuery("sel_gecl3extexistsangecl3^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno13=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			
			//gecl1sno13=gecl1sno12+gecl1sno11;
			
			rs=DBUtils.executeLAPSQuery("sel_gecl1ext3_proposed^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			if(rs.next()){
				gecl3sno24=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
		}
			
			
			
			hshResult.put("dbl_proptotval",String.valueOf(gecl3sno24));
			
			boolean g3flag=false;
			if(String.valueOf(gecl1sno1).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"1");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g3flag=true;
				gecl3sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl3sno2).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"2");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g3flag=true;
				gecl3sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl3sno4).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"4");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g3flag=true;
				gecl3sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			if(String.valueOf(gecl3sno5).equalsIgnoreCase("0.0"))
			{
			strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"5");
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				g3flag=true;
				gecl3sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
			}
			}
			
			
			if(!eg3flag && !g3flag)
			{
				eg3flag=true;
			}
			
			if(eg3flag)
			{
				if(!g3flag && Integer.parseInt(usr_class)>=130 )
				{
				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"1");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl3sno1=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				}
				
				if(!g3flag && Integer.parseInt(usr_class)>=130 )
				{
				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"2");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl3sno2=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				}
				
				if(!g3flag && Integer.parseInt(usr_class)>=130 )
				{
				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"4");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl3sno4=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				}
				
				if(!g3flag && Integer.parseInt(usr_class)>=130 )
				{
				strQuery=SQLParser.getSqlQuery("sel_gecl3ext1snocomassessment^"+strAppno+"^"+"5");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					
					gecl3sno5=Double.parseDouble((String)Helper.correctDouble(rs.getString("totallimit")));
				}
				}
				
			}
					
			
			hshResult.put("gecl3sno1",String.valueOf(gecl3sno1));
			hshResult.put("gecl3sno2",String.valueOf(gecl3sno2));
			hshResult.put("gecl3sno3",String.valueOf(gecl3sno3));
			hshResult.put("gecl3sno4",String.valueOf(gecl3sno4));
			hshResult.put("gecl3sno5",String.valueOf(gecl3sno5));
			hshResult.put("gecl3sno6",String.valueOf(gecl3sno6));
			hshResult.put("gecl3sno7",String.valueOf(gecl3sno7));
			hshResult.put("gecl3sno8",String.valueOf(gecl3sno8));
			hshResult.put("gecl3sno9",String.valueOf(gecl3sno9));
			
			
		//	double gecl1snoh=(gecl1sno7*gecl1sno10)/100;
			
			
			hshResult.put("gecl3sno10",String.valueOf(gecl3sno10));
			
			hshResult.put("gecl3sno11",String.valueOf(gecl3sno11));
			//gecl1sno12=gecl1sno12*10/100;
			hshResult.put("gecl3sno12",String.valueOf(gecl3sno12));
			hshResult.put("gecl3sno13",String.valueOf(gecl3sno13));
			hshResult.put("gecl3sno23",String.valueOf(gecl3sno23));
			hshResult.put("gecl3sno24",String.valueOf(gecl3sno24));
			hshResult.put("gecl3sno25",String.valueOf(gecl3sno24));
			
			
			
			
			strQuery=SQLParser.getSqlQuery("sel_geclextmaxrange3^"+strAppno);
			rs=DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("gecl3maxamount",String.valueOf(Double.parseDouble((String)Helper.correctDouble(rs.getString("COM_RANGETO")))));
			}
			
			
			
			
			}
			else
			{
				strQuery=SQLParser.getSqlQuery("sel_assessment_tl^"+strAppno+"^"+"35");
				rs=DBUtils.executeQuery(strQuery);
				if(rs.next())
				{
					hshResult.put("com_bgassessment",correctNull(Helper.CLOBToString(rs.getClob("com_assessment_comments"))));
				}
			}
			if(rs1!=null){
				rs1.close();
			}
			double dbl_propfundostotval=0.00,dbl_propnonfundostotval=0.00;
			strQuery=SQLParser.getSqlQuery("sel_geclfunchk^"+strAppno);
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				 if(Helper.correctNull((String)rs2.getString("com_factype")).equalsIgnoreCase("F"))
				{
					
					 dbl_propfundostotval+=Double.parseDouble(Helper.correctDouble((String)rs2.getString("proposedlimit")));
					
				}
				 else if(Helper.correctNull((String)rs2.getString("com_factype")).equalsIgnoreCase("NF"))
					{
						
					 dbl_propnonfundostotval+=Double.parseDouble(Helper.correctDouble((String)rs2.getString("proposedlimit")));
						
					}
			}
			if(rs2!=null){
				rs2.close();
			}
			double dbl_proptotval=0.00;
			strQuery=SQLParser.getSqlQuery("sel_geclfunchk^"+strAppno);
			rs2=DBUtils.executeQuery(strQuery);
			while(rs2.next())
			{
				
					
				dbl_proptotval+=Double.parseDouble(Helper.correctDouble((String)rs2.getString("proposedlimit")));
				
			}
			if(rs2!=null){
				rs2.close();
			}
			log.info("<<<<<<<<<<<<<<<=====================proposed limit of Borrower======================>>>>>>>>>>>>>>>"+dbl_proptotval);
			hshResult.put("dbl_proptotval",String.valueOf(dbl_proptotval));
			hshResult.put("dbl_propfundostot",String.valueOf(dbl_propfundostotval));
			hshResult.put("dbl_propnonfundostot",String.valueOf(dbl_propnonfundostotval));
			if(rs!=null){
				rs.close();
			}
			strQuery=SQLParser.getSqlQuery("sel_gecl3crichk^"+strAppno);
			rs = DBUtils.executeQuery(strQuery);
			if(rs.next())
			{
				hshResult.put("strgeclassesamt",Helper.correctNull(rs.getString("COM_DETAILS")));
				log.info("<<<=====strgeclassesamt==>>>"+Helper.correctNull(rs.getString("COM_DETAILS")));
			}
			if(rs1!=null){
				rs1.close();
			}
			
			rs1=DBUtils.executeLAPSQuery("sel_gecl4exissancamt^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
			while (rs1.next()) 
			{
				dblgeclproposedamt+=dbl_proptotval+Double.parseDouble(Helper.correctDouble(rs1.getString("totallimit")));	
			}
			log.info("<<<<<<<<<==========dblgeclproposedamt================>>>>>>>>"+dblgeclproposedamt);
			hshResult.put("dblgeclproposedamt",String.valueOf(dblgeclproposedamt));
			if(rs1!=null){
				rs1.close();
			}
			rs1=DBUtils.executeLAPSQuery("sel_geclidentchk^"+strAppno);
	        if(rs1.next()){
				hshResult.put("COM_GECL4_LIMITPROPOSED",Helper.correctNull(rs1.getString("COM_GECL4_LIMITPROPOSED")));
				hshResult.put("COM_BAL_OUTSTANDING",Helper.correctNull(rs1.getString("COM_BAL_OUTSTANDING")));
				

	        }
	        if(rs1!=null){
				rs1.close();
			}
	        
	        
	        

			
			
			
	        
	        double dblgecl1borrowerourbankamt=0.00;
			rs1=DBUtils.executeLAPSQuery("sel_gecl1_borroweramt^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));
	        while(rs1.next()){
	        	dblgecl1borrowerourbankamt+=Double.parseDouble(Helper.correctDouble(rs1.getString("COM_DETAILS")));	
	        }
	        log.info("<<<<<<<<<==========dblgecl1borrowerourbankamt================>>>>>>>>"+dblgecl1borrowerourbankamt);
			hshResult.put("dblgecl1borrowerourbankamt",String.valueOf(dblgecl1borrowerourbankamt));
			
			
			if(rs1!=null){
				rs1.close();
			}
			int countval=0;
			rs=DBUtils.executeLAPSQuery("sel_geclfacilities^"+Helper.correctNull((String)hshValues.get("hidapplicantid")));				 
			while(rs.next())
			{
				  if(Helper.correctNull(rs.getString("com_gecltype")).equalsIgnoreCase("GECL3")&& Helper.correctNull(rs.getString("FACILITY_STATUS")).equalsIgnoreCase("pa")){
					 countval++;
					
				  }
				 
			}
			if(countval>0){
				  hshResult.put("strgecl3propstatus","Y");

			}else{
				  hshResult.put("strgecl3propstatus","N");
			}
			
			
			
			rs1=DBUtils.executeLAPSQuery("workflowusersanlimit^"+strUserId);
	        if(rs1.next()){
				hshResult.put("usr_class",Helper.correctNull(rs1.getString("usr_class")));
				hshResult.put("org_level",Helper.correctNull(rs1.getString("org_level")));
				
	        }
	        if(rs1!=null){
				rs1.close();
			}
}
		catch(Exception e)
		{
			log.error("error occured in com_assessment_comments"+e.toString());
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
				log.error("error occured in getBGassessment"+e1.toString());
			}
		}
		return hshResult;
		
	}
	
	public HashMap getSancAuthority(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null;
		String strQuery="";
		int a=0;
		
		String strValue=Helper.correctNull((String)hshValues.get("sancdept"));
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			if(strValue.equalsIgnoreCase("006"))
				strValue="RO";
			else if(strValue.equalsIgnoreCase("007"))
				strValue="Branch";
			else if(strValue.equalsIgnoreCase("008"))
				strValue="HEAD,LCFD";
			else if(strValue.equalsIgnoreCase("010"))
				strValue="HEAD,RFD";
			else if(strValue.equalsIgnoreCase("011"))
				strValue="CPC";
			else if(strValue.equalsIgnoreCase("012"))
				strValue="CLPH";
			else if(strValue.equalsIgnoreCase("013"))
				strValue="HEAD,RFD";
			else if(strValue.equalsIgnoreCase("014"))
				strValue="HEAD,MCFD";
			else if(strValue.equalsIgnoreCase("000"))
				strValue="HEAD";
			else if(strValue.equalsIgnoreCase("015"))
				strValue="HEAD";
			else if(strValue.equalsIgnoreCase("016"))
				strValue="HEAD";
			else if(strValue.equalsIgnoreCase("017"))
				strValue="HEAD";
			else if(strValue.equalsIgnoreCase("018"))
				strValue="RLPC";
			
			strQuery=SQLParser.getSqlQuery("sel_sanauthoritycode^15^"+strValue);
			rs=DBUtils.executeQuery(strQuery);
			while(rs.next())
			{
				arrCol=new ArrayList();
				arrCol.add(correctNull(rs.getString("cbs_static_data_code")));
				arrCol.add(correctNull(rs.getString("cbs_static_data_desc")));
				arrCol.add(correctNull(rs.getString("cbs_static_data_show")));
				if(correctNull(rs.getString("cbs_static_data_show")).equalsIgnoreCase("E"))
					a++;
				arrRow.add(arrCol);
			}
			hshResult.put("arrRow",arrRow);
			hshResult.put("strEnabledcnt",String.valueOf(a));
			hshResult.put("strSancAuth",Helper.correctNull((String)hshValues.get("sancauth")));
		}
		catch(Exception e)
		{
			log.error("error occured in com_assessment_comments"+e.toString());
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
				log.error("error occured in getBGassessment"+e1.toString());
			}
		}
		return hshResult;
		
	}
	
	public void updateRBIGuidelines_restr(HashMap hsh) 
	{
		HashMap hshQueryValues = new HashMap();
		HashMap hshQuery = null;
		ArrayList arrValues=new ArrayList();
		String strAction=correctNull((String)hsh.get("hidAction"));
		String appno="";
		String[] strSlno=null; 
		String[] strguidelines=null; 
		String[] strchkbox=null; 
		String[] strCompliances=null; 
		String[] strtxtGuidelines=null; 
	
		
		appno=correctNull((String)hsh.get("appno"));
		if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
		{
			 appno=correctNull((String)hsh.get("app_no"));
		}
		else if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
		{
			 appno=correctNull((String)hsh.get("strappno"));
		}
		try
		{
			String strPagetype=Helper.correctNull((String)hsh.get("strPageType"));
			if(hsh.get("hidslno") instanceof String)
			{
				strSlno=new String[1];
				strSlno[0]=Helper.correctNull((String)hsh.get("hidslno"));
			}
			else
			{
				strSlno=(String[])hsh.get("hidslno");
			}
			
			if(hsh.get("hidguidelines") instanceof String)
			{
				strguidelines=new String[1];
				strguidelines[0]=Helper.correctNull((String)hsh.get("hidguidelines"));
			}
			else
			{
				strguidelines=(String[])hsh.get("hidguidelines");
			}
			
			if(hsh.get("hidchkbox") instanceof String)
			{
				strchkbox=new String[1];
				strchkbox[0]=Helper.correctNull((String)hsh.get("hidchkbox"));
			}
			else
			{
				strchkbox=(String[])hsh.get("hidchkbox");
			}
			
			if(hsh.get("txt_compliances") instanceof String)
			{
				strCompliances=new String[1];
				strCompliances[0]=Helper.correctNull((String)hsh.get("txt_compliances"));
			}
			else
			{
				strCompliances=(String[])hsh.get("txt_compliances");
			}
			if(hsh.get("txt_guideliness") instanceof String)
			{
				strtxtGuidelines=new String[1];
				strtxtGuidelines[0]=Helper.correctNull((String)hsh.get("txt_guideliness"));
			}
			else
			{
				strtxtGuidelines=(String[])hsh.get("txt_guideliness");
			}
			
			
			
			if(strAction.trim().equals("edit"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","rbiguidelines_restr_del");			
				arrValues.add(appno);
				arrValues.add(strPagetype);
				hshQuery.put("arrValues",arrValues);				
				hshQueryValues.put("1",hshQuery);				
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
				
				for(int i=0;i<strguidelines.length;i++)
				{
					if(strguidelines[i]!="")
					{
						hshQueryValues = new HashMap();
						hshQuery = new HashMap();	
						arrValues=new ArrayList();
						hshQueryValues.put("size","1");
						hshQuery.put("strQueryId","rbiguidelines_restr_ins");
						arrValues.add(appno);
						arrValues.add(strSlno[i]);
						arrValues.add(strguidelines[i]);	
						arrValues.add(strCompliances[i]);
						arrValues.add(strchkbox[i]);
						arrValues.add(strtxtGuidelines[i]);
						arrValues.add(strPagetype);
						hshQuery.put("arrValues",arrValues);
						hshQueryValues.put("1",hshQuery);
						EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
					}
				}
			}
			else if(strAction.trim().equals("delete"))
			{
				hshQueryValues = new HashMap();
				hshQuery = new HashMap();					
				hshQueryValues.put("size","1");				
				hshQuery.put("strQueryId","rbiguidelines_restr_del");			
				arrValues.add(appno);
				arrValues.add(strPagetype);
				hshQuery.put("arrValues",arrValues);			
				hshQueryValues.put("1",hshQuery);			
				EJBInvoker.executeStateLess("dataaccess",hshQueryValues,"updateData");
			}
		}
		catch(Exception ce)
		{
			throw new EJBException("inside update"+ce.toString());
		}			
	}
	
	public HashMap getRBIGuidelines_restr(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		String appno="",strPagetype="";
		boolean flag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			strPagetype=Helper.correctNull((String)hsh.get("strPageType"));
			if(strPagetype.equalsIgnoreCase(""))
				strPagetype="G";
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("app_no"));
			}
			else if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("strappno"));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			strQuery = SQLParser.getSqlQuery("rbiguidelines_restr_sel^"+appno+"^"+strPagetype);
			rs=DBUtils.executeQuery(strQuery);
			flag=rs.next();	
			
			if(flag==true)
			{
				do
				{
					arrCol=new ArrayList();
					arrCol.add(Helper.correctNull((String)rs.getString("restr_rbi_slno")));
					arrCol.add(Helper.correctNull((String)rs.getString("restr_rbi_guidelines")));
					arrCol.add(Helper.correctNull((String)rs.getString("restr_rbi_compliance")));
					arrCol.add(Helper.correctNull((String)rs.getString("restr_rbi_chkbox")));
					arrCol.add(Helper.correctNull((String)rs.getString("restr_rbi_comments")));
					arrRow.add(arrCol);
				}while(rs.next());
			}
			else
			{
				if(rs!=null)
				{
					rs.close();
				}
				String strModuleType=Helper.correctNull((String)hsh.get("sessionModuleType"));
				if(strModuleType.equalsIgnoreCase("CORP"))
				{
					strModuleType="C";
				}
				else if(strModuleType.equalsIgnoreCase("AGR"))
				{
					strModuleType="A";
				}
				else if(strModuleType.equalsIgnoreCase("RET"))
				{
					strModuleType="P";
				}
					rs=DBUtils.executeLAPSQuery("sel_rbiguidelines_restr_Active^"+strModuleType+"^"+strPagetype);
					while(rs.next())
					{
						arrCol=new ArrayList();
						arrCol.add(Helper.correctNull((String)rs.getString("rbi_restr_sno")));
						arrCol.add(Helper.correctNull((String)rs.getString("rbi_restr_desc")));
						arrCol.add("");
						arrCol.add("0");
						arrCol.add("");
						arrRow.add(arrCol);
					}
				}
				
			
			

			
			hshValues.put("arrRow",arrRow);
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
			catch(Exception ce)
			{
				throw new EJBException("Error in getData login  "+ce.toString());
		 	}
		}
		return hshValues;
	}
	
	public void updateRestructuringAss(HashMap hsh) 
	{
		HashMap hshqueryval =new HashMap();
		HashMap hshquery = new HashMap();
		ArrayList arr = new ArrayList();
		String strValue="",strQuery ="";
		ResultSet rs = null;
		String  strAction="";
		try
		{
			
			strValue=correctNull((String)hsh.get("appno"));
			strAction=correctNull((String)hsh.get("hidAction"));
			
			
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_com_restr_assessment");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","ins_com_restr_assessment");
				arr.add(strValue);
				arr.add(Helper.correctNull((String)hsh.get("txt_project_details")));
				arr.add(Helper.correctNull((String)hsh.get("txt_restr_reasons")));
				arr.add(Helper.correctNull((String)hsh.get("txt_restr_justification")));
				arr.add(Helper.correctNull((String)hsh.get("txt_exirepay_schedule")));
				arr.add(Helper.correctNull((String)hsh.get("txt_revised_repayschedule")));
				hshquery.put("arrValues",arr);
				hshqueryval.put("2",hshquery);
				hshqueryval.put("size","2");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshqueryval = new HashMap();
				hshquery = new HashMap();		
				arr=new ArrayList();
				hshquery.put("strQueryId","del_com_restr_assessment");
				arr.add(strValue);
				hshquery.put("arrValues",arr);
				hshqueryval.put("1",hshquery);
				hshqueryval.put("size","1");
				EJBInvoker.executeStateLess("dataaccess",hshqueryval,"updateData");
			}				
		}
		catch(Exception ce)
		{
			throw new EJBException("Error in updateRestructuringAssessment  "+ce.toString());
		}finally
		{
			try
			{
				if(rs!=null)
					rs.close();
			}catch(Exception exp)
			{
				throw new EJBException("Error in closing the connection in updateCompany "+ exp.toString()); 
			}
		}
	}
	public HashMap getRestructuringAss(HashMap hsh) 
	{
		String strQuery="";
		ResultSet rs=null;
		HashMap hshValues = new HashMap();
		ArrayList arrCol=null;
		ArrayList arrRow=new ArrayList();
		String appno="";
		boolean flag=false;
		try
		{
			appno=correctNull((String)hsh.get("appno"));
			if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("app_no"));
			}
			else if(appno.equalsIgnoreCase("")||appno.equalsIgnoreCase("null")||appno.equalsIgnoreCase(null))
			{
				 appno=correctNull((String)hsh.get("strappno"));
			}
			
			if(rs!=null)
			{
				rs.close();
			}
			rs=DBUtils.executeLAPSQuery("sel_com_restr_assessment^"+appno);
			if(rs.next())
			{
				hshValues.put("com_proj_details",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_proj_details"))));
				hshValues.put("com_restr_reasons",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_restr_reasons"))));
				hshValues.put("com_restr_justification",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_restr_justification"))));
				hshValues.put("com_exi_repayschedule",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_exi_repayschedule"))));
				hshValues.put("com_revised_repayschedule",Helper.correctNull(Helper.CLOBToString(rs.getClob("com_revised_repayschedule"))));
			}
		}		
		catch (Exception e)
		{
			log.error("error occured"+e.toString());
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
			catch(Exception ce)
			{
				throw new EJBException("Error in getRestructuringAssessment  "+ce.toString());
		 	}
		}
		return hshValues;
	}
	public HashMap getSancBranches(HashMap hshValues) 
	{
		HashMap hshResult=new HashMap();
		ResultSet rs=null,rs1=null;
		String strQuery="";
		int a=0;
		
		String strValue=Helper.correctNull((String)hshValues.get("sancdept"));
		ArrayList arrRow=new ArrayList();
		ArrayList arrCol=new ArrayList();
		try
		{
			
			strQuery=SQLParser.getSqlQuery("sel_cbsstaticdatacode^26^"+strValue);
			rs1=DBUtils.executeQuery(strQuery);
			if(rs1.next())
			{
				String[] strArr=correctNull(rs1.getString("cbs_static_sanc_refno")).split("@");
				
				String strVal="";
				if(strArr!=null && strArr.length>1)
				{
					for(int i=0;i<strArr.length;i++)
					{
						if(strVal.equalsIgnoreCase(""))
							strVal=strArr[i]+"'";
						else
							strVal+=",'"+strArr[i]+"'";
					}
				}
				if(!strVal.equalsIgnoreCase(""))
				{
					strQuery=SQLParser.getSqlQuery("sel_cbsstaticdatacode^131^"+strVal.substring(0, strVal.length()-1));
					rs=DBUtils.executeQuery(strQuery);
					while(rs.next())
					{
					arrCol=new ArrayList();
					arrCol.add(correctNull(rs.getString("cbs_static_data_code")));
					arrCol.add(correctNull(rs.getString("cbs_static_data_desc")));
					arrCol.add(correctNull(rs.getString("cbs_static_data_show")));
					if(correctNull(rs.getString("cbs_static_data_show")).equalsIgnoreCase("E"))
						a++;
					arrRow.add(arrCol);
					}
				}
			}
			hshResult.put("arrRow",arrRow);
			hshResult.put("strEnabledcnt",String.valueOf(a));
			hshResult.put("strSancBranch",Helper.correctNull((String)hshValues.get("sancbranch")));
		}
		
		
		
		catch(Exception e)
		{
			log.error("error occured in com_assessment_comments"+e.toString());
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
				log.error("error occured in getBGassessment"+e1.toString());
			}
		}
		return hshResult;
		
	}
	public HashMap getCgssdAssessment(HashMap hshValues) 
	{
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
		double dbl_propfundostot=0;
		java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
		nft= java.text.NumberFormat.getInstance();
		nft.setMaximumFractionDigits(3);
		nft.setMinimumFractionDigits(3);
		strAppno=correctNull((String)hshValues.get("appno"));
		String facilitysno=correctNull((String)hshValues.get("sel_facilitysno"));
        double dblcgssdperc=0.00,dblprodcgssdperc=0.00;
		try{
		 strQuery = SQLParser.getSqlQuery("sel_cgssd_asses^"+ strAppno+"^"+facilitysno);
	     rs = DBUtils.executeQuery(strQuery);
	     while(rs.next())
	    {
			hshValues.put("com_capita",Helper.correctNull((rs.getString("com_capita"))));
			hshValues.put("com_promoter",Helper.correctNull((rs.getString("com_promoter"))));
			hshValues.put("com_eligamount",Helper.correctNull((rs.getString("com_eligamount"))));
			hshValues.put("com_amountappl",Helper.correctNull((rs.getString("com_amountappl"))));
			hshValues.put("com_liability",Helper.correctNull((rs.getString("com_liability"))));
			hshValues.put("com_maxloan",Helper.correctNull((rs.getString("com_maxloan"))));
			hshValues.put("com_recamount",Helper.correctNull((rs.getString("com_recamount"))));
			hshValues.put("com_entiry_name",correctNull(rs.getString("com_entiry_name")));
			hshValues.put("com_operaccountnum",correctNull(rs.getString("com_operaccountnum")));
			hshValues.put("com_status",correctNull(rs.getString("com_status")));
			hshValues.put("com_npadate",correctNull(rs.getString("com_npadate")));
			hshValues.put("COM_CGSSD_FACSNO",correctNull(rs.getString("COM_CGSSD_FACSNO")));
			hshValues.put("COM_CGSSD_PERC",correctNull(rs.getString("COM_CGSSD_PERC")));
			hshValues.put("COM_MSME_CBSID",correctNull(rs.getString("COM_MSME_CBSID")));
			hshValues.put("COM_MSME_DPDNO",correctNull(rs.getString("COM_MSME_DPDNO")));
			hshValues.put("COM_ENTITY_RESTRUCTURE",correctNull(rs.getString("COM_ENTITY_RESTRUCTURE")));
			dblcgssdperc=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_CGSSD_PERC")));
		}
	     
			 strQuery = SQLParser.getSqlQuery("sel_cgssdperc^"+ strAppno+"^"+facilitysno);
		     rs = DBUtils.executeQuery(strQuery);
		     while(rs.next())
		    {
				hshValues.put("COM_CGSSDPERC",correctNull(rs.getString("COM_CGSSDPERC")));
				hshValues.put("COM_RANGETO",correctNull(rs.getString("COM_RANGETO")));
				dblprodcgssdperc=Double.parseDouble(Helper.correctDouble((String)rs.getString("COM_CGSSDPERC")));
		    }
		     if(dblcgssdperc!=dblprodcgssdperc &&dblcgssdperc!=0.0){
					hshValues.put("strcgssdpercflag","Y");

		     }else{
		    	   hshValues.put("strcgssdpercflag","N");
		     }
		     
		     strQuery=SQLParser.getSqlQuery("sel_proposed_limit^"+strAppno+"^"+facilitysno);
	    		rs1=DBUtils.executeQuery(strQuery);
	    		while(rs1.next())
	    		{
	    			dbl_propfundostot=Double.parseDouble(Helper.correctDouble((String)rs1.getString("facility_proposed")));
	    		}
	    		if(rs1!=null)
	    		{
	    			rs1.close();
	    		}
				  hshValues.put("dbl_propfundostot",String.valueOf(dbl_propfundostot));
				  
		hshValues.put("COM_CGSSD_FACSNO",facilitysno);

		}
	catch (Exception ce) {
		throw new EJBException("Error in getData of Limit of Loan ::  "+ ce.toString());
	} finally {
		try {
			if (rs != null)
				rs.close();

		} catch (Exception cf) {
			throw new EJBException("Error closing the connection "+ cf.getMessage());
		}
	}
		return hshValues;
	}

	public void updateCgssdAssessment(HashMap hshValues) 
	{
	
		HashMap hshQueryVal = new HashMap();
		HashMap hshQuery = new HashMap();
		ArrayList arrValues = new ArrayList();		
		ResultSet rs=null;
		String strSno = "";
		String strAppno="";
		String strAction="";
		String strQuery="",Strsno="";
		int intupdatesize=0;
		
		try
		{
			
			strAction=correctNull((String)hshValues.get("hidAction"));
			strAppno=correctNull((String)hshValues.get("appno"));
			Strsno=correctNull((String) hshValues.get("sel_facilitysno"));
			int intUpdatesize=0;
			String strnpastatus="",strcgssdperc="";
			strQuery = SQLParser.getSqlQuery("sel_cgssdperc^"+ strAppno+"^"+Strsno);
		     rs = DBUtils.executeQuery(strQuery);
		     while(rs.next())
		    {
		    	 strcgssdperc=correctNull(rs.getString("COM_CGSSDPERC"));
		    }
			if(strAction.equalsIgnoreCase("insert"))
			{
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_cgssd_asses");
				arrValues.add(strAppno);
				arrValues.add(Strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryVal.put("1",hshQuery);
				hshQueryVal.put("size","1");
				
				hshQuery = new HashMap();
				arrValues = new ArrayList();
				hshQuery.put("strQueryId", "ins_com_cgssdasses");
				intupdatesize++;
				arrValues.add(strAppno);
				arrValues.add(correctNull((String) hshValues.get("txt_cap_entity")));
				arrValues.add(correctNull((String) hshValues.get("txt_prom_stake")));
				arrValues.add(correctNull((String) hshValues.get("txt_eligamount")));
				arrValues.add(correctNull((String) hshValues.get("txt_amount")));
				arrValues.add(correctNull((String) hshValues.get("txt_liability")));
				arrValues.add(correctNull((String) hshValues.get("txt_maxloan")));
				arrValues.add(correctNull((String) hshValues.get("txt_recomended")));
				arrValues.add(correctNull((String) hshValues.get("txt_entity")));
				arrValues.add(correctNull((String) hshValues.get("txt_operaccountnum")));
				strnpastatus=Helper.correctNull((String) hshValues.get("sel_entitystatus"));
				arrValues.add(strnpastatus);

				if(strnpastatus.equalsIgnoreCase("S")){
					arrValues.add("");
				}else{
				arrValues.add(correctNull((String) hshValues.get("txt_datenpa")));
				}
				arrValues.add(strcgssdperc);
				arrValues.add(correctNull((String) hshValues.get("txt_cusid_msme")));
				arrValues.add(correctNull((String) hshValues.get("txt_dpd_msme")));
				arrValues.add(correctNull((String) hshValues.get("sel_entity_restructure")));
				arrValues.add(correctNull((String) hshValues.get("sel_facilitysno")));
				hshQuery.put("arrValues", arrValues);
				//hshquery.put("arrValues",arr);
				hshQueryVal.put("2",hshQuery);
				hshQueryVal.put("size","2");
				//EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
				//hshQueryVal.put(Integer.toString(intUpdatesize),hshQuery);	
			}
			if(strAction.equalsIgnoreCase("delete"))
			{
				hshQueryVal = new HashMap();
				hshQuery = new HashMap();		
				arrValues=new ArrayList();
				hshQuery.put("strQueryId","del_cgssd_asses");
				arrValues.add(strAppno);
				arrValues.add(Strsno);
				hshQuery.put("arrValues",arrValues);
				hshQueryVal.put("1",hshQuery);
				hshQueryVal.put("size","1");
			}
			
			EJBInvoker.executeStateLess("dataaccess",hshQueryVal,"updateData");
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
			}
			catch(Exception cf)
			{
				throw new EJBException("Error closing the connection "+cf.getMessage());
			}
			
		}
		
	
		
	}
	
	public void updDocborrowerdetails(String strappno, String sno,String docid,String  borrowername,String cbsid,String strStatus,String strapptype) 
	{

		  ArrayList arrValues=new ArrayList();
		  HashMap hshQueryValue = new HashMap();
			HashMap hshQueryval = new HashMap();
			String Sno1 ="",strbordetail="";
			ResultSet rs1=null;
			ResultSet rs2=null;

			

		try
		{
			strbordetail="N";
			rs2=DBUtils.executeLAPSQuery("sel_docbordetails^"+strappno+"^"+sno+"^"+cbsid+"^"+docid+"^"+strapptype);
			if(rs2.next()){
				strbordetail="Y";
			}
			if(!strbordetail.equalsIgnoreCase("Y")){
			rs1=DBUtils.executeLAPSQuery("sel_docdetailmax^"+strappno+"^"+docid);
			if(rs1.next())
			{
				Sno1=rs1.getString("DOC_SNO");
			}
			if(strStatus.equalsIgnoreCase("pa")){
		    hshQueryval = new HashMap(); 
			arrValues = new ArrayList();
			hshQueryval.put("strQueryId", "ins_docdetails");
			arrValues.add(Sno1);
			arrValues.add(strappno);
			arrValues.add(sno);
			arrValues.add(docid);
			arrValues.add(borrowername);
			arrValues.add(cbsid);
			arrValues.add(strapptype);
			hshQueryval.put("arrValues", arrValues);
			hshQueryValue.put("1",hshQueryval);
			hshQueryValue.put("size","1");
			EJBInvoker.executeStateLess("dataaccess",hshQueryValue,"updateData");
			}
			}
			}
		catch(Exception ce)
		{
 			throw new EJBException("Error in updDocborrowerdetails login  "+ce.toString());
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
	
	
	
}
 

//public HashMap PrintData(HashMap hshRequestValues) 
//{	
//	ResultSet rs = null;
//	ResultSet rs_sub = null;
//	int i = 0,newid=0;
//	String []label = new String[4];
//	ResultSet rs1 = null;
//	ResultSet rs2 = null;
//	ResultSet rs3 = null;
//	ResultSet rs4 = null;
//	ResultSet rs5 = null;
//	ResultSet rs6 = null;
//	ResultSet rs7 = null;
//	ArrayList vecData = new ArrayList();
//	ArrayList vecVal=new ArrayList();
//	ArrayList vecRec=new ArrayList();
//	HashMap hshValues=new HashMap();
//	String strQuery="",strValue="",type = "",cattype="";
//	java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
//	jtn.setMaximumFractionDigits(2);
//	jtn.setMinimumFractionDigits(2);
//	jtn.setGroupingUsed(false);
//	try
//	{	
//		cattype=correctNull((String)hshRequestValues.get("hidCategoryType"));
//		strValue=correctNull((String)hshRequestValues.get("appno"));
//		String comapp_id="";
//		comapp_id=correctNull((String)hshRequestValues.get("comappid"));
//		hshValues = new HashMap();
//		strQuery = SQLParser.getSqlQuery("compropform1^"+strValue);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//		String val="",strSpacing="";
//		String companyiddesc = "";	 
//		
//		while(rs.next())
//		{  
//			hshValues.put("companyname",correctNull(rs.getString("comapp_companyname")));
//			hshValues.put("regoffaddress",correctNull(rs.getString("regoffaddress")));
//			hshValues.put("companycity",correctNull(rs.getString("comapp_regcity")));
//			hshValues.put("companystate",correctNull(rs.getString("comapp_regstate")));
//			hshValues.put("companypin",correctNull(rs.getString("comapp_regpin")));
//			hshValues.put("companyfax",correctNull(rs.getString("comapp_regfax")));
//			hshValues.put("companyphone",correctNull(rs.getString("comapp_regphone")));
//			hshValues.put("corpoffaddress",correctNull(rs.getString("corpoffaddress")));
//			hshValues.put("regoffcity",correctNull(rs.getString("comapp_crptcity")));
//			hshValues.put("regoffstate",correctNull(rs.getString("comapp_crptstate")));
//			hshValues.put("regoffpin",correctNull(rs.getString("comapp_crptpin")));
//			hshValues.put("regoffphone",correctNull(rs.getString("comapp_crptphone")));
//			hshValues.put("factoffaddress",correctNull(rs.getString("factoffaddress")));
//			hshValues.put("factoffcity",correctNull(rs.getString("comapp_factcity")));
//			hshValues.put("factoffstate",correctNull(rs.getString("comapp_factstate")));
//			hshValues.put("factoffpin",correctNull(rs.getString("comapp_factpin")));
//			hshValues.put("factoffphone",correctNull(rs.getString("comapp_factphone")));
//			hshValues.put("dateofincorp",correctNull(rs.getString("comapp_yrsinbusiness")));
//			hshValues.put("constitution",correctNull(rs.getString("comapp_ownership")));
//			hshValues.put("group",correctNull(rs.getString("groupcomp")));
//			hshValues.put("activitynature",correctNull(rs.getString("comapp_businessnature")));
//			hshValues.put("dealings",correctNull(rs.getString("comapp_bankdealing")));
//			companyiddesc = correctNull(rs.getString("comapp_companyid"));
//			StringTokenizer st = new StringTokenizer(companyiddesc,"-");
//			companyiddesc = st.nextToken();
//			companyiddesc = st.nextToken();
//			
//				hshValues.put("companyiddesc",companyiddesc);
//			}
//		strQuery = SQLParser.getSqlQuery("ratingdata^<^"+strValue);
//		if(rs != null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//		while(rs.next())
//		{  				
//			hshValues.put("lastrating",Helper.correctDouble(rs.getString("credit_rating")));
//			hshValues.put("lastratingtermfin",Helper.correctDouble(rs.getString("credit_rating_term_finance")));
//		}
//		strQuery = SQLParser.getSqlQuery("ratingdata^=^"+strValue);
//		if(rs != null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//		while(rs.next())
//		{
//			hshValues.put("currating",Helper.correctDouble(rs.getString("credit_rating")));
//			hshValues.put("termrating",Helper.correctNull((String)rs.getString("credit_rating_term_finance")));
//		}
//		if(rs!=null)
//			rs.close();
//		
//		strQuery = SQLParser.getSqlQuery("selexternalrating^"+strValue);				
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extagency"))
//			{
//				hshValues.put("extagency",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extlastrate"))
//			{
//				hshValues.put("extlastrate",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extcurrate"))
//			{
//				hshValues.put("extcurrate",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttrating1"))
//			{
//				hshValues.put("locallasttrating1",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}					
//			else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttermtrating1"))
//			{
//				hshValues.put("locallasttermtrating1",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttrating2"))
//			{
//				hshValues.put("locallasttrating2",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}					
//			else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttermtrating2"))
//			{
//				hshValues.put("locallasttermtrating2",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if (correctNull(rs.getString(1)).equalsIgnoreCase("prevyear1"))
//			{
//				hshValues.put("prevyear1",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//			else if (correctNull(rs.getString(1)).equalsIgnoreCase("prevyear2"))
//			{
//				hshValues.put("prevyear2",Helper.CLOBToString(rs.getClob("com_propcomdesc")));
//			}
//		}
//			
////			to get factor details
//			if(comapp_id!="")
//			{
//			strQuery=SQLParser.getSqlQuery("selallfactorydetails^"+comapp_id);
//		
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			ArrayList vecCol=new ArrayList();
//			ArrayList vecRow=new ArrayList();
//			while(rs.next())
//			{
//				vecCol = new ArrayList();
//				vecCol.add(correctNull((String)rs.getString("comapp_id")));
//				vecCol.add(correctNull((String)rs.getString("comapp_sno")));
//				vecCol.add(correctNull((String)rs.getString("comapp_detailtype")));
//				vecCol.add(correctNull((String)rs.getString("comapp_name")));
//				vecCol.add(correctNull((String)rs.getString("comapp_add")));
//				vecCol.add(correctNull((String)rs.getString("comapp_city")));
//				vecCol.add(correctNull((String)rs.getString("comapp_state")));
//				vecCol.add(correctNull((String)rs.getString("comapp_pincode")));
//				vecCol.add(correctNull((String)rs.getString("comapp_phoneno")));
//				vecCol.add(correctNull((String)rs.getString("comapp_fax")));
//				vecRow.add(vecCol);
//						}			
//			   hshValues.put("vecRow",vecRow);
//			}
//
//			strQuery = SQLParser.getSqlQuery("ratingdata^=^"+strValue);
//		
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{  				
//				hshValues.put("currating",Helper.correctDouble(rs.getString("credit_rating")));
//				hshValues.put("termrating",Helper.correctNull((String)rs.getString("credit_rating_term_finance")));
//			}
//
//			strQuery = SQLParser.getSqlQuery("compropform8^"+strValue);
//		
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//					 
//				hshValues.put("appno",correctNull(rs.getString(1)));
//				hshValues.put("asset",correctNull(rs.getString(2)));
//				hshValues.put("npa",correctNull(rs.getString(3)));
//				hshValues.put("ason",correctNull(rs.getString(4)));
//									
//		}
//		// external credit
//		strQuery = SQLParser.getSqlQuery("selexternalrating^"+strValue);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//				if(correctNull(rs.getString(1)).trim().equalsIgnoreCase("extagency"))
//				{
//					hshValues.put("extagency",correctNull(rs.getString(2).trim()));
//				}
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("extlastrate"))
//				{
//					
//					hshValues.put("extlastrate",correctNull(rs.getString(2).trim()));
//				}
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("extcurrate"))
//				{
//					
//					hshValues.put("extcurrate",correctNull(rs.getString(2).trim()));
//				}
//				
//				/* previous 2 years values are added  */
//				
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttrating1"))
//				{
//					
//					hshValues.put("locallasttrating1",correctNull(rs.getString(2).trim()));
//				}					
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttermtrating1"))
//				{
//					
//					hshValues.put("locallasttermtrating1",correctNull(rs.getString(2).trim()));
//				}
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttrating2"))
//				{
//					
//					hshValues.put("locallasttrating2",correctNull(rs.getString(2).trim()));
//				}					
//				else if (correctNull(rs.getString(1)).trim().equalsIgnoreCase("locallasttermtrating2"))
//				{
//					
//					hshValues.put("locallasttermtrating2",correctNull(rs.getString(2).trim()));
//				}
//				else if (correctNull(rs.getString(1)).equalsIgnoreCase("prevyear1"))
//				{
//					
//					hshValues.put("prevyear1",correctNull(rs.getString(2)));
//				}
//				else if (correctNull(rs.getString(1)).equalsIgnoreCase("prevyear2"))
//				{
//					
//					hshValues.put("prevyear2",correctNull(rs.getString(2)));
//				}
//				
//				/* end  */
//		}
//
//			
//
//		// end credit rating
//
//			strQuery = SQLParser.getSqlQuery("compropform2^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString("borr_name")));
//					vecVal.add(vecRec);
//			}
//			hshValues.put("bowrower",vecVal);
//			vecVal = new ArrayList();
//			ArrayList	vecRec1 = new ArrayList();
//			ArrayList	vecRec2 = new ArrayList();
//			ArrayList	vecRec3 = new ArrayList();
//			ArrayList	vecVal1 = new ArrayList();
//			ArrayList	vecVal2 = new ArrayList();
//			ArrayList	vecVal3 = new ArrayList();
//	
//	if(cattype.equals("CORPORATE"))
//	{
//			
//				strQuery = SQLParser.getSqlQuery("compropform3z^"+strValue);
//				if(rs!=null)
//					rs.close();
//				rs=DBUtils.executeQuery(strQuery);
//				
//				while(rs.next())
//				{
//
//					String strType=(String)correctNull(rs.getString("com_compdttype"));
//					StringTokenizer strTempTokenizer =	new  StringTokenizer(strType,"@");			
//				    while (strTempTokenizer.hasMoreTokens())			
//					{	
//						String strTemp=(String)strTempTokenizer.nextToken();
//						if (strTemp.equalsIgnoreCase("D") || strTemp.equalsIgnoreCase("PD")  || strTemp.equalsIgnoreCase("ND") || strTemp.equalsIgnoreCase("WD") || strTemp.equalsIgnoreCase("MD"))
//						{
//							vecRec = new ArrayList();
//							String strFind="";
//							vecRec.add(correctNull(rs.getString("com_compdtname")));
//							if (strTemp.equalsIgnoreCase("D"))
//							{
//								strFind="Director";
//							}
//							if (strTemp.equalsIgnoreCase("PD"))
//							{
//								strFind="PartTime Director";
//							}
//							if (strTemp.equalsIgnoreCase("ND"))
//							{
//								strFind="Nominee Director";
//							}
//							if (strTemp.equalsIgnoreCase("MD"))
//							{
//								strFind="Managing Director";
//							}
//							if (strTemp.equalsIgnoreCase("WD"))
//							{
//								strFind="Whole Time Director";
//							}
//							vecRec.add(correctNull(rs.getString("com_comdtpershare")));
//
//							vecRec.add(correctNull(rs.getString("com_compdtshareheld")));
//							vecRec.add(correctNull(rs.getString("com_compdtnetworth")));
//							String strDatex=correctNull(rs.getString("com_compdate"));
//							if (strDatex.trim().equals("01/01/1900"))
//							{
//								vecRec.add(strSpacing);
//							}
//							else
//							{
//										vecRec.add(correctNull(rs.getString("com_compdate")));
//							}
//							vecRec.add(strFind);
//							vecVal.add(vecRec);
//						}
//						if (strTemp.equalsIgnoreCase("G") )
//						{
//							vecRec1 = new ArrayList();
//							String strFind1="";
//							vecRec1.add(correctNull(rs.getString("com_compdtname")));
//							vecRec1.add(correctNull(rs.getString("com_comdtpershare")));
//
//							vecRec1.add(correctNull(rs.getString("com_compdtshareheld")));
//							vecRec1.add(correctNull(rs.getString("com_compdtnetworth")));
//							String strDatex=correctNull(rs.getString("com_compdate"));
//							if (strDatex.trim().equals("01/01/1900"))
//							{
//								vecRec1.add(strSpacing);
//							}
//							else
//							{
//										vecRec1.add(correctNull(rs.getString("com_compdate")));
//							}
//							if (strTemp.equalsIgnoreCase("G"))
//							{
//								strFind1="Guarantor";
//							}
//								vecRec1.add(strFind1);
//							vecVal1.add(vecRec1);
//						}
//						if (strTemp.equalsIgnoreCase("O") )
//						{
//							vecRec2 = new ArrayList();
//							vecRec2.add(correctNull(rs.getString("com_compdtname")));
//							vecRec2.add(correctNull(rs.getString("com_comdtpershare")));
//
//							vecRec2.add(correctNull(rs.getString("com_compdtshareheld")));
//							vecRec2.add(correctNull(rs.getString("com_compdtnetworth")));
//							String strDatex=correctNull(rs.getString("com_compdate"));
//							if (strDatex.trim().equals("01/01/1900"))
//							{
//								vecRec2.add(strSpacing);
//							}
//							else
//							{
//										vecRec2.add(correctNull(rs.getString("com_compdate")));
//							}
//							String strFind2="";
//							if (strTemp.equalsIgnoreCase("O"))
//							{
//								strFind2="Share Holder";
//							}
//								vecRec2.add(strFind2);
//
//							vecVal2.add(vecRec2);
//						}
//						if (strTemp.equalsIgnoreCase("P") || strTemp.equalsIgnoreCase("C") || strTemp.equalsIgnoreCase("SP") || strTemp.equalsIgnoreCase("PT"))
//						{
//							vecRec3 = new ArrayList();
//							vecRec3.add(correctNull(rs.getString("com_compdtname")));
//							vecRec3.add(correctNull(rs.getString("com_comdtpershare")));
//
//							vecRec3.add(correctNull(rs.getString("com_compdtshareheld")));
//							vecRec3.add(correctNull(rs.getString("com_compdtnetworth")));
//							String strDatex=correctNull(rs.getString("com_compdate"));
//							if (strDatex.trim().equals("01/01/1900"))
//							{
//								vecRec3.add(strSpacing);
//							}
//							else
//							{
//										vecRec3.add(correctNull(rs.getString("com_compdate")));
//							}
//							String strFind3="";
//							if (strTemp.equalsIgnoreCase("P"))
//							{
//								strFind3="Promoters / Founders";
//							}
//							else if (strTemp.equalsIgnoreCase("C"))
//							{
//								strFind3="Chairman";
//							}
//							if (strTemp.equalsIgnoreCase("SP"))
//							{
//								strFind3="Sole Proprietor";
//							}
//							if (strTemp.equalsIgnoreCase("PT"))
//							{
//								strFind3="Partner";
//							}
//								vecRec3.add(strFind3);
//
//							vecVal3.add(vecRec3);
//						}
//
//					}
//					hshValues.put("promoterdetails",vecVal3);
//					hshValues.put("shareholderdetails",vecVal2);
//											
//					hshValues.put("directordetails",vecVal);
//					hshValues.put("guarantordetails",vecVal1);
//
//				}
//	}
//			
//			vecVal = new ArrayList();
////			if(cattype.equals("SSI"))
////			{					
////				strQuery = SQLParser.getSqlQuery("selnames^"+strValue);
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("ssi_prinfname"))+" "+
////								correctNull(rs.getString("ssi_prinmname"))+" "+correctNull(rs.getString("ssi_prinlname")));
////						
////						String source_pro="";
////						                            
////						if(correctNull(rs.getString("ssi_printype")).trim().equals("PR"))
////						{
////							source_pro = "Proprietor";
////						}
////						else if(correctNull(rs.getString("ssi_printype")).trim().equals("PT"))
////						{
////							source_pro = "Partners";
////						}
////						else if(correctNull(rs.getString("ssi_printype")).trim().equals("MP"))
////						{
////							source_pro = "Managing Partner";
////						}
////						else if(correctNull(rs.getString("ssi_printype")).trim().equals("PM"))
////						{
////							source_pro = "Promoters";
////						}
////						else if(correctNull(rs.getString("ssi_printype")).trim().equals("D"))
////						{
////							source_pro = "Director";
////						}
////						else if(correctNull(rs.getString("ssi_printype")).trim().equals("MD"))
////						{
////							source_pro = "Managing Director";
////						}
////						vecRec.add(source_pro);
////						vecVal.add(vecRec);
////				}
////			
////
////			hshValues.put("promoterdetails",vecVal);
////			vecVal = new ArrayList();
////				
////				strQuery = SQLParser.getSqlQuery("selssiguarantorprop^"+strValue);
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("ssi_guarantor_name")));
////						vecRec.add(correctNull(rs.getString("ssi_guarantor_occupation")));
////
////						vecVal.add(vecRec);
////				}
////				hshValues.put("guarantordetails",vecVal);
////				
////				strQuery = SQLParser.getSqlQuery("ssibankdetail^"+strValue);
////				if(rs != null)
////					rs.close();
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("bank_name")));
////						vecRec.add(correctNull(rs.getString("bank_yrsacchold")));
////						vecRec.add(correctNull(rs.getString("bank_accntno")));
////						vecRec.add(correctNull(rs.getString("bank_balance")));
////
////						vecVal.add(vecRec);
////				}
////			
////				hshValues.put("ssibankdetail",vecVal);
////				vecVal = new ArrayList();
////			
////				strQuery = SQLParser.getSqlQuery("ssipolicydetail^"+strValue);
////				if(rs != null)
////					rs.close();
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("insu_policyno")));
////						vecRec.add(correctNull(rs.getString("insu_matdate")));
////						vecRec.add(correctNull(rs.getString("insu_prepaid")));
////						vecRec.add(correctNull(rs.getString("insu_surrenderval")));
////						vecRec.add(correctNull(rs.getString("insu_agencyname")));
////						vecRec.add(correctNull(rs.getString("insu_agencyphone")));
////
////
////						vecVal.add(vecRec);
////				}
////				hshValues.put("ssipolicydetail",vecVal);
////				vecVal = new ArrayList();
////				strQuery = SQLParser.getSqlQuery("ssistockdetail^"+strValue);
////				if(rs != null)
////					rs.close();
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("stoc_desc")));
////						vecRec.add(correctNull(rs.getString("stoc_shareval")));
////						vecRec.add(correctNull(rs.getString("stoc_noofshares")));
////						vecRec.add(correctNull(rs.getString("tot")));
////						
////						vecVal.add(vecRec);
////				}
////				hshValues.put("ssistockdetail",vecVal);
////				vecVal = new ArrayList();
////				strQuery = SQLParser.getSqlQuery("ssiperdetail^"+strValue);
////				if(rs != null)
////					rs.close();
////				rs=DBUtils.executeQuery(strQuery);
////				while(rs.next())
////				{
////						vecRec = new ArrayList();
////						vecRec.add(correctNull(rs.getString("prop_desc")));
////						vecRec.add(correctNull(rs.getString("prop_purchaseval")));
////						vecRec.add(correctNull(rs.getString("prop_marketval")));
////						vecRec.add(correctNull(rs.getString("prop_valuation_date")));
////						vecVal.add(vecRec);
////				}
////				hshValues.put("ssiperdetail",vecVal);
////				vecVal = new ArrayList();
////			}
//
//			vecVal = new ArrayList();
//
//			
//			type = "M";
//			strQuery = SQLParser.getSqlQuery("compropform4^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString("com_actdesc")));
//					
//
//					vecVal.add(vecRec);
//			}
//
//			hshValues.put("manfactureactivity",vecVal);
//			vecVal = new ArrayList();
//
//			
//			type = "T";
//			strQuery = SQLParser.getSqlQuery("compropform4^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString("com_actdesc")));
//					
//
//					vecVal.add(vecRec);
//			}
//
//			hshValues.put("tradingactivity",vecVal);
//			vecVal = new ArrayList();
//			
//			
//			strQuery = SQLParser.getSqlQuery("compropform5^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs=DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString("com_grpcompname")));
//					vecRec.add(correctNull(rs.getString("com_grpcompactivity")));
//					
//
//					vecVal.add(vecRec);
//			}
//
//			hshValues.put("companyactivity",vecVal);
//			vecVal = new ArrayList();
//
//
//			strQuery = SQLParser.getSqlQuery("compropform11^"+strValue);
//			
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("companydesc",Helper.CLOBToString(rs.getClob("com_propcomdesc")));	
//			
//			}
//			strQuery = SQLParser.getSqlQuery("comprom2^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("promcomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			strQuery = SQLParser.getSqlQuery("comactivity2^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("activcomment",Helper.CLOBToString(rs.getClob("com_propcomdesc")));	
//			}
//
//			strQuery = SQLParser.getSqlQuery("compropfacility9^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("faccomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
////Opertational details
//			
//			type="opercomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("opercomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			
//			type="operdelay";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("delay",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			type="opernoncompliance";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("opernoncompliance",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			type="operdocdet";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("operdocdet",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			
//			
//			strQuery = SQLParser.getSqlQuery("comoperationaldata1^"+strValue);
//		
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			
//			if (correctNull(rs.getString(1)).equals("01/01/1900"))
//			{
//				hshValues.put("yieldfrom",strSpacing);
//			}
//			else
//			{
//			hshValues.put("yieldfrom",correctNull(rs.getString(1)));	
//			}
//			if (correctNull(rs.getString(2)).equals("01/01/1900"))
//			{
//				hshValues.put("yieldto",strSpacing);
//			}
//			else
//			{
//			hshValues.put("yieldto",correctNull(rs.getString(2)));	
//			}
//			hshValues.put("yieldvalue",correctNull(rs.getString(3)));	
//			hshValues.put("yieldpercent",correctNull(rs.getString(4)));	
//			hshValues.put("leadbank",correctNull(rs.getString(5)));	
//			hshValues.put("mulbank",correctNull(rs.getString(6)));	
//			hshValues.put("existfb",correctNull(rs.getString(7)));	
//			hshValues.put("existnfb",correctNull(rs.getString(8)));	
//			hshValues.put("propfb",correctNull(rs.getString(9)));	
//			hshValues.put("propnfb",correctNull(rs.getString(10)));
//			
//			if (correctNull(rs.getString(11)).equals("01/01/1900"))
//			{
//				hshValues.put("lastreviewdate",strSpacing);
//			}
//			else
//			{
//			hshValues.put("lastreviewdate",correctNull(rs.getString(11)));	
//			}
//			
//			hshValues.put("lastreviewperiod",correctNull(rs.getString(12)));
//			
//			if (correctNull(rs.getString(11)).equals("01/01/1900"))
//			{
//				hshValues.put("lastreviewdue",strSpacing);
//			}
//			else
//			{
//			hshValues.put("lastreviewdue",correctNull(rs.getString(13)));	
//			}
//			if (correctNull(rs.getString(14)).equals("01/01/1900"))
//			{
//				hshValues.put("yieldfrom2",strSpacing);
//			}
//			else
//			{
//			hshValues.put("yieldfrom2",correctNull(rs.getString(14)));	
//			}
//			if (correctNull(rs.getString(15)).equals("01/01/1900"))
//			{
//				hshValues.put("yieldto2",strSpacing);
//			}
//			else
//			{
//			hshValues.put("yieldto2",correctNull(rs.getString(15)));
//			}
//			hshValues.put("yieldvalue2",correctNull(rs.getString(16)));	
//			hshValues.put("yieldpercent2",correctNull(rs.getString(17)));	
//
//			}
//
////Confirmation of action
//
//			type="confirmcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("confirmcomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			
//			strQuery = SQLParser.getSqlQuery("comconfirmdata^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					vecRec.add(correctNull(rs.getString(3)));
//					vecRec.add(correctNull(rs.getString(4)));
//					vecVal.add(vecRec);
//			}
//		
//			hshValues.put("value1",vecVal);
////auditor observation
//		
//		val= "AuditorObservation";
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs!=null)
//		rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("commentaudit",correctNull(rs.getString(1)));
//				hshValues.put("com_officer",correctNull(rs.getString("com_officer")));
//
//															
//		}
//		/*
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs != null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			String comment=correctNull(rs.getString(1));
//			if (comment.trim().equalsIgnoreCase(""))
//			{
//				 comment=strComment+"<br>"+correctNull(rs.getString(1));
//				 hshValues.put("comment",comment);
//			}
//			else
//			{
//				hshValues.put("comment",comment);
//			}
//		}
//		else
//		{
//			hshValues.put("comment",strComment);
//		}
//		hshValues.put("appno",strValue);
//		hshValues.put("type",type);
//		hshValues.put("com_seltype",correctNull(rs.getString("com_seltype")));
//		hshValues.put("com_officer",correctNull(rs.getString("com_officer")));
//*/
////process details
//
//
//	type="processcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("processcomment",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			
//			strQuery = SQLParser.getSqlQuery("comproccessdata1^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			vecVal = new ArrayList();
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(3)));
//					vecRec.add(correctNull(rs.getString(4)));
//					vecRec.add(correctNull(rs.getString(5)));
//					vecRec.add(correctNull(rs.getString(6)));
//					vecRec.add(correctNull(rs.getString(7)));
//					vecRec.add(correctNull(rs.getString(8)));
//					vecRec.add(correctNull(rs.getString(9)));
//					vecRec.add(correctNull(rs.getString(10)));
//					vecRec.add(correctNull(rs.getString(11)));
//					vecVal.add(vecRec);
//					
//			}
//			hshValues.put("prdmanufacture",vecVal);
//			
//			
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata2^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					
//					vecVal.add(vecRec);
//			}
//			hshValues.put("prdrawmaterial",vecVal);
//		
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata3^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					
//					vecVal.add(vecRec);
//			}
//			hshValues.put("prdfinished",vecVal);
//			
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata4^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					
//					vecVal.add(vecRec);
//			}
//			hshValues.put("prdsuppliers",vecVal);
//			
//			vecVal = new ArrayList();
//
//			strQuery = SQLParser.getSqlQuery("comproccessdata5^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					
//					vecVal.add(vecRec);
//			}
//			hshValues.put("prdcustomers",vecVal);
//
//
//
////Distribution and marketing
//
//
//
//			type="Distribution setup";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("DistributionSetup",correctNull(rs.getString(1)));	
//			}
//
//			type="Technology used";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("Technology",correctNull(rs.getString(1)));	
//			}
//
//			type="Marketingcomments";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("Marketingcomments",correctNull(rs.getString(1)));	
//			}
//			
//			type="Technologysophistication";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("Technologysophistication",correctNull(rs.getString(1)));	
//			}
//
//			type="GestationPeriod";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("GestationPeriod",correctNull(rs.getString(1)));	
//			}
//
//			type="DistributionNetwork";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("DistributionNetwork",correctNull(rs.getString(1)));	
//			}
//
//			type="MarketingBrandName ";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("MarketingBrandName",correctNull(rs.getString(1)));	
//			}
//
//			type="Marketingstartupcost";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("Marketingstartupcost",correctNull(rs.getString(1)));	
//			}
//
//			vecVal =  new ArrayList();
//			strQuery = SQLParser.getSqlQuery("commarketingdata1^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					vecVal.add(vecRec);
//			}
//			hshValues.put("competitors",vecVal);
//
//
////Management
//			type="Succession plan";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("successplan",correctNull(rs.getString(1)));	
//			}
//
//			type="Strategic initiatives";
//
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("strategic",correctNull(rs.getString(1)));	
//			}
//
//			type="Initiative of the Mgmt on QC";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("iso",correctNull(rs.getString(1)));	
//			}
//			
//			type="Reporting Control";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("reptctrl",correctNull(rs.getString(1)));	
//			}
//
//			type="Long Term Supply";
//
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("termsupply",correctNull(rs.getString(1)));	
//			}
//
//			type="Experience";
//			strQuery = SQLParser.getSqlQuery("comcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("experience",correctNull(rs.getString(1)));	
//			}
//
//			type="Mgmt Skills";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("MgmtSkills",correctNull(rs.getString(1)));	
//			}
//
//			type="RBI Defaulters";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("RBIDefaulters",correctNull(rs.getString(1)));	
//			}
//
//			type="ECGC SAL";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("ECGCSAL",correctNull(rs.getString(1)));	
//			}
//
//			type="magmtdivwithcon";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("magmtdivwithcon",correctNull(rs.getString(1)));	
//			}
//
//			
//
//			type="magmtdivwithoutcon";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("magmtdivwithoutcon",correctNull(rs.getString(1)));	
//			}
//
//			type="magmtnodiv";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("magmtnodiv",correctNull(rs.getString(1)));	
//			}
//			
//			type="magmtcomment";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("magmtcomment",correctNull(rs.getString(1)));	
//			}
//			
//			vecVal =  new ArrayList();
//			/*strQuery = SQLParser.getSqlQuery("comorgsel^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//						vecRec.add(correctNull(rs.getString(3)));
//						vecRec.add(correctNull(rs.getString(4)));
//						vecRec.add(correctNull(rs.getString(5)));
//						vecRec.add(correctNull(rs.getString(6)));
//						vecRec.add(correctNull(rs.getString(7)));
//					vecVal.add(vecRec);
//			}
//			hshValues.put("expertise",vecVal);*/
//			strQuery = SQLParser.getSqlQuery("commgmtdata1^"+strValue);
//			if(rs != null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				vecRec = new ArrayList();
//				vecRec.add(correctNull(rs.getString(1)));
//				vecRec.add(correctNull(rs.getString(2)));
//				vecRec.add(correctNull(rs.getString(3)));
//				vecVal.add(vecRec);
//			}
//			hshValues.put("expertise",vecVal);
//
//
////banking
//		HashMap hshformula=new HashMap();
//		String appno="";
//		String comappid="";
//		appno=correctNull((String)hshRequestValues.get("appno"));
//		comappid=correctNull((String)hshRequestValues.get("comapp_id"));
//		hshformula.put("appno",appno);
//		hshformula.put("comapp_id",comappid);
//		HashMap hshValues_5 = (HashMap)EJBInvoker.executeStateLess("bankapp",hshformula,"getData");
//		ArrayList vecVal_6=(ArrayList)hshValues_5.get("vecData");
//		hshValues.put("vecVal_6",vecVal_6);
//
//
////banking
//
////term banking
//
//HashMap hshValues_6 = (HashMap)EJBInvoker.executeStateLess("bankappfi",hshformula,"getData");
//ArrayList vecVal_7=(ArrayList)hshValues_6.get("vecData");
//
//hshValues.put("vecVal_7",vecVal_7);
//
//
//			
////Over Due
//
//	val = "OverDue";
//	strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//	if(rs!=null)
//		rs.close();	
//	rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("commentoverdue",correctNull(rs.getString(1)));
//											
//		}		
//
//
////for security and charges
//
//	ArrayList vecTotal = new ArrayList();
//	String strFacheadid="";
//	String strFacid="";
//	String strFacname="",securemode="",charge="";
//		strQuery = SQLParser.getSqlQuery("selBorrowerFacilities^"+appno);
//		
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{  
//				
//				strFacheadid=correctNull(rs.getString(1));
//				strFacid=correctNull(rs.getString(3));
//				strFacname=correctNull(rs.getString(2)+" - " + rs.getString(4));
//				
//				
//				strQuery = SQLParser.getSqlQuery("propfacsecselection^"+appno+"^"+strFacheadid+"^"+strFacid);
//			
//				if(rs1!=null)
//					rs1.close();
//				rs1 = DBUtils.executeQuery(strQuery);
//				while(rs1.next())
//				{
//					vecData = new ArrayList();
//					strFacname=correctNull(rs.getString(2)+" - " + rs.getString(4));
//					vecData.add(strFacname);
//					String strVal=correctNull(rs1.getString(1));
//
//					securemode=correctNull(rs1.getString(6));
//				
//					if (securemode.trim().equals("S"))
//					{
//						securemode="Secured";
//						vecData.add(securemode);
//					}
//					else if (securemode.trim().equals("U"))
//					{
//						securemode="Un Secured";
//						vecData.add(securemode);
//					}
//					else if (securemode.trim().equals("sel"))
//					{
//						securemode=" ";
//						vecData.add(securemode);
//					}
//					charge=correctNull(rs1.getString(5));
//				
//					if (charge.trim().equals("1"))
//					{
//						charge="Exclusive First Charge";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("2"))
//					{
//						charge="Second Charge";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("3"))
//					{
//						charge="First Pari-pasu Charge";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("4"))
//					{
//						charge="Others";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("5"))
//					{
//						charge="Second Pari-pasu Charge";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("6"))
//					{
//						charge="Second Charge on Current Assets";
//						vecData.add(charge);
//					}
//					else if (charge.trim().equals("s"))
//					{
//						charge=" ";
//						vecData.add(charge);
//					}
//					
//					strQuery = SQLParser.getSqlQuery("propfacmastersel^"+strVal);
//										
//					if(rs2!=null)
//						rs2.close();
//					rs2 = DBUtils.executeQuery(strQuery);
//				
//					while(rs2.next())
//					{
//						vecVal=new ArrayList();
//						vecVal.add(correctNull(rs2.getString(1)));
//						vecVal.add(correctNull(rs2.getString(2)));
//						vecVal.add(correctNull(rs2.getString(3)));
//						vecVal.add(correctNull(rs2.getString(4)));
//						if (correctNull(rs2.getString(5)).equals("01/01/1900"))
//						{
//							vecVal.add("");
//						}
//						else
//						{
//								vecVal.add(correctNull(rs2.getString(5)));
//						}
//						vecVal.add(correctNull(rs2.getString(6)));
//						vecVal.add(correctNull(rs2.getString(7)));
//						
//						vecData.add(vecVal);
//					}
//					vecTotal.add(vecData);
//				}
//
//				hshValues.put("vecTotal",vecTotal);
//			}
//
//		val = "WorkingCapitalAssessment";
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment1",correctNull(rs.getString(1)));
//											
//		}	
//		
//		
//		val = "LoanRequirement";
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment3",correctNull(rs.getString(1)));
//											
//		}	
//
//		val = "Assessment";
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment2",correctNull(rs.getString(1)));
//											
//		}	
//		
//		
//			val = "LimitRequirement";
//			strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment4",correctNull(rs.getString(1)));
//											
//		}
//		
//		
//			val = "ConductOfAccount";
//			strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment5",correctNull(rs.getString(1)));
//											
//		}
//		val="InventoryHoldings";
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+val);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//				hshValues.put("comment6",correctNull(rs.getString(1)));
//											
//		}
//		
//			type="LoanBusinessTurnOver";
//			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			
//				
//				label[newid] = correctNull(rs.getString(1));
//				hshValues.put("label1"+newid,correctNull(rs.getString(1)));
//				newid = newid + 1;
//															
//		}
//	
//		for (int p=0;p<newid ;p++ )
//		{
//			i = 0;
//		
//			strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
//			if(rs!=null)
//			rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//			while(rs.next())
//			{  
//			
//			
//				i = i + 1;
//				if (p == 0)
//				{
//					hshValues.put("colval11"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 1)
//				{
//					hshValues.put("colval12"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 2)
//				{
//					hshValues.put("colval13"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 3)
//				{
//					hshValues.put("colval14"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 4)
//				{
//					hshValues.put("colval15"+i,correctNull(rs.getString(1)));
//				}
//				
//			
//				
//				
//															
//			}
//
//		}
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("type11",correctNull(rs.getString(1)));
//															
//		}
//		
//			type="BillTurnOver";
//			newid= 0 ;
//			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			
//				
//				label[newid] = correctNull(rs.getString(1));
//				hshValues.put("label2"+newid,correctNull(rs.getString(1)));
//				newid = newid + 1;
//															
//		}
//	
//		for (int p=0;p<newid ;p++ )
//		{
//			i = 0;
//		
//			strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//			while(rs.next())
//			{  
//			
//			
//				i = i + 1;
//				if (p == 0)
//				{
//					hshValues.put("colval21"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 1)
//				{
//					hshValues.put("colval22"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 2)
//				{
//					hshValues.put("colval23"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 3)
//				{
//					hshValues.put("colval24"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 4)
//				{
//					hshValues.put("colval25"+i,correctNull(rs.getString(1)));
//				}
//				
//															
//			}
//
//		}
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("type22",correctNull(rs.getString(1)));
//															
//		}
//		
//		
//		
//			type="TermLoansDeferred ";
//			newid= 0 ;
//			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			
//				
//				label[newid] = correctNull(rs.getString(1));
//				hshValues.put("label3"+newid,correctNull(rs.getString(1)));
//				newid = newid + 1;
//															
//		}
//	
//		for (int p=0;p<newid ;p++ )
//		{
//			i = 0;
//	
//			strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//			while(rs.next())
//			{  
//			
//			
//				i = i + 1;
//				if (p == 0)
//				{
//					hshValues.put("colval31"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 1)
//				{
//					hshValues.put("colval32"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 2)
//				{
//					hshValues.put("colval33"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 3)
//				{
//					hshValues.put("colval34"+i,correctNull(rs.getString(1)));
//				}
//				
//															
//			}
//
//		}
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("type33",correctNull(rs.getString(1)));
//															
//		}
//			type="TermLoanLetterOfCredit";
//			newid= 0 ;
//			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			
//				
//				label[newid] = correctNull(rs.getString(1));
//				hshValues.put("label4"+newid,correctNull(rs.getString(1)));
//				newid = newid + 1;
//															
//		}
//
//		for (int p=0;p<newid ;p++ )
//		{
//			i = 0;
//			
//			strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//			while(rs.next())
//			{  
//			
//			
//				i = i + 1;
//				if (p == 0)
//				{
//					hshValues.put("colval41"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 1)
//				{
//					hshValues.put("colval42"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 2)
//				{
//					hshValues.put("colval43"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 3)
//				{
//					hshValues.put("colval44"+i,correctNull(rs.getString(1)));
//				}
//				
//															
//			}
//
//		}
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("type44",correctNull(rs.getString(1)));
//															
//		}
//					
//			type="TermLoanGurantees";
//			newid= 0 ;
//			strQuery = SQLParser.getSqlQuery("combusinesssel^"+strValue+"^"+type);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//		while(rs.next())
//		{  
//			
//				
//				label[newid] = correctNull(rs.getString(1));
//				hshValues.put("label5"+newid,correctNull(rs.getString(1)));
//				newid = newid + 1;
//															
//		}
//		
//		for (int p=0;p<newid ;p++ )
//		{
//			i = 0;
//			
//			strQuery = SQLParser.getSqlQuery("combusinesssel2^"+strValue+"^"+type+"^"+label[p]);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			 
//			while(rs.next())
//			{  
//			
//				i = i + 1;
//				if (p == 0)
//				{
//					hshValues.put("colval51"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 1)
//				{
//					hshValues.put("colval52"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 2)
//				{
//					hshValues.put("colval53"+i,correctNull(rs.getString(1)));
//				}
//				else if (p == 3)
//				{
//					hshValues.put("colval54"+i,correctNull(rs.getString(1)));
//				}
//				
//															
//			}
//
//		}
//		strQuery = SQLParser.getSqlQuery("comworkasssel^"+strValue+"^"+type);
//		if(rs!=null)
//			rs.close();
//		rs = DBUtils.executeQuery(strQuery);
//			 
//		if(rs.next())
//		{  
//			
//				hshValues.put("type55",correctNull(rs.getString(1)));
//															
//		}
//		
//
//		type="LowYieldReason";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("txt_lowyield",correctNull(rs.getString("com_propcomdesc")));	
//			}
//
//			type="DepositRelationship";
//			strQuery = SQLParser.getSqlQuery("compropcomman^"+type+"^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//			hshValues.put("txt_deprel",correctNull(rs.getString("com_propcomdesc")));	
//			}
//			vecVal = new ArrayList();
//			strQuery = SQLParser.getSqlQuery("selpropyield^"+strValue);
//			if(rs!=null)
//				rs.close();
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//					vecRec = new ArrayList();
//					vecRec.add(correctNull(rs.getString(1)));
//					vecRec.add(correctNull(rs.getString(2)));
//					vecRec.add(correctNull(rs.getString(3)));
//					vecRec.add(correctNull(rs.getString(4)));
//					vecRec.add(correctNull(rs.getString(5)));
//					vecRec.add(correctNull(rs.getString(6)));
//					vecVal.add(vecRec);
//			}
//			hshValues.put("vecValk",vecVal);
//	
//		
//		// For TERMS by balaji for Terms and Condition
//
//	ArrayList vecTerms = new ArrayList();
//	ArrayList vecNFTerms = new ArrayList();
//	ArrayList vecTmp = new ArrayList();
//	ArrayList vecGen = new ArrayList();
//
//	//here we call the printTermAndCondition which return the facility Limit and sub Limit value  
//	hshRequestValues.put("factyp","F");
//	HashMap hshtbl = printTermAndCondition(hshRequestValues);
//	vecTerms = (ArrayList)hshtbl.get("vecTerms");
//	
//	hshRequestValues.put("factyp","NF");
//	HashMap hshtbnfl = printTermAndCondition(hshRequestValues);
//	vecNFTerms = (ArrayList)hshtbnfl.get("vecTerms");
//
//		hshValues.put("vecTerms",vecTerms);	
//		hshValues.put("vecNFTerms",vecNFTerms);	
//
//		if(rs!=null)
//			rs.close();
//		vecTmp = new ArrayList();
//		
//		String strDelTermId="",finalDelTermId="";
//		String TermDesc="";
//		int bool=0;
//
//		strQuery = SQLParser.getSqlQuery("SelMasTermsDeleted^"+"0"+"^"+"0"+"^"+appno);
//		
//		rs = DBUtils.executeQuery(strQuery);
//		while (rs.next())
//		{  
//				
//				strDelTermId+=correctNull((String)rs.getString(1))+",";
//				bool=1;
//			
//		}
//		
//		if(bool==1)
//		{
//			int index=strDelTermId.lastIndexOf(",");				
//			finalDelTermId=strDelTermId.substring(0,index);
//			TermDesc= "fac_sno not in ("+ finalDelTermId +")";
//
//
//					log.info("strDelTermId" + strDelTermId);
//					log.info("finalDelTermId" + finalDelTermId);
//					log.info("TermDesc" + TermDesc);
//
//
//			strQuery = SQLParser.getSqlQuery("SelMasterTerms^"+"0"+"^"+"0"+"^"+"G"+"^"+TermDesc);
//			
//			rs = DBUtils.executeQuery(strQuery);
//			while (rs.next())
//			{  
//			
//				vecVal=new ArrayList();
//				vecVal.add(correctNull(rs.getString(1)));
//				vecTmp.add(vecVal);
//				
//			}
//		}
//		else if(bool==0)
//		{
//	
//		strQuery = SQLParser.getSqlQuery("SelFacilityTerms^"+"0"+"^"+"0"+"^"+"G");					
//		rs = DBUtils.executeQuery(strQuery);
//		while(rs.next())
//		{
//			vecVal=new ArrayList();
//			vecVal.add(correctNull(rs.getString(1)));
//			vecTmp.add(vecVal);
//		}
//		
//		}	
//		vecGen.add(vecTmp);
//					
//		if(rs!=null)
//			rs.close();
//		vecTmp = new ArrayList();
//		strQuery = SQLParser.getSqlQuery("selcomfacilityterms^"+"0"+"^"+"0"+"^"+appno+"^"+"A");
//		
//		
//		rs = DBUtils.executeQuery(strQuery);
//		while(rs.next())
//		{
//			vecVal=new ArrayList();
//			vecVal.add(correctNull(rs.getString(1)));
//			vecTmp.add(vecVal);
//		}
//		vecGen.add(vecTmp);
//		hshValues.put("vecTmpGen",vecGen);	
//		
//		//For TERMS End		
//		String strAppno="",strFacno="",strMoratorium="";
//		String strPeriodicity="",strDisbursement="";
//		double dblPrin=0.00,dblInstalment=0, dblPrincipal=0.00;
// 		ArrayList vecMon = new ArrayList();
//		ArrayList vecYear = new ArrayList();
//		ArrayList arrVal=new ArrayList();
//		String strProposed ="";
//		strAppno = correctNull((String)hshRequestValues.get("appno"));
//		//strFacno = correctNull((String)hshRequestValues.get("selfacility"));
//		strPeriodicity = correctNull((String)hshRequestValues.get("selperiodicity"));//mck
//		ArrayList vecMon2=new ArrayList();
//		ArrayList vecYear2=new ArrayList();
//		
//		if(strFacno.trim().equals(""))
//			{	if(rs != null)
//			{
//				rs.close();
//			}
//			strQuery = SQLParser.getSqlQuery("selectfacsno^"+strAppno);	
//			rs = DBUtils.executeQuery(strQuery);
//			while(rs.next())
//			{
//				arrVal.add(rs.getString(1));
//			
//			}
//			int len=arrVal.size();
//			if(len>0)
//			{
//				for(int j=0;j<len;j++)
//				{
//					 vecMon=new ArrayList();
//					 vecYear=new ArrayList();
//					strFacno=correctNull((String)arrVal.get(j));
//			strQuery = SQLParser.getSqlQuery("select_facilityproposed^"+strAppno+"^"+strFacno);	
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strProposed = correctNull((String)rs.getString("facility_sancamt"));
//				if(strProposed.equalsIgnoreCase(""))
//				{
//					strProposed="0.0";
//				}
//			}
//				
//				if(rs != null)
//				{
//				rs.close();
//			     }
//			strQuery = SQLParser.getSqlQuery("selfacrepaymentvalue^"+strAppno+"^"+strFacno);	
//			//strQuery = SQLParser.getSqlQuery("selfacrepaymentval^"+strAppno+"^"+strFacno);
//			rs = DBUtils.executeQuery(strQuery);
//			if(rs.next())
//			{
//				strMoratorium = correctNull((String)rs.getString(1));
//				dblInstalment =  rs.getDouble(2);
//				strPeriodicity = correctNull((String)rs.getString(3));
//				strDisbursement = correctNull((String)rs.getString(4));
//				
//				if (!strPeriodicity.trim().equalsIgnoreCase("C"))
//				{
//				
//						int intStartMonth = rs.getInt(6);
//						int intStartYear = rs.getInt(7);
//						dblPrincipal = rs.getDouble(8);
//						if(dblInstalment==0)dblInstalment=1;
//						dblPrin = dblPrincipal/dblInstalment;
//						int intInc =0,monCount=0,yearCount=0;
//						if(strPeriodicity.trim().equals("M"))
//						{
//							intInc = 1;
//						}
//						else if(strPeriodicity.trim().equals("Q"))
//						{
//							intInc = 3;
//						}
//						if(strPeriodicity.trim().equals("H"))
//						{
//							intInc = 6;
//						}
//						if(strPeriodicity.trim().equals("Y"))
//						{
//							intInc = 12;
//						}
//						monCount = intStartMonth;
//						yearCount = intStartYear;
//						vecMon.add(strFacno);
//						vecYear.add(strFacno);
//						
//						for(double m=1;m<=dblInstalment;m++)
//						{
//							if(monCount>12)
//							{
//								monCount = monCount - 12;
//								yearCount = yearCount + 1;
//							}
//							String strMonth="";
//							if(monCount==1)
//							{
//								strMonth = "Jan";
//							}
//							else if(monCount==2)
//							{
//								strMonth = "Feb";
//							}
//							else if(monCount==3)
//							{	strMonth = "Mar";
//							}
//							else if(monCount==4)
//							{	strMonth = "Apr";
//							}
//							else if(monCount==5)
//							{	strMonth = "May";
//							}
//							else if(monCount==6)
//							{	strMonth = "Jun";
//							}
//							else if(monCount==7)
//							{	strMonth = "Jul";
//							}
//							else if(monCount==8)
//							{	strMonth = "Aug";
//							}
//							else if(monCount==9)
//							{	strMonth = "Sep";
//							}
//							else if(monCount==10)
//							{	strMonth = "Oct";
//							}
//							else if(monCount==11)
//							{	strMonth = "Nov";
//							}
//							else if(monCount==12)
//							{	strMonth = "Dec";
//							}
//
//							vecMon.add(strMonth);
//							vecYear.add(Integer.toString(yearCount));
//							monCount = monCount + intInc;
//							
//					}
//						vecMon2.add(vecMon);
//						vecYear2.add(vecYear);
//				}
//			}
//		 
//			
//		
//
//				if (strPeriodicity.trim().equalsIgnoreCase("C"))
//				{
//					strQuery = SQLParser.getSqlQuery("comcomman^"+"comfacrepayment"+"^"+strAppno);
//					rs = DBUtils.executeQuery(strQuery);
//					if(rs.next())
//					{
//						hshValues.put("comfacrepayment",correctNull(rs.getString(1)));
//					}
//					strQuery = SQLParser.getSqlQuery("selcomfacrepayment^"+strAppno+"^"+strFacno);
//					rs = DBUtils.executeQuery(strQuery);
//					if(rs.next())
//					{
//						String strdate=correctNull(rs.getString(1));
//			 			if (strdate.trim().equals("01/01/1900"))
//						{
//			 				hshValues.put("endon","");
//						}
//						else
//						{
//							hshValues.put("endon",strdate);
//						}
//					
//					}
//
//					
//					hshValues.put("Disbursement",strDisbursement);
//				}
//			}
//
//			}
//		
//			}
//		hshValues.put("vecmon",vecMon2);
//		hshValues.put("vecyear",vecYear2);
//		hshValues.put("prin",(String)jtn.format(dblPrin));
//		//hshResult.put("facamt",(String)jtn.format(dblFac));
//		hshValues.put("facamt",strProposed);
//		hshValues.put("selfacility",strFacno);
//		hshValues.put("Moratorium",strMoratorium);
//		hshValues.put("Instalment",Helper.formatDoubleValue(dblInstalment));
//		hshValues.put("Periodicity",strPeriodicity);
//		hshValues.put("Disbursement",strDisbursement);
//		hshValues.put("arrVal",arrVal);
//	}
//	catch(Exception ce)
//	{
//		throw new EJBException("Error in getData login  "+ce.toString());
//	}
//	finally
//	{
//		try
//		{	
//			if(rs != null)
//				rs.close();
//			if(rs1 != null)
//				rs1.close();
//			if(rs3!= null)
//				rs3.close();
//			if(rs4 != null)
//				rs4.close();
//			if(rs5 != null)
//				rs5.close();
//			if(rs6 != null)
//				rs6.close();
//			if(rs7 != null)
//				rs7.close();
//			if(rs_sub != null)
//				rs_sub.close();
//			if(rs2 != null)
//				rs2.close();
//			
//		}
//		catch(Exception cf)
//		{
//			throw new EJBException("Error closing the connection "+cf.getMessage());
//		}
//	}
//	
//	return hshValues; 
//}